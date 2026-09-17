local this = class("cellDuelKillResult", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {txt_winPetName = "", txt_losePetName = ""}
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
  self:disposeOutTimer()
end

function this:refresh()
  if not self.isBind then
    return
  end
  local data = self.bind
  local enemyTpl = petTpl:getTplById(data.enemy.petConfigId)
  local playerTpl = petTpl:getTplById(data.player.petConfigId)
  local slotId = C_KiboDuelSystemMgr:GetSlotIdByGuid(data.player.guid)
  local petName = C_KiboDuelSystemMgr:GetPetNameByGuid(data.player.guid)
  if data.isWin then
    self.bind.txt_winPetName = L_GameUtil.fillColor(petName, L_Const.colorHtml.blue010)
    self.bind.txt_losePetName = L_GameUtil.fillColor(petTpl:getName(enemyTpl, false), L_Const.colorHtml.red009)
  else
    self.bind.txt_losePetName = L_GameUtil.fillColor(petName, L_Const.colorHtml.blue010)
    self.bind.txt_winPetName = L_GameUtil.fillColor(petTpl:getName(enemyTpl, false), L_Const.colorHtml.red009)
  end
  if string.isEmpty(self.bind.txt_winPetName) or string.isEmpty(self.bind.txt_losePetName) then
    printf("出现奇波空名字了", data)
  end
end

function this:petIsSpecial(guid)
  if guid then
    local petItem = L_PetStore:getPetItem(guid)
    if petItem then
      return petItem:isSpecialPet()
    end
  end
  return false
end

function this:disposeOutTimer()
  if self.outTimer ~= nil then
    Timer.remove(self.outTimer)
    self.outTimer = nil
  end
end

function this:playShowAnimation(isWin)
  if not self.isBind or not self.bind.cellAnimation then
    return
  end
  if isWin then
    self.bindComponents.cellAnimation:Play("anim_petbattle_killtip_B")
  else
    self.bindComponents.cellAnimation:Play("anim_petbattle_killtip_R")
  end
  self:disposeOutTimer()
  self.outTimer = Timer.once(2.5, function()
    if not self.isBind or not self.bind.cellAnimation then
      return
    end
    self.bindComponents.cellAnimation:Play("anim_petbattle_killtip_out")
  end, self)
end

function this:playMove()
end

return this
