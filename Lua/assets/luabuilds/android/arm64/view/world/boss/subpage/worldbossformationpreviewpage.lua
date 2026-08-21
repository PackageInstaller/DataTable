local var_0_0 = class("WorldBossFormationPreViewPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossFormationPreViewPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.shipList = {
		arg_2_0._tf:Find("frame/ships/1"),
		arg_2_0._tf:Find("frame/ships/2"),
		arg_2_0._tf:Find("frame/ships/3")
	}
	arg_2_0.returnBtn = arg_2_0._tf:Find("frame/return")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.returnBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0._tf:Find("frame/toggles/main"), function(arg_6_0)
		if arg_6_0 then
			arg_3_0:Switch(1)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0._tf:Find("frame/toggles/vanguard"), function(arg_7_0)
		if arg_7_0 then
			arg_3_0:Switch(2)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Switch(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.shipList) do
		arg_8_0:UpdateShip(iter_8_1, arg_8_0.ships[arg_8_1][iter_8_0])
	end

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	var_0_0.super.Show(arg_9_0)
	setParent(arg_9_0._tf, pg.UIMgr.GetInstance().UIMain)

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = iter_9_1:getTeamType()

		if var_9_0 == TeamType.Vanguard then
			table.insert({}, iter_9_1)
		elseif var_9_0 == TeamType.Main then
			table.insert({}, iter_9_1)
		end
	end

	arg_9_0.ships = {
		{},
		{}
	}

	triggerToggle(arg_9_0._tf:Find("frame/toggles/main"), true)

	return
end

function var_0_0.OnHide(arg_10_0)
	var_0_0.super.OnHide(arg_10_0)

	return
end

function var_0_0.UpdateShip(arg_11_0, arg_11_1, arg_11_2)
	local var_11_9000
	local var_11_0 = arg_11_1:Find("bg/info")

	setActive(var_11_0, arg_11_2)

	if arg_11_2 then
		local var_11_1 = var_11_0:Find("ship_type")
		local var_11_2 = UIItemList.New(var_11_0:Find("stars"), var_11_0:Find("stars/star_tpl"))

		var_11_0:Find("name"):GetComponent(typeof(Text)).text = shortenString(arg_11_2:getName(), 6)
		var_11_1.GetComponent(var_11_9000, typeof(Image)).sprite = GetSpriteFromAtlas("shiptype", shipType2print(pg.ship_data_statistics[arg_11_2.configId].type))

		local var_11_3 = arg_11_2:getStar()

		var_11_2:make(function(arg_12_0, arg_12_1, arg_12_2)
			if arg_12_0 == UIItemList.EventUpdate then
				setActive(arg_12_2:Find("star_tpl"), arg_12_1 <= var_11_3)
			end

			return
		end)
		var_11_2:align((arg_11_2:getMaxStar()))

		var_11_0:Find("lv").GetComponent(var_11_1, typeof(Text)).text = "Lv." .. arg_11_2.level
		var_11_0:Find("mask/icon"):GetComponent(typeof(Image)).sprite = LoadSprite("HeroHrzIcon/" .. arg_11_2:getPainting())
	end

	local var_11_4 = arg_11_1:Find("bg/line")

	var_11_4.sizeDelta = arg_11_2 and Vector2(235, 2) or Vector2(461, 2)

	arg_11_0:UpdateEquipments(var_11_0, arg_11_2)

	return
end

function var_0_0.UpdateEquipments(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = UIItemList.New(arg_13_1.parent:Find("equipemtns"), arg_13_1.parent:Find("equipemtns/equipment_tpl"))
	local var_13_1 = arg_13_2 and arg_13_2:getActiveEquipments() or {}

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_13_1[arg_14_1 + 1]

			setActive(arg_14_2:Find("info"), var_13_1[arg_14_1 + 1])
			setActive(arg_14_2:Find("empty"), not var_13_1[arg_14_1 + 1])

			if var_13_1[arg_14_1 + 1] then
				updateEquipment(arg_14_2:Find("info"), var_13_1[arg_14_1 + 1])
				onButton(arg_13_0, arg_14_2, function()
					arg_13_0:emit(BaseUI.ON_EQUIPMENT, {
						type = EquipmentInfoMediator.TYPE_DISPLAY,
						equipment = var_14_0
					})

					return
				end, SFX_PANEL)
			else
				removeOnButton(arg_14_2)
			end
		end

		return
	end)
	var_13_0:align(5)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

return var_0_0
