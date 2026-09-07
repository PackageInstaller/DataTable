local GuildMemberCard = class("GuildMemberCard")

function GuildMemberCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = tf(arg_1_1)
	self.iconTF = self.tf:Find("shipicon/icon"):GetComponent(typeof(Image))
	self.starsTF = self.tf:Find("shipicon/stars")
	self.starTF = self.tf:Find("shipicon/stars/star")
	self.levelTF = self.tf:Find("level/Text"):GetComponent(typeof(Text))
	self.nameTF = self.tf:Find("name_bg/Text"):GetComponent(typeof(Text))
	self.dutyTF = self.tf:Find("duty"):GetComponent(typeof(Image))
	self.livenessTF = self.tf:Find("liveness/Text"):GetComponent(typeof(Text))
	self.onLine = self.tf:Find("online_tag")
	self.offLine = self.tf:Find("last_time")
	self.onLineLabel = self.tf:Find("online")
	self.offLineLabel = self.tf:Find("offline")
	self.offLineText = self.tf:Find("last_time/Text"):GetComponent(typeof(Text))
	self.maskTF = self.tf:Find("mask")
	self.timerTF = self.tf:Find("mask/Text"):GetComponent(typeof(Text))
	self.borderTF = self.tf:Find("selected")
	self.bg = self.tf:Find("bg")
	self.circle = self.tf:Find("shipicon/frame")

	return
end

function GuildMemberCard:Update(arg_2_1, arg_2_2)
	self.memberVO = arg_2_1

	self:Clear()

	local var_2_0 = pg.ship_data_statistics[arg_2_1.icon]

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_2_1.icon,
		skin_id = arg_2_1.skinId,
		propose = arg_2_1.proposeTime
	}):getPainting(), function(arg_3_0)
		if not IsNil(self.iconTF) then
			self.iconTF.sprite = arg_3_0
		end

		return
	end)

	local var_2_1 = AttireFrame.attireFrameRes(arg_2_1, arg_2_1.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, arg_2_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_2_1, var_2_1, true, function(arg_4_0)
		if self.circle and not self.exited then
			arg_4_0.name = var_2_1
			findTF(arg_4_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_4_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_2_1, var_2_1, arg_4_0)
		end

		return
	end)

	self.dutyTF.sprite = GetSpriteFromAtlas("dutyicon", arg_2_1.duty)

	for iter_2_0 = self.starsTF.childCount, var_2_0.star - 1 do
		cloneTplTo(self.starTF, self.starsTF)
	end

	for iter_2_1 = 1, self.starsTF.childCount do
		setActive(self.starsTF:GetChild(iter_2_1 - 1), iter_2_1 <= var_2_0.star)
	end

	self.levelTF.text = arg_2_1.level
	self.nameTF.text = arg_2_1.name
	self.livenessTF.text = arg_2_1.liveness

	setActive(self.onLine, arg_2_1:isOnline())
	setActive(self.offLine, not arg_2_1:isOnline())
	setActive(self.onLineLabel, arg_2_1:isOnline())
	setActive(self.offLineLabel, not arg_2_1:isOnline())

	if not arg_2_1:isOnline() then
		self.offLineText.text = getOfflineTimeStamp(arg_2_1.preOnLineTime)
	end

	local var_2_2 = arg_2_1.duty == GuildConst.DUTY_COMMANDER and arg_2_2:inKickTime()

	setActive(self.maskTF, var_2_2)

	if var_2_2 then
		self:AddTimer(function()
			local var_5_0 = arg_2_2:getKickLeftTime()

			if var_5_0 > 0 then
				self.timerTF.text = pg.TimeMgr.GetInstance():DescCDTime(var_5_0)
			else
				self.timerTF.text = ""

				setActive(self.maskTF, false)
			end

			return
		end)
	end

	return
end

function GuildMemberCard:AddTimer(arg_6_1)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(arg_6_1, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function GuildMemberCard:Clear()
	if self.circle.childCount > 0 then
		local var_7_0 = self.circle:GetChild(0)

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_7_0.gameObject.name, var_7_0.gameObject.name, var_7_0.gameObject)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function GuildMemberCard:SetSelected(arg_8_1)
	setActive(self.borderTF, arg_8_1)
	setActive(self.bg, not arg_8_1)

	return
end

function GuildMemberCard:Dispose()
	self.exited = true

	self:Clear()

	return
end

return GuildMemberCard
