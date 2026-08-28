
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
local CoYield   = CoYield
local CoStart   = CoStart
local CoStop   = CoStop
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
local URPCameraController = CS.Game.Native.URP.URPCameraController
---@type Engine.UI.UIModule
local UIModule = CS.Engine.UI.UIModule
--endregion

--region define

local ViewState = {
    MainPage       = 1, --- 主页
    FeedPage       = 2, --- 喂食界面
    SelectCardPage = 3, --- 选择卡牌界面
}
local cs_coroutine        = require('XLua.cs_coroutine')
---@type MaidCoffeeConstants
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
local ControllerNode      = import(MaidCoffeeConstants.EnvPath.OverseaManageLoungeControllerNode)

---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()

local CanvasType        = typeof(CS.UnityEngine.Canvas)
local UISwitchImageType = typeof(CS.Game.Native.Common.UISwitchImage)

local RoomNumberInto           = "OverManegeLoungeMainDialog_RoomNumber_Into"
local RoomNumberOut            = "OverManegeLoungeMainDialog_RoomNumber_Out"

local BtnFishAll_Normal        = "OverManegeLoungeMainDialog_BtnFishAll_Normal"
local BtnFishAll_Activate      = "OverManegeLoungeMainDialog_BtnFishAll_Activate"

local BtnStartAllRoot_Normal   = "OverManegeLoungeMainDialog_BtnStartAllRoot_Normal"
local BtnStartAllRoot_Activate = "OverManegeLoungeMainDialog_BtnStartAllRoot_Activate"
--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverManegeLoungeMainDialog.prefab
---@class OverManegeLoungeMainDialog
---@field Env                           	OverManegeLoungeMainDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CatTouchNodes                 	UnityEngine.RectTransform               
---@field LoungeSelectCardsNode         	UnityEngine.RectTransform               
---@field LoungeFeedNodes               	UnityEngine.RectTransform               
---@field BtnStartAll_Root              	UnityEngine.Animation                   
---@field BtnStartAll                   	UnityEngine.RectTransform               
---@field BtnFinishAll_Root             	UnityEngine.Animation                   
---@field BtnFinishAll                  	UnityEngine.RectTransform               
---@field BtnFeed                       	UnityEngine.RectTransform               
---@field BtnStaff                      	UnityEngine.RectTransform               
---@field RightPanel                    	UnityEngine.RectTransform               
---@field Lounge                        	UnityEngine.Animation               
---@field StatusRoom                    	UnityEngine.RectTransform               
---@field ImgRing                       	Game.Native.Common.UISwitchImage        
---@field TextNumberRoom                	TMPro.TextMeshProUGUI                   
---@field BtnChange                     	UnityEngine.RectTransform               
---@field LeftPanel                     	UnityEngine.RectTransform               
---@field TagUp                         	UnityEngine.RectTransform               
---@field CatLoungeContent              	UnityEngine.RectTransform       
local OverManegeLoungeMainDialog = Class('OverManegeLoungeMainDialog')


function OverManegeLoungeMainDialog:__init()
    self._viewState = ViewState.MainPage
    ---@type OverseaManageLoungeControllerNode
    self._controllerNode = ControllerNode.New()
    ---@type OverManegeLoungeDataProvider
    self._dataProviderIns = self._controllerNode:GetDataProviderIns()

    self._isExpandRoom   = false
    self._isDetail       = false
    self._statusRooms    = {}
    self._loungeNodeEnvs = {}
    self._cardDetailEnvs = {}
    self._catTouchNodes  = {}
    self._selectLoungeIndex = nil
end


function OverManegeLoungeMainDialog:__delete()
    self.controller = nil
end


function OverManegeLoungeMainDialog:Awake()
end


function OverManegeLoungeMainDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:CreateCoShow()
        GameUtils.ShowBlackOverlay(nil,  function()
            while self._coShow ~= nil do
                cs_coroutine.yield_return()
            end
        end)
        
    end))
    return coWait
end

