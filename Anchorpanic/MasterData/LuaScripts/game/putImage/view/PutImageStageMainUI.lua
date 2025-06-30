-- @FileName:   PutImageStageMainUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.putImage.view.PutImageStageMainUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("putImage/PutImageStageMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")

    self:setTxtTitle(_TT(138901))
end

function initData(self)

end
-- 设置货币栏
function setMoneyBar(self)
end
-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)

    self.mItemTab = self:getChildGO("mItemTab")
    self.mTabGroup = self:getChildTrans("mTabGroup")

    self.list = self:getChildTrans("list")
    self.mDupItem = self:getChildGO("mDupItem")

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.ScrollRect)
    self.mScrollRectTran = self:getChildGO("LyScroller"):GetComponent(ty.RectTransform)
    self.mDupContentRect = self:getChildGO("list"):GetComponent(ty.RectTransform)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

--激活
function active(self, args)
    super.active(self, args)
    self:addAllEventListener()

    self:creatTabList()
    self:refreshAreaRedPoint()
    -- local area_id = args.area_id
    -- if area_id then
    --     local areaConfig = putImage.PutImageManager:getAreaConfig(area_id)
    --     if not areaConfig:isOpen() then
    --         area_id = 1
    --     end

    --     local lastArea = area_id - 1
    --     if lastArea > 0 then
    --         if not putImage.PutImageManager:isPassArea(lastArea) then
    --             area_id = 1
    --         end
    --     end
    -- else
    local areaConfigDic = putImage.PutImageManager:getAreaConfigDic()
    for i = 1, #areaConfigDic do
        local timeOpen = areaConfigDic[i]:isOpen()
        local lastOpen = true
        if i > 1 then
            lastOpen = putImage.PutImageManager:isPassArea(areaConfigDic[i - 1].id)
        end

        if lastOpen and timeOpen then
            area_id = areaConfigDic[i].id
        end
    end
    -- end

    self:selectMapTab(area_id)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.m_select_areaId = nil

    self:removeAllEventListener()

    self:KillScrollTweener()

    self:clearDupItemList()
    self:clearTabItem()

    GameDispatcher:dispatchEvent(EventName.CLOSE_PUTIMAGE_DUPINFOPANEL)
end

function addAllEventListener(self)
    GameDispatcher:addEventListener(EventName.CLOSE_PUTIMAGE_DUPINFOPANEL_HANDLER, self.onDupInfoPanelClose, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_PUTIMAGE_SCENEUI, self.close, self)

end

function removeAllEventListener(self)
    GameDispatcher:removeEventListener(EventName.CLOSE_PUTIMAGE_DUPINFOPANEL_HANDLER, self.onDupInfoPanelClose, self)
    -- GameDispatcher:removeEventListener(EventName.OPEN_PUTIMAGE_SCENEUI, self.close, self)

end

function onDupInfoPanelClose(self)
    if not self.m_dupItemList then
        return
    end

    for _, item in pairs(self.m_dupItemList) do
        item:unSelect()
    end
end

function creatTabList(self)
    local areaConfigDic = putImage.PutImageManager:getAreaConfigDic()
    table.sort(areaConfigDic, function (a, b)
        return a.id < b.id
    end)

    self:clearTabItem()
    for i = 1, #areaConfigDic do
        local tabItem = SimpleInsItem:create(self.mItemTab, self.mTabGroup, "PutImage_stageMainUI_tabItem")
        self.m_tabItemList[i] = tabItem

        tabItem.data = areaConfigDic[i]

        tabItem:getChildGO("mTextLabel"):GetComponent(ty.Text).text = areaConfigDic[i]:getName()
        tabItem:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = areaConfigDic[i]:getName()

        local timeOpen = areaConfigDic[i]:isOpen()
        local lastOpen = true
        if i > 1 then
            lastOpen = putImage.PutImageManager:isPassArea(areaConfigDic[i - 1].id)
        end

        if timeOpen and lastOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = ""
        elseif not timeOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(130002, areaConfigDic[i].begin_time.year, areaConfigDic[i].begin_time.month, areaConfigDic[i].begin_time.day)
        elseif not lastOpen then
            tabItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(4620)
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

            _item:getChildGO("mImgSelect"):SetActive(true)

            self:onSelectMapTab(_item.data.id)
        end

        tabItem.unSelect = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(false)
        end
    end
end

