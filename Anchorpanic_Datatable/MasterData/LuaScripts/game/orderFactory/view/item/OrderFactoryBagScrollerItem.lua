module('game.orderFactory.view.item.OrderFactoryBagScrollerItem', Class.impl('lib.component.BaseItemRender'))

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
            self.m_grid = OrderGrid:poolGet()
        end
        self.m_grid:setData(equipVo)
        self.m_grid:setParent(self.m_childTrans['GridNode'])
        self.m_grid:setClickEnable(false)
        self.m_grid:setScale(0.78)

        if (equipVo.heroId == 0) then
            self:getChildGO("GridHeroIcon"):SetActive(false)
        else
            self:getChildGO("GridHeroIcon"):SetActive(true)
            --     local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
            self.m_imgHero:SetImg(UrlManager:getIconPath(string.format("helper/helperHead/helper_head_%s.png", equipVo.heroId)), false)
        end

        self:setNormalSelect(isSelect)
        self:addOnClick(self:getChildGO("ImgToucher"), self.onClickItemHandler)
    else
        self:deActive()
    end
end

function onClickItemHandler(self)
    local equipVo = self.data:getDataVo()
    if orderFactory.OrderFactoryManager:isFullMaterial() and self.data:getSelect() == false then
        -- gs.Message.Show2("材料已满")
        gs.Message.Show2(_TT(43704))
        return
    end

    orderFactory.OrderFactoryManager:setSelectMaterialList(equipVo.id)
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
