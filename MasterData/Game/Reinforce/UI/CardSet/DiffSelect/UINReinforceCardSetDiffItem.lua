local base = UIBaseNode
local UINReinforceCardSetDiffItem = class("UINReinforceCardSetDiffItem", base)
local color_gray = Color.New(0.5686275, 0.5686275, 0.5686275)

function UINReinforceCardSetDiffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickSelect)
end

function UINReinforceCardSetDiffItem:InitReinforceCSDNDiffItem(diffCfg, isSelected, clickCallback)
  self.diffCfg = diffCfg
  self.clickCallback = clickCallback
  self:__Refresh(diffCfg, isSelected)
end

function UINReinforceCardSetDiffItem:__Refresh(diffCfg, isSelected)
  local isUnlock, unlockInfo
  isUnlock = CheckCondition.CheckLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para2)
  if not isUnlock then
    unlockInfo = CheckCondition.GetUnlockInfoLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para2)
  end
  self.__isUnlock = isUnlock
  self.ui.obj_Selected:SetActive(isSelected)
  self.ui.obj_Lock:SetActive(not isUnlock)
  self.ui.tex_Word:SetIndex(isSelected and 1 or 0)
  self.ui.tex_Selection:SetIndex(isSelected and 1 or 0)
  self.ui.img_DiffBg.color = self.ui.color_DiffBg[isSelected and 1 or 2]
  self.ui.canvasGroup.alpha = isUnlock and 1 or 0.5
  self.ui.tex_Des.gameObject:SetActive(isUnlock)
  if isUnlock then
    self.ui.tex_Des.text = LanguageUtil.GetLocaleText(diffCfg.des_tex)
    self.ui.tex_Lvl.color = Color.white
    self.ui.tex_DiffBonus.color = Color.white
  else
    self.ui.tex_LockDes.text = unlockInfo
    self.ui.tex_Lvl.color = color_gray
    self.ui.tex_DiffBonus.color = color_gray
  end
  self.ui.tex_Lvl.text = diffCfg.difficulty_name
  local addRate = diffCfg.infinite_coe
  self.ui.TexInfo_DiffBonus:SetIndex(0, tostring(addRate))
end

function UINReinforceCardSetDiffItem:__OnClickSelect()
  if not self.__isUnlock then
    return
  end
  if self.clickCallback ~= nil then
    self.clickCallback(self.diffCfg)
  end
end

function UINReinforceCardSetDiffItem:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardSetDiffItem
