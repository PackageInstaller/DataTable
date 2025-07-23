-- 英雄角色的字段信息 key-value，和后端对应
hero.DataFieldKey = { -- 等级
    HERO_LEVEL = 101, -- 经验
    HERO_EXP = 102, -- 经验上限
    HERO_MAX_EXP = 103, -- 进化等级
    HERO_EVOLUTION_LVL = 104, -- 军阶
    HERO_MILITARY_RANK = 105, -- 战力
    HERO_POWER = 106, -- 亲密度
    HERO_INTIMACY = 107, -- 是否上锁
    HERO_IS_LOCK = 108, -- 是否喜欢
    HERO_IS_LIKE = 109, -- 品质
    HERO_COLOR = 110, -- 关联的助手
    COVENANT_HELPER = 111, -- 亲密度等级
    HERO_RELATION_LEVEL = 112, -- 亲密度经验
    HERO_RELATION_EXP = 113, -- 增幅等级
    HERO_GROW_LV = 114
}

-- 请求后端的英雄下一预览类型（和后端一致）
hero.PreviewAttrType = { -- 战员军阶
    MILITARY_RANK = 1, -- 战员进化
    STAR_UP = 2
}

-- 请求后端指定模块类型的全部预览类型（和后端一致）
hero.AllPreviewAttrType = { -- 装备强化
    EQUIP_STRENGTHEN = 1, -- 好感度属性
    BRACELET_TUPO = 2, --手环突破属性
    FAVORABLE = 3
}
--战员品质
hero.HeroColorType = {
    D_CARD = 0, --D卡
    N_CARD = 1, --N卡
    R_CARD = 2, --R卡
    SR_CARD = 3, --SR卡
    SSR_CARD = 4, --SSR卡
}

hero.getColorName = function(color)
    local name = ""
    if (color == 1) then
        name = "N"
    elseif (color == 2) then
        name = "R"
    elseif (color == 3) then
        name = "SR"
    elseif (color == 4) then
        name = "SSR"
    end
    return name
end

hero.getStarName = function(star)
    local name = ""
    if (star == 1) then
        name = "1星"
    elseif (star == 2) then
        name = "2星"
    elseif (star == 3) then
        name = "3星"
    elseif (star == 4) then
        name = "4星"
    elseif (star == 5) then
        name = "5星"
    elseif (star == 6) then
        name = "6星"
    end
    return name
end

-- 定位类型
hero.DefineType = { -- 前排
    FRONT = 1, -- 后排
    BACK = 2, -- 对位
    PARA = 3, -- 低血
    PARAFRONT = 4
}

hero.ProfessionType = { -- 坦克
    TANK = 1, -- "强袭"
    WARRIOR = 2, -- "协同"
    OUTPUT = 3, -- "特勤"
    ASSISTER = 4, -- 医疗
    CONTROL = 5, -- "控场"
    NUCLEUS = 6 -- "中坚"
}

hero.getProfessionName = function(professionType)
    local name = ""
    if (professionType == hero.ProfessionType.TANK) then
        name = _TT(81057) -- "强袭"
    elseif (professionType == hero.ProfessionType.WARRIOR) then
        name = _TT(81058) -- "协同"
    elseif (professionType == hero.ProfessionType.OUTPUT) then
        name = _TT(81059) -- "特勤"
    elseif (professionType == hero.ProfessionType.ASSISTER) then
        name = _TT(81060) -- "医疗"
    elseif (professionType == hero.ProfessionType.CONTROL) then
        name = _TT(81061)-- "控场"
    elseif (professionType == hero.ProfessionType.NUCLEUS) then
        name = _TT(81062)-- "中坚"
    end
    return name
end

hero.getPorfessionDes = function(professionType)
    local des = ""
    if (professionType == hero.ProfessionType.TANK) then
        des = _TT(1157) -- "坦克"
    elseif (professionType == hero.ProfessionType.WARRIOR) then
        des = "" -- "战士"
    elseif (professionType == hero.ProfessionType.OUTPUT) then
        des = _TT(1156) -- "输出"
    elseif (professionType == hero.ProfessionType.ASSISTER) then
        des = _TT(1158) -- "辅助"
    end
    return des
end

hero.CountryType = { -- 北境共同体
    BJGYY = 1, -- 西部联邦
    XBLB = 2, -- 东部共和国
    DBGHG = 3, -- 南部岛链联合王国
    NBDLLHWG = 4, -- 瓦坦斯
    WTS = 5
}

