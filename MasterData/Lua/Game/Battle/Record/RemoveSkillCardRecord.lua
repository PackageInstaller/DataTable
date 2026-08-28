--
-- Author:luqucheng
-- Date: 2019-12-10 20:44:10
--
local RemoveSkillCardRecord = Class("RemoveSkillCardRecord")

RemoveSkillCardRecord.posArray = nil
function  RemoveSkillCardRecord:__init( posArray, cardMgr, removeType )
    self.posArray = posArray
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
    self.recordType = Constants.RecordType.DeleteCard
    self.removeType = removeType or 0

    -- print("BattleMyCard", table.toString(self:ToData(), "data"))
end

function RemoveSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.DeleteCard,
        pa = self.posArray,--{x坐标（从左往右数），y坐标（从上往下数）}数组
        c = self.camp,
        rt = self.removeType,--移除类型，0普通，1吞噬
        pId = self.playerId
    }
end

return  RemoveSkillCardRecord