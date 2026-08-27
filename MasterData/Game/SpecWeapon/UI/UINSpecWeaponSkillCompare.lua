local UINSpecWeaponSkillCompare = class("UINSpecWeaponSkillCompare", UIBaseNode)
local base = UIBaseNode
local UINSpecWeaponSkillComItem = require("Game.SpecWeapon.UI.UINSpecWeaponSkillComItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_MessageCommon = CS.MessageCommon
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINSpecWeaponSkillCompare:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.Hide)
  self._oriSkillItem = UINSpecWeaponSkillComItem.New()
  self._oriSkillItem:Init(self.ui.skillBeforeState)
  self._nowSkillItem = UINSpecWeaponSkillComItem.New()
  self._nowSkillItem:Init(self.ui.skillAfterState)
  self.__OnShowStartCdTimeTipCallback = BindCallback(self, self.__OnShowStartCdTimeTip)
  self.__OnHideStartCdTimeTipCallback = BindCallback(self, self.__OnHideStartCdTimeTip)
  self.__OnShowIntroClickCallback = BindCallback(self, self.__OnShowIntroClick)
  self._oriSkillItem:InjectSpecWeaponSkillComItem(self.__OnShowStartCdTimeTipCallback, self.__OnHideStartCdTimeTipCallback, self.__OnShowIntroClickCallback)
  self._nowSkillItem:InjectSpecWeaponSkillComItem(self.__OnShowStartCdTimeTipCallback, self.__OnHideStartCdTimeTipCallback, self.__OnShowIntroClickCallback)
end

function UINSpecWeaponSkillCompare:BindCompareHideFuncOnce(func)
  self._hideFunc = func
end

function UINSpecWeaponSkillCompare:SpecWeaponSkillCompare(oriSkillData, nowSkillData, resloader)
  self.ui.tex_HasUpgrade:SetActive(false)
  self.ui.tex_before:SetActive(true)
  self.ui.tex_After:SetActive(true)
  self.ui.afterSkillNode:SetActive(true)
  self._oriSkillItem:InitSpecWeaponSkillComItem(oriSkillData, resloader)
  self._nowSkillItem:InitSpecWeaponSkillComItem(nowSkillData, resloader)
end

function UINSpecWeaponSkillCompare:SpecWeaponSkillNewStep(skillData, resloader)
  self.ui.tex_HasUpgrade:SetActive(true)
  self.ui.tex_before:SetActive(false)
  self.ui.tex_After:SetActive(false)
  self.ui.afterSkillNode:SetActive(false)
  self._oriSkillItem:InitSpecWeaponSkillComItem(skillData, resloader)
  self._oriSkillItem:PlaySpecWeaponTween()
end

function UINSpecWeaponSkillCompare:__OnShowStartCdTimeTip(upgradeItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(ConfigData:GetTipContent(617), ConfigData:GetTipContent(616))
  win:FloatTo(upgradeItem.transform, HAType.left, VAType.up)
end

function UINSpecWeaponSkillCompare:__OnHideStartCdTimeTip()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINSpecWeaponSkillCompare:__OnShowIntroClick(skillData, holder)
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      self.ui.holder.position = holder.position
      win:ShowIntroBySkillData(self.ui.holder, skillData, nil, nil, nil, nil, 1)
      win:SetIntroListPosition(cs_Edge.Right, cs_Edge.Top)
    end
  end)
end

function UINSpecWeaponSkillCompare:OnHide()
  base.OnHide(self)
  if self._hideFunc ~= nil then
    self._hideFunc()
    self._hideFunc = nil
  end
end

return UINSpecWeaponSkillCompare
