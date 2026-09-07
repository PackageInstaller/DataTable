local ClueMapMediator = class("ClueMapMediator", import("view.base.ContextMediator"))

ClueMapMediator.ON_TASK_SUBMIT_ONESTEP = "ClueMapMediator.ON_TASK_SUBMIT_ONESTEP"
ClueMapMediator.OPEN_SINGLE_CLUE_GROUP = "ClueMapMediator.OPEN_SINGLE_CLUE_GROUP"
ClueMapMediator.OPEN_CLUE_BOOK = "ClueMapMediator.OPEN_CLUE_BOOK"
ClueMapMediator.OPEN_CLUE_TASk = "ClueMapMediator.OPEN_CLUE_TASk"
ClueMapMediator.OPEN_STAGE = "ClueMapMediator.OPEN_STAGE"
ClueMapMediator.ON_FLEET_SELECT = "ClueMapMediator.ON_FLEET_SELECT"
ClueMapMediator.OPEN_CLUE_JUMP = "ClueMapMediator.OPEN_CLUE_JUMP"

function ClueMapMediator:register()
	self:bind(ClueMapMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	self:bind(ClueMapMediator.OPEN_SINGLE_CLUE_GROUP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:addSubLayers(Context.New({
			viewComponent = ClueGroupSingleView,
			mediator = ClueGroupSingleMediator,
			data = {
				clueGroupId = arg_3_1,
				submitClueIds = arg_3_2
			},
			onRemoved = arg_3_3
		}))

		return
	end)
	self:bind(ClueMapMediator.OPEN_CLUE_BOOK, function(arg_4_0, arg_4_1)
		self.contextData.bookOpen = true
		self.contextData.indexInfo = self.contextData.indexInfo or {}

		self:addSubLayers(Context.New({
			viewComponent = ClueBookLayer,
			mediator = ClueBookMediator,
			data = {
				indexInfo = self.contextData.indexInfo
			},
			onRemoved = function()
				self.contextData.bookOpen = false

				existCall(arg_4_1)

				return
			end
		}))

		return
	end)
	self:bind(ClueMapMediator.OPEN_CLUE_TASk, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = ClueTasksLayer,
			mediator = ClueTasksMediator,
			onRemoved = arg_6_1
		}))

		return
	end)
	self:bind(ClueMapMediator.OPEN_STAGE, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			viewComponent = ClueBuffSelectLayer,
			mediator = ClueBuffSelectMediator,
			data = {
				clueSingleEnemyID = arg_7_1
			}
		}))

		return
	end)

	return
end

function ClueMapMediator:listNotificationInterests()
	return {
		ClueMapMediator.ON_FLEET_SELECT,
		ClueMapMediator.OPEN_CLUE_JUMP,
		PlayerProxy.UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function ClueMapMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ClueMapMediator.ON_FLEET_SELECT then
		self.viewComponent:ShowNormalFleet(var_9_1.singleID)
	elseif var_9_0 == ClueMapMediator.OPEN_CLUE_JUMP then
		self:addSubLayers(Context.New({
			viewComponent = ClueBuffSelectLayer,
			mediator = ClueBuffSelectMediator,
			data = {
				clueSingleEnemyID = pg.activity_clue_group[var_9_1.jumpID].unlock_jump[1][1],
				preSelectedBuffList = Clone(pg.activity_clue_group[var_9_1.jumpID].unlock_jump[2])
			}
		}))

		if pg.activity_single_enemy[pg.activity_clue_group[var_9_1.jumpID].unlock_jump[1][1]].type == 1 or pg.activity_single_enemy[pg.activity_clue_group[var_9_1.jumpID].unlock_jump[1][1]].type == 2 or pg.activity_single_enemy[pg.activity_clue_group[var_9_1.jumpID].unlock_jump[1][1]].type == 3 then
			triggerToggle(self.viewComponent.mapsSwitch[pg.activity_single_enemy[pg.activity_clue_group[var_9_1.jumpID].unlock_jump[1][1]].type], true)
		end
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:ShowResUI()
	elseif var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:RefreshPtAndTicket()
	end

	return
end

return ClueMapMediator
