local WorldAutoFightRewardLayer = class("WorldAutoFightRewardLayer", BaseUI)

function WorldAutoFightRewardLayer:getUIName()
	return "WorldAutoFightRewardUI"
end

local var_0_1 = 0.1

function WorldAutoFightRewardLayer:init()
	self.window = self._tf:Find("Window")
	self.boxView = self.window:Find("Layout/Box/ScrollView")
	self.emptyTip = self.window:Find("Layout/Box/EmptyTip")
	self.itemList = self.boxView:Find("Content/ItemGrid")

	setText(self.emptyTip, i18n("autofight_rewards_none"))
	setText(self.window:Find("Fixed/top/bg/obtain/title"), i18n("autofight_rewards"))
	setText(self.boxView:Find("Content/Title/Text"), i18n("battle_end_subtitle1"))

	return
end

function WorldAutoFightRewardLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:UpdateView()

	local var_3_0 = getProxy(MetaCharacterProxy):getMetaTacticsInfoOnEnd()

	if var_3_0 and #var_3_0 > 0 then
		self.metaExpView = MetaExpView.New(self.window:Find("Layout"), self.event, self.contextData)

		self.metaExpView:setData(var_3_0)
		self.metaExpView:Reset()
		self.metaExpView:Load()
		self.metaExpView:ActionInvoke("Show")
	end

	return
end

function WorldAutoFightRewardLayer:willExit()
	self:SkipAnim()

	if self.metaExpView then
		self.metaExpView:Destroy()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function WorldAutoFightRewardLayer:UpdateView()
	local var_5_0 = self.contextData

	onButton(self, self._tf:Find("BG"), function()
		if self.isRewardAnimating then
			self:SkipAnim()

			return
		end

		existCall(var_5_0.onClose)
		self:closeView()

		return
	end)
	setText(self.window:Find("Fixed/ButtonExit/pic"), i18n("autofight_leave"))
	onButton(self, self.window:Find("Fixed/ButtonExit"), function()
		existCall(var_5_0.onClose)
		self:closeView()

		return
	end, SFX_CANCEL)

	local var_5_1 = nowWorld()
	local var_5_2 = var_5_1.autoInfos

	var_5_1:InitAutoInfos()
	DropResultIntegration(var_5_2.drops)

	local var_5_3 = underscore.map(var_5_2.drops, function(arg_8_0)
		if arg_8_0.type == DROP_TYPE_WORLD_COLLECTION then
			assert(WorldCollectionProxy.GetCollectionType(arg_8_0.id) == WorldCollectionProxy.WorldCollectionType.FILE, string.format("collection drop type error#%d", arg_8_0.id))
			table.insert(var_5_2.message, i18n("autofight_file", WorldCollectionProxy.GetCollectionTemplate(arg_8_0.id).name))
		else
			return {
				drop = arg_8_0
			}
		end

		return
	end)

	for iter_5_0, iter_5_1 in ipairs(var_5_2.salvage) do
		DropResultIntegration(iter_5_1)
		underscore.each(iter_5_1, function(arg_9_0)
			table.insert(var_5_3, {
				drop = arg_9_0,
				salvage = iter_5_0
			})

			return
		end)
	end

	local var_5_4 = true
	local var_5_5 = {}

	setActive(self.boxView:Find("Content/Title"), false)
	setActive(self.itemList, false)

	self.hasRewards = #var_5_3 > 0

	if self.hasRewards then
		var_5_4 = false

		table.insert(var_5_5, function(arg_10_0)
			setActive(self.boxView:Find("Content/Title"), true)
			setActive(self.itemList, true)
			arg_10_0()

			return
		end)

		local var_5_6 = CustomIndexLayer.Clone2Full(self.itemList, #var_5_3)

		for iter_5_2, iter_5_3 in ipairs(var_5_3) do
			local var_5_7 = iter_5_3.drop

			updateDrop(var_5_6[iter_5_2]:Find("Shell/Icon"), iter_5_3.drop)
			onButton(self, var_5_6[iter_5_2]:Find("Shell/Icon"), function()
				self:emit(BaseUI.ON_DROP, var_5_7)

				return
			end, SFX_PANEL)
			setActive(var_5_6[iter_5_2]:Find("salvage"), iter_5_3.salvage)

			if iter_5_3.salvage then
				eachChild(var_5_6[iter_5_2]:Find("salvage"), function(arg_12_0)
					setActive(arg_12_0, arg_12_0.name == tostring(iter_5_3.salvage))

					return
				end)
			end
		end

		self.isRewardAnimating = true

		for iter_5_4 = 1, #var_5_3 do
			local var_5_9 = var_5_6[iter_5_4]

			setActive(var_5_6[iter_5_4], false)
			table.insert(var_5_5, function(arg_13_0)
				if self.exited then
					return
				end

				setActive(var_5_9, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_13_0)).uniqueId

				return
			end)
		end
	end

	setActive(self.boxView:Find("Content/TextArea"), false)

	local var_5_10 = {}

	for iter_5_5, iter_5_6 in ipairs(var_5_2.buffs) do
		if var_5_10[iter_5_6.id] then
			-- block empty
		else
			var_5_10[iter_5_6.id] = iter_5_6.before
		end
	end

	local var_5_11 = underscore.map(pg.gameset.world_mapbuff_list.description, function(arg_14_0)
		if not var_5_10[arg_14_0] then
			return 0
		else
			return var_5_1:GetGlobalBuff(arg_14_0):GetFloor() - var_5_10[arg_14_0]
		end

		return
	end)

	if underscore.any(var_5_11, function(arg_15_0)
		return arg_15_0 ~= 0
	end) then
		table.insert(var_5_2.message, i18n("autofight_effect", unpack(var_5_11)))
	end

	self.hasEventMsg = #var_5_2.message > 0

	if self.hasEventMsg then
		var_5_4 = false

		setText(self.boxView:Find("Content/TextArea/Text"), table.concat(var_5_2.message, "\n"))
		table.insert(var_5_5, function(arg_16_0)
			setActive(self.boxView:Find("Content/TextArea"), true)
			arg_16_0()

			return
		end)
	end

	setActive(self.boxView, not var_5_4)
	setActive(self.emptyTip, var_5_4)
	seriesAsync(var_5_5, function()
		self:SkipAnim()

		return
	end)

	return
end

function WorldAutoFightRewardLayer:SkipAnim()
	if not self.isRewardAnimating then
		return
	end

	self.isRewardAnimating = nil

	if self.LTid then
		LeanTween.cancel(self.LTid)

		self.LTid = nil
	end

	eachChild(self.itemList, function(arg_19_0)
		setActive(arg_19_0, true)

		return
	end)
	setActive(self.boxView:Find("Content/Title"), self.hasRewards)
	setActive(self.itemList, self.hasRewards)
	setActive(self.boxView:Find("Content/TextArea"), self.hasEventMsg)

	return
end

return WorldAutoFightRewardLayer
