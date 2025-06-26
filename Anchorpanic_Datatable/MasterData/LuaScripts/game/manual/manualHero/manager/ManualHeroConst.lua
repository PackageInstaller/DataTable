--[[ 
-----------------------------------------------------
@filename       : ManualHeroConst
@Description    : 战员Const
@date           : 2023-3-27 14:58:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroConst", Class.impl())
-- 图鉴类型
manual.ManualHeroCamp = {
    -- 约瑟伯格
    NorthernCommunity = 1,
    -- 落得联盟
    WesternConfederation = 2,
    -- 北极
    EasternRepublic = 3,
    -- 伯极索米
    SouthernUnitedKingdom = 4,
    -- 远东联盟
    Vartans = 5,
    -- 莱斯坦斯
    SparkAlliance = 6,
    -- 公约辉光之环
    ConventionRingOfGlow = 7,
    -- 未知
    Unknown = 8,
}
function getHeroCampList(self)
    local tab = {}
    tab[manual.ManualHeroCamp.NorthernCommunity] = { camp = manual.ManualHeroCamp.NorthernCommunity, name = _TT(80007), des = _TT(80015), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.NorthernCommunity .. ".png") }
    tab[manual.ManualHeroCamp.WesternConfederation] = { camp = manual.ManualHeroCamp.WesternConfederation, name = _TT(80008), des = _TT(80016), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.WesternConfederation .. ".png") }
    tab[manual.ManualHeroCamp.EasternRepublic] = { camp = manual.ManualHeroCamp.EasternRepublic, name = _TT(80009), des = _TT(80017), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.EasternRepublic .. ".png") }
    tab[manual.ManualHeroCamp.SouthernUnitedKingdom] = { camp = manual.ManualHeroCamp.SouthernUnitedKingdom, name = _TT(80010), des = _TT(80018), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.SouthernUnitedKingdom .. ".png") }
    tab[manual.ManualHeroCamp.Vartans] = { camp = manual.ManualHeroCamp.Vartans, name = _TT(80011), des = _TT(80022), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.Vartans .. ".png") }
    tab[manual.ManualHeroCamp.SparkAlliance] = { camp = manual.ManualHeroCamp.SparkAlliance, name = _TT(80012), des = _TT(80023), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.SparkAlliance .. ".png") }
    tab[manual.ManualHeroCamp.ConventionRingOfGlow] = { camp = manual.ManualHeroCamp.ConventionRingOfGlow, name = _TT(80013), des = _TT(80024), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.ConventionRingOfGlow .. ".png") }
    tab[manual.ManualHeroCamp.Unknown] = { camp = manual.ManualHeroCamp.Unknown, name = _TT(80014), des = _TT(80025), url = UrlManager:getIconPath("camp/camp_" .. manual.ManualHeroCamp.Unknown .. ".png") }
    return tab
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]