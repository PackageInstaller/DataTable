-- 背包类型
bag.BagType = {
    -- 背包
    Bag = 1,
    -- 家具
    Furniture = 2,
    -- 战员碎片
    HeroFragment = 3,
    -- 原料
    Rawmat = 4,
    -- 芯片
    Equip = 5,
    -- 手环
    Bracelets = 6,

    --开心农场
    HappyFarm = 7,

    --战员蛋
    HeroEgg = 8,
}

-- 背包页签类型
bag.BagTabType = {
    NORMAL = 1,
    EQUIP = 2,
    BRACELETS = 3,
    CONSUME = 4,

    NUCLEAR = 5,
    ORDER = 6,
    HERO_FRAGMENT = 7,
    RAWMAT = 8,
    HEROEGG = 9 ,
}

bag.getPageName = function(cusPageType)
    local name = ""
    if (cusPageType == bag.BagTabType.EQUIP) then
        name = _TT(4004)--"武装模组"
    elseif (cusPageType == bag.BagTabType.BRACELETS) then
        name = _TT(4067)--"手环"
    elseif (cusPageType == bag.BagTabType.NUCLEAR) then
        name = _TT(4005)--"核心"
    elseif (cusPageType == bag.BagTabType.NORMAL) then
        name = _TT(4006)--"基础物资"
    elseif (cusPageType == bag.BagTabType.CONSUME) then
        name = _TT(4007)--"消耗物资"
    elseif (cusPageType == bag.BagTabType.ORDER) then
        name = _TT(4048)--"装置"
    elseif (cusPageType == bag.BagTabType.HERO_FRAGMENT) then
        name = _TT(4054)--"战员情报"
    elseif (cusPageType == bag.BagTabType.RAWMAT) then
        name = _TT(4055)--"原料"
    elseif (cusPageType == bag.BagTabType.HEROEGG) then
        name = _TT(149903)
    end
    return name
end

bag.getIconURL = function(cusPageType)
    local url = "bag/bag_icon_3.png"
    if (cusPageType == bag.BagTabType.EQUIP) then
        url = "bag/bag_icon_5.png"--"芯片"
    elseif (cusPageType == bag.BagTabType.BRACELETS) then
        url = "bag/bag_icon_1.png"  --"手环"
        -- elseif (cusPageType == bag.BagTabType.NUCLEAR) then
        --     url = _TT(4005)--"核心"
    elseif (cusPageType == bag.BagTabType.NORMAL) then
        url = "bag/bag_icon_2.png"--"材料"
    elseif (cusPageType == bag.BagTabType.CONSUME) then
        url = "bag/bag_icon_3.png"--"用品"
    elseif (cusPageType == bag.BagTabType.ORDER) then
        url = "bag/bag_icon_4.png"--"序列物"
    elseif (cusPageType == bag.BagTabType.HERO_FRAGMENT) then
        url = "bag/bag_icon_6.png"--"战员碎片"
        -- elseif (cusPageType == bag.BagTabType.RAWMAT) then
        --     url = _TT(4055)--"原料"
    elseif (cusPageType == bag.BagTabType.HEROEGG) then
        url = "bag/bag_icon_6.png"--"战员碎片"
    end
    return UrlManager:getPackPath(url)
end

bag.getPageIcon = function(cusPageType)
    local icon
    if (cusPageType == bag.BagTabType.EQUIP) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_14.png")--"武装模组"
    elseif (cusPageType == bag.BagTabType.BRACELETS) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_53.png")--"手环"
    elseif (cusPageType == bag.BagTabType.NORMAL) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_11.png")--"基础物资"
    elseif (cusPageType == bag.BagTabType.CONSUME) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_12.png")--"消耗物资"
    elseif (cusPageType == bag.BagTabType.ORDER) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_14.png")--"序列物"
    elseif (cusPageType == bag.BagTabType.HERO_FRAGMENT) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_13.png")--"战员情报"
    elseif (cusPageType == bag.BagTabType.HEROEGG) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_13.png")--"战员情报"
    end
    return icon
end

