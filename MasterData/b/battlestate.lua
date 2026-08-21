
require "FSM"
require "GameFlowState"

---@class BattleState : FSMState
local BattleState = FSMState:new("BattleState", GameFlowState.BattleState)

function BattleState:enter()
    LuaLogger.Enabled = false
    UIMgr:switchUIDataGroup(UIGroup.Battle)
    if not (GV.StoryEditorFileName) then
        local BattleVerifyReplayer = require "BattleVerifyReplayer"
        --剧情回顾模式
        local storyArraryId = StoryMgr:getNowStoryArraryId()
        if storyArraryId and Me then
            self:_enterStoryReview(storyArraryId)
            StoryMgr:setNowStoryArraryId(nil)
            return
        end
        --开启寄存Toast模式
        UIMgr:startDepositToast(GE.DepositToastType.Battle)

        local levelId = Me:getNowSelectLevel() or 10110
        local levelConfig = Config.GetPveLevelInfo(levelId)
        if BattleVerifyReplayer.hasPendingReplaySession() then
            self:_initReplayBattle(levelConfig, BattleVerifyReplayer.getPendingReplaySession())
            return
        end
        if levelConfig.type == GE.LevelType.Story then--纯剧情演出入口
            self.battleMgr = BattleCore:getBattleMgr()
            self.battleMgr:setLevelConfig(levelConfig)
            Me:battleStartReq(levelId, {}, Me:getNowEnterMeans(), function (data)
                self:_enterStory(levelConfig, function()
                    local orderReport = {
                        initData = {level = levelId, heroInfoList = {}},
                    }
                    Me:battleResultReq(orderReport, {}, {}, function (resultData)
                        if (resultData.result) then
                            if levelConfig.storyEnd and levelConfig.storyEnd ~= 0 then
                                local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyEnd)
                                if storyConfig.type == 1 then
                                    self.battleMgr:storyStart(levelConfig.storyEnd, function()
                                        local storyMgr = BattleCore:getBattleStoryManager()
                                        storyMgr:clear()
                                        UIMgr:popUI("BattleWinPanel", resultData)
                                    end)
                                elseif storyConfig.type == 2 then
                                    UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[1], callBack = function()
                                        UIMgr:popUI("BattleWinPanel", resultData)
                                    end})
                                end
                            else
                                UIMgr:popUI("BattleWinPanel", resultData, nil, nil, nil, function()
                                    LoadingMgr:SetUIQuickSwitchOver()
                                end)
                            end
                        else
                            UIMgr:popUI("BattleLosePanel")
                        end
                        Time.timeScale = 1
                    end)
                end)
            end)
        else--战斗关卡入口
            self:_initBattle(levelConfig)
        end
    else
        --编辑器入口
        self:_enterStoryEditor()
    end
end

---@param levelConfig PveLevelTable
---@param replaySession table
function BattleState:_initReplayBattle(levelConfig, replaySession)
    local endFunc = function(CB)
        self.battleMgr = BattleCore:getBattleMgr()
        if not ClientBattleManager then
            ClientBattleManager = require "ClientBattleManager"
        end
        self._clientBattleMgr = ClientBattleManager.getInstance()
        self.battleMgr:init()
        self.battleMgr:setLevelConfig(levelConfig)
        self._clientBattleMgr:Init()
        local showManager = self._clientBattleMgr:getShowManager()
        self.battleMgr:setShowManager(showManager)
        self.battleMgr:prepareVerifyBattle(replaySession.battleStartInfo, replaySession.orderReport, {
            stepMode = true,
            autoStart = false,
            clientReplay = true,
        }, replaySession.randomList)
        showManager:preloadRoleRes()
        self._clientBattleMgr:StartBattle(levelConfig, function()
            local replayer = require "BattleVerifyReplayer"
            replayer.onReplayBattleEntered()
            if CB then
                CB()
            end
        end)
    end

    self:_loadBattleMapScene(levelConfig, endFunc)
end

--演出剧情
function BattleState:_enterStory(levelConfig, endCallback)
    -- LoadingMgr:SetLoadingOver(function()
        local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyOpen)
        if storyConfig.type == 1 then--目前暂无演出类型的纯剧情
            -- self.battleMgr = BattleCore:getBattleMgr()
            -- self.battleMgr:setLevelConfig(levelConfig)
            -- self.battleMgr:storyStart(levelConfig.storyOpen, endCallback)
        elseif storyConfig.type == 2 then
            UIMgr:popUI(
                "StoryPanel", 
                {storyName = storyConfig.storyArrary[1], callBackAfter = endCallback, needEndLoading = true},
                nil,
                nil,
                nil,
                function()
                    LoadingMgr:SetLoadingOver(nil, nil, "BattleState")
                end
            )
        end
    -- end)
end
 
--演出编辑器模式
function BattleState:_enterStoryEditor()
    self.battleMgr = BattleCore:getBattleMgr()
    if not ClientBattleManager then
        ClientBattleManager = require "ClientBattleManager"
    end
    self._clientBattleMgr = ClientBattleManager.getInstance()
    self.battleMgr:init()
    self._clientBattleMgr:Init()
    self._clientBattleMgr:storyEditorStart()
end

