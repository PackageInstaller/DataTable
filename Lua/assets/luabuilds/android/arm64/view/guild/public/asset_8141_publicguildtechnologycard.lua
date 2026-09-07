local PublicGuildTechnologyCard = class("PublicGuildTechnologyCard", import("..cards.GuildTechnologyCard"))

function PublicGuildTechnologyCard:Update(arg_1_1)
	local var_1_0 = arg_1_1.group.id
	local var_1_1 = arg_1_1.group
	local var_1_2 = arg_1_1:getConfig("name")

	self.titleImg.text = var_1_2
	self.iconImag.sprite = GetSpriteFromAtlas("GuildTechnology", arg_1_1.group.id)

	local var_1_3 = arg_1_1:GetMaxLevel()
	local var_1_4 = arg_1_1:GetLevel()

	self.levelTxt.text = arg_1_1:IsGuildMember() and "Lv." .. var_1_4 or "Lv." .. var_1_4 .. "/" .. var_1_3
	self.descTxt.text = arg_1_1:GetDesc()

	setActive(self.maxTF, var_1_3 <= var_1_4)
	setActive(self.upgradeTF, var_1_4 < var_1_3)
	removeOnButton(self._tf)

	if var_1_4 < var_1_3 then
		local var_1_5, var_1_6 = arg_1_1:GetConsume()

		self.guildResTxt.text = var_1_5
		self.goldResTxt.text = var_1_6

		onButton(self, self._tf, function()
			if var_1_4 >= var_1_3 then
				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_tech_consume_tip", var_1_5, var_1_6, var_1_2),
				onYes = function()
					self.view:emit(PublicGuildMainMediator.UPGRADE_TECH, var_1_0)

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	setActive(self.guildRes, true)
	setActive(self.goldRes, true)
	setActive(self.upgradeBtn, true)
	setActive(self.livnessTF, not true)
	setActive(self.breakoutSlider.gameObject, true)

	if true then
		local var_1_7 = var_1_1:GetTargetProgress()
		local var_1_8 = var_1_1:GetProgress()

		self.breakoutSlider.value = var_1_8 / var_1_7
		self.breakoutTxt.text = var_1_8 .. "/" .. var_1_7
	end

	return
end

return PublicGuildTechnologyCard
