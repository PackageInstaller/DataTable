local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("ReserveProposalAdditionalView", var_0_0)

function var_0_1.InitSubViewCfg(arg_1_0)
	arg_1_0.subViewDic_ = {
		comboSkillView = {
			go = arg_1_0.comboSkillGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = arg_1_0.mimirInfoGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetMimirInfoViewClass)
		}
	}
	arg_1_0.schemeSwitchList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.switchListGo_, ReserveProposalSwitchItem)
end

function var_0_1.InitController(arg_2_0)
	arg_2_0.raceEffectController_ = arg_2_0.controllerExCollection_:GetController("raceEffect")
	arg_2_0.raceActiveController_ = arg_2_0.controllerExCollection_:GetController("raceActive")
	arg_2_0.btnStateController_ = arg_2_0.controllerExCollection_:GetController("btnState")
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0.schemeSwitchList_:Dispose()

	arg_3_0.schemeSwitchList_ = nil

	var_0_1.super.Dispose(arg_3_0)
end

function var_0_1.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_4_0.maxRaceID_,
			sameCamp = arg_4_0.sameCamp_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.saveBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_SAVE)
	end)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_APPLY)
	end)
	arg_4_0:AddBtnListener(arg_4_0.deleteBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_DELETE)
	end)
end

function var_0_1.RefreshUI(arg_9_0)
	arg_9_0:RefreshRace()
end

function var_0_1.RefreshSwitchList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.contIDList_ = arg_10_1
	arg_10_0.curSelectContID_ = arg_10_2

	local var_10_0 = table.indexof(arg_10_0.contIDList_, arg_10_0.curSelectContID_) or 1

	arg_10_0.schemeSwitchList_:StartScroll(#arg_10_0.contIDList_, var_10_0)

	arg_10_0.progressText_.text = string.format(GetTips("RESERVE_PROPOSAL_NUM"), arg_10_3, GameSetting.default_formation_num_max.value[1])
end

function var_0_1.RefreshSelect(arg_11_0, arg_11_1)
	arg_11_0.curSelectContID_ = arg_11_1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.schemeSwitchList_:GetItemList()) do
		iter_11_1:SetSelect(arg_11_1)
	end
end

function var_0_1.RefreshBtnPanel(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	if ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(arg_12_1):GetIsDirty() == true then
		arg_12_0.btnStateController_:SetSelectedState("save")
	elseif SectionSelectHeroTools.IsReserveProposalEqual(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, nil, arg_12_6) then
		arg_12_0.btnStateController_:SetSelectedState("cur")
	else
		arg_12_0.btnStateController_:SetSelectedState("normal")
	end
end

function var_0_1.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.contIDList_[arg_13_1]

	arg_13_2:SetProxy(arg_13_0.sectionProxy_)
	arg_13_2:SetData(var_13_0)
	arg_13_2:SetSelect(arg_13_0.curSelectContID_)
end

return var_0_1
