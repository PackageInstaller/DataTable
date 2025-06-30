--[[ 
-----------------------------------------------------
@filename       : MiniFactoryInfoView
@Description    : 迷你工厂-生产信息页面
@date           : 2022-05-13 11:07:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryInfoView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("factory/MiniFactoryInfoView.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1278, 520)
end

function initData(self)
    self.mOrderVo = nil
    self.mState = 0
    self.mItemVoList = {}
    self.mCurMoney = 0
    self.mNeedmoney = 0
    self.mOneDaySec = 3600 * 24
end
--析构
function dtor(self)
end

--初始化
function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(miniFac.MiniFactoryFormulaListItem)
    self.mBtnProduceNow = self:getChildGO("mBtnProduceNow")
    self.mBtnProduceBegin = self:getChildGO("mBtnProduceBegin")
    self.mBtnStop = self:getChildGO("mBtnStop")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mImgNo = self:getChildGO("mImgNo")
    self.mTxtProductionNum = self:getChildGO("mTxtProductionNum"):GetComponent(ty.Text)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mWorkShopDetail = self:getChildGO("mWorkShopDetail")
    self.mTxtPropName = self:getChildGO("mTxtPropName"):GetComponent(ty.Text)
    self.mImgCurFactory = self:getChildGO("mImgCurFactory"):GetComponent(ty.AutoRefImage)
    self.mGridPropTrans = self:getChildTrans("mGridPropTrans")
    self.mTxtNeedCapacity = self:getChildGO("mTxtNeedCapacity"):GetComponent(ty.Text)
    self.mTxtNeedTime = self:getChildGO("mTxtNeedTime"):GetComponent(ty.Text)
    self.mCurState = self:getChildGO("mCurState"):GetComponent(ty.Text)
    self.mImgCurState = self:getChildGO("mImgCurState"):GetComponent(ty.AutoRefImage)
    self.mIconCapacity = self:getChildGO("mIconCapacity"):GetComponent(ty.AutoRefImage)
    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mNumberStep = self:getChildGO("mNumberStep"):GetComponent(ty.LyNumberStepper)
    self.mNumberStep:Init(1, 1, 1, 99999, self.onStepChangeHandler, self)
    self.mTxtShowTime = self:getChildGO("mTxtShowTime"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(0)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mImgNo:SetActive(true)
    self.mWorkShopDetail:SetActive(false)
    self.mTxtEmptyTip.text = _TT(60511)--暂未开放
    GameDispatcher:addEventListener(EventName.OPEN_WORK_SHOP_DETAIL_PANEL, self.updateDetail, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)
    self.mIndex = args
    self:setTxtTitle(_TT(miniFac.MiniFactoryManager:getFactoryVo(self.mIndex).showTipsName))
    self.mImgCurFactory:SetImg(UrlManager:getIconPath("miniFactory/factoryIkon_" .. self.mIndex .. ".png"), false)
    self.mIconCapacity:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.POWER_TID), true)
    self:updateView()
    self:setGuideTrans("guide_MiniFactoryInfo_Begin", self.mBtnProduceBegin.transform)
end

--反激活(销毁工作)
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.OPEN_WORK_SHOP_DETAIL_PANEL, self.updateDetail, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)

    miniFac.MiniFactoryManager:setSelectVo(nil)
    if self.mTargetGrid then
        self.mTargetGrid:poolRecover()
        self.mTargetGrid = nil
    end
    self:recycleItem()
    if self.mTimeSign then
        LoopManager:removeTimerByIndex(self.mTimeSign)
        self.mTimeSign = nil
    end
    miniFac.MiniFactoryManager:setRecordBtnTid(0)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function initViewTxt(self)
    self:setBtnLabel(self.mBtnProduceNow, 60529, "立刻获得")
    self:setBtnLabel(self.mBtnProduceBegin, 60530, "开始生产")
    self:setBtnLabel(self.mBtnStop, 60531, "中止生产")
    self:setBtnLabel(self.mBtnGet, 412, "领取")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnStop, self.onClickSuspendHandler)
    self:addUIEvent(self.mBtnProduceNow, self.onClickOverCompleteHandler)
    self:addUIEvent(self.mBtnProduceBegin, self.onClickProduceBeginHandler)
    self:addUIEvent(self.mBtnGet, self.onClickGetHandler)
end

