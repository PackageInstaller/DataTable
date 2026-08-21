-- @FileName:   BulleStageMainUI.lua
-- @Description:   大西瓜关卡界面
-- @Copyright:   (LY) 2023 雷焰网络

module('bulle.BulleStageMainUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bulle/BulleStageMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("stage_01.jpg",true,"bulle")

    local name = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Bulle):getName()
    self:setTxtTitle(name)
end

function initData(self)

end
-- 设置货币栏
function setMoneyBar(self)

end
-- 初始化
function configUI(self)
    self.mItemTab = self:getChildGO("mItemTab")
    self.mTabGroup = self:getChildTrans("mTabGroup")

    self.list = self:getChildTrans("list")
    self.mDupItem = self:getChildGO("mDupItem")

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.ScrollRect)
    self.mScrollRectTran = self:getChildGO("LyScroller"):GetComponent(ty.RectTransform)
    self.mDupContentRect = self:getChildGO("list"):GetComponent(ty.RectTransform)

    --self.mBtnReward = self:getChildGO("mBtnReward")
    --self.mTextStarCount = self:getChildGO("mTextStarCount"):GetComponent(ty.Text)
    --self.ImEffect = self:getChildGO("ImEffect")

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    --self.mBtnFuncTips:SetActive(false)

    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mTxtTask = self:getChildGO("mTxtTask"):GetComponent(ty.Text)
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    --self.mImgBg:setSprite(UrlManager:getSprite("bulle/bg_01.jpg"))

end

function initViewText(self)
    self.mTxtTask.text = _TT(151210)
    self.mTxtRank.text = _TT(151211)
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_TIPS_VIEW)
   
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    --self:addUIEvent(self.mBtnReward, self.onClickReward)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnTask, self.onClickTask)
    self:addUIEvent(self.mBtnRank, self.onClickRank)    
end

function onClickTask(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_TASK_PANEL)
end

function onClickRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_RANK_PANEL)
end


--激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_BULLE_STAGE_PANEL,self.showPanel,self)
    self:showPanel()
end

function showPanel(self)
    self:addAllEventListener()

    self:creatTabList()

    local area_id = nil
    -- if args then
    --     area_id = args.area_id
    -- end

    if area_id then
        local areaConfig = bulle.BulleManager:getAreaConfig(area_id)
        if not areaConfig:isOpen() then
            area_id = 1
        end

        local lastArea = area_id - 1
        if lastArea > 0 then
            if not bulle.BulleManager:getAreaPassState(lastArea) then
                area_id = 1
            end
        end
    else
        local areaConfigDic = bulle.BulleManager:getAreaConfigDic()
        for i = 1, #areaConfigDic do
            local timeOpen = areaConfigDic[i]:isOpen()
            local lastOpen = true
            if i > 1 then
                lastOpen = bulle.BulleManager:getAreaPassState(areaConfigDic[i - 1].tid)
            end

            if lastOpen and timeOpen then
                area_id = areaConfigDic[i].tid
            end
        end
    end

    self:selectMapTab(area_id)
    self:onDataRefresh()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BULLE_STAGE_PANEL,self.showPanel,self)
    self.m_select_areaId = nil

    self:removeAllEventListener()

    self:KillScrollTweener()

    self:clearDupItemList()
    self:clearTabItem()

    --GameDispatcher:dispatchEvent(EventName.CLOSE_MOLE_DUP_PANEL)
end

function close(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_BULLE_DUP_PANEL)

    super.close(self)
end

function addAllEventListener(self)
    GameDispatcher:addEventListener(EventName.ONCLOSE_LINKLINK_DUPPANEL, self.onDupInfoPanelClose, self)
    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_SCENEUI, self.close, self)
    GameDispatcher:addEventListener(EventName.BULLE_TASK_UPDATE, self.onDataRefresh, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BULLE_STAGE_PANEL, self.onDataRefresh, self)
end

function removeAllEventListener(self)
    GameDispatcher:removeEventListener(EventName.ONCLOSE_LINKLINK_DUPPANEL, self.onDupInfoPanelClose, self)
    GameDispatcher:removeEventListener(EventName.LINKLINK_OPEN_SCENEUI, self.close, self)
    GameDispatcher:removeEventListener(EventName.BULLE_TASK_UPDATE, self.onDataRefresh, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BULLE_STAGE_PANEL, self.onDataRefresh, self)
    

end

function onClickReward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_STAR_REWARD_PANEL)
end

function onDataRefresh(self)
    self:refreshStarAwardRedPoint()
    self:refreshAreaRedPoint()
    self:refreshDupRedPoint()
end

function onDupInfoPanelClose(self)
    if not self.m_dupItemList then
        return
    end

    for _, item in pairs(self.m_dupItemList) do
        item:unSelect()
    end

    self.m_SelectDupId = nil
