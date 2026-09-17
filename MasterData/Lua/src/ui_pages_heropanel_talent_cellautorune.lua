local module = class("cellAutoRune", G_UIModuleBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()

function module.bind()
  return {runeIcon = "", runeNameText = ""}
end

function module.methods()
  return {
    onClick_runeIcon = function(self)
      if self.bind.clickCallback then
        self.bind.clickCallback(self.bind.runeId)
      end
    end
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  local runeTpl = talentRuneTpl:getTplById(self.bind.runeId)
  local itemId = talentRuneTpl:getRuneItem(runeTpl)
  local item = L_ItemTplManager:getCommonItem(itemId)
  self.bind.runeIcon = item.icon
  self.bind.runeNameText = item.name
end

return module
