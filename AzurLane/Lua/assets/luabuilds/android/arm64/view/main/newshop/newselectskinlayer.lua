local var_0_0 = class("NewSelectSkinLayer", import(".NewSkinAtlasLayer"))

var_0_0.MODE_SELECT = 1
var_0_0.MODE_VIEW = 2

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)
	setText(arg_1_0._tf:Find("adapt/top/title/Text"), i18n("shop_new_able_to_exchange"))
	setText(arg_1_0._tf:Find("adapt/top/have/Text"), i18n("shop_new_able_to_exchange"))

	arg_1_0.msgBox = SelectSkinMsgbox.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.skins = {}

	local var_2_0 = arg_2_0.contextData.selectableSkinList or {}

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:GetTimeLimitWeight()
		local var_3_1 = arg_3_1:GetTimeLimitWeight()

		if var_3_0 == var_3_1 then
			local var_3_2 = arg_3_0:GetOwnWeight()
			local var_3_3 = arg_3_1:GetOwnWeight()

			if var_3_2 == var_3_3 then
				return arg_3_0.skinId > arg_3_1.skinId
			else
				return var_3_3 < var_3_2
			end
		else
			return var_3_1 < var_3_0
		end

		return
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.skins, iter_2_1:ToShipSkin())
	end

	arg_2_0:GetSkinClassify()

	arg_2_0.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			0
		}
	}
	arg_2_0.filterValuesTemp = Clone(arg_2_0.filterValues)

	return
end

function var_0_0.Check(arg_4_0, arg_4_1)
	local var_4_0

	if getProxy(ShipSkinProxy):hasSkin(arg_4_1.id) then
		do return end

		var_4_0 = {
			content = i18n("skin_exchange_confirm", Item.getConfigData(arg_4_0.contextData.itemId).name, arg_4_1.skinName)
		}
	end

	;({
		count = 1,
		type = DROP_TYPE_ITEM
	}).id = arg_4_0.contextData.itemId
	var_4_0.leftDrop = {
		count = 1,
		type = DROP_TYPE_ITEM
	}
	var_4_0.rightDrop = {
		count = 1,
		type = DROP_TYPE_SKIN,
		id = arg_4_1.id
	}

	function var_4_0.onYes()
		arg_4_0.contextData.OnConfirm(arg_4_1.id)
		arg_4_0:closeView()

		return
	end

	arg_4_0.msgBox:ExecuteAction("Show", var_4_0)

	return
end

function var_0_0.ClickTrigger(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.contextData.mode == var_0_0.MODE_VIEW then
		return
	end

	arg_6_0:Check(arg_6_1.skin)

	return
end

function var_0_0.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	TweenItemAlphaAndWhite(arg_7_2)

	arg_7_1 = arg_7_1 + 1

	local var_7_0 = arg_7_0.scrollDisplays[arg_7_1]

	if arg_7_0.goDic[arg_7_2] and arg_7_0.goDic[arg_7_2] ~= arg_7_1 then
		local var_7_1 = arg_7_0:GetDisplayIndex(arg_7_0.scrollShowClassifyIds[arg_7_0.goDic[arg_7_2]])

		arg_7_0:ReturnIndex(arg_7_0.goDic[arg_7_2])

		if var_7_1 ~= arg_7_0:GetDisplayIndex(arg_7_0.scrollShowClassifyIds[arg_7_0.goDic[arg_7_2]]) then
			table.insert({}, var_7_1)
			table.insert({}, arg_7_0:GetDisplayIndex(arg_7_0.scrollShowClassifyIds[arg_7_0.goDic[arg_7_2]]))
			arg_7_0:ChangeClassifyName({})
		end
	end

	arg_7_0.goDic[arg_7_2] = arg_7_1

	local var_7_2 = arg_7_0:GetDisplayIndex(arg_7_0.scrollShowClassifyIds[arg_7_1])

	arg_7_0:RegisterIndex(arg_7_1)

	if var_7_2 ~= arg_7_0:GetDisplayIndex(arg_7_0.scrollShowClassifyIds[arg_7_1]) then
		table.insert({}, var_7_2)
	end

	table.insert({}, arg_7_1)
	arg_7_0:ChangeClassifyName({})

	if arg_7_0.scrollDisplays[arg_7_1] then
		local var_7_3 = UIItemList.New(tf(arg_7_2):Find("skins"), tf(arg_7_2):Find("skins/SkinAtlasCard"))

		var_7_3:make(function(arg_8_0, arg_8_1, arg_8_2)
			if arg_8_0 == UIItemList.EventUpdate then
				local var_8_0 = var_7_0[arg_8_1 + 1]
				local var_8_1 = SkinAtlasCard.New(arg_8_2)

				table.insert(arg_7_0.cards, var_8_1)
				var_8_1:Update(var_7_0[arg_8_1 + 1], arg_8_1 + 1, true)
				onButton(arg_7_0, arg_8_2, function()
					arg_7_0:ClickTrigger(var_8_1, var_8_0)

					return
				end, SFX_PANEL)
				onButton(arg_7_0, var_8_1.changeSkinUI, function()
					var_8_1:changeSkinNext()

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_7_3:align(#arg_7_0.scrollDisplays[arg_7_1])
	end

	return
end

function var_0_0.willExit(arg_11_0)
	var_0_0.super.willExit(arg_11_0)
	arg_11_0.msgBox:Destroy()

	return
end

return var_0_0
