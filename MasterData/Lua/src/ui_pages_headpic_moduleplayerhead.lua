local this = class("modulePlayerHead", G_UIModuleBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()

function this.bind()
  return {img_head = "", img_frame = ""}
end

function this.methods()
  return {}
end

function this:refreshHead(baseInfo)
end

return this
