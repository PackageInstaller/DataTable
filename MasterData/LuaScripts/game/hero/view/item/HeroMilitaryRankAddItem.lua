module("hero.HeroMilitaryRankAddItem", Class.impl(HeroHeadAddGrid))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroMilitaryRankAddItem.prefab")

function __initData(self)
    super.__initData(self)
    
    self.m_cg = nil
end

function setData(self, cusHeroData, cusIsAsyn)
    self:__reset()
    local name = self:__getPrefabName()
    self.m_uiGo = gs.GOPoolMgr:Get(name)
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
    local toucher = self.m_childGos["ImgToucher"]
    self:addOnClick(toucher, self.__onClickHandler)
    self.m_isLoadFinish = true
    self.m_data = cusHeroData

    self:__updateHead(cusIsAsyn)
end

function setTemp(self, cusHeroData)
    self.m_heroHeadGrid = HeroHeadGrid:poolGet()
    self.m_heroHeadGrid:setData(cusHeroData)
    self.m_heroHeadGrid:setIsShowUseState(false)
    self.m_heroHeadGrid:setParent(self.m_childTrans["BaseGrid"])
    self.m_heroHeadGrid:setStarLvl(-1)
    if self.m_cg == nil then
        self.m_cg = self.m_uiGo:GetComponent(ty.CanvasGroup)
    end
    self.m_cg.alpha = 0.3
end

function __updateHead(self, cusIsAsyn)
    super.__updateHead(self, cusIsAsyn)
    local heroData = self:getData()
    if (heroData) then
        self.m_childGos["ImgClose"]:SetActive(true)
    else
        self.m_childGos["ImgClose"]:SetActive(false)
    end
end

function __updateClickEnable(self)
    if (self.m_isLoadFinish and self.m_temp == false) then
        local toucher = self.m_childGos["ImgToucher"]
        if (self.m_clickEnable == nil or self.m_clickEnable == true) then
            if not toucher:GetComponent(ty.Button) then
                -- logWarn(self.__cname, self:__getPrefabName().."没有对应Button组件")
            else
                self:addOnClick(toucher, self.__onClickHandler)
            end
        else
            if toucher:GetComponent(ty.Button) then
                self:removeOnClick(toucher)
            end
        end
    end
end

function __reset(self)
    if self.m_cg then
        self.m_cg.alpha = 1
    end
    super.__reset(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
