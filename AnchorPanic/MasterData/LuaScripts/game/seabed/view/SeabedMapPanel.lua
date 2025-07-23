module("seabed.SeabedMapPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedMapPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 1 --是否显示全屏纯黑防穿帮底图
isScreensave = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(111017))

    -- self:setBg("seabed_main.jpg", false, "seabed")
end

-- 析构
function dtor(self)
end

function getAdaptaTrans(self)
    return self:getChildTrans("adaptaContent")
end

function initData(self)
    self.mMapList = {}
    self.mLineList = {}

    self.mEventList = {}

    self.mShowBuffList = {}

    self.mAniList = {}
    self.mShowBuffAniList = {}

    self.mAniTime = 0.1
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLineContent = self:getChildTrans("mLineContent")
    self.mLineItem = self:getChildGO("mLineItem")
    self.mLineItem_main = self:getChildGO("mLineItem_main")

    self.mMapContent = self:getChildTrans("mMapContent")
    self.mMapContentImg = self.mMapContent:GetComponent(ty.AutoRefImage)
    self.mRotateContent = self:getChildTrans("mRotateContent")

    self.mMapItem = self:getChildGO("mMapItem")
    self.mMapBossItem = self:getChildGO("mMapBossItem")

    self.mBtnBuff = self:getChildGO("mBtnBuff")
    self.mTxtBuff = self:getChildGO("mTxtBuff"):GetComponent(ty.Text)
    self.mTxtBuffNum = self:getChildGO("mTxtBuffNum"):GetComponent(ty.Text)

    self.mBtnColl = self:getChildGO("mBtnColl")
    self.mTxtColl = self:getChildGO("mTxtColl"):GetComponent(ty.Text)
    self.mTxtCollNum = self:getChildGO("mTxtCollNum"):GetComponent(ty.Text)

    self.mBtnFormation = self:getChildGO("mBtnFormation")

    self.mEventInfo = self:getChildGO("mEventInfo")
    self.mBtnHideEventInfo = self:getChildGO("mBtnHideEventInfo")
    self.mTxtEventName = self:getChildGO("mTxtEventName"):GetComponent(ty.Text)
    self.mImgEventIcon = self:getChildGO("mImgEventIcon"):GetComponent(ty.AutoRefImage)
    self.mEventDesScroll = self:getChildGO("mEventDesScroll"):GetComponent(ty.ScrollRect)
    self.mTxtEventDes = self:getChildGO("mTxtEventDes"):GetComponent(ty.Text)
    self.mEventContent = self:getChildTrans("mEventContent")
    self.mEventItem = self:getChildGO("mEventItem")

    self.mTipsInfo = self:getChildGO("mTipsInfo")
    self.mBtnHideTipsInfo = self:getChildGO("mBtnHideTipsInfo")

    self.mShowBuffInfo = self:getChildGO("mShowBuffInfo")
    self.mBtnHideShowBuff = self:getChildGO("mBtnHideShowBuff")
    self.mTxtShowBuff = self:getChildGO("mTxtShowBuff"):GetComponent(ty.Text)
    self.mShowBuffScroll = self:getChildGO("mShowBuffScroll"):GetComponent(ty.ScrollRect)

    self.mShowCollectionInfo = self:getChildGO("mShowCollectionInfo")
    self.mBtnHideShowCollection = self:getChildGO("mBtnHideShowCollection")
    self.mTxtShowCollection = self:getChildGO("mTxtShowCollection"):GetComponent(ty.Text)
    self.mShowCollectionScroll = self:getChildGO("mShowCollectionScroll"):GetComponent(ty.ScrollRect)

    self.mBuffItem = self:getChildGO("mBuffItem")
    self.mBtnMask = self:getChildGO("mBtnMask")

    self:setGuideTrans("functips_seabed_function_buff", self:getChildTrans("mBtnBuff"))
    self:setGuideTrans("functips_seabed_function_coll", self:getChildTrans("mBtnColl"))
    self:setGuideTrans("functips_seabed_function_formation", self:getChildTrans("mBtnFormation"))
    self:setGuideTrans("functips_seabed_function_eventContent", self:getChildTrans("mEventContent"))
    self:setGuideTrans("functips_seabed_function_action", self:getChildTrans("mFunctionAction"))
    self:setGuideTrans("functips_seabed_function_coin", self:getChildTrans("mFunctionCoin"))
