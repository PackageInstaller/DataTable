--
-- Author:luqucheng
-- Date: 2019-11-27 19:45:42
--
local MoveSkillCardRecord = Class("MoveSkillCardRecord")

function  MoveSkillCardRecord:__init(src, dst, point, cardMgr)
    self.src = src
    self.dst = dst
    self.point = point
    self.recordType = Constants.RecordType.MoveCard
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId

end

function MoveSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.MoveCard,
        s = self.src,--{x坐标（从左往右数），y坐标（从上往下数）}
        d = self.dst,--{x坐标（从左往右数），y坐标（从上往下数）}
        p = self.point,--{roleId, pointAdd}
        c = self.camp,
        pId = self.playerId,
    }
end

return  MoveSkillCardRecord