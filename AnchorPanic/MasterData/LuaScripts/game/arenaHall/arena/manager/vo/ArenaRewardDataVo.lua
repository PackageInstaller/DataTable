

module("ArenaRewardDataRo", Class.impl())

function parseData(self,refData)
	self.rankIcon=refData.rank_icon
	self.rankName=refData.rank_name
	self.needScore=refData.need_score
	self.dayReward=refData.day_reward
	self.seasonReward=refData.season_reward
	self.rankIcon=refData.rank_icon
end

function getScoreInterval(self)
	if self.needScore >= arena.ArenaManager:getMaxSegmentNeedScore() then 
		return self.needScore.."~"
	end
	return self.needScore .. "~" ..arena.ArenaManager:getNextSegment(self.needScore)
end
--获取奖励列表
function getAwardList(self,style)
	if style==arena.ArenaAwardType.DAILY then 
		return arena.ArenaManager:getAwardListToStyle(self.dayReward)
	else 
		return arena.ArenaManager:getAwardListToStyle(self.seasonReward)
	end
end

--获取段位图标
function getRankIcon(self)
	local iconPath = UrlManager:getIconPath(self.rankIcon)
    return iconPath
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
