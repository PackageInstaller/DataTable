local this = class("moduleMythicalPet", G_UIModuleBase)
local petText = "notice_world_rare_kibo_discovered" or "notice_moduleMythicalPet"
local delay = L_GameTpl:getGameConstTpl():getData("WORLD_KIBO_DISCOVERED_TIP_TIME", L_Const.GameTplType.int)

function this.bind()
  return {show = true, txt_mythicalPet = ""}
end

function this.methods()
  return {
    onClick_text = function(self)
      L_UI:open("pageBigMap", {showMythical = true})
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  local petName = "???"
  self.bind.txt_mythicalPet = L_WordsTpl:getValue(petText, {
    [0] = petName
  })
  if self._timer then
    self._timer:reset()
  else
    self._timer = L_GameTimer.new(function()
      self.bind.show = false
    end, delay, 0)
  end
  self._timer:start()
end

function this:close(options)
  this.super.close(self, options)
  if self._timer then
    self._timer:stop()
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
