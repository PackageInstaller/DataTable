local ActivityHeroEnhanceBattleSettlementModule = class("ActivityHeroEnhanceBattleSettlementModule", ReduxView)

function ActivityHeroEnhanceBattleSettlementModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = self:InstView(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityHeroEnhanceBattleSettlementModule:InstView(arg_2_1, arg_2_2)
	return (Object.Instantiate(Asset.Load((ActivityHeroEnhanceTools.GetBattleResultContentUIName(arg_2_2))), arg_2_1))
end

function ActivityHeroEnhanceBattleSettlementModule:BuildContext()
	self.rewardItemList = {}
	self.talentList_ = LuaList.New(handler(self, self.IndexTalentItem), self.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function ActivityHeroEnhanceBattleSettlementModule:Init()
	self:BindCfgUI()
	self:BuildContext()
end

function ActivityHeroEnhanceBattleSettlementModule:OnEnter()
	return
end

function ActivityHeroEnhanceBattleSettlementModule:OnExit()
	return
end

function ActivityHeroEnhanceBattleSettlementModule:RenderView(arg_7_1)
	self.talentIdList_ = arg_7_1.stageData.affixIDList

	self.talentList_:StartScroll(4)
end

function ActivityHeroEnhanceBattleSettlementModule:IndexAwardItem(arg_8_1, arg_8_2)
	local var_8_0 = self.rewardItemList[arg_8_1]

	if ItemCfg[self.rewardItemList[arg_8_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_8_0.id].type then
		if EquipCfg[var_8_0.id] then
			var_8_0.race = EquipCfg[var_8_0.id].race or 0
		end
	end

	local var_8_1 = clone(ItemTemplateData)

	var_8_1.id = var_8_0.id
	var_8_1.number = var_8_0.num
	var_8_1.race = var_8_0.race

	function var_8_1:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_8_2:SetData(var_8_1)
end

function ActivityHeroEnhanceBattleSettlementModule:IndexTalentItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.activityId_, self.talentIdList_[arg_10_1])
	arg_10_2:SetResult()
	arg_10_2:RefreshUI()
end

function ActivityHeroEnhanceBattleSettlementModule:Dispose()
	self.talentList_:Dispose()
	ActivityHeroEnhanceBattleSettlementModule.super.Dispose(self)
end

return ActivityHeroEnhanceBattleSettlementModule
