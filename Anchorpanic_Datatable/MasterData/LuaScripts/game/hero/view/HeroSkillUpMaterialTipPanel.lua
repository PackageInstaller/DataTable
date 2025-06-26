--[[   
     英雄技能升级材料选择界面
]]
module('hero.HeroSkillUpMaterialTipPanel', Class.impl(hero.HeroMilitaryRankMaterialTipPanel))

function initViewText(self)
	self.m_textNotRemind.text = _TT(1073)--"今日不再提示"
	self.m_textTip.text = _TT(27015) --"确认消耗以下战员进行技能等级提升吗？"
end

function setData(self, args)
	self.m_heroId = args.heroId
	self.m_skillId = args.skillId
	self:__updateView()
end

function __onClickConfirmHandler(self)
	local materialIdList = self:__getMaterialHeroIdList()
	self:close()
	if(self.m_isNotRemind)then
		GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {moduleId = self:__remindType()})
	end
	GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_UP, {heroId = self.m_heroId, skillId = self.m_skillId})
end

function __remindType(self)
	return RemindConst.HERO_SKILL_UP
end

function __getMaterialHeroIdList(self)
	return hero.HeroSkillUpManager.materialHeroIdList
end

function __getNeedMaterialCount(self)
	return hero.HeroSkillUpManager.needMaterialCount
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
