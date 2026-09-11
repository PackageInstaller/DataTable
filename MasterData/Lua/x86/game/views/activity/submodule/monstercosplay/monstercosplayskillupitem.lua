local MonsterCosplaySkillUpItem = class("MonsterCosplaySkillUpItem", ReduxView)

function MonsterCosplaySkillUpItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function MonsterCosplaySkillUpItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonsterCosplaySkillUpItem:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.affixCfg = TalentTreeCfg[arg_3_1]
	self.cfg = ActivityMonsterCosplaySkillCfg[self.affixCfg.stage]
	self.index = arg_3_3
	self.callBack = arg_3_2
	self.monsterData = arg_3_4
	self.monsterID = arg_3_5

	self:UpdateView()
end

function MonsterCosplaySkillUpItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller_:GetController("state")
	self.placeController = self.controller_:GetController("place")
	self.colorController = self.controller_:GetController("state2")
	self.color2Controller = self.controller_:GetController("state3")
end

function MonsterCosplaySkillUpItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.callBack then
			self.callBack(self.index, self.stateController)
		end
	end)
end

function MonsterCosplaySkillUpItem:UpdateView()
	self.nameTxt_.text = GetI18NText(self.affixCfg.name)
	self.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(self.affixCfg.id)
	self.descTxt_.text = GetI18NText(self.affixCfg.desc)
	self.skillIndexTxt_.text = GetI18NText(self.cfg.skill_index)
	self.skillIndexTxt2_.text = GetI18NText(self.cfg.skill_index)

	self.placeController:SetSelectedState(tostring(table.indexof(ActivityMonsterCosplayCfg[self.monsterID].skill_list, self.cfg.id)))
	self.stateController:SetSelectedState(self.monsterData.enhancedSkill[self.affixCfg.id] and "get" or "normal")
	self.colorController:SetSelectedState(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
	self.color2Controller:SetSelectedState(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
end

function MonsterCosplaySkillUpItem:OnExit()
	return
end

function MonsterCosplaySkillUpItem:Dispose()
	MonsterCosplaySkillUpItem.super.Dispose(self)
end

return MonsterCosplaySkillUpItem
