class = var_0_10000

local var_0_0 = "NewEducateNodePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.NODE_TYPE = {
	MAIN_OPTION = 104,
	EVENT_TEXT = 100,
	MAIN_TEXT = 103,
	STORY_BRANCH = 2,
	DROP = 102,
	EVENT_OPTION = 101,
	PERFORMANCE = 1
}
var_0_1.NEXT_TYPE = {
	OPTION = 2,
	NOMARL = 1,
	STORY_FLAG = 4,
	PROBABILITY = 3
}
var_0_1.DROP_TYPE = {
	POLAROID = 4,
	WORD_PERFORMANCE = 1,
	EVENT = 3,
	MAIN_TIP = 2,
	DROP_LAYER = 5
}

function var_0_1.getUIName(arg_1_0)
	return "NewEducateNodeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	eachChild = var_1_10001

	var_1_10001(arg_2_0._tf, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, false)

		return
	end)

	local var_2_0 = arg_2_0._tf

	arg_2_0.loopCpkTF = var_1.Find(var_2_0, "cpk_bg")

	local var_2_1 = arg_2_0.loopCpkTF
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	var_2_2(var_2_1, var_4(var_1_10006)).enabled = false

	local var_2_3 = arg_2_0.loopCpkTF
	local var_2_4 = var_1.Find(var_2_3, "cpk/usm")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	CriManaCpkUI = var_1_10006
	arg_2_0.loopCpkPlayer = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0.loopCpkPlayer
	local var_2_7 = var_1.SetMaxFrameDrop

	CriWare = var_4

	var_2_7(var_2_6, var_4.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

	NewEducateCpkHandler = var_2_7

	local var_2_8 = var_2_7.New
	local var_2_9 = arg_2_0._tf

	arg_2_0.cpkHandler = var_2_8(var_3.Find(var_2_9, "cpk"))
	NewEducatePictureHandler = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf

	arg_2_0.pictureHandler = var_2_10(var_3.Find(var_2_11, "picture"))
	NewEducateWordHandler = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0._tf

	arg_2_0.wordHandler = var_2_12(var_3.Find(var_2_13, "dialogue"))
	NewEducateDropHandler = var_1

	local var_2_14 = var_1.New
	local var_2_15 = arg_2_0._tf

	arg_2_0.dropHandler = var_2_14(var_3.Find(var_2_15, "drop"))
	NewEducateSiteHandler = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0._tf

	arg_2_0.siteHandler = var_2_16(var_3.Find(var_2_17, "site"))
	NewEducateOptionsHandler = var_1

	local var_2_18 = var_1.New
	local var_2_19 = arg_2_0._tf

	arg_2_0.optionsHandler = var_2_18(var_3.Find(var_2_19, "options"))
	NewEducateMinigameHandler = var_1

	local var_2_20 = var_1.New
	local var_2_21 = arg_2_0._tf

	arg_2_0.minigameHandler = var_2_20(var_3.Find(var_2_21, "minigame"), arg_2_0.contextData.view)

	local var_2_22 = arg_2_0._tf

	arg_2_0.scheduleTF = var_1.Find(var_2_22, "scheduleBg")
	setText = var_1

	local var_2_23 = arg_2_0.scheduleTF
	local var_2_24 = var_3.Find(var_2_23, "root/window/left/title/Text")

	i18n = var_4

	var_1(var_2_24, var_4("child_plan_perform_title"))

	local var_2_25 = arg_2_0.scheduleTF
	local var_2_26 = var_1.Find(var_2_25, "root/window/left/content")

	UIItemList = var_2
	arg_2_0.planUIList = var_2.New(var_2_26, var_2_26:Find("tpl"))

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0.siteHandler

	var_1.BindEndBtn(var_4_0, function()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end, arg_4_0.contextData.onSiteEnd, arg_4_0.contextData.onNormal)

	local var_4_1 = arg_4_0.planUIList

	var_1.make(var_4_1, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		local var_6_0

		if arg_6_0 == var_2_10003.EventInit then
			var_6_0 = arg_4_0.plans[arg_6_1 + 1]
			setActive = var_2_10004

			var_2_10004(arg_6_2:Find("icon"), var_6_0)

			if var_6_0 then
				var_2_10004 = "plan_type"
				pg = var_2_10005
				var_2_10004 = var_2_10004 .. var_2_10005.child2_plan[var_6_0].replace_type_show
				LoadImageSpriteAtlasAsync = var_5

				var_5("ui/neweducatecommonui_atlas", var_2_10004, arg_6_2:Find("icon"))
			end
		else
			UIItemList = var_6_0

			if arg_6_0 == var_6_0.EventUpdate then
				arg_6_1 = arg_6_1 + 1

				if arg_4_0.plans[arg_6_1] then
					setText = var_2_10004

					local var_6_1 = arg_6_2
					local var_6_2 = arg_6_2.Find(var_6_1, "Text")

					shortenString = var_2_10007
					pg = var_9

					var_2_10004(var_6_2, var_2_10007(var_9.child2_plan[var_3].name_2, 4))

					var_2_10004 = arg_4_0.curPlanIdx < arg_6_1 and "808182" or "ffffff"

					if arg_6_1 == arg_4_0.curPlanIdx then
						var_2_10004 = "29bfff"
					end

					setTextColor = var_5
					var_2_10007 = arg_6_2:Find("Text")
					Color = var_6_1

					var_5(var_2_10007, var_6_1.NewHex(var_2_10004))

					setActive = var_5

					var_5(arg_6_2:Find("selected"), arg_6_1 == arg_4_0.curPlanIdx)
				else
					setText = var_2_10004

					local var_6_3 = arg_6_2:Find("Text")

					i18n = var_2_10007

					var_2_10004(var_6_3, var_2_10007("child2_empty_plan"))

					setActive = var_2_10004

					var_2_10004(arg_6_2:Find("selected"), false)
				end
			end
		end

		return
	end)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = 2
	})

	return
