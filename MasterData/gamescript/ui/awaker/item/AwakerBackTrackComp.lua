local AwakerBackTrackComp, Super = System.NewComponent("AwakerBackTrackComp", AwakerBasePageComp)

function AwakerBackTrackComp:ctor(uiNode, awakerModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_PreviewResource(uiNode)
  self.model = awakerModel
end

function AwakerBackTrackComp:OnBind(binder)
  self.backTrackModel = binder:createModel(AwakerBackTrackModel, self.model)
  self.ui.Text_Awaker_Name:SetActive(false)
  binder:BindToText(self.ui.Text_Name_First, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerName(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Quality_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Level, function()
    do return LT.Textf, "Team_AwakerLevel", self.model:GetAwakerLevel(self.model.selectAwakerId) end
    return LT.Textf, "Team_AwakerLevel", self.model:GetAwakerLevel(self.model.selectAwakerId)
  end)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
    if not awakerData then
      return
    end
    return {
      self.model.selectAwakerId,
      awakerData and awakerData.potency or 0
    }
  end)
  local origText = binder:GetTextComp(self.ui.Text_C_TipDesc).text
  binder:BindToText(self.ui.Text_C_TipDesc, function()
    local awakerId = self.model.selectAwakerId
    local openType = BackTrackDataUtils.GetAwakerOpenType(awakerId)
    if BackTrackDataUtils.IsUniqueAwaker(awakerId) and openType == cd.BackTrackOpenType.ItemOpen then
      do return LT.Text end
      return LT.Text, "BacktrackTips1"
    end
    if openType == cd.BackTrackOpenType.FreeOpen then
      if BackTrackDataUtils.IsLimitAwaker(awakerId) or BackTrackDataUtils.IsNormalAwaker(awakerId) then
        do return LT.Text end
        return LT.Text, "BacktrackTips2"
      end
      if BackTrackDataUtils.IsSystemAwaker(awakerId) then
        do return LT.Text end
        return LT.Text, "BacktrackTips3"
      end
    end
    return origText
  end)
  
  local function tickFunc()
    local endTime = BackTrackDataUtils.GetEndTime()
    local tickStr = TimeUtils.format(endTime - TimeUtils.GetServerTime(), CommonDefine.TimeParseType.dhms)
    local str = LT.Textf("BacktrackTimesLeft", tickStr)
    binder:SetText(self.ui.Text_Deadline, str)
  end
  
  tickFunc()
  binder:BindTimer(1, -1, function()
    tickFunc()
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("BacktrackAwaker_Rules"))
  end)
  self.ui.Btn_Grade:SetActive(true)
  binder:BindZ1Button(self.ui.Btn_Grade, function()
    if not BackTrackDataUtils.IsAwakerOpen(self.model.selectAwakerId) then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    local isEnable, tips = BackTrackDataUtils.IsEnableTrainBack(self.model.selectAwakerId)
    if not isEnable and tips then
      Alert.ShowStr(tips)
      return
    end
    if TaskDataUtils.AwakerInTask(self.model.selectAwakerId) then
      Alert.Show(20126)
      return
    end
    self:LevelBackTrackConfirm(function()
      local awakerName = AwakerDataUtils.GetAwakerName(self.model.selectAwakerId)
      
      local function confirmFunc()
        EventMgr.Instance.OpenReqMask:Dispatch()
        ProtoManager.Instance:ReqServer("GameRequest", "OnBacktrackLevel", function(data)
          RedPointDataUtils.ResetBackTrackOnceRed(self.model.selectAwakerId)
        end, function(_, code)
          Logger.Error("[唤醒体等级回溯] 失败！错误码: %s", code.code)
        end, self.model.selectAwakerId)
      end
      
      local tipsId = 20117
      if BackTrackDataUtils.IsUniqueAwaker(self.model.selectAwakerId) then
        tipsId = 20162
      end
      Alert.ShowWithParams(tipsId, {awakerName}, nil, confirmFunc)
    end)
  end, function()
    if not BackTrackDataUtils.IsAwakerOpen(self.model.selectAwakerId) then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    if not BackTrackDataUtils.IsEnableTrainBack(self.model.selectAwakerId) then
      return CommonDefine.BtnType.Unclickable
    end
    if self:LevelBackTrackConditionMatch() then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Qiling, function()
    if not BackTrackDataUtils.IsAwakerOpen(self.model.selectAwakerId) then
      return
    end
    local isEnable, tips = BackTrackDataUtils.IsEnableQilingBack(self.model.selectAwakerId)
    if not isEnable and tips then
      Alert.ShowStr(tips)
      return
    end
    self:PotencyBackTrackConfirm(function()
      local awakerName = AwakerDataUtils.GetAwakerName(self.model.selectAwakerId)
      
      local function confirmFunc()
        EventMgr.Instance.OpenReqMask:Dispatch()
        ProtoManager.Instance:ReqServer("GameRequest", "OnBacktrackPotency", function(data)
        end, function(_, code)
          Logger.Error("[唤醒体启灵回溯] 失败！错误码: %s", code.code)
        end, self.model.selectAwakerId)
      end
      
      Alert.ShowWithParams(20163, {awakerName}, nil, confirmFunc)
    end)
  end, function()
    if not BackTrackDataUtils.IsAwakerOpen(self.model.selectAwakerId) then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    local isEnable = BackTrackDataUtils.IsEnableQilingBack(self.model.selectAwakerId)
    if not isEnable then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    return self:GetPotencyCount() > 0 and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Unclickable
  end, function()
    local tipsCfg = DT.TipsType[20118]
    do return LT.Text end
    return LT.Text, tipsCfg.Title
  end)
  binder:BindZ1Button(self.ui.Btn_Blackpool, function()
    local isEnable, tips = BackTrackDataUtils.IsEnableHeichiBack(self.model.selectAwakerId)
    if not isEnable then
      if tips then
        Alert.ShowStr(tips)
      end
      return
    end
    if self:IsBanBlack(self.model.selectAwakerId) then
      Alert.Show(20120)
      return
    end
    if TaskDataUtils.AwakerInTask(self.model.selectAwakerId) then
      Alert.Show(20126)
      return
    end
    local awakerName = AwakerDataUtils.GetAwakerName(self.model.selectAwakerId)
    
    local function confirmFunc()
      local config = AwakerDataUtils.GetAwakerConfig(self.model.selectAwakerId)
      local item = ItemDataUtils.GetBagItemByTid(config.PlayerAvatar)
      local itemUid = item and item.uid
      AwakerDataUtils.RequestAwakersCollectState(self.model.selectAwakerId, 0)
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("GameRequest", "OnBacktrackAll", function(data)
        if itemUid then
          SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.Avatar, {itemUid})
        end
        PvPTeamBuildDataUtils.ReqOnOpenTeam()
        RedPointDataUtils.ResetBackTrackOnceRed(self.model.selectAwakerId)
      end, function(_, code)
        Logger.Error("[唤醒体黑池归还] 失败！错误码: %s", code.code)
      end, self.model.selectAwakerId)
    end
    
    Alert.ShowWithParams(20164, {awakerName}, nil, confirmFunc)
  end, function()
    if not BackTrackDataUtils.IsEnableHeichiBack(self.model.selectAwakerId) then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    local ban = self:IsBanBlack(self.model.selectAwakerId)
    return ban and CommonDefine.Z1ButtonState.Unclickable or CommonDefine.Z1ButtonState.High
  end, function()
    do return LT.Text end
    return LT.Text, "BlackPoolBackTrack"
  end)
  binder:BindZ1Button(self.ui.Btn_Observe_3, function()
    if not BackTrackDataUtils.IsEnableTrainBack(self.model.selectAwakerId) then
      return
    end
    self:LevelBackTrackConfirm(function()
      self:PreviewRewardByTag(CommonDefine.BackTrackAwakerType.Level)
    end)
  end)
  binder:BindZ1Button(self.ui.Btn_Observe_2, function()
    local isEnable, tips = BackTrackDataUtils.IsEnableQilingBack(self.model.selectAwakerId)
    if not isEnable then
      if tips then
        Alert.ShowStr(tips)
      end
      return
    end
    self:PotencyBackTrackConfirm(function()
      self:PreviewRewardByTag(CommonDefine.BackTrackAwakerType.Potency)
    end)
  end)
  binder:BindZ1Button(self.ui.Btn_Observe_1, function()
    local isEnable, tips = BackTrackDataUtils.IsEnableHeichiBack(self.model.selectAwakerId)
    if not isEnable then
      if tips then
        Alert.ShowStr(tips)
      end
      return
    end
    if not BackTrackDataUtils.IsAwakerOpen(self.model.selectAwakerId) then
      return CommonDefine.Z1ButtonState.Unclickable
    end
    if self:IsBanBlack(self.model.selectAwakerId) then
      Alert.Show(20120)
      return
    end
    self:PreviewRewardByTag(CommonDefine.BackTrackAwakerType.Black)
  end)
  binder:BindToRaw(function(cbinder, awakerTid)
    cbinder:BindToRaw(function(_, curOpenType, preOpenType)
      if nil ~= preOpenType and curOpenType == cd.BackTrackOpenType.NotOpen then
        RedPointDataUtils.ResetBackTrackOnceRed(awakerTid)
        self.model:SetAwakerPage(CommonDefine.AwakerPage.List)
        self.model:ExitMiniHeadState()
      end
    end, function()
      do return BackTrackDataUtils.GetAwakerOpenType end
      return BackTrackDataUtils.GetAwakerOpenType, awakerTid
    end)
  end, function()
    return self.model.selectAwakerId
  end)
