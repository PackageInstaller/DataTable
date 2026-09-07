local IslandTimelineMgr = class("IslandTimelineMgr", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function IslandTimelineMgr:getUIName()
	return "IslandTimelineUI"
end

function IslandTimelineMgr:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.poolMgr = arg_2_1

	IslandTimelineMgr.super.Ctor(self, arg_2_2, arg_2_3, arg_2_4)

	return
end

function IslandTimelineMgr:OnLoaded()
	self.skipBtn = self._tf:Find("adapt/skip_button")
	self.maskCG = self._tf:Find("mask"):GetComponent(typeof(CanvasGroup))
	self.state = var_0_1

	return
end

function IslandTimelineMgr:GetPoolMgr()
	return self.poolMgr
end

function IslandTimelineMgr:OnInit()
	onButton(self, self.skipBtn, function()
		if not self:IsPlaying() then
			return
		end

		self:Stop()

		return
	end, SFX_PANEL)

	return
end

function IslandTimelineMgr:IsPlaying()
	return self.state == var_0_2
end

function IslandTimelineMgr:Show(arg_8_1, arg_8_2, arg_8_3)
	if self:IsPlaying() then
		return
	end

	IslandTimelineMgr.super.Show(self)

	self.state = var_0_2
	self.callback = arg_8_3
	self.loadCharacterList = {}

	self:PlaySceneTimeline(arg_8_1, arg_8_2, function()
		self:Stop()

		return
	end)

	return
end

function IslandTimelineMgr:PlaySceneTimeline(arg_10_1, arg_10_2, arg_10_3)
	setActive(self.skipBtn, false)

	local var_10_0 = pg.island_scene_timeline[arg_10_1]

	assert(pg.island_scene_timeline[arg_10_1], "island_scene_timeline >>>>" .. arg_10_1)

	local var_10_1 = IslandSceneSwitcher.New()

	self:Mask()
	seriesAsync({
		function(arg_11_0)
			var_10_1:Load(var_10_0.name, nil, {
				function(arg_12_0)
					arg_12_0()
					arg_11_0()

					return
				end
			}, 2)

			return
		end,
		function(arg_13_0)
			self:ApplyReplace(var_10_0, arg_10_2, arg_13_0)

			return
		end,
		function(arg_14_0)
			onNextTick(arg_14_0)

			return
		end,
		function(arg_15_0)
			setActive(self.skipBtn, true)
			self:PlayTimeline(var_10_0.sequence, arg_15_0)

			return
		end,
		function(arg_16_0)
			if not self:IsPlaying() then
				arg_16_0()

				return
			end

			self:UnloadCharacter()
			self:RevertReplace()
			var_10_1:UnLoad()
			_IslandCore:GetView().weatherSystem:Play()
			gcAll(false)
			SceneOpMgr.Inst:SetActiveSceneByIndex(1)
			arg_16_0()

			return
		end
	}, arg_10_3)

	self.sceneLoader = var_10_1

	return
end

function IslandTimelineMgr:RevertReplace()
	for iter_17_0, iter_17_1 in ipairs(self.revertGo or {}) do
		setParent(iter_17_1.go, iter_17_1.container)

		iter_17_1.go.transform.localPosition = iter_17_1.position
		iter_17_1.go.transform.localEulerAngles = iter_17_1.rotation
		iter_17_1.go.transform.localScale = iter_17_1.scale

		if _IslandCore and iter_17_1.unitId >= 0 then
			if iter_17_1.unitId == 0 then
				local var_17_1 = _IslandCore:GetView().player or _IslandCore:GetView():GetUnitModule(iter_17_1.unitId)

				if var_17_1 then
					var_17_1:Enable()
				end
			end
		end
	end

	self.revertGo = {}

	return
end

function IslandTimelineMgr:ApplyReplace(arg_18_1, arg_18_2, arg_18_3)
	self:ReplcaeCamTracks(arg_18_1.sequence)

	if #arg_18_1.obj <= 0 then
		arg_18_3()

		return
	end

	local var_18_0 = {}

	self.revertGo = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.obj) do
		local var_18_1 = arg_18_1.tracks[iter_18_0]

		table.insert(var_18_0, function(arg_19_0)
			self:ReplaceTimelineRes(iter_18_1, var_18_1, arg_18_2, arg_19_0)

			return
		end)
	end

	parallelAsync(var_18_0, arg_18_3)

	return
