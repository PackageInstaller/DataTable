local GearItemPoisonGas, Super = System.NewClass("GearItemPoisonGas", GearItemBase)

function GearItemPoisonGas:OnTriggerChild(svrData)
  local data = svrData and svrData.data or {}
  local subHp = data.subHp
  if subHp then
    local tipId = 10643
    local desc = LT.Textf(DT.TipsType[tipId].Desc, subHp)
    AudioManager.Instance:PostSoundEvent("EXPLORE_BLOCK_POISON_HURT")
  end
  self:AfterTrigger()
end

return GearItemPoisonGas
