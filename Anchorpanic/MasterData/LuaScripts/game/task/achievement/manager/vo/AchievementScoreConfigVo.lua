

module("task.AchievementScoreConfigVo", Class.impl())

function ctor(self)
end

function parseData(self, id, score, awardId)
	self.id = id
	self.score = score
	self.awardId = awardId

	self.mAwardList = nil
end

function getAwardList(self)
	if(not self.mAwardList)then
		self.mAwardList = {}
		local list = AwardPackManager:getAwardListById(self.awardId)
		for i = 1, #list do
			local vo = list[i]
			table.insert(self.mAwardList, {tid = vo.tid, num = vo.num })
		end
	end
	return self.mAwardList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