function OverManegeLoungeMainDialog:OnFocus(focus)

    self._focus = focus
    if focus then
        CfUtils.SetTopCommonCb(function(isMulti)
            if self._viewState ~= ViewState.MainPage then
                self:FreshUI(false, ViewState.MainPage)
                return
            end
            ---如果再记录中未找到 咖啡厅主界面 则不处理等待
            local res      = UIModule.HasTopPageHaveRecord(Constants.UITypeIds.UIMaidCoffeeManagerDialog)
            CfUtils.DialogBack()
            local WaitFunc = function()
                if not res then
                    return
                end
                local isSuccess = self:GetCafeIsLoadSuccess()
            
                local time = os.time()
                while not isSuccess do
                    isSuccess = self:GetCafeIsLoadSuccess()
                    cs_coroutine.yield_return()
                    if (os.time() - time) > 3 then
                        isSuccess = true
                    end
                end
            end

            if not isMulti then
                GameUtils.ShowBlackOverlay(nil,  WaitFunc)
            else
                WaitFunc()
            end
            

        end)
        if self._coShow == nil and self._dataProviderIns:GetIsLoadSceneComplete() then
            self:FreshCamera(self._viewState)
        end
        self:SetCanvasShowState(true)
    else
        CfUtils.ResetNavigatorCustomBackAction()
        self:SetCanvasShowState(false)
    end
end


-- function OverManegeLoungeMainDialog:OnShow()
   

-- end

function OverManegeLoungeMainDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:StopCoShow()
        for i, v in pairs(self._listenerConf) do
            Events.RemoveListener(i, v)
        end
        CfUtils.SetActive(self.RootGo, false)
        if self._controllerNode then
            self._controllerNode:OnDestroy()
            self._controllerNode = nil
        end
        -- self._coHide = CoStart(function() 
        --     CfUtils.CookieSave("IsCafeLoadSuccess", 0)
        --    
        --     while not self:GetCafeIsLoadSuccess() do
        --         CoYield()
        --     end
            
        --     self._coHide = nil
        -- end)
    end))
    return coWait

    
end


function OverManegeLoungeMainDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._isFinalized = true
        -- while self._coHide ~= nil do
        --     CoYield()
        -- end
    
        -- self:DestroyControllerNode()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end

function OverManegeLoungeMainDialog:DestroyControllerNode()
    if self._controllerNode == nil then
        return
    end
    self._controllerNode:OnDestroy()
    self._controllerNode = nil
end


--region init 

function OverManegeLoungeMainDialog:OnInit()
    self:InitScene()
    self:RequestHome()
    self:InitData()
    self:InitUI()
    self:InitListeners()
end

function OverManegeLoungeMainDialog:InitScene()
    self._controllerNode:Awake()
    self._controllerNode:ShowLoungeScene()
end

function OverManegeLoungeMainDialog:InitUI()
    self.RootGo = self.controller.transform:Find("Root").gameObject
    ---@type UnityEngine.Canvas
    self._canvas = self.controller.gameObject:GetComponent(CanvasType)
    self.TextNumberRoom.text = 1
end

function OverManegeLoungeMainDialog:InitListeners()
    local Bind            = Bind
    local Events          = Events
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnStartAll,  Bind(self, self.OnClickBtnStartAllAction))
    SetButtonAction(self.BtnFinishAll, Bind(self, self.OnClickBtnFinishAllAction))
    SetButtonAction(self.BtnFeed,      Bind(self, self.OnClickBtnFeedAction))
    SetButtonAction(self.BtnStaff,     Bind(self, self.OnClickBtnStaffAction))
    SetButtonAction(self.BtnChange,    Bind(self, self.OnClickBtnChangeAction))
    
    self._listenerConf = {
        [MaidCoffeeConstants.EventNames.LoungeRequestSuccess]       = Bind(self, self.OnEventLoungeRequestSuccess),
        [MaidCoffeeConstants.EventNames.LoungeShowTagNode]          = Bind(self, self.OnEventLoungeShowTagNode),
        [MaidCoffeeConstants.EventNames.LoungeCardEnergyTimeChange] = Bind(self, self.OnEventTimeChange),
        [MaidCoffeeConstants.EventNames.LoungeHitCat]               = Bind(self, self.OnEventHitCat),
        [MaidCoffeeConstants.EventNames.LoungeSwitchLounge]         = Bind(self, self.OnClickLoungeNodeAction),
        [MaidCoffeeConstants.EventNames.MaidCoffeeLoungeRoleChange] = Bind(self, self.OnSelectRoleChange),
        -- [Constants.EventNames.ExecuteBackHome]                      = Bind(self, self.OnBackToMainScene),
    }
    for eventName, func in pairs(self._listenerConf) do
        Events.AddListener(eventName, func)
    end
