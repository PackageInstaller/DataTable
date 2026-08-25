local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local LoginByMonthComp, Super = System.NewClass("LoginByMonthComp", ActivityBaseComp)

function LoginByMonthComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.awardItems = {}
  self.awardList = {}
  self:_SetUpAwardList()
  self:_InitUIRes(res)
end

function LoginByMonthComp:_InitUIRes(res)
  self.ui = UI_Events_Panel_DailySignResource(res)
end

function LoginByMonthComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.iconItemModel = binder:createModel(CommonIconItemModel)
  self.iconItemModel:SetItemDataMap(self.awardList)
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  binder:SetText(self.ui.Text_Title, activityName)
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  self:_BindActivityTimer()
  self:_UpdateAwardShow()
  self:_BindPortraitComp()
  self:_TryReqTodayAward()
  self:_BindLoadVXFx()
end

function LoginByMonthComp:_TryReqTodayAward()
  if not self.activityData.loginDaily then
    return
  end
  self:_AwardClickFunc(self.binder, nil, self.activityData.loginDaily)
end

function LoginByMonthComp:_CheckCanGetAward(day)
  local sevenLoginData = self.activityData
  local sevenLoginBaseData = sevenLoginData and sevenLoginData.base
  if not (sevenLoginData and sevenLoginData.prize) or not sevenLoginBaseData then
    return false
  end
  local prizeState = sevenLoginData.prize[day]
  if sevenLoginBaseData.state ~= ActivityDefine.ActivityState.Running then
    return false
  end
  if prizeState == CommonDefine.CommonState.GainPrize then
    return true
  end
  return false
end

function LoginByMonthComp:_SetUpAwardList()
  local list = ActivityDataUtils.GetSevenLoginAwards(self.activityTid)
  local lastDay = #list / 2
  self.awardList = {}
  for day = 1, lastDay do
    local awardIndex = 2 * day - 1
    local tid = list[awardIndex]
    local num = list[awardIndex + 1]
    local uid = day
    if tid and num then
      table.insert(self.awardList, {
        tid = tid,
        num = num,
        uid = uid
      })
    end
  end
end

function LoginByMonthComp:_UpdateAwardShow()
  if not self.activityData then
    return
  end
  local awardNum = #self.awardList
  local ct_transform = self.ui.Layout_DailySign.transform
  local cnt = ct_transform.childCount
  while awardNum > cnt do
    Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  for day = 1, awardNum do
    local go = ct_transform:GetChild(day - 1).gameObject
    go:SetActive(true)
    local awardData = self.awardList[day]
    local ui = UI_Events_Item_DailySignResource(go)
    self:_UpdateAwardItem(ui.UI_Item_WuPin, day, awardData)
    self.binder:SetText(ui.Text_Day, string.format("%02d", day))
  end
  for i = awardNum + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function LoginByMonthComp:_AwardClickFunc(binder, obj, day, awardTid)
  local sevenLoginData = self.activityData
  local gainButNotTake = {}
  for i = 1, #sevenLoginData.prize do
    if sevenLoginData.prize[i] == CommonDefine.CommonState.GainPrize then
      table.insert(gainButNotTake, i)
    end
  end
  local sevenLoginBaseData = sevenLoginData and sevenLoginData.base
  if not (sevenLoginData and sevenLoginData.prize) or not sevenLoginBaseData then
    return
  end
  local prizeState = sevenLoginData.prize[day] or CommonDefine.CommonState.Realy
  if sevenLoginBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if prizeState ~= CommonDefine.CommonState.GainPrize then
    if awardTid and obj then
      ItemDataUtils.ShowItemDetailTips(binder, obj, nil, awardTid)
    end
    return
  end
  
  local function ToGainAllAward(onRequestCallback)
    ActivityDataUtils.ReqOnGainAllPrize(sevenLoginBaseData.tid, function()
      for i = 1, #gainButNotTake do
        local day_i = gainButNotTake[i]
        sevenLoginData.prize[day_i] = CommonDefine.CommonState.Finish
        if self.awardItems[day_i] then
          self.awardItems[day_i]:SetIsGot(true)
          self.awardItems[day_i]:SetShowRing(false)
        end
      end
      ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      if onRequestCallback then
        onRequestCallback()
      end
    end)
  end
  
  ToGainAllAward()
end

function LoginByMonthComp:_UpdateAwardItem(obj, day, awardData)
  local binder = self.binder
  local awardTid = awardData.tid
  local data = self.activityData
  local prizeDatas = data.prize or {}
  local state = prizeDatas[day] or CommonDefine.CommonState.Realy
  local awardNum = awardData.num
  
  local function _OnClickAward()
    self:_AwardClickFunc(binder, obj, day, awardTid)
  end
  
  local item = self.awardItems[day]
  if item then
    item.binder:teardown()
  end
  local itemData = {
    itemTid = awardTid,
    itemCount = awardNum,
    clickFunc = _OnClickAward,
    isShowRing = function()
      return state == CommonDefine.CommonState.GainPrize
    end,
    isGot = state == CommonDefine.CommonState.Finish
  }
  item = binder:BindComponent(CommonIconItemType2(obj, itemData))
  self.awardItems[day] = item
  local textNameObj = self.ui["Text_Name_" .. day]
  if textNameObj then
    binder:SetText(textNameObj, ItemDataUtils.GetItemName(awardTid))
  end
  local receivedTextObj = self.ui["Text_Receive_" .. day]
  if receivedTextObj then
    binder:BindToText(receivedTextObj, function()
      do return self._GetStateText, self end
      return self._GetStateText, self, day
    end)
  end
end

function LoginByMonthComp:_GetStateText(day)
  local sevenLoginData = self.activityData
  if not sevenLoginData or not sevenLoginData.prize then
    return
  end
  local prizeState = sevenLoginData.prize[day] or CommonDefine.CommonState.Realy
  local stateText = ActivityDataUtils.GetPrizeStateText(prizeState)
  if stateText then
    stateText = LT.Text(stateText)
  elseif prizeState == CommonDefine.CommonState.Realy then
    stateText = LT.Textf("ActivityRewardday", day)
  end
  return stateText
end

function LoginByMonthComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function LoginByMonthComp:OnUnbind()
  if self.awardItems and table.next(self.awardItems) ~= nil then
    for k, _ in pairs(self.awardItems) do
      if self.awardItems[k] then
        self.awardItems[k] = nil
      end
    end
  end
end

function LoginByMonthComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Attendance_Open", callback)
end

function LoginByMonthComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Attendance_Close", callback)
end

return LoginByMonthComp
