--[[ 
-----------------------------------------------------
@filename       : MainActivityShopItem
@Description    : 活动玩法商店Item
@date           : 2023/5/24 15:00
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------]]
module("mainActivity.MainActivityShopItem ", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
end


function onInit(self, go)
    super.onInit(self, go)
    self.mImgPropsIcon = self:getChildGO("mImgPropsIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)
    self.mTxtPropsNum = self:getChildGO("mTxtPropsNum"):GetComponent(ty.Text)
    self.mTxtPropsLeftNum = self:getChildGO("mTxtPropsLeftNum"):GetComponent(ty.Text)
    self.mTxtPropsName = self:getChildGO("mTxtPropsName"):GetComponent(ty.Text)
    self:getChildGO("mTxtTile"):GetComponent(ty.Text).text = _TT(25009)
    self.mPropsColor = self:getChildGO("mPropsColor"):GetComponent(ty.AutoRefImage)
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)
end

function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnGet"), self.onClickBuy)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_BUY_UPDATE, self.updateData, self)
    self:getChildGO("mTxtLayOut2"):SetActive(false)
    self:getChildGO("mImgOver"):SetActive(false)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_BUY_UPDATE, self.updateData, self)
end

--纯设置数据
function setData(self, param)
    super.setData(self, param)
    self.mPropsTid = param.itemTid
    self.mPrice = param.price
    self.id = param.id
    self.soldOut = false
end

-- 点击购买
function onClickBuy(self)
    if self.soldOut then
        TipsFactory:propsTips({ propsVo = props.PropsManager:getPropsConfigVo(self.mPropsTid) }, { rectTransform = self.mImgPropsIcon.transform })
        -- gs.Message.Show(_TT(1379))
    else
        local shopVo = LuaPoolMgr:poolGet(shop.ShopVo)
        local msgVo = mainActivity.MainActivityManager:getShopMsgVo(self.data.id)
        local purchasedTimes = msgVo ~= nil and msgVo.purchasedTimes or 0
        shopVo:parseMsg({ id = self.data.id, item_tid = self.data.itemTid, item_num = self.data.sellNum, price = self.data.price, pay_tid = MoneyType.ACTIVITY_COIN_TYPE, pay_type = MoneyTid.ACTIVITY_COIN_TID, discount = 0,
        limit_num = self.data.limitNum, buy_times = purchasedTimes
        })
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_SHOP_BUY_VIEW, shopVo)
    end
end

function updateData(self, args)
    if args.id == self.id then
        self:updateView()
    end
end

function updateView(self)
    if self.data then
        
        self.mImgMoneyIcon:SetImg(UrlManager:getPropsIconUrl(MoneyType.ACTIVITY_COIN_TYPE),false)
        self.m_propsConfigVo = props.PropsManager:getPropsConfigVo(self.data.itemTid)
        self.mImgPropsIcon:SetImg(UrlManager:getPropsIconUrl(self.data.itemTid), false)

        self.mPropsColor.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.m_propsConfigVo.color))
        if self.data.limitNum == 0 then
            self:getChildGO("mTxtLayOut2"):SetActive(false)
            self:getChildGO("mImgOver"):SetActive(false)
        else
            self:getChildGO("mTxtLayOut2"):SetActive(true)
            self.msgVo = mainActivity.MainActivityManager:getShopMsgVo(self.data.id)
            if self.msgVo == nil then
                self.mTxtPropsLeftNum.text = self.data.limitNum
                self:getChildGO("mTxtTile"):GetComponent(ty.Text).text = _TT(25009) .. self.data.limitNum
            else
                local leftTimes = self.data.limitNum - self.msgVo.purchasedTimes
                self.soldOut = leftTimes <= 0
                self.mTxtPropsLeftNum.text = leftTimes
                self:getChildGO("mTxtTile"):GetComponent(ty.Text).text = _TT(25009) .. leftTimes
                self:getChildGO("mImgOver"):SetActive(self.soldOut)
            end
        end

       
        self.mTxtPropsNum.text = "x" .. self.data.sellNum
        self.mTxtPrice.text = self.data.price
        self.mTxtPropsName.text =    self.m_propsConfigVo.name
    else
        self:onDelete()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]