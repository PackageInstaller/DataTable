local Dorm3dVolleyballScene = class("Dorm3dVolleyballScene", import("view.dorm3d.Game.Dorm3dGameTemplate"))
local var_0_1 = "ui-dorm_countdown"
local var_0_2 = "ui-dorm_qte_appear"
local var_0_3 = "ui-dorm_qte_hit"
local var_0_4 = "ui-dorm_qte_citical"
local var_0_5 = "ui-dorm_qte_miss"
local var_0_6 = "ui-dorm_scoring"
local var_0_7 = "ui-dorm_victory"
local var_0_8 = "ui-dorm_pop_up"

Dorm3dVolleyballScene.QTE_RESULT = {
	MISS = "Miss",
	PERFECT = "Critical",
	HIT = "Hit"
}
Dorm3dVolleyballScene.ROUND_RESULT = {
	OUR_WIN = 1,
	OTHER_WIN = 2
}
Dorm3dVolleyballScene.GAME_RESULT = {
	DEFEAT = 2,
	VICTORY = 1
}
Dorm3dVolleyballScene.hitRadiusMax = 231
Dorm3dVolleyballScene.hitRadiusMin = 50
Dorm3dVolleyballScene.perfectRadiusMax = 139
Dorm3dVolleyballScene.perfectRadiusMin = 85
Dorm3dVolleyballScene.perfectScaleRandoms = {
	0.7,
	1.7
}
Dorm3dVolleyballScene.triggerRadius = 255
Dorm3dVolleyballScene.endScore = 6
Dorm3dVolleyballScene.BallInitPos = Vector3(22, 4.5, -22.4)
Dorm3dVolleyballScene.BallSpeed = 0.1
Dorm3dVolleyballScene.BallQTESpeed = 0.01
Dorm3dVolleyballScene.BallRandomDelat = {
	Top = 300,
	Left = 300,
	Bottom = 300,
	Right = 300
}

function Dorm3dVolleyballScene:getUIName()
	return "Dorm3dVolleyballUI"
end

function Dorm3dVolleyballScene:Ctor(...)
	Dorm3dVolleyballScene.super.Ctor(self, ...)

	self.loader = AutoLoader.New()

	return
end

function Dorm3dVolleyballScene:preload(arg_3_1)
	self:SetApartment(getProxy(ApartmentProxy):getApartment(self.contextData.groupId))

	self.volleyballCfg = pg.dorm3d_volleyball[self.contextData.groupId]
	self.sceneRootName = "beach"
	self.sceneName = "map_beach_01"
	self.timelineSceneRootName = pg.dorm3d_dorm_template[self.contextData.groupId].asset_name
	self.timelineSceneName = self.volleyballCfg.scene_name

	seriesAsync({
		function(arg_4_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. self.sceneRootName .. "/" .. self.sceneName .. "_scene"), self.sceneName, LoadSceneMode.Additive, function(arg_5_0, arg_5_1)
				self:InitGameParam()
				SceneManager.SetActiveScene(arg_5_0)
				arg_4_0()

				return
			end)

			return
		end,
		function(arg_6_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/character/" .. self.timelineSceneRootName .. "/timeline/" .. self.timelineSceneName .. "/" .. self.timelineSceneName .. "_scene"), self.timelineSceneName, LoadSceneMode.Additive, function(arg_7_0, arg_7_1)
				arg_6_0()

				return
			end)

			return
		end
	}, arg_3_1)

	return
end

function Dorm3dVolleyballScene:InitGameParam()
	Dorm3dVolleyballScene.BallSpeed = self.volleyballCfg.BallSpeedParam[1]
	Dorm3dVolleyballScene.BallQTESpeed = self.volleyballCfg.BallSpeedParam[2]
	Dorm3dVolleyballScene.endScore = self.volleyballCfg.endScore

	return
end

function Dorm3dVolleyballScene:init()
	self:initUI()
	self:initScene()
	self:BindEvent()

	local var_9_0 = Dorm3dHxHelper.GetTimelineMainCharacter()

	Dorm3dHxHelper.ReplaceCharacterParts(var_9_0)
	Dorm3dHxHelper.HideCharacterPart(var_9_0, nil, true)
	Dorm3dHxHelper.ShowHolyLight({
		var_9_0
	}, self.holyLightRoot)

	return
