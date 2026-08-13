class = var_0_10000

local var_0_0 = var_0_10000("BaseFormation")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._mainTf = arg_1_1
	arg_1_0._heroContainer = arg_1_2
	arg_1_0._heroInfoTpl = arg_1_3
	arg_1_0._gridTFs = arg_1_4
	rtf = var_1_10005

	local var_1_0 = var_1_10005(arg_1_0._mainTf).rect.width

	UnityEngine = var_1_10006
	arg_1_0._widthRate = var_1_0 / var_1_10006.Screen.width
	rtf = var_5

	local var_1_1 = var_5(arg_1_0._mainTf).rect.height

	UnityEngine = var_6
	arg_1_0._heightRate = var_1_1 / var_6.Screen.height
	rtf = var_5
	arg_1_0._halfWidth = var_5(arg_1_0._mainTf).rect.width / 2
	rtf = var_5
	arg_1_0._halfHeight = var_5(arg_1_0._mainTf).rect.height / 2
	arg_1_0._offset = arg_1_0._heroContainer.localPosition
	arg_1_0._eventTriggers = {}
	pg = var_5

	var_5.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.SetFleetVO(arg_2_0, arg_2_1)
	arg_2_0._currentFleetVO = arg_2_1

	return
end

function var_0_0.SetShipVOs(arg_3_0, arg_3_1)
	arg_3_0._shipVOs = arg_3_1

	return
end

function var_0_0.DisableTip(arg_4_0)
	arg_4_0._disableTip = true

	return
end

function var_0_0.ForceDropChar(arg_5_0)
	if arg_5_0._currentDragDelegate then
		arg_5_0._forceDropCharacter = true
		LuaHelper = var_1

		var_1.triggerEndDrag(arg_5_0._currentDragDelegate)
	end

	return
end

function var_0_0.AddHeroInfoModify(arg_6_0, arg_6_1)
	arg_6_0._heroInfoModifyCb = arg_6_1

	return
end

function var_0_0.AddLongPress(arg_7_0, arg_7_1)
	arg_7_0._longPressCb = arg_7_1

	return
end

function var_0_0.AddClick(arg_8_0, arg_8_1)
	arg_8_0._click = arg_8_1

	return
end

function var_0_0.AddBeginDrag(arg_9_0, arg_9_1)
	arg_9_0._beginDrag = arg_9_1

	return
end

function var_0_0.AddEndDrag(arg_10_0, arg_10_1)
	arg_10_0._endDrag = arg_10_1

	return
end

function var_0_0.AddCheckBeginDrag(arg_11_0, arg_11_1)
	arg_11_0._checkBeginDrag = arg_11_1

	return
end

function var_0_0.AddShiftOnly(arg_12_0, arg_12_1)
	arg_12_0._shiftOnly = arg_12_1

	return
end

function var_0_0.AddRemoveShip(arg_13_0, arg_13_1)
	arg_13_0._removeShip = arg_13_1

	return
end

function var_0_0.AddCheckRemove(arg_14_0, arg_14_1)
	arg_14_0._checkRemove = arg_14_1

	return
end

function var_0_0.AddCheckSwitch(arg_15_0, arg_15_1)
	arg_15_0._checkSwitch = arg_15_1

	return
end

function var_0_0.AddSwitchToDisplayMode(arg_16_0, arg_16_1)
	arg_16_0._switchToDisplayModeHandler = arg_16_1

	return
end

function var_0_0.AddSwitchToShiftMode(arg_17_0, arg_17_1)
	arg_17_0._switchToShiftModeHandler = arg_17_1

	return
end

function var_0_0.AddSwitchToPreviewMode(arg_18_0, arg_18_1)
	arg_18_0._swtichToPreviewModeHandler = arg_18_1

	return
end

function var_0_0.AddGridTipClick(arg_19_0, arg_19_1)
	arg_19_0._gridTipClick = arg_19_1

	return
end

function var_0_0.AddLoadComplete(arg_20_0, arg_20_1)
	arg_20_0._loadComplete = arg_20_1

	return
end

function var_0_0.GenCharInfo(arg_21_0, arg_21_1, arg_21_2)
	return {
		heroInfoTF = arg_21_1,
		spineRole = arg_21_2
	}
end

