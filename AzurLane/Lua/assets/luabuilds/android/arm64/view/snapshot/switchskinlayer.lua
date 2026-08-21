local var_0_0 = class("SwitchSkinLayer", import("..base.BaseUI"))

function var_0_0.setShip(arg_1_0, arg_1_1)
	arg_1_0.shipVO = arg_1_1

	return
end

function var_0_0.GetShareSkins(arg_2_0)
	return (_.map(getProxy(ShipSkinProxy):GetShareSkinsForShip(arg_2_0.shipVO), function(arg_3_0)
		return pg.ship_skin_template[arg_3_0.id]
	end))
end

function var_0_0.setSkinList(arg_4_0, arg_4_1)
	arg_4_0.skinList = arg_4_1
	arg_4_0.skins = arg_4_0:getGroupSkinList(arg_4_0.shipVO.groupId)
	arg_4_0.shareSkins = arg_4_0:GetShareSkins()

	return
end

function var_0_0.getUIName(arg_5_0)
	return "SwitchSkinLayer"
end

function var_0_0.back(arg_6_0)
	arg_6_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.shareBtn = arg_7_0._tf:Find("select_skin/share_btn")

	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:initSelectSkinPanel()
	triggerToggle(arg_8_0.shareBtn, false)
	setActive(arg_8_0.shareBtn, #arg_8_0.shareSkins > 0)
	setText(findTF(arg_8_0._tf, "select_skin/title/Text"), i18n("dorm3d_clothing_choose"))

	return
end

function var_0_0.initSelectSkinPanel(arg_9_0)
	arg_9_0.skinPanel = arg_9_0._tf

	onButton(arg_9_0, arg_9_0.skinPanel:Find("select_skin/btnBack"), function()
		arg_9_0:back()

		return
	end)
	onButton(arg_9_0, arg_9_0.skinPanel:Find("print"), function()
		arg_9_0:back()

		return
	end)
	onToggle(arg_9_0, arg_9_0.shareBtn, function(arg_12_0)
		if arg_12_0 then
			arg_9_0:Flush(arg_9_0.shareSkins)
		else
			arg_9_0:Flush(arg_9_0.skins)
		end

		arg_9_0.shareOn = arg_12_0

		return
	end, SFX_PANEL)

	arg_9_0.skinScroll = arg_9_0.skinPanel:Find("select_skin/style_scroll")
	arg_9_0.skinContainer = arg_9_0.skinScroll:Find("view_port")
	arg_9_0.skinCard = arg_9_0.skinContainer:GetChild(0)

	setActive(arg_9_0.skinCard, false)

	arg_9_0.skinCardMap = {}

	return
end

function var_0_0.openSelectSkinPanel(arg_13_0)
	if arg_13_0.shareOn then
		arg_13_0:Flush(arg_13_0.shareSkins)
	else
		arg_13_0:Flush(arg_13_0.skins)
	end

	return
end

function var_0_0.Flush(arg_14_0, arg_14_1)
	for iter_14_0 = arg_14_0.skinContainer.childCount, #arg_14_1 - 1 do
		cloneTplTo(arg_14_0.skinCard, arg_14_0.skinContainer)
	end

	for iter_14_1 = #arg_14_1, arg_14_0.skinContainer.childCount - 1 do
		setActive(arg_14_0.skinContainer:GetChild(iter_14_1), false)
	end

	local var_14_0 = getProxy(ShipSkinProxy)

	for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
		local var_14_2 = arg_14_0.skinContainer:GetChild(iter_14_2 - 1)
		local var_14_3 = arg_14_0.skinCardMap[var_14_2]

		if not arg_14_0.skinCardMap[var_14_2] then
			var_14_3 = ShipSkinCard.New(var_14_2.gameObject)
			arg_14_0.skinCardMap[var_14_2] = var_14_3
		end

		local var_14_4 = arg_14_0.shipVO:getRemouldSkinId() == iter_14_3.id and arg_14_0.shipVO:isRemoulded()
		local var_14_5 = arg_14_0.shipVO:proposeSkinOwned(iter_14_3) or table.contains(arg_14_0.skinList, iter_14_3.id) or var_14_4 or iter_14_3.skin_type == ShipSkin.SKIN_TYPE_OLD or var_14_0:hasSkin(iter_14_3.id)

		var_14_3:updateData(arg_14_0.shipVO, iter_14_3, var_14_5)
		var_14_3:updateUsing((arg_14_0.shipVO:useSkin(iter_14_3.id)))
		removeOnButton(var_14_2)

		local var_14_6 = arg_14_0.shipVO:getRemouldSkinId() == iter_14_3.id and arg_14_0.shipVO:isRemoulded()
		local var_14_7 = (arg_14_0.shipVO:proposeSkinOwned(iter_14_3) or table.contains(arg_14_0.skinList, iter_14_3.id) or var_14_6) and 1 or 0

		if iter_14_3.shop_id > 0 then
			local var_14_8 = pg.shop_template[iter_14_3.shop_id] or nil
			local var_14_10

			if var_14_8 then
				::label_14_0::

				local var_14_9 = pg.TimeMgr.GetInstance()

				var_14_10 = not var_14_9:inTime(var_14_8.time)
			end

			local var_14_11 = iter_14_3.id == arg_14_0.shipVO:getSkinId()
			local var_14_12 = iter_14_3.id == arg_14_0.shipVO:getConfig("skin_id") or var_14_7 >= 1 or iter_14_3.skin_type == ShipSkin.SKIN_TYPE_OLD or var_14_0:hasSkin(iter_14_3.id)
			local var_14_13 = getProxy(ShipSkinProxy):InForbiddenSkinListAndShow(iter_14_3.id)

			onToggle(arg_14_0, var_14_3.hideObjToggleTF, function(arg_15_0)
				PlayerPrefs.SetInt("paint_hide_other_obj_" .. var_14_3.paintingName, arg_15_0 and 1 or 0)
				var_14_3:flushSkin()
				arg_14_0:emit(SwitchSkinMediator.UPDATE_SKINCONFIG, arg_14_0.shipVO:getSkinId())

				return
			end, SFX_PANEL)
			onButton(arg_14_0, var_14_3.changeSkinTF, function(arg_16_0)
				local var_16_0 = ShipSkin.GetChangeSkinNextId(iter_14_3.id)

				ShipSkin.SetStoreChangeSkinId(var_16_0, arg_14_0.shipVO:GetShipPhantomMark())

				if var_0 then
					arg_14_0:emit(SwitchSkinMediator.CHANGE_SKIN, arg_14_0.shipVO:GetShipPhantomMark(), var_16_0)
					pg.m02:sendNotification(GAME.CHANGE_SKIN_UPDATE, arg_14_0.shipVO:GetShipPhantomMark())
				end

				return
			end, SFX_PANEL)
			onButton(arg_14_0, var_14_2, function()
				if var_14_11 then
					arg_14_0:back()
				elseif ShipSkin.IsShareSkin(arg_14_0.shipVO, iter_14_3.id) and not ShipSkin.CanUseShareSkinForShip(arg_14_0.shipVO, iter_14_3.id) then
					-- block empty
				elseif var_14_12 then
					arg_14_0:emit(SwitchSkinMediator.CHANGE_SKIN, arg_14_0.shipVO:GetShipPhantomMark(), iter_14_3.id == arg_14_0.shipVO:getConfig("skin_id") and 0 or iter_14_3.id)
					arg_14_0:back()
				elseif var_14_8 then
					if var_14_10 or var_14_13 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_skin_out_of_stock"))
					else
						local var_17_0 = Goods.Create({
							shop_id = var_14_8.id
						}, Goods.TYPE_SKIN)

						if var_17_0:isDisCount() and var_17_0:IsItemDiscountType() then
							arg_14_0:emit(SwitchSkinMediator.BUY_ITEM_BY_ACT, var_14_8.id, 1)
						else
							({}).content = i18n("text_buy_fashion_tip", var_17_0:GetPrice(), iter_14_3.name)
							;({}).onYes = function()
								arg_14_0:emit(SwitchSkinMediator.BUY_ITEM, var_14_8.id, 1)

								return
							end

							pg.MsgboxMgr.GetInstance():ShowMsgBox({})
						end
					end
				end

				return
			end)
			setActive(var_14_2, true)
		end
	end

	return
end

function var_0_0.getGroupSkinList(arg_19_0, arg_19_1)
	return getProxy(ShipSkinProxy):GetAllSkinForShip(arg_19_0.shipVO)
end

function var_0_0.willExit(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.skinCardMap) do
		iter_20_1:clear()
	end

	arg_20_0:UnOverlayPanel(arg_20_0._tf)

	return
end

return var_0_0
