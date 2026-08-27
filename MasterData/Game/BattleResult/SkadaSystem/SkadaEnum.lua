local SkadaEnum = {}
SkadaEnum.eSkadaType = {
  Damage = 1,
  TakeDamage = 2,
  Heal = 3
}
SkadaEnum.MaxSkadaTypeNum = 3
SkadaEnum.SkadaSortFunc = {
  [SkadaEnum.eSkadaType.Damage] = function(skada1, skada2)
    local damage1 = skada1.detail[SkadaEnum.eSkadaType.Damage].value
    local damage2 = skada2.detail[SkadaEnum.eSkadaType.Damage].value
    if damage1 ~= damage2 then
      return damage1 > damage2
    else
      return skada1.id < skada2.id
    end
  end,
  [SkadaEnum.eSkadaType.TakeDamage] = function(skada1, skada2)
    local takeDamage1 = skada1.detail[SkadaEnum.eSkadaType.TakeDamage].value
    local takeDamage2 = skada2.detail[SkadaEnum.eSkadaType.TakeDamage].value
    if takeDamage1 ~= takeDamage2 then
      return takeDamage1 > takeDamage2
    else
      return skada1.id < skada2.id
    end
  end,
  [SkadaEnum.eSkadaType.Heal] = function(skada1, skada2)
    local heal1 = skada1.detail[SkadaEnum.eSkadaType.Heal].value
    local heal2 = skada2.detail[SkadaEnum.eSkadaType.Heal].value
    if heal1 ~= heal2 then
      return heal1 > heal2
    else
      return skada1.id < skada2.id
    end
  end
}
return SkadaEnum
