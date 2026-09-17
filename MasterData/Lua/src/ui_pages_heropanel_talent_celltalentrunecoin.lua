local this = class("cellTalentRuneCoin", G_UIModuleBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()

function this.bind()
  return {img_icon = "", txt_num = ""}
end

function this.methods()
  return {
    onClick = function(self)
      local notShowAccess = self:GetSourceLuaPageOptions("notShowAccess")
      L_ItemTplManager:showInfoTip(self.bind.type, self.bind.id, nil, nil, notShowAccess, self.bind.num)
    end
  }
end

function this:open(options)
  self.configId = self.bind.id
  self:refresh()
end

function this:refresh()
  if self.configId == nil then
    return
  end
  local item = L_ItemTplManager:getItemConfig(L_Const.resType.currency, self.configId)
  self.bind.img_icon = item.smallIcon or item.icon
  local hadNum = L_ItemTplManager:getItemNum(L_Const.resType.currency, self.configId)
  if hadNum < self.bind.num then
    self.bind.txt_num = L_GameUtil.fillColor(self.bind.num, "#EF5743")
    self.isLack = true
  else
    self.bind.txt_num = tostring(self.bind.num)
    self.isLack = false
  end
  self.bindComponents.rectIcon.localScale = self.bind.iconLocalScale and self.bind.iconLocalScale or C_Vector3(1, 1, 1)
end

return this
