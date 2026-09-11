return {
	LoadPuzzleLevel = function(self, arg_1_1)
		local var_1_0 = SceneManager.GetSceneByName("X103")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		if self.operation_ then
			return
		end

		self.callback_ = arg_1_1
		self.operation_ = Asset.LoadLevelAsync("Levels/X103", true)
		self.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = FrameTimer.New(handler(self, self.Process), 1, -1)

		self.timer_:Start()
	end,
	Process = function(self)
		if self.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("puzzleMain") then
				local var_2_0 = SceneManager.GetSceneByName("X103")

				if var_2_0 and var_2_0.isLoaded == true then
					SceneManager.UnloadSceneAsync("X103")
				end
			end

			if self.timer_ then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self.operation_ = nil

			self:BindCfgUI()
			self:AdaptScreen()

			self.plauAnimCount_ = 0

			if self.callback_ then
				self.callback_()
			end

			self.callback_ = nil
		end
	end,
	UnLoadPuzzleLevel = function(self)
		if self.operation_ then
			return
		end

		if self.pieceList_ then
			for iter_3_0, iter_3_1 in ipairs(self.pieceList_) do
				iter_3_1:Dispose()
			end

			self.pieceList_ = nil
		end

		if self.bgScaleLeanTween_ then
			self.bgScaleLeanTween_:setOnComplete(nil)
			LeanTween.cancel(self.bgTrans_.gameObject)

			self.bgScaleLeanTween_ = nil
		end

		local var_3_0 = SceneManager.GetSceneByName("X103")

		if var_3_0 and var_3_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X103")
		end

		self.puzzleGo_ = nil
		self.puzzlePanelGo_ = nil
		self.puzzleAnswerGo_ = nil

		if self.raycaster_ ~= nil then
			Object.Destroy(self.raycaster_)
		end
	end,
	LevelIsDone = function(self)
		if self.operation_ then
			return self.operation_:IsDone()
		end

		return true
	end,
	BindCfgUI = function(arg_5_0)
		local var_5_0
		local var_5_1

		if SceneManager.GetSceneByName("X103").rootCount > 0 then
			var_5_0 = SceneManager.GetSceneByName("X103"):GetRootGameObjects()
		end

		if var_5_0 ~= nil then
			for iter_5_0 = 0, var_5_0.Length - 1 do
				if var_5_0[iter_5_0].name == "Bg" then
					var_5_1 = var_5_0[iter_5_0]
				end
			end
		end

		ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_5_1)
	end,
	AdaptScreen = function(self)
		self.bgTrans_.localScale = Vector3(1, 1, 1)

		local var_6_0 = Mathf.Max(manager.ui.mainCameraCom_.orthographicSize * 2 / Screen.height * Screen.width / self.bgRenderer_.bounds.size.x, manager.ui.mainCameraCom_.orthographicSize * 2 / self.bgRenderer_.bounds.size.y)

		self.adaptScale_ = Vector2(var_6_0, var_6_0)
		self.bgTrans_.localScale = self.adaptScale_
		self.bgTrans_.localPosition.y = self.bgTrans_.localPosition.y + (self.bgRenderer_.bounds.size.y * var_6_0 - manager.ui.mainCameraCom_.orthographicSize * 2) * 0.5
		self.bgTrans_.localPosition = self.bgTrans_.localPosition

		local var_6_1 = Mathf.Min(manager.ui.mainCameraCom_.orthographicSize * 2 / Screen.height * Screen.width / self.bgRenderer_.bounds.size.x, manager.ui.mainCameraCom_.orthographicSize * 2 / self.bgRenderer_.bounds.size.y)

		self.panelNewScale_ = Vector2(var_6_1, var_6_1)
		self.panelTrans_.localScale = self.panelNewScale_

		UnityEngine.Physics2D.SyncTransforms()
	end,
	InitPuzzlePiece = function(self, arg_7_1, arg_7_2, arg_7_3)
		self.pieceList_ = self.pieceList_ or {}

		local var_7_0 = Vector2(self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type, self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type)
		local var_7_1 = Vector3(-(self.puzzlePanelTrans_.rect.width * 0.5) + self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type * 0.5, self.puzzlePanelTrans_.rect.width * 0.5 - self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type * 0.5, 0)
		local var_7_2 = Vector3(0, 0, 0)
		local var_7_3 = 1

		for iter_7_0 = 0, ActivityPuzzleCfg[arg_7_1].type - 1 do
			for iter_7_1 = 0, ActivityPuzzleCfg[arg_7_1].type - 1 do
				if self.pieceList_[var_7_3] == nil then
					self.pieceList_[#self.pieceList_ + 1] = PuzzlePiece.New(self.puzzlePanelTrans_.childCount < var_7_3 and Object.Instantiate(self.pieceTemplate_, self.puzzlePanelTrans_) or self.puzzlePanelTrans_:GetChild(var_7_3 - 1).gameObject)
				end

				self.pieceList_[var_7_3]:SetSelectCallBack(arg_7_3)
				self.pieceList_[var_7_3]:SetData(arg_7_2[var_7_3], var_7_3, arg_7_1, var_7_0)

				var_7_2.x = iter_7_1 * (self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type)
				var_7_2.y = -iter_7_0 * (self.puzzlePanelTrans_.rect.width / ActivityPuzzleCfg[arg_7_1].type)
				self.pieceList_[var_7_3].transform_.localPosition = var_7_1 + var_7_2
				var_7_3 = var_7_3 + 1
			end
		end

		for iter_7_2 = var_7_3, #self.pieceList_ do
			self.pieceList_[iter_7_2]:SetActive(false)
		end

		UnityEngine.Physics2D.SyncTransforms()

		return self.pieceList_
	end,
	RefreshAnswer = function(self, arg_8_1)
		self.answerRenderer_.sprite = getSprite(ActivityPuzzleCfg[arg_8_1].path, ActivityPuzzleCfg[arg_8_1].picture_id)
	end,
	GetAnswerAnim = function(self)
		return self.answerAnim_
	end,
	SetPuzzleAnswerPanel = function(self, arg_10_1)
		SetActive(self.puzzleAnswerPanel_, arg_10_1)
	end,
	GetPanelNewScale = function(self)
		return self.panelNewScale_
	end,
	SetPuzzleGo = function(self, arg_12_1)
		SetActive(self.puzzleGo_, arg_12_1)
	end,
	RefreshPuzzlePanel = function(self, arg_13_1)
		SetActive(self.puzzlePanelGo_, not arg_13_1)
		SetActive(self.puzzleAnswerGo_, arg_13_1)
	end,
	GetPanelTrans = function(self)
		return self.panelTrans_
	end,
	GetBgTrans = function(self)
		return self.bgTrans_
	end,
	GetPuzzlePanelWidth = function(self)
		if self.corners_ == nil then
			self.corners_ = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
		end

		if self.puzzleWidth_ == nil then
			self.puzzlePanelTrans_:GetWorldCorners(self.corners_)

			self.puzzleWidth_ = (manager.ui.mainCameraCom_:WorldToScreenPoint(self.corners_[2]).x - manager.ui.mainCameraCom_:WorldToScreenPoint(self.corners_[0]).x) * (manager.ui.canvasSize_.x / Screen.width)
		end

		return self.puzzleWidth_
	end,
	RefreshPuzzleBg = function(self, arg_17_1)
		local var_17_0 = getSpriteWithoutAtlas("TextureConfig/VolumeIIIUI/" .. ActivityPuzzleCfg[arg_17_1].album_id)

		if var_17_0 ~= nil then
			self.puzzleBgRenderer_.sprite = var_17_0

			local var_17_1, var_17_2 = self.puzzlePanelTrans_.rect.width / (self.puzzleBgRenderer_.sprite.bounds.size.x - self.puzzleBgRenderer_.sprite.border.x * 0.01 - self.puzzleBgRenderer_.sprite.border.z * 0.01), Vector3
		end

		self.puzzleBgTrans_.localScale = var_17_2(var_17_1, self.puzzlePanelTrans_.rect.height / (self.puzzleBgRenderer_.sprite.bounds.size.y - self.puzzleBgRenderer_.sprite.border.y * 0.01 - self.puzzleBgRenderer_.sprite.border.w * 0.01), 1)
	end,
	ScaleBg = function(self, arg_18_1)
		self.bgOriginScale_ = self.bgTrans_.localScale
		self.bgTrans_.localScale.x = self.bgTrans_.localScale.x + arg_18_1
		self.bgTrans_.localScale.y = self.bgTrans_.localScale.y + arg_18_1
		self.bgScaleLeanTween_ = LeanTween.scale(self.bgTrans_, self.bgTrans_.localScale, 0.466):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			if self.bgScaleLeanTween_ then
				self.bgScaleLeanTween_:setOnComplete(nil)

				self.bgScaleLeanTween_ = nil
			end
		end))
	end,
	RecoverBg = function(self)
		if self.bgOriginScale_ ~= nil then
			self.bgScaleLeanTween_ = LeanTween.scale(self.bgTrans_, self.bgOriginScale_, 0.466):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
				if self.bgScaleLeanTween_ then
					self.bgScaleLeanTween_:setOnComplete(nil)

					self.bgScaleLeanTween_ = nil
				end
			end))
		end

		self.bgOriginScale_ = nil
	end
}
