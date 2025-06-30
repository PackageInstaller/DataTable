-- @FileName:   GuildBossRankPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-07 20:37:09
-- @Copyright:   (LY) 2023 雷焰网络

module("guild.GuildBossRankPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("guild/GuildBossRankPanel.prefab")

panelType = 1-- 窗口类型 1 全屏 2 弹窗

--是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    -- self:setTxtTitle(_TT(52094))
    self:setTxtTitle(_TT(62207))
    self:setBg("")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

-- 激活
function active(self, args)
    super.active(self, args)
end

function setMoneyBar(self)

end

function getTabClass(self)
    self.tabClassDic[1] = guild.GuildBossRankTabView
    self.tabClassDic[2] = guild.GuildBossSeasonAwardTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList =
    {
        [1] =
        {
            type = 2,
            content = {_TT(94566)},
            nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_58.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_58.png")},

        [2] =
        {
            type = 1,
            content = {_TT(94565)},
            nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_57.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_57.png")},
    }

    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end
return _M
