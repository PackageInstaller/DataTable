return {
	LoadPuzzleLevel = function(arg_1_0, arg_1_1)
		local var_1_0 = SceneManager.GetSceneByName("X103")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		if arg_1_0.operation_ then
			return
		end

		arg_1_0.callback_ = arg_1_1
		arg_1_0.operation_ = Asset.LoadLevelAsync("Levels/X103", true)
		arg_1_0.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

		if arg_1_0.timer_ then
			arg_1_0.timer_:Stop()

			arg_1_0.timer_ = nil
		end

		arg_1_0.timer_ = FrameTimer.New(handler(arg_1_0, arg_1_0.Process), 1, -1)

		arg_1_0.timer_:Start()
	end,
	Process = function(arg_2_0)
		if arg_2_0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("puzzleMain") then
				local var_2_0 = SceneManager.GetSceneByName("X103")

				if var_2_0 and var_2_0.isLoaded == true then
					SceneManager.UnloadSceneAsync("X103")
				end
			end

			if arg_2_0.timer_ then
				arg_2_0.timer_:Stop()

				arg_2_0.timer_ = nil
			end

			arg_2_0.operation_ = nil

			arg_2_0:BindCfgUI()
			arg_2_0:AdaptScreen()

			arg_2_0.plauAnimCount_ = 0

			if arg_2_0.callback_ then
				arg_2_0.callback_()
			end

			arg_2_0.callback_ = nil
		end
	end,
	UnLoadPuzzleLevel = function(arg_3_0)
		if arg_3_0.operation_ then
			return
		end

		if arg_3_0.pieceList_ then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0.pieceList_) do
				iter_3_1:Dispose()
			end

			arg_3_0.pieceList_ = nil
		end

		if arg_3_0.bgScaleLeanTween_ then
			arg_3_0.bgScaleLeanTween_:setOnComplete(nil)
			LeanTween.cancel(arg_3_0.bgTrans_.gameObject)

			arg_3_0.bgScaleLeanTween_ = nil
		end

		local var_3_0 = SceneManager.GetSceneByName("X103")

		if var_3_0 and var_3_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X103")
		end

		arg_3_0.puzzleGo_ = nil
		arg_3_0.puzzlePanelGo_ = nil
		arg_3_0.puzzleAnswerGo_ = nil

		if arg_3_0.raycaster_ ~= nil then
			Object.Destroy(arg_3_0.raycaster_)
		end
	end,
	LevelIsDone = function(arg_4_0)
		if arg_4_0.operation_ then
			return arg_4_0.operation_:IsDone()
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
	AdaptScreen = function(arg_6_0)
		arg_6_0.bgTrans_.localScale = Vector3(1, 1, 1)

		local var_6_0 = arg_6_0.bgRenderer_.bounds.size
		local var_6_1 = var_6_0.x
		local var_6_2 = var_6_0.y
		local var_6_3 = manager.ui.mainCameraCom_.orthographicSize * 2
		local var_6_4 = var_6_3 / Screen.height * Screen.width / var_6_1
		local var_6_5 = var_6_3 / var_6_2
		local var_6_6 = Mathf.Max(var_6_4, var_6_5)

		arg_6_0.adaptScale_ = Vector2(var_6_6, var_6_6)
		arg_6_0.bgTrans_.localScale = arg_6_0.adaptScale_

		local var_6_7 = (var_6_2 * var_6_6 - var_6_3) * 0.5
		local var_6_8 = arg_6_0.bgTrans_.localPosition

		var_6_8.y = var_6_8.y + var_6_7
		arg_6_0.bgTrans_.localPosition = var_6_8

		local var_6_9 = Mathf.Min(var_6_4, var_6_5)

		arg_6_0.panelNewScale_ = Vector2(var_6_9, var_6_9)
		arg_6_0.panelTrans_.localScale = arg_6_0.panelNewScale_

		UnityEngine.Physics2D.SyncTransforms()
	end,
	InitPuzzlePiece = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = ActivityPuzzleCfg[arg_7_1].type

		arg_7_0.pieceList_ = arg_7_0.pieceList_ or {}

		local var_7_1 = arg_7_0.puzzlePanelTrans_.childCount
		local var_7_2 = arg_7_0.puzzlePanelTrans_.rect.width
		local var_7_3 = var_7_2 / var_7_0
		local var_7_4 = Vector2(var_7_3, var_7_3)
		local var_7_5 = var_7_2 * 0.5
		local var_7_6 = var_7_3 * 0.5
		local var_7_7 = Vector3(-var_7_5 + var_7_6, var_7_5 - var_7_6, 0)
		local var_7_8 = Vector3(0, 0, 0)
		local var_7_9 = 1
		local var_7_10 = var_7_0 - 1

		for iter_7_0 = 0, var_7_10 do
			for iter_7_1 = 0, var_7_10 do
				if arg_7_0.pieceList_[var_7_9] == nil then
					local var_7_11

					if var_7_1 < var_7_9 then
						var_7_11 = Object.Instantiate(arg_7_0.pieceTemplate_, arg_7_0.puzzlePanelTrans_)
					else
						var_7_11 = arg_7_0.puzzlePanelTrans_:GetChild(var_7_9 - 1).gameObject
					end

					local var_7_12 = PuzzlePiece.New(var_7_11)

					arg_7_0.pieceList_[#arg_7_0.pieceList_ + 1] = var_7_12
				end

				arg_7_0.pieceList_[var_7_9]:SetSelectCallBack(arg_7_3)
				arg_7_0.pieceList_[var_7_9]:SetData(arg_7_2[var_7_9], var_7_9, arg_7_1, var_7_4)

				var_7_8.x = iter_7_1 * var_7_3
				var_7_8.y = -iter_7_0 * var_7_3
				arg_7_0.pieceList_[var_7_9].transform_.localPosition = var_7_7 + var_7_8
				var_7_9 = var_7_9 + 1
			end
		end

		local var_7_13 = #arg_7_0.pieceList_

		for iter_7_2 = var_7_9, var_7_13 do
			arg_7_0.pieceList_[iter_7_2]:SetActive(false)
		end

		UnityEngine.Physics2D.SyncTransforms()

		return arg_7_0.pieceList_
	end,
	RefreshAnswer = function(arg_8_0, arg_8_1)
		local var_8_0 = ActivityPuzzleCfg[arg_8_1].picture_id
		local var_8_1 = ActivityPuzzleCfg[arg_8_1].path

		arg_8_0.answerRenderer_.sprite = getSprite(var_8_1, var_8_0)
	end,
	GetAnswerAnim = function(arg_9_0)
		return arg_9_0.answerAnim_
	end,
	SetPuzzleAnswerPanel = function(arg_10_0, arg_10_1)
		SetActive(arg_10_0.puzzleAnswerPanel_, arg_10_1)
	end,
	GetPanelNewScale = function(arg_11_0)
		return arg_11_0.panelNewScale_
	end,
	SetPuzzleGo = function(arg_12_0, arg_12_1)
		SetActive(arg_12_0.puzzleGo_, arg_12_1)
	end,
	RefreshPuzzlePanel = function(arg_13_0, arg_13_1)
		SetActive(arg_13_0.puzzlePanelGo_, not arg_13_1)
		SetActive(arg_13_0.puzzleAnswerGo_, arg_13_1)
	end,
	GetPanelTrans = function(arg_14_0)
		return arg_14_0.panelTrans_
	end,
	GetBgTrans = function(arg_15_0)
		return arg_15_0.bgTrans_
	end,
	GetPuzzlePanelWidth = function(arg_16_0)
		if arg_16_0.corners_ == nil then
			arg_16_0.corners_ = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
		end

		if arg_16_0.puzzleWidth_ == nil then
			arg_16_0.puzzlePanelTrans_:GetWorldCorners(arg_16_0.corners_)

			local var_16_0 = manager.ui.mainCameraCom_
			local var_16_1 = var_16_0:WorldToScreenPoint(arg_16_0.corners_[0])

			arg_16_0.puzzleWidth_ = (var_16_0:WorldToScreenPoint(arg_16_0.corners_[2]).x - var_16_1.x) * (manager.ui.canvasSize_.x / Screen.width)
		end

		return arg_16_0.puzzleWidth_
	end,
	RefreshPuzzleBg = function(arg_17_0, arg_17_1)
		local var_17_0 = getSpriteWithoutAtlas("TextureConfig/VolumeIIIUI/" .. ActivityPuzzleCfg[arg_17_1].album_id)

		if var_17_0 ~= nil then
			arg_17_0.puzzleBgRenderer_.sprite = var_17_0
		end

		local var_17_1 = arg_17_0.puzzleBgRenderer_.sprite
		local var_17_2 = var_17_1.bounds.size
		local var_17_3 = var_17_1.border
		local var_17_4 = var_17_2.x - var_17_3.x * 0.01 - var_17_3.z * 0.01
		local var_17_5 = var_17_2.y - var_17_3.y * 0.01 - var_17_3.w * 0.01
		local var_17_6 = arg_17_0.puzzlePanelTrans_.rect
		local var_17_7 = var_17_6.width / var_17_4
		local var_17_8 = var_17_6.height / var_17_5
		local var_17_9 = Vector3(var_17_7, var_17_8, 1)

		arg_17_0.puzzleBgTrans_.localScale = var_17_9
	end,
	ScaleBg = function(arg_18_0, arg_18_1)
		arg_18_0.bgOriginScale_ = arg_18_0.bgTrans_.localScale

		local var_18_0 = arg_18_0.bgTrans_.localScale

		var_18_0.x = var_18_0.x + arg_18_1
		var_18_0.y = var_18_0.y + arg_18_1
		arg_18_0.bgScaleLeanTween_ = LeanTween.scale(arg_18_0.bgTrans_, var_18_0, 0.466):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			if arg_18_0.bgScaleLeanTween_ then
				arg_18_0.bgScaleLeanTween_:setOnComplete(nil)

				arg_18_0.bgScaleLeanTween_ = nil
			end
		end))
	end,
	RecoverBg = function(arg_20_0)
		if arg_20_0.bgOriginScale_ ~= nil then
			arg_20_0.bgScaleLeanTween_ = LeanTween.scale(arg_20_0.bgTrans_, arg_20_0.bgOriginScale_, 0.466):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
				if arg_20_0.bgScaleLeanTween_ then
					arg_20_0.bgScaleLeanTween_:setOnComplete(nil)

					arg_20_0.bgScaleLeanTween_ = nil
				end
			end))
		end

		arg_20_0.bgOriginScale_ = nil
	end
}
