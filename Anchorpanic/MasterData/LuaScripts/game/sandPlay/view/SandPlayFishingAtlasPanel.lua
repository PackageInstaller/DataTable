-- @FileName:   SandPlayFishingAtlasPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-21 10:30:52
-- @Copyright:   (LY) 2023 雷焰网络

module("game.sandPlay.view.SandPlayFishingAtlasPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayFishingAtlasPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 518)
    self:setTxtTitle(_TT(98333))

end

function initTabBar(self)

end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
    self.m_content = self:getChildTrans('mTabContent')
    self.mChildPoint = self:getChildTrans("mChildPoint")
end

function getTabViewParent(self)
    return self.mChildPoint
end

-- 玩家关闭所有窗口的c#回调
function __onPlayerClose(self)
    self.m_curTabType = nil
end

function active(self, args)
    -- super.active(self, args)

    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    local selectPath = "arts/ui/pack/common5/common_0014.png"
    self.mMeneList =
    {
        {id = 1, page = 1, nomalLanEnId = 98333, selectIcon = selectPath},
        {id = 2, page = 2, nomalLanEnId = 98334, selectIcon = selectPath},
        {id = 3, page = 3, nomalLanEnId = 98335, selectIcon = selectPath},
    }

    if not self.tabBar then
        self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.m_content, self.setSubPage, self, self.mMeneList, "SandPlayFishingAtlasPanel_TabItem")
    else
        self.tabBar:setData(self.mMeneList)
    end

    self.tabBar:setPage(1)

    self:updataRedState()
end

function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    self.tabBar:reset()
    self.tabBar = nil
end

function initViewText(self)

end

function addAllUIEvent(self)

end

function setSubPage(self, cusPage)
    self:setTxtTitle(_TT(self.mMeneList[cusPage].nomalLanEnId))

    self:setType(cusPage)
end

function getTabClass(self)
    self.tabClassDic[1] = sandPlay.SandPlayFishingAwardTab
    self.tabClassDic[2] = sandPlay.SandPlayFishingAchieveTab
    self.tabClassDic[3] = sandPlay.SandPlayFishingAtlasTab
    return self.tabClassDic
end

function updataRedState(self)
    local awardRedState = sandPlay.SandPlayManager:getFishingAwardRedState()
    if awardRedState then
        self.tabBar:addBubble(1, 97, 22)
    else
        self.tabBar:removeBubble(1)
    end

    local awardRedState = sandPlay.SandPlayManager:getFishingAchieveRedState()
    if awardRedState then
        self.tabBar:addBubble(2, 97, 22)
    else
        self.tabBar:removeBubble(2)
    end
end

return _M
