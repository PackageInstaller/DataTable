local SocialAchieveKey = SocialDefine.SocialAchieveKey
local SocialRelationType = SocialDefine.SocialRelationType
local StageGroupType = CommonDefine.StageGroupType
local SocialSubType = RedTypeDefine.SocialSubType
local SocialPlayerOverviewLeftComp, Super = System.NewComponent("SocialPlayerOverviewLeftComp")

function SocialPlayerOverviewLeftComp:ctor(res, model)
  Super.ctor(self)
  self.ui = UI_Social_Item_Data_Overview_LeftResource(res)
  self.model = model
  self.headComp = nil
end

function SocialPlayerOverviewLeftComp:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name)
  self:_BindBasicInfo(binder)
  self:_BindBirthInfo(binder)
  self:_BindNote(binder)
  self:_SetStatisticsInfo(binder)
  self:_BindHead(binder)
  self:_SetStageProgressInfo(binder)
  self:_BindWhenAttentionChange(binder)
  self:_BindGenderInfo(binder)
end

function SocialPlayerOverviewLeftComp:_BindGenderInfo(binder)
  binder:SetActive(self.ui.Btn_Gender, self.model.isMyInfo)
  if self.model.isMyInfo then
    binder:BindButtonClick(self.ui.Btn_Gender, System.fn(self, self._OnClickBtnGender))
    binder:BindToText(self.ui.Text_Gender, function()
      do return LT.Text, PlayerDataUtils.GetGenderName() end
      return LT.Text, PlayerDataUtils.GetGenderName()
    end)
  else
    binder:BindToText(self.ui.Text_Gender, function()
      return self.model.playerInfoData and LT.Text(PlayerDataUtils.GetGenderName(self.model.playerInfoData.facade.gender)) or ""
    end)
  end
end

function SocialPlayerOverviewLeftComp:_BindWhenAttentionChange(binder)
  binder:BindToRaw(function(cBinder, newRelation, oldRelation)
    if type(oldRelation) ~= "number" or type(newRelation) ~= "number" then
      return
    end
    if not self.model.playerInfoData then
      return
    end
    if SocialDataUtils.CheckIsAttentionRelation(newRelation) and not SocialDataUtils.CheckIsAttentionRelation(oldRelation) then
      local newPlayerInfoData = table.clone(self.model.playerInfoData)
      newPlayerInfoData.followerNum = newPlayerInfoData.followerNum + 1
      self.model:UpdatePlayerInfoData(newPlayerInfoData)
    elseif SocialDataUtils.CheckIsAttentionRelation(oldRelation) and not SocialDataUtils.CheckIsAttentionRelation(newRelation) then
      local newPlayerInfoData = table.clone(self.model.playerInfoData)
      newPlayerInfoData.followerNum = math.max(0, (newPlayerInfoData.followerNum or 0) - 1)
      self.model:UpdatePlayerInfoData(newPlayerInfoData)
    end
    self.binder:SetText(self.ui.Text_FansNum, self.model:GetFansNum())
  end, function()
    do return self.model.GetRelation end
    return self.model.GetRelation, self.model
  end)
end

function SocialPlayerOverviewLeftComp:_SetBasicInfo(binder)
  binder:SetText(self.ui.Text_LvNum, self.model:GetLevel())
  binder:SetText(self.ui.Text_ExpNow, self.model:GetCurrExp())
  binder:SetText(self.ui.Text_ExpGross, self.model:GetExpUpperLimit())
  binder:SetText(self.ui.Text_FansNum, self.model:GetFansNum())
  binder:SetText(self.ui.Text_ExpAccelerates, LT.Textf("SocialSourcePanelAccelerateTips", PlayerDataUtils.GetExpBonusPercent()))
  binder:SetText(self.ui.Text_Concern2Num, self.model:GetAttentionNum())
  binder:SetActive(self.ui.Text_ExpLine, not self.model:IsMaxPlayerLevel())
end

function SocialPlayerOverviewLeftComp:UpdateOnceSetUI()
  local binder = self.binder
  self:_SetBasicInfo(binder)
  self:_SetStatisticsInfo(binder)
  self:_SetStageProgressInfo(binder)
end

