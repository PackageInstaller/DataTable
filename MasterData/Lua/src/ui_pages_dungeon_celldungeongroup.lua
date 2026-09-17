local this = class("cellDungeonGroup", G_UIModuleBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this.bind()
  return {
    txt_name_normal = nil,
    txt_name_select = nil,
    go_normal = false,
    go_select = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  local tpl = _dungeonTpl:getTplListByDoorIdAndGroupId(self.bind.doorId, self.bind.groupId)[1]
  self.bind.txt_name_normal = _dungeonTpl:getGroupName(tpl)
  self.bind.txt_name_select = _dungeonTpl:getGroupName(tpl)
end

function this:setSelect(active)
  self.bind.go_select = active
  self.bind.go_normal = not active
end

return this