end

function IslandTimelineMgr:ReplaceTimelineRes(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_1[1]
	local var_20_1 = BuildVector3(arg_20_1[2])
	local var_20_2 = BuildVector3(arg_20_1[3])
	local var_20_3 = arg_20_1[4][2]
	local var_20_4 = {}
	local var_20_5
	local var_20_6 = false
	local var_20_7 = -1

	if arg_20_1[4][1] == IslandConst.TIMELINE_REPLACE_TYPE_CREATE then
		table.insert(var_20_4, function(arg_21_0)
			self:LoadCharacter(var_20_3, function(arg_22_0)
				var_20_5 = arg_22_0

				arg_21_0()

				return
			end)

			return
		end)
	elseif arg_20_1[4][1] == IslandConst.TIMELINE_REPLACE_TYPE_PLAYER then
		if _IslandCore then
			local var_20_8 = _IslandCore:GetView().player

			if var_20_8 then
				var_20_7 = 0

				var_20_8:Disable()

				var_20_5 = var_20_8._go
			end
		end

		var_20_6 = true
	elseif arg_20_1[4][1] == IslandConst.TIMELINE_REPLACE_TYPE_GEN_OBJ then
		if _IslandCore then
			local var_20_9 = _IslandCore:GetView():GetUnitModule(arg_20_1[4][2])

			if var_20_9 then
				var_20_7 = var_20_9.id

				var_20_9:Disable()

				var_20_5 = var_20_9._go
			end
		end

		var_20_6 = true
	elseif arg_20_1[4][1] == IslandConst.TIMELINE_REPLACE_TYPE_STATIC_OBJ then
		var_20_5 = GameObject.Find(arg_20_1[4][2])
		var_20_6 = true
	elseif arg_20_1[4][1] == IslandConst.TIMELINE_REPLACE_TYPE_CODE_OBJ then
		table.insert(var_20_4, function(arg_23_0)
			self:LoadCharacter(arg_20_3[1], function(arg_24_0)
				var_20_5 = arg_24_0

				arg_23_0()

				return
			end)

			return
		end)
	end

	if var_20_6 and var_20_5 then
		table.insert(self.revertGo, {
			go = var_20_5,
			container = var_20_5.transform.parent,
			position = var_20_5.transform.localPosition,
			rotation = var_20_5.transform.localEulerAngles,
			scale = var_20_5.transform.localScale,
			unitId = var_20_7
		})
	end

	table.insert(var_20_4, function(arg_25_0)
		if not var_20_5 then
			arg_25_0()

			return
		end

		setActive(var_20_5, true)
		setParent(var_20_5, (GameObject.Find(var_20_0)))

		var_20_5.transform.localPosition = var_20_1
		var_20_5.transform.localEulerAngles = var_20_2

		self:ReplaceTracks(var_20_5, arg_20_2, arg_25_0)

		return
	end)
	seriesAsync(var_20_4, arg_20_4)

	return
end

local function var_0_4(arg_26_0, arg_26_1)
	if arg_26_1 == "Animator" then
		local var_26_0 = arg_26_0.transform:GetChild(0):GetComponent(typeof(Animator))

		if var_26_0 then
			return var_26_0
		end

		return (GetOrAddComponent(arg_26_0, typeof(Animator)))
	elseif arg_26_1 == "Transform" then
		return arg_26_0.transform
	else
		return arg_26_0
	end

	return
end

function IslandTimelineMgr:ReplaceTracks(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		var_27_0[iter_27_1[1]] = var_27_0[iter_27_1[1]] or {}

		table.insert(var_27_0[iter_27_1[1]], {
			iter_27_1[2],
			iter_27_1[3]
		})
	end

	for iter_27_2, iter_27_3 in pairs(var_27_0) do
		local var_27_1 = GameObject.Find(iter_27_2):GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
		local var_27_2 = TimelineHelper.GetTimelineTracks(var_27_1):ToTable()
		local var_27_3 = {}

		for iter_27_4, iter_27_5 in ipairs(var_27_2) do
			var_27_3[iter_27_5.name] = iter_27_5
		end

		for iter_27_6, iter_27_7 in ipairs(iter_27_3) do
			local var_27_4 = tonumber(iter_27_7[1])

			if var_27_4 then
				local var_27_5 = var_27_2[var_27_4 + 1] or var_27_3[iter_27_7[1]]

				if var_27_5 then
					TimelineHelper.SetSceneBinding(var_27_1, var_27_5, var_0_4(arg_27_1, iter_27_7[2]))
				end
			end
		end
	end

	arg_27_3()

	return
end

function IslandTimelineMgr:ReplcaeCamTracks(arg_28_1)
	local var_28_0 = GameObject.Find(arg_28_1)

	if not var_28_0 then
		return
	end

	for iter_28_0, iter_28_1 in ipairs((var_28_0.transform:GetComponentsInChildren(typeof(UnityEngine.Playables.PlayableDirector), true):ToTable())) do
		for iter_28_2, iter_28_3 in ipairs((TimelineHelper.GetTimelineTracks(iter_28_1):ToTable())) do
			if iter_28_3:GetType():ToString() == "CinemachineTrack" then
				TimelineHelper.SetSceneBinding(iter_28_1, iter_28_3, IslandCameraMgr.instance.cinemachineBrain)
			end
		end
	end

	return
end

function IslandTimelineMgr:LoadCharacter(arg_29_1, arg_29_2)
	local var_29_0 = pg.island_unit_character[arg_29_1]

	self:GetPoolMgr():GetCharacter(pg.island_unit_character[arg_29_1].model, pg.island_unit_character[arg_29_1].animator, function(arg_30_0)
		table.insert(self.loadCharacterList, {
			data = var_29_0,
			go = arg_30_0
		})
		arg_29_2(arg_30_0)

		return
	end)

	return
end

function IslandTimelineMgr:UnloadCharacter(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(self.loadCharacterList) do
		self:GetPoolMgr():ReturnCharacter(iter_31_1.data.model, iter_31_1.data.animator, iter_31_1.go)
	end

	self.loadCharacterList = {}

	return
end

function IslandTimelineMgr:Mask()
	self.maskCG.alpha = 1
	self.maskCG.blocksRaycasts = true

	return
end

function IslandTimelineMgr:UnMask()
	self.maskCG.alpha = 0
	self.maskCG.blocksRaycasts = false

	return
end

function IslandTimelineMgr:PlayTimeline(arg_34_1, arg_34_2)
	if not self:IsPlaying() then
		arg_34_2()

		return
	end

	self:UnMask()

	local var_34_0 = GameObject.Find(arg_34_1)

	assert(var_34_0, arg_34_1)

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	local var_34_2 = GetOrAddComponent(var_34_0, "DftCommonSignalReceiver")

	var_34_2:SetCommonEvent(function(arg_35_0)
		if arg_35_0.stringParameter == "TimelineEnd" then
			var_34_1:Stop()
			var_34_2:SetCommonEvent(nil)

			self.dftCommonSignalReceiver = nil
			self.playableDirector = nil

			arg_34_2()
		end

		return
	end)
	var_34_1:Play()

	self.playableDirector = var_34_1
	self.dftCommonSignalReceiver = var_34_2

	return
end

function IslandTimelineMgr:Stop()
	self:UnloadCharacter()
	self:RevertReplace()

	if self.playableDirector then
		self.playableDirector:Stop()

		self.playableDirector = nil
	end

	if self.dftCommonSignalReceiver then
		self.dftCommonSignalReceiver:SetCommonEvent(nil)

		self.dftCommonSignalReceiver = nil
	end

	if self.sceneLoader then
		self.sceneLoader:UnLoad()
		SceneOpMgr.Inst:SetActiveSceneByIndex(1)

		self.sceneLoader = nil
	end

	if self.callback then
		self.callback()
	end

	self.callback = nil
	self.state = var_0_3

	self:Hide()

	return
end

function IslandTimelineMgr:Hide()
	IslandTimelineMgr.super.Hide(self)
	self:UnMask()

	return
end

function IslandTimelineMgr:OnDestroy()
	if self:isShowing() then
		self:Stop()
	end

	return
end

return IslandTimelineMgr
