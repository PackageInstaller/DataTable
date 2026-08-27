local BrotatoMonsterDropBuff = class("BrotatoMonsterDropBuff", LuaSkillBase)
local base = LuaSkillBase
BrotatoMonsterDropBuff.config = {}

function BrotatoMonsterDropBuff:ctor()
end

function BrotatoMonsterDropBuff:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBrotatoMonsterDie, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "BrotatoMonsterDropBuff_1_start", 0, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "BrotatoMonsterDropBuff_1_end", 0, self.BeforeBattleEnd)
  self.dropBuffList = {}
end

function BrotatoMonsterDropBuff:OnAfterBattleStart()
  local battleRoomId = LuaSkillCtrl:GetBattleRoomId()
  local sectorStageCfg = ConfigData.brotato_sector_stage_extra[battleRoomId]
  if sectorStageCfg == nil then
    error("brotato_sector_stage_extra表缺少对应房间：" .. tostring(battleRoomId))
    return
  end
  LuaSkillCtrl:CleanDropBuff()
  if not LuaSkillCtrl.IsInVerify then
    local dynPlayer
    if ExplorationManager:IsInExploration() then
      dynPlayer = ExplorationManager:GetDynPlayer()
    elseif BattleDungeonManager:InBattleDungeon() then
      dynPlayer = BattleDungeonManager:GetDungeonDynPlayer()
    end
    if dynPlayer ~= nil then
      for k, v in pairs(sectorStageCfg.drop_buff_list) do
        if dynPlayer:GetEpBuffCount(v) < 1 then
          table.insert(self.dropBuffList, v)
        end
      end
    end
  end
end

function BrotatoMonsterDropBuff:OnRoleDie(killer, role)
  if killer.belongNum == eBattleRoleBelong.player and #self.dropBuffList > 0 and role.recordTable.isCanDropBuff then
    local randNum = LuaSkillCtrl:CallRange(1, #self.dropBuffList)
    local buffId = self.dropBuffList[randNum]
    table.remove(self.dropBuffList, randNum)
    LuaSkillCtrl:AddDropBuff(buffId)
    if not LuaSkillCtrl.IsInVerify then
      local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
      if battleWin and battleWin.gameplayScore then
        battleWin.gameplayScore:PlaySeqBuffTipTween()
      end
      local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if stateInfoWin ~= nil then
        stateInfoWin.buffList:AddDropBuff()
        AudioManager:PlayAudioById(1009)
      end
    end
  end
end

function BrotatoMonsterDropBuff:BeforeBattleEnd()
  if not LuaSkillCtrl.IsInVerify then
    local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if stateInfoWin ~= nil then
      stateInfoWin.buffList:CleanDropBuff()
    end
  end
end

function BrotatoMonsterDropBuff:OnCasterDie()
  base.OnCasterDie(self)
end

return BrotatoMonsterDropBuff
