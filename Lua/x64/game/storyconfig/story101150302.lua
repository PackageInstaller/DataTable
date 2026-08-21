return {
	Play115032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115032001
		arg_1_1.duration_ = 7.6

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "RO0104"

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
				local var_4_5 = arg_1_1.bgs_.RO0104

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
					if iter_4_0 ~= "RO0104" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = manager.ui.mainCamera.transform
			local var_4_23 = 1.999999999999

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_22.localPosition
			end

			local var_4_24 = 0.6

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / 0.066
				local var_4_26, var_4_27 = math.modf(var_4_25)

				var_4_22.localPosition = Vector3.New(var_4_27 * 0.13, var_4_27 * 0.13, var_4_27 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				var_4_22.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_28 = 1.999999999999

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_29 = 0.6

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_30 = arg_1_1.bgs_.RO0104.transform
			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_30.localPosition
			end

			local var_4_32 = 0.001

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Vector3.New(0, 1, 9.5)

				var_4_30.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				var_4_30.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_35 = arg_1_1.bgs_.RO0104.transform
			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_35.localPosition
			end

			local var_4_37 = 0.001

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37
				local var_4_39 = Vector3.New(0, 1, 10)

				var_4_35.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, var_4_39, var_4_38)
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				var_4_35.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_41 = 2.299998

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_42 = arg_1_1.bgs_.RO0104.transform
			local var_4_43 = 0

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_42.localPosition
			end

			local var_4_44 = 3

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_43) / var_4_44
				local var_4_46 = Vector3.New(0, 1, 9.5)

				var_4_42.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, var_4_46, var_4_45)
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				var_4_42.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_47 = 0
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 1.23333333333333
			local var_4_54 = 2.33333333333333

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2.599999999999
			local var_4_60 = 0.625

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(115032001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 25
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_60 or var_4_60 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_60 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_59 = var_4_59 + 0.3

					if var_4_66 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_59 + 0.3
			local var_4_68 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115032002
		arg_9_1.duration_ = 4.63

		local var_9_0 = {
			ja = 2.7,
			ko = 4.633,
			zh = 2.4,
			en = 2.9
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.3

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[265].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(115032002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 12
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032002", "story_v_out_115032.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_115032", "115032002", "story_v_out_115032.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_115032", "115032002", "story_v_out_115032.awb")

						arg_9_1:RecordAudio("115032002", var_12_9)
						arg_9_1:RecordAudio("115032002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115032", "115032002", "story_v_out_115032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115032", "115032002", "story_v_out_115032.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play115032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115032003
		arg_13_1.duration_ = 5.47

		local var_13_0 = {
			ja = 5.466,
			ko = 4.3,
			zh = 4.366,
			en = 3.733
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
				arg_13_0:Play115032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.425

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[264].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(115032003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 17
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032003", "story_v_out_115032.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_115032", "115032003", "story_v_out_115032.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_115032", "115032003", "story_v_out_115032.awb")

						arg_13_1:RecordAudio("115032003", var_16_9)
						arg_13_1:RecordAudio("115032003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115032", "115032003", "story_v_out_115032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115032", "115032003", "story_v_out_115032.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115032004
		arg_17_1.duration_ = 6.87

		local var_17_0 = {
			ja = 6.866,
			ko = 5.799999999999,
			zh = 6.3,
			en = 5.799999999999
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "G03a"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 2

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.G03a

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "G03a" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_17 = 2

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Color.New(0, 0, 0)

				var_20_19.a = Mathf.Lerp(0, 1, var_20_18)
				arg_17_1.mask_.color = var_20_19
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				local var_20_20 = Color.New(0, 0, 0)

				var_20_20.a = 1
				arg_17_1.mask_.color = var_20_20
			end

			local var_20_21 = 2

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_22 = 2

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Color.New(0, 0, 0)

				var_20_24.a = Mathf.Lerp(1, 0, var_20_23)
				arg_17_1.mask_.color = var_20_24
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				local var_20_25 = Color.New(0, 0, 0)
				local var_20_26 = 0

				arg_17_1.mask_.enabled = false
				var_20_25.a = var_20_26
				arg_17_1.mask_.color = var_20_25
			end

			local var_20_27 = "1024ui_story"

			if arg_17_1.actors_[var_20_27] == nil then
				local var_20_28 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_20_28) then
					local var_20_29 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_17_1.stage_.transform)

					var_20_29.name = var_20_27
					var_20_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_27] = var_20_29

					local var_20_30 = var_20_29:GetComponentInChildren(typeof(CharacterEffect))

					var_20_30.enabled = true

					local var_20_31 = GameObjectTools.GetOrAddComponent(var_20_29, typeof(DynamicBoneHelper))

					if var_20_31 then
						var_20_31:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_30.transform, false)

					arg_17_1.var_[var_20_27 .. "Animator"] = var_20_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_27 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_27 .. "LipSync"] = var_20_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_32 = arg_17_1.actors_["1024ui_story"].transform
			local var_20_33 = 3.8

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1.var_.moveOldPos1024ui_story = var_20_32.localPosition
			end

			local var_20_34 = 0.001

			if var_20_33 <= arg_17_1.time_ and arg_17_1.time_ < var_20_33 + var_20_34 then
				local var_20_35 = (arg_17_1.time_ - var_20_33) / var_20_34
				local var_20_36 = Vector3.New(-0.7, -1, -6.05)

				var_20_32.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1024ui_story, var_20_36, var_20_35)

				local var_20_37 = manager.ui.mainCamera.transform.position - var_20_32.position

				var_20_32.forward = Vector3.New(var_20_37.x, var_20_37.y, var_20_37.z)

				local var_20_38 = var_20_32.localEulerAngles

				var_20_38.z = 0
				var_20_38.x = 0
				var_20_32.localEulerAngles = var_20_38
			end

			if arg_17_1.time_ >= var_20_33 + var_20_34 and arg_17_1.time_ < var_20_33 + var_20_34 + arg_20_0 then
				var_20_32.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_20_39 = manager.ui.mainCamera.transform.position - var_20_32.position

				var_20_32.forward = Vector3.New(var_20_39.x, var_20_39.y, var_20_39.z)

				local var_20_40 = var_20_32.localEulerAngles

				var_20_40.z = 0
				var_20_40.x = 0
				var_20_32.localEulerAngles = var_20_40
			end

			local var_20_41 = 3.8

			if var_20_41 < arg_17_1.time_ and arg_17_1.time_ <= var_20_41 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_20_42 = 3.8

			if var_20_42 < arg_17_1.time_ and arg_17_1.time_ <= var_20_42 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_43 = arg_17_1.actors_["1024ui_story"]
			local var_20_44 = 3.8

			if var_20_44 < arg_17_1.time_ and arg_17_1.time_ <= var_20_44 + arg_20_0 and not isNil(var_20_43) and arg_17_1.var_.characterEffect1024ui_story == nil then
				arg_17_1.var_.characterEffect1024ui_story = var_20_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_45 = 0.2

			if var_20_44 <= arg_17_1.time_ and arg_17_1.time_ < var_20_44 + var_20_45 and not isNil(var_20_43) then
				local var_20_46 = (arg_17_1.time_ - var_20_44) / var_20_45

				if arg_17_1.var_.characterEffect1024ui_story and not isNil(var_20_43) then
					arg_17_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_44 + var_20_45 and arg_17_1.time_ < var_20_44 + var_20_45 + arg_20_0 and not isNil(var_20_43) and arg_17_1.var_.characterEffect1024ui_story then
				arg_17_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_47 = 4
			local var_20_48 = 0.25

			if var_20_47 < arg_17_1.time_ and arg_17_1.time_ <= var_20_47 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_49 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_49:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_50 = arg_17_1:FormatText(StoryNameCfg[265].name)

				arg_17_1.leftNameTxt_.text = var_20_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_51 = arg_17_1:GetWordFromCfg(115032004)
				local var_20_52 = arg_17_1:FormatText(var_20_51.content)

				arg_17_1.text_.text = var_20_52

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_53 = 10
				local var_20_54 = utf8.len(var_20_52)
				local var_20_55 = var_20_53 <= 0 and var_20_48 or var_20_48 * (var_20_54 / var_20_53)

				if var_20_55 > 0 and var_20_48 < var_20_55 then
					arg_17_1.talkMaxDuration = var_20_55
					var_20_47 = var_20_47 + 0.3

					if var_20_55 + var_20_47 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_55 + var_20_47
					end
				end

				arg_17_1.text_.text = var_20_52
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032004", "story_v_out_115032.awb") ~= 0 then
					local var_20_56 = manager.audio:GetVoiceLength("story_v_out_115032", "115032004", "story_v_out_115032.awb") / 1000

					if var_20_56 + var_20_47 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_56 + var_20_47
					end

					if var_20_51.prefab_name ~= "" and arg_17_1.actors_[var_20_51.prefab_name] ~= nil then
						local var_20_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_51.prefab_name].transform, "story_v_out_115032", "115032004", "story_v_out_115032.awb")

						arg_17_1:RecordAudio("115032004", var_20_57)
						arg_17_1:RecordAudio("115032004", var_20_57)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115032", "115032004", "story_v_out_115032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115032", "115032004", "story_v_out_115032.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_58 = var_20_47 + 0.3
			local var_20_59 = math.max(var_20_48, arg_17_1.talkMaxDuration)

			if var_20_58 <= arg_17_1.time_ and arg_17_1.time_ < var_20_58 + var_20_59 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_58) / var_20_59

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_58 + var_20_59 and arg_17_1.time_ < var_20_58 + var_20_59 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play115032005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115032005
		arg_23_1.duration_ = 2.97

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play115032006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1024ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1024ui_story == nil then
				arg_23_1.var_.characterEffect1024ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1024ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1024ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1024ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1024ui_story.fillRatio = var_26_5
			end

			local var_26_6 = "10014ui_story"

			if arg_23_1.actors_[var_26_6] == nil then
				local var_26_7 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_26_7) then
					local var_26_8 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_23_1.stage_.transform)

					var_26_8.name = var_26_6
					var_26_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_6] = var_26_8

					local var_26_9 = var_26_8:GetComponentInChildren(typeof(CharacterEffect))

					var_26_9.enabled = true

					local var_26_10 = GameObjectTools.GetOrAddComponent(var_26_8, typeof(DynamicBoneHelper))

					if var_26_10 then
						var_26_10:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_9.transform, false)

					arg_23_1.var_[var_26_6 .. "Animator"] = var_26_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_6 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_6 .. "LipSync"] = var_26_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_11 = arg_23_1.actors_["10014ui_story"].transform
			local var_26_12 = 0

			if var_26_12 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.var_.moveOldPos10014ui_story = var_26_11.localPosition
			end

			local var_26_13 = 0.001

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_13 then
				local var_26_14 = (arg_23_1.time_ - var_26_12) / var_26_13
				local var_26_15 = Vector3.New(0.7, -1.06, -6.2)

				var_26_11.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10014ui_story, var_26_15, var_26_14)

				local var_26_16 = manager.ui.mainCamera.transform.position - var_26_11.position

				var_26_11.forward = Vector3.New(var_26_16.x, var_26_16.y, var_26_16.z)

				local var_26_17 = var_26_11.localEulerAngles

				var_26_17.z = 0
				var_26_17.x = 0
				var_26_11.localEulerAngles = var_26_17
			end

			if arg_23_1.time_ >= var_26_12 + var_26_13 and arg_23_1.time_ < var_26_12 + var_26_13 + arg_26_0 then
				var_26_11.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_26_18 = manager.ui.mainCamera.transform.position - var_26_11.position

				var_26_11.forward = Vector3.New(var_26_18.x, var_26_18.y, var_26_18.z)

				local var_26_19 = var_26_11.localEulerAngles

				var_26_19.z = 0
				var_26_19.x = 0
				var_26_11.localEulerAngles = var_26_19
			end

			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_26_21 = arg_23_1.actors_["10014ui_story"]
			local var_26_22 = 0

			if var_26_22 < arg_23_1.time_ and arg_23_1.time_ <= var_26_22 + arg_26_0 then
				if arg_23_1.var_.characterEffect10014ui_story == nil then
					arg_23_1.var_.characterEffect10014ui_story = var_26_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_26_23 = arg_23_1.var_.characterEffect10014ui_story

				var_26_23.imageEffect:turnOff()

				var_26_23.interferenceEffect.enabled = true
				var_26_23.interferenceEffect.noise = 0.001
				var_26_23.interferenceEffect.simTimeScale = 1
				var_26_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_26_24 = arg_23_1.actors_["10014ui_story"]
			local var_26_25 = 0
			local var_26_26 = 0.1

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 then
				if arg_23_1.var_.characterEffect10014ui_story == nil then
					arg_23_1.var_.characterEffect10014ui_story = var_26_24:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_23_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_26_27 = 0

			if var_26_27 < arg_23_1.time_ and arg_23_1.time_ <= var_26_27 + arg_26_0 then
				arg_23_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_26_28 = 0
			local var_26_29 = 0.125

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_30 = arg_23_1:FormatText(StoryNameCfg[264].name)

				arg_23_1.leftNameTxt_.text = var_26_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_31 = arg_23_1:GetWordFromCfg(115032005)
				local var_26_32 = arg_23_1:FormatText(var_26_31.content)

				arg_23_1.text_.text = var_26_32

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_33 = 5
				local var_26_34 = utf8.len(var_26_32)
				local var_26_35 = var_26_33 <= 0 and var_26_29 or var_26_29 * (var_26_34 / var_26_33)

				if var_26_35 > 0 and var_26_29 < var_26_35 then
					arg_23_1.talkMaxDuration = var_26_35

					if var_26_35 + var_26_28 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_35 + var_26_28
					end
				end

				arg_23_1.text_.text = var_26_32
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032005", "story_v_out_115032.awb") ~= 0 then
					local var_26_36 = manager.audio:GetVoiceLength("story_v_out_115032", "115032005", "story_v_out_115032.awb") / 1000

					if var_26_36 + var_26_28 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_36 + var_26_28
					end

					if var_26_31.prefab_name ~= "" and arg_23_1.actors_[var_26_31.prefab_name] ~= nil then
						local var_26_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_31.prefab_name].transform, "story_v_out_115032", "115032005", "story_v_out_115032.awb")

						arg_23_1:RecordAudio("115032005", var_26_37)
						arg_23_1:RecordAudio("115032005", var_26_37)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115032", "115032005", "story_v_out_115032.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115032", "115032005", "story_v_out_115032.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_38 = math.max(var_26_29, arg_23_1.talkMaxDuration)

			if var_26_28 <= arg_23_1.time_ and arg_23_1.time_ < var_26_28 + var_26_38 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_28) / var_26_38

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_28 + var_26_38 and arg_23_1.time_ < var_26_28 + var_26_38 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play115032006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115032006
		arg_27_1.duration_ = 4.73

		local var_27_0 = {
			ja = 4.733,
			ko = 3.966,
			zh = 3.266,
			en = 2.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115032007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1024ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1024ui_story == nil then
				arg_27_1.var_.characterEffect1024ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1024ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1024ui_story then
				arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_30_4 = 0

			if var_30_4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_30_5 = 0
			local var_30_6 = 0.375

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_7 = arg_27_1:FormatText(StoryNameCfg[265].name)

				arg_27_1.leftNameTxt_.text = var_30_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(115032006)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 15
				local var_30_11 = utf8.len(var_30_9)
				local var_30_12 = var_30_10 <= 0 and var_30_6 or var_30_6 * (var_30_11 / var_30_10)

				if var_30_12 > 0 and var_30_6 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032006", "story_v_out_115032.awb") ~= 0 then
					local var_30_13 = manager.audio:GetVoiceLength("story_v_out_115032", "115032006", "story_v_out_115032.awb") / 1000

					if var_30_13 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_5
					end

					if var_30_8.prefab_name ~= "" and arg_27_1.actors_[var_30_8.prefab_name] ~= nil then
						local var_30_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_8.prefab_name].transform, "story_v_out_115032", "115032006", "story_v_out_115032.awb")

						arg_27_1:RecordAudio("115032006", var_30_14)
						arg_27_1:RecordAudio("115032006", var_30_14)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_115032", "115032006", "story_v_out_115032.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_115032", "115032006", "story_v_out_115032.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_15 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_15 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_15

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_15 and arg_27_1.time_ < var_30_5 + var_30_15 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115032007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115032007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115032008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10014ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10014ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10014ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1024ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos1024ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0, 100, 0)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1024ui_story, var_34_13, var_34_12)

				local var_34_14 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_14.x, var_34_14.y, var_34_14.z)

				local var_34_15 = var_34_9.localEulerAngles

				var_34_15.z = 0
				var_34_15.x = 0
				var_34_9.localEulerAngles = var_34_15
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				var_34_9.localPosition = Vector3.New(0, 100, 0)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_9.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_9.localEulerAngles = var_34_17
			end

			local var_34_18 = 0
			local var_34_19 = 0.8

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_20 = arg_31_1:GetWordFromCfg(115032007)
				local var_34_21 = arg_31_1:FormatText(var_34_20.content)

				arg_31_1.text_.text = var_34_21

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_22 = 32
				local var_34_23 = utf8.len(var_34_21)
				local var_34_24 = var_34_22 <= 0 and var_34_19 or var_34_19 * (var_34_23 / var_34_22)

				if var_34_24 > 0 and var_34_19 < var_34_24 then
					arg_31_1.talkMaxDuration = var_34_24

					if var_34_24 + var_34_18 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_24 + var_34_18
					end
				end

				arg_31_1.text_.text = var_34_21
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_25 = math.max(var_34_19, arg_31_1.talkMaxDuration)

			if var_34_18 <= arg_31_1.time_ and arg_31_1.time_ < var_34_18 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_18) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_18 + var_34_25 and arg_31_1.time_ < var_34_18 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play115032008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115032008
		arg_35_1.duration_ = 5.7

		local var_35_0 = {
			ja = 4.066,
			ko = 4.333,
			zh = 5.3,
			en = 5.7
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
				arg_35_0:Play115032009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_38_2 = arg_35_1.actors_["10014ui_story"].transform
			local var_38_3 = 0

			if var_38_3 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.var_.moveOldPos10014ui_story = var_38_2.localPosition
			end

			local var_38_4 = 0.001

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_3) / var_38_4
				local var_38_6 = Vector3.New(0, -1.06, -6.2)

				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10014ui_story, var_38_6, var_38_5)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_2.position

				var_38_2.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_2.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_2.localEulerAngles = var_38_8
			end

			if arg_35_1.time_ >= var_38_3 + var_38_4 and arg_35_1.time_ < var_38_3 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_38_9 = manager.ui.mainCamera.transform.position - var_38_2.position

				var_38_2.forward = Vector3.New(var_38_9.x, var_38_9.y, var_38_9.z)

				local var_38_10 = var_38_2.localEulerAngles

				var_38_10.z = 0
				var_38_10.x = 0
				var_38_2.localEulerAngles = var_38_10
			end

			local var_38_11 = 0
			local var_38_12 = 0.425

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_13 = arg_35_1:FormatText(StoryNameCfg[264].name)

				arg_35_1.leftNameTxt_.text = var_38_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:GetWordFromCfg(115032008)
				local var_38_15 = arg_35_1:FormatText(var_38_14.content)

				arg_35_1.text_.text = var_38_15

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 17
				local var_38_17 = utf8.len(var_38_15)
				local var_38_18 = var_38_16 <= 0 and var_38_12 or var_38_12 * (var_38_17 / var_38_16)

				if var_38_18 > 0 and var_38_12 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18

					if var_38_18 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_15
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032008", "story_v_out_115032.awb") ~= 0 then
					local var_38_19 = manager.audio:GetVoiceLength("story_v_out_115032", "115032008", "story_v_out_115032.awb") / 1000

					if var_38_19 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_19 + var_38_11
					end

					if var_38_14.prefab_name ~= "" and arg_35_1.actors_[var_38_14.prefab_name] ~= nil then
						local var_38_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_14.prefab_name].transform, "story_v_out_115032", "115032008", "story_v_out_115032.awb")

						arg_35_1:RecordAudio("115032008", var_38_20)
						arg_35_1:RecordAudio("115032008", var_38_20)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115032", "115032008", "story_v_out_115032.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115032", "115032008", "story_v_out_115032.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_21 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_21

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_21 and arg_35_1.time_ < var_38_11 + var_38_21 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play115032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115032009
		arg_39_1.duration_ = 2.8

		local var_39_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.8,
			en = 0.999999999999
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.05

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[265].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(115032009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 2
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032009", "story_v_out_115032.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_115032", "115032009", "story_v_out_115032.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_115032", "115032009", "story_v_out_115032.awb")

						arg_39_1:RecordAudio("115032009", var_42_9)
						arg_39_1:RecordAudio("115032009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115032", "115032009", "story_v_out_115032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115032", "115032009", "story_v_out_115032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115032010
		arg_43_1.duration_ = 3.73

		local var_43_0 = {
			ja = 3.566,
			ko = 3.166,
			zh = 3.733,
			en = 3.5
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1024ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1024ui_story == nil then
				arg_43_1.var_.characterEffect1024ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1024ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1024ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1024ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1024ui_story.fillRatio = var_46_5
			end

			local var_46_6 = 0

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_46_7 = 0
			local var_46_8 = 0.4

			if var_46_7 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_9 = arg_43_1:FormatText(StoryNameCfg[264].name)

				arg_43_1.leftNameTxt_.text = var_46_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(115032010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_12 = 16
				local var_46_13 = utf8.len(var_46_11)
				local var_46_14 = var_46_12 <= 0 and var_46_8 or var_46_8 * (var_46_13 / var_46_12)

				if var_46_14 > 0 and var_46_8 < var_46_14 then
					arg_43_1.talkMaxDuration = var_46_14

					if var_46_14 + var_46_7 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_7
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032010", "story_v_out_115032.awb") ~= 0 then
					local var_46_15 = manager.audio:GetVoiceLength("story_v_out_115032", "115032010", "story_v_out_115032.awb") / 1000

					if var_46_15 + var_46_7 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_7
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_115032", "115032010", "story_v_out_115032.awb")

						arg_43_1:RecordAudio("115032010", var_46_16)
						arg_43_1:RecordAudio("115032010", var_46_16)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_115032", "115032010", "story_v_out_115032.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_115032", "115032010", "story_v_out_115032.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_17 = math.max(var_46_8, arg_43_1.talkMaxDuration)

			if var_46_7 <= arg_43_1.time_ and arg_43_1.time_ < var_46_7 + var_46_17 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_7) / var_46_17

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_7 + var_46_17 and arg_43_1.time_ < var_46_7 + var_46_17 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115032011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
			arg_47_1.auto_ = false
		end

		function arg_47_1.playNext_(arg_49_0)
			arg_47_1.onStoryFinished_()
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10014ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10014ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10014ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0
			local var_50_10 = 0.575

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_11 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_11:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_12 = arg_47_1:GetWordFromCfg(115032011)
				local var_50_13 = arg_47_1:FormatText(var_50_12.content)

				arg_47_1.text_.text = var_50_13

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_14 = 23
				local var_50_15 = utf8.len(var_50_13)
				local var_50_16 = var_50_14 <= 0 and var_50_10 or var_50_10 * (var_50_15 / var_50_14)

				if var_50_16 > 0 and var_50_10 < var_50_16 then
					arg_47_1.talkMaxDuration = var_50_16
					var_50_9 = var_50_9 + 0.3

					if var_50_16 + var_50_9 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_16 + var_50_9
					end
				end

				arg_47_1.text_.text = var_50_13
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_17 = var_50_9 + 0.3
			local var_50_18 = math.max(var_50_10, arg_47_1.talkMaxDuration)

			if var_50_17 <= arg_47_1.time_ and arg_47_1.time_ < var_50_17 + var_50_18 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_17) / var_50_18

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_17 + var_50_18 and arg_47_1.time_ < var_50_17 + var_50_18 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/RO0104",
		"TextureConfig/Background/G03a"
	},
	voices = {
		"story_v_out_115032.awb"
	}
}
