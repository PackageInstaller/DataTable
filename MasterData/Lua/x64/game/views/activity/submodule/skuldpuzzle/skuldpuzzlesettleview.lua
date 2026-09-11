local SkuldPuzzleSettleView = class("SkuldPuzzleSettleView", ReduxView)

function SkuldPuzzleSettleView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_ResultPopUI"
end

function SkuldPuzzleSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function SkuldPuzzleSettleView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldPuzzleSettleView:InitUI()
	self:BindCfgUI()

	self.btnStateController = self.controller_:GetController("btnState")
	self.trustShowController = self.controller_:GetController("trustShow")
	self.rewardList_ = LuaList.New(handler(self, self.IndexRewardItem), self.uilistGo_, CommonItemView)
end

function SkuldPuzzleSettleView:AddUIListeners()
	self:AddBtnListener(self.btnconfirmBtn_, nil, function()
		if SkuldStageCfg[self.levelID].section == 9 then
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = true,
				startNext = false
			}, true)
		else
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = false,
				startNext = false
			}, true)
		end
	end)
	self:AddBtnListener(self.btncontinueBtn_, nil, function()
		self:OnContinueBtn()
	end)
end

function SkuldPuzzleSettleView:OnContinueBtn()
	if not self:IsOpenContinueBtn() then
		return
	end

	SkuldSystemAction.OpenSkuldBattle(self.levelID + 1, BattleConst.SKULD, true)
end

function SkuldPuzzleSettleView:IsOpenContinueBtn()
	return SkuldStageCfg[self.levelID].ending == 1
end

function SkuldPuzzleSettleView:IndexRewardItem(arg_10_1, arg_10_2)
	local var_10_0 = clone(ItemTemplateData)

	var_10_0.id = self.rewardList[arg_10_1][1]
	var_10_0.number = self.rewardList[arg_10_1][2]

	function var_10_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_10_2:SetData(var_10_0)
end

function SkuldPuzzleSettleView:OnEnter()
	self.levelID = self.params_.levelID

	self:RefreshUI()
	SkuldSystemData:UpdateSkuldStageArchiveRed()
end

function SkuldPuzzleSettleView:RefreshUI()
	local var_13_1 = CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id
	local var_13_2 = 0
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in ipairs(self.params_.rewardList) do
		if iter_13_1.id == var_13_1 then
			var_13_2 = iter_13_1.num
		else
			table.insert(var_13_3, {
				iter_13_1.id,
				iter_13_1.num
			})
		end
	end

	self.rewardList = var_13_3

	self.rewardList_:StartScroll(#var_13_3)

	if var_13_2 > 0 then
		self.trustShowController:SetSelectedState("show")
	else
		self.trustShowController:SetSelectedState("hide")
	end

	local var_13_5 = ItemTools.getItemNum(var_13_1)

	self.valueAgoTxt_.text = var_13_5 - var_13_2
	self.valueNowTxt_.text = var_13_5

	if self:IsOpenContinueBtn() then
		self.btnStateController:SetSelectedState("normal")
	else
		self.btnStateController:SetSelectedState("noContinue")
	end
end

function SkuldPuzzleSettleView:OnTop()
	manager.windowBar:SwitchBar({})
end

function SkuldPuzzleSettleView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SkuldPuzzleSettleView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	SkuldPuzzleSettleView.super.Dispose(self)
end

return SkuldPuzzleSettleView
