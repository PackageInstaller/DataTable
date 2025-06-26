module("buildBase.BuildBaseFacProducePanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseFacProducePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    -- self:setTxtTitle(_TT(72108))
    self:setUICode(LinkCode.Covenant)
    -- self:setBg("", false)
end

function dtor(self)
end

function initData(self)
    -- self.mMeterialList = {}
    self.mHeroItemList = {}
    self.mNeedPropList = {}
    self.mCoinProp = nil
    self.mRestTimeSn = nil
    self.mSpareTimeSn = nil
    self.hasProduceNum = 0
    self.allProduceCount = 0
    self.mMoneyItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mMb = self:getChildTrans("mMoneyBar")
    self.mMeterialNode = self:getChildTrans("mMeterialNode")
    self.mFacMeterialItem = self:getChildGO("mFacMeterialItem")
    self.LyNumberStepper = self:getChildGO('LyNumberStepper'):GetComponent(ty.LyNumberStepper)
    -- self.LyNumberStepper.transform:Find("mTxtInput"):GetComponent(ty.Image).enabled = false
    self.TextEmptyTip = self:getChildTrans("TextEmptyTip")

    self.mBtnCommit = self:getChildGO("mBtnCommit")
    self.mBtnCancle = self:getChildGO("mBtnCancle")

    self.mTxtProduceName = self:getChildGO("mTxtProduceName"):GetComponent(ty.Text)
    self.mImgProduceProp = self:getChildGO("mImgProduceProp"):GetComponent(ty.AutoRefImage)
    self.mTxtRestTime = self:getChildGO("mTxtRestTime"):GetComponent(ty.Text)

    self.mTxtBagContain = self:getChildGO("mTxtBagContain"):GetComponent(ty.Text)
    self.mBtnSpeedUp = self:getChildGO("mBtnSpeedUp")
    -- self.mTxtPropNum = self:getChildGO("mTxtPropNum"):GetComponent(ty.Text)

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mSettleInNodeBtn = self:getChildGO("mSettleInNode")
    self.mSettleInNode = self.mSettleInNodeBtn.transform
    self.mTxtStaminaPay = self:getChildGO("mTxtStaminaPay"):GetComponent(ty.Text)
    self.mTxtProducePay = self:getChildGO("mTxtProducePay"):GetComponent(ty.Text)
    self.mTxtAddProducePay = self:getChildGO("mTxtAddProducePay"):GetComponent(ty.Text)

    self.mPropItem1 = self:getChildGO("mPropItem1")
    self.mTxtNone1 = self:getChildGO("mTxtNone1"):GetComponent(ty.Text)
    self.mPropNode1 = self:getChildTrans("mPropNode1")
    self.mPropItem2 = self:getChildGO("mPropItem2")
    self.mTxtNone2 = self:getChildGO("mTxtNone2"):GetComponent(ty.Text)
    self.mPropNode2 = self:getChildTrans("mPropNode2")
    self.mPriceNode = self:getChildTrans("mPriceNode")
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)

    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtProressNum = self:getChildGO("mTxtProressNum"):GetComponent(ty.Text)
    self.mSureTip = self:getChildGO("mSureTip")
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
    end
    self:updateView()
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:initMoneyItem()
    self.mProduceVo = args.produceVo
    self.openSource = args.openSource
    self.mNowBuildId = buildBase.BuildBaseManager:getNowBuildId()
    self.LyNumberStepper:Init(99, 1, 1, -1, self.onStepChange, self)
    self:reflashView()
    GameDispatcher:addEventListener(EventName.UPDATE_BUILDBASE_VIEW, self.reflashView, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.reflashView, self)
    -- 断线重连
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onReConnect, self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCommit, self.onBtnCommitClick)
    self:addUIEvent(self.mBtnSpeedUp, self.onBtnSpeedUpClick)
    self:addUIEvent(self.mBtnGet, self.onBtnGetClick)
    self:addUIEvent(self.mBtnCancle, self.onCancelShowTip)
    self:addUIEvent(self.mSettleInNodeBtn, self.onOpenSettleInListPanel)
    self:addUIEvent(self.mImgProduceProp.gameObject, self.openFacListPanel)
    self:addUIEvent(self:getChildGO("gBtnClose"), self.onClickClose)
    self:addUIEvent(self:getChildGO("gBtnCloseAll"), self.openNavigationLink)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("gTxtTitle"):GetComponent(ty.Text).text = _TT(72108) --加工厂
