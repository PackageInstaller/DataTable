local MAX_SOCIAL_TIME = 30
local INTRO_MAX_SHOW_CHARA = 49
local GoodReason2Text = {
  [SocialDefine.GoodReason.Social] = LT.Text("GoodSourceSocial"),
  [SocialDefine.GoodReason.PVP] = LT.Text("GoodSourcePVP"),
  [SocialDefine.GoodReason.PvpCollectionComment] = LT.Text("LikeSourcePvpCollectionComment"),
  [SocialDefine.GoodReason.CollectionHallComment] = LT.Text("LikeSourceCollectionHallComment")
}
local SocialRelationListItem = NewClass("SocialRelationListItem")

function SocialRelationListItem:ctor(container)
  self.gameObject = container.gameObject
  self.data = nil
  self.binder = nil
  self.ui = UI_Awaker_Item_PlanetResource(container.gameObject)
end

function SocialRelationListItem:GetData()
  return self.data
end

function SocialRelationListItem:SetProxy(proxy)
  self.proxy = proxy
end

function SocialRelationListItem:SetData(data)
  self.data = data
  self.facade = data.facade
  self.socialListItemType = data.socialListItemType
  self.attentionCb = data.attentionCb
  self.likeRecord = data.likeRecord
  self.checkLikeStateFunc = data.checkLikeStateFunc
  self.likeCb = data.likeCb
end

function SocialRelationListItem:Dispose()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function SocialRelationListItem:SetBinder(binder)
  if self.parentBinder ~= binder and self.binder then
    self.binder:teardown()
    self.binder = nil
  end
  self.parentBinder = binder
  if not self.binder then
    self.binder = binder:createChild()
    binder:onDestroy(function()
      self.binder = nil
    end)
    self.binder:UpdateLocalizedTextAndResouce(self.ui.uiNode)
  end
  self.binder:clearChildren()
end

function SocialRelationListItem:OnActive()
  self:Refresh()
  self.binder:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self.UpdateWhenAttention))
  self.binder:BindEvent(EventMgr.Instance.SocialUnfollow, System.fn(self, self.Refresh))
end

function SocialRelationListItem:OnDeative()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function SocialRelationListItem:Refresh()
  if self.awakerPortraitComp then
    self.awakerPortraitComp.binder:teardown()
    self.awakerPortraitComp = nil
  end
  self:TurnArrowImage(true)
  self.ui.UI_Vx_Glow:SetActive(false)
  if not self.facade then
    return
  end
  self.binder:LoadAllLangFont(self.ui.Text_Name)
  self.binder:BindTimer(0.02, 0, nil, function()
    if SocialData.isUnfollowing then
      self.ui.Image_Selected:SetActive(SocialData.unfollowingList[self.facade.uid])
    end
  end)
  self:_OnBindPlayerInfo()
  self:_OnBindAwaker()
  self:_OnBindAttentionGroup()
  self:_OnBindVisitAndNewFansTime()
  self:_OnBindLikeRecord()
  self:_OnBindUnBan()
end

function SocialRelationListItem:_OnBindPlayerInfo()
  local binder, facade = self.binder, self.facade
  binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    clickCb = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, facade.uid)
    end,
    headIcon = ItemDataUtils.GetAvatarIcon(facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(facade.avatarFrame)
  })))
  binder:SetText(self.ui.Text_Lv, LT.Text(string.format("（Lv.%s）", facade.level)))
  binder:SetText(self.ui.Text_Name, LT.Text(SocialDataUtils.GetPlayerName(facade)))
  local node = facade.note
  if not node or "" == node then
    node = LT.Text("SocialSystemIntroductionNone")
  else
    node = StrUtils.TruncateChineseString(node, INTRO_MAX_SHOW_CHARA)
  end
  binder:SetText(self.ui.Text_Synopsis, LT.Text(node))
  binder:SetText(self.ui.Text_State, LT.Text(SocialDataUtils.GetPlayerStateDesc(facade.state)))
  if SocialDataUtils.CheckOffLineState(facade.state) then
    binder:SetImage(self.ui.Image_StateIcon, SocialDefine.SocialOnlineStateIconPath.OutLineIcon)
  else
    binder:SetImage(self.ui.Image_StateIcon, SocialDataUtils.GetPlayerStateIcon(facade.state))
  end
  binder:BindToVisible(self.ui.Image_Mutual, function()
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    return isCorrelations
  end)
  binder:BindToVisible(self.ui.Image_Love, function()
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    local isFollowers = facade.relation == SocialDefine.SocialRelationType.MyFans
    return not isCorrelations and isFollowers
  end)
