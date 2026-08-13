class = var_0_10000

local var_0_0 = "IslandActivitySpecialOrderPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_1.OnDataSetting(arg_1_0)
	return
end

function var_0_1.getTabTipMapList(arg_2_0)
	return {
		{
			"island_spoperation_btn_2509_1",
			"island_spoperation_tip_2509_3"
		},
		{
			"island_spoperation_btn_2509_2",
			"island_spoperation_tip_2509_2"
		},
		{
			"island_spoperation_btn_2509_3",
			"island_spoperation_tip_2509_1"
		}
	}
end

function var_0_1.getItemTipPrefix(arg_3_0)
	return "island_spoperation_item_2509_"
end

function var_0_1.OnFirstFlush(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getTabTipMapList(var_4_0)

	UIItemList = var_4_0

	var_4_0.StaticAlign(arg_4_0.rtTabs, arg_4_0.rtTabTpl, #var_4_1, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_5_0, var_5_1 = var_3(var_4_1[arg_5_1])

			setText = var_2_10005

			local var_5_2 = arg_5_2
			local var_5_3 = arg_5_2.Find(var_5_2, "on/Text")

			i18n = var_5_2

			var_2_10005(var_5_3, var_5_2(var_5_0))

			setText = var_2_10005

			local var_5_4 = arg_5_2
			local var_5_5 = arg_5_2.Find(var_5_4, "off/Text")

			i18n = var_5_4

			var_2_10005(var_5_5, var_5_4(var_5_0))

			setActive = var_2_10005

			var_2_10005(arg_5_2:Find("line"), arg_5_1 < #var_4_1)

			onToggle = var_2_10005

			local var_5_6 = arg_4_0
			local var_5_7 = arg_5_2

			local function var_5_8(arg_6_0)
				if arg_6_0 then
					local var_6_0 = arg_4_0

					var_6_0.index = arg_5_1
					eachChild = var_6_0

					var_6_0(arg_4_0.rtPages, function(arg_7_0, arg_7_1)
						arg_7_1 = arg_7_1 + 1
						setActive = var_4_10002

						var_4_10002(arg_7_0, arg_5_1 == arg_7_1)

						return
					end)

					setText = var_6_0

					local var_6_1 = arg_4_0.rtTitle
					local var_6_2 = var_2.Find(var_6_1, "Text")

					i18n = var_6_1

					var_6_0(var_6_2, var_6_1(var_5_1))

					eachChild = var_6_0

					local var_6_3 = arg_4_0.rtPages
					local var_6_4 = var_2.GetChild(var_6_3, arg_5_1 - 1)

					var_6_0(var_2.Find(var_6_4, "content"), function(arg_8_0, arg_8_1)
						local var_8_0 = arg_8_0:Find("tpl")
						local var_8_1 = {}

						if 0 < arg_8_1 then
							table = var_4

							var_4.insert(var_8_1, function(arg_9_0)
								setCanvasGroupAlpha = var_5_10001

								var_5_10001(var_8_0, 0)

								LeanTween = var_5_10001

								local var_9_0 = var_5_10001.delayedCall
								local var_9_1 = arg_8_1 * 0.08

								System = var_3

								var_9_0(var_9_1, var_3.Action(arg_9_0))

								return
							end)
						end

						seriesAsync = var_4

						var_4(var_8_1, function()
							if arg_4_0._state == var_0_1.STATES.DESTROY then
								return
							end

							quickPlayAnimation = var_0

							var_0(var_8_0, "Anim_IslandActivitySpecialOrderPageTPl_in")

							return
						end)

						return
					end)
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_2_10005(var_5_6, var_5_7, var_5_8, var_2_10009)

			if arg_5_1 == 1 then
				triggerToggle = var_2_10005

				var_2_10005(arg_5_2, true)
			end
		end

		return
	end)

	setText = var_2

	local var_4_2 = arg_4_0.rtTitle
	local var_4_3 = var_3.Find(var_4_2, "level/Text")

	i18n = var_4_2

	var_2(var_4_3, var_4_2("island_spoperation_level_2509_1"))

	eachChild = var_2

	local var_4_4 = arg_4_0.rtPages

	var_2(var_3.Find(var_4_4, "page_2/content"), function(arg_11_0, arg_11_1)
		arg_11_1 = arg_11_1 + 1
		setText = var_2_10002

		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.Find(var_11_0, "tpl/name")

		i18n = var_11_0

		local var_11_2 = arg_4_0

		var_2_10002(var_11_1, var_11_0(var_5.getItemTipPrefix(var_11_2) .. arg_11_1))

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	return
end

function var_0_1.OnShowFlush(arg_13_0)
	quickPlayAnimation = var_1_10001

	var_1_10001(arg_13_0._tf, "Anim_IslandActivitySpecialOrderPage_in")

	triggerToggle = var_1_10001

	local var_13_0 = arg_13_0.rtTabs
	local var_13_1 = var_2.GetChild
	local var_13_2

	if not arg_13_0.index then
		var_13_2 = 1
	end

	var_1_10001(var_13_1(var_13_0, var_13_2 - 1), true)

	return
end

return var_0_1
