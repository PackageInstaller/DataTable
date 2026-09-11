local NorseSurpriseGiftMachinePage = class("NorseSurpriseGiftMachinePage", ReduxView)
local var_0_1 = {
	{
		"anim01_1",
		"anim01_2",
		"anim01_3"
	},
	{
		"anim02_1",
		"anim02_2",
		"anim02_3"
	},
	{
		"anim03_1",
		"anim03_2"
	},
	{
		"anim04_1",
		"anim04_2",
		"anim04_3"
	},
	{
		"anim05_1",
		"anim05_2"
	}
}

function NorseSurpriseGiftMachinePage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftMachineUI"
end

function NorseSurpriseGiftMachinePage:UIParent()
	return manager.ui.uiMain.transform
end

function NorseSurpriseGiftMachinePage:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftMachineItem)
	self.onDrawHandler = handler(self, self.OnNorseGiftDrawSuccess)
	self.onReceiveHandler = handler(self, self.OnNorseGiftReceiveSuccess)
	self.onPlayAnimHandler = handler(self, self.OnNorseGiftPlayAnimDraw)
	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("bottom_btn_switch")
end

function NorseSurpriseGiftMachinePage:indexItem(arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, self.heroDataProxy)
	arg_4_2:SetData(self.draw_list[arg_4_1])

	if self.heartList and #self.heartList > 0 then
		arg_4_2:SetState(self.heartList, self.result_role_id)
	else
		arg_4_2:ResetState()
	end

	if arg_4_1 == self.needPlayDrawAnimIndex then
		arg_4_2:PlayAnim(true)

		self.needPlayDrawAnimIndex = -1
	else
		arg_4_2:PlayAnim(false)
	end
end

function NorseSurpriseGiftMachinePage:AddListeners()
	self:AddBtnListener(self.btnReceive_, nil, function()
		if #NorseSurpriseGiftReceiveData:GetDrawRoleData() <= 0 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_4")
		else
			JumpTools.OpenPageByJump("norseSurpriseGiftReceivePage")
		end
	end)
	self:AddBtnListener(self.btnStart_, nil, function()
		local var_7_0 = NorseSurpriseGiftReceiveData:GetDrawRoleData()

		if #NorseSurpriseGiftReceiveData:GetChooseRoleData() < 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftInStockPage")
		elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_3")
		elseif var_7_0 and #var_7_0 >= 5 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_6")
		else
			manager.windowBar:HideBar()

			self.btnStart_.interactable = false
			self.btnReceive_.interactable = false
			self.btnInfo_.interactable = false
			self.btnWish_.interactable = false
			self.startAnim_.enabled = true

			self.startAnim_:Play("Fx_niudanji_cx", -1, 0)
			self.startAnim_:Update(0)
			AnimatorTools.PlayAnimatorWithCallback(self.startAnim_, "Fx_niudanji_cx", function()
				self.startAnim_.enabled = false

				if self.draw_list then
					for iter_8_0, iter_8_1 in ipairs(var_0_1[#self.draw_list + 1]) do
						self[iter_8_1].enabled = true

						self[iter_8_1]:Play("Fx_ball_saoguang")
					end

					self.animDrop_:Play("ball_trop", -1, 0)
					AnimatorTools.PlayAnimatorWithCallback(self.animDrop_, "ball_trop", function()
						NorseSurpriseGiftReceiveAction.DrawCapsule(242832)

						self.btnStart_.interactable = true
						self.btnReceive_.interactable = true
						self.btnInfo_.interactable = true
						self.btnWish_.interactable = true
					end, false)
				end
			end, false)
		end
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
	self:AddBtnListener(self.btnWish_, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftWishPoolPage")
	end)
end

function NorseSurpriseGiftMachinePage:OnTop()
	self:UpdateBar()
end

function NorseSurpriseGiftMachinePage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_OPTIONAL_RANDOM_RULE")
end

function NorseSurpriseGiftMachinePage:OnEnter()
	NorseSurpriseGiftMachinePage.super.OnEnter(self)
	self:RegistEventListener(NORSE_GIFT_DRAW_SUCCESS, self.onDrawHandler)
	self:RegistEventListener(NORSE_GIFT_RECEIVE_SUCCESS, self.onReceiveHandler)
	self:RegistEventListener(NORSE_GIFT_PLAYANIM_DRAW, self.onPlayAnimHandler)
	manager.redPoint:bindUIandKey(self.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:bindUIandKey(self.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	self:RefreshView()
end

function NorseSurpriseGiftMachinePage:OnExit()
	NorseSurpriseGiftMachinePage.super.OnExit(self)
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:unbindUIandKey(self.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()

	self.needPlayDrawAnimIndex = -1
end

function NorseSurpriseGiftMachinePage:Dispose()
	NorseSurpriseGiftMachinePage.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

function NorseSurpriseGiftMachinePage:RefreshCurrency()
	self.currencyTxt_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 and "<color=#FF000B>x1</color>" or "<color=#262626>x1</color>"
end

function NorseSurpriseGiftMachinePage:RefreshView()
	self.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	self.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	self:RefreshBtn()
	self:RefreshCurrency()

	if self.draw_list and #self.draw_list > 0 and self.uiList_ then
		self.uiList_:StartScroll(#self.draw_list)
	end

	self:RefreshBall(#self.draw_list)
end

function NorseSurpriseGiftMachinePage:RefreshBall(arg_19_1)
	for iter_19_0 = 1, arg_19_1 do
		for iter_19_1, iter_19_2 in ipairs(var_0_1[iter_19_0]) do
			SetActive(self[iter_19_2].gameObject, false)
		end
	end
end

function NorseSurpriseGiftMachinePage:RefreshBtn()
	if self.result_role_id and self.result_role_id ~= 0 then
		self.stateCtrl:SetSelectedIndex(1)
		SetActive(self.costGo_, false)
	end
end

function NorseSurpriseGiftMachinePage:OnNorseGiftDrawSuccess(arg_21_1)
	NorseSurpriseGiftReceiveData:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	JumpTools.OpenPageByJump("norseSurpriseGiftResultsview", {
		data = arg_21_1
	})
end

function NorseSurpriseGiftMachinePage:OnNorseGiftReceiveSuccess(arg_22_1, arg_22_2)
	self.result_role_id = arg_22_2.role_id
	self.item_list = arg_22_1.item_list

	HeroAction.UnlockHeroSuccess(HeroCfg[arg_22_2.role_id].id)
	print("--->播放获取角色动画")
	gameContext:Go("obtainView", {
		itemList = {
			HeroCfg[arg_22_2.role_id]
		},
		doNextHandler = handler(self, self.JumpToReward)
	})
end

function NorseSurpriseGiftMachinePage:JumpToReward()
	getReward2(self.item_list)
	print("奖励弹窗---->", self.result_role_id)
	self:RefreshView()
end

function NorseSurpriseGiftMachinePage:OnNorseGiftPlayAnimDraw()
	self.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	self.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	self:RefreshBtn()
	self:RefreshCurrency()

	self.needPlayDrawAnimIndex = #self.draw_list

	if self.draw_list and #self.draw_list > 0 and self.uiList_ then
		self.uiList_:StartScroll(#self.draw_list)
	end

	self.currencyTxt_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 and "<color=#FF000B>x1</color>" or "<color=#262626>x1</color>"
end

return NorseSurpriseGiftMachinePage