end

function SocialRelationListItem:_OnBindVisitAndNewFansTime()
  local binder, facade = self.binder, self.facade
  binder:BindToVisible(self.ui.Text_Time, function()
    return self.socialListItemType ~= SocialDefine.SocialListItemType.ShowAssist
  end)
  if self.socialListItemType == SocialDefine.SocialListItemType.ShowVisited then
    binder:SetText(self.ui.Text_Time, self:GetVistedTime(facade.relationOccurTs))
  elseif self.socialListItemType == SocialDefine.SocialListItemType.ShowNewFans then
    binder:SetText(self.ui.Text_Time, self:GetNewFansTime(facade.relationOccurTs))
  elseif self.socialListItemType == SocialDefine.SocialListItemType.Ban then
    binder:SetText(self.ui.Text_Time, nil)
  end
end

function SocialRelationListItem:_OnBindUnBan()
  local isBanItem = self.socialListItemType == SocialDefine.SocialListItemType.Ban
  self.binder:SetActive(self.ui.Btn_Unblock, isBanItem)
  if not isBanItem then
    return
  end
  self.binder:BindButtonClick(self.ui.Btn_Unblock, function()
    SocialDataUtils.CancelBan(self.facade.uid, function()
      if not self.ui or not IsNil(self.ui.uiNode) then
        return
      end
    end)
  end)
end

function SocialRelationListItem:_OnBindLikeRecord()
  local binder, facade = self.binder, self.facade
  local showLike = self.socialListItemType == SocialDefine.SocialListItemType.ShowLikeRecord
  binder:SetActive(self.ui.UI_Common_Btn_like, showLike)
  if showLike then
    local function _OnReqLikeSucc(...)
      if self.likeCb then
        self.likeCb(...)
      end
      self.ui.UI_Vx_Glow:SetActive(false)
      self.ui.UI_Vx_Glow:SetActive(true)
    end
    
    local function _OnClickLike()
      if self.checkLikeStateFunc and self.checkLikeStateFunc() then
        Alert.Show(10750)
        return
      end
      SocialDataUtils.ReqOnSocialGood(facade.uid, 1, SocialDefine.GoodReason.Social, _OnReqLikeSucc)
    end
    
    local function _GetBtnState()
      if not self.checkLikeStateFunc or self.checkLikeStateFunc() then
        return CommonDefine.BtnType.Normal
      end
      return CommonDefine.BtnType.High
    end
    
    binder:BindZ1Button(self.ui.UI_Common_Btn_like, _OnClickLike, _GetBtnState)
    binder:SetText(self.ui.Text_Like, self:GetRecordText(facade.relationOccurTs, facade.goodReason))
    local sourceText = GoodReason2Text[facade.goodReason] or LT.Text("GoodSourceSocial")
    binder:SetText(self.ui.Text_Like_Reason, LT.Textf("SocializeAdmireReason", sourceText))
  end
  binder:SetActive(self.ui.Text_Like, showLike)
  binder:SetActive(self.ui.Text_Time, not showLike and self.socialListItemType ~= SocialDefine.SocialListItemType.ShowAssist)
end

