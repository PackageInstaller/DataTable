local UINHeroSkillUpgradeItem = class("UINHeroSkillUpgradeItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")

function UINHeroSkillUpgradeItem:OnInit()
  self.isInited = false
  self.couldUpgrade = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.obj_uINSkillItem)
  self.StarList = {}
  table.insert(self.StarList, self.ui.img_star)
  self.ui.btn_ShowIntro.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_CanLevelUp, self, self.OnClilck)
  UIUtil.AddButtonListener(self.ui.btn_skillUpgradeItem, self, self.OnClilck)
  UIUtil.AddButtonListener(self.ui.btn_ShowIntro, self, self.OnShowIntroClick)
  self.onDescribeSettingChange = BindCallback(self, self._OnDescribeSettingChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
end

function UINHeroSkillUpgradeItem:InitSkillItem(skillData, resloader, type, OpenInfoNodeCallback)
  self.isInited = true
  self.couldUpgrade = false
  self.skillData = skillData
  self.resloader = resloader
  self.type = type
  self.OpenInfoNodeCallback = OpenInfoNodeCallback
  if skillData == nil then
    self.ui.obj_base:SetActive(false)
    self.ui.obj_notGet:SetActive(not CS.ClientConsts.IsAudit)
    self.ui.btn_ShowIntro.gameObject:SetActive(false)
    return
  else
    self.ui.obj_base:SetActive(true)
    self.ui.obj_notGet:SetActive(false)
  end
  if skillData:GetIsUnlock() then
    self.ui.obj_lock:SetActive(false)
    self:UpgradeUnlockSillInfo()
  else
    self.ui.obj_blueDot:SetActive(false)
    self.ui.obj_lock:SetActive(true)
    self:UpgradeLockedSillInfo()
  end
  local active = skillData:HaveSkillLabeId()
  self.ui.btn_ShowIntro.gameObject:SetActive(active)
  local skillCD = skillData:GetCurrentSkillCDTime()
  if skillCD == 0 then
    self.ui.obj_skillCD:SetActive(false)
  else
    self.ui.obj_skillCD:SetActive(true)
    self.ui.tex_skillCD:SetIndex(0, GetPreciseDecimalStr(skillCD, 1))
  end
  self.ui.btn_StartCD.onPressDown:AddListener(BindCallback(self, self.__OnItemLongPress))
  self.ui.btn_StartCD.onPressUp:AddListener(BindCallback(self, self.__OnItemPressUp))
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

function UINHeroSkillUpgradeItem:__OnItemLongPress()
  if self.__onLongPressAction ~= nil then
    self.__onLongPressAction()
  end
end

function UINHeroSkillUpgradeItem:__OnItemPressUp()
  if self.__onLongPressUpAction ~= nil then
    self.__onLongPressUpAction()
  end
end

function UINHeroSkillUpgradeItem:InjectLongPressFunc(onLongPressAction, onLongPressUpAction)
  self.__onLongPressAction = onLongPressAction
  self.__onLongPressUpAction = onLongPressUpAction
end

function UINHeroSkillUpgradeItem:UpgradeUnlockSillInfo()
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  self.ui.tex_Name.color = self.ui.color_normal
  self.ui.tex_Descr.color = self.ui.color_normal
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
    self.ui.img_type.color = self.ui.color_typeArry[self.type + 1]
    self.ui.tex_Type:SetIndex(self.type)
    self.ui.tex_Tppe_En:SetIndex(self.type)
  end
  if not isFullLevel and self.skillData:GetIsUnlock() and self.type ~= HeroSkillUpgradeEnum.SkillType.uSkill then
    self.couldUpgrade = true
    self.ui.btn_CanLevelUp.gameObject:SetActive(true)
  else
    self.couldUpgrade = false
    self.ui.btn_CanLevelUp.gameObject:SetActive(false)
  end
  if isSkillUpUnlock and self.skillData:CanUpgrade() and self.type ~= HeroSkillUpgradeEnum.SkillType.uSkill then
    self.ui.obj_blueDot:SetActive(true)
  else
    self.ui.obj_blueDot:SetActive(false)
  end
end

function UINHeroSkillUpgradeItem:UpgradeLockedSillInfo()
  self:UpgradeUnlockSillInfo()
  self.ui.tex_Name.color = self.ui.color_locked
  self.ui.tex_Descr.color = self.ui.color_locked
  local rare, star = self.skillData:GetOpenStar()
  self:InitStarList(star)
end

function UINHeroSkillUpgradeItem:InitStarList(starNum)
  for _, starGo in ipairs(self.StarList) do
    starGo.gameObject:SetActive(false)
  end
  local count = math.ceil(starNum / 2)
  local isHalf = starNum % 2 == 1
  for i = 1, count do
    if self.StarList[i] ~= nil then
      self.StarList[i].gameObject:SetActive(true)
      self.StarList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.img_star:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.StarList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self.StarList[count]:SetIndex(1)
  end
end

function UINHeroSkillUpgradeItem:OnClilck()
  if self.skillData == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_Skill_notOpenYet))
    return
  end
  if self.skillData:IsFullLevel() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_skill_disable2UpgradeOb))
    return
  end
  if not self.skillData:GetIsUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_Skill_unLockWhernReachStar))
    return
  end
  if self.OpenInfoNodeCallback ~= nil then
    self.OpenInfoNodeCallback(self.skillData)
    AudioManager:PlayAudioById(1075)
  end
end

function UINHeroSkillUpgradeItem:SetIntroClickAction(action)
  self.onShowIntroClick = action
end

function UINHeroSkillUpgradeItem:OnShowIntroClick()
  if self.onShowIntroClick ~= nil then
    self.onShowIntroClick(self.skillData)
  end
end

function UINHeroSkillUpgradeItem:UpdateSkillDescription()
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

function UINHeroSkillUpgradeItem:_OnDescribeSettingChange(eDescTypeId)
  if eDescTypeId ~= eGameSetDescType.skill then
    return
  end
  if self.skillData == nil then
    return
  end
  self:UpdateSkillDescription()
end

function UINHeroSkillUpgradeItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
  base.OnDelete(self)
end

return UINHeroSkillUpgradeItem
