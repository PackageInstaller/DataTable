local UINSpring23ModeSelectDiffItem = class("UINSpring23ModeSelectDiffItem", UIBaseNode)
local base = UIBaseNode

function UINSpring23ModeSelectDiffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickConfirm)
end

function UINSpring23ModeSelectDiffItem:InitModelDiffItem(diffCfg, index, callback)
  self._diffCfg = diffCfg
  self._index = index
  self._callback = callback
  self.ui.tex_ModeENName.text = diffCfg.difficulty_name_en
  self.ui.tex_ModeCNName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  local totalDes
  for index, catalog_id in ipairs(diffCfg.catalog) do
    local desCfg = ConfigData.activity_spring_difficulty_catalog[catalog_id]
    local des = LanguageUtil.GetLocaleText(desCfg.catalog_des)
    if string.IsNullOrEmpty(totalDes) then
      totalDes = des
    else
      totalDes = totalDes .. "\n" .. des
    end
  end
  self.ui.tex_EPoints.text = totalDes
  self:SetModelColor(index)
end

function UINSpring23ModeSelectDiffItem:SetModelDiffItemUnLocke(isUnlock, unlockDes)
  self.isUnlock = isUnlock
  if not IsNull(self.ui.obj_Locked) then
    self.ui.obj_Locked:SetActive(not isUnlock)
    if not isUnlock then
      self.ui.tex_unlock.text = unlockDes
    end
  end
end

function UINSpring23ModeSelectDiffItem:SetModelColor(index)
  local color = self.ui.color_state[index]
  if color == nil then
    color = self.ui.color_state[#self.ui.color_state]
  end
  self.ui.img_ModeBg.color = color
end

function UINSpring23ModeSelectDiffItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self)
  end
end

function UINSpring23ModeSelectDiffItem:GetModeItemDiffInfoCfg()
  return self._diffCfg, self._index
end

return UINSpring23ModeSelectDiffItem
