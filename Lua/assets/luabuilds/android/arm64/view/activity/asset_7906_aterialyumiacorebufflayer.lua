local AterialYumiaCoreBuffLayer = class("AterialYumiaCoreBuffLayer", import("view.base.BaseUI"))

function AterialYumiaCoreBuffLayer:getUIName()
	return "AterialYumiaCoreBuffLayer"
end

function AterialYumiaCoreBuffLayer:SetActivity(arg_2_1)
	self.activity = arg_2_1
	self.config = arg_2_1:getConfig("config_client").core_tasks

	return
end

function AterialYumiaCoreBuffLayer:init()
	self.rtBg = self._tf:Find("bg")
	self.btnReturn = self._tf:Find("adapt/bottom/btn_return")

	onButton(self, self.btnReturn, function()
		if self.inAnim then
			return
		end

		self.inAnim = true

		quickPlayAnimation(self._tf, "Anim_AteriaYumiaCoreBuffLayer_Out")

		return
	end, SFX_CANCEL)

	self.rtUpgrade = self._tf:Find("upgrade")

	setActive(self.rtUpgrade, false)
	onButton(self, self.rtUpgrade:Find("top/btn_back"), function()
		if self.inAnim then
			return
		end

		self.inAnim = true

		quickPlayAnimation(self.rtUpgrade, "Anim_AteriaYumiaCoreBuffLayer_upgrade_Out")

		return
	end, SFX_CANCEL)
	self.rtUpgrade:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self.inAnim = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self.rtUpgrade, self._tf)
		setActive(self.rtUpgrade, false)

		return
	end)
	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self.inAnim = false

		self:closeView()

		return
	end)

	return
end

function AterialYumiaCoreBuffLayer:didEnter()
	self:UpdateView()

	return
end

