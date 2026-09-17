local this = class("moduleKiboDuelMapChange", G_UIModuleBase)
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()

function this.bind()
  return {active_root = false, txt_map = ""}
end

function this.methods()
  return {
    onClick_btnChangeMap = function(self)
      if self.callback then
        self.callback()
      end
    end
  }
end

function this:initModule(mapId, callback)
  local mapTpl = _kiboDuelMapTpl:getTplById(mapId)
  self.bind.txt_map = mapId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(mapTpl)
  self.callback = callback
end

function this:setActive(active)
  self.bind.active_root = active
end

function this:refreshView(mapId)
  local mapTpl = _kiboDuelMapTpl:getTplById(mapId)
  self.bind.txt_map = mapId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(mapTpl)
end

return this
