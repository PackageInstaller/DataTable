local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivityFiveDaySignComp, Super = System.NewClass("ActivityFiveDaySignComp", ActivityBaseComp)

function ActivityFiveDaySignComp:ctor(uiNode, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Activity_DiamondResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.itemIconComps = {}
end

function ActivityFiveDaySignComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_BindActivityTimer()
  self.iconItemModel = binder:createModel(CommonIconItemModel)
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Title, activityName)
  binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  binder:SetText(self.ui.Text_Desc, activityPlotInfo)
  self:_RefreshAwakrds(binder)
end

function ActivityFiveDaySignComp:_RefreshAwakrds(binder)
  for idx = 1, 5 do
    self:_RefreshAwakrd(binder, idx)
  end
end

function ActivityFiveDaySignComp:_RefreshAwakrd(binder, idx)
  local obj = self.ui["WuPin_Type_" .. idx]
  if not obj then
    return
  end
  
  local function _RedFunc()
    return false
  end
  
  local itemIdx = idx * 2 - 1
  local itemTid = self.activityConfig.ActivityPara1[itemIdx]
  local itemCnt = self.activityConfig.ActivityPara1[itemIdx + 1]
  local state = self.activityData.prize[idx]
  local comp = self.itemIconComps[idx]
  local itemCfg = DT.Item[itemTid]
  
  local function _OnClickAward()
    self:_OnGetAwakrd(binder, obj, idx, itemTid)
  end
  
  if comp then
    comp.binder:teardown()
  end
  local itemData = {
    tid = itemTid,
    num = itemCnt,
    model = self.iconItemModel,
    callback = _OnClickAward,
    activityPrizeState = state,
    redFunc = _RedFunc
  }
  comp = binder:BindComponent(CommonIconItem(obj, itemData))
  self.itemIconComps[idx] = comp
  comp:UpdateItemNum(ItemNumUtils.GetStr(LT.Text(itemCfg.Name), itemCnt))
  local objName = self.ui["Text_Name_" .. idx]
  self.binder:SetText(objName, LT.Textf("ActivityRewardday", idx))
  local receivedTextObj = self.ui["Text_Receive_" .. idx]
  receivedTextObj:SetActive(state == CommonDefine.CommonState.Finish)
  objName:SetActive(state ~= CommonDefine.CommonState.Finish)
end

function ActivityFiveDaySignComp:_OnGetAwakrd(binder, obj, day, itemTid)
  local sevenLoginData = self.activityData
  local sevenLoginBaseData = sevenLoginData and sevenLoginData.base
  if not (sevenLoginData and sevenLoginData.prize) or not sevenLoginBaseData then
    return
  end
  local prizeState = sevenLoginData.prize[day] or CommonDefine.CommonState.Realy
  if prizeState ~= CommonDefine.CommonState.GainPrize then
    ItemDataUtils.ShowItemDetailTips(binder, obj, nil, itemTid)
    return
  end
  if sevenLoginBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    ActivityDataUtils.ReqGainAward(sevenLoginBaseData.tid, day, extraParams, function(result)
      if result then
        sevenLoginData.prize[day] = CommonDefine.CommonState.Finish
        self:_RefreshAwakrd(self.binder, day)
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
        if onRequestCallback then
          onRequestCallback()
        end
      end
    end)
  end
  
  ToReqGainAward()
end

function ActivityFiveDaySignComp:OnUnbind()
end

function ActivityFiveDaySignComp:OnOpenAnim()
  self.uiAnimController:PlayState("UI_Events_Activity_Diamond_Open")
end

function ActivityFiveDaySignComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Activity_Diamond_Close", callback)
end

return ActivityFiveDaySignComp
