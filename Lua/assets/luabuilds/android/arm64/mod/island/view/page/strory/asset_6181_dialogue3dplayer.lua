local Dialogue3DPlayer = class("Dialogue3DPlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function Dialogue3DPlayer:Ctor(arg_1_1)
	Dialogue3DPlayer.super.Ctor(self)
	pg.DelegateInfo.New(self)

	self.view = arg_1_1
	self._tf = arg_1_1._tf
	self.dialogueContainer = self._tf:Find("front/dialogue")
	self.asideContainer = self._tf:Find("front/aside")
	self.dialoguePanel = self._tf:Find("front/dialogue/1")
	self.nameContainer = self.dialoguePanel:Find("content/name/tags")
	self.nameTxt = self.dialoguePanel:Find("content/name/tags/3/Text"):GetComponent(typeof(Text))
	self.iconImg = self.dialoguePanel:Find("content/name/tags/3/icon")
	self.contentTxt = self.dialoguePanel:Find("content"):GetComponent(typeof(Text))
	self.typewriter = self.contentTxt:GetComponent(typeof(Typewriter))
	self.blackBg = self._tf:Find("black"):GetComponent(typeof(CanvasGroup))
	self.optionPanel = self.dialoguePanel:Find("options_panel")
	self.uiOptionList = UIItemList.New(self.dialoguePanel:Find("options_panel/options_l"), self.dialoguePanel:Find("options_panel/options_l/option_tpl"))
	self.asidePlayer = IslandAsidePlayer.New(self.asideContainer)
	self.canvasGroup = arg_1_1.canvasGroup

	return
end

function Dialogue3DPlayer:NextOne()
	if self.script and self.script:IsSkipAll() then
		-- block empty
	end

	if self.nextOneFlag then
		return
	end

	if self.step and not self.step:CanSkip() then
		return
	end

	self.autoNext = true

	if self.isRegisterEvent then
		triggerButton(self._tf)
	else
		self.nextOneFlag = true

		self:Clear()

		self.callback = nil

		self.callback()
	end

	return
end

function Dialogue3DPlayer:CancelAuto()
	self.autoNext = false

	self:ClearTimer(self.callback)

	return
end

function Dialogue3DPlayer:OnStart(arg_4_1)
	return
end

function Dialogue3DPlayer:OnStartAction(arg_5_1, arg_5_2)
	self:ActiveDefaultCamera(arg_5_1)
	self:StartFadeIn(arg_5_1)
	arg_5_2()

	return
end

function Dialogue3DPlayer:OnEndAction(arg_6_1, arg_6_2)
	self:StartFadeOut(arg_6_1, arg_6_2)

	return
end

function Dialogue3DPlayer:Reset(arg_7_1)
	setActive(self.dialogueContainer, arg_7_1 == Dialogue3DStep.STYLE_DIALOGUE)
	setActive(self.asideContainer, arg_7_1 == Dialogue3DStep.STYLE_ASIDE)
	removeOnButton(self._tf)
	self.uiOptionList:align(0)

	self.isRegisterEvent = false
	self.nextOneFlag = false
	self.blackBg.alpha = 0

	return
end

function Dialogue3DPlayer:Play(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_3:GetStepByIndex(arg_8_2)

	if not var_8_0 then
		arg_8_4()

		return
	end

	self.isUnmarkedSkipAll = false

	if var_8_0:ExistOption() and arg_8_3:IsSkipAll() then
		arg_8_3:UnMarkSkipAll()

		self.isUnmarkedSkipAll = true
	end

	if arg_8_3:IsSkipAll() then
		arg_8_4()

		return
	end

	self.canvasGroup.blocksRaycasts = true
	self.playerUnit = arg_8_3:GetPlayerRole()

	if not var_8_0 then
		arg_8_4()

		return
	end

	arg_8_1:Add(var_8_0)

	self.script = arg_8_3
	self.callback = arg_8_4
	self.autoNext = arg_8_3:GetAutoPlayFlag()
	self.step = var_8_0

	self:SetTimeScale(1 - arg_8_3:GetPlaySpeed() * 0.1)

	self.isRegisterEvent = false

	local var_8_1 = var_8_0:GetStyle()

	self:Reset(var_8_1)

	if var_8_1 == Dialogue3DStep.STYLE_DIALOGUE then
		self:PlayDialogue(var_8_0, arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_ASIDE then
		self.asidePlayer:Play(var_8_0:GetAsideSequences(), arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_EXIT_GROUP then
		self:PlayNavObject(var_8_0, function()
			local var_9_0 = var_8_0:GetNavObject()

			if var_9_0 then
				IslandCameraMgr.instance:RemoveFromGroup(var_9_0.transform)
			end

			return
		end, arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_JOIN_GROUP then
		self:PlayNavObject(var_8_0, nil, function()
			local var_10_0 = var_8_0:GetNavObject()

			if var_10_0 then
				IslandCameraMgr.instance:AddIntoGroup(var_10_0.transform, 1, 0)
			end

			arg_8_4()

			return
		end)
	end

	return
end

function Dialogue3DPlayer:PlayNavObject(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetNavData()

	self:DelayCall(var_11_0.delay, function()
		local var_12_0

		if arg_11_2 then
			arg_11_2()

			var_12_0 = {}
		end

		var_12_0.navData = {
			unitId = var_11_0.object,
			position = var_11_0.position,
			speed = var_11_0.speed,
			hide = var_11_0.hide,
			waitUntilDone = var_11_0.waitUntilDone,
			index = var_11_0.navData
		}
		var_12_0.callback = arg_11_3

		self.view:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.START_PATHFINDER, var_12_0)

		return
	end)

	return
end

function Dialogue3DPlayer:PlayDialogue(arg_13_1, arg_13_2)
	seriesAsync({
		function(arg_14_0)
			self:SetCustomCameraBlend(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			parallelAsync({
				function(arg_16_0)
					self:ActiveCamera(arg_13_1, arg_16_0)

					return
				end,
				function(arg_17_0)
					self:ShakeCamera(arg_13_1, arg_17_0)

					return
				end,
				function(arg_18_0)
					self:StartAction(arg_13_1, arg_18_0)

					return
				end
			}, arg_15_0)

			return
		end,
		function(arg_19_0)
			self:Clear()
			arg_19_0()

			return
		end
	}, arg_13_2)

	return
end

function Dialogue3DPlayer:StartFadeIn(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:GetFadeInTime()

	if var_20_0 <= 0 then
		if arg_20_2 then
			arg_20_2()
		end

		return
	end

	local var_20_1 = {}

	self:CollectFadeInFunc(var_20_1, var_20_0)
	seriesAsync(var_20_1, arg_20_2)

	return
end

function Dialogue3DPlayer:StartFadeOut(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:GetFadeOutTime()

	if var_21_0 <= 0 then
		if arg_21_2 then
			arg_21_2()
		end

		return
	end

	local var_21_1 = {}

	self:CollectFadeOutFunc(var_21_1, var_21_0)
	seriesAsync(var_21_1, arg_21_2)

	return
end

function Dialogue3DPlayer:ActiveDefaultCamera(arg_22_1)
	local var_22_0, var_22_1, var_22_2 = arg_22_1:GetLookGroup()
	local var_22_3 = System.Array.CreateInstance(typeof(Transform), #var_22_0)
	local var_22_4 = System.Array.CreateInstance(typeof(UnityEngine.Vector2), #var_22_0)

	for iter_22_0 = 0, #var_22_0 - 1 do
		var_22_3[iter_22_0] = var_22_0[iter_22_0 + 1].transform
		var_22_4[iter_22_0] = UnityEngine.Vector2.New(var_22_1[iter_22_0 + 1] or 1, var_22_2[iter_22_0 + 1] or 0)
	end

	if var_22_3.Length > 1 then
		if arg_22_1:ShouldSetCamOffset() then
			IslandCameraMgr.instance:SetVirtualCameraBodyOffset(IslandConst.INTERACTION_CAMERA_NAME, (arg_22_1:GetFollowOffset()))
		end

		IslandCameraMgr.instance:LookAtGroup(var_22_3, var_22_4)
	elseif var_22_3.Length == 1 then
		IslandCameraMgr.instance:SetVirtualCameraBodyOffset(IslandConst.SOLO_INTERACTION_CAMERA_NAME, arg_22_1:IsFacingWhenSolo())
		IslandCameraMgr.instance:LookAt(IslandConst.SOLO_INTERACTION_CAMERA_NAME, var_22_3[0])
	else
		assert(false, "should have at least one target")
	end

	return
end

function Dialogue3DPlayer:DisactiveDefaultCamera()
	IslandCameraMgr.instance:LookAt(self.playerUnit.transform)

	return
end

function Dialogue3DPlayer:ShowOptions(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:GetOptionList()

	self.uiOptionList:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			local var_25_0 = var_24_0[arg_25_1 + 1]

			setText(arg_25_2.transform:Find("main/content/Text"), HXSet.hxLan(var_24_0[arg_25_1 + 1].content))

			local var_25_1 = arg_25_2.transform:Find("main/icon"):GetComponent(typeof(Image))

			var_25_1.sprite = GetSpriteFromAtlas("ui/story_atlas", var_24_0[arg_25_1 + 1].icon)

			var_25_1:SetNativeSize()
			onButton(self, arg_25_2, function()
				self:ResponseOption(var_25_0, arg_24_2)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiOptionList:align(#var_24_0)

	return
end

function Dialogue3DPlayer:ResponseOption(arg_27_1, arg_27_2)
	if arg_27_1.type == Dialogue3DStep.OPTION_TYPE_TEXT then
		self.script:SetBranchCode(arg_27_1.param)
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_PAGE then
		self.script:MarkSkipAll()
		self.view:emit(ISLAND_EX_EVT.OPEN_PAGE, _G[arg_27_1.param])
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_TASK then
		self.script:MarkSkipAll()
		self.view:emit(ISLAND_EX_EVT.TRIGGER_TASK, arg_27_1.param)
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_EXIT then
		self.script:MarkSkipAll()
	end

	self:PlayOptionExitAnimation(arg_27_2)

	return
end

function Dialogue3DPlayer:PlayOptionExitAnimation(arg_28_1)
	local var_28_0 = {}

	self.uiOptionList:eachActive(function(arg_29_0, arg_29_1)
		table.insert(var_28_0, function(arg_30_0)
			arg_29_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				arg_30_0()

				return
			end)
			arg_29_1:GetComponent(typeof(Animation)):Play("anim_IslandStoryUI_Tpl_Out")

			return
		end)

		return
	end)
	parallelAsync(var_28_0, function()
		self.uiOptionList:each(function(arg_33_0, arg_33_1)
			arg_33_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)

			return
		end)
		arg_28_1()

		return
	end)

	return
end

function Dialogue3DPlayer:SetCustomCameraBlend(arg_34_1, arg_34_2)
	arg_34_2()

	return
end

function Dialogue3DPlayer:ClearCustomCameraBlend()
	return
end

function Dialogue3DPlayer:StartAction(arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1:GetPlayMode()

	if var_36_0 == Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE then
		setActive(self._tf, false)
		self.view:emit(ISLAND_EX_EVT.PLAY_TIMELINE, arg_36_1:GetSceneTimelinePath(), {}, function()
			setActive(self._tf, true)
			arg_36_2()

			return
		end)
	elseif var_36_0 == Dialogue3DStep.PLAY_MODE_TIMELINE then
		arg_36_2()
	elseif var_36_0 == Dialogue3DStep.PLAY_MODE_DIALOGUE then
		self:UpdateDialogue(arg_36_1, arg_36_2)
	else
		assert(false, "not support play mode")
		arg_36_2()
	end

	return
end

function Dialogue3DPlayer:CollectFadeInFunc(arg_38_1, arg_38_2)
	self.blackBg.alpha = 1

	table.insert(arg_38_1, function(arg_39_0)
		self:TweenValueForcanvasGroup(self.blackBg, 1, 0, arg_38_2 or 0.5, 0, arg_39_0)

		return
	end)
	table.insert(arg_38_1, function(arg_40_0)
		self:UnscaleDelayCall(1, arg_40_0)

		return
	end)

	return
end

function Dialogue3DPlayer:CollectFadeOutFunc(arg_41_1, arg_41_2)
	self.blackBg.alpha = 0

	table.insert(arg_41_1, function(arg_42_0)
		self:TweenValueForcanvasGroup(self.blackBg, 0, 1, arg_41_2 or 0.5, 0, arg_42_0)

		return
	end)

	return
end

function Dialogue3DPlayer:ActiveCamera(arg_43_1, arg_43_2)
	if not arg_43_1:ShouldActiveCamera() then
		arg_43_2()

		return
	end

	local var_43_0 = arg_43_1:ShouldFadeCamera()
	local var_43_1 = {}

	if var_43_0 then
		self:CollectFadeOutFunc(var_43_1)
	end

	table.insert(var_43_1, function(arg_44_0)
		IslandCameraMgr.instance:ActiveVirtualCamera((arg_43_1:GetActiveCamera()))
		arg_44_0()

		return
	end)

	if var_43_0 then
		self:CollectFadeInFunc(var_43_1)
	end

	seriesAsync(var_43_1, arg_43_2)

	return
end

function Dialogue3DPlayer:ShakeCamera(arg_45_1, arg_45_2)
	if not arg_45_1:ShouldCameraShake() then
		arg_45_2()

		return
	end

	seriesAsync({
		function(arg_46_0)
			self:LoadShakeSrc(arg_45_1, arg_46_0)

			return
		end,
		function(arg_47_0)
			if self.shakeCameraSrc then
				self.shakeCameraSrc:GetComponent("Cinemachine.CinemachineImpulseSource"):GenerateImpulse()
			end

			arg_47_0()

			return
		end
	}, arg_45_2)

	return
end

function Dialogue3DPlayer:LoadShakeSrc(arg_48_1, arg_48_2)
	PoolMgr.GetInstance():GetUI(arg_48_1:GetCameraShakeSrc(), true, function(arg_49_0)
		self.shakeCameraSrc = arg_49_0

		arg_48_2()

		return
	end)

	return
end

function Dialogue3DPlayer:UpdateDialogue(arg_50_1, arg_50_2)
	parallelAsync({
		function(arg_51_0)
			self:LoadContentAndIcon(arg_50_1, arg_51_0)

			return
		end,
		function(arg_52_0)
			self:PlayCharatorAnimation(arg_50_1, arg_52_0)

			return
		end,
		function(arg_53_0)
			self:UpdateTypeWriter(arg_50_1, arg_53_0)

			return
		end,
		function(arg_54_0)
			self:StartUIAnimations(arg_50_1, arg_54_0)

			return
		end,
		function(arg_55_0)
			self:TryFace2Face(arg_50_1, arg_55_0)

			return
		end,
		function(arg_56_0)
			self:TryTurn2Unit(arg_50_1, arg_56_0)

			return
		end
	}, function()
		self:RegisterEvent(arg_50_1, arg_50_2)

		return
	end)

	return
end

function Dialogue3DPlayer:TryTurn2Unit(arg_58_1, arg_58_2)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1:GetTurntoList()) do
		table.insert(var_58_0, function(arg_59_0)
			local var_59_0 = self.script:GetRole(iter_58_1[1])
			local var_59_1 = self.script:GetRole(iter_58_1[2])

			if var_59_1 == nil or var_59_0 == nil then
				arg_59_0()

				return
			end

			self:Turn2Unit(var_59_0.transform, var_59_1.transform, arg_59_0)

			return
		end)
	end

	seriesAsync(var_58_0, arg_58_2)

	return
end

function Dialogue3DPlayer:Turn2Unit(arg_60_1, arg_60_2, arg_60_3)
	arg_60_1.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_60_2.position - arg_60_1.position).eulerAngles.y, 0)

	arg_60_3()

	return
end

function Dialogue3DPlayer:TryFace2Face(arg_61_1, arg_61_2)
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1:GetFace2FaceList()) do
		table.insert(var_61_0, function(arg_62_0)
			local var_62_0 = self.script:GetRole(iter_61_1[1])
			local var_62_1 = self.script:GetRole(iter_61_1[2])

			if var_62_1 == nil or var_62_0 == nil then
				arg_62_0()

				return
			end

			self:Face2Face(var_62_0.transform, var_62_1.transform, arg_62_0)

			return
		end)
	end

	seriesAsync(var_61_0, arg_61_2)

	return
end

function Dialogue3DPlayer:Face2Face(arg_63_1, arg_63_2, arg_63_3)
	if (arg_63_2.position - arg_63_1.position).sqrMagnitude > 0.0001 then
		arg_63_1.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_63_2.position - arg_63_1.position).eulerAngles.y, 0)
	end

	if (arg_63_1.position - arg_63_2.position).sqrMagnitude > 0.0001 then
		arg_63_2.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_63_1.position - arg_63_2.position).eulerAngles.y, 0)
	end

	if arg_63_3 then
		arg_63_3()
	end

	return
end

function Dialogue3DPlayer:StartUIAnimations(arg_64_1, arg_64_2)
	if not arg_64_1:ShouldShakeDailogue() then
		arg_64_2()

		return
	end

	local var_64_0 = arg_64_1:GetShakeDailogueData()

	self:TweenMovex(self.dialoguePanel, var_64_0.x, self.dialoguePanel.localPosition.x, var_64_0.speed, var_64_0.delay, var_64_0.number, arg_64_2)

	return
end

function Dialogue3DPlayer:RegisterEvent(arg_65_1, arg_65_2)
	if not self.callback then
		return
	end

	setActive(self.optionPanel, arg_65_1:ExistOption())

	if arg_65_1:ExistOption() then
		self:ShowOptions(arg_65_1, arg_65_2)
	elseif self.autoNext then
		self:UnscaleDelayCall(self.script:GetTriggerDelayTime(), arg_65_2)
	else
		onButton(self, self._tf, arg_65_2, SFX_PANEL)
	end

	self.isRegisterEvent = true

	return
end

function Dialogue3DPlayer:UpdateTypeWriter(arg_66_1, arg_66_2)
	local var_66_0 = arg_66_1:GetSay()

	if not var_66_0 or var_66_0 == "" or var_66_0 == "…" or #var_66_0 <= 1 or ((var_66_0 and var_66_0 ~= "" or nil) and System.String.New(var_66_0).Length) <= 1 then
		arg_66_2()

		return
	end

	local var_66_2 = arg_66_1:GetTypewriter()

	if not var_66_2 or self.isUnmarkedSkipAll then
		arg_66_2()

		return
	end

	function self.typewriter.endFunc()
		self.typewriterSpeed = 0
		self.typewriter.endFunc = nil

		removeOnButton(self._tf)
		arg_66_2()

		return
	end

	self.typewriterSpeed = math.max((var_66_2.speed or 0.1) * self.timeScale, 0.001)

	local var_66_3 = var_66_2.speedUp or self.typewriterSpeed

	self.typewriter:setSpeed(self.typewriterSpeed)
	self.typewriter:Play()
	onButton(self, self._tf, function()
		if self.puase or self.stop then
			return
		end

		self.typewriterSpeed = math.min(self.typewriterSpeed, var_66_3)

		self.typewriter:setSpeed(self.typewriterSpeed)

		return
	end, SFX_PANEL)

	return
end

function Dialogue3DPlayer:LoadContentAndIcon(arg_69_1, arg_69_2)
	setActive(self.nameContainer, not arg_69_1:IsHideName())

	self.nameTxt.text = arg_69_1:GetName() .. "<size=24>" .. arg_69_1:GetSubName() .. "</size>"
	self.contentTxt.text = arg_69_1:GetSay()

	local var_69_0 = arg_69_1:GetActorIcon()

	if var_69_0 then
		GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. var_69_0, "", self.iconImg)
	end

	setActive(self.iconImg, not arg_69_1:IsHideIcon())
	arg_69_2()

	return
end

function Dialogue3DPlayer:PlayCharatorAnimation(arg_70_1, arg_70_2)
	if not arg_70_1:ExistAnimation() then
		arg_70_2()

		return
	end

	local var_70_0 = self.script:GetRole(arg_70_1:GetUnitData())

	if not var_70_0 then
		arg_70_2()

		return
	end

	local var_70_1 = arg_70_1:GetAnimation()
	local var_70_2 = var_70_0:GetComponent(typeof(Animator))

	var_70_2 = var_70_2 or var_70_0.transform:GetChild(0):GetComponent(typeof(Animator))

	if not var_70_2:GetCurrentAnimatorStateInfo(0):IsName(var_70_1) then
		local var_70_3 = Animator.StringToHash(var_70_1)

		for iter_70_0 = 1, var_70_2.layerCount do
			var_70_2:CrossFadeInFixedTime(var_70_3, 0.2, iter_70_0 - 1)
		end
	end

	arg_70_2()

	return
end

function Dialogue3DPlayer:Clear()
	self.asidePlayer:Clear()

	self.canvasGroup.blocksRaycasts = true

	self.uiOptionList:align(0)
	removeOnButton(self._tf)
	self:ClearAnimation()

	self.blackBg.alpha = 0

	if self.shakeCameraSrc then
		Object.Destroy(self.shakeCameraSrc)

		self.shakeCameraSrc = nil
	end

	return
end

function Dialogue3DPlayer:OnEnd()
	self:DisactiveDefaultCamera()
	self:ClearCustomCameraBlend()

	return
end

function Dialogue3DPlayer:Dispose()
	self.asidePlayer:Dispose()

	self.asidePlayer = nil

	pg.DelegateInfo.Dispose(self)

	return
end

return Dialogue3DPlayer
