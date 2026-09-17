local this = class("wardrobeAvatarTpl")

function this:init(config)
  self.data = config
  self._useType = {}
  self._useTypeList = L_GameTpl:getGameConstTpl():getData("AVATAR_TYPE", L_Const.GameTplType.list_int)
  for _, type in ipairs(self._useTypeList) do
    self._useType[type] = true
  end
end

return this
