local eActMonsterCardEnum = {}
eActMonsterCardEnum.cardType = {passive = 1, active = 2}
eActMonsterCardEnum.cardTypeOredr = {
  eActMonsterCardEnum.cardType.passive,
  eActMonsterCardEnum.cardType.active
}
eActMonsterCardEnum.siftingType = {quality = 1, label = 2}
eActMonsterCardEnum.siftingTypeOrder = {
  eActMonsterCardEnum.siftingType.quality,
  eActMonsterCardEnum.siftingType.label
}
return eActMonsterCardEnum