function SocialRelationListItem:_OnBindAwaker()
  local binder, facade = self.binder, self.facade
  local assistAwakerData
  if facade and facade.team and facade.team.assistAwaker then
    assistAwakerData = facade.team.assistAwaker
  end
  if self.socialListItemType == SocialDefine.SocialListItemType.ShowAssist and assistAwakerData and assistAwakerData.tid and 0 ~= assistAwakerData.tid then
    binder:SetActive(self.ui.Assist_Awaker_Group, true)
    binder:SetActive(self.ui.Image_Role, true)
  else
    binder:SetActive(self.ui.Assist_Awaker_Group, false)
    binder:SetActive(self.ui.Image_Role, false)
    if self.ui.Image_PremiumCardFace then
      binder:SetActive(self.ui.Image_PremiumCardFace, false)
    end
    if self.ui.Image_AwakerFavor then
      binder:SetActive(self.ui.Image_AwakerFavor, false)
    end
    return
  end
  local awakerTid = assistAwakerData.tid
  local resNum
  if assistAwakerData.curSkin then
    resNum = AwakerSkinUtils.GetSkinResNum(assistAwakerData.curSkin)
  end
  local awakerCfg = DT.AwakerConfig[awakerTid]
  if not self.awakerPortraitComp then
    self.awakerPortraitComp = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, not resNum and awakerTid or nil, resNum, nil, CommonDefine.PortraitAlign.Center, nil, self.ui.Container_Awaker:GetComponent(typeof(CS.UIScreenSpaceMask))))
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
  binder:SetImage(self.ui.Image_Career_Icon, AwakerDataUtils.GetSchoolIcon(awakerCfg.School))
  if self.ui.Image_PremiumCardFace then
    binder:BindToVisible(self.ui.Image_PremiumCardFace, function()
      do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid end
      return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, assistAwakerData
    end)
  end
  if self.ui.Image_AwakerFavor then
    binder:BindToVisible(self.ui.Image_AwakerFavor, function()
      do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid end
      return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, assistAwakerData
    end)
  end
  binder:SetText(self.ui.Text_Awaker_Lv, LT.Text(string.format("Lv.%s", assistAwakerData.level)))
  binder:SetText(self.ui.Text_Awaker_Name, LT.Text(awakerCfg.Name))
  self:_OnBindAwakerSkill(binder, assistAwakerData)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local targetAwakerTid = data[1]
    local potencyLevel = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = targetAwakerTid, potencyLevel = potencyLevel}))
  end, function()
    return {
      awakerTid,
      assistAwakerData.potencyLevel
    }
  end)
  if assistAwakerData.talents then
    binder:SetText(self.ui.Txt_Talent, TalentDataUtils.GetDisplayTalentLvDesc(assistAwakerData.talents))
  end
  binder:BindButtonClick(self.ui.Image_Role, function()
    SocialDataUtils.ReqQueryAwaker(facade.uid, awakerTid, function(serverData)
      local awakerData = serverData.awaker
      local items = serverData.items
      local previewData = {
        items = items,
        awakers = {awakerData},
        hideAwakerChangeForm = true
      }
      local awakerBasePanelData = {
        jumpPage = CommonDefine.AwakerPage.Detail,
        previewAwakersData = previewData
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    end)
  end)
end

function SocialRelationListItem:_OnBindAwakerSkill(binder, assistAwakerData)
  local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({
    skills = assistAwakerData.slots
  })
  if specialSkill then
    table.sort(skillList, function(a, b)
      return a.slot < b.slot
    end)
    binder:SetText(self.ui.Text_Mad, specialSkill.level)
    for i = 1, #skillList do
      local ui = self.ui["Text_Skill_0" .. i]
      local skillData = skillList[i]
      if ui and skillData then
        binder:SetText(ui, "/" .. skillData.level or 1)
      end
    end
  else
    binder:SetText(self.ui.Text_Mad, "")
  end
end

function SocialRelationListItem:_OnBindAttentionGroup()
  local binder, facade = self.binder, self.facade
  if table.contains({
    SocialDefine.SocialListItemType.ShowAssist,
    SocialDefine.SocialListItemType.ShowNewFans
  }, self.socialListItemType) then
    binder:SetActive(self.ui.Btn_Attention, true)
  else
    binder:SetActive(self.ui.Btn_Attention, false)
    return
  end
  binder:BindZ1Button(self.ui.Btn_Attention, function()
    if SocialData.isUnfollowing then
      self.ui.Image_Selected:SetActive(SocialDataUtils.ToggleUnfollow(facade.uid))
      return
    end
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    local isMyAttention = facade.relation == SocialDefine.SocialRelationType.Atten
    local isBan = facade.relation == SocialDefine.SocialRelationType.Ban
    if isCorrelations or isMyAttention or isBan then
      self:TurnArrowImage(false)
      local dropGroupData = {
        dropList = {
          {
            text = LT.Text("FriendGame"),
            callback = function()
              FriendMatchMgr.Instance:LaunchFriendGame(facade)
            end,
            checkUnlockFunc = function()
              do return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance end
              return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance, facade
            end
          },
          {
            text = LT.Text("SocialSystemModifyRemarks"),
            callback = function()
              local panelData = {
                title = LT.Text("SocialSystemSetRemarks"),
                tips = LT.Textf("SocialSystemLeaveNoteName", SocialDataUtils.GetPlayerName(facade)),
                oriName = LT.Text(SocialDataUtils.GetPlayerName(facade, true)),
                confirmFunc = function(nickName, cb)
                  if "" == nickName then
                    SocialDataUtils.ReqOnCancelNote(facade.uid, function()
                      self:Refresh()
                      if cb then
                        cb()
                      end
                    end)
                  else
                    SocialDataUtils.ReqOnSocialNote(facade.uid, nickName, function()
                      local myPlayer = SocialDataUtils.GetMyPlayer()
                      if myPlayer and myPlayer.uid2NickName then
                        myPlayer.uid2NickName[facade.uid] = nickName
                        self:Refresh()
                      end
                      if cb then
                        cb()
                      end
                    end)
                  end
                end,
                inputFieldDefaultStr = LT.Text("SocialSystemEnterNoteName")
              }
              UIManager.Instance:Reopen(Urls.SocialRenamePanel, panelData)
            end
          }
        },
        parentNode = self.ui.Btn_Attention,
        maskClickFunc = function()
          self:TurnArrowImage(true)
        end
      }
      if facade.relation == SocialDefine.SocialRelationType.Ban then
        table.insert(dropGroupData.dropList, {
          text = LT.Text("TextCancelBan"),
          callback = function()
            SocialDataUtils.CancelBan(facade.uid)
          end
        })
      else
        table.insert(dropGroupData.dropList, {
          text = LT.Text("SocialSystemCancelFollow"),
          callback = function()
            local tipsId = 20102
            local tipsCfg = DT.TipsType[tipsId]
            Alert.Show(tipsId, nil, function()
              SocialDataUtils.ReqOnSocialCancelAttention(facade.uid, function(targetUid, newRelation)
                self:UpdateWhenAttention(targetUid, newRelation)
              end)
            end, nil, LT.Textf(tipsCfg.Desc, LT.Text(SocialDataUtils.GetPlayerName(facade))))
          end
        })
      end
      binder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), SocialPlayerListDropItem, UI_Social_Dropdown_GroupResource, dropGroupData)
      return
    end
    SocialDataUtils.ReqOnSocialAttention(facade.uid, function(newRelation)
      self:UpdateWhenAttention(facade.uid, newRelation)
    end)
  end, function()
    if SocialData.isUnfollowing then
      return CommonDefine.Z1ButtonState.High
    end
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    local isMyAttention = facade.relation == SocialDefine.SocialRelationType.Atten
    local isBan = facade.relation == SocialDefine.SocialRelationType.Ban
    if isCorrelations or isMyAttention or isBan then
      local content = isCorrelations and "SocialSystemInterrelated" or isMyAttention and "SocialSystemFollowed" or "TextBanned"
      self.binder:SetText(self.ui.Text_Interrelated, LT.Text(content))
      return CommonDefine.Z1ButtonState.Unclickable
    end
    return CommonDefine.Z1ButtonState.Normal
  end)
