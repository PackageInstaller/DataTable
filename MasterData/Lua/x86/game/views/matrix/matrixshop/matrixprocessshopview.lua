local MatrixProcessShopView = class("MatrixProcessShopView", ReduxView)

function MatrixProcessShopView:UIName()
	return "Widget/System/MatrixlUI/MatrixProcessShopUI"
end

function MatrixProcessShopView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixProcessShopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessShopView:InitUI()
	self:BindCfgUI()

	self.matrixShopList_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixProcessShopItem)
	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
end

function MatrixProcessShopView:AddUIListener()
	self:AddBtnListener(self.m_sellerBtn, nil, function()
		self:RandomDialog(1)
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
					self.refreshCost
				},
				(GetTips("MATRIX_SHOP_REFRESH"))
			},
			OkCallback = function()
				MatrixAction.QueryRefreshShopItem()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function MatrixProcessShopView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:Refresh(self.shops[arg_10_1])
end

function MatrixProcessShopView:UpdateView(arg_11_1)
	self.refreshCount, self.shops = self:GetMatrixPhaseData():GetData()

	self.matrixShopList_:StartScroll(#self.shops)

	if arg_11_1 then
		self.matrixShopList_:StartScrollByPosition(#self.shops, arg_11_1)
	else
		self.matrixShopList_:StartScroll(#self.shops)
	end

	if #self.shops == 0 then
		self.emptyController:SetSelectedIndex(1)
	else
		self.emptyController:SetSelectedIndex(0)
	end

	local var_11_0 = self:GetShoRefreshTimes()
	local var_11_1 = self:GetShopFressRefreshTimes()

	if var_11_0 > self.refreshCount then
		SetActive(self.m_refreshContent, true)

		self.refreshCost = 0
		self.m_refreshTimes.text = string.format("%d/%d", self.refreshCount, var_11_0)

		if var_11_1 <= self.refreshCount then
			local var_11_2 = GameSetting.matrix_shop_refresh_cost_item_list.value[math.min(self.refreshCount - var_11_1 + 1, #GameSetting.matrix_shop_refresh_cost_item_list.value)]

			self.refreshCost = var_11_2[2]
			self.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(self:GetSwitchItemIcon(var_11_2[1]))
		else
			self.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(self:GetSwitchItemIcon(GameSetting.matrix_shop_refresh_cost_item_list.value[1][1]))
			self.refreshCost = 0
		end

		self.m_refreshCost.text = "x" .. self.refreshCost
	else
		SetActive(self.m_refreshContent, false)
	end
end

function MatrixProcessShopView:RandomDialog(arg_12_1)
	local var_12_0 = MatrixShopDialogCfg.get_id_list_by_type[arg_12_1]

	if not MatrixShopDialogCfg.get_id_list_by_type[arg_12_1] then
		return
	end

	SetActive(self.m_bubbleGo, true)

	if #var_12_0 == 1 then
		self.curRandomIndex_ = 1
	else
		local var_12_1 = math.random(2, #var_12_0)

		self.curRandomIndex_ = var_12_1 == self.curRandomIndex_ and 1 or var_12_1
	end

	local var_12_2 = MatrixShopDialogCfg[var_12_0[self.curRandomIndex_]]

	self.m_dialogText.text = GetI18NText(MatrixShopDialogCfg[var_12_0[self.curRandomIndex_]].content)

	if var_12_2.voice_sheet ~= nil and var_12_2.voice_sheet ~= "" and var_12_2.voice_name ~= nil and var_12_2.voice_name ~= "" then
		manager.audio:PlayVoice(var_12_2.voice_sheet, var_12_2.voice_name, "")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:RemoveDialog()
		end, 3, 1)

		self.timer_:Start()
	else
		self.timer_:Reset()
	end
end

function MatrixProcessShopView:RemoveDialog()
	SetActive(self.m_bubbleGo, false)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MatrixProcessShopView:OnEnter()
	self:UpdateView()
	self:RandomDialog(2)
end

function MatrixProcessShopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, false)
	manager.windowBar:SetGameHelpKey("MATRIX_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function()
				if self:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
					MatrixAction.QueryNextProgress()
				end

				JumpTools.OpenPageByJump("/matrixBlank/matrixOrigin")
			end
		})
	end)
end

function MatrixProcessShopView:OnExit()
	self:RemoveDialog()
	manager.windowBar:HideBar()
end

function MatrixProcessShopView:Dispose()
	if self.matrixShopList_ then
		self.matrixShopList_:Dispose()

		self.matrixShopList_ = nil
	end

	MatrixProcessShopView.super.Dispose(self)
end

function MatrixProcessShopView:OnMatrixUserUpdate()
	local var_21_0 = self:GetGameState()

	if MatrixConst.STATE_TYPE.STARTED == var_21_0 then
		self:UpdateView()
	elseif MatrixConst.STATE_TYPE.NOTSTARTED == var_21_0 then
		JumpTools.OpenPageByJump("/matrixBlank/matrixPrepare", {
			isTimeOut = true
		})
	end
end

function MatrixProcessShopView:OnMatrixShopBuySuccess()
	self:RandomDialog(3)
end

function MatrixProcessShopView:OnMatrixSystemUpdate()
	self:UpdateView((self.matrixShopList_:GetScrolledPosition()))
end

function MatrixProcessShopView:OnMatrixUserUpdate()
	self:UpdateView((self.matrixShopList_:GetScrolledPosition()))
end

function MatrixProcessShopView:GetGameState()
	return MatrixData:GetGameState()
end

function MatrixProcessShopView:GetMatrixPhaseData()
	return MatrixData:GetMatrixPhaseData()
end

function MatrixProcessShopView:GetShoRefreshTimes()
	return MatrixData:GetShoRefreshTimes()
end

function MatrixProcessShopView:GetShopFressRefreshTimes()
	return MatrixData:GetShopFressRefreshTimes()
end

function MatrixProcessShopView:GetSwitchItemIcon(arg_29_1)
	return arg_29_1
end

return MatrixProcessShopView
