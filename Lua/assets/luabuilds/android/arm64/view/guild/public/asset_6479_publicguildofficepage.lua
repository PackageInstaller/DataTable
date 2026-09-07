local PublicGuildOfficePage = class("PublicGuildOfficePage", import("...base.BaseSubView"))

function PublicGuildOfficePage:getUIName()
	return "PublicGuildDonateBluePage"
end

function PublicGuildOfficePage:OnLoaded()
	self.itemList = UIItemList.New(self._tf:Find("frame/donate_panel/list"), self._tf:Find("frame/donate_panel/list/tpl"))
	self.cntTxt = self._tf:Find("frame/donate_panel/cnt/Text"):GetComponent(typeof(Text))

	return
end

function PublicGuildOfficePage:OnInit()
	self.cards = {}

	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateDonateTask(arg_4_2, self.displays[arg_4_1 + 1])
		end

		return
	end)

	return
end

function PublicGuildOfficePage:Show(arg_5_1)
	self.guild = arg_5_1

	self:Flush()
	PublicGuildOfficePage.super.Show(self)

	return
end

function PublicGuildOfficePage:Flush()
	self.displays = self.guild:GetDonateTasks()

	self.itemList:align(#self.displays)
	pg.GuildPaintingMgr.GetInstance():Update("guild_office_blue", Vector3(-737, -171, 0))

	return
end

function PublicGuildOfficePage:UpdateDonateTask(arg_7_1, arg_7_2)
	local var_7_0 = self.guild:GetRemainDonateCnt()
	local var_7_1 = self.cards[arg_7_1]

	if not self.cards[arg_7_1] then
		var_7_1 = GuildDonateCard.New(arg_7_1)
		self.cards[arg_7_1] = var_7_1
	end

	var_7_1:update(arg_7_2)
	onButton(self, var_7_1.commitBtn, function()
		local var_8_0 = var_7_1.dtask
		local var_8_1 = var_7_1.dtask:getCommitItem()
		local var_8_2 = Drop.Create(var_8_1)
		local var_8_3 = var_7_1:GetResCntByAward(var_8_1)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_donate_tip", var_8_2:getConfig("name"), var_8_1[3], var_8_3, var_8_3 < var_8_1[3] and "#FF5C5CFF" or "#92FC63FF"),
			onYes = function()
				self:emit(PublicGuildMainMediator.ON_COMMIT, var_8_0.id)

				return
			end
		})

		return
	end, SFX_PANEL)
	setButtonEnabled(var_7_1.commitBtn, var_7_0 > 0)

	self.cntTxt.text = i18n("guild_left_donate_cnt", var_7_0)

	return
end

function PublicGuildOfficePage:OnDestroy()
	return
end

return PublicGuildOfficePage
