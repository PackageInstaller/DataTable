--[[ 
-----------------------------------------------------
@filename       : ArenaHellLogPanel
@Description    : 巅峰竞技场日志界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]

module("arenaEntrance.ArenaHellLogPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellLogPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62205))
    self:setSize(0, 0)
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
    self.tabClassDic[arenaEntrance.ArenaEntaceLogType.TypeAttack] = arenaEntrance.ArenaHellLogAttackTabView
    self.tabClassDic[arenaEntrance.ArenaEntaceLogType.TypeDefense] = arenaEntrance.ArenaHellLogDefenseTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(arena.getLogTypeList()) do
        table.insert(self.tabDataList, { type = v.page, content = { v.nomalLan }, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon })
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end


return _M