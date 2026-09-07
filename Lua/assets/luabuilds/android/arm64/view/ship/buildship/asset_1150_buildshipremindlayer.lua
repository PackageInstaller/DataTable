local BuildShipRemindLayer = class("BuildShipRemindLayer", import("...base.BaseUI"))

function BuildShipRemindLayer:getUIName()
	return "BuildShipRemindUI"
end

function BuildShipRemindLayer:setShips(arg_2_1)
	self.ships = arg_2_1

	return
end

function BuildShipRemindLayer:init()
	local var_3_0 = self._tf:Find("window")

	setText(var_3_0:Find("top/bg/infomation/title"), i18n("title_info"))

	self.btnBack = var_3_0:Find("top/btnBack")
	self.btnConfirm = var_3_0:Find("button_container/confirm")

	setText(self.btnConfirm:Find("pic"), i18n("text_confirm"))

	local var_3_1 = var_3_0:Find("item_panel")

	setText(var_3_1:Find("word/Text"), i18n("last_building_not_shown"))

	self.toggleLock = var_3_1:Find("lock_toggle")

	local var_3_2 = var_3_1:Find("scrollview")

	self.shipItemList = UIItemList.New(var_3_2, var_3_2:Find("item_tpl"))

	self.shipItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.ships[arg_4_1]
			local var_4_1 = {
				count = 1,
				type = DROP_TYPE_SHIP,
				id = self.ships[arg_4_1].configId,
				virgin = self.ships[arg_4_1].virgin
			}

			updateDrop(arg_4_2:Find("IconTpl"), var_4_1)
			onButton(self, arg_4_2, function()
				self:emit(BuildShipRemindLayer.ON_DROP, var_4_1)

				return
			end, SFX_PANEL)
			onLongPressTrigger(self, arg_4_2, function()
				self:emit(BuildShipRemindMediator.SHOW_NEW_SHIP, var_4_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function BuildShipRemindLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.btnBack, function()
		self:exitCheck()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnConfirm, function()
		self:exitCheck()

		return
	end, SFX_CONFIRM)
	onToggle(self, self.toggleLock, function(arg_10_0)
		self.isLockNew = arg_10_0

		return
	end, SFX_PANEL)
	triggerToggle(self.toggleLock, false)
	self.shipItemList:align(#self.ships)

	return
end

function BuildShipRemindLayer:exitCheck()
	local var_11_0 = {}

	if self.isLockNew then
		local var_11_1 = underscore(self.ships):chain():filter(function(arg_12_0)
			return arg_12_0.virgin
		end):map(function(arg_13_0)
			return arg_13_0.id
		end):value()

		if #var_11_1 > 0 then
			table.insert(var_11_0, function(arg_14_0)
				self:emit(BuildShipRemindMediator.ON_LOCK, var_11_1, Ship.LOCK_STATE_LOCK, arg_14_0)

				return
			end)
		end
	end

	seriesAsync(var_11_0, function()
		self:closeView()

		return
	end)

	return
end

function BuildShipRemindLayer:onBackPressed()
	return
end

function BuildShipRemindLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BuildShipRemindLayer
