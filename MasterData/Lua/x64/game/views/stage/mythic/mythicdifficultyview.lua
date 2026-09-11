local MythicDifficultyView = class("MythicDifficultyView", ReduxView)

function MythicDifficultyView:UIName()
	return "Widget/System/Challenge_Mythic/MythicDiffcultyUI"
end

function MythicDifficultyView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicDifficultyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MythicDifficultyView:InitUI()
	self:BindCfgUI()

	self.difficultyList_ = LuaList.New(handler(self, self.indexItem), self.m_difficultyList, MythicDifficultyItem)
	self.rewardList_ = LuaList.New(handler(self, self.rewardIndexItem), self.m_rewardList, CommonItemView)
	self.isFinalController_ = ControllerUtil.GetController(self.transform_, "isfinal")
end

function MythicDifficultyView:AddUIListener()
	self:AddBtnListener(self.m_sureBtn, nil, function()
		local var_6_2 = MythicCfg.all[self.index]

		if MythicCfg.all[self.index] == 0 then
			self:Back()

			return
		end

		if MythicData:GetDifficulty() == 0 or MythicData:GetPartitionCount() == 0 and MythicData:GetStarCount() == 0 and MythicData:GetFinalRewardNotGet() == false or _G.SkipTip.MythicDifficultyView then
			MythicAction.QueryChangeDifficulty(MythicCfg.all[self.index])
		else
			ShowMessageBox({
				content = GetTips("MYTHIC_CHANGE_DIFFICULTY"),
				OkCallback = function()
					MythicAction.QueryChangeDifficulty(var_6_2)
				end,
				ToggleCallback = function(arg_8_0)
					_G.SkipTip.MythicDifficultyView = arg_8_0
				end
			})
		end
	end)
end

function MythicDifficultyView:OnTop()
	manager.windowBar:SwitchBar({})
end

function MythicDifficultyView:OnEnter()
	local var_10_0 = MythicData:GetDifficulty()

	self.selectDifficulty = var_10_0 == 0 and MythicData:GetMaxDifficulty() or var_10_0
	self.index = table.indexof(MythicCfg.all, self.selectDifficulty)

	self.difficultyList_:StartScroll(#MythicCfg.all, self.index, true)
	self:Refresh()
end

function MythicDifficultyView:OnExit()
	manager.windowBar:HideBar()
end

function MythicDifficultyView:Refresh()
	self.curLevelID_ = MythicCfg.all[self.index]
	self.m_levelLab.text = (MythicCfg[self.curLevelID_].recommend_level[1] or 0) .. "-" .. (MythicCfg[self.curLevelID_].recommend_level[2] or 0)
	self.m_desLab.text = GetI18NText(MythicCfg[self.curLevelID_].desc)
	self.preview_reward_list = MythicCfg[self.curLevelID_].preview_reward_list

	self.rewardList_:StartScroll(#self.preview_reward_list)

	if MythicCfg[self.curLevelID_].difficulty == 2 then
		self.isFinalController_:SetSelectedState("true")
	else
		self.isFinalController_:SetSelectedState("false")

		self.m_difficultyLab.text = NumberTools.IntToRomam(self.curLevelID_)
	end
end

function MythicDifficultyView:OnItemClick(arg_13_1)
	if self.index ~= arg_13_1 then
		self.index = arg_13_1

		for iter_13_0, iter_13_1 in pairs((self.difficultyList_:GetItemList())) do
			iter_13_1:SetChoice(self.index)
		end

		self:Refresh()
	end
end

function MythicDifficultyView:indexItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshData(arg_14_1)
	arg_14_2:RegistCallBack(function(arg_15_0)
		self:OnItemClick(arg_15_0)
	end)
	arg_14_2:SetChoice(self.index)
end

function MythicDifficultyView:rewardIndexItem(arg_16_1, arg_16_2)
	local var_16_0 = clone(ItemTemplateData)

	var_16_0.id = self.preview_reward_list[arg_16_1][1]
	var_16_0.number = MythicCfg[self.curLevelID_].difficulty == 1 and self.preview_reward_list[arg_16_1][2] or nil

	function var_16_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id
		})
	end

	arg_16_2:SetData(var_16_0)
end

function MythicDifficultyView:Dispose()
	self.difficultyList_:Dispose()
	self.rewardList_:Dispose()
	MythicDifficultyView.super.Dispose(self)
end

function MythicDifficultyView:OnMyticUpdate()
	self.difficultyList_:Refresh()
end

return MythicDifficultyView
