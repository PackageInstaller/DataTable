local var_0_0 = class("IlluEnemyFileDetail", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEnemyDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.itemList_ = {}
	arg_3_0.conList_ = {}
	arg_3_0.infoList_ = {}
	arg_3_0.skillList_ = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.enemyAvatarView_ = EnemyAvatarView.New(arg_4_0, arg_4_0.displayGo_)
	arg_4_0.riskCon_ = ControllerUtil.GetController(arg_4_0.transform_, "conName")
	arg_4_0.toggleController_ = arg_4_0.bossInfo_.transform:GetComponent("ControllerExCollection"):GetController("toggle")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.dataBtn_, nil, function()
		arg_5_0.toggleController_:SetSelectedState("data")
		arg_5_0:RefreshInfo()
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		arg_5_0.toggleController_:SetSelectedState("skill")
		arg_5_0:RefreshSkill()
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = MonsterCfg[arg_8_0.id_]

	arg_8_0.nameText_.text = GetMonsterName({
		arg_8_0.id_
	})
	arg_8_0.raceText_.text = GetTips("RACE_TYPE_" .. var_8_0.race)
	arg_8_0.descText_.text = GetI18NText(var_8_0.desc)

	arg_8_0.riskCon_:SetSelectedState(var_8_0.type)
	arg_8_0:UpdateData()
	arg_8_0.toggleController_:SetSelectedState("data")
	arg_8_0:RefreshInfo()
end

function var_0_0.RefreshInfo(arg_9_0)
	for iter_9_0 = 1, 3 do
		arg_9_0:UpdateItem(iter_9_0, arg_9_0.infoList_[iter_9_0])
	end

	for iter_9_1 = 4, #arg_9_0.itemList_ do
		arg_9_0.itemList_[iter_9_1]:Hide()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
end

function var_0_0.RefreshSkill(arg_10_0)
	for iter_10_0 = 1, 6 do
		arg_10_0:UpdateItem(iter_10_0, arg_10_0.skillList_[iter_10_0])
	end

	for iter_10_1 = 1, 6 do
		if string.len(arg_10_0.skillList_[iter_10_1].name) == 0 then
			arg_10_0.itemList_[iter_10_1]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.contentTrs_)
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.itemList_[arg_11_1] then
		local var_11_0 = Object.Instantiate(arg_11_0.itemGo_, arg_11_0.contentTrs_)

		arg_11_0.itemList_[arg_11_1] = IlluEnemyFileDetailItem.New(var_11_0)
	end

	arg_11_0.itemList_[arg_11_1]:RefreshUI(arg_11_2)
end

function var_0_0.OnEnter(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.ui:SetMainCamera("enemyFile")

	arg_12_0.id_ = arg_12_0.params_.id

	arg_12_0.enemyAvatarView_:OnEnter()
	arg_12_0.enemyAvatarView_:SetBossID(arg_12_0.id_)
	arg_12_0:RefreshUI()
end

function var_0_0.OnExit(arg_13_0)
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	arg_13_0.enemyAvatarView_:OnExit()
end

function var_0_0.UpdateData(arg_14_0)
	arg_14_0.infoList_ = {}
	arg_14_0.skillList_ = {}

	for iter_14_0 = 1, 3 do
		arg_14_0.infoList_[iter_14_0] = {
			isLock = false,
			name = string.format(GetTips("MONSTER_INFORMATION") .. iter_14_0),
			info = MonsterCfg[arg_14_0.id_]["information" .. iter_14_0]
		}
	end

	for iter_14_1 = 1, 6 do
		arg_14_0.skillList_[iter_14_1] = {
			isLock = false,
			name = MonsterCfg[arg_14_0.id_]["skill" .. iter_14_1],
			info = MonsterCfg[arg_14_0.id_]["skill_desc" .. iter_14_1]
		}
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.enemyAvatarView_:Dispose()

	arg_15_0.enemyAvatarView_ = nil

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.itemList_) do
		iter_15_1:Dispose()
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
