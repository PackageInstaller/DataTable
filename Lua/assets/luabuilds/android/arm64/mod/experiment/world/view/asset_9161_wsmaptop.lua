local WSMapTop = class("WSMapTop", import("...BaseEntity"))

WSMapTop.Fields = {
	map = "table",
	btnBack = "userdata",
	rtGlobalBuffs = "userdata",
	gid = "number",
	rtResource = "userdata",
	rtTime = "userdata",
	cmdSkills = "table",
	rtFleetBuffs = "userdata",
	flashTimer = "table",
	entrance = "table",
	rtCmdSkills = "userdata",
	fleet = "table",
	rtPoisonRate = "userdata",
	rtMapName = "userdata",
	rtFlashTipWord = "userdata",
	cmdSkillFunc = "function",
	fleetBuffItemList = "table",
	world = "table",
	transform = "userdata",
	globalBuffItemList = "table",
	cmdSkillItemList = "table",
	globalBuffs = "table",
	poisonFunc = "function",
	fleetBuffs = "table",
	rtMoveLimit = "userdata"
}
WSMapTop.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onUpdateGlobalBuff = "OnUpdateGlobalBuff",
	onUpdateFlashTips = "OnUpdateFlashTips",
	onUpdateCmdSkill = "OnUpdateCmdSkill",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function WSMapTop:Setup()
	local var_1_0 = nowWorld()

	var_1_0:AddListener(World.EventUpdateGlobalBuff, self.onUpdateGlobalBuff)
	var_1_0:GetAtlas():AddListener(WorldAtlas.EventUpdateActiveMap, self.onUpdateFleetBuff)
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSMapTop:Dispose()
	if self.flashTimer then
		self.flashTimer.func()
	end

	local var_2_0 = nowWorld()

	var_2_0:RemoveListener(World.EventUpdateGlobalBuff, self.onUpdateGlobalBuff)
	var_2_0:GetAtlas():RemoveListener(WorldAtlas.EventUpdateActiveMap, self.onUpdateFleetBuff)
	self:RemoveFleetListener(self.fleet)
	self:RemoveMapListener()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

local function var_0_1(arg_3_0, arg_3_1)
	if arg_3_1.config.icon and #arg_3_1.config.icon > 0 then
		GetImageSpriteFromAtlasAsync("world/buff/" .. arg_3_1.config.icon, "", arg_3_0:Find("icon"))
	else
		clearImageSprite(arg_3_0:Find("icon"))
	end

	setText(arg_3_0:Find("floor"), arg_3_1:GetFloor())
	setActive(arg_3_0:Find("floor"), arg_3_1.config.buff_maxfloor > 1)

	local var_3_0 = arg_3_1:GetLost()

	setText(arg_3_0:Find("lost"), var_3_0)
	setActive(arg_3_0:Find("lost"), var_3_0)
	onButton(self, arg_3_0, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_confirm",
			hideNo = true,
			content = "",
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = Drop.New({
				isWorldBuff = true,
				type = DROP_TYPE_STRATEGY,
				id = arg_3_1.id
			})
		})

		return
	end, SFX_PANEL)

	return
end

function WSMapTop:Init()
	self.btnBack = self.transform:Find("back_button")
	self.rtMapName = self.transform:Find("title/name")
	self.rtTime = self.transform:Find("title/time")
	self.rtResource = self.transform:Find("resources")
	self.rtGlobalBuffs = self.transform:Find("features/status_field/global_buffs")
	self.rtMoveLimit = self.transform:Find("features/status_field/move_limit")
	self.rtPoisonRate = self.transform:Find("features/status_field/poison_rate")
	self.rtFleetBuffs = self.transform:Find("features/fleet_field/fleet_buffs")
	self.rtCmdSkills = self.transform:Find("features/fleet_field/cmd_skills")
	self.rtFlashTipWord = self.transform:Find("flash_tip_word")

	setActive(self.rtFlashTipWord, false)
	setText(self.rtMapName, "")
	setText(self.rtTime, "")

	self.globalBuffItemList = UIItemList.New(self.rtGlobalBuffs, self.rtGlobalBuffs:GetChild(0))

	self.globalBuffItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			var_0_1(arg_6_2, self.globalBuffs[arg_6_1 + 1])
		end

		return
	end)

	self.fleetBuffItemList = UIItemList.New(self.rtFleetBuffs, self.rtFleetBuffs:GetChild(0))

	self.fleetBuffItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			var_0_1(arg_7_2, self.fleetBuffs[arg_7_1 + 1])
		end

		return
	end)

	self.cmdSkillItemList = UIItemList.New(self.rtCmdSkills, self.rtCmdSkills:GetChild(0))

	self.cmdSkillItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = self.cmdSkills[arg_8_1 + 1]

			GetImageSpriteFromAtlasAsync("commanderskillicon/" .. self.cmdSkills[arg_8_1 + 1]:getConfig("icon"), "", arg_8_2:Find("icon"))
			setText(arg_8_2:Find("floor"), "Lv." .. self.cmdSkills[arg_8_1 + 1]:getConfig("lv"))
			setActive(arg_8_2:Find("floor"), true)
			setActive(arg_8_2:Find("lost"), false)
			onButton(self, arg_8_2, function()
				self.cmdSkillFunc(var_8_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function WSMapTop:Update(arg_10_1, arg_10_2)
	if self.entrance ~= arg_10_1 or self.map ~= arg_10_2 or self.gid ~= arg_10_2.gid then
		self:RemoveMapListener()

		self.entrance = arg_10_1
		self.map = arg_10_2
		self.gid = arg_10_2.gid

		self:AddMapListener()
		self:OnUpdateMap()
		self:OnUpdateSelectedFleet()
		self:OnUpdateGlobalBuff()
		self:OnUpdatePoison()
		self:OnUpdateMoveLimit()
	end

	return
end

function WSMapTop:AddMapListener()
	if self.map then
		self.map:AddListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapTop:RemoveMapListener()
	if self.map then
		self.map:RemoveListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapTop:AddFleetListener(arg_13_1)
	if arg_13_1 then
		arg_13_1:AddListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBuff)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateDamageLevel, self.onUpdateFleetBuff)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateCatSalvage, self.onUpdateCmdSkill)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateFlashTips, self.onUpdateFlashTips)
	end

	return
