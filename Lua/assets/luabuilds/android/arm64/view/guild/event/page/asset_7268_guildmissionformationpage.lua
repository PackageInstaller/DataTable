local GuildMissionFormationPage = class("GuildMissionFormationPage", import(".GuildEventBasePage"))

function GuildMissionFormationPage:getUIName()
	return "GuildMissionFormationPage"
end

function GuildMissionFormationPage:OnRefreshMission(arg_2_1)
	if not self.mission or self.mission.id ~= arg_2_1.id then
		return
	end

	self:Flush(arg_2_1)

	return
end

function GuildMissionFormationPage:OnFormationDone()
	local var_3_0 = {}

	self.loading = true

	for iter_3_0, iter_3_1 in pairs(self.shipGos) do
		table.insert(var_3_0, function(arg_4_0)
			iter_3_1:SetAction("victory", 0)
			iter_3_1:SetActionCallBack(function(arg_5_0)
				if arg_5_0 == "finish" then
					iter_3_1:SetActionCallBack(nil)
					iter_3_1:SetAction("stand", 0)
					arg_4_0()
				end

				return
			end)

			return
		end)
	end

	parallelAsync(var_3_0, function()
		self:Hide()

		self.loading = false

		return
	end)

	local var_3_1 = self.canFormationIndex or 1

	for iter_3_2, iter_3_3 in ipairs(self.pageFooter) do
		setActive(iter_3_3, iter_3_2 <= var_3_1)
	end

	setActive(self.pageFooterAdd, false)

	return
end

function GuildMissionFormationPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.titleTxt = self._tf:Find("frame/title"):GetComponent(typeof(Text))
	self.recomBtn = self._tf:Find("frame/recom")
	self.clearBtn = self._tf:Find("frame/clear")
	self.goBtn = self._tf:Find("frame/bottom/go")
	self.inProgressBtn = self._tf:Find("frame/bottom/doingBtn")
	self.battleAreaTxt = self._tf:Find("frame/bottom/desc/area/Text"):GetComponent(typeof(Text))
	self.battleTypeTxt = self._tf:Find("frame/bottom/desc/type/Text"):GetComponent(typeof(Text))
	self.awardList = UIItemList.New(self._tf:Find("frame/bottom/award/list"), self._tf:Find("frame/bottom/award/list/item"))
	self.target1Text = self._tf:Find("frame/bottom/desc/target/content/Text"):GetComponent(typeof(Text))
	self.target2Text = self._tf:Find("frame/bottom/desc/target/content/Text2"):GetComponent(typeof(Text))
	self.target1Text4Effect = self._tf:Find("frame/bottom/desc/target/content1/Text"):GetComponent(typeof(Text))
	self.target2Text4Effect = self._tf:Find("frame/bottom/desc/target/content1/Text2"):GetComponent(typeof(Text))
	self.scoreAdditionTxt = self._tf:Find("frame/bottom/score_addition/Text"):GetComponent(typeof(Text))
	self.effectAdditionTxt = self._tf:Find("frame/bottom/effect_addition/Text"):GetComponent(typeof(Text))
	self.effectTxt = self._tf:Find("frame/bottom/effect/Text"):GetComponent(typeof(Text))
	self.bg = self._tf:Find("frame/bottom/bg"):GetComponent(typeof(Image))
	self.pageFooter = {
		self._tf:Find("frame/single/dot/1"),
		self._tf:Find("frame/single/dot/2"),
		self._tf:Find("frame/single/dot/3"),
		self._tf:Find("frame/single/dot/4")
	}
	self.pageFooterAdd = self._tf:Find("frame/single/dot/add")
	self.nextBtn = self._tf:Find("frame/single/next")
	self.prevBtn = self._tf:Find("frame/single/prev")

	setText(self._tf:Find("frame/bottom/desc/area"), i18n("guild_word_battle_area"))
	setText(self._tf:Find("frame/bottom/desc/type"), i18n("guild_word_battle_type"))

	return
end