end

function var_0_1.PlayLoopCpk(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.loopCpkPlayer

	string = var_1_10003
	var_7_0.cpkPath = var_1_10003.lower("OriginSource/cpk/" .. arg_7_1 .. ".cpk")

	local var_7_1 = arg_7_0.loopCpkPlayer

	string = var_3
	var_7_1.movieName = var_3.lower(arg_7_1 .. ".bytes")

	local var_7_2 = arg_7_0.loopCpkPlayer

	var_2.StopCpk(var_7_2)

	local var_7_3 = arg_7_0.loopCpkPlayer

	var_2.SetCpkTotalTimeCallback(var_7_3, function(arg_8_0)
		local var_8_0 = arg_7_0.loopCpkTF
		local var_8_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006
		var_8_1(var_8_0, var_2_10004(var_2_10006)).enabled = true

		return
	end)

	setActive = var_2

	var_2(arg_7_0.loopCpkTF, true)

	local var_7_4 = arg_7_0.loopCpkPlayer

	var_2.PlayCpk(var_7_4)

	return
end

function var_0_1.StopLoopCpk(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.loopCpkTF, false)

	local var_9_0 = arg_9_0.loopCpkTF
	local var_9_1 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	var_9_1(var_9_0, var_4(var_1_10006)).enabled = false

	return
end

function var_0_1.StartNode(arg_10_0, arg_10_1)
	arg_10_0:Show()

	local var_10_0 = arg_10_0.contextData.char
	local var_10_1 = var_2.GetFSM(var_10_0)

	arg_10_0.stystemNo = var_2.GetSystemNo(var_10_1)
	setActive = var_2

	local var_10_2 = arg_10_0.scheduleTF
	local var_10_3 = arg_10_0.stystemNo

	NewEducateFSM = var_1_10006

	var_2(var_10_2, var_10_3 == var_1_10006.SYSTEM.PLAN)

	local var_10_4 = arg_10_0.stystemNo

	NewEducateFSM = var_1_10003

	if var_10_4 == var_1_10003.SYSTEM.MAP then
		local var_10_5 = arg_10_0.contextData.char
		local var_10_6 = var_2.GetFSM(var_10_5)
		local var_10_7 = var_2.GetState

		NewEducateFSM = var_5

		local var_10_8 = var_10_7(var_10_6, var_5.SYSTEM.MAP)
		local var_10_9 = var_2.GetCurSiteId(var_10_8)
		local var_10_10 = arg_10_0.siteHandler

		var_4.SetSite(var_10_10, var_10_9)

		pg = var_4

		local var_10_11 = var_4.child2_site_display[var_10_9].type
		local var_10_12 = 0

		NewEducateConst = var_10_10

		local var_10_14

		if var_10_11 == var_10_10.SITE_TYPE.WORK then
			local var_10_13 = arg_10_0.contextData.char

			var_10_14 = var_10_14.GetNormalIdByType
			NewEducateConst = var_1_10009
			var_10_12 = var_10_14(var_10_13, var_1_10009.SITE_NORMAL_TYPE.WORK)
		else
			NewEducateConst = var_10_14

			if var_10_11 == var_10_14.SITE_TYPE.TRAVEL then
				local var_10_15 = arg_10_0.contextData.char
				local var_10_16 = var_6.GetNormalIdByType

				NewEducateConst = var_1_10009
				var_10_12 = var_10_16(var_10_15, var_1_10009.SITE_NORMAL_TYPE.TRAVEL)
			end
		end

		if var_10_12 ~= 0 then
			local var_10_17 = arg_10_0.contextData.char
			local var_10_18 = var_6.GetRoundData(var_10_17)
			local var_10_19 = var_6.getConfig(var_10_18, "stage")
			local var_10_20 = arg_10_0
			local var_10_21 = arg_10_0.PlayLoopCpk

			pg = var_1_10010

			var_10_21(var_10_20, var_1_10010.child2_site_normal[var_10_12].cpk[var_10_19])
		end
	end

	arg_10_0:ProceedNode(arg_10_1)

	return
end

function var_0_1.OnNodeChainEnd(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.loopCpkTF, false)

	local var_11_0 = arg_11_0.stystemNo

	NewEducateFSM = var_1_10002

	if var_11_0 == var_1_10002.SYSTEM.MAP then
		local var_11_1 = arg_11_0.cpkHandler

		var_1.Reset(var_11_1)

		local var_11_2 = arg_11_0.pictureHandler

		var_1.Reset(var_11_2)

		local var_11_3 = arg_11_0.wordHandler

		var_1.Reset(var_11_3)

		local var_11_4 = arg_11_0.dropHandler

		var_1.Reset(var_11_4)

		local var_11_5 = arg_11_0.minigameHandler

		var_1.Reset(var_11_5)

		local var_11_6 = arg_11_0.siteHandler

		var_1.OnEventEnd(var_11_6)
	else
		local var_11_7 = arg_11_0.stystemNo

		NewEducateFSM = var_2

		if var_11_7 == var_2.SYSTEM.PLAN then
			local var_11_8 = arg_11_0.contextData.char
			local var_11_9 = var_1.GetFSM(var_11_8)
			local var_11_10 = var_1.GetState

			NewEducateFSM = var_4

			local var_11_11 = var_11_10(var_11_9, var_4.SYSTEM.PLAN)

			if var_1.IsFinish(var_11_11) then
				arg_11_0:Hide()
			end
		else
			arg_11_0:Hide()
		end
	end

	return
end

function var_0_1.InitCallback(arg_12_0, arg_12_1)
	arg_12_0.callback = nil
	switch = var_2

	var_2(arg_12_1, {
		[var_0_1.NEXT_TYPE.NOMARL] = function()
			function arg_12_0.callback()
				pg = var_3_10000

				local var_14_0 = var_3_10000.m02
				local var_14_1 = var_0.sendNotification

				GAME = var_3_10003

				var_14_1(var_14_0, var_3_10003.NEW_EDUCATE_TRIGGER_NODE, {
					id = arg_12_0.contextData.char.id
				})

				return
			end

			return
		end,
		[var_0_1.NEXT_TYPE.PROBABILITY] = function()
			function arg_12_0.callback()
				pg = var_3_10000

				local var_16_0 = var_3_10000.m02
				local var_16_1 = var_0.sendNotification

				GAME = var_3_10003

				var_16_1(var_16_0, var_3_10003.NEW_EDUCATE_TRIGGER_NODE, {
					id = arg_12_0.contextData.char.id
				})

				return
			end

			return
		end,
		[var_0_1.NEXT_TYPE.OPTION] = function()
			function arg_12_0.callback(arg_18_0, arg_18_1)
				pg = var_3_10002

				local var_18_0 = var_3_10002.m02
				local var_18_1 = var_2.sendNotification

				GAME = var_3_10005

				var_18_1(var_18_0, var_3_10005.NEW_EDUCATE_TRIGGER_NODE, {
					id = arg_12_0.contextData.char.id,
					branch = arg_18_0,
					costs = arg_18_1
				})

				return
			end

			return
		end,
		[var_0_1.NEXT_TYPE.STORY_FLAG] = function()
			function arg_12_0.callback(arg_20_0)
				pg = var_3_10001

				local var_20_0 = var_3_10001.m02
				local var_20_1 = var_1.sendNotification

				GAME = var_3_10004

				var_20_1(var_20_0, var_3_10004.NEW_EDUCATE_TRIGGER_NODE, {
					id = arg_12_0.contextData.char.id,
					branch = arg_20_0
				})

				return
			end

			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "node表非法next_type: " .. arg_12_1)

		return
	end)

	return
end

function var_0_1.CheckSchedule(arg_22_0)
	local var_22_0 = arg_22_0.stystemNo

	NewEducateFSM = var_1_10002

	if var_22_0 == var_1_10002.SYSTEM.PLAN then
		local var_22_1 = arg_22_0.contextData.char
		local var_22_2 = var_1.GetFSM(var_22_1)
		local var_22_3 = var_1.GetState

		NewEducateFSM = var_1_10004

		local var_22_4 = var_22_3(var_22_2, var_1_10004.SYSTEM.PLAN)
		local var_22_5 = arg_22_0.contextData.char
		local var_22_6 = var_2.GetRoundData(var_22_5)

		arg_22_0.unlockPlanNum = var_2.getConfig(var_22_6, "plan_num")
		arg_22_0.plans = var_22_4:GetPlans()
		arg_22_0.curPlanIdx = var_22_4:GetCurIdx()

		local var_22_7 = arg_22_0.planUIList

		var_2.align(var_22_7, arg_22_0.unlockPlanNum)
	end

	return
end

function var_0_1.CheckLastDrops(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0.curNodeId or not arg_23_1 or #arg_23_1 == 0 then
		arg_23_2()
	else
		pg = var_3

		local var_23_0 = var_3.child2_node[arg_23_0.curNodeId].drop_type_client

		switch = var_1_10005

		var_1_10005(var_23_0, {
			[var_0_1.DROP_TYPE.WORD_PERFORMANCE] = function()
				local var_24_0 = arg_23_0.stystemNo

				NewEducateFSM = var_2_10001

				if var_24_0 == var_2_10001.SYSTEM.PLAN then
					local var_24_1 = arg_23_0.contextData.char
					local var_24_2 = var_0.GetFSM(var_24_1)
					local var_24_3 = var_0.GetState

					NewEducateFSM = var_2_10003

					local var_24_4 = var_24_3(var_24_2, var_2_10003.SYSTEM.PLAN)

					var_0.AddDrops(var_24_4, arg_23_1)
				end

				local var_24_5 = arg_23_0.wordHandler

				var_0.Play(var_24_5, var_0.performance_param[1], arg_23_2, arg_23_1, false)

				return
			end,
			[var_0_1.DROP_TYPE.MAIN_TIP] = function()
				local var_25_0 = arg_23_0.dropHandler

				var_0.Play(var_25_0, arg_23_1, arg_23_2)

				local var_25_1 = arg_23_0.wordHandler

				var_0.Reset(var_25_1)

				return
			end,
			[var_0_1.DROP_TYPE.EVENT] = function()
				seriesAsync = var_2_10000

				var_2_10000({
					function(arg_27_0)
						underscore = var_3_10001

						if #var_3_10001.select(arg_23_1, function(arg_28_0)
							local var_28_0 = arg_28_0.type

							NewEducateConst = var_4_10002

							return var_28_0 == var_4_10002.DROP_TYPE.BUFF
						end) > 0 then
							local var_27_0 = arg_23_0
							local var_27_1 = var_2.emit

							NewEducateBaseUI = var_3_10005

							var_27_1(var_27_0, var_3_10005.ON_DROP, {
								items = var_1,
								removeFunc = arg_27_0
							})
						else
							arg_27_0()
						end

						return
					end
				}, function()
					local var_29_0 = arg_23_0.siteHandler

					var_0.Play(var_29_0, arg_23_0.curNodeId, arg_23_2, arg_23_1)

					return
				end)

				return
			end,
			[var_0_1.DROP_TYPE.POLAROID] = function()
				local var_30_0 = arg_23_0

				var_0.StopLoopCpk(var_30_0)

				local var_30_1 = arg_23_0.cpkHandler

				var_0.Reset(var_30_1)

				local var_30_2 = arg_23_0.wordHandler

				var_0.Reset(var_30_2)

				local var_30_3 = {}

				ipairs = var_2_10001

				for iter_30_0, iter_30_1 in var_2_10001(arg_23_1) do
					assert = var_2_10006

					local var_30_4 = iter_30_1.type

					NewEducateConst = var_2_10009

					var_2_10006(var_30_4 == var_2_10009.DROP_TYPE.POLAROID, "drop_type_client4的掉落必须为大头贴")

					table = var_2_10006

					var_2_10006.insert(var_30_3, function(arg_31_0)
						local var_31_0 = arg_23_0.dropHandler

						var_1.PlayPolaroid(var_31_0, iter_30_1, arg_31_0)

						return
					end)

					table = var_2_10006

					var_2_10006.insert(var_30_3, function(arg_32_0)
						pg = var_3_10001

						if #var_3_10001.child2_polaroid[iter_30_1.id].desc > 0 then
							local var_32_0 = arg_23_0.wordHandler

							var_2.PlayWordIds(var_32_0, var_1, arg_32_0)
						else
							arg_32_0()
						end

						return
					end)
				end

				seriesAsync = var_1

				var_1(var_30_3, function()
					existCall = var_3_10000

					var_3_10000(arg_23_2)

					if #arg_23_1 > 0 then
						pg = var_0

						local var_33_0 = var_0.TipsMgr.GetInstance()
						local var_33_1 = var_0.ShowTips

						i18n = var_3_10003

						var_33_1(var_33_0, var_3_10003("child_polaroid_get_tip"))
					end

					return
				end)

				return
			end,
			[var_0_1.DROP_TYPE.DROP_LAYER] = function()
				local var_34_0 = arg_23_0
				local var_34_1 = var_0.emit

				NewEducateBaseUI = var_2_10003

				var_34_1(var_34_0, var_2_10003.ON_DROP, {
					items = arg_23_1,
					removeFunc = arg_23_2
				})

				return
			end
		}, function()
			warning = var_2_10000

			var_2_10000("node表非法drop_type_client: " .. var_23_0 .. ",node:" .. arg_23_0.curNodeId)

			local var_35_0 = arg_23_0
			local var_35_1 = var_0.emit

			NewEducateBaseUI = var_3

			var_35_1(var_35_0, var_3.ON_DROP, {
				items = arg_23_1,
				removeFunc = arg_23_2
			})

			return
		end)

		local var_23_1 = arg_23_0.stystemNo

		NewEducateFSM = var_1_10006

		if var_23_1 == var_1_10006.SYSTEM.MAP and var_23_0 == var_0_1.DROP_TYPE.WORD_PERFORMANCE then
			local var_23_2 = arg_23_0.siteHandler

			var_5.AddDropRecords(var_23_2, arg_23_1)
		end
	end

	return
end

function var_0_1.ProceedNode(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_37_0)
			local var_37_0 = arg_36_0

			var_1.CheckLastDrops(var_37_0, arg_36_2, arg_37_0)

			return
		end
	}, function()
		local var_38_0 = arg_36_0

		var_0._ProceedNode(var_38_0, arg_36_1, arg_36_2, arg_36_3)

		return
	end)

	return
