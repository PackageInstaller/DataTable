
------------ import ------------
local cs_coroutine     = require "XLua.cs_coroutine"
local Yielders = CS.Engine.Lib.Yielders -- 协程

---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type GoodsConfMgr
local goodsConfMgr     = GoodsConfMgr:GetInstance()
local sceneManagement  = SceneManagement:GetInstance()
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

local MazeMain = import('Game.Behaviours.Maze.MazeMain')


---@type MazeLoadScene
local MazeLoadScene = import('Game.Behaviours.Maze.MazeLoadScene'):GetInstance()

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

------------ import ------------


------------ define ------------
local tInsert = table.insert
------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalExploreTracking.prefab
---@class MapDecryptionExplorePanel
---@field Env                           	MapDecryptionExplorePanel               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field NodeContainer                 	UnityEngine.RectTransform               
---@field redPoint                      	UnityEngine.RectTransform               
---@field BtnTracking                   	UnityEngine.RectTransform               
---@field TxtTips                       	Game.Native.Common.UISwitchText
---@field FontStyleButton               	UnityEngine.RectTransform    -- "探索" 按钮           
---@field ListGroup                     	UnityEngine.RectTransform               
---@field Effect                        	UnityEngine.RectTransform               
---@field ImgRewardIconMask             	Engine.UI.RawImageAlterable             
---@field FinishNode                    	UnityEngine.RectTransform               
---@field TxtGet                        	UnityEngine.UI.Text                     
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   
---@field ImgRewardIcon                 	Engine.UI.RawImageAlterable             
---@field BtnReward                     	UnityEngine.RectTransform               
---@field TxtTitle                      	UnityEngine.UI.Text                     
---@field ImgIcon                       	Engine.UI.RawImageAlterable             
local MapDecryptionExplorePanel = Class('MapDecryptionExplorePanel')

function MapDecryptionExplorePanel:__init()
    self._exploreIndex = 1
    self._exploreNodes = {} -- 装 4 个迷宫图标
    self._taskNodes    = {}
    self._exploreDataEntityList = nil
end

function MapDecryptionExplorePanel:__delete()

end

function MapDecryptionExplorePanel:Awake()
    local ImgIconBg = self.controller.transform:Find("RightPanel/TitleGroup/BtnReward/ImgIconBg")
    if not isNull(ImgIconBg) then
        self.ImgIconBg = ImgIconBg.gameObject:GetComponent(typeof(CS.Game.Native.Common.UISwitchImage))
    end
end


function MapDecryptionExplorePanel:Start()
    SetButtonAction(self.BtnReward,       Bind(self, self.OnClickBtnRewardAction))
    SetButtonAction(self.BtnTracking,     Bind(self, self.OnClickBtnTrackingAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickFontStyleButtonAction))

    self.__onRequestSuccess = Events.AddListener(MapDecryptionConstants.EventNames.RequestSuccess, Bind(self, self.OnRequestSuccess))
end


function MapDecryptionExplorePanel:OnDestroy()
    if self.__onRequestSuccess then
        Events.RemoveListener(MapDecryptionConstants.EventNames.RequestSuccess, self.__onRequestSuccess)
    end
    self:StopHomeRequestCo()
    self:UnRegEventTimeChanged()

    if self.co ~= nil then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function MapDecryptionExplorePanel:Init(nodePositions, nodeRotations, exploreId, controller)
    ---@type MapDecryptionComponent
    local component            = MapDecryptionMgr:GetComponent()
    self._exploreDataEntityList = component:GenerateExploreDataEntityList()

    print( "tpr == exploreId = " .. (exploreId==nil and "nil" or tostring(exploreId) ) )

    -- 旧版实现, 但似乎 exploreId 始终为 nil, 此段未能起效
    -- if exploreId then
    --     exploreId = checkNumber(exploreId)
    --     for i, v in ipairs(self._exploreDataEntityList) do
    --         if v.exploreId == exploreId then
    --             self._exploreIndex = i
    --             break
    --         end
    --     end
    -- end

    ---@type MapDecryptionDojo
    local homeDojo = component:GetMapDecryptionDojo()

    local dojoCurrentMapId = homeDojo.playerMapDecryption.currentMapId -- nil 或 "0" 表示空, 否则为 "1","2","3","4 " 中的一个 
    local dojoLastQuestMapId = homeDojo.playerMapDecryption.lastQuestMapId -- nil 或 "0" 表示空, 否则为 "1","2","3","4 " 中的一个 
    local currentMapId = self:FindCurrentMapId( dojoCurrentMapId, dojoLastQuestMapId )

    -- 若玩家当前正在游玩某个迷宫(且那个章节没有打完), 就沿用那个 mapId, 否则自动指向 迷宫1
    self._exploreIndex = ( currentMapId==0 ) and 1 or currentMapId


    self._controller = controller -- 其实就是: SpringFestivalExploreTracking
    self:InitExploreNodes(nodePositions, nodeRotations, self.NodeContainer)
