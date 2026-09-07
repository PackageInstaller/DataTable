local PlayerResUI = class("PlayerResUI", pm.Mediator)

PlayerResUI.GO_MALL = "PlayerResUI:GO_MALL"
PlayerResUI.CHANGE_TOUCH_ABLE = "PlayerResUI:CHANGE_TOUCH_ABLE"
PlayerResUI.HIDE = "PlayerResUI:HIDE"
PlayerResUI.SHOW = "PlayerResUI:SHOW"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

PlayerResUI.TYPE_OIL = 2
PlayerResUI.TYPE_GOLD = 4
PlayerResUI.TYPE_GEM = 8
PlayerResUI.TYPE_ALL = bit.bor(2, 4, 8)
PlayerResUI.DEFAULT_MODE = {
	showType = PlayerResUI.TYPE_ALL
}

function PlayerResUI:Ctor()
	PlayerResUI.super.Ctor(self)
	pg.DelegateInfo.New(self)
	pg.m02:registerMediator(self)

	self.state = var_0_1
	self.settingsDic = {}
	self.settingsStack = {}

	return
end

function PlayerResUI:GetPlayer()
	return getProxy(PlayerProxy):getRawData()
end

function PlayerResUI:IsLoaded()
	return self.state > var_0_2
end

function PlayerResUI:IsEnable()
	return self.state == var_0_4
end

function PlayerResUI:Load(arg_5_1)
	if self.state ~= var_0_1 then
		return
	end

	self.state = var_0_2

	PoolMgr.GetInstance():GetUI("ResPanel", true, arg_5_1)

	return
end

function PlayerResUI:Init(arg_6_1)
	self._go = arg_6_1
	self.oilAddBtn = findTF(self._go, "oil")
	self.goldAddBtn = findTF(self._go, "gold")
	self.gemAddBtn = findTF(self._go, "gem")
	self.goldMax = findTF(self._go, "gold/gold_max_value"):GetComponent(typeof(Text))
	self.goldValue = findTF(self._go, "gold/gold_value"):GetComponent(typeof(Text))
	self.oilMax = findTF(self._go, "oil/oil_max_value"):GetComponent(typeof(Text))
	self.oilValue = findTF(self._go, "oil/oil_value"):GetComponent(typeof(Text))
	self.gemValue = findTF(self._go, "gem/gem_value"):GetComponent(typeof(Text))
	self.animation = self._go:GetComponent(typeof(Animation))
	self.gemPos = self.gemAddBtn.anchoredPosition
	self.oilPos = self.oilAddBtn.anchoredPosition
	self.foldableHelper = MainFoldableHelper.New(self._go.transform, Vector2(0, 1))

	onButton(self, self.goldAddBtn, function()
		self:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.oilAddBtn, function()
		self:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.gemAddBtn, function()
		self:ClickGem()

		return
	end, SFX_PANEL)

	self.position = tf(self._go).anchoredPosition

	setActive(self._go, true)

	return
end

function PlayerResUI:SetSettings(arg_10_1, arg_10_2)
	self.settingsDic[arg_10_1] = arg_10_2

	self:Reflush()

	return
end

function PlayerResUI:RemoveSettings(arg_11_1)
	self.settingsDic[arg_11_1] = nil

	self:Reflush()

	return
end

function PlayerResUI:GetWeight(arg_12_1)
	return pg.LayerWeightMgr.GetInstance().groupWeightDic[arg_12_1]
end

function PlayerResUI:Reflush()
	local var_13_0

	for iter_13_0, iter_13_1 in pairs(self.settingsDic) do
		if not var_13_0 or self:GetWeight(var_13_0) < self:GetWeight(iter_13_0) then
			var_13_0 = iter_13_0
		end
	end

	if var_13_0 then
		if (self.settingsDic[var_13_0] or nil) ~= self.topSettings then
			if var_13_0 then
				self.topSettings = self.settingsDic[var_13_0] or nil
			end

			if self.topSettings then
				self:Enable(self.topSettings)
			else
				self:Disable()
			end
		end
	end

	return
end

function PlayerResUI:Enable(arg_14_1)
	if not self:IsLoaded() then
		self:Load(function(arg_15_0)
			self._tf = arg_15_0.transform
			self.state = var_0_4

			self:Init(self._tf:Find("frame").gameObject)
			self:CustomSetting(arg_14_1)
			self:Flush()

			return
		end)
	elseif self.state == var_0_4 then
		self:CustomSetting(arg_14_1)
	else
		self.state = var_0_4

		self:CustomSetting(arg_14_1)
		setActive(self._go, true)

		if self:IsDirty() then
			self:Flush()
		end
	end

	return
end

function PlayerResUI:Disable()
	if pg.goldExchangeMgr then
		pg.goldExchangeMgr:exit()

		pg.goldExchangeMgr = nil
	end

	if self:IsLoaded() then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
		setActive(self._go, false)

		self.state = var_0_3
	end

	return
end