end

function creatTabList(self)
    local areaConfigDic = bulle.BulleManager:getAreaConfigDic()
    table.sort(areaConfigDic, function (a, b)
        return a.tid < b.tid
    end)

    self:clearTabItem()
    for i = 1, #areaConfigDic do
        local tabItem = SimpleInsItem:create(self.mItemTab, self.mTabGroup, "bulle_stageMainUI_tabItem")
        self.m_tabItemList[i] = tabItem

        tabItem.data = areaConfigDic[i]

        local timeOpen = areaConfigDic[i]:isOpen()
        local lastOpen = true
        if i > 1 then
            lastOpen = bulle.BulleManager:getAreaPassState(areaConfigDic[i - 1].tid)
        end

        if timeOpen and lastOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = ""

            tabItem:getChildGO("mTextLabel"):GetComponent(ty.Text).text = areaConfigDic[i]:getName()
            tabItem:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = areaConfigDic[i]:getName()
        elseif not timeOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(130002, areaConfigDic[i].begin_time.year, areaConfigDic[i].begin_time.month, areaConfigDic[i].begin_time.day)

            tabItem:getChildGO("mTextLabel"):GetComponent(ty.Text).text = ""
            tabItem:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = ""
        elseif not lastOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(4620)

            tabItem:getChildGO("mTextLabel"):GetComponent(ty.Text).text = ""
            tabItem:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = ""
        end

        tabItem:addUIEvent(nil, function ()
            if not timeOpen then
                gs.Message.Show(_TT(130002, areaConfigDic[i].begin_time.year, areaConfigDic[i].begin_time.month, areaConfigDic[i].begin_time.day))
                return
            end

            if not lastOpen then
                gs.Message.Show(_TT(4620))
                return
            end

            tabItem:select()
        end)

        tabItem.select = function (_item)
            for _, item in pairs(self.m_tabItemList) do
                item:unSelect()
            end

            _item:getChildGO("mImgNormal"):SetActive(false)
            _item:getChildGO("mImgSelect"):SetActive(true)

            self:onSelectMapTab(_item.data.tid)
        end

        tabItem.unSelect = function (_item)
            _item:getChildGO("mImgNormal"):SetActive(true)
            _item:getChildGO("mImgSelect"):SetActive(false)
        end
    end
end

function clearTabItem(self)
    if self.m_tabItemList then
        for k, item in pairs(self.m_tabItemList) do
            item.data = nil
            item.select = nil
            item.unSelect = nil

            item:poolRecover()
        end
    end

    self.m_tabItemList = {}
end

function selectMapTab(self, area_id)
    for _, item in pairs(self.m_tabItemList) do
        if item.data.tid == area_id then
            item:select()
            break
        end
    end
end

function onSelectMapTab(self, area_id)
    if area_id == self.m_select_areaId then
        return
    end

    self.m_select_areaId = area_id

    self.mImgBg:SetImg(UrlManager:getBgPath("bulle/stage_0".. (self.m_select_areaId)..".jpg"))
    --self:setBg("stage_0".. (self.m_select_areaId)..".jpg",true,"bulle")

    self.m_SelectDupId = nil

    local areaConfigDic = bulle.BulleManager:getAreaConfigDic()
    self.m_areaConfig = areaConfigDic[self.m_select_areaId]

    local scroll_dupId = self.m_areaConfig.stage_list[1]
    self:clearDupItemList()
    local length = #self.m_areaConfig.stage_list
    for i = 1, length do
        local dup_id = self.m_areaConfig.stage_list[i]

        local dupItem = SimpleInsItem:create(self.mDupItem, self.list, "bulle_stageMainUI_dupItem")
        self.m_dupItemList[dup_id] = dupItem

        local configVo = bulle.BulleManager:getDupConfig(dup_id)

        dupItem.data = configVo

        local Odd = (i % 2) == 1
        local mRayPoint = dupItem:getChildGO("mRayPoint"):GetComponent(ty.RectTransform)
        local starList = dupItem:getChildGO("starList"):GetComponent(ty.RectTransform)
        if Odd then
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, 82.5)
        else
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, -78)
        end

        --local star_count = bulle.BulleManager:getDupPassStar(dup_id)
        for i = 1, 3 do
            dupItem:getChildGO("mStar_" .. i):SetActive(false)
        end

        local isPass = bulle.BulleManager:getDupPassState(dup_id)
        dupItem:getChildGO("mImgPass"):SetActive(isPass)

        --dupItem:getChildGO("mImgItemBg"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/linklink/linklink%02d.png", 7 + self.m_select_areaId))

        local isTimeOpen = configVo:isOpen()
        local lastPass = true
        if configVo.pre_id ~= 0 then
            lastPass = bulle.BulleManager:getDupPassState(configVo.pre_id)
        end

        if not isTimeOpen then
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = _TT(130002, configVo.begin_time.year, configVo.begin_time.month, configVo.begin_time.day)
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = ""
        elseif not lastPass then
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(130008)
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
        elseif isTimeOpen and lastPass then
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = configVo:getName()
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = ""
        end

        if isTimeOpen and lastPass and not isPass then
            if i - 1 > 1 then
                scroll_dupId = self.m_areaConfig.stage_list[i - 1]
            else
                scroll_dupId = dup_id
            end
        end

        dupItem:addUIEvent("mRayPoint", function ()
            if not isTimeOpen then
                gs.Message.Show(_TT(130002, configVo.begin_time.year, configVo.begin_time.month, configVo.begin_time.day))
                return
            end

            if not lastPass then
                gs.Message.Show(_TT(130009))
                return
            end

            StorageUtil:saveBool1(gstor.BULLE_DUPNEWOPENSTR .. dup_id, true)
            GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
            self:refreshAreaRedPoint()
            self:refreshDupRedPoint()

            dupItem:select()
        end)

        dupItem.select = function (_item)
            for _, item in pairs(self.m_dupItemList) do
                item:unSelect()
            end

            _item:getChildGO("mImgSelect"):SetActive(true)
            self:onSelectDupItem(_item.data)
        end

        dupItem.unSelect = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(false)
        end
    end

    self:onDupInfoPanelClose()

    ---强制刷新布局
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.list)
    self:scrollToIndex(scroll_dupId)

    self:refreshDupRedPoint()
