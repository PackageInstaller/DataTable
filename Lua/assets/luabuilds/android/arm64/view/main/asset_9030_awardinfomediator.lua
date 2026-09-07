local AwardInfoMediator = class("AwardInfoMediator", import("..base.ContextMediator"))

AwardInfoMediator.ON_DROP = "AwardInfoMediator:ON_DROP"

function AwardInfoMediator:register()
	self:bind(AwardInfoMediator.ON_DROP, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1.type == DROP_TYPE_EQUIP then
			self:addSubLayers(Context.New({
				mediator = EquipmentInfoMediator,
				viewComponent = EquipmentInfoLayer,
				data = {
					equipmentId = arg_2_1:getConfig("id"),
					type = EquipmentInfoMediator.TYPE_DISPLAY,
					onRemoved = arg_2_2
				}
			}))
		elseif arg_2_1.type == DROP_TYPE_SPWEAPON then
			self:addSubLayers(Context.New({
				mediator = SpWeaponInfoMediator,
				viewComponent = SpWeaponInfoLayer,
				data = {
					spWeaponConfigId = arg_2_1:getConfig("id"),
					type = SpWeaponInfoLayer.TYPE_DISPLAY,
					onRemoved = arg_2_2
				}
			}))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = arg_2_1,
				onNo = arg_2_2,
				onYes = arg_2_2
			})
		end

		return
	end)

	return
end

function AwardInfoMediator:listNotificationInterests()
	return {
		GAME.STORY_BEGIN,
		GAME.STORY_END,
		GAME.STORY_NEXT
	}
end

function AwardInfoMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.STORY_BEGIN or var_4_0 == GAME.STORY_NEXT then
		self.viewComponent:ShowOrHideSpriteMask(false)
	elseif var_4_0 == GAME.STORY_END then
		self.viewComponent:ShowOrHideSpriteMask(true)
	end

	return
end

return AwardInfoMediator
