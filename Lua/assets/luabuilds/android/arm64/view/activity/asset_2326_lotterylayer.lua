local LotteryLayer = class("LotteryLayer", import("..base.BaseUI"))
local var_0_1 = pg.activity_random_award_template
local var_0_2 = true

function LotteryLayer:getUIName()
	if var_0_2 then
		return "LotteryForCHTUI"
	else
		return "LotteryUI"
	end

	return
end

function LotteryLayer:setPlayerVO(arg_2_1)
	self.playerVO = arg_2_1

	self:updateResource()

	return
end

function LotteryLayer:updateResource()
	self.resCount = self.playerVO[id2res(self.resId)]

	setText(self.resource:Find("Text"), self.resCount)

	return
end

function LotteryLayer:setActivity(arg_4_1)
	self.activityVO = arg_4_1
	self.resId = self.activityVO:getConfig("config_client").resId
	self.awardInfos = arg_4_1:getAwardInfos()

	self:initActivityPools()

	return
end

function LotteryLayer:initActivityPools()
	self.activityPools = {}

	local var_5_0 = self.activityVO:getConfig("config_data")

	for iter_5_0, iter_5_1 in ipairs((_.select(var_0_1.all, function(arg_6_0)
		return table.contains(var_5_0, arg_6_0)
	end))) do
		local var_5_1 = ActivityItemPool.New({
			id = iter_5_1,
			awards = self.awardInfos[iter_5_1],
			prevId = nil,
			index = iter_5_0
		})

		self.activityPools[var_5_1.id] = var_5_1
	end

	self.activityPool = self.activityPools[self.activityVO.data1 or var_5_0[1]]

	return
end

function LotteryLayer:init()
	self.lotteryPoolContainer = self._tf:Find("left_panel/pool_list/content")
	self.attrs = self._tf:Find("left_panel/pool_list/arrs")
	self.mainItenContainer = self._tf:Find("right_panel/main_item_list/content")
	self.mainItenTpl = self.mainItenContainer:Find("equipmenttpl")
	self.resource = self._tf:Find("left_panel/resource")
	self.launchOneBtn = self._tf:Find("left_panel/launch_one_btn")
	self.launchOneBtnTxt = self.launchOneBtn:Find("res/Text"):GetComponent(typeof(Text))
	self.launchTenBtn = self._tf:Find("left_panel/launch_ten_btn")
	self.launchTenBtnTxt = self.launchTenBtn:Find("res/Text"):GetComponent(typeof(Text))
	self.launchMaxBtn = self._tf:Find("left_panel/launch_max_btn")
	self.launchMaxBtnTxt = self.launchMaxBtn:Find("res/Text"):GetComponent(typeof(Text))
	self.awardsCounttxt = self._tf:Find("right_panel/count_container/Text"):GetComponent(typeof(Text))
	self.bgTF = self._tf:Find("right_panel"):GetComponent(typeof(Image))
	self.descBtn = self._tf:Find("right_panel/desc_btn")
	self.bonusWindow = self._tf:Find("Msgbox")

	setActive(self.bonusWindow, false)

	self.topPanel = self._tf:Find("top")

	return
end

