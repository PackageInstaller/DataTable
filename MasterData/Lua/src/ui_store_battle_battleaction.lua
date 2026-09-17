local this = {}

function this:getBattleItem(itemId)
  local battleItem = {item_id = itemId, index = 0}
  local step = L_SceneStore:getSceneObj(itemId).curStep
  battleItem.step = step
  return battleItem
end

function this:req_dungeonBattle(itemId, callback)
  L_UI:backToRoot()
  local createBattleType = self:getCreateBattleType()
  if createBattleType then
    return
  end
  self:setCreateBattleType(L_Const.createBattleType.single)
  local data = {
    entry = L_Const.BattleEntryType.BET_BATTLE_COMPAIGN,
    type = L_Const.battleType.single,
    battle_campaign_obj = itemId
  }
  L_Net:sendMessage(MsgGenCode.CSProtoBattleCreate, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    else
      self:setCreateBattleType(nil)
    end
  end)
end

function this:req_createMultiBattle(callback)
  printf("组队战斗暂时不考虑，代码已注释")
end

function this:rsp_createBattle(sData)
  errorf("沒有這種戰鬥")
end

function this:rsp_finHandle(sData)
end

function this:setBattleReward(rewardList)
  self.data.rewardList = rewardList
  self:resetBattleRewardShowMark()
end

function this:setCatchReward(rewardList)
  self.data.catchRewardList = rewardList
  self:resetBattleRewardShowMark()
end

function this:setBattleRewardShowMark()
  self.data.battleRewardShowMark = true
end

function this:resetBattleRewardShowMark()
  self.data.battleRewardShowMark = false
end

function this:clearHeroDataCache()
  self.data.heroCache = nil
end

function this:setFightOver()
  self.fightIdMap = nil
  self:resetBattleRewardShowMark()
end

function this:req_reqFightEscape()
  L_Net:sendMessage(MsgGenCode.CSProtoFightEscape)
end

function this:rsp_syncBattleHeroInfo(sData)
  if sData == nil or sData.heros == nil then
    return
  end
  for i = 1, #sData.heros do
    local hero = sData.heros[i]
    local attrData = hero.attrs and hero.attrs.attrs or {}
    local winfoAttr
    if hero.winfo ~= nil then
      winfoAttr = hero.winfo.attrs.attrs
    end
    local oinfoAttr
    if hero.oinfo ~= nil then
      local oinfo = hero.oinfo
      oinfoAttr = {}
      for i = 1, #oinfo do
        local o = oinfo[i].attrs
        if o.attrs ~= nil then
          for j = 1, #o.attrs do
            local oa = o.attrs[j]
            if oinfoAttr[oa.attr_id] == nil then
              table.insert(oinfoAttr, {
                attr_id = oa.attr_id,
                attr_val = oa.attr_val
              })
            else
              oinfoAttr[oa.attr_id].attr_val = oinfoAttr[oa.attr_id].attr_val + oa.attr_val
            end
          end
        end
      end
    end
    local subAttrs = {
      winfoAttr or {},
      oinfoAttr or {},
      hero.buffs and hero.buffs.attrs or {}
    }
  end
end

function this:rsp_syncObjBattleInfo(data)
  if data == nil then
    return
  end
  local infos = data.infos
  for i, info in pairs(infos) do
    local curUUID = info.uuid
    self.data.objBattleInfo[curUUID] = info
    local heroDic = L_PlayerManager:getAllHeroCsEntity()
    if not TableIsNull(heroDic) then
      for _, hero in pairs(heroDic) do
        local curHp = C_MyFloatUtility.GetFloat(hero.data.aliveProperty.hp)
        local lastHp = C_MyFloatUtility.GetFloat(hero.data.aliveProperty.lastHp)
        if hero.data.UUID == curUUID and (C_EntityManager.IsEntityDead(hero.data.entityId) or math.abs(curHp - lastHp) < 1.0E-4) then
          goto lbl_75
        end
      end
      if info.reason == L_Const.HeroBattleInfoSyncReason.HBISR_TRANS_POINT or info.reason == L_Const.HeroBattleInfoSyncReason.HBISR_CHARGE then
        L_StarHealingStore:call(L_StarHealingStore.event.playStarHealingEffect, info.uuid)
      end
    end
    ::lbl_75::
  end
end

function this:rsp_syncObjBattleInfoByHurt(data)
  if data == nil then
    return
  end
  local hurt = data.hurt or {}
  for i, v in pairs(hurt) do
    self.data.objBattleInfo[v.tar_id] = {
      hp = v.cur_hp or 0,
      sp = v.sp,
      uuid = v.tar_id
    }
  end
end

return this
