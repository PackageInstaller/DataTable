module("hero.HeroMilitaryRankScrollItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.m_gridNode = self:getChildTrans("BaseGrid")
end

function setData(self, param)
    super.setData(self, param)

    local scrollHeroVo = self.data
    local heroVo = scrollHeroVo:getDataVo()
    if (heroVo) then
        if (not self.m_heroHeadGrid) then
            self.m_heroHeadGrid = HeroHeadSelectGrid:poolGet()
        end
        self.m_heroHeadGrid:setData(heroVo)
        self.m_heroHeadGrid:setParent(self.m_gridNode)
        self.m_heroHeadGrid:setLvl(heroVo.lvl)
        self.m_heroHeadGrid:setIsShowUseState(true)
        self.m_heroHeadGrid:setCallBack(self, self.__onClickHeadHandler)
        self:setSelectState(scrollHeroVo:getSelect())
    else
        self:deActive()
    end
end

function __onClickHeadHandler(self, args)
    local scrollHeroVo = self.data
    local heroVo = scrollHeroVo:getDataVo()
    -- scrollHeroVo:setSelect(not scrollHeroVo:getSelect())
	if(hero.HeroUseCodeManager:getIsCanUse(heroVo.id, true))then
		hero.HeroMilitaryRankManager:dispatchEvent(hero.HeroMilitaryRankManager.HERO_MILITARY_RANK_MATERIAL_SELECT, heroVo)
	end
end

function setSelectState(self, cusIsSelect)
    if (self.m_heroHeadGrid) then
        self.m_heroHeadGrid:setSelectState(cusIsSelect)
    end
end

function getSelectState(self)
    if (self.m_heroHeadGrid) then
        return self.m_heroHeadGrid:getSelectState()
    end
end

function deActive(self)
    super.deActive(self)
    if (self.m_heroHeadGrid) then
        self.m_heroHeadGrid:poolRecover()
        self.m_heroHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
