class = var_0_10000

local var_0_0 = "NewEducateTalentLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateTalentUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.animCom = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.animEvent

	var_1.SetTriggerEvent(var_2_4, function()
		local var_3_0 = arg_2_0.animEvent

		var_0.SetEndEvent(var_3_0, nil)

		local var_3_1 = arg_2_0

		var_0.RefreshView(var_3_1)

		return
	end)

	local var_2_5 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_5, "root")

	local var_2_6 = arg_2_0.rootTF

	arg_2_0.bgTF = var_1.Find(var_2_6, "bg")

	local var_2_7 = arg_2_0.rootTF
	local var_2_8 = var_1.Find(var_2_7, "window/content")

	UIItemList = var_2_7
	arg_2_0.uiList = var_2_7.New(var_2_8, var_2_8:Find("tpl"))

	local var_2_9 = arg_2_0.uiList

	var_2.make(var_2_9, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			arg_4_2.name = arg_4_1 + 1

			local var_4_0 = arg_2_0.talentList[arg_4_1 + 1]
			local var_4_1 = arg_2_0

			var_4.UpdateItem(var_4_1, var_4_0, arg_4_2)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1,
		pbList = {
			arg_5_0.bgTF
		}
	})

	NewEducateGuideSequence = var_1

	var_1.CheckGuide(arg_5_0.__cname)

	return
end

function var_0_1.GetRarityBg(arg_6_0, arg_6_1)
	switch = var_1_10002

	local var_6_0 = arg_6_1
	local var_6_1 = {}

	NewEducateBuff = var_1_10005
	var_6_1[var_1_10005.RARITY.BLUE] = function()
		return "bg_blue"
	end
	NewEducateBuff = var_5
	var_6_1[var_5.RARITY.PURPLE] = function()
		return "bg_purple"
	end
	NewEducateBuff = var_5
	var_6_1[var_5.RARITY.GOLD] = function()
		return "bg_gold"
	end
	NewEducateBuff = var_5
	var_6_1[var_5.RARITY.COLOURS] = function()
		return "bg_colours"
	end

	return var_1_10002(var_6_0, var_6_1)
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	local var_11_0 = var_1_10003.child2_benefit_list[arg_11_1]

	setText = var_1_10004

	var_1_10004(arg_11_2:Find("name/Text"), var_11_0.name)

	setText = var_1_10004

	var_1_10004(arg_11_2:Find("desc/Text"), var_11_0.desc)

	LoadImageSpriteAtlasAsync = var_1_10004

	var_1_10004("ui/neweducatetalentui_atlas", arg_11_0:GetRarityBg(var_11_0.rare), arg_11_2, true)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("neweducateicon/" .. var_11_0.item_icon, arg_11_2:Find("icon"), true)

	table = var_1_10004

	local var_11_1 = not var_1_10004.contains(arg_11_0.reTalentList, arg_11_1)

	setGray = var_5

	var_5(arg_11_2:Find("refresh_btn"), not var_11_1)

	onButton = var_5

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_2:Find("refresh_btn")

	local function var_11_4()
		if arg_11_0.isPlaying then
			return
		end

		if not var_11_1 then
			return
		end

		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		NewEducateTalentMediator = var_2_10002

		local var_12_2 = var_2_10002.ON_REFRESH_TALENT
		local var_12_3 = arg_11_1

		tonumber = var_2_10004

		var_12_1(var_12_0, var_12_2, var_12_3, var_2_10004(arg_11_2.name))

		return
	end

	SFX_PANEL = var_9

	var_5(var_11_2, var_11_3, var_11_4, var_9)

	setText = var_5

	var_5(arg_11_2:Find("refresh_btn/Text"), var_11_1 and 1 or 0)

	onButton = var_5

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_2

	local function var_11_7()
		if arg_11_0.isPlaying then
			return
		end

		local var_13_0 = arg_11_0
		local var_13_1 = var_0.emit

		NewEducateTalentMediator = var_2_10002

		local var_13_2 = var_2_10002.ON_SELECT_TALENT
		local var_13_3 = arg_11_1

		tonumber = var_2_10004

		var_13_1(var_13_0, var_13_2, var_13_3, var_2_10004(arg_11_2.name))

		return
	end

	SFX_PANEL = var_9

	var_5(var_11_5, var_11_6, var_11_7, var_9)

	return
