module("rogueLike.RogueLikeMapItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeMapItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mData = nil
end

function configUI(self)
    super.configUI(self)

    self.mEventQuality = self:getChildGO("mEventQuality"):GetComponent(ty.AutoRefImage)
    self.mEventIcon = self:getChildGO("mEventIcon"):GetComponent(ty.AutoRefImage)
    self.mEventName = self:getChildGO("mEventName"):GetComponent(ty.Text)
    self.mEventLock = self:getChildGO("mEventLock")
    self.mEventComplete = self:getChildGO("mEventComplete")
    self.mEventCurrent = self:getChildGO("mEventCurrent")
    self.mBuffIcon = self:getChildGO("mBuffIcon"):GetComponent(ty.AutoRefImage)
    self.mBuffName = self:getChildGO("mBuffName"):GetComponent(ty.Text)

    self.mEventBuffGet = self:getChildGO("mEventBuffGet")
    self.mBtn = self.UIObject
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_CLOSE_VIEW, self.onOpenClose, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.OPEN_ROGUELIKE_CLOSE_VIEW, self.onOpenClose, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtn, self.onBtnClick)
end

function onOpenClose(self, cellId)
    if self.mData.cell_id == cellId then
        self:onBtnClick()
    end
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    self:updateView()
end

-- 获取当前地图是否当前地图
function getIsCurrentMap(self)
    self.isCurrentMap = rogueLike.RogueLikeManager:getMapIsCurrent(self.mData.cell_id)
end

-- 获取当前地图是否已经通过
function getIsPass(self)
    self.isPassMap = rogueLike.RogueLikeManager:getMapIsPass(self.mData.cell_id)
end

function getIsWalk(self)
    local currentCol = rogueLike.RogueLikeManager:getRogueLikeCol()
    self.isWalk = self.col <= currentCol
end

-- 获取当前地图连线规则
function getMapRule(self)
    -- rule 1 向上  
    -- rule 2 向下
    self.rule = rogueLike.RogueLikeManager:getRogueMapRule(self.mData.cell_id)
end

-- 获取自身格子的行列
function getMapColRow(self)
    self.col, self.row = rogueLike.RogueLikeManager:getRogueMapColRow(self.mData.cell_id)
end

function getLinkNum(self)
    self.linkNum = rogueLike.RogueLikeManager:getLinkNum(self.mData.cell_id)
end

-- 获取最后连接的格子编号
function getLastLikeNum(self)
    self.lastLinkNum = rogueLike.RogueLikeManager:getLastMapIsLinkNum(self.mData.cell_id)
end

-- 获取格子是否是最后经过的
function getMapIsLast(self)
    self.isLastMap = rogueLike.RogueLikeManager:getIsLast(self.mData.cell_id)
end

function getMapChildRule(self)
    self.childRule = rogueLike.RogueLikeManager:getRogueMapChildRule(self.mData.cell_id)
end

function getCustomMapData(self)
    self:getMapChildRule()
    self:getLastLikeNum()
    self:getMapRule()
    self:getLinkNum()
    self:getMapColRow()
    self:getIsCurrentMap()
    self:getIsPass()
    self:getMapIsLast()
    self:getIsWalk()
end

function updateView(self)
    self:getCustomMapData()

    -- self.mEventCurrent:SetActive(self.isCurrentMap)
    self.mEventComplete:SetActive(self.isPassMap)

    -- self.mTxtId.text = self.col .. "|" .. self.row .. " id:" .. self.mData.cell_id
    self.mBuffName.text = ""
    local eventType = rogueLike.RogueLikeManager:getRogueLikeEventData(self.mData.event_id).eventType

    local currentCol = rogueLike.RogueLikeManager:getRogueLikeCol()

    if eventType == rogueLike.EventType.Fight then
        self.mEventName.text = "战斗"
        local infoId = 0
        for k, v in ipairs(self.mData.args) do
            infoId = v.key
        end
        local infoVo = rogueLike.RogueLikeManager:getRogueLikeDupData(infoId)
        if infoVo ~= nil then
            -- infoVo.mBuffType
            self.mBuffName.text = rogueLike.RogueLikeConst:getBuffTypeName(infoVo.mBuffType)
            -- self.mTxtGetBuff.text = "品质:" .. infoVo.mColor .. "类型:" .. infoVo.mBuffType
        end
    elseif eventType == rogueLike.EventType.BuffSelect then
        self.mEventName.text = "BUFF选择"
    elseif eventType == rogueLike.EventType.Recover then
        self.mEventName.text = "恢复事件"
    elseif eventType == rogueLike.EventType.Shop then
        self.mEventName.text = "交易区"
    elseif eventType == rogueLike.EventType.Special then
        self.mEventName.text = "特殊事件"
    end

    self.canWalk = rogueLike.RogueLikeManager:getCanWalk(self.mData.cell_id)
    if self.canWalk then
        self.mEventLock:SetActive(false)
    else
        self.mEventLock:SetActive(true)
    end

    if self.canWalk and self.col <= currentCol and eventType == rogueLike.EventType.Fight then
        self.mEventBuffGet:SetActive(true)
    else
        self.mEventBuffGet:SetActive(false)
    end

    self.mEventCurrent:SetActive(self.col == currentCol and self.canWalk)
    local eventColor = rogueLike.RogueLikeManager:getRogueLikeEventData(self.mData.event_id).eventColor

    self.mEventQuality.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(eventColor))

    self.mEventIcon.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(eventColor))
    self.mEventIcon:SetImg(UrlManager:getRogueLikeMapIcon(eventType), true)

    if self.col == 6 then
        self.mEventBuffGet:SetActive(false)
        self.mEventIcon:SetImg(UrlManager:getRogueLikeMapIcon(rogueLike.EventType.Boss), true)
    end
 
