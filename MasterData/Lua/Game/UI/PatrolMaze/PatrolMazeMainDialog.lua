-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-01 01:17:01
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local ControlPathNodePath = 'Game.UI.PatrolMaze.PatrolMazeMainControlPanel'

local FloorPathNodePath = 'Game.UI.PatrolMaze.PatrolMazeMainFloorPathNode'
local FloorPathNodeName = 'Cell'

local ChestListCellPath = 'Game.UI.PatrolMaze.PatrolMazeMainChestCell'
local ChestListCellName = 'PatrolMainChestCell130201'

local WaitBattleBlockName = 'PatrolMazeMainDialog_ExitBattleLoadOver'  -- 战斗结算回来时，等待loading界面完全消失
local MoveFloorBlockName  = 'PatrolMazeMainDialog_MoveFloorBlockName'  -- 等待移动楼层结束
local ScoreSyncBlockName  = 'PatrolMazeMainDialog_ScoreSyncBlockName'  -- 分数同步更新
local MoveFloorBlockTime  = 0.5
local FoucsFloorBlockTime = 0.2
local ScoreSyncBlockTime  = 0.8


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolMainDialog130201.prefab > name: PatrolMainDialog130201
---@class PatrolMazeMainDialog
---@field Env                           	PatrolMazeMainDialog                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AreaBgImg                     	UnityEngine.RectTransform               	@ 1    区域背景图
---@field UIRootNode                    	UnityEngine.RectTransform               	@ 2    UI根节点
---@field ChestListView                 	SuperScrollView.LoopListView2           	@ 3    奖励列表
---@field ControlPanel                  	UnityEngine.RectTransform               	@ 4    控制面板
---@field FloorPathListView             	SuperScrollView.LoopListView2           	@ 5    路径列表
---@field BottomPanel                   	UnityEngine.RectTransform               	@ 6    底部面板
---@field ScoreExplainBtn               	UnityEngine.RectTransform               	@ 7    积分-说明按钮
---@field ScoreGoodIcon                 	UnityEngine.RectTransform               	@ 8    积分-道具图标
---@field ScoreNumberTxt                	UnityEngine.RectTransform               	@ 9    积分-数量文本
---@field ScoreChangeUIFX               	UnityEngine.RectTransform               	@ 10   积分-变化特效
---@field AreaResetBtn                  	UnityEngine.RectTransform               	@ 11   区域重置按钮
---@field AllFinishNode                 	UnityEngine.RectTransform               	@ 12   全部通关节点
---@field BottomAnimRoot                	UnityEngine.RectTransform               	@ 13   底部动画节点
local PatrolMazeMainDialog = Class('PatrolMazeMainDialog')


function PatrolMazeMainDialog:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type integer @ 选中的路径位置
    self.selectFloorIndex_ = 0

    ---@type integer @ 选中的楼层位置
    self.selectLevelIndex_ = 0

    ---@type UnityEngine.Coroutine @ 滚动地图动画协程序
    self.moveFloorPathListCo_ = nil

    ---@type UnityEngine.Coroutine @ 打开事件界面动画协程序
    self.moveQuestEventDialogCo_ = nil

    ---@type PatrolMazeMainControlPanel @ 控制面板
    self.controlPanelEnv_ = nil
end


function PatrolMazeMainDialog:__delete()
    self.mapAreaDojo_            = nil
    self.selectFloorIndex_       = nil
    self.selectLevelIndex_       = nil
    self.moveFloorPathListCo_    = nil
    self.moveQuestEventDialogCo_ = nil
    self.controlPanelEnv_        = nil
end


