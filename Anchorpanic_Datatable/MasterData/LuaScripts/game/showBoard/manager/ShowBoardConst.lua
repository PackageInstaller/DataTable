-- 展示板模型界面排序专用
showBoard.panelSortType = { LEVEL = "LEVEL", COLOR = "COLOR", STAR_LVL = "STAR_LVL", ELEMENT = "ELEMENT", SETTLEIN = "SETTLEIN", STAMINA = "STAMINA", BUILDSKILL = "BUILDSKILL" }
showBoard.panelSortTypeList = { showBoard.panelSortType.LEVEL, showBoard.panelSortType.COLOR, showBoard.panelSortType.STAR_LVL }

showBoard.getSortTypeName = function(type)
    local name = ""
    if (type == showBoard.panelSortType.LEVEL) then
        name = _TT(1181) --"按等级"
    elseif (type == showBoard.panelSortType.COLOR) then
        name = _TT(1182) --"按品质"
    elseif (type == showBoard.panelSortType.STAR_LVL) then
        name = _TT(1183) --"按星级"
    elseif (type == showBoard.panelSortType.ELEMENT) then
        name = _TT(1382)   -- "按属性"  
    elseif (type == showBoard.panelSortType.NAME) then
        name = _TT(1184) --"按名称"
        -- elseif (type == showBoard.panelSortType.POWER) then
        --     name = _TT(1184) --"按战力"
    elseif (type == showBoard.panelSortType.STAMINA) then
        name = _TT(1377) --"按名称"  
    elseif (type == showBoard.panelSortType.BUILDSKILL) then
        name = _TT(1376) --"按技能"  
    end
    return name
end

showBoard.filterSubTypeAll = "ALL"
-- 屏蔽阵营
showBoard.panelFilterType = { ELEMENT = "ELEMENT", PROFESSION = "PROFESSION", DEFINE_TYPE = "DEFINE_TYPE" }
-- 屏蔽阵营
showBoard.panelFilterTypeList = { showBoard.panelFilterType.ELEMENT, showBoard.panelFilterType.PROFESSION, showBoard.panelFilterType.DEFINE_TYPE }
showBoard.panelFilterTypeDic = {}

showBoard.panelFilterTypeDic[showBoard.panelSortType.ELEMENT] = { showBoard.filterSubTypeAll, hero.ELEMENTTYPE.ATTACK, hero.ELEMENTTYPE.ELECTRICITY, hero.ELEMENTTYPE.FIRE, hero.ELEMENTTYPE.ICE, hero.ELEMENTTYPE.NATURE, hero.ELEMENTTYPE.LIGHT }
-- 屏蔽战士
showBoard.panelFilterTypeDic[showBoard.panelFilterType.PROFESSION] = { showBoard.filterSubTypeAll, hero.ProfessionType.TANK, hero.ProfessionType.WARRIOR, hero.ProfessionType.OUTPUT, hero.ProfessionType.ASSISTER, hero.ProfessionType.CONTROL, hero.ProfessionType.NUCLEUS }
showBoard.panelFilterTypeDic[showBoard.panelFilterType.DEFINE_TYPE] = { showBoard.filterSubTypeAll, hero.DefineType.FRONT, hero.DefineType.BACK, hero.DefineType.PARA,hero.DefineType.PARAFRONT }

showBoard.getFilterTypeName = function(type)
    local name = "xx"
    if (type == showBoard.panelFilterType.CAMP) then
        name = _TT(1006) --"阵营"
    elseif (type == showBoard.panelFilterType.COLOR) then
        name = _TT(1004) --"品质"
    elseif (type == showBoard.panelFilterType.PROFESSION) then
        name = _TT(1007) --"职业"
    elseif (type == showBoard.panelFilterType.DEFINE_TYPE) then
        name = _TT(1008) --"定位"
    elseif (type == showBoard.panelFilterType.STAR_LVL) then
        name = _TT(1005) --"星级"

    elseif (type == showBoard.panelFilterType.ELEMENT) then
        name = "属性" --"星级"
    end
    return name
end

showBoard.getFilterSubTypeName = function(type, subType)
    local name = "xx"
    if (subType == showBoard.filterSubTypeAll) then
        name = _TT(4011) --"全部"
    elseif (type == showBoard.panelFilterType.CAMP) then
        name = hero.getBriefCountryName(subType)
    elseif (type == showBoard.panelFilterType.COLOR) then
        name = HtmlUtil:color(hero.getColorName(subType), ColorUtil:getPropColor(subType))
    elseif (type == showBoard.panelFilterType.ELEMENT) then
        local _, mName = hero.getHeroTypeName(subType)
        name = mName
        --name = HtmlUtil:color(hero.getColorName(subType), ColorUtil:getPropColor(subType))
    elseif (type == showBoard.panelFilterType.PROFESSION) then
        name = hero.getProfessionName(subType)
    elseif (type == showBoard.panelFilterType.DEFINE_TYPE) then
        name = hero.getDefineName(subType)
    end
    return name
end

showBoard.getFilterSubTypeName = function(type, subType)
    local name = "xx"
    if (subType == showBoard.filterSubTypeAll) then
        name = _TT(4011) --"全部"
    elseif (type == showBoard.panelFilterType.CAMP) then
        name = hero.getBriefCountryName(subType)
    elseif (type == showBoard.panelFilterType.COLOR) then
        name = HtmlUtil:color(hero.getColorName(subType), ColorUtil:getPropColor(subType))
    elseif (type == showBoard.panelFilterType.ELEMENT) then
        local _, mName = hero.getHeroTypeName(subType)
        name = mName
        --name = HtmlUtil:color(hero.getColorName(subType), ColorUtil:getPropColor(subType))
    elseif (type == showBoard.panelFilterType.PROFESSION) then
        name = hero.getProfessionName(subType)
    elseif (type == showBoard.panelFilterType.DEFINE_TYPE) then
        name = hero.getDefineName(subType)
    end
    return name
end

--图标
showBoard.getFilterSubTypeIcon = function(type, subType)
    local url
    if (subType == showBoard.filterSubTypeAll) then

    elseif (type == showBoard.panelFilterType.CAMP) then

    elseif (type == showBoard.panelFilterType.COLOR) then

    elseif (type == showBoard.panelFilterType.ELEMENT) then
        url = UrlManager:getHeroEleTypeIconUrl(subType)
    elseif (type == showBoard.panelFilterType.PROFESSION) then
        url = UrlManager:getHeroJobIconUrl(subType)
    elseif (type == showBoard.panelFilterType.DEFINE_TYPE) then

    end
    return url
end



--[[ 替换语言包自动生成，请勿修改！
]]