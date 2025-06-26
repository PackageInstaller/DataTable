--[[ 
-----------------------------------------------------
@filename       : ConvertView
@Description    : 兑换页面
@date           : 2020-10-26 15:04:58
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] --
module('game.convert.view.ConvertView', Class.impl(View))

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
    self:setTxtTitle(_TT(26319))
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.mCurTimes = 0
    self.m_itemList = {}
    self.mLastMoneyBarType = {}
end

-- 初始化
function configUI(self)
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mBtnCencel = self:getChildGO("mBtnCencel")
    self.mBtnReturn = self:getChildGO("mBtnReturn")
    self.mMoneyBarGroup = self:getChildTrans("mMoneyBarGroup")
    self.mTxtOk = self:getChildGO("mTxtOk"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtCount2 = self:getChildGO("mTxtCount2"):GetComponent(ty.Text)
    self.mTxtCount1 = self:getChildGO("mTxtCount1"):GetComponent(ty.Text)
    self.mTxtRemaind = self:getChildGO("mTxtRemaind"):GetComponent(ty.Text)
    self.mGroupItem1 = self:getChildGO("mGroupItem1"):GetComponent(ty.AutoRefImage)
    self.mGroupItem2 = self:getChildGO("mGroupItem2"):GetComponent(ty.AutoRefImage)
    self.LyNumberStepper = self:getChildGO("LyNumberStepper"):GetComponent(ty.LyNumberStepperLongPress)

end

-- 激活
function active(self)
    super.active(self)
    self:__updateItemList()
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.onClickClose, self)
    convert.ConvertManager:addEventListener(convert.ConvertManager.BUY_TITANITE_UPDATE, self.onConvertInfoUpdate, self)
    convert.ConvertManager:addEventListener(convert.ConvertManager.CONVERT_INFO_UPDATE, self.onConvertInfoUpdate, self)
    self.mTxtRemaind.text = _TT(26312, convert.ConvertManager:getMaxBuyTimes())
    self.mGroupItem1:SetImg(UrlManager:getPropsIconUrl(MoneyTid.ITIANIUM_TID), false)
    self.mGroupItem2:SetImg(UrlManager:getPropsIconUrl(MoneyTid.GOLD_COIN_TID), false)
    local propsVo1 = props.PropsManager:getPropsVo({
        tid = MoneyTid.ITIANIUM_TID,
        num = 1
    })
    local propsVo2 = props.PropsManager:getPropsVo({
        tid = MoneyTid.GOLD_COIN_TID,
        num = 1
    })
    self.mTxtName1.text = propsVo1:getName()
    self.mTxtName2.text = propsVo2:getName()
    self.LyNumberStepper:Init(convert.ConvertManager.maxTimes, 1, 1, -1, self.onStepChange, self)
    self:onConvertInfoUpdate()
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    convert.ConvertManager:removeEventListener(convert.ConvertManager.CONVERT_INFO_UPDATE, self.onConvertInfoUpdate,
        self)
    convert.ConvertManager:removeEventListener(convert.ConvertManager.BUY_TITANITE_UPDATE, self.onConvertInfoUpdate,
        self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.onClickClose, self)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self.mTxtOk.text = _TT(3532)
    self:setBtnLabel(self.mBtnReturn, 2, "取消")
    self:setBtnLabel(self:getChildGO("mBtnRR"), 29572, "最多")
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
    local list = {MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID}
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.base_childTrans["MoneyBar"], {
            tid = list[i],
            frontType = self.frontType
        })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.m_itemList, item)
    end
end
-- 回收MoneyBar
function recoverItemList(self)
    for _, item in pairs(self.m_itemList) do
        item:poolRecover()
    end
    self.m_itemList = {}
end

-- 确定兑换
function onSendConvert(self)
    if convert.ConvertManager:getLefTimes() < 0 then
        gs.Message.Show(_TT(26309))
        return
    end
    local ti, gold = convert.ConvertManager:getBuyConfigByTimes(convert.ConvertManager:getBuyTimes())
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.ITIANIUM_TID, ti, true, true)
    if result and tips == "" then
        convert.ConvertManager:sendMsg()
        self.LyNumberStepper.CurrCount = 1
        gs.Message.Show(_TT(81008))
    elseif result and tips ~= "" then
        UIFactory:alertMessge(tips, true, function()
            local hasCount = MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)
            convert.ConvertManager:sendBuyTitumMsg(ti - hasCount, MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID)
            -- convert.ConvertManager:sendMsg()
            self.LyNumberStepper.CurrCount = 1
            -- gs.Message.Show(_TT(81008))
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    elseif not result then
        UIFactory:alertMessge(tips, true, function()
            if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 and
                MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) >= ti then
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                    linkId = LinkCode.Purchase,isCloseAll = true
                })
            end
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    end
end

-- 数据更新
function onConvertInfoUpdate(self)
    self.LyNumberStepper.MaxCount = convert.ConvertManager:getMaxBuyTimes() > 1 and
                                        convert.ConvertManager:getMaxBuyTimes() or 1;
    self.mBtnOk:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0163.png"), false)
    self.mTxtOk.text = _TT(10)
    if 1 > convert.ConvertManager:getMaxBuyTimes() then
        logInfo("不可兑换")
        self.mBtnOk:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0222.png"), false)
        self.mTxtOk.text = _TT(26333)
    end
    self.mTxtRemaind.text = _TT(26312, convert.ConvertManager:getMaxBuyTimes())
    self:onUpdateView()
end

function onUpdateView(self)
    convert.ConvertManager:resetClickTimes()
    local ti, gold = convert.ConvertManager:getFreshTiMoney()
    self:updateText(ti, gold)
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
    convert.ConvertManager:setClikTimes(self.LyNumberStepper.CurrCount)
    self:updateView()
end

function updateView(self)
    if 1 > convert.ConvertManager:getMaxBuyTimes() then
        return
    end
    local ti, gold = convert.ConvertManager:getBuyConfigByTimes(convert.ConvertManager:getBuyTimes())
    self:updateText(ti, gold)
end

function updateText(self, ti, gold)
    if not MoneyUtil.judgeNeedMoneyCountByTid(MoneyType.ITIANIUM_TYPE, ti, false, false) then
        if ti >= 10000 then
            ti = ti / 1000
            self.mTxtCount1.text = "X<color=#d53529>" .. ti .. "K</color>"
        else
            self.mTxtCount1.text = "X<color=#d53529>" .. ti .. "</color>"
        end
    else
        if ti >= 10000 then
            ti = ti / 1000
            self.mTxtCount1.text = "X" .. ti .. "K"
        else
            self.mTxtCount1.text = "X" .. ti
        end
    end
    if gold >= 10000 then
        gold = gold / 1000
        self.mTxtCount2.text = "X" .. gold .. "K"
    else
        self.mTxtCount2.text = "X" .. gold
    end
end

function onClickClose(self)
    self:close()
    convert.ConvertManager:resetClickTimes()
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]
