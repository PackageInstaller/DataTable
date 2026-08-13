class = var_0_10000

local var_0_0 = "ShipUpgradeMediator2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.UPGRADE_SHIP = "ShipUpgradeMediator2:UPGRADE_SHIP"
var_0_1.ON_SELECT_SHIP = "ShipUpgradeMediator2:ON_SELECT_SHIP"
var_0_1.NEXTSHIP = "ShipUpgradeMediator2:NEXTSHIP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	getProxy = var_3
	BagProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_4.setItems(var_1_4, var_1_3:getData())

	getProxy = var_4
	BayProxy = var_1_4

	local var_1_5 = var_4(var_1_4)
	local var_1_6 = var_4.getShipById(var_1_5, arg_1_0.contextData.shipId)
	local var_1_7 = arg_1_0.viewComponent

	var_6.setShip(var_1_7, var_1_6)
	arg_1_0:bind(var_0_1.UPGRADE_SHIP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.UPGRADE_STAR, {
			shipId = arg_1_0.contextData.shipId,
			shipIds = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = var_0
		local var_3_1 = var_3.getUpgradeShips(var_3_0, arg_3_1)

		pg = var_2_10004

		local var_3_2 = var_2_10004.ShipFlagMgr.GetInstance()
		local var_3_3 = var_4.FilterShips

		ShipStatus = var_2_10007

		local var_3_4 = var_2_10007.FILTER_SHIPS_FLAGS_3

		underscore = var_2_10008

		local var_3_5 = var_3_3(var_3_2, var_3_4, var_2_10008.map(var_3_1, function(arg_4_0)
			return arg_4_0.id
		end))

		table = var_3_0

		var_3_0.insert(var_3_5, arg_3_1.id)

		local var_3_6 = arg_1_0
		local var_3_7 = var_5.sendNotification

		GAME = var_8

		local var_3_8 = var_8.GO_SCENE

		SCENE = var_2_10009

		local var_3_9 = var_2_10009.DOCKYARD
		local var_3_10 = {
			destroyCheck = true
		}

		i18n = var_11
		var_3_10.leftTopInfo = var_11("word_upgrade")
		DockyardScene = var_11
		var_3_10.mode = var_11.MODE_UPGRADE
		var_3_10.selectedMax = arg_3_2 or 1
		var_3_10.selectedMin = arg_3_2 or 1
		var_3_10.shipVOs = var_3_1
		var_3_10.ignoredIds = var_3_5

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

		ShipStatus = var_11
		var_3_10.hideTagFlags = var_11.TAG_HIDE_DESTROY

		var_3_7(var_3_6, var_3_8, var_3_9, var_3_10)

		return
	end)
	arg_1_0:bind(var_0_1.NEXTSHIP, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0

		var_2.sendNotification(var_8_0, var_0_1.NEXTSHIP, arg_8_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.UPGRADE_STAR_DONE
	BagProxy = var_2
	var_9_0[2] = var_2.ITEM_UPDATED
	BayProxy = var_2
	var_9_0[3] = var_2.SHIP_REMOVED
	PlayerProxy = var_2
	var_9_0[4] = var_2.UPDATED

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.getName(var_10_0)
	local var_10_2 = arg_10_1:getBody()

	PlayerProxy = var_10_0

	if var_10_1 == var_10_0.UPDATED then
		var_1_10006 = arg_10_0.viewComponent

		var_4.setPlayer(var_1_10006, var_10_2)
	else
		GAME = var_4

		local var_10_3

		if var_10_1 == var_4.UPGRADE_STAR_DONE then
			var_10_3 = arg_10_0.contextData
			var_10_3.materialShipIds = nil
			var_1_10006 = arg_10_0.viewComponent

			var_10_3.setShip(var_1_10006, var_10_2.newShip)

			var_1_10006 = arg_10_0.viewComponent

			var_10_3.updateStagesScrollView(var_1_10006)

			var_1_10006 = arg_10_0
			var_10_3 = arg_10_0.addSubLayers
			Context = var_7

			local var_10_4 = var_7.New
			local var_10_5 = {}

			ShipBreakResultLayer = var_1_10010
			var_10_5.viewComponent = var_1_10010
			ShipBreakResultMediator = var_1_10010
			var_10_5.mediator = var_1_10010
			var_10_5.data = {
				newShip = var_10_2.newShip,
				oldShip = var_10_2.oldShip
			}

			var_10_3(var_1_10006, var_10_4(var_10_5))
		else
			BagProxy = var_10_3

			if var_10_1 == var_10_3.ITEM_UPDATED then
				getProxy = var_4
				BagProxy = var_1_10006

				local var_10_6 = var_4(var_1_10006)
				local var_10_7 = arg_10_0.viewComponent

				var_5.setItems(var_10_7, var_10_6:getRawData())
			end
		end
	end

	return
end

return var_0_1