end

--断线重连
function onReConnect(self)
    local buildId = buildBase.BuildBaseManager:getNowBuildId()
    GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_FAC_INFO, { id = buildId })
end

--MoneyBar
function initMoneyItem(self)
    local list = { MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID }
    -- self.base_childGos["MoneyBar"]:SetActive(false)
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.mMb, { tid = list[i], frontType = self.frontType })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.mMoneyItemList, item)
    end
end

--回收MoneyBar
function recoverMoneyItem(self)
    if self.mMoneyItemList ~= nil then
        if #self.mMoneyItemList > 0 then
            for _, item in pairs(self.mMoneyItemList) do
                item:poolRecover()
            end
            self.mMoneyItemList = {}
        end
    end
end

function onBtnCommitClick(self)
    local generateProp = function()
        -- if self.enoughMeterial then 
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_PRODUCE, { id = self.mNowBuildId, orderType = buildBase.BuildBaseManager:getOrderType(), orderId = self.mProduceVo.id, count = self.LyNumberStepper.CurrCount })
        gs.Message.Show("物品已经加入生产")
        -- else
        -- gs.Message.Show("材料不足")
        -- end
    end
    local allNeedTime = self.facVo.fullTime - GameManager:getClientTime() - 1
    if allNeedTime > 0 and self.facVo.itemTid ~= self.mProduceVo.propProps[1] then
        UIFactory:alertMessge(_TT(76193), true, function()
            generateProp()
        end, _TT(1), nil, true, function()
        end, _TT(2), _TT(5), nil, nil)

    else
        generateProp()
    end
end

function onBtnSpeedUpClick(self)
    TipsFactory:uavTips({ buildBaseMsg = buildBase.BuildBaseManager:getBuildBaseData(self.mNowBuildId), propMsg = self.facVo })
end

function onBtnGetClick(self)
    if self.facVo.produce > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_AWARD, { id = self.mNowBuildId })
    else
        gs.Message.Show("没有可收取的产物")
    end
end

function onCancelShowTip(self)
    self.mSureTip:SetActive(false)
    local curCount = 1
    if self.mProduceVo.id == self.orderVo.orderId and self.orderVo.orderType == buildBase.BuildBaseManager:getOrderType() then
        curCount = self.orderVo.count > 0 and self.orderVo.count or 1
    end
    self.LyNumberStepper.CurrCount = curCount
end

function onOpenSettleInListPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, { buildBaseVo = self.facVo })
end

function openFacListPanel(self)
    if self.openSource == nil then
        self:onClickClose()
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_FAC_PANEL)
    end
end

function reflashView(self)
    self.facVo = buildBase.BuildBaseManager:getBuildBaseData(self.mNowBuildId)
    self.orderVo = buildBase.BuildBaseManager:getFacInfo(self.mNowBuildId)
    self.hasProduce = 0
    self.allProduce = 0
    if self.mProduceVo.id == self.orderVo.orderId and self.orderVo.orderType == buildBase.BuildBaseManager:getOrderType() then
        self.hasProduce = self.facVo.produce / self.mProduceVo.store
        self.allProduce = self.orderVo.count + self.hasProduce
    end
    if self.mProduceVo.propProps[1] == self.facVo.itemTid then
        local currentCount = self.orderVo.count
        currentCount = currentCount == 0 and 1 or currentCount
        self.LyNumberStepper.CurrCount = currentCount
    else
        self.LyNumberStepper.CurrCount = 1
    end
    self:updateView()