end

function getCanWalk(self)
    return self.canWalk
end

function getIsLasMap(self)
    return self.isLastMap
end

function canRun(self)
    local currentCol = rogueLike.RogueLikeManager:getRogueLikeCol()
    local lastMapCol, lastMapRow = rogueLike.RogueLikeManager:getLastMapColRow()
    local run = false
    -- 当前列数对应 或者还未选择的情况
    if self.col == 1 and currentCol == self.col then
        run = true
    else
        if self.rule == 1 then
            if self.col == currentCol and self.row >= lastMapRow and self.row <= lastMapRow + 1 then
                run = true
            end
        else
            if self.col == currentCol and self.row >= lastMapRow - 1 and self.row <= lastMapRow then
                run = true
            end
        end
    end

    if self.lastLinkNum == self.mData.cell_id then
        run = true
    end

    return run
end

function onBtnClick(self)
    local currentSelectCellId = rogueLike.RogueLikeManager:getCurrentCell()
    if currentSelectCellId ~= 0 and currentSelectCellId ~= self.mData.cell_id then
        gs.Message.Show(_TT(56065))
        return
    end

    local canRun = self:canRun()

    if canRun == false or self:getCanWalk() == false then
        gs.Message.Show(_TT(56066))
        return
    end

    --- 设置最后选中的地图为自身 并通知到服务器
    rogueLike.RogueLikeManager:setLastMapId(self.mData.cell_id)
    if currentSelectCellId ~= self.mData.cell_id then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_MAP_ENTER, {id = self.mData.cell_id})
    end

    local eventType = rogueLike.RogueLikeManager:getRogueLikeEventData(self.mData.event_id).eventType

    if eventType == rogueLike.EventType.Fight then -- 战斗
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, {id = self.mData.cell_id, eventId = self.mData.event_id, args = self.mData.args})
    elseif eventType == rogueLike.EventType.BuffSelect then -- buff选择
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_BUFF_SELECT_PANEL, {id = self.mData.cell_id, eventId = self.mData.event_id, args = self.mData.args})
        -- 会存在没有可选择的buff的情况
        if #self.mData.args >= 1 then
            local args = {}
            args.cellId = self.mData.cell_id
            args.eventId = self.mData.event_id
            args.args = self.mData.args
            GameDispatcher:dispatchEvent(EventName.SET_ROGUELIKE_BUFF_ARGS, args)
        end
    elseif eventType == rogueLike.EventType.Recover then -- 恢复事件
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_EVENT_SELECT_PANEL, {id = self.mData.cell_id, eventId = self.mData.event_id, args = self.mData.args})
    elseif eventType == rogueLike.EventType.Shop then -- 商店事件
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_OPEN, {cellId = self.mData.cell_id})
    elseif eventType == rogueLike.EventType.Special then -- 特殊事件
        -- 特殊事件内部会继续包含 战斗 商店 之类的子事件 需要留意!!!
        self.eventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.mData.event_id)
        if self.eventVo.triggerType == rogueLike.ChildEventType.ChildFight then
            -- formation.checkFormationFight(PreFightBattleType.RogueLike, nil, self.mData.cell_id, formation.TYPE.ROGUELIKE, nil, nil)
            GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, {id = self.mData.cell_id, eventId = self.mData.event_id, args = self.mData.args})
        elseif self.eventVo.triggerType == rogueLike.ChildEventType.ChildShop then
            GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_OPEN, {cellId = self.mData.cell_id})
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SPECIAL_EVENT_PANEL, {id = self.mData.cell_id, eventId = self.mData.event_id, args = self.mData.args, shwoPicture = self.mData.show_picture})
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
