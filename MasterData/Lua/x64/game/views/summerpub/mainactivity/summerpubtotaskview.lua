local SummerPubToTaskView = class("SummerPubToTaskView", ReduxView)

function SummerPubToTaskView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_HeroUI"
end

function SummerPubToTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPubToTaskView:Init()
	self:InitUI()
	self:AddListeners()

	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)

	self.doorOpenCriMovie_ = self.doorOpenMovieGo_:GetComponent("CriManaMovieControllerForUI")
	self.doorOpenCriplayer_ = self.doorOpenCriMovie_.player

	self.doorOpenCriplayer_:SetMaxPictureDataSize(300000)

	self.loopCriMovie_ = self.loopMovieGo_:GetComponent("CriManaMovieControllerForUI")
	self.loopCriplayer_ = self.loopCriMovie_.player

	self.loopCriplayer_:SetMaxPictureDataSize(300000)
end

function SummerPubToTaskView:InitUI()
	self:BindCfgUI()

	self.typeWritter = self.talkText_.transform:GetComponent("UITypewriterEffect")
end

function SummerPubToTaskView:AddListeners()
	self:AddBtnListener(self.roleBtn_, nil, function()
		self:PlayCG()
		SetActive(self.guideGo_, false)
	end)
	self:AddBtnListener(self.cgBtn_, nil, function()
		if self.currentIndex == #self.moviePath then
			SetActive(self.cgBtnGo_, false)
			self:OnPlayEnd()
		else
			SetActive(self.cgBtnGo_, false)
			self.loopCriplayer_:Loop(false)

			self.loopMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			JumpTools.OpenPageByJump("summerPubToTaskDialogPopView", {
				cfg = SummerPubHeroCfg[self.eventId],
				callback = function()
					self.currentIndex = self.currentIndex + 1

					SetActive(self.mainPanelGo_, false)
					self:PlayMovie(self.currentIndex)
				end
			})
		end
	end)
end

function SummerPubToTaskView:PlayCG()
	manager.windowBar:HideBar()
	self.criMovie_:Stop()

	self.moviePath = {}
	self.isSetOpenCg = false

	if self.cfg.open_cg_id and self.cfg.open_cg_id ~= "" then
		SetFile(self.criplayer_, nil, "SofdecAsset/activity/" .. self.cfg.open_cg_id .. ".usm", CriMana.Player.SetMode.New)

		self.isSetOpenCg = true
	end

	if self.cfg.taste_cg_id and self.cfg.taste_cg_id ~= "" then
		table.insert(self.moviePath, "SofdecAsset/activity/" .. self.cfg.taste_cg_id .. ".usm")
	end

	if self.cfg.sign_cg_id and self.cfg.sign_cg_id ~= "" then
		table.insert(self.moviePath, "SofdecAsset/activity/" .. self.cfg.sign_cg_id .. ".usm")
	end

	self.loopCriMovie_:Stop()

	self.loopMoviePath = {}

	if self.cfg.taste_cg_id_loop and self.cfg.taste_cg_id_loop ~= "" then
		table.insert(self.loopMoviePath, "SofdecAsset/activity/" .. self.cfg.taste_cg_id_loop .. ".usm")
	end

	if self.cfg.sign_cg_id_loop and self.cfg.sign_cg_id_loop ~= "" then
		table.insert(self.loopMoviePath, "SofdecAsset/activity/" .. self.cfg.sign_cg_id_loop .. ".usm")
	end

	self.doorOpenCriMovie_:Stop()

	self.doorOpenMoviePath = {}

	if #self.moviePath == 0 then
		SummerPubAction.FinishCook(self.cookDishId, SummerPubConst.COOK_STATE.VIEW_CG)
	end

	self.movieGo_.transform.localPosition = Vector3(0, 0, 0)
	self.currentIndex = 1

	self:PlayMovie(self.currentIndex)
end

function SummerPubToTaskView:OnPlayEnd()
	SummerPubAction.FinishCook(self.cookDishId, SummerPubConst.COOK_STATE.VIEW_CG, function()
		self.criMovie_:Stop()

		self.movieGo_.transform.localPosition = Vector3(9999, 9999, 0)
	end)
end

function SummerPubToTaskView:PlayMovie(arg_12_1)
	if not self.criplayer_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	if not self.loopCriplayer_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	SetActive(self.cgBtnGo_, false)

	if self.isSetOpenCg then
		SetFile(self.criplayer_, nil, self.moviePath[arg_12_1], CriMana.Player.SetMode.Append)
	else
		SetFile(self.criplayer_, nil, self.moviePath[arg_12_1], CriMana.Player.SetMode.New)
	end

	self.loopCriplayer_:Stop()
	SetFile(self.loopCriplayer_, nil, self.loopMoviePath[arg_12_1], CriMana.Player.SetMode.New)
	self.loopCriplayer_:Prepare()
	self.loopCriplayer_:Loop(true)
	self.loopCriplayer_:SetVolume(manager.audio:GetEffectVolume())
	self.criplayer_:Start()
	self.criplayer_:SetVolume(manager.audio:GetEffectVolume())

	if arg_12_1 == 1 then
		SDKTools.SendMessageToSDK("activity_illustration", {
			illustration_type = 1,
			type = 1,
			activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
			food_id = self.cookDishId,
			button_name = self.cfg.taste_cg_id
		})
	end
end

function SummerPubToTaskView:OnEnter()
	self.movieGo_.transform.localPosition = Vector3(9999, 9999, 0)

	SetActive(self.guideGo_, false)

	self.cookDishId = self.params_.cookDishId
	self.cfg = SummerPubCookCfg[self.cookDishId]
	self.eventId = self.cfg.hero_id
	self.talk = SummerPubHeroCfg[self.eventId].food_text
	self.talkText_.text = self.talk or ""

	self:SetCriStatusCallBack()