function PatrolMazeMainDialog:Awake()
    self.controlPanelEnv_ = CfUtils.GetLuaScr(self.ControlPanel, ControlPathNodePath)
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [Constants.EventNames.ExitBattleLoadOver]       = Bind(self, self.OnBattleLoadedOverHandler_),
        [PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP] = Bind(self, self.OnMazeContinueStepHandler_),
        [PatrolMazeUtils.EventsName.ENTER_TEAM_ENTER]   = Bind(self, self.OnEnterTeamEnterHandler_),
        [PatrolMazeUtils.EventsName.ENTER_TEAM_CLOSE]   = Bind(self, self.OnEnterTeamCloseHandler_),
    })
    SetButtonAction(self.AreaResetBtn, Bind(self, self.OnClickAreaResetButtonHandler_))
    SetButtonAction(self.ScoreExplainBtn, Bind(self, self.OnClickScoreExplainButtonHandler_))
    SetListViewAction(self.ChestListView, Bind(self, self.OnUpdateChestListCellHandler_), ChestListCellName, {autoSize = true})
    SetListViewAction(self.FloorPathListView, Bind(self, self.OnUpdateFloorPathCellHandler_), FloorPathNodeName, {autoSize = true})
end


function PatrolMazeMainDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams  = CfUtils.DialogSafeParameters(self.controller)
        local mapAreaId   = checkInt(initParams.mapAreaId)
        self.mapAreaDojo_ = patrolMazeComp:GetHomeDojo():GetAreaDojo(mapAreaId)
        self:InitHomeView_()
    end)
end


function PatrolMazeMainDialog:OnFinalize()
    return CoWaitDo(function()
        self.controlPanelEnv_:OnFinalize()
        CfUtils.EventsUndecorated(self.eventsDecorated_)
        CfUtils.ConditionRemove(WaitBattleBlockName)
        CfUtils.ConditionRemove(MoveFloorBlockName)
        CfUtils.ConditionRemove(ScoreSyncBlockName)

        if self.moveFloorPathListCo_ then
            CoStop(self.moveFloorPathListCo_)
            self.moveFloorPathListCo_ = nil
        end
        if self.moveQuestEventDialogCo_ then
            CoStop(self.moveQuestEventDialogCo_)
            self.moveQuestEventDialogCo_ = nil
        end

        local initParams = self.controller.Argument.parameters or {}
        initParams.selectFloorIndex = self.selectFloorIndex_
        initParams.selectLevelIndex = self.selectLevelIndex_
        -- initParams.isNeedSyncData   = false -- 不能做缓存了，后端说战斗完成后不额外返回血量更新了，让重新请求home更新，还有没学的卡从队伍下阵容等
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function PatrolMazeMainDialog:OnShow()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        local isSyncDone = false
        local isAnimDone = false
        
        -- 是否需要重新请求数据（首次进入同步一次，界面回退回来则不用）
        if initParams.isNeedSyncData == false then
            self:UpdateHomeView_()
            isSyncDone = true
        else
            local mapAreaId = self.mapAreaDojo_.areaId
            patrolMazeComp:SyncMazeAreaData(mapAreaId, function()
                self:UpdateHomeView_()
                isSyncDone = true
            end)
        end

        -- 等待入场动画
        local enterAnimTime = CfUtils.GetAnimationTime(self.BottomAnimRoot, 'PatrolMainDialog130201_BottomPanel_Entry')
        -- CoYield(enterAnimTime)  -- 先不要了，会阻塞弹出圣物的时间
        isAnimDone = true

        -- 检测 动画和请求是否都完成了，再衔接做表现
        while not isSyncDone or not isAnimDone do
            CoYield()
        end
        self:CheckContinueStep_()
    end)
end


-------------------------------------------------
-- get / set

---@return PatrolMazeAreaDojo
function PatrolMazeMainDialog:GetMapAreaDojo()
    return self.mapAreaDojo_
end


---@return PatrolMazeFloorPathDojo[]
function PatrolMazeMainDialog:GetFloorPathDojoList()
    return self.mapAreaDojo_.floorPathDojoList
end


---@return PatrolMazeFloorRewardVo[]
function PatrolMazeMainDialog:GetFloorRewardVoList()
    return checkTable(self.floorRewardVoList_)
end
function PatrolMazeMainDialog:SetFloorRewardVoList(floorRewardVoList)
    self.floorRewardVoList_ = checkTable(floorRewardVoList)
    self:UpdateFloorRewardsList_()