bag.getPageNameEn = function(cusPageType)
    local name = ""
    if (cusPageType == bag.BagTabType.EQUIP) then
        name = "Chip"
    elseif (cusPageType == bag.BagTabType.BRACELETS) then
        name = "Bracelets"
    elseif (cusPageType == bag.BagTabType.NUCLEAR) then
        name = "Nucleus"
    elseif (cusPageType == bag.BagTabType.NORMAL) then
        name = "Supplies"
    elseif (cusPageType == bag.BagTabType.CONSUME) then
        name = "Consume"
    elseif (cusPageType == bag.BagTabType.ORDER) then
        name = "Order"
    elseif (cusPageType == bag.BagTabType.HERO_FRAGMENT) then
        name = "Fragment"
    elseif (cusPageType == bag.BagTabType.RAWMAT) then
        name = "RawMaterials"
    elseif (cusPageType == bag.BagTabType.HEROEGG) then
        name = "RawMaterials"
    end
    return name
end

bag.getOrderSubTypeName = function(cusSubType)
    local name = ""
    if (cusSubType == PropsOrderSubType.ATTACK) then
        name = _TT(34)
    elseif (cusSubType == PropsOrderSubType.DEFENCE) then
        name = _TT(35)
    elseif (cusSubType == PropsOrderSubType.EFFECT) then
        name = _TT(36)
    end
    return name
end

bag.getOrderSubTypeIcon = function(cusSubType)
    local list = { 12, 13, 14 }
    return UrlManager:getPackPath(string.format("bag/bag_new_%s.png", list[cusSubType - 1]))
end


bag.BagSortType = {
    -- 等级
    LVL = 1,
    -- 品质
    COLOR = 2,
    -- 改造
    REMAKE = 3,
    -- 数量
    COUNT = 4,
    -- id
    ID = 5,
    -- 精炼
    REFINE = 6
}

bag.getSortName = function(cusSortType)
    local name = ""
    if (cusSortType == bag.BagSortType.LVL) then
        name = _TT(1003)--"等级"
    elseif (cusSortType == bag.BagSortType.COLOR) then
        name = _TT(1004)--"品质"
    elseif (cusSortType == bag.BagSortType.REMAKE) then
        name = _TT(4008)--"改造"
    elseif (cusSortType == bag.BagSortType.COUNT) then
        name = _TT(4009)--"数量"
    elseif (cusSortType == bag.BagSortType.REFINE) then
        name = _TT(4330)--"精炼"
    end
    return name
end

bag.getSortList = function(cusSortType)
    local sortList = {}
    if (cusSortType == bag.BagTabType.EQUIP) then
        table.insert(sortList, bag.BagSortType.LVL)
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.REMAKE)
        table.insert(sortList, bag.BagSortType.ID)
    elseif (cusSortType == bag.BagTabType.BRACELETS) then
        table.insert(sortList, bag.BagSortType.LVL)
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.REFINE)
        table.insert(sortList, bag.BagSortType.ID)
    elseif (cusSortType == bag.BagTabType.NUCLEAR) then
        table.insert(sortList, bag.BagSortType.LVL)
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.REMAKE)
        table.insert(sortList, bag.BagSortType.ID)
    elseif (cusSortType == bag.BagTabType.NORMAL or cusSortType == bag.BagTabType.CONSUME or cusSortType == bag.BagTabType.BRACELETS or cusSortType == bag.BagTabType.HERO_FRAGMENT or cusSortType == bag.BagTabType.RAWMAT) then
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.COUNT)
        table.insert(sortList, bag.BagSortType.ID)
    elseif cusSortType == bag.BagTabType.ORDER then
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.ID)
    elseif cusSortType == bag.BagTabType.HEROEGG then
        table.insert(sortList, bag.BagSortType.COLOR)
        table.insert(sortList, bag.BagSortType.ID)
    end
    return sortList
end

bag.getSortFun = function(isDescending, sortType)
    if (sortType == bag.BagSortType.LVL) then
        return isDescending and bag._descendingLvlFun or bag._ascendingLvlFun
    elseif (sortType == bag.BagSortType.COLOR) then
        return isDescending and bag._descendingColorFun or bag._ascendingColorFun
    elseif (sortType == bag.BagSortType.REMAKE) then
        return isDescending and bag._descendingRemakeFun or bag._ascendingRemakeFun
    elseif (sortType == bag.BagSortType.COUNT) then
        return isDescending and bag._descendingCountFun or bag._ascendingCountFun
    elseif (sortType == bag.BagSortType.ID) then
        return isDescending and bag._descendingIDFun or bag._ascendingIDFun
    elseif (sortType == bag.BagSortType.REFINE) then
        return isDescending and bag._descendingRefineFun or bag._ascendingRefineFun
    end
