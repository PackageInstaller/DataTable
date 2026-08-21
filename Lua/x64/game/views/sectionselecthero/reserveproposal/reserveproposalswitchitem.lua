local var_0_0 = class("ReserveProposalSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerExCollection_:GetController("select")
	arg_3_0.tempController_ = arg_3_0.controllerExCollection_:GetController("temp")
	arg_3_0.headItemList_ = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_0.headContentTrans_:GetChild(iter_3_0 - 1).gameObject

		arg_3_0.headItemList_[iter_3_0] = SectionSmallHeroItem.New(var_3_0)
	end

	arg_3_0.tagItemList_ = {}

	local var_3_1 = arg_3_0.tagContentTrans_.childCount

	for iter_3_1 = 1, var_3_1 do
		local var_3_2 = arg_3_0.tagContentTrans_:GetChild(iter_3_1 - 1).gameObject

		arg_3_0.tagItemList_[iter_3_1] = ReserveProposalAttributeTagItem.New(var_3_2)
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_PROPOSAL, arg_4_0.contID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.renameBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_RENAME, arg_4_0.contID_)
	end)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.headItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.headItemList_ = nil

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.tagItemList_) do
		iter_7_3:Dispose()
	end

	arg_7_0.tagItemList_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetProxy(arg_8_0, arg_8_1)
	arg_8_0.sectionProxy_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	if not arg_9_0.reserveParams_ then
		arg_9_0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, arg_9_1)
	end

	arg_9_0.reserveParams_.contID = arg_9_1
	arg_9_0.contID_ = arg_9_1
	arg_9_0.reserveTemplate_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL)
	arg_9_0.contData_ = arg_9_0.reserveTemplate_:GetContDataTemplateById(arg_9_0.contID_)

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshName()
	arg_10_0:RefreshHeroItemList()
	arg_10_0:RefreshTagItemList()
end

function var_0_0.RefreshName(arg_11_0)
	local var_11_0 = arg_11_0.contData_:GetIsTemp()

	arg_11_0.tempController_:SetSelectedState(tostring(var_11_0))

	if not var_11_0 then
		arg_11_0.nameText_.text = arg_11_0.contData_:GetName()
	end
end

function var_0_0.RefreshHeroItemList(arg_12_0)
	local var_12_0 = arg_12_0.sectionProxy_:GetOuterLockHeroList()

	arg_12_0.heroDataList_ = arg_12_0.contData_:GetHeroList()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroDataList_) do
		local var_12_1 = iter_12_1:GetHeroID()

		arg_12_0.headItemList_[iter_12_0]:SetData(var_12_1)
		arg_12_0.headItemList_[iter_12_0]:RefreshLock(table.indexof(var_12_0, var_12_1) ~= false)
	end
end

function var_0_0.RefreshTagItemList(arg_13_0)
	local var_13_0 = arg_13_0.reserveTemplate_:GetAttributeTagList(arg_13_0.contID_)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		arg_13_0.tagItemList_[iter_13_0]:SetData(iter_13_1)
		arg_13_0.tagItemList_[iter_13_0]:Show(true)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0.tagItemList_ do
		arg_13_0.tagItemList_[iter_13_2]:Show(false)
	end
end

function var_0_0.SetSelect(arg_14_0, arg_14_1)
	arg_14_0.selectController_:SetSelectedState(tostring(arg_14_0.contID_ == arg_14_1))

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.tagItemList_) do
		iter_14_1:SetColor(arg_14_0.contID_ == arg_14_1)
	end
end

return var_0_0
