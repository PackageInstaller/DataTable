--
-- Author:luqucheng
-- Date: 2019-11-27 18:12:49
--
local PushCatSkillCardRecord = Class("PushCatSkillCardRecord")

function  PushCatSkillCardRecord:__init(card, camp, playerId)
    self.recordType = Constants.RecordType.PushCatCard
    self.card = card
    self.camp = camp
    self.playerId = playerId
end

function PushCatSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.PushCatCard,
        cc = self.card:ToData(),
        c = self.camp,
        pId = self.playerId,
    }
end

return  PushCatSkillCardRecord