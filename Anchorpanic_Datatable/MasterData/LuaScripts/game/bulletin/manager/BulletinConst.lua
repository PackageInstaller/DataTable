module("game/bulletin/manager/BulletinConst", Class.impl())
BULLETIN_SYSTEM = 1 -- 系统公告
BULLETIN_ACTIVITY = 2 -- 活动公告

function getTabList(self)
    local tabIcon = {}
    if #bulletin.BulletinManager:getBulletinDataByType(bulletin.BulletinConst.BULLETIN_ACTIVITY) >= 1 then
        table.insert(tabIcon, { page = self.BULLETIN_ACTIVITY, nomalLan = "活动公告", nomalLanEn = "", nomalIcon = UrlManager:getPackPath("bulletin/bulletinActivityIcon.png"), selectIcon = UrlManager:getPackPath("bulletin/bulletinActivityIcon.png") })
    end
    table.insert(tabIcon, { page = self.BULLETIN_SYSTEM, nomalLan = _TT(58), nomalLanEn = "", nomalIcon = UrlManager:getPackPath("bulletin/bulletinSystemIcon.png"), selectIcon = UrlManager:getPackPath("bulletin/bulletinSystemIcon.png") })
    return tabIcon
end

return _M