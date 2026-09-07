local GuildReportCard = class("GuildReportCard")

function GuildReportCard:Ctor(arg_1_1, arg_1_2)
	self.viewComponent = arg_1_2
	self._go = arg_1_1
	self._tf = tf(arg_1_1)

	pg.DelegateInfo.New(self)

	self.bg = self._tf:GetComponent(typeof(Image))
	self.label = self._tf:Find("label"):GetComponent(typeof(Image))
	self.titleTxt = self._tf:Find("title/name"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("desc"):GetComponent(typeof(Text))
	self.awardList = UIItemList.New(self._tf:Find("awards/content"), self._tf:Find("awards/content/item"))
	self.getBtn = self._tf:Find("get")
	self.gotBtn = self._tf:Find("got")
	self.rankBtn = self._tf:Find("rank")

	onButton(self, self.rankBtn, function()
		self.viewComponent:ShowReportRank(self.report.id)

		return
	end, SFX_PANEL)

	return
end

function GuildReportCard:Update(arg_3_1)
	self.report = arg_3_1

	local var_3_0 = arg_3_1:GetType()

	self.bg.sprite = GetSpriteFromAtlas("ui/GuildEventReportUI_atlas", "bg_" .. var_3_0)
	self.label.sprite = GetSpriteFromAtlas("ui/GuildEventReportUI_atlas", "text_" .. var_3_0)

	local var_3_1 = arg_3_1:IsSubmited()

	setActive(self.getBtn, not var_3_1)
	setActive(self.gotBtn, var_3_1)

	if not var_3_1 then
		setGray(self.getBtn, arg_3_1:IsLock(), true)
	end

	self:UpdateAwards()

	self.titleTxt.text = arg_3_1:getConfig("name")
	self.descTxt.text = arg_3_1:GetReportDesc()

	setActive(self.rankBtn, (arg_3_1:IsBoss()))

	return
end

function GuildReportCard:UpdateAwards()
	local var_4_0, var_4_1 = self.report:GetDrop()

	self.awardList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = {
				type = var_4_0[arg_5_1 + 1][1],
				id = var_4_0[arg_5_1 + 1][2],
				count = var_4_0[arg_5_1 + 1][3]
			}

			updateDrop(arg_5_2, var_5_0)
			onButton(self, arg_5_2, function()
				self.viewComponent:emit(BaseUI.ON_DROP, var_5_0)

				return
			end, SFX_PANEL)
			setActive(arg_5_2:Find("icon_bg/bouns"), arg_5_1 + 1 <= var_4_1)
		end

		return
	end)
	self.awardList:align(#var_4_0)

	return
end

function GuildReportCard:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return GuildReportCard