end

function OverManegeLoungeMainDialog:InitData()
    local parameters = self.controller.Argument.parameters
    self._selectLoungeIndex = parameters.selectLoungeIndex or 1
    
end

function OverManegeLoungeMainDialog:CreateCoShow()
    self._coShow = CoStart(function() 
        while not self._dataProviderIns:GetIsLoadSceneComplete() or not self._dataProviderIns:GetIsRequestHomeComplete() do
            CoYield()
        end
        
        self:FreshUI(true)
        self._coShow = nil
    end)
end
function OverManegeLoungeMainDialog:StopCoShow()
    if isNotNull(self._coShow) then
        CoStop(self._coShow)
        self._coShow = nil
    end
end



--endregion 


--region logic 

function OverManegeLoungeMainDialog:FreshCamera(viewState)
    local dataProviderIns     = self._dataProviderIns
    if viewState == ViewState.FeedPage then
        local cameraLocation      = dataProviderIns:GetCamLoc()
        local transform           = URPCameraController.Instance.mainCamera.transform
        transform.localPosition   = cameraLocation.localPosition
        transform.localRotation   = cameraLocation.localRotation
        
    elseif viewState == ViewState.MainPage then
        local cameraOriginLocation = dataProviderIns:GetCamOriginLoc()
        if isNull(cameraOriginLocation) then
            return
        end
        local transform           = URPCameraController.Instance.mainCamera.transform
        transform.localPosition   = cameraOriginLocation[1]
        transform.localRotation   = cameraOriginLocation[2]
    end
    
end

function OverManegeLoungeMainDialog:FreshUI(isInit, viewState)
    viewState = viewState or self._viewState
    if not isInit then
        if viewState == ViewState.FeedPage then
            viewState = self:FixViewState(viewState)
        end
    end
    local isChangeViewState = viewState ~= self._viewState
    local isFeedPage   = viewState == ViewState.FeedPage
    local isMainPage   = viewState == ViewState.MainPage
    local isSelectCard = viewState == ViewState.SelectCardPage
    self._viewState    = viewState
    
    CfUtils.SetActive(self.LeftPanel.gameObject, isMainPage)
    CfUtils.SetActive(self.RightPanel.gameObject, isMainPage)
    CfUtils.SetActive(self.CatLoungeContent.gameObject, not isSelectCard)
    
    self._isDetail = isFeedPage

    if isInit or isChangeViewState then
        self:FreshCamera(viewState)
    end
    self:FreshCatLoungeContent(isInit, isChangeViewState)
    
    if isMainPage then
        self:FreshBtnChange()
        self:FreshLoungeNodes()
        self:FreshBtnFinishAll_Root()
        self:FreshBtnStartAll_Root()
        
    end
    if not isInit then
        CfUtils.SetActive(self.TagUp.gameObject, isFeedPage or isSelectCard)
        CfUtils.SetActive(self.LoungeFeedNodes.gameObject, isFeedPage)
        self:FreshTagNode(isFeedPage or isSelectCard, isChangeViewState)
        -- self:FreshSelectCardsNode()
        self:FreshFeedNodes(isFeedPage, isChangeViewState)
    end
end

function OverManegeLoungeMainDialog:FixViewState(viewState)
    local dataProviderIns = self._dataProviderIns
    local loungeData      = dataProviderIns:GetLoungeDataByIndex(self._selectLoungeIndex)
    local playerCardIds   = loungeData.playerCardIds
    local isFix           = true
    for i, v in ipairs(playerCardIds) do
        if v > 0 then
            isFix = false
            break
        end
    end
    if isFix then
        return ViewState.MainPage
    end
    return viewState
end


