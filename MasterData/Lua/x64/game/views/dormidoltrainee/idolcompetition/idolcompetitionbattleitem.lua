local IdolCompetitionBattleItem = class("IdolCompetitionBattleItem", ReduxView)

function IdolCompetitionBattleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolCompetitionBattleItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.winLineController_ = self.lineController_:GetController("state")
	self.head1StateController_ = self.p1Controller_:GetController("state")
	self.head2StateController_ = self.p2Controller_:GetController("state")
	self.head1MeController_ = self.p1Controller_:GetController("position")
	self.head2MeController_ = self.p2Controller_:GetController("position")
end

function IdolCompetitionBattleItem:AddUIListener()
	self:AddBtnListener(self.p1Btn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
	self:AddBtnListener(self.p2Btn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
end

function IdolCompetitionBattleItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	self.click_ = arg_6_7

	if arg_6_1 then
		self.winLineController_:SetSelectedState("normal")
		self.head1StateController_:SetSelectedState("pending")
		self.head2StateController_:SetSelectedState("pending")
		self.head1MeController_:SetSelectedState("off")
		self.head2MeController_:SetSelectedState("off")

		return
	end

	if arg_6_2 then
		self.winLineController_:SetSelectedState(arg_6_5 == 1 and "up" or "under")
		self.head1StateController_:SetSelectedState(arg_6_5 == 1 and "win" or "lose")
		self.head2StateController_:SetSelectedState(arg_6_5 == 2 and "win" or "lose")
	else
		self.winLineController_:SetSelectedState("normal")
		self.head1StateController_:SetSelectedState("inconclusive")
		self.head2StateController_:SetSelectedState("inconclusive")
	end

	local var_6_0 = IdolCompetitionData:GetRacePlayerInfo(arg_6_6, arg_6_3)
	local var_6_1 = IdolCompetitionData:GetRacePlayerInfo(arg_6_6, arg_6_4)

	if var_6_0.npc == 0 then
		self.p1HeadImg_.sprite = ItemTools.getItemSprite(var_6_0.head)
	else
		self.p1HeadImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_6_0.head
	end

	if var_6_1.npc == 0 then
		self.p2HeadImg_.sprite = ItemTools.getItemSprite(var_6_1.head)
	else
		self.p2HeadImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_6_1.head
	end

	self.p1NameText_.text = var_6_0.name
	self.p2NameText_.text = var_6_1.name

	self.head1MeController_:SetSelectedState("off")
	self.head2MeController_:SetSelectedState("off")

	if arg_6_3 == USER_ID then
		self.head1MeController_:SetSelectedState("on")
	elseif arg_6_4 == USER_ID then
		self.head2MeController_:SetSelectedState("on")
	end
end

function IdolCompetitionBattleItem:Dispose()
	IdolCompetitionBattleItem.super.Dispose(self)
end

return IdolCompetitionBattleItem
