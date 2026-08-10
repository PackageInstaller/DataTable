local var_0_0 = class("ActivityHeroEnhanceBattleSettlementModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ActivityHeroEnhanceTools.GetBattleResultContentUIName(arg_2_2)

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.rewardItemList = {}
	arg_3_0.talentList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTalentItem), arg_3_0.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.RenderView(arg_7_0, arg_7_1)
	arg_7_0.talentIdList_ = arg_7_1.stageData.affixIDList

	arg_7_0.talentList_:StartScroll(4)
end

function var_0_0.IndexAwardItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewardItemList[arg_8_1]

	if ItemCfg[var_8_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_8_0.id].type then
		var_8_0.race = EquipCfg[var_8_0.id] and EquipCfg[var_8_0.id].race or 0
	end

	local var_8_1 = clone(ItemTemplateData)

	var_8_1.id = var_8_0.id
	var_8_1.number = var_8_0.num
	var_8_1.race = var_8_0.race

	function var_8_1.clickFun(arg_9_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end

	arg_8_2:SetData(var_8_1)
end

function var_0_0.IndexTalentItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.talentIdList_[arg_10_1]

	arg_10_2:SetData(arg_10_0.activityId_, var_10_0)
	arg_10_2:SetResult()
	arg_10_2:RefreshUI()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.talentList_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