function LotteryLayer:didEnter()
	onButton(self, self._tf:Find("top/back_btn"), function()
		self:emit(LotteryLayer.ON_CLOSE)

		return
	end, SOUND_BACK)

	local var_8_0 = {
		1,
		10,
		"max"
	}

	for iter_8_0, iter_8_1 in ipairs({
		self.launchOneBtn,
		self.launchTenBtn,
		self.launchMaxBtn
	}) do
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = self.resId
		}):getIcon(), "", iter_8_1:Find("res/icon"), true)
		onButton(self, iter_8_1, function()
			if not self.activityPool then
				return
			end

			if self.activityPool ~= self.showActivityPool then
				pg.TipsMgr.GetInstance():ShowTips(i18n("amercian_notice_5"))

				return
			end

			local var_10_0 = self.activityPool:getleftItemCount()

			if var_10_0 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("activity_pool_awards_empty"))

				return
			end

			local var_10_1 = self.activityPool:getComsume()

			var_10_0 = var_8_0[iter_8_0] == "max" and math.min(var_10_0, math.max(math.floor(self.resCount / var_10_1.count), 1)) or math.min(var_10_0, var_8_0[iter_8_0])

			if not self.activityPool:enoughResForUsage(var_10_0) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

				return
			end

			local function var_10_2()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("amercian_notice_1", var_10_0 * var_10_1.count, var_10_0),
					onYes = function()
						self:emit(LotteryMediator.ON_LAUNCH, self.activityVO.id, self.activityPool.id, var_10_0, var_8_0[iter_8_0] == "max")

						return
					end
				})

				return
			end

			if self.playerVO:OilMax(1) or self.playerVO:GoldMax(1) then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("amercian_notice_6"),
					onYes = function()
						var_10_2()

						return
					end
				})
			else
				var_10_2()
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.descBtn, function()
		if not self.showActivityPool then
			return
		end

		local var_14_0, var_14_1 = self.showActivityPool:getItems()

		self:showBonus(var_14_0, var_14_1)

		return
	end, SFX_PANEL)
	onButton(self, self.bonusWindow:Find("window/top/btnBack"), function()
		setActive(self.bonusWindow, false)

		return
	end)
	onButton(self, self.bonusWindow:Find("window/button"), function()
		setActive(self.bonusWindow, false)

		return
	end)
	onButton(self, self.bonusWindow, function()
		setActive(self.bonusWindow, false)

		return
	end)

	self.bgs = {}
	self.attrTFs = {}

	for iter_8_2 = 1, table.getCount(self.activityPools) do
		local var_8_1 = self.attrs:Find("arr_" .. iter_8_2)

		if not IsNil(var_8_1) then
			table.insert(self.attrTFs, var_8_1)
		end
	end

	self:updateResource()
	self:initPoolTFs()
	self:updateActivityPoolState()
	triggerToggle(self.activityPoolTFs[self.activityPool.id], true)

	return
end

function LotteryLayer:onActivityUpdated(arg_18_1)
	self:setActivity(arg_18_1)
	self:updateActivityPoolState()
	self:switchToPool(arg_18_1.data1)

	return
end

function LotteryLayer:initPoolTFs()
	self.activityPoolTFs = {}

	for iter_19_0, iter_19_1 in pairs(self.activityPools) do
		local var_19_0 = self.lotteryPoolContainer:GetChild(iter_19_1.index - 1)

		self.activityPoolTFs[iter_19_1.id] = var_19_0

		onToggle(self, var_19_0, function(arg_20_0)
			if arg_20_0 then
				if not iter_19_1.prevId or self.activityPools[iter_19_1.prevId]:canOpenNext() then
					self:emit(LotteryMediator.ON_SWITCH, self.activityVO.id, iter_19_1.id)
				else
					self:switchToPool(iter_19_1.id)
				end
			end

			return
		end)
	end

	return
end

function LotteryLayer:updateActivityPoolState()
	for iter_21_0, iter_21_1 in pairs(self.activityPools) do
		local var_21_0 = self.activityPoolTFs[iter_21_0]
		local var_21_1 = not iter_21_1.prevId or self.activityPools[iter_21_1.prevId]:canOpenNext()

		setActive(self.activityPoolTFs[iter_21_0]:Find("bg/unlock"), var_21_1)
		setActive(var_21_0:Find("bg/lock"), not var_21_1)
		setActive(var_21_0:Find("selected/unlock"), var_21_1)
		setActive(var_21_0:Find("selected/lock"), not var_21_1)

		local var_21_3
		local var_21_2

		if var_0_2 then
			setActive(var_21_0:Find("icon"), var_21_1)
			setActive(var_21_0:Find("icon_g"), not var_21_1)

			var_21_2 = setActive
			var_21_3 = var_21_0:Find("finish")
		end

		var_21_2(var_21_3, iter_21_1:getleftItemCount() == 0)

		if self.attrTFs[iter_21_1.index - 1] then
			triggerToggle(self.attrTFs[iter_21_1.index - 1], var_21_1)
		end
	end

	return
end

