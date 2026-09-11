local MultHeartDemonCombatItem = class("MultHeartDemonCombatItem", ReduxView)

function MultHeartDemonCombatItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MultHeartDemonCombatItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonCombatItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.isPlayer then
			self:GoToHeroTeamPage()
		end
	end)

	if self.swapBtn_ then
		self:AddBtnListener(self.swapBtn_, nil, function()
			if self.isPlayer then
				self.callback(self.index)
			end
		end)
	end

	if self.swapBtn2_ then
		self:AddBtnListener(self.swapBtn2_, nil, function()
			if self.isPlayer then
				self:GoToHeroTeamPage()
			end
		end)
	end

	if self.changeBtn1_ then
		self:AddBtnListener(self.changeBtn1_, nil, function()
			self.swapCallback(self.index)
		end)
		self:AddBtnListener(self.changeBtn2_, nil, function()
			self.swapCallback(self.index)
		end)
	end

	if self.tipsBtn_ then
		self:AddBtnListener(self.tipsBtn_, nil, function()
			self:ShowAffixInfo()
		end)
	end
end

function MultHeartDemonCombatItem:ShowAffixInfo()
	SetActive(self.tipsGo_, true)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		self:HideAffixInfo()
	end, 3, 1)

	self.countdownTimer_:Start()
end

function MultHeartDemonCombatItem:HideAffixInfo()
	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	SetActive(self.tipsGo_, false)
end

function MultHeartDemonCombatItem:GoToHeroTeamPage()
	JumpTools.GoToSystem("/multHeartDemonHeroTeamInfo", {
		clickIndex = self.index,
		difficult = self.difficult,
		activityID = self.activityID,
		stage_id = self.stage_id,
		stageType = BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON,
		isLock = self.isLock
	})
end

function MultHeartDemonCombatItem:InitUI()
	self:BindCfgUI()

	self.normalController = self.collection:GetController("normal")
	self.pressController = self.collection:GetController("Press")
	self.imgLanController = self.collection:GetController("Imglan")
	self.powerUpController = self.collection:GetController("Selected")
	self.HpController = self.collection:GetController("bar")
	self.deathController = self.collection:GetController("disable")
	self.handOffController = self.collection:GetController("handoff")
	self.ImgzzController = self.collection:GetController("Imgzz")
	self.fgController = self.collection:GetController("fg")
	self.Imgzz02Controller = self.collection:GetController("Imgzz02")
	self.affixController = self.collection:GetController("affix")
end

function MultHeartDemonCombatItem:SetData(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9, arg_15_10, arg_15_11)
	self.index = arg_15_2
	self.data = arg_15_1
	self.cfg = arg_15_4
	self.isPlayer = self.index <= 3
	self.selectList = arg_15_3 or {}
	self.difficult = arg_15_5
	self.activityID = arg_15_6
	self.playerIndex = arg_15_7
	self.aiIndex = arg_15_8
	self.stage_id = arg_15_9
	self.callback = arg_15_10
	self.swapCallback = arg_15_11
	self.isLock = MultHeartDemonData:GetDataByPara("isLock") or false

	if self.isLock == false then
		self.playerIndex = 1
	end

	self:UpdateView()
end

function MultHeartDemonCombatItem:ShowSwapActiveBtn(arg_16_1)
	self.handOffController:SetSelectedState(arg_16_1 and "state0" or "state1")
end

function MultHeartDemonCombatItem:RestoreSwapActiveBtn()
	if self:IsEmptySlot() then
		self:ShowSwapActiveBtn(next(self.selectList))
	else
		self:ShowSwapActiveBtn(not self.isLock)
	end
end

function MultHeartDemonCombatItem:SetSwapEnabled(arg_18_1)
	local var_18_0 = arg_18_1 and "state0" or "state1"

	if self:IsEmptySlot() then
		self.Imgzz02Controller:SetSelectedState("state1")
		self.ImgzzController:SetSelectedState(var_18_0)
	else
		self.Imgzz02Controller:SetSelectedState(var_18_0)
		self.ImgzzController:SetSelectedState("state1")
	end

	if arg_18_1 then
		self:ShowSwapActiveBtn(false)
	else
		self:RestoreSwapActiveBtn()
	end
end

function MultHeartDemonCombatItem:SetHighlighted(arg_19_1)
	self.fgController:SetSelectedState(arg_19_1 and "state0" or "state1")
end

function MultHeartDemonCombatItem:IsEmptySlot()
	return self.isPlayer and self.selectList[self.index] == nil
end

function MultHeartDemonCombatItem:ColllectImageComsRecursive()
	self.collectedImgs = self.gameObject_:GetComponentsInChildren(typeof(Image), true):ToTable()
end

