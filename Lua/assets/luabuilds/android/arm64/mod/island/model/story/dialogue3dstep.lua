local var_0_0 = class("Dialogue3DStep", import(".IslandBaseStep"))

var_0_0.PLAY_MODE_DIALOGUE = 0
var_0_0.PLAY_MODE_SCENE_TIMELINE = 1
var_0_0.PLAY_MODE_TIMELINE = 2
var_0_0.OPTION_TYPE_TEXT = 0
var_0_0.OPTION_TYPE_PAGE = 1
var_0_0.OPTION_TYPE_TASK = 2
var_0_0.OPTION_TYPE_EXIT = 3
var_0_0.STYLE_DIALOGUE = 1
var_0_0.STYLE_ASIDE = 2
var_0_0.STYLE_EXIT_GROUP = 3
var_0_0.STYLE_JOIN_GROUP = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.subName = arg_1_1.subName or arg_1_1.factiontag or ""
	arg_1_0.timeline = arg_1_1.timeline
	arg_1_0.sceneTimeline = arg_1_1.scene_timeline
	arg_1_0.camera = arg_1_1.camera
	arg_1_0.cameraBlend = arg_1_1.camera_blend
	arg_1_0.cameraFade = arg_1_1.camera_fade
	arg_1_0.dialogShake = arg_1_1.dialogShake
	arg_1_0.cameraShake = arg_1_1.camera_shake
	arg_1_0.face2Face = {}

	local var_1_0 = arg_1_1.face2Face or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = iter_1_1[1]
		local var_1_2 = iter_1_1[2] or 0

		assert(var_1_1 ~= var_1_2, "face2Face配置错误，两个角色id不能相同")
		table.insert(arg_1_0.face2Face, {
			arg_1_0:GenUnitData(arg_1_0.script:GetUnitIdFromCharaId(var_1_1), IslandConst.UNIT_LIST_OBJ),
			(arg_1_0:GenUnitData(arg_1_0.script:GetUnitIdFromCharaId(var_1_2), IslandConst.UNIT_LIST_OBJ))
		})
	end

	arg_1_0.turntoList = {}

	local var_1_3 = arg_1_1.turnto or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_3) do
		local var_1_4 = iter_1_3[1]
		local var_1_5 = iter_1_3[2] or 0

		assert(var_1_4 ~= var_1_5, "turnto配置错误，两个角色id不能相同")
		table.insert(arg_1_0.turntoList, {
			arg_1_0:GenUnitData(arg_1_0.script:GetUnitIdFromCharaId(var_1_4), IslandConst.UNIT_LIST_OBJ),
			(arg_1_0:GenUnitData(arg_1_0.script:GetUnitIdFromCharaId(var_1_5), IslandConst.UNIT_LIST_OBJ))
		})
	end

	arg_1_0.typewriter = arg_1_1.typewriter
	arg_1_0.branchCode = arg_1_1.optionFlag
	arg_1_0.optionList = {}

	local var_1_6 = arg_1_1.options or {}

	for iter_1_4, iter_1_5 in ipairs(var_1_6) do
		table.insert(arg_1_0.optionList, (arg_1_0:GenOption(iter_1_5)))
	end

	arg_1_0.style = arg_1_1.style or var_0_0.STYLE_DIALOGUE
	arg_1_0.sequences = arg_1_1.sequence
	arg_1_0.navData = arg_1_1

	return
end

function var_0_0.GetNavData(arg_2_0)
	if arg_2_0.style == var_0_0.STYLE_EXIT_GROUP or arg_2_0.style == var_0_0.STYLE_JOIN_GROUP then
		return {
			object = arg_2_0.script:GetUnitIdFromCharaId(arg_2_0.navData.characterId),
			position = arg_2_0.navData.position,
			speed = arg_2_0.navData.speed,
			delay = arg_2_0.navData.delay,
			hide = arg_2_0.navData.hide,
			waitUntilDone = arg_2_0.navData.wait_until_done,
			index = arg_2_0.navData.index
		}
	end

	return nil
end

function var_0_0.GetNavObject(arg_3_0)
	if arg_3_0.style ~= var_0_0.STYLE_EXIT_GROUP then
		if arg_3_0.style == var_0_0.STYLE_JOIN_GROUP then
			({}).id = arg_3_0.script:GetUnitIdFromCharaId(arg_3_0.navData.characterId)
			;({}).type = IslandConst.UNIT_LIST_OBJ

			return (arg_3_0.script:GetRole({}))
		end

		return nil
	end
