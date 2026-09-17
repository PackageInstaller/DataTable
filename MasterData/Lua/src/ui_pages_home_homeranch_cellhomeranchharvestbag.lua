local this = class("cellHomeRanchHarvestBag", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    img_iconFilter = "",
    cellIconCircle = L_Const.ModuleInfo.CellIconCircle
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local commonItemTpl = _commonItemTpl:getTplById(self.bind.itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  if not self.isBind then
    return
  end
  self.modules.cellIconCircle:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum
  })
end

return this