function var_0_0.ClearHeroContainer(arg_22_0)
	local var_22_1

	if arg_22_0._characterList then
		local var_22_0 = arg_22_0

		var_22_1 = arg_22_0.RecycleCharacterList

		local var_22_2 = arg_22_0._currentFleetVO
		local var_22_3 = var_4.getTeamByName

		TeamType = var_1_10007

		local var_22_4 = var_22_3(var_22_2, var_1_10007.Main)
		local var_22_5 = arg_22_0._characterList

		TeamType = var_22_2

		var_22_1(var_22_0, var_22_4, var_22_5[var_22_2.Main])

		local var_22_6 = arg_22_0

		var_22_1 = arg_22_0.RecycleCharacterList

		local var_22_7 = arg_22_0._currentFleetVO
		local var_22_8 = var_4.getTeamByName

		TeamType = var_7

		local var_22_9 = var_22_8(var_22_7, var_7.Vanguard)
		local var_22_10 = arg_22_0._characterList

		TeamType = var_22_7

		var_22_1(var_22_6, var_22_9, var_22_10[var_22_7.Vanguard])

		local var_22_11 = arg_22_0

		var_22_1 = arg_22_0.RecycleCharacterList

		local var_22_12 = arg_22_0._currentFleetVO
		local var_22_13 = var_4.getTeamByName

		TeamType = var_7

		local var_22_14 = var_22_13(var_22_12, var_7.Submarine)
		local var_22_15 = arg_22_0._characterList

		TeamType = var_22_12

		var_22_1(var_22_11, var_22_14, var_22_15[var_22_12.Submarine])
	end

	removeAllChildren = var_22_1

	var_22_1(arg_22_0._heroContainer)

	return
end

