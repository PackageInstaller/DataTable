class = var_0_10000

local var_0_0 = "DialogueStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryStep"))

var_0_1.SIDE_LEFT = 0
var_0_1.SIDE_RIGHT = 1
var_0_1.SIDE_MIDDLE = 2
var_0_1.ACTOR_TYPE_PLAYER = 0
var_0_1.ACTOR_TYPE_FLAGSHIP = -1
var_0_1.ACTOR_TYPE_TB = -2
var_0_1.PAINTING_ACTION_MOVE = "move"
var_0_1.PAINTING_ACTION_SHAKE = "shake"
var_0_1.PAINTING_ACTION_ZOOM = "zoom"
var_0_1.PAINTING_ACTION_ROTATE = "rotate"
pg = var_1

local var_0_2 = var_1.ship_skin_template

local function var_0_3(arg_1_0)
	string = var_1_10001

	if var_1_10001.lower(arg_1_0) == "#a9f548" or var_1 == "#a9f548ff" then
		return "#5CE6FF"
	elseif var_1 == "#ff5c5c" then
		return "#FF9B93"
	elseif var_1 == "#ffa500" then
		return "#FFC960"
	elseif var_1 == "#ffff4d" then
		return "#FEF15E"
	elseif var_1 == "#696969" then
		return "#BDBDBD"
	elseif var_1 == "#a020f0" then
		return "#C3ABFF"
	elseif var_1 == "#ffffff" then
		return "#FFFFFF"
	else
		return arg_1_0
	end

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.actor = arg_2_1.actor

	if arg_2_1.nameColor then
		arg_2_0.nameColor = var_0_3(arg_2_1.nameColor)
	else
		COLOR_WHITE = var_2
		arg_2_0.nameColor = var_2
	end

	arg_2_0.specialTbId = nil

	if arg_2_1.tbActor then
		arg_2_0.specialTbId = arg_2_0.actor
		arg_2_0.actor = var_0_1.ACTOR_TYPE_TB
	end

	arg_2_0.actorName = arg_2_1.actorName
	arg_2_0.subActorName = arg_2_1.factiontag

	local var_2_0

	if not arg_2_1.factiontagColor then
		var_2_0 = "#FFFFFF"
	end

	arg_2_0.subActorNameColor = var_2_0
	arg_2_0.withoutActorName = arg_2_1.withoutActorName
	arg_2_0.say = arg_2_1.say

	if not arg_2_1.sayColor then
		COLOR_WHITE = var_2
	end

	arg_2_0.sayColor = var_2
	arg_2_0.dynamicBgType = arg_2_1.dynamicBgType
	arg_2_0.fontSize = arg_2_1.fontsize
	arg_2_0.side = arg_2_1.side
	arg_2_0.dir = arg_2_1.dir

	if arg_2_0.dir == 0 then
		arg_2_0.dir = 1
	end

	arg_2_0.expression = arg_2_1.expression
	arg_2_0.typewriter = arg_2_1.typewriter
	arg_2_0.painting = arg_2_1.painting

	local var_2_1

	if not arg_2_1.fadeInPaintingTime then
		var_2_1 = 0.15
	end

	arg_2_0.fadeInPaintingTime = var_2_1

	local var_2_2

	if not arg_2_1.fadeOutPaintingTime then
		var_2_2 = 0.15
	end

	arg_2_0.fadeOutPaintingTime = var_2_2
	arg_2_0.actorPosition = arg_2_1.actorPosition
	arg_2_0.dialogShake = arg_2_1.dialogShake
	arg_2_0.moveSideData = arg_2_1.paintingFadeOut
	arg_2_0.paingtingGray = arg_2_1.paingtingGray
	arg_2_0.glitchArt = arg_2_1.paintingNoise
	arg_2_0.hideOtherPainting = arg_2_1.hideOther
	arg_2_0.subPaintings = arg_2_1.subActors
	arg_2_0.disappearSeq = {}
	arg_2_0.disappearTime = {
		0,
		0
	}

	if arg_2_0.subPaintings and #arg_2_0.subPaintings > 0 and arg_2_1.disappearSeq then
		arg_2_0.disappearSeq = arg_2_1.disappearSeq

		local var_2_3

		if not arg_2_1.disappearTime then
			var_2_3 = {
				0,
				0
			}
		end

		arg_2_0.disappearTime = var_2_3
	end

	arg_2_0.hideRecordIco = arg_2_1.hideRecordIco
	arg_2_0.paingtingScale = arg_2_1.actorScale
	arg_2_0.paingtingYFlip = arg_2_1.actorYFlip
	arg_2_0.hidePainting = arg_2_1.withoutPainting
	arg_2_0.hidePaintingWithName = arg_2_1.hidePainting
	arg_2_0.actorShadow = arg_2_1.actorShadow
	arg_2_0.actorAlpha = arg_2_1.actorAlpha
	arg_2_0.showNPainting = arg_2_1.hidePaintObj
	arg_2_0.hasPaintbg = arg_2_1.hasPaintbg
	arg_2_0.showWJZPainting = arg_2_1.hidePaintEquip
	arg_2_0.hideDialogFragment = arg_2_1.hideDialogFragment
	arg_2_0.nohead = arg_2_1.nohead
	arg_2_0.live2d = arg_2_1.live2d
	arg_2_0.live2dIdleIndex = arg_2_1.live2dIdleIndex
	arg_2_0.live2dParams = arg_2_1.live2dParams
	arg_2_0.spine = arg_2_1.spine

	local var_2_4

	if not arg_2_1.spinePos then
		var_2_4 = {
			0,
			0,
			0
		}
	end

	arg_2_0.spinePos = var_2_4
	arg_2_0.spineOrderIndex = arg_2_1.spineOrderIndex
	arg_2_0.live2dOffset = arg_2_1.live2dOffset

	local var_2_5

	if not arg_2_1.dialogueBgAlpha then
		var_2_5 = 1
	end

	arg_2_0.contentBGAlpha = var_2_5
	arg_2_0.canMarkNode = arg_2_1.canMarkNode
	arg_2_0.portrait = arg_2_1.portrait
	arg_2_0.miniPortrait = false

	if arg_2_0.portrait and (arg_2_0.portrait == "zhihuiguan" or arg_2_0.portrait == "tongxunqi") then
		arg_2_0.miniPortrait = true
	end

	arg_2_0.glitchArtForPortrait = arg_2_1.portraitNoise

	if arg_2_0.hidePainting or arg_2_0.actor == nil then
		arg_2_0.actor = nil
		arg_2_0.hideOtherPainting = true
	end

	if arg_2_0.hidePaintingWithName or arg_2_0.actor == nil then
		if arg_2_0.actorName == nil then
			arg_2_0.actorName = arg_2_0:GetName()
		end

		arg_2_0.actor = nil
		arg_2_0.hideOtherPainting = true
	end

	local var_2_6

	if not arg_2_1.paintRwIndex then
		var_2_6 = 0
	end

	arg_2_0.paintRwIndex = var_2_6

	local var_2_7

	if not arg_2_1.action then
		var_2_7 = {}
	end

	arg_2_0.action = var_2_7

	return
