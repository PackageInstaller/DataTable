return {
	Play420121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420121001
		arg_1_1.duration_ = 6.33

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(420121001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 0.866666666666667

			if 0.866666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_5 = 19
			local var_4_6 = 1.26666666666667
			local var_4_7, var_4_8 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(420121001).content), 1)

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_9 = var_4_5 <= 0 and var_4_6 or var_4_6 * ((var_4_8 - arg_1_1.typewritterCharCountI18N) / var_4_5)

				if (var_4_5 <= 0 and var_4_6 or var_4_6 * ((var_4_8 - arg_1_1.typewritterCharCountI18N) / var_4_5)) > 0 and var_4_6 < var_4_9 then
					arg_1_1.talkMaxDuration = var_4_9

					if var_4_9 + var_4_4 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_9 + var_4_4
					end
				end
			end

			local var_4_10 = math.max(1.26666666666667, arg_1_1.talkMaxDuration)

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_10 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_7, (arg_1_1.time_ - var_4_4) / var_4_10)
				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_4 + var_4_10 and arg_1_1.time_ < var_4_4 + var_4_10 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_7

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_8
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 1.05

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_22 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_23 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_24 = var_4_22:GetComponent("RectTransform")

				var_4_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_24.offsetMin = Vector2.New(0, -130)
				var_4_24.offsetMax = Vector2.New(0, 0)
			end

			local var_4_25 = 0
			local var_4_26 = manager.audio:GetVoiceLength("story_v_out_420121", "420121001", "story_v_out_420121.awb") / 1000

			if var_4_26 > 0 and 6.333 < var_4_26 and var_4_26 + var_4_25 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_26 + var_4_25
			end

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_420121", "420121001", "story_v_out_420121.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play420121002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 420121002
		arg_7_1.duration_ = 23.4

		local var_7_0 = {
			zh = 15.7993333333333,
			ja = 23.3993333333333
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play420121003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_0 = 1.33333333333333

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				local var_10_1 = Color.New(0, 0, 0)

				var_10_1.a = Mathf.Lerp(1, 0, (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.mask_.color = var_10_1
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				local var_10_2 = Color.New(0, 0, 0)

				arg_7_1.mask_.enabled = false
				var_10_2.a = 0
				arg_7_1.mask_.color = var_10_2
			end

			local var_10_3 = "ST0505"

			if arg_7_1.bgs_.ST0505 == nil then
				local var_10_4 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_3)
				var_10_4.name = var_10_3
				var_10_4.transform.parent = arg_7_1.stage_.transform
				var_10_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_3] = var_10_4
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_5 = arg_7_1.bgs_.ST0505

				arg_7_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = 2 * (var_10_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_10_5.transform.localScale = Vector3.New(var_10_7 / var_10_6.sprite.bounds.size.y < var_10_7 * manager.ui.mainCameraCom_.aspect / var_10_6.sprite.bounds.size.x and var_10_7 * manager.ui.mainCameraCom_.aspect / var_10_6.sprite.bounds.size.x or var_10_7 / var_10_6.sprite.bounds.size.y, var_10_7 / var_10_6.sprite.bounds.size.y < var_10_7 * manager.ui.mainCameraCom_.aspect / var_10_6.sprite.bounds.size.x and var_10_7 * manager.ui.mainCameraCom_.aspect / var_10_6.sprite.bounds.size.x or var_10_7 / var_10_6.sprite.bounds.size.y, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST0505" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_8 = arg_7_1.actors_["10023"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_9 then
					var_10_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_9.radialBlurScale = 1
					var_10_9.radialBlurGradient = 1
					var_10_9.radialBlurIntensity = 1

					if var_10_8 then
						var_10_9.radialBlurTarget = var_10_8.transform
					end
				end
			end

			local var_10_10 = 1.33333333333333

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_10 then
				local var_10_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_11 then
					var_10_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_11.radialBlurScale = Mathf.Lerp(1, 1, (arg_7_1.time_ - 0) / var_10_10)
					var_10_11.radialBlurGradient = Mathf.Lerp(1, 1, (arg_7_1.time_ - 0) / var_10_10)
					var_10_11.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_7_1.time_ - 0) / var_10_10)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_10 and arg_7_1.time_ < 0 + var_10_10 + arg_10_0 then
				local var_10_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_12 then
					var_10_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_12.radialBlurScale = 1
					var_10_12.radialBlurGradient = 1
					var_10_12.radialBlurIntensity = 1
				end
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_13 = 1.33333333333333
			local var_10_14 = 1.35

			if 1.33333333333333 < arg_7_1.time_ and arg_7_1.time_ <= var_10_13 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_15 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_15:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(420121002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_19 = 57 <= 0 and var_10_14 or var_10_14 * (utf8.len(var_10_17) / 57)

				if (57 <= 0 and var_10_14 or var_10_14 * (utf8.len(var_10_17) / 57)) > 0 and var_10_14 < var_10_19 then
					arg_7_1.talkMaxDuration = var_10_19
					var_10_13 = var_10_13 + 0.3

					if var_10_19 + var_10_13 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_19 + var_10_13
					end
				end

				arg_7_1.text_.text = var_10_17
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121002", "story_v_out_420121.awb") ~= 0 then
					local var_10_20 = manager.audio:GetVoiceLength("story_v_out_420121", "420121002", "story_v_out_420121.awb") / 1000

					if var_10_20 + var_10_13 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_13
					end

					if var_10_16.prefab_name ~= "" and arg_7_1.actors_[var_10_16.prefab_name] ~= nil then
						local var_10_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_16.prefab_name].transform, "story_v_out_420121", "420121002", "story_v_out_420121.awb")

						arg_7_1:RecordAudio("420121002", var_10_21)
						arg_7_1:RecordAudio("420121002", var_10_21)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_420121", "420121002", "story_v_out_420121.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_420121", "420121002", "story_v_out_420121.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_22 = var_10_13 + 0.3
			local var_10_23 = math.max(var_10_14, arg_7_1.talkMaxDuration)

			if var_10_13 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_22 + var_10_23 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_22) / var_10_23

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_22 + var_10_23 and arg_7_1.time_ < var_10_22 + var_10_23 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play420121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420121003
		arg_13_1.duration_ = 17.8

		local var_13_0 = {
			zh = 14.566,
			ja = 17.8
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.bgs_.ST0504 == nil then
				local var_16_0 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0504")
				var_16_0.name = "ST0504"
				var_16_0.transform.parent = arg_13_1.stage_.transform
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_.ST0504 = var_16_0
			end

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= 1 + arg_16_0 then
				local var_16_1 = arg_13_1.bgs_.ST0504

				arg_13_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_16_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_2 = var_16_1:GetComponent("SpriteRenderer")

				if var_16_2 and var_16_2.sprite then
					local var_16_3 = 2 * (var_16_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_16_1.transform.localScale = Vector3.New(var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "ST0504" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_4 = 2

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_4 + 0.333333333333336 and arg_13_1.time_ < var_16_4 + 0.333333333333336 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_5 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_6 = 1

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 then
				local var_16_7 = Color.New(0, 0, 0)

				var_16_7.a = Mathf.Lerp(0, 1, (arg_13_1.time_ - var_16_5) / var_16_6)
				arg_13_1.mask_.color = var_16_7
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 then
				local var_16_8 = Color.New(0, 0, 0)

				var_16_8.a = 1
				arg_13_1.mask_.color = var_16_8
			end

			local var_16_9 = 1

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_10 = 1

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 then
				local var_16_11 = Color.New(0, 0, 0)

				var_16_11.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_9) / var_16_10)
				arg_13_1.mask_.color = var_16_11
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 then
				local var_16_12 = Color.New(0, 0, 0)

				arg_13_1.mask_.enabled = false
				var_16_12.a = 0
				arg_13_1.mask_.color = var_16_12
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 0.866666666666666 < arg_13_1.time_ and arg_13_1.time_ <= 0.866666666666666 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_15 = 2
			local var_16_16 = 1.35

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_17 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_17:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(420121003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_21 = 54 <= 0 and var_16_16 or var_16_16 * (utf8.len(var_16_19) / 54)

				if (54 <= 0 and var_16_16 or var_16_16 * (utf8.len(var_16_19) / 54)) > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21
					var_16_15 = var_16_15 + 0.3

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121003", "story_v_out_420121.awb") ~= 0 then
					local var_16_22 = manager.audio:GetVoiceLength("story_v_out_420121", "420121003", "story_v_out_420121.awb") / 1000

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_420121", "420121003", "story_v_out_420121.awb")

						arg_13_1:RecordAudio("420121003", var_16_23)
						arg_13_1:RecordAudio("420121003", var_16_23)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420121", "420121003", "story_v_out_420121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420121", "420121003", "story_v_out_420121.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_24 = var_16_15 + 0.3
			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_24 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_24) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_24 + var_16_25 and arg_13_1.time_ < var_16_24 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play420121004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 420121004
		arg_19_1.duration_ = 13.57

		local var_19_0 = {
			zh = 10.500000000001,
			ja = 13.566000000001
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play420121005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 2.000000000001 < arg_19_1.time_ and arg_19_1.time_ <= 2.000000000001 + arg_22_0 then
				arg_19_1.allBtn_.enabled = false
			end

			if arg_19_1.time_ >= 2.000000000001 + 0.3 and arg_19_1.time_ < 2.000000000001 + 0.3 + arg_22_0 then
				arg_19_1.allBtn_.enabled = true
			end

			local var_22_0 = "L16f"

			if arg_19_1.bgs_.L16f == nil then
				local var_22_1 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_22_0)
				var_22_1.name = var_22_0
				var_22_1.transform.parent = arg_19_1.stage_.transform
				var_22_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_[var_22_0] = var_22_1
			end

			if 0.999999999998999 < arg_19_1.time_ and arg_19_1.time_ <= 0.999999999998999 + arg_22_0 then
				local var_22_2 = arg_19_1.bgs_.L16f

				arg_19_1.bgs_.L16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_22_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_3 = var_22_2:GetComponent("SpriteRenderer")

				if var_22_3 and var_22_3.sprite then
					local var_22_4 = 2 * (var_22_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_22_2.transform.localScale = Vector3.New(var_22_4 / var_22_3.sprite.bounds.size.y < var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x and var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x or var_22_4 / var_22_3.sprite.bounds.size.y, var_22_4 / var_22_3.sprite.bounds.size.y < var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x and var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x or var_22_4 / var_22_3.sprite.bounds.size.y, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "L16f" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_22_5 = 0

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_6 = 0.999999999999999

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_6 then
				local var_22_7 = Color.New(0, 0, 0)

				var_22_7.a = Mathf.Lerp(0, 1, (arg_19_1.time_ - var_22_5) / var_22_6)
				arg_19_1.mask_.color = var_22_7
			end

			if arg_19_1.time_ >= var_22_5 + var_22_6 and arg_19_1.time_ < var_22_5 + var_22_6 + arg_22_0 then
				local var_22_8 = Color.New(0, 0, 0)

				var_22_8.a = 1
				arg_19_1.mask_.color = var_22_8
			end

			local var_22_9 = 0.999999999999999

			if 0.999999999999999 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_10 = 1.000000000001

			if var_22_9 <= arg_19_1.time_ and arg_19_1.time_ < var_22_9 + var_22_10 then
				local var_22_11 = Color.New(0, 0, 0)

				var_22_11.a = Mathf.Lerp(1, 0, (arg_19_1.time_ - var_22_9) / var_22_10)
				arg_19_1.mask_.color = var_22_11
			end

			if arg_19_1.time_ >= var_22_9 + var_22_10 and arg_19_1.time_ < var_22_9 + var_22_10 + arg_22_0 then
				local var_22_12 = Color.New(0, 0, 0)

				arg_19_1.mask_.enabled = false
				var_22_12.a = 0
				arg_19_1.mask_.color = var_22_12
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0.899999999999999 < arg_19_1.time_ and arg_19_1.time_ <= 0.899999999999999 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dreamland", "")
			end

			local var_22_15 = arg_19_1.actors_["10024"]

			if 1 < arg_19_1.time_ and arg_19_1.time_ <= 1 + arg_22_0 then
				local var_22_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_16 then
					var_22_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_16.radialBlurScale = 0.5
					var_22_16.radialBlurGradient = 1
					var_22_16.radialBlurIntensity = 1

					if var_22_15 then
						var_22_16.radialBlurTarget = var_22_15.transform
					end
				end
			end

			local var_22_17 = 1.000000000001

			if 1 <= arg_19_1.time_ and arg_19_1.time_ < 1 + var_22_17 then
				local var_22_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_18 then
					var_22_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_18.radialBlurScale = Mathf.Lerp(0.5, 0.5, (arg_19_1.time_ - 1) / var_22_17)
					var_22_18.radialBlurGradient = Mathf.Lerp(1, 1, (arg_19_1.time_ - 1) / var_22_17)
					var_22_18.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_19_1.time_ - 1) / var_22_17)
				end
			end

			if arg_19_1.time_ >= 1 + var_22_17 and arg_19_1.time_ < 1 + var_22_17 + arg_22_0 then
				local var_22_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_19 then
					var_22_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_19.radialBlurScale = 0.5
					var_22_19.radialBlurGradient = 1
					var_22_19.radialBlurIntensity = 1
				end
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_20 = 2.000000000001
			local var_22_21 = 0.85

			if 2.000000000001 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_22 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_22:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_23 = arg_19_1:GetWordFromCfg(420121004)
				local var_22_24 = arg_19_1:FormatText(var_22_23.content)

				arg_19_1.text_.text = var_22_24

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_26 = 34 <= 0 and var_22_21 or var_22_21 * (utf8.len(var_22_24) / 34)

				if (34 <= 0 and var_22_21 or var_22_21 * (utf8.len(var_22_24) / 34)) > 0 and var_22_21 < var_22_26 then
					arg_19_1.talkMaxDuration = var_22_26
					var_22_20 = var_22_20 + 0.3

					if var_22_26 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_26 + var_22_20
					end
				end

				arg_19_1.text_.text = var_22_24
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121004", "story_v_out_420121.awb") ~= 0 then
					local var_22_27 = manager.audio:GetVoiceLength("story_v_out_420121", "420121004", "story_v_out_420121.awb") / 1000

					if var_22_27 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_27 + var_22_20
					end

					if var_22_23.prefab_name ~= "" and arg_19_1.actors_[var_22_23.prefab_name] ~= nil then
						local var_22_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_23.prefab_name].transform, "story_v_out_420121", "420121004", "story_v_out_420121.awb")

						arg_19_1:RecordAudio("420121004", var_22_28)
						arg_19_1:RecordAudio("420121004", var_22_28)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_420121", "420121004", "story_v_out_420121.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_420121", "420121004", "story_v_out_420121.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_29 = var_22_20 + 0.3
			local var_22_30 = math.max(var_22_21, arg_19_1.talkMaxDuration)

			if var_22_20 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_29 + var_22_30 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_29) / var_22_30

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_29 + var_22_30 and arg_19_1.time_ < var_22_29 + var_22_30 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play420121005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420121005
		arg_25_1.duration_ = 9.1

		local var_25_0 = {
			zh = 7.633,
			ja = 9.1
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420121006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(420121005)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)

				if (24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121005", "story_v_out_420121.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121005", "story_v_out_420121.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_420121", "420121005", "story_v_out_420121.awb")

						arg_25_1:RecordAudio("420121005", var_28_6)
						arg_25_1:RecordAudio("420121005", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420121", "420121005", "story_v_out_420121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420121", "420121005", "story_v_out_420121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420121006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420121006
		arg_29_1.duration_ = 16.2

		local var_29_0 = {
			zh = 11.800000000001,
			ja = 16.200000000001
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420121007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 2.000000000002 < arg_29_1.time_ and arg_29_1.time_ <= 2.000000000002 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= 2.000000000002 + 0.499999999999 and arg_29_1.time_ < 2.000000000002 + 0.499999999999 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			if 0.966666666665666 < arg_29_1.time_ and arg_29_1.time_ <= 0.966666666665666 + arg_32_0 then
				local var_32_0 = arg_29_1.bgs_.ST0505

				arg_29_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_1 = var_32_0:GetComponent("SpriteRenderer")

				if var_32_1 and var_32_1.sprite then
					local var_32_2 = 2 * (var_32_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_0.transform.localScale = Vector3.New(var_32_2 / var_32_1.sprite.bounds.size.y < var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x and var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x or var_32_2 / var_32_1.sprite.bounds.size.y, var_32_2 / var_32_1.sprite.bounds.size.y < var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x and var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x or var_32_2 / var_32_1.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST0505" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_3 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_4 = 0.966666666666667

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_4 then
				local var_32_5 = Color.New(0, 0, 0)

				var_32_5.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_3) / var_32_4)
				arg_29_1.mask_.color = var_32_5
			end

			if arg_29_1.time_ >= var_32_3 + var_32_4 and arg_29_1.time_ < var_32_3 + var_32_4 + arg_32_0 then
				local var_32_6 = Color.New(0, 0, 0)

				var_32_6.a = 1
				arg_29_1.mask_.color = var_32_6
			end

			local var_32_7 = 0.966666666666666

			if 0.966666666666666 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_8 = 1.03333333333433

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 then
				local var_32_9 = Color.New(0, 0, 0)

				var_32_9.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_7) / var_32_8)
				arg_29_1.mask_.color = var_32_9
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 then
				local var_32_10 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_10.a = 0
				arg_29_1.mask_.color = var_32_10
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_dreamland", "")
			end

			if 0.766666666666665 < arg_29_1.time_ and arg_29_1.time_ <= 0.766666666666665 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_32_13 = arg_29_1.actors_["10023"]

			if 0.95 < arg_29_1.time_ and arg_29_1.time_ <= 0.95 + arg_32_0 then
				local var_32_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_14 then
					var_32_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_14.radialBlurScale = 0
					var_32_14.radialBlurGradient = 1
					var_32_14.radialBlurIntensity = 1

					if var_32_13 then
						var_32_14.radialBlurTarget = var_32_13.transform
					end
				end
			end

			local var_32_15 = 0.0166666666666667

			if 0.95 <= arg_29_1.time_ and arg_29_1.time_ < 0.95 + var_32_15 then
				local var_32_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_16 then
					var_32_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_16.radialBlurScale = Mathf.Lerp(0, 0, (arg_29_1.time_ - 0.95) / var_32_15)
					var_32_16.radialBlurGradient = Mathf.Lerp(1, 1, (arg_29_1.time_ - 0.95) / var_32_15)
					var_32_16.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_29_1.time_ - 0.95) / var_32_15)
				end
			end

			if arg_29_1.time_ >= 0.95 + var_32_15 and arg_29_1.time_ < 0.95 + var_32_15 + arg_32_0 then
				local var_32_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_17 then
					var_32_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_17.radialBlurScale = 0
					var_32_17.radialBlurGradient = 1
					var_32_17.radialBlurIntensity = 1
				end
			end

			local var_32_18 = arg_29_1.actors_["10024"]

			if 0.95 < arg_29_1.time_ and arg_29_1.time_ <= 0.95 + arg_32_0 then
				local var_32_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_19 then
					var_32_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_19.radialBlurScale = 0
					var_32_19.radialBlurGradient = 1
					var_32_19.radialBlurIntensity = 1

					if var_32_18 then
						var_32_19.radialBlurTarget = var_32_18.transform
					end
				end
			end

			local var_32_20 = 0.0166666666666667

			if 0.95 <= arg_29_1.time_ and arg_29_1.time_ < 0.95 + var_32_20 then
				local var_32_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_21 then
					var_32_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_21.radialBlurScale = Mathf.Lerp(0, 0, (arg_29_1.time_ - 0.95) / var_32_20)
					var_32_21.radialBlurGradient = Mathf.Lerp(1, 1, (arg_29_1.time_ - 0.95) / var_32_20)
					var_32_21.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_29_1.time_ - 0.95) / var_32_20)
				end
			end

			if arg_29_1.time_ >= 0.95 + var_32_20 and arg_29_1.time_ < 0.95 + var_32_20 + arg_32_0 then
				local var_32_22 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_22 then
					var_32_22.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_22.radialBlurScale = 0
					var_32_22.radialBlurGradient = 1
					var_32_22.radialBlurIntensity = 1
				end
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_23 = 2.000000000001
			local var_32_24 = 0.975

			if 2.000000000001 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_25 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_25:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(420121006)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_29 = 39 <= 0 and var_32_24 or var_32_24 * (utf8.len(var_32_27) / 39)

				if (39 <= 0 and var_32_24 or var_32_24 * (utf8.len(var_32_27) / 39)) > 0 and var_32_24 < var_32_29 then
					arg_29_1.talkMaxDuration = var_32_29
					var_32_23 = var_32_23 + 0.3

					if var_32_29 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_29 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121006", "story_v_out_420121.awb") ~= 0 then
					local var_32_30 = manager.audio:GetVoiceLength("story_v_out_420121", "420121006", "story_v_out_420121.awb") / 1000

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_420121", "420121006", "story_v_out_420121.awb")

						arg_29_1:RecordAudio("420121006", var_32_31)
						arg_29_1:RecordAudio("420121006", var_32_31)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420121", "420121006", "story_v_out_420121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420121", "420121006", "story_v_out_420121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_32 = var_32_23 + 0.3
			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_32 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_32) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_32 + var_32_33 and arg_29_1.time_ < var_32_32 + var_32_33 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420121007 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 420121007
		arg_35_1.duration_ = 9.77

		local var_35_0 = {
			zh = 8.9,
			ja = 9.766
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play420121008(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.6

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(420121007)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 24 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 24)

				if (24 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 24)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121007", "story_v_out_420121.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121007", "story_v_out_420121.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_420121", "420121007", "story_v_out_420121.awb")

						arg_35_1:RecordAudio("420121007", var_38_6)
						arg_35_1:RecordAudio("420121007", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_420121", "420121007", "story_v_out_420121.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_420121", "420121007", "story_v_out_420121.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play420121008 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 420121008
		arg_39_1.duration_ = 9

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play420121009(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 4 < arg_39_1.time_ and arg_39_1.time_ <= 4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= 4 + 0.3 and arg_39_1.time_ < 4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_0 = "L01"

			if arg_39_1.bgs_.L01 == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_2 = arg_39_1.bgs_.L01

				arg_39_1.bgs_.L01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_3 = var_42_2:GetComponent("SpriteRenderer")

				if var_42_3 and var_42_3.sprite then
					local var_42_4 = 2 * (var_42_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_2.transform.localScale = Vector3.New(var_42_4 / var_42_3.sprite.bounds.size.y < var_42_4 * manager.ui.mainCameraCom_.aspect / var_42_3.sprite.bounds.size.x and var_42_4 * manager.ui.mainCameraCom_.aspect / var_42_3.sprite.bounds.size.x or var_42_4 / var_42_3.sprite.bounds.size.y, var_42_4 / var_42_3.sprite.bounds.size.y < var_42_4 * manager.ui.mainCameraCom_.aspect / var_42_3.sprite.bounds.size.x and var_42_4 * manager.ui.mainCameraCom_.aspect / var_42_3.sprite.bounds.size.x or var_42_4 / var_42_3.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "L01" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			if 1.05 < arg_39_1.time_ and arg_39_1.time_ <= 1.05 + arg_42_0 then
				arg_39_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_14 = 4
			local var_42_15 = 0.85

			if 4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_16 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_16:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_17 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(420121008).content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 34 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 34)

				if (34 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 34)) > 0 and var_42_15 < var_42_19 then
					arg_39_1.talkMaxDuration = var_42_19
					var_42_14 = var_42_14 + 0.3

					if var_42_19 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_14
					end
				end

				arg_39_1.text_.text = var_42_17
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_20 = var_42_14 + 0.3
			local var_42_21 = math.max(var_42_15, arg_39_1.talkMaxDuration)

			if var_42_14 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_20 + var_42_21 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_20) / var_42_21

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_20 + var_42_21 and arg_39_1.time_ < var_42_20 + var_42_21 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play420121009 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420121009
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play420121010(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0.833333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 0.833333333333333 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_140", "se_story_140_bird", "")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car03", "")
			end

			local var_48_2 = 0
			local var_48_3 = 0.9

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(420121009).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 36 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 36)

				if (36 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 36)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420121010 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420121010
		arg_49_1.duration_ = 10.57

		local var_49_0 = {
			zh = 8.3,
			ja = 10.566
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420121011(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "1085ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1085ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["1085ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["1085ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["1085ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1085ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1085ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1085ui_story then
				arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_8 = 0
			local var_52_9 = 0.65

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(420121010)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 26 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 26)

				if (26 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 26)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121010", "story_v_out_420121.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_420121", "420121010", "story_v_out_420121.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_420121", "420121010", "story_v_out_420121.awb")

						arg_49_1:RecordAudio("420121010", var_52_15)
						arg_49_1:RecordAudio("420121010", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_420121", "420121010", "story_v_out_420121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_420121", "420121010", "story_v_out_420121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play420121011 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420121011
		arg_53_1.duration_ = 12.43

		local var_53_0 = {
			zh = 8.866,
			ja = 12.433
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420121012(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(420121011)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 27)

				if (27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 27)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121011", "story_v_out_420121.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121011", "story_v_out_420121.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_420121", "420121011", "story_v_out_420121.awb")

						arg_53_1:RecordAudio("420121011", var_56_6)
						arg_53_1:RecordAudio("420121011", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420121", "420121011", "story_v_out_420121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420121", "420121011", "story_v_out_420121.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420121012 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420121012
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play420121013(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1085ui_story = arg_57_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).z)
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles = arg_57_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1085ui_story"].transform.position).z)
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1085ui_story"].transform.localEulerAngles = arg_57_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_60_1 = 0
			local var_60_2 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(420121012).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 34 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 34)

				if (34 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 34)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play420121013 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420121013
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play420121014(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(420121013).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 30)

				if (30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 30)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play420121014 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420121014
		arg_65_1.duration_ = 5.77

		local var_65_0 = {
			zh = 4.8,
			ja = 5.766
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420121015(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = arg_65_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).z)
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles = arg_65_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_65_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).z)
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles = arg_65_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1085ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1085ui_story == nil then
				arg_65_1.var_.characterEffect1085ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1085ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1085ui_story then
				arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(420121014)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 15 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 15)

				if (15 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 15)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121014", "story_v_out_420121.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121014", "story_v_out_420121.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_420121", "420121014", "story_v_out_420121.awb")

						arg_65_1:RecordAudio("420121014", var_68_11)
						arg_65_1:RecordAudio("420121014", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_420121", "420121014", "story_v_out_420121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_420121", "420121014", "story_v_out_420121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play420121015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420121015
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420121016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1085ui_story = arg_69_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).z)
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles = arg_69_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1085ui_story"].transform.position).z)
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1085ui_story"].transform.localEulerAngles = arg_69_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_72_1 = 0
			local var_72_2 = 0.8

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(420121015).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 32 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 32)

				if (32 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 32)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play420121016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 420121016
		arg_73_1.duration_ = 1.53

		local var_73_0 = {
			zh = 1.13333333333333,
			ja = 1.53333333333333
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play420121017(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_76_0 = 0.333333333333333

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				local var_76_1, var_76_2 = math.modf((arg_73_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_76_2 * 0.13, var_76_2 * 0.13, var_76_2 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				manager.ui.mainCamera.transform.localPosition = arg_73_1.var_.shakeOldPos
			end

			local var_76_3 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_3 + 0.383333333332 and arg_73_1.time_ < var_76_3 + 0.383333333332 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_4 = 0.333333333333333
			local var_76_5 = 0.05

			if 0.333333333333333 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_6 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_6:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_7 = arg_73_1:GetWordFromCfg(420121016)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 2 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_8) / 2)

				if (2 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_8) / 2)) > 0 and var_76_5 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10
					var_76_4 = var_76_4 + 0.3

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121016", "story_v_out_420121.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_420121", "420121016", "story_v_out_420121.awb") / 1000

					if var_76_11 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_4
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_420121", "420121016", "story_v_out_420121.awb")

						arg_73_1:RecordAudio("420121016", var_76_12)
						arg_73_1:RecordAudio("420121016", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_420121", "420121016", "story_v_out_420121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_420121", "420121016", "story_v_out_420121.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = var_76_4 + 0.3
			local var_76_14 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_13 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_13) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_13 + var_76_14 and arg_73_1.time_ < var_76_13 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play420121017 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 420121017
		arg_79_1.duration_ = 4.4

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play420121018(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_0 = arg_79_1.bgs_.STwhite

				arg_79_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_1 = var_82_0:GetComponent("SpriteRenderer")

				if var_82_1 and var_82_1.sprite then
					local var_82_2 = 2 * (var_82_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_0.transform.localScale = Vector3.New(var_82_2 / var_82_1.sprite.bounds.size.y < var_82_2 * manager.ui.mainCameraCom_.aspect / var_82_1.sprite.bounds.size.x and var_82_2 * manager.ui.mainCameraCom_.aspect / var_82_1.sprite.bounds.size.x or var_82_2 / var_82_1.sprite.bounds.size.y, var_82_2 / var_82_1.sprite.bounds.size.y < var_82_2 * manager.ui.mainCameraCom_.aspect / var_82_1.sprite.bounds.size.x and var_82_2 * manager.ui.mainCameraCom_.aspect / var_82_1.sprite.bounds.size.x or var_82_2 / var_82_1.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "STwhite" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_3 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_3 + 0.3 and arg_79_1.time_ < var_82_3 + 0.3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_4 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_5 = 2

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_5 then
				local var_82_6 = Color.New(0, 0, 0)

				var_82_6.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_4) / var_82_5)
				arg_79_1.mask_.color = var_82_6
			end

			if arg_79_1.time_ >= var_82_4 + var_82_5 and arg_79_1.time_ < var_82_4 + var_82_5 + arg_82_0 then
				local var_82_7 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_7.a = 0
				arg_79_1.mask_.color = var_82_7
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.cswbg_:SetActive(true)

				local var_82_8 = arg_79_1.cswt_:GetComponent("RectTransform")

				arg_79_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_82_8.offsetMin = Vector2.New(0, 0)
				var_82_8.offsetMax = Vector2.New(0, 130)
				arg_79_1.cswt_.text = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(419148).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.cswt_)

				arg_79_1.cswt_.fontSize = 120
				arg_79_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_79_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_79_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_9 = arg_79_1.fswbg_.transform:Find("textbox/adapt/content") or arg_79_1.fswbg_.transform:Find("textbox/content")
				local var_82_10 = arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_82_11 = var_82_9:GetComponent("RectTransform")

				var_82_9:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_82_11.offsetMin = Vector2.New(0, -70)
				var_82_11.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(true)
				arg_79_1.dialog_:SetActive(false)

				arg_79_1.fswtw_.percent = 0
				arg_79_1.fswt_.text = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(420121017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.fswt_)

				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_79_1.fswtw_:SetDirty()

				arg_79_1.typewritterCharCountI18N = 0

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_12 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_13 = 28
			local var_82_14 = 1.86666666666667
			local var_82_15, var_82_16 = arg_79_1:GetPercentByPara(arg_79_1:FormatText(arg_79_1:GetWordFromCfg(420121017).content), 1)

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_17 = var_82_13 <= 0 and var_82_14 or var_82_14 * ((var_82_16 - arg_79_1.typewritterCharCountI18N) / var_82_13)

				if (var_82_13 <= 0 and var_82_14 or var_82_14 * ((var_82_16 - arg_79_1.typewritterCharCountI18N) / var_82_13)) > 0 and var_82_14 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17

					if var_82_17 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_12
					end
				end
			end

			local var_82_18 = math.max(1.86666666666667, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_18 then
				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_15, (arg_79_1.time_ - var_82_12) / var_82_18)
				arg_79_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_18 and arg_79_1.time_ < var_82_12 + var_82_18 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_15

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_16
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_brake", "")
			end

			if 3.4 < arg_79_1.time_ and arg_79_1.time_ <= 3.4 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play420121018 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 420121018
		arg_83_1.duration_ = 2.88

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play420121019(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.fswbg_:SetActive(true)
				arg_83_1.dialog_:SetActive(false)

				arg_83_1.fswtw_.percent = 0
				arg_83_1.fswt_.text = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(420121018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.fswt_)

				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_83_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_83_1.fswtw_:SetDirty()

				arg_83_1.typewritterCharCountI18N = 0

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.var_.oldValueTypewriter = arg_83_1.fswtw_.percent

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_1 = 7
			local var_86_2 = 0.466666666666667
			local var_86_3, var_86_4 = arg_83_1:GetPercentByPara(arg_83_1:FormatText(arg_83_1:GetWordFromCfg(420121018).content), 1)

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				local var_86_5 = var_86_1 <= 0 and var_86_2 or var_86_2 * ((var_86_4 - arg_83_1.typewritterCharCountI18N) / var_86_1)

				if (var_86_1 <= 0 and var_86_2 or var_86_2 * ((var_86_4 - arg_83_1.typewritterCharCountI18N) / var_86_1)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end
			end

			local var_86_6 = math.max(0.466666666666667, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_6 then
				arg_83_1.fswtw_.percent = Mathf.Lerp(arg_83_1.var_.oldValueTypewriter, var_86_3, (arg_83_1.time_ - var_86_0) / var_86_6)
				arg_83_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_83_1.fswtw_:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_6 and arg_83_1.time_ < var_86_0 + var_86_6 + arg_86_0 then
				arg_83_1.fswtw_.percent = var_86_3

				arg_83_1.fswtw_:SetDirty()
				arg_83_1:ShowNextGo(true)

				arg_83_1.typewritterCharCountI18N = var_86_4
			end

			local var_86_7 = 0.0166666666666667
			local var_86_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121018", "story_v_out_420121.awb") / 1000

			if var_86_8 > 0 and 2.866 < var_86_8 and var_86_8 + var_86_7 > arg_83_1.duration_ then
				arg_83_1.duration_ = var_86_8 + var_86_7
			end

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1:AudioAction("play", "voice", "story_v_out_420121", "420121018", "story_v_out_420121.awb")
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play420121019 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420121019
		arg_87_1.duration_ = 5.62

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play420121020(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.fswbg_:SetActive(true)
				arg_87_1.dialog_:SetActive(false)

				arg_87_1.fswtw_.percent = 0
				arg_87_1.fswt_.text = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(420121019).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.fswt_)

				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_87_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_87_1.fswtw_:SetDirty()

				arg_87_1.typewritterCharCountI18N = 0

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.var_.oldValueTypewriter = arg_87_1.fswtw_.percent

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_1 = 17
			local var_90_2 = 1.13333333333333
			local var_90_3, var_90_4 = arg_87_1:GetPercentByPara(arg_87_1:FormatText(arg_87_1:GetWordFromCfg(420121019).content), 1)

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				local var_90_5 = var_90_1 <= 0 and var_90_2 or var_90_2 * ((var_90_4 - arg_87_1.typewritterCharCountI18N) / var_90_1)

				if (var_90_1 <= 0 and var_90_2 or var_90_2 * ((var_90_4 - arg_87_1.typewritterCharCountI18N) / var_90_1)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end
			end

			local var_90_6 = math.max(1.13333333333333, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_6 then
				arg_87_1.fswtw_.percent = Mathf.Lerp(arg_87_1.var_.oldValueTypewriter, var_90_3, (arg_87_1.time_ - var_90_0) / var_90_6)
				arg_87_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_87_1.fswtw_:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_6 and arg_87_1.time_ < var_90_0 + var_90_6 + arg_90_0 then
				arg_87_1.fswtw_.percent = var_90_3

				arg_87_1.fswtw_:SetDirty()
				arg_87_1:ShowNextGo(true)

				arg_87_1.typewritterCharCountI18N = var_90_4
			end

			local var_90_7 = 0.0166666666666667
			local var_90_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121019", "story_v_out_420121.awb") / 1000

			if var_90_8 > 0 and 5.6 < var_90_8 and var_90_8 + var_90_7 > arg_87_1.duration_ then
				arg_87_1.duration_ = var_90_8 + var_90_7
			end

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1:AudioAction("play", "voice", "story_v_out_420121", "420121019", "story_v_out_420121.awb")
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play420121020 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420121020
		arg_91_1.duration_ = 3.65

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play420121021(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_0 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_0.offsetMin = Vector2.New(0, 0)
				var_94_0.offsetMax = Vector2.New(0, 130)
				arg_91_1.cswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(419143).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.cswt_)

				arg_91_1.cswt_.fontSize = 120
				arg_91_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_91_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_91_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0
				arg_91_1.fswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(420121020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_1 = 0.0166666666666667

			if 0.0166666666666667 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_2 = 7
			local var_94_3 = 0.466666666666667
			local var_94_4, var_94_5 = arg_91_1:GetPercentByPara(arg_91_1:FormatText(arg_91_1:GetWordFromCfg(420121020).content), 1)

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_6 = var_94_2 <= 0 and var_94_3 or var_94_3 * ((var_94_5 - arg_91_1.typewritterCharCountI18N) / var_94_2)

				if (var_94_2 <= 0 and var_94_3 or var_94_3 * ((var_94_5 - arg_91_1.typewritterCharCountI18N) / var_94_2)) > 0 and var_94_3 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end
			end

			local var_94_7 = math.max(0.466666666666667, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_7 then
				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_4, (arg_91_1.time_ - var_94_1) / var_94_7)
				arg_91_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_7 and arg_91_1.time_ < var_94_1 + var_94_7 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_4

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_5
			end

			local var_94_8 = 0.0166666666666667
			local var_94_9 = manager.audio:GetVoiceLength("story_v_out_420121", "420121020", "story_v_out_420121.awb") / 1000

			if var_94_9 > 0 and 3.633 < var_94_9 and var_94_9 + var_94_8 > arg_91_1.duration_ then
				arg_91_1.duration_ = var_94_9 + var_94_8
			end

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1:AudioAction("play", "voice", "story_v_out_420121", "420121020", "story_v_out_420121.awb")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_11 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_11.offsetMin = Vector2.New(0, 0)
				var_94_11.offsetMax = Vector2.New(0, 130)
				arg_91_1.cswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(419143).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.cswt_)

				arg_91_1.cswt_.fontSize = 120
				arg_91_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_91_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_91_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play420121021 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420121021
		arg_95_1.duration_ = 4.65

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play420121022(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0
				arg_95_1.fswt_.text = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(420121021).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_1 = 13
			local var_98_2 = 0.866666666666667
			local var_98_3, var_98_4 = arg_95_1:GetPercentByPara(arg_95_1:FormatText(arg_95_1:GetWordFromCfg(420121021).content), 1)

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_5 = var_98_1 <= 0 and var_98_2 or var_98_2 * ((var_98_4 - arg_95_1.typewritterCharCountI18N) / var_98_1)

				if (var_98_1 <= 0 and var_98_2 or var_98_2 * ((var_98_4 - arg_95_1.typewritterCharCountI18N) / var_98_1)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_0
					end
				end
			end

			local var_98_6 = math.max(0.866666666666667, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_6 then
				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_3, (arg_95_1.time_ - var_98_0) / var_98_6)
				arg_95_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_6 and arg_95_1.time_ < var_98_0 + var_98_6 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_3

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_4
			end

			local var_98_7 = 0.0166666666666667
			local var_98_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121021", "story_v_out_420121.awb") / 1000

			if var_98_8 > 0 and 4.633 < var_98_8 and var_98_8 + var_98_7 > arg_95_1.duration_ then
				arg_95_1.duration_ = var_98_8 + var_98_7
			end

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1:AudioAction("play", "voice", "story_v_out_420121", "420121021", "story_v_out_420121.awb")
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play420121022 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 420121022
		arg_99_1.duration_ = 8.33

		local var_99_0 = {
			zh = 8.333,
			ja = 7.366
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play420121023(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				local var_102_0 = arg_99_1.bgs_.L01

				arg_99_1.bgs_.L01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_1 = var_102_0:GetComponent("SpriteRenderer")

				if var_102_1 and var_102_1.sprite then
					local var_102_2 = 2 * (var_102_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_0.transform.localScale = Vector3.New(var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "L01" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_3 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_4 = 2

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 then
				local var_102_5 = Color.New(1, 1, 1)

				var_102_5.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_3) / var_102_4)
				arg_99_1.mask_.color = var_102_5
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 then
				local var_102_6 = Color.New(1, 1, 1)

				arg_99_1.mask_.enabled = false
				var_102_6.a = 0
				arg_99_1.mask_.color = var_102_6
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(false)
				arg_99_1.dialog_:SetActive(false)
				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.cswbg_:SetActive(false)
			end

			local var_102_7 = arg_99_1.actors_["1085ui_story"].transform

			if 1.9 < arg_99_1.time_ and arg_99_1.time_ <= 1.9 + arg_102_0 then
				arg_99_1.var_.moveOldPos1085ui_story = var_102_7.localPosition
			end

			local var_102_8 = 0.001

			if 1.9 <= arg_99_1.time_ and arg_99_1.time_ < 1.9 + var_102_8 then
				var_102_7.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_99_1.time_ - 1.9) / var_102_8)
				var_102_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_7.position).x, (manager.ui.mainCamera.transform.position - var_102_7.position).y, (manager.ui.mainCamera.transform.position - var_102_7.position).z)
				var_102_7.localEulerAngles.z = 0
				var_102_7.localEulerAngles.x = 0
				var_102_7.localEulerAngles = var_102_7.localEulerAngles
			end

			if arg_99_1.time_ >= 1.9 + var_102_8 and arg_99_1.time_ < 1.9 + var_102_8 + arg_102_0 then
				var_102_7.localPosition = Vector3.New(0, -1.01, -5.83)
				var_102_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_7.position).x, (manager.ui.mainCamera.transform.position - var_102_7.position).y, (manager.ui.mainCamera.transform.position - var_102_7.position).z)
				var_102_7.localEulerAngles.z = 0
				var_102_7.localEulerAngles.x = 0
				var_102_7.localEulerAngles = var_102_7.localEulerAngles
			end

			local var_102_9 = arg_99_1.actors_["1085ui_story"]

			if 1.9 < arg_99_1.time_ and arg_99_1.time_ <= 1.9 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1085ui_story == nil then
				arg_99_1.var_.characterEffect1085ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_10 = 0.200000002980232

			if 1.9 <= arg_99_1.time_ and arg_99_1.time_ < 1.9 + var_102_10 and not isNil(var_102_9) then
				if arg_99_1.var_.characterEffect1085ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 1.9 + var_102_10 and arg_99_1.time_ < 1.9 + var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1085ui_story then
				arg_99_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 1.9 < arg_99_1.time_ and arg_99_1.time_ <= 1.9 + arg_102_0 then
				arg_99_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 1.9 < arg_99_1.time_ and arg_99_1.time_ <= 1.9 + arg_102_0 then
				arg_99_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_12 = 2
			local var_102_13 = 0.55

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_14 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_14:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_15 = arg_99_1:GetWordFromCfg(420121022)
				local var_102_16 = arg_99_1:FormatText(var_102_15.content)

				arg_99_1.text_.text = var_102_16

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_18 = 22 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_16) / 22)

				if (22 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_16) / 22)) > 0 and var_102_13 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18
					var_102_12 = var_102_12 + 0.3

					if var_102_18 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_16
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121022", "story_v_out_420121.awb") ~= 0 then
					local var_102_19 = manager.audio:GetVoiceLength("story_v_out_420121", "420121022", "story_v_out_420121.awb") / 1000

					if var_102_19 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_12
					end

					if var_102_15.prefab_name ~= "" and arg_99_1.actors_[var_102_15.prefab_name] ~= nil then
						local var_102_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_15.prefab_name].transform, "story_v_out_420121", "420121022", "story_v_out_420121.awb")

						arg_99_1:RecordAudio("420121022", var_102_20)
						arg_99_1:RecordAudio("420121022", var_102_20)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_420121", "420121022", "story_v_out_420121.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_420121", "420121022", "story_v_out_420121.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_21 = var_102_12 + 0.3
			local var_102_22 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_22 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_21) / var_102_22

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_21 + var_102_22 and arg_99_1.time_ < var_102_21 + var_102_22 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play420121023 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 420121023
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play420121024(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1085ui_story = arg_105_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).z)
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles = arg_105_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1085ui_story"].transform.position).z)
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1085ui_story"].transform.localEulerAngles = arg_105_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_108_1 = 0
			local var_108_2 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(420121023).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 18 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 18)

				if (18 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 18)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play420121024 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 420121024
		arg_109_1.duration_ = 5.3

		local var_109_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play420121025(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_112_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_109_1.stage_.transform)

				var_112_0.name = "404001ui_story"
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["404001ui_story"] = var_112_0

				local var_112_1 = var_112_0:GetComponentInChildren(typeof(CharacterEffect))

				var_112_1.enabled = true

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_0, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end

				arg_109_1:ShowWeapon(var_112_1.transform, false)

				arg_109_1.var_["404001ui_story" .. "Animator"] = var_112_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_109_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_109_1.var_["404001ui_story" .. "LipSync"] = var_112_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_112_3 = arg_109_1.actors_["404001ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos404001ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["404001ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect404001ui_story == nil then
				arg_109_1.var_.characterEffect404001ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect404001ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect404001ui_story then
				arg_109_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_8 = 0
			local var_112_9 = 0.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(420121024)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 16 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 16)

				if (16 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 16)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121024", "story_v_out_420121.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_420121", "420121024", "story_v_out_420121.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_420121", "420121024", "story_v_out_420121.awb")

						arg_109_1:RecordAudio("420121024", var_112_15)
						arg_109_1:RecordAudio("420121024", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_420121", "420121024", "story_v_out_420121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_420121", "420121024", "story_v_out_420121.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play420121025 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 420121025
		arg_113_1.duration_ = 5.73

		local var_113_0 = {
			zh = 4.166,
			ja = 5.733
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play420121026(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos404001ui_story = arg_113_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).z)
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles = arg_113_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_113_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["404001ui_story"].transform.position).z)
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["404001ui_story"].transform.localEulerAngles = arg_113_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1085ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1085ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = arg_113_1.actors_["1085ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect1085ui_story == nil then
				arg_113_1.var_.characterEffect1085ui_story = var_116_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 and not isNil(var_116_3) then
				if arg_113_1.var_.characterEffect1085ui_story and not isNil(var_116_3) then
					arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect1085ui_story then
				arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_116_6 = arg_113_1.actors_["404001ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect404001ui_story == nil then
				arg_113_1.var_.characterEffect404001ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect404001ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_113_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect404001ui_story then
				arg_113_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_113_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_116_8 = 0
			local var_116_9 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(420121025)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 14 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 14)

				if (14 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 14)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121025", "story_v_out_420121.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_420121", "420121025", "story_v_out_420121.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_420121", "420121025", "story_v_out_420121.awb")

						arg_113_1:RecordAudio("420121025", var_116_15)
						arg_113_1:RecordAudio("420121025", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_420121", "420121025", "story_v_out_420121.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_420121", "420121025", "story_v_out_420121.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play420121026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 420121026
		arg_117_1.duration_ = 10.57

		local var_117_0 = {
			zh = 8.733,
			ja = 10.566
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play420121027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["404001ui_story"]) and arg_117_1.var_.characterEffect404001ui_story == nil then
				arg_117_1.var_.characterEffect404001ui_story = arg_117_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["404001ui_story"]) then
				if arg_117_1.var_.characterEffect404001ui_story and not isNil(arg_117_1.actors_["404001ui_story"]) then
					arg_117_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["404001ui_story"]) and arg_117_1.var_.characterEffect404001ui_story then
				arg_117_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1085ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1085ui_story == nil then
				arg_117_1.var_.characterEffect1085ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1085ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1085ui_story then
				arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.9

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(420121026)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 36 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 36)

				if (36 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 36)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121026", "story_v_out_420121.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121026", "story_v_out_420121.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_420121", "420121026", "story_v_out_420121.awb")

						arg_117_1:RecordAudio("420121026", var_120_11)
						arg_117_1:RecordAudio("420121026", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_420121", "420121026", "story_v_out_420121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_420121", "420121026", "story_v_out_420121.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play420121027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 420121027
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play420121028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos404001ui_story = arg_121_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).z)
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles = arg_121_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["404001ui_story"].transform.position).z)
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["404001ui_story"].transform.localEulerAngles = arg_121_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1085ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1085ui_story = var_124_1.localPosition
			end

			local var_124_2 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 then
				var_124_1.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_2)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 then
				var_124_1.localPosition = Vector3.New(0, 100, 0)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			if 0.200000002980232 < arg_121_1.time_ and arg_121_1.time_ <= 0.200000002980232 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car03", "")
			end

			local var_124_4 = 0
			local var_124_5 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(420121027).content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 29 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_6) / 29)

				if (29 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_6) / 29)) > 0 and var_124_5 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_9 and arg_121_1.time_ < var_124_4 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play420121028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 420121028
		arg_125_1.duration_ = 5.17

		local var_125_0 = {
			zh = 3.266,
			ja = 5.166
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play420121029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos404001ui_story = arg_125_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).z)
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles = arg_125_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_125_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).z)
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles = arg_125_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["404001ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect404001ui_story == nil then
				arg_125_1.var_.characterEffect404001ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect404001ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect404001ui_story then
				arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_128_4 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_4 + 1 and arg_125_1.time_ < var_128_4 + 1 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_5 = 0
			local var_128_6 = 0.275

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(420121028)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 11 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 11)

				if (11 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 11)) > 0 and var_128_6 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121028", "story_v_out_420121.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_420121", "420121028", "story_v_out_420121.awb") / 1000

					if var_128_11 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_5
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_420121", "420121028", "story_v_out_420121.awb")

						arg_125_1:RecordAudio("420121028", var_128_12)
						arg_125_1:RecordAudio("420121028", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_420121", "420121028", "story_v_out_420121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_420121", "420121028", "story_v_out_420121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_13 and arg_125_1.time_ < var_128_5 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play420121029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 420121029
		arg_129_1.duration_ = 12.27

		local var_129_0 = {
			zh = 11.333,
			ja = 12.266
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play420121030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= 4 + 0.3 and arg_129_1.time_ < 4 + 0.3 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_0 = "L16g"

			if arg_129_1.bgs_.L16g == nil then
				local var_132_1 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_0)
				var_132_1.name = var_132_0
				var_132_1.transform.parent = arg_129_1.stage_.transform
				var_132_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_0] = var_132_1
			end

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				local var_132_2 = arg_129_1.bgs_.L16g

				arg_129_1.bgs_.L16g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_3 = var_132_2:GetComponent("SpriteRenderer")

				if var_132_3 and var_132_3.sprite then
					local var_132_4 = 2 * (var_132_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_2.transform.localScale = Vector3.New(var_132_4 / var_132_3.sprite.bounds.size.y < var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x and var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x or var_132_4 / var_132_3.sprite.bounds.size.y, var_132_4 / var_132_3.sprite.bounds.size.y < var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x and var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x or var_132_4 / var_132_3.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "L16g" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_5 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_6 = 2

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 then
				local var_132_7 = Color.New(0, 0, 0)

				var_132_7.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_5) / var_132_6)
				arg_129_1.mask_.color = var_132_7
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 then
				local var_132_8 = Color.New(0, 0, 0)

				var_132_8.a = 1
				arg_129_1.mask_.color = var_132_8
			end

			local var_132_9 = 2

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_10 = 2

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_10 then
				local var_132_11 = Color.New(0, 0, 0)

				var_132_11.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_9) / var_132_10)
				arg_129_1.mask_.color = var_132_11
			end

			if arg_129_1.time_ >= var_132_9 + var_132_10 and arg_129_1.time_ < var_132_9 + var_132_10 + arg_132_0 then
				local var_132_12 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_12.a = 0
				arg_129_1.mask_.color = var_132_12
			end

			local var_132_13 = arg_129_1.actors_["404001ui_story"].transform

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				arg_129_1.var_.moveOldPos404001ui_story = var_132_13.localPosition
			end

			local var_132_14 = 0.001

			if 2 <= arg_129_1.time_ and arg_129_1.time_ < 2 + var_132_14 then
				var_132_13.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 2) / var_132_14)
				var_132_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_13.position).x, (manager.ui.mainCamera.transform.position - var_132_13.position).y, (manager.ui.mainCamera.transform.position - var_132_13.position).z)
				var_132_13.localEulerAngles.z = 0
				var_132_13.localEulerAngles.x = 0
				var_132_13.localEulerAngles = var_132_13.localEulerAngles
			end

			if arg_129_1.time_ >= 2 + var_132_14 and arg_129_1.time_ < 2 + var_132_14 + arg_132_0 then
				var_132_13.localPosition = Vector3.New(0, 100, 0)
				var_132_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_13.position).x, (manager.ui.mainCamera.transform.position - var_132_13.position).y, (manager.ui.mainCamera.transform.position - var_132_13.position).z)
				var_132_13.localEulerAngles.z = 0
				var_132_13.localEulerAngles.x = 0
				var_132_13.localEulerAngles = var_132_13.localEulerAngles
			end

			if 0.466666666666667 < arg_129_1.time_ and arg_129_1.time_ <= 0.466666666666667 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_132_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_17 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_17

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_17
						arg_129_1.bgmTxt2_.text = var_132_17
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.76666666666667 < arg_129_1.time_ and arg_129_1.time_ <= 1.76666666666667 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dreamland", "")
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_19 = 4
			local var_132_20 = 0.65

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_21 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_21:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_129_1.dialogCg_.alpha = arg_134_0
				end))
				var_132_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_22 = arg_129_1:GetWordFromCfg(420121029)
				local var_132_23 = arg_129_1:FormatText(var_132_22.content)

				arg_129_1.text_.text = var_132_23

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_25 = 26 <= 0 and var_132_20 or var_132_20 * (utf8.len(var_132_23) / 26)

				if (26 <= 0 and var_132_20 or var_132_20 * (utf8.len(var_132_23) / 26)) > 0 and var_132_20 < var_132_25 then
					arg_129_1.talkMaxDuration = var_132_25
					var_132_19 = var_132_19 + 0.3

					if var_132_25 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_25 + var_132_19
					end
				end

				arg_129_1.text_.text = var_132_23
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121029", "story_v_out_420121.awb") ~= 0 then
					local var_132_26 = manager.audio:GetVoiceLength("story_v_out_420121", "420121029", "story_v_out_420121.awb") / 1000

					if var_132_26 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_26 + var_132_19
					end

					if var_132_22.prefab_name ~= "" and arg_129_1.actors_[var_132_22.prefab_name] ~= nil then
						local var_132_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_22.prefab_name].transform, "story_v_out_420121", "420121029", "story_v_out_420121.awb")

						arg_129_1:RecordAudio("420121029", var_132_27)
						arg_129_1:RecordAudio("420121029", var_132_27)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_420121", "420121029", "story_v_out_420121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_420121", "420121029", "story_v_out_420121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_28 = var_132_19 + 0.3
			local var_132_29 = math.max(var_132_20, arg_129_1.talkMaxDuration)

			if var_132_19 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_28 + var_132_29 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_28) / var_132_29

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_28 + var_132_29 and arg_129_1.time_ < var_132_28 + var_132_29 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play420121030 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420121030
		arg_136_1.duration_ = 11.8

		local var_136_0 = {
			zh = 11.066,
			ja = 11.8
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play420121031(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.925

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(420121030)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 37 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 37)

				if (37 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 37)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121030", "story_v_out_420121.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121030", "story_v_out_420121.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_420121", "420121030", "story_v_out_420121.awb")

						arg_136_1:RecordAudio("420121030", var_139_6)
						arg_136_1:RecordAudio("420121030", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_420121", "420121030", "story_v_out_420121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_420121", "420121030", "story_v_out_420121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play420121031 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 420121031
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play420121032(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_143_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_2 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_2

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_2
						arg_140_1.bgmTxt2_.text = var_143_2
					end

					if arg_140_1.bgmTimer then
						arg_140_1.bgmTimer:Stop()

						arg_140_1.bgmTimer = nil
					end

					if arg_140_1.settingData.show_music_name == 1 then
						arg_140_1.musicController:SetSelectedState("show")
						arg_140_1.musicAnimator_:Play("open", 0, 0)

						if arg_140_1.settingData.music_time ~= 0 then
							arg_140_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_140_1.settingData.music_time), function()
								if arg_140_1 == nil or isNil(arg_140_1.bgmTxt_) then
									return
								end

								arg_140_1.musicController:SetSelectedState("hide")
								arg_140_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 0.333333333333333 + arg_143_0 then
				arg_140_1:AudioAction("play", "music", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_143_5 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if "" ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_5 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_5

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_5
						arg_140_1.bgmTxt2_.text = var_143_5
					end

					if arg_140_1.bgmTimer then
						arg_140_1.bgmTimer:Stop()

						arg_140_1.bgmTimer = nil
					end

					if arg_140_1.settingData.show_music_name == 1 then
						arg_140_1.musicController:SetSelectedState("show")
						arg_140_1.musicAnimator_:Play("open", 0, 0)

						if arg_140_1.settingData.music_time ~= 0 then
							arg_140_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_140_1.settingData.music_time), function()
								if arg_140_1 == nil or isNil(arg_140_1.bgmTxt_) then
									return
								end

								arg_140_1.musicController:SetSelectedState("hide")
								arg_140_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_143_6 = 0
			local var_143_7 = 0.125

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_8 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(420121031).content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 5 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_8) / 5)

				if (5 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_8) / 5)) > 0 and var_143_7 < var_143_10 then
					arg_140_1.talkMaxDuration = var_143_10

					if var_143_10 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_11 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_11 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_11

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_11 and arg_140_1.time_ < var_143_6 + var_143_11 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play420121032 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 420121032
		arg_146_1.duration_ = 9.7

		local var_146_0 = {
			zh = 7.633,
			ja = 9.7
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play420121033(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1085ui_story = arg_146_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).z)
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles = arg_146_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_146_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1085ui_story"].transform.position).z)
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1085ui_story"].transform.localEulerAngles = arg_146_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1085ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1085ui_story == nil then
				arg_146_1.var_.characterEffect1085ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1085ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1085ui_story then
				arg_146_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_149_4 = 0
			local var_149_5 = 0.65

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(420121032)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 26 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 26)

				if (26 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 26)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121032", "story_v_out_420121.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121032", "story_v_out_420121.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_420121", "420121032", "story_v_out_420121.awb")

						arg_146_1:RecordAudio("420121032", var_149_11)
						arg_146_1:RecordAudio("420121032", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_420121", "420121032", "story_v_out_420121.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_420121", "420121032", "story_v_out_420121.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play420121033 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 420121033
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play420121034(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1085ui_story"]) and arg_150_1.var_.characterEffect1085ui_story == nil then
				arg_150_1.var_.characterEffect1085ui_story = arg_150_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1085ui_story"]) then
				if arg_150_1.var_.characterEffect1085ui_story and not isNil(arg_150_1.actors_["1085ui_story"]) then
					arg_150_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1085ui_story"]) and arg_150_1.var_.characterEffect1085ui_story then
				arg_150_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 0.35

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(420121033).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 14 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 14)

				if (14 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 14)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play420121034 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 420121034
		arg_154_1.duration_ = 2.83

		local var_154_0 = {
			zh = 2.166,
			ja = 2.833
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play420121035(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1085ui_story"]) and arg_154_1.var_.characterEffect1085ui_story == nil then
				arg_154_1.var_.characterEffect1085ui_story = arg_154_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1085ui_story"]) then
				if arg_154_1.var_.characterEffect1085ui_story and not isNil(arg_154_1.actors_["1085ui_story"]) then
					arg_154_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1085ui_story"]) and arg_154_1.var_.characterEffect1085ui_story then
				arg_154_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_157_2 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			if arg_154_1.time_ >= var_157_2 + 0.633333333333333 and arg_154_1.time_ < var_157_2 + 0.633333333333333 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_3 = 0
			local var_157_4 = 0.125

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_3 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_5 = arg_154_1:GetWordFromCfg(420121034)
				local var_157_6 = arg_154_1:FormatText(var_157_5.content)

				arg_154_1.text_.text = var_157_6

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_8 = 5 <= 0 and var_157_4 or var_157_4 * (utf8.len(var_157_6) / 5)

				if (5 <= 0 and var_157_4 or var_157_4 * (utf8.len(var_157_6) / 5)) > 0 and var_157_4 < var_157_8 then
					arg_154_1.talkMaxDuration = var_157_8

					if var_157_8 + var_157_3 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_3
					end
				end

				arg_154_1.text_.text = var_157_6
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121034", "story_v_out_420121.awb") ~= 0 then
					local var_157_9 = manager.audio:GetVoiceLength("story_v_out_420121", "420121034", "story_v_out_420121.awb") / 1000

					if var_157_9 + var_157_3 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_3
					end

					if var_157_5.prefab_name ~= "" and arg_154_1.actors_[var_157_5.prefab_name] ~= nil then
						local var_157_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_5.prefab_name].transform, "story_v_out_420121", "420121034", "story_v_out_420121.awb")

						arg_154_1:RecordAudio("420121034", var_157_10)
						arg_154_1:RecordAudio("420121034", var_157_10)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_420121", "420121034", "story_v_out_420121.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_420121", "420121034", "story_v_out_420121.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_11 = math.max(var_157_4, arg_154_1.talkMaxDuration)

			if var_157_3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_3 + var_157_11 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_3) / var_157_11

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_3 + var_157_11 and arg_154_1.time_ < var_157_3 + var_157_11 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play420121035 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 420121035
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play420121036(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1085ui_story"]) and arg_158_1.var_.characterEffect1085ui_story == nil then
				arg_158_1.var_.characterEffect1085ui_story = arg_158_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1085ui_story"]) then
				if arg_158_1.var_.characterEffect1085ui_story and not isNil(arg_158_1.actors_["1085ui_story"]) then
					arg_158_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1085ui_story"]) and arg_158_1.var_.characterEffect1085ui_story then
				arg_158_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.675

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(420121035).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 27 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 27)

				if (27 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 27)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play420121036 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 420121036
		arg_162_1.duration_ = 4.57

		local var_162_0 = {
			zh = 4.133,
			ja = 4.566
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play420121037(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1085ui_story"]) and arg_162_1.var_.characterEffect1085ui_story == nil then
				arg_162_1.var_.characterEffect1085ui_story = arg_162_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1085ui_story"]) then
				if arg_162_1.var_.characterEffect1085ui_story and not isNil(arg_162_1.actors_["1085ui_story"]) then
					arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1085ui_story"]) and arg_162_1.var_.characterEffect1085ui_story then
				arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_165_2 = 0
			local var_165_3 = 0.6

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(420121036)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 24 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 24)

				if (24 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 24)) > 0 and var_165_3 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121036", "story_v_out_420121.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121036", "story_v_out_420121.awb") / 1000

					if var_165_8 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_2
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_420121", "420121036", "story_v_out_420121.awb")

						arg_162_1:RecordAudio("420121036", var_165_9)
						arg_162_1:RecordAudio("420121036", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_420121", "420121036", "story_v_out_420121.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_420121", "420121036", "story_v_out_420121.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_10 and arg_162_1.time_ < var_165_2 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play420121037 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 420121037
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play420121038(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1085ui_story = arg_166_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).z)
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles = arg_166_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1085ui_story"].transform.position).z)
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1085ui_story"].transform.localEulerAngles = arg_166_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_169_1 = 0
			local var_169_2 = 0.575

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(420121037).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 23 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 23)

				if (23 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 23)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play420121038 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 420121038
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play420121039(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.8

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(420121038).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 32 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 32)

				if (32 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 32)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play420121039 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 420121039
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play420121040(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.875

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(420121039).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 35 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 35)

				if (35 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 35)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play420121040 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 420121040
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play420121041(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.725

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(420121040).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 29 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 29)

				if (29 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 29)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play420121041 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 420121041
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play420121042(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.15

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(420121041).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 46 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 46)

				if (46 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 46)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play420121042 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 420121042
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play420121043(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 1.2

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(420121042).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 48 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 48)

				if (48 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 48)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play420121043 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 420121043
		arg_190_1.duration_ = 4.13

		local var_190_0 = {
			zh = 3.9,
			ja = 4.133
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play420121044(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1085ui_story = arg_190_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).z)
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles = arg_190_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_190_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).z)
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles = arg_190_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1085ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1085ui_story == nil then
				arg_190_1.var_.characterEffect1085ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1085ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1085ui_story then
				arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_193_4 = 0
			local var_193_5 = 0.4

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(420121043)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 16 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 16)

				if (16 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 16)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121043", "story_v_out_420121.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121043", "story_v_out_420121.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_420121", "420121043", "story_v_out_420121.awb")

						arg_190_1:RecordAudio("420121043", var_193_11)
						arg_190_1:RecordAudio("420121043", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_420121", "420121043", "story_v_out_420121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_420121", "420121043", "story_v_out_420121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play420121044 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 420121044
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play420121045(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1085ui_story = arg_194_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).z)
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles = arg_194_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).z)
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles = arg_194_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_197_1 = 0
			local var_197_2 = 0.775

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(420121044).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 31 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 31)

				if (31 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 31)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play420121045 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 420121045
		arg_198_1.duration_ = 7.67

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play420121046(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_0 = 1

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				local var_201_1 = Color.New(0, 0, 0)

				var_201_1.a = Mathf.Lerp(0, 1, (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.mask_.color = var_201_1
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				local var_201_2 = Color.New(0, 0, 0)

				var_201_2.a = 1
				arg_198_1.mask_.color = var_201_2
			end

			local var_201_3 = 1

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_4 = 1

			if var_201_3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_3 + var_201_4 then
				local var_201_5 = Color.New(0, 0, 0)

				var_201_5.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_3) / var_201_4)
				arg_198_1.mask_.color = var_201_5
			end

			if arg_198_1.time_ >= var_201_3 + var_201_4 and arg_198_1.time_ < var_201_3 + var_201_4 + arg_201_0 then
				local var_201_6 = Color.New(0, 0, 0)

				arg_198_1.mask_.enabled = false
				var_201_6.a = 0
				arg_198_1.mask_.color = var_201_6
			end

			local var_201_7 = "SS2002"

			if arg_198_1.bgs_.SS2002 == nil then
				local var_201_8 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_201_7)
				var_201_8.name = var_201_7
				var_201_8.transform.parent = arg_198_1.stage_.transform
				var_201_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_[var_201_7] = var_201_8
			end

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= 1 + arg_201_0 then
				local var_201_9 = arg_198_1.bgs_.SS2002

				arg_198_1.bgs_.SS2002.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_201_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_10 = var_201_9:GetComponent("SpriteRenderer")

				if var_201_10 and var_201_10.sprite then
					local var_201_11 = 2 * (var_201_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_201_9.transform.localScale = Vector3.New(var_201_11 / var_201_10.sprite.bounds.size.y < var_201_11 * manager.ui.mainCameraCom_.aspect / var_201_10.sprite.bounds.size.x and var_201_11 * manager.ui.mainCameraCom_.aspect / var_201_10.sprite.bounds.size.x or var_201_11 / var_201_10.sprite.bounds.size.y, var_201_11 / var_201_10.sprite.bounds.size.y < var_201_11 * manager.ui.mainCameraCom_.aspect / var_201_10.sprite.bounds.size.x and var_201_11 * manager.ui.mainCameraCom_.aspect / var_201_10.sprite.bounds.size.x or var_201_11 / var_201_10.sprite.bounds.size.y, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "SS2002" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_12 = arg_198_1.bgs_.SS2002.transform

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= 1 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2002 = var_201_12.localPosition
			end

			local var_201_13 = 0.001

			if 1 <= arg_198_1.time_ and arg_198_1.time_ < 1 + var_201_13 then
				var_201_12.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2002, Vector3.New(0, 1, 9), (arg_198_1.time_ - 1) / var_201_13)
			end

			if arg_198_1.time_ >= 1 + var_201_13 and arg_198_1.time_ < 1 + var_201_13 + arg_201_0 then
				var_201_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_201_14 = arg_198_1.bgs_.SS2002.transform

			if 1.03333333333333 < arg_198_1.time_ and arg_198_1.time_ <= 1.03333333333333 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2002 = var_201_14.localPosition
			end

			local var_201_15 = 1.63333333333333

			if 1.03333333333333 <= arg_198_1.time_ and arg_198_1.time_ < 1.03333333333333 + var_201_15 then
				var_201_14.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2002, Vector3.New(0, 0.8, 9), (arg_198_1.time_ - 1.03333333333333) / var_201_15)
			end

			if arg_198_1.time_ >= 1.03333333333333 + var_201_15 and arg_198_1.time_ < 1.03333333333333 + var_201_15 + arg_201_0 then
				var_201_14.localPosition = Vector3.New(0, 0.8, 9)
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_16 = 2.66666666666667
			local var_201_17 = 1.075

			if 2.66666666666667 < arg_198_1.time_ and arg_198_1.time_ <= var_201_16 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_18 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_18:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_19 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(420121045).content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_21 = 43 <= 0 and var_201_17 or var_201_17 * (utf8.len(var_201_19) / 43)

				if (43 <= 0 and var_201_17 or var_201_17 * (utf8.len(var_201_19) / 43)) > 0 and var_201_17 < var_201_21 then
					arg_198_1.talkMaxDuration = var_201_21
					var_201_16 = var_201_16 + 0.3

					if var_201_21 + var_201_16 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_21 + var_201_16
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = var_201_16 + 0.3
			local var_201_23 = math.max(var_201_17, arg_198_1.talkMaxDuration)

			if var_201_16 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_22 + var_201_23 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_22) / var_201_23

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_22 + var_201_23 and arg_198_1.time_ < var_201_22 + var_201_23 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2002",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333334,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2002",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.63333333333333,
				className = "StoryMoveNode",
				startTime = 1.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play420121046 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 420121046
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play420121047(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.775

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(420121046).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 31 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 31)

				if (31 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 31)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play420121047 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 420121047
		arg_208_1.duration_ = 5.2

		local var_208_0 = {
			zh = 5.2,
			ja = 3.133
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play420121048(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.45

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(420121047)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 18 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 18)

				if (18 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 18)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121047", "story_v_out_420121.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121047", "story_v_out_420121.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_420121", "420121047", "story_v_out_420121.awb")

						arg_208_1:RecordAudio("420121047", var_211_6)
						arg_208_1:RecordAudio("420121047", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_420121", "420121047", "story_v_out_420121.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_420121", "420121047", "story_v_out_420121.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play420121048 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 420121048
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play420121049(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 1.25

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(420121048).content)

				arg_212_1.text_.text = var_215_1

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_3 = 50 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 50)

				if (50 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 50)) > 0 and var_215_0 < var_215_3 then
					arg_212_1.talkMaxDuration = var_215_3

					if var_215_3 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_3 + 0
					end
				end

				arg_212_1.text_.text = var_215_1
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_4 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_4

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play420121049 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 420121049
		arg_216_1.duration_ = 2.1

		local var_216_0 = {
			zh = 1.834,
			ja = 2.1
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play420121050(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if arg_216_1.bgs_.SS2002a == nil then
				local var_219_0 = Object.Instantiate(arg_216_1.paintGo_)

				var_219_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2002a")
				var_219_0.name = "SS2002a"
				var_219_0.transform.parent = arg_216_1.stage_.transform
				var_219_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_.SS2002a = var_219_0
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				local var_219_1 = arg_216_1.bgs_.SS2002a

				arg_216_1.bgs_.SS2002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_219_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_2 = var_219_1:GetComponent("SpriteRenderer")

				if var_219_2 and var_219_2.sprite then
					local var_219_3 = 2 * (var_219_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_219_1.transform.localScale = Vector3.New(var_219_3 / var_219_2.sprite.bounds.size.y < var_219_3 * manager.ui.mainCameraCom_.aspect / var_219_2.sprite.bounds.size.x and var_219_3 * manager.ui.mainCameraCom_.aspect / var_219_2.sprite.bounds.size.x or var_219_3 / var_219_2.sprite.bounds.size.y, var_219_3 / var_219_2.sprite.bounds.size.y < var_219_3 * manager.ui.mainCameraCom_.aspect / var_219_2.sprite.bounds.size.x and var_219_3 * manager.ui.mainCameraCom_.aspect / var_219_2.sprite.bounds.size.x or var_219_3 / var_219_2.sprite.bounds.size.y, 0)
				end

				for iter_219_0, iter_219_1 in pairs(arg_216_1.bgs_) do
					if iter_219_0 ~= "SS2002a" then
						iter_219_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_219_4 = arg_216_1.bgs_.SS2002a.transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPosSS2002a = var_219_4.localPosition
			end

			local var_219_5 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_5 then
				var_219_4.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPosSS2002a, Vector3.New(0, 0.8, 9), (arg_216_1.time_ - 0) / var_219_5)
			end

			if arg_216_1.time_ >= 0 + var_219_5 and arg_216_1.time_ < 0 + var_219_5 + arg_219_0 then
				var_219_4.localPosition = Vector3.New(0, 0.8, 9)
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_6 = 0.034
			local var_219_7 = 0.125

			if 0.034 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_8 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_8:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_9 = arg_216_1:GetWordFromCfg(420121049)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_12 = 5 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_10) / 5)

				if (5 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_10) / 5)) > 0 and var_219_7 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12
					var_219_6 = var_219_6 + 0.3

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121049", "story_v_out_420121.awb") ~= 0 then
					local var_219_13 = manager.audio:GetVoiceLength("story_v_out_420121", "420121049", "story_v_out_420121.awb") / 1000

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end

					if var_219_9.prefab_name ~= "" and arg_216_1.actors_[var_219_9.prefab_name] ~= nil then
						local var_219_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_9.prefab_name].transform, "story_v_out_420121", "420121049", "story_v_out_420121.awb")

						arg_216_1:RecordAudio("420121049", var_219_14)
						arg_216_1:RecordAudio("420121049", var_219_14)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_420121", "420121049", "story_v_out_420121.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_420121", "420121049", "story_v_out_420121.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_15 = var_219_6 + 0.3
			local var_219_16 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_15) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_15 + var_219_16 and arg_216_1.time_ < var_219_15 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play420121050 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 420121050
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play420121051(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(420121050).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 18 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 18)

				if (18 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 18)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play420121051 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 420121051
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play420121052(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(420121051).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 53 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 53)

				if (53 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 53)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play420121052 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 420121052
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play420121053(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.05

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(420121052).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 42 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 42)

				if (42 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 42)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play420121053 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 420121053
		arg_234_1.duration_ = 9.17

		local var_234_0 = {
			zh = 8.36666666666667,
			ja = 9.16666666666667
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play420121054(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_9001
			local var_237_9000

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				if arg_234_1.var_.effect1048 then
					Object.Destroy(arg_234_1.var_.effect1048)

					arg_234_1.var_.effect1048 = nil
				end
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				local var_237_1 = arg_234_1.var_.effect1053

				if not arg_234_1.var_.effect1053 then
					var_237_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_237_1.name = "1053"
					arg_234_1.var_.effect1053 = var_237_1
				else
					var_237_1.transform:SetParent(var_237_9001)
				end

				var_237_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_237_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_234_1.time_ and arg_234_1.time_ <= 1.2 + arg_237_0 then
				if arg_234_1.var_.effect1053 then
					Object.Destroy(arg_234_1.var_.effect1053)

					arg_234_1.var_.effect1053 = nil
				end
			end

			if 1.2 < arg_234_1.time_ and arg_234_1.time_ <= 1.2 + arg_237_0 then
				local var_237_4 = arg_234_1.var_.effect10532

				if not arg_234_1.var_.effect10532 then
					var_237_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_237_4.name = "10532"
					arg_234_1.var_.effect10532 = var_237_4
				else
					var_237_4.transform:SetParent(var_237_9000)
				end

				var_237_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_237_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.73333333333333 < arg_234_1.time_ and arg_234_1.time_ <= 2.73333333333333 + arg_237_0 then
				if arg_234_1.var_.effect10532 then
					Object.Destroy(arg_234_1.var_.effect10532)

					arg_234_1.var_.effect10532 = nil
				end
			end

			local var_237_7 = "SS2002d"

			if arg_234_1.bgs_.SS2002d == nil then
				local var_237_8 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_7)
				var_237_8.name = var_237_7
				var_237_8.transform.parent = arg_234_1.stage_.transform
				var_237_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_7] = var_237_8
			end

			local var_237_9 = arg_234_1.bgs_.SS2002d.transform

			if 1.2 < arg_234_1.time_ and arg_234_1.time_ <= 1.2 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS2002d = var_237_9.localPosition
			end

			local var_237_10 = 0.001

			if 1.2 <= arg_234_1.time_ and arg_234_1.time_ < 1.2 + var_237_10 then
				var_237_9.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS2002d, Vector3.New(0, 1, 9), (arg_234_1.time_ - 1.2) / var_237_10)
			end

			if arg_234_1.time_ >= 1.2 + var_237_10 and arg_234_1.time_ < 1.2 + var_237_10 + arg_237_0 then
				var_237_9.localPosition = Vector3.New(0, 1, 9)
			end

			local var_237_11 = arg_234_1.bgs_.SS2002d.transform

			if 1.23400000184774 < arg_234_1.time_ and arg_234_1.time_ <= 1.23400000184774 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS2002d = var_237_11.localPosition
			end

			local var_237_12 = 1.43266666481892

			if 1.23400000184774 <= arg_234_1.time_ and arg_234_1.time_ < 1.23400000184774 + var_237_12 then
				var_237_11.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS2002d, Vector3.New(0, 1, 8.8), (arg_234_1.time_ - 1.23400000184774) / var_237_12)
			end

			if arg_234_1.time_ >= 1.23400000184774 + var_237_12 and arg_234_1.time_ < 1.23400000184774 + var_237_12 + arg_237_0 then
				var_237_11.localPosition = Vector3.New(0, 1, 8.8)
			end

			if 1.16599999815226 < arg_234_1.time_ and arg_234_1.time_ <= 1.16599999815226 + arg_237_0 then
				local var_237_13 = arg_234_1.bgs_.SS2002d

				arg_234_1.bgs_.SS2002d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_237_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_14 = var_237_13:GetComponent("SpriteRenderer")

				if var_237_14 and var_237_14.sprite then
					local var_237_15 = 2 * (var_237_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_237_13.transform.localScale = Vector3.New(var_237_15 / var_237_14.sprite.bounds.size.y < var_237_15 * manager.ui.mainCameraCom_.aspect / var_237_14.sprite.bounds.size.x and var_237_15 * manager.ui.mainCameraCom_.aspect / var_237_14.sprite.bounds.size.x or var_237_15 / var_237_14.sprite.bounds.size.y, var_237_15 / var_237_14.sprite.bounds.size.y < var_237_15 * manager.ui.mainCameraCom_.aspect / var_237_14.sprite.bounds.size.x and var_237_15 * manager.ui.mainCameraCom_.aspect / var_237_14.sprite.bounds.size.x or var_237_15 / var_237_14.sprite.bounds.size.y, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS2002d" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_16 = 0

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= var_237_16 + 2.95 and arg_234_1.time_ < var_237_16 + 2.95 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_17 = 2.66666666666667
			local var_237_18 = 0.4

			if 2.66666666666667 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_19 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_19:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_20 = arg_234_1:GetWordFromCfg(420121053)
				local var_237_21 = arg_234_1:FormatText(var_237_20.content)

				arg_234_1.text_.text = var_237_21

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_23 = 16 <= 0 and var_237_18 or var_237_18 * (utf8.len(var_237_21) / 16)

				if (16 <= 0 and var_237_18 or var_237_18 * (utf8.len(var_237_21) / 16)) > 0 and var_237_18 < var_237_23 then
					arg_234_1.talkMaxDuration = var_237_23
					var_237_17 = var_237_17 + 0.3

					if var_237_23 + var_237_17 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_17
					end
				end

				arg_234_1.text_.text = var_237_21
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121053", "story_v_out_420121.awb") ~= 0 then
					local var_237_24 = manager.audio:GetVoiceLength("story_v_out_420121", "420121053", "story_v_out_420121.awb") / 1000

					if var_237_24 + var_237_17 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_24 + var_237_17
					end

					if var_237_20.prefab_name ~= "" and arg_234_1.actors_[var_237_20.prefab_name] ~= nil then
						local var_237_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_20.prefab_name].transform, "story_v_out_420121", "420121053", "story_v_out_420121.awb")

						arg_234_1:RecordAudio("420121053", var_237_25)
						arg_234_1:RecordAudio("420121053", var_237_25)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_420121", "420121053", "story_v_out_420121.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_420121", "420121053", "story_v_out_420121.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_26 = var_237_17 + 0.3
			local var_237_27 = math.max(var_237_18, arg_234_1.talkMaxDuration)

			if var_237_17 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_26 + var_237_27 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_26) / var_237_27

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_26 + var_237_27 and arg_234_1.time_ < var_237_26 + var_237_27 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2002d",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2002d",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.43266666481892,
				className = "StoryMoveNode",
				startTime = 1.23400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play420121054 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 420121054
		arg_240_1.duration_ = 11.17

		local var_240_0 = {
			zh = 6.566,
			ja = 11.166
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play420121055(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.55

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(420121054)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 22 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 22)

				if (22 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 22)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121054", "story_v_out_420121.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_420121", "420121054", "story_v_out_420121.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_420121", "420121054", "story_v_out_420121.awb")

						arg_240_1:RecordAudio("420121054", var_243_6)
						arg_240_1:RecordAudio("420121054", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_420121", "420121054", "story_v_out_420121.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_420121", "420121054", "story_v_out_420121.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play420121055 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 420121055
		arg_244_1.duration_ = 10.83

		local var_244_0 = {
			zh = 8.333,
			ja = 10.833
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play420121056(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				if arg_244_1.var_.effect then
					Object.Destroy(arg_244_1.var_.effect)

					arg_244_1.var_.effect = nil
				end
			end

			local var_247_0 = 0
			local var_247_1 = 0.675

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_2 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_2:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(420121055)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_6 = 27 <= 0 and var_247_1 or var_247_1 * (utf8.len(var_247_4) / 27)

				if (27 <= 0 and var_247_1 or var_247_1 * (utf8.len(var_247_4) / 27)) > 0 and var_247_1 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6
					var_247_0 = var_247_0 + 0.3

					if var_247_6 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121055", "story_v_out_420121.awb") ~= 0 then
					local var_247_7 = manager.audio:GetVoiceLength("story_v_out_420121", "420121055", "story_v_out_420121.awb") / 1000

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_420121", "420121055", "story_v_out_420121.awb")

						arg_244_1:RecordAudio("420121055", var_247_8)
						arg_244_1:RecordAudio("420121055", var_247_8)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_420121", "420121055", "story_v_out_420121.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_420121", "420121055", "story_v_out_420121.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = var_247_0 + 0.3
			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 + 0.3 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_9) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play420121056 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 420121056
		arg_250_1.duration_ = 6.5

		local var_250_0 = {
			zh = 6.5,
			ja = 6.433
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play420121057(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if arg_250_1.bgs_.SS2002b == nil then
				local var_253_0 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2002b")
				var_253_0.name = "SS2002b"
				var_253_0.transform.parent = arg_250_1.stage_.transform
				var_253_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_.SS2002b = var_253_0
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				local var_253_1 = arg_250_1.bgs_.SS2002b

				arg_250_1.bgs_.SS2002b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_253_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_2 = var_253_1:GetComponent("SpriteRenderer")

				if var_253_2 and var_253_2.sprite then
					local var_253_3 = 2 * (var_253_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_253_1.transform.localScale = Vector3.New(var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "SS2002b" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_4 = 0
			local var_253_5 = 0.575

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(420121056)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 23 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 23)

				if (23 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 23)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121056", "story_v_out_420121.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121056", "story_v_out_420121.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_out_420121", "420121056", "story_v_out_420121.awb")

						arg_250_1:RecordAudio("420121056", var_253_11)
						arg_250_1:RecordAudio("420121056", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_420121", "420121056", "story_v_out_420121.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_420121", "420121056", "story_v_out_420121.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play420121057 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 420121057
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play420121058(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(420121057).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 16)

				if (16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 16)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play420121058 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 420121058
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play420121059(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.35

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(420121058).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 54 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 54)

				if (54 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 54)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play420121059 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 420121059
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play420121060(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.7

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(420121059).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 28 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 28)

				if (28 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 28)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play420121060 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 420121060
		arg_266_1.duration_ = 3.03

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play420121061(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if arg_266_1.bgs_.SS2002e == nil then
				local var_269_0 = Object.Instantiate(arg_266_1.paintGo_)

				var_269_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2002e")
				var_269_0.name = "SS2002e"
				var_269_0.transform.parent = arg_266_1.stage_.transform
				var_269_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.bgs_.SS2002e = var_269_0
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				local var_269_1 = arg_266_1.bgs_.SS2002e

				arg_266_1.bgs_.SS2002e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_269_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_269_2 = var_269_1:GetComponent("SpriteRenderer")

				if var_269_2 and var_269_2.sprite then
					local var_269_3 = 2 * (var_269_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_269_1.transform.localScale = Vector3.New(var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, 0)
				end

				for iter_269_0, iter_269_1 in pairs(arg_266_1.bgs_) do
					if iter_269_0 ~= "SS2002e" then
						iter_269_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_269_4 = 0
			local var_269_5 = 0.125

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(420121060)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 5 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 5)

				if (5 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 5)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121060", "story_v_out_420121.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121060", "story_v_out_420121.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_420121", "420121060", "story_v_out_420121.awb")

						arg_266_1:RecordAudio("420121060", var_269_11)
						arg_266_1:RecordAudio("420121060", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_420121", "420121060", "story_v_out_420121.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_420121", "420121060", "story_v_out_420121.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play420121061 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 420121061
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play420121062(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(420121061).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)

				if (11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play420121062 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 420121062
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play420121063(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.75

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(420121062).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 30 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 30)

				if (30 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 30)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play420121063 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 420121063
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play420121064(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(420121063).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)

				if (20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play420121064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 420121064
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play420121065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_0 = 1.05

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				local var_285_1 = Color.New(1, 1, 1)

				var_285_1.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.mask_.color = var_285_1
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				local var_285_2 = Color.New(1, 1, 1)

				arg_282_1.mask_.enabled = false
				var_285_2.a = 0
				arg_282_1.mask_.color = var_285_2
			end

			local var_285_3 = "L16b"

			if arg_282_1.bgs_.L16b == nil then
				local var_285_4 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_285_3)
				var_285_4.name = var_285_3
				var_285_4.transform.parent = arg_282_1.stage_.transform
				var_285_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_[var_285_3] = var_285_4
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_5 = arg_282_1.bgs_.L16b

				arg_282_1.bgs_.L16b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_6 = var_285_5:GetComponent("SpriteRenderer")

				if var_285_6 and var_285_6.sprite then
					local var_285_7 = 2 * (var_285_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_5.transform.localScale = Vector3.New(var_285_7 / var_285_6.sprite.bounds.size.y < var_285_7 * manager.ui.mainCameraCom_.aspect / var_285_6.sprite.bounds.size.x and var_285_7 * manager.ui.mainCameraCom_.aspect / var_285_6.sprite.bounds.size.x or var_285_7 / var_285_6.sprite.bounds.size.y, var_285_7 / var_285_6.sprite.bounds.size.y < var_285_7 * manager.ui.mainCameraCom_.aspect / var_285_6.sprite.bounds.size.x and var_285_7 * manager.ui.mainCameraCom_.aspect / var_285_6.sprite.bounds.size.x or var_285_7 / var_285_6.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "L16b" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_8 = 0
			local var_285_9 = 1.125

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_10 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(420121064).content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_12 = 45 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 45)

				if (45 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 45)) > 0 and var_285_9 < var_285_12 then
					arg_282_1.talkMaxDuration = var_285_12

					if var_285_12 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_13 and arg_282_1.time_ < var_285_8 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play420121065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 420121065
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play420121066(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.6

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(420121065).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 24 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 24)

				if (24 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 24)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play420121066 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 420121066
		arg_290_1.duration_ = 1

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"

			SetActive(arg_290_1.choicesGo_, true)

			for iter_291_0, iter_291_1 in ipairs(arg_290_1.choices_) do
				SetActive(iter_291_1.go, iter_291_0 <= 1)
			end

			arg_290_1.choices_[1].txt.text = arg_290_1:FormatText(StoryChoiceCfg[1234].name)
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play420121067(arg_290_1)
			end

			arg_290_1:RecordChoiceLog(420121066, 1234)
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			return
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play420121067 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 420121067
		arg_294_1.duration_ = 45

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
			arg_294_1.auto_ = false
		end

		function arg_294_1.playNext_(arg_296_0)
			arg_294_1.onStoryFinished_()
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				SetActive(arg_294_1.dialog_, false)
				SetActive(arg_294_1.allBtn_.gameObject, false)
				arg_294_1.hideBtnsController_:SetSelectedIndex(1)
				arg_294_1:StopAllVoice()

				arg_294_1.marker = "stop1"

				manager.video:Play("SofdecAsset/story/story_1042012.usm", function(arg_298_0)
					arg_294_1:Skip(arg_298_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_299_0)
					arg_294_1.state_ = arg_299_0 and "pause" or "playing"
				end, 1042012)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_297_0 = 45

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				-- block empty
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.marker = ""
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/L16f",
		"TextureConfig/Background/L01",
		"TextureConfig/Background/L16g",
		"TextureConfig/Background/SS2002",
		"TextureConfig/Background/SS2002a",
		"TextureConfig/Background/SS2002d",
		"TextureConfig/Background/SS2002b",
		"TextureConfig/Background/SS2002e",
		"TextureConfig/Background/L16b",
		"SofdecAsset/story/story_1042012.usm"
	},
	voices = {
		"story_v_out_420121.awb"
	},
	skipMarkers = {
		420121067
	}
}
