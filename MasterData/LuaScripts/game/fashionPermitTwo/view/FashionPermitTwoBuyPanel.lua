module("fashionPermitTwo.FashionPermitTwoBuyPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("fashionPermitTwo/FashionPermitTwoBuyPanel.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle("购买等级")--通行证


end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mPropsItemList = {}
    self.mNeedBuyLv = 0
    self.mCurLv = 0
    self.mNeedMoney = 0
end

function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mMoneyBarTrans = self:getChildTrans("mMoneyBarTrans")
    self.mTxtNextLv = self:getChildGO("mTxtNextLv"):GetComponent(ty.Text)
    self.mTxtCurLv = self:getChildGO("mTxtCurLv"):GetComponent(ty.Text)
    self.mTxtBuyMoney = self:getChildGO("mTxtBuyMoney"):GetComponent(ty.Text)
    self.mIconBuyMoney = self:getChildGO("mIconBuyMoney"):GetComponent(ty.AutoRefImage)
    self.mNumberStepper = self:getChildGO("mNumberStepper"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, (#fashionPermitTwo.FashionPermitTwoManager:getFashionPermitList() - fashionPermitTwo.FashionPermitTwoManager:getFashionPermitedLv()), self.onStepChange, self)
end


function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    if not self.mMoneyBarItem then
        self.mMoneyBarItem = MoneyItem:poolGet()
    end
    self.mMoneyBarItem:setData(self.mMoneyBarTrans, { tid = MoneyTid.ITIANIUM_TID, frontType = 1 })
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL, self.onCloseView, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updatePrice, self)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL, self.onCloseView, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updatePrice, self)
    MoneyManager:setMoneyTidList()
    self:closeAllProps()
    if self.mMoneyBarItem then
        self.mMoneyBarItem:poolRecover()
        self.mMoneyBarItem = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnBuy, 9, "购买")
end
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnBuy, self.onClickHandler)
end

function updateView(self)
    self.mCurLv = fashionPermitTwo.FashionPermitTwoManager:getFashionPermitedLv()
    self.mTxtCurLv.text = self.mCurLv
 
    self:updatePrice()
    self.mNumberStepper.MaxCount = #fashionPermitTwo.FashionPermitTwoManager:getFashionPermitList() - self.mCurLv
end
function closeAllProps(self)
    if #self.mPropsItemList > 0 then
        for i, _ in ipairs(self.mPropsItemList) do
            self.mPropsItemList[i]:poolRecover()
            self.mPropsItemList[i] = nil
        end
        self.mPropsItemList = {}
    end
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- '最大值'
        if self.mNumberStepper.MaxCount >= (#fashionPermitTwo.FashionPermitTwoManager:getFashionPermitList() - self.mCurLv) then
            gs.Message.Show(_TT(4018))
            return
        end
    elseif cusType == 2 then
        -- '最小值'
        gs.Message.Show(_TT(4019))
    end
    self:updatePrice()
end

function onClickHandler(self)
    if (self.mNeedMoney > MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)) then
        MoneyUtil.judgeNeedMoneyCountByTidTips(MoneyTid.ITIANIUM_TID, self.mNeedMoney, nil, nil, function()
            self:close()
        end)
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_FASHION_PERMIT_TWO_BUY_LV, { buyLv = self.mNumberStepper.CurrCount })
end

function updatePrice(self)
    self:closeAllProps()
    self.mNeedMoney = self.mNumberStepper.CurrCount * sysParam.SysParamManager:getValue(SysParamType.FASHIONPERMIT_TWO_UP_NEED_DIAMOND)
    local needBuyLv = self.mNumberStepper.CurrCount + self.mCurLv
    self.mIconBuyMoney:SetImg(UrlManager:getMoneyIconUrl(MoneyTid.ITIANIUM_TID), false)
    self.mTxtNextLv.text = needBuyLv
    local list = fashionPermitTwo.FashionPermitTwoManager:getFashionPermitLvStageAwardList(needBuyLv)
    for _, propsVo in ipairs(list) do
        local propGrid = PropsGrid:create(self.mAwardContent, { propsVo.tid, (propsVo.num ~= nil and propsVo.num or 1) }, 1, false)
        table.insert(self.mPropsItemList, propGrid)
    end
    self.mTxtBuyMoney.text = (self.mNeedMoney > MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)) and HtmlUtil:color(self.mNeedMoney, "D53529ff") or HtmlUtil:color(self.mNeedMoney, "202226ff")
end

function onCloseView(self)
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]