function updateView(self)
    self:recycleItem()
    self.mItemVoList = miniFac.MiniFactoryManager:getFactoryFormulaVoByTabType(self.mIndex)
    local list = {}
    for i = 1, #self.mItemVoList do
        local scrollerVo = LyScrollerSelectVo.new()
        scrollerVo:setDataVo(self.mItemVoList[i])
        scrollerVo:setSelect(false)
        if miniFac.MiniFactoryManager:getRecordBtnTid() == scrollerVo:getDataVo().tid or i == 1 then
            self:updateDetail(scrollerVo:getDataVo().tid)
            scrollerVo:setSelect(true)
        end
        table.insert(list, scrollerVo)
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    self.mLyScroller:JumpToTop()
    self:updateInfoState()
end

--商品步进器
function onStepChangeHandler(self, cusNum, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(60537))
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
    end
    self:updateMoneyNum()
    self.mTargetGrid:setCount(self.mDetailData.itemNum * self.mNumberStep.CurrCount)
end
--
function updateDetail(self, tid)
    if self.mImgNo.activeSelf == true then
        self.mImgNo:SetActive(false)
    end
    if self.mWorkShopDetail.activeSelf == false then
        self.mWorkShopDetail:SetActive(true)
    end
    local targetNum = 1
    if self.mTargetGrid then
        self.mTargetGrid:poolRecover()
        self.mTargetGrid = nil
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_BTNSTATE, tid)
    self.mTxtShowTime.gameObject:SetActive(true)
    self.mCurMoney = MoneyUtil.getMoneyCountByTid(MoneyTid.POWER_TID)
    self.mDetailData = miniFac.MiniFactoryManager:getFactoryFormulaVoByTid(tid)
    self.mOrderVo = miniFac.MiniFactoryManager:getOrderVo(self.mDetailData.type)
    self.mTxtPropName.text = props.PropsManager:getTypePropsVoByTid(tid).name
    self.mNumberStep.CurrCount = 1
    self.mNeedNum = self.mDetailData.payCost
    self.mNumberStep.MaxCount = self:getMaxProduceNum()
    self.mState = 0
    if self.mOrderVo then
        if self.mOrderVo.tid == tid then
            targetNum = self.mOrderVo.orderNum
            self.mState = self.mOrderVo:getRemainTime() > 0 and 1 or 2
        end
    end
    self.mTargetGrid = PropsGrid:create(self.mGridPropTrans, { tid = tid, num = targetNum * self.mDetailData.itemNum }, 1)
    self:updateTime()
    if self.mTimeSign then
        LoopManager:removeTimerByIndex(self.mTimeSign)
        self.mTimeSign = nil
    end
    if self.mState == 1 then
        self.mTimeSign = LoopManager:addTimer(1, 0, self, self.updateTime)
    end
    self:updateState()
    GameDispatcher:dispatchEvent(EventName.FACTORY_LIST_ITEM_STATE, self.mState)
end

--刷新界面状态
function updateInfoState(self)
    self.mOrderVo = miniFac.MiniFactoryManager:getOrderVo(self.mIndex)
    if not self.mOrderVo then
        self.mState = 0
        LoopManager:removeTimerByIndex(self.mTimeSign)
        self.mTimeSign = nil
        self:updateState()
        GameDispatcher:dispatchEvent(EventName.FACTORY_LIST_ITEM_STATE, self.mState)
    end
end
--刷新进度条
function updateTime(self)
    local sec = sysParam.SysParamManager:getValue(SysParamType.PER_CAPACITY_COST_SEC)
    self.mNeedmoney = math.ceil(self.mDetailData.cost * self.mNumberStep.CurrCount / sec)
    if self.mState == 1 then
        self.mCurState:GetComponent(ty.Text).text = _TT(60524)
        self.mImgCurState:SetImg(UrlManager:getPackPath("miniFactory/miniFactory_5.png"), true)
        self.mImgCurState.color = gs.ColorUtil.GetColor("242728ff")
        self.mTxtShowTime.text = TimeUtil.getHMSByTime(self.mOrderVo:getRemainTime())
        self.mNeedmoney = math.ceil(self.mOrderVo:getRemainTime() / sec)
    elseif self.mState == 2 then
        self.mCurState.text = _TT(60527)--"生产完成"
        self.mImgCurState:SetImg(UrlManager:getCommon5Path("common_0128.png"), true)
        self.mImgCurState.color = gs.ColorUtil.GetColor("ffffffff")
        self:getChildGO("mBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("4eca6fff")
        self.mTxtShowTime.gameObject:SetActive(false)
    end
    if self.mState ~= 0 then
        local config = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.mOrderVo.orderId)
        local curProNum = self.mOrderVo:getSum() - math.ceil(self.mOrderVo:getRemainTime() / self.mOrderVo:getSingleTime())
        local sumTime = self.mOrderVo:getTime()
        self.mTxtProductionNum.text = _TT(60543, curProNum, self.mOrderVo:getSum())
        self.mProgressBar:SetValue(sumTime - self.mOrderVo:getRemainTime(), sumTime, false, false, false)
    end
    self:updateMoneyNum()
