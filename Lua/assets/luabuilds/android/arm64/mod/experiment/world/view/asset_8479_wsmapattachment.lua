local WSMapAttachment = class("WSMapAttachment", import(".WSMapTransform"))

WSMapAttachment.Fields = {
	cell = "table",
	lurkTimer = "table",
	isInit = "boolean",
	map = "table",
	attachment = "table",
	twTimer = "userdata",
	isFighting = "boolean",
	spineChar = "table",
	twBreathId = "number"
}
WSMapAttachment.Listeners = {
	onUpdate = "Update"
}
WSMapAttachment.CharBasePos = Vector2.zero
WSMapAttachment.IconBasePos = Vector2(0, 10)

function WSMapAttachment:GetResName()
	if self.type == WorldMapAttachment.TypeEvent then
		if self:GetReplaceDisplayEnemyConfig() then
			return "enemy_tpl"
		else
			return "event_tpl"
		end
	elseif self.type == WorldMapAttachment.TypeBox then
		return "event_tpl"
	elseif WorldMapAttachment.IsEnemyType(self.type) then
		return "enemy_tpl"
	elseif self.type == WorldMapAttachment.TypePort then
		return "blank_tpl"
	elseif self.type == WorldMapAttachment.TypeTransportFleet then
		return "transport_tpl"
	elseif self.type == WorldMapAttachment.TypeTrap then
		return "event_tpl"
	else
		assert(false, "invalid attachment type: " .. tostring(self.type))
	end

	return
end

function WSMapAttachment:Setup(arg_2_1, arg_2_2, arg_2_3)
	assert(self.worldMapAttachment == nil)

	self.map = arg_2_1
	self.cell = arg_2_2

	self.cell:AddListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:AddListener(WorldMap.EventUpdateMapBuff, self.onUpdate)

	self.attachment = arg_2_3

	self:Init()

	return
end

function WSMapAttachment:Dispose()
	self.cell:RemoveListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:RemoveListener(WorldMap.EventUpdateMapBuff, self.onUpdate)

	if self.twBreathId then
		LeanTween.cancel(self.twBreathId)
	end

	if self.lurkTimer then
		self.lurkTimer:Stop()
	end

	self.transform.localEulerAngles = Vector3.zero

	WSMapAttachment.super.Dispose(self)

	return
end

function WSMapAttachment:Init()
	self.transform.anchoredPosition3D = Vector3.zero
	self.transform.localEulerAngles = Vector3.zero
	self.transform.name = self.attachment:GetDebugName()

	self:SetModelOrder(self.attachment:GetModelOrder(), self.cell.row)
	self:Update()

	return
end

