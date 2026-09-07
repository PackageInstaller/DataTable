local TechnologyTreeNationMediator = class("TechnologyTreeNationMediator", import("..base.ContextMediator"))

function TechnologyTreeNationMediator:register()
	self:bind(TechnologyConst.CLICK_UP_TEC_BTN, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.START_CAMP_TEC, {
			tecID = arg_2_1,
			levelID = arg_2_2
		})

		return
	end)
	self:bind(TechnologyConst.FINISH_UP_TEC, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.FINISH_CAMP_TEC, {
			tecID = arg_3_1,
			levelID = arg_3_2
		})

		return
	end)
	self:bind(TechnologyConst.OPEN_ALL_BUFF_DETAIL, function()
		self:addSubLayers(Context.New({
			mediator = AllBuffDetailMediator,
			viewComponent = AllBuffDetailLayer,
			data = {}
		}))

		return
	end)

	return
end

function TechnologyTreeNationMediator:listNotificationInterests()
	return {
		TechnologyConst.START_TEC_BTN_SUCCESS,
		TechnologyConst.FINISH_TEC_SUCCESS,
		TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION,
		TechnologyConst.GOT_TEC_CAMP_AWARD,
		TechnologyConst.GOT_TEC_CAMP_AWARD_ONESTEP
	}
end

function TechnologyTreeNationMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	getProxy(TechnologyNationProxy):refreshRedPoint()

	if var_6_0 == TechnologyConst.START_TEC_BTN_SUCCESS then
		self.viewComponent:updateTecListData()
		self.viewComponent:updateTecItem(var_6_1)
		self.viewComponent:updateAllTecItemRp()
	elseif var_6_0 == TechnologyConst.FINISH_TEC_SUCCESS then
		self.viewComponent:updateTecListData()
		self.viewComponent:updateTecItem(var_6_1)
		self.viewComponent:updateAllTecItemRp()
	elseif var_6_0 == TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION then
		self.viewComponent:closeMyself()
	elseif var_6_0 == TechnologyConst.GOT_TEC_CAMP_AWARD then
		self.viewComponent:updateTecItem(var_6_1.groupID)
		self.viewComponent:updateOneStepBtn()
		self.viewComponent:updateAllTecItemRp()
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awardList)
	elseif var_6_0 == TechnologyConst.GOT_TEC_CAMP_AWARD_ONESTEP then
		self.viewComponent:updateTecItemList()
		self.viewComponent:updateOneStepBtn()
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awardList)
	end

	return
end

return TechnologyTreeNationMediator
