local var_0_0 = class("DialogueStep", import(".StoryStep"))

var_0_0.SIDE_LEFT = 0
var_0_0.SIDE_RIGHT = 1
var_0_0.SIDE_MIDDLE = 2
var_0_0.ACTOR_TYPE_PLAYER = 0
var_0_0.ACTOR_TYPE_FLAGSHIP = -1
var_0_0.ACTOR_TYPE_TB = -2
var_0_0.PAINTING_ACTION_MOVE = "move"
var_0_0.PAINTING_ACTION_SHAKE = "shake"
var_0_0.PAINTING_ACTION_ZOOM = "zoom"
var_0_0.PAINTING_ACTION_ROTATE = "rotate"

local var_0_1 = pg.ship_skin_template

local function var_0_2(arg_1_0)
	local var_1_0 = string.lower(arg_1_0)

	if var_1_0 == "#a9f548" or var_1_0 == "#a9f548ff" then
		return "#5CE6FF"
	elseif var_1_0 == "#ff5c5c" then
		return "#FF9B93"
	elseif var_1_0 == "#ffa500" then
		return "#FFC960"
	elseif var_1_0 == "#ffff4d" then
		return "#FEF15E"
	elseif var_1_0 == "#696969" then
		return "#BDBDBD"
	elseif var_1_0 == "#a020f0" then
		return "#C3ABFF"
	elseif var_1_0 == "#ffffff" then
		return "#FFFFFF"
	else
		return arg_1_0
	end

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.actor = arg_2_1.actor
	arg_2_0.nameColor = arg_2_1.nameColor and var_0_2(arg_2_1.nameColor) or COLOR_WHITE
	arg_2_0.specialTbId = nil

	if arg_2_1.tbActor then
		arg_2_0.specialTbId = arg_2_0.actor
		arg_2_0.actor = var_0_0.ACTOR_TYPE_TB
	end

	arg_2_0.actorName = arg_2_1.actorName
	arg_2_0.subActorName = arg_2_1.factiontag
	arg_2_0.subActorNameColor = arg_2_1.factiontagColor or "#FFFFFF"
	arg_2_0.withoutActorName = arg_2_1.withoutActorName
	arg_2_0.say = arg_2_1.say
	arg_2_0.sayColor = arg_2_1.sayColor or COLOR_WHITE
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
	arg_2_0.fadeInPaintingTime = arg_2_1.fadeInPaintingTime or 0.15
	arg_2_0.fadeOutPaintingTime = arg_2_1.fadeOutPaintingTime or 0.15
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
		arg_2_0.disappearTime = arg_2_1.disappearTime or {
			0,
			0
		}
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
	arg_2_0.spinePos = arg_2_1.spinePos or {
		0,
		0,
		0
	}
	arg_2_0.spineOrderIndex = arg_2_1.spineOrderIndex
	arg_2_0.live2dOffset = arg_2_1.live2dOffset
	arg_2_0.contentBGAlpha = arg_2_1.dialogueBgAlpha or 1
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

	arg_2_0.paintRwIndex = arg_2_1.paintRwIndex or 0
	arg_2_0.action = arg_2_1.action or {}

	return
end

function var_0_0.GetSpinePosition(arg_3_0)
	return BuildVector3(arg_3_0.spinePos)
end

function var_0_0.GetL2dParams(arg_4_0)
	if not arg_4_0.live2dParams then
		return nil
	end

	return {
		name = arg_4_0.live2dParams[1],
		value = arg_4_0.live2dParams[2]
	}
end

function var_0_0.SetDefaultSide(arg_5_0)
	arg_5_0.side = defaultValue(arg_5_0.side, var_0_0.SIDE_LEFT)

	return
end

function var_0_0.GetBgName(arg_6_0)
	if arg_6_0.dynamicBgType and arg_6_0.dynamicBgType == var_0_0.ACTOR_TYPE_TB and getProxy(EducateProxy) and getProxy(NewEducateProxy) then
		if not pg.NewStoryMgr.GetInstance():IsReView() then
			local var_6_0 = ""

			if not getProxy(NewEducateProxy):GetCurChar() then
				local var_6_1, var_6_2, var_6_3 = getProxy(EducateProxy):GetStoryInfo()

				var_6_0 = var_6_3
			else
				local var_6_4, var_6_5, var_6_6 = getProxy(NewEducateProxy):GetStoryInfo()

				var_6_0 = var_6_6
			end

			do return (arg_6_0:Convert2StoryBg(var_6_0)) end

			goto label_6_0
		end
	end

	do return var_0_0.super.GetBgName(arg_6_0) end

	::label_6_0::

	return
