-- @FileName:   PickGoldStageMainUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.pickGold.view.PickGoldStageMainUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("pickGold/PickGoldStageMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")

    self:setTxtTitle(_TT(151246))
end

function initData(self)

end
-- 设置货币栏
function setMoneyBar(self)

end
-- 初始化
function configUI(self)
    self.list = self:getChildTrans("list")
    self.mDupItem = self:getChildGO("mDupItem")

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.ScrollRect)
    self.mScrollRectTran = self:getChildGO("LyScroller"):GetComponent(ty.RectTransform)
    self.mDupContentRect = self:getChildGO("list"):GetComponent(ty.RectTransform)

    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mBtnRank = self:getChildGO("mBtnRank")

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnTask, 151210)
    self:setBtnLabel(self.mBtnRank, 151211)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnTask, self.onClickReward)
    self:addUIEvent(self.mBtnRank, self.onClickRank)

    self:addUIEvent(self.mBtnFuncTips, self.onClickTeaching)
end

--激活
function active(self, args)
    super.active(self, args)
    self:addAllEventListener()

    self:onSelectMapTab(1)

    self:onDataRefresh()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:removeAllEventListener()

    self:KillScrollTweener()

    self:clearDupItemList()
end

function close(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_PICKGOLD_DUPPANEL)

    super.close(self)
end

function addAllEventListener(self)
    GameDispatcher:addEventListener(EventName.ONCLOSE_PICKGOLD_DUPPANEL, self.onDupInfoPanelClose, self)
    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_SCENEUI, self.close, self)
    GameDispatcher:addEventListener(EventName.PICKGOLD_RECEIVE_REWARD, self.onDataRefresh, self)

end

function removeAllEventListener(self)
    GameDispatcher:removeEventListener(EventName.ONCLOSE_PICKGOLD_DUPPANEL, self.onDupInfoPanelClose, self)
    GameDispatcher:removeEventListener(EventName.OPEN_PICKGOLD_SCENEUI, self.close, self)
    GameDispatcher:removeEventListener(EventName.PICKGOLD_RECEIVE_REWARD, self.onDataRefresh, self)

end

function onClickTeaching(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_TEACHINGVIEW)
end

function onClickReward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_REWARDVIEW)
end

function onClickRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_RANKPANEL)
end

function onDataRefresh(self)
    self:refreshStarAwardRedPoint()
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

function onSelectMapTab(self, area_id)
    local areaConfigDic = pickGold.PickGoldManager:getAreaConfigDic()
    self.m_areaConfig = areaConfigDic[area_id]

    local scroll_dupId = self.m_areaConfig.stage_list[1]
    self:clearDupItemList()
    local length = #self.m_areaConfig.stage_list
    for i = 1, length do
        local dup_id = self.m_areaConfig.stage_list[i]

        local dupItem = SimpleInsItem:create(self.mDupItem, self.list, "pickGold_stageMainUI_dupItem")
        self.m_dupItemList[dup_id] = dupItem

        local configVo = pickGold.PickGoldManager:getDupConfigVo(dup_id)
        dupItem.data = configVo

        local Odd = (i % 2) == 1
        local mRayPoint = dupItem:getChildGO("mRayPoint"):GetComponent(ty.RectTransform)
        if Odd then
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, 95.6)
        else
            mRayPoint.anchoredPosition = gs.Vector2(mRayPoint.anchoredPosition.x, -78)
        end

        local isPass = pickGold.PickGoldManager:isPassDup(dup_id)
        dupItem:getChildGO("mImgPass"):SetActive(isPass)

        local isTimeOpen = configVo:isOpen()
        local lastPass = true
        if configVo.pre_id ~= 0 then
            lastPass = pickGold.PickGoldManager:isPassDup(configVo.pre_id)
        end

        if not isTimeOpen then
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(130002, configVo.begin_time.year, configVo.begin_time.month, configVo.begin_time.day)
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
        elseif not lastPass then
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = _TT(130008)
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
        elseif isTimeOpen and lastPass then
            dupItem:getChildGO("mTextTime"):GetComponent(ty.Text).text = configVo:getName()
            dupItem:getChildGO("mTextName"):GetComponent(ty.Text).text = ""
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

            StorageUtil:saveBool1(gstor.PICKGOLD_DUPNEWOPENSTR .. dup_id, true)
            self:refreshDupRedPoint()

            GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

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
    if self.m_SelectDupId == dupConfigVo.id then
        return
    end

    self.m_SelectDupId = dupConfigVo.id
    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_DUPPANEL, dupConfigVo)
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

function refreshDupRedPoint(self)
    for i = 1, #self.m_areaConfig.stage_list do
        local dup_id = self.m_areaConfig.stage_list[i]
        local dupItem = self.m_dupItemList[dup_id]
        if dupItem then
            if pickGold.PickGoldManager:getDupShowRed(pickGold.PickGoldManager:getDupConfigVo(dup_id)) then
                RedPointManager:add(dupItem:getChildTrans("mRayPoint"), nil, 110, 12)
            else
                RedPointManager:remove(dupItem:getChildTrans("mRayPoint"))
            end
        end
    end
end

function refreshStarAwardRedPoint(self)
    if pickGold.PickGoldManager:getStarRewardRedState() then
        RedPointManager:add(self.mBtnTask.transform, nil, 30, 30)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end
end

return _M
