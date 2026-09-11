return {
	LoadScene = function(self, arg_1_1)
		local var_1_0 = SceneManager.GetSceneByName("X107")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		if self.operation_ then
			return
		end

		self.callback_ = arg_1_1
		self.operation_ = Asset.LoadLevelAsync("Levels/X107", true)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = FrameTimer.New(handler(self, self.Process), 1, -1)

		self.timer_:Start()
	end,
	Process = function(self)
		if self.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("paperCutMain") then
				local var_2_0 = SceneManager.GetSceneByName("X107")

				if var_2_0 and var_2_0.isLoaded == true then
					SceneManager.UnloadSceneAsync("X107")
				end
			end

			if self.timer_ then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self.operation_ = nil

			self:BindCfgUI()
			self.paperCutManager_:SetCanvas(manager.ui.canvas)
			self.paperCutManager_:SetCanvasScale((Vector2(manager.ui.canvasSize_.x / Screen.width, manager.ui.canvasSize_.y / Screen.height)))
			self.paperCutManager_:InitialScene()

			if self.callback_ then
				self.callback_()

				self.callback_ = nil
			end
		end
	end,
	UnLoadScene = function(self)
		if self.operation_ then
			return
		end

		if self.paperCutManager_ ~= nil then
			self.paperCutManager_:ResetScene()

			self.paperCutManager_ = nil
		end

		local var_3_0 = SceneManager.GetSceneByName("X107")

		if var_3_0 and var_3_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X107")
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
	GameStart = function(self, arg_6_1)
		self:RefreshDrawSprite(arg_6_1)
		self:SetCheckPointPanel(arg_6_1)
		self.paperCutManager_:GameStart()
	end,
	GameOver = function(self)
		self.paperCutManager_:GameOver()
	end,
	GetPaperRenderer = function(self)
		return self.paperRenderer_
	end,
	RegisterCompleteHandler = function(self, arg_9_1)
		self.paperCutManager_:SetOnComplete(arg_9_1)
	end,
	RegisterStartDrawHandler = function(self, arg_10_1)
		self.paperCutManager_:SetOnStartDraw(arg_10_1)
	end,
	RefreshDrawSprite = function(self, arg_11_1)
		self.drawSpriteRenderer_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. PaperCutCfg[arg_11_1].cut_result_picture)
		self.drawOutline_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. PaperCutCfg[arg_11_1].cut_line_picture)
	end,
	SetCheckPointPanel = function(self, arg_12_1)
		self.paperCutManager_:LoadCheckPointPanel(arg_12_1)
	end,
	DisplayResultImage = function(self, arg_13_1)
		self.paperCutManager_:DisplayResultImage(arg_13_1)
	end,
	CalculateScore = function(self)
		return self.paperCutManager_:CalculateScore()
	end,
	OnLogout = function(self)
		self:UnLoadScene()
	end
}
