module("HeroHeadAddGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/HeroHeadAddGrid.prefab")

function __initData(self)
    super.__initData(self)
    
    --------------------------------------------- 数据源 self.m_data 为 hero.HeroVo 或 hero.HeroConfigVo ---------------------------------------------
    self.m_heroHeadGrid = nil
    self.m_isSelect = nil
end

function __reset(self)
    if(self.m_heroHeadGrid)then
        self.m_heroHeadGrid:poolRecover()
        self.m_heroHeadGrid = nil
    end
    super.__reset(self)
end

function setData(self, cusHeroData, cusIsAsyn)
    self:__reset()
    local name = self:__getPrefabName()
    self.m_uiGo = gs.GOPoolMgr:Get(name)
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
    self:addOnClick(self.m_uiGo, self.__onClickHandler)
    self.m_isLoadFinish = true
    self.m_data = cusHeroData

    self:__updateHead(cusIsAsyn)
end

function __updateHead(self, cusIsAsyn)
    local heroData = self:getData()
    if (heroData) then
        self.m_heroHeadGrid = HeroHeadGrid:poolGet()
        self.m_heroHeadGrid:setData(heroData, cusIsAsyn)
        self.m_heroHeadGrid:setIsShowUseState(false)
        self.m_heroHeadGrid:setParent(self.m_childTrans["BaseGrid"])
        self.m_heroHeadGrid:setRes(true)
    end
end

function setLvl(self, cusLvl)
    if (self.m_heroHeadGrid) then
        self.m_heroHeadGrid:setLvl(cusLvl)
    end
end

-- 点击默认触发
function __onDefaultClickHandler(self)
    if (self.m_heroHeadGrid) then
        self.m_heroHeadGrid:__onDefaultClickHandler()
    end
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    super.setCallBack(self, cusCallObj, cusCallFun, ...)
    
    if (self.m_heroHeadGrid) then
        self.m_heroHeadGrid:setClickEnable(false)
    end
end

return _M