end

function AwakerBackTrackComp:IsBanBlack(selectAwakerId)
  local noGiveBackAwakersList = DT.GetOriginalConstant("NoGiveBackAwakers")
  for _, awakerId in ipairs(noGiveBackAwakersList) do
    if awakerId == selectAwakerId then
      return true
    end
  end
  return false
end

function AwakerBackTrackComp:LevelBackTrackConditionMatch()
  local lv = self.model:GetAwakerLevel(self.model.selectAwakerId)
  local awaker = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
  local skillHasUp = false
  for _, slotIndex in pairs(CommonDefine.AwakerSkillSlot) do
    local level = AwakerDataUtils.GetSkillSlotLevel(self.model.selectAwakerId, slotIndex)
    skillHasUp = level > 1 and true or false
    if skillHasUp then
      break
    end
  end
  local talentHasUp = false
  for talentTid, talentData in pairs(awaker.talents or {}) do
    if AwakerTalentExtModel.Instance:CheckTalentDefaultActivation(talentTid) then
    elseif talentData.lv and talentData.lv > 0 then
      talentHasUp = true
      break
    end
  end
  return lv > 1 or skillHasUp or talentHasUp
end

function AwakerBackTrackComp:LevelBackTrackConfirm(callback)
  if not self:LevelBackTrackConditionMatch() then
    Alert.Show(20115)
  elseif callback then
    callback()
  end
