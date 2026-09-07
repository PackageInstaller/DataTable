local BuildShipPoolsPage = class("BuildShipPoolsPage", import("...base.BaseSubView"))

function BuildShipPoolsPage:getUIName()
	return "BuildShipPoolsPageUI"
end

function BuildShipPoolsPage:RefreshActivityBuildPool(arg_2_1)
	local var_2_0 = underscore.detect(self.pools, function(arg_3_0)
		return arg_3_0:IsActivity() and arg_3_0.activityId == arg_2_1.id
	end)

	if var_2_0 then
		self:UpdateBuildPoolExchange(var_2_0)
		self:UpdateTicket()
	end

	return
end

function BuildShipPoolsPage:RefreshFreeBuildActivity()
	for iter_4_0, iter_4_1 in pairs(self.freeActTimer) do
		iter_4_1:Stop()
	end

	self.freeActTimer = {}

	for iter_4_2, iter_4_3 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BUILD_FREE)) do
		if iter_4_3:isEnd() == false then
			self.freeActTimer[iter_4_3.id] = Timer.New(function()
				self:emit(BuildShipMediator.ON_UPDATE_ACT)

				return
			end, iter_4_3.stopTime - pg.TimeMgr.GetInstance():GetServerTime())

			self.freeActTimer[iter_4_3.id]:Start()
		end
	end

	return
end

function BuildShipPoolsPage:RefreshRegularExchangeCount()
	if self.pool then
		self:UpdateRegularBuildPoolExchange(self.pool)
	end

	return
end

function BuildShipPoolsPage:OnLoaded()
	self.quickCount = self._tf:Find("gallery/res_items/item")
	self.useItemTF = self.quickCount:Find("Text")
	self.freeCount = self._tf:Find("gallery/res_items/ticket")
	self.ticketTF = self.freeCount:Find("Text")
	self.patingTF = self._tf:Find("painting")
	self.poolContainer = self._tf:Find("gallery/toggle_bg/bg/toggles")
	self.newTpl = self.poolContainer:Find("new")
	self.newPoolTpls = {
		self.newTpl
	}
	self.specialTpl = self.poolContainer:Find("special")
	self.specialPoolTpls = {
		self.specialTpl
	}
	self.lightTpl = self.poolContainer:Find("light")
	self.lightPoolTpls = {
		self.lightTpl
	}
	self.heavyTpl = self.poolContainer:Find("heavy")
	self.heavyPoolTpls = {
		self.heavyTpl
	}
	self.maskContainer = self._tf:Find("gallery/mask")
	self.buildPoolExchangeTF = self._tf:Find("gallery/exchange_bg")
	self.buildPoolExchangeGetBtn = self.buildPoolExchangeTF:Find("get")
	self.buildPoolExchangeTxt = self.buildPoolExchangeTF:Find("Text"):GetComponent(typeof(Text))
	self.buildPoolExchangeGetBtnMark = self.buildPoolExchangeGetBtn:Find("mark")
	self.buildPoolExchangeGetTxt = self.buildPoolExchangeGetBtn:Find("Text"):GetComponent(typeof(Text))
	self.buildPoolExchangeName = self.buildPoolExchangeTF:Find("name"):GetComponent(typeof(Text))
	self.rtRegularExchange = self._tf:Find("gallery/exchange_ur_bg")

	setText(self.rtRegularExchange:Find("name/Text"), i18n("Normalbuild_URexchange_text1"))
	onButton(self, self.rtRegularExchange:Find("name/icon"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("Normalbuild_URexchange_help")
		})

		return
	end, SFX_PANEL)
	setText(self.rtRegularExchange:Find("count/name"), i18n("Normalbuild_URexchange_text2") .. ":")
	setText(self.rtRegularExchange:Find("show/Text"), i18n("Normalbuild_URexchange_text3"))
	setText(self.rtRegularExchange:Find("get/Text"), i18n("Normalbuild_URexchange_text4"))

	for iter_7_0, iter_7_1 in ipairs({
		self.rtRegularExchange:Find("show"),
		self.rtRegularExchange:Find("get")
	}) do
		onButton(self, iter_7_1, function()
			self:emit(BuildShipMediator.ON_BUILDPOOL_UR_EXCHANGE)

			return
		end, SFX_PANEL)
	end

	self.tipSTxt = self._tf:Find("gallery/bg/type_intro/mask/title"):GetComponent("ScrollText")
	self.tipTime = self._tf:Find("gallery/bg/time_text")
	self.helpBtn = self._tf:Find("gallery/help_btn")
	self.testBtn = self._tf:Find("gallery/test_btn")
	self.prevArr = self._tf:Find("gallery/prev_arr")
	self.nextArr = self._tf:Find("gallery/next_arr")
	self.activityTimer = {}
	self.freeActTimer = {}

	return