end

function var_0_0.GetAsideSequences(arg_4_0)
	if arg_4_0.style == var_0_0.STYLE_ASIDE then
		local var_4_0 = arg_4_0.sequences or {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			table.insert({}, {
				text = iter_4_1[1],
				delay = iter_4_1[2]
			})
		end

		return {}
	end

	return nil
end

function var_0_0.GetStyle(arg_5_0)
	return arg_5_0.style
end

function var_0_0.IsTimeline(arg_6_0)
	local var_6_0 = arg_6_0:GetPlayMode()

	return var_6_0 == Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE or var_6_0 == Dialogue3DStep.PLAY_MODE_TIMELINE
end

function var_0_0.ShouldCameraShake(arg_7_0)
	return arg_7_0.cameraShake ~= nil
end

function var_0_0.GetCameraShakeSrc(arg_8_0)
	return arg_8_0.cameraShake
end

function var_0_0.ShouldShakeDailogue(arg_9_0)
	return arg_9_0.dialogShake ~= nil
end

function var_0_0.GetShakeDailogueData(arg_10_0)
	return arg_10_0.dialogShake
end

function var_0_0.GenOption(arg_11_0, arg_11_1)
	if arg_11_1.mission then
		return {
			icon = "icon_task",
			content = arg_11_1.content,
			type = var_0_0.OPTION_TYPE_TASK,
			param = arg_11_1.mission
		}
	elseif arg_11_1.page then
		return {
			icon = "icon_shop",
			content = arg_11_1.content,
			type = var_0_0.OPTION_TYPE_PAGE,
			param = arg_11_1.page
		}
	elseif arg_11_1.exit then
		return {
			icon = "icon_exit",
			content = arg_11_1.content,
			type = var_0_0.OPTION_TYPE_EXIT
		}
	else
		return {
			icon = "icon_dialogue",
			content = arg_11_1.content,
			type = var_0_0.OPTION_TYPE_TEXT,
			param = arg_11_1.flag
		}
	end

	return
end

function var_0_0.GetFace2FaceList(arg_12_0)
	return arg_12_0.face2Face
end

function var_0_0.GetTurntoList(arg_13_0)
	return arg_13_0.turntoList
end

function var_0_0.IsSameBranch(arg_14_0, arg_14_1)
	return not arg_14_0.branchCode or arg_14_0.branchCode == arg_14_1
end

function var_0_0.ExistOption(arg_15_0)
	return #arg_15_0.optionList > 0
end

function var_0_0.GetOptionList(arg_16_0)
	return arg_16_0.optionList
end

function var_0_0.CanSkip(arg_17_0)
	if arg_17_0:ExistOption() or arg_17_0.style == var_0_0.STYLE_EXIT_GROUP or arg_17_0.style == var_0_0.STYLE_JOIN_GROUP then
		return false
	end

	return true
end

function var_0_0.GetTypewriter(arg_18_0)
	return arg_18_0.typewriter
end

function var_0_0.GetName(arg_19_0)
	return arg_19_0:GetActorName()
end

function var_0_0.GetSubName(arg_20_0)
	if not arg_20_0.subName or arg_20_0.subName == "" then
		return ""
	end

	return "/" .. arg_20_0.subName
end

function var_0_0.GetPlayMode(arg_21_0)
	if arg_21_0.sceneTimeline and arg_21_0.sceneTimeline ~= "" then
		return var_0_0.PLAY_MODE_SCENE_TIMELINE
	elseif arg_21_0.timeline and arg_21_0.timeline ~= "" then
		return var_0_0.PLAY_MODE_TIMELINE
	else
		return var_0_0.PLAY_MODE_DIALOGUE
	end

	return
end

function var_0_0.GetTimelinePath(arg_22_0)
	return arg_22_0.timeline
end

function var_0_0.GetActiveCamera(arg_23_0)
	return arg_23_0.camera
end

function var_0_0.ShouldActiveCamera(arg_24_0)
	return arg_24_0.camera and arg_24_0.camera ~= ""
end

function var_0_0.GetSceneTimelinePath(arg_25_0)
	return arg_25_0.sceneTimeline
end

function var_0_0.GetCameraBlendName(arg_26_0)
	return arg_26_0.cameraBlend
end

function var_0_0.SholdBlendCamera(arg_27_0)
	if not arg_27_0.cameraBlend then
		return false
	end

	return true
end

function var_0_0.ShouldFadeCamera(arg_28_0)
	return arg_28_0.cameraFade
end

return var_0_0