end

function Dorm3dVolleyballScene:initUI()
	self.skipUI = self._tf:Find("SkipUI")

	setActive(self.skipUI, false)

	self.gameUI = self._tf:Find("GameUI")

	setText(self.gameUI:Find("Title/Text"), i18n("dorm3d_volleyball_title"))

	self.ourScoreTF = self.gameUI:Find("Score/Content/Left")
	self.otherScoreTF = self.gameUI:Find("Score/Content/Right")
	self.qteTF = self.gameUI:Find("QTE")
	self.qteTriggerTF = self.gameUI:Find("QTE/animroot/Trigger")

	setActive(self.qteTF, false)
	setActive(self.gameUI, false)
	self.gameUI:Find("Count"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		if not self.isStartGame then
			return
		end

		self.isStartGame = false

		setActive(self.gameUI:Find("Count"), false)
		self:StartOneRound()
		setActive(self.gameUI:Find("Score"), true)

		return
	end)

	self.scoreUI = self._tf:Find("ScoreUI")

	setActive(self.scoreUI, false)

	self.endUI = self._tf:Find("EndUI")

	setActive(self.endUI, false)

	self.resultUI = self._tf:Find("ResultUI")

	setActive(self.resultUI, false)
	setText(self.resultUI:Find("AgainBtn/Text"), i18n("dorm3d_minigame_again"))
	setText(self.resultUI:Find("CloseBtn/Text"), i18n("dorm3d_minigame_close"))
	self.scoreUI:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		if not self.isEndOneRound then
			return
		end

		self.isEndOneRound = false

		quickPlayAnimation(self.scoreUI, "Anim_Dorm3d_volleyball_score_out")
		onDelayTick(function()
			setActive(self.scoreUI, false)

			return
		end, 0.1)

		if self:CheckEndGame() then
			self:EndGame()
		else
			setActive(self.gameUI, true)
			self:StartOneRound()
		end

		return
	end)

	local var_10_0 = self._tf:Find("Debug")

	setActive(var_10_0, false)

	self.debugTimelineName = var_10_0:Find("Timeline"):GetComponent(typeof(Text))
	self.debugTrackName = var_10_0:Find("Track"):GetComponent(typeof(Text))
	self.holyLightRoot = self._tf:Find("HolyLightRoot")

	return
end