function SocialPlayerOverviewLeftComp:_BindBasicInfo(binder)
  self:_SetBasicInfo(binder)
  binder:BindToSliderValue(self.ui.Slider_Exp, System.fn(self, self._GetExpPercent))
  binder:BindToText(self.ui.Text_Fan_Number, System.fn(self, self._GetTotalGoodNum))
  binder:BindToRaw(function(_, tbl)
    local names = tbl[1]
    local playerName = tbl[2]
    local showName = self.model.isMyInfo and playerName or names.realName
    binder:SetText(self.ui.Text_Name, showName)
    if names.nickName and names.nickName ~= "" then
      binder:SetActive(self.ui.Group_NickName, true)
      binder:SetText(self.ui.Text_NickName, names.nickName)
    else
      binder:SetActive(self.ui.Group_NickName, false)
    end
  end, function()
    return {
      self:_GetName(),
      DataCenter.playerData.DRole.name
    }
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_like, System.fn(self, self._OnClickLike), System.fn(self, self._GetLikeBtnState))
  binder:BindZ1Button(self.ui.Btn_ExpAccelerates, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, ActivityDataUtils.GetDiamondRechargeRuleTitle(), ActivityDataUtils.GetDiamondRechargeRuleContent(LT.Text("PlayerExpRuleContent")))
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_3, nil, nil, function()
    if not self.model.isMyInfo then
      return false
    end
    do return SocialRedUtils.GetSocialRed end
    return SocialRedUtils.GetSocialRed, {
      RedTypeDefine.SocialSubType.NewGoodRecord
    }, RedTypeDefine.SocialSubType.NewGoodRecord
  end))
  binder:BindButtonClick(self.ui.Btn_Ban, System.fn(self, self.OnBtnBan))
  binder:BindToVisible(self.ui.Btn_Ban, function()
    if self.model.isMyInfo then
      return false
    end
    local relation = self.model:GetRelation()
    local relaType = SocialDefine.SocialRelationType
    return relation == relaType.UnAtten or relation == relaType.MyFans
  end)
  binder:BindToRaw(function(childBinder, isMyInfo)
    childBinder:SetActive(self.ui.UI_Common_Btn_Redact_Name, isMyInfo)
    childBinder:SetActive(self.ui.ExpAccelerates, isMyInfo)
    childBinder:SetActive(self.ui.Btn_Attention, not isMyInfo)
    if isMyInfo then
      childBinder:BindZ1Button(self.ui.UI_Common_Btn_Redact_Name, function()
        self.model:RequestNextRenameTimestamp(function(nextRenameTimestamp)
          local timeToNextRename = nextRenameTimestamp - TimeUtils.GetServerTime()
          if timeToNextRename > 0 then
            local tipCfg = DT.TipsType[10622]
            local hour, min = TimeUtils.SecToHourMin(timeToNextRename)
            Alert.ShowStr(LT.Textf(tipCfg.Desc, hour, min))
            return
          end
          UIManager.Instance:Reopen(Urls.RenamePanel, self.model)
        end)
      end)
    else
      self:_TurnArrowImage(true)
      childBinder:BindZ1Button(self.ui.Btn_Attention, function()
        local relation = self.model:GetRelation()
        if relation == SocialRelationType.UnAtten or relation == SocialRelationType.MyFans then
          SocialDataUtils.ReqOnSocialAttention(self.model:GetUid(), function(_)
            local newRelation = SocialRelationType.Atten
            if relation == SocialRelationType.MyFans then
              newRelation = SocialRelationType.Cor
            end
            self.model:UpdateRelation(newRelation)
          end)
        else
          self:_TurnArrowImage(false)
          local dropGroupData = self.model:GetRelationDropDatas(self.ui.Btn_Attention, System.fn(self, self._TurnArrowImage))
          childBinder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), SocialPlayerListDropItem, UI_Social_Dropdown_GroupResource, dropGroupData)
        end
      end, function()
        local relation = self.model:GetRelation()
        if relation == SocialRelationType.UnAtten or relation == SocialRelationType.MyFans then
          return CommonDefine.BtnType.Normal
        else
          return CommonDefine.BtnType.Unclickable
        end
      end, function()
        local relation = self.model:GetRelation()
        if relation == SocialRelationType.Atten then
          do return LT.Text end
          return LT.Text, "SocialSystemFollowed"
        elseif relation == SocialRelationType.Cor then
          do return LT.Text end
          return LT.Text, "SocialSystemInterrelated"
        elseif relation == SocialRelationType.Ban then
          do return LT.Text end
          return LT.Text, "TextBanned"
        end
        return ""
      end)
    end
  end, function()
    return self.model.isMyInfo
  end)
end

function SocialPlayerOverviewLeftComp:OnBtnBan()
  SocialDataUtils.Ban(self.model:GetUid())
end

