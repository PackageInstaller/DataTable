class = var_0_10000

local var_0_0 = var_0_10000("StoryStep")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.flashout = arg_1_1.flashout
	arg_1_0.flashin = arg_1_1.flashin
	arg_1_0.bgName = arg_1_1.bgName
	arg_1_0.bgShadow = arg_1_1.bgShadow
	arg_1_0.blackBg = arg_1_1.blackBg

	local var_1_0

	if not arg_1_1.blackFg then
		var_1_0 = 0
	end

	arg_1_0.blackFg = var_1_0
	arg_1_0.bgGlitchArt = arg_1_1.bgNoise
	arg_1_0.oldPhoto = arg_1_1.oldPhoto
	arg_1_0.bgm = arg_1_1.bgm

	local var_1_1

	if not arg_1_1.bgmDelay then
		var_1_1 = 0
	end

	arg_1_0.bgmDelay = var_1_1

	local var_1_2

	if not arg_1_1.bgmVolume then
		var_1_2 = -1
	end

	arg_1_0.bgmVolume = var_1_2
	arg_1_0.stopbgm = arg_1_1.stopbgm

	local var_1_3

	if not arg_1_1.effects then
		var_1_3 = {}
	end

	arg_1_0.effects = var_1_3
	arg_1_0.blink = arg_1_1.flash
	arg_1_0.blinkWithColor = arg_1_1.flashN
	arg_1_0.soundeffect = arg_1_1.soundeffect

	local var_1_4

	if not arg_1_1.seDelay then
		var_1_4 = 0
	end

	arg_1_0.seDelay = var_1_4
	arg_1_0.voice = arg_1_1.voice

	local var_1_5

	if not arg_1_1.voiceDelay then
		var_1_5 = 0
	end

	arg_1_0.voiceDelay = var_1_5
	defaultValue = var_1_5
	arg_1_0.stopVoice = var_1_5(arg_1_1.stopVoice, false)
	arg_1_0.movableNode = arg_1_1.movableNode
	arg_1_0.options = arg_1_1.options
	arg_1_0.optionForceCenter = arg_1_1.option_force_center
	arg_1_0.important = arg_1_1.important
	arg_1_0.branchCode = arg_1_1.optionFlag
	arg_1_0.globalBranchCode = arg_1_1.globalOptionFlag
	arg_1_0.recallOption = arg_1_1.recallOption
	arg_1_0.nextScriptName = arg_1_1.jumpto

	local var_1_6

	if not arg_1_1.eventDelay then
		var_1_6 = 0
	end

	arg_1_0.eventDelay = var_1_6

	local var_1_7

	if not arg_1_1.bgColor then
		var_1_7 = {
			0,
			0,
			0
		}
	end

	arg_1_0.bgColor = var_1_7
	arg_1_0.location = arg_1_1.location
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.dispatcher = arg_1_1.dispatcher
	defaultValue = var_2
	arg_1_0.shakeTime = var_2(arg_1_1.shakeTime, 0)

	local var_1_8

	if not arg_1_1.code then
		var_1_8 = -1
	end

	arg_1_0.code = var_1_8
	defaultValue = var_1_8
	arg_1_0.autoShowOption = var_1_8(arg_1_1.autoShowOption, false)
	arg_1_0.selectedBranchCode = 0
	arg_1_0.id = 0
	arg_1_0.placeholderType = 0
	arg_1_0.defaultTb = arg_1_1.defaultTb
	arg_1_0.optionIndex = 0

	return
end

function var_0_0.IsValid(arg_2_0, arg_2_1)
	if arg_2_0.code == -1 then
		return true
	end

	type = var_2

	if var_2(arg_2_0.code) ~= "string" then
		type = var_2_0

		local var_2_0

		if var_2_0(arg_2_0.code) == "number" then
			var_2_0 = arg_2_0.code == arg_2_1

			return var_2_0
		else
			type = var_2_0

			if var_2_0(arg_2_0.code) == "table" then
				table = var_2

				return var_2.contains(arg_2_0.code, arg_2_1)
			end
		end

		return false
	end
