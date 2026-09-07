local AwardWindow = class("AwardWindow", import("view.base.BaseSubView"))

function AwardWindow:getUIName()
	return "ActivitybonusWindow_nonPt"
end

function AwardWindow:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.uiItemList = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/item"))
	self.currentTitle = self._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	self.currentTxt = self._tf:Find("window/pt/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/top/bg/infomation"), i18n("world_expedition_reward_display"))

	return
end

function AwardWindow:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function AwardWindow:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:Find("award")
	local var_7_1 = {
		type = self.awards[arg_7_1 + 1][1],
		id = self.awards[arg_7_1 + 1][2],
		count = self.awards[arg_7_1 + 1][3]
	}

	updateDrop(var_7_0, var_7_1)
	onButton(self, var_7_0, function()
		self:emit(BaseUI.ON_DROP, var_7_1)

		return
	end, SFX_PANEL)
	setActive(arg_7_2:Find("award/mask"), arg_7_1 + 1 <= self.finishIndex)
	setText(arg_7_2:Find("target/title"), self.targetTitle)
	setText(arg_7_2:Find("target/Text"), arg_7_1 + 1)
	setText(arg_7_2:Find("title/Text"), "PHASE  " .. arg_7_1 + 1)
	self:ShowIndex(arg_7_1 + 1, arg_7_2)

	return
end

function AwardWindow:Flush(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.awards = arg_9_1
	self.finishIndex = arg_9_2
	self.targetTitle = arg_9_3[2]
	self.currentTitle.text = arg_9_3[1]
	self.currentTxt.text = arg_9_2
	self.showIndex = arg_9_4

	self.uiItemList:align(#self.awards)
	self:Show()

	return
end

function AwardWindow:ShowIndex(arg_10_1, arg_10_2)
	if self.showIndex ~= nil then
		setText(arg_10_2:Find("target/Text"), self.showIndex.targetList[arg_10_1])

		self.currentTxt.text = self.showIndex.nowGet
	end

	return
end

function AwardWindow:Show()
	AwardWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function AwardWindow:Hide()
	AwardWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function AwardWindow:OnDestroy()
	return
end

return AwardWindow
