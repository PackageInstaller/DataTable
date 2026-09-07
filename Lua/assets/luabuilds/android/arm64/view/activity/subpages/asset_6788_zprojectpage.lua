local ZProjectPage = class("ZProjectPage", import(".TemplatePage.PreviewTemplatePage"))

function ZProjectPage:OnInit()
	ZProjectPage.super.OnInit(self)

	self.awardTF = self._tf:Find("AD/award")

	return
end

function ZProjectPage:OnFirstFlush()
	ZProjectPage.super.OnFirstFlush(self)

	local var_2_0 = self.activity:getConfig("config_client").drop

	updateDrop(self.awardTF, var_2_0)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_2_0)

		return
	end, SFX_PANEL)

	return
end

return ZProjectPage