function Dorm3dVolleyballScene:BindEvent()
	onButton(self, self.gameUI:Find("Title/BackBtn"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.gameUI, function()
		if not self.startQTEUI then
			return
		end

		self:EndQTE()

		return
	end)
	onButton(self, self.skipUI:Find("SkipBtn"), function()
		setActive(self.skipUI, false)
		self:StopPlayingTimeline()
		self:StartGame()

		return
	end, SFX_PANEL)
	onButton(self, self.endUI, function()
		self:emit(Dorm3dGameMediatorTemplate.TRIGGER_FAVOR, self.apartment.configId)

		return
	end, SFX_PANEL)
	onButton(self, self.resultUI:Find("AgainBtn"), function()
		setActive(self.resultUI, false)
		self:StartGame()

		return
	end, SFX_PANEL)
	onButton(self, self.resultUI:Find("CloseBtn"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function Dorm3dVolleyballScene:initScene()
	table.IpairsCArray(SceneManager.GetSceneByName(self.sceneName):GetRootGameObjects(), function(arg_22_0, arg_22_1)
		if arg_22_1.name == "[MainBlock]" then
			self.modelRoot = tf(arg_22_1):Find("[Model]/scene_root")
			self.ballTF = self.modelRoot:Find("fbx/litmap05/pre_db_sportinggoods03")
			self.ballTF.position = Dorm3dVolleyballScene.BallInitPos

			setActive(self.ballTF, false)
		elseif arg_22_1.name == "MainCamera" then
			self.mainCamera = arg_22_1.transform

			setActive(self.mainCamera, false)
		elseif arg_22_1.name == "PlayerCamera" then
			self.ballCamera = arg_22_1.transform
			self.ballCameraComp = self.ballCamera:GetComponent(typeof(Camera))

			setActive(self.ballCamera, false)
		elseif arg_22_1.name == "TriggerPlane" then
			setActive(arg_22_1, false)

			local var_22_0 = tf(arg_22_1):Find("BallCreate")
			local var_22_1 = var_22_0:GetComponent(typeof(UnityEngine.MeshCollider)).sharedMesh

			self.ballCreatePlane = Plane.New(var_22_1.normals[0], -Vector3.Dot(var_22_0.position, var_22_1.normals[0]))

			local var_22_2 = tf(arg_22_1):Find("BallQte")

			setLocalPosition(var_22_2, Vector3(self.volleyballCfg.BallQtePlane[1][1], self.volleyballCfg.BallQtePlane[1][2], self.volleyballCfg.BallQtePlane[1][3]))
			setLocalEulerAngles(var_22_2, Vector3(self.volleyballCfg.BallQtePlane[2][1], self.volleyballCfg.BallQtePlane[2][2], self.volleyballCfg.BallQtePlane[2][3]))

			local var_22_3 = var_22_2:GetComponent(typeof(UnityEngine.MeshCollider)).sharedMesh

			self.ballQtePlane = Plane.New(var_22_3.normals[0], -Vector3.Dot(var_22_2.position, var_22_3.normals[0]))

			local var_22_4 = tf(arg_22_1):Find("BallMiss")

			setLocalPosition(var_22_4, Vector3(self.volleyballCfg.BallMissPlane[1][1], self.volleyballCfg.BallMissPlane[1][2], self.volleyballCfg.BallMissPlane[1][3]))
			setLocalEulerAngles(var_22_4, Vector3(self.volleyballCfg.BallMissPlane[2][1], self.volleyballCfg.BallMissPlane[2][2], self.volleyballCfg.BallMissPlane[2][3]))

			local var_22_5 = var_22_4:GetComponent(typeof(UnityEngine.MeshCollider)).sharedMesh

			self.ballMissPlane = Plane.New(var_22_5.normals[0], -Vector3.Dot(var_22_4.position, var_22_5.normals[0]))
		end

		return
	end)
	self:InitLightSettings()

	self.totalDirectorList = {}

	table.IpairsCArray(SceneManager.GetSceneByName(self.timelineSceneName):GetRootGameObjects(), function(arg_23_0, arg_23_1)
		local var_23_0 = tf(arg_23_1):Find("[sequence]")

		if IsNil(var_23_0) then
			return
		end

		local var_23_1 = var_23_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		var_23_1.playOnAwake = false

		var_23_1:Stop()

		for iter_23_0, iter_23_1 in ipairs((var_23_0:GetComponentsInChildren(typeof(UnityEngine.Playables.PlayableDirector)):ToTable())) do
			iter_23_1.playOnAwake = false

			iter_23_1:Stop()
		end

		table.insert(self.totalDirectorList, {
			name = arg_23_1.name,
			director = var_23_1
		})
		setActive(arg_23_1, false)

		return
	end)

	return
end

function Dorm3dVolleyballScene:InitLightSettings()
	self.globalVolume = GameObject.Find("GlobalVolume")
	self.characterLight = GameObject.Find("CharacterLight")

	table.IpairsCArray(GameObject.Find("[Lighting]").transform:GetComponentsInChildren(typeof(Light)), function(arg_25_0, arg_25_1)
		arg_25_1.shadows = UnityEngine.LightShadows.None

		return
	end)

	return
end

function Dorm3dVolleyballScene:didEnter()
	self:InitData()
	setActive(self.skipUI, true)
	self:PlayTimeline({
		name = self:GetWeightTimeline("jinchang")
	}, function()
		if not self.playingFlag then
			setActive(self.skipUI, false)
			self:StartGame()
		end

		return
	end)

	return
end

function Dorm3dVolleyballScene:InitData()
	return
end

function Dorm3dVolleyballScene:PlayTimeline(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.name
	local var_29_2 = _.detect(self.totalDirectorList, function(arg_30_0)
		return arg_30_0.name == var_29_0
	end)

	assert(var_29_2, "Missing director " .. arg_29_1.name)
	self:StopPlayingTimeline(tobool(var_29_2))

	if not var_29_2 then
		existCall(arg_29_2)

		return
	end

	local var_29_3 = {}

	self.playingDirector = var_29_2.director

	local var_29_4 = self.playingDirector.transform

	self.debugTimelineName.text = self.playingDirector.transform.parent.name

	table.insert(var_29_3, function(arg_31_0)
		if arg_29_1.time then
			self.playingDirector.time = math.clamp(arg_29_1.time, 0, self.playingDirector.duration)
		end

		TimelineSupport.InitTimeline(self.playingDirector)

		local var_31_0 = {}

		GetOrAddComponent(var_29_4, "DftCommonSignalReceiver"):SetCommonEvent(function(arg_32_0)
			switch(arg_32_0.stringParameter, {
				TimelineRandomTrack = function()
					self:DoTimelineRandomTrack(self.playingDirector)

					return
				end,
				TimelineLoop = function()
					self.playingDirector.time = arg_32_0.floatParameter

					return
				end,
				TimelineEnd = function()
					var_31_0.finish = true

					self.playingDirector:Stop()
					setActive(tf(self.playingDirector).parent, false)

					return
				end
			}, function()
				warning("other event trigger:" .. arg_32_0.stringParameter)

				return
			end)

			if var_31_0.finish then
				self.timelineMark = var_31_0
				self.debugTimelineName.text = ""
				self.debugTrackName.text = ""

				arg_31_0()
			end

			return
		end)
		self.playingDirector:Evaluate()
		self:DoTimelineRandomTrack(self.playingDirector)
		setActive(tf(self.playingDirector).parent, true)
		self.playingDirector:Play()
		setActive(self.mainCamera, false)

		if self.activeDirectorInfo then
			self.lastDirectorInfo = self.activeDirectorInfo
		end

		self.activeDirectorInfo = var_29_2

		return
	end)
	seriesAsync(var_29_3, function()
		setActive(self.mainCamera, true)

		self.playingDirector = nil
		self.timelineMark = nil

		existCall(arg_29_2, self.timelineMark)

		return
	end)

	return
end

function Dorm3dVolleyballScene:StopPlayingTimeline(arg_38_1)
	if self.playingDirector then
		self.playingDirector:Stop()
		setActive(tf(self.playingDirector).parent, false)

		self.debugTimelineName.text = ""
		self.debugTrackName.text = ""
		self.playingDirector = nil

		if not arg_38_1 then
			setActive(self.mainCamera, true)
		end
	end

	return
end

function Dorm3dVolleyballScene:StartGame()
	setActive(self.mainCamera, true)

	self.playingFlag = true
	self.gameResult = nil
	self.ourScore, self.otherScore = 0, 0

	setActive(self.gameUI, true)
	setActive(self.gameUI:Find("Score"), false)
	setActive(self.gameUI:Find("Count"), true)

	self.isStartGame = true

	pg.CriMgr.GetInstance():PlaySE_V3(var_0_1)

	return
end

function Dorm3dVolleyballScene:UpdateGameScore()
	setText(self.ourScoreTF, self.ourScore)
	setText(self.otherScoreTF, self.otherScore)

	return
end

function Dorm3dVolleyballScene:UpdateScoreTpl(arg_41_1)
	setText(arg_41_1:Find("Left/Tens/Text"), 0)
	setText(arg_41_1:Find("Left/Units/Text"), self.ourScore % 10)
	setText(arg_41_1:Find("Right/Tens/Text"), 0)
	setText(arg_41_1:Find("Right/Units/Text"), self.otherScore % 10)

	return
end

function Dorm3dVolleyballScene:StartOneRound()
	self:UpdateGameScore()

	self.roundEndFlag = false
	self.roundResult = nil

	seriesAsync({
		function(arg_43_0)
			self:FaQiuOP(arg_43_0)

			return
		end,
		function(arg_44_0)
			self:OneQTE()

			return
		end
	})

	return
end

function Dorm3dVolleyballScene:OneQTE()
	seriesAsync({
		function(arg_46_0)
			self:StartQTE(arg_46_0)

			return
		end,
		function(arg_47_0)
			switch(self.qteResult, {
				[Dorm3dVolleyballScene.QTE_RESULT.MISS] = function()
					self:QteMissOP(function()
						self.roundEndFlag = true
						self.roundResult = Dorm3dVolleyballScene.ROUND_RESULT.OTHER_WIN

						arg_47_0()

						return
					end)

					return
				end,
				[Dorm3dVolleyballScene.QTE_RESULT.HIT] = function()
					self:QteHitOP(arg_47_0)

					return
				end,
				[Dorm3dVolleyballScene.QTE_RESULT.PERFECT] = function()
					self:QtePerfectOP(function()
						self.roundEndFlag = true
						self.roundResult = Dorm3dVolleyballScene.ROUND_RESULT.OUR_WIN

						arg_47_0()

						return
					end)

					return
				end
			}, function()
				assert(false, "unknow qte result" .. self.qteResult)

				return
			end)

			return
		end
	}, function()
		if not self.roundEndFlag then
			self:OneQTE()
		else
			self:EndOneRound()
		end

		return
	end)

	return
end

function Dorm3dVolleyballScene:EndOneRound()
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_6)

	self.isEndOneRound = true

	setActive(self.gameUI, false)
	self:UpdateScoreTpl(self.scoreUI:Find("ScoreTpl"))
	setText(self.scoreUI:Find("ScoreTpl/Left/Units/new/newText"), self.ourScore % 10)
	setText(self.scoreUI:Find("ScoreTpl/Right/Units/new/newText"), self.otherScore % 10)
	switch(self.roundResult, {
		[Dorm3dVolleyballScene.ROUND_RESULT.OUR_WIN] = function()
			self.ourScore = self.ourScore + 1

			setText(self.scoreUI:Find("ScoreTpl/Left/Units/new/newText"), self.ourScore % 10)
			setActive(self.scoreUI, true)
			quickPlayAnimation(self.scoreUI, "Anim_Dorm3d_volleyball_score_leftin")

			return
		end,
		[Dorm3dVolleyballScene.ROUND_RESULT.OTHER_WIN] = function()
			self.otherScore = self.otherScore + 1

			setText(self.scoreUI:Find("ScoreTpl/Right/Units/new/newText"), self.otherScore % 10)
			setActive(self.scoreUI, true)
			quickPlayAnimation(self.scoreUI, "Anim_Dorm3d_volleyball_score_rightin")

			return
		end
	}, function()
		assert(false, "unknow round result" .. self.roundResult)

		return
	end)

	return
end

function Dorm3dVolleyballScene:CheckEndGame()
	if self.ourScore >= Dorm3dVolleyballScene.endScore then
		self.gameResult = Dorm3dVolleyballScene.GAME_RESULT.VICTORY

		return true
	end

	if self.otherScore >= Dorm3dVolleyballScene.endScore then
		self.gameResult = Dorm3dVolleyballScene.GAME_RESULT.DEFEAT

		return true
	end

	return false
end

function Dorm3dVolleyballScene:EndGame()
	if self.gameResult == Dorm3dVolleyballScene.GAME_RESULT.VICTORY then
		pg.CriMgr.GetInstance():PlaySE_V3(var_0_7)
	end

	seriesAsync({
		function(arg_61_0)
			self:PlayTimeline({
				name = self:GetWeightTimeline(self.gameResult == Dorm3dVolleyballScene.GAME_RESULT.VICTORY and "shibai" or "shengli")
			}, arg_61_0)

			return
		end
	}, function()
		self:PlayTimeline({
			name = self:GetWeightTimeline("daiji")
		}, function()
			return
		end)
		setActive(self.endUI, true)
		setActive(self.endUI:Find("Title/Victory"), self.gameResult == Dorm3dVolleyballScene.GAME_RESULT.VICTORY)
		setActive(self.endUI:Find("Title/Defeat"), self.gameResult == Dorm3dVolleyballScene.GAME_RESULT.DEFEAT)
		self:UpdateScoreTpl(self.endUI:Find("ScoreTpl"))

		return
	end)

	return
end

function Dorm3dVolleyballScene:ShowResultUI(arg_64_1)
	(function()
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataRoom(self.contextData.roomId, 8, table.concat(self.contextData.groupIds or {
			self.contextData.groupId
		}, ","), self.ourScore .. ":" .. self.otherScore))

		return
	end)()
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_8)
	seriesAsync({
		function(arg_66_0)
			quickPlayAnimation(self.endUI, "Anim_Dorm3d_volleyball_end_out")
			onDelayTick(function()
				setActive(self.endUI, false)

				return
			end, 0.1)

			if self.gameResult == Dorm3dVolleyballScene.GAME_RESULT.VICTORY then
				self:PlayTimeline({
					name = self:GetWeightTimeline("jiangli")
				}, arg_66_0)
			else
				self:StopPlayingTimeline()
				arg_66_0()
			end

			return
		end
	}, function()
		setActive(self.resultUI, true)
		setText(self.resultUI:Find("Panel/Text"), i18n("volleyball_end_tip", self.apartment:getConfig("name")))

		if arg_64_1 and arg_64_1.cost > 0 then
			setActive(self.resultUI:Find("Panel/Award"), true)
			setText(self.resultUI:Find("Panel/Award/Text"), i18n("volleyball_end_award", self.apartment:getConfig("name")))
		else
			setActive(self.resultUI:Find("Panel/Award"), false)
		end

		gcAll()

		return
	end)

	return
end

function Dorm3dVolleyballScene:FaQiuOP(arg_69_1)
	self:PlayTimeline({
		name = self:GetWeightTimeline("faqiu")
	}, arg_69_1)

	return
end

function Dorm3dVolleyballScene:StartQTE(arg_70_1)
	self.qteCallback = arg_70_1

	setActive(self.ballCamera, true)
	setActive(self.mainCamera, false)

	self.randomScreenPos = Vector2(math.random(Dorm3dVolleyballScene.BallRandomDelat.Left, Screen.width - Dorm3dVolleyballScene.BallRandomDelat.Right), math.random(Dorm3dVolleyballScene.BallRandomDelat.Bottom, Screen.height - Dorm3dVolleyballScene.BallRandomDelat.Top))

	local var_70_0 = self.ballCameraComp:ScreenPointToRay(self.randomScreenPos)

	self.randomScale = math.random(Dorm3dVolleyballScene.perfectScaleRandoms[1] * 10, self.perfectScaleRandoms[2] * 10) / 10

	local var_70_1, var_70_2 = Plane.New(self.ballQtePlane.normal, self.ballQtePlane.distance + (self.ballMissPlane.distance - self.ballQtePlane.distance) * (1 - (Dorm3dVolleyballScene.perfectRadiusMax + Dorm3dVolleyballScene.perfectRadiusMin) / 2 * self.randomScale / Dorm3dVolleyballScene.triggerRadius)):Raycast(var_70_0)

	assert(var_70_1, "retPerfect plane not in view")

	self.ballDir = (var_70_0:GetPoint(var_70_2) - Dorm3dVolleyballScene.BallInitPos):Normalize()

	local var_70_3 = Ray.New(self.ballDir, Dorm3dVolleyballScene.BallInitPos)
	local var_70_4, var_70_5 = self.ballQtePlane:Raycast(var_70_3)

	assert(var_70_4, "qte plane not in view")

	local var_70_6, var_70_7 = self.ballMissPlane:Raycast(var_70_3)

	assert(var_70_6, "miss plane not in view")

	local var_70_8 = 0

	self.qteUITime = (var_70_3:GetPoint(var_70_5) - var_70_3:GetPoint(var_70_7)):Magnitude() / Dorm3dVolleyballScene.BallQTESpeed
	self.ballTimer = Timer.New(function()
		if var_70_8 >= var_70_7 then
			self.ballTimer:Stop()

			self.ballTimer = nil

			setActive(self.ballTF, false)

			self.ballTF.position = Dorm3dVolleyballScene.BallInitPos

			if self.startQTEUI then
				setLocalScale(self.qteTriggerTF, {
					x = 0,
					y = 0
				})
				self:EndQTE(Dorm3dVolleyballScene.QTE_RESULT.MISS)
			end
		elseif var_70_8 >= var_70_5 then
			var_70_8 = var_70_8 + Dorm3dVolleyballScene.BallQTESpeed
			self.ballTF.position = var_70_3:GetPoint(var_70_8)

			if not self.startQTEUI then
				self:StartQTEUI()
			end

			self.curScale = self.curScale - 1 / self.qteUITime

			setLocalScale(self.qteTriggerTF, {
				x = self.curScale,
				y = self.curScale
			})

			self.curRadius = Dorm3dVolleyballScene.triggerRadius * self.curScale

			if self.curScale < 0 then
				self:EndQTE()
			end
		else
			var_70_8 = var_70_8 + Dorm3dVolleyballScene.BallSpeed
			self.ballTF.position = var_70_3:GetPoint(var_70_8)
		end

		return
	end, 0.016666666666666666, -1)

	setActive(self.ballTF, true)
	self.ballTimer:Start()

	return
end

function Dorm3dVolleyballScene:StartQTEUI()
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_2)
	setLocalScale(self.qteTriggerTF, {
		x = 1,
		y = 1
	})
	eachChild(self.qteTF:Find("animroot/Result"), function(arg_73_0)
		setActive(arg_73_0, false)

		return
	end)

	self.qteResult = nil
	self.curRadius = Dorm3dVolleyballScene.triggerRadius
	self.curPerfectRadiusMax = Dorm3dVolleyballScene.perfectRadiusMax * self.randomScale
	self.curPerfectRadiusMin = Dorm3dVolleyballScene.perfectRadiusMin * self.randomScale

	setLocalScale(self.qteTF:Find("animroot/Perfect"), {
		x = self.randomScale,
		y = self.randomScale
	})

	self.curScale = 1

	setLocalPosition(self.qteTF, LuaHelper.ScreenToLocal(self.qteTF.parent, self.randomScreenPos, pg.UIMgr.GetInstance().uiCameraComp))
	setActive(self.qteTF, true)

	self.startQTEUI = true

	return
