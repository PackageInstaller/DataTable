local module = class("cellTalentAttributeBonus", G_UIModuleBase)
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function module.bind()
  return {
    attributeNameText = "",
    valueText = "",
    icon = ""
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  self.bind.icon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(self.bind.attributeId))
  self.bind.valueText = string.concat("+ ", battleInfoTpl:getShowTxtComma(self.bind.attributeId, self.bind.value))
  if string.isEmpty(L_Const.attrBaseName[self.bind.attributeId]) then
    self.bind.attributeNameText = battleInfoTpl:getName(battleInfoTpl:getTplById(self.bind.attributeId))
  else
    self.bind.attributeNameText = L_WordsTpl:getValue(L_Const.attrBaseName[self.bind.attributeId])
  end
end

return module
