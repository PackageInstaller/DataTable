local DockyardShipItem = class("DockyardShipItem")

DockyardShipItem.DetailType0 = 0
DockyardShipItem.DetailType1 = 1
DockyardShipItem.DetailType2 = 2
DockyardShipItem.DetailType3 = 3
DockyardShipItem.SKILL_COLOR = {
	COLOR_RED,
	COLOR_BLUE,
	COLOR_YELLOW
}

local var_0_1 = 0.8

function DockyardShipItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.hideTagFlags = arg_1_2 or {}
	self.blockTagFlags = arg_1_3 or {}
	self.btn = GetOrAddComponent(arg_1_1, "Button")
	self.content = findTF(self.tr, "content").gameObject

	setActive(findTF(self.content, "dockyard"), true)
	setActive(findTF(self.content, "collection"), false)

	self.quit = findTF(self.tr, "quit_button").gameObject
	self.detail = findTF(self.tr, "content/dockyard/detail").gameObject
	self.detailLayoutTr = findTF(self.detail, "layout")
	self.imageQuit = self.quit:GetComponent("Image")
	self.imageFrame = findTF(self.tr, "content/front/frame"):GetComponent("Image")
	self.nameTF = findTF(self.tr, "content/info/name_mask/name")
	self.npc = findTF(self.tr, "content/dockyard/npc")

	setActive(self.npc, false)

	self.lock = findTF(self.tr, "content/dockyard/container/lock")
	self.maskStatusOb = findTF(self.tr, "content/front/status_mask")
	self.iconStatus = findTF(self.tr, "content/dockyard/status")
	self.iconStatusMask = self.iconStatus:GetComponent(typeof(RectMask2D))
	self.iconStatusTxt = findTF(self.tr, "content/dockyard/status/Text"):GetComponent("Text")
	self.selectedGo = findTF(self.tr, "content/front/selected").gameObject
	self.energyTF = findTF(self.tr, "content/dockyard/container/energy")
	self.proposeTF = findTF(self.tr, "content/dockyard/propose")

	self.selectedGo:SetActive(false)

	self.hpBar = findTF(self.tr, "content/dockyard/blood")
	self.expBuff = findTF(self.tr, "content/expbuff")
	self.intimacyTF = findTF(self.tr, "content/intimacy")
	self.detailType = DockyardShipItem.DetailType0
	self.proposeModel = self.proposeTF:Find("heartShipCard(Clone)")

	if self.proposeModel then
		self.sg = GetComponent(self.proposeModel, "SkeletonGraphic")
	end

	self.activityProxy = getProxy(ActivityProxy)
	self.userTF = findTF(self.tr, "content/user")

	if self.userTF then
		self.userIconTF = self.userTF:Find("icon"):GetComponent(typeof(Image))
		self.userIconFrame = self.userTF:Find("frame")
		self.userNameTF = findTF(self.tr, "content/user_name/Text"):GetComponent(typeof(Text))
		self.levelTF = findTF(self.tr, "content/dockyard/lv")
	end

	self.tagRecommand = findTF(self.tr, "content/recommand")
	self.palyerId = getProxy(PlayerProxy):getRawData().id

	ClearTweenItemAlphaAndWhite(self.go)

	self.isClear = true

	return
end

function DockyardShipItem:update(arg_2_1)
	self.isClear = false

	TweenItemAlphaAndWhite(self.go)

	if self.proposeModel then
		LeanTween.cancel(self.proposeModel)
		LeanTween.value(go(self.proposeModel), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
			self.sg.color = Color.New(1, 1, 1, arg_3_0)

			return
		end))
	end

	if arg_2_1 then
		self.go.name = arg_2_1.configId
	end

	if self.shipVO ~= arg_2_1 then
		self.shipVO = arg_2_1

		self:flush()
		self:flushDetail()
	end

	setActive(self.nameTF, false)
	setActive(self.nameTF, true)

	if not IsNil(self.levelTF) then
		setActive(self.levelTF, false)
		setActive(self.levelTF, true)
	end

	return