end


-------------------------------------------------
-- public

function PatrolMazeMainDialog:Close()
    CfUtils.DialogBack()
end


--- 关闭 关卡点事件弹窗
function PatrolMazeMainDialog:CloseQuestEventDialog()
    CfUtils.DialogClose(Constants.UITypeIds.UIPatrolMazeQuestEventDialog)
    self:UnfocusQuestEventDialog()
end


--- 显示 关卡点事件弹窗
---@param pathDojo PatrolMazeFloorPathDojo
---@param levelDojo PatrolMazeFloorLevelDojo
---@param extParams table | nil
function PatrolMazeMainDialog:ShowQuestEventDialog(pathDojo, levelDojo, extParams)
    ---@type PatrolMazeQuestEventDialog
    local questEventDialog = CfUtils.DialogGet(Constants.UITypeIds.UIPatrolMazeQuestEventDialog)
    if questEventDialog then
        questEventDialog.Env:RefreshQuestEvent(pathDojo, levelDojo)
    else
        CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeQuestEventDialog, {
            areaDojo  = self.mapAreaDojo_,
            pathDojo  = pathDojo,
            levelDojo = levelDojo,
            extParams = extParams,
            backCb    = function()
                self:SaveSelectFloorAndLevel_(0, 0)
                self:UnfocusQuestEventDialog()
            end
        })
        self:FocusQuestEventDialog(pathDojo.floorNum)
    end
end


function PatrolMazeMainDialog:FocusQuestEventDialog(floorNum, finishCb)
    if self.moveQuestEventDialogCo_ then
        CoStop(self.moveQuestEventDialogCo_)
    end
    self.moveQuestEventDialogCo_ = CoStart(function()
        CfUtils.ConditionAppend(MoveFloorBlockName)
        local targetScale = 0.8
        local targetIndex = floorNum - 1
        local moveTargetX = CfUtils.CalculateListTargetX(self.FloorPathListView, FloorPathNodeName, targetIndex)
        self.FloorPathListView.ContainerTrans:DOAnchorPosX(moveTargetX, FoucsFloorBlockTime)
        self.FloorPathListView.transform:DOScaleX(targetScale, FoucsFloorBlockTime)
        self.FloorPathListView.transform:DOScaleY(targetScale, FoucsFloorBlockTime)
        CoYield(FoucsFloorBlockTime)
        -- move ended
        CfUtils.ConditionRemove(MoveFloorBlockName)
        self.moveQuestEventDialogCo_ = nil
        if finishCb then
            finishCb()
        end
    end)
end


function PatrolMazeMainDialog:UnfocusQuestEventDialog(finishCb)
    if self.moveQuestEventDialogCo_ then
        CoStop(self.moveQuestEventDialogCo_)
    end
    self.moveQuestEventDialogCo_ = CoStart(function()
        CfUtils.ConditionAppend(MoveFloorBlockName)
        local targetScale = 1
        self.FloorPathListView.transform:DOScaleX(targetScale, FoucsFloorBlockTime)
        self.FloorPathListView.transform:DOScaleY(targetScale, FoucsFloorBlockTime)
        CoYield(FoucsFloorBlockTime)
        -- move ended
        CfUtils.ConditionRemove(MoveFloorBlockName)
        self.moveQuestEventDialogCo_ = nil
        if finishCb then
            finishCb()
        end
    end)
end


-------------------------------------------------
-- private

-- 初始 界面（和数据无关的部分）
function PatrolMazeMainDialog:InitHomeView_()
    CfUtils.RefreshTopGoods({ PatrolMazeUtils.GetCurrencyId() })
    CfUtils.SetActive(self.ScoreChangeUIFX, false)

    -- update map bg
    local mapAreaId = self.mapAreaDojo_.areaId
    local mapBgPath = string.format('Arts/Textures/Activity/PatrolMap/activity_patro_map_%02d.png', mapAreaId)
    CfUtils.FillImage(self.AreaBgImg, mapBgPath)

    -- update score icon
    local goodsId  = PatrolMazeUtils.GetScoreId()
    local iconPath = GoodsConfMgr:GetInstance():GetPhotoPathById(goodsId)
    CfUtils.FillImage(self.ScoreGoodIcon, iconPath)

    -- cache rewardVo
    local rewardVoList = PatrolMazeUtils.GetFloorRewardsVoList(mapAreaId)
    self:SetFloorRewardVoList(rewardVoList)
