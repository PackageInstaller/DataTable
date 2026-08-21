local var_0_0 = class("MythicDifficultyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicDiffcultyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.difficultyList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_difficultyList, MythicDifficultyItem)
	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.rewardIndexItem), arg_4_0.m_rewardList, CommonItemView)
	arg_4_0.isFinalController_ = ControllerUtil.GetController(arg_4_0.transform_, "isfinal")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_sureBtn, nil, function()
		local var_6_0 = 0
		local var_6_1 = 0
		local var_6_2 = MythicCfg.all[arg_5_0.index]
		local var_6_3 = MythicData:GetDifficulty()

		if var_6_2 == var_6_3 then
			arg_5_0:Back()

			return
		end

		if var_6_3 == 0 or MythicData:GetPartitionCount() == 0 and MythicData:GetStarCount() == 0 and MythicData:GetFinalRewardNotGet() == false or _G.SkipTip.MythicDifficultyView then
			MythicAction.QueryChangeDifficulty(var_6_2)
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

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_10_0)
	local var_10_0 = MythicData:GetDifficulty()

	if var_10_0 == 0 then
		arg_10_0.selectDifficulty = MythicData:GetMaxDifficulty()
	else
		arg_10_0.selectDifficulty = var_10_0
	end

	arg_10_0.index = table.indexof(MythicCfg.all, arg_10_0.selectDifficulty)

	arg_10_0.difficultyList_:StartScroll(#MythicCfg.all, arg_10_0.index, true)
	arg_10_0:Refresh()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_12_0)
	arg_12_0.curLevelID_ = MythicCfg.all[arg_12_0.index]

	local var_12_0 = MythicCfg[arg_12_0.curLevelID_]
	local var_12_1 = var_12_0.recommend_level

	arg_12_0.m_levelLab.text = (var_12_1[1] or 0) .. "-" .. (var_12_1[2] or 0)
	arg_12_0.m_desLab.text = GetI18NText(var_12_0.desc)
	arg_12_0.preview_reward_list = var_12_0.preview_reward_list

	arg_12_0.rewardList_:StartScroll(#arg_12_0.preview_reward_list)

	if var_12_0.difficulty == 2 then
		arg_12_0.isFinalController_:SetSelectedState("true")
	else
		arg_12_0.isFinalController_:SetSelectedState("false")

		local var_12_2 = NumberTools.IntToRomam(arg_12_0.curLevelID_)

		arg_12_0.m_difficultyLab.text = var_12_2
	end
end

function var_0_0.OnItemClick(arg_13_0, arg_13_1)
	if arg_13_0.index ~= arg_13_1 then
		arg_13_0.index = arg_13_1

		local var_13_0 = arg_13_0.difficultyList_:GetItemList()

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			iter_13_1:SetChoice(arg_13_0.index)
		end

		arg_13_0:Refresh()
	end
end

function var_0_0.indexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:RefreshData(arg_14_1)
	arg_14_2:RegistCallBack(function(arg_15_0)
		arg_14_0:OnItemClick(arg_15_0)
	end)
	arg_14_2:SetChoice(arg_14_0.index)
end

function var_0_0.rewardIndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.preview_reward_list[arg_16_1]
	local var_16_1 = clone(ItemTemplateData)

	var_16_1.id = var_16_0[1]

	if MythicCfg[arg_16_0.curLevelID_].difficulty == 1 then
		var_16_1.number = var_16_0[2]
	else
		var_16_1.number = nil
	end

	function var_16_1.clickFun(arg_17_0)
		ShowPopItem(POP_ITEM, {
			arg_17_0.id
		})
	end

	arg_16_2:SetData(var_16_1)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.difficultyList_:Dispose()
	arg_18_0.rewardList_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnMyticUpdate(arg_19_0)
	arg_19_0.difficultyList_:Refresh()
end

return var_0_0
