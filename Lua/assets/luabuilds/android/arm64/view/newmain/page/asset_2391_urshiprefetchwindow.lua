local UrShipRefetchWindow = class("UrShipRefetchWindow", import("view.base.BaseSubView"))

function UrShipRefetchWindow:getUIName()
	return "UrShipReFetchWindow"
end

function UrShipRefetchWindow:OnLoaded()
	self.shipTpl = self._tf:Find("window/content/ships/itemtpl")
	self.contentTxt = self._tf:Find("window/content/Text"):GetComponent(typeof(Text))
	self.cntTxt = self._tf:Find("window/content/count"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("window/confirm_btn")

	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))
	setText(self.confirmBtn:Find("pic"), i18n("word_take"))

	return
end

function UrShipRefetchWindow:Show(arg_3_1)
	UrShipRefetchWindow.super.Show(self)
	self:UpdateUrShipAndContent(arg_3_1)
	self:RegisterEvent(arg_3_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

local function var_0_1(arg_4_0)
	local var_4_0 = pg.ship_data_create_exchange[arg_4_0:getConfig("config_id")]

	return arg_4_0.data1, math.min(var_4_0.exchange_available_times, arg_4_0.data2 + 1) * var_4_0.exchange_request, var_4_0.exchange_ship_id[1]
end

local function var_0_2(arg_5_0)
	return arg_5_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function UrShipRefetchWindow:UpdateUrShipAndContent(arg_6_1)
	local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_1)
	local var_6_1, var_6_2, var_6_3 = var_0_1(var_6_0)

	updateDrop(self.shipTpl, {
		type = DROP_TYPE_SHIP,
		id = var_6_3
	})

	self.contentTxt.text = i18n("urdraw_tip")

	self:AddTimer(var_6_0, var_6_1, var_6_2)

	return
end

function UrShipRefetchWindow:AddTimer(arg_7_1, arg_7_2, arg_7_3)
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:UpdateTimeTxt(var_0_2(arg_7_1), arg_7_2, arg_7_3)

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function UrShipRefetchWindow:UpdateTimeTxt(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == 0 then
		pg.m02:sendNotification(MainUrShipReFetchSequence.ON_TIME_UP)

		return
	end

	local var_9_0, var_9_1, var_9_2, var_9_3 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_9_1)

	self.cntTxt.text = i18n("urdraw_complement", arg_9_2 .. "/" .. arg_9_3, var_9_0 == 0 and var_9_1 == 0 and var_9_2 == 0 and var_9_3 > 0 and var_9_3 .. i18n("word_second") or var_9_0 .. i18n("word_date") .. var_9_1 .. i18n("word_hour") .. var_9_2 .. i18n("word_minute"))

	return
end

function UrShipRefetchWindow:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function UrShipRefetchWindow:RegisterEvent(arg_11_1)
	onButton(self, self.confirmBtn, function()
		pg.m02:sendNotification(GAME.GRAFTING_ACT_OP, {
			cmd = 2,
			id = arg_11_1
		})

		return
	end, SFX_CONFIRM)

	return
end

function UrShipRefetchWindow:Hide()
	UrShipRefetchWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	removeOnButton(self.confirmBtn)
	self:RemoveTimer()

	return
end

function UrShipRefetchWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return UrShipRefetchWindow