end

function DockyardShipItem:updateDetail(arg_4_1)
	self.detailType = arg_4_1

	self:flushDetail()

	return
end

function DockyardShipItem:updateSelected(arg_5_1)
	self.selected = arg_5_1

	self.selectedGo:SetActive(self.selected)

	if self.selected then
		self.selectedTwId = self.selectedTwId or LeanTween.alpha(self.selectedGo.transform, 0.5, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif self.selectedTwId then
		LeanTween.cancel(self.selectedTwId)

		self.selectedTwId = nil
	end

	return
end

function DockyardShipItem:flush()
	local var_6_0 = tobool(self.shipVO)

	if var_6_0 then
		if not self.shipVO:getConfigTable() then
			return
		end

		flushShipCard(self.tr, self.shipVO)
		setActive(self.npc, (self.shipVO:isActivityNpc()))

		if self.lock then
			self.lock.gameObject:SetActive(self.shipVO:GetLockState() == Ship.LOCK_STATE_LOCK)
		end

		local var_6_1 = self.shipVO.energy <= Ship.ENERGY_MID

		if self.shipVO.energy <= Ship.ENERGY_MID then
			local var_6_2 = GetSpriteFromAtlas("energy", self.shipVO:getEnergyPrint())

			if not var_6_2 then
				warning("找不到疲劳")
			end

			setImageSprite(self.energyTF, var_6_2)
		end

		setActive(self.energyTF, var_6_1)
		setText(self.nameTF, self.shipVO:GetColorName(shortenString(self.shipVO:getName(), PLATFORM_CODE == PLATFORM_US and 6 or 7)))

		local var_6_3

		if self.shipVO.user then
			local var_6_4 = Clone(self.shipVO)

			var_6_4.id = GuildAssaultFleet.GetRealId(var_6_4.id)
			var_6_3 = ShipStatus.ShipStatusToTag(var_6_4, self.hideTagFlags)
		else
			var_6_3 = ShipStatus.ShipStatusToTag(self.shipVO, self.hideTagFlags)
		end

		if var_6_3 then
			self.iconStatusTxt.text = var_6_3[3]

			GetSpriteFromAtlasAsync(var_6_3[1], var_6_3[2], function(arg_7_0)
				setImageSprite(self.iconStatus, arg_7_0, true)
				setActive(self.iconStatus, true)

				if var_6_3[1] == "shipstatus" then
					self.iconStatus.sizeDelta = Vector2(195, 36)
					self.iconStatusTxt.fontSize = 30
				end

				self.iconStatusMask.enabled = false

				return
			end)
		else
			setActive(self.iconStatus, false)
		end

		if not LOCK_PROPOSE then
			if self.proposeModel then
				self.sg.enabled = self:CheckHeartState()
			elseif self:CheckHeartState() and not self.heartLoading then
				self.heartLoading = true

				pg.PoolMgr.GetInstance():GetUI("heartShipCard", false, function(arg_8_0)
					if self.isClear or self.proposeModel then
						pg.PoolMgr.GetInstance():ReturnUI("heartShipCard", arg_8_0)
					else
						self.proposeModel = arg_8_0
						self.sg = GetComponent(self.proposeModel, "SkeletonGraphic")

						self.proposeModel.transform:SetParent(self.proposeTF, false)

						self.sg.enabled = self:CheckHeartState()
						self.heartLoading = false
					end

					return
				end)
			end
		end

		if self.hpBar then
			setActive(self.hpBar, false)
		end

		self:UpdateExpBuff()
		self:updateNpcTfPosY()
	end

	if self.userTF then
		self:UpdateUser(self.shipVO)
	end

	self.content:SetActive(var_6_0)
	self.quit:SetActive(not var_6_0)

	if var_6_0 then
		self.btn.targetGraphic = self.imageFrame or self.imageQuit
	end

	return
end

function DockyardShipItem:CheckHeartState()
	if tobool(self.shipVO) then
		local var_9_0, var_9_1 = self.shipVO:getIntimacyIcon()

		return var_9_1 and not self.shipVO:isActivityNpc()
	end

	return false
end

local var_0_2 = {
	90,
	60,
	30
}

function DockyardShipItem:updateNpcTfPosY()
	if isActive(self.npc) then
		local var_10_0 = 1

		if isActive((findTF(self.tr, "content/energy"))) then
			var_10_0 = var_10_0 + 1
		end

		if isActive(self.intimacyTF) then
			var_10_0 = var_10_0 + 1
		end

		local var_10_1 = self.npc.anchoredPosition

		var_10_1.y = var_0_2[var_10_0]
		self.npc.anchoredPosition = var_10_1
	end

	return
end

function DockyardShipItem:UpdateUser(arg_11_1)
	if self.userIconFrame.childCount > 0 then
		local var_11_0 = self.userIconFrame:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_0.name, var_11_0.name, var_11_0)
	end

	local var_11_1 = tobool(arg_11_1) and arg_11_1.user
	local var_11_2 = var_11_1 and var_11_1.id ~= self.palyerId

	setActive(self.userTF, var_11_1 and var_11_1.id ~= self.palyerId and self.detailType == DockyardShipItem.DetailType0)
	setActive(self.userNameTF.gameObject.transform.parent, var_11_2)

	if var_11_2 and var_11_1 ~= self.user then
		LoadSpriteAsync("qicon/" .. Ship.New({
			configId = var_11_1.icon
		}):getPrefab(), function(arg_12_0)
			self.userIconTF.sprite = arg_12_0

			return
		end)

		local var_11_3 = AttireFrame.attireFrameRes(var_11_1, false, AttireConst.TYPE_ICON_FRAME, var_11_1.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_11_3, var_11_3, true, function(arg_13_0)
			if IsNil(self.tr) then
				return
			end

			if self.userIconFrame then
				arg_13_0.name = var_11_3

				setParent(arg_13_0, self.userIconFrame, false)
			else
				PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_3, var_11_3, arg_13_0)
			end

			return
		end)

		self.userNameTF.text = var_11_1.name
		self.user = var_11_1

		setAnchoredPosition(self.levelTF, {
			x = -108
		})
	else
		setAnchoredPosition(self.levelTF, {
			x = -16
		})
	end

	return
