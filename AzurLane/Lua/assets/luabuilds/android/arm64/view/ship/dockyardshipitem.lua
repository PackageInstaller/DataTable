local var_0_0 = class("DockyardShipItem")

var_0_0.DetailType0 = 0
var_0_0.DetailType1 = 1
var_0_0.DetailType2 = 2
var_0_0.DetailType3 = 3
var_0_0.SKILL_COLOR = {
	COLOR_RED,
	COLOR_BLUE,
	COLOR_YELLOW
}

local var_0_1 = 0.8

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.hideTagFlags = arg_1_2 or {}
	arg_1_0.blockTagFlags = arg_1_3 or {}
	arg_1_0.btn = GetOrAddComponent(arg_1_1, "Button")
	arg_1_0.content = findTF(arg_1_0.tr, "content").gameObject

	setActive(findTF(arg_1_0.content, "dockyard"), true)
	setActive(findTF(arg_1_0.content, "collection"), false)

	arg_1_0.quit = findTF(arg_1_0.tr, "quit_button").gameObject
	arg_1_0.detail = findTF(arg_1_0.tr, "content/dockyard/detail").gameObject
	arg_1_0.detailLayoutTr = findTF(arg_1_0.detail, "layout")
	arg_1_0.imageQuit = arg_1_0.quit:GetComponent("Image")
	arg_1_0.imageFrame = findTF(arg_1_0.tr, "content/front/frame"):GetComponent("Image")
	arg_1_0.nameTF = findTF(arg_1_0.tr, "content/info/name_mask/name")
	arg_1_0.npc = findTF(arg_1_0.tr, "content/dockyard/npc")

	setActive(arg_1_0.npc, false)

	arg_1_0.lock = findTF(arg_1_0.tr, "content/dockyard/container/lock")
	arg_1_0.maskStatusOb = findTF(arg_1_0.tr, "content/front/status_mask")
	arg_1_0.iconStatus = findTF(arg_1_0.tr, "content/dockyard/status")
	arg_1_0.iconStatusMask = arg_1_0.iconStatus:GetComponent(typeof(RectMask2D))
	arg_1_0.iconStatusTxt = findTF(arg_1_0.tr, "content/dockyard/status/Text"):GetComponent("Text")
	arg_1_0.selectedGo = findTF(arg_1_0.tr, "content/front/selected").gameObject
	arg_1_0.energyTF = findTF(arg_1_0.tr, "content/dockyard/container/energy")
	arg_1_0.proposeTF = findTF(arg_1_0.tr, "content/dockyard/propose")

	arg_1_0.selectedGo:SetActive(false)

	arg_1_0.hpBar = findTF(arg_1_0.tr, "content/dockyard/blood")
	arg_1_0.expBuff = findTF(arg_1_0.tr, "content/expbuff")
	arg_1_0.intimacyTF = findTF(arg_1_0.tr, "content/intimacy")
	arg_1_0.detailType = var_0_0.DetailType0
	arg_1_0.proposeModel = arg_1_0.proposeTF:Find("heartShipCard(Clone)")

	if arg_1_0.proposeModel then
		arg_1_0.sg = GetComponent(arg_1_0.proposeModel, "SkeletonGraphic")
	end

	arg_1_0.activityProxy = getProxy(ActivityProxy)
	arg_1_0.userTF = findTF(arg_1_0.tr, "content/user")

	if arg_1_0.userTF then
		arg_1_0.userIconTF = arg_1_0.userTF:Find("icon"):GetComponent(typeof(Image))
		arg_1_0.userIconFrame = arg_1_0.userTF:Find("frame")
		arg_1_0.userNameTF = findTF(arg_1_0.tr, "content/user_name/Text"):GetComponent(typeof(Text))
		arg_1_0.levelTF = findTF(arg_1_0.tr, "content/dockyard/lv")
	end

	arg_1_0.tagRecommand = findTF(arg_1_0.tr, "content/recommand")
	arg_1_0.palyerId = getProxy(PlayerProxy):getRawData().id

	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	arg_1_0.isClear = true

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.isClear = false

	TweenItemAlphaAndWhite(arg_2_0.go)

	if arg_2_0.proposeModel then
		LeanTween.cancel(arg_2_0.proposeModel)
		LeanTween.value(go(arg_2_0.proposeModel), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
			arg_2_0.sg.color = Color.New(1, 1, 1, arg_3_0)

			return
		end))
	end

	if arg_2_1 then
		arg_2_0.go.name = arg_2_1.configId
	end

	if arg_2_0.shipVO ~= arg_2_1 then
		arg_2_0.shipVO = arg_2_1

		arg_2_0:flush()
		arg_2_0:flushDetail()
	end

	setActive(arg_2_0.nameTF, false)
	setActive(arg_2_0.nameTF, true)

	if not IsNil(arg_2_0.levelTF) then
		setActive(arg_2_0.levelTF, false)
		setActive(arg_2_0.levelTF, true)
	end

	return
