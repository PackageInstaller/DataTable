local SPHeroChallengeEntrustItem = class("SPHeroChallengeEntrustItem", ReduxView)

function SPHeroChallengeEntrustItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SPHeroChallengeEntrustItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeEntrustItem:InitUI()
	self:BindCfgUI()

	self.awardItem = CommonItemView.New(self.awarditemGo_1)
	self.needMaterialItem = CommonItemView.New(self.needitemGo_1)
	self.rankController = self.controller:GetController("rank")
end

function SPHeroChallengeEntrustItem:RefreshUI(arg_4_1)
	if arg_4_1 then
		if ActivityHeroChallengeTaskCfg[arg_4_1.id] then
			self.id = arg_4_1.id
			self.index = arg_4_1.index
			self.timeText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_TIME") .. manager.time:DescCdTime3(ActivityHeroChallengeTaskCfg[arg_4_1.id].time * 60)
			self.entrustnameText_.text = ActivityHeroChallengeTaskCfg[arg_4_1.id].name
			self.entrustdescText_.text = ActivityHeroChallengeTaskCfg[arg_4_1.id].desc

			self.awardItem:SetData({
				id = ActivityHeroChallengeTaskCfg[arg_4_1.id].reward_list[1][1],
				number = ActivityHeroChallengeTaskCfg[arg_4_1.id].reward_list[1][2],
				clickFun = function(self)
					ShowPopItem(POP_ITEM, {
						self.id,
						self.num
					})
				end
			})
			self.needMaterialItem:SetData({
				id = ActivityHeroChallengeTaskCfg[arg_4_1.id].cost[1][1],
				number = ActivityHeroChallengeTaskCfg[arg_4_1.id].cost[1][2],
				clickFun = function(self)
					ShowPopItem(POP_ITEM, {
						self.id,
						self.num
					})
				end
			})
			self.rankController:SetSelectedState(tostring(ActivityHeroChallengeTaskCfg[arg_4_1.id].task_level))
		else
			Debug.LogError("委托item传入的id未获取到配置" .. arg_4_1.id)
		end
	end
end

function SPHeroChallengeEntrustItem:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_8_0 = SPHeroChallengeData:GetCurActivityInfo():GetNextExtrustIndex()

		if var_8_0 then
			local var_8_1 = {
				index = var_8_0,
				entrustID = self.id
			}

			if ActivityHeroChallengeTaskCfg[self.id].task_level == SpHeroChallengeConst.entrustMaxLevel then
				ShowMessageBox({
					isTop = true,
					content = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_CONFIRM"),
					OkCallback = function()
						SPHeroChallengeAction:DispatchEntrust(var_8_1)
					end
				})
			else
				SPHeroChallengeAction:DispatchEntrust(var_8_1)
			end
		else
			ShowTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
		end
	end)
end

function SPHeroChallengeEntrustItem:Dispose()
	self.awardItem:Dispose()
	self.needMaterialItem:Dispose()
	SPHeroChallengeEntrustItem.super.Dispose(self)
end

return SPHeroChallengeEntrustItem
