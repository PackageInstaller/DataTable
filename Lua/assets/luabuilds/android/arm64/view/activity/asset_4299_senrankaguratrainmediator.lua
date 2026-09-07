local SenrankaguraTrainMediator = class("SenrankaguraTrainMediator", import("..base.ContextMediator"))

SenrankaguraTrainMediator.LEVEL_UP = "level up"
SenrankaguraTrainMediator.GET_REWARD = "get reward"

function SenrankaguraTrainMediator:register()
	self:bind(SenrankaguraTrainMediator.LEVEL_UP, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SENRANKAGURA_TRAIN_ACT_OP, arg_2_1)

		return
	end)
	self:bind(SenrankaguraTrainMediator.GET_REWARD, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SENRANKAGURA_TRAIN_ACT_OP, arg_3_1)

		return
	end)

	return
end

function SenrankaguraTrainMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SENRANKAGURA_TRAIN_ACT_OP_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:LevelUp((arg_5_1:getBody()))

			return
		end
	}

	return
end

return SenrankaguraTrainMediator
