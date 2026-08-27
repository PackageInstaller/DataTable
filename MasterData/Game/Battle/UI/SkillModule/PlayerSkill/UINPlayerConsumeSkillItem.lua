local UINPlayerConsumeSkillItem = class("UINPlayerConsumeSkillItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINPlayerConsumeSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_CD.enabled = false
  self.ui.btnPlus_Root.onClick:AddListener(BindCallback(self, self.__OnSkillClicked))
  self.ui.btnPlus_Root.onPress:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btnPlus_Root.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
end

function UINPlayerConsumeSkillItem:InitPlayerConsumeSkillItem(battleSkill, clickFunc, longPressFunc, pressUpFunc, pressDownFunc)
  self.battleSkill = battleSkill
  self.skillId = battleSkill.dataId
  self.clickFunc = clickFunc
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.pressDownFunc = pressDownFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  self.isCanUse = true
  local battleSkillCfg = self.battleSkill.skillCfg
  self:RefreshData(battleSkillCfg)
end

function UINPlayerConsumeSkillItem:InitPlayerConsumeSkillJustShow(battleSkillCfg)
  self.skillId = battleSkillCfg.Id
  self.isCanUse = true
  self:RefreshData(battleSkillCfg)
end

function UINPlayerConsumeSkillItem:SetCantUse(bValue, tipId)
  self.isCanUse = bValue
  self.notCanUseTipId = tipId
end

function UINPlayerConsumeSkillItem:RefreshData(battleSkillCfg)
  local spriteIcon = CRH:GetSprite(battleSkillCfg.Icon, CommonAtlasType.SkillIcon)
  self.ui.img_SkillIcon.sprite = spriteIcon
  local skillTag = battleSkillCfg.SkillTag
  self.ui.img_SkillTypeLine:SetIndex(skillTag)
  self.ui.img_SkillType:SetIndex(skillTag)
  self.ui.img_SkillType.image.color = eBattleSkillTypeColor[battleSkillCfg.TypeColor]
end

function UINPlayerConsumeSkillItem:OnUpdateLogic_PlayerConsumeSkillItem()
  local skill = self.battleSkill
  local canUseTime = skill.useLimitTime - skill.curUseTime
  if self.canUseTime ~= canUseTime then
    self.canUseTime = canUseTime
    if self.canUseTime <= 0 then
      self:Hide()
    else
      self:Show()
    end
  end
  if not self.isCanUse then
    self.ui.img_CD.enabled = true
    self.curCDRatio = 1
    self.nextCDRatio = 1
    self.ui.img_CD.fillAmount = self.curCDRatio
    return
  end
  if not self.isSkillNoCD then
    local skill = self.battleSkill
    if skill:IsReadyToTake() then
      self.ui.img_CD.enabled = false
    else
      self.ui.img_CD.enabled = true
      self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
      self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
      self.ui.img_CD.fillAmount = self.curCDRatio
    end
  end
end

function UINPlayerConsumeSkillItem:OnUpdateRender_PlayerConsumeSkillItem(deltaTime, interpolation)
  if not self.isSkillNoCD and self.ui.img_CD.enabled then
    self.ui.img_CD.fillAmount = Mathf.Lerp(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

function UINPlayerConsumeSkillItem:__OnSkillClicked()
  if BattleUtil.IsBattleInPause() then
    return
  end
  if not self.isCanUse then
    local castTip = ConfigData:GetTipContent(self.notCanUseTipId)
    if string.IsNullOrEmpty(castTip) then
      castTip = ConfigData:GetTipContent(TipContent.SkillSelectUnavailableTips)
    end
    cs_MessageCommon.ShowMessageTips(castTip)
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.battleSkill)
  end
end

function UINPlayerConsumeSkillItem:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.battleSkill)
  end
end

function UINPlayerConsumeSkillItem:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
end

function UINPlayerConsumeSkillItem:SetSkillBtnEnabled(enabled)
  self.ui.btnPlus_Root.enabled = enabled
end

function UINPlayerConsumeSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINPlayerConsumeSkillItem
