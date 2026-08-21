local var_0_0 = class("GuildMissionFormationPage", import(".GuildEventBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "GuildMissionFormationPage"
end

function var_0_0.OnRefreshMission(arg_2_0, arg_2_1)
	if not arg_2_0.mission or arg_2_0.mission.id ~= arg_2_1.id then
		return
	end

	arg_2_0:Flush(arg_2_1)

	return
end

function var_0_0.OnFormationDone(arg_3_0)
	arg_3_0.loading = true

	for iter_3_0, iter_3_1 in pairs(arg_3_0.shipGos) do
		table.insert({}, function(arg_4_0)
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

	parallelAsync({}, function()
		arg_3_0:Hide()

		arg_3_0.loading = false

		return
	end)

	local var_3_0 = arg_3_0.canFormationIndex or 1

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.pageFooter) do
		setActive(iter_3_3, iter_3_2 <= var_3_0)
	end

	setActive(arg_3_0.pageFooterAdd, false)

	return
end

function var_0_0.OnLoaded(arg_7_0)
	arg_7_0.closeBtn = arg_7_0._tf:Find("frame/close")
	arg_7_0.titleTxt = arg_7_0._tf:Find("frame/title"):GetComponent(typeof(Text))
	arg_7_0.recomBtn = arg_7_0._tf:Find("frame/recom")
	arg_7_0.clearBtn = arg_7_0._tf:Find("frame/clear")
	arg_7_0.goBtn = arg_7_0._tf:Find("frame/bottom/go")
	arg_7_0.inProgressBtn = arg_7_0._tf:Find("frame/bottom/doingBtn")
	arg_7_0.battleAreaTxt = arg_7_0._tf:Find("frame/bottom/desc/area/Text"):GetComponent(typeof(Text))
	arg_7_0.battleTypeTxt = arg_7_0._tf:Find("frame/bottom/desc/type/Text"):GetComponent(typeof(Text))
	arg_7_0.awardList = UIItemList.New(arg_7_0._tf:Find("frame/bottom/award/list"), arg_7_0._tf:Find("frame/bottom/award/list/item"))
	arg_7_0.target1Text = arg_7_0._tf:Find("frame/bottom/desc/target/content/Text"):GetComponent(typeof(Text))
	arg_7_0.target2Text = arg_7_0._tf:Find("frame/bottom/desc/target/content/Text2"):GetComponent(typeof(Text))
	arg_7_0.target1Text4Effect = arg_7_0._tf:Find("frame/bottom/desc/target/content1/Text"):GetComponent(typeof(Text))
	arg_7_0.target2Text4Effect = arg_7_0._tf:Find("frame/bottom/desc/target/content1/Text2"):GetComponent(typeof(Text))
	arg_7_0.scoreAdditionTxt = arg_7_0._tf:Find("frame/bottom/score_addition/Text"):GetComponent(typeof(Text))
	arg_7_0.effectAdditionTxt = arg_7_0._tf:Find("frame/bottom/effect_addition/Text"):GetComponent(typeof(Text))
	arg_7_0.effectTxt = arg_7_0._tf:Find("frame/bottom/effect/Text"):GetComponent(typeof(Text))
	arg_7_0.bg = arg_7_0._tf:Find("frame/bottom/bg"):GetComponent(typeof(Image))
	arg_7_0.pageFooter = {
		arg_7_0._tf:Find("frame/single/dot/1"),
		arg_7_0._tf:Find("frame/single/dot/2"),
		arg_7_0._tf:Find("frame/single/dot/3"),
		arg_7_0._tf:Find("frame/single/dot/4")
	}
	arg_7_0.pageFooterAdd = arg_7_0._tf:Find("frame/single/dot/add")
	arg_7_0.nextBtn = arg_7_0._tf:Find("frame/single/next")
	arg_7_0.prevBtn = arg_7_0._tf:Find("frame/single/prev")

	setText(arg_7_0._tf:Find("frame/bottom/desc/area"), i18n("guild_word_battle_area"))
	setText(arg_7_0._tf:Find("frame/bottom/desc/type"), i18n("guild_word_battle_type"))

	return
end

function var_0_0.OnInit(arg_8_0)
	addSlip(SLIP_TYPE_HRZ, arg_8_0._tf:Find("frame"), function()
		if arg_8_0.contextData.index > 1 then
			triggerToggle(arg_8_0.pageFooter[arg_8_0.contextData.index - 1], true)
		end

		return
	end, function()
		if arg_8_0.contextData.index < arg_8_0.mission:GetMaxFleet() then
			if arg_8_0.contextData.index + 1 > arg_8_0.mission:GetFleetCnt() then
				triggerToggle(arg_8_0.pageFooterAdd, true)
			else
				triggerToggle(arg_8_0.pageFooter[arg_8_0.contextData.index + 1], true)
			end
		end

		return
	end)
	onButton(arg_8_0, arg_8_0.nextBtn, function()
		if arg_8_0.contextData.index < arg_8_0.mission:GetMaxFleet() then
			if arg_8_0.contextData.index + 1 > arg_8_0.mission:GetFleetCnt() then
				triggerToggle(arg_8_0.pageFooterAdd, true)
			else
				triggerToggle(arg_8_0.pageFooter[arg_8_0.contextData.index + 1], true)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.prevBtn, function()
		if arg_8_0.contextData.index > 1 then
			triggerToggle(arg_8_0.pageFooter[arg_8_0.contextData.index - 1], true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.closeBtn, function()
		arg_8_0.contextData.missionShips = nil

		arg_8_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.recomBtn, function()
		if not arg_8_0:CheckFormation() then
			return
		end

		arg_8_0:emit(GuildEventMediator.ON_GET_FORMATION, function()
			local var_13_0 = getProxy(GuildProxy):GetRecommendShipsForMission(arg_8_0.mission)

			if #var_13_0 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_recomm_ship_failed"))

				return
			end

			arg_8_0.contextData.missionShips = var_13_0

			arg_8_0:UpdateFleet(arg_8_0.contextData.index)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.clearBtn, function()
		if not arg_8_0:CheckFormation() then
			return
		end

		arg_8_0.contextData.missionShips = {}

		arg_8_0:UpdateFleet(arg_8_0.contextData.index)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.goBtn, function()
		if arg_8_0.mission:IsFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_finish"))

			return
		end

		if not arg_8_0:CheckFormation() then
			return
		end

		if not arg_8_0.contextData.missionShips or #arg_8_0.contextData.missionShips == 0 then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_event_start_event_tip"),
			onYes = function()
				arg_8_0:emit(GuildEventMediator.JOIN_MISSION, arg_8_0.mission.id, arg_8_0.contextData.missionShips)

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_8_0.shipGos = {}

	return
end

function var_0_0.OnShow(arg_17_0)
	arg_17_0.loading = nil
	arg_17_0.maxShipCnt = arg_17_0.extraData.shipCnt

	arg_17_0:UpdateLayout()
	arg_17_0:Flush(arg_17_0.extraData.mission)
	arg_17_0:UpdatePageFooter()
	arg_17_0:AddNextFormationTimer()

	return
end

function var_0_0.UpdatePageFooter(arg_18_0)
	local var_18_0 = arg_18_0.mission:GetFleetCnt()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.pageFooter) do
		setActive(iter_18_1, iter_18_0 <= var_18_0)
		onToggle(arg_18_0, iter_18_1, function(arg_19_0)
			if arg_19_0 then
				arg_18_0:UpdateFleet(iter_18_0)
				arg_18_0:UpdateSwitchBtns()
			end

			return
		end, SFX_PANEL)
	end

	setActive(arg_18_0.pageFooterAdd, (arg_18_0.mission:CanFormation()))
	onToggle(arg_18_0, arg_18_0.pageFooterAdd, function(arg_20_0)
		if arg_20_0 then
			arg_18_0:UpdateFleet(var_18_0 + 1)
		end

		return
	end, SFX_PANEL)

	local var_18_1 = arg_18_0.contextData.index or 1

	if var_18_0 < var_18_1 then
		triggerToggle(arg_18_0.pageFooterAdd, true)
	else
		triggerToggle(arg_18_0.pageFooter[var_18_1], true)
	end

	return
end

function var_0_0.UpdateSwitchBtns(arg_21_0)
	local var_21_0 = arg_21_0.mission:GetMaxFleet()
	local var_21_1 = arg_21_0.contextData.index

	setActive(arg_21_0.prevBtn, arg_21_0.contextData.index ~= 1)
	setActive(arg_21_0.nextBtn, var_21_1 < var_21_0)

	return
end

function var_0_0.AddNextFormationTimer(arg_22_0)
	local var_22_0 = arg_22_0.mission

	if arg_22_0.mission:IsMaxFleetCnt() then
		return
	end

	local function var_22_1(arg_23_0)
		arg_22_0.canFormationIndex = var_22_0:GetCanFormationIndex()

		setActive(arg_22_0.pageFooterAdd, true)

		if arg_23_0 then
			triggerToggle(arg_22_0.pageFooterAdd, false)
		end

		var_22_0:RecordFormationTip()
		setActive(arg_22_0.pageFooterAdd:Find("tip"), var_22_0:ShouldShowFormationTip())
		arg_22_0:UpdateSwitchBtns()

		return
	end

	if not arg_22_0.mission:CanFormation() then
		arg_22_0.timer = Timer.New(function()
			arg_22_0.timer:Stop()

			arg_22_0.timer = nil

			var_22_1(true)

			return
		end, arg_22_0.mission:GetNextFormationTime() - pg.TimeMgr.GetInstance():GetServerTime(), 1)

		arg_22_0.timer:Start()
	else
		var_22_1()
	end

	return
end

function var_0_0.Flush(arg_25_0, arg_25_1)
	arg_25_0.mission = arg_25_1
	arg_25_0.canFormationIndex = arg_25_1:GetCanFormationIndex()

	arg_25_0:InitView()

	return
end

function var_0_0.UpdateLayout(arg_26_0)
	arg_26_0.bg.sprite = GetSpriteFromAtlas("ui/GuildFormationUI_atlas", "bg3")

	local var_26_0 = arg_26_0._tf:Find("frame/single")

	arg_26_0.shipContainer = var_26_0
	arg_26_0.bg.gameObject.transform.sizeDelta = Vector2(arg_26_0.bg.gameObject.transform.sizeDelta.x, 212)

	setActive(var_26_0, true)

	return
end

function var_0_0.InitView(arg_27_0)
	if arg_27_0.initId ~= arg_27_0.mission.id then
		local var_27_0 = arg_27_0.mission:GetAwards()

		arg_27_0.awardList:make(function(arg_28_0, arg_28_1, arg_28_2)
			if arg_28_0 == UIItemList.EventUpdate then
				updateDrop(arg_28_2, {
					type = var_27_0[arg_28_1 + 1][1],
					id = var_27_0[arg_28_1 + 1][2],
					count = var_27_0[arg_28_1 + 1][3]
				})
				onButton(arg_27_0, arg_28_2, function()
					arg_27_0:send(BaseUI.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end

			return
		end)
		arg_27_0.awardList:align(#arg_27_0.mission:GetAwards())

		arg_27_0.battleAreaTxt.text = arg_27_0.mission:getConfig("ship_camp_display")
		arg_27_0.battleTypeTxt.text = arg_27_0.mission:getConfig("ship_type_display")
		arg_27_0.titleTxt.text = arg_27_0.mission:GetName()
		arg_27_0.initId = arg_27_0.mission.id
	end

	return
end

function var_0_0.UpdateFleet(arg_30_0, arg_30_1)
	arg_30_0:ClearSlots()

	local var_30_1 = arg_30_0.maxShipCnt
	local var_30_2 = arg_30_1 == arg_30_0.canFormationIndex and (arg_30_0.contextData.missionShips or var_30_0:GetFleetByIndex(arg_30_1)) or var_30_0:GetFleetByIndex(arg_30_1)
	local var_30_3 = {}

	var_30_2 = var_30_2 or {}

	for iter_30_0 = 1, var_30_1 do
		local var_30_4 = arg_30_0.shipContainer:GetChild(iter_30_0 - 1)

		table.insert(var_30_3, function(arg_31_0)
			arg_30_0:UpdateShipSlot(iter_30_0, var_30_4, var_30_2, arg_31_0)

			return
		end)
	end

	pg.UIMgr.GetInstance():LoadingOn(false)
	parallelAsync(var_30_3, function()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	if var_30_0:IsEliteType() then
		local var_30_5 = arg_30_0:GetTagShipCnt(var_30_2)
		local var_30_6 = var_30_0:GetSquadronTargetCnt()

		if var_30_6 <= var_30_5 then
			local var_30_7 = COLOR_GREEN or COLOR_RED
			local var_30_8 = string.format("%s : (<color=%s>%d/%d</color>)", var_30_0:GetSquadronDisplay(), var_30_7, var_30_5, var_30_6)

			arg_30_0.target2Text.text = HXSet.hxLan(var_30_8)
			arg_30_0.target2Text4Effect.text = HXSet.hxLan(var_30_8)

			if false then
				arg_30_0.target2Text.text = ""
				arg_30_0.target2Text4Effect.text = ""
			end

			arg_30_0.effectTxt.text = GuildMission.CalcMyEffect(var_30_2)

			local var_30_9, var_30_10, var_30_11 = arg_30_0:CalcScoreAddition(var_30_2)

			arg_30_0.scoreAdditionTxt.text = i18n("guild_word_score_addition") .. var_30_9
			arg_30_0.effectAdditionTxt.text = i18n("guild_word_effect_addition") .. arg_30_0:CalcEffectAddition(var_30_2)
			arg_30_0.target1Text.text = table.concat(arg_30_0:GetBattleTarget(var_30_10, var_30_11), " 、")
			arg_30_0.target1Text4Effect.text = arg_30_0.target1Text.text

			setButtonEnabled(arg_30_0.goBtn, #var_30_2 > 0)

			local var_30_12 = not var_30_0:CanFormation() or arg_30_1 <= var_30_0:GetFleetCnt()

			setActive(arg_30_0.inProgressBtn, var_30_12)
			setActive(arg_30_0.goBtn, not var_30_12)

			arg_30_0.contextData.index = arg_30_1

			if arg_30_0.target2Text.text ~= "" and arg_30_0.target1Text.text ~= "" then
				setText(arg_30_0._tf:Find("frame/bottom/desc/target/content/title"), i18n("guild_wrod_battle_target"))
			else
				setText(arg_30_0._tf:Find("frame/bottom/desc/target/content/title"), "")
			end

			return
		end
	end
end

function var_0_0.UpdateShipSlot(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_0.mission
	local var_33_1 = arg_33_3[arg_33_1]
	local var_33_2 = arg_33_2:Find("Image")
	local var_33_3 = arg_33_2:Find("effect")
	local var_33_4 = arg_33_2:Find("score")

	if arg_33_3[arg_33_1] then
		local var_33_5 = getProxy(BayProxy):getShipById(var_33_1)

		if var_33_5 then
			local var_33_6 = var_33_5:getPrefab()

			arg_33_0.spineChar = SpineAnimChar.New()

			arg_33_0.spineChar:SetPaint((var_33_5:getPrefab()))
			arg_33_0.spineChar:Load(true, function(arg_34_0)
				arg_34_0:SetName(var_33_6)
				arg_34_0:SetPivot(Vector2(0.5, 0))
				arg_34_0:SetSizeDelta(Vector2(200, 300))
				arg_34_0:SetParent(arg_33_2)
				arg_34_0:SetLocalPosition(Vector3(0, 0, 0))
				arg_34_0:SetLocalScale(Vector3(0.6, 0.6, 0.6))
				arg_34_0:SetAction("stand")
				GetOrAddComponent(arg_34_0:GetModel(), "EventTriggerListener"):AddPointClickFunc(function(arg_35_0, arg_35_1)
					arg_33_0:emit(GuildEventMediator.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

					return
				end)

				arg_33_0.shipGos[var_33_1] = arg_34_0

				if arg_33_4 then
					arg_33_4()
				end

				return
			end)
			setActive(var_33_3, arg_33_0:HasEffectAddition(var_33_5))
			setActive(var_33_4, arg_33_0:HasScoreAddition(var_33_5))
		elseif arg_33_4 then
			arg_33_4()
		end
	else
		onButton(arg_33_0, var_33_2, function()
			arg_33_0:emit(GuildEventMediator.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

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

function var_0_0.CheckFormation(arg_37_0)
	if arg_37_0.contextData.index ~= arg_37_0.canFormationIndex then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_curr_fleet_can_not_edit"))

		return false
	end

	local var_37_1, var_37_2 = arg_37_0.mission:CanFormation()

	if not var_37_1 then
		if var_37_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_next_edit_fleet_time", var_37_2))
		end

		return false
	end

	return true
end

function var_0_0.emit(arg_38_0, ...)
	if arg_38_0.loading then
		return
	end

	if not arg_38_0:CheckFormation() then
		return
	end

	var_0_0.super.emit(arg_38_0, ...)

	return
end

function var_0_0.send(arg_39_0, ...)
	var_0_0.super.emit(arg_39_0, ...)

	return
end

function var_0_0.GetBattleTarget(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0, iter_40_1 in pairs((arg_40_0.mission:GetAttrCntAcc())) do
		table.insert({}, GuildMissionInfoPage.AttrCnt2Desc(iter_40_0, {
			value = iter_40_1.value + var_40_0,
			total = iter_40_1.total,
			goal = iter_40_1.goal,
			score = iter_40_1.score
		}))
	end

	for iter_40_2, iter_40_3 in pairs((arg_40_0.mission:GetAttrAcc())) do
		table.insert({}, GuildMissionInfoPage.AttrAcc2Desc(iter_40_2, {
			value = iter_40_3.value + var_40_1,
			op = iter_40_3.op,
			goal = iter_40_3.goal,
			score = iter_40_3.score
		}))
	end

	return {}
end

function var_0_0.GetTagShipCnt(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.mission:GetSquadron()
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

function var_0_0.CalcScoreAddition(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.mission:GetAttrCntAcc()
	local var_42_1 = arg_42_0.mission:GetAttrAcc()
	local var_42_2 = pg.attribute_info_by_type
	local var_42_3 = 0
	local var_42_4 = {}
	local var_42_5 = {}
	local var_42_6 = getProxy(BayProxy)

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		local var_42_7 = var_42_6:getShipById(iter_42_1)
		local var_42_8

		if var_42_7 then
			var_42_8 = _.detect(arg_42_0.mission:getConfig("ship_camp_effect"), function(arg_43_0)
				return arg_43_0[1] == var_42_7:getNation()
			end)
		end

		if var_42_8 then
			var_42_3 = var_42_3 + var_42_8[2]
		end

		local var_42_9 = var_42_7 and var_42_7:getProperties() or {}

		for iter_42_2, iter_42_3 in pairs(var_42_0) do
			local var_42_10 = var_42_9[var_42_2[iter_42_2].name] or 0

			if var_42_10 >= iter_42_3.total then
				local var_42_11 = var_42_4[iter_42_2] or 0

				var_42_4[iter_42_2] = var_42_11 + 1
			end
		end

		for iter_42_4, iter_42_5 in pairs(var_42_1) do
			local var_42_12 = var_42_5[iter_42_4] or 0
			local var_42_13 = var_42_9[var_42_2[iter_42_4].name] or 0

			var_42_5[iter_42_4] = var_42_12 + var_42_13
		end
	end

	for iter_42_6, iter_42_7 in pairs(var_42_0) do
		local var_42_14 = var_42_4[iter_42_6] or 0

		if var_42_14 + iter_42_7.value >= iter_42_7.goal then
			var_42_3 = var_42_3 + iter_42_7.score
		end
	end

	for iter_42_8, iter_42_9 in pairs(var_42_1) do
		local var_42_15 = var_42_5[iter_42_8] or 0
		local var_42_16 = iter_42_9.value + var_42_15
		local var_42_17

		if iter_42_9.op == 1 then
			var_42_17 = var_42_16 >= iter_42_9.goal
		elseif iter_42_9.op == 2 then
			var_42_17 = var_42_16 <= iter_42_9.goal
		end

		if var_42_17 then
			var_42_3 = var_42_3 + iter_42_9.score
		end
	end

	return var_42_3, var_42_4, var_42_5
end

function var_0_0.CalcEffectAddition(arg_44_0, arg_44_1)
	local var_44_0 = GuildMission.CalcMyEffect(arg_44_1)
	local var_44_1 = getProxy(BayProxy)

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		local var_44_2

		if var_44_1:getShipById(iter_44_1) then
			var_44_2 = _.detect(arg_44_0.mission:getConfig("ship_type_effect"), function(arg_45_0)
				return arg_45_0[1] == var_0:getShipType()
			end)
		end

		if var_44_2 then
			var_44_0 = var_44_0 + var_44_2[2]
		end
	end

	local var_44_3 = 1

	if arg_44_0.mission:GetSquadronTargetCnt() <= arg_44_0:GetTagShipCnt(arg_44_1) and arg_44_0.mission:IsEliteType() then
		var_44_3 = arg_44_0.mission:GetSquadronRatio()
	end

	return var_44_0 * var_44_3
end

function var_0_0.HasScoreAddition(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.mission:GetAttrCntAcc()
	local var_46_1 = arg_46_0.mission:GetAttrAcc()

	return table.contains(arg_46_0.mission:GetRecommendShipNation(), arg_46_1:getNation()) or (function()
		local var_47_0 = arg_46_1:getProperties()

		for iter_47_0, iter_47_1 in pairs(var_46_0) do
			assert(var_47_0[pg.attribute_info_by_type[iter_47_0].name], pg.attribute_info_by_type[iter_47_0].name)

			local var_47_1 = var_47_0[pg.attribute_info_by_type[iter_47_0].name] or 0

			if var_47_1 >= iter_47_1.total then
				return true
			end
		end

		for iter_47_2, iter_47_3 in pairs(var_46_1) do
			assert(var_47_0[pg.attribute_info_by_type[iter_47_2].name], pg.attribute_info_by_type[iter_47_2].name)

			if iter_47_3.op == 1 then
				local var_47_2 = var_47_0[pg.attribute_info_by_type[iter_47_2].name] or 0

				return var_47_2 > 0
			elseif iter_47_3.op == 2 then
				local var_47_3 = var_47_0[pg.attribute_info_by_type[iter_47_2].name] or 0

				return var_47_3 == 0
			end
		end

		return false
	end)()
end

function var_0_0.HasEffectAddition(arg_48_0, arg_48_1)
	return table.contains(arg_48_0.mission:GetRecommendShipTypes(), arg_48_1:getShipType()) or arg_48_1:IsTagShip((arg_48_0.mission:GetSquadron()))
end

function var_0_0.ClearSlots(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.shipGos) do
		iter_49_1:SetPivot(Vector2(0.5, 0.5))
		GetOrAddComponent(iter_49_1:GetModel(), "EventTriggerListener"):RemovePointClickFunc()
		iter_49_1:SetActionCallBack(nil)
		iter_49_1:Dispose()
	end

	arg_49_0.shipGos = {}

	return
end

function var_0_0.Hide(arg_50_0)
	var_0_0.super.Hide(arg_50_0)
	arg_50_0:ClearSlots()

	if arg_50_0.timer then
		arg_50_0.timer:Stop()

		arg_50_0.timer = nil
	end

	return
end

return var_0_0
