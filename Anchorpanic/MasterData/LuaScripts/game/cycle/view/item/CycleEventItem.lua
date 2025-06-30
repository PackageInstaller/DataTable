module("cycle.CycleEventItem", Class.impl(lib.component.BaseItemRender))

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtTitle1 = self.m_childGos["mTxtTitle1"]:GetComponent(ty.Text)
    self.mTxCollectName = self.m_childGos["mTxCollectName"]:GetComponent(ty.Text)
    self.mTxtOtherDis = self.m_childGos["mTxtOtherDis"]:GetComponent(ty.Text)
    self.mTxtBuffDis = self.m_childGos["mTxtBuffDis"]:GetComponent(ty.Text)
    self.mImgIcon = self.m_childGos["mImgBuff1"]:GetComponent(ty.AutoRefImage)
    self.mBtn = self.m_childGos["mBtn"]
    self.mBtnConfirm = self.m_childGos["mBtnConfirm"]
    self:addOnClick(self.mBtn, self.onChooseItemClick)
    -- self:addOnClick(self.mBtnConfirm, self.onConfirmClick)
    self.mChooseItemLinkValue = {}
    self.isClicked = false

    self.mIsNotHas = self.m_childGos["mIsNotHas"]

    self.m_childGos["mTxtNotHas"]:GetComponent(ty.Text).text = _TT(77856)
    self:clickedUpdate()
end

function setData(self, data)
    super.setData(self, data)
    self.linkValue = data
    if self.linkValue then
        self:recoverAllText()
        self.cellId = cycle.CycleManager:getCurrentCell()
        local cellMsgVo = cycle.CycleManager:getCellDataById(self.cellId)

        local coin = cycle.CycleManager:getResourceInfo().coin
        self.mChooseItemLinkValue = self.linkValue

        cusLog(self.linkValue)
        local childEventVo = cycle.CycleManager:getCycleEventData(self.linkValue)
        -- local childType = childEventVo.eventType
        local args = cellMsgVo:getOptionArgs(self.linkValue)

        self.mTxtTitle1.text = _TT(childEventVo.eventTitle)
        self.mTxtOtherDis.text = _TT(childEventVo.eventDes)
        self.mImgIcon.gameObject:SetActive(false)
        self.m_childGos["mImgOther"]:SetActive(true)
        -- 消耗货币不足的情况
        if childEventVo.costCoin > 0 and childEventVo.costCoin > coin then
            self.mChooseItemLinkValue = COST_TYPE.NO_COIN
        end
        -- 理智值判断
        if childEventVo.eventType == EVENT_TYPE.EXIT then
            if cycle.CycleManager:getResourceInfo().reason_point + childEventVo.eventArgs[1] <= 0 then
                self.mChooseItemLinkValue = COST_TYPE.NO_REASON
            end
        end

        self.mIsNotHas:SetActive(false)
        -- 当前事件是否持有BUFF 需要额外处理buff内容填充
        if childEventVo:getEventIsBuff() then
            local isRandom = childEventVo:getEventIsRandomBuff()
            local collageVo = cycle.CycleManager:getCycleCollectionDataById(args[1])
            if isRandom then
                --self.m_childGos["mImgOther"]:SetActive(false)
            else
                self.mImgIcon.gameObject:SetActive(true)
                self.mImgIcon:SetImg(UrlManager:getIconPath("item/" .. collageVo.icon), false)
                self.mTxCollectName.text = _TT(collageVo.name)
                self.mTxtBuffDis.text = _TT(collageVo.des2)
                self.m_childGos["mImgOther"]:SetActive(false)
                self.mTxtOtherDis.text = ""
                self.mIsNotHas:SetActive(not cycle.CycleManager:getCycleCollageCanHas(args[1]))
            end
           
            local currentReason = cycle.CycleManager:getResourceInfo().reason_point
            if #collageVo.effParam > 0 and collageVo.effParam[1] < 0 and -collageVo.effParam[1] >= currentReason then
                self.mChooseItemLinkValue = COST_TYPE.NO_REASON
            end
            local currentReasonLimit = cycle.CycleManager:getResourceInfo().reason_point_limit
            if #collageVo.effParam > 0 and collageVo.effParam[1] < 0 and -collageVo.effParam[1] >= currentReasonLimit then
                self.mChooseItemLinkValue = COST_TYPE.NO_REASON_LIMIT
            end
            
            -- 是否是赌场事件 需要额外判断次数
        elseif childEventVo:getEventIsCasino() then
            if cellMsgVo:getOptionArgsTimes(self.linkValue) == 0 then
                self.mChooseItemLinkValue = COST_TYPE.NO_TIMER

            end
            -- 是否是赌徒事件 需要额外处理子事件
        elseif childEventVo:getEventIsCambler() then
            local childchildEventVo = cycle.CycleManager:getCycleEventData(args[1])
            self.mTxtTitle1.text = _TT(childchildEventVo.eventTitle)
            self.mTxtBuffDis.text = ""
            self.mTxtOtherDis.text = _TT(childchildEventVo.eventDes)

            if childchildEventVo.costCoin > 0 and childchildEventVo.costCoin > coin then
                self.mChooseItemLinkValue = COST_TYPE.NO_COIN
            end
        end
    else
        self:deActive()
    end
