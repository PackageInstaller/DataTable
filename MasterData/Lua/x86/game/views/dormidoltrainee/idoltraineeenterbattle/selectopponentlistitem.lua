local SelectOpponentListItem = class("SelectOpponentListItem", ReduxView)

function SelectOpponentListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SelectOpponentListItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
	self:InitAbilityItem()

	self.typeController_ = self.mainControllerEx_:GetController("strenthTier")
end

function SelectOpponentListItem:AddUIListener()
	self:AddBtnListener(self.challengeBtn_, nil, function()
		local var_4_0 = IdolTraineeData:GetCurPVPStage()

		if self.curUserID_ and self.friendType and var_4_0 then
			BackHomeCricketAction:AskPvPBattleData(self.curUserID_, var_4_0)
		end
	end)
	self:AddBtnListener(self.compareBtn_, nil, function()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = self.curUserID_,
			friendType = self.friendType
		})
	end)
	self.commonPortrait_:RegisteClickCallback(function()
		if self.curUserID_ then
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.curUserID_, true)
		end
	end)
end

function SelectOpponentListItem:InitAbilityItem()
	self.abilityList = {}

	for iter_7_0 = 1, IdolTraineeConst.AbilityNum do
		self.abilityList[iter_7_0] = IdolTraineeAbilityItem.New(self["propitem" .. iter_7_0 .. "Go_"])
	end
end

function SelectOpponentListItem:SetData(arg_8_1, arg_8_2)
	self.curUserID_ = arg_8_1
	self.friendType = arg_8_2

	local var_8_0 = IdolTraineeTools:GetOpponentData(arg_8_1, arg_8_2)

	self.playerName_.text = GetI18NText(var_8_0.nick)

	self.commonPortrait_:RenderHead(var_8_0.icon)
	self.commonPortrait_:RenderFrame(var_8_0.icon_frame)

	self.heroIcon_.sprite = IdolTraineeTools.GetBackHomeHeadSprite(var_8_0.skin_id)
	self.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(var_8_0.hero_id)

	local var_8_1 = 0

	for iter_8_0 = 1, IdolTraineeConst.AbilityNum do
		self.abilityList[iter_8_0]:SetData(var_8_0.property[iter_8_0])

		var_8_1 = var_8_1 + var_8_0.property[iter_8_0]
	end

	local var_8_2 = 0

	for iter_8_1, iter_8_2 in pairs((IdolTraineeData:GetCurAttackHeroInfo())) do
		for iter_8_3 = 1, IdolTraineeConst.AbilityNum do
			var_8_2 = var_8_2 + iter_8_2[iter_8_3]
		end
	end

	if var_8_1 / var_8_2 < 0.8 then
		self.typeController_:SetSelectedState("strong")
	elseif var_8_1 / var_8_2 > 1.1 then
		self.typeController_:SetSelectedState("weak")
	else
		self.typeController_:SetSelectedState("middle")
	end
end

function SelectOpponentListItem:Dispose()
	self.commonPortrait_:Dispose()

	if self.abilityList then
		for iter_9_0, iter_9_1 in pairs(self.abilityList) do
			iter_9_1:Dispose(self)
		end
	end

	SelectOpponentListItem.super.Dispose(self)
end

return SelectOpponentListItem
