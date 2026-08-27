local gs_2000 = class("gs_2000", LuaGridBase)
gs_2000.config = {}

function gs_2000:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
    return
  end
  local existSummoner = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  if existSummoner ~= nil then
    warn("该人形已装备了义肢")
    self:GridLoseEffect()
    return
  end
  local roleAtkSkill = role:GetCommonAttack()
  if roleAtkSkill == nil then
    self:GridLoseEffect()
    return
  end
  local summoner = LuaSkillCtrl.cluaSkillCtrl:CreateSummoner(roleAtkSkill, self.config.equipmentSummonerId, role.x, role.y, -1)
  summoner:SetAttr(eHeroAttr.maxHp, 1)
  summoner:SetAttr(eHeroAttr.pow, 1)
  summoner:SetAttr(eHeroAttr.intensity, 1)
  summoner:SetAttr(eHeroAttr.speed, role.speed)
  summoner:SetAsRealEntity(15)
  local key = ConfigData.buildinConfig.EquipmentSummonerKey
  local tab = {
    [key] = role,
    equipSummoner = true
  }
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  role.recordTable[key] = summonerEntity
  if summonerEntity ~= nil then
    LuaSkillCtrl:CallBuff(self, summonerEntity, ConfigData.buildinConfig.EquipmentSummonerInvinsibleBuffId, 1, nil)
    role.recordTable[key] = summonerEntity
    summonerEntity:BindHostEntity(role)
    if not LuaSkillCtrl.IsInVerify then
      local trans = summonerEntity.lsObject.transform
      if not IsNull(trans) then
        trans:SetLocalScale(trans.localScale.x, trans.localScale.y, -trans.localScale.z)
      end
      summonerEntity.lsObject.transform.localRotation = Quaternion.identity
    end
  end
  self:GridLoseEffect()
end

return gs_2000
