--[[ 
-----------------------------------------------------
@filename       : MiniProduceItem
@Description    : 迷你工厂-生产列表Item
@date           : 2022-02-28 15:34:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("game.miniFactory.view.item.MiniProduceItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mImgTime = self:getChildGO("mImgTime")
    self.mImgCanGet = self:getChildGO("mImgCanGet")
    self.mBtnSuspend = self:getChildGO("mBtnSuspend")
    self.mBar = self:getChildGO("mBar"):GetComponent(ty.Image)
    self.mBtnOverComplete = self:getChildGO("mBtnOverComplete")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtOverState = self:getChildGO("mTxtOverState"):GetComponent(ty.Text)
    self.mTxtCostMoney = self:getChildGO("mTxtCostMoney"):GetComponent(ty.Text)
    self.mTxtOrderName = self:getChildGO("mTxtOrderName"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.ProgressBar)
    self.mTxtFactoryName1 = self:getChildGO("mTxtFactoryName1"):GetComponent(ty.Text)
    self.mTxtFactoryName2 = self:getChildGO("mTxtFactoryName2"):GetComponent(ty.Text)
    self.mImgCusMoney = self:getChildGO("mImgCusMoney"):GetComponent(ty.AutoRefImage)
    self.mTxtProductionNum = self:getChildGO("mTxtProductionNum"):GetComponent(ty.Text)
    self.mImgFactoryType = self:getChildGO("mImgFactoryType"):GetComponent(ty.AutoRefImage)
    self.mProgressBar:InitData(0)

    self:addOnClick(self.mBtnOverComplete, self.onClickOverCompleteHandler)
    self:addOnClick(self.mBtnSuspend, self.onClickSuspendHandler)
    self:addOnClick(self.mBtnGet, self.onClickGetHandler)
    self.mTxtOverState.text = _TT(43705)
end

function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.updateTime)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mBtnOverComplete, self.onClickOverCompleteHandler)
    self:removeOnClick(self.mBtnSuspend, self.onClickSuspendHandler)
    self:removeOnClick(self.mBtnGet, self.onClickGetHandler)
    LoopManager:removeTimer(self, self.updateTime)
    self:recoverGrid()
end

function setData(self, param)
    super.setData(self, param)
    local propsVo = props.PropsManager:getPropsVo({ tid = self.data.tid, num = self.data.orderNum * self.data:getItemNum() })
    local type = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.data.orderId).type
    self.mImgFactoryType:SetImg(UrlManager:getIconPath("miniFactory/produce_" .. type .. ".png"), false)
    self.mTxtFactoryName1.text = string.sub(self.data:getLuange(), 1, 6)
    self.mTxtFactoryName2.text = string.sub(self.data:getLuange(), 7, -1)
    self.mTxtOrderName.text = propsVo.name
    self.mGridOrder = PropsGrid:create(self:getChildTrans("mImgOrderProps"), propsVo, 0.8)
    self.mImgCusMoney:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.POWER_TID), true)
    self.mCurMoney = self.data:getPayNums()
    self.mBtnGet:SetActive(false)
    self.mBtnOverComplete:SetActive(true)
    self:getChildGO("mImgTime"):SetActive(true)
    self.mImgCanGet:SetActive(false)
    self:updateTime()
    LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)
    local time = self.data.endTime - GameManager:getClientTime()
    local current = (self.data:getTime() - time)
    self.mTxtTime.text = TimeUtil.getHMSByTime(time)
    self.mProgressBar:SetValue(current, self.data:getTime(), true)
    local sec = sysParam.SysParamManager:getValue(SysParamType.PER_CAPACITY_COST_SEC)
    self.needmoney = math.ceil(time / sec)
    local curProNum = self.data:getSum() - math.ceil(time / self.data:getSingleTime())
    if time <= 0 and (table.indexof(miniFac.MiniFactoryManager:getCompleteOrderList(), self.data.id)) then
        self.mBtnGet:SetActive(true)
        self.mBtnOverComplete:SetActive(false)
        self.mImgTime:SetActive(false)
        self.mTxtOverState.gameObject:SetActive(true)
        self.mBtnSuspend:SetActive(false)
        self.mImgCanGet:SetActive(true)
        self.mBar.color = gs.ColorUtil.GetColor("4eca6fff")
        if self.data.endTime - GameManager:getClientTime() then
            LoopManager:removeTimer(self, self.updateTime)
        end
    else
        self.mBar.color = gs.ColorUtil.GetColor("5CAAFAff")
        self.mBtnGet:SetActive(false)
        self.mBtnOverComplete:SetActive(true)
        self.mBtnSuspend:SetActive(true)
        self.mImgTime:SetActive(true)
        self.mTxtOverState.gameObject:SetActive(false)
        self.mImgCanGet:SetActive(false)
        self.mTxtProductionNum.text = _TT(60543, curProNum, self.data:getSum())
    end
    if self.needmoney > self.mCurMoney then
        self.mTxtCostMoney.text = HtmlUtil:color(self.needmoney, ColorUtil.RED_NUM)
    else
        self.mTxtCostMoney.text = HtmlUtil:color(self.needmoney, '40484Bff')
    end
end

--立即完成函数
function onClickOverCompleteHandler(self)
    if self.data:getPayNums() < self.needmoney then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_CAPACITY_VIEW)
    else
        UIFactory:alertMessge(_TT(60522), true, function()
            if bag.BagManager:bagIsFull(nil, bag.BagType.Rawmat) == false then
                GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_RECEIVE, { orderId = self.data.id, isNowComplete = 1 })
            else
                gs.Message.Show(_TT(325))
            end
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
    end
end

--中止函数
function onClickSuspendHandler(self)
    -- 中止订单会返还材料，确认中止该订单吗？
    UIFactory:alertMessge(_TT(60523), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_STOP, self.data.id)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

--已达成领取函数
function onClickGetHandler(self)
    if bag.BagManager:bagIsFull(nil, bag.BagType.Rawmat) == false then
        GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_RECEIVE, { orderId = self.data.id, isNowComplete = 0 })
    else
        gs.Message.Show(_TT(325))
    end
end

function recoverGrid(self)
    if self.mGridOrder then
        self.mGridOrder:poolRecover()
        self.mGridOrder = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]