--[[ 
-----------------------------------------------------
@filename       : ManualConst
@Description    : 怪物const
@date           : 2022-4-20 19:06:00
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
-- 图鉴类型
manual.ManualType = {
    -- 战员
    Hero = 1,
    -- 怪物
    Monster = 2,
    --故事
    Story = 3,
    --模组
    Module = 4,
    --烙痕
    SolderingMark = 5,
    --世界
    World = 6,
    --CG
    CG = 7,
    --音乐
    Music = 8,
    --时装
    Fashion = 9, 
}
manual.MonsterType = {
    Human = 1, --未变异体
    MecWeapons = 2, --机械兵器
    Variation = 3, --异变体
    Repair = 4, --修格尔
}

manual.getProgress = function(type)
    if type == manual.ManualType.SolderingMark then
        local equipList = manual.ManualManager:getBracelesConfigDic()
        local hasTarget = 0
        for k, v in pairs(equipList) do
            if manual.ManualManager:jugEquipHasUnlockByTid(v.tid) then
                hasTarget = hasTarget + 1
            end
        end
        return math.floor(hasTarget / #equipList * 100)
    else
        return 0
    end
end

manual.getTabList = function(tabType)
    local tab = {}
    if tabType == nil then
        for _, vo in ipairs(manual.ManualManager:getMonsterTabList()) do
            tab[vo.type] = { page = vo.type, nomalLan = _TT(vo.lang), nomalLanEn = "",}
        end
    elseif tabType == manual.ManualType.SolderingMark then
        tab[1] = { page = 1, nomalLan = "全部", nomalLanEn = "", colorType = 1 }
        tab[2] = { page = 2, nomalLan = _TT(601301), nomalLanEn = "", colorType = 4 }
        tab[3] = { page = 3, nomalLan = _TT(601303), nomalLanEn = "", colorType = 3 }
        tab[4] = { page = 4, nomalLan = _TT(601302), nomalLanEn = "", colorType = 2 }
    elseif tabType == manual.ManualType.Fashion then
        tab[1] = { page = 1, nomalLan = "全部", nomalLanEn = "", colorType = 1 }
        tab[2] = { page = 2, nomalLan = _TT(80037), nomalLanEn = "", colorType = 4 }
        tab[3] = { page = 3, nomalLan = _TT(80038), nomalLanEn = "", colorType = 3 }
    end
    return tab
end
--btnName为按钮节点名称，nomalLan为按钮语言包，应输入语言包编号，当前字符串只是临时的，progress是模块进度，需要接入各个模块的进度 funcopen_id 功能开启id
manual.getMainBtnList = function()
    local tab = {}
    tab[manual.ManualType.Hero] = { btnName = "mBtnHero", nomalLan = "战员", progress = manual.ManualHeroManager:getAllUnlockListPercent(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_HERO, isNew = manual.ManualHeroManager:getAllHaveNew() }
    tab[manual.ManualType.Monster] = { btnName = "mBtnMonster", nomalLan = "敌人", progress = manual.ManualManager:getMonsterProgress(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_MONSTER, isNew = manual.ManualManager:getAllHaveNew() }
    tab[manual.ManualType.Story] = { btnName = "mBtnStory", nomalLan = "故事", progress = manual.ManualStoryManager:getUnlockSubNum(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_STORY, isNew = manual.ManualStoryManager:getAllHaveNew() }
    tab[manual.ManualType.Module] = { btnName = "mBtnModule", nomalLan = "模组", progress = manual.ManualModuleManager:getSelfProgress(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_MODULD, isNew = manual.ManualModuleManager:getAllHaveNew() }
    tab[manual.ManualType.SolderingMark] = { btnName = "mBtnSolderingMark", nomalLan = "烙痕", progress = manual.getProgress(manual.ManualType.SolderingMark), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_SOLDERINGMARK, isNew = manual.ManualManager:getBracelesAllHaveNew() }
    tab[manual.ManualType.World] = { btnName = "mBtnWorld", nomalLan = "世界", progress = manual.ManualWorldManager:getCurProgresstByType(1), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_WORLD, isNew = manual.ManualWorldManager:getAllHaveNew() }--
    --tab[manual.ManualType.CG] = { btnName = "mBtnCG", nomalLan = "CG", progress = 0, funcopen_id = "" }
    tab[manual.ManualType.Music] = { btnName = "mBtnMusic", nomalLan = "音乐", progress = manual.ManualMusicManager:getUnlockNum(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_MUSIC, isNew = manual.ManualMusicManager:getAllHaveNew() }
    tab[manual.ManualType.Fashion] = { btnName = "mBtnFashion", nomalLan = "时装", progress = manual.ManualFashionManager:getUnlockNum(), funcopen_id = funcopen.FuncOpenConst.FUNC_ID_MANUAL_FASHION, isNew = manual.ManualFashionManager:getAllHaveNew() }
    return tab
end

manual.getPageIcon = function(cusPageType)
    local icon = ""
    if cusPageType == manual.MonsterType.Human then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_46.png")
    elseif cusPageType == manual.MonsterType.MecWeapons then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_59.png")
    elseif cusPageType == manual.MonsterType.Variation then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_60.png")
    elseif cusPageType == manual.MonsterType.Repair then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_61.png")
    end
    return icon
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]