---FreshCatLoungeContent
---刷新上阵的猫内容
function OverManegeLoungeMainDialog:FreshCatLoungeContent(isInit, isChangeViewState)
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    Events.Broadcast(MaidCoffeeConstants.EventNames.LoungeCatLoader, dataProviderIns:GetLoungeCardSkinsByIndex(loungeIndex))
    
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local playerCardIds      = loungeData.playerCardIds
    local parent             = self.CatLoungeContent
    for i, playerCardId in ipairs(playerCardIds) do
        ---@type OverManegeLoungeCardDetailsNode
        local env = self._cardDetailEnvs[i]
        if isNull(env) then
            local node         = parent:GetChild(i - 1)
            env = CfUtils.GetLuaScr(node, MaidCoffeeConstants.EnvPath.OverManegeLoungeCardDetailsNode)
            self._cardDetailEnvs[i] = env
        end

        if isInit or isChangeViewState then
            local offsetY = 80
            ---@type UnityEngine.GameObject
            local locationNode = dataProviderIns:GetCatLocationNodes()[i]
            ---@type UnityEngine.Transform
            local transform    = locationNode.transform
            local position     = transform.position
            local uiPosition   = CfUtils.WorldPosition2UIPosition(position, parent)
            env.controller.transform.anchoredPosition = Vector2.New(uiPosition.x, uiPosition.y + offsetY)
            self:FreshCatTouchPosition(position, i, offsetY)
        end

        if not isNull(env) then
            local cardInfo = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
            env:FreshUI(cardInfo, self._isDetail, isInit, loungeIndex)
        end
    end
end

---FreshCatTouchPosition
---刷新猫触摸坐标
function OverManegeLoungeMainDialog:FreshCatTouchPosition(position, i, offsetY)
    local parent = self.CatTouchNodes
    local node   = self._catTouchNodes[i]
    if isNull(node) then
        node = parent:Find(string.format("Node%s", i))
        SetButtonAction(node, function()
            if self._viewState ~= ViewState.MainPage then
                return
            end
            
            local dataProviderIns = self._dataProviderIns
            local loungeIndex     = self._selectLoungeIndex
            local loungeData      = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
            local playerCardId    = loungeData.playerCardIds[i]
            local cardInfo        = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
            if cardInfo == nil then
                return
            end

            -- self:SetCanvasShowState(false)
            
            CfUtils.DialogOpen(Constants.UITypeIds.OverManegeLoungeStrokeDialog, {loungeIndex = self._selectLoungeIndex, cardIndex = i, playerCardId = playerCardId})
            
        end)
        self._catTouchNodes[i] = node
    end
    local uiPosition   = CfUtils.WorldPosition2UIPosition(position, parent)
    node.anchoredPosition = Vector2.New(uiPosition.x, uiPosition.y + offsetY)
    
end

---FreshBtnChange
---刷新房间入口
function OverManegeLoungeMainDialog:FreshBtnChange()
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    
    self.TextNumberRoom.text = loungeIndex
    self.ImgRing.Status      = self._isExpandRoom and 2 or 1
    
    local parent             = self.StatusRoom
    local playerCardIds      = loungeData.playerCardIds
    for i, playerCardId in ipairs(playerCardIds) do
        local statusRoom = self._statusRooms[i]
        if isNull(statusRoom) then
            local child = parent:GetChild(i - 1)

            ---@type Game.Native.Common.UISwitchImage
            statusRoom = child.gameObject:GetComponent(UISwitchImageType)
            self._statusRooms[i] = statusRoom
        end

        statusRoom.Status = dataProviderIns:GetLoungeCardStatus(playerCardId)

    end
    
end

