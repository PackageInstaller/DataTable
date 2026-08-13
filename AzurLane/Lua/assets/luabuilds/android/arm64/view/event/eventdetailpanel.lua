require = var_0_10000

local var_0_0 = var_0_10000("view/event/EventConst")

class = EventConst

local var_0_1 = var_0("EventDetailPanel")

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.dispatch = arg_1_2

	local var_1_0 = arg_1_0.tr

	arg_1_0.btn = var_3.Find(var_1_0, "btn").gameObject
	setText = var_3
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0.tr, "btn_recommend/text")

	pg = var_6

	var_3(var_1_1, var_6.gametip.event_ui_recommend.tip)

	setText = var_3
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0.tr, "btn_recommend_disable/text")

	pg = var_6

	var_3(var_1_2, var_6.gametip.event_ui_recommend.tip)

	setText = var_3
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0.tr, "consume/label")

	pg = var_6

	var_3(var_1_3, var_6.gametip.event_ui_consume.tip)

	setText = var_3
	findTF = var_1_3

	local var_1_4 = var_1_3(arg_1_0.tr, "btn/start/text")

	pg = var_6

	var_3(var_1_4, var_6.gametip.event_ui_start.tip)

	setText = var_3
	findTF = var_1_4

	local var_1_5 = var_1_4(arg_1_0.tr, "btn_disable/text")

	pg = var_6

	var_3(var_1_5, var_6.gametip.event_ui_start.tip)

	setText = var_3
	findTF = var_1_5

	local var_1_6 = var_1_5(arg_1_0.tr, "btn/giveup/text")

	pg = var_6

	var_3(var_1_6, var_6.gametip.event_ui_giveup.tip)

	setText = var_3
	findTF = var_1_6

	local var_1_7 = var_1_6(arg_1_0.tr, "btn/finish/text")

	pg = var_6

	var_3(var_1_7, var_6.gametip.event_ui_finish.tip)

	findTF = var_3
	arg_1_0.conditions = var_3(arg_1_0.tr, "conditions")
	findTF = var_3
	arg_1_0.condition1 = var_3(arg_1_0.conditions, "condition_1/mask/Text")
	findTF = var_3
	arg_1_0.condition2 = var_3(arg_1_0.conditions, "condition_2/mask/Text")
	findTF = var_3
	arg_1_0.condition3 = var_3(arg_1_0.conditions, "condition_3/mask/Text")

	local var_1_8 = arg_1_0.tr

	arg_1_0.consume = var_3.Find(var_1_8, "consume/Text")

	local var_1_9 = arg_1_0.tr

	arg_1_0.leftShips = var_3.Find(var_1_9, "frame/ship_contain_left")

	local var_1_10 = arg_1_0.tr

	arg_1_0.rightShips = var_3.Find(var_1_10, "frame/ship_contain_right")

	local var_1_11 = arg_1_0.tr

	arg_1_0.disabeleBtn = var_3.Find(var_1_11, "btn_disable").gameObject

	local var_1_12 = arg_1_0.tr

	arg_1_0.recommentBtn = var_3.Find(var_1_12, "btn_recommend")

	local var_1_13 = arg_1_0.tr

	arg_1_0.recommentDisable = var_3.Find(var_1_13, "btn_recommend_disable")

	local var_1_14 = arg_1_0.tr

	arg_1_0.usePrevFormationBtn = var_3.Find(var_1_14, "use_prev_formation")
	arg_1_0.shipItems = {}
	eachChild = var_3

	var_3(arg_1_0.leftShips, function(arg_2_0)
		table = var_2_10001

		var_2_10001.insert(arg_1_0.shipItems, 1, arg_2_0)

		return
	end)

	eachChild = var_3

	var_3(arg_1_0.rightShips, function(arg_3_0)
		table = var_2_10001

		var_2_10001.insert(arg_1_0.shipItems, 4, arg_3_0)

		return
	end)

	onButton = var_3

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.btn

	local function var_1_17()
		local var_4_0 = arg_1_0

		var_0.onFuncClick(var_4_0)

		return
	end

	SFX_PANEL = var_8

	var_3(var_1_15, var_1_16, var_1_17, var_8)

	onButton = var_3

	var_3(arg_1_0, arg_1_0.recommentBtn, function()
		getProxy = var_2_10000
		BayProxy = var_2_10002

		local var_5_0 = var_2_10000(var_2_10002)

		if #var_0.getDelegationRecommendShips(var_5_0, arg_1_0.event) > 0 then
			table = var_2

			var_2.insertto(arg_1_0.event.shipIds, var_1)

			local var_5_1 = arg_1_0

			var_2.Flush(var_5_1)
		elseif #var_0:getDelegationRecommendShipsLV1(arg_1_0.event) > 0 then
			pg = var_3

			local var_5_2 = var_3.MsgboxMgr.GetInstance()
			local var_5_3 = var_3.ShowMsgBox

			var_2_10006 = {}
			i18n = var_2_10007
			var_2_10006.content = var_2_10007("event_recommend_level1")

			function var_2_10006.onYes()
				table = var_3_10000

				var_3_10000.insertto(arg_1_0.event.shipIds, var_0)

				local var_6_0 = arg_1_0

				var_0.Flush(var_6_0)

				return
			end

			var_5_3(var_5_2, var_2_10006)
		else
			local var_5_4 = arg_1_0.event

			if not var_3.reachNum(var_5_4) then
				pg = var_3

				local var_5_5 = var_3.TipsMgr.GetInstance()
				local var_5_6 = var_3.ShowTips

				i18n = var_2_10006

				var_5_6(var_5_5, var_2_10006("event_recommend_fail"))
			end
		end

		return
	end)

	onButton = var_3

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.usePrevFormationBtn

	local function var_1_20()
		local var_7_0 = arg_1_0

		var_0.UsePrevFormation(var_7_0)

		return
	end

	SFX_PANEL = var_8

	var_3(var_1_18, var_1_19, var_1_20, var_8)

	return
end

function var_0_1.Update(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index = arg_8_1
	arg_8_0.event = arg_8_2

	arg_8_0:Flush()

	return
end

function var_0_1.UsePrevFormation(arg_9_0)
	if arg_9_0.event then
		local var_9_0 = arg_9_0.event

		if var_1.ExistPrevFormation(var_9_0) then
			local var_9_1 = arg_9_0.event
			local var_9_2 = var_1.GetPrevFormation(var_9_1)
			local var_9_3 = {}
			local var_9_4 = false
			local var_9_5 = false

			ipairs = var_1_10005
			getProxy = var_1_10007
			BayProxy = var_1_10009

			local var_9_6 = var_1_10007(var_1_10009)

			for iter_9_0, iter_9_1 in var_1_10005(var_7.getShipList(var_9_6, var_9_2)) do
				local var_9_7

				if iter_9_1 then
					ShipStatus = var_9_7

					local var_9_8

					var_9_7, var_9_8 = var_9_7.ShipStatusConflict("inEvent", iter_9_1)
					ShipStatus = var_12

					if var_9_7 == var_12.STATE_CHANGE_FAIL then
						var_9_4 = true
					else
						ShipStatus = var_12

						if var_9_7 == var_12.STATE_CHANGE_CHECK then
							var_9_5 = true
						else
							table = var_12

							var_12.insert(var_9_3, iter_9_1.id)
						end
					end
				end
			end

			local var_9_10

			if var_9_4 then
				pg = var_9_10

				local var_9_9 = var_9_10.TipsMgr.GetInstance()

				var_9_10 = var_9_10.ShowTips
				i18n = iter_9_0

				var_9_10(var_9_9, iter_9_0("collect_tip"))
			end

			if var_9_5 then
				pg = var_9_10

				local var_9_11 = var_9_10.TipsMgr.GetInstance()
				local var_9_12 = var_5.ShowTips

				i18n = iter_9_0

				var_9_12(var_9_11, iter_9_0("collect_tip2"))
			end

			local var_9_13 = arg_9_0.event

			var_5.setShipIds(var_9_13, var_9_3)
			arg_9_0:Flush()
		end
	end

	return
end

function var_0_1.Flush(arg_10_0)
	setActive = var_1_10001

	local var_10_0 = arg_10_0.usePrevFormationBtn
	local var_10_1 = arg_10_0.event

	if var_4.ExistPrevFormation(var_10_1) then
		local var_10_2 = arg_10_0.event
		local var_10_3 = var_10_3.GetState(var_10_2)

		EventInfo = var_1_10005

		if var_10_3 == var_1_10005.StateNone then
			local var_10_4 = arg_10_0.event

			var_10_3 = var_10_3.CanRecordPrevFormation(var_10_4)
		else
			var_10_3 = false
		end
	end

	if false then
		var_10_3 = true
	end

	var_1_10001(var_10_0, var_10_3)

	eachChild = var_1_10001

	var_1_10001(arg_10_0.btn, function(arg_11_0)
		local var_11_0 = arg_10_0.event
		local var_11_1 = var_1.GetState(var_11_0)

		EventInfo = var_2_10002

		if var_11_1 == var_2_10002.StateNone and arg_11_0.name == "start" then
			SetActive = var_2

			var_2(arg_11_0, true)
		else
			EventInfo = var_2

			if var_11_1 == var_2.StateActive and arg_11_0.name == "giveup" then
				SetActive = var_2

				var_2(arg_11_0, true)
			else
				EventInfo = var_2

				if var_11_1 == var_2.StateFinish and arg_11_0.name == "finish" then
					SetActive = var_2

					var_2(arg_11_0, true)
				else
					SetActive = var_2

					var_2(arg_11_0, false)
				end
			end
		end

		return
	end)

	local var_10_5 = arg_10_0.event
	local var_10_6 = var_1.reachLevel(var_10_5)
	local var_10_7 = arg_10_0.event
	local var_10_8 = var_2.reachNum(var_10_7)
	local var_10_9 = arg_10_0.event
	local var_10_10 = var_3.reachTypes(var_10_9)

	SetActive = var_10_7

	var_10_7(arg_10_0.disabeleBtn, not var_10_6 or not var_10_8 or not var_10_10)

	local var_10_11 = arg_10_0.event
	local var_10_12 = var_4.getShipList(var_10_11)
	local var_10_13 = arg_10_0.event.template
	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0.setConditionStr

	i18n = var_1_10009

	local var_10_16 = var_10_15(var_10_14, var_1_10009("event_condition_ship_level", var_10_13.ship_lv), var_10_6)

	setScrollText = var_7

	var_7(arg_10_0.condition1, var_10_16)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_10_0.conditions, "condition_1/mark"), var_10_6)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_10_0.conditions, "condition_1/mark1"), not var_10_6)

	local var_10_17 = arg_10_0
	local var_10_18 = arg_10_0.setConditionStr

	i18n = var_10

	local var_10_19 = var_10_18(var_10_17, var_10("event_condition_ship_count", var_10_13.ship_num), var_10_8)

	setScrollText = var_10_14

	var_10_14(arg_10_0.condition2, var_10_19)

	setActive = var_10_14
	findTF = var_10

	var_10_14(var_10(arg_10_0.conditions, "condition_2/mark"), var_10_8)

	setActive = var_10_14
	findTF = var_10

	var_10_14(var_10(arg_10_0.conditions, "condition_2/mark1"), not var_10_8)

	local var_10_20 = arg_10_0.event
	local var_10_21 = var_8.getTypesStr(var_10_20)
	local var_10_22 = arg_10_0:setConditionStr(var_10_21, var_10_10)

	setScrollText = var_9

	var_9(arg_10_0.condition3, var_10_22)

	setActive = var_9
	findTF = var_11

	var_9(var_11(arg_10_0.conditions, "condition_3/mark"), var_10_10)

	setActive = var_9
	findTF = var_11

	var_9(var_11(arg_10_0.conditions, "condition_3/mark1"), not var_10_10)

	setText = var_9

	local var_10_23 = arg_10_0.consume
	local var_10_24 = arg_10_0.event

	var_9(var_10_23, var_12.getOilConsume(var_10_24))

	ipairs = var_9

	for iter_10_0, iter_10_1 in var_9(arg_10_0.shipItems) do
		local var_10_25 = iter_10_1:Find("shiptpl")
		local var_10_26 = iter_10_1
		local var_10_27 = iter_10_1.Find(var_10_26, "emptytpl")
		local var_10_28 = iter_10_0 <= #var_10_12

		SetActive = var_10_26

		var_10_26(var_10_25, var_10_28)

		SetActive = var_10_26

		var_10_26(var_10_27, not var_10_28)

		if var_10_28 then
			updateShip = var_10_26

			var_10_26(var_10_25, var_10_12[iter_10_0], {
				initStar = true
			})

			setText = var_10_26
			findTF = var_19

			var_10_26(var_19(var_10_25, "icon_bg/lv/Text"), var_10_12[iter_10_0].level)

			onButton = var_10_26

			local var_10_29 = arg_10_0
			local var_10_30 = var_10_25
			local var_10_31 = var_10_25.Find(var_10_30, "icon_bg")

			local function var_10_32()
				local var_12_0 = arg_10_0

				var_0.onRemoveClick(var_12_0, iter_10_0)

				return
			end

			SFX_PANEL = var_10_30

			var_10_26(var_10_29, var_10_31, var_10_32, var_10_30)
		else
			onButton = var_10_26

			var_10_26(arg_10_0, var_10_27, function()
				local var_13_0 = arg_10_0

				var_0.onChangeClick(var_13_0)

				return
			end)
		end
	end

	local var_10_33 = arg_10_0.event
	local var_10_34 = var_9.GetState(var_10_33)

	EventInfo = var_10

	if var_10_34 == var_10.StateNone then
		SetActive = var_10

		var_10(arg_10_0.recommentBtn, true)

		SetActive = var_10

		var_10(arg_10_0.recommentDisable, false)
	else
		SetActive = var_10

		var_10(arg_10_0.recommentBtn, false)

		SetActive = var_10

		var_10(arg_10_0.recommentDisable, true)
	end

	return
