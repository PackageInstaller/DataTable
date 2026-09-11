local AutoChessTipsPanelView = class("AutoChessTipsPanelView", ReduxView)

function AutoChessTipsPanelView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.orignalPos = self.transform_.position
	self.BuffList_ = {}
	self.SepcBuffList_ = {}
	self.buffTipsWidth = 0

	self:Init()
end

function AutoChessTipsPanelView:Init()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitController()
end

function AutoChessTipsPanelView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.closeCallback_ then
			self.closeCallback_()
		end

		self:SetActive(false)
	end)
	TerminologyTools.AddTerminologyHandler(self, self.playerDescText_, self.playerButton_, nil)
	TerminologyTools.AddTerminologyHandler(self, self.descText_, self.descButton_, nil)
end

function AutoChessTipsPanelView:InitController()
	self.typeController_ = self.controllerEx_:GetController("type")
	self.tagListController_ = self.normalContronllerEx_:GetController("tagList")
	self.showCostController_ = self.normalContronllerEx_:GetController("cost")
	self.tipsStatusController_ = self.tipsControllerEx_:GetController("status")
	self.levelController_ = self.tipsControllerEx_:GetController("level")

	self.tipsStatusController_:SetSelectedState("hide")
end

function AutoChessTipsPanelView:SetData(arg_6_1)
	self.buffTipsWidth = 0

	self.tipsStatusController_:SetSelectedState("chess")

	self.chessItemData_ = arg_6_1

	self:CloseSubTips()

	if arg_6_1.shopType ~= AutoChessConst.SHOP_TYPE.PROP then
		self.chessCfg_ = AutoChessCfg[arg_6_1.chessId]

		self:UpdateChessUI()
	else
		self:UpdateItemUI()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsTrans_)
end

function AutoChessTipsPanelView:SetGoldState(arg_7_1)
	if arg_7_1 then
		self.showCostController_:SetSelectedState("on")
	else
		self.showCostController_:SetSelectedState("off")
	end
end

function AutoChessTipsPanelView:SetPos(arg_8_1)
	self.transform_.position = arg_8_1
end

function AutoChessTipsPanelView:SetLocalPos(arg_9_1)
	self.transform_.localPosition = arg_9_1
end

function AutoChessTipsPanelView:GetLocalPos()
	return self.transform_.localPosition
end

function AutoChessTipsPanelView:GetTipsPos()
	return self.tipsTrans_.localPosition
end

function AutoChessTipsPanelView:GetTipsHeight()
	return self.tipsTrans_.rect.height
end

function AutoChessTipsPanelView:GetTipsWidth()
	return self.tipsTrans_.rect.width
end

function AutoChessTipsPanelView:SetPivot(arg_14_1, arg_14_2)
	self.tipsTrans_.pivot = Vector2(arg_14_1, arg_14_2)
end

function AutoChessTipsPanelView:ResetPos()
	self:SetPos(self.orignalPos)
end

function AutoChessTipsPanelView:UpdateChessUI()
	self:UpdateChessInfo()
	self:UpdateTagList()
end

function AutoChessTipsPanelView:UpdateChessInfo()
	if AutoChessCfg[self.chessItemData_.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		self:UpdateAdminChessInfo()
	elseif AutoChessCfg[self.chessItemData_.chessId].type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		self:UpdateOpAdminChessInfo()
	else
		self:UpdateNormalChessInfo()
	end
end

function AutoChessTipsPanelView:UpdateAdminChessInfo()
	self.typeController_:SetSelectedState("special")

	local var_18_0 = AutoChessCfg[self.chessItemData_.chessId]

	self.playerNameText_.text = AutoChessCfg[self.chessItemData_.chessId].name

	if self.chessItemData_.buffList and not table.indexof(self.chessItemData_.buffList, var_18_0.level_buffs[3][1]) then
		local var_18_1 = GetTips("AUTO_CHESS_BOSS_404")

		RichTextTools.SetMixedTextWithImage(self.playerDescText_, var_18_1)

		self.playerDescText_.text = var_18_1
	else
		AutoChessTools.GetChessBuffDesc(self.chessItemData_, var_18_0.level_buffs[3][1], self.playerDescText_)
	end

	self.adminIcon_.sprite = AutoChessTools.GetChessBody(self.chessItemData_.chessId)

	self:UpdatePlayerBuffTips((AutoChessTools.GetPlayerChessLevelBuff(var_18_0)))
	self:UpdateBuffTips()
end

function AutoChessTipsPanelView:UpdateOpAdminChessInfo()
	self.typeController_:SetSelectedState("special")

	self.playerNameText_.text = AutoChessCfg[self.chessItemData_.chessId].name
	self.adminIcon_.sprite = AutoChessTools.GetChessBody(self.chessItemData_.chessId)

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(AutoChessCfg[self.chessItemData_.chessId].level_buffs) do
		if iter_19_0 ~= 1 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	self:UpdatePlayerBuffTips(var_19_0)
	self:UpdateBuffTips()
	AutoChessTools.GetChessBuffDesc(self.chessItemData_, AutoChessCfg[self.chessItemData_.chessId].level_buffs[1][1], self.playerDescText_)
end

function AutoChessTipsPanelView:UpdateNormalChessInfo()
	self.typeController_:SetSelectedState("normal")
	self.tagListController_:SetSelectedState("on")

	local var_20_0 = AutoChessCfg[self.chessItemData_.chessId]

	self.nameText_.text = AutoChessCfg[self.chessItemData_.chessId].name
	self.iconImg_.sprite = AutoChessTools.GetChessBody(self.chessItemData_.chessId)

	if self.chessItemData_.shopType ~= nil then
		self.costText_.text = AutoChessTools.GetAttrValue(nil, AutoChessConst.ATTR_KEY.SHOP_FREE_CHESS_COUNT) > 0 and 0 or var_20_0.shop_price
	else
		if var_20_0.sell_price ~= "" then
			self.costText_.text = "+" .. var_20_0.sell_price[self.chessItemData_.attributeData.level]
		end

		self:UpdateBuffTips()
	end

	AutoChessTools.GetChessBuffDesc(self.chessItemData_, (var_20_0.level_buffs ~= "" or nil) and (var_20_0.level_buffs[self.chessItemData_.attributeData.level][1] or nil), self.descText_)
	self.levelController_:SetSelectedIndex(var_20_0.star - 1)
end

function AutoChessTipsPanelView:UpdatePlayerBuffTips(arg_21_1)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1) do
			if table.indexof(self.chessItemData_.buffList, iter_21_3) then
				var_21_0 = var_21_0 + 1
				self.SepcBuffList_[iter_21_0] = self.SepcBuffList_[iter_21_0] or AutoChessTipsSepcSubItem.New((Object.Instantiate(self.tipsSepcSubGo_, self.specSubRect_)))

				self.SepcBuffList_[iter_21_0]:SetData(iter_21_3, iter_21_0, self.chessItemData_)
				self.SepcBuffList_[iter_21_0]:SetActive(true)

				break
			end
		end
	end

	if var_21_0 > 0 then
		SetActive(self.specSubRect_.gameObject, true)
	end