function MultHeartDemonCombatItem:SetGreyRecursive(arg_22_1)
	if self.collectedImgs == nil then
		self:ColllectImageComsRecursive()
	end

	for iter_22_0, iter_22_1 in pairs(self.collectedImgs) do
		manager.effect:SetGrey(iter_22_1, arg_22_1)
	end
end

function MultHeartDemonCombatItem:SetAffix()
	for iter_23_0, iter_23_1 in ipairs(self.cfg.trial_hero) do
		if self.selectList[self.index] == iter_23_1 and self.cfg.hero_attrib[iter_23_0] and #self.cfg.hero_attrib[iter_23_0] > 0 then
			self.affixController:SetSelectedIndex(0)

			return
		end
	end

	self.affixController:SetSelectedIndex(1)
end

function MultHeartDemonCombatItem:UpdatePlayer()
	local var_24_0 = self.selectList[self.index]

	self.normalController:SetSelectedState(self.selectList[self.index] and "state0" or "state1")
	self:SetSwapEnabled(false)
	self:SetHighlighted(false)

	local var_24_1 = false

	if var_24_0 then
		self.iconImg_.sprite = HeroStandardSystemCfg[var_24_0] and pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. HeroStandardSystemCfg[var_24_0].skin_id) or pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. HeroData:GetHeroUsingSkinInfo(var_24_0).id)

		self.pressController:SetSelectedState("state0")

		if self.data.heroHPList and self.data.heroHPList[var_24_0] then
			local var_24_2 = self.data.heroHPList[var_24_0]

			if self.data.heroHPList[var_24_0] == 0 then
				self.HPSlider_.value = 0
				var_24_1 = true

				self.deathController:SetSelectedState("state0")
				self.powerUpController:SetSelectedState("state1")
			else
				self.HPSlider_.value = var_24_2 / 100

				self.deathController:SetSelectedState("state1")
				self.powerUpController:SetSelectedState("state0")
			end

			self.HPTxt_.text = var_24_2 .. "%"
		else
			self.HPSlider_.value = 1

			self.deathController:SetSelectedState("state1")

			self.HPTxt_.text = "100%"

			self.powerUpController:SetSelectedState(self.index == self.playerIndex and "state0" or "state1")
		end
	else
		self.pressController:SetSelectedState("state1")
		self.HpController:SetSelectedState("state1")
		self.deathController:SetSelectedState("state1")
		self.powerUpController:SetSelectedState(self.index == self.playerIndex and "state0" or "state1")
	end

	self:SetGreyRecursive(var_24_1)

	if self.isLock == false then
		self.powerUpController:SetSelectedState("state1")
	end

	self:RestoreSwapActiveBtn()
	SetActive(self.tipsGo_, false)
	self.affixController:SetSelectedIndex(1)
	self:SetAffix()
end

function MultHeartDemonCombatItem:UpdateAI()
	self.normalController:SetSelectedState("state1")

	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg.heart_damon_id[self.index - 3] - 4000)

	self.HpController:SetSelectedState("state0")
	self.pressController:SetSelectedState("state0")
	self.deathController:SetSelectedState("state1")

	local var_25_0 = false

	if self.data then
		if self.data.heroHPList and self.data.heroHPList[self.cfg.heart_damon_id[self.index - 3]] then
			if self.data.heroHPList[self.cfg.heart_damon_id[self.index - 3]] == 0 then
				self.HPSlider_.value = 0
				var_25_0 = true

				self.deathController:SetSelectedState("state0")
				self.powerUpController:SetSelectedState("state1")
			else
				self.HPSlider_.value = self.data.heroHPList[self.cfg.heart_damon_id[self.index - 3]] / 100

				self.deathController:SetSelectedState("state1")
				self.powerUpController:SetSelectedState("state0")
			end

			self.HPTxt_.text = self.data.heroHPList[self.cfg.heart_damon_id[self.index - 3]] .. "%"
		else
			self.HPSlider_.value = 1
			self.HPTxt_.text = "100%"

			self.powerUpController:SetSelectedState(self.index - 3 == self.aiIndex and "state0" or "state1")
		end
	else
		self.HPSlider_.value = 1

		self.deathController:SetSelectedState("state1")

		self.HPTxt_.text = "100%"

		self.powerUpController:SetSelectedState(self.index - 3 == self.aiIndex and "state0" or "state1")
	end

	self:SetGreyRecursive(var_25_0)

	if self.isLock == false then
		self.powerUpController:SetSelectedState("state1")
	end
end

function MultHeartDemonCombatItem:UpdateView()
	if self.isPlayer then
		self:UpdatePlayer()
	else
		self:UpdateAI()
	end
end

function MultHeartDemonCombatItem:OnEnter()
	self:UpdateView()
end

function MultHeartDemonCombatItem:OnExit()
	self:HideAffixInfo()

	self.collectedImgs = nil
end

function MultHeartDemonCombatItem:Dispose()
	MultHeartDemonCombatItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonCombatItem
