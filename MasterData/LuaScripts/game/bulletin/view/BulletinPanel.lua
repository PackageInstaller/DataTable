--[[ 
-----------------------------------------------------
@filename       : BulletinInfoPanel
@Description    : 游戏内公告
@date           : 2023-4-09 11:07:05
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.bulletin.view.BulletinPanel', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bulletin/BulletinPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1116, 520)
    self:setTxtTitle(_TT(58))
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

function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnClose"), self.onClickClose)
end

function getTabDatas(self)
    self.tabDataList = {}
    local list = bulletin.BulletinConst:getTabList()
    for _, vo in ipairs(list) do
        table.insert(self.tabDataList, { type = vo.page, content = { vo.nomalLan }, nomalIcon = vo.nomalIcon, selectIcon = vo.selectIcon })
    end
    return self.tabDataList
end

--激活
function active(self, args)
    super.active(self, args)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateTabRed, self)
    bulletin.BulletinManager:addEventListener(bulletin.BulletinManager.EVENT_BULLETIN_UPDATE, self.updateTabRed, self)
    bulletin.BulletinManager:addEventListener(bulletin.BulletinManager.EVENT_BULLETIN_PANEL_CLOSE, self.onClickClose, self)
    -- if args.subType then
    --     self:setPage(args.subType)
    -- end
    self:updateTabRed()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateTabRed, self)
    bulletin.BulletinManager:removeEventListener(bulletin.BulletinManager.EVENT_BULLETIN_UPDATE, self.updateTabRed, self)
    bulletin.BulletinManager:removeEventListener(bulletin.BulletinManager.EVENT_BULLETIN_PANEL_CLOSE, self.onClickClose, self)
end

function setTabBar(self)
    if #self:getTabDataList() <= 0 then
        return
    end
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self:getChildTrans("TabBarNode"), self.onClickMenuHandler, self, nil, "TabViewTabBar")
    self.tabBar:setData(self:getTabDataList())
end

function getTabClass(self)
    self.tabClassDic[bulletin.BulletinConst.BULLETIN_ACTIVITY] = bulletin.BulletinInfoPanel
    self.tabClassDic[bulletin.BulletinConst.BULLETIN_SYSTEM] = bulletin.BulletinInfoPanel
    return self.tabClassDic
end

function updateTabRed(self)
    local isFlag = bulletin.BulletinManager:getIsBubble()
    if isFlag then
        self:addBubble(bulletin.BulletinConst.BULLETIN_ACTIVITY, 36.5, 29.5)
    else
        self:removeBubble(bulletin.BulletinConst.BULLETIN_ACTIVITY)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]