end

function AutoChessTipsPanelView:CloseSubTips()
	SetActive(self.specSubRect_.gameObject, false)

	for iter_22_0, iter_22_1 in pairs(self.SepcBuffList_) do
		iter_22_1:SetActive(false)
	end

	for iter_22_2, iter_22_3 in pairs(self.BuffList_) do
		iter_22_3:SetActive(false)
	end
end

function AutoChessTipsPanelView:UpdateBuffTips()
	local var_23_0 = 0

	self.buffTipsWidth = 0

	for iter_23_0, iter_23_1 in ipairs(self.chessItemData_:GetBuffList()) do
		if self.chessItemData_.uniqueId ~= iter_23_1:GetBuffSourceUid() then
			local var_23_1 = iter_23_1:GetBuffID()

			if AutoChessBuffCfg[var_23_1].is_show == 1 then
				var_23_0 = var_23_0 + 1
				self.buffTipsWidth = 576
				self.BuffList_[var_23_0] = self.BuffList_[var_23_0] or AutoChessTipsSubItem.New((Object.Instantiate(self.tipSubGo_, self.sideListRect_)))

				self.BuffList_[var_23_0]:SetData(var_23_1, self.chessItemData_)
				self.BuffList_[var_23_0]:SetActive(true)
			end
		end
	end
end

function AutoChessTipsPanelView:UpdateItemUI(arg_24_1)
	self.typeController_:SetSelectedState("normal")
	self.tagListController_:SetSelectedState("off")

	local var_24_0 = AutoChessItemCfg[self.chessItemData_.chessId]

	self.nameText_.text = AutoChessItemCfg[self.chessItemData_.chessId].name
	self.iconImg_.sprite = AutoChessTools.GetPropIcon(var_24_0.icon)
	self.costText_.text = AutoChessTools.GetAttrValue(nil, AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT) > 0 and 0 or var_24_0.shop_price

	RichTextTools.SetMixedTextWithImage(self.descText_, var_24_0.desc)

	self.descText_.text = var_24_0.desc

	self.levelController_:SetSelectedIndex(var_24_0.star - 1)
end

function AutoChessTipsPanelView:SetActive(arg_25_1)
	if arg_25_1 then
		self.tipsStatusController_:SetSelectedState("chess")
	else
		self.tipsStatusController_:SetSelectedState("hide")
	end
end

function AutoChessTipsPanelView:UpdateTagList()
	for iter_26_0 = 1, self.tagListGo_.transform.childCount do
		if table.indexof(self.chessCfg_.label, iter_26_0) then
			SetActive(self.tagListGo_.transform:GetChild(iter_26_0 - 1), true)
		else
			SetActive(self.tagListGo_.transform:GetChild(iter_26_0 - 1), false)
		end
	end
end

function AutoChessTipsPanelView:RegistCloseCallback(arg_27_1)
	self.closeCallback_ = arg_27_1
end

function AutoChessTipsPanelView:GetBuffWidth()
	return self.buffTipsWidth
end

function AutoChessTipsPanelView:Dispose()
	for iter_29_0, iter_29_1 in pairs(self.SepcBuffList_) do
		iter_29_1:Dispose()
	end

	for iter_29_2, iter_29_3 in pairs(self.BuffList_) do
		iter_29_3:Dispose()
	end

	AutoChessTipsPanelView.super.Dispose(self)
end

return AutoChessTipsPanelView
