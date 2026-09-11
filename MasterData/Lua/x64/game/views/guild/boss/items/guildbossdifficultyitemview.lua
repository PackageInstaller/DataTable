local GuildBossDifficultyItemView = class("GuildBossDifficultyItemView", ReduxView)

function GuildBossDifficultyItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossDifficultyItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossDifficultyItemView:InitUI()
	self:BindCfgUI()

	self.indexController_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.currentController_ = ControllerUtil.GetController(self.gameObject_.transform, "current")
end

function GuildBossDifficultyItemView:AddUIListener()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		local var_5_0, var_5_1 = GuildData:GetLastTime()

		if var_5_0 ~= "prepose" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		GuildAction.GuildBossChangeDifficulty(self.cfg_.boss_level)
	end)
end

function GuildBossDifficultyItemView:AddEventListeners()
	return
end

function GuildBossDifficultyItemView:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.data_ = arg_7_2
	self.cfg_ = ClubBossCfg[arg_7_2]
	self.rewardDataList_ = self.cfg_.preview_reward

	if not self.uiList_ then
		self.uiList_ = {}

		for iter_7_0, iter_7_1 in ipairs(self.rewardDataList_) do
			self.uiList_[iter_7_0] = CommonItemView.New((GameObject.Instantiate(self.commonGo, self.contentTrs)))
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs)
	end

	self:UpdateView()
end

local var_0_1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}
local var_0_2 = {
	"CLUB_BOSS_TIPS_1",
	"CLUB_BOSS_TIPS_2",
	"CLUB_BOSS_TIPS_3",
	"CLUB_BOSS_TIPS_4"
}

function GuildBossDifficultyItemView:UpdateView()
	self.indexController_:SetSelectedIndex(self.index_)

	self.conditionLabel_.text = ""

	if self.index_ > 1 then
		self.conditionLabel_.text = GetTips(var_0_2[self.index_ - 1])
	end

	self.difficult_.text = GetTips(var_0_1[self.index_])
	self.bloodLabel_.text = self.cfg_.boss_hp

	if self.uiList_ then
		for iter_8_0, iter_8_1 in ipairs(self.uiList_) do
			iter_8_1:SetData({
				id = self.rewardDataList_[iter_8_0][1],
				number = self.rewardDataList_[iter_8_0][2],
				clickFun = function(self)
					ShowPopItem(POP_ITEM, {
						self.id
					})
				end
			})
		end
	end

	if not GuildData:IsPassBossDifficulty(self.index_) then
		self.currentController_:SetSelectedState("locked")
	elseif GuildData:GetBossDifficulty() == self.index_ then
		self.currentController_:SetSelectedState("true")
	else
		self.currentController_:SetSelectedState("false")
	end
end

function GuildBossDifficultyItemView:OnEnter()
	self:AddEventListeners()
end

function GuildBossDifficultyItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossDifficultyItemView:OnMainHomeViewTop()
	return
end

function GuildBossDifficultyItemView:Dispose()
	self.data_ = nil

	if self.uiList_ then
		for iter_13_0, iter_13_1 in ipairs(self.uiList_) do
			iter_13_1:Dispose()
		end

		self.uiList_ = nil
	end

	GuildBossDifficultyItemView.super.Dispose(self)
end

return GuildBossDifficultyItemView
