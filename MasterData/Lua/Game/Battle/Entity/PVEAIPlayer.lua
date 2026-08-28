--
-- Author:luqucheng
-- Date: 2019-12-11 14:04:07
--
local MonsterAI = import("Game.Battle.AI.MonsterAI")
local Controller = import('Game.Battle.Entity.Controller')
local PVEAIPlayer = Class("PVEAIPlayer", Controller)

PVEAIPlayer.AISkills = nil--AI预先选择好的技能
PVEAIPlayer.monsterAi = nil

function PVEAIPlayer:__init(camp, playerId, initData)
    Controller.__init(self, camp, playerId)
    self.isPlayer = false
    self.monsterAi = MonsterAI.New()
    self.monsterAi:LoadBt(initData.enemyTeam)
end

function PVEAIPlayer:__delete()
    Controller.__delete(self)

    self.monsterAi:Delete()
end

function PVEAIPlayer:OnRequireInput( callback, refInputSkills )
    table.link(refInputSkills, self.AISkills)
    callback(self, 0)
end

function PVEAIPlayer:OnGameStart(  )
    --AI方会先选择好使用的技能
    -- self.cardMgr:LocalStartRound()
    -- AI:CardSelect(self)
    -- local skills, recs = self.cardMgr:LocalEndRound()
    -- RecordMgr:AddRecords( recs )
    -- self:SetAISkills(skills)
    
end

function PVEAIPlayer:OnTurnStart( camp )
    local isWaveEnd, isGameEnd, winCamp = BattleMgr:IsGameOver()
    if isGameEnd then
        return
    end
    if camp == self.camp then
        local skills = self.monsterAi:GetAIAction(self.camp, false)
        self:SetAISkills(skills)
    end
end

function PVEAIPlayer:HandleMonsterAIs(  )
    
end

function PVEAIPlayer:OnTurnEnd( camp )
    --AI方会先选择好使用的技能
    -- self.cardMgr:LocalStartRound()
    -- AI:CardSelect(self)
    -- local skills, recs = self.cardMgr:LocalEndRound()
    -- RecordMgr:AddRecords( recs )
    -- self:SetAISkills(skills)
    -- local skills = AI:GetAIAction(self)
    -- self:SetAISkills(skills)
end

function PVEAIPlayer:SetAISkills( AISkills )
    self.AISkills = AISkills
    RecordMgr:AddRecord(RecordMgr.AIChooseSkillRecord.New(self.AISkills))
end

return  PVEAIPlayer