end

function AwakerBackTrackComp:PotencyBackTrackConfirm(callback)
  if self:GetPotencyCount() <= 0 then
    Alert.Show(201151)
  elseif callback then
    callback()
  end
end

function AwakerBackTrackComp:GetPotencyCount()
  local awaker = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
  local potencyLevel = awaker and awaker.potencyLevel or 0
  local chipCount = AwakerDataUtils.GetChipCount(self.model.selectAwakerId)
  return potencyLevel + chipCount
end

function AwakerBackTrackComp:PreviewRewardByTag(tag)
  local function callback()
    local list = self.backTrackModel:GetRewardPreview(tag)
    
    UIManager.Instance:Reopen(Urls.BackTrackAwardPreviewPanel, list)
  end
  
  self.backTrackModel:ReqPreviewAwakerBacktrackItems(callback)
end

function AwakerBackTrackComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerBackTrackComp:GetOpenAnim()
  return "UI_Awaker_Panel_Main_Minihead_Item_Preview_Open"
end

function AwakerBackTrackComp:GetCloseAnim()
  return "UI_Awaker_Panel_Main_Minihead_Item_Preview_Close"
end

function AwakerBackTrackComp:GetEnterDetailAnim()
end

function AwakerBackTrackComp:GetExitDetailAnim()
end

function AwakerBackTrackComp:OnOpen()
  self.ui.uiNode:SetActive(true)
  print("------------------open", self.__name)
  if self.model:HasOwnedSelectAwaker() then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name, 81370)
  end
end

function AwakerBackTrackComp:OnClose()
  self.ui.uiNode:SetActive(false)
end

function AwakerBackTrackComp:OnEnterDetail()
end

function AwakerBackTrackComp:OnExitDetail()
end

function AwakerBackTrackComp:OnOpenAnimFinish()
end

function AwakerBackTrackComp:OnCloseAnimFinish()
end

function AwakerBackTrackComp:OnEnterDetailAnimFinish()
end

function AwakerBackTrackComp:OnExitDetailAnimFinish()
end

return AwakerBackTrackComp
