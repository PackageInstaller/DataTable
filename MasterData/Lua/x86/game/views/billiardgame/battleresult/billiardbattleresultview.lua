local BilliardBattleResultView = class("BilliardBattleResultView", ReduxView)

function BilliardBattleResultView:UIName()
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_CheckoutPopUI"
end

function BilliardBattleResultView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardBattleResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BilliardBattleResultView:InitUI()
	self:BindCfgUI()

	self.statusController = self.controller_:GetController("Checkout")
	self.foodController = self.controller_:GetController("Winfood")
	self.context = {
		victory = false
	}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.foodItemList_, BilliardBattleResultFoodItem)
end

function BilliardBattleResultView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Render(self.foodItems[arg_5_1], self)
end

function BilliardBattleResultView:AddUIListener()
	self.AddBtnListener(self, self.sucBtn_, self, function()
		self:OnSucBtnClick()
	end)
	self.AddBtnListener(self, self.backBtn_, self, function()
		self:OnBackBtnClick()
	end)
	self.AddBtnListener(self, self.maskBtn_, self, function()
		self:OnMaskBtnClick()
	end)
end

function BilliardBattleResultView:OnSucBtnClick()
	if self.context.victory then
		OnExitBilliardBattle(self.context.victory)
	else
		manager.ui:SetCanvasAlpha(0)
		BilliardGameMgr:Restart()
	end
end

function BilliardBattleResultView:OnMaskBtnClick()
	if self.isTipsOpen then
		SetActive(self.tipsObj_, false)

		self.isTipsOpen = false
	end
end

function BilliardBattleResultView:OnChildClick(arg_12_1)
	self.isTipsOpen = true

	SetActive(self.tipsObj_, true)

	self.tipsObj_.transform.position = arg_12_1:GetTipTrans().position
	self.tipsTxt_.text = ItemTools.getItemDesc(arg_12_1:GetItemId())
end

function BilliardBattleResultView:OnBackBtnClick()
	manager.ui:SetCanvasAlpha(0)
	LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
end

function BilliardBattleResultView:OnEnter()
	self.needJumpToNextStage = false
	self.context.victory = self.params_.victory

	self.foodController:SetSelectedState("off")
	SetActive(self.collectTxt_.gameObject, false)

	if self.params_.victory then
		manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_cook_gold04", "")
		self.statusController:SetSelectedState("win")
		self.backBtnObj_:SetActive(false)
		self.sucBtnObj_:SetActive(true)

		self.sucBtnTxt_.text = GetTips("BILLIARD_GAME_BACK_ADVENTURE")

		local var_14_0, var_14_1, var_14_2 = BilliardBattleNeedJumpToCook(true)

		if var_14_1 then
			self.foodController:SetSelectedState("on")

			if var_14_2 then
				local var_14_3 = {}

				for iter_14_0, iter_14_1 in ipairs((getRewardFromDropCfg(var_14_2, true))) do
					table.insert(var_14_3, iter_14_1.id)
				end

				self.foodItems = var_14_3

				self.scrollHelper_:StartScroll(#self.foodItems)
			end
		end

		if var_14_0 then
			SetActive(self.collectTxt_.gameObject, true)

			self.sucBtnTxt_.text = GetTips("BILLIARD_GAME_COME_TO_COOK_GAME")
			self.collectTxt_.text = GetTips("BILLIARD_GAME_COME_READY_TO_COOK")
		end

		if BilliardGameMgr:GetLevelId() == BilliardGameConst.FirstLevelId then
			local var_14_4 = 0
			local var_14_5 = false

			if BilliardGameMgr:GetStageId() == SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].stage_id[1] then
				var_14_5 = true
				var_14_4 = SummerPubData:GetClearNumByStageID(BilliardGameMgr:GetLevelId(), 1)
			end

			if var_14_4 == 0 and var_14_5 then
				self.needJumpToNextStage = true
				self.sucBtnTxt_.text = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_CONTINUE")
			end
		end
	else
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done02", "")
		self.statusController:SetSelectedState("lose")
		self.backBtnObj_:SetActive(true)
		self.sucBtnObj_:SetActive(true)

		self.sucBtnTxt_.text = GetTips("BILLIARD_GAME_CONTINUE_ADVENTURE")
		self.backBtnTxt_.text = GetTips("BILLIARD_GAME_BACK_ADVENTURE")
	end
end

function BilliardBattleResultView:OnExit()
	BilliardBattleResultView.super.OnExit(self)
end

function BilliardBattleResultView:Dispose()
	self.scrollHelper_:Dispose()
	BilliardBattleResultView.super.Dispose(self)
end

return BilliardBattleResultView
