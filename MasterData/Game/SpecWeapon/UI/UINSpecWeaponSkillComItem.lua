local UINSpecWeaponSkillComItem = class("UINSpecWeaponSkillComItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINSpecWeaponSkillComItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.obj_uINSkillItem)
  self.ui.btn_ShowIntro.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_ShowIntro, self, self.__OnClickIntro)
  self.ui.btn_StartCD.onPressDown:AddListener(BindCallback(self, self.__OnPressSkill))
  self.ui.btn_StartCD.onPressUp:AddListener(BindCallback(self, self.__OnPressSkillUp))
  self._initPos = self.transform.localPosition
end

function UINSpecWeaponSkillComItem:InjectSpecWeaponSkillComItem(onLongPressAction, onLongPressUpAction, openInfoNodeCallback)
  self._onLongPressAction = onLongPressAction
  self._onLongPressUpAction = onLongPressUpAction
  self._openInfoNodeCallback = openInfoNodeCallback
end

function UINSpecWeaponSkillComItem:InitSpecWeaponSkillComItem(skillData, resloader)
  self.ui.canvasGroup_root.alpha = 1
  self.transform.localPosition = self._initPos
  self.skillData = skillData
  self.resloader = resloader
  self.type = skillData:GetSkillTag()
  self:UpgradeUnlockSillInfo()
  local active = skillData:HaveSkillLabeId()
  self.ui.btn_ShowIntro.gameObject:SetActive(active)
  local skillCD = skillData:GetCurrentSkillCDTime()
  if skillCD == 0 then
    self.ui.obj_skillCD:SetActive(false)
  else
    self.ui.obj_skillCD:SetActive(true)
    self.ui.tex_skillCD:SetIndex(0, GetPreciseDecimalStr(skillCD, 1))
  end
  self.ui.btn_StartCD.gameObject:SetActive(false)
  if self.type == HeroSkillUpgradeEnum.SkillType.active then
    local currntHeroStar = skillData.heroData.star
    local skillStartCD = skillData:GetStartSkillCDTime(currntHeroStar)
    if skillStartCD == 0 then
      self.ui.btn_StartCD.gameObject:SetActive(false)
    else
      self.ui.btn_StartCD.gameObject:SetActive(true)
      self.ui.tex_StartCD:SetIndex(0, GetPreciseDecimalStr(skillStartCD, 1))
    end
  end
end

function UINSpecWeaponSkillComItem:PlaySpecWeaponTween()
  cs_DoTween.Restart(self.transform.gameObject)
end

function UINSpecWeaponSkillComItem:UpgradeUnlockSillInfo()
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  self.ui.tex_Name.text = self.skillData:GetName()
  self:UpdateSkillDescription()
  local isFullLevel = self.skillData:IsFullLevel()
  if isFullLevel then
    self.ui.tex_Lv:SetIndex(1)
  else
    self.ui.tex_Lv:SetIndex(0, tostring(self.skillData.level))
  end
  self.skillItem:InitBaseSkillItem(self.skillData, self.resloader)
  if self.type == nil or self.type == HeroSkillUpgradeEnum.SkillType.undefined then
    self.ui.img_type.color = self.ui.color_typeArry[4]
    self.ui.tex_Type:SetIndex(4)
    self.ui.tex_Tppe_En:SetIndex(4)
  else
    self.ui.img_type.color = self.ui.color_typeArry[self.type]
    local index = self.type - 1
    self.ui.tex_Type:SetIndex(index)
    self.ui.tex_Tppe_En:SetIndex(index)
  end
end

function UINSpecWeaponSkillComItem:UpdateSkillDescription()
  if self.skillData == nil then
    return
  end
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.skill)
  if self.skillData.level <= 0 then
    self.ui.tex_Descr.text = self.skillData:GetLevelDescribe(1, nil, isShowDetail)
  else
    self.ui.tex_Descr.text = self.skillData:GetLevelDescribe(self.skillData.level, nil, isShowDetail)
  end
end

function UINSpecWeaponSkillComItem:__OnClickIntro()
  if self._openInfoNodeCallback ~= nil then
    self._openInfoNodeCallback(self.skillData, self.ui.btn_ShowIntro.transform)
    AudioManager:PlayAudioById(1075)
  end
end

function UINSpecWeaponSkillComItem:__OnPressSkill()
  if self._onLongPressAction then
    self._onLongPressAction()
  end
end

function UINSpecWeaponSkillComItem:__OnPressSkillUp()
  if self._onLongPressUpAction then
    self._onLongPressUpAction()
  end
end

return UINSpecWeaponSkillComItem
