local var_0_0 = class("BossInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BossInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemList_ = {}
	arg_5_0.skillList_ = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()

	arg_12_0.id_ = arg_12_0.params_.bossID

	arg_12_0:UpdateView()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = MonsterCfg[arg_14_0.id_]

	arg_14_0.nameText_.text = GetMonsterName({
		arg_14_0.id_
	})
	arg_14_0.raceText_.text = GetTips("RACE_TYPE_" .. var_14_0.race)

	local var_14_1 = arg_14_0.params_.spritePath

	arg_14_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_14_1)
	arg_14_0.riskText_.text = NumberTools.IntToRomam(var_14_0.type + 1)

	arg_14_0:UpdateData()
	arg_14_0:RefreshSkill()
end

function var_0_0.UpdateData(arg_15_0)
	arg_15_0.skillList_ = GetMonsterSkillDesList({
		arg_15_0.id_
	})
end

function var_0_0.RefreshSkill(arg_16_0)
	for iter_16_0 = 1, 6 do
		if arg_16_0.skillList_[iter_16_0] then
			arg_16_0:UpdateItem(iter_16_0, arg_16_0.skillList_[iter_16_0])
		elseif arg_16_0.itemList_[iter_16_0] then
			arg_16_0.itemList_[iter_16_0]:Hide()
		end
	end

	arg_16_0.scrollviewSr_.normalizedPosition = Vector2(0, 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.contentTrs_)
end

function var_0_0.UpdateItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.itemList_[arg_17_1] then
		local var_17_0 = Object.Instantiate(arg_17_0.itemGo_, arg_17_0.contentTrs_)

		arg_17_0.itemList_[arg_17_1] = BossInfoItemView.New(var_17_0)
	end

	arg_17_0.itemList_[arg_17_1]:RefreshUI(arg_17_2)
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.itemList_) do
		iter_19_1:Dispose()
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
