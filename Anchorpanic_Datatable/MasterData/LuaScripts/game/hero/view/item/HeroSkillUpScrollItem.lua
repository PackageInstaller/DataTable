module("hero.HeroSkillUpScrollItem", Class.impl(hero.HeroColorUpScrollItem))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
end

function __onClickHeadHandler(self, args)
    local scrollHeroVo = self.data
    local heroVo = scrollHeroVo:getDataVo()
    -- scrollHeroVo:setSelect(not scrollHeroVo:getSelect())
	if(hero.HeroUseCodeManager:getIsCanUse(heroVo.id, true))then
		hero.HeroSkillUpManager:dispatchEvent(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_SELECT, heroVo)
	end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
