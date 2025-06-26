--[[ 
-----------------------------------------------------
@filename       : MiniConvertView
@Description    : 迷你工厂兑换页面
@date           : 2022-03-01 13:38:58
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.miniFactory.view.MiniConvertView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("convert/MiniConvertView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1056, 558)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mItianium = nil    --钛石
    self.mNeedCapacity = sysParam.SysParamManager:getValue(SysParamType.CAPACITY_COST_NEED_NUMS)
    self.mOnceBuyCapacity = sysParam.SysParamManager:getValue(SysParamType.CAPACITY_ONCE_BUY_NUMS)
    self.mBuyTimes = sysParam.SysParamManager:getValue(SysParamType.CAPACITY_EVERDAY_BUY_TIMES)
end

-- 初始化
function configUI(self)
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mBtnCencel = self:getChildGO("mBtnCencel")
    self.mMoneyBarGroup = self:getChildTrans("mMoneyBarGroup")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtCount2 = self:getChildGO("mTxtCount2"):GetComponent(ty.Text)
    self.mTxtCount1 = self:getChildGO("mTxtCount1"):GetComponent(ty.Text)
    self.mTxtRemaind = self:getChildGO("mTxtRemaind"):GetComponent(ty.Text)
    self.mTxtTimeOne = self:getChildGO("mTxtTimeOne"):GetComponent(ty.Text)
    self.mTxtTimeAll = self:getChildGO("mTxtTimeAll"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtHasingDes = self:getChildGO("mTxtHasingDes"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtTimeAllLab = self:getChildGO("mTxtTimeAllLab"):GetComponent(ty.Text)
    self.mTxtTimeOneLab = self:getChildGO("mTxtTimeOneLab"):GetComponent(ty.Text)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mGroupItem1 = self:getChildGO("mGroupItem1"):GetComponent(ty.AutoRefImage)
    self.mGroupItem2 = self:getChildGO("mGroupItem2"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
    --if not self.mMoneyItianium then
    --    self.mMoneyItianium = MoneyItem:poolGet()
    --end
    --self.mMoneyItianium:setData(self.mMoneyBarGroup, { tid = MoneyTid.ITIANIUM_TID, frontType = 1 })
    --if not self.mMoneyGold then
    --    self.mMoneyGold = MoneyItem:poolGet()
    --end
    --self.mMoneyGold:setData(self.mMoneyBarGroup, { tid = MoneyTid.POWER_TID, frontType = 1 })
    GameDispatcher:addEventListener(EventName.UPDATE_CONVERT_INFO, self.onConvertInfoUpdate, self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CONVERT_INFO, self.onConvertInfoUpdate, self)
    LoopManager:removeTimerByIndex(self.mloop)
    self.mloop = nil
    --if self.mMoneyItianium then
    --    self.mMoneyItianium:poolRecover()
    --    self.mMoneyItianium = nil
    --end
    --if self.mMoneyGold then
    --    self.mMoneyGold:poolRecover()
    --    self.mMoneyGold = nil
    --end
end

-- 数据更新
function onConvertInfoUpdate(self)
    self:updateView()
end

function initViewText(self)
    self.mTxtTitle.text = _TT(60538)--"产能兑换"
    self.mTxtHasingDes.text = _TT(26324)--"拥有数量："
    self.mTxtTimeOneLab.text = _TT(1208) -- "恢复1ml"
    self.mTxtTimeAllLab.text = _TT(1209) -- "恢复全部"
    self:setBtnLabel(self.mBtnOk, 1, _TT(1))
end

-- UI事件管理
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnOk, self.onSendConvert)
    self:addUIEvent(self.mBtnCencel, self.onCancel)

end

function updateView(self)
    self.capacity = MoneyUtil.getMoneyCountByTid(MoneyTid.POWER_TID)
    self.mItianium = MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)

    self.mTxtCount.text = self.capacity .. "/" .. sysParam.SysParamManager:getValue(SysParamType.CAPACITY_MAXIMUMS_NUMS)
    self.mGroupItem1:SetImg(UrlManager:getPropsIconUrl(MoneyTid.ITIANIUM_TID), false)

    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(MoneyTid.POWER_TID), false)
    self.mGroupItem2:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.POWER_TID), false)

    local propsVo1 = props.PropsManager:getPropsVo({ tid = MoneyTid.ITIANIUM_TID, num = 1 })
    local propsVo2 = props.PropsManager:getPropsVo({ tid = MoneyTid.POWER_TID, num = 1 })
    self.mTxtName1.text = propsVo1:getName()
    self.mTxtName2.text = propsVo2:getName()
    self.mTxtCount1.text = self.mNeedCapacity
    self.mTxtCount2.text = self.mOnceBuyCapacity
    self.mImgColor.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(propsVo2.color))
    self.mImgColorBg.color = gs.ColorUtil.GetColor(ColorUtil:getPropBgColor(propsVo2.color))

    local colorStr = self.mBuyTimes <= miniFac.MiniFactoryManager:getFactoryCapacityVo().buyTimes and "bd2a2a" or "407edbff"
    local timeStr = HtmlUtil:color((self.mBuyTimes - miniFac.MiniFactoryManager:getFactoryCapacityVo().buyTimes), colorStr)
    self.mTxtRemaind.text = _TT(26312, timeStr)
    self:onShowTipsViewHandler()
end

-- 确定兑换
function onSendConvert(self)
    if self.mItianium < self.mNeedCapacity then
        gs.Message.Show(_TT(60518))
        return
    else
        if miniFac.MiniFactoryManager:getFactoryCapacityVo().buyTimes < sysParam.SysParamManager:getValue(SysParamType.CAPACITY_EVERDAY_BUY_TIMES) then
            if self.capacity <= sysParam.SysParamManager:getValue(SysParamType.CAPACITY_MAXIMUMS_NUMS) then
                GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_BUYSM, { times = 1 })
            else
                gs.Message.Show(_TT(60521))
            end
        else
            gs.Message.Show(_TT(26309))
        end
    end
end

function onCancel(self)
    self:close()
end

function onShowTipsViewHandler(self)
    if self.capacity < sysParam.SysParamManager:getValue(SysParamType.CAPACITY_MAXIMUMS_NUMS) then
        self:loopTime()
        self.mloop = LoopManager:addTimer(1, 0, self, self.loopTime)
    else
        self.mTxtTimeOne.text = _TT(60545)--"自动工作机器人已满"
        self.mTxtTimeAll.text = _TT(60545)--"自动工作机器人已满"
    end
end

function loopTime(self)
    local restoreOne = miniFac.MiniFactoryManager:getFactoryCapacityVo().nextTime - GameManager:getClientTime()
    local allTime = miniFac.MiniFactoryManager:getFactoryCapacityVo().allTime - GameManager:getClientTime()
    if MoneyUtil.getMoneyCountByTid(MoneyTid.POWER_TID) < sysParam.SysParamManager:getValue(SysParamType.CAPACITY_MAXIMUMS_NUMS) or (restoreOne > 0) then
        self.mTxtTimeOne.text = TimeUtil.getHMSByTime(restoreOne)
        self.mTxtTimeAll.text = TimeUtil.getHMSByTime(allTime)
    else
        self.mTxtTimeOne.text = _TT(60545)--"自动工作机器人已满"
        self.mTxtTimeAll.text = _TT(60545)--"自动工作机器人已满"
        LoopManager:removeTimerByIndex(self.mloop)
        self.mloop = nil
        return
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]