function var_0_0.LoadAllCharacter(arg_23_0)
	arg_23_0:ClearHeroContainer()

	local var_23_0 = {}

	TeamType = var_1_10002
	var_23_0[var_1_10002.Vanguard] = {}
	TeamType = var_2
	var_23_0[var_2.Main] = {}
	TeamType = var_2
	var_23_0[var_2.Submarine] = {}
	arg_23_0._characterList = var_23_0

	local function var_23_1(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		if arg_23_0._exited then
			return
		end

		local var_24_0 = arg_23_0._shipVOs[arg_24_1]

		tf = var_2_10005
		Instantiate = var_2_10007

		local var_24_1 = var_2_10005(var_2_10007(arg_23_0._heroInfoTpl))

		var_5.SetParent(var_24_1, arg_23_0._heroContainer, false)

		SetActive = var_6

		var_6(var_5, true)
		arg_24_0:SetParent(var_5)
		arg_24_0:SetRaycastTarget(false)

		local var_24_2 = arg_24_0
		local var_24_3 = arg_24_0.SetLocalScale

		Vector3 = var_9

		var_24_3(var_24_2, var_9(0.8, 0.8, 1))

		local var_24_4 = arg_24_0
		local var_24_5 = arg_24_0.SetLayer

		Layer = var_9

		var_24_5(var_24_4, var_9.UI)
		arg_24_0:SetAsFirstSibling()

		if arg_23_0._heroInfoModifyCb ~= nil then
			arg_23_0._heroInfoModifyCb(var_5, var_24_0, arg_24_0)
		end

		local var_24_6 = arg_23_0
		local var_24_7 = var_6.GenCharInfo(var_24_6, var_5, arg_24_0)
		local var_24_8 = arg_23_0._characterList[arg_24_2]

		var_24_8[arg_24_3] = var_24_7

		local var_24_9, var_24_10, var_24_11 = arg_24_0:CreateInterface()
		local var_24_12 = arg_23_0._eventTriggers

		var_24_12[var_24_11] = true
		pg = var_24_12

		var_24_12.DelegateInfo.Add(arg_23_0, var_24_10.onLongPressed)

		var_24_10.longPressThreshold = 1

		local var_24_13 = var_24_10.onLongPressed

		var_11.RemoveAllListeners(var_24_13)

		local var_24_14 = var_24_10.onLongPressed

		var_11.AddListener(var_24_14, function()
			if arg_23_0._longPressCb ~= nil then
				arg_23_0._longPressCb(var_0, var_24_0, arg_23_0._currentFleetVO, arg_24_2)
			end

			return
		end)

		pg = var_11

		var_11.DelegateInfo.Add(arg_23_0, var_24_9.onModelClick)

		local var_24_15 = var_24_9.onModelClick

		var_11.AddListener(var_24_15, function()
			if arg_23_0._click ~= nil then
				arg_23_0._click(var_24_0, arg_24_2, arg_23_0._currentFleetVO)
			end

			return
		end)
		var_24_11:AddBeginDragFunc(function()
			if arg_23_0._modelDrag then
				return
			end

			if arg_23_0._checkBeginDrag and not arg_23_0._checkBeginDrag(var_24_0, arg_24_2, arg_23_0._currentFleetVO) then
				return
			end

			local var_27_0 = arg_23_0
			local var_27_1 = arg_24_0

			var_27_0._modelDrag = var_1.GetRootModel(var_27_1)

			local var_27_2 = arg_23_0

			var_27_2._currentDragDelegate = var_24_11
			LeanTween = var_27_2

			var_27_2.cancel(arg_23_0._modelDrag)

			local var_27_3 = var_0

			var_0.SetAsLastSibling(var_27_3)

			local var_27_4 = arg_23_0

			var_0.SwitchToShiftMode(var_27_4, var_0, arg_24_2)

			local var_27_5 = arg_24_0

			var_0.SetAction(var_27_5, "tuozhuai")

			if arg_23_0._beginDrag then
				arg_23_0._beginDrag(var_0)
			end

			pg = var_0

			local var_27_6 = var_0.CriMgr.GetInstance()
			local var_27_7 = var_0.PlaySoundEffect_V3

			SFX_UI_HOME_DRAG = var_3

			var_27_7(var_27_6, var_3)

			return
		end)
		var_24_11:AddDragFunc(function(arg_28_0, arg_28_1)
			local var_28_0 = arg_23_0._modelDrag
			local var_28_1 = arg_24_0

			if var_28_0 ~= var_3.GetRootModel(var_28_1) then
				return
			end

			local var_28_2 = var_0

			Vector3 = var_3
			var_28_2.localPosition = var_3(arg_28_1.position.x * arg_23_0._widthRate - arg_23_0._halfWidth - arg_23_0._offset.x, arg_28_1.position.y * arg_23_0._heightRate - arg_23_0._halfHeight - arg_23_0._offset.y, -22)

			return
		end)
		var_24_11:AddDragEndFunc(function(arg_29_0, arg_29_1)
			local var_29_0 = arg_23_0._modelDrag
			local var_29_1 = arg_24_0

			if var_29_0 ~= var_3.GetRootModel(var_29_1) then
				return
			end

			arg_23_0._modelDrag = false

			local var_29_2 = arg_23_0._forceDropCharacter

			arg_23_0._forceDropCharacter = nil
			arg_23_0._currentDragDelegate = nil

			local var_29_3 = arg_24_0

			var_3.SetAction(var_29_3, "stand")

			local function var_29_4()
				local var_30_0 = arg_23_0

				var_0.SwitchToDisplayMode(var_30_0)

				local var_30_1 = arg_23_0

				var_0.SortSiblingIndex(var_30_1)

				if arg_23_0._shiftOnly ~= nil then
					arg_23_0._shiftOnly(arg_23_0._currentFleetVO)
				end

				return
			end

			if var_29_2 then
				var_29_4()

				return
			end

			local function var_29_5()
				ipairs = var_4_10000

				for iter_31_0, iter_31_1 in var_4_10000(var_24_8) do
					if iter_31_1.heroInfoTF == var_0 then
						local var_31_0 = iter_31_1.spineRole

						var_5.Dispose(var_31_0)

						local var_31_1 = var_0.gameObject

						var_5.Destroy(var_31_1)

						table = var_5

						var_5.remove(var_24_8, iter_31_0)

						break
					end
				end

				local var_31_2 = arg_23_0

				var_0.SwitchToDisplayMode(var_31_2)

				local var_31_3 = arg_23_0

				var_0.SortSiblingIndex(var_31_3)

				if arg_23_0._removeShip ~= nil then
					arg_23_0._removeShip(var_24_0, arg_23_0._currentFleetVO)
				end

				return
			end

			local var_29_6 = arg_23_0
			local var_29_7, var_29_8 = var_5.GetShipPos(var_29_6, arg_23_0._currentFleetVO, var_24_0)
			local var_29_9 = arg_29_1.position.x

			UnityEngine = var_8

			if not (var_29_9 < var_8.Screen.width * 0.15) then
				local var_29_10 = arg_29_1.position.x

				UnityEngine = var_8

				if not (var_8.Screen.width * 0.87 < var_29_10) then
					local var_29_11 = arg_29_1.position.y

					UnityEngine = var_8

					if not (var_29_11 < var_8.Screen.height * 0.18) then
						local var_29_12 = arg_29_1.position.y

						UnityEngine = var_8

						if var_29_12 > var_8.Screen.height * 0.7 then
							if arg_23_0._checkRemove ~= nil then
								arg_23_0._checkRemove(var_29_4, var_29_5, var_24_0, arg_23_0._currentFleetVO, var_29_8)
							end
						else
							var_29_4()
						end

						if arg_23_0._endDrag ~= nil then
							arg_23_0._endDrag(var_0)
						end

						pg = var_7

						local var_29_13 = var_7.CriMgr.GetInstance()
						local var_29_14 = var_7.PlaySoundEffect_V3

						SFX_UI_HOME_PUT = var_3_10010

						var_29_14(var_29_13, var_3_10010)

						return
					end
				end
			end
		end)

		local var_24_16 = arg_23_0

		var_11.SetCharacterPos(var_24_16, arg_24_2, arg_24_3, var_24_7)

		return
	end

	local var_23_2 = {}

	local function var_23_3(arg_32_0, arg_32_1)
		ipairs = var_2_10002

		for iter_32_0, iter_32_1 in var_2_10002(arg_32_0) do
			table = var_2_10007

			var_2_10007.insert(var_23_2, function(arg_33_0)
				SpineRole = var_3_10001

				local var_33_0 = var_3_10001.New(arg_23_0._shipVOs[iter_32_1])

				var_1.Load(var_33_0, function()
					var_23_1(var_0, iter_32_1, arg_32_1, iter_32_0)
					arg_33_0()

					return
				end, nil, var_1.ORBIT_KEY_UI)

				return
			end)
		end

		return
	end

	local var_23_4 = arg_23_0._currentFleetVO
	local var_23_5 = var_4.getFleetType(var_23_4)

	FleetType = var_1_10005

	local var_23_6

	if var_23_5 == var_1_10005.Normal then
		var_23_6 = var_23_3

		local var_23_7 = arg_23_0._currentFleetVO
		local var_23_8 = var_7.getTeamByName

		TeamType = var_1_10010

		local var_23_9 = var_23_8(var_23_7, var_1_10010.Vanguard)

		TeamType = var_1_10008

		var_23_6(var_23_9, var_1_10008.Vanguard)

		var_23_6 = var_23_3

		local var_23_10 = arg_23_0._currentFleetVO
		local var_23_11 = var_7.getTeamByName

		TeamType = var_1_10010

		local var_23_12 = var_23_11(var_23_10, var_1_10010.Main)

		TeamType = var_1_10008

		var_23_6(var_23_12, var_1_10008.Main)
	else
		FleetType = var_23_6

		if var_23_5 == var_23_6.Submarine then
			var_23_6 = var_23_3

			local var_23_13 = arg_23_0._currentFleetVO
			local var_23_14 = var_7.getTeamByName

			TeamType = var_1_10010

			local var_23_15 = var_23_14(var_23_13, var_1_10010.Submarine)

			TeamType = var_1_10008

			var_23_6(var_23_15, var_1_10008.Submarine)
		end
	end

	pg = var_23_6

	local var_23_16 = var_23_6.UIMgr.GetInstance()

	var_5.LoadingOn(var_23_16)

	parallelAsync = var_5

	var_5(var_23_2, function(arg_35_0)
		pg = var_2_10001

		local var_35_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_35_0)

		if arg_23_0._exited then
			return
		end

		local var_35_1 = arg_23_0

		var_1.SortSiblingIndex(var_35_1)

		if arg_23_0._loadComplete then
			arg_23_0._loadComplete()
		end

		return
	end)

	return
