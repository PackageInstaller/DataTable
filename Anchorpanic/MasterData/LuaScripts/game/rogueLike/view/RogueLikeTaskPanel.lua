--[[ 
-----------------------------------------------------
@filename       : RogueLikeTaskPanel
@Description    : 肉鸽任务界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
--]]
module("rogueLike.RogueLikeTaskPanel", Class.impl(TabView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeTaskPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(1008))
    self:setBg("common_bg_015.jpg", false)
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return {}
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

function getTabViewParent(self)
    return self:getChildTrans("ViewContent")
end

function getTabClass(self)
    self.tabClassDic[rogueLike.TaskType.Week] = rogueLike.RogueLikeTaskTabViewWeek
    self.tabClassDic[rogueLike.TaskType.First] = rogueLike.RogueLikeTaskTabViewFirst
    self.tabClassDic[rogueLike.TaskType.Challenge] = rogueLike.RogueLikeTaskTabViewChallenge
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for i, tab in ipairs(rogueLike.RogueLikeConst:getTaskList()) do
        table.insert(self.tabDataList, { type = tab.page, content = { tab.nomalLan }, nomalIcon = tab.nomalIcon, selectIcon = tab.selectIcon })
    end
    return self.tabDataList
end

--function updateTab(self)
--    local list = rogueLike.RogueLikeConst:getTaskList()
--    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mContent, self.setType, self)
--    self.tabBar:setData(list)
--    self.tabBar:setPage(self.mDefaultPage)
--end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mChildView = self:getChildGO("RogueLikeTaskTabView")
    self.mContent = self:getChildTrans("Content")
    self.mDefaultPage = rogueLike.TaskType.Week
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_TASK_RED,self.updateTaskPanel,self)
    self:updateTabRed()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_TASK_RED,self.updateTaskPanel,self)
end

function updateTaskPanel(self)
    self:updateTabRed()
end

function updateTabRed(self)
    for id,_ in pairs(self.tabBar.btnMap) do
        self:getRedData(id)
    end
end

function getRedData(self,index)
    local isBubble = rogueLike.RogueLikeManager:getRedData(index)
    if (isBubble) then
        self:addBubble(index)
    else
        self:removeBubble(index)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]