function PlayerResUI:CustomSetting(arg_17_1)
	setActive(self.oilAddBtn, bit.band(arg_17_1.showType, PlayerResUI.TYPE_OIL) > 0)
	setActive(self.goldAddBtn, bit.band(arg_17_1.showType, PlayerResUI.TYPE_GOLD) > 0)
	setActive(self.gemAddBtn, bit.band(arg_17_1.showType, PlayerResUI.TYPE_GEM) > 0)

	if arg_17_1.anim then
		self:DoAnimation()
	end

	local var_17_0 = arg_17_1.gemOffsetX or 0

	self.gemAddBtn.anchoredPosition3D = Vector3(self.gemPos.x + var_17_0, self.gemPos.y, 1)
	self.oilAddBtn.anchoredPosition3D = Vector3(self.oilPos.x + var_17_0, self.oilPos.y, 1)

	pg.UIMgr.GetInstance():OverlayPanel(self._tf, {
		groupName = arg_17_1.groupName,
		groupDelta = arg_17_1.groupDelta
	})

	return
end

function PlayerResUI:DoAnimation()
	self.foldableHelper:Fold(true, 0)
	self.foldableHelper:Fold(false, 0.5)

	return
end

function PlayerResUI:ClickGem()
	local var_19_0 = self:GetPlayer()

	local function var_19_1()
		if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})
		else
			pg.m02:sendNotification(PlayerResUI.GO_MALL)
		end

		return
	end

	if PLATFORM_CODE == PLATFORM_JP then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			fontSize = 23,
			yesText = "text_buy",
			content = i18n("word_diamond_tip", var_19_0:getFreeGem(), var_19_0:getChargeGem(), var_19_0:getTotalGem()),
			onYes = var_19_1,
			alignment = TextAnchor.UpperLeft
		})
	else
		var_19_1()
	end

	return
end

function PlayerResUI:ClickGold()
	pg.goldExchangeMgr = pg.goldExchangeMgr or GoldExchangeView.New()

	return
end

function PlayerResUI:ClickOil()
	local var_22_0 = self:GetPlayer()
	local var_22_2 = ShoppingStreet.getRiseShopId(ShopArgs.BuyOil, var_22_0.buyOilCount)

	if not var_22_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_today_buy_limit"))

		return
	end

	local var_22_3 = pg.shop_template[var_22_2]
	local var_22_4 = pg.shop_template[var_22_2].num

	if pg.shop_template[var_22_2].num == -1 and var_22_3.genre == ShopArgs.BuyOil then
		var_22_4 = ShopArgs.getOilByLevel(var_22_0.level)
	end

	if pg.gameset.buy_oil_limit.key_value > var_22_0.buyOilCount then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			windowSize = {
				y = 570
			},
			content = i18n("oil_buy_tip", var_22_3.resource_num, var_22_4, var_22_0.buyOilCount),
			drop = {
				id = 2,
				type = DROP_TYPE_RESOURCE,
				count = var_22_4
			},
			onYes = function()
				pg.m02:sendNotification(GAME.SHOPPING, {
					isQuickShopping = true,
					count = 1,
					id = var_22_2
				})
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_PAY_OIL)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_oil_buy_limit"),
			custom = {
				{
					text = "text_iknow",
					sound = SFX_CANCEL
				}
			}
		})
	end

	return
end

function PlayerResUI:Flush()
	PlayerResUI.StaticFlush(self:GetPlayer(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)
	self:SetDirty(false)

	return
end

function PlayerResUI:StaticFlush(arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_1.text = "MAX: " .. self:getLevelMaxGold()
	arg_25_2.text = self.gold
	arg_25_3.text = "MAX: " .. self:getLevelMaxOil()
	arg_25_4.text = self.oil
	arg_25_5.text = self:getTotalGem()

	return
end

function PlayerResUI:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Disable()
	pg.m02:removeMediator(self.__cname)
	PoolMgr.GetInstance():ReturnUI("ResPanel", self._go)

	self.state = var_0_1

	return
end

function PlayerResUI:SetDirty(arg_27_1)
	self.dirty = arg_27_1

	return
end

function PlayerResUI:IsDirty()
	return self.dirty
end

function PlayerResUI:Fold(arg_29_1, arg_29_2)
	if not self:IsLoaded() then
		return
	end

	self.foldableHelper:Fold(arg_29_1, arg_29_2)

	return
end

function PlayerResUI:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.GUILD_GET_USER_INFO_DONE,
		GAME.GET_PUBLIC_GUILD_USER_DATA_DONE,
		PlayerResUI.CHANGE_TOUCH_ABLE,
		PlayerResUI.HIDE,
		PlayerResUI.SHOW
	}
end

function PlayerResUI:handleNotification(arg_31_1)
	local var_31_0 = arg_31_1:getName()

	if var_31_0 == PlayerResUI.CHANGE_TOUCH_ABLE then
		local var_31_1 = arg_31_1:getBody()
		local var_31_2 = GetComponent(tf(self._go), typeof(CanvasGroup))

		var_31_2.interactable = var_31_1
		var_31_2.blocksRaycasts = var_31_1

		return
	end

	self:updateResPanel(var_31_0)

	return
end

function PlayerResUI:updateResPanel(arg_32_1)
	if not self:IsEnable() then
		self:SetDirty(true)

		return
	end

	if arg_32_1 == PlayerProxy.UPDATED or arg_32_1 == GAME.GUILD_GET_USER_INFO_DONE or arg_32_1 == GAME.GET_PUBLIC_GUILD_USER_DATA_DONE then
		self:Flush()
	end

	return
end

function PlayerResUI:checkBackPressed()
	if pg.goldExchangeMgr then
		pg.goldExchangeMgr:exit()

		pg.goldExchangeMgr = nil

		return true
	else
		return false
	end

	return
end

return PlayerResUI