function SocialPlayerOverviewLeftComp:_BindBirthInfo(binder)
  binder:BindToText(self.ui.Text_BirthdayTime, System.fn(self, self._GetBirth))
  binder:BindToVisible(self.ui.Text_C_Notset, function()
    local birth = self:_GetBirth()
    return not birth or "" == birth
  end)
  binder:BindToRaw(function(childBinder, showBirthBtn)
    childBinder:SetActive(self.ui.UI_Common_Btn_Redact_Time, showBirthBtn)
    childBinder:BindComponent(RedDotComponent(self.ui.Com_RedDot_2, nil, nil, function()
      if not showBirthBtn or not self.model.isMyInfo then
        return
      end
      do return SocialRedUtils.GetSocialRed end
      return SocialRedUtils.GetSocialRed, {
        SocialSubType.Birthday
      }, SocialSubType.Birthday
    end))
    if showBirthBtn then
      childBinder:BindZ1Button(self.ui.UI_Common_Btn_Redact_Time, function()
        local key = SocialRedUtils.GetSocialBirtyRedCacheKey()
        local birthRed = MobileFileDataManager.Instance:GetPlayerFileValue(key)
        if not birthRed then
          SocialRedUtils.RemoveSocialRed(SocialSubType.Birthday)
        end
        UIManager.Instance:Reopen(Urls.SocialPlayerSetBirthPanel, self.model.playerInfoData.facade.birthday, function(month, day)
          self.model:SetBirthday(month, day)
        end)
      end)
    end
  end, function()
    if not self.model.isMyInfo then
      return false
    end
    local birthday = self.model:GetBirth()
    return not birthday or "" == birthday
  end)
end

function SocialPlayerOverviewLeftComp:_BindHead(binder)
  binder:BindToRaw(function(cbinder, data)
    if not data then
      return
    end
    local icon = data.icon
    local frame = data.frame
    if self.headComp then
      self.headComp.binder:teardown()
    end
    self.headComp = cbinder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
      clickCb = function()
        if not self.model.isMyInfo then
          return
        end
        UIManager.Instance:Reopen(Urls.SocialPlayerSetAvatarPanel, icon, frame, function(avatar, avatarFrame, itemSubType)
          if itemSubType == CommonDefine.ItemSubType.PlayerAvatar then
            self.model:SetAvatar(avatar)
          elseif itemSubType == CommonDefine.ItemSubType.AvatarFrame then
            self.model:SetAvatarFrame(avatarFrame)
          end
        end)
      end,
      redFunc = function()
        if not self.model.isMyInfo then
          return
        end
        return SocialRedUtils.GetSocialRed({
          SocialSubType.Avatar
        }) or SocialRedUtils.GetSocialRed({
          SocialSubType.AvatarFrame
        })
      end,
      headIcon = ItemDataUtils.GetAvatarIcon(icon),
      frameIcon = ItemDataUtils.GetItemIcon(frame)
    })))
  end, function()
    if not self.model.playerInfoData then
      return
    end
    local icon = self.model.isMyInfo and DataCenter.playerData.DRole.icon or self.model.playerInfoData.facade.icon
    local frame = self.model.isMyInfo and DataCenter.playerData.DRole.avatarFrame or self.model.playerInfoData.facade.avatarFrame
    return {icon = icon, frame = frame}
  end)
end

function SocialPlayerOverviewLeftComp:_BindNote(binder)
  self.binder:BindToText(self.ui.Text_Account, function()
    do return self.model.GetNote end
    return self.model.GetNote, self.model
  end)
  self.binder:BindToText(self.ui.Text_Account_Tip, function()
    do return self.model.GetPlaceHolderText end
    return self.model.GetPlaceHolderText, self.model
  end)
  self.binder:BindToVisible(self.ui.Text_Account_Tip, function()
    do return string.isempty, self.model:GetNote() end
    return string.isempty, self.model:GetNote()
  end)
  self.binder:BindToVisible(self.ui.Text_Account, function()
    do return self.model.GetNote end
    return self.model.GetNote, self.model
  end)
  binder:BindToRaw(function(childBinder, isMyInfo)
    childBinder:SetActive(self.ui.UI_Common_Btn_Redact_Synopsis, isMyInfo)
    if isMyInfo then
      childBinder:BindZ1Button(self.ui.UI_Common_Btn_Redact_Synopsis, function()
        UIManager.Instance:Reopen(Urls.SocialPlayerSetNotePanel, self.model.playerInfoData.facade.note, function(note)
          self.model:SetNote(note)
        end)
      end)
    end
  end, function()
    return self.model.isMyInfo
  end)
end

