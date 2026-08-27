local UIEventComebackMain = require("Game.ActivityComeback.UI.UIEventComebackMain")
local UIEventComebackLiteMain = class("UIEventComebackLiteMain", UIEventComebackMain)
local base = UIEventComebackMain
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINActivityComebackTap = require("Game.ActivityComeback.UI.UINActivityComebackTap")
local ActivityUIType = {
  ComebackSign = 1,
  ComebackTask = 3,
  ComebackExchage = 4
}
local ActivityPanemParam = {
  [ActivityUIType.ComebackSign] = {
    UIName = "UI_EventComebackLiteSignNode",
    InitFunction = "InitCombackSingIn",
    UITable = "Game.ActivityComeback.UI.UINEventComebackLiteSignIn"
  },
  [ActivityUIType.ComebackTask] = {
    UIName = "UI_EventComebackTaskNode",
    InitFunction = "InitCombackTask",
    UITable = "Game.ActivityComeback.UI.UINEventComebackLiteTask"
  },
  [ActivityUIType.ComebackExchage] = {
    UIName = "UI_EventComebackLiteExchangeNode",
    InitFunction = "InitComebackExchange",
    UITable = "Game.ActivityComeback.UI.UINEventComebackLiteExchange"
  }
}

function UIEventComebackLiteMain:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self._tapPool = UIItemPool.New(UINActivityComebackTap, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.ui.tex_Title.text = ConfigData:GetTipContent(7406)
  self.__ClickTapFunc = BindCallback(self, self.__ClickTap)
  self._resloader = CS.ResLoader.Create()
  self._waitLoadingTable = {}
  UIUtil.AddButtonListener(self.ui.btn_lotteyJump, self, self.OnClickLotteryJumpBtn)
end

function UIEventComebackLiteMain:__ActivityParamDeal(activityList)
  self._activityUItype = {}
  self._activityUIEntity = {}
  for _, actFrameData in ipairs(activityList) do
    local UIType
    if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.SevenDayLogin then
      UIType = ActivityUIType.ComebackSign
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Task then
      UIType = ActivityUIType.ComebackTask
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Round then
      UIType = ActivityUIType.ComebackExchage
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Comeback then
      local activityCfg = ConfigData.activity[actFrameData:GetActivityFrameId()]
      if activityCfg ~= nil and activityCfg.rule_id > 0 then
        UIUtil.SetTopStateInfoFunc(self, function()
          UIManager:CreateWindowAsync(UIWindowTypeID.CommonRuleInfo, function(window)
            if window == nil then
              return
            end
            window:InitCommonRule(activityCfg.rule_id)
          end)
        end)
      end
    else
      error("活动没有面板 " .. tostring(actFrameData:GetActivityFrameId()))
    end
    if UIType ~= nil then
      local frameId = actFrameData:GetActivityFrameId()
      self._activityUItype[frameId] = UIType
    end
  end
end

function UIEventComebackLiteMain:__ClickTap(activityData)
  if activityData == nil then
    return
  end
  local frameId = activityData:GetActivityFrameId()
  if self._activityUItype[frameId] == nil then
    return
  end
  if self._selectActData ~= nil then
    local uiType = self._activityUItype[self._selectActData:GetActivityFrameId()]
    local entity = self._activityUIEntity[uiType]
    if entity ~= nil then
      entity:Hide()
    end
  end
  self._selectActData = activityData
  for _, tap in ipairs(self._tapPool.listItem) do
    local actData = tap:GetActivityCombackData()
    if actData ~= nil then
      local isSelect = actData:GetActivityFrameId() == frameId
      tap:RefreshCombackTapSelect(isSelect)
    else
      tap:RefreshCombackTapSelect(false)
    end
  end
  local uiType = self._activityUItype[frameId]
  local entity = self._activityUIEntity[uiType]
  local panelParam = ActivityPanemParam[uiType]
  UIUtil.RefreshTopResId(self._showItemIds)
  if entity ~= nil then
    entity:Show()
    entity[panelParam.InitFunction](entity, activityData:GetActId())
  elseif not self._waitLoadingTable[uiType] then
    self._waitLoadingTable[uiType] = true
    self._resloader:LoadABAssetAsync(PathConsts:GetActivityComebackPrefab(panelParam.UIName), function(prefab)
      if IsNull(self.transform) or IsNull(prefab) then
        return
      end
      local obj = prefab:Instantiate(self.ui.frameHolder.transform)
      obj.transform.localPosition = Vector3.zero
      obj.transform.localScale = Vector3.one
      local newEntity = require(panelParam.UITable).New()
      self._activityUIEntity[uiType] = newEntity
      self._waitLoadingTable[uiType] = nil
      newEntity:Init(obj)
      local isNeedShow = activityData == self._selectActData
      if isNeedShow then
        newEntity[panelParam.InitFunction](newEntity, activityData:GetActId())
      else
        newEntity:Hide()
      end
      if uiType == ActivityUIType.ComebackSign then
        if self.__PlayAvgCallback == nil then
          self.__PlayAvgCallback = BindCallback(self, self.__PlayAvg)
        end
        newEntity:SetPlayComebackAvg(self.__PlayAvgCallback)
      end
    end)
  end
end

return UIEventComebackLiteMain
