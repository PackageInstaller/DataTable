local var_0_0 = class("ChallengeRogueTeamSectionSelectAttriDescriptionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/ChallengeRogueTeam/ChallengeRogueTeamFormationAttriPopUPUI"
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
	arg_8_0.heroList_ = arg_8_0.params_.heroList
	arg_8_0.attriDic_ = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroList_) do
		local var_8_0 = HeroCfg[iter_8_1]

		if var_8_0 then
			if not arg_8_0.attriDic_[var_8_0.ATK_attribute[1]] then
				arg_8_0.attriDic_[var_8_0.ATK_attribute[1]] = 0
			end

			arg_8_0.attriDic_[var_8_0.ATK_attribute[1]] = arg_8_0.attriDic_[var_8_0.ATK_attribute[1]] + 1
		end
	end

	arg_8_0.attriIDList_ = ChallengeRogueTeamData:GetAttriIDList()

	local var_8_1 = ChallengeRogueTeamTools.HasTeamEffectMaxLevel()

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.attriIDList_) do
		if not arg_8_0.itemList[iter_8_2] then
			local var_8_2 = Object.Instantiate(arg_8_0.godlistnewGo_, arg_8_0.contentTrs_)

			SetActive(var_8_2, true)

			arg_8_0.itemList[iter_8_2] = arg_8_0:GetItemClass().New(var_8_2)
		end

		local var_8_3 = arg_8_0.attriDic_[arg_8_0.attriIDList_[iter_8_2]]

		if var_8_3 and var_8_1 then
			var_8_3 = 3
		end

		arg_8_0.itemList[iter_8_2]:SetData(iter_8_2, arg_8_0.attriIDList_[iter_8_2], var_8_3)
	end
end

function var_0_0.GetItemClass(arg_9_0)
	return ChallengeRogueTeamSectionSelectAttriDescriptionItem
end

return var_0_0
