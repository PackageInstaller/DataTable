class = var_0_10000

local var_0_0 = var_0_10000("IslandTaskTrackCard")

var_0_0.TYPES = {
	OTHER = 2,
	MAIN = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0.type = arg_1_3
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_4.Find(var_1_0, "title/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.nameTF = var_4.Find(var_1_1, "title/name")

	local var_1_2 = arg_1_0._tf

	arg_1_0.finishedTF = var_4.Find(var_1_2, "target/finished")

	local var_1_3 = arg_1_0._tf

	arg_1_0.unFinishTF = var_4.Find(var_1_3, "target/unfinish")
	UIItemList = var_4

	local var_1_4 = var_4.New
	local var_1_5 = arg_1_0.unFinishTF
	local var_1_6 = arg_1_0.unFinishTF

	arg_1_0.targetUIList = var_1_4(var_1_5, var_6.Find(var_1_6, "tpl"))

	local var_1_7 = arg_1_0.targetUIList

	var_4.make(var_1_7, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateTargetItem(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	UIItemList = var_4

	local var_1_8 = var_4.New
	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_5.Find(var_1_9, "btns")
	local var_1_11 = arg_1_0._tf

	arg_1_0.targetBtnUIList = var_1_8(var_1_10, var_6.Find(var_1_11, "btns/tpl"))

	local var_1_12 = arg_1_0.targetBtnUIList

	var_4.make(var_1_12, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_1_0

			var_3.UpdateTargetBtnItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateTargetItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.task
	local var_4_1 = var_3.GetTargetList(var_4_0)[arg_4_1 + 1]
	local var_4_2 = var_3.IsFinish(var_4_1)

	setActive = var_4_1

	var_4_1(arg_4_2:Find("status/unfinish"), not var_4_2)

	setActive = var_4_1

	var_4_1(arg_4_2:Find("status/finished"), var_4_2)

	if var_4_2 then
		local var_4_3 = arg_4_2

		var_4_1 = arg_4_2.GetComponent
		typeof = var_7
		Animation = var_8

		local var_4_4 = var_4_1(var_4_3, var_7(var_8))

		var_4_1.Play(var_4_4, "Island3dTaskTrackPanel_tpl_finish_in")
	else
		local var_4_5 = arg_4_2

		var_4_1 = arg_4_2.GetComponent
		typeof = var_7
		Animation = var_8

		local var_4_6 = var_4_1(var_4_5, var_7(var_8))

		var_4_1.Play(var_4_6, "Island3dTaskTrackPanel_tpl_unfinished_in")
	end

	GetOrAddComponent = var_4_1
	var_4_1(arg_4_2:Find("content"), "CanvasGroup").alpha = var_4_2 and 0.5 or 1

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.GetMapTip

	tonumber = var_7

	if var_4_8(var_4_7, var_7(var_3:GetTrackParma())) and not var_4_2 then
		setText = var_4_7

		var_4_7(arg_4_2:Find("content/Text"), var_5)

		setText = var_4_7

		var_4_7(arg_4_2:Find("content/num"), "")

		goto label_4_0
	end

	setText = var_4_7

	local var_4_9 = arg_4_2
	local var_4_10 = arg_4_2.Find(var_4_9, "content/Text")

	HXSet = var_4_9

	var_4_7(var_4_10, var_4_9.hxLan(var_3:getConfig("name")))

	local var_4_11 = var_3:GetProgress()
	local var_4_12 = var_3
	local var_4_13 = var_3.GetTargetNum(var_4_12)

	setText = var_4_12

	local var_4_14 = arg_4_2:Find("content/num")
	local var_4_15 = "("

	if var_4_11 < var_4_13 then
		setColorStr = var_11

		do
			local var_4_16

			if not var_11(var_4_11, "#dd374e") then
				var_4_16 = var_4_11
			end

			var_4_12(var_4_14, var_4_15 .. var_4_16 .. "/" .. var_4_13 .. ")")
		end

		::label_4_0::

		return
	end
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.unlock = arg_5_2
	arg_5_0.task = arg_5_1
	setActive = var_1_10003

	var_1_10003(arg_5_0._tf, arg_5_0.task)

	if not arg_5_0.task then
		return
	end

	getProxy = var_3
	IslandProxy = var_4

	local var_5_0 = var_3(var_4)
	local var_5_1 = var_3.GetIsland(var_5_0)

	arg_5_0.curMapId = var_3.GetMapId(var_5_1)

	local var_5_2 = arg_5_0.task
	local var_5_3 = var_3.GetShowType(var_5_2)

	GetImageSpriteFromAtlasAsync = var_5_2

	local var_5_4 = "island/islandtasktype"
	local var_5_5 = "track_"

	IslandTaskType = var_1_10007

	var_5_2(var_5_4, var_5_5 .. var_1_10007.ShowTypeFields[var_5_3], arg_5_0.iconTF)

	setImageColor = var_5_2

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_5.Find(var_5_6, "title/bg")

	Color = var_5_6

	local var_5_8 = var_5_6.NewHex

	IslandTaskType = var_7

	var_5_2(var_5_7, var_5_8(var_7.ShowTypeTrackColors[var_5_3]))

	setText = var_5_2

	local var_5_9 = arg_5_0.nameTF

	HXSet = var_6

	local var_5_10 = var_6.hxLan
	local var_5_11 = arg_5_0.task

	var_5_2(var_5_9, var_5_10(var_7.GetName(var_5_11)))
	arg_5_0:UpdateTarget()
	arg_5_0:TrackUI()

	return
end

function var_0_0.UpdateProgress(arg_6_0, arg_6_1)
	arg_6_0.task = arg_6_1

	if not arg_6_0.task then
		return
	end

	arg_6_0:UpdateTarget()
	arg_6_0:TrackUI()

	return
end

function var_0_0.UpdateTarget(arg_7_0)
	local var_7_0 = arg_7_0.task
	local var_7_2

	if not var_1.IsSubmitImmediately(var_7_0) then
		local var_7_1 = arg_7_0.task

		var_7_2 = var_1.IsFinish(var_7_1)
	else
		var_7_2 = false
	end

	if false then
		var_7_2 = true
	end

	local var_7_3 = arg_7_0.task
	local var_7_4 = #var_2.GetTargetList(var_7_3)
	local var_7_5 = arg_7_0.targetUIList

	var_3.align(var_7_5, var_7_4)

	local var_7_6 = arg_7_0.targetBtnUIList

	var_3.align(var_7_6, var_7_4 + (var_7_2 and 1 or 0))

	setActive = var_3

	var_3(arg_7_0.finishedTF, var_7_2)

	if var_7_2 then
		local var_7_7 = arg_7_0
		local var_7_8 = arg_7_0.GetMapTip

		tonumber = var_5

		local var_7_9 = arg_7_0.task

		if var_7_8(var_7_7, var_5(var_6.GetTraceParam(var_7_9))) then
			setText = var_7_7

			local var_7_10 = arg_7_0.finishedTF

			var_7_7(var_5.Find(var_7_10, "Text"), var_3)
		else
			setText = var_7_7

			local var_7_11 = arg_7_0.finishedTF
			local var_7_12 = var_5.Find(var_7_11, "Text")

			HXSet = var_7_11

			local var_7_13 = var_7_11.hxLan
			local var_7_14 = arg_7_0.task

			var_7_7(var_7_12, var_7_13(var_7.GetFinishedDesc(var_7_14)))
		end
	end

	return
end

function var_0_0.RemoveTask(arg_8_0)
	arg_8_0:UnTrackUI()

	setActive = var_1

	var_1(arg_8_0._tf, false)

	return
end

function var_0_0.TrackUI(arg_9_0)
	if not arg_9_0.unlock then
		return
	end

	local var_9_0 = arg_9_0.task
	local var_9_1 = var_1.GetTraceParam(var_9_0)

	tonumber = var_9_0

	if var_9_0(var_9_1) then
		_IslandCore = var_3

		if var_3 then
			_IslandCore = var_3

			local var_9_2 = var_3:GetController()
			local var_9_3 = var_3.NotifiyCore

			ISLAND_EVT = var_1_10005

			local var_9_4 = var_1_10005.TRACKING
			local var_9_5 = {
				id = var_2
			}
			local var_9_6 = arg_9_0.task

			var_9_5.typ = var_7.GetType(var_9_6)
			var_9_5.trackType = arg_9_0.type

			var_9_3(var_9_2, var_9_4, var_9_5)
		end
	else
		arg_9_0:UnTrackUI()
	end

	return
end

function var_0_0.UnTrackUI(arg_10_0)
	if not arg_10_0.unlock then
		return
	end

	_IslandCore = var_1

	if var_1 then
		_IslandCore = var_1

		local var_10_0 = var_1:GetController()
		local var_10_1 = var_1.NotifiyCore

		ISLAND_EVT = var_1_10003

		var_10_1(var_10_0, var_1_10003.UNTRACKING, arg_10_0.type)
	end

	return
end

function var_0_0.GetMapTip(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return nil
	end

	pg = var_1_10002

	if not var_1_10002.island_world_objects[arg_11_1] then
		return nil
	end

	if arg_11_0.curMapId == var_2.mapId then
		return nil
	end

	i18n = var_3

	local var_11_0 = var_3("island_word_go")

	pg = var_4

	return var_11_0 .. var_4.island_map[var_2.mapId].name
end

function var_0_0._SkipBtn(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.island_main_btns[arg_12_1]

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_12_1 = var_1_10003(var_1_10004)
	local var_12_2 = var_3.GetIsland(var_12_1)
	local var_12_3 = var_3.GetAblityAgency(var_12_2)

	if not var_3.HasAbility(var_12_3, var_12_0.ability_id) then
		pg = var_3

		local var_12_4 = var_3.TipsMgr.GetInstance()
		local var_12_5 = var_3.ShowTips

		i18n = var_5

		var_12_5(var_12_4, var_5("island_taskjump_systemnoopen_tips"))

		return
	end

	if var_12_0.open_page ~= "" then
		local var_12_6 = arg_12_0
		local var_12_7 = arg_12_0.emit

		IslandMediator = var_5

		var_12_7(var_12_6, var_5.OPEN_PAGE, var_12_0.open_page, var_12_0.page_param)
	end

	return
end

function var_0_0._SkipObj(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.island_world_objects[arg_13_1].mapId

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_13_1 = var_1_10003(var_1_10004)
	local var_13_2 = var_3.GetIsland(var_13_1)
	local var_13_3 = var_3.GetAblityAgency(var_13_2)

	if not var_3.IsUnlockMap(var_13_3, var_13_0) then
		pg = var_3

		local var_13_4 = var_3.TipsMgr.GetInstance()
		local var_13_5 = var_3.ShowTips

		i18n = var_5

		var_13_5(var_13_4, var_5("island_taskjump_placenoopen_tips"))

		return
	end

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.emit

	IslandBaseMediator = var_5

	local var_13_8 = var_5.SWITCH_MAP
	local var_13_9 = var_13_0

	pg = var_1_10007

	var_13_7(var_13_6, var_13_8, var_13_9, var_1_10007.island_map[var_13_0].born_object)

	return
end

function var_0_0.UpdateTargetBtnItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.task
	local var_14_1 = var_3.GetTargetList(var_14_0)[arg_14_1 + 1]
	local var_14_2 = arg_14_2
	local var_14_3 = arg_14_2.Find(var_14_2, "btn")

	removeOnButton = var_14_2

	var_14_2(var_14_3)

	setActive = var_14_2

	var_14_2(var_14_3, false)

	if var_14_1 then
		pg = var_14_2
		var_14_2 = var_14_2.island_task_target[var_14_1.id]
		tonumber = var_6

		local var_14_4 = var_6(var_14_2.tips)

		tonumber = var_7

		local var_14_5 = var_7(var_14_2.jump_ui)
		local var_14_6 = var_14_1

		if not var_14_1.IsFinish(var_14_6) then
			if var_14_5 then
				setActive = var_8

				var_8(var_14_3, true)

				onButton = var_8
				var_14_6 = arg_14_0

				local var_14_7 = var_14_3

				function var_1_10011()
					local var_15_0 = arg_14_0

					var_0._SkipBtn(var_15_0, var_14_5)

					return
				end

				SFX_PANEL = var_1_10012

				var_8(var_14_6, var_14_7, var_1_10011, var_1_10012)
			elseif var_14_4 then
				pg = var_8

				local var_14_8 = var_8.island_world_objects[var_14_4].mapId

				IslandMainBtnTipHelper = var_14_6

				if var_14_6.IsUnlock("map") and arg_14_0.curMapId ~= var_14_8 then
					setActive = var_9

					var_9(var_14_3, true)

					onButton = var_9

					local var_14_9 = arg_14_0

					var_1_10011 = var_14_3

					local function var_14_10()
						local var_16_0 = arg_14_0

						var_0._SkipObj(var_16_0, var_14_4)

						return
					end

					SFX_PANEL = var_1_10013

					var_9(var_14_9, var_1_10011, var_14_10, var_1_10013)
				end
			end
		end
	else
		setActive = var_14_2

		var_14_2(var_14_3, false)

		tonumber = var_14_2

		local var_14_11 = arg_14_0.task

		if var_14_2(var_6.getConfig(var_14_11, "complete_data")) and var_5 ~= 0 then
			pg = var_6

			local var_14_12 = var_6.island_world_objects[var_5].mapId

			IslandMainBtnTipHelper = var_14_11

			if var_14_11.IsUnlock("map") and arg_14_0.curMapId ~= var_14_12 then
				setActive = var_7

				var_7(var_14_3, true)

				onButton = var_7

				local var_14_13 = arg_14_0
				local var_14_14 = var_14_3

				local function var_14_15()
					local var_17_0 = arg_14_0

					var_0._SkipObj(var_17_0, var_0)

					return
				end

				SFX_PANEL = var_1_10011

				var_7(var_14_13, var_14_14, var_14_15, var_1_10011)
			end
		end
	end

	return
end

function var_0_0.emit(arg_18_0, ...)
	local var_18_0 = arg_18_0.event

	var_1.emit(var_18_0, ...)

	return
end

function var_0_0.Dispose(arg_19_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_19_0)

	return
end

return var_0_0
