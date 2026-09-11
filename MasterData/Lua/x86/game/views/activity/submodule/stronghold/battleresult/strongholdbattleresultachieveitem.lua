local StrongholdBattleResultAchieveItem = class("StrongholdBattleResultAchieveItem", ReduxView)

function StrongholdBattleResultAchieveItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdBattleResultAchieveItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleResultAchieveItem:InitUI()
	self:BindCfgUI()

	self.levelController = ControllerUtil.GetController(self.transform_, "state")
end

function StrongholdBattleResultAchieveItem:AddUIListener()
	return
end

function StrongholdBattleResultAchieveItem:SetData(arg_5_1)
	self.m_name.text = ActivityStrongholdAchievementCfg[arg_5_1].name

	self.levelController:SetSelectedIndex(math.max(0, ActivityStrongholdAchievementCfg[arg_5_1].level - 1))
end

return StrongholdBattleResultAchieveItem
