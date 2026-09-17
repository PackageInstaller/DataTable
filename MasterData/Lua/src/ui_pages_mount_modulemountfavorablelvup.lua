local this = class("moduleMountFavorableLvUp", G_UIModuleBase)

function this:bind()
  return {active_self = false, txt_favorable = ""}
end

function this:methods()
  return {}
end

function this:registerListening()
  if self._isHadRegister then
    return
  end
  self._isHadRegister = true
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetFavorLvUp, self.onEventMessageRefreshPetFavorLvUp, self)
end

function this:unRegisterListening()
  if not self._isHadRegister then
    return
  end
  self._isHadRegister = false
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetFavorLvUp, self.onEventMessageRefreshPetFavorLvUp, self)
end

function this:open()
  self.bind.active_self = false
end

function this:close()
end

function this:show()
  self:registerListening()
  self:disposeAllTimer()
end

function this:hide()
  self:unRegisterListening()
  self:disposeAllTimer()
end

function this:onSetDat(data)
  if data == nil then
    return
  end
  self._petGuid = data.petGuid
end

function this:onShowLvUp(favorLv)
  if self._petGuid == nil then
    return
  end
  self.bind.active_self = true
  if favorLv == nil then
    local petItem = L_PetStore:getPetItem(self._petGuid)
    if petItem == nil then
      return
    end
    favorLv = petItem:petFavorLv()
  end
  self.bind.txt_favorable = L_WordsTpl:getValue("notice_moduleMountFavorableLvUp", {
    [0] = favorLv
  })
  self:playStartAnim()
end

function this:playStartAnim()
  self._timerStart = Timer.once(1.5, function()
    self:playEndAnim()
  end, self)
end

function this:playEndAnim()
  self.bind.active_self = false
end

function this:onEventMessageRefreshPetFavorLvUp(msg)
  if table.isEmpty(msg) or self._petGuid ~= msg.petGuid then
    return
  end
  local favorLv = msg.newFavorLv
  self:onShowLvUp(favorLv)
end

function this:disposeAllTimer()
  if self._timerStart ~= nil then
    Timer.remove(self._timerStart)
    self._timerStart = nil
  end
end

return this
