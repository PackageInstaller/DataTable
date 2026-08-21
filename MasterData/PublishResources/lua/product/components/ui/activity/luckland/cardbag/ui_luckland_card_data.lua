_class("UILuckLandCardData", Object)
UILuckLandCardData = UILuckLandCardData

function UILuckLandCardData:Constructor(uniqueID, id)
  self._cfg = Cfg.cfg_luckland_client_card[id]
  if not self._cfg then
    Log.error("cfg_luckland_client_card error.", id)
    return
  end
  self._uniqueID = uniqueID
  self._stageNumber = 0
  self._id = self._cfg.ID
  self._hp = self:_GetResValue(LuckLandCardResType.HP)
  self._attack = self:_GetResValue(LuckLandCardResType.Attack)
  self._money = self:_GetResValue(LuckLandCardResType.Money)
  self._camp = self._cfg.CardCamp
  self._attribute = self._cfg.CardAttribute
  self._star = self._cfg.CardStar
  self._skills = self._cfg.CardBuff
  self._campName = self._cfg.CardCampName
end

function UILuckLandCardData:Cfg()
  return self._cfg
end

function UILuckLandCardData:UniqueID()
  return self._uniqueID
end

function UILuckLandCardData:ID()
  return self._id
end

function UILuckLandCardData:HP()
  return self._hp
end

function UILuckLandCardData:Attack()
  return self._attack
end

function UILuckLandCardData:Money()
  return self._money
end

function UILuckLandCardData:Camp()
  return self._camp
end

function UILuckLandCardData:CampName()
  return self._campName
end

function UILuckLandCardData:Attribute()
  return self._attribute
end

function UILuckLandCardData:Star()
  return self._star
end

function UILuckLandCardData:Skills()
  return self._skills
end

function UILuckLandCardData:FirstSkill()
  if self._skills then
    return self._skills[1]
  end
  return nil
end

function UILuckLandCardData:StageNumber()
  return self._stageNumber
end

function UILuckLandCardData:AddStageNumber(times)
  self._stageNumber = self._stageNumber + times
end

function UILuckLandCardData:_GetResValue(resType)
  if self._cfg.CardGameRes and self._cfg.CardGameRes[1] == resType then
    return self._cfg.CardGameRes[2]
  end
  return nil
end
