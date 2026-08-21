_class("UIAircraftSettleSpiritItem", UICustomWidget)
UIAircraftSettleSpiritItem = UIAircraftSettleSpiritItem

function UIAircraftSettleSpiritItem:OnShow(uiParams)
  self._module = self:GetModule(PetModule)
  self._pstid = 0
  self:InitWidget()
end

function UIAircraftSettleSpiritItem:OnHide()
end

function UIAircraftSettleSpiritItem:InitWidget()
  self.textSpiriteName = self:GetUIComponent("UILocalizationText", "TextSpiriteName")
  self.textSpiriteNameEn = self:GetUIComponent("UILocalizationText", "TextSpiriteNameEn")
  self.starLayout = self:GetUIComponent("UISelectObjectPath", "StarLayout")
  self.imageColor = self:GetUIComponent("Image", "ImageColor")
  self.rawImageIcon = self:GetUIComponent("RawImageLoader", "RawImageIcon")
  self._skillDesc = self:GetGameObject("skillDesc")
  self._skillDescText = self:GetUIComponent("RollingText", "skillDescText")
  self._skillInvalidTip = self:GetGameObject("skillInvalid")
  self._h = self:GetGameObject("h")
  self._n = self:GetGameObject("n")
end

function UIAircraftSettleSpiritItem:SetData(_pstid, _roomData, _onRemove, index)
  self._pstid = _pstid or 0
  self._index = index
  self.roomData = _roomData
  self.onRemove = _onRemove
  if self._pstid == 0 or self._pstid == nil then
    self._h:SetActive(false)
    self._n:SetActive(true)
    return
  end
  self._h:SetActive(true)
  self._n:SetActive(false)
  self.petData = self._module:GetPet(_pstid)
  self.textSpiriteName.text = StringTable.Get(self.petData:GetPetName())
  self.textSpiriteNameEn.text = StringTable.Get(self.petData:GetPetEnglishName())
  self.rawImageIcon:LoadImage(self.petData:GetPetAircraftBody(PetSkinEffectPath.BODY_INTO_AIRCRAFT_AIRBODY))
  self.starLayout:SpawnObjects("UIEmptyWidget", self.petData:GetPetStar())
  local skill = self:GetActiveSkill()
  if skill == nil then
    self._skillDesc:SetActive(false)
    self._skillInvalidTip:SetActive(true)
  else
    self._skillDescText:RefreshText(StringTable.Get(skill.Desc))
    self._skillDesc:SetActive(true)
    self._skillInvalidTip:SetActive(false)
  end
end

function UIAircraftSettleSpiritItem:Close()
end

function UIAircraftSettleSpiritItem:PetID()
  return self.petData:GetPstID()
end

function UIAircraftSettleSpiritItem:GetActiveSkill()
  local skills = self.petData:GetPetWorkSkills()
  if skills == nil or #skills == 0 then
    return nil
  end
  local roomType = self.roomData:GetRoomType()
  for i = 1, #skills do
    if 0 < skills[i] then
      local cfg = Cfg.cfg_work_skill[skills[i]]
      if cfg.RoomType == roomType then
        return cfg
      end
    end
  end
  return nil
end

function UIAircraftSettleSpiritItem:SettleSpiritItemOnClick(go)
  self:ShowDialog("UIAircraftEnterBuildController", self.roomData, self._pstid, self._index)
end

function UIAircraftSettleSpiritItem:ButtonRemoveOnClick(go)
  self.onRemove(self._pstid, self._index)
end
