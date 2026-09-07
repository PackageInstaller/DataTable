pg = pg or {}
pg.CpkPlayMgr = singletonClass("CpkPlayMgr")

function pg.CpkPlayMgr.Ctor(arg_1_0)
	arg_1_0._onPlaying = false
	arg_1_0._mainTF = nil
	arg_1_0._closeLimit = nil
	arg_1_0._animator = nil
	arg_1_0._timer = nil
	arg_1_0._criUsm = nil
	arg_1_0._criCpk = nil
	arg_1_0._stopGameBGM = false

	return
end

function pg.CpkPlayMgr.Reset(arg_2_0)
	arg_2_0._onPlaying = false
	arg_2_0._mainTF = nil
	arg_2_0._closeLimit = nil
	arg_2_0._animator = nil
	arg_2_0._criUsm = nil
	arg_2_0._criCpk = nil
	arg_2_0._stopGameBGM = false
	arg_2_0._timer = nil

	return
end

function pg.CpkPlayMgr:OnPlaying()
	return self._onPlaying
end

function pg.CpkPlayMgr:PlayCpkMovie(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	pg.DelegateInfo.New(self)

	self._onPlaying = true
	self._stopGameBGM = arg_4_6

	pg.UIMgr.GetInstance():LoadingOn()

	local function var_4_0()
		if self.debugTimer then
			self.debugTimer:Stop()
		end

		if not self._mainTF then
			return
		end

		if not arg_4_8 and Time.realtimeSinceStartup < self._closeLimit then
			return
		end

		setActive(self._mainTF, false)
		self:DisposeCpkMovie()

		if arg_4_2 then
			arg_4_2()
		end

		return
	end

	local function var_4_1()
		onButton(self, self._mainTF, function()
			if arg_4_5 then
				var_4_0()
			end

			return
		end)

		if self._criUsm then
			self._criUsm.player:SetVolume(PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME))
			self._criUsm.player:SetShaderDispatchCallback(function(arg_8_0, arg_8_1)
				self:CheckRatioFitter()
				self:checkBgmStop(arg_8_0)

				return nil
			end)
		end

		if self._criCpk then
			self._criCpk.player:SetVolume(PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME))
			self._criCpk.player:SetShaderDispatchCallback(function(arg_9_0, arg_9_1)
				self:CheckRatioFitter()
				self:checkBgmStop(arg_9_0)

				return nil
			end)
		end

		if self._animator ~= nil then
			self._animator.enabled = true

			local var_6_0 = self._mainTF:GetComponent("DftAniEvent")

			var_6_0:SetStartEvent(function(arg_10_0)
				if self._criUsm then
					self._criUsm:Play()
				end

				return
			end)
			var_6_0:SetEndEvent(function(arg_11_0)
				var_4_0()

				return
			end)
		else
			self._timer = Timer.New(var_4_0, arg_4_7)

			self._timer:Start()
		end

		setActive(self._mainTF, true)

		if self._stopGameBGM then
			pg.BgmMgr.GetInstance():StopPlay()
		end

		if arg_4_1 then
			arg_4_1()
		end

		return
	end

	if IsNil(self._mainTF) then
		LoadAndInstantiateAsync(arg_4_3, arg_4_4, function(arg_12_0)
			pg.UIMgr.GetInstance():LoadingOff()

			self._closeLimit = Time.realtimeSinceStartup + 1

			if not self._onPlaying then
				Destroy(arg_12_0)

				return
			end

			self._parentTF = self._parentTF or GameObject.Find("UICamera/Canvas")

			setParent(arg_12_0, self._parentTF)

			self._ratioFitter = arg_12_0:GetComponent("AspectRatioFitter")
			self._mainTF = arg_12_0

			pg.UIMgr.GetInstance():OverlayPanel(self._mainTF.transform)

			self._criUsm = tf(self._mainTF):Find("usm"):GetComponent("CriManaEffectUI")
			self._criCpk = tf(self._mainTF):Find("usm"):GetComponent("CriManaCpkUI")
			self._usmImg = tf(self._mainTF):Find("usm"):GetComponent("Image")
			self._animator = self._mainTF:GetComponent("Animator")

			if self._criUsm then
				self._criUsm.renderMode = CriWare.CriManaMovieMaterialBase.RenderMode.Always
			end

			if self._usmImg and self._usmImg.color.a == 0 then
				self._usmImg.color = Color.New(1, 1, 1, 0.1)
			end

			var_4_1()

			return
		end)
	else
		var_4_1()
	end

	return
end

function pg.CpkPlayMgr:CheckRatioFitter()
	if self._ratioFitter then
		self._ratioFitter.enabled = true
		self._ratioFitter = nil
	end

	return
end

function pg.CpkPlayMgr:checkBgmStop(arg_14_1)
	if self._onPlaying then
		if arg_14_1.numAudioStreams and arg_14_1.numAudioStreams > 0 then
			pg.BgmMgr.GetInstance():StopPlay()

			self._stopGameBGM = true
		end
	end

	return
end

function pg.CpkPlayMgr:DisposeCpkMovie()
	if self._onPlaying then
		if self._mainTF then
			pg.UIMgr.GetInstance():UnOverlayPanel(self._mainTF.transform, self._tf)
			Destroy(self._mainTF)

			if self._animator ~= nil then
				self._animator.enabled = false
			end

			if self._timer ~= nil then
				self._timer:Stop()

				self._timer = nil
			end

			if self._criUsm then
				self._criUsm:Stop()
			end

			if self._stopGameBGM then
				pg.BgmMgr.GetInstance():ContinuePlay()
			end

			self._onPlaying = false

			pg.DelegateInfo.Dispose(self)
		end

		self:Reset()
	end

	return
end

return
