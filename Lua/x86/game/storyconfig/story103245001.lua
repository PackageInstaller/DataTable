return {
	Play324501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324501001
		arg_1_1.duration_ = 7.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J21h"

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
				local var_4_5 = arg_1_1.bgs_.J21h

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
					if iter_4_0 ~= "J21h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect32143
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_keep"), var_4_28)
					var_4_26.name = "32143"
					arg_1_1.var_.effect32143 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = manager.ui.mainCamera.transform
			local var_4_30 = 1.5

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = arg_1_1.var_.effect3214
				local var_4_32
				local var_4_33 = var_4_29

				if not var_4_31 then
					var_4_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_out"), var_4_33)
					var_4_31.name = "3214"
					arg_1_1.var_.effect3214 = var_4_31
				else
					var_4_31.transform:SetParent(var_4_33)
				end

				var_4_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_34 = manager.ui.mainCamera.transform
			local var_4_35 = 1.76666666666667

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_36 = arg_1_1.var_.effect32143

				if var_4_36 then
					Object.Destroy(var_4_36)

					arg_1_1.var_.effect32143 = nil
				end
			end

			local var_4_37 = manager.ui.mainCamera.transform
			local var_4_38 = 3.26666666666666

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = arg_1_1.var_.effect3214

				if var_4_39 then
					Object.Destroy(var_4_39)

					arg_1_1.var_.effect3214 = nil
				end
			end

			local var_4_40
			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_42 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_4_42 then
					var_4_42.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_4_42.radialBlurScale = 0
					var_4_42.radialBlurGradient = 1
					var_4_42.radialBlurIntensity = 1

					if var_4_40 then
						var_4_42.radialBlurTarget = var_4_40.transform
					end
				end
			end

			local var_4_43 = 2

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_41) / var_4_43
				local var_4_45 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_4_45 then
					var_4_45.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_4_45.radialBlurScale = Mathf.Lerp(0, 0.857, var_4_44)
					var_4_45.radialBlurGradient = Mathf.Lerp(1, 1, var_4_44)
					var_4_45.radialBlurIntensity = Mathf.Lerp(1, 1, var_4_44)
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_43 and arg_1_1.time_ < var_4_41 + var_4_43 + arg_4_0 then
				local var_4_46 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_4_46 then
					var_4_46.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_4_46.radialBlurScale = 0.857
					var_4_46.radialBlurGradient = 1
					var_4_46.radialBlurIntensity = 1
				end
			end

			local var_4_47 = 0

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_48 = 3.56666666666667

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_49 = 0.1
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_53 = 0
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "effect"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_57 = 0
			local var_4_58 = 1.5

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "effect"

				arg_1_1:AudioAction(var_4_59, var_4_60, "se_story_150", "se_story_150_open", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2.8
			local var_4_62 = 1.4

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(324501001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 56
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_62 or var_4_62 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_62 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_61 = var_4_61 + 0.3

					if var_4_68 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_61 + 0.3
			local var_4_70 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324501002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324501002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324501003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.45

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(324501002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 58
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play324501003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 324501003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play324501004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "play"
				local var_14_3 = "music"

				arg_11_1:AudioAction(var_14_2, var_14_3, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_14_4 = ""
				local var_14_5 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if var_14_5 ~= "" then
					if arg_11_1.bgmTxt_.text ~= var_14_5 and arg_11_1.bgmTxt_.text ~= "" then
						if arg_11_1.bgmTxt2_.text ~= "" then
							arg_11_1.bgmTxt_.text = arg_11_1.bgmTxt2_.text
						end

						arg_11_1.bgmTxt2_.text = var_14_5

						arg_11_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_11_1.bgmTxt_.text = var_14_5
						arg_11_1.bgmTxt2_.text = var_14_5
					end

					if arg_11_1.bgmTimer then
						arg_11_1.bgmTimer:Stop()

						arg_11_1.bgmTimer = nil
					end

					if arg_11_1.settingData.show_music_name == 1 then
						arg_11_1.musicController:SetSelectedState("show")
						arg_11_1.musicAnimator_:Play("open", 0, 0)

						if arg_11_1.settingData.music_time ~= 0 then
							arg_11_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_11_1.settingData.music_time), function()
								if arg_11_1 == nil or isNil(arg_11_1.bgmTxt_) then
									return
								end

								arg_11_1.musicController:SetSelectedState("hide")
								arg_11_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_14_6 = 0
			local var_14_7 = 0.275

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_8 = arg_11_1:FormatText(StoryNameCfg[7].name)

				arg_11_1.leftNameTxt_.text = var_14_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_9 = arg_11_1:GetWordFromCfg(324501003)
				local var_14_10 = arg_11_1:FormatText(var_14_9.content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_11 = 11
				local var_14_12 = utf8.len(var_14_10)
				local var_14_13 = var_14_11 <= 0 and var_14_7 or var_14_7 * (var_14_12 / var_14_11)

				if var_14_13 > 0 and var_14_7 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_6 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_6
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_14 = math.max(var_14_7, arg_11_1.talkMaxDuration)

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_14 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_6) / var_14_14

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_6 + var_14_14 and arg_11_1.time_ < var_14_6 + var_14_14 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play324501004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324501004
		arg_16_1.duration_ = 2.93

		local var_16_0 = {
			zh = 2.933,
			ja = 1.666
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324501005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10165ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "10165ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["10165ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect10165ui_story == nil then
				arg_16_1.var_.characterEffect10165ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.200000002980232

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect10165ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect10165ui_story then
				arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_19_9 = 0
			local var_19_10 = 0.3

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_11 = arg_16_1:FormatText(StoryNameCfg[1446].name)

				arg_16_1.leftNameTxt_.text = var_19_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10165")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_12 = arg_16_1:GetWordFromCfg(324501004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_14 = 12
				local var_19_15 = utf8.len(var_19_13)
				local var_19_16 = var_19_14 <= 0 and var_19_10 or var_19_10 * (var_19_15 / var_19_14)

				if var_19_16 > 0 and var_19_10 < var_19_16 then
					arg_16_1.talkMaxDuration = var_19_16

					if var_19_16 + var_19_9 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_9
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501004", "story_v_out_324501.awb") ~= 0 then
					local var_19_17 = manager.audio:GetVoiceLength("story_v_out_324501", "324501004", "story_v_out_324501.awb") / 1000

					if var_19_17 + var_19_9 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_9
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_324501", "324501004", "story_v_out_324501.awb")

						arg_16_1:RecordAudio("324501004", var_19_18)
						arg_16_1:RecordAudio("324501004", var_19_18)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324501", "324501004", "story_v_out_324501.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324501", "324501004", "story_v_out_324501.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_19 = math.max(var_19_10, arg_16_1.talkMaxDuration)

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_19 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_9) / var_19_19

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_9 + var_19_19 and arg_16_1.time_ < var_19_9 + var_19_19 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324501005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324501005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324501006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10165ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10165ui_story == nil then
				arg_20_1.var_.characterEffect10165ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10165ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10165ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10165ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10165ui_story.fillRatio = var_23_5
			end

			local var_23_6
			local var_23_7 = 0

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				local var_23_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_8 then
					var_23_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_8.radialBlurScale = 0.857
					var_23_8.radialBlurGradient = 1
					var_23_8.radialBlurIntensity = 1

					if var_23_6 then
						var_23_8.radialBlurTarget = var_23_6.transform
					end
				end
			end

			local var_23_9 = 1

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_9 then
				local var_23_10 = (arg_20_1.time_ - var_23_7) / var_23_9
				local var_23_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_11 then
					var_23_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_11.radialBlurScale = Mathf.Lerp(0.857, 0, var_23_10)
					var_23_11.radialBlurGradient = Mathf.Lerp(1, 1, var_23_10)
					var_23_11.radialBlurIntensity = Mathf.Lerp(1, 1, var_23_10)
				end
			end

			if arg_20_1.time_ >= var_23_7 + var_23_9 and arg_20_1.time_ < var_23_7 + var_23_9 + arg_23_0 then
				local var_23_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_12 then
					var_23_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_12.radialBlurScale = 0
					var_23_12.radialBlurGradient = 1
					var_23_12.radialBlurIntensity = 1
				end
			end

			local var_23_13 = 0
			local var_23_14 = 1

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_15 = arg_20_1:GetWordFromCfg(324501005)
				local var_23_16 = arg_20_1:FormatText(var_23_15.content)

				arg_20_1.text_.text = var_23_16

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 40
				local var_23_18 = utf8.len(var_23_16)
				local var_23_19 = var_23_17 <= 0 and var_23_14 or var_23_14 * (var_23_18 / var_23_17)

				if var_23_19 > 0 and var_23_14 < var_23_19 then
					arg_20_1.talkMaxDuration = var_23_19

					if var_23_19 + var_23_13 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_13
					end
				end

				arg_20_1.text_.text = var_23_16
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_14, arg_20_1.talkMaxDuration)

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_13) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_13 + var_23_20 and arg_20_1.time_ < var_23_13 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324501006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324501006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324501007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.1

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(324501006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 44
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324501007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324501007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324501008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.15

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(324501007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 6
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324501008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324501008
		arg_32_1.duration_ = 2.53

		local var_32_0 = {
			zh = 2.066,
			ja = 2.533
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324501009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10165ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10165ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, -1.08, -5.83)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10165ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["10165ui_story"]
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect10165ui_story == nil then
				arg_32_1.var_.characterEffect10165ui_story = var_35_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_13 = 0.200000002980232

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 and not isNil(var_35_11) then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13

				if arg_32_1.var_.characterEffect10165ui_story and not isNil(var_35_11) then
					arg_32_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect10165ui_story then
				arg_32_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_35_17 = 0
			local var_35_18 = 0.125

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_19 = arg_32_1:FormatText(StoryNameCfg[1446].name)

				arg_32_1.leftNameTxt_.text = var_35_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_20 = arg_32_1:GetWordFromCfg(324501008)
				local var_35_21 = arg_32_1:FormatText(var_35_20.content)

				arg_32_1.text_.text = var_35_21

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_22 = 5
				local var_35_23 = utf8.len(var_35_21)
				local var_35_24 = var_35_22 <= 0 and var_35_18 or var_35_18 * (var_35_23 / var_35_22)

				if var_35_24 > 0 and var_35_18 < var_35_24 then
					arg_32_1.talkMaxDuration = var_35_24

					if var_35_24 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_17
					end
				end

				arg_32_1.text_.text = var_35_21
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501008", "story_v_out_324501.awb") ~= 0 then
					local var_35_25 = manager.audio:GetVoiceLength("story_v_out_324501", "324501008", "story_v_out_324501.awb") / 1000

					if var_35_25 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_25 + var_35_17
					end

					if var_35_20.prefab_name ~= "" and arg_32_1.actors_[var_35_20.prefab_name] ~= nil then
						local var_35_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_20.prefab_name].transform, "story_v_out_324501", "324501008", "story_v_out_324501.awb")

						arg_32_1:RecordAudio("324501008", var_35_26)
						arg_32_1:RecordAudio("324501008", var_35_26)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324501", "324501008", "story_v_out_324501.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324501", "324501008", "story_v_out_324501.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_27 = math.max(var_35_18, arg_32_1.talkMaxDuration)

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_27 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_27

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_27 and arg_32_1.time_ < var_35_17 + var_35_27 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324501009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324501009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324501010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10165ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10165ui_story == nil then
				arg_36_1.var_.characterEffect10165ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10165ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10165ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10165ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10165ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.3

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(324501009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 12
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324501010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324501010
		arg_40_1.duration_ = 4.67

		local var_40_0 = {
			zh = 4.666,
			ja = 4.533
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324501011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10165ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10165ui_story == nil then
				arg_40_1.var_.characterEffect10165ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10165ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10165ui_story then
				arg_40_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.375

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[1446].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(324501010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 15
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501010", "story_v_out_324501.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_324501", "324501010", "story_v_out_324501.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_324501", "324501010", "story_v_out_324501.awb")

						arg_40_1:RecordAudio("324501010", var_43_13)
						arg_40_1:RecordAudio("324501010", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324501", "324501010", "story_v_out_324501.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324501", "324501010", "story_v_out_324501.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324501011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324501011
		arg_44_1.duration_ = 7.83

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324501012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "ST2006"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 1.33333333333333

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.ST2006

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "ST2006" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 1.33333333333333

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_17 = 0.3

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_18 = 0

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_19 = 1.33333333333333

			if var_47_18 <= arg_44_1.time_ and arg_44_1.time_ < var_47_18 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_18) / var_47_19
				local var_47_21 = Color.New(0, 0, 0)

				var_47_21.a = Mathf.Lerp(0, 1, var_47_20)
				arg_44_1.mask_.color = var_47_21
			end

			if arg_44_1.time_ >= var_47_18 + var_47_19 and arg_44_1.time_ < var_47_18 + var_47_19 + arg_47_0 then
				local var_47_22 = Color.New(0, 0, 0)

				var_47_22.a = 1
				arg_44_1.mask_.color = var_47_22
			end

			local var_47_23 = 1.33333333333333

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_24 = 2

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24
				local var_47_26 = Color.New(0, 0, 0)

				var_47_26.a = Mathf.Lerp(1, 0, var_47_25)
				arg_44_1.mask_.color = var_47_26
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 then
				local var_47_27 = Color.New(0, 0, 0)
				local var_47_28 = 0

				arg_44_1.mask_.enabled = false
				var_47_27.a = var_47_28
				arg_44_1.mask_.color = var_47_27
			end

			local var_47_29 = arg_44_1.actors_["10165ui_story"].transform
			local var_47_30 = 1.33333333333333

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 then
				arg_44_1.var_.moveOldPos10165ui_story = var_47_29.localPosition

				local var_47_31 = GameObjectTools.GetOrAddComponent(var_47_29.gameObject, typeof(DynamicBoneHelper))

				if var_47_31 then
					var_47_31:EnableDynamicBone(false)
				end
			end

			local var_47_32 = 0.001

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_32 then
				local var_47_33 = (arg_44_1.time_ - var_47_30) / var_47_32
				local var_47_34 = Vector3.New(0, 100, 0)

				var_47_29.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10165ui_story, var_47_34, var_47_33)

				local var_47_35 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_35.x, var_47_35.y, var_47_35.z)

				local var_47_36 = var_47_29.localEulerAngles

				var_47_36.z = 0
				var_47_36.x = 0
				var_47_29.localEulerAngles = var_47_36
			end

			if arg_44_1.time_ >= var_47_30 + var_47_32 and arg_44_1.time_ < var_47_30 + var_47_32 + arg_47_0 then
				var_47_29.localPosition = Vector3.New(0, 100, 0)

				local var_47_37 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_37.x, var_47_37.y, var_47_37.z)

				local var_47_38 = var_47_29.localEulerAngles

				var_47_38.z = 0
				var_47_38.x = 0
				var_47_29.localEulerAngles = var_47_38

				local var_47_39 = GameObjectTools.GetOrAddComponent(var_47_29.gameObject, typeof(DynamicBoneHelper))

				if var_47_39 then
					var_47_39:EnableDynamicBone(true)
				end
			end

			local var_47_40 = arg_44_1.actors_["10165ui_story"]
			local var_47_41 = 1.33333333333333

			if var_47_41 < arg_44_1.time_ and arg_44_1.time_ <= var_47_41 + arg_47_0 and not isNil(var_47_40) and arg_44_1.var_.characterEffect10165ui_story == nil then
				arg_44_1.var_.characterEffect10165ui_story = var_47_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_42 = 0.200000002980232

			if var_47_41 <= arg_44_1.time_ and arg_44_1.time_ < var_47_41 + var_47_42 and not isNil(var_47_40) then
				local var_47_43 = (arg_44_1.time_ - var_47_41) / var_47_42

				if arg_44_1.var_.characterEffect10165ui_story and not isNil(var_47_40) then
					local var_47_44 = Mathf.Lerp(0, 0.5, var_47_43)

					arg_44_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10165ui_story.fillRatio = var_47_44
				end
			end

			if arg_44_1.time_ >= var_47_41 + var_47_42 and arg_44_1.time_ < var_47_41 + var_47_42 + arg_47_0 and not isNil(var_47_40) and arg_44_1.var_.characterEffect10165ui_story then
				local var_47_45 = 0.5

				arg_44_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10165ui_story.fillRatio = var_47_45
			end

			local var_47_46 = 1.3
			local var_47_47 = 1

			if var_47_46 < arg_44_1.time_ and arg_44_1.time_ <= var_47_46 + arg_47_0 then
				local var_47_48 = "play"
				local var_47_49 = "effect"

				arg_44_1:AudioAction(var_47_48, var_47_49, "se_story_150", "se_story_150_monster_far", "")
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_50 = 2.83333333333333
			local var_47_51 = 1.725

			if var_47_50 < arg_44_1.time_ and arg_44_1.time_ <= var_47_50 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_52 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_52:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_53 = arg_44_1:GetWordFromCfg(324501011)
				local var_47_54 = arg_44_1:FormatText(var_47_53.content)

				arg_44_1.text_.text = var_47_54

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_55 = 69
				local var_47_56 = utf8.len(var_47_54)
				local var_47_57 = var_47_55 <= 0 and var_47_51 or var_47_51 * (var_47_56 / var_47_55)

				if var_47_57 > 0 and var_47_51 < var_47_57 then
					arg_44_1.talkMaxDuration = var_47_57
					var_47_50 = var_47_50 + 0.3

					if var_47_57 + var_47_50 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_57 + var_47_50
					end
				end

				arg_44_1.text_.text = var_47_54
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_58 = var_47_50 + 0.3
			local var_47_59 = math.max(var_47_51, arg_44_1.talkMaxDuration)

			if var_47_58 <= arg_44_1.time_ and arg_44_1.time_ < var_47_58 + var_47_59 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_58) / var_47_59

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_58 + var_47_59 and arg_44_1.time_ < var_47_58 + var_47_59 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play324501012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324501012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324501013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.3

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(324501012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 52
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324501013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324501013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324501014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.325

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(324501013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 13
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_8 and arg_54_1.time_ < var_57_0 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324501014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324501014
		arg_58_1.duration_ = 5.03

		local var_58_0 = {
			zh = 3.6,
			ja = 5.033
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324501015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "10164ui_story"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Char/" .. "10164ui_story")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(Asset.Load("Char/" .. "10164ui_story"), arg_58_1.stage_.transform)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentInChildren(typeof(CharacterEffect))

					var_61_3.enabled = true

					local var_61_4 = GameObjectTools.GetOrAddComponent(var_61_2, typeof(DynamicBoneHelper))

					if var_61_4 then
						var_61_4:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_3.transform, false)

					arg_58_1.var_[var_61_0 .. "Animator"] = var_61_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_0 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_0 .. "LipSync"] = var_61_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_5 = arg_58_1.actors_["10164ui_story"].transform
			local var_61_6 = 0

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.var_.moveOldPos10164ui_story = var_61_5.localPosition

				local var_61_7 = GameObjectTools.GetOrAddComponent(var_61_5.gameObject, typeof(DynamicBoneHelper))

				if var_61_7 then
					var_61_7:EnableDynamicBone(false)
				end
			end

			local var_61_8 = 0.001

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_6) / var_61_8
				local var_61_10 = Vector3.New(0, -1.08, -5.83)

				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10164ui_story, var_61_10, var_61_9)

				local var_61_11 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_11.x, var_61_11.y, var_61_11.z)

				local var_61_12 = var_61_5.localEulerAngles

				var_61_12.z = 0
				var_61_12.x = 0
				var_61_5.localEulerAngles = var_61_12
			end

			if arg_58_1.time_ >= var_61_6 + var_61_8 and arg_58_1.time_ < var_61_6 + var_61_8 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_61_13 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_13.x, var_61_13.y, var_61_13.z)

				local var_61_14 = var_61_5.localEulerAngles

				var_61_14.z = 0
				var_61_14.x = 0
				var_61_5.localEulerAngles = var_61_14

				local var_61_15 = GameObjectTools.GetOrAddComponent(var_61_5.gameObject, typeof(DynamicBoneHelper))

				if var_61_15 then
					var_61_15:EnableDynamicBone(true)
				end
			end

			local var_61_16 = arg_58_1.actors_["10164ui_story"]
			local var_61_17 = 0

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 and not isNil(var_61_16) and arg_58_1.var_.characterEffect10164ui_story == nil then
				arg_58_1.var_.characterEffect10164ui_story = var_61_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_18 = 0.200000002980232

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_18 and not isNil(var_61_16) then
				local var_61_19 = (arg_58_1.time_ - var_61_17) / var_61_18

				if arg_58_1.var_.characterEffect10164ui_story and not isNil(var_61_16) then
					arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_17 + var_61_18 and arg_58_1.time_ < var_61_17 + var_61_18 + arg_61_0 and not isNil(var_61_16) and arg_58_1.var_.characterEffect10164ui_story then
				arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_61_20 = 0

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			local var_61_21 = 0

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_22 = 0
			local var_61_23 = 0.525

			if var_61_22 < arg_58_1.time_ and arg_58_1.time_ <= var_61_22 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_24 = arg_58_1:FormatText(StoryNameCfg[1462].name)

				arg_58_1.leftNameTxt_.text = var_61_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_25 = arg_58_1:GetWordFromCfg(324501014)
				local var_61_26 = arg_58_1:FormatText(var_61_25.content)

				arg_58_1.text_.text = var_61_26

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_27 = 21
				local var_61_28 = utf8.len(var_61_26)
				local var_61_29 = var_61_27 <= 0 and var_61_23 or var_61_23 * (var_61_28 / var_61_27)

				if var_61_29 > 0 and var_61_23 < var_61_29 then
					arg_58_1.talkMaxDuration = var_61_29

					if var_61_29 + var_61_22 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_29 + var_61_22
					end
				end

				arg_58_1.text_.text = var_61_26
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501014", "story_v_out_324501.awb") ~= 0 then
					local var_61_30 = manager.audio:GetVoiceLength("story_v_out_324501", "324501014", "story_v_out_324501.awb") / 1000

					if var_61_30 + var_61_22 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_30 + var_61_22
					end

					if var_61_25.prefab_name ~= "" and arg_58_1.actors_[var_61_25.prefab_name] ~= nil then
						local var_61_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_25.prefab_name].transform, "story_v_out_324501", "324501014", "story_v_out_324501.awb")

						arg_58_1:RecordAudio("324501014", var_61_31)
						arg_58_1:RecordAudio("324501014", var_61_31)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324501", "324501014", "story_v_out_324501.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324501", "324501014", "story_v_out_324501.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_32 = math.max(var_61_23, arg_58_1.talkMaxDuration)

			if var_61_22 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_32 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_22) / var_61_32

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_22 + var_61_32 and arg_58_1.time_ < var_61_22 + var_61_32 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play324501015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324501015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324501016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10164ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10164ui_story == nil then
				arg_62_1.var_.characterEffect10164ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10164ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10164ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10164ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10164ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.425

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(324501015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 17
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324501016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324501016
		arg_66_1.duration_ = 15.43

		local var_66_0 = {
			zh = 8.866,
			ja = 15.433
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324501017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10164ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10164ui_story == nil then
				arg_66_1.var_.characterEffect10164ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10164ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10164ui_story then
				arg_66_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_69_4 = 0
			local var_69_5 = 1.075

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_6 = arg_66_1:FormatText(StoryNameCfg[1462].name)

				arg_66_1.leftNameTxt_.text = var_69_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_7 = arg_66_1:GetWordFromCfg(324501016)
				local var_69_8 = arg_66_1:FormatText(var_69_7.content)

				arg_66_1.text_.text = var_69_8

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 43
				local var_69_10 = utf8.len(var_69_8)
				local var_69_11 = var_69_9 <= 0 and var_69_5 or var_69_5 * (var_69_10 / var_69_9)

				if var_69_11 > 0 and var_69_5 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_8
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501016", "story_v_out_324501.awb") ~= 0 then
					local var_69_12 = manager.audio:GetVoiceLength("story_v_out_324501", "324501016", "story_v_out_324501.awb") / 1000

					if var_69_12 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_4
					end

					if var_69_7.prefab_name ~= "" and arg_66_1.actors_[var_69_7.prefab_name] ~= nil then
						local var_69_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_7.prefab_name].transform, "story_v_out_324501", "324501016", "story_v_out_324501.awb")

						arg_66_1:RecordAudio("324501016", var_69_13)
						arg_66_1:RecordAudio("324501016", var_69_13)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324501", "324501016", "story_v_out_324501.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324501", "324501016", "story_v_out_324501.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_14 and arg_66_1.time_ < var_69_4 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play324501017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324501017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324501018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "10166ui_story"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "10166ui_story")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_70_1.stage_.transform)

					var_73_2.name = var_73_0
					var_73_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_70_1.actors_[var_73_0] = var_73_2

					local var_73_3 = var_73_2:GetComponentInChildren(typeof(CharacterEffect))

					var_73_3.enabled = true

					local var_73_4 = GameObjectTools.GetOrAddComponent(var_73_2, typeof(DynamicBoneHelper))

					if var_73_4 then
						var_73_4:EnableDynamicBone(false)
					end

					arg_70_1:ShowWeapon(var_73_3.transform, false)

					arg_70_1.var_[var_73_0 .. "Animator"] = var_73_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_70_1.var_[var_73_0 .. "Animator"].applyRootMotion = true
					arg_70_1.var_[var_73_0 .. "LipSync"] = var_73_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_73_5 = arg_70_1.actors_["10166ui_story"]
			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect10166ui_story == nil then
				arg_70_1.var_.characterEffect10166ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.200000002980232

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 and not isNil(var_73_5) then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7

				if arg_70_1.var_.characterEffect10166ui_story and not isNil(var_73_5) then
					local var_73_9 = Mathf.Lerp(0, 0.5, var_73_8)

					arg_70_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10166ui_story.fillRatio = var_73_9
				end
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect10166ui_story then
				local var_73_10 = 0.5

				arg_70_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10166ui_story.fillRatio = var_73_10
			end

			local var_73_11 = 0
			local var_73_12 = 0.05

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_13 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_14 = arg_70_1:GetWordFromCfg(324501017)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_16 = 2
				local var_73_17 = utf8.len(var_73_15)
				local var_73_18 = var_73_16 <= 0 and var_73_12 or var_73_12 * (var_73_17 / var_73_16)

				if var_73_18 > 0 and var_73_12 < var_73_18 then
					arg_70_1.talkMaxDuration = var_73_18

					if var_73_18 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_11
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_19 = math.max(var_73_12, arg_70_1.talkMaxDuration)

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_19 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_11) / var_73_19

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_11 + var_73_19 and arg_70_1.time_ < var_73_11 + var_73_19 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play324501018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324501018
		arg_74_1.duration_ = 12.33

		local var_74_0 = {
			zh = 7.866,
			ja = 12.333
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324501019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10164ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos10164ui_story = var_77_0.localPosition

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end
			end

			local var_77_3 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_3 then
				local var_77_4 = (arg_74_1.time_ - var_77_1) / var_77_3
				local var_77_5 = Vector3.New(0, -1.08, -5.83)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10164ui_story, var_77_5, var_77_4)

				local var_77_6 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_6.x, var_77_6.y, var_77_6.z)

				local var_77_7 = var_77_0.localEulerAngles

				var_77_7.z = 0
				var_77_7.x = 0
				var_77_0.localEulerAngles = var_77_7
			end

			if arg_74_1.time_ >= var_77_1 + var_77_3 and arg_74_1.time_ < var_77_1 + var_77_3 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_77_8 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_8.x, var_77_8.y, var_77_8.z)

				local var_77_9 = var_77_0.localEulerAngles

				var_77_9.z = 0
				var_77_9.x = 0
				var_77_0.localEulerAngles = var_77_9

				local var_77_10 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_10 then
					var_77_10:EnableDynamicBone(true)
				end
			end

			local var_77_11 = arg_74_1.actors_["10164ui_story"]
			local var_77_12 = 0

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect10164ui_story == nil then
				arg_74_1.var_.characterEffect10164ui_story = var_77_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_13 = 0.200000002980232

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_13 and not isNil(var_77_11) then
				local var_77_14 = (arg_74_1.time_ - var_77_12) / var_77_13

				if arg_74_1.var_.characterEffect10164ui_story and not isNil(var_77_11) then
					arg_74_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_12 + var_77_13 and arg_74_1.time_ < var_77_12 + var_77_13 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect10164ui_story then
				arg_74_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_77_15 = 0

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action483")
			end

			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_77_17 = 0
			local var_77_18 = 0.975

			if var_77_17 < arg_74_1.time_ and arg_74_1.time_ <= var_77_17 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_19 = arg_74_1:FormatText(StoryNameCfg[1462].name)

				arg_74_1.leftNameTxt_.text = var_77_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_20 = arg_74_1:GetWordFromCfg(324501018)
				local var_77_21 = arg_74_1:FormatText(var_77_20.content)

				arg_74_1.text_.text = var_77_21

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_22 = 39
				local var_77_23 = utf8.len(var_77_21)
				local var_77_24 = var_77_22 <= 0 and var_77_18 or var_77_18 * (var_77_23 / var_77_22)

				if var_77_24 > 0 and var_77_18 < var_77_24 then
					arg_74_1.talkMaxDuration = var_77_24

					if var_77_24 + var_77_17 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_24 + var_77_17
					end
				end

				arg_74_1.text_.text = var_77_21
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501018", "story_v_out_324501.awb") ~= 0 then
					local var_77_25 = manager.audio:GetVoiceLength("story_v_out_324501", "324501018", "story_v_out_324501.awb") / 1000

					if var_77_25 + var_77_17 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_25 + var_77_17
					end

					if var_77_20.prefab_name ~= "" and arg_74_1.actors_[var_77_20.prefab_name] ~= nil then
						local var_77_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_20.prefab_name].transform, "story_v_out_324501", "324501018", "story_v_out_324501.awb")

						arg_74_1:RecordAudio("324501018", var_77_26)
						arg_74_1:RecordAudio("324501018", var_77_26)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324501", "324501018", "story_v_out_324501.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324501", "324501018", "story_v_out_324501.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_27 = math.max(var_77_18, arg_74_1.talkMaxDuration)

			if var_77_17 <= arg_74_1.time_ and arg_74_1.time_ < var_77_17 + var_77_27 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_17) / var_77_27

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_17 + var_77_27 and arg_74_1.time_ < var_77_17 + var_77_27 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play324501019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324501019
		arg_78_1.duration_ = 12

		local var_78_0 = {
			zh = 5.666,
			ja = 12
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324501020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.8

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1462].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(324501019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 32
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501019", "story_v_out_324501.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_324501", "324501019", "story_v_out_324501.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_324501", "324501019", "story_v_out_324501.awb")

						arg_78_1:RecordAudio("324501019", var_81_9)
						arg_78_1:RecordAudio("324501019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324501", "324501019", "story_v_out_324501.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324501", "324501019", "story_v_out_324501.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324501020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324501020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324501021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10164ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos10164ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, 100, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10164ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 100, 0)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["10164ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10164ui_story == nil then
				arg_82_1.var_.characterEffect10164ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect10164ui_story and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10164ui_story then
				arg_82_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_85_15 = 0
			local var_85_16 = 1.375

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_17 = arg_82_1:GetWordFromCfg(324501020)
				local var_85_18 = arg_82_1:FormatText(var_85_17.content)

				arg_82_1.text_.text = var_85_18

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_19 = 55
				local var_85_20 = utf8.len(var_85_18)
				local var_85_21 = var_85_19 <= 0 and var_85_16 or var_85_16 * (var_85_20 / var_85_19)

				if var_85_21 > 0 and var_85_16 < var_85_21 then
					arg_82_1.talkMaxDuration = var_85_21

					if var_85_21 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_21 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_18
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_22 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_22

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_22 and arg_82_1.time_ < var_85_15 + var_85_22 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play324501021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324501021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324501022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.125

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_2 = arg_86_1:GetWordFromCfg(324501021)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 45
				local var_89_5 = utf8.len(var_89_3)
				local var_89_6 = var_89_4 <= 0 and var_89_1 or var_89_1 * (var_89_5 / var_89_4)

				if var_89_6 > 0 and var_89_1 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_7 and arg_86_1.time_ < var_89_0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play324501022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324501022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324501023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.2

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(324501022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 48
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324501023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324501023
		arg_94_1.duration_ = 3.37

		local var_94_0 = {
			zh = 2.1,
			ja = 3.366
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324501024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "1077ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_94_1.stage_.transform)

					var_97_2.name = var_97_0
					var_97_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_0] = var_97_2

					local var_97_3 = var_97_2:GetComponentInChildren(typeof(CharacterEffect))

					var_97_3.enabled = true

					local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_2, typeof(DynamicBoneHelper))

					if var_97_4 then
						var_97_4:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_3.transform, false)

					arg_94_1.var_[var_97_0 .. "Animator"] = var_97_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_0 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_0 .. "LipSync"] = var_97_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_5 = arg_94_1.actors_["1077ui_story"]
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.200000002980232

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 and not isNil(var_97_5) then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7

				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_97_9 = 0
			local var_97_10 = 0.225

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_11 = arg_94_1:FormatText(StoryNameCfg[1467].name)

				arg_94_1.leftNameTxt_.text = var_97_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_12 = arg_94_1:GetWordFromCfg(324501023)
				local var_97_13 = arg_94_1:FormatText(var_97_12.content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_14 = 9
				local var_97_15 = utf8.len(var_97_13)
				local var_97_16 = var_97_14 <= 0 and var_97_10 or var_97_10 * (var_97_15 / var_97_14)

				if var_97_16 > 0 and var_97_10 < var_97_16 then
					arg_94_1.talkMaxDuration = var_97_16

					if var_97_16 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_9
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501023", "story_v_out_324501.awb") ~= 0 then
					local var_97_17 = manager.audio:GetVoiceLength("story_v_out_324501", "324501023", "story_v_out_324501.awb") / 1000

					if var_97_17 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_17 + var_97_9
					end

					if var_97_12.prefab_name ~= "" and arg_94_1.actors_[var_97_12.prefab_name] ~= nil then
						local var_97_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_12.prefab_name].transform, "story_v_out_324501", "324501023", "story_v_out_324501.awb")

						arg_94_1:RecordAudio("324501023", var_97_18)
						arg_94_1:RecordAudio("324501023", var_97_18)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324501", "324501023", "story_v_out_324501.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324501", "324501023", "story_v_out_324501.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_19 = math.max(var_97_10, arg_94_1.talkMaxDuration)

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_19 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_9) / var_97_19

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_9 + var_97_19 and arg_94_1.time_ < var_97_9 + var_97_19 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324501024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324501024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324501025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1077ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1077ui_story == nil then
				arg_98_1.var_.characterEffect1077ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1077ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1077ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1077ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1077ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.85

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(324501024)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 34
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_7 or var_101_7 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_7 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_13 and arg_98_1.time_ < var_101_6 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324501025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324501025
		arg_102_1.duration_ = 2.47

		local var_102_0 = {
			zh = 1.566,
			ja = 2.466
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324501026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1077ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1077ui_story == nil then
				arg_102_1.var_.characterEffect1077ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1077ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1077ui_story then
				arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_105_4 = 0
			local var_105_5 = 0.2

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_6 = arg_102_1:FormatText(StoryNameCfg[1467].name)

				arg_102_1.leftNameTxt_.text = var_105_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_7 = arg_102_1:GetWordFromCfg(324501025)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 8
				local var_105_10 = utf8.len(var_105_8)
				local var_105_11 = var_105_9 <= 0 and var_105_5 or var_105_5 * (var_105_10 / var_105_9)

				if var_105_11 > 0 and var_105_5 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501025", "story_v_out_324501.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_324501", "324501025", "story_v_out_324501.awb") / 1000

					if var_105_12 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_4
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_324501", "324501025", "story_v_out_324501.awb")

						arg_102_1:RecordAudio("324501025", var_105_13)
						arg_102_1:RecordAudio("324501025", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324501", "324501025", "story_v_out_324501.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324501", "324501025", "story_v_out_324501.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_14 and arg_102_1.time_ < var_105_4 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play324501026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324501026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324501027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1077ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1077ui_story == nil then
				arg_106_1.var_.characterEffect1077ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1077ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1077ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1077ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1077ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.375

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(324501026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 15
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324501027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324501027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324501028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1.2

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(324501027)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 48
				local var_113_5 = utf8.len(var_113_3)
				local var_113_6 = var_113_4 <= 0 and var_113_1 or var_113_1 * (var_113_5 / var_113_4)

				if var_113_6 > 0 and var_113_1 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_7 and arg_110_1.time_ < var_113_0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324501028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324501028
		arg_114_1.duration_ = 2.33

		local var_114_0 = {
			zh = 2.2,
			ja = 2.333
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
			arg_114_1.auto_ = false
		end

		function arg_114_1.playNext_(arg_116_0)
			arg_114_1.onStoryFinished_()
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1077ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1077ui_story == nil then
				arg_114_1.var_.characterEffect1077ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1077ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1077ui_story then
				arg_114_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_117_4 = 0
			local var_117_5 = 0.275

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_6 = arg_114_1:FormatText(StoryNameCfg[1467].name)

				arg_114_1.leftNameTxt_.text = var_117_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_7 = arg_114_1:GetWordFromCfg(324501028)
				local var_117_8 = arg_114_1:FormatText(var_117_7.content)

				arg_114_1.text_.text = var_117_8

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 11
				local var_117_10 = utf8.len(var_117_8)
				local var_117_11 = var_117_9 <= 0 and var_117_5 or var_117_5 * (var_117_10 / var_117_9)

				if var_117_11 > 0 and var_117_5 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_8
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324501", "324501028", "story_v_out_324501.awb") ~= 0 then
					local var_117_12 = manager.audio:GetVoiceLength("story_v_out_324501", "324501028", "story_v_out_324501.awb") / 1000

					if var_117_12 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_4
					end

					if var_117_7.prefab_name ~= "" and arg_114_1.actors_[var_117_7.prefab_name] ~= nil then
						local var_117_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_7.prefab_name].transform, "story_v_out_324501", "324501028", "story_v_out_324501.awb")

						arg_114_1:RecordAudio("324501028", var_117_13)
						arg_114_1:RecordAudio("324501028", var_117_13)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_324501", "324501028", "story_v_out_324501.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_324501", "324501028", "story_v_out_324501.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_14 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_14 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_14

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_14 and arg_114_1.time_ < var_117_4 + var_117_14 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/ST2006"
	},
	voices = {
		"story_v_out_324501.awb"
	}
}
