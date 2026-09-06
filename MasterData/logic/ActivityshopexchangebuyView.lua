-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangebuyView.lua

module("logic.extensions.activityshop.view.ActivityshopexchangebuyView", package.seeall)

local ActivityshopexchangebuyView = class("ActivityshopexchangebuyView", ViewComponent)
local limitPeriod = {
	[""] = "",
	weekly = lang("每周"),
	daily = lang("每日"),
	monthly = lang("每月"),
	allTime = lang("活动")
}

function ActivityshopexchangebuyView:ctor()
	ActivityshopexchangebuyView.super.ctor(self)
end

function ActivityshopexchangebuyView:buildUI()
	ActivityshopexchangebuyView.super.buildUI(self)

	self._itemCon = self:getGo("content/itemCon")
	self._timeObj = self:getGo("content/ImgTimeBg")
	self._timeTxt = self:getGo("content/ImgTimeBg/TxtTime"):GetComponent("Text")
	self._nameTxt = self:getGo("content/TxtName"):GetComponent("Text")
	self._limitTxt = self:getGo("content/TxtLimit"):GetComponent("Text")
	self._priceTxt = self:getGo("content/BgPrice/ImgCnt/TxtPrice"):GetComponent("Text")
	self._haveTxt = self:getGo("content/TxtHave"):GetComponent("Text")
	self._descTxt = self:getGo("content/TxtDesc"):GetComponent("Text")
	self._useMatIcon = self:getGo("content/BgPrice/ImgCnt")
	self._addBtn = self:getBtn("content/BgNum/BtnAdd")
	self._minusBtn = self:getBtn("content/BgNum/BtnMinus")
	self._addBtnTen = self:getBtn("content/BgNum/BtnAddTen")
	self._minusBtnTen = self:getBtn("content/BgNum/BtnMinusTen")
	self._buyBtn = self:getBtn("content/BtnBuy")
	self._returnBtn = self:getBtn("btnRtn")
	self._input = self:getInput("content/BgNum")
	self._nameTxt = self:getGo("content/TxtName"):GetComponent("Text")
	self.group = self:getGo("content/TxtName"):GetComponent("UIChangeGroup")
end