hero.getCountryName = function(countryType)
    local name = ""
    if (countryType == hero.CountryType.BJGYY) then
        name = "北境共同体"
    elseif (countryType == hero.CountryType.XBLB) then
        name = "西部联邦"
    elseif (countryType == hero.CountryType.DBGHG) then
        name = "东部共和国"
    elseif (countryType == hero.CountryType.NBDLLHWG) then
        name = "南部岛链联合王国"
    elseif (countryType == hero.CountryType.WTS) then
        name = _TT(1049)
    end
    return name
end

hero.getBriefCountryName = function(countryType)
    local name = ""
    if (countryType == hero.CountryType.BJGYY) then
        name = _TT(1045) -- "北境国"
    elseif (countryType == hero.CountryType.XBLB) then
        name = _TT(1046) -- "西部国"
    elseif (countryType == hero.CountryType.DBGHG) then
        name = _TT(1047) -- "东部国"
    elseif (countryType == hero.CountryType.NBDLLHWG) then
        name = _TT(1048) -- "南部岛"
    elseif (countryType == hero.CountryType.WTS) then
        name = _TT(1049) -- "瓦坦斯"
    end
    return name
end

hero.getDefineName = function(defineType)
    local name = ""
    if (defineType == 1) then
        name = _TT(1034) -- "前排优先"
    elseif (defineType == 2) then
        name = _TT(1035) -- "后排优先"
    elseif (defineType == 3) then
        name = _TT(1036) -- "对位优先"
    elseif (defineType == 4) then
        name = _TT(1424) -- "血量最低"
    -- elseif (defineType == 5) then
    --     name = _TT(1424) -- "血量最低"
    end
    return name
end

hero.getSkillDefineName = function(defineType)
    local name = ""
    if (defineType == 0) then
        name = _TT(1385) -- "普通攻击"
    elseif (defineType == 1) then
        name = _TT(1386) -- "主动技能"
    elseif (defineType == 3) then
        name = _TT(1387) -- "奥义"
    elseif (defineType == 4) then
        name = _TT(1388) -- "天赋"
    elseif (defineType == 5) then
        name = _TT(1389) -- "特殊强化"

    end
    return name
end

-- 英雄培养页签类型
hero.DevelopTabType = {
    LVL_UP = 1,
    COLOR_UP = 2,
    SKILL = 3,
    STAR_UP = 4,
    GROW = 5,
    -- EQUIP = 6,
    -- BRACELETS = 7,
    ASSIST = 8,
    RESONANCE = 9,
    MILITARY_RANK_UP = 100,
    ATTR = 101,
    REPLACE = 102
}

-- hero.EquipTabType = {ATTR = 1,REPLACE = 2}

hero.getDevelopName = function(cusTabType)
    local name = ""
    if (cusTabType == hero.DevelopTabType.LVL_UP) then
        name = _TT(1040) -- "升级"
    elseif (cusTabType == hero.DevelopTabType.COLOR_UP) then
        name = _TT(1109) -- "升格"
    elseif (cusTabType == hero.DevelopTabType.SKILL) then
        name = _TT(1041) -- "技能"
    elseif (cusTabType == hero.DevelopTabType.STAR_UP) then
        name = _TT(1042) -- "进化"
    elseif (cusTabType == hero.DevelopTabType.MILITARY_RANK_UP) then
        name = _TT(1043) -- "军阶"
    elseif (cusTabType == hero.DevelopTabType.EQUIP) then
        name = _TT(1044) -- "芯片"
    elseif (cusTabType == hero.DevelopTabType.BRACELETS) then
        name = _TT(4318) -- "手环"
    elseif (cusTabType == hero.DevelopTabType.ASSIST) then
        name = _TT(71005) -- "助战"
    elseif (cusTabType == hero.DevelopTabType.GROW) then
        name = _TT(1167) -- 源质
    elseif (cusTabType == hero.DevelopTabType.ATTR) then
        name = _TT(1030) -- 属性
    elseif (cusTabType == hero.DevelopTabType.REPLACE) then
        name = _TT(71006) -- 配置
     elseif (cusTabType == hero.DevelopTabType.RESONANCE) then
        name = _TT(110001) -- 共鸣
    end
    return name
end

hero.getDevelopNameEn = function(cusTabType)
    local name = ""
    return name
