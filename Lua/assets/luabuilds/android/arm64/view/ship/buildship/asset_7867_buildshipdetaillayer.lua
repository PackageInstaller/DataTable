local BuildShipDetailLayer = class("BuildShipDetailLayer", import("...base.BaseUI"))
local var_0_2 = 2
local var_0_3 = 1
local var_0_5 = {
	"resources/1",
	"resources/2",
	"resources/3",
	"resources/1"
}

function BuildShipDetailLayer:getUIName()
	return "BuildShipDetailUI1"
end

function BuildShipDetailLayer:setItems(arg_2_1)
	self.itemVO = arg_2_1[ITEM_ID_EQUIP_QUICK_FINISH] or {
		count = 0,
		id = ITEM_ID_EQUIP_QUICK_FINISH
	}

	return
end

function BuildShipDetailLayer:setWorkCount(arg_3_1)
	self.workCount = arg_3_1

	return
end

function BuildShipDetailLayer:setBuildSpeedUpRemind(arg_4_1)
	self.isStopSpeedUpRemind = arg_4_1

	return
end

BuildShipDetailLayer.MODEL_INDEX = 2

function BuildShipDetailLayer:setProjectList(arg_5_1)
	self.projectList = arg_5_1

	if #self.projectList > BuildShipDetailLayer.MODEL_INDEX then
		self.MODEL = var_0_2 or var_0_3
	end

	return
end

function BuildShipDetailLayer:init()
	self.multLineTF = self._tf:Find("list_mult_line")
	self.multLineContain = self._tf:Find("list_mult_line/content")
	self.multLineTpl = self.multLineContain:Find("project_tpl")
	self.multList = UIItemList.New(self.multLineContain, self.multLineTpl)
	self.singleLineTF = self._tf:Find("list_single_line")
	self.singleLineContain = self._tf:Find("list_single_line/content")
	self.singleLineTpl = self.singleLineContain:Find("project_tpl")
	self.singleList = UIItemList.New(self.singleLineContain, self.singleLineTpl)
	self.listCountTF = self._tf:Find("title/value")
	self.quickCount = self._tf:Find("quick_count")
	self.quickCountTF = self._tf:Find("quick_count/value")
	self.noneBg = self._tf:Find("none_bg")
	self.allLaunch = self._tf:Find("all_launch")
	self.aniBgTF = self._tf:Find("aniBg")
	self.autoLockShipToggle = self._tf:Find("autolockship/Toggle"):GetComponent(typeof(Toggle))
	self.canvasgroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	setText(self._tf:Find("title/text"), i18n("build_detail_intro"))
	setText(self._tf:Find("autolockship/Text"), i18n("lock_new_ship"))

	return
end

function BuildShipDetailLayer:updatePlayer(arg_7_1)
	self._player = arg_7_1

	return
end

function BuildShipDetailLayer:didEnter()
	self.projectTFs = {}

	self.multList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			arg_9_2.gameObject.name = "project_" .. arg_9_1 + 1
			self.projectTFs[arg_9_1 + 1] = arg_9_2

			self:updateProject(arg_9_1 + 1, self.projectList[arg_9_1 + 1])
		end

		return
	end)
	self.singleList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_10_2.gameObject.name = "project_" .. arg_10_1 + 1
			self.projectTFs[arg_10_1 + 1] = arg_10_2

			self:updateProject(arg_10_1 + 1, self.projectList[arg_10_1 + 1])
		end

		return
	end)
	self:initProjectList()
	self:updateItem()
	self:updateListCount()
	self.aniBgTF.transform:SetParent(GameObject.Find("Overlay/UIOverlay").transform, false)
	onButton(self, self.allLaunch, function()
		local var_11_0 = self:getNeedCount()

		if var_11_0 > 0 and not self.isStopSpeedUpRemind then
			local var_11_1 = pg.MsgboxMgr.GetInstance()
			local var_11_2 = {
				showStopRemind = true
			}

			var_11_2.content = i18n("ship_buildShipScene_quest_quickFinish", var_11_0, (self.itemVO.count == 0 or nil) and (COLOR_RED or COLOR_GREEN), self.itemVO.count)
			var_11_2.stopRamindContent = i18n("common_dont_remind_dur_login")

			function var_11_2.onYes()
				self:emit(BuildShipDetailMediator.LAUNCH_ALL, var_11_1.stopRemindToggle.isOn)

				return
			end

			var_11_1:ShowMsgBox(var_11_2)
		elseif #self.projectList > 0 then
			self:emit(BuildShipDetailMediator.LAUNCH_ALL)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_getShip_error_noShip"))
		end

		return
	end, SFX_UI_BUILDING_FASTBUILDING)
	onButton(self, self.quickCount, function()
		shoppingBatch(61009, {
			id = pg.shop_template[61009].effect_args[1]
		}, 9, "build_ship_quickly_buy_tool")

		return
	end)

	local var_8_0 = pg.settings_other_template[22]
	local var_8_1 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[pg.settings_other_template[22].name])

	if pg.settings_other_template[22].default == 1 then
		var_8_1 = not var_8_1
	end

	self.autoLockShipToggle.isOn = var_8_1 or false

	onToggle(self, go(self.autoLockShipToggle), function(arg_14_0)
		self:ChangeAutoLockShip(var_8_0, arg_14_0)

		return
	end, SFX_PANEL)

	return