end

function Dorm3dVolleyballScene:EndQTE(arg_74_1)
	self.startQTEUI = nil

	setActive(self.mainCamera, true)
	setActive(self.ballCamera, false)

	self.qteResult = arg_74_1 and arg_74_1 or (self.curRadius < Dorm3dVolleyballScene.hitRadiusMin or self.curRadius > Dorm3dVolleyballScene.hitRadiusMax) and Dorm3dVolleyballScene.QTE_RESULT.MISS or self.curRadius <= self.curPerfectRadiusMax and self.curRadius >= self.curPerfectRadiusMin and Dorm3dVolleyballScene.QTE_RESULT.PERFECT or Dorm3dVolleyballScene.QTE_RESULT.HIT

	eachChild(self.qteTF:Find("animroot/Result"), function(arg_75_0)
		setActive(arg_75_0, arg_75_0.name == self.qteResult)

		return
	end)

	if self.ballTimer then
		self.ballTimer:Stop()

		self.ballTimer = nil

		setActive(self.ballTF, false)

		self.ballTF.position = Dorm3dVolleyballScene.BallInitPos
	end

	if self.qteCallback then
		self.qteCallback()

		self.qteCallback = nil
	end

	onDelayTick(function()
		setActive(self.qteTF, false)

		return
	end, 1)

	return