end

function var_0_0.GetShipPos(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_2 then
		return
	end

	local var_36_0 = arg_36_2
	local var_36_1 = arg_36_2.getTeamType(var_36_0)
	local var_36_2 = arg_36_1:getTeamByName(var_36_1)

	table = var_36_0

	local var_36_3

	if not var_36_0.indexof(var_36_2, arg_36_2.id) then
		var_36_3 = -1
	end

	return var_36_3, var_36_1
end

function var_0_0.SetAllCharacterPos(arg_37_0)
	local var_37_0 = {}

	TeamType = var_1_10002
	var_37_0[1] = var_1_10002.Main
	TeamType = var_2
	var_37_0[2] = var_2.Vanguard
	TeamType = var_2
	var_37_0[3] = var_2.Submarine
	_ = var_2

	var_2.each(var_37_0, function(arg_38_0)
		ipairs = var_2_10001

		for iter_38_0, iter_38_1 in var_2_10001(arg_37_0._characterList[arg_38_0]) do
			local var_38_0 = arg_37_0

			var_6.SetCharacterPos(var_38_0, arg_38_0, iter_38_0, iter_38_1)
		end

		return
	end)

	return
end

function var_0_0.SetCharacterPos(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	assert = var_1_10004

	local var_39_0 = arg_39_0._gridTFs[arg_39_1]
	local var_39_1 = "没有找到编队显示对象_teamType:"

	tostring = var_1_10008

	var_1_10004(var_39_0, var_39_1 .. var_1_10008(arg_39_1))

	local var_39_2 = arg_39_3.heroInfoTF
	local var_39_3 = arg_39_3.spineRole
	local var_39_4 = var_5.GetRootModel(var_39_3)
	local var_39_5 = arg_39_0._gridTFs[arg_39_1][arg_39_2].localPosition

	LeanTween = var_1_10009

	var_1_10009.cancel(var_39_4)

	Vector3 = var_9
	var_39_2.localPosition = var_9(var_39_5.x, var_39_5.y, -15 + var_39_5.z + arg_39_2)

	local var_39_6 = var_39_4.transform

	Vector3 = var_10
	var_39_6.localPosition = var_10(0, 20, 0)
	LeanTween = var_39_6

	local var_39_7 = var_39_6.moveY

	rtf = var_11

	local var_39_8 = var_39_7(var_11(var_39_4), 0, 0.5)

	var_9.setDelay(var_39_8, 0.5)

	SetActive = var_9

	var_9(var_7:Find("shadow"), true)
	var_5:SetAction("stand")
	var_5:resumeRole()

	return
end

function var_0_0.ResetGrid(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0._gridTFs[arg_40_1] then
		return
	end

	local var_40_0 = arg_40_0._currentFleetVO
	local var_40_1 = var_3.getTeamByName(var_40_0, arg_40_1)

	assert = var_1_10004

	var_1_10004(var_40_1, arg_40_1)

	local var_40_2 = arg_40_0._gridTFs[arg_40_1]

	ipairs = var_40_0

	for iter_40_0, iter_40_1 in var_40_0(var_40_2) do
		SetActive = var_1_10010

		var_1_10010(iter_40_1:Find("shadow"), false)

		SetActive = var_1_10010

		var_1_10010(iter_40_1:Find("tip"), false)
	end

	TeamType = var_5

	if arg_40_1 == var_5.Main then
		local var_40_3 = arg_40_0._currentFleetVO
		local var_40_4 = var_5.getTeamByName

		TeamType = iter_40_0

		if #var_40_4(var_40_3, iter_40_0.Vanguard) == 0 then
			return
		end
	end

	if #var_40_1 < 3 then
		local var_40_5 = var_40_2[var_5 + 1]
		local var_40_6 = var_6.Find(var_40_5, "tip")
		local var_40_7 = var_7.GetComponent(var_40_6, "Button")

		var_40_7.enabled = true
		onButton = var_40_7

		local var_40_8 = arg_40_0
		local var_40_9 = var_7

		local function var_40_10()
			if arg_40_0._gridTipClick then
				arg_40_0._gridTipClick(arg_40_1, arg_40_0._currentFleetVO)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_40_7(var_40_8, var_40_9, var_40_10, var_1_10013)

		Vector3 = var_40_7
		var_7.localScale = var_40_7(0, 0, 1)

		if not arg_40_0._disableTip then
			SetActive = var_8

			var_8(var_7, not arg_40_2)
		end

		LeanTween = var_8

		local var_40_11 = var_8.value

		go = var_10

		local var_40_12 = var_40_11(var_10(var_7), 0, 1, 1)
		local var_40_13 = var_8.setOnUpdate

		System = var_11

		local var_40_14 = var_40_13(var_40_12, var_11.Action_float(function(arg_42_0)
			local var_42_0 = var_0

			Vector3 = var_2_10002
			var_42_0.localScale = var_2_10002(arg_42_0, arg_42_0, 1)

			return
		end))
		local var_40_15 = var_8.setEase

		LeanTweenType = var_11

		var_40_15(var_40_14, var_11.easeOutBack)
	end

	return
end

function var_0_0.SwitchToShiftMode(arg_43_0, arg_43_1, arg_43_2)
	assert = var_1_10003

	local var_43_0 = arg_43_0._gridTFs[arg_43_2]
	local var_43_1 = "没有找到编队显示对象_teamType:"

	tostring = var_1_10007

	var_1_10003(var_43_0, var_43_1 .. var_1_10007(arg_43_2))

	if arg_43_0._switchToShiftModeHandler then
		arg_43_0._switchToShiftModeHandler()
	end

	for iter_43_0 = 1, 3 do
		local var_43_2 = {}

		TeamType = var_1_10008
		var_43_2[1] = var_1_10008.Vanguard
		TeamType = var_1_10008
		var_43_2[2] = var_1_10008.Main
		TeamType = var_1_10008
		var_43_2[3] = var_1_10008.Submarine
		_ = var_1_10008

		var_1_10008.each(var_43_2, function(arg_44_0)
			if arg_43_0._gridTFs[arg_44_0] and arg_43_0._gridTFs[arg_44_0][iter_43_0] then
				setActive = var_1

				local var_44_0 = arg_43_0._gridTFs[arg_44_0][iter_43_0]

				var_1(var_3.Find(var_44_0, "tip"), false)
			end

			return
		end)

		setActive = var_1_10008
		var_1_10012 = arg_43_0._gridTFs[arg_43_2][iter_43_0]

		var_1_10008(var_10.Find(var_1_10012, "shadow"), false)
	end

	local var_43_3 = arg_43_0._characterList[arg_43_2]

	ipairs = var_4

	for iter_43_1, iter_43_2 in var_4(var_43_3) do
		local var_43_4 = iter_43_2.heroInfoTF
		local var_43_5 = iter_43_2.spineRole
		local var_43_6 = var_10.GetRootModel(var_43_5)

		if var_43_4 ~= arg_43_1 then
			LeanTween = var_1_10012
			var_1_10012 = var_1_10012.moveY
			rtf = var_1_10014

			var_1_10012(var_1_10014(var_43_6), var_43_6.transform.localPosition.y + 20, 0.5)

			var_1_10014 = var_10

			local var_43_7

			var_1_10012, var_43_7, var_1_10014 = var_10.GetInterface(var_1_10014)
			arg_43_0._eventTriggers[var_1_10014] = true

			var_1_10014:AddPointEnterFunc(function()
				ipairs = var_2_10000

				for iter_45_0, iter_45_1 in var_2_10000(var_43_3) do
					if iter_45_1.heroInfoTF == var_43_4 then
						seriesAsync = var_5

						var_5({
							function(arg_46_0)
								if not arg_43_0._checkSwitch then
									return arg_46_0()
								end

								arg_43_0._checkSwitch(arg_46_0, arg_43_0._shiftIndex, iter_45_0, arg_43_0._currentFleetVO, arg_43_2)

								return
							end,
							function(arg_47_0)
								local var_47_0 = arg_43_0

								var_1.Shift(var_47_0, arg_43_0._shiftIndex, iter_45_0, arg_43_2)

								return
							end
						})

						break
					end
				end

				return
			end)
		else
			arg_43_0._shiftIndex = iter_43_1
			var_1_10014 = var_10

			var_10.DisableInterface(var_1_10014)
		end

		var_1_10014 = var_10

		var_10.SetAction(var_1_10014, "normal")
	end

	return
end

function var_0_0.SwitchToDisplayMode(arg_48_0)
	if arg_48_0._switchToDisplayModeHandler then
		arg_48_0._switchToDisplayModeHandler()
	end

	local function var_48_0(arg_49_0)
		ipairs = var_2_10001

		for iter_49_0, iter_49_1 in var_2_10001(arg_49_0) do
			local var_49_0 = iter_49_1.heroInfoTF
			local var_49_1 = iter_49_1.spineRole
			local var_49_2 = var_7.GetRootModel(var_49_1)
			local var_49_3, var_49_4, var_49_5 = var_7:GetInterface()

			if var_49_5 then
				arg_48_0._eventTriggers[var_49_5] = true

				if var_49_5 then
					var_49_5:RemovePointEnterFunc()
				end
			end
		end

		return
	end

	arg_48_0:TurnOffPreviewMode()

	local var_48_1 = var_48_0
	local var_48_2 = arg_48_0._characterList

	TeamType = var_1_10005

	var_48_1(var_48_2[var_1_10005.Vanguard])

	local var_48_3 = var_48_0
	local var_48_4 = arg_48_0._characterList

	TeamType = var_5

	var_48_3(var_48_4[var_5.Main])

	local var_48_5 = var_48_0
	local var_48_6 = arg_48_0._characterList

	TeamType = var_5

	var_48_5(var_48_6[var_5.Submarine])

	arg_48_0._shiftIndex = nil

	return
end

function var_0_0.SwitchToPreviewMode(arg_50_0)
	if arg_50_0._swtichToPreviewModeHandler then
		arg_50_0._swtichToPreviewModeHandler()
	end

	local var_50_0 = arg_50_0
	local var_50_1 = arg_50_0.ResetGrid

	TeamType = var_1_10004

	var_50_1(var_50_0, var_1_10004.Vanguard, true)

	local var_50_2 = arg_50_0
	local var_50_3 = arg_50_0.ResetGrid

	TeamType = var_4

	var_50_3(var_50_2, var_4.Main, true)

	local var_50_4 = arg_50_0
	local var_50_5 = arg_50_0.ResetGrid

	TeamType = var_4

	var_50_5(var_50_4, var_4.Submarine, true)
	arg_50_0:SetAllCharacterPos()
	arg_50_0:SetEnableForSpineInterface(false)

	return
end

function var_0_0.TurnOffPreviewMode(arg_51_0)
	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.ResetGrid

	TeamType = var_1_10004

	var_51_1(var_51_0, var_1_10004.Vanguard)

	local var_51_2 = arg_51_0
	local var_51_3 = arg_51_0.ResetGrid

	TeamType = var_4

	var_51_3(var_51_2, var_4.Main)

	local var_51_4 = arg_51_0
	local var_51_5 = arg_51_0.ResetGrid

	TeamType = var_4

	var_51_5(var_51_4, var_4.Submarine)
	arg_51_0:SetAllCharacterPos()
	arg_51_0:SetEnableForSpineInterface(true)

	return
end

function var_0_0.SetEnableForSpineInterface(arg_52_0, arg_52_1)
	local var_52_0 = {}

	TeamType = var_1_10003
	var_52_0[1] = var_1_10003.Main
	TeamType = var_3
	var_52_0[2] = var_3.Vanguard
	TeamType = var_3
	var_52_0[3] = var_3.Submarine
	_ = var_3

	var_3.each(var_52_0, function(arg_53_0)
		ipairs = var_2_10001

		for iter_53_0, iter_53_1 in var_2_10001(arg_52_0._characterList[arg_53_0]) do
			if arg_52_1 then
				local var_53_0 = iter_53_1.spineRole

				var_6.EnableInterface(var_53_0)
			else
				local var_53_1 = iter_53_1.spineRole

				var_6.DisableInterface(var_53_1)
			end
		end

		return
	end)

	return
end

function var_0_0.Shift(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	assert = var_1_10004

	local var_54_0 = arg_54_0._gridTFs[arg_54_3]
	local var_54_1 = "没有找到编队显示对象_teamType:"

	tostring = var_1_10008

	var_1_10004(var_54_0, var_54_1 .. var_1_10008(arg_54_3))

	local var_54_2 = arg_54_0._characterList[arg_54_3]
	local var_54_3 = arg_54_0._gridTFs[arg_54_3]
	local var_54_4 = var_54_2[arg_54_2].heroInfoTF
	local var_54_5 = var_6.spineRole
	local var_54_6 = var_8.GetRootModel(var_54_5)
	local var_54_7 = var_54_3[arg_54_1].localPosition

	Vector3 = var_1_10011
	var_54_4.localPosition = var_1_10011(var_54_7.x, var_54_7.y + 20, -15 + var_54_7.z + arg_54_1)

	local var_54_8 = var_54_2[arg_54_1].spineRole.ship.id
	local var_54_9 = var_54_2[arg_54_2].spineRole.ship.id

	LeanTween = var_13

	var_13.cancel(var_54_6)

	var_54_2[arg_54_1], var_54_2[arg_54_2] = var_54_2[arg_54_2], var_54_2[arg_54_1]

	local var_54_10 = arg_54_0._currentFleetVO

	var_13.switchShip(var_54_10, arg_54_3, arg_54_1, arg_54_2, var_54_8, var_54_9)

	arg_54_0._shiftIndex = arg_54_2

	return
end

function var_0_0.SortSiblingIndex(arg_55_0)
	local var_55_0 = 0
	local var_55_1 = {
		2,
		1,
		3
	}

	ipairs = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10003(var_55_1) do
		local var_55_2 = arg_55_0._characterList

		TeamType = var_1_10009

		if var_55_2[var_1_10009.Main][iter_55_1] then
			var_1_10009 = var_8.heroInfoTF
			tf = var_1_10010

			local var_55_3 = var_1_10010(var_1_10009)

			var_1_10010.SetSiblingIndex(var_55_3, var_55_0)

			var_55_0 = var_55_0 + 1
		end
	end

	local var_55_4 = 3

	while var_55_4 > 0 do
		local var_55_5 = arg_55_0._characterList

		TeamType = var_55_6

		local var_55_6

		if var_55_5[var_55_6.Vanguard][var_55_4] then
			var_55_6 = var_4.heroInfoTF
			tf = iter_55_0

			local var_55_7 = iter_55_0(var_55_6)

			iter_55_0.SetSiblingIndex(var_55_7, var_55_0)

			var_55_0 = var_55_0 + 1
		end

		var_55_4 = var_55_4 - 1
	end

	local var_55_8 = 3

	while var_55_8 > 0 do
		local var_55_9 = arg_55_0._characterList

		TeamType = var_55_6

		if var_55_9[var_55_6.Submarine][var_55_8] then
			var_55_6 = var_4.heroInfoTF
			tf = iter_55_0

			local var_55_10 = iter_55_0(var_55_6)

			iter_55_0.SetSiblingIndex(var_55_10, var_55_0)

			var_55_0 = var_55_0 + 1
		end

		var_55_8 = var_55_8 - 1
	end

	return
end

function var_0_0.UpdateGridVisibility(arg_56_0)
	local var_56_0 = arg_56_0._currentFleetVO
	local var_56_1 = var_1.getFleetType(var_56_0)

	_ = var_1_10002

	local var_56_2 = var_1_10002.each
	local var_56_3 = arg_56_0._gridTFs

	TeamType = var_1_10005

	var_56_2(var_56_3[var_1_10005.Main], function(arg_57_0)
		setActive = var_2_10001

		local var_57_0 = arg_57_0
		local var_57_1 = var_56_1

		FleetType = var_2_10005

		var_2_10001(var_57_0, var_57_1 == var_2_10005.Normal)

		return
	end)

	_ = var_56_2

	local var_56_4 = var_56_2.each
	local var_56_5 = arg_56_0._gridTFs

	TeamType = var_5

	var_56_4(var_56_5[var_5.Vanguard], function(arg_58_0)
		setActive = var_2_10001

		local var_58_0 = arg_58_0
		local var_58_1 = var_56_1

		FleetType = var_2_10005

		var_2_10001(var_58_0, var_58_1 == var_2_10005.Normal)

		return
	end)

	_ = var_56_4

	local var_56_6 = var_56_4.each
	local var_56_7 = arg_56_0._gridTFs

	TeamType = var_5

	var_56_6(var_56_7[var_5.Submarine], function(arg_59_0)
		setActive = var_2_10001

		local var_59_0 = arg_59_0
		local var_59_1 = var_56_1

		FleetType = var_2_10005

		var_2_10001(var_59_0, var_59_1 == var_2_10005.Submarine)

		return
	end)

	return
end

function var_0_0.RecycleCharacterList(arg_60_0, arg_60_1, arg_60_2)
	ipairs = var_1_10003

	for iter_60_0, iter_60_1 in var_1_10003(arg_60_1) do
		if arg_60_2[iter_60_0] then
			local var_60_0 = var_8.spineRole

			var_9.Dispose(var_60_0)

			arg_60_2[iter_60_0] = nil
		end
	end

	return
end

function var_0_0.Destroy(arg_61_0)
	arg_61_0._exited = true

	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.RecycleCharacterList
	local var_61_2 = arg_61_0._currentFleetVO
	local var_61_3 = var_4.getTeamByName

	TeamType = var_1_10007

	local var_61_4 = var_61_3(var_61_2, var_1_10007.Main)
	local var_61_5 = arg_61_0._characterList

	TeamType = var_61_2

	var_61_1(var_61_0, var_61_4, var_61_5[var_61_2.Main])

	local var_61_6 = arg_61_0
	local var_61_7 = arg_61_0.RecycleCharacterList
	local var_61_8 = arg_61_0._currentFleetVO
	local var_61_9 = var_4.getTeamByName

	TeamType = var_7

	local var_61_10 = var_61_9(var_61_8, var_7.Vanguard)
	local var_61_11 = arg_61_0._characterList

	TeamType = var_61_8

	var_61_7(var_61_6, var_61_10, var_61_11[var_61_8.Vanguard])

	local var_61_12 = arg_61_0
	local var_61_13 = arg_61_0.RecycleCharacterList
	local var_61_14 = arg_61_0._currentFleetVO
	local var_61_15 = var_4.getTeamByName

	TeamType = var_7

	local var_61_16 = var_61_15(var_61_14, var_7.Submarine)
	local var_61_17 = arg_61_0._characterList

	TeamType = var_61_14

	var_61_13(var_61_12, var_61_16, var_61_17[var_61_14.Submarine])

	if arg_61_0._eventTriggers then
		pairs = var_1

		for iter_61_0, iter_61_1 in var_1(arg_61_0._eventTriggers) do
			ClearEventTrigger = var_6

			var_6(iter_61_0)
		end

		arg_61_0._eventTriggers = nil
	end

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_61_0)

	return
end

return var_0_0