end


--- 刷新 全部主页数据
function PatrolMazeMainDialog:UpdateHomeView_()
    self.controlPanelEnv_:SetMainDialog(self)
    self:UpdateScoreRewards_()
    self:UpdateFloorPathList_()
    Events.Broadcast(Constants.EventNames.EveryThingChangeEventName)  -- 货币栏刷新最新货币
end


-- 检测 执行继续未完成的步骤
function PatrolMazeMainDialog:CheckContinueStep_()
    local mapAreaId = self.mapAreaDojo_.areaId

    -------------------------------------------------
    -- 是否：从助理助战角色 的【三方卡牌预览界面】回来
    local initParams   = self.controller.Argument.parameters or {}
    local helpSelectId = checkInt(initParams.tempHelpSelectId)
    if helpSelectId > 0 then
        -- clean tempData
        initParams.tempHelpSelectId = nil
        -- select levelNdoe
        local floorIndex = checkInt(initParams.selectFloorIndex)
        local levelIndex = checkInt(initParams.selectLevelIndex)
        self:SaveSelectFloorAndLevel_(floorIndex, levelIndex)
        -- show eventDialog
        local pathDojo  = self:GetFloorPathDojoList()[floorIndex]
        local levelDojo = pathDojo.levelDojoList[levelIndex]
        self:ShowQuestEventDialog(pathDojo, levelDojo, {helpSelectId = helpSelectId})
        return
    end

    -------------------------------------------------
    -- 是否：刚刚战斗结束
    if self.mapAreaDojo_.tempPassedQuestData ~= nil then
        -- 等待战斗界面loading完全消失
        CfUtils.ConditionAppend(WaitBattleBlockName)
        return
    end

    -------------------------------------------------
    -- 是否：有过关后的圣物选择
    if next(self.mapAreaDojo_.tempChooseRelics) ~= nil then
        local chooseRelics = self.mapAreaDojo_.tempChooseRelics
        CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeBuffChooseDialog, {mapAreaId = mapAreaId, chooseRelics = chooseRelics, closeCb = function()
            self.controlPanelEnv_:PlayBuffReceiveAnim()
            Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
        end})
        return
    end

    -------------------------------------------------
    -- 是否：剧情选项完成
    if self.mapAreaDojo_.tempStoryChoseData ~= nil then
        patrolMazeComp:MoveMazeByStoryOption(
            mapAreaId,
            function(relicId)
                CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeBuffChooseDialog, {mapAreaId = mapAreaId, rewardRelicId = relicId, closeCb = function()
                    self.controlPanelEnv_:PlayBuffReceiveAnim()
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end})
            end,
            function(curseId)
                CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeBuffChooseDialog, {mapAreaId = mapAreaId, rewardCurseId = curseId, closeCb = function()
                    self.controlPanelEnv_:PlayBuffReceiveAnim()
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end})
            end,
            function(addPoint)
                local rewardList = {
                    {goodsId = PatrolMazeUtils.GetCurrencyId(), num = addPoint, showText = false}
                }
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList, cb = function()
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end})
            end,
            function(rewardList)
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList, cb = function()
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end})
            end,
            function(cureDatas)
                CfUtils.DialogOpen(Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, {
                    levelUpType = Constants.UICultivateLevelUpFinishType.PatrolMazeCardsRecovery,
                    mapAreaId = mapAreaId, 
                    cureDatas = cureDatas, 
                    closeCb   = function()
                        Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                    end
                })
            end
        )
        return
    end

    -------------------------------------------------
    -- 是否：有分数变化
    if self.mapAreaDojo_.tempMazeScore > -1 then
        local passedFloor  = self.mapAreaDojo_.tempPassedFloor
        local passedLevel  = self.mapAreaDojo_.tempPassedLevel
        local oldMazeScore = self.mapAreaDojo_.tempMazeScore
        local newMazeScore = self.mapAreaDojo_.mazeScore
        -- clean tempData
        self.mapAreaDojo_.tempMazeScore   = -1
        self.mapAreaDojo_.tempPassedFloor = 0
        self.mapAreaDojo_.tempPassedLevel = 0
        CfUtils.ConditionAppend(ScoreSyncBlockName)
        -- tween score
        local doScoreUpdateTween = function()
            local scoreTweenValue = newMazeScore - oldMazeScore
            CfUtils.DoTween(ScoreSyncBlockTime, 
                function(updatePercent)
                    local targetPoint = oldMazeScore + math.ceil(scoreTweenValue * updatePercent)
                    self:UpdateScoreProgress_(targetPoint)
                end, 
                function()
                    self:UpdateScoreProgress_(newMazeScore)
                    CfUtils.ConditionRemove(ScoreSyncBlockName)
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end
            )
        end
        -- check passedNode anim
        if passedFloor > 0 and passedLevel > 0 then
            CfUtils.SetActive(self.ScoreChangeUIFX, false)
            local clickPathNodeObj  = self.FloorPathListView:GetShownItemByItemIndex(passedFloor - 1)
            ---@type PatrolMazeMainFloorPathNode
            local clickPathNodeEnv  = CfUtils.GetLuaScr(clickPathNodeObj, FloorPathNodePath)
            local clickLevelNodeEnv = clickPathNodeEnv:GetLevelNodeEnvList()[passedLevel]
            clickLevelNodeEnv:PlayScoreBoomAnim(self.ScoreNumberTxt, function()
                CfUtils.SetActive(self.ScoreChangeUIFX, true)
                doScoreUpdateTween()
            end)
        else
            doScoreUpdateTween()
        end
        return
    end

    -------------------------------------------------
    -- 是否通关楼层更新
    if self.mapAreaDojo_.tempFloorPassed > 0 then
        self.mapAreaDojo_.floorPassed  = self.mapAreaDojo_.tempFloorPassed
        self.mapAreaDojo_.historyFloor = math.max(self.mapAreaDojo_.historyFloor, self.mapAreaDojo_.floorPassed)
        -- clean tempData
        self.mapAreaDojo_.tempFloorPassed = 0
        -- move floorMap
        self:UpdateFloorPathList_(true, function()
            Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
        end)
        return
    end

    -------------------------------------------------
    -- 是否有楼层奖励未领取
    local drawFloorRewardId = nil
    for rewardIndex, floorRewardVo in ipairs(self:GetFloorRewardVoList()) do
        if self.mapAreaDojo_.mazeScore >= floorRewardVo.scoreNum then
            if not self.mapAreaDojo_:HasFloorRewardDrawn(floorRewardVo.rewardId) then
                drawFloorRewardId = floorRewardVo.rewardId
                break
            end
        end
    end
    if drawFloorRewardId ~= nil then
        local requestData = {areaId = mapAreaId, floorRewardsId = drawFloorRewardId}
        GameUtils.Request(Interfaces.OverseaMazeAreaDrawRewards, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)
                -- save floorRewardId
                self.mapAreaDojo_:AddFloorRewardDrawn(drawFloorRewardId)
                self:UpdateScoreRewards_()  -- 刷新掉领取状态
                -- draw rewards
                local rewardList = checkTable(responseData.rewards)
                GoodsUtils.DrawRewards(rewardList, true)
                -- show rewards
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList, cb = function()
                    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
                end})
            end
        end)
        return
    end

    -------------------------------------------------
    -- 是否全部通关
    if self.mapAreaDojo_.floorPassed >= self.mapAreaDojo_.floorLimit then
        CfUtils.SetActive(self.AllFinishNode, true)
        CfUtils.SetActive(self.AreaResetBtn, false)
        return
    end
