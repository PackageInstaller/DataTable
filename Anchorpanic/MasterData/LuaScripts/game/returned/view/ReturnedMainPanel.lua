--[[ 
-----------------------------------------------------
@filename       : ReturnedMainPanel
@Description    : 常驻回归活动主界面
@date           : 2023-10-31 17:25:06
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.view.ReturnedMainPanel', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("returned/ReturnedMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(94005))
    self:setBg("")
end
--析构  
function dtor(self)
end

function initData(self)
    super.initData(self)
    self.showTabType = 2
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO("aa"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
end

--激活
function active(self, args)
    super.active(self, args)
    returned.ReturnedManager:addEventListener(returned.ReturnedManager.EVENT_RETURNED_SIGN_UPDATE, self.onDataUpdate, self)
    returned.ReturnedManager:addEventListener(returned.ReturnedManager.EVENT_RETURNED_TASK_UPDATE, self.onDataUpdate, self)

    self:updateTabRed()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    returned.ReturnedManager:removeEventListener(returned.ReturnedManager.EVENT_RETURNED_SIGN_UPDATE, self.onDataUpdate, self)
    returned.ReturnedManager:removeEventListener(returned.ReturnedManager.EVENT_RETURNED_TASK_UPDATE, self.onDataUpdate, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function getTabDatas(self)
    self.tabDataList = {}

    table.insert(self.tabDataList, { type = ReturnedTabPage.RETURNEN_PAGE_SIGN, content = { _TT(94001) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_65.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_65.png") })
    table.insert(self.tabDataList, { type = ReturnedTabPage.RETURNEN_PAGE_TASK_DAILY, content = { _TT(94002) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_66.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_66.png") })
    table.insert(self.tabDataList, { type = ReturnedTabPage.RETURNEN_PAGE_TASK_CHALLENGE, content = { _TT(94003) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_67.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_67.png") })
    table.insert(self.tabDataList, { type = ReturnedTabPage.RETURNEN_PAGE_SHOP, content = { _TT(94004) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_68.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_68.png") })

    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[ReturnedTabPage.RETURNEN_PAGE_SIGN] = returned.ReturnedSignView
    self.tabClassDic[ReturnedTabPage.RETURNEN_PAGE_TASK_DAILY] = returned.ReturnedTaskDailyView
    self.tabClassDic[ReturnedTabPage.RETURNEN_PAGE_TASK_CHALLENGE] = returned.ReturnedTaskChallengeView
    self.tabClassDic[ReturnedTabPage.RETURNEN_PAGE_SHOP] = returned.ReturnedShopView
    return self.tabClassDic
end

function setPage(self, cusType)
    super.setPage(self, cusType)
    if cusType == ReturnedTabPage.RETURNEN_PAGE_SIGN then
        self:setBg("Regression_bg_01.jpg", false, "returned")
    elseif cusType == ReturnedTabPage.RETURNEN_PAGE_TASK_DAILY then
        self:setBg("Regression_bg_02.jpg", false, "returned")
    elseif cusType == ReturnedTabPage.RETURNEN_PAGE_TASK_CHALLENGE then
        self:setBg("Regression_bg_03.jpg", false, "returned")
    elseif cusType == ReturnedTabPage.RETURNEN_PAGE_SHOP then
        self:setBg("Regression_bg_04.jpg", false, "returned")
    end
end

function onDataUpdate(self)
    self:updateTabRed()
end

function updateTabRed(self)
    for page, _ in pairs(self.tabBar.btnMap) do
        local isRed = returned.ReturnedManager:getHasRedAll(page)
        if isRed then
            self:addBubble(page)
        else
            self:removeBubble(page)
        end
    end
end

return _M