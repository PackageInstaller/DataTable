local OsirisPlayGameBattleRecordView = class("OsirisPlayGameBattleRecordView", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")))

function OsirisPlayGameBattleRecordView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_RewardTrustUI"
end

function OsirisPlayGameBattleRecordView:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetActivityID()

	self.idList_ = self:GetLevelIDList()
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.curLv_ = 0
	self.maxLv_ = 0
	self.onekeyController_ = self.mainControllerEx_:GetController("onekey")
	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, OsirisPlayGamePointTaskCommonItem)
end

function OsirisPlayGameBattleRecordView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME
end

function OsirisPlayGameBattleRecordView:GetLevelInfo()
	return OsirisPlayGameData:GetNum(), #ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function OsirisPlayGameBattleRecordView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		OsirisPlayGameAction.GetPointReward(self.receiveList_)
	end)
end

function OsirisPlayGameBattleRecordView:OnEnter()
	self.super.OnEnter(self)
	manager.notify:RegistListener(OSIRISPLAYGAME_UPDATE_TASK, self.taskUpdateHandler_)
end

function OsirisPlayGameBattleRecordView:OnExit()
	OsirisPlayGameBattleRecordView.super.OnExit(self)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, self.taskUpdateHandler_)
end

function OsirisPlayGameBattleRecordView:Dispose()
	self.taskUpdateHandler_ = nil

	self.super.Dispose(self)
end

function OsirisPlayGameBattleRecordView:UpdateView()
	self.receiveList_ = {}
	self.showIdList_ = {}

	for iter_10_0, iter_10_1 in ipairs(self.idList_) do
		local var_10_0 = ""

		if OsirisPlayGameData:IsCompleteID(iter_10_1) == 2 then
			var_10_0 = "complete"
		elseif OsirisPlayGameData:IsCompleteID(iter_10_1) == 1 then
			var_10_0 = "receive"

			table.insert(self.receiveList_, iter_10_1)
		else
			var_10_0 = "lock"
		end

		table.insert(self.showIdList_, {
			id = iter_10_1,
			ind = iter_10_0,
			state = var_10_0
		})
	end

	local var_10_1 = 0

	for iter_10_2, iter_10_3 in ipairs(self.showIdList_) do
		if iter_10_3.state == "receive" then
			var_10_1 = iter_10_2

			break
		end
	end

	if var_10_1 <= 0 then
		for iter_10_4, iter_10_5 in ipairs(self.showIdList_) do
			if iter_10_5.state == "lock" then
				var_10_1 = iter_10_4

				break
			end
		end
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_10_1)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function OsirisPlayGameBattleRecordView:TaskUpdate()
	self:GetLevelInfo()
	self:UpdateView()
end

return OsirisPlayGameBattleRecordView