end

function var_0_0.ShouldShake(arg_3_0)
	return arg_3_0.shakeTime > 0
end

function var_0_0.GetShakeTime(arg_4_0)
	return arg_4_0.shakeTime
end

function var_0_0.SetDefaultTb(arg_5_0, arg_5_1)
	if not arg_5_0.defaultTb or arg_5_0.defaultTb <= 0 then
		arg_5_0.defaultTb = arg_5_1
	end

	return
end

function var_0_0.SetPlaceholderType(arg_6_0, arg_6_1)
	arg_6_0.placeholderType = arg_6_1

	return
end

function var_0_0.ShouldReplacePlayer(arg_7_0)
	bit = var_1_10001

	local var_7_0 = var_1_10001.band
	local var_7_1 = arg_7_0.placeholderType

	Story = var_1_10003

	return var_7_0(var_7_1, var_1_10003.PLAYER) > 0
end

function var_0_0.ShouldReplaceTb(arg_8_0)
	bit = var_1_10001

	local var_8_0 = var_1_10001.band
	local var_8_1 = arg_8_0.placeholderType

	Story = var_1_10003

	return var_8_0(var_8_1, var_1_10003.TB) > 0
end

function var_0_0.ShouldReplaceDorm(arg_9_0)
	bit = var_1_10001

	local var_9_0 = var_1_10001.band
	local var_9_1 = arg_9_0.placeholderType

	Story = var_1_10003

	return var_9_0(var_9_1, var_1_10003.DORM) > 0
end

function var_0_0.ShouldReplaceCar2026(arg_10_0)
	bit = var_1_10001

	local var_10_0 = var_1_10001.band
	local var_10_1 = arg_10_0.placeholderType

	Story = var_1_10003

	return var_10_0(var_10_1, var_1_10003.CAR2026) > 0
end

function var_0_0.ReplacePlayerName(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	if var_1_10002(var_1_10003) then
		getProxy = var_2
		PlayerProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)

		if not var_2.getRawData(var_1_10003) then
			return arg_11_1
		end

		getProxy = var_2
		PlayerProxy = var_1_10003

		local var_11_0 = var_2(var_1_10003)
		local var_11_1 = var_2.getRawData(var_11_0)
		local var_11_2 = var_2.GetName(var_11_1)

		string = var_11_1

		return (var_11_1.gsub(arg_11_1, "{playername}", var_11_2))
	end
end