end

function SocialRelationListItem:UpdateWhenAttention(uid, newRelation)
  if uid == self.facade.uid and self.attentionCb then
    self.attentionCb(newRelation)
    self:Refresh()
  end
end

function SocialRelationListItem:TurnArrowImage(isUp)
  if isUp then
    CS.Framework.TransformUtil.SetLocalScale(self.ui.Image_Arrow_1.transform, 1, -1, 1)
  else
    CS.Framework.TransformUtil.SetLocalScale(self.ui.Image_Arrow_1.transform, 1, 1, 1)
  end
end

function SocialRelationListItem:GetVistedTime(timeStamp)
  local d, h, m = TimeUtils.GetSocialTime(timeStamp)
  if not d then
    return ""
  end
  if d >= 1 then
    do return LT.Textf, "SocialSystemVisitedDaysAgo", math.min(MAX_SOCIAL_TIME, math.floor(d)) end
    return LT.Textf, "SocialSystemVisitedDaysAgo", math.min(MAX_SOCIAL_TIME, math.floor(d))
  elseif h >= 1 then
    do return LT.Textf, "SocialSystemVisitedHoursAgo", math.floor(h) end
    return LT.Textf, "SocialSystemVisitedHoursAgo", math.floor(h)
  elseif m >= 1 then
    do return LT.Textf, "SocialSystemVisitedMinutesAgo", math.floor(m) end
    return LT.Textf, "SocialSystemVisitedMinutesAgo", math.floor(m)
  end
  do return LT.Text end
  return LT.Text, "SocialSystemJustVisited", math.floor(m)
