local GuildRenameView = class("GuildRenameView", ReduxView)

function GuildRenameView:UIName()
	return "Widget/System/Club/ClubCommunitynamePopUI"
end

function GuildRenameView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildRenameView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.textCost_.text = GetI18NText(GameSetting.club_rename_cost.value[1])
	self.freeController_ = self.controller:GetController("free")
end

function GuildRenameView:OnEnter()
	local var_4_0 = GuildData:GetRenameFreeCnt()

	if var_4_0 > 0 then
		self.freeController_:SetSelectedState("false")
	else
		self.freeController_:SetSelectedState("true")
	end

	self.freeRenameCnt_ = var_4_0
end

function GuildRenameView:OnTop()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetAsLastSibling()
end

function GuildRenameView:OnExit()
	manager.windowBar:HideBar()
end

function GuildRenameView:Dispose()
	GuildRenameView.super.Dispose(self)
end

function GuildRenameView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self.inputFieldNick_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self.inputFieldNick_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_NICK) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_11_0 = self.inputFieldNick_.text

		if self.inputFieldNick_.text == "" then
			ShowTips("CLUB_NEED_NAME")

			return
		end

		if IsAllSpace(var_11_0) then
			ShowTips("INPUT_CHAT_CONTENT")

			self.inputFieldNick_.text = ""

			return
		end

		local var_11_1, var_11_2 = textLimit(var_11_0, 16)
		local var_11_3 = var_11_1

		if not nameRule(var_11_1) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_11_1, function(arg_12_0)
			if not arg_12_0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			if not var_11_2 then
				ShowTips("CLUB_FOUNDED_NAME_MAX")

				return
			end

			local var_12_0 = 2

			if self.freeRenameCnt_ > 0 then
				var_12_0 = 1
			else
				local var_12_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

				if var_12_1 < GameSetting.club_rename_cost.value[1] then
					JumpTools.OpenPopUp("rechargeDiamondExchange", {
						defaultNum = 1,
						useBaseNum = GameSetting.club_rename_cost.value[1] - var_12_1,
						getBaseNum = GameSetting.club_rename_cost.value[1] - var_12_1,
						useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
						getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
					}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

					return
				end
			end

			GuildAction.GuildRename(var_11_3, var_12_0, function(arg_13_0)
				if isSuccess(arg_13_0.result) then
					ShowTips("CLUB_RENANE_SUCCESS")

					if self.freeRenameCnt_ <= 0 then
						-- block empty
					else
						GuildData:UseRenameFree()
					end

					self.inputFieldNick_.text = ""

					self:Back()
				else
					ShowTips(arg_13_0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

return GuildRenameView
