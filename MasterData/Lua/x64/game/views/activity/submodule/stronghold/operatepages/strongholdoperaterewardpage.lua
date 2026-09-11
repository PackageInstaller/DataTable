local StrongholdOperateSkillPage = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function StrongholdOperateSkillPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdRewardUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:Refresh()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateSkillPage:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, StrongholdOperateRewardItem)
	self.rewardController = ControllerUtil.GetController(self.transform_, "reward")
	self.specItems = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.specItems, StrongholdOperateRewardSpecItem.New(self["m_specReward" .. iter_4_0]))
	end
end

function StrongholdOperateSkillPage:AddUIListener()
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		StrongholdAction.QueryReward(self.activity_id, (self:GetAllRecevieRewardIdList()))
	end)
end

function StrongholdOperateSkillPage:Refresh(arg_7_1, arg_7_2)
	if arg_7_2 == nil then
		arg_7_2 = true
	end

	self.activity_id = arg_7_1
	self.rewardDataList = ActivityStrongholdRewardCfg.get_id_list_by_tag[0]

	table.sort(self.rewardDataList, function(arg_8_0, arg_8_1)
		local var_8_0 = StrongholdData:GetRewardState(arg_7_1, arg_8_0)
		local var_8_1 = StrongholdData:GetRewardState(arg_7_1, arg_8_1)

		if var_8_0 == var_8_1 then
			return arg_8_0 < arg_8_1
		else
			return var_8_0 < var_8_1
		end
	end)

	if arg_7_2 then
		self.list:StartScroll(#self.rewardDataList)
	else
		self.list:StartScrollWithoutAnimator(#self.rewardDataList, (self.list:GetScrolledPosition()))
	end

	self:RefreshUI()
end

function StrongholdOperateSkillPage:RefreshUI()
	self.rewardController:SetSelectedIndex(#self:GetAllRecevieRewardIdList() > 0 and 1 or 0)

	for iter_9_0, iter_9_1 in ipairs(ActivityStrongholdRewardCfg.get_id_list_by_tag[1]) do
		if self.specItems[iter_9_0] then
			self.specItems[iter_9_0]:SetData(self.activity_id, iter_9_1)
		end
	end
end

function StrongholdOperateSkillPage:GetAllRecevieRewardIdList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ActivityStrongholdRewardCfg.all) do
		if StrongholdData:GetRewardState(self.activity_id, iter_10_1) == 0 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function StrongholdOperateSkillPage:Dispose()
	self.list:Dispose()

	for iter_11_0, iter_11_1 in ipairs(self.specItems) do
		iter_11_1:Dispose()
	end

	self.specItems = {}

	StrongholdOperateSkillPage.super.Dispose(self)
end

function StrongholdOperateSkillPage:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.activity_id, self.rewardDataList[arg_12_1])
end

function StrongholdOperateSkillPage:OnStrongholdUpdateReward()
	self:Refresh(self.activity_id, false)
end

return StrongholdOperateSkillPage
