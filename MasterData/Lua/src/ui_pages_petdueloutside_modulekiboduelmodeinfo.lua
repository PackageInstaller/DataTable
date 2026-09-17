local this = class("moduleKiboDuelModeInfo", G_UIModuleBase)
local FormationTypeEnum = {
  [L_PetConst.PetDuelGameType.Battle] = L_WordsTpl:getValue("ui_kiboDuel_06"),
  [L_PetConst.PetDuelGameType.Arena] = L_WordsTpl:getValue("ui_kiboDuel_05")
}

function this.bind()
  return {active_root = false, txt_modeName = ""}
end

function this.methods()
  return {
    onClick_close = function(self)
      if self.callback then
        self.callback()
      end
    end
  }
end

function this:initModule(mode, callback)
  self:setActive(true)
  self:refreshModule(mode)
  self.callback = callback
end

function this:refreshModule(mode)
  self:setActive(true)
  if mode ~= nil then
    self.mode = mode
    self.bind.txt_modeName = FormationTypeEnum[mode]
  end
end

function this:setActive(active)
  self.bind.active_root = active
end

return this
