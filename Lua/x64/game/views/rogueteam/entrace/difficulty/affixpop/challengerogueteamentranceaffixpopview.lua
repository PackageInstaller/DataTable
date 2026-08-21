local var_0_0 = class("ChallengRogueTeamEntranceAffixPopView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.itemList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.itemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = RogueTeamDifficultyCfg[arg_4_1]

	if #var_4_0.affix > 0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0.affix) do
			arg_4_0.itemList_[iter_4_0] = arg_4_0.itemList_[iter_4_0] or ChallengeRogueTeamEntranceAffixPopItem.New(arg_4_0.itemGo_, arg_4_0.parentGo_)

			arg_4_0.itemList_[iter_4_0]:SetData(iter_4_1)
		end

		for iter_4_2 = #arg_4_0.itemList_, #var_4_0.affix + 1, -1 do
			arg_4_0.itemList_[iter_4_2]:Show(false)
		end

		arg_4_0:Show(true)
	else
		arg_4_0:Show(false)
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

return var_0_0
