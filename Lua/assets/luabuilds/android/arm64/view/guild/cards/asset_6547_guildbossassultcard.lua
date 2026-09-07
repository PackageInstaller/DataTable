local GuildBossAssultCard = class("GuildBossAssultCard")

function GuildBossAssultCard:Ctor(arg_1_1)
	self._tr = tf(arg_1_1)
	self._go = arg_1_1
	self.mask = findTF(self._tr, "mask"):GetComponent(typeof(Image))
	self.icon = findTF(self._tr, "icon/icon"):GetComponent(typeof(Image))
	self.shipNameTxt = findTF(self._tr, "info/shipname"):GetComponent(typeof(Text))
	self.userNameTxt = findTF(self._tr, "info/username"):GetComponent(typeof(Text))
	self.levelTxt = findTF(self._tr, "info/lv/Text"):GetComponent(typeof(Text))
	self.startList = UIItemList.New(findTF(self._tr, "info/stars"), findTF(self._tr, "info/stars/star_tpl"))
	self.recommendBtn = findTF(self._tr, "info/recom_btn")
	self.recommendBtnMark = self.recommendBtn:Find("mark")
	self.viewEquipmentBtn = findTF(self._tr, "info/view_equipment")
	self.tag = findTF(self._tr, "tag")

	return
end

function GuildBossAssultCard:Flush(arg_2_1, arg_2_2)
	self.shipNameTxt.text = arg_2_2:getName()
	self.ship = arg_2_2
	self.member = arg_2_1
	self.levelTxt.text = arg_2_2.level

	local var_2_0 = arg_2_2:getStar()

	self.startList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("star_tpl"), arg_3_1 <= var_2_0)
		end

		return
	end)
	self.startList:align((arg_2_2:getMaxStar()))

	self.userNameTxt.text = i18n("guild_ship_from") .. arg_2_1.name

	LoadSpriteAsync("shipYardIcon/" .. arg_2_2:getPainting(), function(arg_4_0)
		if self._tr then
			self.icon.sprite = arg_4_0
		end

		return
	end)

	local var_2_1 = arg_2_2:rarity2bgPrint()
	local var_2_2 = false

	if #var_2_1 > 1 then
		if string.sub(var_2_1, 1, 1) == "1" then
			var_2_2 = true
		else
			var_2_1 = string.sub(var_2_1, 2, 1)
		end
	end

	self:LoadMetaEffect(var_2_2)

	self.mask.sprite = GetSpriteFromAtlas("ui/GuildBossAssultUI_atlas", var_2_1)

	setActive(self.recommendBtnMark, arg_2_2.guildRecommand)
	setActive(self.tag, arg_2_2.guildRecommand)
	setActive(self.recommendBtn, GuildMember.IsAdministrator((getProxy(GuildProxy):getRawData():getSelfDuty())))

	return
end

local var_0_1 = "meta_huoxing"

function GuildBossAssultCard:LoadMetaEffect(arg_5_1)
	if self.loading then
		self.destoryMetaEffect = not arg_5_1

		return
	end

	if arg_5_1 and not self.metaEffect then
		self.loading = true

		PoolMgr.GetInstance():GetUI(var_0_1, true, function(arg_6_0)
			self.loading = nil

			if self.destoryMetaEffect then
				self:RemoveMetaEffect()

				self.destoryMetaEffect = nil
			else
				self.metaEffect = arg_6_0

				SetParent(self.metaEffect, self._tr)
				setActive(arg_6_0, true)
			end

			return
		end)
	elseif not arg_5_1 and self.metaEffect then
		self:RemoveMetaEffect()
	elseif self.metaEffect then
		setActive(self.metaEffect, true)
	end

	return
end

function GuildBossAssultCard:RemoveMetaEffect()
	if self.metaEffect then
		PoolMgr.GetInstance():ReturnUI(var_0_1, self.metaEffect)

		self.metaEffect = nil
	end

	return
end

function GuildBossAssultCard:Dispose()
	self:RemoveMetaEffect()

	self.destoryMetaEffect = true

	return
end

return GuildBossAssultCard
