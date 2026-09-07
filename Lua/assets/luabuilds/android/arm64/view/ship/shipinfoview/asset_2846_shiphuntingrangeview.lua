local ShipHuntingRangeView = class("ShipHuntingRangeView", import("...base.BaseSubView"))

function ShipHuntingRangeView:getUIName()
	return "ShipHuntingRangeView"
end

function ShipHuntingRangeView:OnInit()
	self.huntingRange = self._tf

	setActive(self.huntingRange, false)

	self.curLevel = self.huntingRange:Find("frame/current_level")
	self.showLevel = self.huntingRange:Find("frame/level/Text")
	self.tips = self.huntingRange:Find("frame/tips")
	self.closeBtn = self.huntingRange:Find("frame/close_btn")
	self.helpBtn = self.huntingRange:Find("frame/help")
	self.cellRoot = self.huntingRange:Find("frame/range")
	self.onSelected = false

	return
end

function ShipHuntingRangeView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function ShipHuntingRangeView:GetShipVO()
	if self.shareData and self.shareData.shipVO then
		return self.shareData.shipVO
	end

	return nil
end

function ShipHuntingRangeView:DisplayHuntingRange()
	self.onSelected = true

	local var_5_0 = self:GetShipVO()

	setActive(self.huntingRange, true)
	self:UpdateHuntingRange(var_5_0, var_5_0:getHuntingLv())
	setText(self.curLevel, "Lv." .. var_5_0:getHuntingLv())
	setText(self.tips, i18n("ship_hunting_level_tips"))
	onButton(self, self.closeBtn, function()
		self:HideHuntingRange()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_hunting.tip
		})

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(self.huntingRange)

	return
end

function ShipHuntingRangeView:UpdateHuntingRange(arg_8_1, arg_8_2)
	local var_8_0 = self.cellRoot

	for iter_8_0 = 0, self.cellRoot.childCount - 1 do
		setActive(self.cellRoot:GetChild(iter_8_0):Find("activate"), false)
	end

	_.each(arg_8_1:getHuntingRange(arg_8_2), function(arg_9_0)
		local var_9_0 = arg_9_0[1] * 7 + arg_9_0[2] + math.floor(24.5)
		local var_9_1 = var_8_0:GetChild(var_9_0)

		if var_9_1 and var_9_0 ~= 24 then
			setActive(var_9_1:Find("activate"), true)
		end

		return
	end)

	local var_8_1 = self.huntingRange:Find("frame/last")
	local var_8_2 = self.huntingRange:Find("frame/next")

	setActive(var_8_1, arg_8_2 > 1)
	setActive(var_8_2, arg_8_2 < #arg_8_1:getConfig("hunting_range"))
	setText(self.showLevel, "Lv." .. arg_8_2)
	onButton(self, var_8_1, function()
		self:UpdateHuntingRange(arg_8_1, (arg_8_2 - 1 == 0 or nil) and #arg_8_1:getConfig("hunting_range"))

		return
	end, SFX_PANEL)
	onButton(self, var_8_2, function()
		self:UpdateHuntingRange(arg_8_1, (arg_8_2 + 1 == #arg_8_1:getConfig("hunting_range") + 1 or nil) and 1)

		return
	end, SFX_PANEL)

	return
end

function ShipHuntingRangeView:HideHuntingRange()
	setActive(self.huntingRange, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.huntingRange, self._tf)

	self.onSelected = false

	return
end

function ShipHuntingRangeView:OnDestroy()
	self:HideHuntingRange()

	self.shareData = nil

	return
end

return ShipHuntingRangeView