function clearTabItem(self)
    if self.m_tabItemList then
        for k, item in pairs(self.m_tabItemList) do
            item:poolRecover()
        end
    end

    self.m_tabItemList = {}
end

function selectMapTab(self, area_id)
    for _, item in pairs(self.m_tabItemList) do
        if item.data.id == area_id then
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

    local areaConfigDic = putImage.PutImageManager:getAreaConfigDic()
    self.m_areaConfig = areaConfigDic[self.m_select_areaId]

    local scroll_dupId = self.m_areaConfig.stage_list[1]
    self:clearDupItemList()
    local length = #self.m_areaConfig.stage_list
    for i = 1, length do
        local dup_id = self.m_areaConfig.stage_list[i]

        local dupItem = SimpleInsItem:create(self.mDupItem, self.list, "PutImage_stageMainUI_dupItem")
        self.m_dupItemList[dup_id] = dupItem

        local configVo = putImage.PutImageManager:getDupConfigVo(dup_id)
        dupItem.data = configVo

        local mRayPoint = dupItem:getChildGO("mRayPoint"):GetComponent(ty.RectTransform)
        if (i % 2) == 1 then
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, 105)
        else
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, -10)
        end

        dupItem:getChildGO("mImgPass"):SetActive(putImage.PutImageManager:isPassDup(self.m_areaConfig.stage_list[i]))
        dupItem:getChildGO("mImgItemBg"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/putImage/putImage_%02d.png", self.m_select_areaId + 2))

        local isTimeOpen = configVo:isOpen()
        local lastPass = true
        if configVo.pre_id ~= 0 then
            lastPass = putImage.PutImageManager:isPassDup(configVo.pre_id)
        end

        dupItem:getChildGO("mLock"):SetActive(not isTimeOpen or not lastPass)
        if not isTimeOpen then
            dupItem:getChildGO("mTextLockTips"):GetComponent(ty.Text).text = _TT(130002, configVo.begin_time.year, configVo.begin_time.month, configVo.begin_time.day)
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
        elseif not lastPass then
            dupItem:getChildGO("mTextLockTips"):GetComponent(ty.Text).text = _TT(130008)
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
        elseif isTimeOpen and lastPass then
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = configVo:getName()
        end

        if isTimeOpen and lastPass then
            scroll_dupId = self.m_areaConfig.stage_list[i]
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

            StorageUtil:saveBool1(gstor.PUTIMAGE_DUPNEWOPENSTR .. dup_id, true)
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

    self.mImgBg:SetImg(string.format("arts/ui/bg/putImage/putImage_PnlBg_%02d.jpg", area_id))

    ---强制刷新布局
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.list)

    self:scrollToIndex(scroll_dupId)

    self:refreshDupRedPoint()
end

function onSelectDupItem(self, dupConfigVo)
    GameDispatcher:dispatchEvent(EventName.OPEN_PUTIMAGE_DUPINFOPANEL, {dupVo = dupConfigVo, area_id = self.m_select_areaId})
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
        local horizontalNormalizedPosition = (itemRect.anchoredPosition.x - (itemRect.rect.width / 2)) / self.mDupContentRect.rect.width

        self:KillScrollTweener()
        self.m_scrollTweener = gs.DT.DoTweenEx.DOProgressFloatVal(0, horizontalNormalizedPosition, 0.2, function (val)
            self.mLyScroller.horizontalNormalizedPosition = val
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
            item:poolRecover()
        end
    end

    self.m_dupItemList = {}
end

function refreshAreaRedPoint(self)
    local redAreaId = putImage.PutImageManager:isShowAreaRed()
    for areaId, tabItem in pairs(self.m_tabItemList) do
        if redAreaId == areaId then
            RedPointManager:add(tabItem:getTrans(), nil, 75, 13)
        else
            RedPointManager:remove(tabItem:getTrans())
        end
    end
end

function refreshDupRedPoint(self)
    for i = 1, #self.m_areaConfig.stage_list do
        local dup_id = self.m_areaConfig.stage_list[i]
        local dupItem = self.m_dupItemList[dup_id]
        if dupItem then
            local dupConfigVo = putImage.PutImageManager:getDupConfigVo(dup_id)
            if putImage.PutImageManager:getDupShowRed(dupConfigVo) then
                RedPointManager:add(dupItem:getChildTrans("mRayPoint"), nil, 73.3, -19.3)
            else
                RedPointManager:remove(dupItem:getChildTrans("mRayPoint"))
            end
        end
    end

    return false
end

return _M