end


--- 刷新 楼层地图列表
---@param isTweenMove boolean
---@param finishCb fun():void
function PatrolMazeMainDialog:UpdateFloorPathList_(isTweenMove, finishCb)
    local listDataLength = #self:GetFloorPathDojoList()
    GameUtils.ReloadData(self.FloorPathListView, listDataLength)

    local targetIndex = self.mapAreaDojo_.floorPassed
    if isTweenMove then
        if self.moveFloorPathListCo_ then
            CoStop(self.moveFloorPathListCo_)
        end
        self.moveFloorPathListCo_ = CoStart(function()
            CfUtils.ConditionAppend(MoveFloorBlockName)
            -- move start
            local targetScale = 1
            local moveTargetX = CfUtils.CalculateListTargetX(self.FloorPathListView, FloorPathNodeName, targetIndex)
            self.FloorPathListView.ContainerTrans:DOAnchorPosX(moveTargetX, MoveFloorBlockTime)
            self.FloorPathListView.transform:DOScaleX(targetScale, FoucsFloorBlockTime)
            self.FloorPathListView.transform:DOScaleY(targetScale, FoucsFloorBlockTime)
            CoYield(MoveFloorBlockTime)
            -- move ended
            CfUtils.ConditionRemove(MoveFloorBlockName)
            self.moveFloorPathListCo_ = nil
            if finishCb then
                finishCb()
            end
        end)
    else
        -- scroll to current floor
        self.FloorPathListView:MovePanelToItemIndex(targetIndex)
    end
