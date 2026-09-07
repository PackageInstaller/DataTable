local IslandActivitySpecialOrderPage = class("IslandActivitySpecialOrderPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function IslandActivitySpecialOrderPage:OnDataSetting()
	return
end

function IslandActivitySpecialOrderPage:getTabTipMapList()
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

function IslandActivitySpecialOrderPage:getItemTipPrefix()
	return "island_spoperation_item_2509_"
end

function IslandActivitySpecialOrderPage:OnFirstFlush()
	local var_4_0 = self:getTabTipMapList()

	UIItemList.StaticAlign(self.rtTabs, self.rtTabTpl, #var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(var_4_0[arg_5_1])

			setText(arg_5_2:Find("on/Text"), i18n(var_5_0))
			setText(arg_5_2:Find("off/Text"), i18n(var_5_0))
			setActive(arg_5_2:Find("line"), arg_5_1 < #var_4_0)
			onToggle(self, arg_5_2, function(arg_6_0)
				if arg_6_0 then
					self.index = arg_5_1

					eachChild(self.rtPages, function(arg_7_0, arg_7_1)
						arg_7_1 = arg_7_1 + 1

						setActive(arg_7_0, arg_5_1 == arg_7_1)

						return
					end)
					setText(self.rtTitle:Find("Text"), i18n(var_5_1))
					eachChild(self.rtPages:GetChild(arg_5_1 - 1):Find("content"), function(arg_8_0, arg_8_1)
						local var_8_0 = arg_8_0:Find("tpl")
						local var_8_1 = {}

						if arg_8_1 > 0 then
							table.insert(var_8_1, function(arg_9_0)
								setCanvasGroupAlpha(var_8_0, 0)
								LeanTween.delayedCall(arg_8_1 * 0.08, System.Action(arg_9_0))

								return
							end)
						end

						seriesAsync(var_8_1, function()
							if self._state == IslandActivitySpecialOrderPage.STATES.DESTROY then
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
	setText(self.rtTitle:Find("level/Text"), i18n("island_spoperation_level_2509_1"))
	eachChild(self.rtPages:Find("page_2/content"), function(arg_11_0, arg_11_1)
		arg_11_1 = arg_11_1 + 1

		setText(arg_11_0:Find("tpl/name"), i18n(self:getItemTipPrefix() .. arg_11_1))

		return
	end)

	return
end

function IslandActivitySpecialOrderPage:OnUpdateFlush()
	return
end

function IslandActivitySpecialOrderPage:OnShowFlush()
	quickPlayAnimation(self._tf, "Anim_IslandActivitySpecialOrderPage_in")
	triggerToggle(self.rtTabs:GetChild((self.index or 1) - 1), true)

	return
end

return IslandActivitySpecialOrderPage