end
-- 培养Icon
hero.getDevelopIcon = function(cusTabType)
    local icon = ""
    if (cusTabType == hero.DevelopTabType.LVL_UP) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_25.png") -- "详情"
    elseif (cusTabType == hero.DevelopTabType.COLOR_UP) then
        icon = "" -- UrlManager:getIconPath("") -- "升格"
    elseif (cusTabType == hero.DevelopTabType.SKILL) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_35.png") -- "技能"
    elseif (cusTabType == hero.DevelopTabType.STAR_UP) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_36.png") -- "进化"
    elseif (cusTabType == hero.DevelopTabType.MILITARY_RANK_UP) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_34.png") -- "突破"
    elseif (cusTabType == hero.DevelopTabType.EQUIP) then
        icon = "" -- UrlManager:getIconPath("") -- "芯片"
    elseif (cusTabType == hero.DevelopTabType.BRACELETS) then
        icon = "" -- UrlManager:getIconPath("") -- "手环"
    elseif (cusTabType == hero.DevelopTabType.ASSIST) then
        icon = "" -- UrlManager:getIconPath("") -- "助战"
    elseif (cusTabType == hero.DevelopTabType.GROW) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_37.png") -- 源质
    elseif (cusTabType == hero.DevelopTabType.ATTR) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_20.png") -- 属性
    elseif (cusTabType == hero.DevelopTabType.REPLACE) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_19.png") -- 配置
        elseif (cusTabType == hero.DevelopTabType.RESONANCE) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_78.png") -- 共鸣
    end
    return icon
end

-- 0-物理/无属性
-- 1-电属性
-- 2-火属性
-- 3-冰属性
hero.getEleTypeColor = function(eleType)
    local color = "8e8e8eFF"
    local name = "无属性"
    if (eleType == 1) then
        name = "电" -- "电属性"
        color = "f3c434ff"
    elseif (eleType == 2) then
        name = "火" -- "火属性"
        color = "d16466ff"
    elseif (eleType == 3) then
        name = "冰" -- "冰属性"
        color = "4e82f8ff"
    elseif (eleType == 4) then
        name = "物理" -- "冰属性"
        color = "4e82f8ff"
    elseif (eleType == 5) then
        name = "光" -- "冰属性"
        color = "4e82f8ff"
    elseif (eleType == 6) then
        name = "暗" -- "冰属性"
        color = "4e82f8ff"
    end
    return color, name
end

-- 0-物理/ 直击
-- 1-电属性 骋电
-- 2-火属性 轰炎
-- 3-冰属性 寒霜
-- 4-自然 生蕴
-- 5-光属性 量蚀
hero.getHeroTypeName = function(eleType)
    local color = "8e8e8eFF"
    local name = "直击"
    if (eleType == 0) then
        name = _TT(81056) -- 直击"无属性"
        color = "ffb136ff"
    elseif (eleType == 1) then
        name = _TT(81052) --骋电 "电属性"
        color = "c7a5ffff"
    elseif (eleType == 2) then
        name = _TT(81051)  --轰炎 "火属性"
        color = "f8566aff"
    elseif (eleType == 3) then
        name = _TT(81053)-- 寒霜 "冰属性"
        color = "78e4ffff"
    elseif (eleType == 4) then
        name = _TT(81054) -- 生蕴 "自然属性"
        color = "45c996ff"
    elseif (eleType == 5) then
        name = _TT(81055) --量蚀"光属性"
        color = "fff660ff"
    end
    return color, name
end

-- 1-普攻
-- 2-技能一
-- 3-技能二
-- 4-源能爆发
hero.getHeroSkillTypeName = function(eleType)
    local name = 41618--普攻
    if (eleType == 2) then
        name = 41603 --技能一
    elseif (eleType == 3) then
        name = 41604  --技能二
    elseif (eleType == 4) then
        name = 41605-- 源能爆发
    end
    return name
end

-- 0-物理/ 直击
-- 1-电属性 骋电
-- 2-火属性 轰炎
-- 3-冰属性 寒霜
-- 4-自然 生蕴
-- 5-光属性 量蚀
hero.ELEMENTTYPE = {
    ATTACK = 0, -- 物理
    ELECTRICITY = 1, -- 电
    FIRE = 2, -- 火
    ICE = 3, --  冰
    NATURE = 4, -- 自然
    LIGHT = 5 -- 光
}


