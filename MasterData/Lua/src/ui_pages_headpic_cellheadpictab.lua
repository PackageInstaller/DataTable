local this = class("cellHeadPicTab", G_UIModuleBase)
local _playerDressListTpl = L_GameTpl:getPlayercardDressListTpl()

function this.bind()
  return {
    txtNameOn = "",
    txtNameOff = "",
    activeRed = nil,
    tabId = 0
  }
end

function this:open()
  local name = _playerDressListTpl:getName(_playerDressListTpl:getTplById(self.bind.tabId))
  self.bind.txtNameOn = name
  self.bind.txtNameOff = name
  if self.bind.tabId == L_Const.playerDressType.head then
    L_ReddotManager:registerReddot(self.bindComponents.reddot, L_ReddotManager.DotDef.PlayerHead_head)
  elseif self.bind.tabId == L_Const.playerDressType.headFrame then
    L_ReddotManager:registerReddot(self.bindComponents.reddot, L_ReddotManager.DotDef.PlayerHead_frame)
  end
end

return this
