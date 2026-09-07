local NewEducateTalentMediator = class("NewEducateTalentMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateTalentMediator.ON_REFRESH_TALENT = "NewEducateTalentMediator:ON_REFRESH_TALENT"
NewEducateTalentMediator.ON_SELECT_TALENT = "NewEducateTalentMediator:ON_SELECT_TALENT"

function NewEducateTalentMediator:register()
	self:bind(NewEducateTalentMediator.ON_REFRESH_TALENT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.NEW_EDUCATE_REFRESH_TALENT, {
			id = self.contextData.char.id,
			talentId = arg_2_1,
			idx = arg_2_2
		})

		return
	end)
	self:bind(NewEducateTalentMediator.ON_SELECT_TALENT, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.NEW_EDUCATE_SEL_TALENT, {
			id = self.contextData.char.id,
			talentId = arg_3_1,
			idx = arg_3_2
		})

		return
	end)

	return
end

function NewEducateTalentMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_REFRESH_TALENT_DONE,
		GAME.NEW_EDUCATE_SEL_TALENT_DONE
	}
end

function NewEducateTalentMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.NEW_EDUCATE_REFRESH_TALENT_DONE then
		self.viewComponent:OnRefreshTalent(var_5_1.idx, var_5_1.newId)
	elseif var_5_0 == GAME.NEW_EDUCATE_SEL_TALENT_DONE then
		self.viewComponent:OnSelectedDone(var_5_1)
	end

	return
end

return NewEducateTalentMediator