function ActivityshopexchangebuyView:bindEvents()
	ActivityshopexchangebuyView.super.bindEvents(self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtnTen:AddClickListener(self._onClickAddTen, self)
	self._minusBtnTen:AddClickListener(self._onClickMinusTen, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
	self._returnBtn:AddClickListener(self._onClickReturn, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)
end

function ActivityshopexchangebuyView:unbindEvents()
	ActivityshopexchangebuyView.super.unbindEvents(self)
	self._addBtn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtnTen:RemoveClickListener()
	self._minusBtnTen:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._returnBtn:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function ActivityshopexchangebuyView:destroyUI()
	ActivityshopexchangebuyView.super.destroyUI(self)
end

function ActivityshopexchangebuyView:onEnter()
	ActivityshopexchangebuyView.super.onEnter(self)

	local param = self:getOpenParam()

	self._actType = param[1]
	self._actId = param[2]
	self._itemId = param[3]
	self._hasBuyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._actType, self._actId, self._itemId)

	self:_refreshSelect()
end

function ActivityshopexchangebuyView:onEnterFinished()
	ActivityshopexchangebuyView.super.onEnterFinished(self)
end

function ActivityshopexchangebuyView:onExit()
	ActivityshopexchangebuyView.super.onExit(self)
	MaterialMgr.resetAll(self._itemCon)
	MaterialMgr.clearIcon(self._useMatIcon)
	removetimer(self._onCountDown, self)
end

function ActivityshopexchangebuyView:onExitFinished()
	ActivityshopexchangebuyView.super.onExitFinished(self)
end

function ActivityshopexchangebuyView:_refreshSelect()
	self._noBuyCount = false

	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._actType, self._actId, self._itemId)

	if not cfg then
		return
	end

	self._info = cfg

	local goodsInfo = cfg
	local content = goodsInfo.sellContent

	if string.find(goodsInfo.sellContent, "^" .. MatType.Cloth .. ":") then
		local arr = string.split(goodsInfo.sellContent, "#")

		content = arr[Mathf.Min(RoleModel.instance:getGender() + 1, #arr)]
	end

	local strs = string.split(content, ":")
	local matType = checknumber(strs[1])
	local matId = checknumber(strs[2])

	self._buyCount = 1

	local buyTimes = ActivityshopModel.instance:getActiveShopBuyTimes(self._actType, self._actId, self._itemId)

	self._limitTxt.gameObject:SetActive(false)

	if goodsInfo.sellPeriodLimit ~= "none" then
		self._limitTxt.gameObject:SetActive(true)

		self._limitTxt.text = limitPeriod[goodsInfo.sellPeriodLimit] .. "限购 " .. goodsInfo.sellLimitCount - buyTimes .. "/" .. goodsInfo.sellLimitCount
		self._noBuyCount = buyTimes >= goodsInfo.sellLimitCount
	end

	self._haveTxt.text = "拥有：" .. MaterialFacade.instance:getMatNumber(matType, matId)

	self.group:SetState(0)

	local color = MaterialMgr.getGoodsColor(matType, matId)

	if matType == MatType.Pet then
		local cfg = CharacterConfig.instance:getPetInfoCo(matId)

		self._descTxt.text = cfg.introduce
		self._nameTxt.text = GameUtil.HtmlColorTxt(cfg.name, color)
	else
		local matCfg = MaterialMgr.getMatCfg(matType, matId)

		self._descTxt.text = matCfg.desc

		local name = MaterialMgr.getMaterialsName(matType, matId)

		self._nameTxt.text = GameUtil.HtmlColorTxt(name, color)
	end

	local t = GameUtil.parseMatStr2Table(goodsInfo.sellPrice)

	MaterialMgr.setIcon(self._useMatIcon, t[1], t[2])

	local proxy = MaterialMgr.setCellByCfg(content, self._itemCon)

	proxy:setAutoTips(false)

	self._sellLimitCount = self._info.sellLimitCount
	self._sellPrice = self._info.sellPrice

	local isDiscTime = GameUtil.checkTimeStr(self._info.discountTime)
	local showDisc = isDiscTime and not string.nilorempty(self._info.discountPrice)

	if showDisc then
		self._sellPrice = self._info.discountPrice
	end

	self:_refreshBuyCount()
	removetimer(self._onCountDown, self)

	if isDiscTime and ActivityshopModel.instance:getDiscountEndTime(cfg.discountTime) then
		settimer(1, self._onCountDown, self)
	end
end

function ActivityshopexchangebuyView:_buyCountChanged()
	self._buyCount = checknumber(self._input:GetText())

	self:_refreshBuyCount()
end

function ActivityshopexchangebuyView:_refreshBuyCount()
	local matType, matId, matNum = unpack(string.splitToNumber(self._sellPrice, ":"))
	local limitCount = math.floor(MaterialModel.instance:getMaterialsNumber(matType, matId) / matNum)

	print("sr----------------------------       擦1 = ", self._buyCount)

	self._buyCount = math.max(self._buyCount, 1)
	self._buyCount = math.min(self._buyCount, limitCount)

	print("sr----------------------------       擦2  = ", self._buyCount, limitCount)

	self._buyCount = self._sellLimitCount > 0 and math.min(self._buyCount, self._sellLimitCount - self._hasBuyTime) or math.min(self._buyCount, 99)

	local costNum = MaterialFacade.instance:getGoodCostByStr(self._sellPrice)

	self._priceTxt.text = costNum * self._buyCount

	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._actType, self._actId, self._itemId)

	if cfg then
		local isDiscTime = GameUtil.checkTimeStr(cfg.discountTime)
		local showDisc = isDiscTime and not string.nilorempty(cfg.discountPrice)

		if showDisc then
			self._priceTxt.text = MaterialFacade.instance:getGoodCostByStr(cfg.discountPrice) * self._buyCount
		end
	end

	local str = tostring(self._buyCount)

	print("sr----------------------------       擦3333  = ", self._buyCount, str)
	self._input:SetText(str)
end

function ActivityshopexchangebuyView:_onClickAdd()
	self._buyCount = self._buyCount + 1

	self:_refreshBuyCount()
end

function ActivityshopexchangebuyView:_onClickMinus()
	self._buyCount = self._buyCount - 1

	self:_refreshBuyCount()
end

function ActivityshopexchangebuyView:_onClickAddTen()
	self._buyCount = self._buyCount + 10

	self:_refreshBuyCount()
end

function ActivityshopexchangebuyView:_onClickMinusTen()
	self._buyCount = self._buyCount - 10

	self:_refreshBuyCount()
end

function ActivityshopexchangebuyView:_onClickBuy()
	if self._noBuyCount then
		FloatWordMgr.instance:show("商品可购买次数不足")
	elseif self._buyCount > 0 then
		ActivityshopController.instance:buyShopItem(self._actType, self._actId, self._itemId, self._buyCount)
	else
		TipsFacade.instance:openCommonTips(lang("购买数量不能为0"))
	end

	self:_onClickReturn()
end

function ActivityshopexchangebuyView:_onClickReturn()
	self:close()
end

function ActivityshopexchangebuyView:_onCountDown()
	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._actType, self._actId, self._itemId)
	local isDiscountTime = GameUtil.checkTimeStr(cfg.discountTime)

	if not isDiscountTime and ActivityshopModel.instance:getDiscountEndTime(cfg.discountTime) then
		TipsFacade.instance:openCommonTips(lang("折扣刷新"))
		self:_refreshSelect()
	end
end

return ActivityshopexchangebuyView
