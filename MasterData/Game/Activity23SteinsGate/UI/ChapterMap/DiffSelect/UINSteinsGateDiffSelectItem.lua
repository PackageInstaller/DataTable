local base = UIBaseNode
local UINSteinsGateDiffSelectItem = class("UINSteinsGateDiffSelectItem", base)

function UINSteinsGateDiffSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.__OnClick)
end

function UINSteinsGateDiffSelectItem:InitSteinsGateDiffSelectItem(diffCfg, selectCallback)
  self.diffCfg = diffCfg
  self.diffIndex = diffCfg.difficulty_id
  self.ui.tex_Mode.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name_en)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_desc)
  self.ui.tex_TitleName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  self.selectCallback = selectCallback
  local isHard = self.diffIndex > 1
  self.ui.img_NormalMode:SetActive(not isHard)
  self.ui.img_HardMode:SetActive(isHard)
  local isUnlock = CheckCondition.CheckLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para1)
  self.__isUnlock = isUnlock
  self.ui.obj_Lock:SetActive(not isUnlock)
  if not isUnlock then
    self.ui.tex_UnlockDes.text = CheckCondition.GetUnlockInfoLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para1)
  end
end

function UINSteinsGateDiffSelectItem:__OnClick()
  if not self.__isUnlock then
    return
  end
  if self.selectCallback ~= nil then
    self.selectCallback(self.diffIndex)
  end
end

function UINSteinsGateDiffSelectItem:OnDelete()
  base.OnDelete(self)
end

return UINSteinsGateDiffSelectItem