function AterialYumiaCoreBuffLayer:UpdateView()
	for iter_9_0, iter_9_1 in ipairs(self.config) do
		local var_9_0 = {}

		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			local var_9_1 = getProxy(TaskProxy):getTaskVO(iter_9_3)

			if var_9_1 and var_9_1:isReceive() then
				table.insert(var_9_0, var_9_1)
			end
		end

		local var_9_2 = self.rtBg:Find(tostring(iter_9_0))

		setText(var_9_2:Find("name/Text"), i18n("yumia_buff_name_" .. iter_9_0))
		setText(var_9_2:Find("name/level"), string.format("LV.<size=30>%s</size>", #var_9_0))
		UIItemList.StaticAlign(var_9_2:Find("buffs"), var_9_2:Find("buffs/tpl"), #var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
			arg_10_1 = arg_10_1 + 1

			if arg_10_0 == UIItemList.EventUpdate then
				GetImageSpriteFromAtlasAsync(Drop.Create(var_9_0[arg_10_1]:getConfig("award_display")[1]):getIcon(), "", arg_10_2, false)
			end

			return
		end)
		onButton(self, var_9_2, function()
			self:ShowUpgrade(iter_9_0)
			pg.UIMgr.GetInstance():BlurPanel(self.rtUpgrade)
			setActive(self.rtUpgrade, true)

			for iter_11_0 = 1, 4 do
				local var_11_0 = self.rtUpgrade:Find("main/ring"):Find("lv" .. iter_11_0)

				setCanvasGroupAlpha(var_11_0, 0)

				local var_11_1 = {}

				if iter_11_0 > 1 then
					table.insert(var_11_1, function(arg_12_0)
						onDelayTick(arg_12_0, (iter_11_0 - 1) * 0.08)

						return
					end)
				end

				seriesAsync(var_11_1, function()
					quickPlayAnimation(var_11_0, string.format("Anim_AteriaYumiaCoreBuffLayer_lv%d_In", iter_11_0))

					return
				end)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function AterialYumiaCoreBuffLayer:ShowUpgrade(arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or self.index
	self.index = arg_14_1

	local var_14_0 = self.config[arg_14_1]
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(self.config[arg_14_1]) do
		local var_14_2 = getProxy(TaskProxy)
		local var_14_3 = var_14_2:getTaskVO(iter_14_1)
		local var_14_4 = self.rtUpgrade:Find("main/ring"):Find("lv" .. iter_14_0)
		local var_14_5 = var_14_3:isReceive()

		if var_14_2 then
			var_14_1 = iter_14_0

			local var_14_6 = Drop.Create(var_14_3:getConfig("award_display")[1])

			GetImageSpriteFromAtlasAsync(var_14_6:getIcon(), "", var_14_4:Find("active/icon"), false)
			setText(var_14_4:Find("active/icon/name"), var_14_6:getName())
			setText(var_14_4:Find("active/icon/Text"), var_14_6.desc)
		else
			setText(var_14_4:Find("inactive/Text"), i18n("yumia_buff_4", iter_14_0))
		end

		if arg_14_2 and not isActive(var_14_4:Find("active")) and var_14_5 then
			quickPlayAnimation(var_14_4, "Anim_AteriaYumiaCoreBuffLayer_active")
		end

		setActive(var_14_4:Find("active"), var_14_5)
		setActive(var_14_4:Find("inactive"), not var_14_5)
	end

	local var_14_7 = self.rtUpgrade:Find("main/content")

	setText(var_14_7:Find("icon/core_name"), i18n("yumia_buff_name_" .. arg_14_1))
	setText(var_14_7:Find("icon/desc"), i18n("yumia_buff_desc_" .. arg_14_1))

	if arg_14_2 then
		var_14_7:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setText(var_14_7:Find("icon/level"), string.format("LV.<size=50><color=#ffffff00>%s</color></size>", var_14_1))
			setText(var_14_7:Find("icon/level/number"), string.format("<size=50>%s</size>", var_14_1))
			onNextTick(function()
				setCanvasGroupAlpha(var_14_7:Find("icon/level/number"), 1)

				return
			end)

			return
		end)
		quickPlayAnimation(var_14_7, "Anim_AteriaYumiaCoreBuffLayer_active_Level")
	else
		setText(var_14_7:Find("icon/level"), string.format("LV.<size=50><color=#ffffff00>%s</color></size>", var_14_1))
		setText(var_14_7:Find("icon/level/number"), string.format("<size=50>%s</size>", var_14_1))
	end

	local var_14_8 = getProxy(TaskProxy):getTaskVO(var_14_0[math.min(var_14_1 + 1, #var_14_0)])
	local var_14_9 = var_14_8:getGiveDrops()

	setText(var_14_7:Find("cost/Text"), i18n("yumia_buff_1"))
	UIItemList.StaticAlign(var_14_7:Find("cost/container"), var_14_7:Find("cost/container/IconTpl"), #var_14_9, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_14_9[arg_17_1]

			updateDrop(arg_17_2, var_14_9[arg_17_1])
			setText(arg_17_2:Find("icon_bg/count"), string.format("%d/%d", var_14_9[arg_17_1]:getOwnedCount(), var_14_9[arg_17_1].count))
			onButton(self, arg_17_2, function()
				self:emit(BaseUI.ON_DROP, var_17_0)

				return
			end, SFX_PANEL)
			setCanvasGroupAlpha(arg_17_2, 0)

			if arg_17_1 > 1 then
				onDelayTick(function()
					quickPlayAnimation(arg_17_2, "Anim_AteriaYumiaCoreBuffLayer_tpl")

					return
				end, 0.08 * (arg_17_1 - 1))
			else
				quickPlayAnimation(arg_17_2, "Anim_AteriaYumiaCoreBuffLayer_tpl")
			end
		end

		return
	end)

	local var_14_10 = var_14_8:getTaskStatus()

	setActive(var_14_7:Find("btn_lock"), var_14_10 == 0)
	setText(var_14_7:Find("btn_lock/Text"), i18n("yumia_buff_2"))
	setActive(var_14_7:Find("btn_confirm"), var_14_10 == 1)
	setText(var_14_7:Find("btn_confirm/Text"), i18n("yumia_buff_2"))
	setActive(var_14_7:Find("btn_finish"), var_14_10 == 2)
	setText(var_14_7:Find("btn_finish/Text"), i18n("yumia_buff_3"))
	onButton(self, var_14_7:Find("btn_confirm"), function()
		self:emit(AterialYumiaCoreBuffMediator.SUBMIT_TASK, var_14_8.id)

		return
	end, SFX_CONFIRM)

	return
end

function AterialYumiaCoreBuffLayer:willExit()
	if isActive(self.rtUpgrade) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.rtUpgrade, self._tf)
		setActive(self.rtUpgrade, false)
	end

	return
end

function AterialYumiaCoreBuffLayer:onBackPressed()
	if isActive(self.rtUpgrade) then
		triggerButton(self.rtUpgrade:Find("top/btn_back"))
	else
		triggerButton(self.btnReturn)
	end

	return
end

return AterialYumiaCoreBuffLayer