---FreshLoungeNodes
---刷新所有休息室
function OverManegeLoungeMainDialog:FreshLoungeNodes()
    local dataProviderIns = self._dataProviderIns
    local loungeNodeEnvs = self._loungeNodeEnvs
    local parent         = self.Lounge.transform
    local maxLoungeCount = dataProviderIns:GetMaxLoungeCount()
    local forTimes = math.max(parent.childCount, maxLoungeCount)
    for i = 1, forTimes do
        ---@type OverManageBigBtnLoungeNode
        local loungeNodeEnv = loungeNodeEnvs[i]
        local isInit = isNull(loungeNodeEnv) 
        if isInit then
            local loungeNode = parent:Find(string.format("BtnLounge%s/BigBtnLoungeNode", i))
            local isShow = i <= maxLoungeCount
            CfUtils.SetActive(loungeNode.gameObject, i <= maxLoungeCount)
            if isShow then
                ---@type OverManageBigBtnLoungeNode
                loungeNodeEnv = CfUtils.GetLuaScr(loungeNode, MaidCoffeeConstants.EnvPath.OverManageBigBtnLoungeNode)
                loungeNodeEnvs[i] = loungeNodeEnv
            end
        end

        if not isNull(loungeNodeEnv) then
            local loungeData = dataProviderIns:GetLoungeDataByIndex(i)
            if isInit then
                loungeNodeEnv:InitUI(loungeData, i, i == self._selectLoungeIndex)
                loungeNodeEnv:SetCallback(Bind(self, self.OnClickLoungeNodeAction))
            else
                loungeNodeEnv:FreshUI(loungeData, i == self._selectLoungeIndex)
            end
            
        end
        
    end

end


---FreshBtnFinishAll_Root
---刷新一键外出动画
function OverManegeLoungeMainDialog:FreshBtnFinishAll_Root()
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)

    local isCanActive = false
    local playerCardIds = loungeData.playerCardIds
    for i, playerCardId in ipairs(playerCardIds) do
        if playerCardId > 0 then
            local cardInfo = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
            if checkNumber(cardInfo.cafeEnergy) >= cardInfo.maxEnergy then
                isCanActive = true
                break
            end
        end
    end
    
    self.BtnFinishAll_Root:Play(isCanActive and BtnFishAll_Activate or BtnFishAll_Normal)
end

---FreshBtnStartAll_Root
---刷新快速休息动画
function OverManegeLoungeMainDialog:FreshBtnStartAll_Root()
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local loungeCapacity     = dataProviderIns:GetLoungeCapacity()
    local cardCount          = loungeData.cardCount

    local cards = dataProviderIns:GetCards()
    local isActive = false
    if cardCount < loungeCapacity and next(cards) ~= nil then
        ---@param cardDojo CardDojo
        for i, cardDojo in ipairs(cards) do
            local maxEnergy = cardConfMgr:GetCardMoodByCardIdLevel(cardDojo.cardId, cardDojo.favorabilityLevel)
            if (cardDojo.cafeStatus == MaidCoffeeConstants.CafeStatus.Non)
                    and cardDojo.cafeEnergy < maxEnergy then
                isActive = true
                break
            end
        end
    end
    
    self.BtnStartAll_Root:Play(isActive and BtnStartAllRoot_Activate or BtnStartAllRoot_Normal)
    
end

function OverManegeLoungeMainDialog:FreshTagNode(isFeedPage, isChangeViewState)
    ---@type OverManegeLoungeTagNode
    local env = CfUtils.GetLuaScr(self.TagUp, MaidCoffeeConstants.EnvPath.OverManegeLoungeTagNode)
    if not isNull(env) then
        env:FreshUI(isFeedPage, self._selectLoungeIndex, isChangeViewState)
    end
end

function OverManegeLoungeMainDialog:FreshFeedNodes(isFeedPage, isChangeViewState)
    ---@type OverManegeLoungeFeedNodes
    local env = CfUtils.GetLuaScr(self.LoungeFeedNodes, MaidCoffeeConstants.EnvPath.OverManegeLoungeFeedNodes)
    if not isNull(env) then
        env:InitDragResponseRegion(self._catTouchNodes)
        env:FreshUI(isFeedPage, isChangeViewState, self._selectLoungeIndex)
    end
end

---FreshRoomFeedEffect
---刷新房间内猫的喂食效果
function OverManegeLoungeMainDialog:FreshRoomFeedEffect(playerCardId2Feed, isStroke)
    if isStroke then
        return
    end
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local playerCardIds      = loungeData.playerCardIds
    for catIndex, playerCardId in ipairs(playerCardIds) do
        if playerCardId2Feed[playerCardId] then
            ---@type OverManegeLoungeCardDetailsNode
            local env = self._cardDetailEnvs[catIndex]
            if not isNull(env) then
                env:FreshFeedEffectShowState(true)
            end
        end
    end
