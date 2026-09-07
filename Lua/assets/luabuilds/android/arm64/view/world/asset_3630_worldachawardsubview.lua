local WorldAchAwardSubview = class("WorldAchAwardSubview", import("view.base.BaseSubView"))

WorldAchAwardSubview.ShowDrop = "WorldAchAwardSubview.ShowDrop"

function WorldAchAwardSubview:getUIName()
	return "WorldAchAwardSubview"
end

function WorldAchAwardSubview:OnLoaded()
	return
end

function WorldAchAwardSubview:OnInit()
	self.textTitle = self._tf:Find("title/Text")
	self.btnBG = self._tf:Find("bg")
	self.itemContent = self._tf:Find("award_list/content")
	self.itemList = UIItemList.New(self.itemContent, self.itemContent:Find("item"))

	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.awards[arg_4_1]
			local var_4_1 = not self.nextStar or var_4_0.star < self.nextStar
			local var_4_2 = self.nextStar and var_4_0.star == self.nextStar
			local var_4_3 = self.nextStar and var_4_0.star > self.nextStar
			local var_4_4 = arg_4_2:Find("award")

			setActive(var_4_4, true)
			setActive(arg_4_2:Find("lock_award"), false)
			updateDrop(var_4_4, var_4_0.drop)
			setGray(var_4_4:Find("icon_bg"), var_4_1 or var_4_3)
			onButton(self, var_4_4, function()
				self:emit(WorldAchAwardSubview.ShowDrop, var_4_0.drop)

				return
			end, SFX_PANEL)
			setText(arg_4_2:Find("star/count"), var_4_0.star)
			setActive(arg_4_2:Find("star/bg_on"), var_4_2)
			setActive(arg_4_2:Find("star/bg_off"), not var_4_2)
			setActive(arg_4_2:Find("star/lock"), var_4_3)
			setActive(arg_4_2:Find("ready_mark"), var_4_2 and not var_4_1 and not self.hasAward)
			setActive(arg_4_2:Find("get_mark"), var_4_2 and self.hasAward)
			setActive(arg_4_2:Find("got_mark"), var_4_1)
			setActive(arg_4_2:Find("lock_mark"), var_4_3)
			setActive(arg_4_2:Find("mark/on"), var_4_1)
			setActive(arg_4_2:Find("mark/off"), not var_4_1)
		end

		return
	end)
	onButton(self, self.btnBG, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function WorldAchAwardSubview:OnDestroy()
	return
end

function WorldAchAwardSubview:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function WorldAchAwardSubview:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function WorldAchAwardSubview:isShowing()
	return self._tf and isActive(self._tf)
end

function WorldAchAwardSubview:Setup(arg_11_1)
	self.awards = arg_11_1:GetAchievementAwards()

	local var_11_0, var_11_1 = nowWorld():AnyUnachievedAchievement(arg_11_1)

	self.hasAward = var_11_0

	if var_11_1 then
		self.nextStar = var_11_1.star or nil
	end

	self.itemList:align(#self.awards)
	setText(self._tf:Find("title/Text"), arg_11_1:GetBaseMap():GetName())

	return
end

return WorldAchAwardSubview
