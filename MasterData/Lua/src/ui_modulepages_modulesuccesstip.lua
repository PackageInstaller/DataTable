local this = class("", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:open()
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Positive_Open")
end

return this