end

function MapDecryptionExplorePanel:InitExploreNodes(nodePositions, nodeRotations, parent)
    self.co = cs_coroutine.start(function ()
        local go
        local parentGo = parent.gameObject
        for i, entity in ipairs(self._exploreDataEntityList) do
            if i == 1 then
                go = MapDecryptionUtils.CreateGameObjectByPath(MapDecryptionConstants.PrefabPath.MapExploreNode, parent)
            else
                go = parentGo:AddChild(go)
            end
            tInsert(self._exploreNodes, go)

            local nodePosition = nodePositions[i]
            local transform = go.transform
            transform.anchoredPosition = CfUtils.WorldPosition2UIPosition(nodePosition, parent)
            transform.rotation = nodeRotations[i]
            self:FreshExploreNode(go, entity, self._exploreIndex == i, i)
        end


        local entityList = self._exploreDataEntityList
        ---@type MapDecryptionExploreTrackingController
        local controllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.ExploreTracking)
        local root = controllerComp._explorePositionRoot
        while true do
            for i, entity in ipairs(entityList) do
                local child = root:GetChild(i - 1)
                local nodePosition            = child.position
                local node = self._exploreNodes[i]
                node.transform.anchoredPosition = CfUtils.WorldPosition2UIPosition(nodePosition, parent)
                
            end
            cs_coroutine.yield_return()
        end
        
        self.co = nil
    end)
end


-- 每次进入 "探索-桌面- 4迷宫选择" 界面时, 被调用
--- FreshExploreNode
---@param go UnityEngine.GameObject
---@param entity MapDecryptionExploreDataEntity
---@param isSelect boolean
function MapDecryptionExplorePanel:FreshExploreNode(go, entity, isSelect, exploreIndex)
    ---@type MapDecryptionMapExploreNode
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.MapExploreNode)
    if not isNull(env) then
        if exploreIndex then
            env:SetIndex(exploreIndex)
            env:SetCallback(Bind(self, self.OnClickExploreNodeAction))
        end
        env:FreshUI(entity, isSelect)
    end
end

function MapDecryptionExplorePanel:FreshUI()
    ---@type MapDecryptionExploreDataEntity
    local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]
    
    ---@type MapDecryptionDecryptedMapsVo
    local decryptedMapVo = exploreDataEntity.mapConfData
    local antiqueId      = decryptedMapVo.antiqueId
    local num            = GoodsUtils.GetThingNo(antiqueId)
    self.ImgIcon:LoadSprite(num > 0 and decryptedMapVo.antiquePicture or decryptedMapVo.noAntique)
    self.TxtTitle.text = decryptedMapVo.name

    local rewards  = decryptedMapVo.rewards
    local reward   = table.takeFirst(rewards) or {}
    local goodsId  = reward.goodsId
    -- local goodsNum = reward.goodsNum
    self:FreshFinalRewardShowStatus(exploreDataEntity) -- 只有用户选中的那个 迷宫ui 才会调用

    ---@type GoodsVo
    local goodsVo  = goodsConfMgr:GetGoodsVoById(goodsId)
    if goodsVo then
        self.ImgRewardIconMask:LoadSprite(goodsVo.photoPath)
        self.ImgRewardIcon:LoadSprite(goodsVo.photoPath)
    else
        printError("未在道具表找到%s", goodsId)    
    end
    

    self:FreshListGroup(exploreDataEntity)

end

