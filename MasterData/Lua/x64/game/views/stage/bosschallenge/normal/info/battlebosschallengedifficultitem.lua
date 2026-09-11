local BattleBossChallengeDifficultItem = class("BattleBossChallengeDifficultItem", ReduxView)

function BattleBossChallengeDifficultItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.lightGo_ = Object.Instantiate(arg_1_3, arg_1_4.transform)

	SetActive(self.lightGo_, true)

	self.difficult_ = arg_1_5

	self:BindCfgUI()
	self:AddListeners()

	self.lightController_ = ControllerUtil.GetController(self.lightGo_.transform, "conName")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")

	local var_1_0 = GetTips("BOSS_LEVEL_" .. arg_1_5)

	self.textName_.text = var_1_0
	self.textName2_.text = var_1_0
	self.textName3_.text = var_1_0

	SetActive(self.gameObject_, true)
end

function BattleBossChallengeDifficultItem:AddListeners()
	self:AddBtnListener(self.buttonSelect_, nil, function()
		BattleBossChallengeNormalData:SetSelectDifficult(self.bossIndex_, self.difficult_)
		manager.notify:Invoke(BOSS_CHALLENGE_SWITCH_DIFFICULT, self.difficult_)
	end)
end

function BattleBossChallengeDifficultItem:SetData(arg_4_1)
	self.bossIndex_ = arg_4_1

	local var_4_0 = self.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(self.bossIndex_)

	if var_4_0 then
		self.lightController_:SetSelectedState("1")
		self.lockController_:SetSelectedState("1")
	else
		self.lightController_:SetSelectedState("0")
		self.lockController_:SetSelectedState("0")
	end

	self.isLock_ = var_4_0
end

function BattleBossChallengeDifficultItem:SwitchDifficult(arg_5_1)
	if self.difficult_ == arg_5_1 then
		self.selectController_:SetSelectedState("0")
	else
		self.selectController_:SetSelectedState("1")
	end
end

function BattleBossChallengeDifficultItem:Dispose()
	BattleBossChallengeDifficultItem.super.Dispose(self)
	Object.Destroy(self.lightGo_)
	Object.Destroy(self.gameObject_)

	self.lightGo_ = nil
	self.transform_ = nil
	self.gameObject_ = nil
end

return BattleBossChallengeDifficultItem