end


--- 保存 选中的楼层位置
---@param floorIndex integer
---@param levelIndex integer
function PatrolMazeMainDialog:SaveSelectFloorAndLevel_(floorIndex, levelIndex)
    local oldFloorIndex = self.selectFloorIndex_
    local oldLevelIndex = self.selectLevelIndex_
    local newFloorIndex = checkInt(floorIndex)
    local newLevelIndex = checkInt(levelIndex)

    -- check same select
    if oldFloorIndex == newFloorIndex and oldLevelIndex == newLevelIndex then
        return
    end

    -- update dooj
    self.mapAreaDojo_.selectFloorIndex = newFloorIndex
    self.mapAreaDojo_.selectLevelIndex = newLevelIndex

    -- update view
    local oldPathNodeObj = self.FloorPathListView:GetShownItemByItemIndex(oldFloorIndex - 1)
    local newPathNodeObj = self.FloorPathListView:GetShownItemByItemIndex(newFloorIndex - 1)
    
    ---@type PatrolMazeMainFloorPathNode
    local oldPathNodeEnv = CfUtils.GetLuaScr(oldPathNodeObj, FloorPathNodePath)
    ---@type PatrolMazeMainFloorPathNode
    local newPathNodeEnv = CfUtils.GetLuaScr(newPathNodeObj, FloorPathNodePath)
    
    -- cancel old
    if oldPathNodeEnv then
        oldPathNodeEnv:SetClickLevelIndex(0)
    end
    
    -- select new
    if newPathNodeEnv then
        newPathNodeEnv:SetClickLevelIndex(newLevelIndex)
    end

    -- update cache
    self.selectFloorIndex_ = newFloorIndex
    self.selectLevelIndex_ = newLevelIndex
    Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_FLOOR_SELECT)
end


--- 刷新奖励列表
function PatrolMazeMainDialog:UpdateFloorRewardsList_()
    local listDataLength = #self:GetFloorRewardVoList()
    GameUtils.ReloadData(self.ChestListView, listDataLength)
end


--- 刷新 积分奖励列表
function PatrolMazeMainDialog:UpdateScoreRewards_()
    -- update score progress
    local mazeScore = self.mapAreaDojo_.tempMazeScore > -1 and self.mapAreaDojo_.tempMazeScore or self.mapAreaDojo_.mazeScore
    self:UpdateScoreProgress_(mazeScore)
end


