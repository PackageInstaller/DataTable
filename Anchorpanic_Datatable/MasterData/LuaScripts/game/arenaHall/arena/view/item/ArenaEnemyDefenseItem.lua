module("arena.ArenaEnemyDefenseItem", Class.impl())

function setParent(self, cusParentTrans)
    self.UIObject = gs.GOPoolMgr:Get("ArenaEnemyDefenseItem.prefab")
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
    self.UIObject.transform:SetParent(cusParentTrans, false)
end

function setIndex(self, cusIndex)
    self.m_imgIndex = self.m_childGos["ImgIndex"]:GetComponent(ty.AutoRefImage)
    self.m_imgIndex:SetImg(UrlManager:getFormationTileImgUrl(cusIndex), false)
end

function setCanStand(self)
    local formationTileCount, row, col = formation.FormationManager:getFormationTileCount()
    self.m_imgIndex = self.m_childGos["ImgIndex"]:GetComponent(ty.AutoRefImage)
    self.m_imgIndex:SetImg(UrlManager:getFormationTileImgUrl(formationTileCount + 1), false)
end

function setHero(self, cusFormationHeroVo)
    if (not self.heroHeadGrid) then
        self.heroHeadGrid = HeroHeadGrid:poolGet()
    end
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(cusFormationHeroVo:getHeroTid())
    self.heroHeadGrid:setData(heroConfigVo)
    self.heroHeadGrid:setParent(self.UIObject.transform)
    self.heroHeadGrid:setName("")
    -- self.heroHeadGrid:setLvl(cusFormationHeroVo:getHeroLvl())
    -- self.heroHeadGrid:setStarLvl(cusFormationHeroVo:getHeroEvolutionLvl())
    self.heroHeadGrid:setScale(1.24)
    self.heroHeadGrid:setClickEnable(false)
end

function resetData(self)
    gs.GOPoolMgr:Recover(self.UIObject, "ArenaEnemyDefenseItem.prefab")
    self.UIObject = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self.m_imgIndex = nil

	if(self.heroHeadGrid)then
		self.heroHeadGrid:poolRecover()
		self.heroHeadGrid = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
