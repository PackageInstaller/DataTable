local VoteMediator = class("VoteMediator", import("..base.ContextMediator"))

VoteMediator.ON_VOTE = "VoteMediator:ON_VOTE"
VoteMediator.ON_FILTER = "VoteMediator:ON_FILTER"
VoteMediator.ON_SCHEDULE = "VoteMediator:ON_SCHEDULE"
VoteMediator.OPEN_EXCHANGE = "VoteMediator:OPEN_EXCHANGE"

function VoteMediator:register()
	self:bind(VoteMediator.ON_VOTE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.ON_NEW_VOTE, {
			voteId = arg_2_1,
			gid = arg_2_2,
			count = arg_2_3
		})

		return
	end)
	self:bind(VoteMediator.ON_FILTER, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_3_1
		}))

		return
	end)
	self:bind(VoteMediator.ON_SCHEDULE, function()
		self:addSubLayers(Context.New({
			mediator = VoteScheduleMediator,
			viewComponent = VoteScheduleScene
		}))

		return
	end)
	self:bind(VoteMediator.OPEN_EXCHANGE, function()
		local var_5_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		if not var_5_0 then
			return
		end

		self:addSubLayers(Context.New({
			mediator = VoteExchangeMediator,
			viewComponent = VoteExchangeScene,
			data = {
				voteGroup = var_5_0
			}
		}))

		return
	end)

	return
end

function VoteMediator:listNotificationInterests()
	return {
		GAME.ON_NEW_VOTE_DONE,
		GAME.ACT_NEW_PT_DONE
	}
end

function VoteMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.ON_NEW_VOTE_DONE then
		self.viewComponent:updateMainview(false)
		pg.TipsMgr.GetInstance():ShowTips(i18n("vote_success"))
		self:DisplayAwards(var_7_1.awards)
	elseif var_7_0 == GAME.ACT_NEW_PT_DONE then
		self:DisplayAwards(var_7_1.awards)
	end

	return
end

function VoteMediator:DisplayAwards(arg_8_1)
	local function var_8_1()
		if #self.cache <= 0 then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.cache[1], function()
			table.remove(self.cache, 1)
			var_8_1()

			return
		end)

		return
	end

	self.cache = self.cache or {}

	table.insert(self.cache, arg_8_1)

	if #self.cache == 1 then
		var_8_1()
	end

	return
end

return VoteMediator
