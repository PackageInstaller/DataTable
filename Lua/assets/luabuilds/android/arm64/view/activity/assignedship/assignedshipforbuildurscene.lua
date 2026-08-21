local var_0_0 = class("AssignedShipForBuildURScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AssignedShipBuildURUI"
end

function var_0_0.setItemVO(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1

	return
end

function var_0_0.preload(arg_3_0, arg_3_1)
	arg_3_0.shipUsageDic = {}
	arg_3_0.ids = underscore.map(arg_3_0.contextData.itemVO:getConfig("usage_arg"), function(arg_4_0)
		arg_3_0.shipUsageDic[pg.item_usage_invitation[arg_4_0].ship_id] = arg_4_0

		return pg.item_usage_invitation[arg_4_0].ship_id
	end)
	arg_3_0.iconSprites = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.ids) do
		table.insert({}, function(arg_5_0)
			GetSpriteFromAtlasAsync("RegularExchangeIcon", tostring(iter_3_1), function(arg_6_0)
				arg_3_0.iconSprites[iter_3_1] = arg_6_0

				arg_5_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_3_1)

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.backBtn = arg_7_0._tf:Find("top/bg/btn_back")

	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:closeView()

		return
	end, SFX_CANCEL)

	local var_7_0 = arg_7_0._tf:Find("select/view/container")

	arg_7_0.iconList = UIItemList.New(var_7_0, var_7_0:Find("tpl"))

	arg_7_0.iconList:make(function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1

		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = Ship.New({
				configId = arg_7_0.ids[arg_9_1]
			})

			setImageSprite(arg_9_2:Find("Image"), arg_7_0.iconSprites[var_9_0.configId], true)
			setActive(arg_9_2:Find("noget"), not getProxy(CollectionProxy):getShipGroup(var_9_0:getGroupId()))
			onToggle(arg_7_0, arg_9_2, function(arg_10_0)
				if arg_10_0 then
					arg_7_0:setSelectedShip(var_9_0)
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_9_2, arg_9_1 == 1)
		end

		return
	end)

	arg_7_0.btnConfirm = arg_7_0._tf:Find("select/operation/confirm")

	onButton(arg_7_0, arg_7_0.btnConfirm, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("handbook_ur_double_check", arg_7_0.shipVO:getName()),
			onYes = function()
				arg_7_0:emit(AssignedShipMediator.ON_USE_ITEM, arg_7_0.itemVO.id, 1, {
					arg_7_0.shipUsageDic[arg_7_0.shipVO:GetConfigID()]
				})

				return
			end
		})

		return
	end, SFX_CONFIRM)

	arg_7_0.rtName = arg_7_0._tf:Find("select/name_bg")
	arg_7_0.rtPaint = arg_7_0._tf:Find("main/paint")

	return
end

function var_0_0.setSelectedShip(arg_13_0, arg_13_1)
	if arg_13_0.shipVO then
		retPaintingPrefab(arg_13_0.rtPaint, arg_13_0.shipVO:getPainting())
	end

	arg_13_0.shipVO = arg_13_1

	GetImageSpriteFromAtlasAsync("shiptype", ShipType.Type2BattlePrint(arg_13_1:getShipType()), arg_13_0.rtName:Find("shiptype/Image"), true)
	setText(arg_13_0.rtName:Find("name"), arg_13_1:getName())
	setText(arg_13_0.rtName:Find("english"), string.upper(arg_13_1:getConfig("english_name")))
	setPaintingPrefabAsync(arg_13_0.rtPaint, arg_13_1:getPainting(), "huode")

	return
end

function var_0_0.flush(arg_14_0)
	arg_14_0.iconList:align(#arg_14_0.ids)

	return
end

function var_0_0.didEnter(arg_15_0)
	arg_15_0:flush()

	return
end

function var_0_0.willExit(arg_16_0)
	arg_16_0.iconSprites = nil

	if arg_16_0.shipVO then
		retPaintingPrefab(arg_16_0.rtPaint, arg_16_0.shipVO:getPainting())
	end

	return
end

return var_0_0
