class = var_0_10000

local var_0_0 = "NewEducateMapMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateContextMediator"))

var_0_1.ON_SITE_NORMAL = "NewEducateMapMediator.ON_SITE_NORMAL"
var_0_1.ON_SITE_EVENT = "NewEducateMapMediator.ON_SITE_EVENT"
var_0_1.ON_SITE_SHIP = "NewEducateMapMediator.ON_SITE_SHIP"
var_0_1.ON_SHOPPING = "NewEducateMapMediator.ON_SHOPPING"
var_0_1.ON_REFRESH_SHOP = "NewEducateMapMediator.ON_REFRESH_SHOP"
var_0_1.ON_UPGRADE_NORMAL = "NewEducateMapMediator.ON_UPGRADE_NORMAL"
var_0_1.ON_SHIP_UPGRADE_LEVEL = "NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SITE_NORMAL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.NEW_EDUCATE_MAP_NORMAL, {
			id = arg_1_0.contextData.char.id,
			normalId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SITE_EVENT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.NEW_EDUCATE_MAP_EVENT, {
			id = arg_1_0.contextData.char.id,
			eventId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SITE_SHIP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.NEW_EDUCATE_MAP_SHIP, {
			id = arg_1_0.contextData.char.id,
			shipId = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.NEW_EDUCATE_SHOPPING, {
			id = arg_1_0.contextData.char.id,
			goodId = arg_5_1,
			num = arg_5_2 or 1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REFRESH_SHOP, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.NEW_EDUCATE_REFRESH_SHOP, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE_NORMAL, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		var_7_1(var_7_0, var_2_10006.NEW_EDUCATE_UPGRADE_NORMAL_SITE, {
			id = arg_1_0.contextData.char.id,
			normalId = arg_7_1,
			callback = arg_7_2
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	NewEducateProxy = var_1_10002
	var_8_0[1] = var_1_10002.RESOURCE_UPDATED
	NewEducateProxy = var_2
	var_8_0[2] = var_2.ATTR_UPDATED
	NewEducateProxy = var_2
	var_8_0[3] = var_2.PERSONALITY_UPDATED
	NewEducateProxy = var_2
	var_8_0[4] = var_2.TALENT_UPDATED
	NewEducateProxy = var_2
	var_8_0[5] = var_2.STATUS_UPDATED
	NewEducateProxy = var_2
	var_8_0[6] = var_2.TAROT_UPDATED
	GAME = var_2
	var_8_0[7] = var_2.NEW_EDUCATE_NODE_START
	GAME = var_2
	var_8_0[8] = var_2.NEW_EDUCATE_NEXT_NODE
	GAME = var_2
	var_8_0[9] = var_2.NEW_EDUCATE_SHOPPING_DONE
	GAME = var_2
	var_8_0[10] = var_2.NEW_EDUCATE_REFRESH_SHOP_DONE
	GAME = var_2
	var_8_0[11] = var_2.NEW_EDUCATE_REFRESH_DONE
	GAME = var_2
	var_8_0[12] = var_2.NEW_EDUCATE_MAP_NORMAL_DONE
	GAME = var_2
	var_8_0[13] = var_2.NEW_EDUCATE_MAP_EVENT_DONE
	GAME = var_2
	var_8_0[14] = var_2.NEW_EDUCATE_MAP_SHIP_DONE
	GAME = var_2
	var_8_0[15] = var_2.NEW_EDUCATE_CHECK_PRIORITY_FSM
	var_8_0[16] = var_0_1.ON_SHIP_UPGRADE_LEVEL

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	NewEducateProxy = var_9_0

	if var_9_1 == var_9_0.RESOURCE_UPDATED then
		local var_9_3 = arg_9_0.viewComponent

		var_4.OnResUpdate(var_9_3)
	else
		NewEducateProxy = var_4

		if var_9_1 == var_4.ATTR_UPDATED then
			local var_9_4 = arg_9_0.viewComponent

			var_4.OnAttrUpdate(var_9_4)
		else
			NewEducateProxy = var_4

			if var_9_1 == var_4.PERSONALITY_UPDATED then
				local var_9_5 = arg_9_0.viewComponent

				var_4.OnPersonalityUpdate(var_9_5, var_9_2.number, var_9_2.oldTag)
			else
				NewEducateProxy = var_4

				if var_9_1 == var_4.TALENT_UPDATED then
					local var_9_6 = arg_9_0.viewComponent

					var_4.OnTalentUpdate(var_9_6)
				else
					NewEducateProxy = var_4

					if var_9_1 == var_4.STATUS_UPDATED then
						local var_9_7 = arg_9_0.viewComponent

						var_4.OnStatusUpdate(var_9_7)
					else
						NewEducateProxy = var_4

						if var_9_1 == var_4.TAROT_UPDATED then
							local var_9_8 = arg_9_0.viewComponent

							var_4.OnTarotUpdate(var_9_8)
						else
							GAME = var_4

							if var_9_1 == var_4.NEW_EDUCATE_NODE_START then
								local var_9_9 = arg_9_0.viewComponent

								var_4.OnNodeStart(var_9_9, var_9_2.node)
							else
								GAME = var_4

								if var_9_1 == var_4.NEW_EDUCATE_NEXT_NODE then
									local var_9_10 = arg_9_0.viewComponent

									var_4.OnNextNode(var_9_10, var_9_2)
								else
									GAME = var_4

									if var_9_1 == var_4.NEW_EDUCATE_SHOPPING_DONE then
										seriesAsync = var_4

										var_4({
											function(arg_10_0)
												if not var_9_2.isUpgradeEntry then
													local var_10_0 = arg_9_0.viewComponent
													local var_10_1 = var_1.emit

													NewEducateBaseUI = var_2_10004

													var_10_1(var_10_0, var_2_10004.ON_DROP, {
														items = var_9_2.drops,
														removeFunc = arg_10_0
													})
												else
													arg_10_0()
												end

												return
											end
										}, function()
											local var_11_0 = arg_9_0.viewComponent

											var_0.OnShoppingDone(var_11_0)

											return
										end)
									else
										GAME = var_4

										if var_9_1 == var_4.NEW_EDUCATE_REFRESH_SHOP_DONE then
											local var_9_11 = arg_9_0.viewComponent

											var_4.OnRefreshShopDone(var_9_11)
										else
											GAME = var_4

											local var_9_13

											if var_9_1 == var_4.NEW_EDUCATE_REFRESH_DONE then
												local var_9_12 = arg_9_0.viewComponent

												var_9_13 = var_9_13.emit
												NewEducateBaseUI = var_1_10007

												local var_9_14 = var_1_10007.GO_SCENE

												SCENE = var_1_10008

												var_9_13(var_9_12, var_9_14, var_1_10008.NEW_EDUCATE, {
													id = var_9_2.id
												})
											else
												GAME = var_9_13

												if var_9_1 == var_9_13.NEW_EDUCATE_MAP_NORMAL_DONE then
													arg_9_0:StartNodeWithCheckDrops(var_9_2)
												else
													GAME = var_4

													if var_9_1 == var_4.NEW_EDUCATE_MAP_EVENT_DONE then
														arg_9_0:StartNodeWithCheckDrops(var_9_2)
													else
														GAME = var_4

														if var_9_1 == var_4.NEW_EDUCATE_MAP_SHIP_DONE then
															arg_9_0:StartNodeWithCheckDrops(var_9_2)
														elseif var_9_1 == var_0_1.ON_SHIP_UPGRADE_LEVEL then
															local var_9_15 = arg_9_0.viewComponent

															var_4.UpdateShipLv(var_9_15)
														else
															GAME = var_4

															if var_9_1 == var_4.NEW_EDUCATE_CHECK_PRIORITY_FSM then
																arg_9_0:CheckPriorityState()
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.StartNodeWithCheckDrops(arg_12_0, arg_12_1)
	if #arg_12_1.drops == 0 then
		local var_12_0 = arg_12_0.viewComponent

		var_2.OnNodeStart(var_12_0, arg_12_1.node)
	else
		local var_12_1 = arg_12_0.viewComponent
		local var_12_2 = var_2.emit

		NewEducateBaseUI = var_1_10005

		var_12_2(var_12_1, var_1_10005.ON_DROP, {
			items = arg_12_1.drops,
			removeFunc = function()
				local var_13_0 = arg_12_0.viewComponent

				var_0.OnNodeStart(var_13_0, arg_12_1.node)

				return
			end
		})
	end

	return
end

return var_0_1