end


--endregion 


--region Request


function OverManegeLoungeMainDialog:RequestHome()
    local dataProviderIns = self._dataProviderIns
    dataProviderIns:RequestHome()
end


function OverManegeLoungeMainDialog:RequestLoungeUpdate(roomId2CardIds, isFinishAl)
    local dataProviderIns = self._dataProviderIns
    dataProviderIns:RequestLoungeUpdate(roomId2CardIds, isFinishAl)
end

--endregion

--region get/set 


function OverManegeLoungeMainDialog:SetCanvasShowState(isShow)
    self._canvas.enabled = isShow
end

function OverManegeLoungeMainDialog:GetCafeIsLoadSuccess()
    local num = CfUtils.CookieLoad("IsCafeLoadSuccess")
    local isSuccess = checkNumber(num) == 1
    return isSuccess
end

---endregion 


--region handler 

function OverManegeLoungeMainDialog:OnClickBtnStartAllAction()

    local dataProviderIns    = self._dataProviderIns
    -- local loungeIndex        = self._selectLoungeIndex
    -- local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local loungeCapacity     = dataProviderIns:GetLoungeCapacity()
    -- local cardCount          = loungeData.cardCount

    ---@type PlayerComponent
    local playerComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting4032, "WelfareSettingVo", 1)
    local isHavePrivilegeCard = playerDojo:IsHavePrivilegeCardById(tonumber(vo.giftId))
    -- if loungeData.vip and not isHavePrivilegeCard then
    --     GameUtils.Toast(localize("当前特权卡已过期"))
    --     return
    -- end
    
    -- if cardCount >= loungeCapacity then
    --     GameUtils.Toast(localize("当前所有房间已满员"))
    --      return
    -- end

    local cards = dataProviderIns:GetCards()
    if next(cards) == nil then
        GameUtils.Toast(localize("暂无需要休息的员工"))
        return
    end
    
    local ids           = {}
    SortByMember(cards, "cafeEnergy", true)

    local cardCount = 0
    local maxLoungeCapacity = loungeCapacity * table.count(dataProviderIns:GetLoungeInfo())
    local isChange = false
    --local limitStatus2Status = MaidCoffeeUtils.GetMaidCoffeeCardStatusLimit(MaidCoffeeConstants.CafeStatus.Resting)
    ---@param cardDojo CardDojo 
    for i, cardDojo in ipairs(cards) do
        local maxEnergy = cardConfMgr:GetCardMoodByCardIdLevel(cardDojo.cardId, cardDojo.favorabilityLevel)
        --- 卡牌处于无状态并且心情值不是最大心情
        if (cardDojo.cafeStatus == MaidCoffeeConstants.CafeStatus.Non and cardDojo.cafeEnergy < maxEnergy) or
        --- 卡牌处于工作中并且心情值小于等于0
            ((cardDojo.cafeStatus == MaidCoffeeConstants.CafeStatus.UnderManagement or cardDojo.cafeStatus == MaidCoffeeConstants.CafeStatus.InService) and cardDojo.cafeEnergy <= 0)
                 then
            cardCount = cardCount + 1
            isChange = true
            -----如果这里有在编队中的卡牌的时候  要从编队中拿掉
            ---@type MaidCoffeePlayerComponent
            local maidCoffeePlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.MaidCoffeePlayerComponent)
            maidCoffeePlayerComponent:RemoveTeamsPlayerId(cardDojo.id)
            ---如果这个人在编队的缓存里面  要清掉
            local component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
            component:RemoveCacheDataById(cardDojo.id)

            table.insert(ids, cardDojo.id)
            if cardCount == maxLoungeCapacity then
                break
            end
        end
    end

    if not isChange then
        GameUtils.Toast(localize("暂无需要休息的员工"))
        return
    end
    -- and (loungeData.vip and isHavePrivilegeCard) or not loungeData.vip) 
    local rootId2CardIds = {}
    local isMaxMember = true
    local loungeInfo = dataProviderIns:GetLoungeInfo()
    local LoungeStatus = MaidCoffeeConstants.LoungeStatus
    local idIdx         = 1
    for key, loungeData in pairs(loungeInfo) do
        local loungeStatus = loungeData.loungeStatus
        if (loungeStatus == LoungeStatus.Unlock or loungeStatus == LoungeStatus.VipUnlock) and
            ((loungeData.vip and isHavePrivilegeCard) or not loungeData.vip)
         then
            
            local t             = {}
            local playerCardIds = loungeData.playerCardIds
            for i, playerCardId in ipairs(playerCardIds) do
                if playerCardId > 0 then
                    table.insert(t, playerCardId)
                else
                    table.insert(t, ids[idIdx] or 0)
                    idIdx = idIdx + 1
                    isMaxMember = false
                end
            end

            rootId2CardIds[loungeData.roomId] = t
        end
    end
    
    if isMaxMember then
        GameUtils.Toast(localize("当前所有房间已满员"))
    else
        self:RequestLoungeUpdate(rootId2CardIds)
    end
    
    
