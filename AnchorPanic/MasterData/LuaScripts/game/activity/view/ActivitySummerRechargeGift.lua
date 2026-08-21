--[[ SetActive
-----------------------------------------------------
@filename       : ActivitySummerRechargeGift
@Description      夏日促销礼包
@date           : 2024-09-03
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivitySummerRechargeGift', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivitySummerRechargeGift.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtActivityTime = self:getChildGO("mTxtActivityTime"):GetComponent(ty.Text)
    
    self.mPropContent1_1 = self:getChildTrans("mPropContent1_1")
    self.mPropContent1_2 = self:getChildTrans("mPropContent1_2")
    self.mTxtOriginal1 = self:getChildGO("mTxtOriginal1"):GetComponent(ty.Text)
    self.mImgMoney1 = self:getChildGO("mImgMoney1"):GetComponent(ty.Image)
    self.mImgBuyMoney1 = self:getChildGO("mImgBuyMoney1"):GetComponent(ty.Image)
    self.mTxtBuyMoney1 = self:getChildGO("mTxtBuyMoney1"):GetComponent(ty.Text)

    self.mPropContent2 = self:getChildTrans("mPropContent2")
    self.mTxtOriginal2 = self:getChildGO("mTxtOriginal2"):GetComponent(ty.Text)
    self.mImgMoney2 = self:getChildGO("mImgMoney2"):GetComponent(ty.Image)
    self.mImgBuyMoney2 = self:getChildGO("mImgBuyMoney2"):GetComponent(ty.Image)
    self.mTxtBuyMoney2 = self:getChildGO("mTxtBuyMoney2"):GetComponent(ty.Text)

    self.mBtnBuy1 = self:getChildGO("mBtnBuy1")
    self.mBtnBuy2 = self:getChildGO("mBtnBuy2")

    self.mBtnSellOut1 = self:getChildGO("mBtnSellOut1")
    self.mBtnSellOut2 = self:getChildGO("mBtnSellOut2")
end

--激活
function active(self)
    super.active(self)
    self:updateView()
    self:addTime()
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.updateView, self)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID })
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:destroyTime()
    self:recoverSubPropsItem()
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.updateView, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setTextLabel("mTxtOriginalDes1", 10000023)
    self:setTextLabel("mTxtOriginalDes2", 10000023)
    self:setTextLabel("mTxtTitle1", 10000021)
    self:setTextLabel("mTxtTitle2", 10000024)
    self:setTextLabel("mTxtTitle3", 10000026)
    self:setTextLabel("mTxtTitle4", 10000025)
    self:setTextLabel("mTxtTitle5", 10000027)
    self:setTextLabel("mTxtTitle6", 10000022)
    self:setTextLabel("mTxtTips", 10000029)
    self:setBtnLabel(self.mBtnSellOut1, 25011)
    self:setBtnLabel(self.mBtnSellOut2, 25011)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy1, self.onClickBtnBuy1Handler)
    self:addUIEvent(self.mBtnBuy2, self.onClickBtnBuy2Handler)
end

-- 更新 View 界面
function updateView(self)
    self:recoverSubPropsItem()
    local DirectBuyVo1 = purchase.DirectBuyManager:getDirectBuyVoById(61)
    self.DirectBuyVo1 = DirectBuyVo1
    --货币价格
    self.mImgMoney1:SetImg(DirectBuyVo1:getPayIcon(), true)
    self.mImgBuyMoney1:SetImg(DirectBuyVo1:getPayIcon(), true)
    self.mTxtOriginal1.text = DirectBuyVo1.original_cost
    local price = DirectBuyVo1:getPrice()
    local isEnought = MoneyUtil.judgeNeedMoneyCountByType(DirectBuyVo1:getPayType(), price, false, false)
    self.mTxtBuyMoney1.text = isEnought and price or HtmlUtil:color(price, "D53529ff")
    --道具列表
    local subProps = AwardPackManager:getAwardListById(DirectBuyVo1:getDropId())
    local itemId1, itemId2 = subProps[1].tid, subProps[2].tid
    --策划要求掉落包里面配自选礼包，界面要显示自选礼包里的内容，然后沟通告知可以直接拿道具id去再拿掉落包
    local subProps1 = AwardPackManager:getAwardListById(itemId1)
    local subProps2 = AwardPackManager:getAwardListById(itemId2)
    for _, v in ipairs(subProps1) do
        local item = PropsGrid:create(self.mPropContent1_1, v, 1)
        table.insert(self.mSubPropsItem, item)
    end
    for _, v in ipairs(subProps2) do
        local item = PropsGrid:create(self.mPropContent1_2, v, 1)
        table.insert(self.mSubPropsItem, item)
    end

    local DirectBuyVo2 = purchase.DirectBuyManager:getDirectBuyVoById(62)
    self.DirectBuyVo2 = DirectBuyVo2
    --货币价格
    self.mImgMoney2:SetImg(DirectBuyVo2:getPayIcon(), true)
    self.mImgBuyMoney2:SetImg(DirectBuyVo2:getPayIcon(), true)
    self.mTxtOriginal2.text = DirectBuyVo2.original_cost
    local price = DirectBuyVo2:getPrice()
    local isEnought = MoneyUtil.judgeNeedMoneyCountByType(DirectBuyVo2:getPayType(), price, false, false)
    self.mTxtBuyMoney2.text = isEnought and price or HtmlUtil:color(price, "D53529ff")
    --道具列表
    local subProps = AwardPackManager:getAwardListById(DirectBuyVo2:getDropId())
    for _, v in ipairs(subProps) do
        local item = PropsGrid:create(self.mPropContent2, v, 1)
        table.insert(self.mSubPropsItem, item)
    end

    --购买状态
    local limitNum = DirectBuyVo1:getLimit()
    local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(DirectBuyVo1:getId())
    self.mBtnSellOut1:SetActive(hadBuyNum >= limitNum)
    self.mBtnBuy1:SetActive(hadBuyNum < limitNum)

    local limitNum = DirectBuyVo2:getLimit()
    local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(DirectBuyVo2:getId())
    self.mBtnSellOut2:SetActive(hadBuyNum >= limitNum)
    self.mBtnBuy2:SetActive(hadBuyNum < limitNum)
end

function recoverSubPropsItem(self)
    if self.mSubPropsItem then
        for k, v in pairs(self.mSubPropsItem) do
            v:poolRecover()
            self.mSubPropsItem[k] = nil
        end
    end
    self.mSubPropsItem = {}
end

function destroyTime(self)
    if self.mTime then
        LoopManager:removeTimerByIndex(self.mTime)
        self.mTime = nil
    end
end

function addTime(self)
    self:destroyTime()
    self:updateTime()
    self.mTime = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_SummerRecharge_Gift) then
        local RemainingTime = activity.ActivityManager:getActivityVoById(
            activity.ActivityId.Activity_SummerRecharge_Gift):getEndTime() - GameManager:getClientTime()
        self.mTxtActivityTime.text = _TT(94557) .. TimeUtil.getFormatTimeBySeconds_9(RemainingTime)
    end
end

function onClickBtnBuy1Handler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DIRECT_BUY_MONEY_PANEL, self.DirectBuyVo1)
end

function onClickBtnBuy2Handler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DIRECT_BUY_MONEY_PANEL, self.DirectBuyVo2)
end

return _M