function WSMapAttachment:LoadAvatar(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}

	if arg_5_1 and #arg_5_1 > 0 then
		table.insert(var_5_0, function(arg_6_0)
			self:LoadModel(WorldConst.ModelSpine, arg_5_1, nil, true, function()
				self.model:SetParent(arg_5_2, false)
				arg_6_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_5_0, arg_5_3)

	return
end

function WSMapAttachment:LoadBoxPrefab(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}

	if arg_8_1 and #arg_8_1 > 0 then
		table.insert(var_8_0, function(arg_9_0)
			self:LoadModel(WorldConst.ModelPrefab, WorldConst.ResBoxPrefab .. arg_8_1, arg_8_1, true, function()
				self.model:SetParent(arg_8_2, false)
				arg_9_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_8_0, arg_8_3)

	return
end

function WSMapAttachment:LoadChapterPrefab(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	if arg_11_1 and #arg_11_1 > 0 then
		table.insert(var_11_0, function(arg_12_0)
			self:LoadModel(WorldConst.ModelPrefab, WorldConst.ResChapterPrefab .. arg_11_1, arg_11_1, true, function()
				self.model:SetParent(arg_11_2, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_11_0, arg_11_3)

	return
end

function WSMapAttachment:Update(arg_14_1)
	if self.attachment.type == WorldMapAttachment.TypeEvent then
		if self.attachment:GetReplaceDisplayEnemyConfig() then
			self:UpdateEventEnemy(arg_14_1)
		else
			self:UpdateEvent(arg_14_1)
		end
	elseif self.attachment.type == WorldMapAttachment.TypeBox then
		self:UpdateBox(arg_14_1)
	elseif self.attachment.type == WorldMapAttachment.TypePort then
		self:UpdatePort(arg_14_1)
	elseif WorldMapAttachment.IsEnemyType(self.attachment.type) then
		self:UpdateEnemy(arg_14_1)
	elseif self.attachment.type == WorldMapAttachment.TypeTransportFleet then
		self:UpdateTransportFleet(arg_14_1)
	elseif self.attachment.type == WorldMapAttachment.TypeTrap then
		self:UpdateTrap(arg_14_1)
	else
		assert(false, "invalid attachment type: " .. self.attachment.type)
	end

	self:UpdateBreathTween()
	self:UpdateModelAngles(self.attachment:GetMillor() and Vector3(0, 180, 0) or Vector3.zero)
	self:UpdateModelScale(self.attachment:GetScale())

	return
end

function WSMapAttachment:UpdateEvent(arg_15_1)
	local var_15_0 = self.attachment
	local var_15_1 = self.transform
	local var_15_2 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_15_2)

	if var_15_2 then
		local var_15_3 = var_15_0:IsAvatar()

		if self.isInit and arg_15_1 == WorldMap.EventUpdateMapBuff then
			self:UpdateMapBuff(var_15_1, var_15_0:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_15_0))
		end

		if not self.isInit then
			self.isInit = true

			local var_15_4 = var_15_0.config
			local var_15_5 = var_15_1:Find("char")
			local var_15_6 = var_15_1:Find("icon")

			setActive(var_15_5, var_15_3)
			setActive(var_15_6, not var_15_3)

			if var_15_3 then
				self:LoadAvatar(var_15_0.config.icon, var_15_5:Find("ship"), function()
					if #var_15_4.icon > 0 then
						setAnchoredPosition(self.model, var_15_0:GetDeviation())
					end

					return
				end)
			elseif math.floor(var_15_0.config.enemyicon / 2) == 2 then
				self:LoadChapterPrefab(var_15_0.config.icon, var_15_6, function()
					if #var_15_4.icon > 0 then
						setAnchoredPosition(self.model, var_15_0:GetDeviation())
					end

					return
				end)
			elseif math.floor(var_15_0.config.enemyicon / 2) == 0 then
				self:LoadBoxPrefab(var_15_0.config.icon, var_15_6, function()
					if #var_15_4.icon > 0 then
						setAnchoredPosition(self.model, var_15_0:GetDeviation())
					end

					return
				end)
			else
				assert(false, "enemyicon error from id: " .. var_15_0.id)
			end

			self:UpdateBuffList(var_15_1, var_15_0:GetBuffList())
			self:UpdateMapBuff(var_15_1, var_15_0:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_15_0))
		end

		if arg_15_1 == WorldMapAttachment.EventUpdateLurk and self.cell:GetInFOV() and not var_15_0.lurk then
			setActive(var_15_1:Find("effect_found"), true)

			self.lurkTimer = Timer.New(function()
				setActive(var_15_1:Find("effect_found"), false)

				return
			end, 3, 1)

			self.lurkTimer:Start()
		else
			setActive(var_15_1:Find("effect_found"), false)
		end
	end

	return
end

function WSMapAttachment:UpdateEventEnemy(arg_20_1)
	local var_20_0 = self.attachment
	local var_20_1 = self.transform:Find("live")
	local var_20_2 = self.transform:Find("dead")
	local var_20_3 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_20_3)

	if var_20_3 then
		local var_20_4 = var_20_0:IsAvatar()

		if self.isInit and arg_20_1 == WorldMap.EventUpdateMapBuff then
			self:UpdateMapBuff(var_20_1, var_20_0:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_20_0))
		end

		if not self.isInit then
			self.isInit = true

			local var_20_5 = var_20_0:GetReplaceDisplayEnemyConfig()
			local var_20_6 = var_20_1:Find("char")
			local var_20_7 = var_20_1:Find("icon")

			setActive(var_20_6, var_20_4)
			setActive(var_20_7, not var_20_4)

			if var_20_4 then
				self:LoadAvatar(var_20_5.icon, var_20_6:Find("ship"))
			else
				GetImageSpriteFromAtlasAsync("enemies/" .. var_20_5.icon, "", var_20_7:Find("pic"))

				local var_20_8 = WorldConst.EnemySize[var_20_5.type]

				setActive(var_20_7:Find("size/bg_s"), WorldConst.EnemySize[var_20_5.type] == 1 or not var_20_8)
				setActive(var_20_7:Find("size/bg_m"), var_20_8 == 2)
				setActive(var_20_7:Find("size/bg_h"), var_20_8 == 3)
				setActive(var_20_7:Find("size/bg_boss"), var_20_8 == 99)

				if var_20_5.difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
					setActive(var_20_7:Find("size/bg_boss"), false)
					setText(var_20_7:Find("lv/Text"), WorldConst.WorldLevelCorrect(self.map.config.expedition_level, var_20_5.type))
				else
					setText(var_20_7:Find("lv/Text"), var_20_5.level)
				end

				GetImageSpriteFromAtlasAsync("enemies/" .. var_20_5.icon .. "_d_blue", "", var_20_2:Find("icon"))
			end

			self:UpdateHP(var_20_1:Find("hp"), var_20_0:GetHP(), var_20_0:GetMaxHP())
			self:UpdateBuffList(var_20_1, var_20_0:GetBuffList())
			self:UpdateMapBuff(var_20_1, var_20_0:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_20_0))
		end

		setActive(var_20_1, (var_20_0:IsAlive()))
		setActive(var_20_2, false)
		setActive(var_20_1:Find("fighting"), false)

		if arg_20_1 == WorldMapAttachment.EventUpdateLurk and self.cell:GetInFOV() and not var_20_0.lurk then
			setActive(var_20_1:Find("effect_found"), true)

			self.lurkTimer = Timer.New(function()
				setActive(var_20_1:Find("effect_found"), false)

				return
			end, 3, 1)

			self.lurkTimer:Start()
		else
			setActive(var_20_1:Find("effect_found"), false)
		end
	end

	return