--- FreshFinalRewardShowStatus
---@param exploreDataEntity MapDecryptionExploreDataEntity
function MapDecryptionExplorePanel:FreshFinalRewardShowStatus(exploreDataEntity)
    local ReceiveStatus = MapDecryptionConstants.ReceiveStatus

    local status        = exploreDataEntity.status
    local isNotComplete = status == ReceiveStatus.NotComplete
    KTool.SetActive(self.TxtNumber.gameObject,  isNotComplete)
    if isNotComplete then
        self.TxtNumber.text = string.format("<color=#a3a3a3>%s</color>/%s", exploreDataEntity.exploreProgress, exploreDataEntity.exploreTargetNum)
    end

    local isCanReceive  = status == ReceiveStatus.CanReceive
    KTool.SetActive(self.TxtGet.gameObject,     isCanReceive)

    local isReceived    = status == ReceiveStatus.Received
    KTool.SetActive(self.FinishNode.gameObject, isReceived)
    
    if not isNull(self.ImgIconBg) then
        self.ImgIconBg.Status = isReceived and 2 or 1
    end

    if self:FreshBottom() then
        self:UnRegEventTimeChanged()
    end
end

function MapDecryptionExplorePanel:FreshBottom()
    ---@type MapDecryptionExploreDataEntity
    local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]
    local curTime   = os.time()
    local unlockDay = exploreDataEntity.unlockDay
    local isUnlock  = curTime >= unlockDay
    local seconds   = curTime - unlockDay
    if isUnlock then
        self:FreshBottomUI(MapDecryptionMgr:CheckActivityIsEnd(), exploreDataEntity.isUnlock == 1)
    else
        self:FreshCountDown(seconds)
    end
    return isUnlock
end

function MapDecryptionExplorePanel:FindCurrentMapId(dojoCurrentMapId, dojoLastQuestMapId)

    local currentMapId = 0 -- 0表示空, 否则为有效值 int 1,2,3,4
    if dojoCurrentMapId == nil or dojoCurrentMapId == "0" then 
        -- 玩家要么第一次进入 2D迷宫, 要么打完了上一个章节:
        if dojoLastQuestMapId == nil or dojoLastQuestMapId == "0" then 
            currentMapId = 0
        else 
            currentMapId = checkInt(dojoLastQuestMapId)
        end
    else 
        -- 存在有效的 currentMapId, 说明玩家上次探索的章节并未打完:
        currentMapId = checkInt( dojoCurrentMapId )
    end
    return currentMapId
end 