end

function onClickClose(self)
    -- super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
end

function active(self)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_SEABED_TOP_PANEL)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_MAP_PANEL, self.showPanel, self)

    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_BUFF_OPT, self.updateBufOpt, self)
    gs.CameraMgr:SetUICameraProjetion(false, 1)
    gs.CameraMgr:GetUICamera().farClipPlane = 1000

    --LoopManager:setTimeout(1,self,function ()
    --    self:showPanel()
    --end)
    
end

function open(self)
    super.open(self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_MAP_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_BUFF_OPT, self.updateBufOpt, self)
    gs.CameraMgr:SetUICameraProjetion(true, 1)
    gs.CameraMgr:GetUICamera().farClipPlane = 100
    self:clearAniList()
    self:clearShowBuffAniList()
    self:clearEventList()
    self:clearLineList()
    self:clearMapItemList()
    self:clearShowBuffList()
    if self.mTxtTime then
        self:removeTimerByIndex(self.mTxtTime)
        self.mTxtTime = nil
    end


    -- GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)

end

function clearAniList(self)
    for i = 1, #self.mAniList do
        LoopManager:clearTimeout(self.mAniList[i])
    end
    self.mAniList = {}
end

function clearShowBuffAniList(self)
    for i = 1, #self.mShowBuffAniList do
        LoopManager:clearTimeout(self.mShowBuffAniList[i])
    end
    self.mShowBuffAniList = {}
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtBuff.text = _TT(111043)
    self.mTxtColl.text = _TT(111044)
    self:getChildGO("mTxtTips"):GetComponent(ty.Text).text = _TT(111045)

end

function onBtnHideTipsClickHandler(self)
    self.mTipsInfo:SetActive(false)
end

function onBtnHideEventInfoClickHandler(self)
    self:clearEventList()
    self.mEventInfo:SetActive(false)
    if self.mTxtTime then
        self:removeTimerByIndex(self.mTxtTime)
        self.mTxtTime = nil
    end
end

function onBtnHideShowBuffClickHandler(self)
    self.mShowBuffInfo:SetActive(false)
    self:clearShowBuffList()
end

function onBtnBuffClickHandler(self)
    local buffList = seabed.SeabedManager:getCurBuffList()
    if #buffList == 0 then
        gs.Message.Show(_TT(111046))
        return
    end

    self.mTxtShowBuff.text = _TT(111047) .. #buffList
    self:clearShowBuffList()
    for i = 1, #buffList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowBuffScroll.content, "mSeabedBuffItemBuff")
        local vo = seabed.SeabedManager:getSeabedBuffDataById(buffList[i])
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath("seabed/color_0" .. vo.color .. ".png"), false)
        local timeSn = LoopManager:setTimeout(i * 0.03, self, function()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)
        table.insert(self.mShowBuffAniList, timeSn)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowBuffInfo:SetActive(true)
end

function onBtnCollClickHandler(self)
    local collectionList = seabed.SeabedManager:getCurCollectionList()
    if #collectionList == 0 then
        gs.Message.Show(_TT(111048))
        return
    end

    self.mTxtShowCollection.text = _TT(111049) .. #collectionList
    self:clearShowBuffList()
    for i = 1, #collectionList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowCollectionScroll.content, "mSeabedBuffItemColl")
        local vo = seabed.SeabedManager:getSeabedCollectionDataById(collectionList[i])
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath("seabed/color_0" .. vo.color .. ".png"), false)
        local timeSn = LoopManager:setTimeout(i * 0.03, self, function()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)
        table.insert(self.mShowBuffAniList, timeSn)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowCollectionInfo:SetActive(true)
end

function clearShowBuffList(self)

    self:clearShowBuffAniList()

    for i = 1, #self.mShowBuffList, 1 do
        self.mShowBuffList[i]:poolRecover()
    end
    self.mShowBuffList = {}
end

