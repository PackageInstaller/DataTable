local TaskAppointBuildTips, Super = System.NewClass("TaskAppointBuildTips", UIBasePanel)
TaskAppointBuildTips.uiResCls = UI_Research_Popup_RecallResource

function TaskAppointBuildTips:ctor(data)
  Super.ctor(self)
  self.data = data
  self.DISPATCH_MAX_ITEM_NUM = 6
end

function TaskAppointBuildTips:OnBind(binder)
  local model = binder:createModel(TaskAppointBuildTipsModel, self.data)
  self.model = model
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnClose))
  binder:BindToTextColor(self.ui.Text_Special1, function()
    local condInfo = TaskDataUtils.GetConditionInfo(self.model.taskCfg.CompleteCond, self.model.taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
    if condInfo.isOk then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Normal
  end)
  binder:BindToTextColor(self.ui.Text_C_Special2, function()
    local tid = self.data.taskData.tid
    local awakerList = self.model.chooseAwakerGroup
    if self.model.chooseAwakerNum <= 0 then
      return CommonDefine.ColorType.Normal
    end
    local reach = TaskDataUtils.IsReachDispatchExtraAwardCond(tid, awakerList)
    if reach then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Normal
  end)
  binder:BindToVisible(self.ui.Image_Extra, System.fn(self, self._IsShowExtraAwardTips))
  self:BindRightPart(binder)
  self:BindAwakerGroup(binder)
  self:BindBottomBtn(binder)
end

function TaskAppointBuildTips:BindRightPart(binder)
  binder:BindRawTable(function()
    return self.model.chooseAwakerGroup
  end, function(childBinder, nAwakerTid, oAwakerTid, index)
    local showAwaker = index <= self.model.MAX_AWAKER_NUM and nil ~= nAwakerTid
    local obj = self.ui["UI_Common_Item_Awaker" .. index]
    obj:SetActive(showAwaker)
    if not childBinder then
      return
    end
    if nAwakerTid then
      local awakerData = AwakerDataUtils.GetAwakerData(nAwakerTid)
      local itemData = {
        awakerId = nAwakerTid,
        itemCount = string.format("LV.%s", awakerData.level)
      }
      childBinder:BindComponent(CommonIconItemType2(obj, itemData))
    end
  end)
  for i = 1, self.DISPATCH_MAX_ITEM_NUM do
    local bgObj = self.ui["Image_Bg" .. i]
    local showBg = i <= self.model.MAX_AWAKER_NUM
    binder:SetActive(bgObj, showBg)
  end
  binder:BindToCircularListView(self.ui.ScrollView_Award, function()
    return self.model.showAwardGroup
  end, function(itemBinder, item, index)
    local data = self.model.showAwardGroup[index]
    local itemCount
    local itemCfg = DT.Item[data.itemTid]
    if itemCfg.Type == "DropItem" then
      itemCount = ""
    else
      itemCount = data.count
    end
    local _darkShowFunc = System.fn(self, self._NormalAwardDarkShow)
    
    local function _showFlowingLightFunc()
      return not self:_NormalAwardDarkShow()
    end
    
    if data.isExtra then
      _darkShowFunc = System.fn(self, self._ExtraAwardDarkShow)
      
      function _showFlowingLightFunc()
        return not self:_ExtraAwardDarkShow()
      end
    end
    local _extraDescFunc
    if data.isExtra then
      _extraDescFunc = TaskDataUtils.GetExtraAwardTagText
    end
    local itemData = {
      itemTid = data.itemTid,
      itemCount = itemCount,
      isGot = false,
      darkShowFunc = _darkShowFunc,
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue,
      extraDescFunc = _extraDescFunc,
      showFlowingLightFunc = _showFlowingLightFunc
    }
    local itemComp = itemBinder:BindComponent(CommonIconItemType2(item, itemData))
    if data.isExtra then
      itemBinder:BindToRaw(function(_, selectAwakerNum)
        if not selectAwakerNum then
          return
        end
        if itemComp then
          local taskTid = self.model.taskData.tid
          local awakerList = self.model.chooseAwakerGroup
          local extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(taskTid, awakerList)
          if extraAwardInfo then
            itemComp:UpdateItemCount(extraAwardInfo.num)
          end
        end
      end, function()
        return self.model.chooseAwakerNum
      end)
    end
  end)
  binder:BindToText(self.ui.Text_Special1, function()
    return self.model.conditionTips
  end)
  binder:BindToVisible(self.ui.Image_Icon_Cond_1, function()
    return self.model.conditionTips ~= "" and self:_NormalAwardDarkShow()
  end)
  binder:BindToVisible(self.ui.Image_Icon_Hook_1, function()
    local tid = self.data.taskData.tid
    local taskCfg = TaskDataUtils.GetConfig(tid)
    local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
    return condInfo and condInfo.isOk
  end)
  binder:BindToVisible(self.ui.Image_Icon_Cond_2, function()
    local tid = self.data.taskData.tid
    if not tid then
      return
    end
    local hasExtraAward = TaskDataUtils.HasExtraAward(tid)
    return hasExtraAward and self:_ExtraAwardDarkShow()
  end)
  binder:BindToVisible(self.ui.Image_Icon_Hook_2, function()
    local tid = self.data.taskData.tid
    local awakerList = self.model.chooseAwakerGroup
    if self.model.chooseAwakerNum <= 0 then
      return false
    end
    local reach = TaskDataUtils.IsReachDispatchExtraAwardCond(tid, awakerList)
    return reach
  end)
  binder:BindToText(self.ui.Text_ProgressNum1, function()
    local condInfo = TaskDataUtils.GetConditionInfo(self.model.taskCfg.CompleteCond, self.model.taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
    local before, after = string.match(condInfo.conditionStr, "(.-)/(.+)")
    do return string.format, "%s%s", LT.Text(before), string.color("/" .. LT.Text(after), "#ACBFCA") end
    return string.format, "%s%s", LT.Text(before), string.color("/" .. LT.Text(after), "#ACBFCA")
  end)
end

function TaskAppointBuildTips:BindAwakerGroup(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_List, function()
    return self.model.showAwakerGroup
  end, function(itemBinder, obj, index)
    local awakerData = self.model.showAwakerGroup[index]
    
    local function clickFunc()
      if TaskDataUtils.AwakerInTask(awakerData.tid) then
        Alert.ShowStr(LT.Text("Task_Dispatch_DispatchingTips"))
        return
      end
      if table.contains(self.model.chooseAwakerGroup, awakerData.tid) then
        self.model.RemoveAwaker(awakerData.tid)
      else
        self.model.AddAwaker(awakerData.tid)
      end
    end
    
    local function selectBgFunc()
      do return table.contains, self.model.chooseAwakerGroup end
      return table.contains, self.model.chooseAwakerGroup, awakerData.tid
    end
    
    local function wrongBgFunc()
      do return TaskDataUtils.AwakerInTask end
      return TaskDataUtils.AwakerInTask, awakerData.tid
    end
    
    local itemData = {
      clickFunc = clickFunc,
      awakerData = awakerData,
      selectBgFunc = selectBgFunc,
      wrongBgFunc = wrongBgFunc,
      showPotencyInfoFunc = function()
        do return AwakerDataUtils.HasOwnedAwaker end
        return AwakerDataUtils.HasOwnedAwaker, awakerData.tid
      end
    }
    itemBinder:BindComponent(CommonAwakerListItem(obj, itemData))
  end)
end

function TaskAppointBuildTips:BindBottomBtn(binder)
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupTipsData))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Cancel, System.fn(self, self._OnLeftBtn), function()
    return CommonDefine.BtnType.High
  end, System.fn(self, self._GetLeftBtnText))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Notarize, System.fn(self, self.Challenge), function()
    local condInfo = TaskDataUtils.GetConditionInfo(self.model.taskCfg.CompleteCond, self.model.taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
    if self.model.IsEmptyTeam() or not condInfo.isOk then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DispatchNormal"
  end)
