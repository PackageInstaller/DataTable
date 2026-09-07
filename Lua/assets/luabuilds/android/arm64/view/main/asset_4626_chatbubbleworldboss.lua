local ChatBubbleWorldBoss = class("ChatBubbleWorldBoss")

function ChatBubbleWorldBoss:Ctor(arg_1_1, arg_1_2)
	self.tf = tf(arg_1_1)
	self.interactable = defaultValue(arg_1_2, true)
	self.nameTF = findTF(self.tf, "desc/name"):GetComponent("Text")
	self.face = findTF(self.tf, "face/content")
	self.circle = findTF(self.tf, "shipicon/frame")
	self.timeTF = findTF(self.tf, "time"):GetComponent("Text")
	self.headTF = findTF(self.tf, "shipicon/icon"):GetComponent("Image")
	self.stars = findTF(self.tf, "shipicon/stars")
	self.star = findTF(self.stars, "star")
	self.dutyTF = findTF(self.tf, "desc/duty")
	self.channel = findTF(self.tf, "desc/channel")
	self.chatframe = findTF(self.tf, "chat_fram")
	self.chatContent = findTF(self.tf, "chat_fram/Text"):GetComponent("Text")
	self.chatframeSel = findTF(self.tf, "chat_fram/sel")
	self.chatframeUnsel = findTF(self.tf, "chat_fram/unsel")

	setActive(self.chatframeSel, true)
	setActive(self.chatframeUnsel, false)

	return
end

function ChatBubbleWorldBoss:update(arg_2_1)
	if self.data == arg_2_1 then
		return
	end

	self.data = arg_2_1

	if arg_2_1.player.icon == 0 then
		arg_2_1.player.icon = 101171
	end

	local var_2_0 = arg_2_1.player.propose

	self.nameTF.text = arg_2_1.player.name
	self.timeTF.text = getOfflineTimeStamp(arg_2_1.timestamp)

	local var_2_1 = pg.ship_data_statistics[arg_2_1.player.icon]

	for iter_2_0 = self.stars.childCount, Ship.New({
		configId = pg.ship_data_statistics[arg_2_1.player.icon].id
	}):getStar() - 1 do
		cloneTplTo(self.star, self.stars)
	end

	for iter_2_1 = 0, self.stars.childCount - 1 do
		self.stars:GetChild(iter_2_1).gameObject:SetActive(iter_2_1 < var_2_1.star)
	end

	if self.channel then
		setImageSprite(self.channel, GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_2_1.type) .. "_1920"), true)
	end

	self.headTF.color = Color.New(1, 1, 1, 0)

	LoadSpriteAsync("qicon/" .. arg_2_1.player:getPainting(), function(arg_3_0)
		if not IsNil(self.headTF) then
			self.headTF.color = Color.white
			self.headTF.sprite = arg_3_0 or LoadSprite("heroicon/unknown")
		end

		return
	end)

	if self.dutyTF then
		setActive(self.dutyTF, arg_2_1.player.duty)

		if arg_2_1.player.duty then
			setImageSprite(self.dutyTF, GetSpriteFromAtlas("dutyicon", arg_2_1.player.duty), true)
		end
	end

	local var_2_2 = AttireFrame.attireFrameRes(arg_2_1.player, false, AttireConst.TYPE_ICON_FRAME, var_2_0)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_2_2, var_2_2, true, function(arg_4_0)
		if IsNil(self.tf) then
			return
		end

		if self.circle and self.data then
			arg_4_0.name = var_2_2
			findTF(arg_4_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_4_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_2_2, var_2_2, arg_4_0)
		end

		return
	end)

	local var_2_3 = arg_2_1.args.wordBossId

	onButton(nil, self.chatframe, function()
		if not self.interactable then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_inbattle"))

			return
		end

		if arg_2_1.args.isDeath then
			self:SetGray()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))

			return
		end

		pg.WorldBossTipMgr.GetInstance():OnClick("", var_2_3, arg_2_1.args.lastTime, function()
			self:SetGray()

			return
		end)

		return
	end, SFX_PANEL)

	if arg_2_1.args.isDeath then
		self:SetGray()
	end

	self.chatContent.text = i18n("world_boss_ad", arg_2_1.args.bossName, arg_2_1.args.level)

	return
end

function ChatBubbleWorldBoss:SetGray()
	setActive(self.chatframeSel, false)
	setActive(self.chatframeUnsel, true)

	return
end

function ChatBubbleWorldBoss:dispose()
	removeOnButton(self.chatframe)

	if self.circle.childCount > 0 then
		local var_8_0 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_8_0.name, var_8_0.name, var_8_0)
	end

	return
end

return ChatBubbleWorldBoss
