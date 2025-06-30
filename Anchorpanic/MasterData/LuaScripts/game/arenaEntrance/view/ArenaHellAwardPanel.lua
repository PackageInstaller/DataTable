--[[ 
-----------------------------------------------------
@filename       : ArenaHellAwardPanel
@Description    : 巅峰竞技场奖励界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("arenaEntrance.ArenaHellAwardPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellAwardPanel.prefab")

panelType = 1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

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

-- 初始化
function configUI(self)
    super.configUI(self)
end


-- 激活
function active(self, args)
    super.active(self, args)
end

function getTabClass(self)
    self.tabClassDic[arenaEntrance.RankTabType.RANK_LIST] = arenaEntrance.ArenaHellSeasonRankTabView
    self.tabClassDic[arenaEntrance.RankTabType.RANK_AWARD] = arenaEntrance.ArenaHellSeasonAwardTabView
    self.tabClassDic[arenaEntrance.RankTabType.WEEK_AWARD] = arenaEntrance.ArenaHellWeekAwardTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(arenaEntrance.getCollectionTypeList()) do
        table.insert(self.tabDataList, { type = v.page, content = { v.nomalLan }, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon })
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end



return _M