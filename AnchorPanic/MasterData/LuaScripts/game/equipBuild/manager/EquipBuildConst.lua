-- 装备培养类型
equipBuild.BuildTabType = {
    ATTRS = 1,
    STRENGTHEN = 2,
    REMAKE = 3,
    RESTRUCTURE = 4,
}

equipBuild.getBuildName = function(cusTabType)
    local name = ""
    if (cusTabType == equipBuild.BuildTabType.ATTRS) then
        name = _TT(71426)
    elseif (cusTabType == equipBuild.BuildTabType.STRENGTHEN) then
        name = _TT(71427)
    elseif (cusTabType == equipBuild.BuildTabType.REMAKE) then
        name = _TT(71428)
    elseif (cusTabType == equipBuild.BuildTabType.RESTRUCTURE) then
        name = _TT(71429)
    end
    return name
end

equipBuild.getBuildIcon = function(cusTabType)
    local icon = ""
    if (cusTabType == equipBuild.BuildTabType.ATTRS) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_38.png")
    elseif (cusTabType == equipBuild.BuildTabType.STRENGTHEN) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_39.png")
    elseif (cusTabType == equipBuild.BuildTabType.REMAKE) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_40.png")
    elseif (cusTabType == equipBuild.BuildTabType.RESTRUCTURE) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_40.png")
    end
    return icon
end

-- 装备道具的部位显示字符串
equipBuild.getEquipRemakePosStr = function(remakePos)
    local posDic = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ" }
    return posDic[remakePos]
end


----------------------- 界面排序专用-----------------------------
-- 强化排序和筛选
equipBuild.panelSortType = {  COLOR = "COLOR", LEVEL = "LEVEL",POS = "POS" }
equipBuild.panelSortTypeList = {  equipBuild.panelSortType.COLOR, equipBuild.panelSortType.LEVEL }

equipBuild.panelRemakeSortTypeList = { equipBuild.panelSortType.LEVEL ,equipBuild.panelSortType.POS }

equipBuild.filterSubTypeAll = "ALL"
equipBuild.panelFilterType = { COLOR = "COLOR", SUIT = "SUIT", POS = "POS" }
equipBuild.panelFilterTypeList = { equipBuild.panelFilterType.COLOR, equipBuild.panelFilterType.SUIT, equipBuild.panelFilterType.POS }
equipBuild.panelFilterTypeDic = {}
equipBuild.panelFilterTypeDic[equipBuild.panelFilterType.COLOR] = { equipBuild.filterSubTypeAll, ColorType.GREEN, ColorType.BLUE, ColorType.VIOLET, ColorType.ORANGE }
equipBuild.panelFilterTypeDic[equipBuild.panelFilterType.SUIT] = { equipBuild.filterSubTypeAll }
local suitConfigList = equip.EquipSuitManager:getSuitConfigList()
for i = 1, #suitConfigList do
    table.insert(equipBuild.panelFilterTypeDic[equipBuild.panelFilterType.SUIT], suitConfigList[i].suitId)
end
equipBuild.panelFilterTypeDic[equipBuild.panelFilterType.POS] = { equipBuild.filterSubTypeAll, 1, 2, 3, 4, 5, 6 }

---------------------------改造筛选--------------------------------------------
equipBuild.remakeFilterTypeList = { equipBuild.panelFilterType.SUIT }


equipBuild.getFilterTypeName = function(type)
    local name = "xx"
    if (type == equipBuild.panelFilterType.COLOR) then
        name = _TT(71430)
    elseif (type == equipBuild.panelFilterType.SUIT) then
        name = _TT(71431)
    elseif (type == equipBuild.panelFilterType.POS) then
        name = _TT(71432)
    end
    return name
end

equipBuild.getFilterSubTypeName = function(type, subType)
    local name = "xx"
    if (subType == equipBuild.filterSubTypeAll) then
        name = _TT(4011) --"全部"
    elseif (type == equipBuild.panelFilterType.COLOR) then
        name = hero.getColorName(subType)
    elseif (type == equipBuild.panelFilterType.SUIT) then
        name = equip.EquipSuitManager:getEquipSuitConfigVo(subType).name
    elseif (type == equipBuild.panelFilterType.POS) then
        name = equipBuild.getEquipRemakePosStr(subType)
    end
    return name
end

equipBuild.getSortTypeName = function(type)
    local name = "xx"
    if type == equipBuild.panelSortType.DEFAULT then
        name = _TT(71433)
    elseif (type == equipBuild.panelSortType.LEVEL) then
        name = _TT(1003) --"等级"
    elseif (type == equipBuild.panelSortType.COLOR) then
        name = _TT(1004) --"品质"
    elseif (type == equipBuild.panelSortType.POS) then
        name = _TT(71432) --"品质"
    end
    return name
end

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71433):	"默认"
	语言包: _TT(71432):	"部位"
	语言包: _TT(71431):	"套装"
	语言包: _TT(71430):	"稀有度"
	语言包: _TT(71429):	"重构"
	语言包: _TT(71428):	"改造"
	语言包: _TT(71427):	"强化"
	语言包: _TT(71426):	"属性"
]]