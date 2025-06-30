

module("task.AchievementConfigVo", Class.impl())

function ctor(self)
	-- 由外部赋值
	self.uicode = nil
end

function parseData(self, id, tabType, cusData)
	self.id = id
	self.step = cusData.step
	self.m_awardList = cusData.rewards
	self.name = cusData.name
	self.des = cusData.describe
	self.targetCount = cusData.factor
	self.tabType = tabType
	self.achievementPoint = cusData.achievement_point
end

function getAwardList(self)
	local awardList = {}
	for i = 1, #self.m_awardList do
		local propsVo = props.PropsVo.new()
		propsVo:setTid(self.m_awardList[i][1])
		propsVo.count = self.m_awardList[i][2]
		table.insert(awardList, propsVo)
	end
	return awardList
end

function getName(self)
	return _TT(self.name)
end

function getDes(self)
	return _TT(self.des)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
