module('task.AchievementPanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('achievement/AchievementPanel.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("common_bg_015.jpg", false)
    self:setTxtTitle(_TT(72106))
    self:setUICode(LinkCode.HomeAchievement)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_curTabType = nil
    -- 切卡组类型
    self.m_tabTypeList = { task.AchievementTab.STORY, task.AchievementTab.DEVELOPMENT, task.AchievementTab.HERO, task.AchievementTab.OTHER }
    self.showTabType = 2
end

function configUI(self)
    super.configUI(self)
end
function setMoneyBar(self)
end


function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_LIST, self.__updateBubbleHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_AWARD, self.__updateBubbleHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ALL_ACHIEVEMENT_AWARD, self.__updateBubbleHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_SCORE_AWARD, self.__updateBubbleHandler, self)
    self:__updateBubbleHandler()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_LIST, self.__updateBubbleHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_AWARD, self.__updateBubbleHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ALL_ACHIEVEMENT_AWARD, self.__updateBubbleHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_SCORE_AWARD, self.__updateBubbleHandler, self)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("mTabBarNode")
end

function getTabDatas(self)
    self.tabDataList = {}
    for i = 1, #self.m_tabTypeList do
        local tabType = self.m_tabTypeList[i]
        -- if (tabType ~= task.AchievementTab.OTHER or (tabType == task.AchievementTab.OTHER and task.AchievementManager:getCompleteNum(tabType) > 0)) then
        table.insert(self.tabDataList, { type = tabType, content = { task.getPageName(tabType) }, nomalIcon = task.getIconPath(tabType), selectIcon = task.getIconPath(tabType) })
        -- end
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[task.AchievementTab.STORY] = task.AchievementTabView
    self.tabClassDic[task.AchievementTab.DEVELOPMENT] = task.AchievementTabView
    self.tabClassDic[task.AchievementTab.HERO] = task.AchievementTabView
    self.tabClassDic[task.AchievementTab.OTHER] = task.AchievementTabView
    return self.tabClassDic
end

function __updateBubbleHandler(self)
    self:__updateBubble(task.AchievementTab.STORY)
    self:__updateBubble(task.AchievementTab.DEVELOPMENT)
    self:__updateBubble(task.AchievementTab.HERO)
    self:__updateBubble(task.AchievementTab.OTHER)
end

function __updateBubble(self, tabType)
    if (task.AchievementManager:judgeIsTypeCanRes(tabType)) then
        self:addBubble(tabType)
    else
        self:removeBubble(tabType)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]