end

function var_0_0.Convert2StoryBg(arg_7_0, arg_7_1)
	local var_7_0 = ({
		educate_tb_3 = "bg_project_tb_room3",
		educate_tb_2 = "bg_project_tb_room2",
		educate_tb_1 = "bg_project_tb_room1"
	})[arg_7_1]

	if not ({
		educate_tb_3 = "bg_project_tb_room3",
		educate_tb_2 = "bg_project_tb_room2",
		educate_tb_1 = "bg_project_tb_room1"
	})[arg_7_1] then
		var_7_0 = arg_7_1
	end

	return var_7_0
end

function var_0_0.GetPaintingRwIndex(arg_8_0)
	if not arg_8_0.glitchArt then
		return 0
	end

	if not arg_8_0.expression then
		return 0
	end

	return arg_8_0.paintRwIndex
end

function var_0_0.IsMiniPortrait(arg_9_0)
	return arg_9_0.miniPortrait
end

function var_0_0.ExistPortrait(arg_10_0)
	return arg_10_0.portrait ~= nil
end

function var_0_0.GetPortrait(arg_11_0)
	if type(arg_11_0.portrait) == "number" then
		return pg.ship_skin_template[arg_11_0.portrait].painting
	elseif type(arg_11_0.portrait) == "string" then
		return arg_11_0.portrait
	else
		return nil
	end

	return
end

function var_0_0.ShouldHideDialogue(arg_12_0)
	return arg_12_0.hideDialogFragment
end

function var_0_0.ShouldGlitchArtForPortrait(arg_13_0)
	return arg_13_0.glitchArtForPortrait
end

function var_0_0.GetMode(arg_14_0)
	return Story.MODE_DIALOGUE
end

function var_0_0.GetContentBGAlpha(arg_15_0)
	return arg_15_0.contentBGAlpha
end

function var_0_0.GetSpineExPression(arg_16_0)
	if arg_16_0.expression then
		return arg_16_0.expression
	end

	return
end

function var_0_0.GetExPression(arg_17_0)
	if arg_17_0.expression then
		return arg_17_0.expression
	else
		local var_17_0 = arg_17_0:GetPainting()

		if var_17_0 and ShipExpressionHelper.DefaultFaceless(var_17_0) then
			return ShipExpressionHelper.GetDefaultFace(var_17_0)
		end
	end

	return
end

function var_0_0.ShouldAddHeadMaskWhenFade(arg_18_0)
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

function var_0_0.ShouldGrayingPainting(arg_19_0, arg_19_1)
	return arg_19_1:GetPainting() ~= nil and not arg_19_0:IsSameSide(arg_19_1)
end

function var_0_0.ShouldGrayingOutPainting(arg_20_0, arg_20_1)
	return arg_20_0:GetPainting() ~= nil and not arg_20_0:IsSameSide(arg_20_1)
end

function var_0_0.ShouldFadeInPainting(arg_21_0)
	if not arg_21_0:GetPainting() then
		return false
	end

	if arg_21_0:IsLive2dPainting() or arg_21_0:IsSpinePainting() then
		return false
	end

	local var_21_0 = arg_21_0:GetFadeInPaintingTime()

	if not var_21_0 or var_21_0 <= 0 then
		return false
	end

	return true
end

function var_0_0.GetTypewriter(arg_22_0)
	return arg_22_0.typewriter
end

function var_0_0.ShouldFaceBlack(arg_23_0)
	return arg_23_0.actorShadow
end

function var_0_0.GetPaintingData(arg_24_0)
	local var_24_0 = arg_24_0.painting or {}
	local var_24_1 = {}

	var_24_1.alpha = var_24_0.alpha or 0.3
	var_24_1.time = var_24_0.time or 1

	return var_24_1
end

function var_0_0.GetFadeInPaintingTime(arg_25_0)
	return arg_25_0.fadeInPaintingTime
end

function var_0_0.GetFadeOutPaintingTime(arg_26_0)
	return arg_26_0.fadeOutPaintingTime
end

function var_0_0.GetPaintingDir(arg_27_0)
	local var_27_0 = arg_27_0.paingtingScale or 1
	local var_27_1 = arg_27_0.dir or 1

	return var_27_1 * var_27_0
end

function var_0_0.ShouldFlipPaintingY(arg_28_0)
	return arg_28_0.paingtingYFlip ~= nil
end

function var_0_0.GetTag(arg_29_0)
	if arg_29_0.glitchArt == true then
		return 2
	else
		return 1
	end

	return
end

function var_0_0.GetPaintingAlpha(arg_30_0)
	return arg_30_0.actorAlpha