end

function Dorm3dVolleyballScene:QteMissOP(arg_77_1)
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_5)
	self:PlayTimeline({
		name = self:GetWeightTimeline("shiqiu")
	}, arg_77_1)

	return
end

function Dorm3dVolleyballScene:QteHitOP(arg_78_1)
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_3)
	seriesAsync({
		function(arg_79_0)
			self:PlayTimeline({
				name = self:GetWeightTimeline("fly")
			}, arg_79_0)

			return
		end,
		function(arg_80_0)
			self:PlayTimeline({
				name = self:GetWeightTimeline("jieqiu")
			}, arg_80_0)

			return
		end
	}, arg_78_1)

	return
end

function Dorm3dVolleyballScene:QtePerfectOP(arg_81_1)
	pg.CriMgr.GetInstance():PlaySE_V3(var_0_4)
	seriesAsync({
		function(arg_82_0)
			self:PlayTimeline({
				name = self:GetWeightTimeline("max_fly")
			}, arg_82_0)

			return
		end,
		function(arg_83_0)
			self:PlayTimeline({
				name = self:GetWeightTimeline("shouji")
			}, arg_83_0)

			return
		end
	}, arg_81_1)

	return
end

function Dorm3dVolleyballScene:GetWeightTimeline(arg_84_1)
	local var_84_0 = self.volleyballCfg[arg_84_1]

	assert(self.volleyballCfg[arg_84_1] ~= "", "volleyball cfg is empty string" .. arg_84_1)
	assert(#var_84_0 ~= 0, "volleyball cfg is empty table:" .. arg_84_1)

	local var_84_1 = math.random() * underscore.reduce(var_84_0, 0, function(arg_85_0, arg_85_1)
		return arg_85_0 + arg_85_1[2]
	end)
	local var_84_2 = 0

	for iter_84_0, iter_84_1 in ipairs(var_84_0) do
		var_84_2 = var_84_2 + iter_84_1[2]

		if var_84_1 <= var_84_2 then
			return iter_84_1[1]
		end
	end

	return
end

function Dorm3dVolleyballScene:DoTimelineRandomTrack(arg_86_1)
	local var_86_0 = {}

	for iter_86_0, iter_86_1 in ipairs(TimelineHelper.GetTimelineTracks(arg_86_1):ToTable()) do
		if iter_86_1.name ~= "Markers" then
			iter_86_1.muted = true

			table.insert(var_86_0, iter_86_1)
		end
	end

	if #var_86_0 > 0 then
		local var_86_1 = var_86_0[math.random(#var_86_0)]

		underscore.each(var_86_0, function(arg_87_0)
			if arg_87_0.name == var_86_1.name then
				arg_87_0.muted = false
			end

			return
		end)

		self.debugTrackName.text = var_86_1.name
	else
		self.debugTrackName.text = "track cnt 0"
	end

	return
end

function Dorm3dVolleyballScene:OnPause()
	if self.ballTimer then
		self.ballTimer:Stop()
	end

	if self.playingDirector then
		self.playingDirector:Pause()
	end

	return
end

function Dorm3dVolleyballScene:OnResume()
	if self.ballTimer then
		self.ballTimer:Start()
	end

	if self.playingDirector then
		self.playingDirector:Play()
	end

	return
end

function Dorm3dVolleyballScene:onBackPressed()
	if not self.playingFlag or isActive(self.gameUI:Find("Count")) or isActive(self.endUI) then
		return
	end

	self:OnPause()
	pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
		contentText = i18n("sure_exit_volleyball"),
		onConfirm = function()
			self:emit(Dorm3dVolleyballScene.ON_BACK)

			return
		end,
		onClose = function()
			self:OnResume()

			return
		end
	})

	return
end

function Dorm3dVolleyballScene:willExit()
	self.loader:Clear()

	if self.ballTimer then
		self.ballTimer:Stop()

		self.ballTimer = nil
	end

	seriesAsync(underscore.map({
		{
			path = string.lower("dorm3d/character/" .. self.timelineSceneRootName .. "/timeline/" .. self.timelineSceneName .. "/" .. self.timelineSceneName .. "_scene"),
			name = self.timelineSceneName
		},
		{
			path = string.lower("dorm3d/scenesres/scenes/common/" .. self.sceneRootName .. "/" .. self.sceneName .. "_scene"),
			name = self.sceneName
		}
	}, function(arg_94_0)
		return function(arg_95_0)
			SceneOpMgr.Inst:UnloadSceneAsync(arg_94_0.path, arg_94_0.name, arg_95_0)

			return
		end
	end), function()
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.LightmapSettings"), "lightmaps", nil, nil)

		return
	end)

	return
end

return Dorm3dVolleyballScene
