local var_0_0 = class("SelectSkinLayer", import(".SkinAtlasScene"))

var_0_0.MODE_SELECT = 1
var_0_0.MODE_VIEW = 2

function var_0_0.getUIName(arg_1_0)
	return "SelectSkinUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_2_0._tf)

	arg_2_0.msgBox = SelectSkinMsgbox.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	return
end

function var_0_0.GetSkinList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.contextData.selectableSkinList or {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = iter_4_1:ToShipSkin()

		if (arg_4_1 == var_0_0.PAGE_ALL or var_4_2:IsType(arg_4_1)) and not var_4_2:IsDefault() and var_4_2:IsMatchKey(arg_4_2) and arg_4_0:MatchIndex(var_4_2) then
			table.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_1
end

function var_0_0.SortDisplay(arg_5_0, arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:GetTimeLimitWeight()
		local var_6_1 = arg_6_1:GetTimeLimitWeight()

		if var_6_0 == var_6_1 then
			local var_6_2 = arg_6_0:GetOwnWeight()
			local var_6_3 = arg_6_1:GetOwnWeight()

			if var_6_2 == var_6_3 then
				return arg_6_0.skinId > arg_6_1.skinId
			else
				return var_6_3 < var_6_2
			end
		else
			return var_6_1 < var_6_0
		end

		return
	end)

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	local var_7_0 = SelectSkinCard.New(arg_7_1)

	onButton(arg_7_0, var_7_0._tf, function()
		if arg_7_0.contextData.mode == var_0_0.MODE_VIEW then
			return
		end

		arg_7_0:Check(var_7_0.skin)

		return
	end, SFX_PANEL)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_0.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.cards[arg_9_2] then
		arg_9_0:OnInitItem(arg_9_2)
	end

	arg_9_0.cards[arg_9_2]:Update(arg_9_0.displays[arg_9_1 + 1]:ToShipSkin(), arg_9_1 + 1, arg_9_0.displays[arg_9_1 + 1]:IsTimeLimit(), arg_9_0.displays[arg_9_1 + 1]:OwnSkin())

	return
end

function var_0_0.Check(arg_10_0, arg_10_1)
	local var_10_0

	if getProxy(ShipSkinProxy):hasSkin(arg_10_1.id) then
		do return end

		var_10_0 = {
			content = i18n("skin_exchange_confirm", Item.getConfigData(arg_10_0.contextData.itemId).name, arg_10_1.skinName)
		}
	end

	;({
		count = 1,
		type = DROP_TYPE_ITEM
	}).id = arg_10_0.contextData.itemId
	var_10_0.leftDrop = {
		count = 1,
		type = DROP_TYPE_ITEM
	}
	var_10_0.rightDrop = {
		count = 1,
		type = DROP_TYPE_SKIN,
		id = arg_10_1.id
	}

	function var_10_0.onYes()
		arg_10_0.contextData.OnConfirm(arg_10_1.id)
		arg_10_0:closeView()

		return
	end

	arg_10_0.msgBox:ExecuteAction("Show", var_10_0)

	return
end

function var_0_0.willExit(arg_12_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)
	arg_12_0.msgBox:Destroy()
	var_0_0.super.willExit(arg_12_0)

	return
end

return var_0_0
