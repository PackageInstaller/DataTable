local CommanderResetTalentPage = class("CommanderResetTalentPage", import("view.base.BaseSubView"))

function CommanderResetTalentPage:getUIName()
	return "CommanderCatResetTalentUI"
end

function CommanderResetTalentPage:OnLoaded()
	self.resetCancelBtn = self._tf:Find("bg/frame/cancel_btn")
	self.resetConfirmBtn = self._tf:Find("bg/frame/confirm_btn")
	self.resetCloseBtn = self._tf:Find("bg/frame/close_btn")
	self.resetGoldTxt = self._tf:Find("bg/frame/bg/tip/texts/Text"):GetComponent(typeof(Text))
	self.resetPointTxt = self._tf:Find("bg/frame/bg/tip/texts1/Text"):GetComponent(typeof(Text))
	self.resetList = UIItemList.New(self._tf:Find("bg/frame/bg/talents/content"), self._tf:Find("bg/frame/bg/talents/content/talent_tpl"))

	local var_2_0 = string.split(i18n("commander_choice_talent_reset"), "$1")
	local var_2_1 = string.split(var_2_0[2], "\t")
	local var_2_2 = string.split(var_2_1[2], "$2")

	setText(self._tf:Find("bg/frame/bg/tip/texts/label"), var_2_0[1] .. " ")
	setText(self._tf:Find("bg/frame/bg/tip/texts/label1"), " " .. var_2_1[1])
	setText(self._tf:Find("bg/frame/bg/tip/texts1/label"), var_2_2[1] .. " ")
	setText(self._tf:Find("bg/frame/bg/tip/texts1/label1"), " " .. var_2_2[2])

	return
end

function CommanderResetTalentPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.resetCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.resetCancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.resetConfirmBtn, function()
		if self.commanderVO then
			local var_7_0 = getProxy(PlayerProxy):getRawData()

			if var_7_0.gold < self.total then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						self.total - var_7_0.gold,
						self.total
					}
				})

				return
			end

			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_reset_talent_tip"),
				onYes = function()
					self:emit(CommanderCatMediator.RESET_TALENT, self.commanderVO.id)
					self:Hide()

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderResetTalentPage:Show(arg_9_1)
	CommanderResetTalentPage.super.Show(self)
	self._tf:SetAsLastSibling()

	self.commanderVO = arg_9_1

	self:Flush()

	return
end

function CommanderResetTalentPage:Flush()
	local var_10_0 = self.commanderVO:getTalentOrigins()

	self.resetList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdateTalentCard(arg_11_2, var_10_0[arg_11_1 + 1])
		end

		return
	end)
	self.resetList:align(#var_10_0)

	local var_10_1 = getProxy(PlayerProxy):getRawData()

	self.total = self.commanderVO:getResetTalentConsume()

	if var_10_1.gold < self.total then
		self.resetGoldTxt.text = "<color=" .. COLOR_RED .. ">" .. self.total .. "</color>" or self.total
	end

	self.resetPointTxt.text = self.commanderVO:getTotalPoint()
	GetComponent(self.resetGoldTxt, typeof(Outline)).enabled = var_10_1.gold >= self.total

	return
end

function CommanderResetTalentPage:UpdateTalentCard(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:Find("unlock")
	local var_12_1 = arg_12_1:Find("lock")

	if arg_12_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_12_2:getConfig("icon"), "", var_12_0:Find("icon"))

		local var_12_2 = var_12_0:Find("tree_btn")

		if var_12_2 then
			onButton(self, var_12_2, function()
				self.contextData.treePanel:ExecuteAction("Show", arg_12_2)

				return
			end, SFX_PANEL)
		end

		setText(var_12_0:Find("name_bg/Text"), arg_12_2:getConfig("name"))
		setScrollText(var_12_0:Find("desc/Text"), arg_12_2:getConfig("desc"))
	end

	setActive(var_12_0, arg_12_2)

	if var_12_1 then
		setActive(var_12_1, not arg_12_2)
	end

	return
end

function CommanderResetTalentPage:OnDestroy()
	return
end

return CommanderResetTalentPage