end

function var_0_1.GetSpinePosition(arg_3_0)
	BuildVector3 = var_1_10001

	return var_1_10001(arg_3_0.spinePos)
end

function var_0_1.GetL2dParams(arg_4_0)
	if not arg_4_0.live2dParams then
		return nil
	end

	return {
		name = arg_4_0.live2dParams[1],
		value = arg_4_0.live2dParams[2]
	}
end

function var_0_1.SetDefaultSide(arg_5_0)
	defaultValue = var_1_10001
	arg_5_0.side = var_1_10001(arg_5_0.side, var_0_1.SIDE_LEFT)

	return
end

function var_0_1.GetBgName(arg_6_0)
	if arg_6_0.dynamicBgType and arg_6_0.dynamicBgType == var_0_1.ACTOR_TYPE_TB then
		getProxy = var_1
		EducateProxy = var_1_10003

		if var_1(var_1_10003) then
			getProxy = var_1
			NewEducateProxy = var_1_10003

			if var_1(var_1_10003) then
				pg = var_1

				local var_6_0 = var_1.NewStoryMgr.GetInstance()

				if not var_1.IsReView(var_6_0) then
					local var_6_1 = ""

					getProxy = var_2
					NewEducateProxy = var_1_10004

					local var_6_2 = var_2(var_1_10004)
					local var_6_3

					if not var_2.GetCurChar(var_6_2) then
						getProxy = var_6_3
						EducateProxy = var_6_2
						var_6_2 = var_6_3(var_6_2)

						local var_6_4

						var_6_3, var_6_4, var_6_2 = var_6_3.GetStoryInfo(var_6_2)
						var_6_1 = var_6_2
					else
						getProxy = var_6_3
						NewEducateProxy = var_6_2

						local var_6_5 = var_6_3(var_6_2)
						local var_6_6, var_6_7, var_6_8 = var_2.GetStoryInfo(var_6_5)

						var_6_1 = var_6_8
					end

					do return (arg_6_0:Convert2StoryBg(var_6_1)) end

					goto label_6_0
				end
			end
		end
	end

	do return var_0_1.super.GetBgName(arg_6_0) end

	::label_6_0::

	return