--- FreshBottomUI
---@param isTimeEnd boolean 
---@param status number | nil 时间结束 status 无意义 可以不传此参数
---@param isUnlock number | nil 时间结束 isUnlock 无意义 可以不传此参数
function MapDecryptionExplorePanel:FreshBottomUI(isTimeEnd, isUnlock)

    local isShowTips = true
    -- 1: "收集上一张地图古物后解锁" 
    -- 2: "活动已经结束"
    -- 3: "您正在探索另一张地图"
    -- 4: "当前地图已完成探索"
    local txtTipsStatus = nil 
    local txtTips = nil
    --- 
    if isTimeEnd == true then 
        txtTipsStatus = 2

    elseif (not isUnlock) then
        txtTipsStatus = 1

    else 
        ---@type MapDecryptionComponent
        local component = MapDecryptionMgr:GetComponent()
        ---@type MapDecryptionDojo
        local homeDojo          = component:GetMapDecryptionDojo()

        local dojoCurrentMapId = homeDojo.playerMapDecryption.currentMapId -- nil 或 "0" 表示空, 否则为 "1","2","3","4 " 中的一个 
        -- local dojoLastQuestMapId = homeDojo.playerMapDecryption.lastQuestMapId -- nil 或 "0" 表示空, 否则为 "1","2","3","4 " 中的一个 
        ---@type MapDecryptionExploreDataEntity
        local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]
        ---@type MapDecryptionDecryptedMapsVo
        local mapConfData       = exploreDataEntity.mapConfData
        local mapId             = mapConfData.id
        local unlockNum         = mapConfData.unlockNum

        local currentMapId = (dojoCurrentMapId == nil or dojoCurrentMapId == "0") and 0 or checkInt(dojoCurrentMapId) -- int 0 表示空
        
        if unlockNum > 0 and not QuestConfMgr:GetInstance():IsPassQuest(unlockNum) then
            txtTipsStatus = 1
            
        elseif currentMapId ~= 0 then 
            -- 说明当前存在 "尚未打穿" 的章节
            if currentMapId == mapId then 
                -- 玩家选中了 上一次正在玩的章节
                isShowTips = false
                txtTipsStatus = nil
            else 
                -- 存在 "正在进行的章节", 但玩家选了另一张迷宫 
                txtTipsStatus = 3
            end 
        else 
        
            local mapPassedInfo     = checkTable(homeDojo.mapPassedInfo)
            local groupIdStr        = mapPassedInfo[mapId]
            local groupId           = checkNumber(groupIdStr)
            --- 最终古物特殊 是不配的 所以加下这个判断
            if groupIdStr ~= nil and groupId == 0 then
                txtTipsStatus = 4
                
            elseif groupId == mapConfData.groupOne then
                local antiqueId = mapConfData.antiqueId
                local finalAntiqueId     = component:GetFinalAntiqueId()
                if GoodsUtils.GetThingNo(antiqueId) <= 0 then
                    local name = GoodsConfMgr:GetInstance():GetGoodsVoById(antiqueId).name
                    txtTips = antiqueId == finalAntiqueId and localize("合成《_name_》后解锁", {_name_ = name}) or localize("修复《_name_》后解锁", {_name_ = name})
                else
                    isShowTips = false
                end
                -- 合成XXXX后解锁
            --- 通关到 获得古物但未修复时地图组  需要检查是否解锁了古物 未解锁不能进
            elseif groupId == mapConfData.groupTwo then
                --- 配0相当于 全通关 不能进去
                if mapConfData.groupThree == 0 then
                    txtTipsStatus = 4
                else
                    ---@type MapDecryptionAntiqueRestorationEntity[]
                    local antiqueEntityList = component:GetAntiqueEntityList()
                    local isUnlockAntique   = false
                    local antiqueId = mapConfData.antiqueId
                    ---@type MapDecryptionAntiqueRestorationVo
                    local vo
                    for index, value in ipairs(antiqueEntityList) do
                        if value.antiqueId == antiqueId then
                            isUnlockAntique = value.status == 2
                            vo = value.antiqueRestorationVo
                            break
                        end
                    end
                    isShowTips = not isUnlockAntique
                    if isShowTips and vo then
                        txtTips = localize("修复《_name_》后解锁", {_name_ = vo.name})
                    end
                end
            elseif groupIdStr ~= nil and groupId == mapConfData.groupThree then
                txtTipsStatus = 4
            else
                isShowTips = false
            end

            -- if      mapPassedInfoEnt ~= nil 
            --     and mapPassedInfoEnt == Maze2DStates.lastChapterIds[exploreIndexStr]
            -- then 
            --     txtTipsStatus = 4 
            -- else 
            --     print("currentMapId----...")
            --     isShowTips = false
            --     txtTipsStatus = nil
            -- end 
        end 
    end 


    --local isShowTips = isTimeEnd or not isUnlock
    KTool.SetActive(self.FontStyleButton.gameObject, not isShowTips)
    KTool.SetActive(self.TxtTips.gameObject, isShowTips)

    if txtTips then
        self.TxtTips.text = txtTips
    elseif isShowTips then
        --self.TxtTips.Status = isTimeEnd and 2 or 1
        assert( not isNull(txtTipsStatus) )
        --print( "txtTipsStatus = " .. txtTipsStatus )
        if self.TxtTips.Status == txtTipsStatus then
            self.TxtTips:Reset()
        else
            self.TxtTips.Status = txtTipsStatus
        end
    end

end

function MapDecryptionExplorePanel:FreshCountDown(seconds)
    self:RegEventTimeChanged()
    KTool.SetActive(self.FontStyleButton.gameObject, false)
    KTool.SetActive(self.TxtTips.gameObject, true)
    local realSeconds = seconds * -1
    self.TxtTips.text = localize("距离开放：_num_", {_num_ = CfUtils.GetTimeHMS(realSeconds)})

end
function MapDecryptionExplorePanel:RegEventTimeChanged()
    if self.__EventTimeChange then
        return
    end
    self.__EventTimeChange = Events.AddListener(MapDecryptionConstants.EventNames.TimeChanged, function ()
        if self:FreshBottom() then
            self:UnRegEventTimeChanged()
            self:RefreshUI()
        end
    end)
end
function MapDecryptionExplorePanel:UnRegEventTimeChanged()
    if self.__EventTimeChange == nil then
        return
    end
    Events.RemoveListener(MapDecryptionConstants.EventNames.TimeChanged, self.__EventTimeChange)
    self.__EventTimeChange = nil
end