-- 英雄界面排序专用
hero.panelSortType = {
    ALL = "ALL",
    COLOR = "COLOR",
    PROFESSION = "PROFESSION"
}
hero.panelSortTypeDic = {}
hero.panelSortTypeDic[hero.panelSortType.COLOR] = { ColorType.GREEN, ColorType.BLUE, ColorType.VIOLET, ColorType.ORANGE }
hero.panelSortTypeDic[hero.panelSortType.PROFESSION] = { hero.ProfessionType.TANK, hero.ProfessionType.WARRIOR,
hero.ProfessionType.OUTPUT, hero.ProfessionType.ASSISTER }
hero.panelSortTypeList = { hero.panelSortType.COLOR, hero.panelSortType.PROFESSION }

hero.getHeroInUse = function(heroId, dic)
    for k, v in pairs(dic) do
        if v.heroId == heroId then
            return true
        end
    end
    return false
end
--模组品质色号
hero.getEquipColor = function(cusColor)
    local color = "7d848fff"
    if cusColor == 1 then
        color = "29acffff"
    elseif cusColor == 2 then
        color = "45cea2ff"
    elseif cusColor == 3 then
        color = "ff72f1ff"
    elseif cusColor == 4 then
        color = "ff9e35ff"
    end
    return color
end

--烙痕品质色号
hero.getBraceletsColor = function(cusColor)
    local color = "7d848fff"
    if cusColor == 1 then
        color = "0ac3d0ff"
    elseif cusColor == 2 then
        color = "ff72f1ff"
    elseif cusColor == 3 then
        color = "ff9e35f"
    end
    return color
end

-- 等级从大到小
hero.descendingLvlFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.lvl == heroVo2.lvl) then
            if heroVo1.color == heroVo2.color then
                if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.evolutionLvl > heroVo2.evolutionLvl
                end
            else
                return heroVo1.color > heroVo2.color
            end
        else
            return heroVo1.lvl > heroVo2.lvl
        end
    end
    return nil
end
-- 等级从小到大
hero.ascendingLvlFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.lvl == heroVo2.lvl) then
            if heroVo1.color == heroVo2.color then
                if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.evolutionLvl > heroVo2.evolutionLvl
                end
            else
                return heroVo1.color > heroVo2.color
            end
        else
            return heroVo1.lvl < heroVo2.lvl
        end
    end
    return nil
end

-- 品质从大到小
hero.descendingColorFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.color == heroVo2.color) then
            if heroVo1.lvl == heroVo2.lvl then
                if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.evolutionLvl > heroVo2.evolutionLvl
                end
            else
                return heroVo1.lvl > heroVo2.lvl
            end
        else
            return heroVo1.color > heroVo2.color
        end
    end
    return nil
end
-- 品质从小到大
hero.ascendingColorFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.color == heroVo2.color) then
            if heroVo1.lvl == heroVo2.lvl then
                if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.evolutionLvl > heroVo2.evolutionLvl
                end
            else
                return heroVo1.lvl > heroVo2.lvl
            end
        else
            return heroVo1.color < heroVo2.color
        end
    end
    return nil
end

-- 星级从大到小
hero.descendingEvolutionLvlFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
            if (heroVo1.lvl == heroVo2.lvl) then
                if heroVo1.color == heroVo2.color then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.color > heroVo2.color
                end
            else
                return heroVo1.lvl > heroVo2.lvl
            end
        else
            return heroVo1.evolutionLvl > heroVo2.evolutionLvl
        end
    end

    return nil
end
-- 星级从小到大
hero.ascendingEvolutionLvlFun = function(heroVo1, heroVo2)
    if (heroVo1 ~= nil and heroVo2 ~= nil) then
        if (heroVo1.evolutionLvl == heroVo2.evolutionLvl) then
            if (heroVo1.lvl == heroVo2.lvl) then
                if heroVo1.color == heroVo2.color then
                    return heroVo1.tid > heroVo2.tid
                else
                    return heroVo1.color > heroVo2.color
                end
            else
                return heroVo1.lvl > heroVo2.lvl
            end
        else
            return heroVo1.evolutionLvl < heroVo2.evolutionLvl
        end
    end

    return nil
end

