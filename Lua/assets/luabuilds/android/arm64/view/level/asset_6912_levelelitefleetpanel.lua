local LevelEliteFleetPanel = class("LevelEliteFleetPanel", import("..base.BasePanel"))
local var_0_1 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

function LevelEliteFleetPanel:init()
	LevelEliteFleetPanel.super.init(self)

	self.tfShipTpl = self._tf:Find("panel/shiptpl")
	self.tfEmptyTpl = self._tf:Find("panel/emptytpl")
	self.tfFleets = {
		[FleetType.Normal] = {
			self._tf:Find("panel/fleet/1"),
			self._tf:Find("panel/fleet/2")
		},
		[FleetType.Submarine] = {
			self._tf:Find("panel/sub/1")
		}
	}
	self.tfLimit = self._tf:Find("panel/limit")
	self.tfLimitTips = self._tf:Find("panel/limit_tip")
	self.tfLimitElite = self._tf:Find("panel/limit_elite")
	self.tfLimitContainer = self._tf:Find("panel/limit_elite/limit_list")
	self.tfLimitTpl = self._tf:Find("panel/limit_elite/condition")
	self.btnBack = self._tf:Find("panel/btnBack")
	self.btnGo = self._tf:Find("panel/start_button")
	self.btnAdHelp = self._tf:Find("panel/title/ADvalue/helpbtn")
	self.commanderBtn = self._tf:Find("panel/commander_btn")
	self.toggleMask = self._tf:Find("mask")

	setActive(self.tfShipTpl, false)
	setActive(self.tfEmptyTpl, false)
	setActive(self.tfLimitTpl, false)
	setActive(self.toggleMask, false)

	self.onConfirm = nil
	self.onCancel = nil
	self.onClick = nil
	self.onLongPressed = nil
	self.onEliteClear = nil
	self.onEliteRecommend = nil

	return
end

