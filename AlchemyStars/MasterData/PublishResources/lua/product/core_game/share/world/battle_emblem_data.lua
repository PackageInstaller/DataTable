local EmblemElementComType = {
  Equal = 1,
  Greater = 2,
  Less = 3
}
_enum("EmblemElementComType", EmblemElementComType)
_class("BattleEmblemElementData", Object)
BattleEmblemElementData = BattleEmblemElementData

function BattleEmblemElementData:Constructor(data, cfgData)
  self._data = data
  self._cfgData = cfgData
end

function BattleEmblemElementData:GetComType()
  if self._data == self._cfgData then
    return EmblemElementComType.Equal
  end
  if self._data > self._cfgData then
    return EmblemElementComType.Greater
  end
  return EmblemElementComType.Less
end

function BattleEmblemElementData:GetData()
  return self._data
end

_class("BattleEmblemData", Object)
BattleEmblemData = BattleEmblemData

function BattleEmblemData:Constructor(id, sp, criChance, criDamage, hitRate, comboRate, randomRate)
  self._emblemID = id
  self._spData = nil
  self._criChanceData = nil
  self._criDamageData = nil
  self._hitRateData = nil
  self._comboRateData = nil
  self._randomRateData = nil
end

function BattleEmblemData:BuildEmblemData(emblemData)
end