end

function WSMapAttachment:UpdateBox(arg_22_1)
	local var_22_1 = self.transform
	local var_22_2 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_22_2)

	if var_22_2 then
		local var_22_3 = self.attachment:IsAvatar()

		if not self.isInit then
			self.isInit = true

			local var_22_4 = var_22_1:Find("char")
			local var_22_5 = var_22_1:Find("icon")

			setActive(var_22_4, var_22_3)
			setActive(var_22_5, not var_22_3)
			setAnchoredPosition(var_22_4, WSMapAttachment.CharBasePos)
			setAnchoredPosition(var_22_5, WSMapAttachment.IconBasePos)

			if var_22_3 then
				self:LoadAvatar(self.attachment.config.icon, var_22_4:Find("ship"))
			else
				self:LoadBoxPrefab(self.attachment.config.icon, var_22_5)
			end

			self:UpdateBuffList(var_22_1, {})
			self:UpdateMapBuff(var_22_1, {}, {})
		end
	end

	return
end

function WSMapAttachment:UpdateEnemy(arg_23_1)
	local var_23_1 = self.attachment
	local var_23_2 = self.transform:Find("live")
	local var_23_3 = self.transform:Find("dead")
	local var_23_4 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_23_4)

	if var_23_4 then
		local var_23_5 = var_23_1:IsAlive()
		local var_23_6 = var_23_1:IsAvatar()

		if self.isInit and arg_23_1 == WorldMap.EventUpdateMapBuff then
			self:UpdateMapBuff(var_23_2, var_23_1:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_23_1))
		end

		if not self.isInit then
			self.isInit = true

			local var_23_7 = var_23_1.config
			local var_23_8 = var_23_2:Find("char")
			local var_23_9 = var_23_2:Find("icon")

			setActive(var_23_8, var_23_6)
			setActive(var_23_9, not var_23_6)

			if var_23_6 then
				self:LoadAvatar(var_23_7.icon, var_23_8:Find("ship"))
			else
				GetImageSpriteFromAtlasAsync("enemies/" .. var_23_7.icon, "", var_23_9:Find("pic"))

				local var_23_10 = WorldConst.EnemySize[var_23_7.type]

				setActive(var_23_9:Find("size/bg_s"), WorldConst.EnemySize[var_23_7.type] == 1 or not var_23_10)
				setActive(var_23_9:Find("size/bg_m"), var_23_10 == 2)
				setActive(var_23_9:Find("size/bg_h"), var_23_10 == 3)
				setActive(var_23_9:Find("size/bg_boss"), var_23_10 == 99)

				if var_23_7.difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
					setActive(var_23_9:Find("size/bg_boss"), false)
					setText(var_23_9:Find("lv/Text"), WorldConst.WorldLevelCorrect(self.map.config.expedition_level, var_23_7.type))
				else
					setText(var_23_9:Find("lv/Text"), var_23_7.level)
				end

				GetImageSpriteFromAtlasAsync("enemies/" .. var_23_7.icon .. "_d_blue", "", var_23_3:Find("icon"))
			end

			self:UpdateHP(var_23_2:Find("hp"), var_23_1:GetHP(), var_23_1:GetMaxHP())
			self:UpdateBuffList(var_23_2, var_23_1:GetBuffList())
			self:UpdateMapBuff(var_23_2, var_23_1:GetRadiationBuffs(), self.map:GetBuffList(WorldMap.FactionEnemy, var_23_1))
		end

		setActive(var_23_2, var_23_5)
		setActive(var_23_3, not var_23_6 and var_23_1.flag == 1)

		if var_23_5 then
			setActive(var_23_2:Find("fighting"), self.isFighting)
		end
	end

	return
