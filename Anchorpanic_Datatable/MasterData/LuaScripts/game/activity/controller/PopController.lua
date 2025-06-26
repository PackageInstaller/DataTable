--[[
-----------------------------------------------------
   @CreateTime:2025/5/23 16:31:22
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:游戏内弹窗管理器
]]

module("game.activity.controller.PopController", Class.impl(Controller))

function ctor(self)
    super.ctor(self)
    self.popViewInstanceDic = {}
    self.loginHadPopView = {} --本次登录已经弹出打开过
    self.isReceiveUpdateFashionedInfoMsg = nil
end

function reLogin(self)
    super.reLogin(self)
    self.loginHadPopView = {}
    self.isReceiveUpdateFashionedInfoMsg = nil
end

function listNotification(self)
    GameDispatcher:addEventListener(EventName.SIGNIN_PANEL_CLOSE, self.onSigninPanelCloseHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SIGNIN_STATE, self.onSigninPanelCloseHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onMainUIFinishHandler, self)
    GameDispatcher:addEventListener(EventName.ADD_MONTH_NO_FLAG, self.onAddMonthNoFlagHandler, self)
    GameDispatcher:addEventListener(EventName.RECEIVE_UPDATE_FASHIONED_INFO_MSG, self.onReceiveUpdateFashionedInfoMsgHandler, self)
end

function registerMsgHandler(self)
end

-- 签到界面关闭
function onSigninPanelCloseHandler(self)
    self:checkPopView()
end

-- 主界面打开完成
function onMainUIFinishHandler(self)
    self.mMainUIFinish = true
    self:checkPopView()
end

-- ADD_MONTH_NO_FLAG
function onAddMonthNoFlagHandler(self, args)
    self:setMonthNoPopFlag(args.viewClass)
end

--时装商店未初始化完毕
function onReceiveUpdateFashionedInfoMsgHandler(self)
    if not self.isReceiveUpdateFashionedInfoMsg then
        self.isReceiveUpdateFashionedInfoMsg = true
        self:checkPopView()
    end
end

----------------------------------------------------------
-------------------------------------------------------------
--开关界面逻辑处理
function openPopView(self, viewClass, args)
    local viewInstance = self.popViewInstanceDic[viewClass.__cname]
    if not viewInstance then
        viewInstance = viewClass.new()
        viewInstance:addEventListener(View.EVENT_CLOSE, self.onClosePopViewHandler, self)
        self.popViewInstanceDic[viewClass.__cname] = viewInstance
        self.loginHadPopView[viewClass.__cname] = 1
    end
    viewInstance:open(args)
end

function onClosePopViewHandler(self, event, viewInstance)
    viewInstance:removeEventListener(View.EVENT_CLOSE, self.onClosePopViewHandler, self)
    self.popViewInstanceDic[viewInstance.__cname] = nil
    self:checkPopView()
end

function checkPopView(self)
    if not self.mMainUIFinish then
        -- 主界面未准备好
        return
    end
    
    if next(self.popViewInstanceDic) ~= nil then
        --正在弹窗
       return 
    end

    if dailyCheckIn.DailyCheckInManager:getIsSign() == false then
        -- 未签到，不弹
        return
    end

    if self:onTapTapPopOpenHandler() then
       return 
    end

    if self:onActivityPromoOpenHandler() then
       return 
    end

    if self:onFashionShopPopOpenHandler() then
       return 
    end
end

--taptap弹窗
function onTapTapPopOpenHandler(self)
    if self:checkThisLoginHadPop(taptapAward.TaptapAwardPanel) then
       return 
    end
    if taptapAward.TaptapAwardManager:canOpenTaptapAwardPanel() then
        self:openPopView(taptapAward.TaptapAwardPanel)
        return true
    end
end

-- 活动推介打开处理
function onActivityPromoOpenHandler(self, args)
    if activity.ActivityManager:getPromoIsShow() then
        return
    end

    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ACTIVITY_PROMO_SHOW)
    if isNotRemind then
        -- 今天不再提示
        return
    end

    activity.ActivityManager:setPromoIsShow(true)
    -- 首次回到主界面则会弹出 1元超值链接补给包推荐购买 （优先弹出签到，签到界面关闭后再弹出推广页），
    -- 若1元超值礼包已被购买则会弹出 首充弹窗界面，若首充已购买则会弹出月卡推荐界面，若月卡已激活则会弹出成长礼遇推荐购买界面
    if not recharge.RechargeManager:getIsBuyOneGift() then
        self:openPopView(activity.ActivityPromoView1)
    elseif not firstCharge.FirstChargeManager:getIsReCharge() then
        self:openPopView(firstCharge.FirstChargePanel, { isShowToggle = true })
    elseif not purchase.MonthCardManager:getIsBuyMonthlyed() and not purchase.MonthCardManager:getIsPurchased() then
        self:openPopView(activity.ActivityPromoView2)
    elseif not purchase.GrowthFundManager:getIsGrowthFundMoney() then
        self:openPopView(activity.ActivityPromoView3)
    else
        return false
    end
    return true
end

--时装商店弹窗
function onFashionShopPopOpenHandler(self)
    if not self.isReceiveUpdateFashionedInfoMsg then
        --时装商店未初始化完毕
       return 
    end
    if self:checkThisLoginHadPop(activity.ActivityPromoView4) then
       return 
    end
    if self:checkIsNoPopFlag(activity.ActivityPromoView4) then
       return 
    end
    
    local id = sysParam.SysParamManager:getValue(SysParamType.MAIN_BANNER_PROMO4_ID, 0)
    --检查组合包中是否存在任一商品已被购买
    if purchase.FashionShopManager:checkComboIsAnyGoodsHadBuy(id) then
        return
    end

    self:openPopView(activity.ActivityPromoView4)
    return true
end

--保存本周不再提示标记
function setMonthNoPopFlag(self, viewClass)
    local currentWeek = TimeUtil.getWeekOfYear()
    StorageUtil:saveNumber1("MonthNoPopFlagWeek" .. viewClass.__cname, currentWeek)
end

function getMonthNoPopFlag(self, viewClass)
    local recordWeek = StorageUtil:getNumber1("MonthNoPopFlagWeek" .. viewClass.__cname) or 0
    local currentWeek = TimeUtil.getWeekOfYear()
    return recordWeek == currentWeek
end

function checkIsNoPopFlag(self, viewClass)
    --本周不在提示标记
    if self:getMonthNoPopFlag(viewClass) then
        return true
    end

    return false
end

--本次登录是否已经弹窗过
function checkThisLoginHadPop(self, viewClass)
    return self.loginHadPopView[viewClass.__cname] ~= nil
end

return _M
