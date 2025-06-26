module("purchase.RechargeCostItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mIsFirst = self:getChildGO("mIsFirst")
    self.mGroupNomal = self:getChildGO("mGroupNomal")
    self.mAddTxt = self:getChildGO("mAddTxt"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mCostTxt = self:getChildGO("mCostTxt"):GetComponent(ty.Text)
    self.mTxtDisco = self:getChildGO("mTxtDisco"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mGetTxtEx = self:getChildGO("mGetTxtEx"):GetComponent(ty.Text)
    self.mIcon = self:getChildGO("mPropIconImg"):GetComponent(ty.AutoRefImage)
    self.mIconProp = self:getChildGO("mIconProp"):GetComponent(ty.AutoRefImage)
    self.mIconExProp = self:getChildGO("mIconExProp"):GetComponent(ty.AutoRefImage)
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self:addOnClick(self.mGroupNomal, self.__onClickBuyHadler)
end

function setData(self, param)
    super.setData(self, param)
    self.rechargeVo = self.data
    self.index = self.rechargeVo.index
    self.mAddTxt.text = "x" .. self.rechargeVo.goldNum
    self.mTxtDisco.text = _TT(50067)
    local vo = purchase.RechargeCostManager:getRechargeData(self.index)
    local isFirst = not recharge.RechargeManager:checkIsRecharge(self.rechargeVo.itemId)
    self.mIconProp:SetImg(UrlManager:getPropsIconUrl(vo.firstIid), false)
    

    self.mIconExProp:SetImg(UrlManager:getPropsIconUrl(vo.nofirstId), false)
    self.mTxtTitle.text = "开采源晶"
    self.mIconExProp.gameObject:SetActive(self.rechargeVo.extraGoldNum > 0)
    if self.rechargeVo.extraGoldNum > 0 then
        self.mTxtTitle.text = "额外赠送"
        self.mGetTxtEx.text =  self.rechargeVo.extraGoldNum
    end
    self.mTxtName.text = _TT(50057 + self.index)
    self.mCostTxt.text = self.rechargeVo.RMB
    --self.mIcon:SetImg(UrlManager:getIconPath("recharge/recharge_" .. self.index .. ".png"), false)
    self.mImgBg:SetImg(UrlManager:getIconPath("recharge/recharge_icon0" .. self.index .. ".png"), false)
    self.mIsFirst:SetActive(isFirst)
end

function __onClickBuyHadler(self)
    recharge.sendRecharge(recharge.RechargeType.MONEY_ITIANIUM, nil, self.rechargeVo.detailId)
    --  GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE, { type = recharge.RechargeType.MONEY_ITIANIUM, subType = nil, itemId = self.rechargeVo.itemId, itemTitle = _TT(50029), itemName = _TT(50057 + self.index), itemDes = _TT(50031) })
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mGroupNomal)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(50031):	"直充描述"
	语言包: _TT(50030):	"直充商品名"
	语言包: _TT(50029):	"直充标题"
]]