function GuildMissionFormationPage:OnInit()
	local function var_8_0()
		if self.contextData.index > 1 then
			triggerToggle(self.pageFooter[self.contextData.index - 1], true)
		end

		return
	end

	local function var_8_1()
		if self.contextData.index < self.mission:GetMaxFleet() then
			if self.contextData.index + 1 > self.mission:GetFleetCnt() then
				triggerToggle(self.pageFooterAdd, true)
			else
				triggerToggle(self.pageFooter[self.contextData.index + 1], true)
			end
		end

		return
	end

	addSlip(SLIP_TYPE_HRZ, self._tf:Find("frame"), var_8_0, var_8_1)
	onButton(self, self.nextBtn, var_8_1, SFX_PANEL)
	onButton(self, self.prevBtn, var_8_0, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self.contextData.missionShips = nil

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.recomBtn, function()
		if not self:CheckFormation() then
			return
		end

		self:emit(GuildEventMediator.ON_GET_FORMATION, function()
			local var_13_0 = getProxy(GuildProxy):GetRecommendShipsForMission(self.mission)

			if #var_13_0 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_recomm_ship_failed"))

				return
			end

			self.contextData.missionShips = var_13_0

			self:UpdateFleet(self.contextData.index)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		if not self:CheckFormation() then
			return
		end

		self.contextData.missionShips = {}

		self:UpdateFleet(self.contextData.index)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		if self.mission:IsFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_finish"))

			return
		end

		if not self:CheckFormation() then
			return
		end

		if not self.contextData.missionShips or #self.contextData.missionShips == 0 then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_event_start_event_tip"),
			onYes = function()
				self:emit(GuildEventMediator.JOIN_MISSION, self.mission.id, self.contextData.missionShips)

				return
			end
		})

		return
	end, SFX_PANEL)

	self.shipGos = {}

	return
end

function GuildMissionFormationPage:OnShow()
	self.loading = nil
	self.maxShipCnt = self.extraData.shipCnt

	self:UpdateLayout()
	self:Flush(self.extraData.mission)
	self:UpdatePageFooter()
	self:AddNextFormationTimer()

	return
end

function GuildMissionFormationPage:UpdatePageFooter()
	local var_18_0 = self.mission:GetFleetCnt()

	for iter_18_0, iter_18_1 in ipairs(self.pageFooter) do
		setActive(iter_18_1, iter_18_0 <= var_18_0)
		onToggle(self, iter_18_1, function(arg_19_0)
			if arg_19_0 then
				self:UpdateFleet(iter_18_0)
				self:UpdateSwitchBtns()
			end

			return
		end, SFX_PANEL)
	end

	setActive(self.pageFooterAdd, (self.mission:CanFormation()))
	onToggle(self, self.pageFooterAdd, function(arg_20_0)
		if arg_20_0 then
			self:UpdateFleet(var_18_0 + 1)
		end

		return
	end, SFX_PANEL)

	local var_18_1 = self.contextData.index or 1

	if var_18_0 < var_18_1 then
		triggerToggle(self.pageFooterAdd, true)
	else
		triggerToggle(self.pageFooter[var_18_1], true)
	end

	return
end

function GuildMissionFormationPage:UpdateSwitchBtns()
	local var_21_0 = self.mission:GetMaxFleet()
	local var_21_1 = self.contextData.index

	setActive(self.prevBtn, self.contextData.index ~= 1)
	setActive(self.nextBtn, var_21_1 < var_21_0)

	return
end

function GuildMissionFormationPage:AddNextFormationTimer()
	local var_22_0 = self.mission

	if self.mission:IsMaxFleetCnt() then
		return
	end

	local function var_22_1(arg_23_0)
		self.canFormationIndex = var_22_0:GetCanFormationIndex()

		setActive(self.pageFooterAdd, true)

		if arg_23_0 then
			triggerToggle(self.pageFooterAdd, false)
		end

		var_22_0:RecordFormationTip()
		setActive(self.pageFooterAdd:Find("tip"), var_22_0:ShouldShowFormationTip())
		self:UpdateSwitchBtns()

		return
	end

	if not self.mission:CanFormation() then
		self.timer = Timer.New(function()
			self.timer:Stop()

			self.timer = nil

			var_22_1(true)

			return
		end, self.mission:GetNextFormationTime() - pg.TimeMgr.GetInstance():GetServerTime(), 1)

		self.timer:Start()
	else
		var_22_1()
	end

	return
end

function GuildMissionFormationPage:Flush(arg_25_1)
	self.mission = arg_25_1
	self.canFormationIndex = arg_25_1:GetCanFormationIndex()

	self:InitView()

	return
end

function GuildMissionFormationPage:UpdateLayout()
	self.bg.sprite = GetSpriteFromAtlas("ui/GuildFormationUI_atlas", "bg3")

	local var_26_0 = self._tf:Find("frame/single")

	self.shipContainer = var_26_0
	self.bg.gameObject.transform.sizeDelta = Vector2(self.bg.gameObject.transform.sizeDelta.x, 212)

	setActive(var_26_0, true)

	return
