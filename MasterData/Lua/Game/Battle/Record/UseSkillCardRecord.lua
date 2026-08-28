--
-- Author:luqucheng
-- Date: 2019-11-27 19:58:18
--
local UseSkillCardRecord = Class("UseSkillCardRecord")

--@card: [Game.Battle.SkillCard.SkillCard#SkillCard]
function  UseSkillCardRecord:__init(dst, targetId, point, card, cardMgr, params, inputParams)
    self.dst = dst
    self.point = point
    self.targetId = targetId
    self.roleId = card.roleId
    self.star = card.star
    self.isUltra = card.isUltra
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
    self.skillIndex = card.skillIndex
    self.recordType = Constants.RecordType.UseCard
    self.params = params
    self.inputParams = inputParams
end

function UseSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.UseCard,
        d = self.dst,--{x坐标（从左往右数），y坐标（从上往下数）}
        p = self.point,--{roleId, pointAdd}
        ri = self.roleId,
        si = self.skillIndex,
        s = self.star,
        ti = self.targetId,
        c = self.camp,
        sp = self.isUltra,
        params = self.inputParams,
        pId = self.playerId,
    }
end

return  UseSkillCardRecord