end

function DockyardShipItem:flushDetail()
	local var_14_0 = tobool(self.shipVO)

	if var_14_0 and self.detailType > DockyardShipItem.DetailType0 then
		local var_14_1 = self.shipVO:getShipProperties()
		local var_14_2 = {
			{
				AttributeType.Durability,
				AttributeType.Cannon,
				AttributeType.Torpedo,
				AttributeType.Air,
				AttributeType.Reload,
				AttributeType.Intimacy
			},
			{
				AttributeType.ArmorType,
				AttributeType.AntiAircraft,
				AttributeType.Dodge,
				AttributeType.AntiSub,
				AttributeType.Expend
			},
			{}
		}
		local var_14_3 = self.shipVO:getShipCombatPower()
		local var_14_4
		local var_14_5

		if self.detailType == DockyardShipItem.DetailType3 then
			var_14_4 = self.shipVO:getDisplaySkillIds()
			var_14_5 = pg.skill_data_template
		end

		for iter_14_0 = 1, 6 do
			local var_14_6 = self.detailLayoutTr:GetChild(iter_14_0 - 1)
			local var_14_7 = true
			local var_14_8 = var_14_6:GetChild(0):GetComponent("Text")
			local var_14_9 = var_14_6:GetChild(1):GetComponent("Text")

			var_14_8.alignment = TextAnchor.MiddleLeft
			var_14_9.alignment = TextAnchor.MiddleRight

			if self.detailType == DockyardShipItem.DetailType1 then
				if iter_14_0 == 6 then
					local var_14_10, var_14_11 = self.shipVO:getIntimacyDetail()

					var_14_8.text = AttributeType.Type2Name(var_14_2[self.detailType][iter_14_0])
					var_14_9.text = setColorStr(var_14_11, (var_14_10 <= var_14_11 or nil) and (COLOR_GREEN or COLOR_WHITE))
				else
					local var_14_12 = tostring(math.floor(var_14_1[var_14_2[self.detailType][iter_14_0]]))

					var_14_8.text = AttributeType.Type2Name(var_14_2[self.detailType][iter_14_0])
					var_14_9.text = setColorStr(var_14_12, (self:canModAttr(self.shipVO, var_14_2[self.detailType][iter_14_0], var_14_1) or nil) and (COLOR_GREEN or COLOR_WHITE))
				end
			elseif self.detailType == DockyardShipItem.DetailType2 then
				if iter_14_0 == 1 then
					var_14_8.alignment = TextAnchor.MiddleCenter
					var_14_8.text = self.shipVO:getShipArmorName()
					var_14_9.text = ""
				elseif iter_14_0 == 5 then
					local var_14_15 = self.shipVO:getBattleTotalExpend()

					var_14_8.text = AttributeType.Type2Name(AttributeType.Expend)
					var_14_9.text = tostring(math.floor(var_14_15))
				elseif iter_14_0 == 6 then
					var_14_8.text = setColorStr(i18n("word_synthesize_power"), COLOR_GREEN)
					var_14_9.text = tostring(var_14_3)
				else
					var_14_8.text = AttributeType.Type2Name(var_14_2[self.detailType][iter_14_0])
					var_14_9.text = tostring(math.floor(var_14_1[var_14_2[self.detailType][iter_14_0]]))
				end
			elseif self.detailType == DockyardShipItem.DetailType3 then
				local var_14_16 = var_14_4[iter_14_0]

				if var_14_4[iter_14_0] and self.shipVO.skills[var_14_16] and var_14_5[var_14_16].max_level ~= 1 then
					local var_14_17 = self.shipVO.skills[var_14_16]
					local var_14_18 = DockyardShipItem.SKILL_COLOR[pg.skill_data_template[self.shipVO.skills[var_14_16].id].type] or COLOR_WHITE

					var_14_8.alignment = TextAnchor.MiddleLeft
					var_14_8.text = setColorStr(i18n("skill") .. iter_14_0, var_14_18)
					var_14_9.text = setColorStr(var_14_17.level == var_14_5[var_14_16].max_level and "Lv.Max" or "Lv." .. var_14_17.level, var_14_18)
				else
					var_14_7 = false
				end
			end

			setActive(var_14_6, var_14_7)
		end
	end

	self.detail:SetActive(var_14_0 and self.detailType > DockyardShipItem.DetailType0)

	if self.userTF then
		self:UpdateUser(self.shipVO)
	end

	self:UpdateRecommandTag(self.shipVO)

	return