end

function BuildShipPoolsPage:OnInit()
	onButton(self, self.quickCount, function()
		shoppingBatch(61008, {
			id = pg.shop_template[61008].effect_args[1]
		}, 9, "build_ship_quickly_buy_stone")

		return
	end)
	onButton(self, self.helpBtn, function()
		self.contextData.helpWindow:ExecuteAction("Show", self.pool:getConfigTable(), nil, self.pool:IsActivity())

		return
	end, SFX_CANCEL)

	return
end

function BuildShipPoolsPage:Flush(arg_13_1, arg_13_2)
	local var_13_0 = getProxy(ActivityProxy)

	self.pools = underscore.filter(arg_13_1, function(arg_14_0)
		local var_14_0 = var_13_0:getBuildPoolActivity(arg_14_0)

		return tobool(arg_13_2) == (var_14_0 and var_14_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD or false)
	end)

	if #self.pools > 4 then
		self:AdjustToggleContainer()
	end

	local var_13_1 = {}

	self:RemoveAllTimer()
	eachChild(self.poolContainer, function(arg_15_0)
		setActive(arg_15_0, false)

		return
	end)

	for iter_13_0, iter_13_1 in ipairs(self.pools) do
		local var_13_2 = self:GetPoolTpl((iter_13_1:GetMark()))

		setActive(var_13_2, true)

		if iter_13_1:IsActivity() then
			self:AddActivityTimer(iter_13_1)
		end

		local var_13_3 = var_13_2:Find("frame")

		removeOnToggle(var_13_3)
		triggerToggle(var_13_3, false)
		onToggle(self, var_13_3, function(arg_16_0)
			if arg_16_0 then
				self:SwitchPool(iter_13_1)
			end

			return
		end, SFX_PANEL)

		var_13_1[iter_13_1:GetPoolId()] = var_13_2
	end

	table.sort(self.pools, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:GetSortCode()
		local var_17_1 = arg_17_1:GetSortCode()

		if var_17_0 == var_17_1 then
			return arg_17_0:GetPoolId() > arg_17_1:GetPoolId()
		else
			return var_17_1 < var_17_0
		end

		return
	end)

	for iter_13_2, iter_13_3 in ipairs(self.pools) do
		var_13_1[iter_13_3:GetPoolId()]:SetAsFirstSibling()
	end

	triggerToggle(var_13_1[self:GetActivePool(self:ActivePool(), BuildShipScene.buildShipActPoolId):GetPoolId()]:Find("frame"), true)

	self.contextData.projectName = nil

	scrollTo(self.poolContainer.parent, 0, 1)
	self:RefreshFreeBuildActivity()
	self:UpdateItem(self.contextData.itemVO.count)
	onNextTick(function()
		self:UpdateArr(#self.pools)

		return
	end)

	return
end

local function var_0_1(arg_19_0)
	local var_19_0 = _.select(arg_19_0.pools, function(arg_20_0)
		return arg_20_0:GetMark() == BuildShipPool.BUILD_POOL_MARK_NEW
	end)

	table.sort(var_19_0, function(arg_21_0, arg_21_1)
		return arg_21_0:GetPoolId() < arg_21_1:GetPoolId()
	end)

	return var_19_0[1]
end

function BuildShipPoolsPage:GetActivePool(arg_22_1, arg_22_2)
	if not arg_22_1 then
		return nil
	end

	return arg_22_1 == BuildShipPool.BUILD_POOL_MARK_NEW and (_.detect(self.pools, function(arg_23_0)
		return arg_23_0:GetPoolId() == arg_22_2
	end) or var_0_1(self)) or _.detect(self.pools, function(arg_24_0)
		return arg_24_0:GetMark() == arg_22_1
	end) or self.pools[1]
end

function BuildShipPoolsPage:AdjustToggleContainer()
	if not self.isInit then
		local var_25_0 = self.poolContainer.parent

		SetParent(self.poolContainer.parent, self.maskContainer)

		var_25_0.sizeDelta, var_25_0.localScale = self.poolContainer.parent.sizeDelta * (1 + (1 - 0.85)), Vector3(0.85, 0.85, 1)

		local var_25_1 = self.poolContainer:GetComponent(typeof(HorizontalLayoutGroup))

		var_25_1.padding.left = 60
		var_25_1.padding.right = 60
		var_25_1.padding.top = 0
		self.isInit = true
	end

	return
end

function BuildShipPoolsPage:UpdateArr(arg_26_1)
	if arg_26_1 <= 4 then
		setActive(self.prevArr, false)
		setActive(self.nextArr, false)

		return
	end

	local var_26_0 = getBounds(self.maskContainer)
	local var_26_1 = self.poolContainer:GetChild(0)
	local var_26_2 = self.poolContainer:GetChild(self.poolContainer.childCount - 1)

	onScroll(self, self.poolContainer.parent, function(arg_27_0)
		local var_27_0 = getBounds(var_26_1)
		local var_27_1 = getBounds(var_26_2)

		setActive(self.prevArr, arg_27_0.x > 0.01)
		setActive(self.nextArr, arg_27_0.x < 0.99)

		return
	end)
	onButton(self, self.prevArr, function()
		scrollTo(self.poolContainer.parent, 0, 1)

		return
	end, SFX_PANEL)
	onButton(self, self.nextArr, function()
		scrollTo(self.poolContainer.parent, 1, 1)

		return
	end, SFX_PANEL)

	return
end

function BuildShipPoolsPage:GetPoolTpl(arg_30_1)
	assert(self[arg_30_1 .. "PoolTpls"])

	if #self[arg_30_1 .. "PoolTpls"] <= 0 then
		local var_30_0 = Object.Instantiate(self[arg_30_1 .. "Tpl"], self.poolContainer).transform

		var_30_0:SetSiblingIndex(self[arg_30_1 .. "Tpl"]:GetSiblingIndex() + 1)

		return var_30_0
	else
		return table.remove(self[arg_30_1 .. "PoolTpls"], 1)
	end

	return
end

function BuildShipPoolsPage:ActivePool()
	local var_31_0 = _.any(self.pools, function(arg_32_0)
		return arg_32_0:IsActivity()
	end)
	local var_31_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

	if self.contextData.activity and self.contextData.activity > 0 then
		self.contextData.projectName = BuildShipPool.BUILD_POOL_MARK_NEW

		local var_31_2 = getProxy(ActivityProxy):getActivityById(self.contextData.activity)

		if var_31_2 and not var_31_2:isEnd() then
			BuildShipScene.buildShipActPoolId = var_31_2:getConfig("config_id")
		end
	end

	local var_31_3

	if self.contextData.projectName then
		var_31_3 = self.contextData.projectName
	elseif BuildShipScene.projectName then
		var_31_3 = BuildShipScene.projectName == BuildShipPool.BUILD_POOL_MARK_NEW and not var_31_0 and BuildShipPool.BUILD_POOL_MARK_HEAVY or BuildShipScene.projectName
	elseif var_31_0 then
		var_31_3 = BuildShipPool.BUILD_POOL_MARK_NEW
	elseif var_31_1 and not var_31_1:isEnd() then
		local var_31_4 = var_31_1:getConfig("config_client").id
		local var_31_5 = _.detect(self.pools, function(arg_33_0)
			return arg_33_0.id == var_31_4
		end)

		var_31_3 = var_31_5 and var_31_5:GetMark() or BuildShipPool.BUILD_POOL_MARK_HEAVY
	else
		var_31_3 = self.contextData.projectName or BuildShipScene.projectName or BuildShipPool.BUILD_POOL_MARK_HEAVY
	end

	if not underscore.any(self.pools, function(arg_34_0)
		return arg_34_0:GetMark() == var_31_3
	end) then
		return self.pools[1]:GetMark()
	else
		return var_31_3
	end

	return
end

function BuildShipPoolsPage:UpdateItem(arg_35_1)
	setText(self.useItemTF, arg_35_1)
	Canvas.ForceUpdateCanvases()

	return
end

function BuildShipPoolsPage:UpdateTicket()
	local var_36_0 = getProxy(ActivityProxy)
	local var_36_1 = var_36_0:getBuildFreeActivityByBuildId(self.pool.id)

	if var_36_1 and not var_36_1:isEnd() then
		local var_36_2 = Drop.New({
			type = DROP_TYPE_VITEM,
			id = var_36_1:getConfig("config_client")[1],
			count = var_36_1.data1
		})

		setActive(self.freeCount:Find("tip"), var_36_1.stopTime - pg.TimeMgr.GetInstance():GetServerTime() < 0 and var_36_2.count > 0)
		LoadImageSpriteAtlasAsync(var_36_2:getConfig("icon"), "", self.freeCount:Find("icon"))
		setText(self.ticketTF, var_36_1.data1)
		onButton(self, self.freeCount, function()
			self:emit(BaseUI.ON_DROP, var_36_2)

			return
		end, SFX_PANEL)

		local var_36_3 = self._tf:Find("gallery/item_bg/ticket")

		LoadImageSpriteAtlasAsync(var_36_2:getConfig("icon"), "", var_36_3:Find("icon"))
		setText(var_36_3:Find("name"), var_36_2:getConfig("name"))
		setText(var_36_3:Find("tip"), i18n("build_ticket_description"))
	end

	local var_36_4 = checkExist(var_36_0:getBuildPoolActivity(self.pool), {
		"getConfig",
		{
			"type"
		}
	}) == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD

	setText(self._tf:Find("gallery/prints/intro/text"), var_36_4 and i18n("newserver_build_tip") or i18n("build_pools_intro"))
	setActive(self.freeCount, tobool(var_36_1))
	setActive(self.quickCount, not var_36_4)

	self.useTicket = var_36_4 or var_36_1 and var_36_1.data1 > 0

	setActive(self._tf:Find("gallery/item_bg/item"), not self.useTicket)
	setActive(self._tf:Find("gallery/item_bg/gold"), not self.useTicket)
	setActive(self._tf:Find("gallery/item_bg/ticket"), self.useTicket)

	return
end

function BuildShipPoolsPage:SwitchPool(arg_38_1)
	self.pool = arg_38_1
	self.buildPainting = nil

	local var_38_0 = getProxy(ActivityProxy)
	local var_38_1 = var_38_0:getBuildPoolActivity(arg_38_1)

	if PLATFORM_CODE == PLATFORM_CH and var_38_1 then
		self.buildPainting = var_38_1:getConfig("config_client").build_painting
	end

	setActive(self.tipTime, var_38_1 and var_38_1:isVariableTime())

	if isActive(self.tipTime) then
		local var_38_2 = pg.TimeMgr.GetInstance()

		setText(self.tipTime, var_38_2:STimeDescC(var_38_1:getStartTime(), "%Y.%m.%d") .. " - " .. var_38_2:STimeDescC(var_38_1.stopTime, "%m.%d %H:%M"))
	end

	local var_38_3 = arg_38_1:GetMark()

	self._tf:Find("gallery/bg/type"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/BuildShipUI_atlas", "sub_title_" .. var_38_3)

	local var_38_4 = arg_38_1:getConfigTable()
	local var_38_5 = arg_38_1:IsActivity() and var_38_0:getBuildActivityCfgByID(var_38_4.id) or var_38_0:getNoneActBuildActivityCfgByID(var_38_4.id)
	local var_38_7 = LoadSprite((HXSet.HxPath((var_38_5 or nil) and (var_38_5.bg or "loadingbg/bg_" .. var_38_4.icon))))

	self.tipSTxt:SetText(var_38_5 and var_38_5.buildship_tip and HXSet.hxLan(var_38_5 and var_38_5.buildship_tip) or i18n("buildship_" .. var_38_3 .. "_tip"))

	self._tf:Find("gallery/bg"):GetComponent(typeof(Image)).sprite = var_38_7

	setText(self._tf:Find("gallery/item_bg/item/Text"), var_38_4.number_1)
	setText(self._tf:Find("gallery/item_bg/gold/Text"), var_38_4.use_gold)
	self:UpdateBuildPoolExchange(arg_38_1)
	self:UpdateRegularBuildPoolExchange(arg_38_1)
	self:UpdateTicket()
	self:UpdateTestBtn(arg_38_1)
	self:UpdateBuildPoolPaiting(arg_38_1)

	local var_38_8 = {}

	if arg_38_1:getConfig("exchange_count") > 0 then
		table.insert(var_38_8, function(arg_39_0)
			if getProxy(BuildShipProxy):getRegularExchangeCount() >= pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID].exchange_request then
				if PlayerPrefs.GetString("REGULAR_BUILD_MAX_TIP", "") == pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d") then
					arg_39_0()

					goto label_39_0
				end
			end

			do
				local var_39_0 = pg.MsgboxMgr.GetInstance()

				local function var_39_1(arg_40_0)
					PlayerPrefs.SetString("REGULAR_BUILD_MAX_TIP", (arg_40_0 or nil) and (pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d") or ""))

					return
				end

				var_39_0:ShowMsgBox({
					showStopRemind = true,
					content = i18n("Normalbuild_URexchange_warning3"),
					stopRamindContent = i18n("dont_remind_today"),
					onYes = function()
						var_39_1(var_39_0.stopRemindToggle.isOn)
						arg_39_0()

						return
					end,
					onNo = function()
						var_39_1(var_39_0.stopRemindToggle.isOn)

						return
					end
				})
			end

			::label_39_0::

			return
		end)
	end

	onButton(self, self._tf:Find("gallery/start_btn"), function()
		seriesAsync(var_38_8, function()
			local var_44_0 = self.useTicket and var_38_0:getBuildFreeActivityByBuildId(self.pool.id) or nil
			local var_44_1

			if self.useTicket and (not var_44_0 or var_44_0:isEnd()) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				do return end

				var_44_1 = self.useTicket and {
					buildType = "ticket",
					itemVO = Item.New({
						id = var_44_0:getConfig("config_client")[1],
						count = var_44_0.data1
					}),
					buildPool = var_38_4,
					max = MAX_BUILD_WORK_COUNT - self.contextData.startCount,
					onConfirm = function(arg_45_0)
						if arg_38_1:IsActivity() then
							self:emit(BuildShipMediator.ACT_ON_BUILD, arg_38_1:GetActivityId(), var_38_4.id, arg_45_0, true)
						else
							self:emit(BuildShipMediator.ON_BUILD, var_38_4.id, arg_45_0, true)
						end

						return
					end
				} or {
					buildType = "base",
					player = self.contextData.player,
					itemVO = self.contextData.itemVO,
					buildPool = var_38_4,
					max = MAX_BUILD_WORK_COUNT - self.contextData.startCount,
					onConfirm = function(arg_46_0)
						if arg_38_1:IsActivity() then
							self:emit(BuildShipMediator.ACT_ON_BUILD, arg_38_1:GetActivityId(), var_38_4.id, arg_46_0)
						else
							self:emit(BuildShipMediator.ON_BUILD, var_38_4.id, arg_46_0)
						end

						return
					end
				}
			end

			self.contextData.msgbox:ExecuteAction("Show", var_44_1)

			return
		end)

		return
	end, SFX_UI_BUILDING_STARTBUILDING)

	BuildShipScene.projectName = var_38_3

	if arg_38_1:IsActivity() then
		BuildShipScene.buildShipActPoolId = arg_38_1:GetPoolId()
	end

	return
end

local function var_0_2(arg_47_0)
	if not arg_47_0:IsActivity() then
		return false
	end

	local var_47_0 = pg.ship_data_create_exchange[arg_47_0:GetActivityId()]

	return var_47_0 and #var_47_0.exchange_ship_id > 0
end

function BuildShipPoolsPage:UpdateBuildPoolPaiting(arg_48_1)
	local var_48_0

	if self.buildPainting then
		var_48_0 = self.buildPainting
	elseif var_0_2(arg_48_1) then
		local var_48_1 = pg.ship_data_statistics[pg.ship_data_create_exchange[arg_48_1:GetActivityId()].exchange_ship_id[1]]

		assert(var_48_1)

		var_48_0 = pg.ship_skin_template[var_48_1.skin_id].painting
	else
		var_48_0 = self.contextData.falgShip:getPainting()
	end

	if self.painting ~= var_48_0 then
		local function var_48_2()
			self.painting = var_48_0

			self:Hx4Channel()

			return
		end

		self:RevertHxChannel()

		if self.buildPainting then
			setBuildPaintingPrefabAsync(self.patingTF, var_48_0, "build", var_48_2)
		else
			setPaintingPrefabAsync(self.patingTF, var_48_0, "build", var_48_2)
		end
	end

	return
end

local function var_0_3(arg_50_0)
	local var_50_0 = arg_50_0.patingTF:Find("fitter")

	if var_50_0.childCount <= 0 then
		return nil
	end

	local var_50_1 = var_50_0:GetChild(0)

	if IsNil(var_50_1) then
		return nil
	end

	return (var_50_1:Find("build_hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function BuildShipPoolsPage:Hx4Channel()
	local var_51_0 = var_0_3(self)

	if not IsNil(var_51_0) then
		setActive(var_51_0, HXSet.isHx())
	end

	return
end

function BuildShipPoolsPage:RevertHxChannel()
	local var_52_0 = var_0_3(self)

	if not IsNil(var_52_0) then
		setActive(var_52_0, false)
	end

	return
end

function BuildShipPoolsPage:UpdateBuildPoolExchange(arg_53_1)
	local var_53_0
	local var_53_1
	local var_53_2

	if arg_53_1:IsActivity() then
		local var_53_3 = pg.ship_data_create_exchange[arg_53_1:GetActivityId()]

		if var_53_3 then
			var_53_0 = var_53_3.exchange_request
			var_53_1 = var_53_3.exchange_available_times
			var_53_2 = var_53_3.exchange_ship_id[1]
		end
	end

	local var_53_4 = var_53_0 and var_53_0 > 0 and var_53_1 and var_53_1 > 0

	if var_53_0 and var_53_0 > 0 and var_53_1 and var_53_1 > 0 then
		local var_53_5 = arg_53_1:GetActivity()
		local var_53_6 = var_53_5.data1
		local var_53_7 = var_53_5.data2
		local var_53_8 = math.min(var_53_1, var_53_5.data2 + 1) * var_53_0

		self.buildPoolExchangeTxt.text = i18n("build_count_tip") .. "<color=#FFDF48>" .. var_53_5.data1 .. "</color>/" .. var_53_8

		local var_53_9 = var_53_7 < var_53_1 and var_53_8 <= var_53_6

		setActive(self.buildPoolExchangeGetBtnMark, var_53_7 < var_53_1 and var_53_8 <= var_53_6)

		self.buildPoolExchangeGetTxt.text = var_53_7 .. "/" .. var_53_1
		self.buildPoolExchangeName.text = SwitchSpecialChar(pg.ship_data_statistics[var_53_2].name, true)

		local var_53_10 = pg.ship_data_statistics[var_53_2].rarity

		eachChild(self.buildPoolExchangeTF:Find("bg"), function(arg_54_0)
			setActive(arg_54_0, arg_54_0.name == tostring(var_53_10))

			return
		end)
		onButton(self, self.buildPoolExchangeTF, function()
			if var_53_9 then
				self:emit(BuildShipMediator.ON_BUILDPOOL_EXCHANGE, var_53_5.id)
			end

			return
		end, SFX_PANEL)
		setGray(self.buildPoolExchangeGetBtn, not var_53_9, true)
		setButtonEnabled(self.buildPoolExchangeTF, var_53_9)
	else
		removeOnButton(self.buildPoolExchangeTF)
	end

	setActive(self.buildPoolExchangeTF, var_53_4)

	return
end

function BuildShipPoolsPage:UpdateRegularBuildPoolExchange(arg_56_1)
	local var_56_0 = arg_56_1:getConfig("exchange_count") > 0

	setActive(self.rtRegularExchange, var_56_0)

	if var_56_0 then
		local var_56_1 = getProxy(BuildShipProxy):getRegularExchangeCount()
		local var_56_2 = pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID]

		setText(self.rtRegularExchange:Find("count/Text"), "<color=#FFDF48>" .. var_56_1 .. "</color>/" .. pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID].exchange_request)
		setActive(self.rtRegularExchange:Find("show"), var_56_1 < var_56_2.exchange_request)
		setActive(self.rtRegularExchange:Find("get"), var_56_1 >= var_56_2.exchange_request)
	end

	return
end

function BuildShipPoolsPage:UpdateTestBtn(arg_57_1)
	local var_57_0 = false

	if PLATFORM_CODE ~= PLATFORM_JP and arg_57_1:IsActivity() and not arg_57_1:IsEnd() then
		local var_57_1 = arg_57_1:GetStageId()

		if var_57_1 then
			var_57_0 = true

			onButton(self, self.testBtn, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("juese_tiyan"),
					onYes = function()
						self:emit(BuildShipMediator.SIMULATION_BATTLE, var_57_1)

						return
					end
				})

				return
			end, SFX_PANEL)
		end
	end

	setActive(self.testBtn, var_57_0)

	return
end

function BuildShipPoolsPage:AddActivityTimer(arg_60_1)
	self:RemoveActivityTimer(arg_60_1)

	if arg_60_1:IsActivity() then
		local var_60_0 = arg_60_1:GetActivity()

		assert(var_60_0)

		self.activityTimer[arg_60_1.id] = Timer.New(function()
			self:RemoveActivityTimer(arg_60_1)
			self:emit(BuildShipMediator.ON_UPDATE_ACT)

			return
		end, var_60_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

		self.activityTimer[arg_60_1.id]:Start()
	end

	return
end

function BuildShipPoolsPage:RemoveActivityTimer(arg_62_1)
	if self.activityTimer[arg_62_1.id] then
		self.activityTimer[arg_62_1.id]:Stop()

		self.activityTimer[arg_62_1.id] = nil
	end

	return
end

function BuildShipPoolsPage:RemoveAllTimer()
	for iter_63_0, iter_63_1 in pairs(self.activityTimer) do
		iter_63_1:Stop()
	end

	self.activityTimer = {}

	for iter_63_2, iter_63_3 in pairs(self.freeActTimer) do
		iter_63_3:Stop()
	end

	self.freeActTimer = {}

	return
end

function BuildShipPoolsPage:ShowOrHide(arg_64_1)
	if arg_64_1 then
		self:Show()
	else
		self:Hide()
	end

	return
end

function BuildShipPoolsPage:OnDestroy()
	self:RevertHxChannel()
	self:RemoveAllTimer()

	self.activityTimer = nil

	return
end

return BuildShipPoolsPage