--- 刷新 积分的进度
---@param mazeScore integer
function PatrolMazeMainDialog:UpdateScoreProgress_(mazeScore)
    -- update score number
    CfUtils.FillText(self.ScoreNumberTxt, mazeScore)

    -- update reward progress
    for rewardIndex = 1, #self:GetFloorRewardVoList() do
        local curtRewardVo  = self:GetFloorRewardVoList()[rewardIndex]
        local prevRewardVo  = self:GetFloorRewardVoList()[rewardIndex - 1] or {scoreNum = 0}
        local chestCellNode = self.ChestListView:GetShownItemByItemIndex(rewardIndex - 1)
        ---@type PatrolMazeMainChestCell
        local chestCellEnv  = CfUtils.GetLuaScr(chestCellNode, ChestListCellPath)
        if mazeScore > curtRewardVo.scoreNum then
            if chestCellEnv then
                chestCellEnv:SetScorePercent(1)
            end
        else
            local targeted = curtRewardVo.scoreNum - prevRewardVo.scoreNum
            local overflow = math.max(mazeScore - prevRewardVo.scoreNum, 0)
            if chestCellEnv then
                chestCellEnv:SetScorePercent(overflow / targeted)
            end
        end
    end
end


-------------------------------------------------
-- handler

function PatrolMazeMainDialog:OnMazeContinueStepHandler_()
    self:CheckContinueStep_()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function PatrolMazeMainDialog:OnUpdateChestListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(ChestListCellName)
    local cellData = self:GetFloorRewardVoList()[luaIndex]
    ---@type PatrolMazeMainChestCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, ChestListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({rewardVo = cellData, mapAreaDojo = self.mapAreaDojo_})
        cellEnv:SetClickChestCB(Bind(self, self.OnClickChestListCellCallback_))
    end
    return cellNode
end


function PatrolMazeMainDialog:OnClickChestListCellCallback_(luaIndex, sender)
    ---@type PatrolMazeFloorRewardVo
    local rewardVo = checkTable(self:GetFloorRewardVoList()[luaIndex])
    local hasDrawn = self.mapAreaDojo_:HasFloorRewardDrawn(rewardVo.rewardId)
    if hasDrawn then
        GameUtils.Toast(localize('奖励已领取'))
    else
        GameUtils.ShowCommonTipsBoardRewardPreview(sender, rewardVo.rewardsData, localize('奖励预览:'), false)
    end
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function PatrolMazeMainDialog:OnUpdateFloorPathCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(FloorPathNodeName)
    local cellData = self:GetFloorPathDojoList()[luaIndex]
    ---@type PatrolMazeMainFloorPathNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, FloorPathNodePath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({areaDojo = self.mapAreaDojo_, pathDojo = cellData})
        cellEnv:SetClickLevelNodeCb(Bind(self, self.OnClickFloorLevelNodeCallback_))
        -- update cell
        if self.selectFloorIndex_ == luaIndex then
            cellEnv:SetClickLevelIndex(self.selectLevelIndex_)
        else
            cellEnv:SetClickLevelIndex(0)
        end
        -- play anim
        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


---@param pathNode PatrolMazeMainFloorPathNode
---@param levelNode PatrolMazeMainFloorLevelNode
function PatrolMazeMainDialog:OnClickFloorLevelNodeCallback_(pathNode, levelNode)
    local questState = levelNode:GetQuestState()
    if questState == PatrolMazeUtils.QuestState.CURRENT then
        local clickFloorIndex = checkInt(pathNode:GetLuaIndex())
        local clickLevelIndex = checkInt(levelNode:GetLuaIndex())
        -- check click same
        if clickFloorIndex == self.selectFloorIndex_ and clickLevelIndex == self.selectLevelIndex_ then
            self:SaveSelectFloorAndLevel_(0, 0)
            self:CloseQuestEventDialog()
        else
            self:SaveSelectFloorAndLevel_(pathNode:GetLuaIndex(), levelNode:GetLuaIndex())
            self:ShowQuestEventDialog(pathNode:GetPathDojo(), levelNode:GetLevelDojo())
        end

    elseif questState == PatrolMazeUtils.QuestState.PAASED then
        GameUtils.Toast(localize('该层已通关'))

    elseif questState == PatrolMazeUtils.QuestState.COMING_SOON then
        GameUtils.Toast(localize('请先通过前一层'))

    elseif questState == PatrolMazeUtils.QuestState.DISABLE then
        GameUtils.Toast(localize('该层还未激活'))

    elseif questState == PatrolMazeUtils.QuestState.INVALID then
        GameUtils.Toast(localize('该路线不可选择'))

    else
        GameUtils.Toast('Debug：发生了甚么事情')
    end