end

function var_0_1.setConditionStr(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		setColorStr = var_1_10003

		local var_14_0 = arg_14_1

		COLOR_YELLOW = var_1_10006

		if not var_1_10003(var_14_0, var_1_10006) then
			setColorStr = var_1_10003
			var_1_10003 = var_1_10003(arg_14_1, "#F35842FF")
		end

		return var_1_10003
	end
end

function var_0_1.Clear(arg_15_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_15_0)

	return
end

function var_0_1.onChangeClick(arg_16_0)
	local var_16_0 = arg_16_0.event
	local var_16_1 = var_1.GetState(var_16_0)

	EventInfo = var_1_10002

	if var_16_1 == var_1_10002.StateNone then
		local var_16_2 = arg_16_0.dispatch

		EventConst = var_16_0

		var_16_2(var_16_0.EVENT_OPEN_DOCK, arg_16_0.event)
	end

	return
end

function var_0_1.onRemoveClick(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.event
	local var_17_1 = var_2.GetState(var_17_0)

	EventInfo = var_1_10003

	if var_17_1 == var_1_10003.StateNone then
		table = var_17_1

		var_17_1.remove(arg_17_0.event.shipIds, arg_17_1)
		arg_17_0:Flush()
	end

	return
end

function var_0_1.onFuncClick(arg_18_0)
	local var_18_0 = arg_18_0.event
	local var_18_1 = var_1.GetState(var_18_0)

	EventInfo = var_1_10002

	local var_18_2

	if var_18_1 == var_1_10002.StateNone then
		var_18_2 = arg_18_0.dispatch
		EventConst = var_1_10004

		var_18_2(var_1_10004.EVENT_START, arg_18_0.event)
	else
		EventInfo = var_18_2

		local var_18_3

		if var_18_1 == var_18_2.StateActive then
			var_18_3 = arg_18_0.dispatch
			EventConst = var_1_10004

			var_18_3(var_1_10004.EVENT_GIVEUP, arg_18_0.event)
		else
			EventInfo = var_18_3

			if var_18_1 == var_18_3.StateFinish then
				local var_18_4 = arg_18_0.dispatch

				EventConst = var_1_10004

				var_18_4(var_1_10004.EVENT_FINISH, arg_18_0.event)
			end
		end
	end

	return
end

return var_0_1
