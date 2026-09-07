local ClueGroupSingleMediator = class("ClueGroupSingleMediator", import("view.base.ContextMediator"))

ClueGroupSingleMediator.OPEN_CLUE_JUMP = "ClueGroupSingleMediator.OPEN_CLUE_JUMP"

function ClueGroupSingleMediator:register()
	self:bind(ClueGroupSingleMediator.OPEN_CLUE_JUMP, function(arg_2_0, arg_2_1)
		print(arg_2_1)
		self:sendNotification(ClueMapMediator.OPEN_CLUE_JUMP, {
			jumpID = arg_2_1
		})

		return
	end)

	return
end

function ClueGroupSingleMediator:listNotificationInterests()
	return {}
end

function ClueGroupSingleMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return ClueGroupSingleMediator
