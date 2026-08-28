--
-- Author:luqucheng
-- Date: 2019-12-11 19:30:46
--
local RequireInputRecord = Class("RequireInputRecord")
function  RequireInputRecord:__init(cardChoosableNum, cardMgr)
    self.cardChoosableNum = cardChoosableNum
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
    self.actionPoint = cardMgr:GetSkillCardMaxUseCount()
    self.campActionPoint = BattleMgr:GetCampSkillCardMaxUseCount(self.camp)
end

function RequireInputRecord:ToData()
    return {
        r = Constants.RecordType.RequireInput,--战报类型
        n = self.cardChoosableNum, --总计可以使用的卡牌数量
        c = self.camp,
        pId = self.playerId,
        ap = self.actionPoint,
        cap = self.campActionPoint,
    }
end
return  RequireInputRecord