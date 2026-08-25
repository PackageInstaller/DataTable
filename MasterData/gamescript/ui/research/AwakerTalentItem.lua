local AwakerTalentItem, Super = System.NewComponent("AwakerTalentItem")

function AwakerTalentItem:ctor(gameObj, model, talentCfgId, awakerCfgId, bCanOperate)
  Super.ctor(self)
  self.ui = UI_Research_Panel_Ceri_ItemResource(gameObj)
  self.model = model
  self.talentCfgId = talentCfgId
  self.awakerCfgId = awakerCfgId
  self.bCanOperate = bCanOperate
end

function AwakerTalentItem:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Dis, System.fn(self, self.Islocked))
  binder:BindToVisible(self.ui.Text_C_NoeGet, System.fn(self, self.NotOwnAwaker))
  binder:BindToVisible(self.ui.Group_Head_Dis, System.fn(self, self.Islocked))
  binder:BindToVisible(self.ui.UI_Common_Btn_Small_240x90, System.fn(self, self.IsShowUnlockBtn))
  binder:BindToVisible(self.ui.Group_Nor, System.fn(self, self.IsUnlocked))
  binder:BindToText(self.ui.Text_Title_Normal, System.fn(self, self.GetSkillTitle))
  binder:BindToText(self.ui.Text_Info_Normal, System.fn(self, self.GetSkillDesc))
  binder:BindToText(self.ui.Text_Name, System.fn(self, self.GetOwnerName))
  binder:BindToText(self.ui.Text_Title_Dis, System.fn(self, self.GetSkillTitle))
  binder:BindToText(self.ui.Text_Info_Dis, System.fn(self, self.GetSkillDesc))
  binder:BindToImage(self.ui.Image_Awaker, System.fn(self, self.GetSkillIcon))
  binder:BindToImage(self.ui.Image_D_Quality_Color, System.fn(self, self.GetSkillQualityFrame))
  if self.bCanOperate then
    binder:BindZ1Button(self.ui.UI_Common_Btn_Small_240x90, System.fn(self, self.UnlockTalent))
    if self:NotOwnAwaker() then
      binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.ClickTipsWhenNotOwnAwaker))
    end
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, System.fn(self, self.ShowTalentUnlockRedDot)))
  end
end

function AwakerTalentItem:ShowTalentUnlockRedDot()
  do return TalentDataUtils.IsTalentCanUnlock end
  return TalentDataUtils.IsTalentCanUnlock, self.talentCfgId
end

function AwakerTalentItem:UnlockTalent()
  UIManager.Instance:Reopen(Urls.TalentUnlockPanel, self.talentCfgId, self.awakerCfgId)
end

function AwakerTalentItem:Islocked()
  do return TalentDataUtils.IsTalentlocked end
  return TalentDataUtils.IsTalentlocked, self.talentCfgId
end

function AwakerTalentItem:IsUnlocked()
  return not self:Islocked()
end

function AwakerTalentItem:ClickTipsWhenNotOwnAwaker()
  do return Alert.Show end
  return Alert.Show, 10596
end

function AwakerTalentItem:GetSkillTitle()
  do return TalentDataUtils.GetSpecialSkillTitle end
  return TalentDataUtils.GetSpecialSkillTitle, self.talentCfgId
end

function AwakerTalentItem:GetSkillDesc()
  do return TalentDataUtils.GetSpecialSkillDesc end
  return TalentDataUtils.GetSpecialSkillDesc, self.talentCfgId
end

function AwakerTalentItem:GetOwnerName()
  do return TalentDataUtils.GetSpecialSkillOwnerName end
  return TalentDataUtils.GetSpecialSkillOwnerName, self.talentCfgId
end

function AwakerTalentItem:GetSkillIcon()
  do return TalentDataUtils.GetSpecialSkillAwakerIcon end
  return TalentDataUtils.GetSpecialSkillAwakerIcon, self.talentCfgId
end

function AwakerTalentItem:GetSkillQualityFrame()
  do return TalentDataUtils.GetSpecialSkillOwnerQualityFrame end
  return TalentDataUtils.GetSpecialSkillOwnerQualityFrame, self.talentCfgId
end

function AwakerTalentItem:NotOwnAwaker()
  return not self:HasAwaker()
end

function AwakerTalentItem:HasAwaker()
  do return AwakerDataUtils.HasOwnedAwaker end
  return AwakerDataUtils.HasOwnedAwaker, self.awakerCfgId
end

function AwakerTalentItem:IsShowUnlockBtn()
  return self:HasAwaker() and self:Islocked() and self.bCanOperate
end

function AwakerTalentItem:_IsNewVisible()
  local redDataType = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.AwakerSpecialSkill, {
    self.data.tid,
    self.data.awaker
  })
  return redDataType and redDataType == RedPointDataUtils.RedAttrType.IsNew
end

return AwakerTalentItem