end

-- 强化等级从大到小
bag._descendingLvlFun = function(propsVo1, propsVo2)
    if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
        if propsVo1.color == propsVo2.color then
                return propsVo1.tid > propsVo2.tid
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return propsVo1.strengthenLvl > propsVo2.strengthenLvl
    end
    return nil
end

-- 品质从大到小
bag._descendingColorFun = function(propsVo1, propsVo2)
    if (propsVo1.color == propsVo2.color) then
        if propsVo1.strengthenLvl and propsVo2.strengthenLvl then
            if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
                if propsVo1.refineLvl and propsVo2.refineLvl then
                    if propsVo1.refineLvl == propsVo2.refineLvl then
                        return propsVo1.tid > propsVo2.tid
                    else
                        return propsVo1.refineLvl > propsVo2.refineLvl
                    end
                else
                    return propsVo1.tid > propsVo2.tid
                end
            else
                return propsVo1.strengthenLvl > propsVo2.strengthenLvl
            end
        else
            return propsVo1.tid > propsVo2.tid
            -- if propsVo1.count == propsVo2.count then
            --     return propsVo1.tid > propsVo2.tid
            -- else
            --     if propsVo1.count == propsVo2.count then
            --         return propsVo1.tid > propsVo2.tid
            --     else
            --         return propsVo1.count > propsVo2.count
            --     end
            -- end
        end
    else
        return propsVo1.color > propsVo2.color
    end
    return nil
end

-- 改造数从大到小
bag._descendingRemakeFun = function(propsVo1, propsVo2)
    local remake1, remake2 = propsVo1:getRemakeCount(), propsVo2:getRemakeCount()
    if remake1 == remake2 then
        if propsVo1.color == propsVo2.color then
            if propsVo1.tid == propsVo2.tid then
                return propsVo1.strengthenLvl > propsVo2.strengthenLvl
            else
                return propsVo1.tid > propsVo2.tid
            end
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return remake1 > remake2
    end
    return nil
end

-- 数量从大到小
bag._descendingCountFun = function(propsVo1, propsVo2)
    if propsVo1.count == propsVo2.count then
        if propsVo1.color == propsVo2.color then
            return propsVo1.tid > propsVo2.tid
        else
            return propsVo1.color > propsVo2.color
        end
    else
        return propsVo1.count > propsVo2.count
    end
end

-- id从大到小
bag._descendingIDFun = function(propsVo1, propsVo2)

    if (propsVo1.createdTime < propsVo2.createdTime) then return true end
    if (propsVo1.createdTime > propsVo2.createdTime) then return false end

    if (propsVo1.id > propsVo2.id) then
        return true
    end
    if (propsVo1.id < propsVo2.id) then
        return false
    end
    return nil
end

-- 精炼从小到大
bag._ascendingRefineFun = function(propsVo1, propsVo2)
    if (propsVo1.refineLvl == propsVo2.refineLvl) then
        if (propsVo1.strengthenLvl == propsVo2.strengthenLvl) then
            if (propsVo1.color and propsVo2.color) then
                if propsVo1.color == propsVo2.color then
                    if propsVo1.tid and propsVo1.tid then
                        return propsVo1.tid < propsVo1.tid
                    end
                else
                    return propsVo1.color < propsVo2.color
                end
            end
        else
            if propsVo1.strengthenLvl and propsVo2.strengthenLvl then
                return propsVo1.strengthenLvl < propsVo2.strengthenLvl
            end
        end
    else
        return propsVo1.refineLvl < propsVo2.refineLvl
    end
    return nil
end

--------------------------------------------------------------
-- 强化等级从小到大
bag._ascendingLvlFun = function(propsVo1, propsVo2)
    if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
        if propsVo1.color == propsVo2.color then
            if propsVo1.tid and propsVo2.tid then
                return propsVo1.tid < propsVo2.tid
            end
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return propsVo1.strengthenLvl < propsVo2.strengthenLvl
    end
    return nil
end