end

function var_0_1.RefreshView(arg_14_0)
	local var_14_0 = arg_14_0.contextData.char
	local var_14_1 = var_1.GetFSM(var_14_0)
	local var_14_2 = var_1.GetState

	NewEducateFSM = var_1_10003

	local var_14_3 = var_14_2(var_14_1, var_1_10003.SYSTEM.TALENT)

	arg_14_0.talentList = var_1.GetTalents(var_14_3)
	arg_14_0.reTalentList = var_1:GetReTalents()

	local var_14_4 = arg_14_0.uiList

	var_2.align(var_14_4, #arg_14_0.talentList)

	return
end

function var_0_1.OnRefreshTalent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.contextData.char
	local var_15_1 = var_3.GetFSM(var_15_0)
	local var_15_2 = var_3.GetState

	NewEducateFSM = var_1_10005

	local var_15_3 = var_15_2(var_15_1, var_1_10005.SYSTEM.TALENT)

	arg_15_0.talentList = var_3.GetTalents(var_15_3)
	arg_15_0.reTalentList = var_3:GetReTalents()
	eachChild = var_4

	var_4(arg_15_0.uiList.container, function(arg_16_0)
		tonumber = var_2_10001

		if var_2_10001(arg_16_0.name) == arg_15_1 then
			local var_16_0 = arg_16_0
			local var_16_1 = arg_16_0.GetComponent

			typeof = var_2_10003
			DftAniEvent = var_2_10004

			local var_16_2 = var_16_1(var_16_0, var_2_10003(var_2_10004))

			var_1.SetTriggerEvent(var_16_2, function()
				local var_17_0 = var_0

				var_0.SetTriggerEvent(var_17_0, nil)

				arg_15_0.isPlaying = false

				local var_17_1 = arg_15_0

				var_0.UpdateItem(var_17_1, arg_15_2, arg_16_0)

				return
			end)

			local var_16_3 = arg_16_0
			local var_16_4 = arg_16_0.GetComponent

			typeof = var_4
			Animation = var_2_10005

			local var_16_5 = var_16_4(var_16_3, var_4(var_2_10005))

			var_2.Play(var_16_5, "Anim_educate_talent_tpl_change")

			arg_15_0.isPlaying = true
		end

		return
	end)

	return
end

function var_0_1.OnSelectedDone(arg_18_0, arg_18_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_19_0)
			if #arg_18_1.drops > 0 then
				local var_19_0 = arg_18_0

				var_1.emit(var_19_0, var_0_1.ON_DROP, {
					items = arg_18_1.drops,
					removeFunc = function()
						arg_19_0()

						return
					end
				})
			else
				arg_19_0()
			end

			return
		end
	}, function()
		local var_21_0 = arg_18_0.animEvent

		var_0.SetEndEvent(var_21_0, function()
			local var_22_0 = arg_18_0.animEvent

			var_0.SetEndEvent(var_22_0, nil)

			arg_18_0.isPlaying = false

			local var_22_1 = arg_18_0

			var_0.closeView(var_22_1)

			return
		end)

		local var_21_1 = arg_18_0.animCom

		var_0.Play(var_21_1, "Anim_educate_talent_select")

		local var_21_2 = arg_18_0

		var_21_2.isPlaying = true
		eachChild = var_21_2

		var_21_2(arg_18_0.uiList.container, function(arg_23_0)
			tonumber = var_3_10001

			if var_3_10001(arg_23_0.name) ~= arg_18_1.idx then
				local var_23_0 = arg_23_0
				local var_23_1 = arg_23_0.GetComponent

				typeof = var_3_10003
				Animation = var_3_10004

				local var_23_2 = var_23_1(var_23_0, var_3_10003(var_3_10004))

				var_1.Play(var_23_2, "Anim_educate_talent_tpl_out")
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_24_0)
	return
end

function var_0_1.willExit(arg_25_0)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)

	existCall = var_1

	var_1(arg_25_0.contextData.onExit)

	return
end

return var_0_1
