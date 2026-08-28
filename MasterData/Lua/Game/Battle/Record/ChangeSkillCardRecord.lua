--
-- Author:luqucheng
-- Date: 2019-11-27 19:45:42
--
local ChangeSkillCardRecord = Class("ChangeSkillCardRecord")

function  ChangeSkillCardRecord:__init(pos, card, cardMgr)
    self.pos = {pos[1],pos[2]}
    self.cardData = card:ToData()
    self.recordType = Constants.RecordType.ChangeCard
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId

end

function ChangeSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.ChangeCard,
        p = self.pos,
        d = self.cardData,
        c = self.camp,
        pId = self.playerId,
    }
end

return  ChangeSkillCardRecord