class = var_0_10000

local var_0_0 = "SwitchSkinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.setShip(arg_1_0, arg_1_1)
	arg_1_0.shipVO = arg_1_1

	return
end

function var_0_1.GetShareSkins(arg_2_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.GetShareSkinsForShip(var_2_0, arg_2_0.shipVO)

	_ = var_2_0

	return (var_2_0.map(var_2_1, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.ship_skin_template[arg_3_0.id]
	end))
end

function var_0_1.setSkinList(arg_4_0, arg_4_1)
	arg_4_0.skinList = arg_4_1
	arg_4_0.skins = arg_4_0:getGroupSkinList(arg_4_0.shipVO.groupId)
	arg_4_0.shareSkins = arg_4_0:GetShareSkins()

	return
end

function var_0_1.getUIName(arg_5_0)
	return "SwitchSkinLayer"
end

function var_0_1.back(arg_6_0)
	arg_6_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.shareBtn = var_1.Find(var_7_0, "select_skin/share_btn")

	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:initSelectSkinPanel()

	triggerToggle = var_1

	var_1(arg_8_0.shareBtn, false)

	setActive = var_1

	var_1(arg_8_0.shareBtn, #arg_8_0.shareSkins > 0)

	setText = var_1
	findTF = var_2

	local var_8_0 = var_2(arg_8_0._tf, "select_skin/title/Text")

	i18n = var_3

	var_1(var_8_0, var_3("dorm3d_clothing_choose"))

	return
end

function var_0_1.initSelectSkinPanel(arg_9_0)
	arg_9_0.skinPanel = arg_9_0._tf

	local var_9_0 = arg_9_0.skinPanel
	local var_9_1 = var_1.Find(var_9_0, "select_skin/btnBack")
	local var_9_2 = arg_9_0.skinPanel
	local var_9_3 = var_2.Find(var_9_2, "print")

	onButton = var_9_2

	var_9_2(arg_9_0, var_9_1, function()
		local var_10_0 = arg_9_0

		var_0.back(var_10_0)

		return
	end)

	onButton = var_9_2

	var_9_2(arg_9_0, var_9_3, function()
		local var_11_0 = arg_9_0

		var_0.back(var_11_0)

		return
	end)

	onToggle = var_9_2

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.shareBtn

	local function var_9_6(arg_12_0)
		if arg_12_0 then
			local var_12_0 = arg_9_0

			var_1.Flush(var_12_0, arg_9_0.shareSkins)
		else
			local var_12_1 = arg_9_0

			var_1.Flush(var_12_1, arg_9_0.skins)
		end

		arg_9_0.shareOn = arg_12_0

		return
	end

	SFX_PANEL = var_1_10007

	var_9_2(var_9_4, var_9_5, var_9_6, var_1_10007)

	local var_9_7 = arg_9_0.skinPanel

	arg_9_0.skinScroll = var_3.Find(var_9_7, "select_skin/style_scroll")

	local var_9_8 = arg_9_0.skinScroll

	arg_9_0.skinContainer = var_3.Find(var_9_8, "view_port")

	local var_9_9 = arg_9_0.skinContainer

	arg_9_0.skinCard = var_3.GetChild(var_9_9, 0)
	setActive = var_3

	var_3(arg_9_0.skinCard, false)

	arg_9_0.skinCardMap = {}

	return
end

function var_0_1.openSelectSkinPanel(arg_13_0)
	if arg_13_0.shareOn then
		arg_13_0:Flush(arg_13_0.shareSkins)
	else
		arg_13_0:Flush(arg_13_0.skins)
	end

	return
end

function var_0_1.Flush(arg_14_0, arg_14_1)
	for iter_14_0 = arg_14_0.skinContainer.childCount, #arg_14_1 - 1 do
		cloneTplTo = var_1_10006

		var_1_10006(arg_14_0.skinCard, arg_14_0.skinContainer)
	end

	for iter_14_1 = #arg_14_1, arg_14_0.skinContainer.childCount - 1 do
		setActive = var_1_10006

		local var_14_0 = arg_14_0.skinContainer

		var_1_10006(var_7.GetChild(var_14_0, iter_14_1), false)
	end

	getProxy = var_2
	ShipSkinProxy = var_3

	local var_14_1 = var_2(var_3)
	local var_14_2 = arg_14_0.skinContainer.childCount

	ipairs = var_4

	for iter_14_2, iter_14_3 in var_4(arg_14_1) do
		local var_14_3 = arg_14_0.skinContainer
		local var_14_4 = var_9.GetChild(var_14_3, iter_14_2 - 1)
		local var_14_5

		if not arg_14_0.skinCardMap[var_14_4] then
			ShipSkinCard = var_11
			var_14_5 = var_11.New(var_14_4.gameObject)
			arg_14_0.skinCardMap[var_14_4] = var_14_5
		end

		local var_14_6 = arg_14_0.shipVO
		local var_14_8

		if var_11.getRemouldSkinId(var_14_6) == iter_14_3.id then
			local var_14_7 = arg_14_0.shipVO

			var_14_8 = var_11.isRemoulded(var_14_7)
		else
			var_14_8 = false
		end

		if false then
			var_14_8 = true
		end

		local var_14_9 = arg_14_0.shipVO
		local var_14_10

		if not var_12.proposeSkinOwned(var_14_9, iter_14_3) then
			table = var_14_10

			if not var_14_10.contains(arg_14_0.skinList, iter_14_3.id) and not var_14_8 then
				::label_14_0::

				var_14_10 = iter_14_3.skin_type
				ShipSkin = var_13
				var_14_10 = var_14_10 == var_13.SKIN_TYPE_OLD or var_14_1:hasSkin(iter_14_3.id)
			end
		end

		var_14_5:updateData(arg_14_0.shipVO, iter_14_3, var_14_10)

		local var_14_11 = arg_14_0.shipVO
		local var_14_12 = var_13.useSkin(var_14_11, iter_14_3.id)

		var_14_5:updateUsing(var_14_12)

		removeOnButton = var_14

		var_14(var_14_4)

		local var_14_13 = arg_14_0.shipVO
		local var_14_15

		if var_14.getRemouldSkinId(var_14_13) == iter_14_3.id then
			local var_14_14 = arg_14_0.shipVO

			var_14_15 = var_14.isRemoulded(var_14_14)
		else
			var_14_15 = false
		end

		if false then
			var_14_15 = true
		end

		local var_14_16 = arg_14_0.shipVO

		if not var_15.proposeSkinOwned(var_14_16, iter_14_3) then
			table = var_15

			local var_14_17

			if var_15.contains(arg_14_0.skinList, iter_14_3.id) or var_14_15 then
				var_14_17 = 1
			else
				var_14_17 = 0
			end

			local var_14_18 = iter_14_3.shop_id

			if 0 < var_14_18 then
				pg = var_14_18

				local var_14_19

				if not var_14_18.shop_template[iter_14_3.shop_id] then
					var_14_19 = nil
				end

				local var_14_21

				if var_14_19 then
					::label_14_1::

					pg = var_14_21

					local var_14_20 = var_14_21.TimeMgr.GetInstance()

					var_14_21 = not var_14_21.inTime(var_14_20, var_14_19.time)
				end

				local var_14_22 = iter_14_3.id
				local var_14_23 = arg_14_0.shipVO
				local var_14_24 = var_14_22 == var_19.getSkinId(var_14_23)
				local var_14_25 = iter_14_3.id
				local var_14_26 = arg_14_0.shipVO
				local var_14_28, var_14_29

				if var_14_25 ~= var_20.getConfig(var_14_26, "skin_id") and not (var_14_17 >= 1) then
					local var_14_27 = iter_14_3.skin_type

					ShipSkin = var_14_28

					if var_14_27 ~= var_14_28.SKIN_TYPE_OLD then
						var_14_28 = var_14_1
						var_14_29 = var_14_1.hasSkin(var_14_28, iter_14_3.id)

						if false then
							var_14_29 = false
						end

						goto label_14_2
					end
				end

				var_14_29 = true

				::label_14_2::

				getProxy = var_14_28
				ShipSkinProxy = var_14_26

				local var_14_30 = var_14_28(var_14_26)
				local var_14_31 = var_20.InForbiddenSkinListAndShow(var_14_30, iter_14_3.id)

				onToggle = var_14_30

				local var_14_32 = arg_14_0
				local var_14_33 = var_14_5.hideObjToggleTF

				local function var_14_34(arg_15_0)
					PlayerPrefs = var_2_10001

					var_2_10001.SetInt("paint_hide_other_obj_" .. var_14_5.paintingName, arg_15_0 and 1 or 0)

					local var_15_0 = var_14_5

					var_1.flushSkin(var_15_0)

					local var_15_1 = arg_14_0
					local var_15_2 = var_1.emit

					SwitchSkinMediator = var_3

					local var_15_3 = var_3.UPDATE_SKINCONFIG
					local var_15_4 = arg_14_0.shipVO

					var_15_2(var_15_1, var_15_3, var_4.getSkinId(var_15_4))

					return
				end

				SFX_PANEL = var_1_10025

				var_14_30(var_14_32, var_14_33, var_14_34, var_1_10025)

				onButton = var_14_30

				local var_14_35 = arg_14_0
				local var_14_36 = var_14_5.changeSkinTF

				local function var_14_37(arg_16_0)
					ShipSkin = var_2_10001

					local var_16_0 = var_2_10001.GetChangeSkinNextId(iter_14_3.id)

					ShipSkin = var_2

					local var_16_1 = var_2.SetStoreChangeSkinId
					local var_16_2 = var_16_0
					local var_16_3 = arg_14_0.shipVO

					var_16_1(var_16_2, var_4.GetShipPhantomMark(var_16_3))

					if var_14_12 then
						local var_16_4 = arg_14_0
						local var_16_5 = var_2.emit

						SwitchSkinMediator = var_4

						local var_16_6 = var_4.CHANGE_SKIN
						local var_16_7 = arg_14_0.shipVO

						var_16_5(var_16_4, var_16_6, var_5.GetShipPhantomMark(var_16_7), var_16_0)

						pg = var_16_5

						local var_16_8 = var_16_5.m02
						local var_16_9 = var_2.sendNotification

						GAME = var_16_6

						local var_16_10 = var_16_6.CHANGE_SKIN_UPDATE
						local var_16_11 = arg_14_0.shipVO

						var_16_9(var_16_8, var_16_10, var_5.GetShipPhantomMark(var_16_11))
					end

					return
				end

				SFX_PANEL = var_1_10025

				var_14_30(var_14_35, var_14_36, var_14_37, var_1_10025)

				onButton = var_14_30

				var_14_30(arg_14_0, var_14_4, function()
					if var_14_24 then
						local var_17_0 = arg_14_0

						var_0.back(var_17_0)
					else
						ShipSkin = var_0

						if var_0.IsShareSkin(arg_14_0.shipVO, iter_14_3.id) then
							ShipSkin = var_0

							if not var_0.CanUseShareSkinForShip(arg_14_0.shipVO, iter_14_3.id) then
								goto label_17_0
							end
						end

						local var_17_3

						if var_14_29 then
							local var_17_1 = arg_14_0
							local var_17_2 = var_0.emit

							SwitchSkinMediator = var_17_3
							var_17_3 = var_17_3.CHANGE_SKIN

							local var_17_4 = arg_14_0.shipVO

							var_2_10003 = var_2_10003.GetShipPhantomMark(var_17_4)

							local var_17_5 = iter_14_3.id
							local var_17_6 = arg_14_0.shipVO

							var_17_2(var_17_1, var_17_3, var_2_10003, var_17_5 == var_5.getConfig(var_17_6, "skin_id") and 0 or iter_14_3.id)

							local var_17_7 = arg_14_0

							var_0.back(var_17_7)
						elseif var_14_19 then
							local var_17_9

							if var_14_21 or var_14_31 then
								pg = var_17_9

								local var_17_8 = var_17_9.TipsMgr.GetInstance()

								var_17_9 = var_17_9.ShowTips
								i18n = var_17_3

								var_17_9(var_17_8, var_17_3("common_skin_out_of_stock"))
							else
								Goods = var_17_9

								local var_17_10 = var_17_9.Create
								local var_17_11 = {
									shop_id = var_14_19.id
								}

								Goods = var_2

								local var_17_12 = var_17_10(var_17_11, var_2.TYPE_SKIN)

								if var_0.isDisCount(var_17_12) and var_0:IsItemDiscountType() then
									local var_17_13 = arg_14_0
									local var_17_14 = var_1.emit

									SwitchSkinMediator = var_2_10003

									var_17_14(var_17_13, var_2_10003.BUY_ITEM_BY_ACT, var_14_19.id, 1)
								else
									local var_17_15 = var_0
									local var_17_16 = var_0.GetPrice(var_17_15)

									i18n = var_17_15

									local var_17_17 = var_17_15("text_buy_fashion_tip", var_17_16, iter_14_3.name)

									pg = var_3

									local var_17_18 = var_3.MsgboxMgr.GetInstance()

									var_3.ShowMsgBox(var_17_18, {
										content = var_17_17,
										onYes = function()
											local var_18_0 = arg_14_0
											local var_18_1 = var_0.emit

											SwitchSkinMediator = var_3_10002

											var_18_1(var_18_0, var_3_10002.BUY_ITEM, var_14_19.id, 1)

											return
										end
									})
								end
							end
						end
					end

					::label_17_0::

					return
				end)

				setActive = var_14_30

				var_14_30(var_14_4, true)
			end
		end
	end

	return
end

function var_0_1.getGroupSkinList(arg_19_0, arg_19_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_19_0 = var_1_10002(var_1_10003)

	return var_2.GetAllSkinForShip(var_19_0, arg_19_0.shipVO)
end

function var_0_1.willExit(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.skinCardMap) do
		iter_20_1:clear()
	end

	arg_20_0:UnOverlayPanel(arg_20_0._tf)

	return
end

return var_0_1
