local var_0_0 = class("IslandActivitySpecialOrderPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_0.OnDataSetting(arg_1_0)
	return
end

function var_0_0.getTabTipMapList(arg_2_0)
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

function var_0_0.getItemTipPrefix(arg_3_0)
	return "island_spoperation_item_2509_"
end

function var_0_0.OnFirstFlush(arg_4_0)
	UIItemList.StaticAlign(arg_4_0.rtTabs, arg_4_0.rtTabTpl, #arg_4_0:getTabTipMapList(), function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(var_0[arg_5_1])

			setText(arg_5_2:Find("on/Text"), i18n(var_5_0))
			setText(arg_5_2:Find("off/Text"), i18n(var_5_0))
			setActive(arg_5_2:Find("line"), arg_5_1 < #var_0)
			onToggle(arg_4_0, arg_5_2, function(arg_6_0)
				if arg_6_0 then
					arg_4_0.index = arg_5_1

					eachChild(arg_4_0.rtPages, function(arg_7_0, arg_7_1)
						arg_7_1 = arg_7_1 + 1

						setActive(arg_7_0, arg_5_1 == arg_7_1)

						return
					end)
					setText(arg_4_0.rtTitle:Find("Text"), i18n(var_5_1))
					eachChild(arg_4_0.rtPages:GetChild(arg_5_1 - 1):Find("content"), function(arg_8_0, arg_8_1)
						local var_8_0 = arg_8_0:Find("tpl")

						if arg_8_1 > 0 then
							table.insert({}, function(arg_9_0)
								setCanvasGroupAlpha(var_8_0, 0)
								LeanTween.delayedCall(arg_8_1 * 0.08, System.Action(arg_9_0))

								return
							end)
						end

						seriesAsync({}, function()
							if arg_4_0._state == var_0_0.STATES.DESTROY then
								return
							end

							quickPlayAnimation(var_8_0, "Anim_IslandActivitySpecialOrderPageTPl_in")

							return
						end)

						return
					end)
				end

				return
			end, SFX_PANEL)

			if arg_5_1 == 1 then
				triggerToggle(arg_5_2, true)
			end
		end

		return
	end)
	setText(arg_4_0.rtTitle:Find("level/Text"), i18n("island_spoperation_level_2509_1"))
	eachChild(arg_4_0.rtPages:Find("page_2/content"), function(arg_11_0, arg_11_1)
		arg_11_1 = arg_11_1 + 1

		setText(arg_11_0:Find("tpl/name"), i18n(arg_4_0:getItemTipPrefix() .. arg_11_1))

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	return
end

function var_0_0.OnShowFlush(arg_13_0)
	quickPlayAnimation(arg_13_0._tf, "Anim_IslandActivitySpecialOrderPage_in")

	local var_13_0 = arg_13_0.index or 1

	triggerToggle(arg_13_0.rtTabs:GetChild(var_13_0 - 1), true)

	return
end

return var_0_0
