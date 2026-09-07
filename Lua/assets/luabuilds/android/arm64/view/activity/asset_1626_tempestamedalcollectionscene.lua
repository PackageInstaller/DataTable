local TempestaMedalCollectionScene = class("TempestaMedalCollectionScene", import("view.base.BaseUI"))

function TempestaMedalCollectionScene:getUIName()
	return "TempestaMedalCollectionUI"
end

function TempestaMedalCollectionScene:setActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function TempestaMedalCollectionScene:onBackPressed()
	if isActive(self.rtHelpPanel) then
		setActive(self.rtHelpPanel)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.rtHelpPanel, self._tf)

		return
	end

	self:closeView()

	return
end

function TempestaMedalCollectionScene:init()
	onButton(self, self._tf:Find("top/btn_back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	self.rtMainPanel = self._tf:Find("main")

	onButton(self, self.rtMainPanel:Find("btn_help"), function()
		pg.UIMgr.GetInstance():BlurPanel(self.rtHelpPanel)
		setActive(self.rtHelpPanel, true)

		return
	end, SFX_PANEL)

	self.rtHelpPanel = self._tf:Find("help_panel")

	setText(self.rtHelpPanel:Find("window/Text"), i18n("pirate_wanted_help"))
	onButton(self, self.rtHelpPanel:Find("bg"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	return
end

function TempestaMedalCollectionScene:didEnter()
	self:updateTaskLayers()

	return
end

function TempestaMedalCollectionScene:updateTaskLayers()
	local var_9_0 = getProxy(TaskProxy)
	local var_9_1 = underscore.map(self.activity:getConfig("config_data"), function(arg_10_0)
		local var_10_0 = var_9_0:getTaskVO(arg_10_0)

		if not var_10_0 then
			var_10_0 = Task.New({
				submit_time = 1,
				id = arg_10_0
			})

			var_10_0:updateProgress(var_10_0:getConfig("target_num"))
		end

		return var_10_0
	end)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = self.rtMainPanel:Find("tasks"):GetChild(iter_9_0 - 1)

		if iter_9_0 == #var_9_1 then
			setActive(var_9_2:Find("got"), iter_9_1:isReceive())

			local var_9_3 = Drop.Create(iter_9_1:getConfig("award_display")[1])

			onButton(self, var_9_2, function()
				self:emit(BaseUI.ON_DROP, var_9_3)

				return
			end, SFX_PANEL)
		else
			local var_9_4 = {}

			var_9_4.type, var_9_4.id, var_9_4.count = unpack(iter_9_1:getConfig("award_display")[1])

			updateDrop(var_9_2:Find("IconTpl"), var_9_4)
			onButton(self, var_9_2:Find("IconTpl"), function()
				self:emit(BaseUI.ON_DROP, var_9_4)

				return
			end, SFX_PANEL)
			setText(var_9_2:Find("Text"), iter_9_1:getConfig("desc"))

			local var_9_5 = iter_9_1:getTaskStatus()

			setActive(var_9_2:Find("btn_go"), var_9_5 == 0)
			setActive(var_9_2:Find("btn_get"), var_9_5 == 1)
			setActive(var_9_2:Find("btn_got"), var_9_5 == 2)
			onButton(self, var_9_2:Find("btn_go"), function()
				self:emit(TempestaMedalCollectionMediator.ON_TASK_GO, iter_9_1)

				return
			end, SFX_PANEL)
			onButton(self, var_9_2:Find("btn_get"), function()
				self:emit(TempestaMedalCollectionMediator.ON_TASK_SUBMIT, iter_9_1)

				return
			end, SFX_PANEL)
		end
	end

	local var_9_6 = underscore.reduce(var_9_1, 0, function(arg_15_0, arg_15_1)
		return arg_15_0 + (arg_15_1:isReceive() and 1 or 0)
	end)

	setText(self.rtMainPanel:Find("progress/Text"), math.min(var_9_6, #var_9_1 - 1) .. "/" .. #var_9_1 - 1)

	if #var_9_1 - 1 <= var_9_6 and not var_9_1[#var_9_1]:isReceive() then
		self:emit(TempestaMedalCollectionMediator.ON_TASK_SUBMIT, var_9_1[#var_9_1])
	end

	return
end

function TempestaMedalCollectionScene:willExit()
	if isActive(self.rtHelpPanel) then
		self:onBackPressed()
	end

	return
end

return TempestaMedalCollectionScene
