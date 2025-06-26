module("hero.HeroMaterialItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

	self.m_guideClick = self:getChildGO("GuideClick")
	self:addOnClick(self.m_guideClick, self.__onClickCardHandler)
end

function getTrans(self)
	return self.m_guideClick.transform
end

function setData(self, param)
    super.setData(self, param)
    local heroSelectVo = self.data
    local isSelect = heroSelectVo:getSelect()
    local heroVo = heroSelectVo:getDataVo()
    if (heroVo) then
        local function __onLoadFinishHandler()
            self:__onLoadFinishHandler()
        end
        if (not self.mHeroCard) then
            self.mHeroCard = hero.HeroCard:poolGet()
        end
        self.mHeroCard:setData(heroVo, nil, __onLoadFinishHandler)
        self.mHeroCard:setStarLvl(heroVo.evolutionLvl)
        self.mHeroCard:setParent(self.m_childTrans["HeroCardNode"])
        self.mHeroCard:setShowUseState(false)
        self.mHeroCard:setScale(0.6)
        -- self.mHeroCard:setClickEnable(true)
        -- self.mHeroCard:setCallBack(self, self.__onClickCardHandler)
    else
        self:deActive()
    end
end

function __onLoadFinishHandler(self)
    local heroSelectVo = self.data
    local isSelect = heroSelectVo:getSelect()
    self:__setSelect(isSelect)
end

function __onClickCardHandler(self)
    local heroSelectVo = self.data
    local heroVo = heroSelectVo:getDataVo()
    hero.HeroSkillUpManager:dispatchEvent(hero.HeroManager.HERO_MATERIAL_SELECT, {heroVo = heroVo })
end

function __setSelect(self, isSelect)
    if(self.mHeroCard)then
        self.mHeroCard:setSelect(isSelect)
    end
end

function deActive(self)
    super.deActive(self)
    if (self.mHeroCard) then
        self.mHeroCard:poolRecover()
        self.mHeroCard = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