end

function updateView(self)
    self:recoverPropGrid()
    if self.mProduceVo.requiredProps[1] then
        local propGrid = PropsGrid:create(self.mPropNode1, self.mProduceVo.requiredProps[1], 1, false)
        propGrid:setCount(self.mProduceVo.requiredProps[1][2] * self.LyNumberStepper.CurrCount)
        self.mTxtNone1.text = props.PropsManager:getPropsConfigVo(self.mProduceVo.requiredProps[1][1]).name
        table.insert(self.mNeedPropList, propGrid)
    end
    self.mTxtNone2.gameObject:SetActive(self.mProduceVo.requiredProps[2])
    if self.mProduceVo.requiredProps[2] then
        local propGrid = PropsGrid:create(self.mPropNode2, self.mProduceVo.requiredProps[2], 1, false)
        propGrid:setCount(self.mProduceVo.requiredProps[2][2] * self.LyNumberStepper.CurrCount)
        self.mTxtNone2.text = props.PropsManager:getPropsConfigVo(self.mProduceVo.requiredProps[2][1]).name
        table.insert(self.mNeedPropList, propGrid)
    end

    self.mCoinProp = PropsGrid:create(self.mPriceNode, self.mProduceVo.requiredCoin, 1, false)
    self.mCoinProp:setCount(self.mProduceVo.requiredCoin[2] * self.LyNumberStepper.CurrCount)
    self.mTxtPrice.text = props.PropsManager:getPropsConfigVo(self.mProduceVo.requiredCoin[1]).name
    self.mTxtProressNum.text = self.hasProduce .. "/" .. self.allProduce
    self.mSureTip:SetActive(true)
    if self.orderVo.orderType == buildBase.BuildBaseManager:getOrderType() and
    self.mProduceVo.propProps[1] == self.facVo.itemTid and self.orderVo.count == self.LyNumberStepper.CurrCount then
        self.mSureTip:SetActive(false)
    end
    self:updateRight()
end

function updateRight(self)
    self:recoverItems()
    local facTypeConfig = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(buildBase.BuildBaseType.Factory)
    local nowfacLvConfigVo = facTypeConfig:getLevelDataVo(self.facVo.lv)
    local settleInHeroList = self.facVo.heroList
    local power = 0
    for k, v in pairs(self.facVo.skillList) do
        local skillData = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(k):getCurLvAttr(v)
        power = power + skillData.value[2]
    end

    local heroLimit = nowfacLvConfigVo.num
    for i = 1, 3 do
        local trans = self:getChildTrans("mImgEmptyHero" .. i)
        trans:Find("mAdd").gameObject:SetActive(i <= heroLimit)
        trans:Find("mEmpty").gameObject:SetActive(i > heroLimit)
    end

    for k, v in pairs(settleInHeroList) do
        local item = buildBase.BuildBaseStateGrid:poolGet()
        item:setData(v)
        item:setParent(self.mSettleInNode)
        table.insert(self.mHeroItemList, item)
    end
    self.mTxtStaminaPay.text = nowfacLvConfigVo.stamina
    self.mTxtProducePay.text = "1"
    self.mTxtAddProducePay.text = "+" .. (power / 10000)
    self.mTxtAddProducePay.gameObject:SetActive(power > 0)
    local produceVo = props.PropsManager:getPropsVo2(self.mProduceVo.propProps)
    self.mTxtProduceName.text = produceVo:getName()
    self.mImgProduceProp:SetImg(UrlManager:getIconPath(produceVo.icon))
    -- self.mTxtPropNum.text = self.LyNumberStepper.CurrCount * produceVo.count
    local singleStore = 0
    if self.orderVo.orderType > 0 and self.orderVo.orderId > 0 then
        local produceConfig = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId)
        singleStore = produceConfig.store
    end
    self.mTxtBagContain.text = self.facVo.produce .. "/" .. nowfacLvConfigVo.toplimit

    self:getMaxProduce()
    if self.mRestTimeSn then
        LoopManager:removeTimerByIndex(self.mRestTimeSn)
        self.mRestTimeSn = nil
    end
    local allNeedTime = self.facVo.fullTime - GameManager:getClientTime() - 1
    local updateRestTime = function()
        local resTime = self.facVo.time - GameManager:getClientTime()
        if allNeedTime <= 0 or self.facVo.itemTid ~= self.mProduceVo.propProps[1] then
            self.mTxtRestTime.text = "--:--:--"
            self.mTxtStaminaPay.text = "-"
            self.mTxtProducePay.text = "-"
            self.mImgProgress.fillAmount = 0
            self.mTxtAddProducePay.gameObject:SetActive(false)
            for k, v in pairs(self.mHeroItemList) do
                v:setBarShow(false)
            end
            if self.mRestTimeSn then
                LoopManager:removeTimerByIndex(self.mRestTimeSn)
                self.mRestTimeSn = nil
            end
        else
            self.mImgProgress.fillAmount = 1 - resTime / (self.facVo.time - self.facVo.startTime)
            self.mTxtRestTime.text = TimeUtil.getHMSByTime(allNeedTime)  -- 服务器剩余时间转换
            resTime = resTime - 1
            allNeedTime = allNeedTime - 1
        end
    end
    updateRestTime()
    self.mRestTimeSn = LoopManager:addTimer(1, 0, self, updateRestTime)