end

function active(self)
    super.active(self)
    cycle.CycleManager:addEventListener(cycleEvent.ON_EVENT_ITEM_CLICKED, self.onClickHandler, self)
    self.isClicked = false
    self:clickedUpdate()
end

function deActive(self)
    super.deActive(self)
    self:recoverAllText()
    cycle.CycleManager:removeEventListener(cycleEvent.ON_EVENT_ITEM_CLICKED, self.onClickHandler, self)
end

function onDelete(self)
    super.onDelete(self)
end

--按钮事件
function onChooseItemClick(self)
    self.isClicked = not self.isClicked
    if self.isClicked then
        cycle.CycleManager:dispatchEvent(cycleEvent.ON_EVENT_ITEM_CLICKED, self.linkValue)
        self:clickedUpdate()
    else
        self:onConfirmClick()
    end

end

function onClickHandler(self, id)
    self.isClicked = id == self.linkValue
    self:clickedUpdate()
end

--确定选择
function onConfirmClick(self)
    if cycle.CycleManager:getEventClicked() == true then
        return
    end

    if self.mChooseItemLinkValue == COST_TYPE.NO_COIN then
        gs.Message.Show(_TT(27527))
        return
    elseif self.mChooseItemLinkValue == COST_TYPE.NO_TIMER then
        gs.Message.Show(_TT(27528))
        return
    elseif self.mChooseItemLinkValue == COST_TYPE.NO_REASON then
        gs.Message.Show(_TT(27529))
        return
    elseif self.mChooseItemLinkValue == COST_TYPE.NO_REASON_LIMIT then
        gs.Message.Show(_TT(27530))
        return
    end
    -- local eventData = cycle.CycleManager:getCycleEventData(self.mEventId)
    --cycle.CycleManager:copyLastCellEventId(self.mChooseItemLinkValue)

    cycle.CycleManager:setLastSelectChildEvent(self.mChooseItemLinkValue)
    GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
        cellId = self.cellId,
        args = { self.mChooseItemLinkValue }
    })

    cycle.CycleManager:setEventClicked(true)
end


function recoverAllText(self)
    self.mTxtTitle1.text =""
    self.mTxCollectName.text =""
    self.mTxtOtherDis.text =""
    self.mTxtBuffDis.text =""
end
function clickedUpdate(self)
    self.m_childGos["mBodySelect"]:SetActive(self.isClicked)
    self.m_childGos["mImgSelected"]:SetActive(self.isClicked)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27530):	"理智上限不足 无法选择"
	语言包: _TT(27529):	"理智不足 无法选择"
	语言包: _TT(27528):	"次数不足 无法选择"
	语言包: _TT(27527):	"货币不足 无法选择"
]]
