local GuildMemberBasePage = class("GuildMemberBasePage", import("....base.BaseSubView"))

function GuildMemberBasePage:SetCallBack(arg_1_1, arg_1_2)
	self.onShowCallBack = arg_1_1
	self.onHideCallBack = arg_1_2

	return
end

function GuildMemberBasePage:OnLoaded()
	self.buttonContainer = self._tf:Find("frame/opera")

	local var_2_0 = pg.UIMgr.GetInstance().OverlayMain.transform:InverseTransformPoint(self.buttonContainer.position)

	self.buttonPos = Vector3(var_2_0.x, var_2_0.y, 0)

	return
end

function GuildMemberBasePage:Show(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4 then
		arg_3_4()
	end

	self.guildVO = arg_3_1
	self.playerVO = arg_3_2
	self.memberVO = arg_3_3

	if not self:ShouldShow() then
		return
	end

	self:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	GuildMemberBasePage.super.Show(self)
	self._tf:SetAsLastSibling()
	self.onShowCallBack(self.buttonPos)

	return
end

function GuildMemberBasePage:Hide()
	if self:isShowing() then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	if self.circle.childCount > 0 then
		local var_4_0 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_4_0.name, var_4_0.name, var_4_0)
	end

	GuildMemberBasePage.super.Hide(self)
	self.onHideCallBack()

	return
end

function GuildMemberBasePage:OnDestroy()
	self:Hide()

	return
end

function GuildMemberBasePage:ShouldShow()
	return true
end

function GuildMemberBasePage:OnShow()
	return
end

return GuildMemberBasePage