end

function OverManegeLoungeMainDialog:OnClickBtnFinishAllAction()
    local dataProviderIns    = self._dataProviderIns

    local isChange = false
    local roomId2CardIds = {}
    local loungeInfo = dataProviderIns:GetLoungeInfo()
    for key, loungeData in pairs(loungeInfo) do
        local t = {}
        local playerCardIds = loungeData.playerCardIds
        for i, playerCardId in ipairs(playerCardIds) do
            if playerCardId > 0 then
                local cardInfo = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
                if checkNumber(cardInfo.cardDojo.cafeEnergy) >= cardInfo.maxEnergy then
                    isChange = true
                    -- table.insert(changeIds, playerCardId)
                    table.insert(t, 0)
                else
                    table.insert(t, playerCardId)
                end
            else
                table.insert(t, playerCardId)
            end
        end
        roomId2CardIds[loungeData.roomId] = t
    end

    if not isChange then
        GameUtils.Toast(localize("该休息室暂无可出仓卡牌"))
        return
    end
    
    self:RequestLoungeUpdate(roomId2CardIds, true) 
end

function OverManegeLoungeMainDialog:OnClickBtnFeedAction()
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    if loungeData.cardCount <= 0 then
        GameUtils.Toast(localize("对应房间当前没有猫咪在休息"))
        return
    end
    
    self:FreshUI(false, ViewState.FeedPage)
end

function OverManegeLoungeMainDialog:OnClickBtnStaffAction()
    -- self:SetCanvasShowState(false)
    local dataProviderIns = self._dataProviderIns
    local loungeIndex     = self._selectLoungeIndex
    local haveData,roomId = dataProviderIns:GetLoungeSelectCardInfoByIndex(loungeIndex)

    ---@type MaidCoffeeComponent
    local component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
    component:SaveCacheData(haveData)

    CfUtils.DialogOpen(Constants.UITypeIds.UIMaidCoffeePersonSelectDialog, { type = MaidCoffeeConstants.SelectType.Lounge,index = roomId, data = haveData, cb = nil } )

end

function OverManegeLoungeMainDialog:OnClickBtnChangeAction()
    self._isExpandRoom = not self._isExpandRoom
    self.Lounge:Play(self._isExpandRoom and RoomNumberOut or RoomNumberInto)
end


