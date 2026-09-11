ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local SpringFestivalGreetingSubmoduleItem = class("SpringFestivalGreetingSubmoduleItem", ActivitySubmoduleItem)

function SpringFestivalGreetingSubmoduleItem:InitUI()
	SpringFestivalGreetingSubmoduleItem.super.InitUI(self)

	self.updateModelHandler_ = handler(self, self.LoadModel)
end

function SpringFestivalGreetingSubmoduleItem:OnEnter()
	SpringFestivalGreetingSubmoduleItem.super.OnEnter(self)
	manager.notify:RegistListener(SPRING_FESTIVAL_GREETING_UPDATE, self.updateModelHandler_)
	self:LoadModel()
end

function SpringFestivalGreetingSubmoduleItem:OnExit()
	manager.notify:RemoveListener(SPRING_FESTIVAL_GREETING_UPDATE, self.updateModelHandler_)
	SpringFestivalGreetingSubmoduleItem.super.OnExit(self)
end

function SpringFestivalGreetingSubmoduleItem:Dispose()
	SpringFestivalGreetingSubmoduleItem.super.Dispose(self)

	self.updateModelHandler_ = nil

	self:UnLoadModel()
end

function SpringFestivalGreetingSubmoduleItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityTools.JumpToSubmodulePage(self.activityId_)
	end)
	self:AddBtnListener(self.greetingBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalGreetingLetter")
	end)
end

function SpringFestivalGreetingSubmoduleItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, self.activityId_))
end

function SpringFestivalGreetingSubmoduleItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, self.activityId_))
end

function SpringFestivalGreetingSubmoduleItem:LoadModel()
	local var_10_0 = SpringFestivalGreetingData:GetUnlockCnt(self.activityId_)

	if var_10_0 > #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[self.activityId_] then
		var_10_0 = #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[self.activityId_]
	end

	local var_10_1 = SkinCfg[ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[self.activityId_][var_10_0]].story_name].picture_id

	if self.lastModelID_ ~= SkinCfg[ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[self.activityId_][var_10_0]].story_name].picture_id then
		if self.model_ then
			self:UnLoadModel()
		end

		self.lastModelID_ = var_10_1
		self.model_ = Object.Instantiate(Asset.Load("UIChar/" .. var_10_1), self.charTf_)
	end
end

function SpringFestivalGreetingSubmoduleItem:UnLoadModel()
	if self.model_ then
		Object.Destroy(self.model_)

		self.model_ = nil
		self.lastModelID_ = nil
	end
end

return SpringFestivalGreetingSubmoduleItem
