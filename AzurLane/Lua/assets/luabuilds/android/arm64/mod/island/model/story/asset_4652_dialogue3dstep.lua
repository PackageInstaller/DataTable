class = var_0_10000

local var_0_0 = "Dialogue3DStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseStep"))

var_0_1.PLAY_MODE_DIALOGUE = 0
var_0_1.PLAY_MODE_SCENE_TIMELINE = 1
var_0_1.PLAY_MODE_TIMELINE = 2
var_0_1.OPTION_TYPE_TEXT = 0
var_0_1.OPTION_TYPE_PAGE = 1
var_0_1.OPTION_TYPE_TASK = 2
var_0_1.OPTION_TYPE_EXIT = 3
var_0_1.STYLE_DIALOGUE = 1
var_0_1.STYLE_ASIDE = 2
var_0_1.STYLE_EXIT_GROUP = 3
var_0_1.STYLE_JOIN_GROUP = 4

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0

	if not arg_1_1.subName and not arg_1_1.factiontag then
		var_1_0 = ""
	end

	arg_1_0.subName = var_1_0
	arg_1_0.timeline = arg_1_1.timeline
	arg_1_0.sceneTimeline = arg_1_1.scene_timeline
	arg_1_0.camera = arg_1_1.camera
	arg_1_0.cameraBlend = arg_1_1.camera_blend
	arg_1_0.cameraFade = arg_1_1.camera_fade
	arg_1_0.dialogShake = arg_1_1.dialogShake
	arg_1_0.cameraShake = arg_1_1.camera_shake
	arg_1_0.face2Face = {}
	ipairs = var_3

	local var_1_1

	if not arg_1_1.face2Face then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		local var_1_2 = iter_1_1[1]

		if not iter_1_1[2] then
			var_1_10009 = 0
		end

		assert = var_1_10010

		var_1_10010(var_1_2 ~= var_1_10009, "face2Face配置错误，两个角色id不能相同")

		local var_1_3 = arg_1_0.script

		var_1_10010 = var_1_10010.GetUnitIdFromCharaId(var_1_3, var_1_2)

		local var_1_4 = arg_1_0.script
		local var_1_5 = var_11.GetUnitIdFromCharaId(var_1_4, var_1_10009)
		local var_1_6 = arg_1_0
		local var_1_7 = arg_1_0.GenUnitData
		local var_1_8 = var_1_10010

		IslandConst = var_1_10016

		local var_1_9 = var_1_7(var_1_6, var_1_8, var_1_10016.UNIT_LIST_OBJ)
		local var_1_10 = arg_1_0
		local var_1_11 = arg_1_0.GenUnitData

		var_1_10016 = var_1_5
		IslandConst = var_1_10017

		local var_1_12 = var_1_11(var_1_10, var_1_10016, var_1_10017.UNIT_LIST_OBJ)

		table = var_1_6

		var_1_6.insert(arg_1_0.face2Face, {
			var_1_9,
			var_1_12
		})
	end

	arg_1_0.turntoList = {}
	ipairs = var_3

	local var_1_13

	if not arg_1_1.turnto then
		var_1_13 = {}
	end

	for iter_1_2, iter_1_3 in var_3(var_1_13) do
		local var_1_14 = iter_1_3[1]

		if not iter_1_3[2] then
			var_1_10009 = 0
		end

		assert = var_1_10010

		var_1_10010(var_1_14 ~= var_1_10009, "turnto配置错误，两个角色id不能相同")

		local var_1_15 = arg_1_0.script

		var_1_10010 = var_1_10010.GetUnitIdFromCharaId(var_1_15, var_1_14)

		local var_1_16 = arg_1_0.script
		local var_1_17 = var_11.GetUnitIdFromCharaId(var_1_16, var_1_10009)
		local var_1_18 = arg_1_0
		local var_1_19 = arg_1_0.GenUnitData
		local var_1_20 = var_1_10010

		IslandConst = var_1_10016

		local var_1_21 = var_1_19(var_1_18, var_1_20, var_1_10016.UNIT_LIST_OBJ)
		local var_1_22 = arg_1_0
		local var_1_23 = arg_1_0.GenUnitData

		var_1_10016 = var_1_17
		IslandConst = var_1_10017

		local var_1_24 = var_1_23(var_1_22, var_1_10016, var_1_10017.UNIT_LIST_OBJ)

		table = var_1_18

		var_1_18.insert(arg_1_0.turntoList, {
			var_1_21,
			var_1_24
		})
	end

	arg_1_0.typewriter = arg_1_1.typewriter
	arg_1_0.branchCode = arg_1_1.optionFlag
	arg_1_0.optionList = {}
	ipairs = var_3

	local var_1_25

	if not arg_1_1.options then
		var_1_25 = {}
	end

	for iter_1_4, iter_1_5 in var_3(var_1_25) do
		local var_1_26 = arg_1_0:GenOption(iter_1_5)

		table = var_1_10009

		var_1_10009.insert(arg_1_0.optionList, var_1_26)
	end

	local var_1_27

	if not arg_1_1.style then
		var_1_27 = var_0_1.STYLE_DIALOGUE
	end

	arg_1_0.style = var_1_27
	arg_1_0.sequences = arg_1_1.sequence
	arg_1_0.navData = arg_1_1

	return