end

function SummerPubToTaskView:SetCriStatusCallBack()
	function self.criplayer_.statusChangeCallback(arg_15_0)
		local var_15_0 = tostring(arg_15_0)

		if var_15_0 == "PlayEnd" then
			self.loopCriplayer_:Start()

			self.loopMovieGo_.transform.localPosition = Vector3(0, 0, 0)

			SetActive(self.cgBtnGo_, true)
		elseif var_15_0 == "Stop" then
			self.criMovie_:Stop()
		elseif var_15_0 == "Error" then
			self.criMovie_:Stop()
		end
	end

	function self.loopCriplayer_.statusChangeCallback(arg_16_0)
		local var_16_0 = tostring(arg_16_0)

		if var_16_0 == "PlayEnd" then
			self.loopCriplayer_:Stop()
		elseif var_16_0 == "Stop" then
			self.loopCriplayer_:Stop()
		elseif var_16_0 == "Error" then
			self.loopCriplayer_:Stop()
		end
	end

	function self.doorOpenCriplayer_.statusChangeCallback(arg_17_0)
		local var_17_0 = tostring(arg_17_0)

		if var_17_0 == "PlayEnd" then
			self:StopTimer()

			self.openTimer_ = Timer.New(function()
				self:UpdateText()

				self.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

				self.timer:Start()
			end, 0.66, 1)

			self.openTimer_:Start()

			self.timer = Timer.New(function()
				self:StopTimer()
				SetActive(self.guideGo_, true)
			end, 4, 1)

			self.timer:Start()
			self.doorOpenCriplayer_:Stop()
		elseif var_17_0 == "Playing" then
			SummerPubTool:LoadScene(self.eventId, SetActive(self.mainPanelGo_, true))
		elseif var_17_0 == "Stop" then
			self.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			self.doorOpenCriMovie_:Stop()
		elseif var_17_0 == "Error" then
			self.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			self.doorOpenCriMovie_:Stop()
		end
	end
end

function SummerPubToTaskView:OnEnterOver()
	if self.cookDishId == SummerPubConst.COOK_FIRST_STAGE then
		manager.windowBar:HideBar()
		SummerPubTool:LoadScene(self.eventId, function()
			SetActive(self.mainPanelGo_, true)
		end)
		self:UpdateText()

		self.guideTimer_ = Timer.New(function()
			self:StopTimer()
			SetActive(self.guideGo_, true)
		end, 4, 1)

		self.guideTimer_:Start()
	else
		SetFile(self.doorOpenCriplayer_, nil, "SofdecAsset/activity/activity_4_3_00_door.usm", CriMana.Player.SetMode.New)
		self.doorOpenCriplayer_:Prepare()
		FrameTimer.New(function()
			self:PlayDoorOpenMovie()
		end, 1, 1):Start()
	end
end

function SummerPubToTaskView:PlayDoorOpenMovie()
	manager.windowBar:HideBar()

	self.doorOpenMovieGo_.transform.localPosition = Vector3(0, 0, 0)

	self.doorOpenCriMovie_:Play()
	self.doorOpenCriplayer_:SetVolume(manager.audio:GetEffectVolume())
end

function SummerPubToTaskView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.openTimer_ then
		self.openTimer_:Stop()

		self.openTimer_ = nil
	end

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end
end

function SummerPubToTaskView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_27_0, var_27_1 = ChapterResidentTools.GetResidentMainActTime(ActivityConst.ACTIVITY_NYA_SUMMER_PUB)

		if var_27_0 and var_27_1 and var_27_1 <= manager.time:GetServerTime() then
			JumpTools.GoToSystem("/chapterMap", {
				chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
				activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
			})
		else
			ActivityTools.JumpBackToActivityMainViewByActivityID(ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
		end
	end)
end

function SummerPubToTaskView:UpdateText()
	local var_28_1 = utf8len(self.talk) / (GameSetting.nya_summer_taste_typespeed.value[1] or 20)
	local var_28_2 = 0
	local var_28_3 = 0

	self.timer = Timer.New(function()
		var_28_2 = var_28_2 + 0.01
		var_28_3 = Mathf.Lerp(0, 1, var_28_2 / var_28_1)

		if self.typeWritter.percent < var_28_3 then
			self.typeWritter.percent = var_28_3

			self.typeWritter:SetDirty()
		end

		if var_28_2 >= var_28_1 and self.timer then
			self.timer:Stop()

			self.timer = nil
		end
	end, 0.01, -1)

	self.timer:Start()
end

function SummerPubToTaskView:OnExit()
	self:StopTimer()
	self.super.OnExit(self)

	self.typeWritter.percent = 0

	if self.criplayer_ then
		self.criplayer_.statusChangeCallback = nil
	end

	if self.criMovie_ then
		self.criMovie_:Stop()
	end

	if self.doorOpenCriplayer_ then
		self.doorOpenCriplayer_.statusChangeCallback = nil
	end

	if self.doorOpenCriMovie_ then
		self.doorOpenCriMovie_:Stop()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	SummerPubTool:OnLogout()
end

function SummerPubToTaskView:Dispose()
	if self.criplayer_ then
		self.criplayer_:Dispose()

		self.criplayer_ = nil
	end

	if self.doorOpenCriplayer_ then
		self.doorOpenCriplayer_:Dispose()

		self.doorOpenCriplayer_ = nil
	end

	if self.loopCriplayer_ then
		self.loopCriplayer_:Dispose()

		self.loopCriplayer_ = nil
	end

	SummerPubToTaskView.super.Dispose(self)
end

return SummerPubToTaskView
