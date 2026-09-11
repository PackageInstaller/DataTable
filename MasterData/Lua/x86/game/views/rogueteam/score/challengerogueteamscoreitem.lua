local ChallengeRogueTeamScoreItem = class("ChallengeRogueTeamScoreItem", ReduxView)

function ChallengeRogueTeamScoreItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.scoreIDList_ = arg_1_2

	self:Init()
end

function ChallengeRogueTeamScoreItem:Init()
	self:InitUI()
	self:AddListeners()

	self.getController_ = self.controller_:GetController("get")
	self.commonItem_ = CommonItemView.New(self.rewardItem_, true)
end

function ChallengeRogueTeamScoreItem:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamScoreItem:AddListeners()
	return
end

function ChallengeRogueTeamScoreItem:Dispose()
	ChallengeRogueTeamScoreItem.super.Dispose(self)
end

function ChallengeRogueTeamScoreItem:SetData(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1
	self.index_ = arg_6_2
	self.cfg_ = ActivityPointRewardCfg[arg_6_1]
	self.levelText_.text = tostring(math.floor(self.cfg_.need / ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_PER_VALUE, ChallengeRogueTeamData:GetCacheTemplateID())))
	self.reward_ = self.cfg_.reward_item_list[1]

	self:RefreshUI()
end

function ChallengeRogueTeamScoreItem:OnTop()
	self:RefreshUI()
end

function ChallengeRogueTeamScoreItem:RefreshUI()
	local var_8_0 = clone(ItemTemplateData)
	local var_8_1 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_8_2 = self.cfg_.need > ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item)
	local var_8_3 = self.cfg_.need <= ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item)
	local var_8_4 = table.indexof(ChallengeRogueTeamData:GetRewardedScoreList(ChallengeRogueTeamData:GetCacheTemplateID()), self.taskID_)

	var_8_0.id = self.reward_[1]
	var_8_0.number = self.reward_[2]

	function var_8_0:clickFun()
		if var_8_3 and not var_8_4 then
			local var_9_0 = {}

			for iter_9_0, iter_9_1 in ipairs(self.scoreIDList_) do
				if ActivityPointRewardCfg[iter_9_1].need <= ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item) and not table.indexof(ChallengeRogueTeamData:GetRewardedScoreList(ChallengeRogueTeamData:GetCacheTemplateID()), iter_9_1) then
					table.insert(var_9_0, iter_9_1)
				end
			end

			ActivityAction.ReceivePointReward(var_9_0, nil, self.callBack_)

			return
		end

		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem_:SetData(var_8_0)

	if var_8_2 then
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), self.index_) then
			self.getController_:SetSelectedState("bigFalse")
		else
			self.getController_:SetSelectedState("false")
		end

		self.commonItem_:RefreshCompleted(false)
		self.commonItem_:RefreshHighLight(false)
	elseif var_8_4 then
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), self.index_) then
			self.getController_:SetSelectedState("bigTrue")
		else
			self.getController_:SetSelectedState("true")
		end

		self.commonItem_:RefreshCompleted(true)
		self.commonItem_:RefreshHighLight(false)
	else
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), self.index_) then
			self.getController_:SetSelectedState("bigTrue")
		else
			self.getController_:SetSelectedState("true")
		end

		self.commonItem_:RefreshCompleted(false)
		self.commonItem_:RefreshHighLight(true)
	end
end

function ChallengeRogueTeamScoreItem:SetReveivedHandler(arg_10_1)
	self.callBack_ = arg_10_1
end

function ChallengeRogueTeamScoreItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return ChallengeRogueTeamScoreItem
