local IslandAwardDisplayWindow = class("IslandAwardDisplayWindow", import("view.base.BaseSubView"))

function IslandAwardDisplayWindow:getUIName()
	return "IslandAwardDisplayUI"
end

function IslandAwardDisplayWindow:OnLoaded()
	self.frameTr = self._tf:Find("frame")
	self.title = self._tf:Find("frame/Board/Top/text/text"):GetComponent("Text")
	self.uiitemList = UIItemList.New(self._tf:Find("frame/Board/Content/award/content"), self._tf:Find("frame/Board/Content/award/content/tpl"))

	setText(self._tf:Find("frame/tip"), i18n("island_click_close"))

	self.animator = self.frameTr:GetComponent(typeof(Animation))
	self.aniDft = self.frameTr:GetComponent(typeof(DftAniEvent))
	self.scrollRect = self._tf:Find("frame/Board/Content/award_scroll/content"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandAwardDisplayWindow:Show(arg_5_1)
	IslandAwardDisplayWindow.super.Show(self)

	self.title.text = setColorStr(arg_5_1.title or "", arg_5_1.titleColor or "#393a3c")

	self:UpdateAwards(arg_5_1.awards)

	return
end

function IslandAwardDisplayWindow:OnUpdateItem(arg_6_1, arg_6_2)
	updateCustomDrop(arg_6_2.transform, self.awards[arg_6_1 + 1], {
		style = "island"
	})
	setText(findTF(arg_6_2.transform, "icon_bg/count_bg/count"), "x" .. self.awards[arg_6_1 + 1].count)

	return
end

function IslandAwardDisplayWindow:UpdateAwards(arg_7_1)
	local var_7_0 = #arg_7_1 > 10

	self.awards = arg_7_1

	setActive(self._tf:Find("frame/Board/Content/award_scroll"), var_7_0)
	setActive(self._tf:Find("frame/Board/Content/award"), not var_7_0)

	if var_7_0 then
		self.scrollRect:SetTotalCount(#self.awards, -1)
	else
		self.uiitemList:make(function(arg_8_0, arg_8_1, arg_8_2)
			if arg_8_0 == UIItemList.EventUpdate then
				updateCustomDrop(arg_8_2, arg_7_1[arg_8_1 + 1], {
					style = "island"
				})
				setText(findTF(arg_8_2, "icon_bg/count_bg/count"), "x" .. arg_7_1[arg_8_1 + 1].count)
			end

			return
		end)
		self.uiitemList:align(#arg_7_1)
	end

	return
end

function IslandAwardDisplayWindow:PlayExitAniamtion(arg_9_1)
	self.aniDft:SetEndEvent(function()
		self.aniDft:SetEndEvent(nil)
		arg_9_1()

		return
	end)
	self.animator:Play("anim_Island_commonget_single_out")

	return
end

function IslandAwardDisplayWindow:OnDestroy()
	self.aniDft:SetEndEvent(nil)
	ClearLScrollrect(self.scrollRect)

	return
end

return IslandAwardDisplayWindow