end


function PatrolMazeMainDialog:OnClickAreaResetButtonHandler_()
    local mapAreaId = self.mapAreaDojo_.areaId
    GameUtils.SecondConfirm(localize('是否重置全部关卡？'), function()
        if self.selectFloorIndex_ > 0 or self.selectLevelIndex_ > 0 then
            self:SaveSelectFloorAndLevel_(0, 0)
            self:CloseQuestEventDialog()
        end
        patrolMazeComp:ResetMazeAreaData(mapAreaId, function()
            CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeEnterTeamPopup, {mapAreaId = mapAreaId})
        end)
    end)
end


function PatrolMazeMainDialog:OnEnterTeamEnterHandler_()
    local mapAreaId = self.mapAreaDojo_.areaId
    patrolMazeComp:SyncMazeAreaData(mapAreaId, function()
        self:UpdateHomeView_()
        self:CheckContinueStep_()
    end)
end


function PatrolMazeMainDialog:OnEnterTeamCloseHandler_()
    CoStart(function()
        while CfUtils.DialogGet(Constants.UITypeIds.UIPatrolMazeEnterTeamPopup) do
            CoYield()
        end
        self:Close()
    end)
end


function PatrolMazeMainDialog:OnClickScoreExplainButtonHandler_()
    local scoreDescr = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.MAZE_SCORE_DESCR)
    GameUtils.ShowCommonTipsBoardAttribute(self.ScoreExplainBtn.gameObject, localize('积分说明'), scoreDescr, true, false)
end


function PatrolMazeMainDialog:OnBattleLoadedOverHandler_()
    if self.mapAreaDojo_.tempPassedQuestData ~= nil then
        local passedFloor = checkInt(self.mapAreaDojo_.tempPassedQuestData.floor)
        local passedLevel = checkInt(self.mapAreaDojo_.tempPassedQuestData.level)
        local passedQuest = checkInt(self.mapAreaDojo_.tempPassedQuestData.questId)

        -- 最后一关通关，没有圣物选择
        if passedFloor == self.mapAreaDojo_.floorLimit then

            -- 完成当前层，向下走一层
            self.mapAreaDojo_.tempFloorPassed = self.mapAreaDojo_.floorPassed + 1
            self.mapAreaDojo_.tempPassedFloor = passedFloor
            self.mapAreaDojo_.tempPassedLevel = passedLevel

            -- 手动增加最新分数
            local floorPathDojo  = self.mapAreaDojo_.floorPathDojoList[passedFloor]
            local floorLevelDojo = floorPathDojo.levelDojoList[floorPathDojo.selectLevel]
            local addMazeScore   = PatrolMazeUtils.GetScoreNum(self.mapAreaDojo_.areaId, passedFloor, floorLevelDojo.questType)
            self.mapAreaDojo_.tempMazeScore = self.mapAreaDojo_.mazeScore
            self.mapAreaDojo_.mazeScore     = self.mapAreaDojo_.mazeScore + addMazeScore
        end

        -- clean tempData
        self.mapAreaDojo_.tempPassedQuestData = nil
        CfUtils.ConditionRemove(WaitBattleBlockName)
        Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
        -- switch bgm
        local bgmName = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.MAZE_BGM_NAME)
        GameUtils.GetCriWareUtils().PlayMusicById(bgmName)
    end
end


return PatrolMazeMainDialog
