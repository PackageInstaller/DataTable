_class("SimplePet", Object)
SimplePet = SimplePet

function SimplePet:Constructor()
  self._templateID = nil
  self._level = nil
  self._break = nil
  self._awake = nil
end

function SimplePet:SetData(serverData)
  self._templateID = serverData.template_id
  self._level = serverData.level
  self._break = serverData.awakening
  self._breakLock = serverData.awake_lock
  self._awake = serverData.grade
  self._skin = serverData.skin_id
  self._equipLv = serverData.equip_lv
  self._equipRefineLv = serverData.equip_refine_lv
  self._cfg_pet = Cfg.cfg_pet[self._templateID]
  if self._cfg_pet == nil then
    Log.fatal("[SimplePet] 找不到星灵ID：", self._templateID)
    return
  end
  if self._awake > 0 then
    local gradeCfg = Cfg.cfg_pet_grade({
      PetID = self._templateID,
      Grade = self._awake
    })
    if gradeCfg == nil then
      Log.fatal("[SimplePet] 找不到星灵觉醒数据，id：", self._templateID, "，觉醒：", self._awake)
      return
    end
    self._cfg_grade = gradeCfg[1]
  end
end

function SimplePet:GetEquipRefineLv()
  return self._equipRefineLv
end

function SimplePet:GetPstID()
  return nil
end

function SimplePet:GetTemplateID()
  return self._templateID
end

function SimplePet:GetPetName()
  return self._cfg_pet.Name
end

function SimplePet:GetPetLevel()
  return self._level
end

function SimplePet:GetPetAwakening()
  return self._break
end

function SimplePet:GetPetGrade()
  return self._awake
end

function SimplePet:GetEquipLv()
  return self._equipLv
end

function SimplePet:GetSkinId()
  return self._skin
end

function SimplePet:GetPetTeamBody()
  return HelperProxy:GetInstance():GetPetTeamBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), PetSkinEffectPath.CARD_TOWER_TEAM_BODY)
end

function SimplePet:GetPetFirstElement()
  return self._cfg_pet.FirstElement
end

function SimplePet:GetPetSecondElement()
  if self._awake >= self._cfg_pet.Element2NeedGrade and self._cfg_pet.SecondElement > 0 then
    return self._cfg_pet.SecondElement
  end
end

function SimplePet:GetPetBody()
  return HelperProxy:GetInstance():GetPetBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), PetSkinEffectPath.CARD_TOWER)
end

function SimplePet:GetPetLogo()
  return self._cfg_pet.Logo
end

function SimplePet:GetPetStar()
  return self._cfg_pet.Star
end

function SimplePet:GetAwakeMatch()
  return self._breakLock > 0 and self._breakLock or self._break
end

function SimplePet:IsLegendPet()
  return self._cfg_pet.LegendPet == 1
end

function SimplePet:GetProf()
  return self._cfg_pet.Prof
end

function SimplePet:GetJob()
  return self:GetProf()
end
