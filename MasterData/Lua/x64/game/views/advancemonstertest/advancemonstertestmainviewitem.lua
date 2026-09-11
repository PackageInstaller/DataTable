local AdvanceMonsterTestMainViewItem = class("AdvanceMonsterTestMainViewItem", ReduxView)

function AdvanceMonsterTestMainViewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AdvanceMonsterTestMainViewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceMonsterTestMainViewItem:InitUI()
	self:BindCfgUI()
end

function AdvanceMonsterTestMainViewItem:SetData(arg_4_1)
	self.stageID_ = arg_4_1

	self:UpdateView()
end

function AdvanceMonsterTestMainViewItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/advanceMonsterAffixView", {
			stageID = self.stageID_
		})
	end)
end

function AdvanceMonsterTestMainViewItem:UpdateView()
	if ActivityAdvanceMonsterTestCfg[self.stageID_].type == 1 then
		self:UpdateCurrentUI()
	else
		self:UpdateLookBackUI()
	end
end

function AdvanceMonsterTestMainViewItem:UpdateCurrentUI()
	self.nameText_.text = GetI18NText(BattleActivityAdvanceMonsterTestCfg[ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id].name)
	self.pointText_.text = AdvanceMonsterTestData:GetStagePoint(self.stageID_)

	local var_8_0 = ""

	for iter_8_0, iter_8_1 in pairs(ActivityAdvanceMonsterTestCfg[self.stageID_].boss_list) do
		var_8_0 = var_8_0 .. iter_8_1
	end

	self.image_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_8_0)
end

function AdvanceMonsterTestMainViewItem:UpdateLookBackUI()
	self.nameText_.text = GetI18NText(BattleActivityAdvanceMonsterTestCfg[ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id].name)
	self.descText_.text = GetI18NText(BattleActivityAdvanceMonsterTestCfg[ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id].tips)
end

function AdvanceMonsterTestMainViewItem:Dispose()
	AdvanceMonsterTestMainViewItem.super.Dispose(self)
end

return AdvanceMonsterTestMainViewItem
