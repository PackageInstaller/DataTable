local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local LAST_DAY = 7
local SevenDayLoginComp, Super = System.NewClass("SevenDayLoginComp", ActivityBaseComp)

function SevenDayLoginComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_AttendanceResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.awardItems = {}
  self.awardList = {}
  self.currSelectDay = Vue.ref(0)
  self:_SetUpAwardList()
end

function SevenDayLoginComp:OnBind(binder)
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
  self:_BindGiftTask()
end

function SevenDayLoginComp:_SetUpAwardList()
  local list = ActivityDataUtils.GetSevenLoginAwards(self.activityTid)
  if #list < LAST_DAY * 2 then
    return
  end
  self.awardList = {}
  for day = 1, LAST_DAY do
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

function SevenDayLoginComp:_UpdateAwardShow()
  if not self.activityData then
    return
  end
  local data = self.activityData
  local prizeDatas = data.prize or {}
  for day = 1, LAST_DAY do
    local awardData = self.awardList[day]
    if not awardData then
    else
      local state = prizeDatas[day]
      self:_UpdateAwardItem(day, awardData, state)
    end
  end
end

function SevenDayLoginComp:_AwardClickFunc(binder, obj, day, awardTid)
  local sevenLoginData = self.activityData
  local sevenLoginBaseData = sevenLoginData and sevenLoginData.base
  if not (sevenLoginData and sevenLoginData.prize) or not sevenLoginBaseData then
    return
  end
  local prizeState = sevenLoginData.prize[day] or CommonDefine.CommonState.Realy
  if day == self.currSelectDay.value then
    if prizeState ~= CommonDefine.CommonState.GainPrize then
      ItemDataUtils.ShowItemDetailTips(binder, obj, nil, awardTid)
    end
    return
  end
  if sevenLoginBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if prizeState ~= CommonDefine.CommonState.GainPrize then
    ItemDataUtils.ShowItemDetailTips(binder, obj, nil, awardTid)
    return
  end
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    ActivityDataUtils.ReqGainAward(sevenLoginBaseData.tid, day, extraParams, function(result)
      if result then
        sevenLoginData.prize[day] = CommonDefine.CommonState.Finish
        if self.awardItems[day] then
          self.awardItems[day]:UpdatePrizeState(CommonDefine.CommonState.Finish)
        end
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
        if onRequestCallback then
          onRequestCallback()
        end
      end
    end)
  end
  
  ToReqGainAward()
end

function SevenDayLoginComp:_UpdateAwardItem(day, awardData, state)
  local obj = self.ui["WuPin_Type_" .. day]
  local binder = self.binder
  local awardTid = awardData.tid
  state = state or CommonDefine.CommonState.Realy
  local awardNum = awardData.num
  
  local function _OnClickAward()
    self:_AwardClickFunc(binder, obj, day, awardTid)
  end
  
  if day < LAST_DAY then
    local item = self.awardItems[day]
    if not item then
      local itemData = {
        tid = awardTid,
        num = awardNum,
        model = self.iconItemModel,
        callback = _OnClickAward,
        activityPrizeState = state,
        redFunc = _RedFunc
      }
      item = binder:BindComponent(CommonIconItem(obj, itemData))
      self.awardItems[day] = item
    else
      item:UpdateItemTid(awardTid)
      item:UpdateItemCount(awardNum)
      item:UpdateClickFunc(_OnClickAward)
      item:UpdatePrizeState(state)
    end
  elseif day == LAST_DAY then
    local skinTid = AwakerSkinUtils.GetSkinByItem(awardTid)
    if not skinTid then
      binder:SetActive(self.ui.Group_Normal, true)
      binder:SetActive(self.ui.Group_AwakerSkin, false)
      binder:SetImage(self.ui.Icon_Article, ItemDataUtils.GetIcon(awardTid))
      local textNumObj = self.ui.Text_Quantity
      if textNumObj then
        binder:SetText(textNumObj, awardNum)
      end
    else
      binder:SetActive(self.ui.Group_AwakerSkin, true)
      binder:SetActive(self.ui.Group_Normal, false)
      binder:SetImage(self.ui.Icon_Skin, ItemDataUtils.GetIcon(awardTid))
      binder:SetImage(self.ui.Image_Quality, ItemDataUtils.GetQualityIcon(awardTid))
      binder:SetImage(self.ui.Image_SkinQuality, AwakerSkinCfgUtils.GetSkinItemQualityBottomImage(skinTid))
      AwakerUiUtils.RefreshAwakerSkinStarGroup(self, binder, skinTid)
      self:_RefreshSkinJumpGroup(skinTid)
    end
    binder:BindLongPressButton(self.ui.Btn_Click, _OnClickAward, _OnClickAward, tonumber(DT.GetConstant("Role_Press_Time")))
    binder:BindComponent(RedDotComponent(self.ui.Group_Sub_RedDot, nil, nil, _RedFunc))
    self:_BindLastAwardItemStateShow()
  end
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

function SevenDayLoginComp:_RefreshSkinJumpGroup(skinTid)
  local summonBtnUI = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump)
  self.binder:SetText(summonBtnUI.Text_Name, AwakerSkinCfgUtils.GetCfgField("Name", skinTid))
  self.binder:SetImage(summonBtnUI.Image_Positioning, CommonRes.SkinIcon)
  self.binder:SetActive(summonBtnUI.Image_Up, false)
  self.binder:SetActive(summonBtnUI.Image_SSR, false)
  self.binder:BindButtonClick(summonBtnUI.uiNode, function()
    UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, nil, skinTid)
  end)
end

function SevenDayLoginComp:_GetStateText(day)
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

function SevenDayLoginComp:_BindLastAwardItemStateShow()
  local binder = self.binder
  binder:BindToVisible(self.ui.Image_Dis, function()
    return self.activityData.prize[LAST_DAY] == CommonDefine.CommonState.Finish
  end)
  binder:BindToVisible(self.ui.Image_Receive, function()
    return self.activityData.prize[LAST_DAY] == CommonDefine.CommonState.GainPrize
  end)
end

function SevenDayLoginComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function SevenDayLoginComp:_BindGiftTask()
  local activityConfg = ActivityDataUtils.GetConfig(self.activityTid)
  local taskTid = activityConfg.ActivityPara3
  if type(taskTid) == "table" then
    taskTid = taskTid[1]
  end
  taskTid = tonumber(taskTid)
  if not taskTid then
    self.ui.UI_Summon_GiftTask:SetActive(false)
    return
  end
  self.ui.UI_Summon_GiftTask:SetActive(true)
  self.binder:BindComponent(SummonGiftTask(self.ui.UI_Summon_GiftTask, taskTid, System.fn(self, self.ReqTaskReward)))
end

function SevenDayLoginComp:ReqTaskReward(taskTid)
  ActivityDataUtils.ReqGainAward(self.activityTid, taskTid)
end

function SevenDayLoginComp:OnUnbind()
  self:_ClearTimer()
  if self.awardItems and table.next(self.awardItems) ~= nil then
    for k, _ in pairs(self.awardItems) do
      if self.awardItems[k] then
        self.awardItems[k] = nil
      end
    end
  end
end

function SevenDayLoginComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Attendance_Open", callback)
end

function SevenDayLoginComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Attendance_Close", callback)
end

return SevenDayLoginComp
