local this = class("cellDungeonDifficulty", G_UIModuleBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this.bind()
  return {
    txt_level_normal = nil,
    txt_level_select = nil,
    go_lock = false,
    go_normal = false,
    go_select = false,
    go_line = true
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
  local tpl = _dungeonTpl:getTplById(self.bind.dungeonId)
  local dungeonGroupOrder = _dungeonTpl:getDungeonGroupOrder(tpl)
  self.bind.txt_level_normal = L_DungeonConst.RomeNumber[dungeonGroupOrder]
  self.bind.txt_level_select = L_DungeonConst.RomeNumber[dungeonGroupOrder]
  local isUnlock = L_ConditionManager:isComplete(_dungeonTpl:getUnlockCondition(tpl))
  self.bind.go_lock = not isUnlock
  self.bind.go_normal = isUnlock
end

function this:setSelect(active)
  if not self.bind.go_lock then
    self.bind.go_select = active
    self.bind.go_normal = not active
  end
end

return this