function LotteryLayer:switchToPool(arg_22_1)
	self:updateMainItems(self.activityPools[arg_22_1])
	self:updateAwardsFetchedCount(self.activityPools[arg_22_1])

	local var_22_1 = self.bgs[arg_22_1]

	if not self.bgs[arg_22_1] then
		var_22_1 = var_0_2 and LoadSprite("lotterybg/cht_" .. self.activityPools[arg_22_1].index) or LoadSprite("lotterybg/kr_re_" .. self.activityPools[arg_22_1].index)
		self.bgs[arg_22_1] = var_22_1
	end

	self.bgTF.sprite = var_22_1

	local var_22_2 = self.activityPools[arg_22_1]:getComsume()

	self.launchOneBtnTxt.text = var_22_2.count
	self.launchTenBtnTxt.text = var_22_2.count * math.min(self.activityPools[arg_22_1]:getleftItemCount(), 10)
	self.launchMaxBtnTxt.text = var_22_2.count * math.min(self.activityPools[arg_22_1]:getleftItemCount(), math.max(math.floor(self.resCount / var_22_2.count), 1))
	self.showActivityPool = self.activityPools[self.activityPools[arg_22_1].id]

	return
end

function LotteryLayer:updateAwardsFetchedCount(arg_23_1)
	if self.awardsCounttxt then
		local var_23_0 = arg_23_1:getFetchCount()
		local var_23_1 = arg_23_1:getItemCount()

		self.awardsCounttxt.text = setColorStr(var_23_1 - var_23_0, (var_23_0 < var_23_1 or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_23_1
	end

	return
end

function LotteryLayer:updateMainItems(arg_24_1)
	local var_24_0 = arg_24_1:getMainItems()

	for iter_24_0 = self.mainItenContainer.childCount, #var_24_0 do
		cloneTplTo(self.mainItenTpl, self.mainItenContainer)
	end

	for iter_24_1 = 1, self.mainItenContainer.childCount do
		local var_24_1 = self.mainItenContainer:GetChild(iter_24_1 - 1)
		local var_24_2 = iter_24_1 <= #var_24_0

		setActive(var_24_1, iter_24_1 <= #var_24_0)

		if var_24_2 then
			local var_24_3 = var_24_0[iter_24_1]

			updateDrop(var_24_1, var_24_0[iter_24_1])
			setActive(var_24_1:Find("mask"), var_24_3.surplus <= 0)
			setText(var_24_1:Find("icon_bg/surplus"), "X" .. (var_24_3.surplus or ""))
			onButton(self, var_24_1, function()
				self:emit(LotteryLayer.ON_DROP, var_24_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function LotteryLayer:showBonus(arg_26_1, arg_26_2)
	setActive(self.bonusWindow, true)

	self.awardMain = arg_26_1
	self.awardNormal = arg_26_2
	self.trDropTpl = self._tf:Find("Msgbox/window/items/scrollview/item")
	self.trDrops = self._tf:Find("Msgbox/window/items/scrollview/list/list_main")
	self.dropList = UIItemList.New(self.trDrops, self.trDropTpl)

	self.dropList:make(function(arg_27_0, arg_27_1, arg_27_2)
		self:updateDrop(arg_27_0, arg_27_1, arg_27_2, self.awardMain)

		return
	end)
	self.dropList:align(#self.awardMain)

	self.trDropsN = self._tf:Find("Msgbox/window/items/scrollview/list/list_normal")
	self.dropListN = UIItemList.New(self.trDropsN, self.trDropTpl)

	self.dropListN:make(function(arg_28_0, arg_28_1, arg_28_2)
		self:updateDrop(arg_28_0, arg_28_1, arg_28_2, self.awardNormal)

		return
	end)
	self.dropListN:align(#self.awardNormal)

	return
end

function LotteryLayer:updateDrop(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if arg_29_1 == UIItemList.EventUpdate then
		local var_29_0 = arg_29_4[arg_29_2 + 1]

		updateDrop(arg_29_3, arg_29_4[arg_29_2 + 1])
		setText(arg_29_3:Find("count"), var_29_0.surplus .. "/" .. var_29_0.total)
		setActive(arg_29_3:Find("mask"), var_29_0.surplus <= 0)
		setScrollText(findTF(arg_29_3, "name_mask/name"), var_29_0.name or var_29_0:getConfig("name"))
	end

	return
end

function LotteryLayer:willExit()
	self.bgs = nil

	return
end

return LotteryLayer