end

function var_0_1.Convert2StoryBg(arg_7_0, arg_7_1)
	local var_7_0

	if not ({
		educate_tb_3 = "bg_project_tb_room3",
		educate_tb_2 = "bg_project_tb_room2",
		educate_tb_1 = "bg_project_tb_room1"
	})[arg_7_1] then
		var_7_0 = arg_7_1
	end

	return var_7_0
end

function var_0_1.GetPaintingRwIndex(arg_8_0)
	if not arg_8_0.glitchArt then
		return 0
	end

	if not arg_8_0.expression then
		return 0
	end

	return arg_8_0.paintRwIndex
end

function var_0_1.IsMiniPortrait(arg_9_0)
	return arg_9_0.miniPortrait
end

function var_0_1.ExistPortrait(arg_10_0)
	return arg_10_0.portrait ~= nil
end

function var_0_1.GetPortrait(arg_11_0)
	type = var_1_10001

	if var_1_10001(arg_11_0.portrait) == "number" then
		pg = var_1

		return var_1.ship_skin_template[arg_11_0.portrait].painting
	else
		type = var_1

		if var_1(arg_11_0.portrait) == "string" then
			return arg_11_0.portrait
		else
			return nil
		end
	end

	return
end

function var_0_1.ShouldHideDialogue(arg_12_0)
	return arg_12_0.hideDialogFragment
end

function var_0_1.ShouldGlitchArtForPortrait(arg_13_0)
	return arg_13_0.glitchArtForPortrait
end

function var_0_1.GetMode(arg_14_0)
	Story = var_1_10001

	return var_1_10001.MODE_DIALOGUE
end

function var_0_1.GetContentBGAlpha(arg_15_0)
	return arg_15_0.contentBGAlpha
end

function var_0_1.GetSpineExPression(arg_16_0)
	if arg_16_0.expression then
		return arg_16_0.expression
	end

	return
end

function var_0_1.GetExPression(arg_17_0)
	if arg_17_0.expression then
		return arg_17_0.expression
	elseif arg_17_0:GetPainting() then
		ShipExpressionHelper = var_1_10002

		if var_1_10002.DefaultFaceless(var_1) then
			ShipExpressionHelper = var_2

			return var_2.GetDefaultFace(var_1)
		end
	end

	return
end

function var_0_1.ShouldAddHeadMaskWhenFade(arg_18_0)
	if arg_18_0:ShouldAddGlitchArtEffect() then
		return false
	end

	if arg_18_0:IsNoHeadPainting() then
		return false
	end

	if not arg_18_0:GetExPression() then
		return false
	end

	return true
end

function var_0_1.ShouldGrayingPainting(arg_19_0, arg_19_1)
	return arg_19_1:GetPainting() ~= nil and not arg_19_0:IsSameSide(arg_19_1)
end

function var_0_1.ShouldGrayingOutPainting(arg_20_0, arg_20_1)
	return arg_20_0:GetPainting() ~= nil and not arg_20_0:IsSameSide(arg_20_1)
end

function var_0_1.ShouldFadeInPainting(arg_21_0)
	if not arg_21_0:GetPainting() then
		return false
	end

	if arg_21_0:IsLive2dPainting() or arg_21_0:IsSpinePainting() then
		return false
	end

	if not arg_21_0:GetFadeInPaintingTime() or var_1 <= 0 then
		return false
	end

	return true
end

function var_0_1.GetTypewriter(arg_22_0)
	return arg_22_0.typewriter
end

function var_0_1.ShouldFaceBlack(arg_23_0)
	return arg_23_0.actorShadow
end

function var_0_1.GetPaintingData(arg_24_0)
	local var_24_0

	if not arg_24_0.painting then
		var_24_0 = {}
	end

	local var_24_1 = {}
	local var_24_2

	if not var_24_0.alpha then
		var_24_2 = 0.3
	end

	var_24_1.alpha = var_24_2

	local var_24_3

	if not var_24_0.time then
		var_24_3 = 1
	end

	var_24_1.time = var_24_3

	return var_24_1
