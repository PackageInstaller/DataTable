local GuideStep = class("GuideStep")

GuideStep.TYPE_DOFUNC = 0
GuideStep.TYPE_DONOTHING = 1
GuideStep.TYPE_FINDUI = 2
GuideStep.TYPE_HIDEUI = 3
GuideStep.TYPE_SENDNOTIFIES = 4
GuideStep.TYPE_SHOWSIGN = 5
GuideStep.TYPE_STORY = 6
GuideStep.DIALOGUE_BLUE = 1
GuideStep.DIALOGUE_WHITE = 2
GuideStep.DIALOGUE_WORLD = 3
GuideStep.DIALOGUE_DORM = 4
GuideStep.HIGH_TYPE_LINE = 1
GuideStep.HIGH_TYPE_GAMEOBJECT = 2
GuideStep.HIGH_TYPE_FLOAT = 3

function GuideStep:Ctor(arg_1_1)
	self.delay = arg_1_1.delay
	self.waitScene = arg_1_1.waitScene
	self.code = arg_1_1.code
	self.alpha = arg_1_1.alpha
	self.mask = defaultValue(arg_1_1.mask, false)
	self.isWorld = defaultValue(arg_1_1.isWorld, true)
	self.styleData = self:GenStyleData(arg_1_1.style)
	self.highLightData = self:GenHighLightData(arg_1_1.style)
	self.baseUI = self:GenSearchData(arg_1_1.baseui)
	self.spriteUI = self:GenSpriteSearchData(arg_1_1.spriteui)
	self.sceneName = arg_1_1.style and arg_1_1.style.scene
	self.otherTriggerTarget = arg_1_1.style and arg_1_1.style.trigger

	return
end

function GuideStep:CanClick()
	return not self.mask
end

function GuideStep:UpdateIsWorld(arg_3_1)
	self.isWorld = arg_3_1

	return
end

function GuideStep:IsMatchWithCode(arg_4_1)
	local var_4_0 = self:GetMatchCode()

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

function GuideStep:GetMatchCode()
	return self.code
end

function GuideStep:GetDelay()
	return self.delay or 0
end

function GuideStep:GetAlpha()
	return self.alpha or 0.4
end

function GuideStep:ShouldWaitScene()
	return self.waitScene and self.waitScene ~= ""
end

function GuideStep:GetWaitScene()
	return self.waitScene
end

function GuideStep:ShouldShowDialogue()
	return self.styleData ~= nil
end

function GuideStep:GetDialogueType()
	return self.styleData.mode
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
		return arg_14_1.mode == GuideStep.DIALOGUE_BLUE and Vector2(-400, -170) or Vector2(-350, 0)
	else
		return arg_14_1.mode == GuideStep.DIALOGUE_BLUE and Vector2(400, -170) or Vector2(350, 0)
	end

	return
end

local function var_0_3(arg_15_0)
	local var_15_0 = arg_15_0.charScale and Vector2(arg_15_0.charScale[1], arg_15_0.charScale[2]) or Vector2(1, 1)

	return arg_15_0.dir == 1 and var_15_0 or Vector3(-var_15_0.x, var_15_0.y, 1)
end

function GuideStep:GenStyleData(arg_16_1)
	if not arg_16_1 then
		return nil
	end

	local var_16_0

	if arg_16_1.mode == GuideStep.DIALOGUE_DORM then
		var_16_0 = nil
		arg_16_1.dir = 1
	else
		var_16_0 = {
			name = var_0_1(self, arg_16_1),
			position = var_0_2(self, arg_16_1),
			scale = var_0_3(arg_16_1)
		}
	end

	local var_16_1 = {
		mode = arg_16_1.mode
	}

	var_16_1.text = HXSet.hxLan(arg_16_1.text or "")
	var_16_1.counsellor = var_16_0
	var_16_1.scale = arg_16_1.dir == 1 and Vector3(1, 1, 1) or Vector3(-1, 1, 1)
	var_16_1.position = Vector2(arg_16_1.posX or 0, arg_16_1.posY or 0)
	var_16_1.handPosition = arg_16_1.handPos and Vector3(arg_16_1.handPos.x, arg_16_1.handPos.y, 0) or Vector3(-267, -96, 0)

	if arg_16_1.handPos then
		var_16_1.handAngle = Vector3(0, 0, arg_16_1.handPos.w or 0) or Vector3(0, 0, 0)
	end

	return var_16_1
end

function GuideStep:GetHighlightName()
	if self:GetDialogueType() == GuideStep.DIALOGUE_DORM then
		return "wShowArea4"
	elseif self.isWorld then
		return "wShowArea"
	else
		return "wShowArea1"
	end

	return
end

function GuideStep:GetHighlightLength()
	if self:GetDialogueType() == GuideStep.DIALOGUE_DORM then
		return 50
	elseif self.isWorld then
		return 15
	else
		return 55
	end

	return
end

function GuideStep:GetStyleData()
	return self.styleData
end

function GuideStep:GenHighLightData(arg_20_1)
	local function var_20_0(arg_21_0)
		local var_21_0 = self:GenSearchData(arg_21_0)

		var_21_0.type = arg_21_0.lineMode or GuideStep.HIGH_TYPE_GAMEOBJECT

		return var_21_0
	end

	local var_20_1 = {}

	if arg_20_1 and arg_20_1.ui then
		table.insert(var_20_1, var_20_0(arg_20_1.ui))
	elseif arg_20_1 and arg_20_1.uiset then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1.uiset) do
			table.insert(var_20_1, var_20_0(iter_20_1))
		end
	elseif arg_20_1 and arg_20_1.uiFunc then
		for iter_20_2, iter_20_3 in ipairs((arg_20_1.uiFunc())) do
			table.insert(var_20_1, var_20_0(iter_20_3))
		end
	end

	return var_20_1
end

function GuideStep:ShouldHighLightTarget()
	return #self.highLightData > 0
end

function GuideStep:GetHighLightTarget()
	return self.highLightData
end

function GuideStep:ExistTrigger()
	local var_24_0 = self:GetType()

	return var_24_0 == GuideStep.TYPE_FINDUI or var_24_0 == GuideStep.TYPE_STORY
end

function GuideStep:ShouldGoScene()
	return self.sceneName and self.sceneName ~= ""
end

function GuideStep:GetSceneName()
	return self.sceneName
end

function GuideStep:ShouldTriggerOtherTarget()
	return self.otherTriggerTarget ~= nil
end

function GuideStep:GetOtherTriggerTarget()
	return self:GenSearchData(self.otherTriggerTarget)
end

function GuideStep:GenSearchData(arg_29_1)
	if not arg_29_1 then
		return nil
	end

	return {
		path = (arg_29_1.dynamicPath or nil) and arg_29_1.dynamicPath(),
		delay = arg_29_1.delay,
		pathIndex = arg_29_1.pathIndex,
		conditionData = arg_29_1.conditionData
	}
end

function GuideStep:GenSpriteSearchData(arg_30_1)
	if not arg_30_1 then
		return nil
	end

	local var_30_0 = self:GenSearchData(arg_30_1)

	var_30_0.defaultName = arg_30_1.defaultName
	var_30_0.childPath = arg_30_1.childPath

	return var_30_0
end

function GuideStep:ShouldCheckBaseUI()
	return self.baseUI ~= nil
end

function GuideStep:GetBaseUI()
	return self.baseUI
end

function GuideStep:ShouldCheckSpriteUI()
	return self.spriteUI ~= nil
end

function GuideStep:GetSpriteUI()
	return self.spriteUI
end

function GuideStep:GetType()
	assert(false, "overwrite me!!!")

	return
end

return GuideStep