end

function var_0_0.updateDetail(arg_4_0, arg_4_1)
	arg_4_0.detailType = arg_4_1

	arg_4_0:flushDetail()

	return
end

function var_0_0.updateSelected(arg_5_0, arg_5_1)
	arg_5_0.selected = arg_5_1

	arg_5_0.selectedGo:SetActive(arg_5_0.selected)

	if arg_5_0.selected then
		arg_5_0.selectedTwId = arg_5_0.selectedTwId or LeanTween.alpha(arg_5_0.selectedGo.transform, 0.5, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif arg_5_0.selectedTwId then
		LeanTween.cancel(arg_5_0.selectedTwId)

		arg_5_0.selectedTwId = nil
	end

	return
end

function var_0_0.flush(arg_6_0)
	local var_6_0 = tobool(arg_6_0.shipVO)

	if var_6_0 then
		if not arg_6_0.shipVO:getConfigTable() then
			return
		end

		flushShipCard(arg_6_0.tr, arg_6_0.shipVO)
		setActive(arg_6_0.npc, (arg_6_0.shipVO:isActivityNpc()))

		if arg_6_0.lock then
			arg_6_0.lock.gameObject:SetActive(arg_6_0.shipVO:GetLockState() == Ship.LOCK_STATE_LOCK)
		end

		local var_6_1 = arg_6_0.shipVO.energy <= Ship.ENERGY_MID

		if arg_6_0.shipVO.energy <= Ship.ENERGY_MID then
			local var_6_2 = GetSpriteFromAtlas("energy", arg_6_0.shipVO:getEnergyPrint())

			if not var_6_2 then
				warning("找不到疲劳")
			end

			setImageSprite(arg_6_0.energyTF, var_6_2)
		end

		setActive(arg_6_0.energyTF, var_6_1)
		setText(arg_6_0.nameTF, arg_6_0.shipVO:GetColorName(shortenString(arg_6_0.shipVO:getName(), PLATFORM_CODE == PLATFORM_US and 6 or 7)))

		local var_6_3

		if arg_6_0.shipVO.user then
			local var_6_4 = Clone(arg_6_0.shipVO)

			var_6_4.id = GuildAssaultFleet.GetRealId(var_6_4.id)
			var_6_3 = ShipStatus.ShipStatusToTag(var_6_4, arg_6_0.hideTagFlags)
		else
			var_6_3 = ShipStatus.ShipStatusToTag(arg_6_0.shipVO, arg_6_0.hideTagFlags)
		end

		if var_6_3 then
			arg_6_0.iconStatusTxt.text = var_6_3[3]

			GetSpriteFromAtlasAsync(var_6_3[1], var_6_3[2], function(arg_7_0)
				setImageSprite(arg_6_0.iconStatus, arg_7_0, true)
				setActive(arg_6_0.iconStatus, true)

				if var_6_3[1] == "shipstatus" then
					arg_6_0.iconStatus.sizeDelta = Vector2(195, 36)
					arg_6_0.iconStatusTxt.fontSize = 30
				end

				arg_6_0.iconStatusMask.enabled = false

				return
			end)
		else
			setActive(arg_6_0.iconStatus, false)
		end

		if not LOCK_PROPOSE then
			if arg_6_0.proposeModel then
				arg_6_0.sg.enabled = arg_6_0:CheckHeartState()
			elseif arg_6_0:CheckHeartState() and not arg_6_0.heartLoading then
				arg_6_0.heartLoading = true

				pg.PoolMgr.GetInstance():GetUI("heartShipCard", false, function(arg_8_0)
					if arg_6_0.isClear or arg_6_0.proposeModel then
						pg.PoolMgr.GetInstance():ReturnUI("heartShipCard", arg_8_0)
					else
						arg_6_0.proposeModel = arg_8_0
						arg_6_0.sg = GetComponent(arg_6_0.proposeModel, "SkeletonGraphic")

						arg_6_0.proposeModel.transform:SetParent(arg_6_0.proposeTF, false)

						arg_6_0.sg.enabled = arg_6_0:CheckHeartState()
						arg_6_0.heartLoading = false
					end

					return
				end)
			end
		end

		if arg_6_0.hpBar then
			setActive(arg_6_0.hpBar, false)
		end

		arg_6_0:UpdateExpBuff()
		arg_6_0:updateNpcTfPosY()
	end

	if arg_6_0.userTF then
		arg_6_0:UpdateUser(arg_6_0.shipVO)
	end

	arg_6_0.content:SetActive(var_6_0)
	arg_6_0.quit:SetActive(not var_6_0)

	local var_6_5 = arg_6_0.btn

	if var_6_0 then
		var_6_5.targetGraphic = arg_6_0.imageFrame or arg_6_0.imageQuit

		return
	end
end

function var_0_0.CheckHeartState(arg_9_0)
	if tobool(arg_9_0.shipVO) then
		local var_9_0, var_9_1 = arg_9_0.shipVO:getIntimacyIcon()

		return var_9_1 and not arg_9_0.shipVO:isActivityNpc()
	end

	return false
end

local var_0_2 = {
	90,
	60,
	30
}

function var_0_0.updateNpcTfPosY(arg_10_0)
	if isActive(arg_10_0.npc) then
		local var_10_0 = 1

		if isActive((findTF(arg_10_0.tr, "content/energy"))) then
			var_10_0 = var_10_0 + 1
		end

		if isActive(arg_10_0.intimacyTF) then
			var_10_0 = var_10_0 + 1
		end

		local var_10_1 = arg_10_0.npc.anchoredPosition

		var_10_1.y = var_0_2[var_10_0]
		arg_10_0.npc.anchoredPosition = var_10_1
	end

	return
end

function var_0_0.UpdateUser(arg_11_0, arg_11_1)
	if arg_11_0.userIconFrame.childCount > 0 then
		local var_11_0 = arg_11_0.userIconFrame:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_0.name, var_11_0.name, var_11_0)
	end

	local var_11_1 = tobool(arg_11_1) and arg_11_1.user
	local var_11_2 = var_11_1 and var_11_1.id ~= arg_11_0.palyerId

	setActive(arg_11_0.userTF, var_11_1 and var_11_1.id ~= arg_11_0.palyerId and arg_11_0.detailType == var_0_0.DetailType0)
	setActive(arg_11_0.userNameTF.gameObject.transform.parent, var_11_2)

	if var_11_2 and var_11_1 ~= arg_11_0.user then
		LoadSpriteAsync("qicon/" .. Ship.New({
			configId = var_11_1.icon
		}):getPrefab(), function(arg_12_0)
			arg_11_0.userIconTF.sprite = arg_12_0

			return
		end)

		local var_11_3 = AttireFrame.attireFrameRes(var_11_1, false, AttireConst.TYPE_ICON_FRAME, var_11_1.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_11_3, var_11_3, true, function(arg_13_0)
			if IsNil(arg_11_0.tr) then
				return
			end

			if arg_11_0.userIconFrame then
				arg_13_0.name = var_11_3

				setParent(arg_13_0, arg_11_0.userIconFrame, false)
			else
				PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_3, var_11_3, arg_13_0)
			end

			return
		end)

		arg_11_0.userNameTF.text = var_11_1.name
		arg_11_0.user = var_11_1

		setAnchoredPosition(arg_11_0.levelTF, {
			x = -108
		})
	else
		setAnchoredPosition(arg_11_0.levelTF, {
			x = -16
		})
	end

	return