function onBtnHideShowCollectionClickHandler(self)
    self.mShowCollectionInfo:SetActive(false)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFormation, self.onBtnFormationClickHandler)
    self:addUIEvent(self.mBtnHideEventInfo, self.onBtnHideEventInfoClickHandler)
    self:addUIEvent(self.mBtnColl, self.onBtnCollClickHandler)
    self:addUIEvent(self.mBtnHideShowCollection, self.onBtnHideShowCollectionClickHandler)

    self:addUIEvent(self.mBtnBuff, self.onBtnBuffClickHandler)
    self:addUIEvent(self.mBtnHideShowBuff, self.onBtnHideShowBuffClickHandler)
    self:addUIEvent(self.mBtnHideTipsInfo, self.onBtnHideTipsClickHandler)
    self:addUIEvent(self.mBtnMask, self.onBtnMaskClickHandler)
end

function onBtnFormationClickHandler(self)
    seabed.SeabedManager:setIsDefFormation(false)
    formation.checkFormationFight(PreFightBattleType.Seabed, DupType.Seaded, nil, formation.TYPE.SEABED, nil, nil)
end

function updateBufOpt(self)
    self.mTxtBuffNum.text = #seabed.SeabedManager:getCurBuffList()
    self.mTxtCollNum.text = #seabed.SeabedManager:getCurCollectionList()
end

function showPanel(self)
    local hasData = seabed.SeabedManager:getSeabedHasSettleData()
    if hasData then
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SETTPANEL)
        return
    end

    self.isFirstShowMap = seabed.SeabedManager:getIsFirstShowMap()
    self.mEventInfo:SetActive(false)
    self:updateBufOpt()

    self.curId = seabed.SeabedManager:getCurCellId()
    self.lineVo = seabed.SeabedManager:getCurSeabedLineData()

    print("当前线段id：" .. self.lineVo.id)
    self.mMapContentImg:SetImg(UrlManager:getBgPath(self.lineVo.backGround), true)

    self:clearLineList()
    self:clearMapItemList()

    local canClickIds = seabed.SeabedManager:getCanClickCell()
    self.cellDic = self.lineVo:getAllCell()
    for id, cellVo in pairs(self.cellDic) do
        local isEnd = table.indexof01(self.lineVo.endCell, id) > 0
        local item
        if isEnd then
            item = SimpleInsItem:create(self.mMapBossItem, self.mRotateContent, "mSeabedMapBossItem")
        else
            item = SimpleInsItem:create(self.mMapItem, self.mRotateContent, "mSeabedMapItem")
        end

        item.m_go.gameObject:SetActive(false)

        gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), cellVo.rowNum, cellVo.colNum)

        local msgData = seabed.SeabedManager:getMsgCellDataById(id)
        local eventVo = seabed.SeabedManager:getSeabedEventDataById(msgData.event_id)

        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(eventVo.eventIcon),
            false)

        item:getChildGO("mImgSelect"):SetActive(self.curId == id)

        local isEnd = table.indexof01(self.lineVo.endCell, id) > 0
        item:getChildGO("mImgEnd"):SetActive(isEnd)

        local isPass = seabed.SeabedManager:getCellIsPass(id)
        local curNotEvent = self.curId == 0 or self.curId == id

        local isCanClick = table.indexof01(canClickIds, id) > 0 and isPass == false and curNotEvent
        item:getChildGO("mImgNotClick"):SetActive(not isCanClick)

        item:getChildGO("mIsCanClick"):SetActive(isCanClick)

        if isCanClick == false and isPass == false and isEnd == false then
            gs.TransQuick:Scale(item.m_go:GetComponent(ty.RectTransform), 0.7, 0.7, 0.7)
        else
            gs.TransQuick:Scale(item.m_go:GetComponent(ty.RectTransform), 1, 1, 1)
        end

        item:getChildGO("mImgPass"):SetActive(isPass)
        if isPass or isCanClick then
            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(eventVo.iconName)
        else
            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(121196)
        end

        item:getChildGO("mTxtDebug"):GetComponent(ty.Text).text = "格子id:" .. id .. " 事件id:" .. msgData.event_id
        item:getChildGO("mTxtDebug"):SetActive(seabed.SeabedManager:getIsDebug())

        if self.isFirstShowMap then
            local timeSn = LoopManager:setTimeout(cellVo.aniIndex * self.mAniTime, self, function()
                item.m_go.gameObject:SetActive(true)
                item.m_go:GetComponent(ty.Animator):SetTrigger("show")
            end)
            table.insert(self.mAniList, timeSn)
        else
            item.m_go.gameObject:SetActive(true)
        end

        self:setGuideTrans("functips_seabed_mapItem_" .. id, item:getChildTrans("mBtnClick"))

        item:addUIEvent("mBtnClick", function()
            if isCanClick then
                self:onClickMapItem(id)
            else
                gs.Message.Show(_TT(111050))
            end
        end)

        if #cellVo.nextIds > 0 then
            for i = 1, #cellVo.nextIds do
                self:drawLineItem(id, cellVo.nextIds[i], cellVo.aniIndex)
            end
        end

        table.insert(self.mMapList, item)
    end

    self.mTipsInfo:SetActive(seabed.SeabedManager:getNeedShowTips())
    if seabed.SeabedManager:getNeedShowTips() then
        seabed.SeabedManager:setFirstShowTips(true)
    end

    local function call()
        if self.curId ~= 0 then
            self:onClickMapItem(self.curId)
        end
    end

    local lastCellId = seabed.SeabedManager:getLastCellId()
    if lastCellId == 0 then
        lastCellId = 1
    end
    local screenW, screenH = ScreenUtil:getScreenSize()

    local lastCellVo = self.lineVo:getSingleCellData(lastCellId)
    local h = lastCellVo.rowNum
    local w = lastCellVo.colNum

    local needX = gs.Mathf.Clamp(h - screenW / 2, 0, self.lineVo.long)
    local needY = gs.Mathf.Clamp(w - screenH / 2, 0, self.lineVo.wide)
    gs.TransQuick:UIPos(self.mMapContent:GetComponent(ty.RectTransform), -needX, -needY)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    --self:setTimeout(0.1, function()
        seabed.SeabedManager:getTodoSomeEvent(call)
    --end)
