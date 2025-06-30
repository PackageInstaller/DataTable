--[[
-----------------------------------------------------
@filename       : PermitBuyShowView
@Description    : 通行证购买界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("permit.PermitBuyShowView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("permit/PermitBuyShowView.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1272, 523)
    self:setTxtTitle("激活多通道")--通行证
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mPropsGridList = {}
end

function configUI(self)
    super.configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnBuyTop = self:getChildGO("mBtnBuyTop")
    self.mBtnBuyDown = self:getChildGO("mBtnBuyDown")
    self.mImgTopOver = self:getChildGO("mImgTopOver")
    self.mImgDownOver = self:getChildGO("mImgDownOver")
    self.mTransAward = self:getChildTrans("mTransAward")
    self.mTxtTop = self:getChildGO("mTxtTop"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtDes2 = self:getChildGO("mTxtDes2"):GetComponent(ty.Text)
    self.mTxtDes1 = self:getChildGO("mTxtDes1"):GetComponent(ty.Text)
    self.mTxtDown = self:getChildGO("mTxtDown"):GetComponent(ty.Text)
    self.mTxtTopDes = self:getChildGO("mTxtTopDes"):GetComponent(ty.Text)
    self.mTxtBuyTop = self:getChildGO("mTxtBuyTop"):GetComponent(ty.Text)
    self.mTxtBuyDown = self:getChildGO("mTxtBuyDown"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_PERMIT_PANEL, self.updateView, self)
    self:updateView()
    --self:updateTime()
    --self:addTimer(1, 0, self.updateTime)
end

function deActive(self)
    super.deActive(self)
    self:closeAllProps()
    GameDispatcher:removeEventListener(EventName.UPDATE_PERMIT_PANEL, self.updateView, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtDes.text = _TT(81002)
    self.mTxtTop.text = _TT(81005)--“激活通行证”
    self.mTxtDes2.text = _TT(81003)--立即获得：提升10级
    self.mTxtDes1.text = _TT(81004)--额外获得
    self.mTxtDown.text = _TT(81006)--“激活+直升10级”
    self.mTxtTopDes.text = _TT(81001)
    self:getChildGO("mTxtType"):GetComponent(ty.Text).text = _TT(98106)
    self:getChildGO("mTxtHeroName"):GetComponent(ty.Text).text = _TT(98109)

end
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnBuyTop, self.onClickBuy68Handler)
    self:addUIEvent(self.mBtnBuyDown, self.onClickHandler)
end

function updateView(self)
    self:closeAllProps()
    if recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.TONG_XING_ZHENG, nil, nil) then
        local btn98Txt = permit.PermitManager:getIsBuyPermit(1) and self:getRechargeVo("3").RMB or self:getRechargeVo("2").RMB
        self.mTxtBuyDown.text = permit.PermitManager:getIsBuyPermit(2) and "已激活" or btn98Txt
        self.mTxtBuyTop.text = permit.PermitManager:getIsBuyPermit(-1) and "已激活" or self:getRechargeVo("1").RMB
    else
        local btn98Txt = permit.PermitManager:getIsBuyPermit(1) and 30 or 98
        self.mTxtBuyDown.text = permit.PermitManager:getIsBuyPermit(2) and "已激活" or btn98Txt
        self.mTxtBuyTop.text = permit.PermitManager:getIsBuyPermit(-1) and "已激活" or 68
    end
    self.mBtnBuyDown:SetActive((permit.PermitManager:getIsBuyPermit(2) == false))
    self.mImgDownOver:SetActive(permit.PermitManager:getIsBuyPermit(2) == true)
    self.mBtnBuyTop:SetActive((permit.PermitManager:getIsBuyPermit(-1) == false))
    self.mImgTopOver:SetActive(permit.PermitManager:getIsBuyPermit(-1) == true)
    for _, propsVo in ipairs(AwardPackManager:getAwardListById(sysParam.SysParamManager:getValue(SysParamType.PERMIT_UP_EXTRA_AWARD_98))) do
        local propGrid = PropsGrid:create(self.mTransAward, {propsVo.tid, (propsVo.num ~= nil and propsVo.num or 1)}, 1, false)
        propGrid:setCountTextSize(24)
        table.insert(self.mPropsGridList, propGrid)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTransAward.transform) --立即刷新
end
function closeAllProps(self)
    if #self.mPropsGridList > 0 then
        for i, _ in ipairs(self.mPropsGridList) do
            self.mPropsGridList[i]:poolRecover()
            self.mPropsGridList[i] = nil
        end
        self.mPropsGridList = {}
    end
end

function getRechargeVo(self, detailId)
    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.TONG_XING_ZHENG, nil, detailId)
    if rechargeVo then
        return rechargeVo
    end
    return "无对应充值数据"
end

function onClickHandler(self)
    local detailId = "2";
    if permit.PermitManager:getIsBuyPermit(1) then
        detailId = "3"
    end
    recharge.sendRecharge(recharge.RechargeType.TONG_XING_ZHENG, nil, detailId)
end

function onClickBuy68Handler(self)
    recharge.sendRecharge(recharge.RechargeType.TONG_XING_ZHENG, nil, "1")
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit):getEndTime() - clientTime
        local timeTxt = RemainingTime <= 0 and "活动已结束" or _TT(3530) .. HtmlUtil:color(TimeUtil.getFormatTimeBySeconds_9(RemainingTime), "fa3a2bff")
        self.mTxtTime.text = timeTxt
        if RemainingTime <= 0 then
            self:removeTimer(self.updateTime)
            return
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
