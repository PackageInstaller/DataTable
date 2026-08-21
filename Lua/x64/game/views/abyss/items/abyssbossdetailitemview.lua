local var_0_0 = class("AbyssBossDetailItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.itemList_ = {}
	arg_2_0.skillList_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.id_ = arg_6_2
	arg_6_0.monsterCollectId_ = AbyssUICfg[arg_6_0.id_].enemy_id

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = MonsterCfg[arg_7_0.monsterCollectId_]

	arg_7_0.nameText_.text = GetMonsterName({
		arg_7_0.monsterCollectId_
	})
	arg_7_0.raceText_.text = GetTips("RACE_TYPE_" .. var_7_0.race)
	arg_7_0.riskText_.text = NumberTools.IntToRomam(var_7_0.type + 1)
	arg_7_0.portraitImage_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. arg_7_0.monsterCollectId_)

	arg_7_0:UpdateData()
	arg_7_0:RefreshSkill()
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0.skillList_ = GetMonsterSkillDesList({
		arg_8_0.monsterCollectId_
	})
end

function var_0_0.RefreshSkill(arg_9_0)
	for iter_9_0 = 1, 6 do
		if arg_9_0.skillList_[iter_9_0] then
			arg_9_0:UpdateItem(iter_9_0, arg_9_0.skillList_[iter_9_0])
		elseif arg_9_0.itemList_[iter_9_0] then
			arg_9_0.itemList_[iter_9_0]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
end

function var_0_0.UpdateItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.itemList_[arg_10_1] then
		local var_10_0 = Object.Instantiate(arg_10_0.itemGo_, arg_10_0.contentTrs_)

		arg_10_0.itemList_[arg_10_1] = AffixSelectBossInfoItem.New(var_10_0)
	end

	arg_10_0.itemList_[arg_10_1]:RefreshUI(arg_10_2)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.itemList_) do
		iter_14_1:Dispose()
	end

	arg_14_0.itemList_ = nil
	arg_14_0.data_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
