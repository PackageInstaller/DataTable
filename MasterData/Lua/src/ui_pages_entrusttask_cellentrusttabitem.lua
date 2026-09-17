local module = class("cellEntrustTabItem", G_UIModuleBase)
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()

function module.bind()
  return {
    txt_selectName = "",
    txt_unSelectName = "",
    tabId = -1
  }
end

function module:open()
  self.bind.tabId = self.bind.id
  local tpl = _dungeonEntrustTypeTpl:getTplById(self.bind.id)
  self.bind.txt_selectName = _dungeonEntrustTypeTpl:getName(tpl)
  self.bind.txt_unSelectName = _dungeonEntrustTypeTpl:getName(tpl)
end

return module
