--[[ 
-----------------------------------------------------
@Description    : 联盟团战排名页
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module("guildWar.GuildWarTabPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarTabPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(149120))
    self:setBg("disaster_blur.jpg", false, "disaster")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

-- 初始化
function configUI(self)
    super.configUI(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ })
end

function getTabClass(self)
    self.tabClassDic[guildWar.TabType.Rank] = guildWar.GuildWarRankTabView
    self.tabClassDic[guildWar.TabType.Award] = guildWar.GuildWarAwardTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(guildWar.GetTabeList()) do
        table.insert(self.tabDataList, {type = v.page, content = {v.nomalLan}, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon})
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

return _M