--- FreshListGroup
---@param exploreDataEntity MapDecryptionExploreDataEntity
function MapDecryptionExplorePanel:FreshListGroup(exploreDataEntity)
    
    ---@type MapDecryptionExploreTaskEntity[]
    local taskEntityList = exploreDataEntity.taskEntityList
    local mapId = exploreDataEntity.mapConfData.id
    self._taskEntityList = taskEntityList
    local parent         = self.ListGroup
    local childCount     = parent.childCount
    for i, v in ipairs(taskEntityList) do
        if i > childCount then
            break
        end
        local taskNode = self._taskNodes[i]
        if taskNode == nil then
            taskNode = parent:GetChild(i - 1)
            tInsert(self._taskNodes, taskNode)
        end

        ---@type MapDecryptionExplorePanelListCell
        local env = CfUtils.GetLuaScr(taskNode, MapDecryptionConstants.EnvPath.ExplorePanelListCell)
        if not isNull(env) then
            env:FreshUI(v, mapId)
        end
    end
end

function MapDecryptionExplorePanel:FreshSelectState(exploreIndex, isSelect, isLock)
    local go = self._exploreNodes[exploreIndex]
    ---@type MapDecryptionMapExploreNode
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.MapExploreNode)
    if not isNull(env) then
        env:FreshSelectState(isSelect)
    end
end

function MapDecryptionExplorePanel:RefreshUI()
    MapDecryptionMgr:RequestHome()
    self:StopHomeRequestCo()
    self._homeRequestCo = CoStart(function() 
        local CoYield = CoYield
        while not MapDecryptionMgr:GetIsRequestHomeComplete() do 
            CoYield()
        end
        ---@type MapDecryptionComponent
        local component            = MapDecryptionMgr:GetComponent()
        self._exploreDataEntityList = component:GenerateExploreDataEntityList()

        for i, entity in ipairs(self._exploreDataEntityList) do
            local go = self._exploreNodes[i]
            self:FreshExploreNode(go, entity, self._exploreIndex == i, i)
            if self._exploreIndex == i then
                self:FreshFinalRewardShowStatus(entity) -- 只有用户选中的那个 迷宫ui 才会调用
            end
        end
        self._homeRequestCo = nil

    end)
end
function MapDecryptionExplorePanel:StopHomeRequestCo()
    if isNull(self._homeRequestCo) then
        return
    end
    CoStop(self._homeRequestCo)
    self._homeRequestCo = nil
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


function MapDecryptionExplorePanel:OnClickBtnTrackingAction()
    local MapDecryptionConstants = MapDecryptionConstants
    Events.Broadcast(MapDecryptionConstants.EventNames.SwitchExploreOrTracking, MapDecryptionConstants.ExploreTrackingSubViewType.Tracking)
end