end

function GuildMissionFormationPage:InitView()
	if self.initId ~= self.mission.id then
		local var_27_0 = self.mission:GetAwards()

		self.awardList:make(function(arg_28_0, arg_28_1, arg_28_2)
			if arg_28_0 == UIItemList.EventUpdate then
				local var_28_0 = {
					type = var_27_0[arg_28_1 + 1][1],
					id = var_27_0[arg_28_1 + 1][2],
					count = var_27_0[arg_28_1 + 1][3]
				}

				updateDrop(arg_28_2, var_28_0)
				onButton(self, arg_28_2, function()
					self:send(BaseUI.ON_DROP, var_28_0)

					return
				end, SFX_PANEL)
			end

			return
		end)
		self.awardList:align(#var_27_0)

		self.battleAreaTxt.text = self.mission:getConfig("ship_camp_display")
		self.battleTypeTxt.text = self.mission:getConfig("ship_type_display")
		self.titleTxt.text = self.mission:GetName()
		self.initId = self.mission.id
	end

	return
end

function GuildMissionFormationPage:UpdateFleet(arg_30_1)
	self:ClearSlots()

	local var_30_0 = self.mission
	local var_30_1 = self.maxShipCnt
	local var_30_2 = arg_30_1 == self.canFormationIndex and (self.contextData.missionShips or var_30_0:GetFleetByIndex(arg_30_1)) or var_30_0:GetFleetByIndex(arg_30_1)
	local var_30_3 = {}

	var_30_2 = var_30_2 or {}

	for iter_30_0 = 1, var_30_1 do
		local var_30_4 = self.shipContainer:GetChild(iter_30_0 - 1)

		table.insert(var_30_3, function(arg_31_0)
			self:UpdateShipSlot(iter_30_0, var_30_4, var_30_2, arg_31_0)

			return
		end)
	end

	pg.UIMgr.GetInstance():LoadingOn(false)
	parallelAsync(var_30_3, function()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	if var_30_0:IsEliteType() then
		local var_30_5 = self:GetTagShipCnt(var_30_2)
		local var_30_6 = var_30_0:GetSquadronTargetCnt()
		local var_30_7 = string.format("%s : (<color=%s>%d/%d</color>)", var_30_0:GetSquadronDisplay(), (var_30_6 <= var_30_5 or nil) and (COLOR_GREEN or COLOR_RED), var_30_5, var_30_6)

		self.target2Text.text = HXSet.hxLan(var_30_7)
		self.target2Text4Effect.text = HXSet.hxLan(var_30_7)
	else
		self.target2Text.text = ""
		self.target2Text4Effect.text = ""
	end

	self.effectTxt.text = GuildMission.CalcMyEffect(var_30_2)

	local var_30_8, var_30_9, var_30_10 = self:CalcScoreAddition(var_30_2)

	self.scoreAdditionTxt.text = i18n("guild_word_score_addition") .. var_30_8
	self.effectAdditionTxt.text = i18n("guild_word_effect_addition") .. self:CalcEffectAddition(var_30_2)
	self.target1Text.text = table.concat(self:GetBattleTarget(var_30_9, var_30_10), " 、")
	self.target1Text4Effect.text = self.target1Text.text

	setButtonEnabled(self.goBtn, #var_30_2 > 0)

	local var_30_11 = not var_30_0:CanFormation() or arg_30_1 <= var_30_0:GetFleetCnt()

	setActive(self.inProgressBtn, var_30_11)
	setActive(self.goBtn, not var_30_11)

	self.contextData.index = arg_30_1

	if self.target2Text.text ~= "" and self.target1Text.text ~= "" then
		setText(self._tf:Find("frame/bottom/desc/target/content/title"), i18n("guild_wrod_battle_target"))
	else
		setText(self._tf:Find("frame/bottom/desc/target/content/title"), "")
	end

	return
end

function GuildMissionFormationPage:UpdateShipSlot(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = self.mission
	local var_33_1 = arg_33_3[arg_33_1]
	local var_33_2 = arg_33_2:Find("Image")
	local var_33_3 = arg_33_2:Find("effect")
	local var_33_4 = arg_33_2:Find("score")

	if arg_33_3[arg_33_1] then
		local var_33_5 = getProxy(BayProxy):getShipById(var_33_1)

		if var_33_5 then
			local var_33_6 = var_33_5:getPrefab()

			self.spineChar = SpineAnimChar.New()

			self.spineChar:SetPaint(var_33_6)
			self.spineChar:Load(true, function(arg_34_0)
				arg_34_0:SetName(var_33_6)
				arg_34_0:SetPivot(Vector2(0.5, 0))
				arg_34_0:SetSizeDelta(Vector2(200, 300))
				arg_34_0:SetParent(arg_33_2)
				arg_34_0:SetLocalPosition(Vector3(0, 0, 0))
				arg_34_0:SetLocalScale(Vector3(0.6, 0.6, 0.6))
				arg_34_0:SetAction("stand")
				GetOrAddComponent(arg_34_0:GetModel(), "EventTriggerListener"):AddPointClickFunc(function(arg_35_0, arg_35_1)
					self:emit(GuildEventMediator.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

					return
				end)

				self.shipGos[var_33_1] = arg_34_0

				if arg_33_4 then
					arg_33_4()
				end

				return
			end)
			setActive(var_33_3, self:HasEffectAddition(var_33_5))
			setActive(var_33_4, self:HasScoreAddition(var_33_5))
		elseif arg_33_4 then
			arg_33_4()
		end
	else
		onButton(self, var_33_2, function()
			self:emit(GuildEventMediator.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

			return
		end, SFX_PANEL)
		setActive(var_33_3, false)
		setActive(var_33_4, false)

		if arg_33_4 then
			arg_33_4()
		end
	end

	setActive(var_33_2, not var_33_1)

	return
end

function GuildMissionFormationPage:CheckFormation()
	if self.contextData.index ~= self.canFormationIndex then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_curr_fleet_can_not_edit"))

		return false
	end

	local var_37_1, var_37_2 = self.mission:CanFormation()

	if not var_37_1 then
		if var_37_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_next_edit_fleet_time", var_37_2))
		end

		return false
	end

	return true
end

function GuildMissionFormationPage:emit(...)
	if self.loading then
		return
	end

	if not self:CheckFormation() then
		return
	end

	GuildMissionFormationPage.super.emit(self, ...)

	return
end

function GuildMissionFormationPage:send(...)
	GuildMissionFormationPage.super.emit(self, ...)

	return
end

function GuildMissionFormationPage:GetBattleTarget(arg_40_1, arg_40_2)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs((self.mission:GetAttrCntAcc())) do
		local var_40_1 = arg_40_1[iter_40_0] or 0

		table.insert(var_40_0, GuildMissionInfoPage.AttrCnt2Desc(iter_40_0, {
			value = iter_40_1.value + var_40_1,
			total = iter_40_1.total,
			goal = iter_40_1.goal,
			score = iter_40_1.score
		}))
	end

	for iter_40_2, iter_40_3 in pairs((self.mission:GetAttrAcc())) do
		local var_40_2 = arg_40_2[iter_40_2] or 0

		table.insert(var_40_0, GuildMissionInfoPage.AttrAcc2Desc(iter_40_2, {
			value = iter_40_3.value + var_40_2,
			op = iter_40_3.op,
			goal = iter_40_3.goal,
			score = iter_40_3.score
		}))
	end

	return var_40_0
end

function GuildMissionFormationPage:GetTagShipCnt(arg_41_1)
	local var_41_0 = self.mission:GetSquadron()
	local var_41_1 = 0
	local var_41_2 = getProxy(BayProxy)

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		local var_41_3 = var_41_2:getShipById(iter_41_1)

		if var_41_3 and var_41_3:IsTagShip(var_41_0) then
			var_41_1 = var_41_1 + 1
		end
	end

	return var_41_1
end

function GuildMissionFormationPage:CalcScoreAddition(arg_42_1)
	local var_42_0 = self.mission:GetAttrCntAcc()
	local var_42_1 = self.mission:GetAttrAcc()
	local var_42_2 = pg.attribute_info_by_type
	local var_42_3 = 0
	local var_42_4 = {}
	local var_42_5 = {}
	local var_42_6 = getProxy(BayProxy)

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		local var_42_7 = var_42_6:getShipById(iter_42_1)
		local var_42_8

		if var_42_7 then
			var_42_8 = _.detect(self.mission:getConfig("ship_camp_effect"), function(arg_43_0)
				return arg_43_0[1] == var_42_7:getNation()
			end)
		end

		if var_42_8 then
			var_42_3 = var_42_3 + var_42_8[2]
		end

		local var_42_9 = var_42_7 and var_42_7:getProperties() or {}

		for iter_42_2, iter_42_3 in pairs(var_42_0) do
			if (var_42_9[var_42_2[iter_42_2].name] or 0) >= iter_42_3.total then
				var_42_4[iter_42_2] = (var_42_4[iter_42_2] or 0) + 1
			end
		end

		for iter_42_4, iter_42_5 in pairs(var_42_1) do
			var_42_5[iter_42_4] = (var_42_5[iter_42_4] or 0) + (var_42_9[var_42_2[iter_42_4].name] or 0)
		end
	end

	for iter_42_6, iter_42_7 in pairs(var_42_0) do
		if (var_42_4[iter_42_6] or 0) + iter_42_7.value >= iter_42_7.goal then
			var_42_3 = var_42_3 + iter_42_7.score
		end
	end

	for iter_42_8, iter_42_9 in pairs(var_42_1) do
		local var_42_15 = iter_42_9.value + (var_42_5[iter_42_8] or 0)
		local var_42_16

		if iter_42_9.op == 1 then
			var_42_16 = var_42_15 >= iter_42_9.goal
		elseif iter_42_9.op == 2 then
			var_42_16 = var_42_15 <= iter_42_9.goal
		end

		if var_42_16 then
			var_42_3 = var_42_3 + iter_42_9.score
		end
	end

	return var_42_3, var_42_4, var_42_5
end

function GuildMissionFormationPage:CalcEffectAddition(arg_44_1)
	local var_44_0 = GuildMission.CalcMyEffect(arg_44_1)
	local var_44_1 = getProxy(BayProxy)

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		local var_44_2 = var_44_1:getShipById(iter_44_1)
		local var_44_3

		if var_44_2 then
			var_44_3 = _.detect(self.mission:getConfig("ship_type_effect"), function(arg_45_0)
				return arg_45_0[1] == var_44_2:getShipType()
			end)
		end

		if var_44_3 then
			var_44_0 = var_44_0 + var_44_3[2]
		end
	end

	return var_44_0 * ((self.mission:GetSquadronTargetCnt() <= self:GetTagShipCnt(arg_44_1) and self.mission:IsEliteType() or nil) and self.mission:GetSquadronRatio())
end

function GuildMissionFormationPage:HasScoreAddition(arg_46_1)
	local var_46_0 = self.mission:GetAttrCntAcc()
	local var_46_1 = self.mission:GetAttrAcc()

	return table.contains(self.mission:GetRecommendShipNation(), arg_46_1:getNation()) or (function()
		local var_47_0 = arg_46_1:getProperties()

		for iter_47_0, iter_47_1 in pairs(var_46_0) do
			assert(var_47_0[pg.attribute_info_by_type[iter_47_0].name], pg.attribute_info_by_type[iter_47_0].name)

			if (var_47_0[pg.attribute_info_by_type[iter_47_0].name] or 0) >= iter_47_1.total then
				return true
			end
		end

		for iter_47_2, iter_47_3 in pairs(var_46_1) do
			assert(var_47_0[pg.attribute_info_by_type[iter_47_2].name], pg.attribute_info_by_type[iter_47_2].name)

			if iter_47_3.op == 1 then
				return (var_47_0[pg.attribute_info_by_type[iter_47_2].name] or 0) > 0
			elseif iter_47_3.op == 2 then
				return (var_47_0[pg.attribute_info_by_type[iter_47_2].name] or 0) == 0
			end
		end

		return false
	end)()
end

function GuildMissionFormationPage:HasEffectAddition(arg_48_1)
	return table.contains(self.mission:GetRecommendShipTypes(), arg_48_1:getShipType()) or arg_48_1:IsTagShip((self.mission:GetSquadron()))
end

function GuildMissionFormationPage:ClearSlots()
	for iter_49_0, iter_49_1 in pairs(self.shipGos) do
		iter_49_1:SetPivot(Vector2(0.5, 0.5))
		GetOrAddComponent(iter_49_1:GetModel(), "EventTriggerListener"):RemovePointClickFunc()
		iter_49_1:SetActionCallBack(nil)
		iter_49_1:Dispose()
	end

	self.shipGos = {}

	return
end

function GuildMissionFormationPage:Hide()
	GuildMissionFormationPage.super.Hide(self)
	self:ClearSlots()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return GuildMissionFormationPage