end

function BuildShipDetailLayer:onBackPressed()
	if self.isPlayAnim then
		return
	end

	self:emit(BuildShipDetailLayer.ON_BACK_PRESSED, true)

	return
end

function BuildShipDetailLayer:getNeedCount()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(self.projectList) do
		if iter_16_1.state ~= BuildShip.FINISH then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function BuildShipDetailLayer:updateListCount()
	setText(self.listCountTF, self.workCount)

	return
end

function BuildShipDetailLayer:updateItem()
	setText(self.quickCountTF, self.itemVO.count)

	return
end

function BuildShipDetailLayer:initProjectList()
	for iter_19_0, iter_19_1 in pairs(self.buildTimers or {}) do
		pg.TimeMgr.GetInstance():RemoveTimer(iter_19_1)
	end

	self.buildTimers = {}

	local var_19_1

	if self.MODEL == var_0_2 then
		var_19_1 = #self.projectList or 0

		local var_19_2

		if self.MODEL == var_0_3 then
			var_19_2 = #self.projectList or 0
		end
	end

	setActive(self.multLineTF, var_19_1 > 0)
	setActive(self.singleLineTF, var_19_2 > 0)
	self.multList:align(var_19_1)
	self.singleList:align(var_19_2)
	setActive(self.noneBg, #self.projectList <= 0)

	return
end

function BuildShipDetailLayer:initMultLine()
	self.multList:align(#self.projectList)

	return
end

function BuildShipDetailLayer:initSingleLine()
	self.singleList:align(#self.projectList)

	return
end

function BuildShipDetailLayer:updateProject(arg_22_1, arg_22_2)
	assert(isa(arg_22_2, BuildShip), "必须是实例BuildShip")

	local var_22_0 = self.projectTFs[arg_22_1]

	if IsNil(self.projectTFs[arg_22_1]) then
		return
	end

	local var_22_1 = var_22_0:Find("frame/buiding")
	local var_22_2 = var_22_0:Find("frame/finished")
	local var_22_3 = var_22_0:Find("frame/waiting")

	setActive(var_22_3, false)
	setActive(var_22_1, arg_22_2.state == BuildShip.ACTIVE)
	setActive(var_22_2, arg_22_2.state == BuildShip.FINISH)

	var_22_0:GetComponent("CanvasGroup").alpha = arg_22_2.state == BuildShip.INACTIVE and 0.6 or 1

	local var_22_4 = tonumber(pg.ship_data_create_material[arg_22_2.type].ship_icon)
	local var_22_5 = var_22_1:Find("ship_modal")

	for iter_22_0 = 0, var_22_5.childCount - 1 do
		setActive(var_22_5:GetChild(iter_22_0), false)
	end

	if arg_22_2.state == BuildShip.ACTIVE then
		local var_22_6 = GetComponent(var_22_1, typeof(CanvasGroup))

		if var_22_6 then
			var_22_6.alpha = 1
		end

		local var_22_7 = var_22_5:Find("shipModelBuliding" .. var_22_4)

		if not var_22_7 then
			PoolMgr.GetInstance():GetUI("shipModelBuliding" .. var_22_4, true, function(arg_23_0)
				arg_23_0.transform:SetParent(var_22_5, false)

				arg_23_0.transform.localPosition = Vector3(1, 1, 1)
				arg_23_0.transform.localScale = Vector3(1, 1, 1)

				arg_23_0.transform:SetAsFirstSibling()
				setActive(arg_23_0, true)

				return
			end)
		else
			setActive(var_22_7, true)
		end

		local var_22_8 = var_22_1:Find("timer/Text")

		onButton(self, var_22_1:Find("quick_btn"), function()
			local var_24_0, var_24_1, var_24_2 = BuildShip.canQuickBuildShip(arg_22_1)

			if not var_24_0 then
				if var_24_2 then
					GoShoppingMsgBox(i18n("switch_to_shop_tip_1"), ChargeScene.TYPE_ITEM, var_24_2)
				else
					pg.TipsMgr.GetInstance():ShowTips(var_24_1)
				end

				return
			end

			if self.isStopSpeedUpRemind then
				self:emit(BuildShipDetailMediator.ON_QUICK, arg_22_1)
			else
				local var_24_3 = pg.MsgboxMgr.GetInstance()
				local var_24_4 = {
					showStopRemind = true
				}

				var_24_4.content = i18n("ship_buildShipScene_quest_quickFinish", 1, (self.itemVO.count == 0 or nil) and (COLOR_RED or COLOR_GREEN), self.itemVO.count)
				var_24_4.stopRamindContent = i18n("dont_remind_session")

				function var_24_4.onYes()
					self:emit(BuildShipDetailMediator.ON_QUICK, arg_22_1, var_24_3.stopRemindToggle.isOn)

					return
				end

				var_24_3:ShowMsgBox(var_24_4)
			end

			return
		end, SFX_UI_BUILDING_FASTBUILDING)

		local function var_22_9()
			pg.TimeMgr.GetInstance():RemoveTimer(self.buildTimers[arg_22_1])

			self.buildTimers[arg_22_1] = nil

			setActive(var_22_1, false)
			setActive(var_22_2, true)

			return
		end

		local function var_22_10(arg_27_0)
			setText(var_22_8, (pg.TimeMgr.GetInstance():DescCDTime(arg_27_0)))

			return
		end

		if self.buildTimers[arg_22_1] then
			pg.TimeMgr.GetInstance():RemoveTimer(self.buildTimers[arg_22_1])

			self.buildTimers[arg_22_1] = nil
		end

		self.buildTimers[arg_22_1] = pg.TimeMgr.GetInstance():AddTimer("timer" .. arg_22_1, 0, 1, function()
			local var_28_0 = arg_22_2:getLeftTime()

			if var_28_0 <= 0 then
				var_22_9()
			else
				var_22_10(var_28_0)
			end

			return
		end)
	elseif arg_22_2.state == BuildShip.FINISH then
		GetOrAddComponent(var_22_1, typeof(CanvasGroup)).alpha = 0

		setActive(var_22_1, true)

		local var_22_11 = var_22_5:Find("shipModelBuliding" .. var_22_4)

		if var_22_11 then
			setActive(var_22_11, true)
		end

		self:setSpriteTo(var_0_5[tonumber(pg.ship_data_create_material[arg_22_2.type].ship_icon)], var_22_2:Find("ship_modal"), false)

		local var_22_12 = findTF(var_22_2, "launched_btn")

		onButton(self, var_22_12, function()
			self:emit(BuildShipDetailMediator.ON_LAUNCHED, arg_22_1)

			return
		end, SFX_PANEL)
		onButton(self, var_22_0, function()
			triggerButton(var_22_12)

			return
		end, SFX_PANEL)
	elseif arg_22_2.state == BuildShip.INACTIVE then
		setActive(var_22_3, true)
		setActive(var_22_1, false)
		setActive(var_22_2, false)
	end

	return
end

function BuildShipDetailLayer:playGetShipAnimate(arg_31_1, arg_31_2)
	self.canvasgroup.blocksRaycasts = false

	local var_31_0 = pg.ship_data_create_material[arg_31_2]

	self.isPlayAnim = true
	self.onLoading = true

	pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
		self.onLoading = false

		if var_31_0 and var_31_0.build_voice ~= "" then
			self:playCV(var_31_0.build_voice)
		end

		warning("BuildingCPK PlayCallBack", pg.CpkPlayMgr.GetInstance()._ratioFitter.enabled)

		return
	end, function()
		self.isPlayAnim = false
		self.canvasgroup.blocksRaycasts = true

		arg_31_1()

		return
	end, "ui", pg.ship_data_create_material[arg_31_2].build_anim or "Building", true, false, 4.5, true)

	return
end

function BuildShipDetailLayer:willExit()
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()

	for iter_34_0, iter_34_1 in pairs(self.buildTimers) do
		pg.TimeMgr.GetInstance():RemoveTimer(iter_34_1)
	end

	if self.aniBgTF then
		SetParent(self.aniBgTF, self._tf)
	end

	self.buildTimers = nil

	self:stopCV()

	self.onLoading = false

	self.multList:each(function(arg_35_0, arg_35_1)
		eachChild(arg_35_1:Find("frame/buiding/ship_modal"), function(arg_36_0)
			PoolMgr.GetInstance():ReturnUI(arg_36_0.name, arg_36_0)

			return
		end)

		return
	end)
	self.singleList:each(function(arg_37_0, arg_37_1)
		eachChild(arg_37_1:Find("frame/buiding/ship_modal"), function(arg_38_0)
			PoolMgr.GetInstance():ReturnUI(arg_38_0.name, arg_38_0)

			return
		end)

		return
	end)

	return
end

function BuildShipDetailLayer:playCV(arg_39_1)
	self:stopCV()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/cv/build/" .. arg_39_1)

	self.voiceContent = "event:/cv/build/" .. arg_39_1

	return
end

function BuildShipDetailLayer:stopCV()
	if self.voiceContent then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self.voiceContent)
	end

	self.voiceContent = nil

	return
end

function BuildShipDetailLayer:ChangeAutoLockShip(arg_41_1, arg_41_2)
	local var_41_0 = getProxy(PlayerProxy):getRawData():GetCommonFlag(_G[arg_41_1.name])

	if (arg_41_1.default == 1 or nil) and arg_41_2 then
		pg.m02:sendNotification(GAME.CANCEL_COMMON_FLAG, {
			flagID = _G[arg_41_1.name]
		})
	else
		pg.m02:sendNotification(GAME.COMMON_FLAG, {
			flagID = _G[arg_41_1.name]
		})
	end

	return
end

return BuildShipDetailLayer
