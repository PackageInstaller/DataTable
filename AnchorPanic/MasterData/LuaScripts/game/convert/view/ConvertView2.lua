--[[ 
-----------------------------------------------------
@filename       : ConvertView2
@Description    : 兑换页面
@date           : 2020-10-26 15:04:58
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module('game.convert.view.ConvertView2', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("convert/ConvertView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是
isShowMoneyBar = 0
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(26331))
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.mMoneyItemList = {}
    self.mMoneyList = {MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID}
    self.mRatio = 1
end

-- 初始化
function configUI(self)
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mBtnCencel = self:getChildGO("mBtnCencel")
    self.mBtnReturn = self:getChildGO("mBtnReturn")
    -- self.mMoneyBarGroup = self:getChildTrans("mMoneyBarGroup")
    -- self.mMoneyBar = self:getChildTrans("mMoneyBar")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtCount2 = self:getChildGO("mTxtCount2"):GetComponent(ty.Text)
    self.mTxtCount1 = self:getChildGO("mTxtCount1"):GetComponent(ty.Text)
    self.mTxtRemaind = self:getChildGO("mTxtRemaind")
    self.mTxtRemaind:SetActive(false)
    self.mTxtOk = self:getChildGO("mTxtOk"):GetComponent(ty.Text)
    self.mTxtOk.text = _TT(3532)
    self.mGroupItem1 = self:getChildGO("mGroupItem1"):GetComponent(ty.AutoRefImage)
    self.mGroupItem2 = self:getChildGO("mGroupItem2"):GetComponent(ty.AutoRefImage)
    self.LyNumberStepper = self:getChildGO("LyNumberStepper"):GetComponent(ty.LyNumberStepperLongPress)
end

-- 激活
function active(self, args)
    super.active(self, args)
    if args then
        if args.moneyList then
            self.mMoneyList = args.moneyList
        end
        if args.ratio then
            self.mRatio = args.ratio
        end
    end
    self:__updateItemList()
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.onClickClose, self)
    convert.ConvertManager:addEventListener(convert.ConvertManager.BUY_TITANITE_UPDATE, self.onConvertInfoUpdate, self)
    self.mGroupItem1:SetImg(UrlManager:getPropsIconUrl(self.mMoneyList[1]), true)
    self.mGroupItem2:SetImg(UrlManager:getPropsIconUrl(self.mMoneyList[2]), true)
    local propsVo1 = props.PropsManager:getPropsVo({
        tid = self.mMoneyList[1],
        num = 1
    })
    local propsVo2 = props.PropsManager:getPropsVo({
        tid = self.mMoneyList[2],
        num = 1
    })
    self.mTxtName1.text = propsVo1:getName()
    self.mTxtName2.text = propsVo2:getName()

    local leftMoney = MoneyUtil.getMoneyCountByType(self.mMoneyList[1])
    if leftMoney < 1 then
        leftMoney = 1
    end
    self.LyNumberStepper:Init(99999, 1, 1, leftMoney, self.onStepChange, self)
    self:updateText()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    convert.ConvertManager:removeEventListener(convert.ConvertManager.BUY_TITANITE_UPDATE, self.onConvertInfoUpdate,
        self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.onClickClose, self)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_childGos["mTxtOk"]:GetComponent(ty.Text).text = _TT(10)
    self:setBtnLabel(self.mBtnReturn, 2, "取消")
    self:setBtnLabel(self.m_childGos["mBtnRR"], 29572, "最多")
end

-- UI事件管理
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnCencel, self.onClickClose)
    self:addUIEvent(self.mBtnReturn, self.onClickClose)
    self:addUIEvent(self.mBtnOk, self.onSendConvert)
end

-- MoneyBar
function __updateItemList(self)
    local list = self.mMoneyList
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.base_childTrans["MoneyBar"], {
            tid = list[i],
            frontType = self.frontType
        })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.mMoneyItemList, item)
    end
end

-- 回收MoneyBar
function recoverItemList(self)
    for _, item in pairs(self.mMoneyItemList) do
        item:poolRecover()
    end
    self.mMoneyItemList = {}
end

-- 数据更新
function onConvertInfoUpdate(self)
    self.LyNumberStepper.CurrCount = 1
    local leftMoney = MoneyUtil.getMoneyCountByType(self.mMoneyList[1])
    if leftMoney > 1 then
        self.LyNumberStepper.SuperStep = leftMoney
    else
        self.LyNumberStepper.SuperStep = 1
    end
    self:updateText()
end

-- 计数器回调
function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(4018))
        return
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
        return
    end
    self:updateText()
end

function updateText(self)
    local enoughTi = MoneyUtil.shortValueStr(self.LyNumberStepper.CurrCount)
    self.mTxtCount2.text = "X" .. enoughTi * self.mRatio
    if not MoneyUtil.judgeNeedMoneyCountByTid(self.mMoneyList[1], self.LyNumberStepper.CurrCount, false, false) then
        local exceedingTi = HtmlUtil:color(enoughTi, "d53529")
        self.mTxtCount1.text = "X" .. exceedingTi
    else
        self.mTxtCount1.text = "X" .. enoughTi
    end
end

-- 发送购买协议
function onSendConvert(self)
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.mMoneyList[1], self.LyNumberStepper.CurrCount, true,
        true)
    if result then
        if self.LyNumberStepper.CurrCount > 0 then
            convert.ConvertManager:sendBuyTitumMsg(self.LyNumberStepper.CurrCount, self.mMoneyList[1],
                self.mMoneyList[2])
            self.LyNumberStepper.CurrCount = 1
        end
    else
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                linkId = LinkCode.Purchase,isCloseAll = true
            })
            self:onClickClose()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    end
end
-- 关闭按钮
function onClickClose(self)
    self:close()
    convert.ConvertManager:resetClickTimes()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