--演出回顾模式
function BattleState:_enterStoryReview(storyId)
    self.battleMgr = BattleCore:getBattleMgr()
    if not ClientBattleManager then
        ClientBattleManager = require "ClientBattleManager"
    end
    self._clientBattleMgr = ClientBattleManager.getInstance()
    self.battleMgr:init()
    self._clientBattleMgr:Init()
    local storyMgr = BattleCore:getBattleStoryManager()
    storyMgr:initCreatMap(storyId, function()
        local showManager = self._clientBattleMgr:getShowManager()
        showManager:loadPVRoot(function()
            LoadingMgr:SetLoadingOver(function()
                self._clientBattleMgr:storyStart(function()
                    storyMgr:clear()
                    GameObject.DestroyImmediate(showManager.battleRoot)
                    local callBack = StoryMgr:getNowStoryEndCallBack()
                    if callBack then
                        callBack()
                    end
                end)
            end, nil, "BattleState2")
        end)
    end)
end

--关卡入口
---@param levelConfig PveLevelTable
function BattleState:_initBattle(levelConfig)

    if not ClientBattleManager then
        ClientBattleManager = require "ClientBattleManager"
    end
    local endFunc = function(CB)
        self.battleMgr = BattleCore:getBattleMgr()
        self._clientBattleMgr = ClientBattleManager.getInstance()
        self.battleMgr:init()
        self.battleMgr:setLevelConfig(levelConfig)
        self._clientBattleMgr:Init()
        local showManager = self._clientBattleMgr:getShowManager()
        showManager:preloadRoleRes()
        self.battleMgr:setShowManager(showManager)
        self.battleMgr:initBattleTest(levelConfig)
        self.battleMgr:initWeekLyBossData()
        self._clientBattleMgr:StartBattle(levelConfig, function()
            if CB then
                CB()
            end
        end)
    end

    local jumpOpenStory = ClientData:GetJumpOpenStory()
    if levelConfig.storyOpen and levelConfig.storyOpen ~= 0 and jumpOpenStory ~= true then --战前演出剧情加载剧情中配置的地图
        local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyOpen)
        if storyConfig.type == 1 then
            self.battleMgr = BattleCore:getBattleMgr()
            if not ClientBattleManager then
                ClientBattleManager = require "ClientBattleManager"
            end
            self._clientBattleMgr = ClientBattleManager.getInstance()
            self.battleMgr:init()
            self.battleMgr:setLevelConfig(levelConfig)
            self._clientBattleMgr:Init()
            local storyMgr = BattleCore:getBattleStoryManager()
            storyMgr:initCreatMap(levelConfig.storyOpen, function()
                local showManager = self._clientBattleMgr:getShowManager()
                showManager:loadPVRoot(function()
                    LoadingMgr:SetLoadingOver(function()
                        self._clientBattleMgr:storyStart(function()
                            GameObject.DestroyImmediate(showManager.battleRoot)
                            self.battleMgr:clear()
                            self._clientBattleMgr:clear()
                            local storyMapId = storyMgr.mapId
                            DLuaTimer:DoAfter(0.1, function()
                                --根据地图是否相同判断是否要重新加载地图
                                if storyMapId ~= levelConfig.BattleMapId then
                                    LoadingMgr:SetLoadingStart(function()
                                        self:_loadBattleMapScene(levelConfig, function()
                                            endFunc(function()
                                                storyMgr:clear()
                                            end)
                                        end)
                                    end, nil, nil, "BattleState4")
                                else
                                    --battleroot重载完后再clear 防止相机露底
                                    endFunc(function()
                                        storyMgr:clear()
                                    end)
                                end
                            end) 
						end)
                    end, nil, "BattleState3")
                end)
            end)
            return
        end
    end

    self:_loadBattleMapScene(levelConfig, endFunc)
    -- if sceneMemoryProfiler then
    --     sceneMemoryProfiler:OnSceneLoading(mapPath)
    -- end

end

--战斗地图场景加载方法
---@param levelConfig PveLevelTable
---@param callBack function
function BattleState:_loadBattleMapScene(levelConfig, callBack)
    local mapConfig = Config.GetBattleMapInfo(levelConfig.BattleMapId)
    local mapPath = string.format(Config.ScenePath.BattleMapScene, mapConfig.resource,mapConfig.resource)
    ResMgr:LoadSceneAsyncLua(mapPath, false, function(sceneName)
        print("_initBattle LoadSceneAsync",sceneName)
        -- if (not sceneName or sceneName == "") then
            --编辑器模式
            LoadingMgr:UpdateProgress(1)
            callBack()
            -- return
        -- end
        -- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(sceneName)
        -- if self.loadSceneTimer then
        --     DLuaTimer:RemoveTimer(self.loadSceneTimer)
        -- end
        -- self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
        --     --进度条
        --     LoadingMgr:UpdateProgress(asyncOperation.progress)
        --     print("loadSceneTimer",asyncOperation.progress)
        --     if (asyncOperation.isDone) then
        --         DLuaTimer:RemoveTimer(self.loadSceneTimer)
        --         callBack()
        --     end
        -- end)
    end)
end

--剧情地图场景加载方法
---@param storyConfig StoryArraryTable
---@param callBack function
function BattleState:_loadStoryMapScene(storyConfig, callBack)
    
end

function BattleState:update()
    if self._clientBattleMgr then
        self._clientBattleMgr:Update()
    end
end

function BattleState:exit()
    -- UIMgr:removeUI("MatchMain")
    LuaLogger.Enabled = true
    if self.battleMgr then
        self.battleMgr:clear()
    end
    if self._clientBattleMgr then
        self._clientBattleMgr:clear()
    end
    self._clientBattleMgr = nil
    if ClientBattleManager then
        ClientBattleManager = nil
    end
    UIMgr:clearAllUI()
    PoolMgr:Clear()
    -- AssetManager.Instance:UnloadUnusedAssets()
    collectgarbage("collect")
    -- ResMgr:UnloadUnusedBundles(true)
end

return BattleState