end

--刷新生产状态 state 0.默认状态 1.生产中状态 2.可领取状态 
function updateState(self)
    self.mBtnGet:SetActive(self.mState == 2)
    self.mBtnStop:SetActive(self.mState == 1)
    self.mGroupTime:SetActive(self.mState ~= 0)
    self.mBtnProduceNow:SetActive(self.mState ~= 2)
    self.mBtnProduceBegin:SetActive(self.mState == 0)
    self.mNumberStep.gameObject:SetActive(self.mState == 0)
    local color = self.mState == 2 and "4eca6fff" or "5CAAFAff"
    self:getChildGO("mBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(color)
    if self.mState == 1 then
        self.mCurState:GetComponent(ty.Text).text = _TT(60524)
        self.mImgCurState:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("miniFactory/miniFactory_5.png"), false)
    elseif self.mState == 2 then
        self.mCurState:GetComponent(ty.Text).text = _TT(43705)
        self.mImgCurState:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0128.png"), false)
    end
end

--最大数量
function getMaxProduceNum(self)
    local numMax = math.floor(self.mOneDaySec / self.mDetailData.cost)
    return numMax
end
--更新消耗道具数量
function updateMoneyNum(self)
    local sec = sysParam.SysParamManager:getValue(SysParamType.PER_CAPACITY_COST_SEC)
    if self.mState == 0 then
        self.mNeedmoney = math.ceil(self.mDetailData.cost * self.mNumberStep.CurrCount / sec)
    end
    self.mTxtNeedTime.text = TimeUtil.getHMSByTime(self.mDetailData.cost * self.mNumberStep.CurrCount)
    if self.mNeedmoney > self.mCurMoney then
        self.mTxtNeedCapacity.text = HtmlUtil:color(self.mNeedmoney, ColorUtil.RED_NUM)
    else
        self.mTxtNeedCapacity.text = HtmlUtil:color(self.mNeedmoney, '242728ff')
    end
end
--立即完成函数
function onClickOverCompleteHandler(self)
    if self.mNeedmoney > self.mCurMoney then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_CAPACITY_VIEW)
    else
        UIFactory:alertMessge(_TT(60522), true, function()
            if bag.BagManager:bagIsFull(nil, bag.BagType.Rawmat) == false then
                if not self.mOrderVo or (self.mOrderVo.tid ~= self.mDetailData.tid) then
                    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_ORDER, { id = self.mDetailData.type, orderId = self.mDetailData.key, orderNum = self.mNumberStep.CurrCount, isNowComplete = 1 })
                    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_INFO)
                else
                    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_RECEIVE, { orderId = self.mDetailData.type, isNowComplete = 1 })
                end
                miniFac.MiniFactoryManager:setRecordBtnTid(self.mDetailData.tid)
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
        GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_STOP, self.mOrderVo.id)
        miniFac.MiniFactoryManager:setRecordBtnTid(self.mDetailData.tid)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

-- 开始生产（材料+时间）
function onClickProduceBeginHandler(self)
    --同模块禁止购买
    if #miniFac.MiniFactoryManager:getProduceList() <= 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_ORDER, { id = self.mDetailData.type, orderId = self.mDetailData.key, orderNum = self.mNumberStep.CurrCount, isNowComplete = 0 })
        miniFac.MiniFactoryManager:setRecordBtnTid(self.mDetailData.tid)
        return
    else
        if self.mOrderVo ~= nil then
            gs.Message.Show(_TT(60513))
        else
            GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_ORDER, { id = self.mDetailData.type, orderId = self.mDetailData.key, orderNum = self.mNumberStep.CurrCount, isNowComplete = 0 })
            miniFac.MiniFactoryManager:setRecordBtnTid(self.mDetailData.tid)
        end
    end
end

function getCapacityMoreThanNeed(self)
    local capacity = miniFac.MiniFactoryManager:getFactoryCapacityVo()
    if capacity then
        return capacity.capacity >= self.mNeedNum
    end
    return true
end
--已达成领取函数
function onClickGetHandler(self)
    if bag.BagManager:bagIsFull(nil, bag.BagType.Rawmat) == false then
        GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_RECEIVE, { orderId = self.mOrderVo.id, isNowComplete = 0 })
        miniFac.MiniFactoryManager:setRecordBtnTid(self.mDetailData.tid)
    else
        gs.Message.Show(_TT(325))
    end
end

--清除物体
function recycleItem(self)
    if #self.mItemVoList > 0 then
        for _, vo in ipairs(self.mItemVoList) do
            vo = nil
        end
        self.mItemVoList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]