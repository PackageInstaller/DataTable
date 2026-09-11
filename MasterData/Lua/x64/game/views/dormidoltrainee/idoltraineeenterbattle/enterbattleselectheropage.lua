local EnterBattleSelectHeroPage = class("EnterBattleSelectHeroPage", ReduxView)

function EnterBattleSelectHeroPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EnterBattleSelectHeroPage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.charaItem_ = {}

	self:BindCfgUI(self.changeCharaGo_, self.charaItem_)

	self.infoPage_ = IdolTraineeTrainInfoPage.New(self.heroInfoSubView_)
	self.heroList_ = {}
	self.curHeroID_ = 0
	self.curHeroIndex_ = 0
	self.heroUIList_ = LuaList.New(handler(self, self.IndexItem), self.heroListGo_, IdolTraineeHeadItem)
	self.detailController_ = self.mainControllerEx_:GetController("showDetail")
	self.curAtkController_ = self.mainControllerEx_:GetController("curAtk")
	self.curDefController_ = self.mainControllerEx_:GetController("curDef")
end

function EnterBattleSelectHeroPage:AddUIListener()
	self:AddBtnListener(self.setAttackCharaBtn_, nil, function()
		IdolTraineeAction.RequestSetAttackHero(self.curHeroID_, function()
			self:RefreshUI()
			IdolTraineeCampBridge.GenerateAttackHero(self.curHeroID_)
		end)
	end)
	self:AddBtnListener(self.setDefendCharaBtn_, nil, function()
		IdolTraineeAction.RequestSetDefendHero(self.curHeroID_, function()
			self:RefreshUI()
		end)
	end)
end

function EnterBattleSelectHeroPage:ShowPage(arg_8_1)
	if self.showFlag == arg_8_1 then
		return
	end

	self.showFlag = arg_8_1

	if arg_8_1 then
		self.detailController_:SetSelectedState("true")
		self:OnEnter()

		if self.showCallBack then
			self.showCallBack()
		end
	else
		self.detailController_:SetSelectedState("false")
		self:OnExit()

		if self.closeCallBack then
			self.closeCallBack()
		end
	end
end

function EnterBattleSelectHeroPage:SetShowCallBack(arg_9_1, arg_9_2)
	if arg_9_1 then
		self.showCallBack = arg_9_1
	end

	if arg_9_2 then
		self.closeCallBack = arg_9_2
	end
end

function EnterBattleSelectHeroPage:OnEnter()
	self.infoPage_:RegisterEvents()

	if self.showFlag then
		self:RefreshUI()
	end
end

function EnterBattleSelectHeroPage:OnExit()
	if self.showFlag then
		-- block empty
	end

	self.infoPage_:RemoveAllEventListener()
end

function EnterBattleSelectHeroPage:RefreshUI()
	self.heroList_ = IdolTraineeData:GetIdolHeroList() or {}

	DormTools.SortBattleHeroList(self.heroList_)

	if not self.curHeroID_ or self.curHeroID_ == 0 then
		for iter_12_0, iter_12_1 in pairs((IdolTraineeData:GetCurAttackHero())) do
			if iter_12_1 == true then
				self.curHeroID_ = iter_12_0
			end
		end
	end

	if self.curHeroID_ then
		self.curHeroIndex_ = table.keyof(self.heroList_, self.curHeroID_)
		self.charaItem_.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.curHeroID_)
	end

	IdolTraineeCampBridge.GenerateAttackHero(self.curHeroID_)
	self:UpdateView(self.curHeroID_)
	self.heroUIList_:StartScroll(#self.heroList_)
end

function EnterBattleSelectHeroPage:UpdateView(arg_13_1)
	self.curHeroID_ = arg_13_1

	local var_13_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(self.curHeroID_)

	self.curDefController_:SetSelectedState(IdolTraineeTools:CheckHeroIsDefine(self.curHeroID_) and "true" or "false")
	self.curAtkController_:SetSelectedState(IdolTraineeTools:CheckHeroIsAttack(self.curHeroID_) and "true" or "false")
	self.infoPage_:RefreshUI(var_13_0)
end

function EnterBattleSelectHeroPage:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.heroList_[arg_14_1], self.curHeroID_, function()
		if self.curHeroID_ ~= 0 and self.curHeroIndex_ ~= 0 then
			local var_15_0 = self.heroUIList_:GetItemByIndex(self.curHeroIndex_)

			if var_15_0 then
				var_15_0:SelectOff()
			end
		end

		self.curHeroIndex_ = arg_14_1

		arg_14_2:SelectOn()
		self:UpdateView(self.heroList_[arg_14_1])
	end)
end

function EnterBattleSelectHeroPage:Dispose()
	if self.heroUIList_ then
		self.heroUIList_:Dispose()

		self.heroUIList_ = nil
	end

	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	EnterBattleSelectHeroPage.super.Dispose(self)
end

return EnterBattleSelectHeroPage
