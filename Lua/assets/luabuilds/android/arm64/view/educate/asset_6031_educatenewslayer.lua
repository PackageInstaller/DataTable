local EducateNewsLayer = class("EducateNewsLayer", import(".base.EducateBaseUI"))
local var_0_1 = {
	[EducateSpecialEvent.TAG_ING] = "5ACEFE",
	[EducateSpecialEvent.TAG_COMING] = "CB99FF",
	[EducateSpecialEvent.TAG_END] = "7C7E81"
}
local var_0_2 = {
	[EducateSpecialEvent.TAG_ING] = "393A3C",
	[EducateSpecialEvent.TAG_COMING] = "393A3C",
	[EducateSpecialEvent.TAG_END] = "7C7E81"
}

function EducateNewsLayer:getUIName()
	return "EducateNewsUI"
end

function EducateNewsLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateNewsLayer:initData()
	self.curTime = getProxy(EducateProxy):GetCurTime()
	self.finishEvents = getProxy(EducateProxy):GetEventProxy():GetFinishSpecEventIds()
	self.importEvents = {}
	self.otherEvents = {}

	local var_3_0 = getProxy(EducateProxy):GetPersonalityId()

	for iter_3_0, iter_3_1 in ipairs(pg.child_event_special.all) do
		local var_3_1 = EducateSpecialEvent.New(iter_3_1)

		if var_3_1:IsShow() and var_3_1:InMonth(self.curTime.month) and var_3_1:IsUnlockSite() and var_3_1:IsMatch(var_3_0) then
			if var_3_1:IsImport() then
				table.insert(self.importEvents, var_3_1)
			elseif var_3_1:IsOther() then
				table.insert(self.otherEvents, var_3_1)
			end
		end
	end

	return
end

function EducateNewsLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateNewsLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")
	self.tplTF = self.windowTF:Find("tpl")

	setActive(self.tplTF, false)

	self.importTF = self.windowTF:Find("scrollview/view/content/import_news")
	self.importUIList = UIItemList.New(self.importTF:Find("list"), self.tplTF)

	setText(self.importTF:Find("title/Text"), i18n("child_news_import_title"))
	setText(self.importTF:Find("empty/Text"), i18n("child_news_import_empty"))

	self.otherTF = self.windowTF:Find("scrollview/view/content/other_news")
	self.otherUIList = UIItemList.New(self.otherTF:Find("list"), self.tplTF)

	setText(self.otherTF:Find("title/Text"), i18n("child_news_other_title"))
	setText(self.otherTF:Find("empty/Text"), i18n("child_news_other_empty"))

	return
end

function EducateNewsLayer:addListener()
	onButton(self, self._tf:Find("anim_root/bg"), function()
		self:_close()

		return
	end, SFX_PANEL)

	return
end

function EducateNewsLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self:initNewsList()
	self:updateNewsList()

	return
end

function EducateNewsLayer:initNewsList()
	self.importUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:updateEventItem(arg_10_1, arg_10_2, true)
		end

		return
	end)
	self.otherUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:updateEventItem(arg_11_1, arg_11_2, false)
		end

		return
	end)

	return
end

function EducateNewsLayer:updateEventItem(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0

	if arg_12_3 then
		var_12_0 = self.importEvents[arg_12_1 + 1] or self.otherEvents[arg_12_1 + 1]
	end

	local var_12_1 = var_12_0:GetTag(self.finishEvents, self.curTime.week)
	local var_12_2 = EducateSpecialEvent.TAG2NAME[var_12_1]

	setImageColor(arg_12_2:Find("block"), Color.NewHex(var_0_1[var_12_1]))
	setText(arg_12_2:Find("name"), var_12_0:getConfig("main_desc"))
	setTextColor(arg_12_2:Find("name"), Color.NewHex(var_0_2[var_12_1]))
	eachChild(arg_12_2:Find("name/tags"), function(arg_13_0)
		setActive(arg_13_0, arg_13_0.name == var_12_2)

		return
	end)
	setText(arg_12_2:Find("time/Text"), var_12_0:GetTimeDesc())

	return
end

function EducateNewsLayer:updateNewsList()
	local var_14_0 = CompareFuncs({
		function(arg_15_0)
			return arg_15_0:GetTag(self.finishEvents, self.curTime.week)
		end,
		function(arg_16_0)
			return arg_16_0.id
		end
	})

	table.sort(self.importEvents, var_14_0)
	table.sort(self.otherEvents, var_14_0)
	setActive(self.importTF:Find("empty"), #self.importEvents <= 0)
	setActive(self.otherTF:Find("empty"), #self.otherEvents <= 0)
	self.importUIList:align(#self.importEvents)
	self.otherUIList:align(#self.otherEvents)

	return
end

function EducateNewsLayer:_close()
	self.anim:Play("anim_educate_newsUI_out")

	return
end

function EducateNewsLayer:onBackPressed()
	self:_close()

	return
end

function EducateNewsLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateNewsLayer
