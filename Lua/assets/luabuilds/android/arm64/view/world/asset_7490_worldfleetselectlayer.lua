local WorldFleetSelectLayer = class("WorldFleetSelectLayer", import("..base.BaseUI"))

function WorldFleetSelectLayer:getUIName()
	return "WorldFleetSelect"
end

function WorldFleetSelectLayer:init()
	self.rtBg = self._tf:Find("bg")

	local var_2_0 = nowWorld():GetRealm()

	eachChild(self.rtBg, function(arg_3_0)
		setActive(arg_3_0, arg_3_0.name == tostring(var_2_0))

		return
	end)

	self.rtPanel = self._tf:Find("panel")
	self.rtShipTpl = self.rtPanel:Find("shiptpl")

	setActive(self.rtShipTpl, false)

	self.rtEmptyTpl = self.rtPanel:Find("emptytpl")

	setActive(self.rtEmptyTpl, false)

	self.rtScroll = self.rtPanel:Find("bg")
	self.rtContent = self.rtScroll:Find("content")
	self.rtFleets = {
		[FleetType.Normal] = self.rtContent:Find("fleet"),
		[FleetType.Submarine] = self.rtContent:Find("sub")
	}
	self.btnBack = self.rtPanel:Find("btnBack")
	self.btnGo = self.rtPanel:Find("start_button")
	self.commanderToggle = self.rtPanel:Find("commander_btn")
	self.formationToggle = self.rtPanel:Find("formation_btn")
	self.tfLimitTip = self.rtPanel:Find("limit_tip")

	setText(self.tfLimitTip:Find("Text"), i18n("world_fleet_choose"))

	self.tfLimitSub = self.rtPanel:Find("limit_world/limit_sub")

	setText(self.tfLimitSub:Find("Text"), i18n("ship_limit_notice"))

	self.tfLimitContainer = self.rtPanel:Find("limit_world/limit_list")
	self.tfLimitTpl = self.tfLimitContainer:Find("condition")

	self:buildCommanderPanel()

	return
end

function WorldFleetSelectLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self.rtPanel)
	onButton(self, self.btnGo, function()
		local var_5_0, var_5_1 = self:CheckValid()

		if var_5_0 then
			self:emit(WorldFleetSelectMediator.OnGO)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_5_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	local function var_4_0(arg_7_0)
		self.contextData.showCommander = arg_7_0

		for iter_7_0, iter_7_1 in pairs(self.rtFleets) do
			for iter_7_2 = 1, #self.contextData.fleets[iter_7_0] do
				self:updateCommanderBtn(iter_7_1:GetChild(iter_7_2 - 1))
			end
		end

		return
	end

	onToggle(self, self.commanderToggle, function(arg_8_0)
		if arg_8_0 then
			var_4_0(arg_8_0)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.formationToggle, function(arg_9_0)
		if arg_9_0 then
			var_4_0(not arg_9_0)
		end

		return
	end, SFX_PANEL)
	self:UpdateFleets()
	scrollTo(self.rtContent, nil, self.contextData.scrollY)

	self.contextData.showCommander = defaultValue(self.contextData.showCommander, true)

	triggerToggle((self.contextData.showCommander or nil) and (self.commanderToggle or self.formationToggle), true)
	self:CheckWorldResetAward()

	return
end

function WorldFleetSelectLayer:willExit()
	self.contextData.scrollY = GetComponent(self.rtContent, typeof(ScrollRect)).normalizedPosition.y

	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtPanel, self._tf)
	self:destroyCommanderPanel()

	return
end

function WorldFleetSelectLayer:onBackPressed()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("Hide")
	else
		self:closeView()
	end

	return
end

function WorldFleetSelectLayer:UpdateFleets()
	local var_12_0 = self.contextData.fleets

	for iter_12_0, iter_12_1 in pairs(self.contextData.fleets) do
		local var_12_1 = self.rtFleets[iter_12_0]
		local var_12_2 = UIItemList.New(self.rtFleets[iter_12_0], self.rtFleets[iter_12_0]:GetChild(0))

		var_12_2:make(function(arg_13_0, arg_13_1, arg_13_2)
			if arg_13_0 == UIItemList.EventUpdate then
				self:UpdateFleet(arg_13_2, iter_12_0, arg_13_1 + 1)
			end

			return
		end)
		var_12_2:align(#var_12_0[iter_12_0])
		setActive(var_12_1, #var_12_0[iter_12_0] > 0)
	end

	self:updateEliteLimit()

	return
end

function WorldFleetSelectLayer:IsPropertyLimitationSatisfy()
	local var_14_0 = getProxy(BayProxy):getRawData()
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(pg.gameset.world_fleet_unlock_level.description) do
		var_14_1[iter_14_1[1]] = 0
	end

	local var_14_2 = 0

	for iter_14_2, iter_14_3 in ipairs(self.contextData.fleets[FleetType.Normal]) do
		if self:GetTeamShipCount(iter_14_3[TeamType.Main]) == 0 or self:GetTeamShipCount(iter_14_3[TeamType.Vanguard]) == 0 then
			-- block empty
		else
			local var_14_3 = {}
			local var_14_4 = {}
			local var_14_5 = 0

			for iter_14_4, iter_14_5 in ipairs(pg.gameset.world_fleet_unlock_level.description) do
				local var_14_6, var_14_7, var_14_8, var_14_9 = unpack(iter_14_5)

				if string.sub(var_14_6, 1, 5) == "fleet" then
					var_14_3[var_14_6] = 0
					var_14_4[var_14_6] = var_14_9
				end
			end

			for iter_14_6, iter_14_7 in pairs(iter_14_3) do
				for iter_14_8 = 1, 3 do
					local var_14_10 = iter_14_7[iter_14_8] and var_14_0[iter_14_7[iter_14_8]]

					if var_14_10 then
						var_14_2 = var_14_2 + 1
						var_14_5 = var_14_5 + 1

						local var_14_11 = intProperties(var_14_10:getProperties())

						for iter_14_9, iter_14_10 in pairs(var_14_1) do
							if string.sub(iter_14_9, 1, 5) == "fleet" then
								if iter_14_9 == "fleet_totle_level" then
									var_14_3[iter_14_9] = var_14_3[iter_14_9] + var_14_10.level
								end
							else
								var_14_1[iter_14_9] = iter_14_9 == "level" and iter_14_10 + var_14_10.level or iter_14_10 + var_14_11[iter_14_9]
							end
						end
					end
				end
			end

			for iter_14_11, iter_14_12 in pairs(var_14_3) do
				if iter_14_11 == "fleet_totle_level" and iter_14_12 > var_14_4[iter_14_11] then
					var_14_1[iter_14_11] = var_14_1[iter_14_11] + 1
				end
			end
		end
	end

	local var_14_12 = {}

	for iter_14_13, iter_14_14 in ipairs(pg.gameset.world_fleet_unlock_level.description) do
		local var_14_13, var_14_14, var_14_15, var_14_16 = unpack(iter_14_14)

		if var_14_13 == "level" and var_14_2 > 0 then
			var_14_1[var_14_13] = math.ceil(var_14_1[var_14_13] / var_14_2)
		end

		var_14_12[iter_14_13] = AttributeType.EliteConditionCompare(var_14_14, var_14_1[var_14_13], var_14_15) and 1 or 0
	end

	return var_14_12, var_14_1
end

function WorldFleetSelectLayer:updateEliteLimit()
	local var_15_0 = pg.gameset.world_fleet_unlock_level.description

	if #pg.gameset.world_fleet_unlock_level.description == 0 then
		return
	end

	local var_15_1, var_15_2 = self:IsPropertyLimitationSatisfy()
	local var_15_3 = UIItemList.New(self.tfLimitContainer, self.tfLimitTpl)

	var_15_3:make(function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0, var_16_1, var_16_2, var_16_3 = unpack(var_15_0[arg_16_1])

			arg_16_2:Find("Text"):GetComponent(typeof(Text)).color = var_15_1[arg_16_1] == 1 and Color.New(1, 0.9607843137254902, 0.5019607843137255) or Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)

			setText(arg_16_2:Find("Text"), (AttributeType.EliteCondition2Name(var_16_0, var_16_3) .. AttributeType.eliteConditionCompareTip(var_16_1) .. var_16_2) .. "（" .. var_15_2[var_16_0] .. "）")
		end

		return
	end)
	var_15_3:align(#pg.gameset.world_fleet_unlock_level.description)

	return
end

function WorldFleetSelectLayer:updateCommanderBtn(arg_17_1)
	setActive(arg_17_1:Find("btn_recom"), not self.contextData.showCommander)
	setActive(arg_17_1:Find("btn_clear"), not self.contextData.showCommander)
	setActive(arg_17_1:Find("commander"), self.contextData.showCommander)

	return
end

function WorldFleetSelectLayer:UpdateFleet(arg_18_1, arg_18_2, arg_18_3)
	self:updateCommanders(arg_18_1:Find("commander"), arg_18_2, arg_18_3)

	local var_18_0 = self.contextData.fleets[arg_18_2][arg_18_3]

	setText(arg_18_1:Find("bg/name"), Fleet.DEFAULT_NAME[(arg_18_2 == FleetType.Submarine and 10 or 0) + arg_18_3])

	if arg_18_2 == FleetType.Normal then
		self:UpdateShips(arg_18_1:Find(TeamType.Main), TeamType.Main, var_18_0)
		self:UpdateShips(arg_18_1:Find(TeamType.Vanguard), TeamType.Vanguard, var_18_0)
		setActive(arg_18_1:Find("selected"), self:GetTeamShipCount(var_18_0[TeamType.Main]) > 0 and self:GetTeamShipCount(var_18_0[TeamType.Vanguard]) > 0)
	elseif arg_18_2 == FleetType.Submarine then
		self:UpdateShips(arg_18_1:Find(TeamType.Submarine), TeamType.Submarine, var_18_0)
		setActive(arg_18_1:Find("selected"), self:GetTeamShipCount(var_18_0[TeamType.Submarine]) > 0)
	end

	onButton(self, arg_18_1:Find("btn_recom"), function()
		self:RecommendFormation(arg_18_2, arg_18_3)
		self:UpdateFleet(arg_18_1, arg_18_2, arg_18_3)
		self:updateEliteLimit()

		return
	end, SFX_PANEL)
	onButton(self, arg_18_1:Find("btn_clear"), function()
		if self:GetTeamShipCount(var_18_0[TeamType.Main]) > 0 or self:GetTeamShipCount(var_18_0[TeamType.Vanguard]) > 0 or self:GetTeamShipCount(var_18_0[TeamType.Submarine]) > 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("battle_preCombatLayer_clear_confirm"),
				onYes = function()
					var_18_0[TeamType.Main] = {}
					var_18_0[TeamType.Vanguard] = {}
					var_18_0[TeamType.Submarine] = {}

					self:UpdateFleet(arg_18_1, arg_18_2, arg_18_3)
					self:updateEliteLimit()

					return
				end
			})
		end

		return
	end, SFX_CANCEL)

	return