end

function var_0_0.GetPaitingOffst(arg_31_0)
	return arg_31_0.actorPosition
end

function var_0_0.GetSound(arg_32_0)
	return arg_32_0.sound
end

function var_0_0.GetPaintingActions(arg_33_0)
	return arg_33_0.action
end

function var_0_0.GetPaintingMoveToSide(arg_34_0)
	return arg_34_0.moveSideData
end

function var_0_0.ShouldMoveToSide(arg_35_0)
	return arg_35_0.moveSideData ~= nil
end

function var_0_0.GetPaintingAction(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs((arg_36_0:GetPaintingActions())) do
		if iter_36_1.type == arg_36_1 then
			table.insert({}, iter_36_1)
		end
	end

	return {}
end

function var_0_0.GetSide(arg_37_0)
	return arg_37_0.side
end

function var_0_0.GetContent(arg_38_0)
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

	if arg_38_0:ShouldReplaceCar2026() then
		var_38_0 = arg_38_0:ReplaceCar2026Name(var_38_0)
	end

	var_38_0 = PLATFORM_CODE ~= PLATFORM_US and SwitchSpecialChar(HXSet.hxLan(var_38_0), true) or HXSet.hxLan(var_38_0)

	return var_38_0
end

function var_0_0.GetContentColor(arg_39_0)
	return arg_39_0.sayColor or COLOR_WHITE
end

function var_0_0.GetNameWithColor(arg_40_0)
	local var_40_0 = arg_40_0:GetName()

	if not var_40_0 then
		return nil
	end

	return setColorStr(var_40_0, (arg_40_0:GetNameColor()))
end

function var_0_0.GetNameColor(arg_41_0)
	return arg_41_0.nameColor or COLOR_WHITE
end

function var_0_0.GetNameColorCode(arg_42_0)
	return string.gsub(arg_42_0:GetNameColor(), "#", "")
end

function var_0_0.GetCustomActorName(arg_43_0)
	if type(arg_43_0.actorName) == "number" and arg_43_0.actorName == 0 and getProxy(PlayerProxy) then
		return getProxy(PlayerProxy):getRawData().name
	elseif type(arg_43_0.actorName) == "number" then
		return ShipGroup.getDefaultShipNameByGroupID(arg_43_0.actorName)
	elseif type(arg_43_0.actorName) == "string" then
		return arg_43_0.actorName
	else
		return ""
	end

	return
end

function var_0_0.GetPortraitName(arg_44_0)
	if not arg_44_0:ExistPortrait() then
		return ""
	end

	if type(arg_44_0.portrait) ~= "number" then
		return ""
	end

	local var_44_0 = var_0_1[arg_44_0.portrait]

	if not var_0_1[arg_44_0.portrait] then
		return ""
	end

	local var_44_2 = ShipGroup.getDefaultShipConfig(var_44_0.ship_group)

	return not var_44_2 and var_44_0.name or Ship.getShipName(var_44_2.id)
end

function var_0_0.GetName(arg_45_0)
	local var_45_0 = arg_45_0.actorName and arg_45_0:GetCustomActorName() or arg_45_0:GetPaintingAndName() or ""

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

	return (HXSet.hxLan(var_45_0))
end

function var_0_0.GetPainting(arg_46_0)
	local var_46_0, var_46_1 = arg_46_0:GetPaintingAndName()

	return var_46_1
end

function var_0_0.ExistPainting(arg_47_0)
	return arg_47_0:GetPainting() ~= nil
end

function var_0_0.ShouldShakeDailogue(arg_48_0)
	return arg_48_0.dialogShake ~= nil
end

function var_0_0.GetShakeDailogueData(arg_49_0)
	return arg_49_0.dialogShake
end

function var_0_0.IsSameSide(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:GetPrevSide(arg_50_1)
	local var_50_1 = arg_50_0:GetSide()

	return var_50_0 ~= nil and var_50_1 ~= nil and var_50_0 == var_50_1
end

function var_0_0.GetPrevSide(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1:GetSide()

	if arg_51_0.moveSideData then
		var_51_0 = arg_51_0.moveSideData.side
	end

	return var_51_0
end

function var_0_0.GetPaintingIcon(arg_52_0)
	local var_52_0 = arg_52_0.actor == var_0_0.ACTOR_TYPE_FLAGSHIP and getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character):getPrefab() or (arg_52_0.actor ~= var_0_0.ACTOR_TYPE_PLAYER or nil) and (arg_52_0.actor ~= var_0_0.ACTOR_TYPE_TB or nil) and (arg_52_0.actor or nil) and (not arg_52_0.hideRecordIco or nil) and var_0_1[arg_52_0.actor].prefab

	if var_52_0 == nil and arg_52_0:ExistPortrait() and not arg_52_0.hideRecordIco then
		var_52_0 = arg_52_0:GetPortrait()
	end

	return var_52_0
end

function var_0_0.GetPaintingAndName(arg_53_0)
	local var_53_0
	local var_53_1

	if not UnGamePlayState and arg_53_0.actor == var_0_0.ACTOR_TYPE_FLAGSHIP then
		local var_53_2 = getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character)

		var_53_0 = var_53_2:getName()
		var_53_1 = var_53_2:getPainting()

		goto label_53_0
	end

	if not UnGamePlayState and arg_53_0.actor == var_0_0.ACTOR_TYPE_PLAYER then
		var_53_0 = getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().name or ""

		goto label_53_0
	end

	if not UnGamePlayState and arg_53_0.actor == var_0_0.ACTOR_TYPE_TB then
		if pg.NewStoryMgr.GetInstance():IsReView() then
			local var_53_3 = arg_53_0.defaultTb and arg_53_0.defaultTb > 0

			assert(var_53_3, "<<< defaultTb is nil >>>")

			var_53_0 = pg.secretary_special_ship[arg_53_0.defaultTb].name or ""
			var_53_1 = pg.secretary_special_ship[arg_53_0.defaultTb].prefab
		elseif arg_53_0.specialTbId then
			assert(pg.secretary_special_ship[arg_53_0.specialTbId])

			var_53_0 = pg.secretary_special_ship[arg_53_0.specialTbId].name or ""
			var_53_1 = pg.secretary_special_ship[arg_53_0.specialTbId].prefab
		else
			if getProxy(NewEducateProxy) then
				if getProxy(NewEducateProxy):GetCurChar() then
					var_53_1, var_53_0 = getProxy(NewEducateProxy):GetStoryInfo()

					goto label_53_0
				end
			end

			if EducateProxy and getProxy(EducateProxy) then
				var_53_1, var_53_0 = getProxy(EducateProxy):GetStoryInfo()
			else
				var_53_0 = ""
			end
		end

		goto label_53_0
	end

	::label_53_0::

	if arg_53_0.actor then
		if var_0_1[arg_53_0.actor] == nil then
			var_53_1 = nil
			var_53_0 = nil
		else
			local var_53_4 = var_0_1[arg_53_0.actor]
			local var_53_5 = ShipGroup.getDefaultShipConfig(var_0_1[arg_53_0.actor].ship_group)

			var_53_0 = not var_53_5 and var_53_4.name or Ship.getShipName(var_53_5.id)
			var_53_1 = var_53_4.painting
		end

		return HXSet.hxLan(var_53_0), var_53_1
	end
end

function var_0_0.GetShipSkinId(arg_54_0)
	if arg_54_0.actor == var_0_0.ACTOR_TYPE_FLAGSHIP then
		return getProxy(BayProxy):GetShipPhantom(getProxy(PlayerProxy):getRawData():GetFlagShipPhantomMark()):getSkinId()
	elseif arg_54_0.actor == var_0_0.ACTOR_TYPE_PLAYER then
		return nil
	elseif not arg_54_0.actor then
		return nil
	else
		return arg_54_0.actor
	end

	return
end

function var_0_0.IsShowNPainting(arg_55_0)
	return arg_55_0.showNPainting
end

function var_0_0.IsShowWJZPainting(arg_56_0)
	return arg_56_0.showWJZPainting
end

function var_0_0.ShouldGrayPainting(arg_57_0)
	return arg_57_0.paingtingGray
end

function var_0_0.ShouldAddGlitchArtEffect(arg_58_0)
	return arg_58_0.glitchArt
end

function var_0_0.HideOtherPainting(arg_59_0)
	return arg_59_0.hideOtherPainting
end

function var_0_0.GetSubPaintings(arg_60_0)
	local var_60_0 = arg_60_0.subPaintings or {}

	return _.map(var_60_0, function(arg_61_0)
		assert(pg.ship_skin_template[arg_61_0.actor])

		;({
			actor = arg_61_0.actor,
			name = pg.ship_skin_template[arg_61_0.actor].painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}).dir = arg_61_0.dir or 1
		;({
			actor = arg_61_0.actor,
			name = pg.ship_skin_template[arg_61_0.actor].painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}).paintingNoise = arg_61_0.paintingNoise or false
		;({
			actor = arg_61_0.actor,
			name = pg.ship_skin_template[arg_61_0.actor].painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}).showNPainting = arg_61_0.hidePaintObj or false

		return {
			actor = arg_61_0.actor,
			name = pg.ship_skin_template[arg_61_0.actor].painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}
	end)
end

function var_0_0.NeedDispppearSubPainting(arg_62_0)
	return #arg_62_0.disappearSeq > 0
end

function var_0_0.GetDisappearSeq(arg_63_0)
	return arg_63_0.disappearSeq
end

function var_0_0.GetDisappearTime(arg_64_0)
	return arg_64_0.disappearTime[1], arg_64_0.disappearTime[2]
end

function var_0_0.IsNoHeadPainting(arg_65_0)
	return arg_65_0.nohead
end

function var_0_0.GetFontSize(arg_66_0)
	return arg_66_0.fontSize
end

function var_0_0.IsSpinePainting(arg_67_0)
	local var_67_0

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		do return false end

		var_67_0 = tobool
	end

	return var_67_0(arg_67_0:GetPainting() ~= nil and arg_67_0.spine)
end

function var_0_0.IsHideSpineBg(arg_68_0)
	return arg_68_0.spine == 1
end

function var_0_0.GetSpineOrderIndex(arg_69_0)
	if arg_69_0:IsSpinePainting() then
		return arg_69_0.spineOrderIndex
	else
		return nil
	end

	return
end

function var_0_0.IsLive2dPainting(arg_70_0)
	local var_70_0

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		do return false end

		var_70_0 = tobool
	end

	return var_70_0(arg_70_0:GetPainting() ~= nil and arg_70_0.live2d)
end

function var_0_0.GetLive2dPos(arg_71_0)
	if arg_71_0.live2dOffset then
		return Vector3(arg_71_0.live2dOffset[1], arg_71_0.live2dOffset[2], arg_71_0.live2dOffset[3])
	end

	return
end

function var_0_0.GetVirtualShip(arg_72_0)
	local var_72_0 = arg_72_0:GetShipSkinId()

	return StoryShip.New({
		skin_id = var_72_0
	})
end

function var_0_0.GetLive2dAction(arg_73_0)
	if type(arg_73_0.live2d) == "string" then
		if pg.character_voice[arg_73_0.live2d] then
			return pg.character_voice[arg_73_0.live2d].l2d_action
		end

		return arg_73_0.live2d
	else
		return nil
	end

	return
end

function var_0_0.GetL2dIdleIndex(arg_74_0)
	return arg_74_0.live2dIdleIndex
end

function var_0_0.GetSubActorName(arg_75_0)
	if arg_75_0.subActorName and arg_75_0.subActorName ~= "" then
		return " " .. setColorStr(HXSet.hxLan(arg_75_0.subActorName), arg_75_0.subActorNameColor)
	else
		return ""
	end

	return
end

function var_0_0.IsSamePainting(arg_76_0, arg_76_1)
	return (function()
		return arg_76_0:GetPainting() == arg_76_1:GetPainting() and arg_76_0:IsShowNPainting() == arg_76_1:IsShowNPainting() and arg_76_0:IsShowWJZPainting() == arg_76_1:IsShowWJZPainting()
	end)() and arg_76_0:IsLive2dPainting() == arg_76_1:IsLive2dPainting() and arg_76_0:IsSpinePainting() == arg_76_1:IsSpinePainting() and not var_76_0()
end

function var_0_0.ExistCanMarkNode(arg_79_0)
	if arg_79_0.canMarkNode ~= nil and type(arg_79_0.canMarkNode) == "table" then
		local var_79_0 = arg_79_0.canMarkNode[1]

		if arg_79_0.canMarkNode[1] then
			if arg_79_0.canMarkNode[1] ~= "" then
				var_79_0 = arg_79_0.canMarkNode[2] and type(arg_79_0.canMarkNode[2]) == "table"

				return var_79_0
			end
		end
	end
end

function var_0_0.GetCanMarkNodeData(arg_80_0)
	local var_80_0 = arg_80_0.canMarkNode[2] or {}

	for iter_80_0, iter_80_1 in ipairs(var_80_0) do
		table.insert({}, iter_80_1 .. "")
	end

	return {
		name = arg_80_0.canMarkNode[1],
		marks = {}
	}
end

function var_0_0.OnClear(arg_81_0)
	return
end

function var_0_0.GetUsingPaintingNames(arg_82_0)
	local var_82_0 = arg_82_0:GetPainting()

	if var_82_0 ~= nil then
		table.insert({}, var_82_0)
	end

	for iter_82_0, iter_82_1 in ipairs((arg_82_0:GetSubPaintings())) do
		table.insert({}, iter_82_1.name)
	end

	return {}
end

return var_0_0