function OverManegeLoungeMainDialog:OnClickLoungeNodeAction(index)
    if self._selectLoungeIndex == index then return end
    local dataProviderIns    = self._dataProviderIns
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(index)
    local loungeStatus       = loungeData.loungeStatus
    local isLock             = loungeStatus == MaidCoffeeConstants.LoungeStatus.Lock 
    if isLock then
        local text = string.isEmpty(loungeData.unlockDesc) and localize("该孵化室暂未解锁") or loungeData.unlockDesc
        GameUtils.Toast(text)
        return
    end
    
    local isLockVip          = loungeStatus == MaidCoffeeConstants.LoungeStatus.VipLock 
    if loungeData.cardCount <= 0 and isLockVip then
        local WelfareConstants = import("Game.UI.Welfare.WelfareConstants")
        UIModule.OpenDialog(
                { id = Constants.UITypeIds.UIWelfareMainDialog, parameters = {selectedIndex = WelfareConstants.OpenIds.SubScribe}})
        return
    end
    
    ---@type OverManageBigBtnLoungeNode
    local env                = self._loungeNodeEnvs[index]
    local loungeIndex        = self._selectLoungeIndex
    local oldLoungeData      = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    ---@type OverManageBigBtnLoungeNode
    local oldEnv             = self._loungeNodeEnvs[loungeIndex]
    
    oldEnv:FreshNodeStatus(oldLoungeData.loungeStatus, false)
    env:FreshNodeStatus(loungeData.loungeStatus, true)
    
    self._selectLoungeIndex = index
    
    self:FreshUI()
end


function OverManegeLoungeMainDialog:OnEventLoungeRequestSuccess(interface, ...)
    if interface == Interfaces.MaidCoffeeLoungeUpdate 
        -- or interface == Interfaces.MaidCoffeeLoungeFeedAll 
        -- or interface == Interfaces.MaidCoffeeLoungeFeed 
        -- or interface == Interfaces.MaidCoffeeLoungeTouch 
    then
        self:FreshUI()

    elseif interface == Interfaces.MaidCoffeeLoungeFeedAll or 
           interface == Interfaces.MaidCoffeeLoungeFeed 
    then
        self:FreshFeedNodes(true, false)
        self:FreshRoomFeedEffect(...)

    end
end

function OverManegeLoungeMainDialog:OnEventLoungeShowTagNode()
    CfUtils.SetActive(self.CatLoungeContent.gameObject, false)
    CfUtils.SetActive(self.TagUp.gameObject, true)
end

function OverManegeLoungeMainDialog:OnEventTimeChange(isChange)
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local playerCardIds      = loungeData.playerCardIds
    local seconds            = os.time()
    local isMax              = nil
    for i, playerCardId in ipairs(playerCardIds) do
        if playerCardId > 0 then
            ---@type OverManegeLoungeCardDetailsNode
            local env = self._cardDetailEnvs[i]
            if not isNull(env) then
                local cardInfo = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
                env:FreshTime(cardInfo.recoveryTime - seconds , self._isDetail)
                if isChange then
                    if not isMax then
                        isMax = cardInfo.cafeEnergy >= cardInfo.maxEnergy
                    end
                    env:FreshMood(cardInfo.cafeEnergy, cardInfo.maxEnergy, self._isDetail)
                    
                end
            end
        end
        
    end

    if isMax then
        self:FreshBtnFinishAll_Root()
    end
end

function OverManegeLoungeMainDialog:OnEventHitCat(catIndex, snakeId)
    if self._viewState ~= ViewState.FeedPage then
        return
    end
    local dataProviderIns    = self._dataProviderIns
    local loungeIndex        = self._selectLoungeIndex
    local loungeData         = dataProviderIns:GetLoungeDataByIndex(loungeIndex)
    local playerCardIds      = loungeData.playerCardIds
    local playerCardId       = playerCardIds[catIndex]
    if playerCardId == nil or playerCardId == 0 then
        return 
    end
    
    local info = dataProviderIns:GetCardInfoByPlayerCardId(playerCardId)
    if info.cafeEnergy >= info.maxEnergy then
        GameUtils.Toast(localize("当前员工心情值已满"))
        return
    end
    
    -- ---@type OverManegeLoungeCardDetailsNode
    -- local env = self._cardDetailEnvs[catIndex]
    -- if not isNull(env) then
    --     env:FreshFeedEffectShowState(true)
    -- end
    dataProviderIns:RequestLoungeFeed(playerCardId, snakeId)
    
end


function OverManegeLoungeMainDialog:OnSelectRoleChange()
    local dataProviderIns = self._dataProviderIns
    dataProviderIns:RequestHome()
    self:StopCoShow()
    self:CreateCoShow()

end

function OverManegeLoungeMainDialog:OnBackAction()
    self._controllerNode:DisablePlanarReflections()
end




---endregion 


return OverManegeLoungeMainDialog
