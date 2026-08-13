class = var_0_10000

local var_0_0 = "ShipRemouldMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.REMOULD_SHIP = "ShipRemouldMediator:REMOULD_SHIP"
var_0_1.ON_SELECTE_SHIP = "ShipRemouldMediator:ON_SELECTE_SHIP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getShipById(var_1_0, arg_1_0.contextData.shipId)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setShipVO(var_1_2, var_1_1)

	getProxy = var_3
	PlayerProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = var_3.getData(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_5.setPlayer(var_1_5, var_1_4)

	getProxy = var_5
	BagProxy = var_1_5
	arg_1_0.bagProxy = var_5(var_1_5)

	local var_1_6 = arg_1_0.viewComponent
	local var_1_7 = var_5.setItems
	local var_1_8 = arg_1_0.bagProxy

	var_1_7(var_1_6, var_8.getData(var_1_8))
	arg_1_0:bind(var_0_1.REMOULD_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_1_0.contextData.materialShipIds and #arg_1_0.contextData.materialShipIds > 1 then
			pg = var_4

			local var_2_0 = var_4.TipsMgr.GetInstance()
			local var_2_1 = var_4.ShowTips

			i18n = var_2_10007

			var_2_1(var_2_0, var_2_10007("remould_ship_count_more"))

			return
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_4.sendNotification

		GAME = var_2_10007

		local var_2_4 = var_2_10007.REMOULD_SHIP
		local var_2_5 = {
			shipId = arg_2_1,
			remouldId = arg_2_2
		}
		local var_2_6

		if not arg_1_0.contextData.materialShipIds then
			var_2_6 = {}
		end

		var_2_5.materialIds = var_2_6

		var_2_3(var_2_2, var_2_4, var_2_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECTE_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = var_0
		local var_3_1 = var_2.getUpgradeShips(var_3_0, arg_3_1)

		pg = var_2_10003

		local var_3_2 = var_2_10003.ShipFlagMgr.GetInstance()
		local var_3_3 = var_3.FilterShips

		ShipStatus = var_2_10006

		local var_3_4 = var_2_10006.FILTER_SHIPS_FLAGS_3

		underscore = var_2_10007

		local var_3_5 = var_3_3(var_3_2, var_3_4, var_2_10007.map(var_3_1, function(arg_4_0)
			return arg_4_0.id
		end))

		table = var_3_0

		var_3_0.insert(var_3_5, arg_3_1.id)

		local var_3_6 = arg_1_0
		local var_3_7 = var_4.sendNotification

		GAME = var_7

		local var_3_8 = var_7.GO_SCENE

		SCENE = var_2_10008

		local var_3_9 = var_2_10008.DOCKYARD
		local var_3_10 = {
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_1,
			ignoredIds = var_3_5
		}
		local var_3_11

		if not arg_1_0.contextData.materialShipIds then
			var_3_11 = {}
		end

		var_3_10.selectedIds = var_3_11

		function var_3_10.onShip(arg_5_0, arg_5_1)
			if arg_5_0:getFlag("inAdmiral") then
				local var_5_0 = false

				i18n = var_3_10003
				var_3_10003 = var_3_10003("confirm_unlock_ship_main")

				return
			else
				local var_5_1 = arg_5_0:GetLockState()

				Ship = var_3_10003

				if var_5_1 == var_3_10003.LOCK_STATE_LOCK then
					pg = var_5_1

					local var_5_2 = var_5_1.MsgboxMgr.GetInstance()

					var_5_1 = var_5_1.ShowMsgBox

					local var_5_3 = {
						yseBtnLetf = true
					}

					i18n = var_3_10006
					var_5_3.content = var_3_10006("confirm_unlock_lv", "Lv." .. arg_5_0.level, arg_5_0:getName())

					function var_5_3.onYes()
						pg = var_4_10000

						local var_6_0 = var_4_10000.m02
						local var_6_1 = var_0.sendNotification

						GAME = var_4_10003

						local var_6_2 = var_4_10003.UPDATE_LOCK
						local var_6_3 = {
							ship_id_list = {
								arg_5_0.id
							}
						}

						Ship = var_5
						var_6_3.is_locked = var_5.LOCK_STATE_UNLOCK

						var_6_1(var_6_0, var_6_2, var_6_3)

						return
					end

					i18n = var_6
					var_5_3.yesText = var_6("msgbox_text_unlock")

					var_5_1(var_5_2, var_5_3)

					return false, nil
				else
					ShipStatus = var_5_1

					return var_5_1.canDestroyShip(arg_5_0, arg_5_1)
				end
			end

			return
		end

		function var_3_10.onSelected(arg_7_0)
			arg_1_0.contextData.materialShipIds = arg_7_0

			return
		end

		DockyardScene = var_10
		var_3_10.mode = var_10.MODE_REMOULD
		ShipStatus = var_10
		var_3_10.hideTagFlags = var_10.TAG_HIDE_DESTROY

		var_3_7(var_3_6, var_3_8, var_3_9, var_3_10)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.REMOULD_SHIP_DONE
	PlayerProxy = var_2
	var_8_0[2] = var_2.UPDATED
	BagProxy = var_2
	var_8_0[3] = var_2.ITEM_UPDATED

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	local var_9_6

	if var_9_1 == var_9_0.REMOULD_SHIP_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_9_6.setShipVO(var_9_3, var_9_2.ship)

		local var_9_4 = arg_9_0.viewComponent

		var_9_6.updateLines(var_9_4)

		local var_9_7

		if #var_9_2.awards ~= 0 then
			local var_9_5 = arg_9_0

			var_9_6 = arg_9_0.addSubLayers
			Context = var_9_7
			var_9_7 = var_9_7.New

			local var_9_8 = {}

			NewShipMediator = var_1_10010
			var_9_8.mediator = var_1_10010
			NewShipLayer = var_1_10010
			var_9_8.viewComponent = var_1_10010
			var_9_8.data = {
				fromRemould = true,
				ship = var_9_2.ship
			}

			var_9_6(var_9_5, var_9_7(var_9_8))

			local var_9_9 = arg_9_0.viewComponent

			var_9_6.initShipModel(var_9_9)
		end

		var_9_6 = arg_9_0.contextData
		var_9_6.materialShipIds = nil
		pg = var_9_6

		local var_9_10 = var_9_6.TipsMgr.GetInstance()

		var_9_6 = var_9_6.ShowTips
		i18n = var_9_7

		var_9_6(var_9_10, var_9_7("remould_ship_ok"))
	else
		PlayerProxy = var_9_6

		if var_9_1 == var_9_6.UPDATED then
			local var_9_11 = arg_9_0.viewComponent

			var_4.setPlayer(var_9_11, var_9_2)
		else
			BagProxy = var_4

			if var_9_1 == var_4.ITEM_UPDATED then
				local var_9_12 = arg_9_0.viewComponent
				local var_9_13 = var_4.setItems
				local var_9_14 = arg_9_0.bagProxy

				var_9_13(var_9_12, var_7.getData(var_9_14))
			end
		end
	end

	return
end

return var_0_1
