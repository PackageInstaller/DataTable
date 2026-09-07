local ReMapTransformationMediator = class("ReMapTransformationMediator", import("view.base.ContextMediator"))

ReMapTransformationMediator.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"

function ReMapTransformationMediator:register()
	self:bind(ReMapTransformationMediator.ON_USE_ITEM, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)

	return
end

function ReMapTransformationMediator:initNotificationHandleDic()
	self.handleDic = {
		[BagProxy.ITEM_UPDATED] = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_1:getBody()

			if var_4_0.id == arg_4_0.viewComponent.itemVO.id then
				if var_4_0.count > 0 then
					if arg_4_0.viewComponent.itemVO.extra then
						if not getProxy(BagProxy):hasExtraData(arg_4_0.viewComponent.itemVO.id, arg_4_0.viewComponent.itemVO.extra) then
							arg_4_0.viewComponent:closeView()

							goto label_4_0
						end
					end
				end

				arg_4_0.viewComponent:update(Drop.New({
					type = DROP_TYPE_ITEM,
					id = var_4_0.id,
					count = var_4_0.count,
					extra = var_4_0.extra
				}):getSubClass())
			end

			::label_4_0::

			return
		end
	}

	return
end

function ReMapTransformationMediator:remove()
	return
end

return ReMapTransformationMediator