end

function WorldFleetSelectLayer:updateCommanders(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = Fleet.New({
		ship_list = {},
		commanders = self.contextData.fleets[arg_22_2][arg_22_3].commanders
	})

	for iter_22_0 = 1, 2 do
		local var_22_1 = var_22_0:getCommanderByPos(iter_22_0)
		local var_22_2 = arg_22_1:Find("pos" .. iter_22_0)
		local var_22_3 = var_22_2:Find("add")
		local var_22_4 = var_22_2:Find("info")

		setActive(var_22_3, not var_22_1)
		setActive(var_22_4, var_22_1)

		if var_22_1 then
			setImageSprite(var_22_4:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_22_1:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_22_1:getPainting(), "", var_22_4:Find("mask/icon"))
		else
			local var_22_5 = 1

			while self.contextData.fleets[arg_22_2][arg_22_3].commanders[var_22_5] and self.contextData.fleets[arg_22_2][arg_22_3].commanders[var_22_5].pos ~= iter_22_0 do
				var_22_5 = var_22_5 + 1
			end

			if self.contextData.fleets[arg_22_2][arg_22_3].commanders[var_22_5] then
				table.remove(self.contextData.fleets[arg_22_2][arg_22_3].commanders, var_22_5)
			end
		end

		onButton(self, var_22_3, function()
			self:openCommanderPanel(var_22_0, arg_22_2, arg_22_3)

			return
		end, SFX_PANEL)
		onButton(self, var_22_4, function()
			self:openCommanderPanel(var_22_0, arg_22_2, arg_22_3)

			return
		end, SFX_PANEL)
	end

	return
end

function WorldFleetSelectLayer:UpdateShips(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = getProxy(BayProxy)
	local var_25_1 = arg_25_3[arg_25_2]
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in ipairs({
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}) do
		for iter_25_2 = 1, 3 do
			local var_25_3 = arg_25_3[iter_25_1][iter_25_2] and var_25_0:getShipById(arg_25_3[iter_25_1][iter_25_2]) or nil

			table.insert(var_25_2, var_25_3)

			if not var_25_3 then
				arg_25_3[iter_25_1][iter_25_2] = nil
			end
		end
	end

	removeAllChildren(arg_25_1)

	for iter_25_3 = 1, 3 do
		local var_25_4
		local var_25_5

		if arg_25_3[arg_25_2][iter_25_3] then
			var_25_4 = cloneTplTo(self.rtShipTpl, arg_25_1, "ship_" .. arg_25_3[arg_25_2][iter_25_3])
			var_25_5 = var_25_0:getShipById(arg_25_3[arg_25_2][iter_25_3])

			updateShip(var_25_4, var_25_5)
		else
			var_25_4 = cloneTplTo(self.rtEmptyTpl, arg_25_1, "empty")

			setActive(var_25_4:Find("ship_type"), false)
		end

		onButton(self, var_25_4:Find("icon_bg"), function()
			self:emit(WorldFleetSelectMediator.OnSelectShip, arg_25_2, var_25_1, iter_25_3)

			return
		end, SFX_PANEL)

		local var_25_6 = GetOrAddComponent(var_25_4:Find("icon_bg"), typeof(UILongPressTrigger))

		pg.DelegateInfo.Add(self, var_25_6.onLongPressed)
		var_25_6.onLongPressed:RemoveAllListeners()
		var_25_6.onLongPressed:AddListener(function()
			if not var_25_5 then
				self:emit(WorldFleetSelectMediator.OnSelectShip, arg_25_2, var_25_1, iter_25_3)
			else
				self:emit(WorldFleetSelectMediator.OnShipDetail, {
					shipId = var_25_5.id,
					shipVOs = var_25_2
				})
			end

			return
		end)
	end

	return
end

function WorldFleetSelectLayer:setCommanderPrefabs(arg_28_1)
	self.commanderPrefabs = arg_28_1

	return
end

function WorldFleetSelectLayer:openCommanderPanel(arg_29_1, arg_29_2, arg_29_3)
	self.levelCMDFormationView:setCallback(function(arg_30_0)
		if arg_30_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(WorldFleetSelectMediator.OnCommanderSkill, arg_30_0.skill)
		elseif arg_30_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				fleetType = arg_29_2,
				fleetIndex = arg_29_3,
				pos = arg_30_0.pos
			}

			self:emit(WorldFleetSelectMediator.OnSelectEliteCommander, arg_29_2, arg_29_3, arg_30_0.pos)
			self:closeCommanderPanel()
		else
			self:emit(WorldFleetSelectMediator.OnCommanderFormationOp, {
				FleetType = LevelUIConst.FLEET_TYPE_WORLD,
				data = arg_30_0,
				fleets = self.contextData.fleets,
				fleetType = arg_29_2,
				fleetIndex = arg_29_3
			})
		end

		return
	end)
	self.levelCMDFormationView:Load()
	self.levelCMDFormationView:ActionInvoke("update", arg_29_1, self.commanderPrefabs)
	self.levelCMDFormationView:ActionInvoke("Show")

	return
end

function WorldFleetSelectLayer:closeCommanderPanel()
	self.levelCMDFormationView:ActionInvoke("Hide")

	return
end

function WorldFleetSelectLayer:updateCommanderFleet(arg_32_1)
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updateFleet", arg_32_1)
	end

	return
end

function WorldFleetSelectLayer:updateCommanderPrefab()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updatePrefabs", self.commanderPrefabs)
	end

	return
end

function WorldFleetSelectLayer:buildCommanderPanel()
	self.levelCMDFormationView = LevelCMDFormationView.New(self._tf, self.event, self.contextData)

	return
end

function WorldFleetSelectLayer:destroyCommanderPanel()
	self.levelCMDFormationView:Destroy()

	self.levelCMDFormationView = nil

	return
end

function WorldFleetSelectLayer:CheckValid()
	for iter_36_0, iter_36_1 in pairs(self.contextData.fleets) do
		if iter_36_0 == FleetType.Normal then
			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				if self:GetTeamShipCount(iter_36_3[TeamType.Main]) == 0 or self:GetTeamShipCount(iter_36_3[TeamType.Vanguard]) == 0 then
					local var_36_1 = i18n("world_fleet_formation_not_valid", Fleet.DEFAULT_NAME[iter_36_2])

					return
				end
			end
		end
	end

	local var_36_2, var_36_3 = self:IsPropertyLimitationSatisfy()
	local var_36_4 = 1

	for iter_36_4, iter_36_5 in ipairs(var_36_2) do
		var_36_4 = var_36_4 * iter_36_5
	end

	if var_36_4 ~= 1 then
		local var_36_6 = i18n("elite_disable_property_unsatisfied")

		return
	end

	return true
end

function WorldFleetSelectLayer:GetTeamShipCount(arg_37_1)
	local var_37_0 = 0

	for iter_37_0 = 1, 3 do
		if arg_37_1[iter_37_0] then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0
end

function WorldFleetSelectLayer:RecommendFormation(arg_38_1, arg_38_2)
	local var_38_0 = {
		[FleetType.Normal] = {
			TeamType.Main,
			TeamType.Vanguard
		},
		[FleetType.Submarine] = {
			TeamType.Submarine
		}
	}
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in pairs(self.contextData.fleets) do
		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			for iter_38_4, iter_38_5 in ipairs(var_38_0[iter_38_0]) do
				for iter_38_6 = 1, 3 do
					if iter_38_3[iter_38_5][iter_38_6] then
						table.insert(var_38_1, iter_38_3[iter_38_5][iter_38_6])
					end
				end
			end
		end
	end

	local var_38_2 = getProxy(BayProxy)

	for iter_38_7, iter_38_8 in ipairs(var_38_0[arg_38_1]) do
		for iter_38_9 = 1, 3 do
			if not self.contextData.fleets[arg_38_1][arg_38_2][iter_38_8][iter_38_9] then
				local var_38_3 = var_38_2:getWorldRecommendShip(iter_38_8, var_38_1)

				if var_38_3 then
					self.contextData.fleets[arg_38_1][arg_38_2][iter_38_8][iter_38_9] = var_38_3.id

					table.insert(var_38_1, var_38_3.id)
				end
			end
		end
	end

	return
end

function WorldFleetSelectLayer:CheckWorldResetAward()
	local var_39_0 = {}
	local var_39_1 = nowWorld()
	local var_39_2 = var_39_1.resetAward

	if var_39_1.resetAward and #var_39_1.resetAward > 0 then
		local var_39_3 = pg.gameset.world_resetting_story.description[1]

		if #pg.gameset.world_resetting_story.description[1] > 0 then
			table.insert(var_39_0, function(arg_40_0)
				pg.NewStoryMgr.GetInstance():Play(var_39_3, arg_40_0, true)

				return
			end)
		end

		table.insert(var_39_0, function(arg_41_0)
			local var_41_0

			var_41_0 = {
				hideYes = true,
				hideNo = true,
				type = MSGBOX_TYPE_WORLD_RESET,
				itemFunc = function(arg_42_0)
					self:emit(WorldFleetSelectLayer.ON_DROP, arg_42_0, function()
						pg.MsgboxMgr.GetInstance():ShowMsgBox(var_41_0)

						return
					end)

					return
				end,
				drops = var_39_2,
				tipWord = i18n("world_recycle_item_transform"),
				onNo = arg_41_0
			}

			pg.MsgboxMgr.GetInstance():ShowMsgBox(nil)

			return
		end)
	end

	if var_39_1.resetLimitTip then
		table.insert(var_39_0, function(arg_44_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("world_resource_fill")
			})

			return
		end)
	end

	seriesAsync(var_39_0, function()
		var_39_1:ClearResetAward()

		return
	end)

	return
end

return WorldFleetSelectLayer
