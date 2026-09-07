local GuildTechnologyGroupCard = class("GuildTechnologyGroupCard", import(".GuildTechnologyCard"))

function GuildTechnologyGroupCard:Ctor(arg_1_1, arg_1_2)
	GuildTechnologyGroupCard.super.Ctor(self, arg_1_1, arg_1_2)

	self.devBtn = self.breakoutTF:Find("dev_btn")
	self.cancelBtn = self.breakoutTF:Find("cancel_btn")
	self.devBtnTxt = self.devBtn:Find("Text"):GetComponent(typeof(Text))

	return
end

function GuildTechnologyGroupCard:Update(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.id

	self.titleImg.text = arg_2_1:getConfig("name")
	self.iconImag.sprite = GetSpriteFromAtlas("GuildTechnology", arg_2_1.id)
	self.descTxt.text = arg_2_1:GetDesc()

	local var_2_1 = arg_2_1:GetMaxLevel()
	local var_2_2 = arg_2_1:GetLevel()
	local var_2_3 = arg_2_1:GetState()

	setActive(self.maxTF, var_2_1 <= var_2_2)
	setActive(self.breakoutTF, var_2_2 < var_2_1)
	setActive(self.devBtn, var_2_3 == GuildTechnologyGroup.STATE_STOP and var_2_2 < var_2_1)
	setActive(self.breakoutSlider.gameObject, var_2_3 == GuildTechnologyGroup.STATE_START)
	setActive(self.cancelBtn, false)

	if var_2_2 < var_2_1 then
		onButton(self, self._tf, function()
			if not arg_2_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_non_admin"))

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_start_tech_group_tip", arg_2_1:getConfig("name")),
				onYes = function()
					self.view:emit(GuildTechnologyMediator.ON_START, var_2_0)

					return
				end
			})

			return
		end, SFX_PANEL)

		self.levelTxt.text = "Lv." .. var_2_2 .. "/" .. var_2_1
	else
		self.levelTxt.text = "Lv." .. var_2_1 .. "/" .. var_2_1
	end

	if var_2_3 == GuildTechnologyGroup.STATE_START then
		local var_2_4 = arg_2_1:GetTargetProgress()
		local var_2_5 = arg_2_1:GetProgress()

		self.breakoutSlider.value = var_2_5 / var_2_4
		self.breakoutTxt.text = var_2_5 .. "/" .. var_2_4
	end

	onButton(self, self.cancelBtn, function()
		if not arg_2_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_non_admin"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_cancel_tech_tip", arg_2_1:getConfig("name")),
			onYes = function()
				self.view:emit(GuildTechnologyMediator.ON_CANCEL_TECH, var_2_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	self.devBtnTxt.text = i18n("guild_tech_donate_target", arg_2_1:GetTargetProgress())

	return
end

return GuildTechnologyGroupCard