end

function var_0_0.flushDetail(arg_14_0)
	local var_14_0 = tobool(arg_14_0.shipVO)

	if var_14_0 and arg_14_0.detailType > var_0_0.DetailType0 then
		local var_14_1 = arg_14_0.shipVO:getShipProperties()
		local var_14_2 = arg_14_0.shipVO:getShipCombatPower()
		local var_14_3
		local var_14_4

		if arg_14_0.detailType == var_0_0.DetailType3 then
			var_14_3 = arg_14_0.shipVO:getDisplaySkillIds()
			var_14_4 = pg.skill_data_template
		end

		for iter_14_0 = 1, 6 do
			local var_14_5 = arg_14_0.detailLayoutTr:GetChild(iter_14_0 - 1)
			local var_14_6 = true
			local var_14_7 = var_14_5:GetChild(0):GetComponent("Text")
			local var_14_8 = var_14_5:GetChild(1):GetComponent("Text")

			var_14_7.alignment = TextAnchor.MiddleLeft
			var_14_8.alignment = TextAnchor.MiddleRight

			if arg_14_0.detailType == var_0_0.DetailType1 then
				if iter_14_0 == 6 then
					local var_14_9, var_14_10 = arg_14_0.shipVO:getIntimacyDetail()

					var_14_7.text = AttributeType.Type2Name(({
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
					})[arg_14_0.detailType][iter_14_0])

					local var_14_12 = var_14_10

					if var_14_9 <= var_14_10 then
						local var_14_13 = COLOR_GREEN or COLOR_WHITE

						var_14_8.text = var_14_11(var_14_12, var_14_13)

						local var_14_14 = tostring(math.floor(var_14_1[({
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
						})[arg_14_0.detailType][iter_14_0]]))
						local var_14_16 = var_14_14

						goto label_14_0

						var_14_7.text = AttributeType.Type2Name(({
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
						})[arg_14_0.detailType][iter_14_0])

						::label_14_0::

						if arg_14_0:canModAttr(arg_14_0.shipVO, ({
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
						})[arg_14_0.detailType][iter_14_0], var_14_1) then
							do
								local var_14_17 = COLOR_GREEN or COLOR_WHITE

								var_14_8.text = var_14_15(var_14_16, var_14_17)

								goto label_14_0

								if arg_14_0.detailType == var_0_0.DetailType2 then
									if iter_14_0 == 1 then
										var_14_7.alignment = TextAnchor.MiddleCenter
										var_14_7.text = arg_14_0.shipVO:getShipArmorName()
										var_14_8.text = ""
									elseif iter_14_0 == 5 then
										local var_14_18 = arg_14_0.shipVO:getBattleTotalExpend()

										var_14_7.text = AttributeType.Type2Name(AttributeType.Expend)
										var_14_8.text = tostring(math.floor(var_14_18))
									elseif iter_14_0 == 6 then
										var_14_7.text = setColorStr(i18n("word_synthesize_power"), COLOR_GREEN)
										var_14_8.text = tostring(var_14_2)
									else
										var_14_7.text = AttributeType.Type2Name(({
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
										})[arg_14_0.detailType][iter_14_0])
										var_14_8.text = tostring(math.floor(var_14_1[({
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
										})[arg_14_0.detailType][iter_14_0]]))
									end
								elseif arg_14_0.detailType == var_0_0.DetailType3 then
									local var_14_19 = var_14_3[iter_14_0]

									if var_14_3[iter_14_0] and arg_14_0.shipVO.skills[var_14_19] and var_14_4[var_14_19].max_level ~= 1 then
										local var_14_20 = arg_14_0.shipVO.skills[var_14_19]
										local var_14_21 = var_0_0.SKILL_COLOR[pg.skill_data_template[arg_14_0.shipVO.skills[var_14_19].id].type] or COLOR_WHITE

										var_14_7.alignment = TextAnchor.MiddleLeft
										var_14_7.text = setColorStr(i18n("skill") .. iter_14_0, var_14_21)
										var_14_8.text = setColorStr(var_14_20.level == var_14_4[var_14_19].max_level and "Lv.Max" or "Lv." .. var_14_20.level, var_14_21)
									else
										var_14_6 = false
									end
								end
							end

							setActive(var_14_5, var_14_6)
						end
					end
				end
			end
		end
	end

	arg_14_0.detail:SetActive(var_14_0 and arg_14_0.detailType > var_0_0.DetailType0)

	if arg_14_0.userTF then
		arg_14_0:UpdateUser(arg_14_0.shipVO)
	end

	arg_14_0:UpdateRecommandTag(arg_14_0.shipVO)

	return