end

function var_0_1.GetFadeInPaintingTime(arg_25_0)
	return arg_25_0.fadeInPaintingTime
end

function var_0_1.GetFadeOutPaintingTime(arg_26_0)
	return arg_26_0.fadeOutPaintingTime
end

function var_0_1.GetPaintingDir(arg_27_0)
	local var_27_0

	if not arg_27_0.paingtingScale then
		var_27_0 = 1
	end

	local var_27_1

	if not arg_27_0.dir then
		var_27_1 = 1
	end

	return var_27_1 * var_27_0
end

function var_0_1.ShouldFlipPaintingY(arg_28_0)
	return arg_28_0.paingtingYFlip ~= nil
end

function var_0_1.GetTag(arg_29_0)
	if arg_29_0.glitchArt == true then
		return 2
	else
		return 1
	end

	return
end

function var_0_1.GetPaintingAlpha(arg_30_0)
	return arg_30_0.actorAlpha
end

function var_0_1.GetPaitingOffst(arg_31_0)
	return arg_31_0.actorPosition
end

function var_0_1.GetSound(arg_32_0)
	return arg_32_0.sound
end

function var_0_1.GetPaintingActions(arg_33_0)
	return arg_33_0.action
end

function var_0_1.GetPaintingMoveToSide(arg_34_0)
	return arg_34_0.moveSideData
end

function var_0_1.ShouldMoveToSide(arg_35_0)
	return arg_35_0.moveSideData ~= nil
end