function LevelEliteFleetPanel:set(arg_2_1)
	self.chapter = arg_2_1
	self.propetyLimitation = self.chapter:getConfig("property_limitation")
	self.eliteFleetList = self.chapter:getEliteFleetList()
	self.chapterADValue = self.chapter:getConfig("air_dominance")
	self.suggestionValue = math.max(self.chapter:getConfig("best_air_dominance"), 150)
	self.eliteCommanderList = self.chapter:getEliteFleetCommanders()
	self.typeLimitations = self.chapter:getConfig("limitation")

	onButton(self, self.btnGo, function()
		if self.onConfirm then
			self.onConfirm()
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnAdHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.btnBack, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onToggle(self, self.commanderBtn, function(arg_7_0)
		self.parent.contextData.EditingCommander = arg_7_0

		self:flush()

		return
	end, SFX_PANEL)
	triggerToggle(self.commanderBtn, self.parent.contextData.EditingCommander)
	setActive(self.commanderBtn, self.parent.openedCommanerSystem)
	self:flush()

	return
end

function LevelEliteFleetPanel:clear()
	triggerToggle(self.commanderBtn, false)

	return
end

function LevelEliteFleetPanel:flush()
	self:updateLimit()

	if OPEN_AIR_DOMINANCE and self.chapterADValue > 0 then
		setActive(self._tf:Find("panel/title/ADvalue"), true)
		self:updateFleetPanelADValue()
	else
		setActive(self._tf:Find("panel/title/ADvalue"), false)
	end

	self:updateFleets()

	return
end

function LevelEliteFleetPanel:updateLimit()
	setActive(self.toggleMask, false)
	setActive(self.tfLimit, false)
	setActive(self.tfLimitTips, #self.propetyLimitation == 0)
	setActive(self.tfLimitElite, #self.propetyLimitation > 0)
	removeAllChildren(self.tfLimitContainer)

	if #self.propetyLimitation > 0 then
		local var_10_0, var_10_1 = self.chapter:IsPropertyLimitationSatisfy()

		for iter_10_0, iter_10_1 in ipairs(self.propetyLimitation) do
			local var_10_2, var_10_3, var_10_4, var_10_5 = unpack(iter_10_1)
			local var_10_6 = cloneTplTo(self.tfLimitTpl, self.tfLimitContainer)

			var_10_6:Find("Text"):GetComponent(typeof(Text)).color = var_10_0[iter_10_0] == 1 and Color.New(1, 0.9607843137254902, 0.5019607843137255) or Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)

			setActive(var_10_6, true)
			setText(var_10_6:Find("Text"), (AttributeType.EliteCondition2Name(var_10_2, var_10_5) .. AttributeType.eliteConditionCompareTip(var_10_3) .. var_10_4) .. "（" .. var_10_1[var_10_2] .. "）")
		end

		setActive(self.tfLimitElite:Find("sub"), self.chapter:getConfig("submarine_num") > 0)
	end

	return
end

function LevelEliteFleetPanel:updateFleetPanelADValue()
	local var_11_0 = getProxy(BayProxy)
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(self.eliteFleetList) do
		local var_11_2 = {}

		for iter_11_2, iter_11_3 in pairs(self.eliteCommanderList[iter_11_0]) do
			var_11_2[iter_11_2] = getProxy(CommanderProxy):getCommanderById(iter_11_3)
		end

		for iter_11_4, iter_11_5 in ipairs(iter_11_1) do
			var_11_1 = var_11_1 + calcAirDominanceValue(var_11_0:getShipById(iter_11_5), var_11_2)
		end
	end

	local var_11_3 = math.floor(var_11_1)
	local var_11_4 = self._tf:Find("panel/title/ADvalue/Text")

	setText(var_11_4, i18n("level_scene_title_word_5"))
	setText(var_11_4:Find("Num1"), setColorStr(var_11_3, var_11_3 < self.suggestionValue and "#f1dc36" or COLOR_WHITE))
	setText(var_11_4:Find("Num2"), self.suggestionValue)

	return
end

function LevelEliteFleetPanel:initAddButton(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = self.eliteFleetList[arg_12_4]
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(self.eliteFleetList[arg_12_4]) do
		var_12_1[self.parent.shipVOs[iter_12_1]] = true

		if arg_12_2 == self.parent.shipVOs[iter_12_1]:getTeamType() then
			table.insert(var_12_2, iter_12_1)
		end
	end

	removeAllChildren(arg_12_1)

	local var_12_3 = 0
	local var_12_4 = false
	local var_12_5 = 0

	arg_12_3 = Clone(arg_12_3)

	table.sort(arg_12_3, function(arg_13_0, arg_13_1)
		local var_13_0 = type(arg_13_0)
		local var_13_1 = type(arg_13_1)

		if var_13_0 == var_13_1 then
			return var_13_1 < var_13_0
		elseif arg_13_1 == 0 or var_13_1 == "string" and arg_13_0 ~= 0 then
			return true
		else
			return false
		end

		return
	end)

	local var_12_6 = {}
	local var_12_7 = {}

	for iter_12_2 = 1, 3 do
		local var_12_9
		local var_12_10

		if var_12_2[iter_12_2] then
			local var_12_11 = self.parent.shipVOs[var_12_2[iter_12_2]] or nil

			if var_12_11 then
				for iter_12_3, iter_12_4 in ipairs(arg_12_3) do
					if ShipType.ContainInLimitBundle(iter_12_4, var_12_11:getShipType()) then
						var_12_9 = var_12_11
						var_12_10 = iter_12_4

						table.remove(arg_12_3, iter_12_3)
						table.insert(var_12_6, iter_12_3)

						var_12_4 = var_12_4 or iter_12_4 ~= 0

						break
					end
				end

				goto label_12_0
			end
		end

		var_12_10 = arg_12_3[1]

		table.remove(arg_12_3, 1)
		table.insert(var_12_6, 1)

		::label_12_0::

		if var_12_10 == 0 then
			var_12_5 = var_12_5 + 1
		end

		local var_12_12 = var_12_9 and cloneTplTo(self.tfShipTpl, arg_12_1) or cloneTplTo(self.tfEmptyTpl, arg_12_1)

		table.insert(var_12_7, var_12_12)
		setActive(var_12_12, true)

		if var_12_9 then
			updateShip(var_12_12, var_12_9)
			setActive(var_12_12:Find("event_block"), var_12_9:getFlag("inEvent"))

			var_12_1[var_12_9] = true
		else
			var_12_3 = var_12_3 + 1
		end

		local var_12_13 = findTF(var_12_12, "icon_bg")

		setActive(var_12_12:Find("ship_type"), true)

		if type(var_12_10) == "number" then
			if var_12_10 ~= 0 then
				setImageSprite(var_12_12:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.Type2CNLabel(var_12_10)), true)
			else
				setActive(var_12_12:Find("ship_type"), false)
			end
		elseif type(var_12_10) == "string" then
			setImageSprite(var_12_12:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.BundleType2CNLabel(var_12_10)), true)
		end

		setActive(var_12_12:Find("ship_type"), not var_12_9 and var_12_10 ~= 0)

		local var_12_14 = _.map(var_12_0, function(arg_14_0)
			return self.parent.shipVOs[arg_14_0]
		end)

		table.sort(var_12_14, function(arg_15_0, arg_15_1)
			return var_0_1[arg_15_0:getTeamType()] < var_0_1[arg_15_1:getTeamType()] or var_0_1[arg_15_0:getTeamType()] == var_0_1[arg_15_1:getTeamType()] and table.indexof(var_12_0, arg_15_0.id) < table.indexof(var_12_0, arg_15_1.id)
		end)

		local var_12_15 = GetOrAddComponent(var_12_13, typeof(UILongPressTrigger))

		var_12_15.onReleased:RemoveAllListeners()
		var_12_15.onLongPressed:RemoveAllListeners()
		var_12_15.onReleased:AddListener(function()
			self.onClick({
				shipType = var_12_10,
				fleet = var_12_1,
				chapter = self.chapter,
				shipVO = var_12_9,
				fleetIndex = arg_12_4,
				teamType = arg_12_2
			})

			return
		end)
		var_12_15.onLongPressed:AddListener(function()
			if not var_12_9 then
				self.onClick({
					shipType = var_12_10,
					fleet = var_12_1,
					chapter = self.chapter,
					shipVO = var_12_9,
					fleetIndex = arg_12_4,
					teamType = arg_12_2
				})
			else
				self.onLongPressed({
					shipId = var_12_9.id,
					shipVOs = var_12_14,
					chapter = self.chapter
				})
			end

			return
		end)
	end

	for iter_12_5 = 3, 1, -1 do
		var_12_7[iter_12_5]:SetSiblingIndex(var_12_6[iter_12_5] - 1)
	end

	if (var_12_4 == true or var_12_5 == 3) and var_12_3 ~= 3 then
		return true
	else
		return false
	end

	return
end

function LevelEliteFleetPanel:initCommander(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_3:getEliteFleetCommanders()[arg_18_1]

	for iter_18_0 = 1, 2 do
		local var_18_1

		if var_18_0[iter_18_0] then
			var_18_1 = getProxy(CommanderProxy):getCommanderById(var_18_0[iter_18_0])
		end

		local var_18_2 = arg_18_2:Find("pos" .. iter_18_0)
		local var_18_3 = var_18_2:Find("add")
		local var_18_4 = var_18_2:Find("info")

		setActive(var_18_3, not var_18_1)
		setActive(var_18_4, var_18_1)

		if var_18_1 then
			setImageSprite(var_18_4:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_18_1:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_18_1:getPainting(), "", var_18_4:Find("mask/icon"))
		end

		local var_18_5 = arg_18_3:wrapEliteFleet(arg_18_1)

		onButton(self, var_18_3, function()
			self.parent:openCommanderPanel(var_18_5, arg_18_3.id, arg_18_1)

			return
		end, SFX_PANEL)
		onButton(self, var_18_4, function()
			self.parent:openCommanderPanel(var_18_5, arg_18_3.id, arg_18_1)

			return
		end, SFX_PANEL)
	end

	return
end

function LevelEliteFleetPanel:updateFleets()
	for iter_21_0, iter_21_1 in ipairs(self.tfFleets[FleetType.Normal]) do
		local var_21_0 = iter_21_1:Find("btn_clear")
		local var_21_1 = iter_21_1:Find("btn_recom")
		local var_21_2 = iter_21_1:Find("blank")
		local var_21_3 = iter_21_1:Find("commander")

		setActive(iter_21_1:Find("btn_select"), false)
		setActive(findTF(iter_21_1, "selected"), false)

		local var_21_4 = iter_21_0 <= self.chapter:getConfig("group_num")

		setActive(findTF(iter_21_1, TeamType.Main), var_21_4)
		setActive(findTF(iter_21_1, TeamType.Vanguard), var_21_4)
		setActive(var_21_0, var_21_4 and not self.contextData.EditingCommander)
		setActive(var_21_1, var_21_4 and not self.contextData.EditingCommander)
		setActive(var_21_2, not var_21_4)
		setActive(var_21_3, var_21_4 and self.contextData.EditingCommander)
		setText(iter_21_1:Find("bg/name"), (var_21_4 or nil) and (Fleet.DEFAULT_NAME[iter_21_0] or ""))

		if var_21_4 then
			local var_21_6 = self:initAddButton(iter_21_1:Find(TeamType.Main), TeamType.Main, self.typeLimitations[iter_21_0][1], iter_21_0)
			local var_21_7 = self:initAddButton(iter_21_1:Find(TeamType.Vanguard), TeamType.Vanguard, self.typeLimitations[iter_21_0][2], iter_21_0)

			self:initCommander(iter_21_0, var_21_3, self.chapter)

			if var_21_6 and var_21_7 then
				setActive(iter_21_1:Find("selected"), true)
			end

			onButton(self, var_21_0, function()
				if #self.eliteFleetList[iter_21_0] ~= 0 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("battle_preCombatLayer_clear_confirm"),
						onYes = function()
							self.onEliteClear({
								index = iter_21_0,
								chapterVO = self.chapter
							})

							return
						end
					})
				end

				return
			end)
			onButton(self, var_21_1, function()
				if #self.eliteFleetList[iter_21_0] ~= 6 then
					if #self.eliteFleetList[iter_21_0] ~= 0 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("battle_preCombatLayer_auto_confirm"),
							onYes = function()
								self.onEliteRecommend({
									index = iter_21_0,
									chapterVO = self.chapter
								})

								return
							end
						})
					else
						self.onEliteRecommend({
							index = iter_21_0,
							chapterVO = self.chapter
						})
					end
				end

				return
			end)
		end
	end

	for iter_21_2, iter_21_3 in ipairs(self.tfFleets[FleetType.Submarine]) do
		local var_21_8 = iter_21_2 + 2
		local var_21_9 = iter_21_3:Find("btn_clear")
		local var_21_10 = iter_21_3:Find("btn_recom")
		local var_21_11 = iter_21_3:Find("blank")
		local var_21_12 = iter_21_3:Find("commander")

		setActive(iter_21_3:Find("btn_select"), false)
		setActive(findTF(iter_21_3, "selected"), false)
		setActive(findTF(iter_21_3, TeamType.Submarine), iter_21_2 <= self.chapter:getConfig("submarine_num"))
		setActive(var_21_9, iter_21_2 <= self.chapter:getConfig("submarine_num") and not self.contextData.EditingCommander)
		setActive(var_21_10, iter_21_2 <= self.chapter:getConfig("submarine_num") and not self.contextData.EditingCommander)
		setActive(var_21_11, iter_21_2 > self.chapter:getConfig("submarine_num"))
		setActive(var_21_12, iter_21_2 <= self.chapter:getConfig("submarine_num") and self.contextData.EditingCommander)
		setText(iter_21_3:Find("bg/name"), (iter_21_2 <= self.chapter:getConfig("submarine_num") or nil) and (Fleet.DEFAULT_NAME[Fleet.SUBMARINE_FLEET_ID + iter_21_2 - 1] or ""))
		self:initCommander(var_21_8, var_21_12, self.chapter)

		if iter_21_2 <= self.chapter:getConfig("submarine_num") then
			if self:initAddButton(iter_21_3:Find(TeamType.Main), TeamType.Submarine, {
				0,
				0,
				0
			}, var_21_8) then
				setActive(iter_21_3:Find("selected"), true)
			end

			onButton(self, var_21_9, function()
				if #self.eliteFleetList[var_21_8] ~= 0 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("battle_preCombatLayer_clear_confirm"),
						onYes = function()
							self.onEliteClear({
								index = var_21_8,
								chapterVO = self.chapter
							})

							return
						end
					})
				end

				return
			end)
			onButton(self, var_21_10, function()
				if #self.eliteFleetList[var_21_8] ~= 3 then
					if #self.eliteFleetList[var_21_8] ~= 0 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("battle_preCombatLayer_auto_confirm"),
							onYes = function()
								self.onEliteRecommend({
									index = var_21_8,
									chapterVO = self.chapter
								})

								return
							end
						})
					else
						self.onEliteRecommend({
							index = var_21_8,
							chapterVO = self.chapter
						})
					end
				end

				return
			end)
		end
	end

	return
end

return LevelEliteFleetPanel
