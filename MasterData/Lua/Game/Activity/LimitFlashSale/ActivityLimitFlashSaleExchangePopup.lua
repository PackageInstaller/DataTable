
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type ActivityConstants
local ActivityConstants = import("Game.Activity.ActivityConstants")
local CDTimerModule     = CS.Engine.Modules.CDTimerModule.GetInstance()
--endregion

--region define
local Cell = "Cell"
local CellPath = "Game.Activity.LimitFlashSale.ActivityLimitFlashSaleExchangeCell"
local TitleNodeScrPath = "Game.UI.Common.CommonUITitleNode"
--endregion

--- from: Assets/BundleResources/Prefabs/Activity/LimitFlashSaleExchangePopup140001.prefab > name: LimitFlashSaleExchangePopup140001
---@class ActivityLimitFlashSaleExchangePopup
---@field Env                           	ActivityLimitFlashSaleExchangePopup     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ScrollView                    	SuperScrollView.LoopListView2           
---@field CommonUITitleNode2            	UnityEngine.RectTransform               
---@field TxtTime                       	UnityEngine.UI.Text                     
---@field BtnClose                      	UnityEngine.RectTransform               
---@field ClickClose                    	UnityEngine.RectTransform               
local ActivityLimitFlashSaleExchangePopup = Class('ActivityLimitFlashSaleExchangePopup')


function ActivityLimitFlashSaleExchangePopup:__init()
    self._isSendBackEvent = false
end


function ActivityLimitFlashSaleExchangePopup:__delete()
    self.controller = nil
end


-- function ActivityLimitFlashSaleExchangePopup:Awake()
-- end


function ActivityLimitFlashSaleExchangePopup:OnFocus(focus)

end


function ActivityLimitFlashSaleExchangePopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


function ActivityLimitFlashSaleExchangePopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ActivityLimitFlashSaleExchangePopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._isSendBackEvent then
            Events.Broadcast(Constants.EventNames.ActivityLimitFlashSaleFreshHome)
        end
        self:StopCountDown()
        if self.__OnEventExchangeComplete then
            Events.RemoveListener(Constants.EventNames.ActivityLimitFlashSaleExchangeComplete, self.__OnEventExchangeComplete)
            self.__OnEventExchangeComplete = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ActivityLimitFlashSaleExchangePopup:OnInit()
    self:InitData()
    self:RequestData()
    self:InitAction()
    self:StartCountDown()
end

function ActivityLimitFlashSaleExchangePopup:InitData()
    local parameters   = self.controller.Argument.parameters
    -- local activityUuid = parameters.activityUuid
    local activityType = parameters.activityType
    local config        = ActivityConstants.Configs[activityType] or ActivityConstants.Configs[ActivityConstants.ActivityType.LimitFlashSale]
    local providerPath = config.providerPath
    local provider     = import(providerPath)
    self._provider     = provider
end

function ActivityLimitFlashSaleExchangePopup:RequestData()
    self._provider:RequestPopHome()
    local CoYield = CoYield
    while not self._provider:GetIsRequestComplete() do
        CoYield()
    end
    self:FreshUI()

end

function ActivityLimitFlashSaleExchangePopup:InitAction()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickBtnCloseAction))
    
    self.__OnEventExchangeComplete = Events.AddListener(Constants.EventNames.ActivityLimitFlashSaleExchangeComplete, Bind(self, self.OnEventExchangeComplete))
end

function ActivityLimitFlashSaleExchangePopup:StartCountDown()
    if isNotNull(self._co) then return end

    self._timer = CfUtils.CDTimerAppend(1, 86400, false, true, function(count, id, elapsed)
        local curTime   = os.time()
        local activityDojo = self._provider:GetActivityDojo()
        local countDown = activityDojo.closeTime - curTime
        if countDown > 0 then
            self:FreshTimeNode(countDown)
        else
            self:StopCountDown()
        end
       
    end)

    
end

function ActivityLimitFlashSaleExchangePopup:StopCountDown()
    CfUtils.CDTimerRemove(self._timer)
    
end
--endregion 


--region logic 

function ActivityLimitFlashSaleExchangePopup:FreshTimeNode(leftSeconds)
    if leftSeconds == nil then
        ---@type ActivityDojo
        local activityDojo = self._provider:GetActivityDojo()
        local closeTime    = activityDojo.closeTime
        leftSeconds  = closeTime - os.time()
    end
    self.TxtTime.text  = CfUtils.GetTimeHMS(leftSeconds)
end

function ActivityLimitFlashSaleExchangePopup:FreshUI()
    self:FreshScrollView()
    self:FreshTimeNode()
    self:FreshTitleNode()
end

function ActivityLimitFlashSaleExchangePopup:FreshTitleNode()
    local scr = CfUtils.GetLuaScr(self.CommonUITitleNode2, TitleNodeScrPath)
    if scr then
        scr:Refresh(localize("字符兑换"))
    end
end

function ActivityLimitFlashSaleExchangePopup:FreshScrollView()
    local dataList   = self:GetDataList()
    -- print(table.toString(dataList))
    local count      = #dataList
    local ScrollView = self.ScrollView
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end


function ActivityLimitFlashSaleExchangePopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(Cell)
    local node = GetLuaBehaviour(cell.gameObject, CellPath)
    
    ---@type ActivityLimitFlashSaleExchangeCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
        nodeEnv:SetCallback(Bind(self, self.OnClickExchangeBtnAction))
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self:GetDataList()
        local position = index + 1
        nodeEnv:FreshUI(dataList[position], position)

    end

    return cell
end

--endregion 


--region get/set 

function ActivityLimitFlashSaleExchangePopup:GetDataList()
    return self._provider:GetPopHomeData()
end

---endregion 


--region handler 

function ActivityLimitFlashSaleExchangePopup:OnClickExchangeBtnAction(data)
    local provider = self._provider
    if provider:CheckIsActivityClosed() then
        return
    end
    provider:RequestExchange(data.id)
end

function ActivityLimitFlashSaleExchangePopup:OnClickBtnCloseAction()
    self.controller:Close()
end

function ActivityLimitFlashSaleExchangePopup:OnEventExchangeComplete(rewards)
    self._isSendBackEvent = true
    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewards })
    self:FreshScrollView()
end

---endregion 


return ActivityLimitFlashSaleExchangePopup
