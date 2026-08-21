module("seabed.SeabedTaskPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedTaskPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(111020))
    self:setBg("seabed_main.jpg", false, "seabed")
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
    MoneyManager:setMoneyTidList({})
    self:updateBubble()
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_RED,self.updateBubble,self)
end

function getTabClass(self)
    self.tabClassDic[seabed.SeabedTaskType.Def] = seabed.SeabedTaskDefTabView
    self.tabClassDic[seabed.SeabedTaskType.High] = seabed.SeabedTaskHighTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(seabed.getSeabedTaskList()) do
        table.insert(self.tabDataList, {type = v.page, content = {v.nomalLan}, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon})
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_RED,self.updateBubble,self)
end

function updateBubble(self)
    if seabed.SeabedManager:canGetTaskByType(seabed.SeabedTaskType.Def) then
        self:addBubble(seabed.SeabedTaskType.Def)
    else
        self:removeBubble(seabed.SeabedTaskType.Def)
    end
    if seabed.SeabedManager:canGetTaskByType(seabed.SeabedTaskType.High) then
        self:addBubble(seabed.SeabedTaskType.High)
    else
        self:removeBubble(seabed.SeabedTaskType.High)
    end
end


return _M