end

function var_0_1.GetNavData(arg_2_0)
	if arg_2_0.style == var_0_1.STYLE_EXIT_GROUP or arg_2_0.style == var_0_1.STYLE_JOIN_GROUP then
		local var_2_0 = {}
		local var_2_1 = arg_2_0.script

		var_2_0.object = var_2.GetUnitIdFromCharaId(var_2_1, arg_2_0.navData.characterId)
		var_2_0.position = arg_2_0.navData.position
		var_2_0.speed = arg_2_0.navData.speed
		var_2_0.delay = arg_2_0.navData.delay
		var_2_0.hide = arg_2_0.navData.hide
		var_2_0.waitUntilDone = arg_2_0.navData.wait_until_done
		var_2_0.index = arg_2_0.navData.index

		return var_2_0
	end

	return nil
end

function var_0_1.GetNavObject(arg_3_0)
	if arg_3_0.style == var_0_1.STYLE_EXIT_GROUP or arg_3_0.style == var_0_1.STYLE_JOIN_GROUP then
		local var_3_0 = arg_3_0.script
		local var_3_1 = var_1.GetUnitIdFromCharaId(var_3_0, arg_3_0.navData.characterId)
		local var_3_2 = arg_3_0.script
		local var_3_3 = var_2.GetRole
		local var_3_4 = {
			id = var_3_1
		}

		IslandConst = var_1_10006
		var_3_4.type = var_1_10006.UNIT_LIST_OBJ

		return (var_3_3(var_3_2, var_3_4))
	end

	return nil
end

function var_0_1.GetAsideSequences(arg_4_0)
	if arg_4_0.style == var_0_1.STYLE_ASIDE then
		local var_4_0 = {}

		ipairs = var_2

		local var_4_1

		if not arg_4_0.sequences then
			var_4_1 = {}
		end

		for iter_4_0, iter_4_1 in var_2(var_4_1) do
			table = var_1_10007

			var_1_10007.insert(var_4_0, {
				text = iter_4_1[1],
				delay = iter_4_1[2]
			})
		end

		return var_4_0
	end

	return nil
end

function var_0_1.GetStyle(arg_5_0)
	return arg_5_0.style
end

function var_0_1.IsTimeline(arg_6_0)
	local var_6_0 = arg_6_0:GetPlayMode()

	Dialogue3DStep = var_1_10002

	local var_6_1

	if var_6_0 ~= var_1_10002.PLAY_MODE_SCENE_TIMELINE then
		Dialogue3DStep = var_2

		if var_6_0 ~= var_2.PLAY_MODE_TIMELINE then
			var_6_1 = false

			goto label_6_0
		end
	end

	var_6_1 = true

	::label_6_0::

	return var_6_1