function SocialPlayerOverviewLeftComp:_SetStatisticsInfo(binder)
  binder:SetText(self.ui.Text_AwakerNum, self.model:GetAchieveValue(SocialAchieveKey.AwakerNum))
  binder:SetText(self.ui.Text_ConcludeNum, self.model:GetAchieveValue(SocialAchieveKey.AchieveNum))
  binder:SetText(self.ui.Text_RegisterNum, self.model:GetAchieveValue(SocialAchieveKey.LoginDay))
  binder:SetText(self.ui.Text_AssistNum, self.model:GetAchieveValue(SocialAchieveKey.AssistNum))
  binder:SetText(self.ui.Text_CollectionNum, self.model:GetCollectionCount())
end

function SocialPlayerOverviewLeftComp:_SetStageProgressInfo(binder)
  binder:SetActive(self.ui.UI_Common_Btn_Redact_Team, true)
  binder:SetActive(self.ui.Image_Null, false)
  binder:SetActive(self.ui.Image_Situation, true)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Redact_Team, function()
    UIManager.Instance:Reopen(Urls.SocialStageProgressTipsPanel, self.model.playerInfoData.facade.achieve, self.ui.Situation_Tips)
  end)
  binder:SetText(self.ui.Text_DifficultyNum, self.model:GetMainStageProgress(SocialAchieveKey.Main1))
  binder:SetText(self.ui.Text_HardDifficultyNum, self.model:GetMainStageProgress(SocialAchieveKey.Main2))
  binder:SetText(self.ui.Text_DreamNum, self.model:GetAchieveValue(SocialAchieveKey.DailyChallengeLifeMaxScore))
  binder:SetText(self.ui.Text_PagodaNum, self.model:GetSchoolTowerTotalStar(StageGroupType.DisposableSchoolTower))
  binder:SetText(self.ui.Text_AbyssNum, self.model:GetAchieveValue(SocialAchieveKey.AbyssChallengeLifeMaxScore))
end

function SocialPlayerOverviewLeftComp:_GetExpPercent()
  do return self.model.GetExpPercent end
  return self.model.GetExpPercent, self.model
end

function SocialPlayerOverviewLeftComp:_GetAvatar()
  do return self.model.GetAvatar end
  return self.model.GetAvatar, self.model
end

function SocialPlayerOverviewLeftComp:_GetName()
  do return self.model.GetRoleName end
  return self.model.GetRoleName, self.model
end

function SocialPlayerOverviewLeftComp:_GetBirth()
  do return self.model.GetBirth end
  return self.model.GetBirth, self.model
end

function SocialPlayerOverviewLeftComp:_GetNote()
  do return self.model.GetNote end
  return self.model.GetNote, self.model
end

function SocialPlayerOverviewLeftComp:_GetTotalGoodNum()
  do return self.model.GetTotalGoodNum end
  return self.model.GetTotalGoodNum, self.model
end

function SocialPlayerOverviewLeftComp:_GetLikeBtnState()
  if self.model.isMyInfo then
    return CommonDefine.BtnType.Normal
  end
  if self.model.playerInfoData and SocialDataUtils.HasOfferLike(self.model.playerInfoData.facade.uid) then
    return CommonDefine.BtnType.Unclickable
  end
  return CommonDefine.BtnType.Normal
end

function SocialPlayerOverviewLeftComp:_TurnArrowImage(isUp)
  if isUp then
    CS.Framework.TransformUtil.SetLocalScale(self.ui.Image_Arror.transform, 1, -1, 1)
  else
    CS.Framework.TransformUtil.SetLocalScale(self.ui.Image_Arror.transform, 1, 1, 1)
  end
end

function SocialPlayerOverviewLeftComp:_OnClickLike()
  if self.model.isMyInfo then
    if SocialRedUtils.GetSocialRed({
      SocialSubType.NewGoodRecord
    }) then
      SocialRedUtils.RemoveSocialRed(SocialSubType.NewGoodRecord)
    end
    UIManager.Instance:Reopen(Urls.SocialPlayerLikeRecordListPanel)
  else
    local uid = self.model.playerInfoData.facade.uid
    if SocialDataUtils.HasOfferLike(uid) then
      Alert.Show(10750)
      return
    end
    
    local function callback()
      Alert.Show(10747)
      self.model:AddLikeNum(1)
      SocialDataUtils.AddLikeRecord(uid, 1, nil)
    end
    
    SocialDataUtils.ReqOnSocialGood(uid, 1, SocialDefine.GoodReason.Social, callback)
  end
end

function SocialPlayerOverviewLeftComp:_OnClickBtnGender()
  GenderDataUtils.ChangeGender()
end

return SocialPlayerOverviewLeftComp