-- 名称长度从大到小
hero.descendingNameLenFun = function(heroVo1, heroVo2)
    -- 名称长度从大到小
    if (heroVo1.name ~= nil and heroVo2.name ~= nil and #heroVo1.name > #heroVo2.name) then
        return true
    end
    if (heroVo1.name ~= nil and heroVo2.name ~= nil and #heroVo1.name < #heroVo2.name) then
        return false
    end
    -- 星级从大到小
    if (heroVo1.evolutionLvl ~= nil and heroVo2.evolutionLvl ~= nil and heroVo1.evolutionLvl > heroVo2.evolutionLvl) then
        return true
    end
    if (heroVo1.evolutionLvl ~= nil and heroVo2.evolutionLvl ~= nil and heroVo1.evolutionLvl < heroVo2.evolutionLvl) then
        return false
    end
    return nil
end
-- 名称长度从小到大
hero.ascendingNameLenFun = function(heroVo1, heroVo2)
    -- 名称长度从小到大
    if (heroVo1.name ~= nil and heroVo2.name ~= nil and #heroVo1.name < #heroVo2.name) then
        return true
    end
    if (heroVo1.name ~= nil and heroVo2.name ~= nil and #heroVo1.name > #heroVo2.name) then
        return false
    end
    -- 星级从大到小
    if (heroVo1.evolutionLvl ~= nil and heroVo2.evolutionLvl ~= nil and heroVo1.evolutionLvl > heroVo2.evolutionLvl) then
        return true
    end
    if (heroVo1.evolutionLvl ~= nil and heroVo2.evolutionLvl ~= nil and heroVo1.evolutionLvl < heroVo2.evolutionLvl) then
        return false
    end

    return nil
end

-- 战员疲劳从大到小
hero.descendingStaminaFun = function(heroVo1, heroVo2)
    local buildBaseHeroInfo1 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroVo1.tid)
    local buildBaseHeroInfo2 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroVo2.tid)
    local isAvailuable1 = hero.HeroCuteManager:getHeroCuteConfigVo(heroVo1.tid) and 0 or -999
    local isAvailuable2 = hero.HeroCuteManager:getHeroCuteConfigVo(heroVo2.tid) and 0 or -999
    if buildBaseHeroInfo1 ~= nil and buildBaseHeroInfo2 ~= nil then
        return buildBaseHeroInfo1.stamina + isAvailuable1 > buildBaseHeroInfo2.stamina + isAvailuable2
    end
    return nil
end

-- 战员疲劳从小到大
hero.ascendingStaminaFun = function(heroVo1, heroVo2)
    local buildBaseHeroInfo1 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroVo1.tid)
    local buildBaseHeroInfo2 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroVo2.tid)
    local isAvailuable1 = hero.HeroCuteManager:getHeroCuteConfigVo(heroVo1.tid) and 0 or 999
    local isAvailuable2 = hero.HeroCuteManager:getHeroCuteConfigVo(heroVo2.tid) and 0 or 999
    if buildBaseHeroInfo1 ~= nil and buildBaseHeroInfo2 ~= nil then
        return buildBaseHeroInfo1.stamina + isAvailuable1 < buildBaseHeroInfo2.stamina + isAvailuable2
    end
    return nil
end

-- 战员升格特效目录
hero.StarUpEffect = {
    Selected = "fx_ui_shengge_xuanzhong", --选中
    -- MaxSelected = "fx_ui_shengge_xuanzhong_jin", --满级选中
    Actived = "fx_ui_shengge_jihuo", --激活
    -- Deactived = "fx_ui_shengge_weijihuo", --未激活
    Explode = "fx_ui_shengge_baofa", --激活中的爆发动效
    -- MaxLv = "fx_ui_shengge_shanguang_jin", --满级
}


-- 记录的英雄界面的列表位置
hero.__HeroPanelOffset = nil
hero.setHeroPanelOffset = function(offset)
    hero.__HeroPanelOffset = offset
end
hero.getHeroPanelOffset = function()
    return hero.__HeroPanelOffset
end

-- 记录的英雄单选界面的列表位置
hero.__SingleSelectOffset = nil
hero.setSingleSelectOffset = function(offset)
    hero.__SingleSelectOffset = offset
end
hero.getSingleSelectOffset = function()
    return hero.__SingleSelectOffset
end

--战员dna蛋 形态枚举
hero.eggType = {
    none = 0, --无
    egg = 1, --蛋形态
    role = 2 --人形态
}

hero.eggQuality = {
    r = 1,
    sr = 2,
    ssr = 3
}

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1030):	"属性"
	语言包: _TT(1167):	"增幅"
	语言包: _TT(1049):	"瓦坦斯"
]]