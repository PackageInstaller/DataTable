local this = class("cellPetDuelMap", G_UIModuleBase)
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()

function this.bind()
  return {
    active_selected = false,
    img_map = "",
    toggle_map = true,
    text_mapName = ""
  }
end

function this.methods()
  return {
    onclick_selectMap = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function this:refresh()
  self.mapId = self.bind.mapId
  self.selectMapId = self.bind.selectMapId
  self.isRandom = self.bind.isRandom
  self.callback = self.bind.callback
  self:refreshView()
end

function this:refreshView()
  self.bind.active_selected = self.selectMapId == self.mapId
  if self.isRandom then
    self.bind.text_mapName = L_WordsTpl:getValue("ui_kiboDuel_60")
    self.bind.img_map = "UI/Texture/KiboDuelMapPic/tex_petduel_map_bg_01.png"
  else
    local mapTpl = _kiboDuelMapTpl:getTplById(self.mapId)
    self.bind.text_mapName = _kiboDuelMapTpl:getName(mapTpl)
    self.bind.img_map = _kiboDuelMapTpl:getMapPic(mapTpl)
  end
  self.bind.toggle_map = self.isRandom
end

return this