end

function DockyardShipItem:UpdateRecommandTag(arg_15_1)
	if arg_15_1 and self.tagRecommand then
		setActive(self.tagRecommand, (defaultValue(arg_15_1.guildRecommand, false)))
	end

	return
end

function DockyardShipItem:canModAttr(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1:isBluePrintShip() then
		return arg_16_1:getBluePrint():isMaxIntensifyLevel()
	elseif arg_16_1:isMetaShip() then
		return arg_16_1:getMetaCharacter():isMaxRepairExp()
	elseif not ShipModAttr.ATTR_TO_INDEX[arg_16_2] then
		return true
	elseif arg_16_1:getModAttrTopLimit(arg_16_2) == 0 then
		return true
	else
		return (arg_16_1.level >= 100 or arg_16_1.level == arg_16_1:getMaxLevel()) and arg_16_1:getModAttrBaseMax(arg_16_2) <= arg_16_3[arg_16_2]
	end

	return
end

function DockyardShipItem:updateBlackBlock(arg_17_1)
	local var_17_0 = false

	if self.shipVO then
		for iter_17_0, iter_17_1 in pairs(self.blockTagFlags) do
			if iter_17_1 and self.shipVO:getFlag(iter_17_0) then
				var_17_0 = true

				break
			end
		end

		if not var_17_0 and arg_17_1 then
			local var_17_1 = getProxy(BayProxy)

			for iter_17_2, iter_17_3 in ipairs(arg_17_1) do
				local var_17_2 = var_17_1:getShipById(iter_17_3)

				if var_17_2 and self.shipVO:isSameKind(var_17_2) then
					var_17_0 = var_17_2.id ~= self.shipVO.id

					break
				end
			end
		end
	end

	if self.maskStatusOb then
		setActive(self.maskStatusOb, var_17_0)
	end

	return
end

function DockyardShipItem:updateWorld()
	if self.shipVO:getFlag("inWorld") then
		local var_18_0 = WorldConst.FetchWorldShip(self.shipVO.id)

		setActive(self.hpBar, true)

		local var_18_1 = self.hpBar:Find("fillarea/green")
		local var_18_2 = self.hpBar:Find("fillarea/red")

		setActive(var_18_1, var_18_0:IsHpSafe())
		setActive(var_18_2, not var_18_0:IsHpSafe())

		self.hpBar:GetComponent(typeof(Slider)).fillRect = var_18_0:IsHpSafe() and var_18_1 or var_18_2

		setSlider(self.hpBar, 0, 10000, var_18_0.hpRant)
		setActive(self.hpBar:Find("broken"), var_18_0:IsBroken())

		if self.maskStatusOb then
			setActive(self.maskStatusOb, not var_18_0:IsAlive())
		end
	end

	return
end

function DockyardShipItem:UpdateExpBuff()
	local var_19_0 = self.activityProxy:getBuffShipList()[self.shipVO:getGroupId()]

	setActive(self.expBuff, false)
	setActive(self.expBuff, var_19_0 ~= nil)

	if var_19_0 then
		local var_19_1 = tostring(var_19_0 / 100)

		if var_19_0 % 100 > 0 then
			var_19_1 = var_19_1 .. "." .. tostring(var_19_0 % 100)
		end

		setText(self.expBuff:Find("text"), string.format("EXP +%s%%", var_19_1))
	end

	return
end

function DockyardShipItem:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	if self.selectedTwId then
		LeanTween.cancel(self.selectedTwId)

		self.selectedTwId = nil
	end

	self.isClear = true

	return
end

function DockyardShipItem:updateIntimacy(arg_21_1)
	if not self.shipVO then
		return
	end

	if isActive((findTF(self.tr, "content/energy"))) then
		self.intimacyTF = findTF(self.tr, "content/intimacy_with_energy")

		setActive(findTF(self.tr, "content/intimacy"), false)
	else
		self.intimacyTF = findTF(self.tr, "content/intimacy")

		setActive(findTF(self.tr, "content/intimacy_with_energy"), false)
	end

	local var_21_0, var_21_1 = self.shipVO:getIntimacyDetail()

	setText(findTF(self.intimacyTF, "Text"), var_21_1)

	if var_21_1 == 100 or var_21_1 == 200 then
		setText(findTF(self.intimacyTF, "Text"), setColorStr(var_21_1, "#ff8d8d"))
	end

	setActive(self.intimacyTF, arg_21_1)
	self:updateNpcTfPosY()

	return
end

function DockyardShipItem:updateIntimacyEnergy(arg_22_1)
	local var_22_0 = self.tr:Find("content/energy")

	setActive(self.tr:Find("content/energy"), self.shipVO and arg_22_1)

	if arg_22_1 and tobool(self.shipVO) then
		setImageSprite(var_22_0:Find("icon/img"), GetSpriteFromAtlas("energy", self.shipVO:getEnergyPrint()), true)
		setText(var_22_0:Find("Text"), self.shipVO:getEnergy())
		setActive(var_22_0:Find("Text"), false)
		setActive(var_22_0:Find("Text"), true)
	end

	return
end

return DockyardShipItem
