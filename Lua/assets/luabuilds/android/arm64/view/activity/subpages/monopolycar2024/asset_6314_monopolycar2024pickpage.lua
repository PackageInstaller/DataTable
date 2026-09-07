local MonopolyCar2024PickPage = class("MonopolyCar2024PickPage", import("view.base.BaseSubView"))

function MonopolyCar2024PickPage:getUIName()
	return "MonopolyCar2024PickUI"
end

function MonopolyCar2024PickPage:OnLoaded()
	self.confirmBtn = self._tf:Find("confirm")
	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self.anim:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		MonopolyCar2024PickPage.super.Hide(self)

		return
	end)

	self.items = {
		self._tf:Find("list/1"),
		self._tf:Find("list/2"),
		self._tf:Find("list/3")
	}

	setText(self._tf:Find("title/Text"), i18n("MonopolyCar2024Game_pick_tip"))
	setText(self.confirmBtn:Find("Text"), i18n("MonopolyCar2024Game_sel_label"))

	return
end

function MonopolyCar2024PickPage:OnInit()
	self.selectedId = 0

	onButton(self, self.confirmBtn, function()
		if self.selectedId <= 0 then
			return
		end

		if self.callback then
			self.callback(self.selectedId)
		end

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2024PickPage:UpdateList()
	for iter_6_0, iter_6_1 in ipairs(self.items) do
		local var_6_0 = table.contains(self.banList, iter_6_0)

		onToggle(self, iter_6_1, function(arg_7_0)
			if arg_7_0 then
				self.selectedId = iter_6_0
			end

			return
		end, SFX_PANEL)
		setToggleEnabled(iter_6_1, not var_6_0)
		warning(iter_6_0, var_6_0)
		setActive(iter_6_1:Find(iter_6_0 .. "/active"), not var_6_0)
		setActive(iter_6_1:Find(iter_6_0 .. "/coin"), self.banCount < 3 and not var_6_0)

		if not var_6_0 then
			triggerToggle(iter_6_1, true)
		end
	end

	return
end

function MonopolyCar2024PickPage:Show(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	MonopolyCar2024PickPage.super.Show(self)

	self.activityId = arg_8_1
	self.turnCnt = arg_8_4
	self.banCount = #arg_8_2
	self.banList = self.banCount >= 3 and {} or arg_8_2
	self.callback = arg_8_5

	self:UpdateList()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.anim:Play("anim_monopolycar_pick_in")
	self:CheckAuto(arg_8_3)

	return
end

function MonopolyCar2024PickPage:CheckAuto(arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self.items) do
		if not table.contains(self.banList, iter_9_0) then
			table.insert(var_9_0, iter_9_0)
		end
	end

	self.selectedId = var_9_0[math.random(1, #var_9_0)]

	if self.callback then
		self.callback(self.selectedId)
	end

	return
end

function MonopolyCar2024PickPage:Hide()
	self.anim:Play("anim_monopolycar_pick_out")

	for iter_10_0, iter_10_1 in ipairs(self.items) do
		triggerToggle(iter_10_1, false)
	end

	self.selectedId = 0

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function MonopolyCar2024PickPage:OnDestroy()
	return
end

return MonopolyCar2024PickPage
