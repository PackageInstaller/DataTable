local GuildTechnologyCard = class("GuildTechnologyCard")

function GuildTechnologyCard:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_2

	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.titleImg = self._tf:Find("title"):GetComponent(typeof(Text))
	self.iconImag = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.levelTxt = self._tf:Find("level"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("desc"):GetComponent(typeof(Text))
	self.upgradeTF = self._tf:Find("upgrade")
	self.guildRes = self.upgradeTF:Find("cion")
	self.guildResTxt = self.upgradeTF:Find("cion/Text"):GetComponent(typeof(Text))
	self.goldRes = self.upgradeTF:Find("gold")
	self.goldResTxt = self.upgradeTF:Find("gold/Text"):GetComponent(typeof(Text))
	self.upgradeBtn = self.upgradeTF:Find("upgrade_btn")
	self.maxTF = self._tf:Find("max")
	self.breakoutTF = self._tf:Find("breakout")
	self.breakoutSlider = self._tf:Find("progress"):GetComponent(typeof(Slider))
	self.breakoutTxt = self._tf:Find("progress/Text"):GetComponent(typeof(Text))
	self.livnessTF = self.upgradeTF:Find("livness")

	setActive(self.breakoutSlider.gameObject, false)
	setActive(self.upgradeTF, false)
	setActive(self.maxTF, false)
	setActive(self.breakoutTF, false)

	return
end

function GuildTechnologyCard:Update(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.group.id

	self.titleImg.text = arg_2_1:getConfig("name")
	self.iconImag.sprite = GetSpriteFromAtlas("GuildTechnology", var_2_0)

	local var_2_1 = arg_2_1:GetMaxLevel()
	local var_2_2 = arg_2_1:GetLevel()
	local var_2_3 = arg_2_1.group:GetFakeLevel()
	local var_2_4 = math.max(var_2_1, var_2_3)

	self.levelTxt.text = arg_2_1:IsGuildMember() and "Lv." .. var_2_2 or "Lv." .. var_2_2 .. "/" .. var_2_4 .. string.format(" [%s+%s]", var_2_1, math.max(0, var_2_3 - var_2_1))
	self.descTxt.text = arg_2_1:GetDesc()

	setActive(self.maxTF, var_2_4 <= var_2_2)
	setActive(self.upgradeTF, var_2_2 < var_2_4)

	local var_2_5 = arg_2_1:_ReachTargetLiveness_()

	removeOnButton(self._tf)

	if arg_2_1:CanUpgrade() then
		var_2_5 = true

		local var_2_6, var_2_7 = arg_2_1:GetConsume()

		self.guildResTxt.text = var_2_6
		self.goldResTxt.text = var_2_7

		onButton(self, self._tf, function()
			if var_2_2 >= var_2_4 then
				return
			end

			self:DoUprade(arg_2_1)

			return
		end, SFX_PANEL)
	elseif not var_2_5 then
		setText(self.livnessTF, i18n("guild_tech_livness_no_enough_label", arg_2_1:GetTargetLivness()))
	end

	setActive(self.guildRes, var_2_5)
	setActive(self.goldRes, var_2_5)
	setActive(self.upgradeBtn, var_2_5)
	setActive(self.livnessTF, not var_2_5)

	local var_2_8 = arg_2_2 and arg_2_2.id == var_2_0

	setActive(self.breakoutSlider.gameObject, arg_2_2 and arg_2_2.id == var_2_0)

	if var_2_8 then
		local var_2_9 = arg_2_2:GetTargetProgress()
		local var_2_10 = arg_2_2:GetProgress()

		self.breakoutSlider.value = var_2_10 / var_2_9
		self.breakoutTxt.text = var_2_10 .. "/" .. var_2_9
	end

	return
end

function GuildTechnologyCard:DoUprade(arg_4_1)
	local function var_4_0()
		local var_5_0, var_5_1 = arg_4_1:GetConsume()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_tech_consume_tip", var_5_0, var_5_1, (arg_4_1:getConfig("name"))),
			onYes = function()
				self.view:emit(GuildTechnologyMediator.ON_UPGRADE, arg_4_1.group.id)

				return
			end
		})

		return
	end

	local function var_4_1(arg_7_0)
		if arg_4_1:IsRiseInPrice() then
			local var_7_0, var_7_1, var_7_2 = arg_4_1:CanUpgradeBySelf()
			local var_7_3 = i18n("guild_tech_price_inc_tip")

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = (var_7_2 and not var_7_1 or nil) and i18n("guild_tech_livness_no_enough", (arg_4_1:GetLivenessOffset())),
				onYes = arg_7_0
			})
		else
			arg_7_0()
		end

		return
	end

	seriesAsync({
		function(arg_8_0)
			var_4_1(arg_8_0)

			return
		end,
		function(arg_9_0)
			var_4_0()

			return
		end
	})

	return
end

function GuildTechnologyCard:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return GuildTechnologyCard
