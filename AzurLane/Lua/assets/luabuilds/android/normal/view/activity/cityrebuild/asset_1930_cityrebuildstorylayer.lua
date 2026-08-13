class = var_0_10000

local var_0_0 = "CityRebuildStoryLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CityRebuildStoryUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "panel/closeBtn")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "panel/storyScroll/Viewport/Content")
	local var_2_5 = arg_2_0._tf

	arg_2_0.storyList = var_2_2(var_2_4, var_3.Find(var_2_5, "panel/storyScroll/Viewport/Content/story"))
	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "panel/desc")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("ninja_game_storydialog"))

	pg = var_1

	local var_2_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_8, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bg

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)
	arg_3_0:Refresh()

	return
end

function var_0_1.InitData(arg_6_0)
	ActivityConst = var_1_10001
	arg_6_0.activityId = var_1_10001.NINJA_CITY_ACT_ID
	getProxy = var_1
	CityRebuildProxy = var_1_10002
	arg_6_0.cityRebuildProxy = var_1(var_1_10002)

	local var_6_0 = arg_6_0.cityRebuildProxy

	arg_6_0.cityRebuildData = var_1.GetData(var_6_0, arg_6_0.activityId)
	arg_6_0.ids = {}
	arg_6_0.storyCfgs = {}
	ipairs = var_1
	pg = var_6_0

	for iter_6_0, iter_6_1 in var_1(var_6_0.activity_ninja_building.all) do
		pg = var_1_10006

		if var_1_10006.activity_ninja_building[iter_6_1].story ~= "" then
			table = var_7

			var_7.insert(arg_6_0.ids, iter_6_1)

			table = var_7

			var_7.insert(arg_6_0.storyCfgs, var_1_10006.story)
		end
	end

	return
end

function var_0_1.Refresh(arg_7_0)
	local var_7_0 = arg_7_0.storyList

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_0.ids[arg_8_1 + 1]
			local var_8_1 = arg_7_0.storyCfgs[arg_8_1 + 1]
			local var_8_2 = arg_7_0.cityRebuildData
			local var_8_3 = var_5.IsRepairedOrRecruited(var_8_2, var_8_0)

			setActive = var_8_2

			var_8_2(arg_8_2:Find("normal"), var_8_3)

			setActive = var_8_2

			var_8_2(arg_8_2:Find("lock"), not var_8_3)

			if var_8_3 then
				GetImageSpriteFromAtlasAsync = var_8_2

				local var_8_4 = var_8_1[6]
				local var_8_5 = ""
				local var_8_6 = arg_8_2

				var_8_2(var_8_4, var_8_5, arg_8_2.Find(var_8_6, "normal/mask/pic"))

				setScrollText = var_8_2

				var_8_2(arg_8_2:Find("normal/nameBg/name"), var_8_1[5])

				onButton = var_8_2

				local var_8_7 = arg_7_0
				local var_8_8 = arg_8_2

				local function var_8_9()
					pg = var_3_10000

					local var_9_0 = var_3_10000.NewStoryMgr.GetInstance()

					var_0.Play(var_9_0, var_8_1[1], nil, true)

					return
				end

				SFX_PANEL = var_8_6

				var_8_2(var_8_7, var_8_8, var_8_9, var_8_6)
			else
				setScrollText = var_8_2

				var_8_2(arg_8_2:Find("lock/mask/Text"), var_8_1[4])
			end
		end

		return
	end)

	local var_7_1 = arg_7_0.storyList

	var_1.align(var_7_1, #arg_7_0.storyCfgs)

	return
end

function var_0_1.willExit(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf)

	return
end

return var_0_1
