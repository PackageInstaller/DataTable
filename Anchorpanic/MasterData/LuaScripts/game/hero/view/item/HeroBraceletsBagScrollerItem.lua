module('hero.HeroBraceletsBagScrollerItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.m_imgHero = self:getChildGO("ImgHero"):GetComponent(ty.AutoRefImage)
end

function getTrans(self)
    return self:getChildTrans("ImgToucher")
end

function setData(self, param)
    self.data = param
    if (self.data) then
        local equipVo = self.data:getDataVo()
        local isSelect = self.data:getSelect()

        if (not self.m_grid) then
            self.m_grid = BraceletsGrid:poolGet()
        end
        self.m_grid:setData(equipVo)
        self.m_grid:setParent(self.m_childTrans['GridNode'])
        self.m_grid:setClickEnable(false)
        self.m_grid:setScale(0.7)
        gs.TransQuick:Scale(self.m_grid.mImgLock:GetComponent(ty.RectTransform),1.42857, 1.42857,1.42857)
        -- self.m_grid.mImgLock
        --self.m_imgHero.gameObject:SetActive(false)
        if equipVo == nil then
            self:getChildGO("GridHeroIcon"):SetActive(false)
            self:setNormalSelect(false)
            return
        end

        -- if(equipVo.heroId == 0)then
        --     self:getChildGO("GridHeroIcon"):SetActive(false)
        -- else
        --     self:getChildGO("GridHeroIcon"):SetActive(true)
        --     -- local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
        --     -- self.m_imgHero:SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), false)
        -- end

        self:setNormalSelect(isSelect)
        self:addOnClick(self:getChildGO("ImgToucher"), self.onClickItemHandler)
    else
        self:deActive()
    end
end

function onClickItemHandler(self)
    local equipVo = self.data:getDataVo()

    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, equipVo.id)
    if self.isNew then
        self.m_grid:setIsNew(false) 
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = equipVo.id })
    end

    GameDispatcher:dispatchEvent(EventName.BRACELETS_SELECT_CHANGE,{equipVo = equipVo,scrollerVo = self})
    --hero.HeroBraceletsManager:dispatchEvent(hero.HeroBraceletsManager.BRACELETS_SELECT_CHANGE,{equipVo = equipVo,scrollerVo = self})
    --hero.HeroBraceletsManager:dispatchEvent(hero.HeroBraceletsManager.BRACELETS_BAG_EQUIP_SELECT, { equipVo = equipVo })
end

-- 设置普通选中状态
function setNormalSelect(self, isSelect)
    if (isSelect) then
        self:getChildGO("ImgSelect"):SetActive(true)
    else
        self:getChildGO("ImgSelect"):SetActive(false)
    end
end

function deActive(self)
    super.deActive(self)
    if (self.m_grid) then
        gs.TransQuick:Scale(self.m_grid.mImgLock:GetComponent(ty.RectTransform),1,1,1)
        self.m_grid:poolRecover()
        self.m_grid = nil
    end
    self:removeOnClick(self:getChildGO("ImgToucher"))
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
