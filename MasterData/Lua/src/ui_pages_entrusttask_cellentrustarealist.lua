local module = class("cellEntrustAreaList", G_UIModuleBase)
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local _dungeonEntrustAreaTpl = L_GameTpl:getDungeonEntrustAreaTpl()

function module.bind()
  return {txt_Name = "", active_selection = false}
end

function module.methods()
  return {
    onClick = function(self)
      self.bind.onClickHandle(self.data.areaTplId)
    end
  }
end

function module:initData()
  self.data = {areaId = 0}
end

function module:open()
  self:initData()
  if self.bind.areaTplId then
    self.data.areaTplId = self.bind.areaTplId
  end
  local tpl = _dungeonEntrustAreaTpl:getTplById(self.data.areaTplId)
  self.bind.txt_Name = self.bind.name
end

function module:refreshSelection(id)
  self.bind.active_selection = id == self.data.areaTplId
end

return module
