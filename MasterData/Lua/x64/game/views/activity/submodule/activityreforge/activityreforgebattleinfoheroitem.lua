local ActivityReforgeBattleInfoHeroItem = class("ActivityReforgeBattleInfoHeroItem", ReduxView)

function ActivityReforgeBattleInfoHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeBattleInfoHeroItem:Init()
	self:InitUI()
end

function ActivityReforgeBattleInfoHeroItem:InitUI()
	self:BindCfgUI()

	self.heroHeadItem_ = ActivityReforgeHeroHeadItem.New(self.heroHeadGo_)
end

function ActivityReforgeBattleInfoHeroItem:SetData(arg_4_1, arg_4_2)
	local var_4_0 = ActivityReforgeData:GetFinishWaveHeroInfo(arg_4_1, arg_4_2)

	if var_4_0.leftHp <= 0 then
		SetActive(self.diePanelGo_, true)

		self.curHpImage_.fillAmount = 0
	else
		SetActive(self.diePanelGo_, false)

		self.curHpImage_.fillAmount = var_4_0.leftHp / var_4_0.maxHp
	end

	self.heroHeadItem_:SetData(arg_4_2)
end

function ActivityReforgeBattleInfoHeroItem:Dispose()
	self.heroHeadItem_:Dispose()

	self.heroHeadItem_ = nil

	ActivityReforgeBattleInfoHeroItem.super.Dispose(self)
end

return ActivityReforgeBattleInfoHeroItem
