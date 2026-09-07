local ItemInfoMediator = class("ItemInfoMediator", import("..base.ContextMediator"))

ItemInfoMediator.USE_ITEM = "ItemInfoMediator:USE_ITEM"
ItemInfoMediator.COMPOSE_ITEM = "ItemInfoMediator:COMPOSE_ITEM"
ItemInfoMediator.SELL_BLUEPRINT = "sell blueprint"
ItemInfoMediator.EXCHANGE_LOVE_LETTER_ITEM = "ItemInfoMediator.EXCHANGE_LOVE_LETTER_ITEM"
ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM = "ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM"
ItemInfoMediator.CHECK_LOVE_LETTER_MAIL = "ItemInfoMediator.CHECK_LOVE_LETTER_MAIL"
ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL = "ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL"

function ItemInfoMediator:register()
	self:bind(ItemInfoMediator.SELL_BLUEPRINT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.FRAG_SELL, {
			arg_2_1
		})

		return
	end)
	self:bind(ItemInfoMediator.USE_ITEM, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = getProxy(BagProxy):getItemById(arg_3_1)

		if not UseItemCommand.Check(var_3_0, arg_3_2) then
			self.viewComponent:closeView()

			return
		end

		self.viewComponent:PlayOpenBox(var_3_0:getConfig("display_effect"), function()
			self:sendNotification(GAME.USE_ITEM, {
				id = arg_3_1,
				count = arg_3_2,
				isEquipBox = var_3_0:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5
			})

			return
		end)

		return
	end)
	self:bind(ItemInfoMediator.COMPOSE_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.COMPOSE_ITEM, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(ItemInfoMediator.EXCHANGE_LOVE_LETTER_ITEM, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.EXCHANGE_LOVE_LETTER_ITEM, {
			activity_id = arg_6_1
		})

		return
	end)
	self:bind(ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = LoveLetterSelectCharMediator,
			viewComponent = LoveLetterSelectCharLayer,
			data = {
				isRepair = true,
				itemVO = arg_7_1
			}
		}))

		return
	end)
	self:bind(ItemInfoMediator.CHECK_LOVE_LETTER_MAIL, function(arg_8_0, arg_8_1, arg_8_2)
		self:sendNotification(GAME.LOVE_ITEM_MAIL_CHECK, {
			item_id = arg_8_1,
			group_id = arg_8_2
		})

		return
	end)
	self:bind(ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self:sendNotification(GAME.LOVE_ITEM_MAIL_REPAIR, {
			item_id = arg_9_1,
			year = arg_9_2,
			group_id = arg_9_3
		})

		return
	end)
	self.viewComponent:setDrop(self.contextData.drop)

	return
end

function ItemInfoMediator:listNotificationInterests()
	return {
		BagProxy.ITEM_UPDATED,
		GAME.USE_ITEM_DONE,
		GAME.FRAG_SELL_DONE,
		GAME.LOVE_ITEM_MAIL_CHECK_DONE
	}
end

function ItemInfoMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == BagProxy.ITEM_UPDATED then
		if var_11_1.id == self.viewComponent.itemVO.id then
			if var_11_1.count > 0 then
				if self.viewComponent.itemVO.extra then
					if not getProxy(BagProxy):hasExtraData(self.viewComponent.itemVO.id, self.viewComponent.itemVO.extra) then
						self.viewComponent:closeView()

						goto label_11_0
					end
				end
			end

			self.viewComponent:setItem(Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_11_1.id,
				count = var_11_1.count,
				extra = var_11_1.extra
			}))
		end
	elseif var_11_0 == GAME.USE_ITEM_DONE then
		self.viewComponent:SetOperateCount(1)
	elseif var_11_0 == GAME.FRAG_SELL_DONE then
		self.viewComponent:SetOperateCount(1)
	elseif var_11_0 == GAME.LOVE_ITEM_MAIL_CHECK_DONE then
		self.viewComponent:setDrop(self.contextData.drop)
	end

	::label_11_0::

	return
end

return ItemInfoMediator
