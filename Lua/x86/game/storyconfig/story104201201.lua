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
			local var_4_0 = "STwhite"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STwhite

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_17 = arg_1_1:GetWordFromCfg(420121001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.fswt_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_19 = 0.866666666666667

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 19
			local var_4_21 = 1.26666666666667
			local var_4_22 = arg_1_1:GetWordFromCfg(420121001)
			local var_4_23 = arg_1_1:FormatText(var_4_22.content)
			local var_4_24, var_4_25 = arg_1_1:GetPercentByPara(var_4_23, 1)

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_26 = var_4_20 <= 0 and var_4_21 or var_4_21 * ((var_4_25 - arg_1_1.typewritterCharCountI18N) / var_4_20)

				if var_4_26 > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end
				end
			end

			local var_4_27 = 1.26666666666667
			local var_4_28 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_19) / var_4_28

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_24, var_4_29)
				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_28 and arg_1_1.time_ < var_4_19 + var_4_28 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_24

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_25
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_31 = 1.05

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Color.New(0, 0, 0)

				var_4_33.a = Mathf.Lerp(1, 0, var_4_32)
				arg_1_1.mask_.color = var_4_33
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				local var_4_34 = Color.New(0, 0, 0)
				local var_4_35 = 0

				arg_1_1.mask_.enabled = false
				var_4_34.a = var_4_35
				arg_1_1.mask_.color = var_4_34
			end

			local var_4_36 = 0
			local var_4_37 = 0.2

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = 0.333333333333333
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 0.05
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "effect"

				arg_1_1:AudioAction(var_4_50, var_4_51, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_53 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_54 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_55 = var_4_53:GetComponent("Text")
				local var_4_56 = var_4_53:GetComponent("RectTransform")

				var_4_55.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_56.offsetMin = Vector2.New(0, -130)
				var_4_56.offsetMax = Vector2.New(0, 0)
			end

			local var_4_57 = 0
			local var_4_58 = 6.333
			local var_4_59 = manager.audio:GetVoiceLength("story_v_out_420121", "420121001", "story_v_out_420121.awb") / 1000

			if var_4_59 > 0 and var_4_58 < var_4_59 and var_4_59 + var_4_57 > arg_1_1.duration_ then
				local var_4_60 = var_4_59

				arg_1_1.duration_ = var_4_59 + var_4_57
			end

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "voice"

				arg_1_1:AudioAction(var_4_61, var_4_62, "story_v_out_420121", "420121001", "story_v_out_420121.awb")
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
			local var_10_0 = 0

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_1 = 1.33333333333333

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_1 then
				local var_10_2 = (arg_7_1.time_ - var_10_0) / var_10_1
				local var_10_3 = Color.New(0, 0, 0)

				var_10_3.a = Mathf.Lerp(1, 0, var_10_2)
				arg_7_1.mask_.color = var_10_3
			end

			if arg_7_1.time_ >= var_10_0 + var_10_1 and arg_7_1.time_ < var_10_0 + var_10_1 + arg_10_0 then
				local var_10_4 = Color.New(0, 0, 0)
				local var_10_5 = 0

				arg_7_1.mask_.enabled = false
				var_10_4.a = var_10_5
				arg_7_1.mask_.color = var_10_4
			end

			local var_10_6 = "ST0505"

			if arg_7_1.bgs_[var_10_6] == nil then
				local var_10_7 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_6)
				var_10_7.name = var_10_6
				var_10_7.transform.parent = arg_7_1.stage_.transform
				var_10_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_6] = var_10_7
			end

			local var_10_8 = 0

			if var_10_8 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				local var_10_9 = manager.ui.mainCamera.transform.localPosition
				local var_10_10 = Vector3.New(0, 0, 10) + Vector3.New(var_10_9.x, var_10_9.y, 0)
				local var_10_11 = arg_7_1.bgs_.ST0505

				var_10_11.transform.localPosition = var_10_10
				var_10_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_12 = var_10_11:GetComponent("SpriteRenderer")

				if var_10_12 and var_10_12.sprite then
					local var_10_13 = (var_10_11.transform.localPosition - var_10_9).z
					local var_10_14 = manager.ui.mainCameraCom_
					local var_10_15 = 2 * var_10_13 * Mathf.Tan(var_10_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_16 = var_10_15 * var_10_14.aspect
					local var_10_17 = var_10_12.sprite.bounds.size.x
					local var_10_18 = var_10_12.sprite.bounds.size.y
					local var_10_19 = var_10_16 / var_10_17
					local var_10_20 = var_10_15 / var_10_18
					local var_10_21 = var_10_20 < var_10_19 and var_10_19 or var_10_20

					var_10_11.transform.localScale = Vector3.New(var_10_21, var_10_21, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST0505" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_22 = 0

			if var_10_22 < arg_7_1.time_ and arg_7_1.time_ <= var_10_22 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_23 = arg_7_1.actors_["10023"]
			local var_10_24 = 0

			if var_10_24 < arg_7_1.time_ and arg_7_1.time_ <= var_10_24 + arg_10_0 then
				local var_10_25 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_25 then
					var_10_25.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_25.radialBlurScale = 1
					var_10_25.radialBlurGradient = 1
					var_10_25.radialBlurIntensity = 1

					if var_10_23 then
						var_10_25.radialBlurTarget = var_10_23.transform
					end
				end
			end

			local var_10_26 = 1.33333333333333

			if var_10_24 <= arg_7_1.time_ and arg_7_1.time_ < var_10_24 + var_10_26 then
				local var_10_27 = (arg_7_1.time_ - var_10_24) / var_10_26
				local var_10_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_28 then
					var_10_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_28.radialBlurScale = Mathf.Lerp(1, 1, var_10_27)
					var_10_28.radialBlurGradient = Mathf.Lerp(1, 1, var_10_27)
					var_10_28.radialBlurIntensity = Mathf.Lerp(1, 1, var_10_27)
				end
			end

			if arg_7_1.time_ >= var_10_24 + var_10_26 and arg_7_1.time_ < var_10_24 + var_10_26 + arg_10_0 then
				local var_10_29 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_29 then
					var_10_29.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_29.radialBlurScale = 1
					var_10_29.radialBlurGradient = 1
					var_10_29.radialBlurIntensity = 1
				end
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_30 = 1.33333333333333
			local var_10_31 = 1.35

			if var_10_30 < arg_7_1.time_ and arg_7_1.time_ <= var_10_30 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_32 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_32:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_33 = arg_7_1:GetWordFromCfg(420121002)
				local var_10_34 = arg_7_1:FormatText(var_10_33.content)

				arg_7_1.text_.text = var_10_34

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_35 = 57
				local var_10_36 = utf8.len(var_10_34)
				local var_10_37 = var_10_35 <= 0 and var_10_31 or var_10_31 * (var_10_36 / var_10_35)

				if var_10_37 > 0 and var_10_31 < var_10_37 then
					arg_7_1.talkMaxDuration = var_10_37
					var_10_30 = var_10_30 + 0.3

					if var_10_37 + var_10_30 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_37 + var_10_30
					end
				end

				arg_7_1.text_.text = var_10_34
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121002", "story_v_out_420121.awb") ~= 0 then
					local var_10_38 = manager.audio:GetVoiceLength("story_v_out_420121", "420121002", "story_v_out_420121.awb") / 1000

					if var_10_38 + var_10_30 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_38 + var_10_30
					end

					if var_10_33.prefab_name ~= "" and arg_7_1.actors_[var_10_33.prefab_name] ~= nil then
						local var_10_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_33.prefab_name].transform, "story_v_out_420121", "420121002", "story_v_out_420121.awb")

						arg_7_1:RecordAudio("420121002", var_10_39)
						arg_7_1:RecordAudio("420121002", var_10_39)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_420121", "420121002", "story_v_out_420121.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_420121", "420121002", "story_v_out_420121.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_40 = var_10_30 + 0.3
			local var_10_41 = math.max(var_10_31, arg_7_1.talkMaxDuration)

			if var_10_40 <= arg_7_1.time_ and arg_7_1.time_ < var_10_40 + var_10_41 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_40) / var_10_41

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_40 + var_10_41 and arg_7_1.time_ < var_10_40 + var_10_41 + arg_10_0 then
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
			local var_16_0 = "ST0504"

			if arg_13_1.bgs_[var_16_0] == nil then
				local var_16_1 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_16_0)
				var_16_1.name = var_16_0
				var_16_1.transform.parent = arg_13_1.stage_.transform
				var_16_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_[var_16_0] = var_16_1
			end

			local var_16_2 = 1

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				local var_16_3 = manager.ui.mainCamera.transform.localPosition
				local var_16_4 = Vector3.New(0, 0, 10) + Vector3.New(var_16_3.x, var_16_3.y, 0)
				local var_16_5 = arg_13_1.bgs_.ST0504

				var_16_5.transform.localPosition = var_16_4
				var_16_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_6 = var_16_5:GetComponent("SpriteRenderer")

				if var_16_6 and var_16_6.sprite then
					local var_16_7 = (var_16_5.transform.localPosition - var_16_3).z
					local var_16_8 = manager.ui.mainCameraCom_
					local var_16_9 = 2 * var_16_7 * Mathf.Tan(var_16_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_16_10 = var_16_9 * var_16_8.aspect
					local var_16_11 = var_16_6.sprite.bounds.size.x
					local var_16_12 = var_16_6.sprite.bounds.size.y
					local var_16_13 = var_16_10 / var_16_11
					local var_16_14 = var_16_9 / var_16_12
					local var_16_15 = var_16_14 < var_16_13 and var_16_13 or var_16_14

					var_16_5.transform.localScale = Vector3.New(var_16_15, var_16_15, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "ST0504" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_16 = 2

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_17 = 0.333333333333336

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_19 = 1

			if var_16_18 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 then
				local var_16_20 = (arg_13_1.time_ - var_16_18) / var_16_19
				local var_16_21 = Color.New(0, 0, 0)

				var_16_21.a = Mathf.Lerp(0, 1, var_16_20)
				arg_13_1.mask_.color = var_16_21
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 then
				local var_16_22 = Color.New(0, 0, 0)

				var_16_22.a = 1
				arg_13_1.mask_.color = var_16_22
			end

			local var_16_23 = 1

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_24 = 1

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_24 then
				local var_16_25 = (arg_13_1.time_ - var_16_23) / var_16_24
				local var_16_26 = Color.New(0, 0, 0)

				var_16_26.a = Mathf.Lerp(1, 0, var_16_25)
				arg_13_1.mask_.color = var_16_26
			end

			if arg_13_1.time_ >= var_16_23 + var_16_24 and arg_13_1.time_ < var_16_23 + var_16_24 + arg_16_0 then
				local var_16_27 = Color.New(0, 0, 0)
				local var_16_28 = 0

				arg_13_1.mask_.enabled = false
				var_16_27.a = var_16_28
				arg_13_1.mask_.color = var_16_27
			end

			local var_16_29 = 0
			local var_16_30 = 1

			if var_16_29 < arg_13_1.time_ and arg_13_1.time_ <= var_16_29 + arg_16_0 then
				local var_16_31 = "stop"
				local var_16_32 = "effect"

				arg_13_1:AudioAction(var_16_31, var_16_32, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_16_33 = 0.866666666666666
			local var_16_34 = 1

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				local var_16_35 = "play"
				local var_16_36 = "effect"

				arg_13_1:AudioAction(var_16_35, var_16_36, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_37 = 2
			local var_16_38 = 1.35

			if var_16_37 < arg_13_1.time_ and arg_13_1.time_ <= var_16_37 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_39 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_39:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_40 = arg_13_1:GetWordFromCfg(420121003)
				local var_16_41 = arg_13_1:FormatText(var_16_40.content)

				arg_13_1.text_.text = var_16_41

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_42 = 54
				local var_16_43 = utf8.len(var_16_41)
				local var_16_44 = var_16_42 <= 0 and var_16_38 or var_16_38 * (var_16_43 / var_16_42)

				if var_16_44 > 0 and var_16_38 < var_16_44 then
					arg_13_1.talkMaxDuration = var_16_44
					var_16_37 = var_16_37 + 0.3

					if var_16_44 + var_16_37 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_44 + var_16_37
					end
				end

				arg_13_1.text_.text = var_16_41
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121003", "story_v_out_420121.awb") ~= 0 then
					local var_16_45 = manager.audio:GetVoiceLength("story_v_out_420121", "420121003", "story_v_out_420121.awb") / 1000

					if var_16_45 + var_16_37 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_45 + var_16_37
					end

					if var_16_40.prefab_name ~= "" and arg_13_1.actors_[var_16_40.prefab_name] ~= nil then
						local var_16_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_40.prefab_name].transform, "story_v_out_420121", "420121003", "story_v_out_420121.awb")

						arg_13_1:RecordAudio("420121003", var_16_46)
						arg_13_1:RecordAudio("420121003", var_16_46)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420121", "420121003", "story_v_out_420121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420121", "420121003", "story_v_out_420121.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_47 = var_16_37 + 0.3
			local var_16_48 = math.max(var_16_38, arg_13_1.talkMaxDuration)

			if var_16_47 <= arg_13_1.time_ and arg_13_1.time_ < var_16_47 + var_16_48 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_47) / var_16_48

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_47 + var_16_48 and arg_13_1.time_ < var_16_47 + var_16_48 + arg_16_0 then
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
			local var_22_0 = 2.000000000001

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.allBtn_.enabled = false
			end

			local var_22_1 = 0.3

			if arg_19_1.time_ >= var_22_0 + var_22_1 and arg_19_1.time_ < var_22_0 + var_22_1 + arg_22_0 then
				arg_19_1.allBtn_.enabled = true
			end

			local var_22_2 = "L16f"

			if arg_19_1.bgs_[var_22_2] == nil then
				local var_22_3 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_22_2)
				var_22_3.name = var_22_2
				var_22_3.transform.parent = arg_19_1.stage_.transform
				var_22_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_[var_22_2] = var_22_3
			end

			local var_22_4 = 0.999999999998999

			if var_22_4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				local var_22_5 = manager.ui.mainCamera.transform.localPosition
				local var_22_6 = Vector3.New(0, 0, 10) + Vector3.New(var_22_5.x, var_22_5.y, 0)
				local var_22_7 = arg_19_1.bgs_.L16f

				var_22_7.transform.localPosition = var_22_6
				var_22_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_8 = var_22_7:GetComponent("SpriteRenderer")

				if var_22_8 and var_22_8.sprite then
					local var_22_9 = (var_22_7.transform.localPosition - var_22_5).z
					local var_22_10 = manager.ui.mainCameraCom_
					local var_22_11 = 2 * var_22_9 * Mathf.Tan(var_22_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_22_12 = var_22_11 * var_22_10.aspect
					local var_22_13 = var_22_8.sprite.bounds.size.x
					local var_22_14 = var_22_8.sprite.bounds.size.y
					local var_22_15 = var_22_12 / var_22_13
					local var_22_16 = var_22_11 / var_22_14
					local var_22_17 = var_22_16 < var_22_15 and var_22_15 or var_22_16

					var_22_7.transform.localScale = Vector3.New(var_22_17, var_22_17, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "L16f" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_19 = 0.999999999999999

			if var_22_18 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 then
				local var_22_20 = (arg_19_1.time_ - var_22_18) / var_22_19
				local var_22_21 = Color.New(0, 0, 0)

				var_22_21.a = Mathf.Lerp(0, 1, var_22_20)
				arg_19_1.mask_.color = var_22_21
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 then
				local var_22_22 = Color.New(0, 0, 0)

				var_22_22.a = 1
				arg_19_1.mask_.color = var_22_22
			end

			local var_22_23 = 0.999999999999999

			if var_22_23 < arg_19_1.time_ and arg_19_1.time_ <= var_22_23 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_24 = 1.000000000001

			if var_22_23 <= arg_19_1.time_ and arg_19_1.time_ < var_22_23 + var_22_24 then
				local var_22_25 = (arg_19_1.time_ - var_22_23) / var_22_24
				local var_22_26 = Color.New(0, 0, 0)

				var_22_26.a = Mathf.Lerp(1, 0, var_22_25)
				arg_19_1.mask_.color = var_22_26
			end

			if arg_19_1.time_ >= var_22_23 + var_22_24 and arg_19_1.time_ < var_22_23 + var_22_24 + arg_22_0 then
				local var_22_27 = Color.New(0, 0, 0)
				local var_22_28 = 0

				arg_19_1.mask_.enabled = false
				var_22_27.a = var_22_28
				arg_19_1.mask_.color = var_22_27
			end

			local var_22_29 = 0
			local var_22_30 = 1

			if var_22_29 < arg_19_1.time_ and arg_19_1.time_ <= var_22_29 + arg_22_0 then
				local var_22_31 = "stop"
				local var_22_32 = "effect"

				arg_19_1:AudioAction(var_22_31, var_22_32, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_22_33 = 0.899999999999999
			local var_22_34 = 1

			if var_22_33 < arg_19_1.time_ and arg_19_1.time_ <= var_22_33 + arg_22_0 then
				local var_22_35 = "play"
				local var_22_36 = "effect"

				arg_19_1:AudioAction(var_22_35, var_22_36, "se_story_140", "se_story_140_amb_dreamland", "")
			end

			local var_22_37 = arg_19_1.actors_["10024"]
			local var_22_38 = 1

			if var_22_38 < arg_19_1.time_ and arg_19_1.time_ <= var_22_38 + arg_22_0 then
				local var_22_39 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_39 then
					var_22_39.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_39.radialBlurScale = 0.5
					var_22_39.radialBlurGradient = 1
					var_22_39.radialBlurIntensity = 1

					if var_22_37 then
						var_22_39.radialBlurTarget = var_22_37.transform
					end
				end
			end

			local var_22_40 = 1.000000000001

			if var_22_38 <= arg_19_1.time_ and arg_19_1.time_ < var_22_38 + var_22_40 then
				local var_22_41 = (arg_19_1.time_ - var_22_38) / var_22_40
				local var_22_42 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_42 then
					var_22_42.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_42.radialBlurScale = Mathf.Lerp(0.5, 0.5, var_22_41)
					var_22_42.radialBlurGradient = Mathf.Lerp(1, 1, var_22_41)
					var_22_42.radialBlurIntensity = Mathf.Lerp(1, 1, var_22_41)
				end
			end

			if arg_19_1.time_ >= var_22_38 + var_22_40 and arg_19_1.time_ < var_22_38 + var_22_40 + arg_22_0 then
				local var_22_43 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_22_43 then
					var_22_43.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_22_43.radialBlurScale = 0.5
					var_22_43.radialBlurGradient = 1
					var_22_43.radialBlurIntensity = 1
				end
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_44 = 2.000000000001
			local var_22_45 = 0.85

			if var_22_44 < arg_19_1.time_ and arg_19_1.time_ <= var_22_44 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_46 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_46:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_47 = arg_19_1:GetWordFromCfg(420121004)
				local var_22_48 = arg_19_1:FormatText(var_22_47.content)

				arg_19_1.text_.text = var_22_48

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_49 = 34
				local var_22_50 = utf8.len(var_22_48)
				local var_22_51 = var_22_49 <= 0 and var_22_45 or var_22_45 * (var_22_50 / var_22_49)

				if var_22_51 > 0 and var_22_45 < var_22_51 then
					arg_19_1.talkMaxDuration = var_22_51
					var_22_44 = var_22_44 + 0.3

					if var_22_51 + var_22_44 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_51 + var_22_44
					end
				end

				arg_19_1.text_.text = var_22_48
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121004", "story_v_out_420121.awb") ~= 0 then
					local var_22_52 = manager.audio:GetVoiceLength("story_v_out_420121", "420121004", "story_v_out_420121.awb") / 1000

					if var_22_52 + var_22_44 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_52 + var_22_44
					end

					if var_22_47.prefab_name ~= "" and arg_19_1.actors_[var_22_47.prefab_name] ~= nil then
						local var_22_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_47.prefab_name].transform, "story_v_out_420121", "420121004", "story_v_out_420121.awb")

						arg_19_1:RecordAudio("420121004", var_22_53)
						arg_19_1:RecordAudio("420121004", var_22_53)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_420121", "420121004", "story_v_out_420121.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_420121", "420121004", "story_v_out_420121.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_54 = var_22_44 + 0.3
			local var_22_55 = math.max(var_22_45, arg_19_1.talkMaxDuration)

			if var_22_54 <= arg_19_1.time_ and arg_19_1.time_ < var_22_54 + var_22_55 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_54) / var_22_55

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_54 + var_22_55 and arg_19_1.time_ < var_22_54 + var_22_55 + arg_22_0 then
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
			local var_28_0 = 0
			local var_28_1 = 0.6

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(420121005)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 24
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121005", "story_v_out_420121.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_420121", "420121005", "story_v_out_420121.awb") / 1000

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_420121", "420121005", "story_v_out_420121.awb")

						arg_25_1:RecordAudio("420121005", var_28_8)
						arg_25_1:RecordAudio("420121005", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420121", "420121005", "story_v_out_420121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420121", "420121005", "story_v_out_420121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_9 and arg_25_1.time_ < var_28_0 + var_28_9 + arg_28_0 then
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
			local var_32_0 = 2.000000000002

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_1 = 0.499999999999

			if arg_29_1.time_ >= var_32_0 + var_32_1 and arg_29_1.time_ < var_32_0 + var_32_1 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_2 = 0.966666666665666

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ST0505

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST0505" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_17 = 0.966666666666667

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Color.New(0, 0, 0)

				var_32_19.a = Mathf.Lerp(0, 1, var_32_18)
				arg_29_1.mask_.color = var_32_19
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				local var_32_20 = Color.New(0, 0, 0)

				var_32_20.a = 1
				arg_29_1.mask_.color = var_32_20
			end

			local var_32_21 = 0.966666666666666

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_22 = 1.03333333333433

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Color.New(0, 0, 0)

				var_32_24.a = Mathf.Lerp(1, 0, var_32_23)
				arg_29_1.mask_.color = var_32_24
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				local var_32_25 = Color.New(0, 0, 0)
				local var_32_26 = 0

				arg_29_1.mask_.enabled = false
				var_32_25.a = var_32_26
				arg_29_1.mask_.color = var_32_25
			end

			local var_32_27 = 0
			local var_32_28 = 1

			if var_32_27 < arg_29_1.time_ and arg_29_1.time_ <= var_32_27 + arg_32_0 then
				local var_32_29 = "stop"
				local var_32_30 = "effect"

				arg_29_1:AudioAction(var_32_29, var_32_30, "se_story_140", "se_story_140_amb_dreamland", "")
			end

			local var_32_31 = 0.766666666666665
			local var_32_32 = 1

			if var_32_31 < arg_29_1.time_ and arg_29_1.time_ <= var_32_31 + arg_32_0 then
				local var_32_33 = "play"
				local var_32_34 = "effect"

				arg_29_1:AudioAction(var_32_33, var_32_34, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_32_35 = arg_29_1.actors_["10023"]
			local var_32_36 = 0.95

			if var_32_36 < arg_29_1.time_ and arg_29_1.time_ <= var_32_36 + arg_32_0 then
				local var_32_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_37 then
					var_32_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_37.radialBlurScale = 0
					var_32_37.radialBlurGradient = 1
					var_32_37.radialBlurIntensity = 1

					if var_32_35 then
						var_32_37.radialBlurTarget = var_32_35.transform
					end
				end
			end

			local var_32_38 = 0.0166666666666667

			if var_32_36 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_38 then
				local var_32_39 = (arg_29_1.time_ - var_32_36) / var_32_38
				local var_32_40 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_40 then
					var_32_40.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_40.radialBlurScale = Mathf.Lerp(0, 0, var_32_39)
					var_32_40.radialBlurGradient = Mathf.Lerp(1, 1, var_32_39)
					var_32_40.radialBlurIntensity = Mathf.Lerp(1, 1, var_32_39)
				end
			end

			if arg_29_1.time_ >= var_32_36 + var_32_38 and arg_29_1.time_ < var_32_36 + var_32_38 + arg_32_0 then
				local var_32_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_41 then
					var_32_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_41.radialBlurScale = 0
					var_32_41.radialBlurGradient = 1
					var_32_41.radialBlurIntensity = 1
				end
			end

			local var_32_42 = arg_29_1.actors_["10024"]
			local var_32_43 = 0.95

			if var_32_43 < arg_29_1.time_ and arg_29_1.time_ <= var_32_43 + arg_32_0 then
				local var_32_44 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_44 then
					var_32_44.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_44.radialBlurScale = 0
					var_32_44.radialBlurGradient = 1
					var_32_44.radialBlurIntensity = 1

					if var_32_42 then
						var_32_44.radialBlurTarget = var_32_42.transform
					end
				end
			end

			local var_32_45 = 0.0166666666666667

			if var_32_43 <= arg_29_1.time_ and arg_29_1.time_ < var_32_43 + var_32_45 then
				local var_32_46 = (arg_29_1.time_ - var_32_43) / var_32_45
				local var_32_47 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_47 then
					var_32_47.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_47.radialBlurScale = Mathf.Lerp(0, 0, var_32_46)
					var_32_47.radialBlurGradient = Mathf.Lerp(1, 1, var_32_46)
					var_32_47.radialBlurIntensity = Mathf.Lerp(1, 1, var_32_46)
				end
			end

			if arg_29_1.time_ >= var_32_43 + var_32_45 and arg_29_1.time_ < var_32_43 + var_32_45 + arg_32_0 then
				local var_32_48 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_32_48 then
					var_32_48.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_32_48.radialBlurScale = 0
					var_32_48.radialBlurGradient = 1
					var_32_48.radialBlurIntensity = 1
				end
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_49 = 2.000000000001
			local var_32_50 = 0.975

			if var_32_49 < arg_29_1.time_ and arg_29_1.time_ <= var_32_49 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_51 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_51:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_52 = arg_29_1:GetWordFromCfg(420121006)
				local var_32_53 = arg_29_1:FormatText(var_32_52.content)

				arg_29_1.text_.text = var_32_53

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_54 = 39
				local var_32_55 = utf8.len(var_32_53)
				local var_32_56 = var_32_54 <= 0 and var_32_50 or var_32_50 * (var_32_55 / var_32_54)

				if var_32_56 > 0 and var_32_50 < var_32_56 then
					arg_29_1.talkMaxDuration = var_32_56
					var_32_49 = var_32_49 + 0.3

					if var_32_56 + var_32_49 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_56 + var_32_49
					end
				end

				arg_29_1.text_.text = var_32_53
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121006", "story_v_out_420121.awb") ~= 0 then
					local var_32_57 = manager.audio:GetVoiceLength("story_v_out_420121", "420121006", "story_v_out_420121.awb") / 1000

					if var_32_57 + var_32_49 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_57 + var_32_49
					end

					if var_32_52.prefab_name ~= "" and arg_29_1.actors_[var_32_52.prefab_name] ~= nil then
						local var_32_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_52.prefab_name].transform, "story_v_out_420121", "420121006", "story_v_out_420121.awb")

						arg_29_1:RecordAudio("420121006", var_32_58)
						arg_29_1:RecordAudio("420121006", var_32_58)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420121", "420121006", "story_v_out_420121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420121", "420121006", "story_v_out_420121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_59 = var_32_49 + 0.3
			local var_32_60 = math.max(var_32_50, arg_29_1.talkMaxDuration)

			if var_32_59 <= arg_29_1.time_ and arg_29_1.time_ < var_32_59 + var_32_60 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_59) / var_32_60

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_59 + var_32_60 and arg_29_1.time_ < var_32_59 + var_32_60 + arg_32_0 then
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
			local var_38_0 = 0
			local var_38_1 = 0.6

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(420121007)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 24
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121007", "story_v_out_420121.awb") ~= 0 then
					local var_38_7 = manager.audio:GetVoiceLength("story_v_out_420121", "420121007", "story_v_out_420121.awb") / 1000

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end

					if var_38_2.prefab_name ~= "" and arg_35_1.actors_[var_38_2.prefab_name] ~= nil then
						local var_38_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_2.prefab_name].transform, "story_v_out_420121", "420121007", "story_v_out_420121.awb")

						arg_35_1:RecordAudio("420121007", var_38_8)
						arg_35_1:RecordAudio("420121007", var_38_8)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_420121", "420121007", "story_v_out_420121.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_420121", "420121007", "story_v_out_420121.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_9 and arg_35_1.time_ < var_38_0 + var_38_9 + arg_38_0 then
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
			local var_42_0 = 4

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			local var_42_1 = 0.3

			if arg_39_1.time_ >= var_42_0 + var_42_1 and arg_39_1.time_ < var_42_0 + var_42_1 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_2 = "L01"

			if arg_39_1.bgs_[var_42_2] == nil then
				local var_42_3 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_2)
				var_42_3.name = var_42_2
				var_42_3.transform.parent = arg_39_1.stage_.transform
				var_42_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_2] = var_42_3
			end

			local var_42_4 = 2

			if var_42_4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				local var_42_5 = manager.ui.mainCamera.transform.localPosition
				local var_42_6 = Vector3.New(0, 0, 10) + Vector3.New(var_42_5.x, var_42_5.y, 0)
				local var_42_7 = arg_39_1.bgs_.L01

				var_42_7.transform.localPosition = var_42_6
				var_42_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_8 = var_42_7:GetComponent("SpriteRenderer")

				if var_42_8 and var_42_8.sprite then
					local var_42_9 = (var_42_7.transform.localPosition - var_42_5).z
					local var_42_10 = manager.ui.mainCameraCom_
					local var_42_11 = 2 * var_42_9 * Mathf.Tan(var_42_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_12 = var_42_11 * var_42_10.aspect
					local var_42_13 = var_42_8.sprite.bounds.size.x
					local var_42_14 = var_42_8.sprite.bounds.size.y
					local var_42_15 = var_42_12 / var_42_13
					local var_42_16 = var_42_11 / var_42_14
					local var_42_17 = var_42_16 < var_42_15 and var_42_15 or var_42_16

					var_42_7.transform.localScale = Vector3.New(var_42_17, var_42_17, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "L01" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_18 = 0

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_19 = 2

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_19 then
				local var_42_20 = (arg_39_1.time_ - var_42_18) / var_42_19
				local var_42_21 = Color.New(0, 0, 0)

				var_42_21.a = Mathf.Lerp(0, 1, var_42_20)
				arg_39_1.mask_.color = var_42_21
			end

			if arg_39_1.time_ >= var_42_18 + var_42_19 and arg_39_1.time_ < var_42_18 + var_42_19 + arg_42_0 then
				local var_42_22 = Color.New(0, 0, 0)

				var_42_22.a = 1
				arg_39_1.mask_.color = var_42_22
			end

			local var_42_23 = 2

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_24 = 2

			if var_42_23 <= arg_39_1.time_ and arg_39_1.time_ < var_42_23 + var_42_24 then
				local var_42_25 = (arg_39_1.time_ - var_42_23) / var_42_24
				local var_42_26 = Color.New(0, 0, 0)

				var_42_26.a = Mathf.Lerp(1, 0, var_42_25)
				arg_39_1.mask_.color = var_42_26
			end

			if arg_39_1.time_ >= var_42_23 + var_42_24 and arg_39_1.time_ < var_42_23 + var_42_24 + arg_42_0 then
				local var_42_27 = Color.New(0, 0, 0)
				local var_42_28 = 0

				arg_39_1.mask_.enabled = false
				var_42_27.a = var_42_28
				arg_39_1.mask_.color = var_42_27
			end

			local var_42_29 = 1.05
			local var_42_30 = 1

			if var_42_29 < arg_39_1.time_ and arg_39_1.time_ <= var_42_29 + arg_42_0 then
				local var_42_31 = "stop"
				local var_42_32 = "effect"

				arg_39_1:AudioAction(var_42_31, var_42_32, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_33 = 4
			local var_42_34 = 0.85

			if var_42_33 < arg_39_1.time_ and arg_39_1.time_ <= var_42_33 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_35 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_35:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_36 = arg_39_1:GetWordFromCfg(420121008)
				local var_42_37 = arg_39_1:FormatText(var_42_36.content)

				arg_39_1.text_.text = var_42_37

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_38 = 34
				local var_42_39 = utf8.len(var_42_37)
				local var_42_40 = var_42_38 <= 0 and var_42_34 or var_42_34 * (var_42_39 / var_42_38)

				if var_42_40 > 0 and var_42_34 < var_42_40 then
					arg_39_1.talkMaxDuration = var_42_40
					var_42_33 = var_42_33 + 0.3

					if var_42_40 + var_42_33 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_40 + var_42_33
					end
				end

				arg_39_1.text_.text = var_42_37
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_41 = var_42_33 + 0.3
			local var_42_42 = math.max(var_42_34, arg_39_1.talkMaxDuration)

			if var_42_41 <= arg_39_1.time_ and arg_39_1.time_ < var_42_41 + var_42_42 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_41) / var_42_42

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_41 + var_42_42 and arg_39_1.time_ < var_42_41 + var_42_42 + arg_42_0 then
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
			local var_48_0 = 0.833333333333333
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_140", "se_story_140_bird", "")
			end

			local var_48_4 = 0
			local var_48_5 = 1

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				local var_48_6 = "play"
				local var_48_7 = "effect"

				arg_45_1:AudioAction(var_48_6, var_48_7, "se_story_140", "se_story_140_car03", "")
			end

			local var_48_8 = 0
			local var_48_9 = 0.9

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(420121009)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 36
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_9 or var_48_9 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_9 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_15 and arg_45_1.time_ < var_48_8 + var_48_15 + arg_48_0 then
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
			local var_52_0 = "1085ui_story"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_49_1.stage_.transform)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentInChildren(typeof(CharacterEffect))

					var_52_3.enabled = true

					local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_2, typeof(DynamicBoneHelper))

					if var_52_4 then
						var_52_4:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_3.transform, false)

					arg_49_1.var_[var_52_0 .. "Animator"] = var_52_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_0 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_0 .. "LipSync"] = var_52_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_5 = arg_49_1.actors_["1085ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos1085ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(0, -1.01, -5.83)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1085ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = arg_49_1.actors_["1085ui_story"]
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_16 = 0.200000002980232

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 and not isNil(var_52_14) then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16

				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_14) then
					arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1085ui_story then
				arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_52_18 = 0

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_52_19 = 0

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_20 = 0
			local var_52_21 = 0.65

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_22 = arg_49_1:FormatText(StoryNameCfg[328].name)

				arg_49_1.leftNameTxt_.text = var_52_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_23 = arg_49_1:GetWordFromCfg(420121010)
				local var_52_24 = arg_49_1:FormatText(var_52_23.content)

				arg_49_1.text_.text = var_52_24

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_25 = 26
				local var_52_26 = utf8.len(var_52_24)
				local var_52_27 = var_52_25 <= 0 and var_52_21 or var_52_21 * (var_52_26 / var_52_25)

				if var_52_27 > 0 and var_52_21 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27

					if var_52_27 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_20
					end
				end

				arg_49_1.text_.text = var_52_24
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121010", "story_v_out_420121.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_420121", "420121010", "story_v_out_420121.awb") / 1000

					if var_52_28 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_20
					end

					if var_52_23.prefab_name ~= "" and arg_49_1.actors_[var_52_23.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_23.prefab_name].transform, "story_v_out_420121", "420121010", "story_v_out_420121.awb")

						arg_49_1:RecordAudio("420121010", var_52_29)
						arg_49_1:RecordAudio("420121010", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_420121", "420121010", "story_v_out_420121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_420121", "420121010", "story_v_out_420121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = math.max(var_52_21, arg_49_1.talkMaxDuration)

			if var_52_20 <= arg_49_1.time_ and arg_49_1.time_ < var_52_20 + var_52_30 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_20) / var_52_30

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_20 + var_52_30 and arg_49_1.time_ < var_52_20 + var_52_30 + arg_52_0 then
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
			local var_56_0 = 0
			local var_56_1 = 0.675

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[328].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(420121011)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 27
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121011", "story_v_out_420121.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121011", "story_v_out_420121.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_420121", "420121011", "story_v_out_420121.awb")

						arg_53_1:RecordAudio("420121011", var_56_9)
						arg_53_1:RecordAudio("420121011", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420121", "420121011", "story_v_out_420121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420121", "420121011", "story_v_out_420121.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
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
			local var_60_0 = arg_57_1.actors_["1085ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1085ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1085ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = 0
			local var_60_10 = 0.85

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(420121012)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 34
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_10 or var_60_10 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_10 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_16 and arg_57_1.time_ < var_60_9 + var_60_16 + arg_60_0 then
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
			local var_64_0 = 0
			local var_64_1 = 0.75

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(420121013)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 30
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
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
			local var_68_0 = arg_65_1.actors_["1085ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -1.01, -5.83)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1085ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1085ui_story == nil then
				arg_65_1.var_.characterEffect1085ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1085ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1085ui_story then
				arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_68_14 = 0
			local var_68_15 = 0.375

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_16 = arg_65_1:FormatText(StoryNameCfg[328].name)

				arg_65_1.leftNameTxt_.text = var_68_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_17 = arg_65_1:GetWordFromCfg(420121014)
				local var_68_18 = arg_65_1:FormatText(var_68_17.content)

				arg_65_1.text_.text = var_68_18

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_19 = 15
				local var_68_20 = utf8.len(var_68_18)
				local var_68_21 = var_68_19 <= 0 and var_68_15 or var_68_15 * (var_68_20 / var_68_19)

				if var_68_21 > 0 and var_68_15 < var_68_21 then
					arg_65_1.talkMaxDuration = var_68_21

					if var_68_21 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_14
					end
				end

				arg_65_1.text_.text = var_68_18
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121014", "story_v_out_420121.awb") ~= 0 then
					local var_68_22 = manager.audio:GetVoiceLength("story_v_out_420121", "420121014", "story_v_out_420121.awb") / 1000

					if var_68_22 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_14
					end

					if var_68_17.prefab_name ~= "" and arg_65_1.actors_[var_68_17.prefab_name] ~= nil then
						local var_68_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_17.prefab_name].transform, "story_v_out_420121", "420121014", "story_v_out_420121.awb")

						arg_65_1:RecordAudio("420121014", var_68_23)
						arg_65_1:RecordAudio("420121014", var_68_23)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_420121", "420121014", "story_v_out_420121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_420121", "420121014", "story_v_out_420121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_15, arg_65_1.talkMaxDuration)

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_14) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_14 + var_68_24 and arg_65_1.time_ < var_68_14 + var_68_24 + arg_68_0 then
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
			local var_72_0 = arg_69_1.actors_["1085ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1085ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1085ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0
			local var_72_10 = 0.8

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:GetWordFromCfg(420121015)
				local var_72_12 = arg_69_1:FormatText(var_72_11.content)

				arg_69_1.text_.text = var_72_12

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 32
				local var_72_14 = utf8.len(var_72_12)
				local var_72_15 = var_72_13 <= 0 and var_72_10 or var_72_10 * (var_72_14 / var_72_13)

				if var_72_15 > 0 and var_72_10 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_12
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_16 and arg_69_1.time_ < var_72_9 + var_72_16 + arg_72_0 then
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
			local var_76_0 = manager.ui.mainCamera.transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = var_76_0.localPosition
			end

			local var_76_2 = 0.333333333333333

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / 0.066
				local var_76_4, var_76_5 = math.modf(var_76_3)

				var_76_0.localPosition = Vector3.New(var_76_5 * 0.13, var_76_5 * 0.13, var_76_5 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = arg_73_1.var_.shakeOldPos
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_7 = 0.383333333332

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_8 = 0.333333333333333
			local var_76_9 = 0.05

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_10 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_10:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_11 = arg_73_1:FormatText(StoryNameCfg[668].name)

				arg_73_1.leftNameTxt_.text = var_76_11

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

				local var_76_12 = arg_73_1:GetWordFromCfg(420121016)
				local var_76_13 = arg_73_1:FormatText(var_76_12.content)

				arg_73_1.text_.text = var_76_13

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_14 = 2
				local var_76_15 = utf8.len(var_76_13)
				local var_76_16 = var_76_14 <= 0 and var_76_9 or var_76_9 * (var_76_15 / var_76_14)

				if var_76_16 > 0 and var_76_9 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16
					var_76_8 = var_76_8 + 0.3

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_13
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121016", "story_v_out_420121.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_420121", "420121016", "story_v_out_420121.awb") / 1000

					if var_76_17 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_8
					end

					if var_76_12.prefab_name ~= "" and arg_73_1.actors_[var_76_12.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_12.prefab_name].transform, "story_v_out_420121", "420121016", "story_v_out_420121.awb")

						arg_73_1:RecordAudio("420121016", var_76_18)
						arg_73_1:RecordAudio("420121016", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_420121", "420121016", "story_v_out_420121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_420121", "420121016", "story_v_out_420121.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = var_76_8 + 0.3
			local var_76_20 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_19 <= arg_73_1.time_ and arg_73_1.time_ < var_76_19 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_19) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_19 + var_76_20 and arg_73_1.time_ < var_76_19 + var_76_20 + arg_76_0 then
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
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				local var_82_1 = manager.ui.mainCamera.transform.localPosition
				local var_82_2 = Vector3.New(0, 0, 10) + Vector3.New(var_82_1.x, var_82_1.y, 0)
				local var_82_3 = arg_79_1.bgs_.STwhite

				var_82_3.transform.localPosition = var_82_2
				var_82_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_4 = var_82_3:GetComponent("SpriteRenderer")

				if var_82_4 and var_82_4.sprite then
					local var_82_5 = (var_82_3.transform.localPosition - var_82_1).z
					local var_82_6 = manager.ui.mainCameraCom_
					local var_82_7 = 2 * var_82_5 * Mathf.Tan(var_82_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_8 = var_82_7 * var_82_6.aspect
					local var_82_9 = var_82_4.sprite.bounds.size.x
					local var_82_10 = var_82_4.sprite.bounds.size.y
					local var_82_11 = var_82_8 / var_82_9
					local var_82_12 = var_82_7 / var_82_10
					local var_82_13 = var_82_12 < var_82_11 and var_82_11 or var_82_12

					var_82_3.transform.localScale = Vector3.New(var_82_13, var_82_13, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "STwhite" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_14 = 2

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_15 = 0.3

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_17 = 2

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17
				local var_82_19 = Color.New(0, 0, 0)

				var_82_19.a = Mathf.Lerp(1, 0, var_82_18)
				arg_79_1.mask_.color = var_82_19
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				local var_82_20 = Color.New(0, 0, 0)
				local var_82_21 = 0

				arg_79_1.mask_.enabled = false
				var_82_20.a = var_82_21
				arg_79_1.mask_.color = var_82_20
			end

			local var_82_22 = 0

			if var_82_22 < arg_79_1.time_ and arg_79_1.time_ <= var_82_22 + arg_82_0 then
				arg_79_1.cswbg_:SetActive(true)

				local var_82_23 = arg_79_1.cswt_:GetComponent("RectTransform")

				arg_79_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_82_23.offsetMin = Vector2.New(0, 0)
				var_82_23.offsetMax = Vector2.New(0, 130)

				local var_82_24 = arg_79_1:GetWordFromCfg(419148)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.cswt_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.cswt_)

				arg_79_1.cswt_.fontSize = 120
				arg_79_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_79_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_79_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_82_26 = 0

			if var_82_26 < arg_79_1.time_ and arg_79_1.time_ <= var_82_26 + arg_82_0 then
				local var_82_27 = arg_79_1.fswbg_.transform:Find("textbox/adapt/content") or arg_79_1.fswbg_.transform:Find("textbox/content")
				local var_82_28 = arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_82_29 = var_82_27:GetComponent("Text")
				local var_82_30 = var_82_27:GetComponent("RectTransform")

				var_82_29.alignment = UnityEngine.TextAnchor.LowerCenter
				var_82_30.offsetMin = Vector2.New(0, -70)
				var_82_30.offsetMax = Vector2.New(0, 0)
			end

			local var_82_31 = 0

			if var_82_31 < arg_79_1.time_ and arg_79_1.time_ <= var_82_31 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(true)
				arg_79_1.dialog_:SetActive(false)

				arg_79_1.fswtw_.percent = 0

				local var_82_32 = arg_79_1:GetWordFromCfg(420121017)
				local var_82_33 = arg_79_1:FormatText(var_82_32.content)

				arg_79_1.fswt_.text = var_82_33

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.fswt_)

				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_79_1.fswtw_:SetDirty()

				arg_79_1.typewritterCharCountI18N = 0

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_34 = 2

			if var_82_34 < arg_79_1.time_ and arg_79_1.time_ <= var_82_34 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_35 = 28
			local var_82_36 = 1.86666666666667
			local var_82_37 = arg_79_1:GetWordFromCfg(420121017)
			local var_82_38 = arg_79_1:FormatText(var_82_37.content)
			local var_82_39, var_82_40 = arg_79_1:GetPercentByPara(var_82_38, 1)

			if var_82_34 < arg_79_1.time_ and arg_79_1.time_ <= var_82_34 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_41 = var_82_35 <= 0 and var_82_36 or var_82_36 * ((var_82_40 - arg_79_1.typewritterCharCountI18N) / var_82_35)

				if var_82_41 > 0 and var_82_36 < var_82_41 then
					arg_79_1.talkMaxDuration = var_82_41

					if var_82_41 + var_82_34 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_41 + var_82_34
					end
				end
			end

			local var_82_42 = 1.86666666666667
			local var_82_43 = math.max(var_82_42, arg_79_1.talkMaxDuration)

			if var_82_34 <= arg_79_1.time_ and arg_79_1.time_ < var_82_34 + var_82_43 then
				local var_82_44 = (arg_79_1.time_ - var_82_34) / var_82_43

				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_39, var_82_44)
				arg_79_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= var_82_34 + var_82_43 and arg_79_1.time_ < var_82_34 + var_82_43 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_39

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_40
			end

			local var_82_45 = 2
			local var_82_46 = 1

			if var_82_45 < arg_79_1.time_ and arg_79_1.time_ <= var_82_45 + arg_82_0 then
				local var_82_47 = "play"
				local var_82_48 = "effect"

				arg_79_1:AudioAction(var_82_47, var_82_48, "se_story_140", "se_story_140_car_brake", "")
			end

			local var_82_49 = 3.4
			local var_82_50 = 1

			if var_82_49 < arg_79_1.time_ and arg_79_1.time_ <= var_82_49 + arg_82_0 then
				local var_82_51 = "play"
				local var_82_52 = "effect"

				arg_79_1:AudioAction(var_82_51, var_82_52, "se_story_140", "se_story_140_foley_hold", "")
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
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.fswbg_:SetActive(true)
				arg_83_1.dialog_:SetActive(false)

				arg_83_1.fswtw_.percent = 0

				local var_86_1 = arg_83_1:GetWordFromCfg(420121018)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.fswt_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.fswt_)

				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_83_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_83_1.fswtw_:SetDirty()

				arg_83_1.typewritterCharCountI18N = 0

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_3 = 0.0166666666666667

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.var_.oldValueTypewriter = arg_83_1.fswtw_.percent

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_4 = 7
			local var_86_5 = 0.466666666666667
			local var_86_6 = arg_83_1:GetWordFromCfg(420121018)
			local var_86_7 = arg_83_1:FormatText(var_86_6.content)
			local var_86_8, var_86_9 = arg_83_1:GetPercentByPara(var_86_7, 1)

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				local var_86_10 = var_86_4 <= 0 and var_86_5 or var_86_5 * ((var_86_9 - arg_83_1.typewritterCharCountI18N) / var_86_4)

				if var_86_10 > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_3
					end
				end
			end

			local var_86_11 = 0.466666666666667
			local var_86_12 = math.max(var_86_11, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_3) / var_86_12

				arg_83_1.fswtw_.percent = Mathf.Lerp(arg_83_1.var_.oldValueTypewriter, var_86_8, var_86_13)
				arg_83_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_83_1.fswtw_:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_12 and arg_83_1.time_ < var_86_3 + var_86_12 + arg_86_0 then
				arg_83_1.fswtw_.percent = var_86_8

				arg_83_1.fswtw_:SetDirty()
				arg_83_1:ShowNextGo(true)

				arg_83_1.typewritterCharCountI18N = var_86_9
			end

			local var_86_14 = 0.0166666666666667
			local var_86_15 = 2.866
			local var_86_16 = manager.audio:GetVoiceLength("story_v_out_420121", "420121018", "story_v_out_420121.awb") / 1000

			if var_86_16 > 0 and var_86_15 < var_86_16 and var_86_16 + var_86_14 > arg_83_1.duration_ then
				local var_86_17 = var_86_16

				arg_83_1.duration_ = var_86_16 + var_86_14
			end

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				local var_86_18 = "play"
				local var_86_19 = "voice"

				arg_83_1:AudioAction(var_86_18, var_86_19, "story_v_out_420121", "420121018", "story_v_out_420121.awb")
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
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.fswbg_:SetActive(true)
				arg_87_1.dialog_:SetActive(false)

				arg_87_1.fswtw_.percent = 0

				local var_90_1 = arg_87_1:GetWordFromCfg(420121019)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.fswt_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.fswt_)

				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_87_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_87_1.fswtw_:SetDirty()

				arg_87_1.typewritterCharCountI18N = 0

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_3 = 0.0166666666666667

			if var_90_3 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.var_.oldValueTypewriter = arg_87_1.fswtw_.percent

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_4 = 17
			local var_90_5 = 1.13333333333333
			local var_90_6 = arg_87_1:GetWordFromCfg(420121019)
			local var_90_7 = arg_87_1:FormatText(var_90_6.content)
			local var_90_8, var_90_9 = arg_87_1:GetPercentByPara(var_90_7, 1)

			if var_90_3 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				local var_90_10 = var_90_4 <= 0 and var_90_5 or var_90_5 * ((var_90_9 - arg_87_1.typewritterCharCountI18N) / var_90_4)

				if var_90_10 > 0 and var_90_5 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_3
					end
				end
			end

			local var_90_11 = 1.13333333333333
			local var_90_12 = math.max(var_90_11, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_12 then
				local var_90_13 = (arg_87_1.time_ - var_90_3) / var_90_12

				arg_87_1.fswtw_.percent = Mathf.Lerp(arg_87_1.var_.oldValueTypewriter, var_90_8, var_90_13)
				arg_87_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_87_1.fswtw_:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_12 and arg_87_1.time_ < var_90_3 + var_90_12 + arg_90_0 then
				arg_87_1.fswtw_.percent = var_90_8

				arg_87_1.fswtw_:SetDirty()
				arg_87_1:ShowNextGo(true)

				arg_87_1.typewritterCharCountI18N = var_90_9
			end

			local var_90_14 = 0.0166666666666667
			local var_90_15 = 5.6
			local var_90_16 = manager.audio:GetVoiceLength("story_v_out_420121", "420121019", "story_v_out_420121.awb") / 1000

			if var_90_16 > 0 and var_90_15 < var_90_16 and var_90_16 + var_90_14 > arg_87_1.duration_ then
				local var_90_17 = var_90_16

				arg_87_1.duration_ = var_90_16 + var_90_14
			end

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				local var_90_18 = "play"
				local var_90_19 = "voice"

				arg_87_1:AudioAction(var_90_18, var_90_19, "story_v_out_420121", "420121019", "story_v_out_420121.awb")
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
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_1 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_1.offsetMin = Vector2.New(0, 0)
				var_94_1.offsetMax = Vector2.New(0, 130)

				local var_94_2 = arg_91_1:GetWordFromCfg(419143)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.cswt_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.cswt_)

				arg_91_1.cswt_.fontSize = 120
				arg_91_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_91_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_91_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0

				local var_94_5 = arg_91_1:GetWordFromCfg(420121020)
				local var_94_6 = arg_91_1:FormatText(var_94_5.content)

				arg_91_1.fswt_.text = var_94_6

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_7 = 0.0166666666666667

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_8 = 7
			local var_94_9 = 0.466666666666667
			local var_94_10 = arg_91_1:GetWordFromCfg(420121020)
			local var_94_11 = arg_91_1:FormatText(var_94_10.content)
			local var_94_12, var_94_13 = arg_91_1:GetPercentByPara(var_94_11, 1)

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_14 = var_94_8 <= 0 and var_94_9 or var_94_9 * ((var_94_13 - arg_91_1.typewritterCharCountI18N) / var_94_8)

				if var_94_14 > 0 and var_94_9 < var_94_14 then
					arg_91_1.talkMaxDuration = var_94_14

					if var_94_14 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_7
					end
				end
			end

			local var_94_15 = 0.466666666666667
			local var_94_16 = math.max(var_94_15, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_16 then
				local var_94_17 = (arg_91_1.time_ - var_94_7) / var_94_16

				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_12, var_94_17)
				arg_91_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_16 and arg_91_1.time_ < var_94_7 + var_94_16 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_12

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_13
			end

			local var_94_18 = 0.0166666666666667
			local var_94_19 = 3.633
			local var_94_20 = manager.audio:GetVoiceLength("story_v_out_420121", "420121020", "story_v_out_420121.awb") / 1000

			if var_94_20 > 0 and var_94_19 < var_94_20 and var_94_20 + var_94_18 > arg_91_1.duration_ then
				local var_94_21 = var_94_20

				arg_91_1.duration_ = var_94_20 + var_94_18
			end

			if var_94_18 < arg_91_1.time_ and arg_91_1.time_ <= var_94_18 + arg_94_0 then
				local var_94_22 = "play"
				local var_94_23 = "voice"

				arg_91_1:AudioAction(var_94_22, var_94_23, "story_v_out_420121", "420121020", "story_v_out_420121.awb")
			end

			local var_94_24 = 0

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_25 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_25.offsetMin = Vector2.New(0, 0)
				var_94_25.offsetMax = Vector2.New(0, 130)

				local var_94_26 = arg_91_1:GetWordFromCfg(419143)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.cswt_.text = var_94_27

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
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0

				local var_98_1 = arg_95_1:GetWordFromCfg(420121021)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.fswt_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_3 = 0.0166666666666667

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_4 = 13
			local var_98_5 = 0.866666666666667
			local var_98_6 = arg_95_1:GetWordFromCfg(420121021)
			local var_98_7 = arg_95_1:FormatText(var_98_6.content)
			local var_98_8, var_98_9 = arg_95_1:GetPercentByPara(var_98_7, 1)

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_10 = var_98_4 <= 0 and var_98_5 or var_98_5 * ((var_98_9 - arg_95_1.typewritterCharCountI18N) / var_98_4)

				if var_98_10 > 0 and var_98_5 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_3
					end
				end
			end

			local var_98_11 = 0.866666666666667
			local var_98_12 = math.max(var_98_11, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_12 then
				local var_98_13 = (arg_95_1.time_ - var_98_3) / var_98_12

				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_8, var_98_13)
				arg_95_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_12 and arg_95_1.time_ < var_98_3 + var_98_12 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_8

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_9
			end

			local var_98_14 = 0.0166666666666667
			local var_98_15 = 4.633
			local var_98_16 = manager.audio:GetVoiceLength("story_v_out_420121", "420121021", "story_v_out_420121.awb") / 1000

			if var_98_16 > 0 and var_98_15 < var_98_16 and var_98_16 + var_98_14 > arg_95_1.duration_ then
				local var_98_17 = var_98_16

				arg_95_1.duration_ = var_98_16 + var_98_14
			end

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				local var_98_18 = "play"
				local var_98_19 = "voice"

				arg_95_1:AudioAction(var_98_18, var_98_19, "story_v_out_420121", "420121021", "story_v_out_420121.awb")
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
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				local var_102_1 = manager.ui.mainCamera.transform.localPosition
				local var_102_2 = Vector3.New(0, 0, 10) + Vector3.New(var_102_1.x, var_102_1.y, 0)
				local var_102_3 = arg_99_1.bgs_.L01

				var_102_3.transform.localPosition = var_102_2
				var_102_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_4 = var_102_3:GetComponent("SpriteRenderer")

				if var_102_4 and var_102_4.sprite then
					local var_102_5 = (var_102_3.transform.localPosition - var_102_1).z
					local var_102_6 = manager.ui.mainCameraCom_
					local var_102_7 = 2 * var_102_5 * Mathf.Tan(var_102_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_8 = var_102_7 * var_102_6.aspect
					local var_102_9 = var_102_4.sprite.bounds.size.x
					local var_102_10 = var_102_4.sprite.bounds.size.y
					local var_102_11 = var_102_8 / var_102_9
					local var_102_12 = var_102_7 / var_102_10
					local var_102_13 = var_102_12 < var_102_11 and var_102_11 or var_102_12

					var_102_3.transform.localScale = Vector3.New(var_102_13, var_102_13, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "L01" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_15 = 2

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_15 then
				local var_102_16 = (arg_99_1.time_ - var_102_14) / var_102_15
				local var_102_17 = Color.New(1, 1, 1)

				var_102_17.a = Mathf.Lerp(1, 0, var_102_16)
				arg_99_1.mask_.color = var_102_17
			end

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 then
				local var_102_18 = Color.New(1, 1, 1)
				local var_102_19 = 0

				arg_99_1.mask_.enabled = false
				var_102_18.a = var_102_19
				arg_99_1.mask_.color = var_102_18
			end

			local var_102_20 = 0

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(false)
				arg_99_1.dialog_:SetActive(false)
				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_21 = 0

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.cswbg_:SetActive(false)
			end

			local var_102_22 = arg_99_1.actors_["1085ui_story"].transform
			local var_102_23 = 1.9

			if var_102_23 < arg_99_1.time_ and arg_99_1.time_ <= var_102_23 + arg_102_0 then
				arg_99_1.var_.moveOldPos1085ui_story = var_102_22.localPosition
			end

			local var_102_24 = 0.001

			if var_102_23 <= arg_99_1.time_ and arg_99_1.time_ < var_102_23 + var_102_24 then
				local var_102_25 = (arg_99_1.time_ - var_102_23) / var_102_24
				local var_102_26 = Vector3.New(0, -1.01, -5.83)

				var_102_22.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1085ui_story, var_102_26, var_102_25)

				local var_102_27 = manager.ui.mainCamera.transform.position - var_102_22.position

				var_102_22.forward = Vector3.New(var_102_27.x, var_102_27.y, var_102_27.z)

				local var_102_28 = var_102_22.localEulerAngles

				var_102_28.z = 0
				var_102_28.x = 0
				var_102_22.localEulerAngles = var_102_28
			end

			if arg_99_1.time_ >= var_102_23 + var_102_24 and arg_99_1.time_ < var_102_23 + var_102_24 + arg_102_0 then
				var_102_22.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_102_29 = manager.ui.mainCamera.transform.position - var_102_22.position

				var_102_22.forward = Vector3.New(var_102_29.x, var_102_29.y, var_102_29.z)

				local var_102_30 = var_102_22.localEulerAngles

				var_102_30.z = 0
				var_102_30.x = 0
				var_102_22.localEulerAngles = var_102_30
			end

			local var_102_31 = arg_99_1.actors_["1085ui_story"]
			local var_102_32 = 1.9

			if var_102_32 < arg_99_1.time_ and arg_99_1.time_ <= var_102_32 + arg_102_0 and not isNil(var_102_31) and arg_99_1.var_.characterEffect1085ui_story == nil then
				arg_99_1.var_.characterEffect1085ui_story = var_102_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_33 = 0.200000002980232

			if var_102_32 <= arg_99_1.time_ and arg_99_1.time_ < var_102_32 + var_102_33 and not isNil(var_102_31) then
				local var_102_34 = (arg_99_1.time_ - var_102_32) / var_102_33

				if arg_99_1.var_.characterEffect1085ui_story and not isNil(var_102_31) then
					arg_99_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_32 + var_102_33 and arg_99_1.time_ < var_102_32 + var_102_33 + arg_102_0 and not isNil(var_102_31) and arg_99_1.var_.characterEffect1085ui_story then
				arg_99_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_102_35 = 1.9

			if var_102_35 < arg_99_1.time_ and arg_99_1.time_ <= var_102_35 + arg_102_0 then
				arg_99_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_102_36 = 1.9

			if var_102_36 < arg_99_1.time_ and arg_99_1.time_ <= var_102_36 + arg_102_0 then
				arg_99_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_37 = 2
			local var_102_38 = 0.55

			if var_102_37 < arg_99_1.time_ and arg_99_1.time_ <= var_102_37 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_39 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_39:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_40 = arg_99_1:FormatText(StoryNameCfg[328].name)

				arg_99_1.leftNameTxt_.text = var_102_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_41 = arg_99_1:GetWordFromCfg(420121022)
				local var_102_42 = arg_99_1:FormatText(var_102_41.content)

				arg_99_1.text_.text = var_102_42

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_43 = 22
				local var_102_44 = utf8.len(var_102_42)
				local var_102_45 = var_102_43 <= 0 and var_102_38 or var_102_38 * (var_102_44 / var_102_43)

				if var_102_45 > 0 and var_102_38 < var_102_45 then
					arg_99_1.talkMaxDuration = var_102_45
					var_102_37 = var_102_37 + 0.3

					if var_102_45 + var_102_37 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_45 + var_102_37
					end
				end

				arg_99_1.text_.text = var_102_42
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121022", "story_v_out_420121.awb") ~= 0 then
					local var_102_46 = manager.audio:GetVoiceLength("story_v_out_420121", "420121022", "story_v_out_420121.awb") / 1000

					if var_102_46 + var_102_37 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_46 + var_102_37
					end

					if var_102_41.prefab_name ~= "" and arg_99_1.actors_[var_102_41.prefab_name] ~= nil then
						local var_102_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_41.prefab_name].transform, "story_v_out_420121", "420121022", "story_v_out_420121.awb")

						arg_99_1:RecordAudio("420121022", var_102_47)
						arg_99_1:RecordAudio("420121022", var_102_47)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_420121", "420121022", "story_v_out_420121.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_420121", "420121022", "story_v_out_420121.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_48 = var_102_37 + 0.3
			local var_102_49 = math.max(var_102_38, arg_99_1.talkMaxDuration)

			if var_102_48 <= arg_99_1.time_ and arg_99_1.time_ < var_102_48 + var_102_49 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_48) / var_102_49

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_48 + var_102_49 and arg_99_1.time_ < var_102_48 + var_102_49 + arg_102_0 then
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
			local var_108_0 = arg_105_1.actors_["1085ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1085ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1085ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = 0
			local var_108_10 = 0.45

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_11 = arg_105_1:GetWordFromCfg(420121023)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 18
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_10 or var_108_10 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_10 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_9 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_9
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_10, arg_105_1.talkMaxDuration)

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_9) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_9 + var_108_16 and arg_105_1.time_ < var_108_9 + var_108_16 + arg_108_0 then
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
			local var_112_0 = "404001ui_story"

			if arg_109_1.actors_[var_112_0] == nil then
				local var_112_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_112_1) then
					local var_112_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_109_1.stage_.transform)

					var_112_2.name = var_112_0
					var_112_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_0] = var_112_2

					local var_112_3 = var_112_2:GetComponentInChildren(typeof(CharacterEffect))

					var_112_3.enabled = true

					local var_112_4 = GameObjectTools.GetOrAddComponent(var_112_2, typeof(DynamicBoneHelper))

					if var_112_4 then
						var_112_4:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_3.transform, false)

					arg_109_1.var_[var_112_0 .. "Animator"] = var_112_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_0 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_0 .. "LipSync"] = var_112_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_5 = arg_109_1.actors_["404001ui_story"].transform
			local var_112_6 = 0

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.var_.moveOldPos404001ui_story = var_112_5.localPosition
			end

			local var_112_7 = 0.001

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_7 then
				local var_112_8 = (arg_109_1.time_ - var_112_6) / var_112_7
				local var_112_9 = Vector3.New(0, -1.55, -5.5)

				var_112_5.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos404001ui_story, var_112_9, var_112_8)

				local var_112_10 = manager.ui.mainCamera.transform.position - var_112_5.position

				var_112_5.forward = Vector3.New(var_112_10.x, var_112_10.y, var_112_10.z)

				local var_112_11 = var_112_5.localEulerAngles

				var_112_11.z = 0
				var_112_11.x = 0
				var_112_5.localEulerAngles = var_112_11
			end

			if arg_109_1.time_ >= var_112_6 + var_112_7 and arg_109_1.time_ < var_112_6 + var_112_7 + arg_112_0 then
				var_112_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_112_12 = manager.ui.mainCamera.transform.position - var_112_5.position

				var_112_5.forward = Vector3.New(var_112_12.x, var_112_12.y, var_112_12.z)

				local var_112_13 = var_112_5.localEulerAngles

				var_112_13.z = 0
				var_112_13.x = 0
				var_112_5.localEulerAngles = var_112_13
			end

			local var_112_14 = arg_109_1.actors_["404001ui_story"]
			local var_112_15 = 0

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect404001ui_story == nil then
				arg_109_1.var_.characterEffect404001ui_story = var_112_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_16 = 0.200000002980232

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_16 and not isNil(var_112_14) then
				local var_112_17 = (arg_109_1.time_ - var_112_15) / var_112_16

				if arg_109_1.var_.characterEffect404001ui_story and not isNil(var_112_14) then
					arg_109_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_15 + var_112_16 and arg_109_1.time_ < var_112_15 + var_112_16 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect404001ui_story then
				arg_109_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_112_18 = 0

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_112_19 = 0

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_20 = 0
			local var_112_21 = 0.4

			if var_112_20 < arg_109_1.time_ and arg_109_1.time_ <= var_112_20 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_22 = arg_109_1:FormatText(StoryNameCfg[668].name)

				arg_109_1.leftNameTxt_.text = var_112_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_23 = arg_109_1:GetWordFromCfg(420121024)
				local var_112_24 = arg_109_1:FormatText(var_112_23.content)

				arg_109_1.text_.text = var_112_24

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_25 = 16
				local var_112_26 = utf8.len(var_112_24)
				local var_112_27 = var_112_25 <= 0 and var_112_21 or var_112_21 * (var_112_26 / var_112_25)

				if var_112_27 > 0 and var_112_21 < var_112_27 then
					arg_109_1.talkMaxDuration = var_112_27

					if var_112_27 + var_112_20 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_27 + var_112_20
					end
				end

				arg_109_1.text_.text = var_112_24
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121024", "story_v_out_420121.awb") ~= 0 then
					local var_112_28 = manager.audio:GetVoiceLength("story_v_out_420121", "420121024", "story_v_out_420121.awb") / 1000

					if var_112_28 + var_112_20 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_20
					end

					if var_112_23.prefab_name ~= "" and arg_109_1.actors_[var_112_23.prefab_name] ~= nil then
						local var_112_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_23.prefab_name].transform, "story_v_out_420121", "420121024", "story_v_out_420121.awb")

						arg_109_1:RecordAudio("420121024", var_112_29)
						arg_109_1:RecordAudio("420121024", var_112_29)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_420121", "420121024", "story_v_out_420121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_420121", "420121024", "story_v_out_420121.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_30 = math.max(var_112_21, arg_109_1.talkMaxDuration)

			if var_112_20 <= arg_109_1.time_ and arg_109_1.time_ < var_112_20 + var_112_30 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_20) / var_112_30

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_20 + var_112_30 and arg_109_1.time_ < var_112_20 + var_112_30 + arg_112_0 then
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
			local var_116_0 = arg_113_1.actors_["404001ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos404001ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos404001ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1085ui_story"].transform
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.var_.moveOldPos1085ui_story = var_116_9.localPosition
			end

			local var_116_11 = 0.001

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11
				local var_116_13 = Vector3.New(0.75, -1.01, -5.83)

				var_116_9.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1085ui_story, var_116_13, var_116_12)

				local var_116_14 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_14.x, var_116_14.y, var_116_14.z)

				local var_116_15 = var_116_9.localEulerAngles

				var_116_15.z = 0
				var_116_15.x = 0
				var_116_9.localEulerAngles = var_116_15
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 then
				var_116_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_9.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_9.localEulerAngles = var_116_17
			end

			local var_116_18 = arg_113_1.actors_["1085ui_story"]
			local var_116_19 = 0

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect1085ui_story == nil then
				arg_113_1.var_.characterEffect1085ui_story = var_116_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_20 = 0.200000002980232

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_20 and not isNil(var_116_18) then
				local var_116_21 = (arg_113_1.time_ - var_116_19) / var_116_20

				if arg_113_1.var_.characterEffect1085ui_story and not isNil(var_116_18) then
					arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_19 + var_116_20 and arg_113_1.time_ < var_116_19 + var_116_20 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect1085ui_story then
				arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_116_22 = arg_113_1.actors_["404001ui_story"]
			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect404001ui_story == nil then
				arg_113_1.var_.characterEffect404001ui_story = var_116_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_24 = 0.200000002980232

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 and not isNil(var_116_22) then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / var_116_24

				if arg_113_1.var_.characterEffect404001ui_story and not isNil(var_116_22) then
					local var_116_26 = Mathf.Lerp(0, 0.5, var_116_25)

					arg_113_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_113_1.var_.characterEffect404001ui_story.fillRatio = var_116_26
				end
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect404001ui_story then
				local var_116_27 = 0.5

				arg_113_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_113_1.var_.characterEffect404001ui_story.fillRatio = var_116_27
			end

			local var_116_28 = 0
			local var_116_29 = 0.35

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_30 = arg_113_1:FormatText(StoryNameCfg[328].name)

				arg_113_1.leftNameTxt_.text = var_116_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_31 = arg_113_1:GetWordFromCfg(420121025)
				local var_116_32 = arg_113_1:FormatText(var_116_31.content)

				arg_113_1.text_.text = var_116_32

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_33 = 14
				local var_116_34 = utf8.len(var_116_32)
				local var_116_35 = var_116_33 <= 0 and var_116_29 or var_116_29 * (var_116_34 / var_116_33)

				if var_116_35 > 0 and var_116_29 < var_116_35 then
					arg_113_1.talkMaxDuration = var_116_35

					if var_116_35 + var_116_28 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_35 + var_116_28
					end
				end

				arg_113_1.text_.text = var_116_32
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121025", "story_v_out_420121.awb") ~= 0 then
					local var_116_36 = manager.audio:GetVoiceLength("story_v_out_420121", "420121025", "story_v_out_420121.awb") / 1000

					if var_116_36 + var_116_28 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_36 + var_116_28
					end

					if var_116_31.prefab_name ~= "" and arg_113_1.actors_[var_116_31.prefab_name] ~= nil then
						local var_116_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_31.prefab_name].transform, "story_v_out_420121", "420121025", "story_v_out_420121.awb")

						arg_113_1:RecordAudio("420121025", var_116_37)
						arg_113_1:RecordAudio("420121025", var_116_37)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_420121", "420121025", "story_v_out_420121.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_420121", "420121025", "story_v_out_420121.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_38 = math.max(var_116_29, arg_113_1.talkMaxDuration)

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_38 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_28) / var_116_38

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_28 + var_116_38 and arg_113_1.time_ < var_116_28 + var_116_38 + arg_116_0 then
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
			local var_120_0 = arg_117_1.actors_["404001ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect404001ui_story == nil then
				arg_117_1.var_.characterEffect404001ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect404001ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect404001ui_story then
				arg_117_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["1085ui_story"]
			local var_120_5 = 0

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1085ui_story == nil then
				arg_117_1.var_.characterEffect1085ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 and not isNil(var_120_4) then
				local var_120_7 = (arg_117_1.time_ - var_120_5) / var_120_6

				if arg_117_1.var_.characterEffect1085ui_story and not isNil(var_120_4) then
					local var_120_8 = Mathf.Lerp(0, 0.5, var_120_7)

					arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1085ui_story.fillRatio = var_120_8
				end
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1085ui_story then
				local var_120_9 = 0.5

				arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1085ui_story.fillRatio = var_120_9
			end

			local var_120_10 = 0
			local var_120_11 = 0.9

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_12 = arg_117_1:FormatText(StoryNameCfg[668].name)

				arg_117_1.leftNameTxt_.text = var_120_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:GetWordFromCfg(420121026)
				local var_120_14 = arg_117_1:FormatText(var_120_13.content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_15 = 36
				local var_120_16 = utf8.len(var_120_14)
				local var_120_17 = var_120_15 <= 0 and var_120_11 or var_120_11 * (var_120_16 / var_120_15)

				if var_120_17 > 0 and var_120_11 < var_120_17 then
					arg_117_1.talkMaxDuration = var_120_17

					if var_120_17 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_10
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121026", "story_v_out_420121.awb") ~= 0 then
					local var_120_18 = manager.audio:GetVoiceLength("story_v_out_420121", "420121026", "story_v_out_420121.awb") / 1000

					if var_120_18 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_10
					end

					if var_120_13.prefab_name ~= "" and arg_117_1.actors_[var_120_13.prefab_name] ~= nil then
						local var_120_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_13.prefab_name].transform, "story_v_out_420121", "420121026", "story_v_out_420121.awb")

						arg_117_1:RecordAudio("420121026", var_120_19)
						arg_117_1:RecordAudio("420121026", var_120_19)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_420121", "420121026", "story_v_out_420121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_420121", "420121026", "story_v_out_420121.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_20 = math.max(var_120_11, arg_117_1.talkMaxDuration)

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_10) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_10 + var_120_20 and arg_117_1.time_ < var_120_10 + var_120_20 + arg_120_0 then
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
			local var_124_0 = arg_121_1.actors_["404001ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos404001ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos404001ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1085ui_story"].transform
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.var_.moveOldPos1085ui_story = var_124_9.localPosition
			end

			local var_124_11 = 0.001

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11
				local var_124_13 = Vector3.New(0, 100, 0)

				var_124_9.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1085ui_story, var_124_13, var_124_12)

				local var_124_14 = manager.ui.mainCamera.transform.position - var_124_9.position

				var_124_9.forward = Vector3.New(var_124_14.x, var_124_14.y, var_124_14.z)

				local var_124_15 = var_124_9.localEulerAngles

				var_124_15.z = 0
				var_124_15.x = 0
				var_124_9.localEulerAngles = var_124_15
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 then
				var_124_9.localPosition = Vector3.New(0, 100, 0)

				local var_124_16 = manager.ui.mainCamera.transform.position - var_124_9.position

				var_124_9.forward = Vector3.New(var_124_16.x, var_124_16.y, var_124_16.z)

				local var_124_17 = var_124_9.localEulerAngles

				var_124_17.z = 0
				var_124_17.x = 0
				var_124_9.localEulerAngles = var_124_17
			end

			local var_124_18 = 0.200000002980232
			local var_124_19 = 1

			if var_124_18 < arg_121_1.time_ and arg_121_1.time_ <= var_124_18 + arg_124_0 then
				local var_124_20 = "play"
				local var_124_21 = "effect"

				arg_121_1:AudioAction(var_124_20, var_124_21, "se_story_140", "se_story_140_car03", "")
			end

			local var_124_22 = 0
			local var_124_23 = 0.725

			if var_124_22 < arg_121_1.time_ and arg_121_1.time_ <= var_124_22 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(420121027)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 29
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_23 or var_124_23 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_23 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_22 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_22
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_29 = math.max(var_124_23, arg_121_1.talkMaxDuration)

			if var_124_22 <= arg_121_1.time_ and arg_121_1.time_ < var_124_22 + var_124_29 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_22) / var_124_29

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_22 + var_124_29 and arg_121_1.time_ < var_124_22 + var_124_29 + arg_124_0 then
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
			local var_128_0 = arg_125_1.actors_["404001ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos404001ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -1.55, -5.5)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos404001ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["404001ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect404001ui_story == nil then
				arg_125_1.var_.characterEffect404001ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect404001ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect404001ui_story then
				arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_16 = 1

			if arg_125_1.time_ >= var_128_15 + var_128_16 and arg_125_1.time_ < var_128_15 + var_128_16 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_17 = 0
			local var_128_18 = 0.275

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_19 = arg_125_1:FormatText(StoryNameCfg[668].name)

				arg_125_1.leftNameTxt_.text = var_128_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_20 = arg_125_1:GetWordFromCfg(420121028)
				local var_128_21 = arg_125_1:FormatText(var_128_20.content)

				arg_125_1.text_.text = var_128_21

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_22 = 11
				local var_128_23 = utf8.len(var_128_21)
				local var_128_24 = var_128_22 <= 0 and var_128_18 or var_128_18 * (var_128_23 / var_128_22)

				if var_128_24 > 0 and var_128_18 < var_128_24 then
					arg_125_1.talkMaxDuration = var_128_24

					if var_128_24 + var_128_17 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_17
					end
				end

				arg_125_1.text_.text = var_128_21
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121028", "story_v_out_420121.awb") ~= 0 then
					local var_128_25 = manager.audio:GetVoiceLength("story_v_out_420121", "420121028", "story_v_out_420121.awb") / 1000

					if var_128_25 + var_128_17 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_25 + var_128_17
					end

					if var_128_20.prefab_name ~= "" and arg_125_1.actors_[var_128_20.prefab_name] ~= nil then
						local var_128_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_20.prefab_name].transform, "story_v_out_420121", "420121028", "story_v_out_420121.awb")

						arg_125_1:RecordAudio("420121028", var_128_26)
						arg_125_1:RecordAudio("420121028", var_128_26)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_420121", "420121028", "story_v_out_420121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_420121", "420121028", "story_v_out_420121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_27 = math.max(var_128_18, arg_125_1.talkMaxDuration)

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_27 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_17) / var_128_27

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_17 + var_128_27 and arg_125_1.time_ < var_128_17 + var_128_27 + arg_128_0 then
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
			local var_132_0 = 4

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_1 = 0.3

			if arg_129_1.time_ >= var_132_0 + var_132_1 and arg_129_1.time_ < var_132_0 + var_132_1 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_2 = "L16g"

			if arg_129_1.bgs_[var_132_2] == nil then
				local var_132_3 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_2)
				var_132_3.name = var_132_2
				var_132_3.transform.parent = arg_129_1.stage_.transform
				var_132_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_2] = var_132_3
			end

			local var_132_4 = 2

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				local var_132_5 = manager.ui.mainCamera.transform.localPosition
				local var_132_6 = Vector3.New(0, 0, 10) + Vector3.New(var_132_5.x, var_132_5.y, 0)
				local var_132_7 = arg_129_1.bgs_.L16g

				var_132_7.transform.localPosition = var_132_6
				var_132_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_8 = var_132_7:GetComponent("SpriteRenderer")

				if var_132_8 and var_132_8.sprite then
					local var_132_9 = (var_132_7.transform.localPosition - var_132_5).z
					local var_132_10 = manager.ui.mainCameraCom_
					local var_132_11 = 2 * var_132_9 * Mathf.Tan(var_132_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_132_12 = var_132_11 * var_132_10.aspect
					local var_132_13 = var_132_8.sprite.bounds.size.x
					local var_132_14 = var_132_8.sprite.bounds.size.y
					local var_132_15 = var_132_12 / var_132_13
					local var_132_16 = var_132_11 / var_132_14
					local var_132_17 = var_132_16 < var_132_15 and var_132_15 or var_132_16

					var_132_7.transform.localScale = Vector3.New(var_132_17, var_132_17, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "L16g" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_18 = 0

			if var_132_18 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_19 = 2

			if var_132_18 <= arg_129_1.time_ and arg_129_1.time_ < var_132_18 + var_132_19 then
				local var_132_20 = (arg_129_1.time_ - var_132_18) / var_132_19
				local var_132_21 = Color.New(0, 0, 0)

				var_132_21.a = Mathf.Lerp(0, 1, var_132_20)
				arg_129_1.mask_.color = var_132_21
			end

			if arg_129_1.time_ >= var_132_18 + var_132_19 and arg_129_1.time_ < var_132_18 + var_132_19 + arg_132_0 then
				local var_132_22 = Color.New(0, 0, 0)

				var_132_22.a = 1
				arg_129_1.mask_.color = var_132_22
			end

			local var_132_23 = 2

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_24 = 2

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_24 then
				local var_132_25 = (arg_129_1.time_ - var_132_23) / var_132_24
				local var_132_26 = Color.New(0, 0, 0)

				var_132_26.a = Mathf.Lerp(1, 0, var_132_25)
				arg_129_1.mask_.color = var_132_26
			end

			if arg_129_1.time_ >= var_132_23 + var_132_24 and arg_129_1.time_ < var_132_23 + var_132_24 + arg_132_0 then
				local var_132_27 = Color.New(0, 0, 0)
				local var_132_28 = 0

				arg_129_1.mask_.enabled = false
				var_132_27.a = var_132_28
				arg_129_1.mask_.color = var_132_27
			end

			local var_132_29 = arg_129_1.actors_["404001ui_story"].transform
			local var_132_30 = 2

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.var_.moveOldPos404001ui_story = var_132_29.localPosition
			end

			local var_132_31 = 0.001

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_31 then
				local var_132_32 = (arg_129_1.time_ - var_132_30) / var_132_31
				local var_132_33 = Vector3.New(0, 100, 0)

				var_132_29.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos404001ui_story, var_132_33, var_132_32)

				local var_132_34 = manager.ui.mainCamera.transform.position - var_132_29.position

				var_132_29.forward = Vector3.New(var_132_34.x, var_132_34.y, var_132_34.z)

				local var_132_35 = var_132_29.localEulerAngles

				var_132_35.z = 0
				var_132_35.x = 0
				var_132_29.localEulerAngles = var_132_35
			end

			if arg_129_1.time_ >= var_132_30 + var_132_31 and arg_129_1.time_ < var_132_30 + var_132_31 + arg_132_0 then
				var_132_29.localPosition = Vector3.New(0, 100, 0)

				local var_132_36 = manager.ui.mainCamera.transform.position - var_132_29.position

				var_132_29.forward = Vector3.New(var_132_36.x, var_132_36.y, var_132_36.z)

				local var_132_37 = var_132_29.localEulerAngles

				var_132_37.z = 0
				var_132_37.x = 0
				var_132_29.localEulerAngles = var_132_37
			end

			local var_132_38 = 0.466666666666667
			local var_132_39 = 0.2

			if var_132_38 < arg_129_1.time_ and arg_129_1.time_ <= var_132_38 + arg_132_0 then
				local var_132_40 = "play"
				local var_132_41 = "music"

				arg_129_1:AudioAction(var_132_40, var_132_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_132_42 = ""
				local var_132_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_132_43 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_43 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_43

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_43
						arg_129_1.bgmTxt2_.text = var_132_43
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

			local var_132_44 = 1.76666666666667
			local var_132_45 = 1

			if var_132_44 < arg_129_1.time_ and arg_129_1.time_ <= var_132_44 + arg_132_0 then
				local var_132_46 = "play"
				local var_132_47 = "effect"

				arg_129_1:AudioAction(var_132_46, var_132_47, "se_story_140", "se_story_140_amb_dreamland", "")
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_48 = 4
			local var_132_49 = 0.65

			if var_132_48 < arg_129_1.time_ and arg_129_1.time_ <= var_132_48 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_50 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_50:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_129_1.dialogCg_.alpha = arg_134_0
				end))
				var_132_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_51 = arg_129_1:GetWordFromCfg(420121029)
				local var_132_52 = arg_129_1:FormatText(var_132_51.content)

				arg_129_1.text_.text = var_132_52

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_53 = 26
				local var_132_54 = utf8.len(var_132_52)
				local var_132_55 = var_132_53 <= 0 and var_132_49 or var_132_49 * (var_132_54 / var_132_53)

				if var_132_55 > 0 and var_132_49 < var_132_55 then
					arg_129_1.talkMaxDuration = var_132_55
					var_132_48 = var_132_48 + 0.3

					if var_132_55 + var_132_48 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_55 + var_132_48
					end
				end

				arg_129_1.text_.text = var_132_52
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121029", "story_v_out_420121.awb") ~= 0 then
					local var_132_56 = manager.audio:GetVoiceLength("story_v_out_420121", "420121029", "story_v_out_420121.awb") / 1000

					if var_132_56 + var_132_48 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_56 + var_132_48
					end

					if var_132_51.prefab_name ~= "" and arg_129_1.actors_[var_132_51.prefab_name] ~= nil then
						local var_132_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_51.prefab_name].transform, "story_v_out_420121", "420121029", "story_v_out_420121.awb")

						arg_129_1:RecordAudio("420121029", var_132_57)
						arg_129_1:RecordAudio("420121029", var_132_57)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_420121", "420121029", "story_v_out_420121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_420121", "420121029", "story_v_out_420121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_58 = var_132_48 + 0.3
			local var_132_59 = math.max(var_132_49, arg_129_1.talkMaxDuration)

			if var_132_58 <= arg_129_1.time_ and arg_129_1.time_ < var_132_58 + var_132_59 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_58) / var_132_59

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_58 + var_132_59 and arg_129_1.time_ < var_132_58 + var_132_59 + arg_132_0 then
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
			local var_139_0 = 0
			local var_139_1 = 0.925

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(420121030)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 37
				local var_139_5 = utf8.len(var_139_3)
				local var_139_6 = var_139_4 <= 0 and var_139_1 or var_139_1 * (var_139_5 / var_139_4)

				if var_139_6 > 0 and var_139_1 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121030", "story_v_out_420121.awb") ~= 0 then
					local var_139_7 = manager.audio:GetVoiceLength("story_v_out_420121", "420121030", "story_v_out_420121.awb") / 1000

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end

					if var_139_2.prefab_name ~= "" and arg_136_1.actors_[var_139_2.prefab_name] ~= nil then
						local var_139_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_2.prefab_name].transform, "story_v_out_420121", "420121030", "story_v_out_420121.awb")

						arg_136_1:RecordAudio("420121030", var_139_8)
						arg_136_1:RecordAudio("420121030", var_139_8)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_420121", "420121030", "story_v_out_420121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_420121", "420121030", "story_v_out_420121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_9 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_9 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_9

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_9 and arg_136_1.time_ < var_139_0 + var_139_9 + arg_139_0 then
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
			local var_143_0 = 0
			local var_143_1 = 0.2

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				local var_143_2 = "play"
				local var_143_3 = "music"

				arg_140_1:AudioAction(var_143_2, var_143_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_143_4 = ""
				local var_143_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_143_5 ~= "" then
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

			local var_143_6 = 0.333333333333333
			local var_143_7 = 1

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				local var_143_8 = "play"
				local var_143_9 = "music"

				arg_140_1:AudioAction(var_143_8, var_143_9, "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_143_10 = ""
				local var_143_11 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if var_143_11 ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_11 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_11

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_11
						arg_140_1.bgmTxt2_.text = var_143_11
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

			local var_143_12 = 0
			local var_143_13 = 0.125

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_14

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

				local var_143_15 = arg_140_1:GetWordFromCfg(420121031)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 5
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_20 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_20

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_20 and arg_140_1.time_ < var_143_12 + var_143_20 + arg_143_0 then
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
			local var_149_0 = arg_146_1.actors_["1085ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1085ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, -1.01, -5.83)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1085ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1085ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1085ui_story == nil then
				arg_146_1.var_.characterEffect1085ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect1085ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1085ui_story then
				arg_146_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_149_15 = 0
			local var_149_16 = 0.65

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[328].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(420121032)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 26
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121032", "story_v_out_420121.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_out_420121", "420121032", "story_v_out_420121.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_out_420121", "420121032", "story_v_out_420121.awb")

						arg_146_1:RecordAudio("420121032", var_149_24)
						arg_146_1:RecordAudio("420121032", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_420121", "420121032", "story_v_out_420121.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_420121", "420121032", "story_v_out_420121.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_25 and arg_146_1.time_ < var_149_15 + var_149_25 + arg_149_0 then
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
			local var_153_0 = arg_150_1.actors_["1085ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1085ui_story == nil then
				arg_150_1.var_.characterEffect1085ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1085ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1085ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1085ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1085ui_story.fillRatio = var_153_5
			end

			local var_153_6 = 0
			local var_153_7 = 0.35

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_8 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_8

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

				local var_153_9 = arg_150_1:GetWordFromCfg(420121033)
				local var_153_10 = arg_150_1:FormatText(var_153_9.content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 14
				local var_153_12 = utf8.len(var_153_10)
				local var_153_13 = var_153_11 <= 0 and var_153_7 or var_153_7 * (var_153_12 / var_153_11)

				if var_153_13 > 0 and var_153_7 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_10
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_14 and arg_150_1.time_ < var_153_6 + var_153_14 + arg_153_0 then
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
			local var_157_0 = arg_154_1.actors_["1085ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1085ui_story == nil then
				arg_154_1.var_.characterEffect1085ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1085ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1085ui_story then
				arg_154_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_157_4 = 0

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_157_6 = 0

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_7 = 0.633333333333333

			if arg_154_1.time_ >= var_157_6 + var_157_7 and arg_154_1.time_ < var_157_6 + var_157_7 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_8 = 0
			local var_157_9 = 0.125

			if var_157_8 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_10 = arg_154_1:FormatText(StoryNameCfg[328].name)

				arg_154_1.leftNameTxt_.text = var_157_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_11 = arg_154_1:GetWordFromCfg(420121034)
				local var_157_12 = arg_154_1:FormatText(var_157_11.content)

				arg_154_1.text_.text = var_157_12

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_13 = 5
				local var_157_14 = utf8.len(var_157_12)
				local var_157_15 = var_157_13 <= 0 and var_157_9 or var_157_9 * (var_157_14 / var_157_13)

				if var_157_15 > 0 and var_157_9 < var_157_15 then
					arg_154_1.talkMaxDuration = var_157_15

					if var_157_15 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_8
					end
				end

				arg_154_1.text_.text = var_157_12
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121034", "story_v_out_420121.awb") ~= 0 then
					local var_157_16 = manager.audio:GetVoiceLength("story_v_out_420121", "420121034", "story_v_out_420121.awb") / 1000

					if var_157_16 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_16 + var_157_8
					end

					if var_157_11.prefab_name ~= "" and arg_154_1.actors_[var_157_11.prefab_name] ~= nil then
						local var_157_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_11.prefab_name].transform, "story_v_out_420121", "420121034", "story_v_out_420121.awb")

						arg_154_1:RecordAudio("420121034", var_157_17)
						arg_154_1:RecordAudio("420121034", var_157_17)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_420121", "420121034", "story_v_out_420121.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_420121", "420121034", "story_v_out_420121.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = math.max(var_157_9, arg_154_1.talkMaxDuration)

			if var_157_8 <= arg_154_1.time_ and arg_154_1.time_ < var_157_8 + var_157_18 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_8) / var_157_18

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_8 + var_157_18 and arg_154_1.time_ < var_157_8 + var_157_18 + arg_157_0 then
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
			local var_161_0 = arg_158_1.actors_["1085ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1085ui_story == nil then
				arg_158_1.var_.characterEffect1085ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1085ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1085ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1085ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1085ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.675

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

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

				local var_161_9 = arg_158_1:GetWordFromCfg(420121035)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 27
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
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
			local var_165_0 = arg_162_1.actors_["1085ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1085ui_story == nil then
				arg_162_1.var_.characterEffect1085ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1085ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1085ui_story then
				arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_165_6 = 0
			local var_165_7 = 0.6

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[328].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_9 = arg_162_1:GetWordFromCfg(420121036)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 24
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121036", "story_v_out_420121.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_420121", "420121036", "story_v_out_420121.awb") / 1000

					if var_165_14 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_6
					end

					if var_165_9.prefab_name ~= "" and arg_162_1.actors_[var_165_9.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_9.prefab_name].transform, "story_v_out_420121", "420121036", "story_v_out_420121.awb")

						arg_162_1:RecordAudio("420121036", var_165_15)
						arg_162_1:RecordAudio("420121036", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_420121", "420121036", "story_v_out_420121.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_420121", "420121036", "story_v_out_420121.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_16 and arg_162_1.time_ < var_165_6 + var_165_16 + arg_165_0 then
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
			local var_169_0 = arg_166_1.actors_["1085ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1085ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1085ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = 0
			local var_169_10 = 0.575

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_11 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_11

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

				local var_169_12 = arg_166_1:GetWordFromCfg(420121037)
				local var_169_13 = arg_166_1:FormatText(var_169_12.content)

				arg_166_1.text_.text = var_169_13

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_14 = 23
				local var_169_15 = utf8.len(var_169_13)
				local var_169_16 = var_169_14 <= 0 and var_169_10 or var_169_10 * (var_169_15 / var_169_14)

				if var_169_16 > 0 and var_169_10 < var_169_16 then
					arg_166_1.talkMaxDuration = var_169_16

					if var_169_16 + var_169_9 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_16 + var_169_9
					end
				end

				arg_166_1.text_.text = var_169_13
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_17 = math.max(var_169_10, arg_166_1.talkMaxDuration)

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_17 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_9) / var_169_17

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_9 + var_169_17 and arg_166_1.time_ < var_169_9 + var_169_17 + arg_169_0 then
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
			local var_173_0 = 0
			local var_173_1 = 0.8

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_2

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

				local var_173_3 = arg_170_1:GetWordFromCfg(420121038)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 32
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
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
			local var_177_0 = 0
			local var_177_1 = 0.875

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_2

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

				local var_177_3 = arg_174_1:GetWordFromCfg(420121039)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 35
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_8 and arg_174_1.time_ < var_177_0 + var_177_8 + arg_177_0 then
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
			local var_181_0 = 0
			local var_181_1 = 0.725

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

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

				local var_181_3 = arg_178_1:GetWordFromCfg(420121040)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 29
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
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
			local var_185_0 = 0
			local var_185_1 = 1.15

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_2 = arg_182_1:GetWordFromCfg(420121041)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 46
				local var_185_5 = utf8.len(var_185_3)
				local var_185_6 = var_185_4 <= 0 and var_185_1 or var_185_1 * (var_185_5 / var_185_4)

				if var_185_6 > 0 and var_185_1 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_7 and arg_182_1.time_ < var_185_0 + var_185_7 + arg_185_0 then
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
			local var_189_0 = 0
			local var_189_1 = 1.2

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(420121042)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 48
				local var_189_5 = utf8.len(var_189_3)
				local var_189_6 = var_189_4 <= 0 and var_189_1 or var_189_1 * (var_189_5 / var_189_4)

				if var_189_6 > 0 and var_189_1 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_7 and arg_186_1.time_ < var_189_0 + var_189_7 + arg_189_0 then
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
			local var_193_0 = arg_190_1.actors_["1085ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1085ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0, -1.01, -5.83)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1085ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["1085ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1085ui_story == nil then
				arg_190_1.var_.characterEffect1085ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.200000002980232

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect1085ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1085ui_story then
				arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_193_14 = 0
			local var_193_15 = 0.4

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_16 = arg_190_1:FormatText(StoryNameCfg[328].name)

				arg_190_1.leftNameTxt_.text = var_193_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_17 = arg_190_1:GetWordFromCfg(420121043)
				local var_193_18 = arg_190_1:FormatText(var_193_17.content)

				arg_190_1.text_.text = var_193_18

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_19 = 16
				local var_193_20 = utf8.len(var_193_18)
				local var_193_21 = var_193_19 <= 0 and var_193_15 or var_193_15 * (var_193_20 / var_193_19)

				if var_193_21 > 0 and var_193_15 < var_193_21 then
					arg_190_1.talkMaxDuration = var_193_21

					if var_193_21 + var_193_14 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_21 + var_193_14
					end
				end

				arg_190_1.text_.text = var_193_18
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121043", "story_v_out_420121.awb") ~= 0 then
					local var_193_22 = manager.audio:GetVoiceLength("story_v_out_420121", "420121043", "story_v_out_420121.awb") / 1000

					if var_193_22 + var_193_14 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_14
					end

					if var_193_17.prefab_name ~= "" and arg_190_1.actors_[var_193_17.prefab_name] ~= nil then
						local var_193_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_17.prefab_name].transform, "story_v_out_420121", "420121043", "story_v_out_420121.awb")

						arg_190_1:RecordAudio("420121043", var_193_23)
						arg_190_1:RecordAudio("420121043", var_193_23)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_420121", "420121043", "story_v_out_420121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_420121", "420121043", "story_v_out_420121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_24 = math.max(var_193_15, arg_190_1.talkMaxDuration)

			if var_193_14 <= arg_190_1.time_ and arg_190_1.time_ < var_193_14 + var_193_24 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_14) / var_193_24

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_14 + var_193_24 and arg_190_1.time_ < var_193_14 + var_193_24 + arg_193_0 then
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
			local var_197_0 = arg_194_1.actors_["1085ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1085ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, 100, 0)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1085ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, 100, 0)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = 0
			local var_197_10 = 0.775

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_11 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_11

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

				local var_197_12 = arg_194_1:GetWordFromCfg(420121044)
				local var_197_13 = arg_194_1:FormatText(var_197_12.content)

				arg_194_1.text_.text = var_197_13

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_14 = 31
				local var_197_15 = utf8.len(var_197_13)
				local var_197_16 = var_197_14 <= 0 and var_197_10 or var_197_10 * (var_197_15 / var_197_14)

				if var_197_16 > 0 and var_197_10 < var_197_16 then
					arg_194_1.talkMaxDuration = var_197_16

					if var_197_16 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_16 + var_197_9
					end
				end

				arg_194_1.text_.text = var_197_13
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_17 = math.max(var_197_10, arg_194_1.talkMaxDuration)

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_17 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_9) / var_197_17

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_9 + var_197_17 and arg_194_1.time_ < var_197_9 + var_197_17 + arg_197_0 then
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
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_1 = 1

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_1 then
				local var_201_2 = (arg_198_1.time_ - var_201_0) / var_201_1
				local var_201_3 = Color.New(0, 0, 0)

				var_201_3.a = Mathf.Lerp(0, 1, var_201_2)
				arg_198_1.mask_.color = var_201_3
			end

			if arg_198_1.time_ >= var_201_0 + var_201_1 and arg_198_1.time_ < var_201_0 + var_201_1 + arg_201_0 then
				local var_201_4 = Color.New(0, 0, 0)

				var_201_4.a = 1
				arg_198_1.mask_.color = var_201_4
			end

			local var_201_5 = 1

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_6 = 1

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6
				local var_201_8 = Color.New(0, 0, 0)

				var_201_8.a = Mathf.Lerp(1, 0, var_201_7)
				arg_198_1.mask_.color = var_201_8
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				local var_201_9 = Color.New(0, 0, 0)
				local var_201_10 = 0

				arg_198_1.mask_.enabled = false
				var_201_9.a = var_201_10
				arg_198_1.mask_.color = var_201_9
			end

			local var_201_11 = "SS2002"

			if arg_198_1.bgs_[var_201_11] == nil then
				local var_201_12 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_201_11)
				var_201_12.name = var_201_11
				var_201_12.transform.parent = arg_198_1.stage_.transform
				var_201_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_[var_201_11] = var_201_12
			end

			local var_201_13 = 1

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				local var_201_14 = manager.ui.mainCamera.transform.localPosition
				local var_201_15 = Vector3.New(0, 0, 10) + Vector3.New(var_201_14.x, var_201_14.y, 0)
				local var_201_16 = arg_198_1.bgs_.SS2002

				var_201_16.transform.localPosition = var_201_15
				var_201_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_17 = var_201_16:GetComponent("SpriteRenderer")

				if var_201_17 and var_201_17.sprite then
					local var_201_18 = (var_201_16.transform.localPosition - var_201_14).z
					local var_201_19 = manager.ui.mainCameraCom_
					local var_201_20 = 2 * var_201_18 * Mathf.Tan(var_201_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_201_21 = var_201_20 * var_201_19.aspect
					local var_201_22 = var_201_17.sprite.bounds.size.x
					local var_201_23 = var_201_17.sprite.bounds.size.y
					local var_201_24 = var_201_21 / var_201_22
					local var_201_25 = var_201_20 / var_201_23
					local var_201_26 = var_201_25 < var_201_24 and var_201_24 or var_201_25

					var_201_16.transform.localScale = Vector3.New(var_201_26, var_201_26, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "SS2002" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_27 = arg_198_1.bgs_.SS2002.transform
			local var_201_28 = 1

			if var_201_28 < arg_198_1.time_ and arg_198_1.time_ <= var_201_28 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2002 = var_201_27.localPosition
			end

			local var_201_29 = 0.001

			if var_201_28 <= arg_198_1.time_ and arg_198_1.time_ < var_201_28 + var_201_29 then
				local var_201_30 = (arg_198_1.time_ - var_201_28) / var_201_29
				local var_201_31 = Vector3.New(0, 1, 9)

				var_201_27.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2002, var_201_31, var_201_30)
			end

			if arg_198_1.time_ >= var_201_28 + var_201_29 and arg_198_1.time_ < var_201_28 + var_201_29 + arg_201_0 then
				var_201_27.localPosition = Vector3.New(0, 1, 9)
			end

			local var_201_32 = arg_198_1.bgs_.SS2002.transform
			local var_201_33 = 1.03333333333333

			if var_201_33 < arg_198_1.time_ and arg_198_1.time_ <= var_201_33 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2002 = var_201_32.localPosition
			end

			local var_201_34 = 1.63333333333333

			if var_201_33 <= arg_198_1.time_ and arg_198_1.time_ < var_201_33 + var_201_34 then
				local var_201_35 = (arg_198_1.time_ - var_201_33) / var_201_34
				local var_201_36 = Vector3.New(0, 0.8, 9)

				var_201_32.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2002, var_201_36, var_201_35)
			end

			if arg_198_1.time_ >= var_201_33 + var_201_34 and arg_198_1.time_ < var_201_33 + var_201_34 + arg_201_0 then
				var_201_32.localPosition = Vector3.New(0, 0.8, 9)
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_37 = 2.66666666666667
			local var_201_38 = 1.075

			if var_201_37 < arg_198_1.time_ and arg_198_1.time_ <= var_201_37 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_39 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_39:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_40 = arg_198_1:GetWordFromCfg(420121045)
				local var_201_41 = arg_198_1:FormatText(var_201_40.content)

				arg_198_1.text_.text = var_201_41

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_42 = 43
				local var_201_43 = utf8.len(var_201_41)
				local var_201_44 = var_201_42 <= 0 and var_201_38 or var_201_38 * (var_201_43 / var_201_42)

				if var_201_44 > 0 and var_201_38 < var_201_44 then
					arg_198_1.talkMaxDuration = var_201_44
					var_201_37 = var_201_37 + 0.3

					if var_201_44 + var_201_37 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_44 + var_201_37
					end
				end

				arg_198_1.text_.text = var_201_41
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_45 = var_201_37 + 0.3
			local var_201_46 = math.max(var_201_38, arg_198_1.talkMaxDuration)

			if var_201_45 <= arg_198_1.time_ and arg_198_1.time_ < var_201_45 + var_201_46 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_45) / var_201_46

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_45 + var_201_46 and arg_198_1.time_ < var_201_45 + var_201_46 + arg_201_0 then
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
			local var_207_0 = 0
			local var_207_1 = 0.775

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_2

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

				local var_207_3 = arg_204_1:GetWordFromCfg(420121046)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 31
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
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
			local var_211_0 = 0
			local var_211_1 = 0.45

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[328].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(420121047)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 18
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121047", "story_v_out_420121.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_420121", "420121047", "story_v_out_420121.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_420121", "420121047", "story_v_out_420121.awb")

						arg_208_1:RecordAudio("420121047", var_211_9)
						arg_208_1:RecordAudio("420121047", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_420121", "420121047", "story_v_out_420121.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_420121", "420121047", "story_v_out_420121.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
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
			local var_215_0 = 0
			local var_215_1 = 1.25

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_2

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

				local var_215_3 = arg_212_1:GetWordFromCfg(420121048)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 50
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_8 and arg_212_1.time_ < var_215_0 + var_215_8 + arg_215_0 then
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
			local var_219_0 = "SS2002a"

			if arg_216_1.bgs_[var_219_0] == nil then
				local var_219_1 = Object.Instantiate(arg_216_1.paintGo_)

				var_219_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_0)
				var_219_1.name = var_219_0
				var_219_1.transform.parent = arg_216_1.stage_.transform
				var_219_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_[var_219_0] = var_219_1
			end

			local var_219_2 = 0

			if var_219_2 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				local var_219_3 = manager.ui.mainCamera.transform.localPosition
				local var_219_4 = Vector3.New(0, 0, 10) + Vector3.New(var_219_3.x, var_219_3.y, 0)
				local var_219_5 = arg_216_1.bgs_.SS2002a

				var_219_5.transform.localPosition = var_219_4
				var_219_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_6 = var_219_5:GetComponent("SpriteRenderer")

				if var_219_6 and var_219_6.sprite then
					local var_219_7 = (var_219_5.transform.localPosition - var_219_3).z
					local var_219_8 = manager.ui.mainCameraCom_
					local var_219_9 = 2 * var_219_7 * Mathf.Tan(var_219_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_219_10 = var_219_9 * var_219_8.aspect
					local var_219_11 = var_219_6.sprite.bounds.size.x
					local var_219_12 = var_219_6.sprite.bounds.size.y
					local var_219_13 = var_219_10 / var_219_11
					local var_219_14 = var_219_9 / var_219_12
					local var_219_15 = var_219_14 < var_219_13 and var_219_13 or var_219_14

					var_219_5.transform.localScale = Vector3.New(var_219_15, var_219_15, 0)
				end

				for iter_219_0, iter_219_1 in pairs(arg_216_1.bgs_) do
					if iter_219_0 ~= "SS2002a" then
						iter_219_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_219_16 = arg_216_1.bgs_.SS2002a.transform
			local var_219_17 = 0

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.var_.moveOldPosSS2002a = var_219_16.localPosition
			end

			local var_219_18 = 0.001

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_18 then
				local var_219_19 = (arg_216_1.time_ - var_219_17) / var_219_18
				local var_219_20 = Vector3.New(0, 0.8, 9)

				var_219_16.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPosSS2002a, var_219_20, var_219_19)
			end

			if arg_216_1.time_ >= var_219_17 + var_219_18 and arg_216_1.time_ < var_219_17 + var_219_18 + arg_219_0 then
				var_219_16.localPosition = Vector3.New(0, 0.8, 9)
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_21 = 0.034
			local var_219_22 = 0.125

			if var_219_21 < arg_216_1.time_ and arg_216_1.time_ <= var_219_21 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_23 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_23:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_24 = arg_216_1:FormatText(StoryNameCfg[328].name)

				arg_216_1.leftNameTxt_.text = var_219_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_25 = arg_216_1:GetWordFromCfg(420121049)
				local var_219_26 = arg_216_1:FormatText(var_219_25.content)

				arg_216_1.text_.text = var_219_26

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_27 = 5
				local var_219_28 = utf8.len(var_219_26)
				local var_219_29 = var_219_27 <= 0 and var_219_22 or var_219_22 * (var_219_28 / var_219_27)

				if var_219_29 > 0 and var_219_22 < var_219_29 then
					arg_216_1.talkMaxDuration = var_219_29
					var_219_21 = var_219_21 + 0.3

					if var_219_29 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_29 + var_219_21
					end
				end

				arg_216_1.text_.text = var_219_26
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121049", "story_v_out_420121.awb") ~= 0 then
					local var_219_30 = manager.audio:GetVoiceLength("story_v_out_420121", "420121049", "story_v_out_420121.awb") / 1000

					if var_219_30 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_30 + var_219_21
					end

					if var_219_25.prefab_name ~= "" and arg_216_1.actors_[var_219_25.prefab_name] ~= nil then
						local var_219_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_25.prefab_name].transform, "story_v_out_420121", "420121049", "story_v_out_420121.awb")

						arg_216_1:RecordAudio("420121049", var_219_31)
						arg_216_1:RecordAudio("420121049", var_219_31)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_420121", "420121049", "story_v_out_420121.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_420121", "420121049", "story_v_out_420121.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_32 = var_219_21 + 0.3
			local var_219_33 = math.max(var_219_22, arg_216_1.talkMaxDuration)

			if var_219_32 <= arg_216_1.time_ and arg_216_1.time_ < var_219_32 + var_219_33 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_32) / var_219_33

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_32 + var_219_33 and arg_216_1.time_ < var_219_32 + var_219_33 + arg_219_0 then
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
			local var_225_0 = 0
			local var_225_1 = 0.45

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_2

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

				local var_225_3 = arg_222_1:GetWordFromCfg(420121050)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 18
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
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
			local var_229_0 = 0
			local var_229_1 = 1.325

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_2

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

				local var_229_3 = arg_226_1:GetWordFromCfg(420121051)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 53
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
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
			local var_233_0 = 0
			local var_233_1 = 1.05

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_2

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

				local var_233_3 = arg_230_1:GetWordFromCfg(420121052)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 42
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
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
			local var_237_0 = manager.ui.mainCamera.transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				local var_237_2 = arg_234_1.var_.effect1048

				if var_237_2 then
					Object.Destroy(var_237_2)

					arg_234_1.var_.effect1048 = nil
				end
			end

			local var_237_3 = manager.ui.mainCamera.transform
			local var_237_4 = 0

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				local var_237_5 = arg_234_1.var_.effect1053
				local var_237_6
				local var_237_7 = var_237_3

				if not var_237_5 then
					var_237_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_237_7)
					var_237_5.name = "1053"
					arg_234_1.var_.effect1053 = var_237_5
				else
					var_237_5.transform:SetParent(var_237_7)
				end

				var_237_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_237_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_237_8 = manager.ui.mainCamera.transform
			local var_237_9 = 1.2

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 then
				local var_237_10 = arg_234_1.var_.effect1053

				if var_237_10 then
					Object.Destroy(var_237_10)

					arg_234_1.var_.effect1053 = nil
				end
			end

			local var_237_11 = manager.ui.mainCamera.transform
			local var_237_12 = 1.2

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 then
				local var_237_13 = arg_234_1.var_.effect10532
				local var_237_14
				local var_237_15 = var_237_11

				if not var_237_13 then
					var_237_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_237_15)
					var_237_13.name = "10532"
					arg_234_1.var_.effect10532 = var_237_13
				else
					var_237_13.transform:SetParent(var_237_15)
				end

				var_237_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_237_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_237_16 = manager.ui.mainCamera.transform
			local var_237_17 = 2.73333333333333

			if var_237_17 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				local var_237_18 = arg_234_1.var_.effect10532

				if var_237_18 then
					Object.Destroy(var_237_18)

					arg_234_1.var_.effect10532 = nil
				end
			end

			local var_237_19 = "SS2002d"

			if arg_234_1.bgs_[var_237_19] == nil then
				local var_237_20 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_19)
				var_237_20.name = var_237_19
				var_237_20.transform.parent = arg_234_1.stage_.transform
				var_237_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_19] = var_237_20
			end

			local var_237_21 = arg_234_1.bgs_.SS2002d.transform
			local var_237_22 = 1.2

			if var_237_22 < arg_234_1.time_ and arg_234_1.time_ <= var_237_22 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS2002d = var_237_21.localPosition
			end

			local var_237_23 = 0.001

			if var_237_22 <= arg_234_1.time_ and arg_234_1.time_ < var_237_22 + var_237_23 then
				local var_237_24 = (arg_234_1.time_ - var_237_22) / var_237_23
				local var_237_25 = Vector3.New(0, 1, 9)

				var_237_21.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS2002d, var_237_25, var_237_24)
			end

			if arg_234_1.time_ >= var_237_22 + var_237_23 and arg_234_1.time_ < var_237_22 + var_237_23 + arg_237_0 then
				var_237_21.localPosition = Vector3.New(0, 1, 9)
			end

			local var_237_26 = arg_234_1.bgs_.SS2002d.transform
			local var_237_27 = 1.23400000184774

			if var_237_27 < arg_234_1.time_ and arg_234_1.time_ <= var_237_27 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS2002d = var_237_26.localPosition
			end

			local var_237_28 = 1.43266666481892

			if var_237_27 <= arg_234_1.time_ and arg_234_1.time_ < var_237_27 + var_237_28 then
				local var_237_29 = (arg_234_1.time_ - var_237_27) / var_237_28
				local var_237_30 = Vector3.New(0, 1, 8.8)

				var_237_26.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS2002d, var_237_30, var_237_29)
			end

			if arg_234_1.time_ >= var_237_27 + var_237_28 and arg_234_1.time_ < var_237_27 + var_237_28 + arg_237_0 then
				var_237_26.localPosition = Vector3.New(0, 1, 8.8)
			end

			local var_237_31 = 1.16599999815226

			if var_237_31 < arg_234_1.time_ and arg_234_1.time_ <= var_237_31 + arg_237_0 then
				local var_237_32 = manager.ui.mainCamera.transform.localPosition
				local var_237_33 = Vector3.New(0, 0, 10) + Vector3.New(var_237_32.x, var_237_32.y, 0)
				local var_237_34 = arg_234_1.bgs_.SS2002d

				var_237_34.transform.localPosition = var_237_33
				var_237_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_35 = var_237_34:GetComponent("SpriteRenderer")

				if var_237_35 and var_237_35.sprite then
					local var_237_36 = (var_237_34.transform.localPosition - var_237_32).z
					local var_237_37 = manager.ui.mainCameraCom_
					local var_237_38 = 2 * var_237_36 * Mathf.Tan(var_237_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_39 = var_237_38 * var_237_37.aspect
					local var_237_40 = var_237_35.sprite.bounds.size.x
					local var_237_41 = var_237_35.sprite.bounds.size.y
					local var_237_42 = var_237_39 / var_237_40
					local var_237_43 = var_237_38 / var_237_41
					local var_237_44 = var_237_43 < var_237_42 and var_237_42 or var_237_43

					var_237_34.transform.localScale = Vector3.New(var_237_44, var_237_44, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS2002d" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_45 = 0

			if var_237_45 < arg_234_1.time_ and arg_234_1.time_ <= var_237_45 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_46 = 2.95

			if arg_234_1.time_ >= var_237_45 + var_237_46 and arg_234_1.time_ < var_237_45 + var_237_46 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_47 = 2.66666666666667
			local var_237_48 = 0.4

			if var_237_47 < arg_234_1.time_ and arg_234_1.time_ <= var_237_47 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_49 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_49:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_50 = arg_234_1:GetWordFromCfg(420121053)
				local var_237_51 = arg_234_1:FormatText(var_237_50.content)

				arg_234_1.text_.text = var_237_51

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_52 = 16
				local var_237_53 = utf8.len(var_237_51)
				local var_237_54 = var_237_52 <= 0 and var_237_48 or var_237_48 * (var_237_53 / var_237_52)

				if var_237_54 > 0 and var_237_48 < var_237_54 then
					arg_234_1.talkMaxDuration = var_237_54
					var_237_47 = var_237_47 + 0.3

					if var_237_54 + var_237_47 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_54 + var_237_47
					end
				end

				arg_234_1.text_.text = var_237_51
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121053", "story_v_out_420121.awb") ~= 0 then
					local var_237_55 = manager.audio:GetVoiceLength("story_v_out_420121", "420121053", "story_v_out_420121.awb") / 1000

					if var_237_55 + var_237_47 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_55 + var_237_47
					end

					if var_237_50.prefab_name ~= "" and arg_234_1.actors_[var_237_50.prefab_name] ~= nil then
						local var_237_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_50.prefab_name].transform, "story_v_out_420121", "420121053", "story_v_out_420121.awb")

						arg_234_1:RecordAudio("420121053", var_237_56)
						arg_234_1:RecordAudio("420121053", var_237_56)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_420121", "420121053", "story_v_out_420121.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_420121", "420121053", "story_v_out_420121.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_57 = var_237_47 + 0.3
			local var_237_58 = math.max(var_237_48, arg_234_1.talkMaxDuration)

			if var_237_57 <= arg_234_1.time_ and arg_234_1.time_ < var_237_57 + var_237_58 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_57) / var_237_58

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_57 + var_237_58 and arg_234_1.time_ < var_237_57 + var_237_58 + arg_237_0 then
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
			local var_243_0 = 0
			local var_243_1 = 0.55

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(420121054)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 22
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121054", "story_v_out_420121.awb") ~= 0 then
					local var_243_7 = manager.audio:GetVoiceLength("story_v_out_420121", "420121054", "story_v_out_420121.awb") / 1000

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end

					if var_243_2.prefab_name ~= "" and arg_240_1.actors_[var_243_2.prefab_name] ~= nil then
						local var_243_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_2.prefab_name].transform, "story_v_out_420121", "420121054", "story_v_out_420121.awb")

						arg_240_1:RecordAudio("420121054", var_243_8)
						arg_240_1:RecordAudio("420121054", var_243_8)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_420121", "420121054", "story_v_out_420121.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_420121", "420121054", "story_v_out_420121.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_9 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_9 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_9

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_9 and arg_240_1.time_ < var_243_0 + var_243_9 + arg_243_0 then
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
			local var_247_0 = 0

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				local var_247_1 = arg_244_1.var_.effect

				if var_247_1 then
					Object.Destroy(var_247_1)

					arg_244_1.var_.effect = nil
				end
			end

			local var_247_2 = 0
			local var_247_3 = 0.675

			if var_247_2 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_4 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_4:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_5 = arg_244_1:GetWordFromCfg(420121055)
				local var_247_6 = arg_244_1:FormatText(var_247_5.content)

				arg_244_1.text_.text = var_247_6

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 27
				local var_247_8 = utf8.len(var_247_6)
				local var_247_9 = var_247_7 <= 0 and var_247_3 or var_247_3 * (var_247_8 / var_247_7)

				if var_247_9 > 0 and var_247_3 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9
					var_247_2 = var_247_2 + 0.3

					if var_247_9 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_2
					end
				end

				arg_244_1.text_.text = var_247_6
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121055", "story_v_out_420121.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_420121", "420121055", "story_v_out_420121.awb") / 1000

					if var_247_10 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_2
					end

					if var_247_5.prefab_name ~= "" and arg_244_1.actors_[var_247_5.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_5.prefab_name].transform, "story_v_out_420121", "420121055", "story_v_out_420121.awb")

						arg_244_1:RecordAudio("420121055", var_247_11)
						arg_244_1:RecordAudio("420121055", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_420121", "420121055", "story_v_out_420121.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_420121", "420121055", "story_v_out_420121.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = var_247_2 + 0.3
			local var_247_13 = math.max(var_247_3, arg_244_1.talkMaxDuration)

			if var_247_12 <= arg_244_1.time_ and arg_244_1.time_ < var_247_12 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_12) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_12 + var_247_13 and arg_244_1.time_ < var_247_12 + var_247_13 + arg_247_0 then
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
			local var_253_0 = "SS2002b"

			if arg_250_1.bgs_[var_253_0] == nil then
				local var_253_1 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_253_0)
				var_253_1.name = var_253_0
				var_253_1.transform.parent = arg_250_1.stage_.transform
				var_253_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_[var_253_0] = var_253_1
			end

			local var_253_2 = 0

			if var_253_2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				local var_253_3 = manager.ui.mainCamera.transform.localPosition
				local var_253_4 = Vector3.New(0, 0, 10) + Vector3.New(var_253_3.x, var_253_3.y, 0)
				local var_253_5 = arg_250_1.bgs_.SS2002b

				var_253_5.transform.localPosition = var_253_4
				var_253_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_6 = var_253_5:GetComponent("SpriteRenderer")

				if var_253_6 and var_253_6.sprite then
					local var_253_7 = (var_253_5.transform.localPosition - var_253_3).z
					local var_253_8 = manager.ui.mainCameraCom_
					local var_253_9 = 2 * var_253_7 * Mathf.Tan(var_253_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_253_10 = var_253_9 * var_253_8.aspect
					local var_253_11 = var_253_6.sprite.bounds.size.x
					local var_253_12 = var_253_6.sprite.bounds.size.y
					local var_253_13 = var_253_10 / var_253_11
					local var_253_14 = var_253_9 / var_253_12
					local var_253_15 = var_253_14 < var_253_13 and var_253_13 or var_253_14

					var_253_5.transform.localScale = Vector3.New(var_253_15, var_253_15, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "SS2002b" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_16 = 0
			local var_253_17 = 0.575

			if var_253_16 < arg_250_1.time_ and arg_250_1.time_ <= var_253_16 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_18 = arg_250_1:FormatText(StoryNameCfg[328].name)

				arg_250_1.leftNameTxt_.text = var_253_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_19 = arg_250_1:GetWordFromCfg(420121056)
				local var_253_20 = arg_250_1:FormatText(var_253_19.content)

				arg_250_1.text_.text = var_253_20

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_21 = 23
				local var_253_22 = utf8.len(var_253_20)
				local var_253_23 = var_253_21 <= 0 and var_253_17 or var_253_17 * (var_253_22 / var_253_21)

				if var_253_23 > 0 and var_253_17 < var_253_23 then
					arg_250_1.talkMaxDuration = var_253_23

					if var_253_23 + var_253_16 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_16
					end
				end

				arg_250_1.text_.text = var_253_20
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121056", "story_v_out_420121.awb") ~= 0 then
					local var_253_24 = manager.audio:GetVoiceLength("story_v_out_420121", "420121056", "story_v_out_420121.awb") / 1000

					if var_253_24 + var_253_16 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_24 + var_253_16
					end

					if var_253_19.prefab_name ~= "" and arg_250_1.actors_[var_253_19.prefab_name] ~= nil then
						local var_253_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_19.prefab_name].transform, "story_v_out_420121", "420121056", "story_v_out_420121.awb")

						arg_250_1:RecordAudio("420121056", var_253_25)
						arg_250_1:RecordAudio("420121056", var_253_25)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_420121", "420121056", "story_v_out_420121.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_420121", "420121056", "story_v_out_420121.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_26 = math.max(var_253_17, arg_250_1.talkMaxDuration)

			if var_253_16 <= arg_250_1.time_ and arg_250_1.time_ < var_253_16 + var_253_26 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_16) / var_253_26

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_16 + var_253_26 and arg_250_1.time_ < var_253_16 + var_253_26 + arg_253_0 then
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
			local var_257_0 = 0
			local var_257_1 = 0.4

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_2

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

				local var_257_3 = arg_254_1:GetWordFromCfg(420121057)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 16
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_8 and arg_254_1.time_ < var_257_0 + var_257_8 + arg_257_0 then
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
			local var_261_0 = 0
			local var_261_1 = 1.35

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_2

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

				local var_261_3 = arg_258_1:GetWordFromCfg(420121058)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 54
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_8 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_8 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_8

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_8 and arg_258_1.time_ < var_261_0 + var_261_8 + arg_261_0 then
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
			local var_265_0 = 0
			local var_265_1 = 0.7

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_2

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

				local var_265_3 = arg_262_1:GetWordFromCfg(420121059)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 28
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
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
			local var_269_0 = "SS2002e"

			if arg_266_1.bgs_[var_269_0] == nil then
				local var_269_1 = Object.Instantiate(arg_266_1.paintGo_)

				var_269_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_269_0)
				var_269_1.name = var_269_0
				var_269_1.transform.parent = arg_266_1.stage_.transform
				var_269_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.bgs_[var_269_0] = var_269_1
			end

			local var_269_2 = 0

			if var_269_2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				local var_269_3 = manager.ui.mainCamera.transform.localPosition
				local var_269_4 = Vector3.New(0, 0, 10) + Vector3.New(var_269_3.x, var_269_3.y, 0)
				local var_269_5 = arg_266_1.bgs_.SS2002e

				var_269_5.transform.localPosition = var_269_4
				var_269_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_269_6 = var_269_5:GetComponent("SpriteRenderer")

				if var_269_6 and var_269_6.sprite then
					local var_269_7 = (var_269_5.transform.localPosition - var_269_3).z
					local var_269_8 = manager.ui.mainCameraCom_
					local var_269_9 = 2 * var_269_7 * Mathf.Tan(var_269_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_269_10 = var_269_9 * var_269_8.aspect
					local var_269_11 = var_269_6.sprite.bounds.size.x
					local var_269_12 = var_269_6.sprite.bounds.size.y
					local var_269_13 = var_269_10 / var_269_11
					local var_269_14 = var_269_9 / var_269_12
					local var_269_15 = var_269_14 < var_269_13 and var_269_13 or var_269_14

					var_269_5.transform.localScale = Vector3.New(var_269_15, var_269_15, 0)
				end

				for iter_269_0, iter_269_1 in pairs(arg_266_1.bgs_) do
					if iter_269_0 ~= "SS2002e" then
						iter_269_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_269_16 = 0
			local var_269_17 = 0.125

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_18 = arg_266_1:FormatText(StoryNameCfg[328].name)

				arg_266_1.leftNameTxt_.text = var_269_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_19 = arg_266_1:GetWordFromCfg(420121060)
				local var_269_20 = arg_266_1:FormatText(var_269_19.content)

				arg_266_1.text_.text = var_269_20

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_21 = 5
				local var_269_22 = utf8.len(var_269_20)
				local var_269_23 = var_269_21 <= 0 and var_269_17 or var_269_17 * (var_269_22 / var_269_21)

				if var_269_23 > 0 and var_269_17 < var_269_23 then
					arg_266_1.talkMaxDuration = var_269_23

					if var_269_23 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_16
					end
				end

				arg_266_1.text_.text = var_269_20
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420121", "420121060", "story_v_out_420121.awb") ~= 0 then
					local var_269_24 = manager.audio:GetVoiceLength("story_v_out_420121", "420121060", "story_v_out_420121.awb") / 1000

					if var_269_24 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_16
					end

					if var_269_19.prefab_name ~= "" and arg_266_1.actors_[var_269_19.prefab_name] ~= nil then
						local var_269_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_19.prefab_name].transform, "story_v_out_420121", "420121060", "story_v_out_420121.awb")

						arg_266_1:RecordAudio("420121060", var_269_25)
						arg_266_1:RecordAudio("420121060", var_269_25)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_420121", "420121060", "story_v_out_420121.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_420121", "420121060", "story_v_out_420121.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_26 = math.max(var_269_17, arg_266_1.talkMaxDuration)

			if var_269_16 <= arg_266_1.time_ and arg_266_1.time_ < var_269_16 + var_269_26 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_16) / var_269_26

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_16 + var_269_26 and arg_266_1.time_ < var_269_16 + var_269_26 + arg_269_0 then
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
			local var_273_0 = 0
			local var_273_1 = 0.275

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

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

				local var_273_3 = arg_270_1:GetWordFromCfg(420121061)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 11
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
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
			local var_277_0 = 0
			local var_277_1 = 0.75

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(420121062)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 30
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
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
			local var_281_0 = 0
			local var_281_1 = 0.5

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_2

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

				local var_281_3 = arg_278_1:GetWordFromCfg(420121063)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 20
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
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
			local var_285_0 = 0

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_1 = 1.05

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_1 then
				local var_285_2 = (arg_282_1.time_ - var_285_0) / var_285_1
				local var_285_3 = Color.New(1, 1, 1)

				var_285_3.a = Mathf.Lerp(1, 0, var_285_2)
				arg_282_1.mask_.color = var_285_3
			end

			if arg_282_1.time_ >= var_285_0 + var_285_1 and arg_282_1.time_ < var_285_0 + var_285_1 + arg_285_0 then
				local var_285_4 = Color.New(1, 1, 1)
				local var_285_5 = 0

				arg_282_1.mask_.enabled = false
				var_285_4.a = var_285_5
				arg_282_1.mask_.color = var_285_4
			end

			local var_285_6 = "L16b"

			if arg_282_1.bgs_[var_285_6] == nil then
				local var_285_7 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_285_6)
				var_285_7.name = var_285_6
				var_285_7.transform.parent = arg_282_1.stage_.transform
				var_285_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_[var_285_6] = var_285_7
			end

			local var_285_8 = 0

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				local var_285_9 = manager.ui.mainCamera.transform.localPosition
				local var_285_10 = Vector3.New(0, 0, 10) + Vector3.New(var_285_9.x, var_285_9.y, 0)
				local var_285_11 = arg_282_1.bgs_.L16b

				var_285_11.transform.localPosition = var_285_10
				var_285_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_12 = var_285_11:GetComponent("SpriteRenderer")

				if var_285_12 and var_285_12.sprite then
					local var_285_13 = (var_285_11.transform.localPosition - var_285_9).z
					local var_285_14 = manager.ui.mainCameraCom_
					local var_285_15 = 2 * var_285_13 * Mathf.Tan(var_285_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_285_16 = var_285_15 * var_285_14.aspect
					local var_285_17 = var_285_12.sprite.bounds.size.x
					local var_285_18 = var_285_12.sprite.bounds.size.y
					local var_285_19 = var_285_16 / var_285_17
					local var_285_20 = var_285_15 / var_285_18
					local var_285_21 = var_285_20 < var_285_19 and var_285_19 or var_285_20

					var_285_11.transform.localScale = Vector3.New(var_285_21, var_285_21, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "L16b" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_22 = 0
			local var_285_23 = 1.125

			if var_285_22 < arg_282_1.time_ and arg_282_1.time_ <= var_285_22 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_24 = arg_282_1:GetWordFromCfg(420121064)
				local var_285_25 = arg_282_1:FormatText(var_285_24.content)

				arg_282_1.text_.text = var_285_25

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_26 = 45
				local var_285_27 = utf8.len(var_285_25)
				local var_285_28 = var_285_26 <= 0 and var_285_23 or var_285_23 * (var_285_27 / var_285_26)

				if var_285_28 > 0 and var_285_23 < var_285_28 then
					arg_282_1.talkMaxDuration = var_285_28

					if var_285_28 + var_285_22 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_28 + var_285_22
					end
				end

				arg_282_1.text_.text = var_285_25
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_29 = math.max(var_285_23, arg_282_1.talkMaxDuration)

			if var_285_22 <= arg_282_1.time_ and arg_282_1.time_ < var_285_22 + var_285_29 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_22) / var_285_29

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_22 + var_285_29 and arg_282_1.time_ < var_285_22 + var_285_29 + arg_285_0 then
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
			local var_289_0 = 0
			local var_289_1 = 0.6

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(420121065)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 24
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
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
				local var_291_0 = iter_291_0 <= 1

				SetActive(iter_291_1.go, var_291_0)
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
			local var_297_0 = 0

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				SetActive(arg_294_1.dialog_, false)
				SetActive(arg_294_1.allBtn_.gameObject, false)
				arg_294_1.hideBtnsController_:SetSelectedIndex(1)
				arg_294_1:StopAllVoice()

				arg_294_1.marker = "stop1"

				manager.video:Play("SofdecAsset/story/story_1042012.usm", function(arg_298_0)
					arg_294_1:Skip(arg_298_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_299_0)
					if arg_299_0 then
						arg_294_1.state_ = "pause"
					else
						arg_294_1.state_ = "playing"
					end
				end, 1042012)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_297_1 = 45

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_1 then
				-- block empty
			end

			if arg_294_1.time_ >= var_297_0 + var_297_1 and arg_294_1.time_ < var_297_0 + var_297_1 + arg_297_0 then
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
