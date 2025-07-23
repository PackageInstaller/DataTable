module("cycle.CycleMapPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleMapPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("")
  
    self:setBg("cycle_bg_001.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mGroupItems = {}
    self.mLoopSn = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mCycleMapItemScroll = self:getChildGO("mCycleMapItemScroll"):GetComponent(ty.ScrollRect)
    self.mPreviewGroup = self:getChildTrans("mPreviewGroup")
    self.mEmptyGroup = self:getChildGO("mEmptyGroup")
end

function active(self)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_MAP_PANEL, self.onUpdateCycleMapPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_PREVIEW_PANEL, self.onOpenCyclePreviewPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_PREVIEW_PANEL, self.onEmptyClick, self)
    GameDispatcher:addEventListener(EventName.CHANGE_LAYER, self.changeLayer, self)
    MoneyManager:setMoneyTidList({})
    self.gBtnCloseAll:SetActive(false)
    self.mEmptyGroup:SetActive(false)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_MAP_PANEL, self.onUpdateCycleMapPanel, self)
    GameDispatcher:removeEventListener(EventName.OPEN_CYCLE_PREVIEW_PANEL, self.onOpenCyclePreviewPanel, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_CYCLE_PREVIEW_PANEL, self.onEmptyClick, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_LAYER, self.changeLayer, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:onEmptyClick()
    GameDispatcher:dispatchEvent(EventName.CHOOSE_EVENT, nil)
    self.mPreviewGroup.gameObject:SetActive(false)
    self:clearMapGroup()
    if self.mLoopSn then 
        LoopManager:removeFrameByIndex(self.mLoopSn)
        self.mLoopSn = nil
    end
end

function open(self)
    super.open(self)
    self:showPanel()
end

---变更关卡
function changeLayer(self)
    local line = cycle.CycleManager:getLineId()

    local function openMapPanel()
        self.mCycleMapItemScroll.horizontalNormalizedPosition = 0
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SHOW_LAYER_PANEL, {
        id = line,
        callback = openMapPanel
    })

end

function onUpdateCycleMapPanel(self)
    self:showPanel()
end

--- 打开详情页
function onOpenCyclePreviewPanel(self, args)
    if not args.isCloseTips then 
        if self.mCyclePreviewPanel == nil then
            self.mCyclePreviewPanel = cycle.CyclePreviewPanel.new()
        end
        self.mCyclePreviewPanel:show(args, self.mPreviewGroup)
    end
    self:moveToCellPos(args.rootTrans)
end

-- 移动cell到中间
function moveToCellPos(self, rootTrans, isCloseTip)
    local content = self.mCycleMapItemScroll.content
    local w, h = ScreenUtil:getScreenSize()
    local sizeX = content:GetComponent(ty.RectTransform).sizeDelta.x
    local targetX = 0
    if isCloseTip then 
        -- 挪到中间
        targetX = rootTrans.localPosition.x - (w * 0.5)
    else
        targetX = rootTrans.localPosition.x - (w * 0.25)
    end
    if targetX < 0 then 
        targetX = 0  
    elseif targetX + w > sizeX then 
        targetX = sizeX - w
    end
    if content.sizeDelta.x == 0 then 
        return
    end
    TweenFactory:move2LPosX(content, -targetX, 0.1, gs.DT.Ease.Linear, function() 
        gs.TransQuick:UIPosX(self.mCyclePreviewPanel.UITrans, 362 - rootTrans:InverseTransformPoint(self:getAdaptaTrans().position).x)
        if not isCloseTip then 
            self.mPreviewGroup.gameObject:SetActive(true)
        end
    end)
end

--点击空白处
function onEmptyClick(self)
    self.mPreviewGroup.gameObject:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.CHOOSE_EVENT, nil)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onUpdateTopPanel(self)
    self:showPanel()
end

function showPanel(self)
    local difficult = cycle.CycleManager:getCycleDifficult()
    local layer = cycle.CycleManager:getCurrentLayer()
    if difficult == 0 or layer == 0 then
        cusLog("关闭了Map界面")
        cusLog(difficult)
        cusLog(layer)
       self:close()
       return
    end

    if self.mLoopSn then 
        LoopManager:removeFrameByIndex(self.mLoopSn)
        self.mLoopSn = nil
    end
    self.mLoopSn = LoopManager:addFrame(2, 1, self, function()
        local nowTrans = cycle.CycleManager:getNowEventTrans()
        if nowTrans then 
            self:moveToCellPos(nowTrans, true)
        else
            self.mCycleMapItemScroll.content.localPosition = gs.Vector3.zero
        end
    end)
    cycle.CycleManager:setFightEnd(false)

    local lineData = cycle.CycleManager:getCurrentCycleLineData()
    if lineData == nil then 
        logError("缺少难度：", difficult, "层数：", layer, "的数据")
    end

    local row = lineData:getRow()
    local col = lineData:getCol()
    local cellData = lineData:getCellData()
    -- 生成地图格子 将会有多层嵌套
    self:clearMapGroup()
    for i = 1, col do
        local group = cycle.CycleGroupItem:poolGet()
        group:setData(self.mCycleMapItemScroll.content)
        table.insert(self.mGroupItems, group)
    end

    local rowDic = {}
    for k, v in pairs(cellData) do
        if rowDic[v.row] == nil then
            rowDic[v.row] = {v}
        else
            table.insert(rowDic[v.row], v)
        end
    end

    for i = 1, #self.mGroupItems do
        self.mGroupItems[i]:updateRowDic(i, rowDic[i])
    end

    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(lineData.name),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_CONTENT_PARENT, {
        parentTrans =  GameView.story,
        isShow = true
    })


    cycle.CycleManager:setGroupClassCopyData(self.mGroupItems)
    self:showCurrentCell()
end

-- 显示当前格子事件
function showCurrentCell(self)
    local currentCellId = cycle.CycleManager:getCurrentCell()
    cusLog("当前格子Id:" .. currentCellId)
    if currentCellId == 0 then
        return
    end

    local cellMsgVo = cycle.CycleManager:getCellDataById(currentCellId)
    local currentEventId = cellMsgVo.eventId
    cusLog("当前事件Id:" .. currentEventId)
    if currentEventId == 0 then
        return
    end

    local eventData = cycle.CycleManager:getCycleEventData(currentEventId)
    if eventData.eventType == EVENT_TYPE.FIGHT then
        if cellMsgVo.postwarArgs and #cellMsgVo.postwarArgs > 0 then
            -- 打开战后界面
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_POSTWAR_PANEL, {
                eventId = currentEventId
            })
        else
            self:onClickClose()
            -- 打开阵型界面
            formation.checkFormationFight(PreFightBattleType.Cycle, DupType.Cycle, cellMsgVo.normalArgs[1], formation.TYPE.CYCLE,
                nil, nil)
        end
    elseif eventData.eventType == EVENT_TYPE.SHOP then
        -- 打开商店面板
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SHOP_PANEL,{openType = OPEN_DEF_TYPE.SHOP })
    elseif eventData.eventType == EVENT_TYPE.RANDOM_RECRUIT then
        -- 打开招募战员
        cycle.CycleManager:setCurTicketAndType(cellMsgVo.normalArgs[1],RECUIT_TYPE.EVENT)
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SELECT_PANEL)
    else
        -- 打开事件面板
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_EVENT_PANEL, {
            cellId = currentCellId,
            eventId = currentEventId
        })
    end
end

function clearMapGroup(self)
    for i = 1, #self.mGroupItems do
        self.mGroupItems[i]:clearChildList()
        self.mGroupItems[i]:poolRecover()
    end
    self.mGroupItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