end

function onClickMapItem(self, id)
    local function clickCall()
        self.mEventInfo:SetActive(true)

        local msgData = seabed.SeabedManager:getMsgCellDataById(id)
        local eventVo = seabed.SeabedManager:getSeabedEventDataById(msgData.event_id)

        self.mTxtEventName.text = _TT(eventVo.eventTitle)
        self.mImgEventIcon:SetImg(UrlManager:getIconPath(eventVo.eventIcon), false)
        self:clearEventList()
        self:writeString(_TT(eventVo.eventDes), id, msgData.option_args)
    end
    local cellVo = self.lineVo:getSingleCellData(id)
    if seabed.SeabedManager:getIsFirstBranchCell() and cellVo.isMain == 0 then
        UIFactory:alertMessge(_TT(121197), true, function()
            clickCall()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        clickCall()
    end

end

function onBtnMaskClickHandler(self)
    if self.mTxtTime then
        self:removeTimerByIndex(self.mTxtTime)
        self:finishCall(self.needId, self.needArgs, self.needDes)
    end
end

function writeString(self, des, id, args)
    local charLength = string.toCharArray(des)

    self.needId = id
    self.needArgs = args
    self.needDes = des

    self.mBtnMask:SetActive(true)
    if next(charLength) then
        local charIndex = 1
        local strLen = table.getn(charLength)
        local str = charLength[charIndex]
        self.mTxtEventDes.text = str
        local time = sysParam.SysParamManager:getValue(78) / 1000
        self.mTxtTime = self:addTimer(time, 0, function()
            charIndex = charIndex + 1
            if charIndex <= strLen then
                str = str .. charLength[charIndex]
                self.mTxtEventDes.text = str
                gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mEventDesScroll.transform)
                self.mEventDesScroll.verticalNormalizedPosition = 0
            else
                self:removeTimerByIndex(self.mTxtTime)
                self:finishCall(id, args, des)
            end
        end)
    end
end

