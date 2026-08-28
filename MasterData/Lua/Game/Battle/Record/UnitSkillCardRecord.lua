--
-- Author:luqucheng
-- Date: 2019-11-27 15:30:14
--
local UnitSkillCardRecord = {}
UnitSkillCardRecord = Class("UnitSkillCardRecord")

function  UnitSkillCardRecord:__init(src, dst, point, resultStar, isPlayerMoveAndUnitSameCard, cardMgr)
    self.src = src
    self.dst = dst
    self.point = point
    self.recordType = Constants.RecordType.UnitCard
    self.resultStar = resultStar
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
    self.isPlayerMoveAndUnitSameCard = isPlayerMoveAndUnitSameCard
end

function UnitSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.UnitCard,
        s = self.src,--{x坐标（从左往右数），y坐标（从上往下数）}
        d = self.dst,--{x坐标（从左往右数），y坐标（从上往下数）}
        p = self.point,--{roleId, pointAdd}
        c = self.camp,
        st = self.resultStar,
        im = self.isPlayerMoveAndUnitSameCard,--是否手动移动覆盖同牌
        pId = self.playerId,
    }
end

return  UnitSkillCardRecord