end

function SocialRelationListItem:GetNewFansTime(timeStamp)
  local d, h, m = TimeUtils.GetSocialTime(timeStamp)
  if not d then
    return ""
  end
  if d >= 1 then
    do return LT.Textf, "Socialize_FollowTime_Day", math.min(MAX_SOCIAL_TIME, math.floor(d)) end
    return LT.Textf, "Socialize_FollowTime_Day", math.min(MAX_SOCIAL_TIME, math.floor(d))
  elseif h >= 1 then
    do return LT.Textf, "Socialize_FollowTime_Hour", math.floor(h) end
    return LT.Textf, "Socialize_FollowTime_Hour", math.floor(h)
  elseif m >= 1 then
    do return LT.Textf, "Socialize_FollowTime_Minute", math.floor(math.max(m)) end
    return LT.Textf, "Socialize_FollowTime_Minute", math.floor(math.max(m))
  end
  do return LT.Text end
  return LT.Text, "Socialize_FollowTime_JustNow", math.floor(math.max(m))
end

function SocialRelationListItem:GetRecordText(timeStamp, goodReason)
  local d, h, m = TimeUtils.GetSocialTime(timeStamp)
  if not d then
    return ""
  end
  if d >= 1 then
    do return LT.Textf, "SocializeAdmireTime_Day", math.floor(d) end
    return LT.Textf, "SocializeAdmireTime_Day", math.floor(d)
  elseif h >= 1 then
    do return LT.Textf, "SocializeAdmireTime_Hour", math.floor(h) end
    return LT.Textf, "SocializeAdmireTime_Hour", math.floor(h)
  elseif m >= 1 then
    do return LT.Textf, "SocializeAdmireTime_Minute", math.floor(math.max(m)) end
    return LT.Textf, "SocializeAdmireTime_Minute", math.floor(math.max(m))
  end
  do return LT.Text end
  return LT.Text, "SocializeAdmireTime_JustNow", math.floor(math.max(m))
end

return SocialRelationListItem