end

function WSMapAttachment:UpdatePort(arg_24_1)
	setActive(self.transform, false)

	return
end

function WSMapAttachment:UpdateTransportFleet(arg_25_1)
	local var_25_1 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_25_1)

	if var_25_1 and not self.isInit then
		self.isInit = true

		GetImageSpriteFromAtlasAsync("enemies/" .. self.attachment.config.icon, "", (self.transform:Find("ship/icon")))
	end

	return
end

function WSMapAttachment:UpdateTrap(arg_26_1)
	local var_26_1 = self.transform
	local var_26_2 = self.map:CheckDisplay(self.attachment)

	setActive(self.transform, var_26_2)

	if var_26_2 then
		local var_26_3 = self.attachment:IsAvatar()

		if not self.isInit then
			self.isInit = true

			local var_26_4 = var_26_1:Find("char")
			local var_26_5 = var_26_1:Find("icon")

			setActive(var_26_4, var_26_3)
			setActive(var_26_5, not var_26_3)
			setAnchoredPosition(var_26_4, WSMapAttachment.CharBasePos)
			setAnchoredPosition(var_26_5, WSMapAttachment.IconBasePos)

			if var_26_3 then
				self:LoadAvatar(self.attachment.config.trap_fx, var_26_4:Find("ship"))
			else
				self:LoadBoxPrefab(self.attachment.config.trap_fx, var_26_5)
			end

			self:UpdateBuffList(var_26_1, {})
			self:UpdateMapBuff(var_26_1, {}, {})
		end
	end

	return
