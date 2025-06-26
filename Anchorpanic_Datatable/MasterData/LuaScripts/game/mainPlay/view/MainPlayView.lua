module("mainPlay.MainPlayView", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("mainPlay/MainPlayView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52001))
    self:setUICode(LinkCode.Adventure)
    self:setBg("")
end

-- 适应全面屏，刘海缩进
--function getAdaptaTrans(self)
--   return self.base_childTrans["mGroupTop"]
--end

function initTabBar(self)
end

function getTabViewParent(self)
    return self:getChildTrans("ViewContent")
end

function getTabClass(self)
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_BIOGRAPHY] = battleMap.BiographyTabView
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_MAIN] = battleMap.MainMapTabView
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_STORY] = branchStory.BranchStoryPanel
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_DUP] = mainPlay.MainPlayDupView
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_CHALLAGE] = dup.DupChallengePanel
    self.tabClassDic[mainPlay.MainPlayConst.MAINPLAY_FRAGMENT] = battleMap.FragmentMapTabView
    return self.tabClassDic
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function updateTabBar(self)
end

function configUI(self)
    super.configUI(self)
    self.mViewContent = self:getChildTrans("ViewContent")
    self.mContent = self:getChildTrans("Content")
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    local args = self.mActiveArgs or {}
    self.mActiveArgs = nil
    return args
end

function sortDicToList(self, dic)
    local list = {}
    for id, data in pairs(dic) do
        table.insert(list, data)
    end

    table.sort(list, function(a, b)
        return a.page < b.page
    end)
    return list
end

function updateTab(self)
    local dic = mainPlay.MainPlayConst:getTabList() --mainPlay.MainPlayConst.TAB_LIST
    local list = self:sortDicToList(dic)
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mContent, self.setType, self)
    self.tabBar:setData(list)

    self.mContent.gameObject:SetActive(#list > 1)

    for type, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_BtnMainPlay_" .. type, item:getChildTrans("mBtnNomal"))
    end
end

function updateTabRed(self, index)
    if index == nil then
        for id, _ in pairs(self.tabBar.btnMap) do
            self:updateBubbleView(id)
        end
    else
        if self.tabBar.btnMap[index] == nil then
            return
        end
        self:updateBubbleView(index)
    end
end

function updateFragmentRedByRead(self)
    local isBubble = mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_FRAGMENTMAP)
    if (isBubble) then
        self:addBubble(mainPlay.MainPlayConst.MAINPLAY_FRAGMENT, 83, 16)
    else
        self:removeBubble(mainPlay.MainPlayConst.MAINPLAY_FRAGMENT)
    end
end

function updateBubbleView(self, index)
    local dic = mainPlay.MainPlayConst:getTabList()
    local manager = dic[index].manager
    local isBubble = false
    if (manager) then
        isBubble = manager:isBubble()
    elseif index == mainPlay.MainPlayConst.MAINPLAY_CHALLAGE then
        isBubble = mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_ROGUE) or
        mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR) or
        mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE) or
        mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER) or
        mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_BOUNDLESS) or 
        mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_SEADED)
    elseif index == mainPlay.MainPlayConst.MAINPLAY_MAIN then
        isBubble = mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_MAINMAP)
    elseif index == mainPlay.MainPlayConst.MAINPLAY_FRAGMENT then
        isBubble = mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_FRAGMENTMAP)
    end
    if (isBubble) then
        self:addBubble(index, 83, 16)
    else
        self:removeBubble(index)
    end
end

function setType(self, cusTabType, cusArgs)
    if (self.curPage == cusTabType) then
        self:subActive()
        return
    end
    if cusTabType == mainPlay.MainPlayConst.MAINPLAY_DUP then
        dup.DupDailyBaseManager.mIsShowMain = true
    end
    self:setPage(cusTabType)
    local instance = self:getClassInsByType(cusTabType)
    for type, classIns in pairs(self.m_classInsDic) do
        if (type ~= cusTabType) then
            if (not classIns:getIsCache()) then
                classIns:setUICache(false)
                classIns:__deActive()
            end
        end
    end
    if cusArgs then
        self.args[self.curPage] = cusArgs
    elseif not self.args[self.curPage] then
        self.args[self.curPage] = self:getActiveArgs()
    end
    instance:setUICache(true)
    instance:__active(self.args[self.curPage], self.isReshow)
    self.isReshow = false
end

function active(self, args)
    super.active(self, args)

    self:updateTab()
    self:updateTabImg()
    self.mActiveArgs = args.data
    self.tabBar:setPage(args.type)
    self:updateTabRed(nil)
    GameDispatcher:addEventListener(EventName.UPDATE_FRAGMENT_RED, self.updateFragmentRedByRead, self)
end

function deActive(self)
    super.deActive(self)
    self.tabBar:removeAllBubble()
    self.tabBar:reset()
    GameDispatcher:removeEventListener(EventName.UPDATE_FRAGMENT_RED, self.updateFragmentRedByRead, self)
end

function updateBg(self, page)
end

function updateTabImg(self)
    for type, item in pairs(self.tabBar.btnMap) do
        item:getChildGO("mBtnSelect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("mainPlay/mainPlay_select_2.png"), false)
        item:getChildGO("mImgSelectTip"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("mainPlay/mainPlay_icon_" .. type .. ".png"), true)
        item:getChildGO("mImgNomalTip"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("mainPlay/mainPlay_icon_" .. type .. ".png"), true)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]