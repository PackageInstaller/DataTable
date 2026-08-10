return {
	LoadScene = function(arg_1_0, arg_1_1)
		local var_1_0 = SceneManager.GetSceneByName("X107")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		if arg_1_0.operation_ then
			return
		end

		arg_1_0.callback_ = arg_1_1
		arg_1_0.operation_ = Asset.LoadLevelAsync("Levels/X107", true)

		if arg_1_0.timer_ then
			arg_1_0.timer_:Stop()

			arg_1_0.timer_ = nil
		end

		arg_1_0.timer_ = FrameTimer.New(handler(arg_1_0, arg_1_0.Process), 1, -1)

		arg_1_0.timer_:Start()
	end,
	Process = function(arg_2_0)
		if arg_2_0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("paperCutMain") then
				local var_2_0 = SceneManager.GetSceneByName("X107")

				if var_2_0 and var_2_0.isLoaded == true then
					SceneManager.UnloadSceneAsync("X107")
				end
			end

			if arg_2_0.timer_ then
				arg_2_0.timer_:Stop()

				arg_2_0.timer_ = nil
			end

			arg_2_0.operation_ = nil

			arg_2_0:BindCfgUI()
			arg_2_0.paperCutManager_:SetCanvas(manager.ui.canvas)

			local var_2_1 = Vector2(manager.ui.canvasSize_.x / Screen.width, manager.ui.canvasSize_.y / Screen.height)

			arg_2_0.paperCutManager_:SetCanvasScale(var_2_1)
			arg_2_0.paperCutManager_:InitialScene()

			if arg_2_0.callback_ then
				arg_2_0.callback_()

				arg_2_0.callback_ = nil
			end
		end
	end,
	UnLoadScene = function(arg_3_0)
		if arg_3_0.operation_ then
			return
		end

		if arg_3_0.paperCutManager_ ~= nil then
			arg_3_0.paperCutManager_:ResetScene()

			arg_3_0.paperCutManager_ = nil
		end

		local var_3_0 = SceneManager.GetSceneByName("X107")

		if var_3_0 and var_3_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X107")
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

		if SceneManager.GetSceneByName("X107").rootCount > 0 then
			var_5_0 = SceneManager.GetSceneByName("X107"):GetRootGameObjects()
		end

		if var_5_0 ~= nil then
			for iter_5_0 = 0, var_5_0.Length - 1 do
				if var_5_0[iter_5_0].name == "Panel" then
					var_5_1 = var_5_0[iter_5_0]
				end
			end
		end

		arg_5_0.paperCutManager_ = var_5_1:GetComponent("PaperCutManager")

		ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_5_1)
	end,
	GameStart = function(arg_6_0, arg_6_1)
		arg_6_0:RefreshDrawSprite(arg_6_1)
		arg_6_0:SetCheckPointPanel(arg_6_1)
		arg_6_0.paperCutManager_:GameStart()
	end,
	GameOver = function(arg_7_0)
		arg_7_0.paperCutManager_:GameOver()
	end,
	GetPaperRenderer = function(arg_8_0)
		return arg_8_0.paperRenderer_
	end,
	RegisterCompleteHandler = function(arg_9_0, arg_9_1)
		arg_9_0.paperCutManager_:SetOnComplete(arg_9_1)
	end,
	RegisterStartDrawHandler = function(arg_10_0, arg_10_1)
		arg_10_0.paperCutManager_:SetOnStartDraw(arg_10_1)
	end,
	RefreshDrawSprite = function(arg_11_0, arg_11_1)
		local var_11_0 = PaperCutCfg[arg_11_1].cut_result_picture
		local var_11_1 = PaperCutCfg[arg_11_1].cut_line_picture

		arg_11_0.drawSpriteRenderer_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. var_11_0)
		arg_11_0.drawOutline_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. var_11_1)
	end,
	SetCheckPointPanel = function(arg_12_0, arg_12_1)
		arg_12_0.paperCutManager_:LoadCheckPointPanel(arg_12_1)
	end,
	DisplayResultImage = function(arg_13_0, arg_13_1)
		arg_13_0.paperCutManager_:DisplayResultImage(arg_13_1)
	end,
	CalculateScore = function(arg_14_0)
		return arg_14_0.paperCutManager_:CalculateScore()
	end,
	OnLogout = function(arg_15_0)
		arg_15_0:UnLoadScene()
	end
}
