_class("UIWidgetBattleEnemyPetInfo", UICustomWidget)
UIWidgetBattleEnemyPetInfo = UIWidgetBattleEnemyPetInfo

function UIWidgetBattleEnemyPetInfo:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetBattleEnemyPetInfo:InitWidget()
  self._petpool = self:GetUIComponent("UISelectObjectPath", "petpool")
  self:RegisterEvent()
end

function UIWidgetBattleEnemyPetInfo:RegisterEvent()
  self:AttachEvent(GameEventType.PetPowerChange, self.OnPetPowerChange)
  self:AttachEvent(GameEventType.PetLegendPowerChange, self.OnPetLegendPowerChange)
  self:AttachEvent(GameEventType.PetAlchemyPowerChange, self.OnPetAlchemyPowerChange)
  self:AttachEvent(GameEventType.PetActiveSkillGetReady, self.OnPetActiveSkillGetReady)
  self:AttachEvent(GameEventType.PetActiveSkillCancelReady, self.OnPetActiveSkillCancelReady)
  self:AttachEvent(GameEventType.SetHeadMaskAlpha, self.OnPetHeadMaskAlpha)
  self:AttachEvent(GameEventType.UIExclusivePetHeadMaskAlpha, self.OnExclusivePetHeadMaskAlpha)
end

function UIWidgetBattleEnemyPetInfo:SetData(matchEnterData)
  self.uiWidgetEnemyPets = {}
  local remotePetCount = 0
  local dict, list = InnerGameHelperRender.GetRemoteMatchPets()
  self._remotePets = dict
  for i = 1, #list do
    if list[i].pet_pstid ~= FormationPetPlaceType.FormationPetPlaceType_None then
      remotePetCount = remotePetCount + 1
    end
  end
  self._petpool:SpawnObjects("UIWidgetEnemyPet", remotePetCount)
  self.uiWidgetEnemyPets = self._petpool:GetAllSpawnList()
  for i = 1, #list do
    local petData = list[i]
    if petData.pet_pstid ~= FormationPetPlaceType.FormationPetPlaceType_None then
      self.uiWidgetEnemyPets[i]:SetData(i, dict[petData.pet_pstid], function()
        self:ShowBlackFistEnemyTeam(list, i)
      end)
    end
  end
end

function UIWidgetBattleEnemyPetInfo:ShowBlackFistEnemyTeam(list, idx)
  local atlas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  local t = {}
  for i, v in ipairs(list) do
    local pet = Cfg.cfg_pet({
      v.template_id
    })
    local petskin = Cfg.cfg_pet_skin({
      id = pet[1].SkinId
    })
    local elemt1, elemt2, battleMe
    battleMe = petskin[1].BattleMes
    if pet[1].FirstElement == 0 then
      elemt1 = nil
    else
      local icon = Cfg.cfg_pet_element[pet[1].FirstElement].Icon
      elemt1 = atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(icon))
    end
    if pet[1].SecondElement == 0 then
      elemt2 = nil
    else
      local icon = Cfg.cfg_pet_element[pet[1].SecondElement].Icon
      elemt2 = atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(icon))
    end
    t[#t + 1] = {
      petid = v.template_id,
      elemt1 = elemt1,
      elemt2 = elemt2,
      battleMe = battleMe,
      lv = v.level,
      awakening = v.awakening,
      grade = v.grade,
      equip = v.equip_lv
    }
  end
  self:ShowDialog("UIN7EnemyDetailsController", t, idx)
end

function UIWidgetBattleEnemyPetInfo:OnPetPowerChange(petPstID, power, effect, logicReady)
  for i = 1, #self.uiWidgetEnemyPets do
    if self.uiWidgetEnemyPets[i]:IsMyPet(petPstID) then
      self.uiWidgetEnemyPets[i]:OnChangePower(power, effect, logicReady)
      break
    end
  end
end

function UIWidgetBattleEnemyPetInfo:OnPetLegendPowerChange(petPstID, power, effect, logicReady, maxValue)
  for i = 1, #self.uiWidgetEnemyPets do
    if self.uiWidgetEnemyPets[i]:IsMyPet(petPstID) then
      self.uiWidgetEnemyPets[i]:OnChangeLegendPower(power, effect, logicReady, maxValue)
      break
    end
  end
end

function UIWidgetBattleEnemyPetInfo:OnPetAlchemyPowerChange(petPstID, power, effect, logicReady, maxValue)
  for i = 1, #self.uiWidgetEnemyPets do
    if self.uiWidgetEnemyPets[i]:IsMyPet(petPstID) then
      self.uiWidgetEnemyPets[i]:OnChangeAlchemyPower(power, effect, logicReady, maxValue)
      break
    end
  end
end

function UIWidgetBattleEnemyPetInfo:OnPetActiveSkillGetReady(petPstID, playReminder, previousReady)
  for i = 1, #self.uiWidgetEnemyPets do
    if self.uiWidgetEnemyPets[i]:IsMyPet(petPstID) then
      self.uiWidgetEnemyPets[i]:OnPowerReady(playReminder, previousReady)
      break
    end
  end
end

function UIWidgetBattleEnemyPetInfo:OnPetActiveSkillCancelReady(petPstID, addCdAnimation)
  for i = 1, #self.uiWidgetEnemyPets do
    if self.uiWidgetEnemyPets[i]:IsMyPet(petPstID) then
      self.uiWidgetEnemyPets[i]:OnPowerCancelReady(addCdAnimation)
      break
    end
  end
end

function UIWidgetBattleEnemyPetInfo:OnShowPetInfoInish()
  for i = 1, #self.uiWidgetEnemyPets do
    self.uiWidgetEnemyPets[i]:OnShowPetInfoInish()
  end
end

function UIWidgetBattleEnemyPetInfo:OnPetHeadMaskAlpha(alpha)
  for i = 1, #self.uiWidgetEnemyPets do
    self.uiWidgetEnemyPets[i]:OnChangeHeadAlpha(alpha)
  end
end

function UIWidgetBattleEnemyPetInfo:OnExclusivePetHeadMaskAlpha(alpha, exclusivePetPstID)
  for i = 1, #self.uiWidgetEnemyPets do
    if not self.uiWidgetEnemyPets[i]:IsMyPet(exclusivePetPstID) then
      self.uiWidgetEnemyPets[i]:OnChangeHeadAlpha(alpha)
    else
      self.uiWidgetEnemyPets[i]:OnChangeHeadAlpha(0)
    end
  end
end