function var_0_1.GetPaintingAction(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1 = arg_36_0:GetPaintingActions()

	ipairs = var_1_10004

	for iter_36_0, iter_36_1 in var_1_10004(var_36_1) do
		if iter_36_1.type == arg_36_1 then
			table = var_9

			var_9.insert(var_36_0, iter_36_1)
		end
	end

	return var_36_0
end

function var_0_1.GetSide(arg_37_0)
	return arg_37_0.side
end

function var_0_1.GetContent(arg_38_0)
	if not arg_38_0.say then
		return "..."
	end

	local var_38_0 = arg_38_0.say

	if arg_38_0:ShouldReplacePlayer() then
		var_38_0 = arg_38_0:ReplacePlayerName(var_38_0)
	end

	if arg_38_0:ShouldReplaceTb() then
		var_38_0 = arg_38_0:ReplaceTbName(var_38_0)
	end

	if arg_38_0:ShouldReplaceDorm() then
		var_38_0 = arg_38_0:ReplaceDormName(var_38_0)
	end

	local var_38_1 = arg_38_0

	if arg_38_0.ShouldReplaceCar2026(var_38_1) then
		var_38_1 = arg_38_0
		var_38_0 = arg_38_0.ReplaceCar2026Name(var_38_1, var_38_0)
	end

	PLATFORM_CODE = var_2
	PLATFORM_US = var_1_10003

	if var_2 ~= var_1_10003 then
		SwitchSpecialChar = var_2
		HXSet = var_38_1
		var_38_0 = var_2(var_38_1.hxLan(var_38_0), true)
	else
		HXSet = var_2
		var_38_0 = var_2.hxLan(var_38_0)
	end

	return var_38_0
end

function var_0_1.GetContentColor(arg_39_0)
	if not arg_39_0.sayColor then
		COLOR_WHITE = var_1
	end

	return var_1
end

function var_0_1.GetNameWithColor(arg_40_0)
	local var_40_0 = arg_40_0

	if not arg_40_0.GetName(var_40_0) then
		return nil
	end

	local var_40_1 = arg_40_0:GetNameColor()

	setColorStr = var_40_0

	return var_40_0(var_1, var_40_1)
end

function var_0_1.GetNameColor(arg_41_0)
	if not arg_41_0.nameColor then
		COLOR_WHITE = var_1
	end

	return var_1
end

function var_0_1.GetNameColorCode(arg_42_0)
	local var_42_0 = arg_42_0:GetNameColor()

	string = var_1_10002

	return var_1_10002.gsub(var_42_0, "#", "")
end

function var_0_1.GetCustomActorName(arg_43_0)
	type = var_1_10001

	if var_1_10001(arg_43_0.actorName) == "number" and arg_43_0.actorName == 0 then
		getProxy = var_1
		PlayerProxy = var_3

		if var_1(var_3) then
			getProxy = var_1
			PlayerProxy = var_3

			local var_43_0 = var_1(var_3)

			do return var_1.getRawData(var_43_0).name end

			goto label_43_0
		end
	end

	type = var_1

	if var_1(arg_43_0.actorName) == "number" then
		ShipGroup = var_1

		return var_1.getDefaultShipNameByGroupID(arg_43_0.actorName)
	else
		type = var_1

		if var_1(arg_43_0.actorName) == "string" then
			return arg_43_0.actorName
		else
			return ""
		end
	end

	::label_43_0::

	return
end

function var_0_1.GetPortraitName(arg_44_0)
	if not arg_44_0:ExistPortrait() then
		return ""
	end

	type = var_1

	if var_1(arg_44_0.portrait) ~= "number" then
		return ""
	end

	if not var_0_2[arg_44_0.portrait] then
		return ""
	end

	local var_44_0 = ""
	local var_44_1 = var_1.ship_group

	ShipGroup = var_1_10004

	if not var_1_10004.getDefaultShipConfig(var_44_1) then
		var_44_0 = var_1.name
	else
		Ship = var_1_10005
		var_44_0 = var_1_10005.getShipName(var_4.id)
	end

	return var_44_0
end

function var_0_1.GetName(arg_45_0)
	local var_45_0

	if (not arg_45_0.actorName or not arg_45_0:GetCustomActorName()) and not arg_45_0:GetPaintingAndName() then
		var_45_0 = ""
	end

	if not var_45_0 or var_45_0 == "" then
		var_45_0 = arg_45_0:GetPortraitName()
	end

	if not var_45_0 or var_45_0 == "" or arg_45_0.withoutActorName then
		return nil
	end

	if arg_45_0:ShouldReplacePlayer() then
		var_45_0 = arg_45_0:ReplacePlayerName(var_45_0)
	end

	if arg_45_0:ShouldReplaceTb() then
		var_45_0 = arg_45_0:ReplaceTbName(var_45_0)
	end

	if arg_45_0:ShouldReplaceCar2026() then
		var_45_0 = arg_45_0:ReplaceCar2026Name(var_45_0)
	end

	HXSet = var_2

	return (var_2.hxLan(var_45_0))
end

function var_0_1.GetPainting(arg_46_0)
	local var_46_0, var_46_1 = arg_46_0:GetPaintingAndName()

	return var_46_1
end

function var_0_1.ExistPainting(arg_47_0)
	return arg_47_0:GetPainting() ~= nil
end

function var_0_1.ShouldShakeDailogue(arg_48_0)
	return arg_48_0.dialogShake ~= nil
end

function var_0_1.GetShakeDailogueData(arg_49_0)
	return arg_49_0.dialogShake
end

function var_0_1.IsSameSide(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:GetPrevSide(arg_50_1)
	local var_50_1 = arg_50_0:GetSide()

	return var_50_0 ~= nil and var_50_1 ~= nil and var_50_0 == var_50_1
end

function var_0_1.GetPrevSide(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1:GetSide()

	if arg_51_0.moveSideData then
		var_51_0 = arg_51_0.moveSideData.side
	end

	return var_51_0
end

function var_0_1.GetPaintingIcon(arg_52_0)
	local var_52_0

	if arg_52_0.actor == var_0_1.ACTOR_TYPE_FLAGSHIP then
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_52_1 = var_2(var_1_10004)
		local var_52_2 = var_2.getRawData(var_52_1).character

		getProxy = var_3
		BayProxy = var_1_10005

		local var_52_3 = var_3(var_1_10005)
		local var_52_4 = var_3.getShipById(var_52_3, var_52_2)

		var_52_0 = var_3.getPrefab(var_52_4)
	else
		var_52_0 = (arg_52_0.actor ~= var_0_1.ACTOR_TYPE_PLAYER or nil) and (arg_52_0.actor ~= var_0_1.ACTOR_TYPE_TB or nil) and (arg_52_0.actor or nil) and (not arg_52_0.hideRecordIco or nil) and var_0_2[arg_52_0.actor].prefab
	end

	if var_52_0 == nil and arg_52_0:ExistPortrait() and not arg_52_0.hideRecordIco then
		var_52_0 = arg_52_0:GetPortrait()
	end

	return var_52_0
end

function var_0_1.GetPaintingAndName(arg_53_0)
	local var_53_0
	local var_53_1

	UnGamePlayState = var_1_10003

	if not var_1_10003 and arg_53_0.actor == var_0_1.ACTOR_TYPE_FLAGSHIP then
		getProxy = var_1_10003
		PlayerProxy = var_1_10005
		var_1_10005 = var_1_10003(var_1_10005)
		var_1_10003 = var_1_10003.getRawData(var_1_10005).character
		getProxy = var_4
		BayProxy = var_1_10006
		var_1_10006 = var_4(var_1_10006)

		local var_53_2 = var_4.getShipById(var_1_10006, var_1_10003)

		var_53_0 = var_4.getName(var_53_2)
		var_53_1 = var_4:getPainting()
	else
		UnGamePlayState = var_1_10003

		if not var_1_10003 and arg_53_0.actor == var_0_1.ACTOR_TYPE_PLAYER then
			getProxy = var_1_10003
			PlayerProxy = var_1_10005

			if var_1_10003(var_1_10005) then
				getProxy = var_1_10003
				PlayerProxy = var_1_10005
				var_1_10005 = var_1_10003(var_1_10005)
				var_53_0 = var_1_10003.getRawData(var_1_10005).name
			else
				var_53_0 = ""
			end
		else
			UnGamePlayState = var_1_10003

			if not var_1_10003 and arg_53_0.actor == var_0_1.ACTOR_TYPE_TB then
				pg = var_1_10003
				var_1_10005 = var_1_10003.NewStoryMgr.GetInstance()

				if var_1_10003.IsReView(var_1_10005) then
					assert = var_1_10003

					if arg_53_0.defaultTb then
						var_1_10005 = arg_53_0.defaultTb
						var_1_10005 = 0 < var_1_10005
					end

					var_1_10003(var_1_10005, "<<< defaultTb is nil >>>")

					pg = var_1_10003
					var_53_0 = var_1_10003.secretary_special_ship[arg_53_0.defaultTb].name or ""
					var_53_1 = var_1_10003.prefab
				elseif arg_53_0.specialTbId then
					pg = var_1_10003
					var_1_10003 = var_1_10003.secretary_special_ship[arg_53_0.specialTbId]
					assert = var_4

					var_4(var_1_10003)

					var_53_0 = var_1_10003.name or ""
					var_53_1 = var_1_10003.prefab
				else
					getProxy = var_1_10003
					NewEducateProxy = var_1_10005

					if var_1_10003(var_1_10005) then
						getProxy = var_1_10003
						NewEducateProxy = var_1_10005
						var_1_10005 = var_1_10003(var_1_10005)

						if var_1_10003.GetCurChar(var_1_10005) then
							getProxy = var_1_10003
							NewEducateProxy = var_1_10005
							var_1_10005 = var_1_10003(var_1_10005)

							local var_53_3

							var_1_10003, var_53_3 = var_1_10003.GetStoryInfo(var_1_10005)
							var_53_0 = var_53_3
							var_53_1 = var_1_10003

							goto label_53_0
						end
					end

					EducateProxy = var_1_10003

					if var_1_10003 then
						getProxy = var_1_10003
						EducateProxy = var_1_10005

						if var_1_10003(var_1_10005) then
							getProxy = var_1_10003
							EducateProxy = var_1_10005
							var_1_10005 = var_1_10003(var_1_10005)

							local var_53_4

							var_1_10003, var_53_4 = var_1_10003.GetStoryInfo(var_1_10005)
							var_53_0 = var_53_4
							var_53_1 = var_1_10003

							goto label_53_0
						end
					end

					var_53_0 = ""
				end
			elseif not arg_53_0.actor or var_0_2[arg_53_0.actor] == nil then
				var_1_10003 = nil
				var_53_1 = nil
				var_53_0 = var_1_10003
			else
				local var_53_5 = var_0_2[arg_53_0.actor].ship_group

				ShipGroup = var_1_10005

				if not var_1_10005.getDefaultShipConfig(var_53_5) then
					var_53_0 = var_1_10003.name
				else
					Ship = var_1_10006
					var_53_0 = var_1_10006.getShipName(var_5.id)
				end

				var_53_1 = var_1_10003.painting
			end
		end
	end

	::label_53_0::

	HXSet = var_1_10003

	return var_1_10003.hxLan(var_53_0), var_53_1
end

function var_0_1.GetShipSkinId(arg_54_0)
	if arg_54_0.actor == var_0_1.ACTOR_TYPE_FLAGSHIP then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_54_0 = var_1(var_1_10003)
		local var_54_1 = var_1.getRawData(var_54_0)

		getProxy = var_2
		BayProxy = var_1_10004

		local var_54_2 = var_2(var_1_10004)
		local var_54_3 = var_2.GetShipPhantom(var_54_2, var_54_1:GetFlagShipPhantomMark())

		return var_2.getSkinId(var_54_3)
	elseif arg_54_0.actor == var_0_1.ACTOR_TYPE_PLAYER then
		return nil
	elseif not arg_54_0.actor then
		return nil
	else
		return arg_54_0.actor
	end

	return
end

function var_0_1.IsShowNPainting(arg_55_0)
	return arg_55_0.showNPainting
end

function var_0_1.IsShowWJZPainting(arg_56_0)
	return arg_56_0.showWJZPainting
end

function var_0_1.ShouldGrayPainting(arg_57_0)
	return arg_57_0.paingtingGray
end

function var_0_1.ShouldAddGlitchArtEffect(arg_58_0)
	return arg_58_0.glitchArt
end

function var_0_1.HideOtherPainting(arg_59_0)
	return arg_59_0.hideOtherPainting
end

function var_0_1.GetSubPaintings(arg_60_0)
	_ = var_1_10001

	local var_60_0 = var_1_10001.map
	local var_60_1

	if not arg_60_0.subPaintings then
		var_60_1 = {}
	end

	return var_60_0(var_60_1, function(arg_61_0)
		pg = var_2_10001

		local var_61_0 = var_2_10001.ship_skin_template[arg_61_0.actor]

		assert = var_2

		var_2(var_61_0)

		local var_61_1 = {
			actor = arg_61_0.actor,
			name = var_61_0.painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}
		local var_61_2

		if not arg_61_0.dir then
			var_61_2 = 1
		end

		var_61_1.dir = var_61_2

		local var_61_3

		if not arg_61_0.paintingNoise then
			var_61_3 = false
		end

		var_61_1.paintingNoise = var_61_3

		local var_61_4

		if not arg_61_0.hidePaintObj then
			var_61_4 = false
		end

		var_61_1.showNPainting = var_61_4

		return var_61_1
	end)
end

function var_0_1.NeedDispppearSubPainting(arg_62_0)
	return #arg_62_0.disappearSeq > 0
end

function var_0_1.GetDisappearSeq(arg_63_0)
	return arg_63_0.disappearSeq
end

function var_0_1.GetDisappearTime(arg_64_0)
	return arg_64_0.disappearTime[1], arg_64_0.disappearTime[2]
end

function var_0_1.IsNoHeadPainting(arg_65_0)
	return arg_65_0.nohead
end

function var_0_1.GetFontSize(arg_66_0)
	return arg_66_0.fontSize
end

function var_0_1.IsSpinePainting(arg_67_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		HXSet = var_1_10001

		if var_1_10001.isHx() then
			return false
		end
	end

	local var_67_0 = arg_67_0:GetPainting()

	tobool = var_1_10002

	return var_1_10002(var_67_0 ~= nil and arg_67_0.spine)
end

function var_0_1.IsHideSpineBg(arg_68_0)
	return arg_68_0.spine == 1
end

function var_0_1.GetSpineOrderIndex(arg_69_0)
	if arg_69_0:IsSpinePainting() then
		return arg_69_0.spineOrderIndex
	else
		return nil
	end

	return
end

function var_0_1.IsLive2dPainting(arg_70_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		HXSet = var_1_10001

		if var_1_10001.isHx() then
			return false
		end
	end

	local var_70_0 = arg_70_0:GetPainting()

	tobool = var_1_10002

	return var_1_10002(var_70_0 ~= nil and arg_70_0.live2d)
end

function var_0_1.GetLive2dPos(arg_71_0)
	if arg_71_0.live2dOffset then
		Vector3 = var_1

		return var_1(arg_71_0.live2dOffset[1], arg_71_0.live2dOffset[2], arg_71_0.live2dOffset[3])
	end

	return
end

function var_0_1.GetVirtualShip(arg_72_0)
	local var_72_0 = arg_72_0
	local var_72_1 = arg_72_0.GetShipSkinId(var_72_0)

	pg = var_1_10002

	local var_72_2 = var_1_10002.ship_skin_template[var_72_1].ship_group

	StoryShip = var_72_0

	return var_72_0.New({
		skin_id = var_72_1
	})
end

function var_0_1.GetLive2dAction(arg_73_0)
	type = var_1_10001

	if var_1_10001(arg_73_0.live2d) == "string" then
		pg = var_1

		if var_1.character_voice[arg_73_0.live2d] then
			return var_1.l2d_action
		end

		return arg_73_0.live2d
	else
		return nil
	end

	return
end

function var_0_1.GetL2dIdleIndex(arg_74_0)
	return arg_74_0.live2dIdleIndex
end

function var_0_1.GetSubActorName(arg_75_0)
	if arg_75_0.subActorName and arg_75_0.subActorName ~= "" then
		HXSet = var_1

		local var_75_0 = var_1.hxLan(arg_75_0.subActorName)
		local var_75_1 = " "

		setColorStr = var_3

		return var_75_1 .. var_3(var_75_0, arg_75_0.subActorNameColor)
	else
		return ""
	end

	return
end

function var_0_1.IsSamePainting(arg_76_0, arg_76_1)
	local function var_76_0()
		local var_77_0 = arg_76_1
		local var_77_2

		if not var_0.ShouldAddGlitchArtEffect(var_77_0) then
			local var_77_1 = arg_76_0

			var_77_2 = var_0.ShouldAddGlitchArtEffect(var_77_1)
		end

		return var_77_2
	end

	local var_76_1

	if (function()
		local var_78_0 = arg_76_0
		local var_78_1 = var_0.GetPainting(var_78_0)
		local var_78_2 = arg_76_1

		if var_78_1 == var_1.GetPainting(var_78_2) then
			local var_78_3 = arg_76_0
			local var_78_4 = var_0.IsShowNPainting(var_78_3)
			local var_78_5 = arg_76_1

			if var_78_4 == var_1.IsShowNPainting(var_78_5) then
				local var_78_6 = arg_76_0
				local var_78_7 = var_0.IsShowWJZPainting(var_78_6)
				local var_78_8 = arg_76_1
				local var_78_9

				if var_78_7 ~= var_1.IsShowWJZPainting(var_78_8) then
					var_78_9 = false
				else
					var_78_9 = true
				end

				return var_78_9
			end
		end
	end)() then
		var_76_1 = arg_76_0:IsLive2dPainting() == arg_76_1:IsLive2dPainting() and arg_76_0:IsSpinePainting() == arg_76_1:IsSpinePainting() and not var_76_0()
	end

	return var_76_1
end

function var_0_1.ExistCanMarkNode(arg_79_0)
	if arg_79_0.canMarkNode ~= nil then
		type = var_79_0

		if var_79_0(arg_79_0.canMarkNode) == "table" then
			if arg_79_0.canMarkNode[1] then
				if arg_79_0.canMarkNode[1] ~= "" then
					local var_79_0

					if arg_79_0.canMarkNode[2] then
						type = var_79_0

						if var_79_0(arg_79_0.canMarkNode[2]) ~= "table" then
							var_79_0 = false
						else
							var_79_0 = true
						end
					end

					return var_79_0
				end
			end
		end
	end
end

function var_0_1.GetCanMarkNodeData(arg_80_0)
	local var_80_0 = {}

	ipairs = var_1_10002

	local var_80_1

	if not arg_80_0.canMarkNode[2] then
		var_80_1 = {}
	end

	for iter_80_0, iter_80_1 in var_1_10002(var_80_1) do
		table = var_1_10007

		var_1_10007.insert(var_80_0, iter_80_1 .. "")
	end

	return {
		name = arg_80_0.canMarkNode[1],
		marks = var_80_0
	}
end

function var_0_1.OnClear(arg_81_0)
	return
end

function var_0_1.GetUsingPaintingNames(arg_82_0)
	local var_82_0 = {}
	local var_82_1 = arg_82_0

	if arg_82_0.GetPainting(var_82_1) ~= nil then
		table = var_1_10003

		var_1_10003.insert(var_82_0, var_2)
	end

	local var_82_2 = arg_82_0:GetSubPaintings()

	ipairs = var_82_1

	for iter_82_0, iter_82_1 in var_82_1(var_82_2) do
		local var_82_3 = iter_82_1.name

		table = var_1_10010

		var_1_10010.insert(var_82_0, var_82_3)
	end

	return var_82_0
end

return var_0_1
