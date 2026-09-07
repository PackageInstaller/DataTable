local ChuixuePTRePage = class("ChuixuePTRePage", import(".TemplatePage.PtTemplatePage"))

function ChuixuePTRePage:OnFirstFlush()
	ChuixuePTRePage.super.OnFirstFlush(self)

	ChuixuePTRePage.scrolltext = self.awardTF:Find("name")

	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.GO_SHOPS_LAYER_STEEET, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})

		return
	end)

	return
end

function ChuixuePTRePage:OnUpdateFlush()
	ChuixuePTRePage.super.OnUpdateFlush(self)
	self:SetAwardName()

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_3_2 >= 1 and setColorStr(var_3_0, "#A2A2A2FF") or var_3_0) .. "/" .. var_3_1)

	return
end

function ChuixuePTRePage:SetAwardName()
	local var_4_0 = self.ptData:GetAward()

	if Item.getConfigData(var_4_0.id) then
		changeToScrollText(ChuixuePTRePage.scrolltext, var_4_0:getName())
	else
		setActive(self.awardTF:Find("name"), false)
	end

	return
end

return ChuixuePTRePage
