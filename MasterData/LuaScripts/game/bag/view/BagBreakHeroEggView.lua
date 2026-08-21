--[[ 
-----------------------------------------------------
@filename       : BagBreakHeroEggView
@Description    : 战员蛋分解

@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module('game.bag.view.BagBreakHeroEggView', Class.impl(bag.BagBreakEquipView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bag/BagBreakHeroEggView.prefab")

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mGridScroller:SetItemRender(bag.BreakHeroEggScrollerItem)
end

-- 取类型道具列表
function getTypsList(self, cusType)
    local propsList = self:getPrpsList()
    local list = {}
    for i, vo in ipairs(propsList) do
        if bag.BagManager:getBreakBaseData(vo.tid, 2) then
            if cusType == 1 and vo.color == ColorType.GREEN then
                table.insert(list, vo.id)
            end
            if cusType == 2 and vo.color == ColorType.BLUE then
                table.insert(list, vo.id)
            end
            if cusType == 3 and vo.color == ColorType.VIOLET then
                table.insert(list, vo.id)
            end

            if cusType == 4 and vo.color == ColorType.ORANGE  then
                table.insert(list, vo.id)
            end
        end
    end
    return list
end

function showSortView(self)
    self.mSortView:addSortMenu(bag.getSortList(self.tabType), nil, true, false)
    self.mSortView:setShowTipGroup(false)
end

function active(self, args)
    super.active(self, args)

    self.mToggleG.gameObject:SetActive(false)
end

function getPrpsList(self)
    -- 普通筛选
    -- local suitFilterType = self.mSortView:getSuitFilterType()
    -- local suitId = suitFilterType ~= -1 and suitFilterType.suitId or suitFilterType
    -- local slotPos = self.mSortView:getPosFilterType() ~= -1 and self.mSortView:getPosFilterType() or nil
    -- local propsList = bag.BagManager:getBagPagePropsList(self.tabType, suitId, slotPos, self.mSortData, self:getBagType())
    -- for i = #propsList, 1, -1 do
    --     if (propsList[i].heroId > 0) then
    --         table.remove(propsList, i)
    --     end
    -- end
    -- return propsList

    -- 特殊筛选
    local colorList, suitIdList, mainAttrKeyList, attachAttrKeyList = self.mSortView:getDetailFilterData()
    local slotPosList = self.mSortView:getPosFilterType() ~= -1 and {self.mSortView:getPosFilterType()} or nil
    local equipList = bag.BagManager:getBagPagePropsList(self.tabType, suitIdList, slotPosList, colorList,
        self.mSortData, self:getBagType())
    return equipList
end

-- function showSortView(self)
--     self.mSortView:addOrderMenu({-1, PropsOrderSubType.ATTACK, PropsOrderSubType.DEFENCE, PropsOrderSubType.EFFECT},
--         nil, false)
--     self.mSortView:addSortMenu(bag.getSortList(self.tabType), nil, true, false)
-- end

function updatePropsListView(self, cusIsInit)
    local propsList = self:getPrpsList()
    local scrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]

        local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollerVo:setDataVo(propsVo)
        scrollerVo:setSelect(false)
        table.insert(scrollList, scrollerVo)

    end

    self:recoverListData(self.mGridScroller.DataProvider)
    if (cusIsInit == nil or cusIsInit == true) then
        self.mGridScroller.DataProvider = scrollList
    else
        -- 避免列表跳动
        if (self.mGridScrollerRect.anchoredPosition.y <= 5) then
            self.mGridScroller.DataProvider = scrollList
        else
            self.mGridScroller:ReplaceAllDataProvider(scrollList)
        end
    end
end

function getBagType(self)
    return bag.BagType.HeroEgg
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
