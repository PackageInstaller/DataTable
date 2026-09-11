return {
	LoadScene = function(self, arg_1_1, arg_1_2)
		self.activityId = arg_1_1
		self.callback_ = arg_1_2
		self.assetSetDone = false

		local var_1_0 = SceneManager.GetSceneByName("X221")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		self.operation_ = Asset.LoadLevelAsync("Levels/X221", true)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		manager.ui:SetMainCamera("flipcard")

		manager.ui.mainCameraCom_.fieldOfView = 1.77 / (Screen.width / Screen.height) * CameraCfg.flipcard.fieldOfView

		if Screen.width / Screen.height <= 1.34 then
			manager.ui.mainCameraCom_.fieldOfView = manager.ui.mainCameraCom_.fieldOfView - 3
		end

		self.timer_ = FrameTimer.New(handler(self, self.Process), 1, -1)

		self.timer_:Start()

		whereami = "battle"
	end,
	UnLoadScene = function(arg_2_0)
		local var_2_0 = SceneManager.GetSceneByName("X221")

		whereami = "home"

		if var_2_0 and var_2_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X221")
		end
	end,
	Process = function(self)
		local var_3_0 = SceneManager.GetSceneByName("X221")

		if var_3_0 and var_3_0.isLoaded then
			var_3_0:GetRootGameObjects()[1].transform:GetChild(0):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureBg/Version/V4_5_Horus/V4_5_Horus_FlipCardUI/V4_5_Horus_01003")

			self:SetAssetPath(self.activityId)

			self.assetSetDone = true

			if self.callback_ then
				self.callback_()
			end
		end

		if self.assetSetDone then
			self.timer_:Stop()

			self.timer_ = nil
		end
	end,
	LevelIsDone = function(self)
		return not self.operation_ or self.operation_:IsDone()
	end,
	SetAssetPath = function(arg_5_0, arg_5_1)
		local var_5_0 = FlipCardCfg[arg_5_1]
		local var_5_1 = FlipCardCfg[arg_5_1].icon_path
		local var_5_2 = FlipCardCfg[arg_5_1].normal_card
		local var_5_3 = FlipCardCfg[arg_5_1].special_card

		FlipCardGameController.Instance:SetCardFaceBack(FlipCardCfg[arg_5_1].atlas_name, FlipCardCfg[arg_5_1].normal_front_back_icon, FlipCardCfg[arg_5_1].atlas_name ~= "")
		FlipCardGameController.Instance:SetCardFaceBack(var_5_0.atlas_name, var_5_0.special_front_back_icon, var_5_0.atlas_name ~= "")

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			FlipCardGameController.Instance:SetCardFaces(var_5_1, iter_5_1, false)
		end

		for iter_5_2, iter_5_3 in pairs(var_5_3) do
			FlipCardGameController.Instance:SetCardFaces(var_5_1, iter_5_3, true)
		end
	end,
	StartGame = function(arg_6_0)
		FlipCardGameController.Instance:StarCheckCardFace()
	end,
	GameOver = function(arg_7_0, arg_7_1)
		FlipCardGameController.Instance:GameOver(arg_7_1)
	end,
	GetGameState = function(arg_8_0)
		if not FlipCardGameController.Instance then
			return 0
		end

		return FlipCardGameController.Instance:GetGameState()
	end,
	StopObservingCard = function(arg_9_0)
		FlipCardGameController.Instance:StopObservingCards()
	end,
	GetObservingLeftTime = function(arg_10_0)
		return math.floor(FlipCardGameController.Instance.RemainingObservationTime + 0.5)
	end,
	GetFlippingLeftTime = function(arg_11_0)
		return math.floor(FlipCardGameController.Instance.CurrentTimeValue + 0.5)
	end,
	GetFlipCardCount = function(arg_12_0)
		return math.floor(FlipCardGameController.Instance.FlipCardCount)
	end,
	GiveUp = function(arg_13_0)
		FlipCardGameController.Instance:GiveUp()
	end,
	ChangeStatus = function(arg_14_0, arg_14_1)
		FlipCardGameController.Instance:ChangeStatus(arg_14_1)
	end,
	ResetGame = function(arg_15_0, arg_15_1)
		FlipCardGameController.Instance:ResetGame()
	end,
	GetIsSuccess = function(arg_16_0)
		return FlipCardGameController.Instance:GetIsSuccess()
	end,
	GetUseTime = function(arg_17_0)
		return math.ceil(FlipCardGameController.Instance.TimerDuration - FlipCardGameController.Instance.CurrentTimeValue)
	end,
	GetHomeUI = function(arg_18_0)
		local var_18_0 = XH3rdFlipCardData:GetActivityID()

		if var_18_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardHomeUI"
		elseif var_18_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardHomeUI"
		elseif var_18_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardHomeUI"
		elseif var_18_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardHomeUI"
		end
	end,
	GetGameUI = function(arg_19_0)
		local var_19_0 = XH3rdFlipCardData:GetActivityID()

		if var_19_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardGameUI"
		elseif var_19_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardGameUI"
		elseif var_19_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardGameUI"
		elseif var_19_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardGameUI"
		end
	end,
	GetRewardUI = function(arg_20_0)
		local var_20_0 = XH3rdFlipCardData:GetActivityID()

		if var_20_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardRewardUI"
		elseif var_20_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardRewardUI"
		elseif var_20_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardRewardUI"
		elseif var_20_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardRewardUI"
		end
	end,
	GetClueUI = function(arg_21_0)
		local var_21_0 = XH3rdFlipCardData:GetActivityID()

		if var_21_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardClueUI"
		elseif var_21_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardClueUI"
		elseif var_21_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardClueUI"
		elseif var_21_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardClueUI"
		end
	end,
	GetHelpTips = function(arg_22_0)
		local var_22_0 = XH3rdFlipCardData:GetActivityID()

		if var_22_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN")
		elseif var_22_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_0")
		elseif var_22_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11")
		elseif var_22_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_4_5")
		end
	end,
	GetUnlockPopUI = function(arg_23_0)
		local var_23_0 = XH3rdFlipCardData:GetActivityID()

		if var_23_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardUnlockUI"
		elseif var_23_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardUnlockUI"
		end
	end,
	GetResultUI = function(arg_24_0)
		local var_24_0 = XH3rdFlipCardData:GetActivityID()

		if var_24_0 == ActivityConst.ACTIVITY_3_11_FLIPCARD then
			return "Widget/Version/CORGUI_3_11/CORGUI_3_11_FlipCardUI/CORGUI_FlipCardResultPopUI"
		elseif var_24_0 == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			return "Widget/Version/V4_5_Horus/NorseUI_4_5FlipCardUI/CORGUI_FlipCardResultPopUI"
		end
	end,
	SetCardNum = function(arg_25_0, arg_25_1, arg_25_2)
		FlipCardGameController.Instance.ColmnCount = arg_25_1
		FlipCardGameController.Instance.RowCount = arg_25_2
	end,
	InitGame = function(arg_26_0)
		local var_26_0 = SceneManager.GetSceneByName("X221")

		var_26_0:GetRootGameObjects()[1].transform:GetChild(1):GetChild(1):GetComponent("SpriteRenderer").sprite = getSprite("Atlas/V4_5_HorusAtlas", "V4_5_Horus_01021")

		Debug.Log(var_26_0:GetRootGameObjects()[1].transform:GetChild(1):GetChild(1):GetComponent("SpriteRenderer").sprite)
		FlipCardGameController.Instance:InitGame()
	end
}
