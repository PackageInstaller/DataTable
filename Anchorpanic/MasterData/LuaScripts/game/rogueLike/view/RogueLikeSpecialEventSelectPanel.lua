--[[ 
-----------------------------------------------------
@filename       : RogueLikeSpecialEventSelectPanel
@Description    : 肉鸽特殊事件
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeSpecialEventSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeSpecialEventSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mEventItemList = {}
    self.mSelectItem = nil
    self.mIsShowResult = nil
    self.mResultItem = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mBtnSure = self:getChildGO("mBtnSure")

    self.mIsResult = self:getChildGO("mIsResult")
    self.mTxtResultDes = self:getChildGO("mTxtResultDes"):GetComponent(ty.Text)
    self.mResultScroll = self:getChildGO("mResultScroll"):GetComponent(ty.ScrollRect)
    self.mBtnResultSure = self:getChildGO("mBtnResultSure")
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_SPECIAL_PANEL, self.updateSpecialPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_ROGUELIKE_SPECIAL_RESULT_PANEL, self.closeSpecialPanel, self)
    self.cellId = args.id
    self.eventId = args.eventId
    self.args = args.args
    self.mIsShowResult = args.shwoPicture == 2 -- args.args[1].key == 1

    self.currentEventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)

    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_SPECIAL_PANEL, self.updateSpecialPanel, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_ROGUELIKE_SPECIAL_RESULT_PANEL, self.closeSpecialPanel, self)
    self:recoverList()

    -- if self.mEndCall ~= nil then
    --     self.mEndCall()
    -- end
end

function updateSpecialPanel(self, cellData)
    self.cellId = cellData.cell_id
    self.eventId = cellData.event_id
    self.args = cellData.args
    self.mIsShowResult = cellData.show_picture == 2
    self.mSelectEventId = nil

    self.currentEventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
    self:updateView()
end

function closeSpecialPanel(self)
    self:onClickClose()

  
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onSureBtnClick)

    self:addUIEvent(self.mBtnResultSure, self.onResultSureClick)
end

function onSureBtnClick(self)
    if self.mSelectItem and self.mSelectEventId then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SPECIAL_SELECT_EVENT, {cellId = self.cellId, eventId = self.mSelectEventId})
    else
        gs.Message.Show("请选择一个特殊事件")
    end
end

function onResultSureClick(self)
    -- 如果是战斗或者是商店的特殊事件做特殊的请求
    if self.currentEventVo.triggerType == 6 then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, {id = self.cellId, eventId = self.eventId ,args = self.args})
        self:onClickClose()
    elseif self.currentEventVo.triggerType == 9 then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_OPEN, {cellId = self.cellId, eventId = self.eventId})
        self:onClickClose()
    else
        --获取buff的子事件                                                                  --丢失buff的子事件
        if self.currentEventVo.triggerType == 3 or self.currentEventVo.triggerType == 4 or self.currentEventVo.triggerType == 5  then
            cusLog("可以打开")
            rogueLike.RogueLikeManager:setCanShowBuffChange(true)
        end
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SPECIAL_SURE_EVENT, {cellId = self.cellId})
    end
end

function updateView(self)
    self:recoverList()

    self.mIsSelect:SetActive(self.mIsShowResult == false)
    self.mIsResult:SetActive(self.mIsShowResult == true)

    if self.mIsShowResult == false then
        local list = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
        self.mTxtTitle.text = _TT(list.eventTitle)
        self.mTxtDes.text = _TT(list.eventDes)
        for id, data in pairs(list.eventArgs) do
            local item = rogueLike.RogueLikeSpecialEventSelectItem:poolGet()
            item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
            item:setData(self.mScrollView.content, self.cellId, data)
            table.insert(self.mEventItemList, item)
        end
    else
        local eventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
        self.mResultItem = rogueLike.RogueLikeSpecialEventResultItem:poolGet()
        self.mResultItem:setData(self.mResultScroll.content, self.cellId, self.eventId)
    end
end

-- 回收项
function recoverList(self)
    if self.mEventItemList then
        for i, v in pairs(self.mEventItemList) do
            v:removeEventListener(v.EVENT_CHANGE, self.onItemChange, self)
            v:poolRecover()
        end
    end
    self.mEventItemList = {}

    if self.mResultItem ~= nil then
        self.mResultItem:poolRecover()
        self.mResultItem = nil
    end
end

function onItemChange(self, args)
    if self.mSelectItem then
        -- 回收之前打开的
        self.mSelectItem:setSelect(false)
        self.mSelectItem = nil

        self.mSelectEventId = nil
    end
    self.mSelectItem = args.item
    self.mSelectEventId = args.eventId
    self.mEndCall = args.callback
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
