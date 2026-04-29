_class("UICustomPetData", Object)
UICustomPetData = UICustomPetData

function UICustomPetData:Constructor(cfg)
  if cfg then
    self._petId = cfg.PetId
    self._attack = cfg.Attack
    self._hp = cfg.Hp
    self._def = cfg.Def
    self._awakening = cfg.Awakening
    self._grade = cfg.Grade
    self._equip = cfg.Equip
  end
  self._isShowBtnInfo = false
  self._btnInfoName = ""
  self._btnInfoCallback = nil
end

function UICustomPetData:GetPetId()
  return self._petId
end

function UICustomPetData:SetPetId(id)
  self._petId = id
end

function UICustomPetData:GetAttacke()
  return self._attack
end

function UICustomPetData:SetAttack(attack)
  self._attack = attack
end

function UICustomPetData:GetHP()
  return self._hp
end

function UICustomPetData:SetHP(hp)
  self._hp = hp
end

function UICustomPetData:GetDef()
  return self._def
end

function UICustomPetData:SetDef(def)
  self._def = def
end

function UICustomPetData:GetAwakening()
  return self._awakening
end

function UICustomPetData:SetAwakeing(awake)
  self._awakening = awake
end

function UICustomPetData:GetGrade()
  return self._grade
end

function UICustomPetData:SetGrade(grade)
  self._grade = grade
end

function UICustomPetData:GetEquip()
  return self._equip
end

function UICustomPetData:SetEquip(equip)
  self._equip = equip
end

function UICustomPetData:IsShowBtnInfo()
  return self._isShowBtnInfo
end

function UICustomPetData:SetShowBtnStatus(status)
  self._isShowBtnInfo = status
end

function UICustomPetData:GetBtnInfoName()
  return self._btnInfoName
end

function UICustomPetData:SetBtnInfoName(name)
  self._btnInfoName = name
end

function UICustomPetData:GetBtnInfoCallback()
  return self._btnInfoCallback
end

function UICustomPetData:SetBtnInfoCallback(callback)
  self._btnInfoCallback = callback
end

function UICustomPetData:SetHideHomeBtn(bHide)
  self._hideHomeBtn = bHide
end

function UICustomPetData:GetHideHomeBtn()
  return self._hideHomeBtn
end

function UICustomPetData:GetDetailTitleText()
  return self._detailTitleText
end

function UICustomPetData:SetDetailTitleText(text)
  self._detailTitleText = text
end

function UICustomPetData:GetShowLevelArea()
  return self._showLevelArea
end

function UICustomPetData:SetShowLevelArea(bShow)
  self._showLevelArea = bShow
end

function UICustomPetData:GetCustomLevel()
  return self._customLevel
end

function UICustomPetData:SetCustomLevel(level)
  self._customLevel = level
end

function UICustomPetData:GetAffinityLevel()
  return self._affinityLevel
end

function UICustomPetData:SetAffinityLevel(affinityLevel)
  self._affinityLevel = affinityLevel
end

function UICustomPetData:GetEquipRefineLevel()
  return self._equipRefineLevel
end

function UICustomPetData:SetEquipRefineLevel(equipRefineLevel)
  self._equipRefineLevel = equipRefineLevel
end
