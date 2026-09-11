local ActivityPointTaskCommonModule = class("ActivityPointTaskCommonModule", ReduxView)

function ActivityPointTaskCommonModule:GetLevelIDList()
	return ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function ActivityPointTaskCommonModule:GetLevelInfo()
	local var_2_0 = self:GetLevelIDList()
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if ItemTools.getItemNum(ActivityPointRewardCfg[iter_2_1].need_item_id) >= ActivityPointRewardCfg[iter_2_1].need then
			var_2_1 = var_2_1 + 1
		end
	end

	return var_2_1, #var_2_0
end

function ActivityPointTaskCommonModule:UpdateLevelRewardRedPoint()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs((self:GetLevelIDList())) do
		local var_3_1 = ActivityPointRewardCfg[iter_3_1]

		if not ActivityPointData:IsCompleteID(iter_3_1) and (point and math.max(point, ItemTools.getItemNum(var_3_1.need_item_id)) or ItemTools.getItemNum(var_3_1.need_item_id)) >= var_3_1.need then
			var_3_0 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD, var_3_0)
end

function ActivityPointTaskCommonModule:UIName()
	return "Widget/Common/Com_Prefab/Com_Activity_RewardTrustUI"
end

function ActivityPointTaskCommonModule:SetActivityID()
	self.activityPointRewardActivityID_ = 1
end

function ActivityPointTaskCommonModule:BindRedPoint()
	return
end

function ActivityPointTaskCommonModule:UnBindRedPoint()
	return
end

function ActivityPointTaskCommonModule:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPointTaskCommonModule:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetActivityID()

	self.idList_ = self:GetLevelIDList()
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.curLv_ = 0
	self.maxLv_ = 0
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, ActivityPointTaskCommonItem)
	self.receivePointRewardHandler_ = handler(self, self.OnReceivePointReward)
	self.onekeyController_ = self.mainControllerEx_:GetController("onekey")
end

function ActivityPointTaskCommonModule:InitUI()
	self:BindCfgUI()
end

function ActivityPointTaskCommonModule:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward(self.receiveList_)
	end)
end

function ActivityPointTaskCommonModule:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.showIdList_[arg_13_1].id, self.showIdList_[arg_13_1].ind, self.showIdList_[arg_13_1].state, self.activityPointRewardActivityID_)
end

function ActivityPointTaskCommonModule:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curLv_, self.maxLv_ = self:GetLevelInfo()
	self.levelText_.text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"

	if self.progressImg_ then
		self.progressImg_.fillAmount = self.curLv_ / self.maxLv_
	end

	self:UpdateView()
	self:BindRedPoint()
end

function ActivityPointTaskCommonModule:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
end

function ActivityPointTaskCommonModule:OnReceivePointReward()
	self:UpdateView()
	self:UpdateLevelRewardRedPoint()
end

function ActivityPointTaskCommonModule:UpdateView()
	self.receiveList_ = {}
	self.showIdList_ = {}

	for iter_17_0, iter_17_1 in ipairs(self.idList_) do
		local var_17_0 = ""

		if ActivityPointData:IsCompleteID(iter_17_1) then
			var_17_0 = "complete"
		elseif iter_17_0 <= self.curLv_ then
			var_17_0 = "receive"

			table.insert(self.receiveList_, iter_17_1)
		else
			var_17_0 = "lock"
		end

		table.insert(self.showIdList_, {
			id = iter_17_1,
			ind = iter_17_0,
			state = var_17_0
		})
	end

	self.levelLuaList_:StartScroll(#self.showIdList_)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function ActivityPointTaskCommonModule:Dispose()
	ActivityPointTaskCommonModule.super.Dispose(self)

	if self.levelLuaList_ then
		self.levelLuaList_:Dispose()

		self.levelLuaList_ = nil
	end
end

return ActivityPointTaskCommonModule