end

function WSMapTop:RemoveFleetListener(arg_14_1)
	if arg_14_1 then
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBuff)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateDamageLevel, self.onUpdateFleetBuff)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateCatSalvage, self.onUpdateCmdSkill)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateFlashTips, self.onUpdateFlashTips)
	end

	return
end

function WSMapTop:OnUpdateMap()
	setText(self.rtMapName, self.map:GetName(self.entrance))

	return
end

function WSMapTop:OnUpdateSelectedFleet()
	local var_16_0 = self.map:GetFleet()

	if self.fleet ~= var_16_0 then
		self:RemoveFleetListener(self.fleet)

		self.fleet = var_16_0

		self:AddFleetListener(self.fleet)
		self:OnUpdateFleetBuff()
		self:OnUpdateCmdSkill()
	end

	return
end

function WSMapTop:OnUpdateGlobalBuff()
	self.globalBuffs = nowWorld():GetWorldMapBuffs()

	self.globalBuffItemList:align(#self.globalBuffs)

	return
end

function WSMapTop:OnUpdateMoveLimit()
	local var_18_0 = not self.map:IsUnlockFleetMode()

	setActive(self.rtMoveLimit, var_18_0)

	if var_18_0 then
		local var_18_1 = WorldBuff.New()

		var_18_1:Setup({
			floor = 0,
			id = WorldConst.MoveLimitBuffId
		})
		var_0_1(self.rtMoveLimit, var_18_1)
	end

	return
end

function WSMapTop:OnUpdatePoison()
	local var_19_0, var_19_1 = self.map:GetEventPoisonRate()

	setActive(self.rtPoisonRate, var_19_1 > 0)

	if var_19_1 > 0 then
		local var_19_2 = calcFloor(var_19_0 / var_19_1 * 100)
		local var_19_3 = Clone(pg.gameset.world_sairen_infection.description)

		table.insert(var_19_3, 1, 0)
		table.insert(var_19_3, 999)
		eachChild(self.rtPoisonRate:Find("bg/ring"), function(arg_20_0)
			local var_20_0 = arg_20_0:GetSiblingIndex() + 1

			if var_19_2 >= var_19_3[var_20_0] and var_19_2 < var_19_3[var_20_0 + 1] then
				setActive(arg_20_0, true)

				arg_20_0:GetComponent(typeof(Image)).fillAmount = var_19_2 / 100
			else
				setActive(arg_20_0, false)
			end

			setText(self.rtPoisonRate:Find("bg/Text"), var_19_2 .. "%")

			return
		end)
		onButton(self, self.rtPoisonRate, function()
			self.poisonFunc(var_19_2)

			return
		end, SFX_PANEL)
	end

	return
end

function WSMapTop:OnUpdateFleetBuff()
	self.fleetBuffs = self.fleet:GetBuffList()

	local var_22_0 = self.fleet:GetDamageBuff()

	if var_22_0 then
		table.insert(self.fleetBuffs, 1, var_22_0)
	end

	self.fleetBuffItemList:align(#self.fleetBuffs)
	setActive(self.rtFleetBuffs, #self.fleetBuffs > 0)

	return
end

function WSMapTop:OnUpdateCmdSkill()
	self.cmdSkills = self.fleet:IsCatSalvage() and {} or _.map(_.values(self.fleet:getCommanders()), function(arg_24_0)
		return arg_24_0:getSkills()[1]
	end)

	self.cmdSkillItemList:align(#self.cmdSkills)
	setActive(self.rtCmdSkills, #self.cmdSkills > 0)

	return
end

function WSMapTop:OnUpdateFlashTips(arg_25_1, arg_25_2, arg_25_3)
	if self.flashTimer then
		self.flashTimer.func()
	end

	setActive(self.rtFlashTipWord, true)
	quickPlayAnimation(self.rtFlashTipWord, "anim_flash_tip_word_in")
	setText(self.rtFlashTipWord:Find("Text"), HXSet.hxLan(arg_25_3))

	local var_25_0 = GetOrAddComponent(self.rtFlashTipWord:Find("Text"), typeof(Typewriter))

	self.flashTimer = Timer.New(function()
		if self.flashTimer then
			self.flashTimer:Stop()

			self.flashTimer = nil
		end

		local function var_26_1()
			var_26_1 = nil

			setActive(self.rtFlashTipWord, false)

			return
		end

		self.rtFlashTipWord:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			existCall(var_26_1)

			return
		end)
		quickPlayAnimation(self.rtFlashTipWord, "anim_flash_tip_word_out")

		return
	end, getGameset("world_tip_last")[1])

	function var_25_0.endFunc()
		if self.flashTimer then
			self.flashTimer:Start()
		end

		return
	end

	var_25_0:setSpeed(getGameset("world_tip_typewriter")[2][1])
	var_25_0:Play()

	return
end

return WSMapTop
