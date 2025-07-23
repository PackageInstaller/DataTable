module("recruit.RecruitSucItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
	super.onInit(self, go)
end

function setData(self, param)
	super.setData(self, param)
    local heroTid = self.data
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
    if (heroConfigVo) then
        if (not self.m_heroCard) then
            self.m_heroCard = hero.HeroCard:poolGet()
        end
        self.m_heroCard:setData(heroConfigVo)
        self.m_heroCard:setParent(self.m_childTrans["HeroCardNode"])
        self.m_heroCard:setScale(1)
    else
        self:deActive()
    end
end

function deActive(self)
	super.deActive(self)
    if (self.m_heroCard) then
        self.m_heroCard:poolRecover()
        self.m_heroCard = nil
    end
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
