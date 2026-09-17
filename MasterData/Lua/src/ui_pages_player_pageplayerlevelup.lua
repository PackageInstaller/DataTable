local this = class("pagePlayerLevelUp", G_UIPageBase)

function this.bind()
  return {txt_oldLv = "", txt_newLv = ""}
end

function this.methods()
  return {}
end

function this:show(options)
  self.bind.txt_oldLv = tostring(options.lastLv)
  self.bind.txt_newLv = tostring(options.curLv)
  L_AudioUtil.playSound("Play_SFX_System_HUD_General_StarLevel_Upgrade")
  if self.timer then
    self.timer:destroy()
  end
  self.timer = Timer.once(2, function()
    L_UI:close(self.pageName)
  end, self)
end

function this:escHandle()
end

function this:close()
  if self.timer then
    self.timer:destroy()
  end
end

return this
