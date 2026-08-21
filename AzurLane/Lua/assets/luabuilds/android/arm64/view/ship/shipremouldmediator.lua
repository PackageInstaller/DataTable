local var_0_0 = class("ShipRemouldMediator", import("..base.ContextMediator"))

var_0_0.REMOULD_SHIP = "ShipRemouldMediator:REMOULD_SHIP"
var_0_0.ON_SELECTE_SHIP = "ShipRemouldMediator:ON_SELECTE_SHIP"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(BayProxy)

	arg_1_0.viewComponent:setShipVO((getProxy(BayProxy):getShipById(arg_1_0.contextData.shipId)))
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	arg_1_0.bagProxy = getProxy(BagProxy)

	arg_1_0.viewComponent:setItems(arg_1_0.bagProxy:getData())
	arg_1_0:bind(var_0_0.REMOULD_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_1_0.contextData.materialShipIds and #arg_1_0.contextData.materialShipIds > 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("remould_ship_count_more"))

			return
		end

		;({
			shipId = arg_2_1,
			remouldId = arg_2_2
		}).materialIds = arg_1_0.contextData.materialShipIds or {}

		var_2_0(arg_1_0, GAME.REMOULD_SHIP, {
			shipId = arg_2_1,
			remouldId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECTE_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = var_1_0:getUpgradeShips(arg_3_1)
		local var_3_1 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_3, underscore.map(var_3_0, function(arg_4_0)
			return arg_4_0.id
		end))

		table.insert(var_3_1, arg_3_1.id)

		;({
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}).selectedIds = arg_1_0.contextData.materialShipIds or {}
		;({
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}).onShip = function(arg_5_0, arg_5_1)
			if arg_5_0:getFlag("inAdmiral") then
				local var_5_1 = i18n("confirm_unlock_ship_main")

				return
			elseif arg_5_0:GetLockState() == Ship.LOCK_STATE_LOCK then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					yseBtnLetf = true,
					content = i18n("confirm_unlock_lv", "Lv." .. arg_5_0.level, arg_5_0:getName()),
					onYes = function()
						pg.m02:sendNotification(GAME.UPDATE_LOCK, {
							ship_id_list = {
								arg_5_0.id
							},
							is_locked = Ship.LOCK_STATE_UNLOCK
						})

						return
					end,
					yesText = i18n("msgbox_text_unlock")
				})

				return false, nil
			else
				return ShipStatus.canDestroyShip(arg_5_0, arg_5_1)
			end

			return
		end
		;({
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}).onSelected = function(arg_7_0)
			arg_1_0.contextData.materialShipIds = arg_7_0

			return
		end
		;({
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}).mode = DockyardScene.MODE_REMOULD
		;({
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}).hideTagFlags = ShipStatus.TAG_HIDE_DESTROY

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		GAME.REMOULD_SHIP_DONE,
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.REMOULD_SHIP_DONE then
		arg_9_0.viewComponent:setShipVO(var_9_1.ship)
		arg_9_0.viewComponent:updateLines()

		if #var_9_1.awards ~= 0 then
			arg_9_0:addSubLayers(Context.New({
				mediator = NewShipMediator,
				viewComponent = NewShipLayer,
				data = {
					fromRemould = true,
					ship = var_9_1.ship
				}
			}))
			arg_9_0.viewComponent:initShipModel()
		end

		arg_9_0.contextData.materialShipIds = nil

		pg.TipsMgr.GetInstance():ShowTips(i18n("remould_ship_ok"))
	elseif var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == BagProxy.ITEM_UPDATED then
		arg_9_0.viewComponent:setItems(arg_9_0.bagProxy:getData())
	end

	return
end

return var_0_0
