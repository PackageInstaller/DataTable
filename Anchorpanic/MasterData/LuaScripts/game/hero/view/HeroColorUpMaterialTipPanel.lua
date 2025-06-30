--[[   
     英雄升品材料选择界面
]]
module('hero.HeroColorUpMaterialTipPanel', Class.impl(hero.HeroMilitaryRankMaterialTipPanel))

function initViewText(self)
	self.m_textNotRemind.text = _TT(1073)--"今日不再提示"
	self.m_textTip.text = _TT(1122) --"确定消耗以下材料进行升品吗？"
end

function __onClickConfirmHandler(self)
	local materialIdList = self:__getMaterialHeroIdList()
	self:close()
	if(self.m_isNotRemind)then
		GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {moduleId = self:__remindType()})
	end
	GameDispatcher:dispatchEvent(EventName.REQ_HERO_COLOR_UP, {heroId = self.m_heroId, costHeroIdList = materialIdList})
end

function __remindType(self)
	return RemindConst.HERO_COLOR_UP
end

function __getMaterialHeroIdList(self)
	return hero.HeroColorUpManager.materialHeroIdList
end

function __getNeedMaterialCount(self)
	return hero.HeroColorUpManager.needMaterialCount
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