end

function TaskAppointBuildTips:_OnLeftBtn()
  if self.model.IsEmptyTeam() then
    self.model:OneClickFormation()
  else
    self.model.Clear_chooseAwakerGroup()
  end
end

function TaskAppointBuildTips:_GetLeftBtnText()
  if self.model.IsEmptyTeam() then
    do return LT.Text end
    return LT.Text, "DispatchOneClickFormation"
  else
    do return LT.Text end
    return LT.Text, "DispatchClear"
  end
end

function TaskAppointBuildTips:_NormalAwardDarkShow()
  if self.model.chooseAwakerNum <= 0 then
    return true
  end
  local tid = self.data.taskData.tid
  local taskCfg = TaskDataUtils.GetConfig(tid)
  local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
  return not condInfo.isOk
end

function TaskAppointBuildTips:_ExtraAwardDarkShow()
  if self.model.chooseAwakerNum <= 0 then
    return true
  end
  local tid = self.data.taskData.tid
  local awakerList = self.model.chooseAwakerGroup
  local _extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(tid, awakerList)
  return not _extraAwardInfo or not _extraAwardInfo.reach
end

function TaskAppointBuildTips:_IsShowExtraAwardTips()
  local tid = self.data.taskData.tid
  if not tid then
    return
  end
  do return TaskDataUtils.HasExtraAward end
  return TaskDataUtils.HasExtraAward, tid
end

function TaskAppointBuildTips:Challenge()
  if self.model.IsEmptyTeam() then
    Alert.ShowStr(LT.Text("Task_Dispatch_Select_Null"))
    return
  end
  local condInfo = TaskDataUtils.GetConditionInfo(self.model.taskCfg.CompleteCond, self.model.taskCfg.CompleteCondPara, self.model.chooseAwakerGroup)
  if not condInfo.isOk then
    Alert.ShowStr(LT.Text("Task_Dispatch_Select_Condition_NotMeet"))
    return
  end
  
  local function challenge()
    if self.data and self.data.challengeFunc then
      local awakerList = table.deepclone(self.model.chooseAwakerGroup)
      self.data.challengeFunc(awakerList, self.data.taskData)
    end
    self:OnClose()
  end
  
  if self.data and self.data.challengeConditionFunc then
    local tipId, desc = self.data.challengeConditionFunc(table.deepclone(self.model.chooseAwakerGroup))
    if tipId and desc then
      Alert.Show(tipId, nil, function()
        challenge()
      end, DT.TipsType[tipId].Title, desc)
    else
      challenge()
    end
  else
    challenge()
  end
end

function TaskAppointBuildTips:OnClose()
  self:Close()
end

return TaskAppointBuildTips
