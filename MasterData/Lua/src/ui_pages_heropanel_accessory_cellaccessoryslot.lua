local this = class("cellAccessorySlot", G_UIModuleBase)

function this.bind()
  return {
    go_equipped = false,
    go_empty = false,
    img_quality_angle = nil,
    img_icon = nil,
    img_staticIcon = nil,
    txt_level = nil,
    go_headRank = false,
    img_headRank = "",
    go_animRoot_earrings = false,
    go_animRoot_pants = false,
    go_animRoot_sword = false,
    go_animRoot_armor = false,
    go_animRoot_ring = false,
    go_animRoot_Empty = true
  }
end

function this.methods()
  return {
    onClick_item = function(self)
      local notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
      local _guid = self.bind.go_equipped and self.bind.guid or nil
      local data = {
        accessoryType = self.bind.type,
        selectHeroGuid = self.bind.heroId,
        equipType = self.bind.type,
        guid = _guid,
        notShowAccess = notShowAccess
      }
      self:emit("onClick_item", data)
    end,
    onPointEnter_item = function(self)
      if not L_DeviceTpl:getIsPc() then
        return
      end
      L_AudioUtil.playSound("Play_SFX_System_UI_Equip_Hover")
      self:getPosState(self.bind.type, true)
    end,
    onPointExit_item = function(self)
      if not L_DeviceTpl:getIsPc() then
        return
      end
      self:getPosState(self.bind.type, false)
    end
  }
end

function this:close()
  AzurWorld.RedDotMgr:UnBindRedDotRenderer(string.format("HeroAccessorySlot_%s_%s", self.bind.heroId, self.bind.type))
end

function this:refresh()
  local index = self.bind.index
  local heroId = self.bind.heroId
  if self.bind.type then
    self.bind.img_staticIcon = string.format("UI/Atlas/Accessory/tex_equipment_btn_newempty%s.png", tostring(self.bind.type))
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("HeroAccessorySlot_%s_%s", heroId, self.bind.type), self.bindComponents.reddotNormal.gameObject)
  end
end

function this:getPosState(type, state)
  if type == 1 then
    self.bind.go_animRoot_sword = state
  elseif type == 2 then
    self.bind.go_animRoot_armor = state
  elseif type == 3 then
    self.bind.go_animRoot_pants = state
  elseif type == 4 then
    self.bind.go_animRoot_earrings = state
  elseif type == 5 then
    self.bind.go_animRoot_ring = state
  end
  self.bind.go_animRoot_Empty = not state
end

return this
