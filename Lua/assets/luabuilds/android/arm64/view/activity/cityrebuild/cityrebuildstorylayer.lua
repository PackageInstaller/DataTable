local var_0_0 = class("CityRebuildStoryLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CityRebuildStoryUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.closeBtn = arg_2_0._tf:Find("panel/closeBtn")
	arg_2_0.storyList = UIItemList.New(arg_2_0._tf:Find("panel/storyScroll/Viewport/Content"), arg_2_0._tf:Find("panel/storyScroll/Viewport/Content/story"))

	setText(arg_2_0._tf:Find("panel/desc"), i18n("ninja_game_storydialog"))
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.bg, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	arg_3_0:Refresh()

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.activityId = ActivityConst.NINJA_CITY_ACT_ID
	arg_6_0.cityRebuildProxy = getProxy(CityRebuildProxy)
	arg_6_0.cityRebuildData = arg_6_0.cityRebuildProxy:GetData(arg_6_0.activityId)
	arg_6_0.ids = {}
	arg_6_0.storyCfgs = {}

	for iter_6_0, iter_6_1 in ipairs(pg.activity_ninja_building.all) do
		if pg.activity_ninja_building[iter_6_1].story ~= "" then
			table.insert(arg_6_0.ids, iter_6_1)
			table.insert(arg_6_0.storyCfgs, pg.activity_ninja_building[iter_6_1].story)
		end
	end

	return
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0.storyList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_7_0.storyCfgs[arg_8_1 + 1]
			local var_8_1 = arg_7_0.cityRebuildData:IsRepairedOrRecruited(arg_7_0.ids[arg_8_1 + 1])

			setActive(arg_8_2:Find("normal"), var_8_1)
			setActive(arg_8_2:Find("lock"), not var_8_1)

			if var_8_1 then
				GetImageSpriteFromAtlasAsync(arg_7_0.storyCfgs[arg_8_1 + 1][6], "", arg_8_2:Find("normal/mask/pic"))
				setScrollText(arg_8_2:Find("normal/nameBg/name"), arg_7_0.storyCfgs[arg_8_1 + 1][5])
				onButton(arg_7_0, arg_8_2, function()
					pg.NewStoryMgr.GetInstance():Play(var_8_0[1], nil, true)

					return
				end, SFX_PANEL)
			else
				setScrollText(arg_8_2:Find("lock/mask/Text"), arg_7_0.storyCfgs[arg_8_1 + 1][4])
			end
		end

		return
	end)
	arg_7_0.storyList:align(#arg_7_0.storyCfgs)

	return
end

function var_0_0.willExit(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf)

	return
end

return var_0_0