end

function var_0_0.UpdateRecommandTag(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0.tagRecommand then
		setActive(arg_15_0.tagRecommand, (defaultValue(arg_15_1.guildRecommand, false)))
	end

	return
end

function var_0_0.canModAttr(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1:isBluePrintShip() then
		return arg_16_1:getBluePrint():isMaxIntensifyLevel()
	elseif arg_16_1:isMetaShip() then
		return arg_16_1:getMetaCharacter():isMaxRepairExp()
	elseif not ShipModAttr.ATTR_TO_INDEX[arg_16_2] then
		return true
	else
		local var_16_0

		if arg_16_1:getModAttrTopLimit(arg_16_2) == 0 then
			do return true end

			goto label_16_0

			var_16_0 = arg_16_1:getModAttrBaseMax(arg_16_2)
		end

		return (arg_16_1.level >= 100 or arg_16_1.level == arg_16_1:getMaxLevel()) and var_16_0 <= arg_16_3[arg_16_2]
	end

	::label_16_0::

	return
end

function var_0_0.updateBlackBlock(arg_17_0, arg_17_1)
	local var_17_0 = false

	if arg_17_0.shipVO then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.blockTagFlags) do
			if iter_17_1 and arg_17_0.shipVO:getFlag(iter_17_0) then
				var_17_0 = true

				break
			end
		end

		if not var_17_0 and arg_17_1 then
			local var_17_1 = getProxy(BayProxy)

			for iter_17_2, iter_17_3 in ipairs(arg_17_1) do
				local var_17_2 = var_17_1:getShipById(iter_17_3)

				if var_17_2 and arg_17_0.shipVO:isSameKind(var_17_2) then
					var_17_0 = var_17_2.id ~= arg_17_0.shipVO.id

					break
				end
			end
		end
	end

	if arg_17_0.maskStatusOb then
		setActive(arg_17_0.maskStatusOb, var_17_0)
	end

	return
end

function var_0_0.updateWorld(arg_18_0)
	if arg_18_0.shipVO:getFlag("inWorld") then
		local var_18_0 = WorldConst.FetchWorldShip(arg_18_0.shipVO.id)

		setActive(arg_18_0.hpBar, true)

		local var_18_1 = arg_18_0.hpBar:Find("fillarea/green")
		local var_18_2 = arg_18_0.hpBar:Find("fillarea/red")

		setActive(var_18_1, var_18_0:IsHpSafe())
		setActive(var_18_2, not var_18_0:IsHpSafe())

		arg_18_0.hpBar:GetComponent(typeof(Slider)).fillRect = var_18_0:IsHpSafe() and var_18_1 or var_18_2

		setSlider(arg_18_0.hpBar, 0, 10000, var_18_0.hpRant)
		setActive(arg_18_0.hpBar:Find("broken"), var_18_0:IsBroken())

		if arg_18_0.maskStatusOb then
			setActive(arg_18_0.maskStatusOb, not var_18_0:IsAlive())
		end
	end

	return
end

function var_0_0.UpdateExpBuff(arg_19_0)
	local var_19_0 = arg_19_0.activityProxy:getBuffShipList()[arg_19_0.shipVO:getGroupId()]

	setActive(arg_19_0.expBuff, false)
	setActive(arg_19_0.expBuff, var_19_0 ~= nil)

	if var_19_0 then
		local var_19_1 = tostring(var_19_0 / 100)

		if var_19_0 % 100 > 0 then
			var_19_1 = var_19_1 .. "." .. tostring(var_19_0 % 100)
		end

		setText(arg_19_0.expBuff:Find("text"), string.format("EXP +%s%%", var_19_1))
	end

	return
end

function var_0_0.clear(arg_20_0)
	ClearTweenItemAlphaAndWhite(arg_20_0.go)

	if arg_20_0.selectedTwId then
		LeanTween.cancel(arg_20_0.selectedTwId)

		arg_20_0.selectedTwId = nil
	end

	arg_20_0.isClear = true

	return
end

function var_0_0.updateIntimacy(arg_21_0, arg_21_1)
	if not arg_21_0.shipVO then
		return
	end

	if isActive((findTF(arg_21_0.tr, "content/energy"))) then
		arg_21_0.intimacyTF = findTF(arg_21_0.tr, "content/intimacy_with_energy")

		setActive(findTF(arg_21_0.tr, "content/intimacy"), false)
	else
		arg_21_0.intimacyTF = findTF(arg_21_0.tr, "content/intimacy")

		setActive(findTF(arg_21_0.tr, "content/intimacy_with_energy"), false)
	end

	local var_21_0, var_21_1 = arg_21_0.shipVO:getIntimacyDetail()

	setText(findTF(arg_21_0.intimacyTF, "Text"), var_21_1)

	if var_21_1 == 100 or var_21_1 == 200 then
		setText(findTF(arg_21_0.intimacyTF, "Text"), setColorStr(var_21_1, "#ff8d8d"))
	end

	setActive(arg_21_0.intimacyTF, arg_21_1)
	arg_21_0:updateNpcTfPosY()

	return
end

function var_0_0.updateIntimacyEnergy(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.tr:Find("content/energy")

	setActive(arg_22_0.tr:Find("content/energy"), arg_22_0.shipVO and arg_22_1)

	if arg_22_1 and tobool(arg_22_0.shipVO) then
		setImageSprite(var_22_0:Find("icon/img"), GetSpriteFromAtlas("energy", arg_22_0.shipVO:getEnergyPrint()), true)
		setText(var_22_0:Find("Text"), arg_22_0.shipVO:getEnergy())
		setActive(var_22_0:Find("Text"), false)
		setActive(var_22_0:Find("Text"), true)
	end

	return
end

return var_0_0
