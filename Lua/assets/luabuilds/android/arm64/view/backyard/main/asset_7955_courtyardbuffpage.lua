local CourtYardBuffPage = class("CourtYardBuffPage", import("...base.BaseSubView"))

function CourtYardBuffPage:getUIName()
	return "CourtYardBuffListPanel"
end

function CourtYardBuffPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.uiItemList = UIItemList.New(self._tf:Find("frame/list/content"), self._tf:Find("frame/list/content/tpl"))
	self.totalExp = self._tf:Find("frame/subtitle/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/title"), i18n("courtyard_label_exp_addition"))
	setText(self._tf:Find("frame/subtitle"), i18n("courtyard_label_total_exp_addition"))

	self.timers = {}

	return
end

function CourtYardBuffPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CourtYardBuffPage:Show(arg_6_1)
	CourtYardBuffPage.super.Show(self)
	self:Flush(arg_6_1)

	self.list = arg_6_1

	return
end

function CourtYardBuffPage:Flush(arg_7_1)
	local var_7_0 = 0
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1:getLeftTime() > 0 then
			table.insert(var_7_1, iter_7_1)
		end
	end

	self.uiItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			updateDrop(arg_8_2:Find("award"), {
				count = 0,
				type = DROP_TYPE_BUFF,
				id = var_7_1[arg_8_1 + 1].id
			})
			setText(arg_8_2:Find("Text"), var_7_1[arg_8_1 + 1]:getConfig("desc"))
			self:AddTimer(arg_8_2:Find("time"), var_7_1[arg_8_1 + 1])

			var_7_0 = var_7_0 + tonumber((var_7_1[arg_8_1 + 1]:getConfig("benefit_effect")))
		end

		return
	end)
	self.uiItemList:align(#var_7_1)

	self.totalExp.text = 0 .. "%"

	return
end

function CourtYardBuffPage:AddTimer(arg_9_1, arg_9_2)
	self:RemoveTimer(arg_9_2.id)

	local var_9_0 = Timer.New(function()
		local var_10_0 = arg_9_2:getLeftTime()

		if var_10_0 > 0 then
			local var_10_1 = pg.TimeMgr.GetInstance():DescCDTime(var_10_0)

			setText(arg_9_1, var_10_0 <= 600 and setColorStr(var_10_1, COLOR_RED) or setColorStr(var_10_1, "#72bc42"))
		else
			self:RemoveTimer(arg_9_2.id)
			self:Flush(self.list)
		end

		return
	end, 1, -1)

	var_9_0.func()
	var_9_0:Start()

	self.timers[arg_9_2.id] = var_9_0

	return
end

function CourtYardBuffPage:RemoveTimer(arg_11_1)
	if self.timers[arg_11_1] then
		self.timers[arg_11_1]:Stop()

		self.timers[arg_11_1] = nil
	end

	return
end

function CourtYardBuffPage:RemoveAllTimer()
	for iter_12_0, iter_12_1 in pairs(self.timers or {}) do
		iter_12_1:Stop()
	end

	self.timers = {}

	return
end

function CourtYardBuffPage:OnDestroy()
	self:RemoveAllTimer()

	return
end

return CourtYardBuffPage
