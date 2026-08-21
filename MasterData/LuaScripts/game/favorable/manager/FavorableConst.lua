--[[ 
-----------------------------------------------------
@filename       : FavorableConst
@Description    : 战员档案常量
@date           : 2021-08-23 15:32:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.manager.FavorableConst', Class.impl())


-- 战员档案
HERO_DETAIL = 1

HERO_FAVORABLE = 2
-- 战员秘闻
HERO_FILE_CASE = 3
-- 战员cv
HERO_FILE_VOICE = 4
-- 战员动作
HERO_FILE_INTERACT = 5

--心语录
HERO_STORY = 6

-- 菜单列表
TAB_LIST = {}
TAB_LIST[HERO_FAVORABLE] = { page = HERO_FAVORABLE, nomalLan = _TT(41715), nomalLanEn = "" }
TAB_LIST[HERO_FILE_CASE] = { page = HERO_FILE_CASE, nomalLan = _TT(41716), nomalLanEn = "" }
TAB_LIST[HERO_FILE_VOICE] = { page = HERO_FILE_VOICE, nomalLan = _TT(41717), nomalLanEn = "" }
TAB_LIST[HERO_FILE_INTERACT] = { page = HERO_FILE_INTERACT, nomalLan = _TT(41718), nomalLanEn = "" }
TAB_LIST[HERO_DETAIL] = { page = HERO_DETAIL, nomalLan = _TT(41725), nomalLanEn = "" }
TAB_LIST[HERO_STORY] = { page = HERO_STORY, nomalLan = _TT(41758), nomalLanEn = "" }
-- 菜单列表2
TAB_LIST2 = {}
TAB_LIST2[HERO_DETAIL] = { page = HERO_DETAIL, nomalLan = _TT(41725), nomalLanEn = "" }
TAB_LIST2[HERO_FILE_CASE] = { page = HERO_FILE_CASE, nomalLan = _TT(41716), nomalLanEn = "" }
TAB_LIST2[HERO_FILE_VOICE] = { page = HERO_FILE_VOICE, nomalLan = _TT(41717), nomalLanEn = "" }
TAB_LIST2[HERO_FILE_INTERACT] = { page = HERO_FILE_INTERACT, nomalLan = _TT(41718), nomalLanEn = "" }
TAB_LIST2[HERO_STORY] = { page = HERO_STORY, nomalLan = _TT(41758), nomalLanEn = "" }

favorable.getPageIcon = function(cusPageType)
    local icon = ""
    if cusPageType == favorable.FavorableConst.HERO_DETAIL then
        icon = UrlManager:getPackPath("heroFavorable/hero_favorableBtn_01.png") --"战员档案"
    elseif (cusPageType == favorable.FavorableConst.HERO_FILE_CASE) then
        icon = UrlManager:getPackPath("heroFavorable/hero_favorableBtn_02.png")--"战员秘闻"
    elseif cusPageType == favorable.FavorableConst.HERO_FILE_VOICE then
        icon = UrlManager:getPackPath("heroFavorable/hero_favorableBtn_03.png")--"战员cv"
    elseif cusPageType == favorable.FavorableConst.HERO_FILE_INTERACT then
        icon = UrlManager:getPackPath("heroFavorable/hero_favorableBtn_04.png")--"战员动作"
    elseif cusPageType == favorable.FavorableConst.HERO_STORY then
        icon = UrlManager:getPackPath("heroFavorable/hero_favorableBtn_04.png")--"战员动作"
    end
    return icon
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]