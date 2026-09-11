local DormCharaterFatigueShowView = class("DormCharaterFatigueShowView", ReduxView)

function DormCharaterFatigueShowView:OnCtor(arg_1_1)
	self.go = arg_1_1

	self:Init()
end

function DormCharaterFatigueShowView:Init()
	self:InitUI()
end

function DormCharaterFatigueShowView:InitUI()
	self:BindCfgUI(self.go)
end

function DormCharaterFatigueShowView:OnEnter()
	return
end

function DormCharaterFatigueShowView:RefreshView(arg_5_1)
	local var_5_0 = DormData:GetHeroTemplateInfo(arg_5_1)

	self.curFatigue.text = var_5_0:GetFatigue()
	self.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	self.recoverFatigue.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), var_5_0:GetRecoverFatigueNum())
end

function DormCharaterFatigueShowView:Dispose()
	DormCharaterFatigueShowView.super.Dispose(self)
end

return DormCharaterFatigueShowView
