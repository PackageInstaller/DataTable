class = var_0_10000

local var_0_0 = "ItemInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.USE_ITEM = "ItemInfoMediator:USE_ITEM"
var_0_1.COMPOSE_ITEM = "ItemInfoMediator:COMPOSE_ITEM"
var_0_1.SELL_BLUEPRINT = "sell blueprint"
var_0_1.EXCHANGE_LOVE_LETTER_ITEM = "ItemInfoMediator.EXCHANGE_LOVE_LETTER_ITEM"
var_0_1.REPAIR_LOVE_LETTER_ITEM = "ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM"
var_0_1.CHECK_LOVE_LETTER_MAIL = "ItemInfoMediator.CHECK_LOVE_LETTER_MAIL"
var_0_1.REPAIR_LOVE_LETTER_MAIL = "ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SELL_BLUEPRINT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.FRAG_SELL, {
			arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.USE_ITEM, function(arg_3_0, arg_3_1, arg_3_2)
		getProxy = var_2_10003
		BagProxy = var_2_10004

		local var_3_0 = var_2_10003(var_2_10004)
		local var_3_1 = var_3.getItemById(var_3_0, arg_3_1)

		UseItemCommand = var_3_0

		if not var_3_0.Check(var_3_1, arg_3_2) then
			local var_3_2 = arg_1_0.viewComponent

			var_4.closeView(var_3_2)

			return
		end

		local var_3_3 = arg_1_0.viewComponent

		var_4.PlayOpenBox(var_3_3, var_3_1:getConfig("display_effect"), function()
			local var_4_0 = arg_1_0
			local var_4_1 = var_0.sendNotification

			GAME = var_3_10002

			local var_4_2 = var_3_10002.USE_ITEM
			local var_4_3 = {
				id = arg_3_1,
				count = arg_3_2
			}
			local var_4_4 = var_3_1
			local var_4_5 = var_4.getConfig(var_4_4, "type")

			Item = var_4_4
			var_4_3.isEquipBox = var_4_5 == var_4_4.EQUIPMENT_BOX_TYPE_5

			var_4_1(var_4_0, var_4_2, var_4_3)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.COMPOSE_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.COMPOSE_ITEM, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.EXCHANGE_LOVE_LETTER_ITEM, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.EXCHANGE_LOVE_LETTER_ITEM, {
			activity_id = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.REPAIR_LOVE_LETTER_ITEM, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		LoveLetterSelectCharMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		LoveLetterSelectCharLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		var_7_3.data = {
			isRepair = true,
			itemVO = arg_7_1
		}

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHECK_LOVE_LETTER_MAIL, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.LOVE_ITEM_MAIL_CHECK, {
			item_id = arg_8_1,
			group_id = arg_8_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REPAIR_LOVE_LETTER_MAIL, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		local var_9_0 = arg_1_0
		local var_9_1 = var_4.sendNotification

		GAME = var_2_10006

		var_9_1(var_9_0, var_2_10006.LOVE_ITEM_MAIL_REPAIR, {
			item_id = arg_9_1,
			year = arg_9_2,
			group_id = arg_9_3
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.setDrop(var_1_0, arg_1_0.contextData.drop)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	BagProxy = var_1_10002
	var_10_0[1] = var_1_10002.ITEM_UPDATED
	GAME = var_2
	var_10_0[2] = var_2.USE_ITEM_DONE
	GAME = var_2
	var_10_0[3] = var_2.FRAG_SELL_DONE
	GAME = var_2
	var_10_0[4] = var_2.LOVE_ITEM_MAIL_CHECK_DONE

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)

	BagProxy = var_11_1

	if var_11_0 == var_11_1.ITEM_UPDATED then
		local var_11_3 = arg_11_0.viewComponent.itemVO

		if var_11_2.id == var_11_3.id then
			if not (var_11_2.count <= 0) then
				if var_11_3.extra then
					getProxy = var_5
					BagProxy = var_6

					local var_11_4 = var_5(var_6)

					if not var_5.hasExtraData(var_11_4, var_11_3.id, var_11_3.extra) then
						local var_11_5 = arg_11_0.viewComponent

						var_5.closeView(var_11_5)

						goto label_11_0
					end
				end

				do
					local var_11_6 = arg_11_0.viewComponent
					local var_11_7 = var_5.setItem

					Drop = var_1_10007

					local var_11_8 = var_1_10007.New
					local var_11_9 = {}

					DROP_TYPE_ITEM = var_1_10009
					var_11_9.type = var_1_10009
					var_11_9.id = var_11_2.id
					var_11_9.count = var_11_2.count
					var_11_9.extra = var_11_2.extra

					var_11_7(var_11_6, var_11_8(var_11_9))

					goto label_11_0

					GAME = var_11_3

					if var_11_0 == var_11_3.USE_ITEM_DONE then
						local var_11_10 = arg_11_0.viewComponent

						var_4.SetOperateCount(var_11_10, 1)
					else
						GAME = var_4

						if var_11_0 == var_4.FRAG_SELL_DONE then
							local var_11_11 = arg_11_0.viewComponent

							var_4.SetOperateCount(var_11_11, 1)
						else
							GAME = var_4

							if var_11_0 == var_4.LOVE_ITEM_MAIL_CHECK_DONE then
								local var_11_12 = arg_11_0.viewComponent

								var_4.setDrop(var_11_12, arg_11_0.contextData.drop)
							end
						end
					end
				end

				::label_11_0::

				return
			end
		end
	end
end

return var_0_1
