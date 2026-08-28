--[[
    author:luqucheng
    time:2023-02-01 17:39:05
]]
local CardController = import('Game.Battle.Entity.CardController')
local SkillCardMgr = import('Game.Battle.SkillCard.SkillCardMgr')

local TeamPlayer = {}
TeamPlayer = Class("TeamPlayer", CardController)

function TeamPlayer:__init(camp, playerId, initData)
    CardController.__init(self, camp, playerId)

    self.isPlayer = true

   
    self.cardMgr1 = SkillCardMgr.New()
    self.cardMgr1:Init(self, camp == Constants.Camp.One and initData.playerTeam or initData.enemyTeam)

    self.cardMgr2 = SkillCardMgr.New()
    self.cardMgr2:Init(self, camp == Constants.Camp.One and initData.playerTeam or initData.enemyTeam)
    
    self.__UseReplayInput = Bind(self, self.UseReplayInput)
    Events.AddListener(Constants.EventNames.BattleRequireInput, self.__UseReplayInput)
end

return TeamPlayer