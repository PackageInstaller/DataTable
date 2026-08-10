local var_0_0 = class("SeaWarfareGmPanelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationGmUI"
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

	arg_4_0.normalStageList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexNormalStage), arg_4_0.normalStageListGo_, SeaWarfareGmButtonItem)
	arg_4_0.marinerSkillList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexMarinerSkill), arg_4_0.marinerSkillListGo_, SeaWarfareGmButtonItem)
	arg_4_0.skillList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSkill), arg_4_0.skillListGo_, SeaWarfareGmButtonItem)
	arg_4_0.tagList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTag), arg_4_0.tagListGo_, SeaWarfareGmButtonItem)
	arg_4_0.clickNormalStageHandler_ = handler(arg_4_0, arg_4_0.OnClickNormalStage)
	arg_4_0.clickMarinerSkillHandler_ = handler(arg_4_0, arg_4_0.OnClickMarinerSkill)
	arg_4_0.clickSkillStageHandler_ = handler(arg_4_0, arg_4_0.OnClickSkill)
	arg_4_0.clickTagHandler_ = handler(arg_4_0, arg_4_0.OnClickTag)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startNormalBattleBtn_, nil, function()
		if arg_5_0.selectNormaslStageID_ and arg_5_0.selectSkillID_ then
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(arg_5_0.selectMarinerDic_) do
				table.insert(var_6_0, iter_6_1)
			end

			SeaWarfareTools.LaunchBattle(arg_5_0.selectNormaslStageID_, arg_5_0.selectSkillID_, var_6_0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.openTagBtn_, nil, function()
		if arg_5_0.selectTagID_ then
			QWorldMgr:GetQWorldTagMgr():GotoTag(arg_5_0.selectTagID_)
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:ResetParams()
	arg_8_0:RefreshUI()
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.ResetParams(arg_10_0)
	arg_10_0.selectNormaslStageID_ = nil
	arg_10_0.selectSkillID_ = nil
	arg_10_0.selectTagID_ = nil
	arg_10_0.selectMarinerDic_ = {}
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.normalStageIDList_ = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.NORMAL)

	arg_12_0.normalStageList_:StartScroll(#arg_12_0.normalStageIDList_)

	arg_12_0.marinerIDList_ = SeaWarfareTools.GetMarinerIDList()

	arg_12_0.marinerSkillList_:StartScroll(#arg_12_0.marinerIDList_)

	arg_12_0.skillIDList_ = SeaWarfareTools.GetSkillIDList()

	arg_12_0.skillList_:StartScroll(#arg_12_0.skillIDList_)

	arg_12_0.tagIDList_ = SeaWarfareTools.GetTagIDList()

	arg_12_0.tagList_:StartScroll(#arg_12_0.tagIDList_)
end

function var_0_0.IndexNormalStage(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_0.normalStageIDList_[arg_13_1])
	arg_13_2:SetClickCallBack(arg_13_0.clickNormalStageHandler_)
	arg_13_2:SetSelect(arg_13_0.normalStageIDList_[arg_13_1] == arg_13_0.selectNormaslStageID_)
end

function var_0_0.IndexMarinerSkill(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.marinerIDList_[arg_14_1])
	arg_14_2:SetClickCallBack(arg_14_0.clickMarinerSkillHandler_)
	arg_14_2:SetSelect(arg_14_0.selectMarinerDic_[arg_14_0.marinerIDList_[arg_14_1]])
end

function var_0_0.IndexSkill(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_0.skillIDList_[arg_15_1])
	arg_15_2:SetClickCallBack(arg_15_0.clickSkillStageHandler_)
	arg_15_2:SetSelect(arg_15_0.skillIDList_[arg_15_1] == arg_15_0.selectSkillID_)
end

function var_0_0.IndexTag(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_0.tagIDList_[arg_16_1])
	arg_16_2:SetClickCallBack(arg_16_0.clickTagHandler_)
	arg_16_2:SetSelect(arg_16_0.tagIDList_[arg_16_1] == arg_16_0.selectTagID_)
end

function var_0_0.OnClickNormalStage(arg_17_0, arg_17_1)
	arg_17_0.selectNormaslStageID_ = arg_17_1

	local var_17_0 = arg_17_0.normalStageList_:GetItemList()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:SetSelect(arg_17_1 == iter_17_1:GetID())
	end
end

function var_0_0.OnClickMarinerSkill(arg_18_0, arg_18_1)
	arg_18_0.selectMarinerDic_[arg_18_1] = not arg_18_0.selectMarinerDic_[arg_18_1]

	local var_18_0 = arg_18_0.marinerSkillList_:GetItemList()

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		iter_18_1:SetSelect(arg_18_0.selectMarinerDic_[iter_18_1:GetID()])
	end
end

function var_0_0.OnClickSkill(arg_19_0, arg_19_1)
	arg_19_0.selectSkillID_ = arg_19_1

	local var_19_0 = arg_19_0.skillList_:GetItemList()

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		iter_19_1:SetSelect(arg_19_1 == iter_19_1:GetID())
	end
end

function var_0_0.OnClickTag(arg_20_0, arg_20_1)
	arg_20_0.selectTagID_ = arg_20_1

	local var_20_0 = arg_20_0.tagList_:GetItemList()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		iter_20_1:SetSelect(arg_20_1 == iter_20_1:GetID())
	end
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
	arg_21_0.normalStageList_:Dispose()
	arg_21_0.marinerSkillList_:Dispose()
	arg_21_0.skillList_:Dispose()
	arg_21_0.tagList_:Dispose()
end

return var_0_0
