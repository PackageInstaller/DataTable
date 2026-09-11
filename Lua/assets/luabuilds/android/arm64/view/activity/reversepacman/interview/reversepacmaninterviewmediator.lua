local ReversePacmanInterviewMediator = class("ReversePacmanInterviewMediator", import("view.base.ContextMediator"))

ReversePacmanInterviewMediator.CMD_HIRE = "ReversePacmanInterviewMediator::CMD_HIRE"

function ReversePacmanInterviewMediator:register()
	local var_1_0 = ReversePacmanTools.GetActivity().id

	self:bind(ReversePacmanInterviewMediator.CMD_HIRE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.REVERSE_PACMAN_HIRE_ROLE, {
			activityID = var_1_0,
			roleID = arg_2_1
		})

		return
	end)

	return
end

function ReversePacmanInterviewMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.REVERSE_PACMAN_HIRE_ROLE_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:OnRoleHireSuccess((arg_4_1:getBody()))

			return
		end,
		[STORY_EVENT.OPTION_SELECTED] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:OnSelectedOption()

			return
		end,
		[GAME.REVERSE_PACMAN_REFRESH_TIP] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:RefreshBtns()

			return
		end
	}

	return
end

return ReversePacmanInterviewMediator
