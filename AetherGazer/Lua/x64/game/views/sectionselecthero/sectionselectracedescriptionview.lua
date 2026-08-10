local var_0_0 = class("SectionSelectRaceDescriptionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationGodPopUPUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemList = {}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList) do
		iter_7_1:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.raceID_ = arg_8_0.params_.raceID
	arg_8_0.sameCamp_ = arg_8_0.params_.sameCamp
	arg_8_0.raceIDList_ = arg_8_0:GetRaceIDList()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.raceIDList_) do
		if not arg_8_0.itemList[iter_8_0] then
			local var_8_0 = Object.Instantiate(arg_8_0.godlistnewGo_, arg_8_0.contentTrs_)

			SetActive(var_8_0, true)

			arg_8_0.itemList[iter_8_0] = arg_8_0:GetItemClass().New(var_8_0)
		end

		local var_8_1 = arg_8_0.raceID_ == arg_8_0.raceIDList_[iter_8_0]

		arg_8_0.itemList[iter_8_0]:SetData(arg_8_0.raceIDList_[iter_8_0], var_8_1, arg_8_0.sameCamp_)
	end

	local var_8_2 = arg_8_0.contentTrs_.localPosition

	arg_8_0.contentTrs_.localPosition = Vector3(var_8_2.x, 0, 0)

	TimeTools.StartAfterSeconds(0.1, function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrs_)
	end, {})
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.raceID_ == arg_10_0.raceIDList_[arg_10_1]

	arg_10_2:SetData(arg_10_0.raceIDList_[arg_10_1], var_10_0, arg_10_0.sameCamp_)
end

function var_0_0.GetRaceIDList(arg_11_0)
	local var_11_0 = clone(RaceEffectCfg.all)

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		if arg_12_0 == arg_11_0.raceID_ then
			return true
		end

		if arg_12_1 == arg_11_0.raceID_ then
			return false
		end

		return arg_12_0 < arg_12_1
	end)

	return var_11_0
end

function var_0_0.GetItemClass(arg_13_0)
	return SectionSelectRaceDescriptionItem
end

return var_0_0