end

function WSMapAttachment:UpdateBuffList(arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:Find("buffs")

	setActive(var_27_0, #arg_27_2 > 0)

	local var_27_1 = UIItemList.New(var_27_0, var_27_0:GetChild(0))

	var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
		arg_28_1 = arg_28_1 + 1

		if arg_28_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("world/buff/" .. arg_27_2[arg_28_1].config.icon, "", arg_28_2)
		end

		return
	end)
	var_27_1:align(#arg_27_2)
	setAnchoredPosition(var_27_0, {
		y = self.modelType == WorldConst.ModelSpine and 100 or 0
	})

	return
end

function WSMapAttachment:UpdateMapBuff(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1:Find("map_buff")
	local var_29_1 = false

	if #arg_29_2 > 0 then
		var_29_1 = "wifi"

		local var_29_2, var_29_3, var_29_4 = unpack(arg_29_2[1])

		GetImageSpriteFromAtlasAsync("world/mapbuff/" .. pg.world_SLGbuff_data[var_29_3].icon, "", var_29_0:Find("Image"))
	elseif #arg_29_3 > 0 then
		var_29_1 = "arrow"

		GetImageSpriteFromAtlasAsync("world/mapbuff/" .. arg_29_3[1].config.icon, "", var_29_0:Find("Image"))
	end

	setActive(var_29_0:Find("wifi"), var_29_1 == "wifi")
	setActive(var_29_0:Find("arrow"), var_29_1 == "arrow")
	setActive(var_29_0, var_29_1)

	return
end

function WSMapAttachment:UpdateHP(arg_30_1, arg_30_2, arg_30_3)
	setActive(arg_30_1, arg_30_2 and arg_30_3)

	if arg_30_2 and arg_30_3 then
		setSlider(arg_30_1, 0, arg_30_3, arg_30_2)
	end

	return
end

function WSMapAttachment:UpdateBreathTween()
	if self.attachment:IsFloating() and self.attachment:IsAlive() and self.attachment:IsVisible() then
		if not self.twBreathId then
			self.transform.localPosition = Vector3(0, 40, 0)

			local var_31_0 = LeanTween.moveY(self.transform, 50, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

			var_31_0.passed = self.twTimer.passed
			var_31_0.direction = self.twTimer.direction
			self.twBreathId = var_31_0.uniqueId
		end
	elseif self.twBreathId then
		LeanTween.cancel(self.twBreathId)

		self.twBreathId = nil
		self.transform.localPosition = Vector3(0, 40, 0)
	end

	return
end

function WSMapAttachment:UpdateIsFighting(arg_32_1)
	assert(WorldMapAttachment.IsEnemyType(self.attachment.type))

	if self.isFighting ~= arg_32_1 then
		self.isFighting = arg_32_1

		self:UpdateEnemy()
	end

	return
end

function WSMapAttachment:TrapAnimDisplay(arg_33_1)
	local var_33_0 = {}
	local var_33_1 = self.model:GetChild(0)

	table.insert(var_33_0, function(arg_34_0)
		var_33_1:GetComponent("DftAniEvent"):SetEndEvent(arg_34_0)
		var_33_1:GetComponent("Animator"):Play("disappear")

		return
	end)
	table.insert(var_33_0, function(arg_35_0)
		self:UpdateModelScale((self.attachment:GetScale(self.attachment.config.trap_range[1])))
		var_33_1:GetComponent("DftAniEvent"):SetEndEvent(arg_35_0)
		var_33_1:GetComponent("Animator"):Play("vortexAnimation")

		return
	end)
	table.insert(var_33_0, function(arg_36_0)
		self:UpdateModelScale(Vector3.zero)
		var_33_1:GetComponent("Animator"):Play("loop")
		arg_36_0()

		return
	end)
	seriesAsync(var_33_0, arg_33_1)

	return
end

return WSMapAttachment