-- 点击 "探索" 按钮, 进入迷宫场景
function MapDecryptionExplorePanel:OnClickFontStyleButtonAction()
    UIRaycastBlocker:AddCondition("MapDecryptionExplorePanel.enterExploreMap")
    
    cs_coroutine.start(function ()
        --print( "tpr - 进入望月城: MapDecryptionExplorePanel:OnClickFontStyleButtonAction" )
        UIRaycastBlocker:RemoveCondition("MapDecryptionExplorePanel.enterExploreMap")
        -- local sceneManagement = SceneManagement:GetInstance()
        -- sceneManagement:AppendScene(Constants.IdSceneSetting39, true)   
        ---@type MapDecryptionExploreDataEntity
        local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]
        ---@type MapDecryptionDecryptedMapsVo
        -- "解密地图表.cvs"
        local mapConfData = exploreDataEntity.mapConfData
        local sceneId_2d     = mapConfData.sence -- 39, 场景的序号
        KCookie.Set(MapDecryptionConstants.EventNames.ExploreMapId, mapConfData.id)

        ---@type MapDecryptionComponent
        local component = MapDecryptionMgr:GetComponent()

        ---@type ActivityDojo
        local activityData = component:GetActivityData()

        local activityContentId = MapDecryptionMgr:GetActivityData().activityContentId
        ---@type MapDecryptionPlanVo
        local planVo = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
        local sceneId_3d = planVo.sceneId -- "37"


        -- =====================================
        -- debug 用, 用来清空存档
        local isCleanData = true
        isCleanData = false


        if isCleanData then
            -- todo: debug:  清空 2d迷宫存档数据; 未来要禁用
            cs_coroutine.yield_return( self:CallServerClearMap() )
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
            cs_coroutine.yield_return( self:CallServerClearMap() )
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
            return
        end


        -- ================ ActivityMapDecryption/home ====================
        ---@type MapDecryptionDojo
        local mapDecryptionHomeDatas = component:GetMapDecryptionDojo()

        local playerMapDecryption = mapDecryptionHomeDatas.playerMapDecryption 
        assert( not isNull(playerMapDecryption) )
        
        -- =====================================
        local groupId = nil
        local isFindNewMap = false -- 当第一次进入 "101", "201"... 时, 此值为 true

        local tmpCurrentGroupId = checkString(playerMapDecryption.currentGroupId)
        
        if     tmpCurrentGroupId == '' 
            or tmpCurrentGroupId == "0" -- "0" 表示 "此时未在探索任何一个章节"
        then 
            -- 当第一次进入某张 map 时, currentGroupId 为空, 此时要调用后端的 enterMap() 函数
            print( "tpr == 第一次进入 map, currentGroupId 为空, 需调用后端的 enterMap() 函数" )

            GameUtils.Request(
                Interfaces.ActivityMapDecryptionEnterMap, 
                {
                    activityUuid = activityData.id,
                    mapId = exploreDataEntity.mapConfData.id
                }, 
                function(request, response)
                    if checkNumber(response.errCode) ~= 0 then 
                        printError( "没读取到 后端数据 - 2 -" )
                        return 
                    end
                    ----
                    local jsonData = response.data
                    assert( jsonData ~= nil )
                    assert( jsonData.currentGroupId ~= nil ) -- 是个 string, 如 "101"
                    print( "tpr -2- 成功执行 EnterMap, currentGroupId = " .. jsonData.currentGroupId ) -- 如 101
                    groupId = jsonData.currentGroupId
                    isFindNewMap = (checkInt(groupId) % 10) == 1
                end
            )
        else 
            -- 不是第一次进入某张 map, 可以从后端直接读取到 currentGroupId:
            print( "tpr == 不是第一次进入某张 map, 可以从后端直接读取到 currentGroupId = " .. tmpCurrentGroupId )
            groupId = tmpCurrentGroupId
        end 
        
        --- 等待上述 EnterMap() 调用完成:
        while isNull(groupId) do
            coroutine.yield(Yielders.EndOfFrame)
        end 

        groupId = tostring( groupId ) -- "101", "102" 这种

        -- 暂存 2D迷宫 公共数据:
        Maze2DStates.mapId   = tostring( exploreDataEntity.mapConfData.id )
        Maze2DStates.groupId = groupId
        Maze2DStates.mapDecryptionHomeDatas = mapDecryptionHomeDatas
        Maze2DStates.isFindNewMap = isFindNewMap
        --Maze2DStates.isInFirstGroup = (checkInt(groupId) % 10) == 1
        --Maze2DStates.isInLastGroup = (groupId=="103" or groupId=="203" or groupId=="303" or groupId=="402")

        local isInLastGroup = false 
        for _,lastId in pairs(Maze2DStates.lastChapterIds) do 
            if groupId == lastId then 
                isInLastGroup = true
                break
            end
        end
        Maze2DStates.isInLastGroup = isInLastGroup


        -- ========================= 正式切换到 2D迷宫 场景 =================================
        MazeLoadScene:LoadSceneTo2DMaze( sceneId_3d, sceneId_2d )
        while MazeLoadScene.isLoadFinished == false do
            cs_coroutine.yield_return()
        end

    end)
    
end



-- todo: 临时测试用:
-- 调用后端 ActivityMapDecryption/quitMap（退出地图)
function MapDecryptionExplorePanel.CallServerQuitMap()

    ---@type MapDecryptionComponent
    local mapDecryptionComponent = MapDecryptionMgr:GetComponent()

    local isRet = false

    UIRaycastBlocker:AddCondition("MapDecryptionExplorePanel.quitMap")    
    cs_coroutine.start(function()
        UIRaycastBlocker:RemoveCondition("MapDecryptionExplorePanel.quitMap")

        ---@type ActivityDojo
        local activityData = mapDecryptionComponent:GetActivityData()
        
        GameUtils.Request(
            Interfaces.ActivityMapDecryptionQuitMap, 
            {
                activityUuid = activityData.id,
            }, 
            function(request, response)
                if checkNumber(response.errCode) ~= 0 then 
                    printError( "没读取到 后端数据 ActivityMapDecryption/quitMap " )
                    return 
                end
                ----
                isRet = true
            end
        )
    end)
    ---
    while isRet == false do
        coroutine.yield(Yielders.EndOfFrame)
    end
