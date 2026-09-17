local this = class("cellPetRecommend", G_UIModuleBase)

function this.bind()
  return {
    petIcon = "",
    name = "",
    possessActive = false,
    unlockActive = true,
    lockActive = false,
    selecrActive = false
  }
end

function this.methods()
  return {
    onClick_selectPet = function(self)
      self:selectPet()
    end
  }
end

function this:selectPet()
  if self.bind.unlockActive then
    self:trackPet()
    return
  end
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_petsell_unlock"))
end

function this:trackPet()
  if self.bind.heroConfigId then
    local eventData = {
      hero_id = self.bind.heroConfigId,
      pet_id = self.bind.petConfigId,
      rec_result = 2
    }
    L_GameUtil.logEvent(L_Const.logEventName.pet_formation_rec, eventData)
  end
  C_MapManager:trackBoki(self.bind.petConfigId)
end

return this
