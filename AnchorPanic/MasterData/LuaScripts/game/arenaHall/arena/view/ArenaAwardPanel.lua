module("arena.ArenaAwardPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaAwardPanel.prefab")
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
    self.tabClassDic[arena.ArenaAwardType.SEASON] = arena.ArenaAwardSegement
    self.tabClassDic[arena.ArenaAwardType.RANKAWARD] = arena.ArenaAwardRank  
    self.tabClassDic[arena.ArenaAwardType.DAILY] = arena.ArenaAwardDaily 

    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(arena.getCollectionTypeList()) do
        table.insert(self.tabDataList, { type = v.page, content = { v.nomalLan }, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon })
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end



return _M

--[[ 替换语言包自动生成，请勿修改！
]]