
module('noviceActivity.NoviceActivitySsrOptionalTabView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("noviceActivity/NoviceActivitySsrOptionalTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self.mAwardItem=nil
end
--析构  
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnRecive = self:getChildGO("mBtnRecive")
    self.mImgRecived = self:getChildGO("mImgRecived")
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mTxtTTop = self:getChildGO("mTxtTTop"):GetComponent(ty.Text)
    self.mTxtNomal = self:getChildGO("mTxtNomal"):GetComponent(ty.Text)
    self.mTxtMoney = self:getChildGO("mTxtMoney"):GetComponent(ty.Text)
    self.mTxtTBelow = self:getChildGO("mTxtTBelow"):GetComponent(ty.Text)
    self.mTxtTMiddle = self:getChildGO("mTxtTMiddle"):GetComponent(ty.Text)
    self.mTxtRecived = self:getChildGO("mTxtRecived"):GetComponent(ty.Text)
    self.mTxtMoneyDes = self:getChildGO("mTxtMoneyDes"):GetComponent(ty.Text)
    self.mTxtTopTitle = self:getChildGO("mTxtTopTitle"):GetComponent(ty.Text)
    self.mTxtAwardName = self:getChildGO("mTxtAwardName"):GetComponent(ty.Text)
    self.mTxtTTopTitle = self:getChildGO("mTxtTTopTitle"):GetComponent(ty.Text)
    self.mTxtTBelowTitle = self:getChildGO("mTxtTBelowTitle"):GetComponent(ty.Text)
    self.mTxtTTMiddleTitle = self:getChildGO("mTxtTTMiddleTitle"):GetComponent(ty.Text)

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    -- self.mTxtHero1 = self:getChildGO("mTxtHero1"):GetComponent(ty.Text)
    -- self.mTxtHero2 = self:getChildGO("mTxtHero2"):GetComponent(ty.Text)
    -- self.mTxtHero3 = self:getChildGO("mTxtHero3"):GetComponent(ty.Text)

    -- self.mTxtTipsInfo1 = self:getChildGO("mTxtTipsInfo1"):GetComponent(ty.Text)
    -- self.mTxtTipsInfo2 = self:getChildGO("mTxtTipsInfo2"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    self:updateView()
    GameDispatcher:addEventListener(EventName.UPDATE_SSROPTIONAL_INFO, self.updateView, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SSROPTIONAL_INFO, self.updateView, self)
    self:clearItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtNomal.text = _TT(412)
    self.mTxtRecived.text=_TT(411)--"已领取"
    self.mTxtTopTitle.text=_TT(121001)--"晶耀补给"--
    self.mTxtTTopTitle.text=_TT(50053)--"购买即获得"
    self.mTxtTBelowTitle.text=_TT(50052)--"每日可领取"
    self.mTxtTTMiddleTitle.text=_TT(50052)--"每日可领取"
    self.mTxtTTop.text=_TT(121004)--"星彩源晶<color=#ff7022>x300</color>"
    self.mTxtTBelow.text=_TT(121002)--"污染中和町(中)<color=#ff7022>x1</color>"
    self.mTxtTMiddle.text=_TT(121003)--"源晶辉锭<color=#ff7022>x80</color>"--_TT()
    self.mTxtMoneyDes.text="￥             ".._TT(9)

    -- self.mTxtHero1.text = _TT(95122)
    -- self.mTxtHero2.text = _TT(95128)
    -- self.mTxtHero3.text = _TT(95139)

    -- self.mTxtTipsInfo1.text= _TT(121209)
    -- self.mTxtTipsInfo2.text= _TT(121210)
end


function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecive,self.onClickGet)
end

function onClickGet(self)
    if noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Recive then
        GameDispatcher:dispatchEvent(EventName.REQ_NOVICE_SSR_GET)
    else
        if (purchase.MonthCardManager:getHadBuyTimes() < sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_LIMIT_BUY_TIMES)) then
            recharge.sendRecharge(recharge.RechargeType.MONTH_CARD, nil, nil)
        else
            gs.Message.Show(_TT(50028))
        end  
    end

end
-- 更新 View 界面
function updateView(self)
    self:clearItem()
    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.MONTH_CARD, nil, nil)
    local chargeVlaue = rechargeVo and rechargeVo.RMB or "NONE"
    self.mTxtMoney.text = chargeVlaue
    self.mTxtMoney.gameObject:SetActive(noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Nomal)
    self.mTxtNomal.gameObject:SetActive(noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Recive)
    self.mTxtMoneyDes.gameObject:SetActive(self.mTxtMoney.gameObject.activeSelf)
    self.mBtnRecive:SetActive(noviceActivity.NoviceActivityManager:getSSROptionalState()~=Celebration.CelebrationConst.AwardState.Recived)
    self.mImgRecived:SetActive(noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Recived)
    local awardList = sysParam.SysParamManager:getValue(SysParamType.SSR_OPTIONAL_AWARD)[1]
    local propsVo= props.PropsManager:getPropsConfigVo(awardList[1])
    self.mAwardItem=PropsGrid:createByData({ tid = awardList[1], num = awardList[2], parent = self.mAwardTrans, scale = 1, showUseInTip = true })
    self.mAwardItem:setHasRec(noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Recived)
    self.mAwardItem:setIsShowCanRec(noviceActivity.NoviceActivityManager:getSSROptionalState()==Celebration.CelebrationConst.AwardState.Recive)
    self.mTxtAwardName.text=propsVo.name

   
    local curActivityOverTime =  noviceActivity.NoviceActivityManager:getSSrEndTime()
    --local remainingTime = curActivityOverTime-GameManager:getClientTime()
    local md, hm = TimeUtil.getMDHByTime2(curActivityOverTime)
    self.mTxtTime.text = _TT(121009,md .. " " .. hm) 
end

function clearItem(self)
    if self.mAwardItem then
        self.mAwardItem:poolRecover()
        self.mAwardItem=nil
    end
end
return _M