end




-- 测试用
-- 清空本账号的全部 2d迷宫 存档数据
function MapDecryptionExplorePanel:CallServerClearMap()

    local isRet = false

    UIRaycastBlocker:AddCondition("MapDecryptionExplorePanel.clearMap")   
    cs_coroutine.start(function()
        UIRaycastBlocker:RemoveCondition("MapDecryptionExplorePanel.clearMap")

        ---@type MapDecryptionComponent
        local component = MapDecryptionMgr:GetComponent()

        ---@type ActivityDojo
        local activityData = component:GetActivityData()
        
        GameUtils.Request(
            Interfaces.ActivityMapDecryptionClearMap, 
            {
                activityUuid = activityData.id,
            }, 
            function(request, response)
                if checkNumber(response.errCode) ~= 0 then 
                    printError( "没读取到 后端数据 RecordMap - 3 -" )
                    return 
                end
                ----
                isRet = true
            end
        )
    end)

    -- 等待调用完成
    while isRet == false do 
        coroutine.yield(Yielders.EndOfFrame)
    end 

    -- 适当等两帧:
    coroutine.yield(Yielders.EndOfFrame)
    coroutine.yield(Yielders.EndOfFrame)

    print( "tpr =7= clearMap 已完成" )
end




function MapDecryptionExplorePanel:OnClickBtnRewardAction()
    ---@type MapDecryptionExploreDataEntity
    local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]

    local ReceiveStatus = MapDecryptionConstants.ReceiveStatus
    if exploreDataEntity.status ~= ReceiveStatus.CanReceive then
        local decryptedMapVo = exploreDataEntity.mapConfData
        local rewards  = decryptedMapVo.rewards
        local reward   = table.takeFirst(rewards) or {}
        local goodsId  = reward.goodsId
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        GameUtils.ShowCommonTipsBoard(self.BtnReward, vo.name, vo.desc, vo.quality, vo.id, true)
        return
    end

    MapDecryptionMgr:RequestDrawFinallyTask(exploreDataEntity.mapConfData.id)

end

function MapDecryptionExplorePanel:OnRequestSuccess(requestPath, ...)
    if requestPath == Interfaces.ActivityMapDecryptionDrawFinallyTask then
        self:HandleDrawFinallyTask(...)

    elseif requestPath == Interfaces.ActivityMapDecryptionDrawTask then
        self:HandleDrawTask(...)
    end
    
end

function MapDecryptionExplorePanel:HandleDrawFinallyTask(taskId, mapId)
    ---@type MapDecryptionExploreDataEntity
    local exploreDataEntity = self._exploreDataEntityList[self._exploreIndex]
    local ReceiveStatus = MapDecryptionConstants.ReceiveStatus
    -- 更新本地数据
    exploreDataEntity.status = ReceiveStatus.Received   
    --- 更新UI
    self:FreshFinalRewardShowStatus(exploreDataEntity)
end

function MapDecryptionExplorePanel:HandleDrawTask(taskId)
    for i, v in pairs(self._taskEntityList) do
        if v.taskId == taskId then
            v.status = MapDecryptionConstants.ReceiveStatus.Received
            local taskNode = self._taskNodes[i]
            ---@type MapDecryptionExplorePanelListCell
            local env = CfUtils.GetLuaScr(taskNode, MapDecryptionConstants.EnvPath.ExplorePanelListCell)
            if not isNull(env) then
                env:FreshUI(v)
            end

            break
        end
    end

end

--- OnClickExploreNodeAction
---@param entity MapDecryptionExploreDataEntity
---@param exploreIndex number
---@param nodeEnv MapDecryptionMapExploreNode
function MapDecryptionExplorePanel:OnClickExploreNodeAction(entity, exploreIndex, nodeEnv)
    if self._exploreIndex == exploreIndex then return end 
    local oldExploreIndex = self._exploreIndex
    self._exploreIndex = exploreIndex

    nodeEnv:FreshSelectState(true, entity.isUnlock == 0)
    self:FreshSelectState(oldExploreIndex, false)
    self:FreshUI()

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionExplorePanel
