local Dialogue3DStep = class("Dialogue3DStep", import(".IslandBaseStep"))

Dialogue3DStep.PLAY_MODE_DIALOGUE = 0
Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE = 1
Dialogue3DStep.PLAY_MODE_TIMELINE = 2
Dialogue3DStep.OPTION_TYPE_TEXT = 0
Dialogue3DStep.OPTION_TYPE_PAGE = 1
Dialogue3DStep.OPTION_TYPE_TASK = 2
Dialogue3DStep.OPTION_TYPE_EXIT = 3
Dialogue3DStep.STYLE_DIALOGUE = 1
Dialogue3DStep.STYLE_ASIDE = 2
Dialogue3DStep.STYLE_EXIT_GROUP = 3
Dialogue3DStep.STYLE_JOIN_GROUP = 4

function Dialogue3DStep:Ctor(arg_1_1, arg_1_2)
	Dialogue3DStep.super.Ctor(self, arg_1_1, arg_1_2)

	self.subName = arg_1_1.subName or arg_1_1.factiontag or ""
	self.timeline = arg_1_1.timeline
	self.sceneTimeline = arg_1_1.scene_timeline
	self.camera = arg_1_1.camera
	self.cameraBlend = arg_1_1.camera_blend
	self.cameraFade = arg_1_1.camera_fade
	self.dialogShake = arg_1_1.dialogShake
	self.cameraShake = arg_1_1.camera_shake
	self.face2Face = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.face2Face or {}) do
		local var_1_0 = iter_1_1[1]
		local var_1_1 = iter_1_1[2] or 0

		assert(var_1_0 ~= var_1_1, "face2Face配置错误，两个角色id不能相同")
		table.insert(self.face2Face, {
			self:GenUnitData(self.script:GetUnitIdFromCharaId(var_1_0), IslandConst.UNIT_LIST_OBJ),
			(self:GenUnitData(self.script:GetUnitIdFromCharaId(var_1_1), IslandConst.UNIT_LIST_OBJ))
		})
	end

	self.turntoList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.turnto or {}) do
		local var_1_2 = iter_1_3[1]
		local var_1_3 = iter_1_3[2] or 0

		assert(var_1_2 ~= var_1_3, "turnto配置错误，两个角色id不能相同")
		table.insert(self.turntoList, {
			self:GenUnitData(self.script:GetUnitIdFromCharaId(var_1_2), IslandConst.UNIT_LIST_OBJ),
			(self:GenUnitData(self.script:GetUnitIdFromCharaId(var_1_3), IslandConst.UNIT_LIST_OBJ))
		})
	end

	self.typewriter = arg_1_1.typewriter
	self.branchCode = arg_1_1.optionFlag
	self.optionList = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.options or {}) do
		table.insert(self.optionList, (self:GenOption(iter_1_5)))
	end

	self.style = arg_1_1.style or Dialogue3DStep.STYLE_DIALOGUE
	self.sequences = arg_1_1.sequence
	self.navData = arg_1_1

	return
end

function Dialogue3DStep:GetNavData()
	if self.style == Dialogue3DStep.STYLE_EXIT_GROUP or self.style == Dialogue3DStep.STYLE_JOIN_GROUP then
		return {
			object = self.script:GetUnitIdFromCharaId(self.navData.characterId),
			position = self.navData.position,
			speed = self.navData.speed,
			delay = self.navData.delay,
			hide = self.navData.hide,
			waitUntilDone = self.navData.wait_until_done,
			index = self.navData.index
		}
	end

	return nil
end

function Dialogue3DStep:GetNavObject()
	if self.style ~= Dialogue3DStep.STYLE_EXIT_GROUP then
		if self.style == Dialogue3DStep.STYLE_JOIN_GROUP then
			local var_3_0 = {}

			var_3_0.id = self.script:GetUnitIdFromCharaId(self.navData.characterId)
			var_3_0.type = IslandConst.UNIT_LIST_OBJ

			return (self.script:GetRole(var_3_0))
		end
	end

	return nil
end

function Dialogue3DStep:GetAsideSequences()
	if self.style == Dialogue3DStep.STYLE_ASIDE then
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(self.sequences or {}) do
			table.insert(var_4_0, {
				text = iter_4_1[1],
				delay = iter_4_1[2]
			})
		end

		return var_4_0
	end

	return nil
end

function Dialogue3DStep:GetStyle()
	return self.style
end

function Dialogue3DStep:IsTimeline()
	local var_6_0 = self:GetPlayMode()

	return var_6_0 == Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE or var_6_0 == Dialogue3DStep.PLAY_MODE_TIMELINE
end

function Dialogue3DStep:ShouldCameraShake()
	return self.cameraShake ~= nil
end

function Dialogue3DStep:GetCameraShakeSrc()
	return self.cameraShake
end

function Dialogue3DStep:ShouldShakeDailogue()
	return self.dialogShake ~= nil
end

function Dialogue3DStep:GetShakeDailogueData()
	return self.dialogShake
end

function Dialogue3DStep:GenOption(arg_11_1)
	if arg_11_1.mission then
		return {
			icon = "icon_task",
			content = arg_11_1.content,
			type = Dialogue3DStep.OPTION_TYPE_TASK,
			param = arg_11_1.mission
		}
	elseif arg_11_1.page then
		return {
			icon = "icon_shop",
			content = arg_11_1.content,
			type = Dialogue3DStep.OPTION_TYPE_PAGE,
			param = arg_11_1.page
		}
	elseif arg_11_1.exit then
		return {
			icon = "icon_exit",
			content = arg_11_1.content,
			type = Dialogue3DStep.OPTION_TYPE_EXIT
		}
	else
		return {
			icon = "icon_dialogue",
			content = arg_11_1.content,
			type = Dialogue3DStep.OPTION_TYPE_TEXT,
			param = arg_11_1.flag
		}
	end

	return
end

function Dialogue3DStep:GetFace2FaceList()
	return self.face2Face
end

function Dialogue3DStep:GetTurntoList()
	return self.turntoList
end

function Dialogue3DStep:IsSameBranch(arg_14_1)
	return not self.branchCode or self.branchCode == arg_14_1
end

function Dialogue3DStep:ExistOption()
	return #self.optionList > 0
end

function Dialogue3DStep:GetOptionList()
	return self.optionList
end

function Dialogue3DStep:CanSkip()
	if self:ExistOption() or self.style == Dialogue3DStep.STYLE_EXIT_GROUP or self.style == Dialogue3DStep.STYLE_JOIN_GROUP then
		return false
	end

	return true
end

function Dialogue3DStep:GetTypewriter()
	return self.typewriter
end

function Dialogue3DStep:GetName()
	return self:GetActorName()
end

function Dialogue3DStep:GetSubName()
	if not self.subName or self.subName == "" then
		return ""
	end

	return "/" .. self.subName
end

function Dialogue3DStep:GetPlayMode()
	if self.sceneTimeline and self.sceneTimeline ~= "" then
		return Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE
	elseif self.timeline and self.timeline ~= "" then
		return Dialogue3DStep.PLAY_MODE_TIMELINE
	else
		return Dialogue3DStep.PLAY_MODE_DIALOGUE
	end

	return
end

function Dialogue3DStep:GetTimelinePath()
	return self.timeline
end

function Dialogue3DStep:GetActiveCamera()
	return self.camera
end

function Dialogue3DStep:ShouldActiveCamera()
	return self.camera and self.camera ~= ""
end

function Dialogue3DStep:GetSceneTimelinePath()
	return self.sceneTimeline
end

function Dialogue3DStep:GetCameraBlendName()
	return self.cameraBlend
end

function Dialogue3DStep:SholdBlendCamera()
	if not self.cameraBlend then
		return false
	end

	return true
end

function Dialogue3DStep:ShouldFadeCamera()
	return self.cameraFade
end

return Dialogue3DStep
