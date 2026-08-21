local var_0_0 = class("GuideStep")

var_0_0.TYPE_DOFUNC = 0
var_0_0.TYPE_DONOTHING = 1
var_0_0.TYPE_FINDUI = 2
var_0_0.TYPE_HIDEUI = 3
var_0_0.TYPE_SENDNOTIFIES = 4
var_0_0.TYPE_SHOWSIGN = 5
var_0_0.TYPE_STORY = 6
var_0_0.DIALOGUE_BLUE = 1
var_0_0.DIALOGUE_WHITE = 2
var_0_0.DIALOGUE_WORLD = 3
var_0_0.DIALOGUE_DORM = 4
var_0_0.HIGH_TYPE_LINE = 1
var_0_0.HIGH_TYPE_GAMEOBJECT = 2
var_0_0.HIGH_TYPE_FLOAT = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.delay = arg_1_1.delay
	arg_1_0.waitScene = arg_1_1.waitScene
	arg_1_0.code = arg_1_1.code
	arg_1_0.alpha = arg_1_1.alpha
	arg_1_0.mask = defaultValue(arg_1_1.mask, false)
	arg_1_0.isWorld = defaultValue(arg_1_1.isWorld, true)
	arg_1_0.styleData = arg_1_0:GenStyleData(arg_1_1.style)
	arg_1_0.highLightData = arg_1_0:GenHighLightData(arg_1_1.style)
	arg_1_0.baseUI = arg_1_0:GenSearchData(arg_1_1.baseui)
	arg_1_0.spriteUI = arg_1_0:GenSpriteSearchData(arg_1_1.spriteui)
	arg_1_0.sceneName = arg_1_1.style and arg_1_1.style.scene
	arg_1_0.otherTriggerTarget = arg_1_1.style and arg_1_1.style.trigger

	return
end

function var_0_0.CanClick(arg_2_0)
	return not arg_2_0.mask
end

function var_0_0.UpdateIsWorld(arg_3_0, arg_3_1)
	arg_3_0.isWorld = arg_3_1

	return
end

function var_0_0.IsMatchWithCode(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetMatchCode()

	if not var_4_0 then
		return true
	end

	if type(var_4_0) == "number" then
		return table.contains(arg_4_1, var_4_0)
	elseif type(var_4_0) == "table" then
		return _.any(arg_4_1, function(arg_5_0)
			return table.contains(var_4_0, arg_5_0)
		end)
	end

	return false
end

function var_0_0.GetMatchCode(arg_6_0)
	return arg_6_0.code
end

function var_0_0.GetDelay(arg_7_0)
	return arg_7_0.delay or 0
end

function var_0_0.GetAlpha(arg_8_0)
	return arg_8_0.alpha or 0.4
end

function var_0_0.ShouldWaitScene(arg_9_0)
	return arg_9_0.waitScene and arg_9_0.waitScene ~= ""
end

function var_0_0.GetWaitScene(arg_10_0)
	return arg_10_0.waitScene
end

function var_0_0.ShouldShowDialogue(arg_11_0)
	return arg_11_0.styleData ~= nil
end

function var_0_0.GetDialogueType(arg_12_0)
	return arg_12_0.styleData.mode
end

local function var_0_1(arg_13_0, arg_13_1)
	local var_13_0 = "char"

	if arg_13_1.char and arg_13_1.char == 1 then
		var_13_0 = arg_13_0.isWorld and "char_world" or "char_world1"
	elseif arg_13_1.char and arg_13_1.char == "amazon" then
		var_13_0 = "char_amazon"
	end

	return var_13_0
end

local function var_0_2(arg_14_0, arg_14_1)
	if arg_14_1.charPos then
		return Vector2(arg_14_1.charPos[1], arg_14_1.charPos[2])
	elseif arg_14_1.dir == 1 then
		return arg_14_1.mode == var_0_0.DIALOGUE_BLUE and Vector2(-400, -170) or Vector2(-350, 0)
	else
		return arg_14_1.mode == var_0_0.DIALOGUE_BLUE and Vector2(400, -170) or Vector2(350, 0)
	end

	return
end

local function var_0_3(arg_15_0)
	local var_15_0 = arg_15_0.charScale and Vector2(arg_15_0.charScale[1], arg_15_0.charScale[2]) or Vector2(1, 1)

	return arg_15_0.dir == 1 and var_15_0 or Vector3(-var_15_0.x, var_15_0.y, 1)
end

function var_0_0.GenStyleData(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return nil
	end

	local var_16_0

	if arg_16_1.mode == var_0_0.DIALOGUE_DORM then
		var_16_0 = nil
		arg_16_1.dir = 1
	else
		var_16_0 = {
			name = var_0_1(arg_16_0, arg_16_1),
			position = var_0_2(arg_16_0, arg_16_1),
			scale = var_0_3(arg_16_1)
		}
	end

	local var_16_1 = {
		mode = arg_16_1.mode
	}
	local var_16_2 = arg_16_1.text or ""

	var_16_1.text = HXSet.hxLan(var_16_2)
	var_16_1.counsellor = var_16_0
	var_16_1.scale = arg_16_1.dir == 1 and Vector3(1, 1, 1) or Vector3(-1, 1, 1)

	local var_16_3 = arg_16_1.posX or 0
	local var_16_4 = arg_16_1.posY or 0

	var_16_1.position = Vector2(var_16_3, var_16_4)
	var_16_1.handPosition = arg_16_1.handPos and Vector3(arg_16_1.handPos.x, arg_16_1.handPos.y, 0) or Vector3(-267, -96, 0)

	if arg_16_1.handPos then
		local var_16_5 = arg_16_1.handPos.w or 0

		var_16_1.handAngle = Vector3(0, 0, var_16_5) or Vector3(0, 0, 0)

		return var_16_1
	end
end

function var_0_0.GetHighlightName(arg_17_0)
	if arg_17_0:GetDialogueType() == var_0_0.DIALOGUE_DORM then
		return "wShowArea4"
	elseif arg_17_0.isWorld then
		return "wShowArea"
	else
		return "wShowArea1"
	end

	return
end

function var_0_0.GetHighlightLength(arg_18_0)
	if arg_18_0:GetDialogueType() == var_0_0.DIALOGUE_DORM then
		return 50
	elseif arg_18_0.isWorld then
		return 15
	else
		return 55
	end

	return
end

function var_0_0.GetStyleData(arg_19_0)
	return arg_19_0.styleData
end

function var_0_0.GenHighLightData(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_1 and arg_20_1.ui then
		table.insert(var_20_0, (function(arg_21_0)
			local var_21_0 = arg_20_0:GenSearchData(arg_21_0)

			var_21_0.type = arg_21_0.lineMode or var_0_0.HIGH_TYPE_GAMEOBJECT

			return var_21_0
		end)(arg_20_1.ui))
	elseif arg_20_1 and arg_20_1.uiset then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1.uiset) do
			table.insert(var_20_0, (function(arg_21_0)
				local var_21_0 = arg_20_0:GenSearchData(arg_21_0)

				var_21_0.type = arg_21_0.lineMode or var_0_0.HIGH_TYPE_GAMEOBJECT

				return var_21_0
			end)(iter_20_1))
		end
	elseif arg_20_1 and arg_20_1.uiFunc then
		for iter_20_2, iter_20_3 in ipairs((arg_20_1.uiFunc())) do
			table.insert(var_20_0, (function(arg_21_0)
				local var_21_0 = arg_20_0:GenSearchData(arg_21_0)

				var_21_0.type = arg_21_0.lineMode or var_0_0.HIGH_TYPE_GAMEOBJECT

				return var_21_0
			end)(iter_20_3))
		end
	end

	return var_20_0
end

function var_0_0.ShouldHighLightTarget(arg_22_0)
	return #arg_22_0.highLightData > 0
end

function var_0_0.GetHighLightTarget(arg_23_0)
	return arg_23_0.highLightData
end

function var_0_0.ExistTrigger(arg_24_0)
	local var_24_0 = arg_24_0:GetType()

	return var_24_0 == var_0_0.TYPE_FINDUI or var_24_0 == var_0_0.TYPE_STORY
end

function var_0_0.ShouldGoScene(arg_25_0)
	return arg_25_0.sceneName and arg_25_0.sceneName ~= ""
end

function var_0_0.GetSceneName(arg_26_0)
	return arg_26_0.sceneName
end

function var_0_0.ShouldTriggerOtherTarget(arg_27_0)
	return arg_27_0.otherTriggerTarget ~= nil
end

function var_0_0.GetOtherTriggerTarget(arg_28_0)
	return arg_28_0:GenSearchData(arg_28_0.otherTriggerTarget)
end

function var_0_0.GenSearchData(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return nil
	end

	local var_29_0 = arg_29_1.path

	if arg_29_1.dynamicPath then
		var_29_0 = arg_29_1.dynamicPath()
	end

	return {
		path = var_29_0,
		delay = arg_29_1.delay,
		pathIndex = arg_29_1.pathIndex,
		conditionData = arg_29_1.conditionData
	}
end

function var_0_0.GenSpriteSearchData(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return nil
	end

	local var_30_0 = arg_30_0:GenSearchData(arg_30_1)

	var_30_0.defaultName = arg_30_1.defaultName
	var_30_0.childPath = arg_30_1.childPath

	return var_30_0
end

function var_0_0.ShouldCheckBaseUI(arg_31_0)
	return arg_31_0.baseUI ~= nil
end

function var_0_0.GetBaseUI(arg_32_0)
	return arg_32_0.baseUI
end

function var_0_0.ShouldCheckSpriteUI(arg_33_0)
	return arg_33_0.spriteUI ~= nil
end

function var_0_0.GetSpriteUI(arg_34_0)
	return arg_34_0.spriteUI
end

function var_0_0.GetType(arg_35_0)
	assert(false, "overwrite me!!!")

	return
end

return var_0_0