end

function var_0_1.ShouldCameraShake(arg_7_0)
	return arg_7_0.cameraShake ~= nil
end

function var_0_1.GetCameraShakeSrc(arg_8_0)
	return arg_8_0.cameraShake
end

function var_0_1.ShouldShakeDailogue(arg_9_0)
	return arg_9_0.dialogShake ~= nil
end

function var_0_1.GetShakeDailogueData(arg_10_0)
	return arg_10_0.dialogShake
end

function var_0_1.GenOption(arg_11_0, arg_11_1)
	if arg_11_1.mission then
		return {
			icon = "icon_task",
			content = arg_11_1.content,
			type = var_0_1.OPTION_TYPE_TASK,
			param = arg_11_1.mission
		}
	elseif arg_11_1.page then
		return {
			icon = "icon_shop",
			content = arg_11_1.content,
			type = var_0_1.OPTION_TYPE_PAGE,
			param = arg_11_1.page
		}
	elseif arg_11_1.exit then
		return {
			icon = "icon_exit",
			content = arg_11_1.content,
			type = var_0_1.OPTION_TYPE_EXIT
		}
	else
		return {
			icon = "icon_dialogue",
			content = arg_11_1.content,
			type = var_0_1.OPTION_TYPE_TEXT,
			param = arg_11_1.flag
		}
	end

	return
end

function var_0_1.GetFace2FaceList(arg_12_0)
	return arg_12_0.face2Face
end

function var_0_1.GetTurntoList(arg_13_0)
	return arg_13_0.turntoList
end

function var_0_1.IsSameBranch(arg_14_0, arg_14_1)
	return not arg_14_0.branchCode or arg_14_0.branchCode == arg_14_1
end

function var_0_1.ExistOption(arg_15_0)
	return #arg_15_0.optionList > 0
end

function var_0_1.GetOptionList(arg_16_0)
	return arg_16_0.optionList
end

function var_0_1.CanSkip(arg_17_0)
	if arg_17_0:ExistOption() or arg_17_0.style == var_0_1.STYLE_EXIT_GROUP or arg_17_0.style == var_0_1.STYLE_JOIN_GROUP then
		return false
	end

	return true
end

function var_0_1.GetTypewriter(arg_18_0)
	return arg_18_0.typewriter
end

function var_0_1.GetName(arg_19_0)
	return arg_19_0:GetActorName()
end

function var_0_1.GetSubName(arg_20_0)
	if not arg_20_0.subName or arg_20_0.subName == "" then
		return ""
	end

	return "/" .. arg_20_0.subName
end

function var_0_1.GetPlayMode(arg_21_0)
	if arg_21_0.sceneTimeline and arg_21_0.sceneTimeline ~= "" then
		return var_0_1.PLAY_MODE_SCENE_TIMELINE
	elseif arg_21_0.timeline and arg_21_0.timeline ~= "" then
		return var_0_1.PLAY_MODE_TIMELINE
	else
		return var_0_1.PLAY_MODE_DIALOGUE
	end

	return
end

function var_0_1.GetTimelinePath(arg_22_0)
	return arg_22_0.timeline
end

function var_0_1.GetActiveCamera(arg_23_0)
	return arg_23_0.camera
end

function var_0_1.ShouldActiveCamera(arg_24_0)
	local var_24_0

	if arg_24_0.camera then
		var_24_0 = arg_24_0.camera ~= ""
	end

	return var_24_0
end

function var_0_1.GetSceneTimelinePath(arg_25_0)
	return arg_25_0.sceneTimeline
end

function var_0_1.GetCameraBlendName(arg_26_0)
	return arg_26_0.cameraBlend
end

function var_0_1.SholdBlendCamera(arg_27_0)
	if not arg_27_0.cameraBlend then
		return false
	end

	return true
end

function var_0_1.ShouldFadeCamera(arg_28_0)
	return arg_28_0.cameraFade
end

return var_0_1
