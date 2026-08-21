local var_0_0 = class("AnniversaryIslandBuildingUpgrade2023Window", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AnniversaryIslandBuildingUpgrade2023Window"
end

function var_0_0.GetAtlasPath(arg_2_0)
	return "ui/" .. arg_2_0:getUIName() .. "_atlas"
end

function var_0_0.init(arg_3_0)
	arg_3_0.window = arg_3_0._tf:Find("Window")
	arg_3_0.upgradeWindow = arg_3_0.window:Find("Upgrade")
	arg_3_0.displayWindow = arg_3_0.window:Find("Display")

	setText(arg_3_0.window:Find("Upgrade/MaterialsTitle"), i18n("workbench_need_materials"))
	setText(arg_3_0.window:Find("Display/MaxTip"), i18n("workbench_tips6"))

	arg_3_0.loader = AutoLoader.New()

	return
end

function var_0_0.didEnter(arg_4_0)
	local var_4_0 = arg_4_0.contextData.buildingID

	onButton(arg_4_0, arg_4_0._tf:Find("BG"), function()
		arg_4_0:onBackPressed()

		return
	end)
	onButton(arg_4_0, arg_4_0.upgradeWindow:Find("Cancel"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.upgradeWindow:Find("Upgrade"), function()
		if arg_4_0.isMaxLevel then
			return
		elseif arg_4_0.isOverAvg then
			pg.TipsMgr.GetInstance():ShowTips(i18n("haidaojudian_upgrade_limit"))
		elseif arg_4_0.isLackMat then
			pg.TipsMgr.GetInstance():ShowTips(i18n("haidaojudian_building_tip"))
		else
			arg_4_0:emit(BuildingUpgradeMediator.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_4_0.activityId,
				arg1 = var_4_0
			})
		end

		return
	end)
	onButton(arg_4_0, arg_4_0.displayWindow:Find("Confirm"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	arg_4_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = arg_9_0.contextData.buildingID
	local var_9_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	arg_9_0.activityId = var_9_1.id

	local var_9_2 = var_9_1:GetBuildingLevel(var_9_0)

	arg_9_0.isMaxLevel = #pg.activity_event_building[var_9_0].buff <= var_9_2
	arg_9_0.isOverAvg = var_9_2 > var_9_1:GetTotalBuildingLevel()

	setActive(arg_9_0.upgradeWindow, not arg_9_0.isMaxLevel)
	setActive(arg_9_0.displayWindow, arg_9_0.isMaxLevel)

	if arg_9_0.isMaxLevel then
		local var_9_3 = arg_9_0.displayWindow or arg_9_0.upgradeWindow

		arg_9_0.loader:GetSpriteQuiet(arg_9_0:GetAtlasPath(), AnniversaryIsland2023Scene.Buildings[var_9_0], var_9_3:Find("Title/BuildingName"), true)

		local var_9_4 = 0

		;(function()
			arg_9_0.loader:GetSpriteQuiet(arg_9_0:GetAtlasPath(), var_9_2, var_9_3:Find("Title/LevelBefore"), true)

			local var_10_0 = CommonBuff.New({
				id = var_0.buff[var_9_2]
			})
			local var_10_1 = string.split(var_10_0:getConfig("desc"), "/")

			assert(var_10_1)

			local var_10_2, var_10_3, var_10_4 = string.find(var_10_1[1], "([^%+]*)%+")
			local var_10_5, var_10_6, var_10_7 = string.find(var_10_1[2], "([^%+]*)%+")

			setText(var_9_3:Find("Progress1/1/Desc"), var_10_4)
			setText(var_9_3:Find("Progress1/1/Value"), (string.sub(var_10_1[1], var_10_3, #var_10_1[1])))
			setText(var_9_3:Find("Progress2/1/Desc"), var_10_7)
			setText(var_9_3:Find("Progress2/1/Value"), (string.sub(var_10_1[2], var_10_6, #var_10_1[2])))

			var_9_4 = tonumber(var_10_0:getConfig("benefit_effect"))

			return
		end)()
		;(function()
			if var_9_2 >= var_0 then
				return
			end

			local var_11_0 = var_9_2 + 1

			arg_9_0.loader:GetSpriteQuiet(arg_9_0:GetAtlasPath(), var_9_2 + 1, var_9_3:Find("Title/LevelAfter"), true)

			local var_11_1 = CommonBuff.New({
				id = var_0.buff[var_11_0]
			})
			local var_11_2 = string.split(var_11_1:getConfig("desc"), "/")

			assert(var_11_2)

			local var_11_3, var_11_4, var_11_5 = string.find(var_11_2[1], "([^%+]*)%+")
			local var_11_6, var_11_7, var_11_8 = string.find(var_11_2[2], "([^%+]*)%+")

			setText(var_9_3:Find("Progress1/2/Desc"), var_11_5)
			setText(var_9_3:Find("Progress1/2/Value"), (string.sub(var_11_2[1], var_11_4, #var_11_2[1])))
			setText(var_9_3:Find("Progress2/2/Desc"), var_11_8)
			setText(var_9_3:Find("Progress2/2/Value"), (string.sub(var_11_2[2], var_11_7, #var_11_2[2])))
			setActive(var_9_3:Find("Progress2/2/Up"), tonumber(var_11_1:getConfig("benefit_effect")) > var_9_4)

			return
		end)()
		;(function()
			if var_9_2 >= var_0 then
				return
			end

			local var_12_0 = var_0.material[var_9_2]
			local var_12_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

			arg_9_0.isLackMat = false

			UIItemList.StaticAlign(var_9_3:Find("Materials"), var_9_3:Find("Materials"):GetChild(0), #var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
				if arg_13_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_13_0 = var_12_0[arg_13_1 + 1]

				arg_9_0:UpdateActivityDrop(arg_13_2:Find("Icon"), {
					type = var_12_0[arg_13_1 + 1][1],
					id = var_12_0[arg_13_1 + 1][2],
					count = var_12_0[arg_13_1 + 1][3]
				})
				onButton(arg_9_0, arg_13_2:Find("Icon"), function()
					if var_0.type == DROP_TYPE_WORKBENCH_DROP then
						arg_9_0:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
							configId = var_0.id,
							count = var_0.count
						}))
					else
						arg_9_0:emit(BaseUI.ON_DROP, var_0)
					end

					return
				end)

				local var_13_1 = var_12_1:getVitemNumber(var_13_0[2])
				local var_13_2 = var_13_1 < var_13_0[3]

				setText(arg_13_2:Find("Text"), setColorStr(var_13_1, var_13_1 < var_13_0[3] and "#bb6754" or "#6b5a48") .. "/" .. var_13_0[3])

				arg_9_0.isLackMat = arg_9_0.isLackMat or var_13_2

				return
			end)

			return
		end)()

		return
	end
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function var_0_0.UpdateActivityDrop(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	updateDrop(arg_15_1, arg_15_2)
	SetCompomentEnabled(arg_15_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_15_1:Find("bg"), false)
	setActive(arg_15_1:Find("icon_bg/frame"), false)
	setActive(arg_15_1:Find("icon_bg/stars"), false)

	local var_15_0 = arg_15_2:getConfig("rarity")

	if arg_15_2.type == DROP_TYPE_EQUIP or arg_15_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_15_0 = var_15_0 - 1
	end

	local var_15_1 = "icon_frame_" .. var_15_0

	if arg_15_3 then
		var_15_1 = var_15_1 .. "_small"
	end

	arg_15_0.loader:GetSpriteQuiet(var_0_1, var_15_1, arg_15_1)

	return
end

function var_0_0.willExit(arg_16_0)
	arg_16_0.loader:Clear()

	return
end

return var_0_0