end

function getMaxProduce(self)
    local prop1Tid = self.mProduceVo.requiredProps[1][1]
    local coinTid = self.mProduceVo.requiredCoin[1]
    local hasNum1 = MoneyUtil.getMoneyCountByTid(prop1Tid)
    local hasNumCoin = MoneyUtil.getMoneyCountByTid(coinTid)
    local prop1Copy = math.floor(hasNum1 / self.mProduceVo.requiredProps[1][2])
    local prop2Copy = 99
    if self.mProduceVo.requiredProps[2] then
        local prop2Tid = self.mProduceVo.requiredProps[2][1]
        local hasNum2 = MoneyUtil.getMoneyCountByTid(prop2Tid)
        prop2Copy = math.floor(hasNum2 / self.mProduceVo.requiredProps[2][2])
    end
    local coinCopy = math.floor(hasNumCoin / self.mProduceVo.requiredCoin[2])
    local resStore = math.min(prop1Copy, math.min(prop2Copy, coinCopy))
    local maxValue = resStore
    -- local nowCount = self.mProduceVo.propProps[1] == self.facVo.itemTid and self.orderVo.count or 0
    if self.mProduceVo.id == self.orderVo.orderId and self.orderVo.orderType == buildBase.BuildBaseManager:getOrderType() then
        maxValue = resStore + self.orderVo.count
    end
    maxValue = maxValue > 99 and 99 or maxValue
    if maxValue <= 0 then
        maxValue = 1
    end
    self.LyNumberStepper.MaxCount = maxValue
end

function recoverPropGrid(self)
    if (self.mCoinProp) then
        self.mCoinProp:poolRecover()
    end
    self.mCoinProp = nil

    for k, v in pairs(self.mNeedPropList) do
        v:poolRecover()
    end
    self.mNeedPropList = {}
end

function recoverItems(self)
    for k, v in pairs(self.mHeroItemList) do
        v:poolRecover()
    end
    self.mHeroItemList = {}
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BUILDBASE_VIEW, self.reflashView, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.reflashView, self)
    GameDispatcher:removeEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onReConnect, self)
    self:recoverItems()
    self:recoverPropGrid()
    self:recoverMoneyItem()
    if self.mRestTimeSn then
        LoopManager:removeTimerByIndex(self.mRestTimeSn)
        self.mRestTimeSn = nil
    end
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose(true)
end

function playerClose(self)

end

function closeAll(self)
    super.closeAll(self)

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end


return _M