end

function onSelectDupItem(self, dupConfigVo)
    -- if self.m_SelectDupId == dupConfigVo.id then
    --     return
    -- end

    self.m_SelectDupId = dupConfigVo.id
    GameDispatcher:dispatchEvent(EventName.CLOSE_BULLE_DUP_PANEL)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_DUP_PANEL, dupConfigVo)
end

function scrollToIndex(self, dup_id)
    -- self:setTimeout(0.1, function ()
    self:_scrollToIndex(dup_id)
    -- end)
end

function _scrollToIndex(self, dup_id)
    if self.mDupContentRect.rect.width < self.mScrollRectTran.rect.width then
        return
    end

    local itemGO = self.m_dupItemList[dup_id].m_go
    if itemGO then
        local itemRect = itemGO:GetComponent(ty.RectTransform)
        local anchoredPosition_x = itemRect.anchoredPosition.x
        local maxWidth = self.mDupContentRect.rect.width - gs.Screen.width
        if itemRect.anchoredPosition.x > maxWidth then
            anchoredPosition_x = maxWidth
        end

        self:KillScrollTweener()
        self.m_scrollTweener = gs.DT.DoTweenEx.DOProgressFloatVal(0, anchoredPosition_x, 0.2, function (val)
            self.mDupContentRect.anchoredPosition = gs.Vector2(val *- 1, self.mDupContentRect.anchoredPosition.y)
        end)
    end
end

function KillScrollTweener(self)
    if self.m_scrollTweener then
        self.m_scrollTweener:Kill()
        self.m_scrollTweener = nil
    end
end

function clearDupItemList(self)
    if self.m_dupItemList then
        for _, item in pairs(self.m_dupItemList) do
            item.data = nil
            item.select = nil
            item.unSelect = nil

            item:poolRecover()
        end
    end

    self.m_dupItemList = {}
end

function refreshAreaRedPoint(self)
    local areaConfig = bulle.BulleManager:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        local tabItem = self.m_tabItemList[areaId]
        if tabItem then
            if bulle.BulleManager:getAreaShowRed(areaConfigVo) then
                RedPointManager:add(tabItem:getTrans(), nil, 66, 11.7)
            else
                RedPointManager:remove(tabItem:getTrans())
            end
        end
    end
end

function refreshDupRedPoint(self)
    for i = 1, #self.m_areaConfig.stage_list do
        local dup_id = self.m_areaConfig.stage_list[i]
        local dupItem = self.m_dupItemList[dup_id]
        if dupItem then
            if bulle.BulleManager:getDupShowRed(dup_id) then
                RedPointManager:add(dupItem:getChildTrans("mRayPoint"), nil, 30,30)
            else
                RedPointManager:remove(dupItem:getChildTrans("mRayPoint"))
            end
        end
    end

    return false
end

function refreshStarAwardRedPoint(self)
    if bulle.BulleManager:getTaskRed() then
        RedPointManager:add(self.mBtnTask.transform, nil, 30,30)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end
    --self.ImEffect:SetActive(bulle.BulleManager:getStarAwardRedState())
end

return _M