end

function var_0_1._ProceedNode(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0.curNodeId = arg_39_1

	if arg_39_0.curNodeId == 0 then
		existCall = var_4

		var_4(arg_39_3)
		arg_39_0:OnNodeChainEnd()

		return
	end

	arg_39_0:CheckSchedule()

	pg = var_4

	local var_39_0 = var_4.child2_node[arg_39_1]

	originalPrint = var_1_10005

	var_1_10005("ProceedNode", arg_39_1)
	arg_39_0:InitCallback(var_39_0.next_type)

	switch = var_5

	var_5(var_39_0.type, {
		[var_0_1.NODE_TYPE.PERFORMANCE] = function()
			local var_40_0 = arg_39_0

			var_0.PlayPerformances(var_40_0, var_39_0.performance_type, var_39_0.performance_param, arg_39_0.callback)

			return
		end,
		[var_0_1.NODE_TYPE.DROP] = function()
			arg_39_0.callback()

			return
		end,
		[var_0_1.NODE_TYPE.STORY_BRANCH] = function()
			local var_42_0 = arg_39_0

			var_0.PlayStoryBranch(var_42_0, var_39_0.performance_param, function(arg_43_0)
				arg_39_0.callback(arg_43_0)

				return
			end)

			return
		end,
		[var_0_1.NODE_TYPE.EVENT_TEXT] = function()
			local var_44_0 = arg_39_0.siteHandler

			var_0.Play(var_44_0, arg_39_1, arg_39_0.callback)

			return
		end,
		[var_0_1.NODE_TYPE.EVENT_OPTION] = function()
			local var_45_0 = arg_39_0.siteHandler

			var_0.Play(var_45_0, arg_39_1, arg_39_0.callback)

			return
		end,
		[var_0_1.NODE_TYPE.MAIN_TEXT] = function()
			local var_46_0 = arg_39_0
			local var_46_1 = var_0._IsShowNextInMainText(var_46_0, var_39_0)

			if var_39_0.next_type == var_0_1.NEXT_TYPE.OPTION then
				local function var_46_2()
					local var_47_0 = arg_39_0.optionsHandler

					var_0.Play(var_47_0, var_39_0.next, arg_39_0.callback)

					return
				end

				var_2_10004 = arg_39_0.wordHandler

				local var_46_3 = var_2.Play

				tonumber = var_2_10005

				var_46_3(var_2_10004, var_2_10005(var_39_0.text), var_46_2, nil, var_46_1, true)
			else
				local var_46_4 = arg_39_0.wordHandler
				local var_46_5 = var_1.Play

				tonumber = var_2_10004

				var_46_5(var_46_4, var_2_10004(var_39_0.text), arg_39_0.callback, nil, var_46_1, true)
			end

			return
		end,
		[var_0_1.NODE_TYPE.MAIN_OPTION] = function()
			arg_39_0.callback()

			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "node表非法type: " .. var_39_0.type)

		return
	end)

	return
end

function var_0_1._IsShowNextInMainText(arg_50_0, arg_50_1)
	if arg_50_1.next == "" then
		return false
	end

	if arg_50_1.next_type == var_0_1.NEXT_TYPE.NOMARL then
		tonumber = var_2

		local var_50_0 = var_2(arg_50_1.next)

		pg = var_3

		return var_3.child2_node[var_50_0].type ~= var_0_1.NODE_TYPE.DROP
	end

	return true
end

function var_0_1.PlayPerformances(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	switch = var_1_10004

	local var_51_0 = arg_51_1
	local var_51_1 = {}

	NewEducateConst = var_1_10008
	var_51_1[var_1_10008.PERFORM_TYPE.CPK] = function()
		local var_52_0 = arg_51_0.wordHandler

		var_0.Reset(var_52_0)

		local var_52_1 = arg_51_0.contextData.char
		local var_52_2 = var_0.GetRoundData(var_52_1)
		local var_52_3 = var_0.getConfig(var_52_2, "stage")
		local var_52_4 = ""
		local var_52_5 = arg_51_0.stystemNo

		NewEducateFSM = var_3

		if var_52_5 == var_3.SYSTEM.PLAN then
			local var_52_6 = arg_51_0.plans[arg_51_0.curPlanIdx]

			pg = var_3
			var_52_4 = var_3.child2_plan[var_52_6].name
		end

		local var_52_7 = arg_51_0.cpkHandler
		local var_52_8 = var_2.SetUIParam
		local var_52_9 = arg_51_0.stystemNo

		NewEducateFSM = var_2_10006

		var_52_8(var_52_7, var_52_9 == var_2_10006.SYSTEM.PLAN)

		local var_52_10 = arg_51_0.cpkHandler

		var_2.Play(var_52_10, arg_51_2[var_52_3], arg_51_3, var_52_4)

		return
	end
	NewEducateConst = var_8
	var_51_1[var_8.PERFORM_TYPE.PICTURE] = function()
		local var_53_0 = arg_51_0.wordHandler

		var_0.Reset(var_53_0)

		local var_53_1 = arg_51_0.pictureHandler

		var_0.Play(var_53_1, arg_51_2, arg_51_3)

		return
	end
	NewEducateConst = var_8
	var_51_1[var_8.PERFORM_TYPE.WORD] = function()
		pg = var_2_10000

		local var_54_0 = var_2_10000.child2_node[arg_51_0.curNodeId].next == ""
		local var_54_1 = arg_51_0.wordHandler

		var_1.Play(var_54_1, arg_51_2[1], arg_51_3, nil, not var_54_0, true)

		return
	end
	NewEducateConst = var_8
	var_51_1[var_8.PERFORM_TYPE.STORY] = function()
		NewEducateHelper = var_2_10000

		var_2_10000.PlaySpecialStory(arg_51_2, function(arg_56_0, arg_56_1)
			arg_51_3(arg_56_1)

			return
		end, true)

		return
	end
	NewEducateConst = var_8
	var_51_1[var_8.PERFORM_TYPE.MINIGAME] = function()
		local var_57_0 = arg_51_0.minigameHandler
		local var_57_1 = var_0.Play

		tonumber = var_2_10003

		var_57_1(var_57_0, var_2_10003(arg_51_2), function(arg_58_0)
			arg_51_3(arg_58_0)

			local var_58_0 = arg_51_0.minigameHandler

			var_1.Reset(var_58_0)

			return
		end)

		return
	end

	var_1_10004(var_51_0, var_51_1, function()
		assert = var_2_10000

		var_2_10000(false, "node表非法performance_type: " .. arg_51_1)

		return
	end)

	return
end

function var_0_1.PlayStoryBranch(arg_60_0, arg_60_1, arg_60_2)
	NewEducateHelper = var_1_10003

	var_1_10003.PlaySpecialStory(arg_60_1, function(arg_61_0, arg_61_1)
		arg_60_2(arg_61_1)

		return
	end, true)

	return
end

function var_0_1.PlayWordIds(arg_62_0, arg_62_1, arg_62_2)
	arg_62_0:Show()

	local var_62_0 = arg_62_0.wordHandler

	var_3.PlayWordIds(var_62_0, arg_62_1, function()
		local var_63_0 = arg_62_0.wordHandler

		var_0.Reset(var_63_0)
		arg_62_0.super.Hide(arg_62_0)

		existCall = var_0

		var_0(arg_62_2)

		return
	end)

	return
end

function var_0_1.UpdateCallName(arg_64_0)
	local var_64_0 = arg_64_0.wordHandler

	var_1.UpdateCallName(var_64_0)

	local var_64_1 = arg_64_0.siteHandler

	var_1.UpdateCallName(var_64_1)

	local var_64_2 = arg_64_0.optionsHandler

	var_1.UpdateCallName(var_64_2)

	return
end

function var_0_1.Hide(arg_65_0)
	existCall = var_1_10001

	var_1_10001(arg_65_0.contextData.onHide)
	arg_65_0:StopLoopCpk()

	local var_65_0 = arg_65_0.cpkHandler

	var_1.Reset(var_65_0)

	local var_65_1 = arg_65_0.pictureHandler

	var_1.Reset(var_65_1)

	local var_65_2 = arg_65_0.wordHandler

	var_1.Reset(var_65_2)

	local var_65_3 = arg_65_0.dropHandler

	var_1.Reset(var_65_3)

	local var_65_4 = arg_65_0.siteHandler

	var_1.Reset(var_65_4)

	local var_65_5 = arg_65_0.optionsHandler

	var_1.Reset(var_65_5)

	local var_65_6 = arg_65_0.minigameHandler

	var_1.Reset(var_65_6)
	arg_65_0.super.Hide(arg_65_0)

	return
end

function var_0_1.OnDestroy(arg_66_0)
	arg_66_0:UnOverlayPanel(arg_66_0._tf, arg_66_0._parentTf)

	if arg_66_0.cpkHandler then
		local var_66_0 = arg_66_0.cpkHandler

		var_1.Destroy(var_66_0)
	end

	if arg_66_0.pictureHandler then
		local var_66_1 = arg_66_0.pictureHandler

		var_1.Destroy(var_66_1)
	end

	if arg_66_0.wordHandler then
		local var_66_2 = arg_66_0.wordHandler

		var_1.Destroy(var_66_2)
	end

	if arg_66_0.dropHandler then
		local var_66_3 = arg_66_0.dropHandler

		var_1.Destroy(var_66_3)
	end

	if arg_66_0.siteHandler then
		local var_66_4 = arg_66_0.siteHandler

		var_1.Destroy(var_66_4)
	end

	if arg_66_0.optionsHandler then
		local var_66_5 = arg_66_0.optionsHandler

		var_1.Destroy(var_66_5)
	end

	if arg_66_0.minigameHandler then
		local var_66_6 = arg_66_0.minigameHandler

		var_1.Destroy(var_66_6)
	end

	return
end

return var_0_1