-- 品质从小到大
bag._ascendingColorFun = function(propsVo1, propsVo2)
    if (propsVo1.color == propsVo2.color) then
        if propsVo1.strengthenLvl and propsVo2.strengthenLvl then
            if propsVo1.strengthenLvl == propsVo2.strengthenLvl then
                if propsVo1.refineLvl and propsVo2.refineLvl then
                    if propsVo1.refineLvl == propsVo2.refineLvl then
                        return propsVo1.tid < propsVo2.tid
                    else
                        return propsVo1.refineLvl < propsVo2.refineLvl
                    end
                else
                    return propsVo1.tid < propsVo2.tid
                end
            else
                return propsVo1.strengthenLvl < propsVo2.strengthenLvl
            end
        else
            return propsVo1.tid < propsVo2.tid
            -- if propsVo1.count == propsVo2.count then
            --     return propsVo1.tid < propsVo2.tid
            -- else
            --     if propsVo1.count == propsVo2.count then
            --         return propsVo1.tid < propsVo2.tid
            --     else
            --         return propsVo1.count < propsVo2.count
            --     end
            -- end
        end
    else
        return propsVo1.color < propsVo2.color
    end
    return nil
end

-- 改造数从小到大
bag._ascendingRemakeFun = function(propsVo1, propsVo2)
    local remake1, remake2 = propsVo1:getRemakeCount(), propsVo2:getRemakeCount()
    if remake1 == remake2 then
        if propsVo1.color == propsVo2.color then
            if propsVo1.tid == propsVo2.tid then
                return propsVo1.strengthenLvl < propsVo2.strengthenLvl
            else
                return propsVo1.tid < propsVo2.tid
            end
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return remake1 < remake2
    end
    return nil
end

-- 数量从小到大
bag._ascendingCountFun = function(propsVo1, propsVo2)
    if propsVo1.count == propsVo2.count then
        if propsVo1.color == propsVo2.color then
            return propsVo1.tid < propsVo2.tid
        else
            return propsVo1.color < propsVo2.color
        end
    else
        return propsVo1.count < propsVo2.count
    end
end

-- id从小到大
bag._ascendingIDFun = function(propsVo1, propsVo2)
    if (propsVo1.id < propsVo2.id) then
        return true
    end
    if (propsVo1.id > propsVo2.id) then
        return false
    end
    return nil
end

-- 精炼从大到小
bag._descendingRefineFun = function(propsVo1, propsVo2)

    if (propsVo1.refineLvl == propsVo2.refineLvl) then
        if (propsVo1.strengthenLvl == propsVo2.strengthenLvl) then
            if propsVo1.color == propsVo2.color then
                return propsVo1.tid > propsVo2.tid
            else
                return propsVo1.color > propsVo2.color
            end
        else
            if propsVo1.strengthenLvl and propsVo2.strengthenLvl then
                return propsVo1.strengthenLvl > propsVo2.strengthenLvl
            end
        end
    else
        return propsVo1.refineLvl > propsVo2.refineLvl
    end
    return nil
end

-- 装备道具的部位显示字符串
bag.getEquipPosStr = function(equipSubType)
    local posDic = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ" }
    return posDic[equipSubType]
end

-- 页签类型：1 物品 2 装备
bag.getTabOpType = function(cusType)
    if cusType == bag.BagTabType.NORMAL or cusType == bag.BagTabType.CONSUME or cusType == bag.BagTabType.RAWMAT then
        return 1
    elseif cusType == bag.BagTabType.EQUIP or cusType == bag.BagTabType.BRACELETS or cusType == bag.BagTabType.NUCLEAR or cusType == bag.BagTabType.ORDER or cusType == bag.BagTabType.HEROEGG then
        return 2
    end
end

bag.getNameByColor = function(color)
    if(color == ColorType.GREEN)then
        return _TT(15)
    elseif(color == ColorType.BLUE)then
        return _TT(16)
    elseif(color == ColorType.VIOLET)then
        return _TT(17)
    elseif(color == ColorType.ORANGE)then
        return _TT(18)
    elseif(color == ColorType.RED)then
        return _TT(19)
    end
    return ""
end

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(36):	"效果"
	语言包: _TT(35):	"防御"
	语言包: _TT(34):	"攻击"
]]