function var_0_0.ReplaceTbName(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.NewStoryMgr.GetInstance()
	local var_12_1

	if var_2.IsReView(var_12_0) then
		string = var_12_1
		var_12_1 = var_12_1.gsub
		var_12_0 = arg_12_1
		var_1_10004 = "{tb}"
		i18n = var_1_10005

		return var_12_1(var_12_0, var_1_10004, var_1_10005("child_story_name"))
	end

	getProxy = var_12_1
	EducateProxy = var_12_0

	if var_12_1(var_12_0) then
		getProxy = var_2
		NewEducateProxy = var_12_0

		if not var_2(var_12_0) then
			return arg_12_1
		end

		getProxy = var_2
		NewEducateProxy = var_12_0

		local var_12_2 = var_2(var_12_0)
		local var_12_3

		if not var_2.GetCurChar(var_12_2) then
			getProxy = var_12_3
			EducateProxy = var_12_2
			var_12_2 = var_12_3(var_12_2)
			var_12_3, var_12_2 = var_12_3.GetStoryInfo(var_12_2)
			string = var_1_10004
			arg_12_1 = var_1_10004.gsub(arg_12_1, "{tb}", var_12_2)
		else
			getProxy = var_12_3
			NewEducateProxy = var_12_2

			local var_12_4 = var_12_3(var_12_2)
			local var_12_5, var_12_6 = var_2.GetStoryInfo(var_12_4)

			string = var_1_10004
			arg_12_1 = var_1_10004.gsub(arg_12_1, "{tb}", var_12_6)
		end

		return arg_12_1
	end
end

function var_0_0.ReplaceDormName(arg_13_0, arg_13_1)
	if not arg_13_0.actorName then
		return arg_13_1
	end

	getProxy = var_2
	ApartmentProxy = var_1_10003

	local var_13_0 = var_2(var_1_10003)

	if var_2.getApartment(var_13_0, arg_13_0.actorName) then
		local var_13_1 = var_2
		local var_13_2

		if not var_2.GetCallName(var_13_1) then
			var_13_2 = arg_13_0.actorName
		end

		string = var_13_1

		return (var_13_1.gsub(arg_13_1, "{dorm3d}", var_13_2))
	end
end

function var_0_0.ReplaceCar2026Name(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)
	local var_14_1 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_14_2 = var_14_1(var_14_0, var_1_10005.ACTIVITY_TYPE_MONOPOLY)
	local var_14_3 = ""

	getProxy = var_5
	PlayerProxy = var_1_10006

	if var_5(var_1_10006) then
		getProxy = var_14_6
		PlayerProxy = var_1_10006

		local var_14_4 = var_14_6(var_1_10006)
		local var_14_5 = var_14_6.getRawData(var_14_4)

		var_14_3 = var_14_6.GetName(var_14_5)
	end

	local var_14_6

	if var_14_2 then
		var_14_6 = var_14_2:getConfig("config_client").link_act

		if var_2:RawGetActivityById(var_14_6) and not var_6:isEnd() then
			var_14_3 = var_6.str_data1
		end
	end

	string = var_14_6

	return var_14_6.gsub(arg_14_1, "{car2026}", var_14_3)
end

function var_0_0.ExistDispatcher(arg_15_0)
	return arg_15_0.dispatcher ~= nil
end

function var_0_0.GetDispatcher(arg_16_0)
	return arg_16_0.dispatcher
end

function var_0_0.IsRecallDispatcher(arg_17_0)
	if not arg_17_0:ExistDispatcher() then
		return false
	end

	return arg_17_0:GetDispatcher().callbackData ~= nil and var_1.callbackData.name ~= nil
end

function var_0_0.GetDispatcherRecallName(arg_18_0)
	if not arg_18_0:IsRecallDispatcher() then
		return nil
	end

	return arg_18_0:GetDispatcher().callbackData.name
end

function var_0_0.ShouldHideUI(arg_19_0)
	if not arg_19_0:IsRecallDispatcher() then
		return false
	end

	return arg_19_0:GetDispatcher().callbackData.hideUI == true
end

function var_0_0.ExistIcon(arg_20_0)
	return arg_20_0.icon ~= nil
end

function var_0_0.GetIconData(arg_21_0)
	return arg_21_0.icon
end

function var_0_0.SetId(arg_22_0, arg_22_1)
	arg_22_0.id = arg_22_1

	return
end

function var_0_0.GetId(arg_23_0)
	return arg_23_0.id
end

function var_0_0.AutoShowOption(arg_24_0)
	arg_24_0.autoShowOption = true

	return
end

function var_0_0.SkipEventForOption(arg_25_0)
	local var_25_0

	if arg_25_0:ExistOption() then
		var_25_0 = arg_25_0.autoShowOption
	end

	return var_25_0
end

function var_0_0.IsRecallOption(arg_26_0)
	if arg_26_0:ExistOption() and arg_26_0:GetOptionCnt() > 1 and arg_26_0.recallOption then
		return true
	end

	return false
end

function var_0_0.IsOptionForceCenter(arg_27_0)
	return arg_27_0.optionForceCenter
end

function var_0_0.SetBranchCode(arg_28_0, arg_28_1)
	arg_28_0.selectedBranchCode = arg_28_1

	return
end

function var_0_0.GetSelectedBranchCode(arg_29_0)
	return arg_29_0.selectedBranchCode
end

function var_0_0.ExistLocation(arg_30_0)
	return arg_30_0.location ~= nil
end

function var_0_0.GetLocation(arg_31_0)
	local var_31_0 = {}
	local var_31_1

	if not arg_31_0.location[1] then
		var_31_1 = ""
	end

	var_31_0.text = var_31_1

	local var_31_2

	if not arg_31_0.location[2] then
		var_31_2 = 999
	end

	var_31_0.time = var_31_2

	return var_31_0
end

function var_0_0.ExistMovableNode(arg_32_0)
	if arg_32_0.movableNode ~= nil then
		type = var_1

		local var_32_0

		if var_1(arg_32_0.movableNode) ~= "table" or not (#arg_32_0.movableNode > 0) then
			var_32_0 = false
		else
			var_32_0 = true
		end

		return var_32_0
	end
end

function var_0_0.GetPathByString(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	pg = var_1_10004

	local var_33_1 = var_1_10004.NewStoryMgr.GetInstance()
	local var_33_2 = var_4.GetRectSize(var_33_1)

	Vector3 = var_33_1

	local var_33_3 = var_33_1(-var_33_2.x * 0.5, var_33_2.y * 0.5, 0)

	Vector3 = var_6

	local var_33_4 = var_6(var_33_2.x * 0.5, var_33_2.y * 0.5, 0)

	Vector3 = var_7

	local var_33_5 = var_7(-var_33_2.x * 0.5, -var_33_2.y * 0.5, 0)

	Vector3 = var_8

	local var_33_6 = var_8(var_33_2.x * 0.5, -var_33_2.y * 0.5, 0)
	local var_33_7 = arg_33_2 or 200
	local var_33_8

	if arg_33_1 == "LTLB" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(var_33_7, 0, 0)
		var_33_0 = {
			var_33_3 + var_33_8,
			var_33_5 + var_33_8
		}
	elseif arg_33_1 == "LBLT" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(var_33_7, 0, 0)
		var_33_0 = {
			var_33_5 + var_33_8,
			var_33_3 + var_33_8
		}
	elseif arg_33_1 == "LTRT" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(0, -var_33_7, 0)
		var_33_0 = {
			var_33_3 + var_33_8,
			var_33_4 + var_33_8
		}
	elseif arg_33_1 == "RTLT" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(0, -var_33_7, 0)
		var_33_0 = {
			var_33_4 + var_33_8,
			var_33_3 + var_33_8
		}
	elseif arg_33_1 == "RTRB" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(var_33_7, 0, 0)
		var_33_0 = {
			var_33_4 + var_33_8,
			var_33_6 + var_33_8
		}
	elseif arg_33_1 == "RBRT" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(var_33_7, 0, 0)
		var_33_0 = {
			var_33_6 + var_33_8,
			var_33_4 + var_33_8
		}
	elseif arg_33_1 == "LBRB" then
		Vector3 = var_33_8
		var_33_8 = var_33_8(0, -(arg_33_2 or 0), 0)
		var_33_0 = {
			var_33_5 + var_33_8,
			var_33_6 + var_33_8
		}
	elseif arg_33_1 == "RBLB" then
		Vector3 = var_33_8

		local var_33_9 = var_33_8(0, -(arg_33_2 or 0), 0)

		var_33_0 = {
			var_33_6 + var_33_9,
			var_33_5 + var_33_9
		}
	end

	return var_33_0
end

function var_0_0.GenMoveNode(arg_34_0, arg_34_1)
	local var_34_0 = {}

	type = var_1_10003

	if var_1_10003(arg_34_1.path) == "table" then
		ipairs = var_3

		for iter_34_0, iter_34_1 in var_3(arg_34_1.path) do
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_34_1 = var_34_0

			Vector3 = var_1_10010

			var_1_10008(var_34_1, var_1_10010(iter_34_1[1], iter_34_1[2], 0))
		end
	else
		type = var_3

		if var_3(arg_34_1.path) == "string" then
			var_34_0 = arg_34_0:GetPathByString(arg_34_1.path, arg_34_1.offset)
		else
			var_34_0 = arg_34_0:GetPathByString("LTRT")
		end
	end

	type = var_3

	local var_34_2 = var_3(arg_34_1.spine) == "table" or arg_34_1.spine == true
	local var_34_3

	if arg_34_1.spine == true then
		var_34_3 = {
			action = "walk",
			scale = 0.5
		}
	elseif var_34_2 then
		local var_34_4 = {}
		local var_34_5

		if not arg_34_1.spine.action then
			var_34_5 = "walk"
		end

		var_34_4.action = var_34_5

		local var_34_6

		if not arg_34_1.spine.scale then
			var_34_6 = 0.5
		end

		var_34_4.scale = var_34_6
		var_34_3 = var_34_4
	end

	local var_34_7 = {
		name = arg_34_1.name,
		isSpine = var_34_2,
		spineData = var_34_3,
		path = var_34_0,
		time = arg_34_1.time
	}
	local var_34_8

	if not arg_34_1.delay then
		var_34_8 = 0
	end

	var_34_7.delay = var_34_8

	local var_34_9

	if not arg_34_1.easeType then
		LeanTweenType = var_34_9
		var_34_9 = var_34_9.linear
	end

	var_34_7.easeType = var_34_9

	return var_34_7
end

function var_0_0.GetMovableNode(arg_35_0)
	local var_35_0 = arg_35_0

	if not arg_35_0.ExistMovableNode(var_35_0) then
		return {}
	end

	local var_35_1 = {}

	pairs = var_35_0

	local var_35_2

	if not arg_35_0.movableNode then
		var_35_2 = {}
	end

	for iter_35_0, iter_35_1 in var_35_0(var_35_2) do
		local var_35_3 = arg_35_0
		local var_35_4 = arg_35_0.GenMoveNode(var_35_3, iter_35_1)

		table = var_35_3

		var_35_3.insert(var_35_1, var_35_4)
	end

	return var_35_1
end

function var_0_0.OldPhotoEffect(arg_36_0)
	return arg_36_0.oldPhoto
end

function var_0_0.ShouldBgGlitchArt(arg_37_0)
	return arg_37_0.bgGlitchArt
end

function var_0_0.IsSameBranch(arg_38_0, arg_38_1)
	return not arg_38_0.branchCode or arg_38_0.branchCode == arg_38_1
end

function var_0_0.IsGlobalFlagHit(arg_39_0)
	local var_39_0 = var_0_0.GetGlobalFlagKey(arg_39_0.globalBranchCode.id)
	local var_39_1 = 1
	local var_39_2 = 0

	::label_39_0::

	PlayerPrefs = var_1_10004

	if var_1_10004.HasKey(var_39_0 .. var_39_1) then
		repeat
			PlayerPrefs = var_1_10004
			var_39_2 = var_39_2 + var_1_10004.GetInt(var_39_0 .. var_39_1)
			var_39_1 = var_39_1 + 1

			goto label_39_0
		until true
	end

	local var_39_3 = arg_39_0.globalBranchCode.section

	ipairs = var_5

	for iter_39_0, iter_39_1 in var_5(var_39_3) do
		if var_39_2 >= iter_39_1[1] and var_39_2 <= iter_39_1[2] then
			return true
		end
	end

	return false
end

function var_0_0.GetGlobalFlagKey(arg_40_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_40_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_40_0).id .. "GlobalStoryFlag_" .. arg_40_0 .. "_"
end

function var_0_0.GetMode(arg_41_0)
	assert = var_1_10001

	var_1_10001(false, "should override this function")

	return
end

function var_0_0.GetFlashoutData(arg_42_0)
	if arg_42_0.flashout then
		local var_42_0 = arg_42_0.flashout.alpha[1]
		local var_42_1 = arg_42_0.flashout.alpha[2]
		local var_42_2 = arg_42_0.flashout.dur
		local var_42_3 = arg_42_0.flashout.black

		return var_42_0, var_42_1, var_42_2, var_42_3
	end

	return
end

function var_0_0.GetFlashinData(arg_43_0)
	if arg_43_0.flashin then
		local var_43_0 = arg_43_0.flashin.alpha[1]
		local var_43_1 = arg_43_0.flashin.alpha[2]
		local var_43_2 = arg_43_0.flashin.dur
		local var_43_3 = arg_43_0.flashin.black
		local var_43_4 = arg_43_0.flashin.delay

		return var_43_0, var_43_1, var_43_2, var_43_3, var_43_4
	end

	return
end

function var_0_0.GetBgColor(arg_44_0)
	Color = var_1_10001

	local var_44_0 = var_1_10001.New
	local var_44_1

	if not arg_44_0.bgColor[1] then
		var_44_1 = 0
	end

	local var_44_2

	if not arg_44_0.bgColor[2] then
		var_44_2 = 0
	end

	local var_44_3

	if not arg_44_0.bgColor[3] then
		var_44_3 = 0
	end

	return var_44_0(var_44_1, var_44_2, var_44_3)
end

function var_0_0.IsBlackBg(arg_45_0)
	return arg_45_0.blackBg
end

function var_0_0.GetBgName(arg_46_0)
	return arg_46_0.bgName
end

function var_0_0.GetBgShadow(arg_47_0)
	return arg_47_0.bgShadow
end

function var_0_0.IsDialogueMode(arg_48_0)
	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.GetMode(var_48_0)

	Story = var_48_0

	return var_48_1 == var_48_0.MODE_DIALOGUE
end

function var_0_0.GetBgmData(arg_49_0)
	return arg_49_0.bgm, arg_49_0.bgmDelay, arg_49_0.bgmVolume
end

function var_0_0.ShoulePlayBgm(arg_50_0)
	return arg_50_0.bgm ~= nil
end

function var_0_0.ShouldStopBgm(arg_51_0)
	return arg_51_0.stopbgm
end

function var_0_0.GetEffects(arg_52_0)
	return arg_52_0.effects
end

function var_0_0.ShouldBlink(arg_53_0)
	return arg_53_0.blink ~= nil
end

function var_0_0.GetBlinkData(arg_54_0)
	return arg_54_0.blink
end

function var_0_0.ShouldBlinkWithColor(arg_55_0)
	return arg_55_0.blinkWithColor ~= nil
end

function var_0_0.GetBlinkWithColorData(arg_56_0)
	return arg_56_0.blinkWithColor
end

function var_0_0.ShouldPlaySoundEffect(arg_57_0)
	return arg_57_0.soundeffect ~= nil
end

function var_0_0.GetSoundeffect(arg_58_0)
	return arg_58_0.soundeffect, arg_58_0.seDelay
end

function var_0_0.ShouldPlayVoice(arg_59_0)
	return arg_59_0.voice ~= nil
end

function var_0_0.ShouldStopVoice(arg_60_0)
	return arg_60_0.stopVoice
end

function var_0_0.GetVoice(arg_61_0)
	return arg_61_0.voice, arg_61_0.voiceDelay
end

function var_0_0.ExistOption(arg_62_0)
	return arg_62_0.options ~= nil and #arg_62_0.options > 0
end

function var_0_0.GetOptionCnt(arg_63_0)
	if arg_63_0:ExistOption() then
		return #arg_63_0.options
	else
		return 0
	end

	return
end

function var_0_0.SetOptionSelCodes(arg_64_0, arg_64_1)
	arg_64_0.optionSelCode = arg_64_1

	return
end

function var_0_0.IsBlackFrontGround(arg_65_0)
	local var_65_0 = arg_65_0.blackFg
	local var_65_1

	var_65_1 = 0 < var_65_0
	Mathf = var_2

	local var_65_2 = var_2.Clamp01(arg_65_0.blackFg)
end

function var_0_0.GetOptionIndexByAutoSel(arg_66_0)
	local var_66_0 = 0
	local var_66_1 = 0

	ipairs = var_1_10003

	for iter_66_0, iter_66_1 in var_1_10003(arg_66_0.options) do
		if arg_66_0.optionSelCode and iter_66_1.flag == arg_66_0.optionSelCode then
			var_66_0 = iter_66_0

			break
		end

		if iter_66_1.autochoice and iter_66_1.autochoice == 1 then
			var_66_1 = iter_66_0
		end
	end

	if var_66_0 > 0 then
		return var_66_0
	end

	if var_66_1 > 0 then
		return var_66_1
	end

	return nil
end

function var_0_0.IsImport(arg_67_0)
	return arg_67_0.important
end

function var_0_0.SetOptionIndex(arg_68_0, arg_68_1)
	arg_68_0.optionIndex = arg_68_1

	return
end

function var_0_0.GetOptionIndex(arg_69_0)
	return arg_69_0.optionIndex
end

function var_0_0.GetOptions(arg_70_0)
	_ = var_1_10001

	local var_70_0 = var_1_10001.map
	local var_70_1

	if not arg_70_0.options then
		var_70_1 = {}
	end

	return var_70_0(var_70_1, function(arg_71_0)
		local var_71_0 = arg_71_0.content
		local var_71_1 = arg_70_0

		if var_2.ShouldReplacePlayer(var_71_1) then
			local var_71_2 = arg_70_0

			var_71_0 = var_2.ReplacePlayerName(var_71_2, var_71_0)
		end

		local var_71_3 = arg_70_0

		if var_2.ShouldReplaceTb(var_71_3) then
			local var_71_4 = arg_70_0

			var_71_0 = var_2.ReplaceTbName(var_71_4, var_71_0)
		end

		local var_71_5 = arg_70_0

		if var_2.ShouldReplaceDorm(var_71_5) then
			local var_71_6 = arg_70_0

			var_71_0 = var_2.ReplaceDormName(var_71_6, var_71_0)
		end

		local var_71_7 = arg_70_0

		if var_2.ShouldReplaceCar2026(var_71_7) then
			local var_71_8 = arg_70_0

			var_71_0 = var_2.ReplaceCar2026Name(var_71_8, var_71_0)
		end

		HXSet = var_2

		local var_71_9 = var_2.hxLan(var_71_0)

		return {
			var_71_9,
			arg_71_0.flag,
			arg_71_0.type,
			arg_71_0.globalFlag
		}
	end)
end

function var_0_0.ShouldJumpToNextScript(arg_72_0)
	return arg_72_0.nextScriptName ~= nil
end

function var_0_0.GetNextScriptName(arg_73_0)
	return arg_73_0.nextScriptName
end

function var_0_0.ShouldDelayEvent(arg_74_0)
	local var_74_0

	if arg_74_0.eventDelay then
		var_74_0 = arg_74_0.eventDelay > 0
	end

	return var_74_0
end

function var_0_0.GetEventDelayTime(arg_75_0)
	return arg_75_0.eventDelay
end

function var_0_0.GetUsingPaintingNames(arg_76_0)
	return {}
end

function var_0_0.GetResList(arg_77_0)
	local var_77_0 = {}
	local var_77_1 = arg_77_0

	if arg_77_0.GetBgName(var_77_1) then
		table = var_77_1

		var_77_1.insert(var_77_0, var_2)
	end

	if arg_77_0.GetSubBg then
		local var_77_2 = arg_77_0

		if arg_77_0.GetSubBg(var_77_2) then
			table = var_77_2

			var_77_2.insert(var_77_0, var_3)
		end
	end

	_ = var_3

	local var_77_3 = var_3.map(var_77_0, function(arg_78_0)
		return "bg/" .. arg_78_0
	end)
	local var_77_4 = {}
	local var_77_5, var_77_6, var_77_7 = arg_77_0:GetBgmData()

	if var_77_5 then
		table = var_1_10008

		var_1_10008.insert(var_77_4, var_77_5)
	end

	local var_77_8 = {}

	_ = var_1_10009

	var_1_10009.each(var_77_4, function(arg_79_0)
		table = var_2_10001

		var_2_10001.insert(var_77_8, "cue/" .. arg_79_0 .. ".b")

		table = var_1

		var_1.insert(var_77_8, "cue/bgm-" .. arg_79_0 .. ".b")

		return
	end)

	local var_77_9 = {}
	local var_77_10 = arg_77_0

	if arg_77_0.ShouldPlaySoundEffect(var_77_10) then
		var_77_10 = arg_77_0

		local var_77_11

		var_77_11, var_77_10 = arg_77_0.GetSoundeffect(var_77_10)

		if var_77_11 then
			table = var_1_10012

			var_1_10012.insert(var_77_9, var_77_11)
		end
	end

	local var_77_12 = {}

	_ = var_77_10

	var_77_10.each(var_77_9, function(arg_80_0)
		pg = var_2_10001

		local var_80_0 = var_2_10001.CriMgr.GetInstance()

		if var_1.CheckFModeEvent(var_80_0, arg_80_0, function()
			return
		end, function()
			return
		end) then
			table = var_80_0

			var_80_0.insert(var_77_12, "cue/" .. var_1 .. ".b")
		end

		return
	end)

	local var_77_13 = {}
	local var_77_14 = arg_77_0

	if arg_77_0.ShouldPlayVoice(var_77_14) then
		var_77_14 = arg_77_0

		local var_77_15

		var_77_15, var_77_14 = arg_77_0.GetVoice(var_77_14)

		if var_77_15 then
			table = var_1_10014

			var_1_10014.insert(var_77_13, var_77_15)
		end
	end

	local var_77_16 = {}

	_ = var_77_14

	var_77_14.each(var_77_13, function(arg_83_0)
		pg = var_2_10001

		local var_83_0 = var_2_10001.CriMgr.GetInstance()

		if var_1.CheckFModeEvent(var_83_0, arg_83_0, function()
			return
		end, function()
			return
		end) then
			table = var_83_0

			var_83_0.insert(var_77_16, "cue/" .. var_1 .. ".b")
		end

		return
	end)

	local var_77_17 = {}
	local var_77_18 = arg_77_0
	local var_77_19 = arg_77_0.GetEffects(var_77_18)

	_ = var_77_18

	var_77_18.each(var_77_19, function(arg_86_0)
		local var_86_0 = arg_86_0.name

		table = var_2_10002

		var_2_10002.insert(var_77_17, var_86_0)

		return
	end)

	local var_77_20 = {}

	_ = var_16

	var_16.each(var_77_17, function(arg_87_0)
		table = var_2_10001

		var_2_10001.insert(var_77_20, "ui/" .. arg_87_0)

		table = var_1

		var_1.insert(var_77_20, "effect/" .. arg_87_0)

		return
	end)

	local var_77_21 = {}
	local var_77_22 = arg_77_0

	if arg_77_0.ExistIcon(var_77_22) then
		var_77_22 = arg_77_0

		if arg_77_0.GetIconData(var_77_22) and var_17.image then
			table = var_77_22

			var_77_22.insert(var_77_21, var_17.image)
		end
	end

	local var_77_23 = {}

	StoryRecorder = var_77_22

	local var_77_24 = var_77_22.New()

	var_18.Add(var_77_24, arg_77_0)

	local var_77_25 = var_18
	local var_77_26 = var_18.GetContentList(var_77_25)

	_ = var_77_25

	var_77_25.each(var_77_26, function(arg_88_0)
		if arg_88_0.icon then
			local var_88_0 = "squareicon/" .. arg_88_0.icon

			table = var_2

			var_2.insert(var_77_23, var_88_0)
		end

		return
	end)

	SplitPackMediatorResMap = var_20

	return (var_20.MergeLuaArr(var_77_3, var_77_8, var_77_12, var_77_16, var_77_20, var_77_21, var_77_23))
end

return var_0_0
