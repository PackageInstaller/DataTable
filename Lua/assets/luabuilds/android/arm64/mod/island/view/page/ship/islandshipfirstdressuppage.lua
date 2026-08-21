local var_0_0 = class("IslandShipFirstDressupPage", import(".IslandBaseDressupPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommanderMainUI"
end

function var_0_0.CanEsc(arg_2_0)
	return false
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.leftPlane = arg_3_0._tf:Find("adapt/left_panel")
	arg_3_0.backBtn = arg_3_0._tf:Find("adapt/left_panel/back")
	arg_3_0.homeBtn = arg_3_0._tf:Find("adapt/home")

	setText(arg_3_0._tf:Find("adapt/left_panel/title/Text"), i18n("island_dressup_titile"))
	setActive(arg_3_0.leftPlane, false)
	setActive(arg_3_0.homeBtn, false)

	return
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddListener(GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE, arg_4_0.OnDressUpDone)

	return
end

function var_0_0.RemoveListeners(arg_5_0)
	arg_5_0:RemoveListener(GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE, arg_5_0.OnDressUpDone)

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.homeBtn, function()
		arg_6_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		if arg_6_0:CheckDressIsDirty() then
			arg_6_0:ShowMsgBox({
				type = IslandMsgBox.TYPE_COMMON,
				content = i18n("island_dressup_tip_1"),
				onYes = function()
					arg_6_0.currentChildPage:SaveDressUpData()
					arg_6_0:Hide()

					return
				end,
				onNo = function()
					arg_6_0:Hide()

					return
				end
			})
		else
			arg_6_0:Hide()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_11_0, arg_11_1)
	arg_11_0.callback = arg_11_1

	var_0_0.super.Show(arg_11_0)
	arg_11_0:Flush()

	arg_11_0.shipDressHelper = IslandShipDressHelperNew.New()

	arg_11_0.shipDressHelper:SetShipId(0)

	arg_11_0.currentChildPage = arg_11_0:OpenPage(IslandShipDressUpPageNew, 0, true, arg_11_0.shipDressHelper)

	arg_11_0:LoadCharacter({
		model = pg.island_unit_character[0].model,
		animator = pg.island_unit_character[0].animator
	})

	return
end

function var_0_0.Flush(arg_12_0)
	return
end

function var_0_0.GetSmoothRotateObject(arg_13_0)
	return arg_13_0._tf:Find("adapt/char")
end

function var_0_0.OnCharLoaded(arg_14_0)
	arg_14_0.shipDressHelper:OnRoleLoaded(arg_14_0.role.transform)

	return
end

function var_0_0.Hide(arg_15_0)
	arg_15_0.currentChildPage:Destroy()
	arg_15_0.shipDressHelper:Destroy()
	var_0_0.super.Hide(arg_15_0)

	return
end

function var_0_0.OnDressUpDone(arg_16_0)
	arg_16_0:Hide()
	arg_16_0:ClearCharacterScene(arg_16_0.callback)

	return
end

function var_0_0.CheckDressIsDirty(arg_17_0)
	return arg_17_0.currentChildPage:CheckDressIsDirty()
end

function var_0_0.OnDestroy(arg_18_0)
	return
end

return var_0_0
