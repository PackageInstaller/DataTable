class = var_0_10000

local var_0_0 = var_0_10000("DockyardShipItem")

var_0_0.DetailType0 = 0
var_0_0.DetailType1 = 1
var_0_0.DetailType2 = 2
var_0_0.DetailType3 = 3

local var_0_1 = {}

COLOR_RED = var_2
var_0_1[1] = var_2
COLOR_BLUE = var_2
var_0_1[2] = var_2
COLOR_YELLOW = var_2
var_0_1[3] = var_2
var_0_0.SKILL_COLOR = var_0_1

local var_0_2 = 0.8

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.hideTagFlags = arg_1_2 or {}
	arg_1_0.blockTagFlags = arg_1_3 or {}
	GetOrAddComponent = var_4
	arg_1_0.btn = var_4(arg_1_1, "Button")
	findTF = var_4
	arg_1_0.content = var_4(arg_1_0.tr, "content").gameObject
	setActive = var_4
	findTF = var_6

	var_4(var_6(arg_1_0.content, "dockyard"), true)

	setActive = var_4
	findTF = var_6

	var_4(var_6(arg_1_0.content, "collection"), false)

	findTF = var_4
	arg_1_0.quit = var_4(arg_1_0.tr, "quit_button").gameObject
	findTF = var_4
	arg_1_0.detail = var_4(arg_1_0.tr, "content/dockyard/detail").gameObject
	findTF = var_4
	arg_1_0.detailLayoutTr = var_4(arg_1_0.detail, "layout")

	local var_1_0 = arg_1_0.quit

	arg_1_0.imageQuit = var_4.GetComponent(var_1_0, "Image")
	findTF = var_4

	local var_1_1 = var_4(arg_1_0.tr, "content/front/frame")

	arg_1_0.imageFrame = var_4.GetComponent(var_1_1, "Image")
	findTF = var_4
	arg_1_0.nameTF = var_4(arg_1_0.tr, "content/info/name_mask/name")
	findTF = var_4
	arg_1_0.npc = var_4(arg_1_0.tr, "content/dockyard/npc")
	setActive = var_4

	var_4(arg_1_0.npc, false)

	findTF = var_4
	arg_1_0.lock = var_4(arg_1_0.tr, "content/dockyard/container/lock")
	findTF = var_4
	arg_1_0.maskStatusOb = var_4(arg_1_0.tr, "content/front/status_mask")
	findTF = var_4
	arg_1_0.iconStatus = var_4(arg_1_0.tr, "content/dockyard/status")

	local var_1_2 = arg_1_0.iconStatus
	local var_1_3 = var_4.GetComponent

	typeof = var_7
	RectMask2D = var_9
	arg_1_0.iconStatusMask = var_1_3(var_1_2, var_7(var_9))
	findTF = var_4

	local var_1_4 = var_4(arg_1_0.tr, "content/dockyard/status/Text")

	arg_1_0.iconStatusTxt = var_4.GetComponent(var_1_4, "Text")
	findTF = var_4
	arg_1_0.selectedGo = var_4(arg_1_0.tr, "content/front/selected").gameObject
	findTF = var_4
	arg_1_0.energyTF = var_4(arg_1_0.tr, "content/dockyard/container/energy")
	findTF = var_4
	arg_1_0.proposeTF = var_4(arg_1_0.tr, "content/dockyard/propose")

	local var_1_5 = arg_1_0.selectedGo

	var_4.SetActive(var_1_5, false)

	findTF = var_4
	arg_1_0.hpBar = var_4(arg_1_0.tr, "content/dockyard/blood")
	findTF = var_4
	arg_1_0.expBuff = var_4(arg_1_0.tr, "content/expbuff")
	findTF = var_4
	arg_1_0.intimacyTF = var_4(arg_1_0.tr, "content/intimacy")
	arg_1_0.detailType = var_0_0.DetailType0

	local var_1_6 = arg_1_0.proposeTF

	arg_1_0.proposeModel = var_4.Find(var_1_6, "heartShipCard(Clone)")

	if arg_1_0.proposeModel then
		GetComponent = var_4
		arg_1_0.sg = var_4(arg_1_0.proposeModel, "SkeletonGraphic")
	end

	getProxy = var_4
	ActivityProxy = var_1_6
	arg_1_0.activityProxy = var_4(var_1_6)
	findTF = var_4
	arg_1_0.userTF = var_4(arg_1_0.tr, "content/user")

	local var_1_9

	if arg_1_0.userTF then
		local var_1_7 = arg_1_0.userTF
		local var_1_8 = var_1_9.Find(var_1_7, "icon")

		var_1_9 = var_1_9.GetComponent
		typeof = var_7
		Image = var_9
		arg_1_0.userIconTF = var_1_9(var_1_8, var_7(var_9))

		local var_1_10 = arg_1_0.userTF

		arg_1_0.userIconFrame = var_1_9.Find(var_1_10, "frame")
		findTF = var_1_9

		local var_1_11 = var_1_9(arg_1_0.tr, "content/user_name/Text")

		var_1_9 = var_1_9.GetComponent
		typeof = var_7
		Text = var_9
		arg_1_0.userNameTF = var_1_9(var_1_11, var_7(var_9))
		findTF = var_1_9
		arg_1_0.levelTF = var_1_9(arg_1_0.tr, "content/dockyard/lv")
	end

	findTF = var_1_9
	arg_1_0.tagRecommand = var_1_9(arg_1_0.tr, "content/recommand")
	getProxy = var_4
	PlayerProxy = var_6

	local var_1_12 = var_4(var_6)

	arg_1_0.palyerId = var_4.getRawData(var_1_12).id
	ClearTweenItemAlphaAndWhite = var_4

	var_4(arg_1_0.go)

	arg_1_0.isClear = true

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.isClear = false
	TweenItemAlphaAndWhite = var_2

	var_2(arg_2_0.go)

	if arg_2_0.proposeModel then
		LeanTween = var_2

		var_2.cancel(arg_2_0.proposeModel)

		LeanTween = var_2

		local var_2_0 = var_2.value

		go = var_4

		local var_2_1 = var_2_0(var_4(arg_2_0.proposeModel), 0, 1, 0.4)
		local var_2_2 = var_2.setOnUpdate

		System = var_5

		var_2_2(var_2_1, var_5.Action_float(function(arg_3_0)
			local var_3_0 = arg_2_0.sg

			Color = var_2_10002
			var_3_0.color = var_2_10002.New(1, 1, 1, arg_3_0)

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

	setActive = var_2

	var_2(arg_2_0.nameTF, false)

	setActive = var_2

	var_2(arg_2_0.nameTF, true)

	IsNil = var_2

	if not var_2(arg_2_0.levelTF) then
		setActive = var_2

		var_2(arg_2_0.levelTF, false)

		setActive = var_2

		var_2(arg_2_0.levelTF, true)
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

	local var_5_0 = arg_5_0.selectedGo

	var_2.SetActive(var_5_0, arg_5_0.selected)

	if arg_5_0.selected then
		if not arg_5_0.selectedTwId then
			LeanTween = var_2

			local var_5_1 = var_2.alpha(arg_5_0.selectedGo.transform, 0.5, var_0_2)
			local var_5_2 = var_2.setFrom(var_5_1, 0)
			local var_5_3 = var_2.setEase

			LeanTweenType = var_5

			local var_5_4 = var_5_3(var_5_2, var_5.easeInOutSine)

			arg_5_0.selectedTwId = var_2.setLoopPingPong(var_5_4).uniqueId
		end
	elseif arg_5_0.selectedTwId then
		LeanTween = var_2

		var_2.cancel(arg_5_0.selectedTwId)

		arg_5_0.selectedTwId = nil
	end

	return
end

function var_0_0.flush(arg_6_0)
	local var_6_0 = arg_6_0.shipVO

	tobool = var_1_10002

	if var_1_10002(var_6_0) then
		local var_6_1 = var_6_0

		if not var_6_0.getConfigTable(var_6_1) then
			return
		end

		flushShipCard = var_4

		var_4(arg_6_0.tr, var_6_0)

		local var_6_2 = var_6_0
		local var_6_3 = var_6_0.isActivityNpc(var_6_2)

		setActive = var_6_1

		var_6_1(arg_6_0.npc, var_6_3)

		local var_6_4

		if arg_6_0.lock then
			var_6_4 = arg_6_0.lock.gameObject

			local var_6_5 = var_5.SetActive
			local var_6_6 = var_6_0:GetLockState()

			Ship = var_1_10009

			var_6_5(var_6_4, var_6_6 == var_1_10009.LOCK_STATE_LOCK)
		end

		local var_6_7 = var_6_0.energy

		Ship = var_6_2

		if var_6_7 <= var_6_2.ENERGY_MID then
			GetSpriteFromAtlas = var_6

			if not var_6("energy", var_6_0:getEnergyPrint()) then
				warning = var_6_4

				var_6_4("找不到疲劳")
			end

			setImageSprite = var_6_4

			var_6_4(arg_6_0.energyTF, var_6)
		end

		setActive = var_6

		var_6(arg_6_0.energyTF, var_5)

		setText = var_6

		local var_6_8 = arg_6_0.nameTF
		local var_6_9 = var_6_0
		local var_6_10 = var_6_0.GetColorName

		shortenString = var_1_10012

		local var_6_11 = var_6_0
		local var_6_12 = var_6_0.getName(var_6_11)

		PLATFORM_CODE = var_1_10015
		PLATFORM_US = var_6_11

		var_6(var_6_8, var_6_10(var_6_9, var_1_10012(var_6_12, var_1_10015 == var_6_11 and 6 or 7)))

		local var_6_13
		local var_6_14

		if var_6_0.user then
			Clone = var_6_14
			var_6_14 = var_6_14(var_6_0)
			GuildAssaultFleet = var_6_8
			var_6_14.id = var_6_8.GetRealId(var_6_14.id)
			ShipStatus = var_8
			var_6_13 = var_8.ShipStatusToTag(var_6_14, arg_6_0.hideTagFlags)
		else
			ShipStatus = var_6_14
			var_6_13 = var_6_14.ShipStatusToTag(var_6_0, arg_6_0.hideTagFlags)
		end

		if var_6_13 then
			var_6_14 = arg_6_0.iconStatusTxt
			var_6_14.text = var_6_13[3]
			GetSpriteFromAtlasAsync = var_6_14

			var_6_14(var_6_13[1], var_6_13[2], function(arg_7_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_6_0.iconStatus, arg_7_0, true)

				setActive = var_2_10001

				var_2_10001(arg_6_0.iconStatus, true)

				if var_6_13[1] == "shipstatus" then
					local var_7_0 = arg_6_0.iconStatus

					Vector2 = var_2_10002
					var_7_0.sizeDelta = var_2_10002(195, 36)
					arg_6_0.iconStatusTxt.fontSize = 30
				end

				arg_6_0.iconStatusMask.enabled = false

				return
			end)
		else
			setActive = var_6_14

			var_6_14(arg_6_0.iconStatus, false)
		end

		LOCK_PROPOSE = var_6_14

		if not var_6_14 then
			if arg_6_0.proposeModel then
				arg_6_0.sg.enabled = arg_6_0:CheckHeartState()
			elseif arg_6_0:CheckHeartState() and not arg_6_0.heartLoading then
				arg_6_0.heartLoading = true
				pg = var_7

				local var_6_15 = var_7.PoolMgr.GetInstance()

				var_7.GetUI(var_6_15, "heartShipCard", false, function(arg_8_0)
					if arg_6_0.isClear or arg_6_0.proposeModel then
						pg = var_1

						local var_8_0 = var_1.PoolMgr.GetInstance()

						var_1.ReturnUI(var_8_0, "heartShipCard", arg_8_0)
					else
						arg_6_0.proposeModel = arg_8_0

						local var_8_1 = arg_6_0

						GetComponent = var_2_10002
						var_8_1.sg = var_2_10002(arg_6_0.proposeModel, "SkeletonGraphic")

						local var_8_2 = arg_6_0.proposeModel.transform

						var_1.SetParent(var_8_2, arg_6_0.proposeTF, false)

						local var_8_3 = arg_6_0.sg
						local var_8_4 = arg_6_0

						var_8_3.enabled = var_2.CheckHeartState(var_8_4)
						arg_6_0.heartLoading = false
					end

					return
				end)
			end
		end

		if arg_6_0.hpBar then
			setActive = var_7

			var_7(arg_6_0.hpBar, false)
		end

		arg_6_0:UpdateExpBuff()
		arg_6_0:updateNpcTfPosY()
	end

	if arg_6_0.userTF then
		arg_6_0:UpdateUser(var_6_0)
	end

	local var_6_16 = arg_6_0.content

	var_3.SetActive(var_6_16, var_2)

	local var_6_17 = arg_6_0.quit

	var_3.SetActive(var_6_17, not var_2)

	local var_6_18 = arg_6_0.btn
	local var_6_19

	if not var_2 or not arg_6_0.imageFrame then
		var_6_19 = arg_6_0.imageQuit
	end

	var_6_18.targetGraphic = var_6_19

	return
end

function var_0_0.CheckHeartState(arg_9_0)
	tobool = var_1_10001

	if var_1_10001(arg_9_0.shipVO) then
		local var_9_0 = arg_9_0.shipVO
		local var_9_1, var_9_2 = var_2.getIntimacyIcon(var_9_0)
		local var_9_3 = arg_9_0.shipVO
		local var_9_4 = var_4.isActivityNpc(var_9_3)

		return var_9_2 and not var_9_4
	end

	return false
end

local var_0_3 = {
	90,
	60,
	30
}

function var_0_0.updateNpcTfPosY(arg_10_0)
	isActive = var_1_10001

	if var_1_10001(arg_10_0.npc) then
		local var_10_0 = 1

		findTF = var_1_10002

		local var_10_1 = var_1_10002(arg_10_0.tr, "content/energy")

		isActive = var_3

		if var_3(var_10_1) then
			var_10_0 = var_10_0 + 1
		end

		isActive = var_3

		if var_3(arg_10_0.intimacyTF) then
			var_10_0 = var_10_0 + 1
		end

		local var_10_2 = arg_10_0.npc.anchoredPosition

		var_10_2.y = var_0_3[var_10_0]
		arg_10_0.npc.anchoredPosition = var_10_2
	end

	return
end

function var_0_0.UpdateUser(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.userIconFrame.childCount

	if 0 < var_11_0 then
		local var_11_1 = arg_11_0.userIconFrame

		var_11_0 = var_11_0.GetChild(var_11_1, 0).gameObject
		PoolMgr = var_3
		var_1_10005 = var_3.GetInstance()

		var_3.ReturnPrefab(var_1_10005, "IconFrame/" .. var_11_0.name, var_11_0.name, var_11_0)
	end

	tobool = var_11_0

	local var_11_2

	if var_11_0(arg_11_1) then
		var_11_2 = arg_11_1.user
	end

	local var_11_3 = var_11_2 and var_11_2.id ~= arg_11_0.palyerId

	setActive = var_11_4

	var_11_4(arg_11_0.userTF, var_11_3 and arg_11_0.detailType == var_0_0.DetailType0)

	setActive = var_11_4

	var_11_4(arg_11_0.userNameTF.gameObject.transform.parent, var_11_3)

	local var_11_4

	if var_11_3 and var_11_2 ~= arg_11_0.user then
		Ship = var_11_4
		var_11_4 = var_11_4.New({
			configId = var_11_2.icon
		})
		LoadSpriteAsync = var_1_10005

		var_1_10005("qicon/" .. var_11_4:getPrefab(), function(arg_12_0)
			arg_11_0.userIconTF.sprite = arg_12_0

			return
		end)

		AttireFrame = var_1_10005

		local var_11_5 = var_1_10005.attireFrameRes
		local var_11_6 = var_11_2
		local var_11_7 = false

		AttireConst = var_1_10009

		local var_11_8 = var_11_5(var_11_6, var_11_7, var_1_10009.TYPE_ICON_FRAME, var_11_2.propose)

		PoolMgr = var_6

		local var_11_9 = var_6.GetInstance()

		var_6.GetPrefab(var_11_9, "IconFrame/" .. var_11_8, var_11_8, true, function(arg_13_0)
			IsNil = var_2_10001

			if var_2_10001(arg_11_0.tr) then
				return
			end

			if arg_11_0.userIconFrame then
				arg_13_0.name = var_11_8
				setParent = var_1

				var_1(arg_13_0, arg_11_0.userIconFrame, false)
			else
				PoolMgr = var_1

				local var_13_0 = var_1.GetInstance()

				var_1.ReturnPrefab(var_13_0, "IconFrame/" .. var_11_8, var_11_8, arg_13_0)
			end

			return
		end)

		local var_11_10 = arg_11_0.userNameTF

		var_11_10.text = var_11_2.name
		arg_11_0.user = var_11_2
		setAnchoredPosition = var_11_10

		var_11_10(arg_11_0.levelTF, {
			x = -108
		})
	else
		setAnchoredPosition = var_11_4

		var_11_4(arg_11_0.levelTF, {
			x = -16
		})
	end

	return
end

function var_0_0.flushDetail(arg_14_0)
	local var_14_0 = arg_14_0.shipVO

	tobool = var_1_10002

	if var_1_10002(var_14_0) and arg_14_0.detailType > var_0_0.DetailType0 then
		local var_14_1 = var_14_0:getShipProperties()
		local var_14_2 = {}
		local var_14_3 = {}

		AttributeType = var_1_10006
		var_14_3[1] = var_1_10006.Durability
		AttributeType = var_6
		var_14_3[2] = var_6.Cannon
		AttributeType = var_6
		var_14_3[3] = var_6.Torpedo
		AttributeType = var_6
		var_14_3[4] = var_6.Air
		AttributeType = var_6
		var_14_3[5] = var_6.Reload
		AttributeType = var_6
		var_14_3[6] = var_6.Intimacy
		var_14_2[1] = var_14_3

		local var_14_4 = {}

		AttributeType = var_6
		var_14_4[1] = var_6.ArmorType
		AttributeType = var_6
		var_14_4[2] = var_6.AntiAircraft
		AttributeType = var_6
		var_14_4[3] = var_6.Dodge
		AttributeType = var_6
		var_14_4[4] = var_6.AntiSub
		AttributeType = var_6
		var_14_4[5] = var_6.Expend
		var_14_2[2] = var_14_4
		var_14_2[3] = {}

		local var_14_5 = var_14_0:getShipCombatPower()
		local var_14_6
		local var_14_7

		if arg_14_0.detailType == var_0_0.DetailType3 then
			var_14_6 = var_14_0:getDisplaySkillIds()
			pg = var_8
			var_14_7 = var_8.skill_data_template
		end

		for iter_14_0 = 1, 6 do
			local var_14_8 = arg_14_0.detailLayoutTr
			local var_14_9 = var_12.GetChild(var_14_8, iter_14_0 - 1)
			local var_14_10 = true
			local var_14_11 = var_14_9:GetChild(0)
			local var_14_12 = var_14.GetComponent(var_14_11, "Text")
			local var_14_13 = var_14_9:GetChild(1)
			local var_14_14 = var_15.GetComponent(var_14_13, "Text")

			TextAnchor = var_14_11
			var_14_12.alignment = var_14_11.MiddleLeft
			TextAnchor = var_16
			var_14_14.alignment = var_16.MiddleRight

			local var_14_15 = var_14_2[arg_14_0.detailType][iter_14_0]

			if arg_14_0.detailType == var_0_0.DetailType1 then
				if iter_14_0 == 6 then
					var_1_10019 = arg_14_0.shipVO

					local var_14_16, var_14_17 = var_14_16.getIntimacyDetail(var_1_10019)

					AttributeType = var_1_10019
					var_14_12.text = var_1_10019.Type2Name(var_14_15)
					setColorStr = var_1_10019

					local var_14_18 = var_14_17

					if var_14_16 <= var_14_17 then
						COLOR_GREEN = var_1_10022

						if not var_1_10022 then
							COLOR_WHITE = var_1_10022
						end

						var_14_14.text = var_1_10019(var_14_18, var_1_10022)

						goto label_14_0

						tostring = var_14_16
						math = var_1_10019
						var_14_16 = var_14_16(var_1_10019.floor(var_14_1[var_14_15]))
						AttributeType = var_14_17
						var_14_12.text = var_14_17.Type2Name(var_14_15)
						setColorStr = var_18
						var_1_10020 = var_14_16

						if arg_14_0:canModAttr(var_14_0, var_14_15, var_14_1) then
							COLOR_GREEN = var_21

							if not var_21 then
								COLOR_WHITE = var_21
							end

							var_14_14.text = var_18(var_1_10020, var_21)

							goto label_14_0

							if arg_14_0.detailType == var_0_0.DetailType2 then
								if iter_14_0 == 1 then
									TextAnchor = var_14_16
									var_14_12.alignment = var_14_16.MiddleCenter
									var_1_10019 = var_14_0
									var_14_12.text = var_14_0.getShipArmorName(var_1_10019)
									var_14_14.text = ""
								elseif iter_14_0 == 5 then
									var_1_10019 = var_14_0
									var_14_16 = var_14_0.getBattleTotalExpend(var_1_10019)
									AttributeType = var_18

									local var_14_19 = var_18.Type2Name

									AttributeType = var_1_10020
									var_14_12.text = var_14_19(var_1_10020.Expend)
									tostring = var_18
									math = var_1_10020
									var_14_14.text = var_18(var_1_10020.floor(var_14_16))
								elseif iter_14_0 == 6 then
									setColorStr = var_14_16
									i18n = var_1_10019
									var_1_10019 = var_1_10019("word_synthesize_power")
									COLOR_GREEN = var_1_10020
									var_14_12.text = var_14_16(var_1_10019, var_1_10020)
									tostring = var_14_16
									var_14_14.text = var_14_16(var_14_5)
								else
									AttributeType = var_14_16
									var_14_12.text = var_14_16.Type2Name(var_14_15)
									tostring = var_14_16
									math = var_1_10019
									var_14_14.text = var_14_16(var_1_10019.floor(var_14_1[var_14_15]))
								end
							elseif arg_14_0.detailType == var_0_0.DetailType3 then
								if var_14_6[iter_14_0] and var_14_0.skills[var_14_16] and var_14_7[var_14_16].max_level ~= 1 then
									local var_14_20 = var_14_0.skills[var_14_16]

									var_1_10019 = var_0_0.SKILL_COLOR
									pg = var_1_10020

									if not var_1_10019[var_1_10020.skill_data_template[var_14_20.id].type] then
										COLOR_WHITE = var_1_10019
									end

									TextAnchor = var_1_10020
									var_14_12.alignment = var_1_10020.MiddleLeft
									setColorStr = var_1_10020
									i18n = var_1_10022
									var_14_12.text = var_1_10020(var_1_10022("skill") .. iter_14_0, var_1_10019)
									var_1_10020 = var_14_20.level == var_14_7[var_14_16].max_level and "Lv.Max" or "Lv." .. var_14_20.level
									setColorStr = var_21
									var_14_14.text = var_21(var_1_10020, var_1_10019)
								else
									var_14_10 = false
								end
							end

							::label_14_0::

							setActive = var_14_16

							var_14_16(var_14_9, var_14_10)
						end
					end
				end
			end
		end
	end

	local var_14_21 = arg_14_0.detail

	var_3.SetActive(var_14_21, var_2 and arg_14_0.detailType > var_0_0.DetailType0)

	if arg_14_0.userTF then
		arg_14_0:UpdateUser(var_14_0)
	end

	arg_14_0:UpdateRecommandTag(var_14_0)

	return
end

function var_0_0.UpdateRecommandTag(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0.tagRecommand then
		defaultValue = var_2

		local var_15_0 = var_2(arg_15_1.guildRecommand, false)

		setActive = var_1_10003

		var_1_10003(arg_15_0.tagRecommand, var_15_0)
	end

	return
end

function var_0_0.canModAttr(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1:isBluePrintShip() then
		local var_16_0 = arg_16_1:getBluePrint()

		return var_4.isMaxIntensifyLevel(var_16_0)
	elseif arg_16_1:isMetaShip() then
		local var_16_1 = arg_16_1:getMetaCharacter()

		return var_4.isMaxRepairExp(var_16_1)
	else
		ShipModAttr = var_4

		if not var_4.ATTR_TO_INDEX[arg_16_2] then
			return true
		elseif arg_16_1:getModAttrTopLimit(arg_16_2) == 0 then
			return true
		else
			local var_16_2 = arg_16_1.level >= 100 or arg_16_1.level == arg_16_1:getMaxLevel()
			local var_16_3 = arg_16_1:getModAttrBaseMax(arg_16_2)

			return var_16_2 and var_16_3 <= arg_16_3[arg_16_2]
		end
	end

	return
end

function var_0_0.updateBlackBlock(arg_17_0, arg_17_1)
	local var_17_0 = false

	if arg_17_0.shipVO then
		pairs = var_3

		for iter_17_0, iter_17_1 in var_3(arg_17_0.blockTagFlags) do
			if iter_17_1 then
				local var_17_1 = arg_17_0.shipVO

				if var_8.getFlag(var_17_1, iter_17_0) then
					var_17_0 = true

					break
				end
			end
		end

		if not var_17_0 and arg_17_1 then
			getProxy = var_3
			BayProxy = var_5

			local var_17_2 = var_3(var_5)

			ipairs = var_4

			for iter_17_2, iter_17_3 in var_4(arg_17_1) do
				if var_17_2:getShipById(iter_17_3) then
					local var_17_3 = arg_17_0.shipVO

					if var_10.isSameKind(var_17_3, var_9) then
						var_17_0 = var_9.id ~= arg_17_0.shipVO.id

						break
					end
				end
			end
		end
	end

	if arg_17_0.maskStatusOb then
		setActive = var_3

		var_3(arg_17_0.maskStatusOb, var_17_0)
	end

	return
end

function var_0_0.updateWorld(arg_18_0)
	local var_18_0 = arg_18_0.shipVO

	if var_1.getFlag(var_18_0, "inWorld") then
		WorldConst = var_2

		local var_18_1 = var_2.FetchWorldShip(var_1.id)

		setActive = var_1_10003

		var_1_10003(arg_18_0.hpBar, true)

		local var_18_2 = arg_18_0.hpBar
		local var_18_3 = var_3.Find(var_18_2, "fillarea/green")
		local var_18_4 = arg_18_0.hpBar
		local var_18_5 = var_4.Find(var_18_4, "fillarea/red")

		setActive = var_18_2

		var_18_2(var_18_3, var_18_1:IsHpSafe())

		setActive = var_18_2

		local var_18_6 = var_18_5
		local var_18_7 = var_18_1

		var_18_2(var_18_6, not var_18_1.IsHpSafe(var_18_7))

		local var_18_8 = arg_18_0.hpBar
		local var_18_9 = var_5.GetComponent

		typeof = var_8
		Slider = var_18_7

		local var_18_10 = var_18_9(var_18_8, var_8(var_18_7))

		var_18_10.fillRect = var_18_1:IsHpSafe() and var_18_3 or var_18_5
		setSlider = var_18_10

		var_18_10(arg_18_0.hpBar, 0, 10000, var_18_1.hpRant)

		setActive = var_18_10

		local var_18_11 = arg_18_0.hpBar

		var_18_10(var_7.Find(var_18_11, "broken"), var_18_1:IsBroken())

		if arg_18_0.maskStatusOb then
			setActive = var_5

			var_5(arg_18_0.maskStatusOb, not var_18_1:IsAlive())
		end
	end

	return
end

function var_0_0.UpdateExpBuff(arg_19_0)
	local var_19_0 = arg_19_0.shipVO
	local var_19_1 = arg_19_0.activityProxy
	local var_19_2 = var_2.getBuffShipList(var_19_1)[var_19_0:getGroupId()]

	setActive = var_19_1

	var_19_1(arg_19_0.expBuff, false)

	setActive = var_19_1

	var_19_1(arg_19_0.expBuff, var_19_2 ~= nil)

	if var_19_2 then
		local var_19_3 = var_19_2 / 100
		local var_19_4 = var_19_2 % 100

		tostring = var_6

		local var_19_5 = var_6(var_19_3)
		local var_19_6

		if 0 < var_19_4 then
			var_19_6 = var_19_5

			local var_19_7 = "."

			tostring = var_1_10009
			var_19_5 = var_19_6 .. var_19_7 .. var_1_10009(var_19_4)
		end

		setText = var_19_6

		local var_19_8 = arg_19_0.expBuff
		local var_19_9 = var_9.Find(var_19_8, "text")

		string = var_1_10010

		var_19_6(var_19_9, var_1_10010.format("EXP +%s%%", var_19_5))
	end

	return
end

function var_0_0.clear(arg_20_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_20_0.go)

	if arg_20_0.selectedTwId then
		LeanTween = var_1

		var_1.cancel(arg_20_0.selectedTwId)

		arg_20_0.selectedTwId = nil
	end

	arg_20_0.isClear = true

	return
end

function var_0_0.updateIntimacy(arg_21_0, arg_21_1)
	if not arg_21_0.shipVO then
		return
	end

	findTF = var_1_10003

	local var_21_0 = var_1_10003(arg_21_0.tr, "content/energy")

	isActive = var_1_10004

	if var_1_10004(var_21_0) then
		findTF = var_4
		arg_21_0.intimacyTF = var_4(arg_21_0.tr, "content/intimacy_with_energy")
		setActive = var_4
		findTF = var_6

		var_4(var_6(arg_21_0.tr, "content/intimacy"), false)
	else
		findTF = var_4
		arg_21_0.intimacyTF = var_4(arg_21_0.tr, "content/intimacy")
		setActive = var_4
		findTF = var_6

		var_4(var_6(arg_21_0.tr, "content/intimacy_with_energy"), false)
	end

	local var_21_1 = var_2
	local var_21_2, var_21_3 = var_2.getIntimacyDetail(var_21_1)

	setText = var_21_1
	findTF = var_1_10008

	var_21_1(var_1_10008(arg_21_0.intimacyTF, "Text"), var_21_3)

	if var_21_3 == 100 or var_21_3 == 200 then
		setText = var_21_1
		findTF = var_8

		local var_21_4 = var_8(arg_21_0.intimacyTF, "Text")

		setColorStr = var_9

		var_21_1(var_21_4, var_9(var_21_3, "#ff8d8d"))
	end

	setActive = var_21_1

	var_21_1(arg_21_0.intimacyTF, arg_21_1)
	arg_21_0:updateNpcTfPosY()

	return
end

function var_0_0.updateIntimacyEnergy(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.tr
	local var_22_1 = var_2.Find(var_22_0, "content/energy")
	local var_22_2 = arg_22_0.shipVO

	setActive = var_22_0

	local var_22_3 = arg_22_0.tr

	var_22_0(var_6.Find(var_22_3, "content/energy"), var_22_2 and arg_22_1)

	if arg_22_1 then
		tobool = var_22_0

		if var_22_0(var_22_2) then
			GetSpriteFromAtlas = var_4

			local var_22_4 = var_4("energy", var_22_2:getEnergyPrint())

			setImageSprite = var_5

			var_5(var_22_1:Find("icon/img"), var_22_4, true)

			setText = var_5

			var_5(var_22_1:Find("Text"), var_22_2:getEnergy())

			setActive = var_5

			var_5(var_22_1:Find("Text"), false)

			setActive = var_5

			var_5(var_22_1:Find("Text"), true)
		end
	end

	return
end

return var_0_0