function finishCall(self, id, args, des)
    self.mBtnMask:SetActive(false)
    self.mTxtEventDes.text = des
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mEventDesScroll.transform)
    self:setTimeout(0.1, function()
        self.mEventDesScroll.verticalNormalizedPosition = 0
    end)

    local optArgs = args
    for i = 1, #optArgs do
        local childEventVo = seabed.SeabedManager:getSeabedEventDataById(optArgs[i])
        local item = SimpleInsItem:create(self.mEventItem, self.mEventContent, "mSeabedEventItem")
        item:getChildGO("mTxtEvent"):GetComponent(ty.Text).text = _TT(childEventVo.btnTitle)
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(childEventVo.btnDes)
        item:getChildGO("mTxtEventCostCount"):GetComponent(ty.Text).text = 
            childEventVo.needActionPoint + seabed.SeabedManager:getExtraActionPoint()

        item:getChildGO("mTxtDebug"):GetComponent(ty.Text).text = "子事件id:" .. optArgs[i]
        item:getChildGO("mTxtDebug"):SetActive(seabed.SeabedManager:getIsDebug())

        item.isSelect = false
        item:getChildGO("mImgSure"):SetActive(false)

        item:addUIEvent("mBtnClick", function()
            self:onClickEventItem(i, optArgs[i], id)
        end)
        table.insert(self.mEventList, item)
    end
end

function onClickEventItem(self, index, id, cellId)
    local item = self.mEventList[index]
    if item.isSelect then
        if seabed.SeabedManager:getIsDebug() then
            gs.Message.Show("确认某个事件 cellId:" .. cellId .. " 事件Id:" .. id)
        end

        local newRunPoint, newCoin = seabed.SeabedManager:getSeabedResource()
        local eventVo = seabed.SeabedManager:getSeabedEventDataById(id)
        if newCoin < math.abs(eventVo.costCoin) then
            gs.Message.Show(_TT(111145))
            return
        end

        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_EVENT, {
            cellId = cellId,
            eventId = id
        })
        return
    end

    for i = 1, #self.mEventList, 1 do
        local item = self.mEventList[i]
        item:getChildGO("mImgSure"):SetActive(i == index)
        item.isSelect = i == index
    end
end

function clearEventList(self)
    for i = 1, #self.mEventList, 1 do
        self.mEventList[i]:poolRecover()
    end
    self.mEventList = {}
end

function drawLineItem(self, startId, endId, aniIndex)

    local startVo = self.lineVo:getSingleCellData(startId)
    local endVo = self.lineVo:getSingleCellData(endId)
    local isMain = endVo.isMain == 1

    local item
    if isMain then
        item = SimpleInsItem:create(self.mLineItem_main, self.mLineContent, "mSeabeLineItem_main")
    else
        item = SimpleInsItem:create(self.mLineItem, self.mLineContent, "mSeabeLineItem")
    end

    item:getGo():SetActive(false)
    local lastId = seabed.SeabedManager:getLastCellId()
    local isPass = seabed.SeabedManager:getCellIsPass(endId)

    local isCanClick = lastId == startId and endId and isPass == false and self.curId == 0

    if isCanClick then
        item:getGo():GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffffff")
    else
        item:getGo():GetComponent(ty.Image).color = gs.ColorUtil.GetColor("b2b2b2ff")
    end

    gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), startVo.rowNum, startVo.colNum)

    local w = gs.Vector3.Distance(gs.Vector3(startVo.rowNum, startVo.colNum, 0),
        gs.Vector3(endVo.rowNum, endVo.colNum, 0))
    gs.TransQuick:SizeDelta01(item:getGo():GetComponent(ty.RectTransform), w)

    gs.TransQuick:SetLRotation(item:getGo():GetComponent(ty.RectTransform), 0, 0,
        self:getAngle(startVo.rowNum, startVo.colNum, endVo.rowNum, endVo.colNum))

    if self.isFirstShowMap then
        local timeSn = LoopManager:setTimeout(aniIndex * self.mAniTime, self, function()
            item:getGo():SetActive(true)
            item:getGo():GetComponent(ty.Animator):SetTrigger("show")
        end)
        table.insert(self.mAniList, timeSn)
    else
        item:getGo():SetActive(true)
    end

    table.insert(self.mLineList, item)
end

function clearMapItemList(self)
    for i = 1, #self.mMapList do
        self.mMapList[i]:poolRecover()
    end
    self.mMapList = {}
end

function clearLineList(self)
    for i = 1, #self.mLineList do
        self.mLineList[i]:poolRecover()
    end
    self.mLineList = {}
end

function getAngle(self, x1, y1, x2, y2)
    return gs.Mathf.Atan2(y2 - y1, x2 - x1) * 180 / 3.14
end

return _M
