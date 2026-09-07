local CommanderBuildPoolPanel = class("CommanderBuildPoolPanel", import("...base.BaseSubView"))

function CommanderBuildPoolPanel:getUIName()
	return "CommanderBuildPoolUI"
end

local var_0_1 = 10

function CommanderBuildPoolPanel:OnLoaded()
	self.buildPoolList = UIItemList.New(self._tf:Find("frame/bg/content/list"), self._tf:Find("frame/bg/content/list/1"))

	local var_2_0 = self._tf:Find("frame/bg/content/queue/list1/pos")

	self.posListTop = UIItemList.New(self._tf:Find("frame/bg/content/queue/list1"), var_2_0)
	self.posListBottom = UIItemList.New(self._tf:Find("frame/bg/content/queue/list2"), var_2_0)
	self.autoBtn = self._tf:Find("frame/bg/auto_btn")
	self.startBtn = self._tf:Find("frame/bg/start_btn")
	self.selectedTxt = self._tf:Find("statistics/Text"):GetComponent(typeof(Text))

	local var_2_1 = {}

	var_2_1[1] = self._tf:Find("frame/bg/content/list/1/icon/iconImg"):GetComponent(typeof(Image)).sprite
	var_2_1[2] = self._tf:Find("frame/bg/content/list/2/icon/iconImg"):GetComponent(typeof(Image)).sprite
	var_2_1[3] = self._tf:Find("frame/bg/content/list/3/icon/iconImg"):GetComponent(typeof(Image)).sprite
	self.sprites = var_2_1

	setText(self._tf:Find("frame/bg/content/Text"), i18n("commander_use_box_tip"))
	setText(self._tf:Find("frame/bg/content/queue/title/Text"), i18n("commander_use_box_queue"))

	return
end

function CommanderBuildPoolPanel:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/bg/close_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.autoBtn, function()
		if #self.selected >= var_0_1 then
			return
		end

		self:AutoSelect()
		self:UpdatePos()

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		if #self.selected == 0 then
			return
		end

		self.contextData.msgBox:ExecuteAction("Show", {
			content = i18n("commander_select_box_tip", #self.selected),
			onYes = function()
				self:emit(CommanderCatMediator.BATCH_BUILD, self.selected)
				self:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function CommanderBuildPoolPanel:AutoSelect()
	local function var_9_1()
		local var_10_0

		for iter_10_0, iter_10_1 in pairs(self.counts) do
			if iter_10_1 > 0 then
				var_10_0 = iter_10_0
			end
		end

		return var_10_0
	end

	for iter_9_0 = 1, var_0_1 - #self.selected do
		local var_9_2 = var_9_1()

		if var_9_2 then
			self:ReduceCount(var_9_2, -1)
		end
	end

	return
end

function CommanderBuildPoolPanel:Show(arg_11_1, arg_11_2)
	var_0_1 = arg_11_2
	self.selected = {}
	self.pools = arg_11_1

	local var_11_0 = self.pools

	self.counts = {}

	for iter_11_0, iter_11_1 in ipairs(self.pools) do
		self.counts[iter_11_1.id] = iter_11_1:getItemCount()
	end

	self.boxesTxt = {}

	table.sort(self.pools, function(arg_12_0, arg_12_1)
		return arg_12_0.id < arg_12_1.id
	end)
	self.buildPoolList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_11_0[arg_13_1 + 1]

			pressPersistTrigger(arg_13_2:Find("icon"), 0.5, function(arg_14_0)
				if #self.selected < var_0_1 and self.counts[var_13_0.id] > 0 then
					self:ReduceCount(var_13_0.id, -1)
				else
					arg_14_0()
				end

				return
			end, nil, true, true, 0.15, SFX_PANEL)
			setText(arg_13_2:Find("name"), var_11_0[arg_13_1 + 1]:getName())

			self.boxesTxt[var_11_0[arg_13_1 + 1].id] = arg_13_2:Find("Text")

			self:ReduceCount(var_11_0[arg_13_1 + 1].id, 0)
		end

		return
	end)
	self.buildPoolList:align(#self.pools)
	self:UpdatePos()
	setActive(self._tf, true)

	self.isShow = true

	return
end

function CommanderBuildPoolPanel:ReduceCount(arg_15_1, arg_15_2, arg_15_3)
	assert(arg_15_2 == 1 or arg_15_2 == 0 or arg_15_2 == -1)

	self.counts[arg_15_1] = self.counts[arg_15_1] + arg_15_2

	setText(self.boxesTxt[arg_15_1], self.counts[arg_15_1] + arg_15_2)

	if arg_15_2 < 0 then
		table.insert(self.selected, arg_15_1)
		self:UpdatePos()
	elseif arg_15_2 > 0 then
		table.remove(self.selected, arg_15_3)
		self:UpdatePos()
	end

	return
end

function CommanderBuildPoolPanel:poolId2Sprite(arg_16_1)
	return self.sprites[arg_16_1]
end

function CommanderBuildPoolPanel:UpdatePos()
	local function var_17_0(arg_18_0, arg_18_1)
		local var_18_0 = self.selected[arg_18_0]
		local var_18_1 = arg_18_1:Find("icon")

		if self.selected[arg_18_0] then
			var_18_1:GetComponent(typeof(Image)).sprite = self:poolId2Sprite(var_18_0)

			onButton(self, var_18_1, function()
				self:ReduceCount(var_18_0, 1, arg_18_0)

				return
			end, SFX_PANEL)
		else
			setText(arg_18_1:Find("empty/Text"), arg_18_0)
		end

		setActive(arg_18_1:Find("empty"), not var_18_0)
		setActive(var_18_1, var_18_0)

		return
	end

	self.posListTop:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			var_17_0(arg_20_1 + 1, arg_20_2)
		end

		return
	end)
	self.posListTop:align(math.min(5, var_0_1))
	self.posListBottom:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			var_17_0(arg_21_1 + 6, arg_21_2)
		end

		return
	end)
	self.posListBottom:align(math.max(0, math.min(5, var_0_1 - 5)))

	self.selectedTxt.text = #self.selected .. "/" .. var_0_1

	return
end

function CommanderBuildPoolPanel:Hide()
	setActive(self._tf, false)

	self.isShow = false

	return
end

function CommanderBuildPoolPanel:OnDestroy()
	return
end

return CommanderBuildPoolPanel
