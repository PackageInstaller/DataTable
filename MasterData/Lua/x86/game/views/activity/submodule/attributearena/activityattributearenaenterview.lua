local ActivityAttributeArenaEnterView = class("ActivityAttributeArenaEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivityAttributeArenaEnterView:GetUIName()
	return AttributeArenaTools.GetEnterUI(self.activityID_)
end

function ActivityAttributeArenaEnterView:Init()
	ActivityAttributeArenaEnterView.super.Init(self)

	self.itemDataList_ = {}

	if self.btnControllerEx_ then
		self.lockController = self.btnControllerEx_:GetController("statelock01")
	end
end

function ActivityAttributeArenaEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/activityAttributeArena", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_5_0, var_5_1 = self:CheckAdvanceOpenTime()

		manager.tips:ShowTips(var_5_1)
	end)
	self:AddBtnListener(nil, self.descBtn_, function()
		local var_6_0 = {
			content = GetTips("ACTIVITY_ATTRIBUTE_GAME_TIP")
		}

		var_6_0.key = "ACTIVITY_ATTRIBUTE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_6_0)
	end)
end

function ActivityAttributeArenaEnterView:OnEnter()
	ActivityAttributeArenaEnterView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, self.activityID_)))

	self.titleTet_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name
	self.descTxt_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc
end

function ActivityAttributeArenaEnterView:OnExit()
	ActivityAttributeArenaEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, self.activityID_)))
end

function ActivityAttributeArenaEnterView:IndexItem(arg_9_1, arg_9_2)
	if not self.itemDataList_[arg_9_1] then
		self.itemDataList_[arg_9_1] = clone(ItemTemplateData)
		self.itemDataList_[arg_9_1].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	self.itemDataList_[arg_9_1].id = self.itemIDList_[arg_9_1]
	self.itemDataList_[arg_9_1].number = nil

	arg_9_2:SetData(self.itemDataList_[arg_9_1])
end

function ActivityAttributeArenaEnterView:Dispose()
	ActivityAttributeArenaEnterView.super.Dispose(self)
end

function ActivityAttributeArenaEnterView:RefreshAcvanceStatus(arg_12_1)
	if self.lockController then
		self.lockController:SetSelectedState(arg_12_1 and "normal01" or "lock01")
	end
end

function ActivityAttributeArenaEnterView:RefreshTimeText()
	if self.timeText_ then
		if not self:isHasLeftTimeDes() then
			local var_13_0, var_13_1 = self:CheckAdvanceOpenTime()

			self.timeText_.text = var_13_1

			self:RefreshAcvanceStatus(not var_13_0)
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		end
	end
end

return ActivityAttributeArenaEnterView
