return {
	Play105031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105031001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			ja = 4.3,
			ko = 4.333,
			zh = 4.8,
			en = 4.7
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play105031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "S0506a"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.S0506a
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueS0506a = var_4_14.color.a
					arg_1_1.var_.alphaMatValueS0506a = var_4_14
				end

				arg_1_1.var_.alphaOldValueS0506a = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0506a, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueS0506a then
					local var_4_18 = arg_1_1.var_.alphaMatValueS0506a.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueS0506a.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueS0506a then
				local var_4_19 = arg_1_1.var_.alphaMatValueS0506a
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.S0506a

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0506a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = manager.ui.mainCamera.transform
			local var_4_36 = 1.4

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_35.localPosition
			end

			local var_4_37 = 0.6

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / 0.066
				local var_4_39, var_4_40 = math.modf(var_4_38)

				var_4_35.localPosition = Vector3.New(var_4_40 * 0.13, var_4_40 * 0.13, var_4_40 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				var_4_35.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_42 = 2

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_43 = 2
			local var_4_44 = 0.25

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_45 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_45:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_46 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_47 = arg_1_1:GetWordFromCfg(105031001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 10
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_44 or var_4_44 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_44 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_43 = var_4_43 + 0.3

					if var_4_51 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_43
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031001", "story_v_out_105031.awb") ~= 0 then
					local var_4_52 = manager.audio:GetVoiceLength("story_v_out_105031", "105031001", "story_v_out_105031.awb") / 1000

					if var_4_52 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_52 + var_4_43
					end

					if var_4_47.prefab_name ~= "" and arg_1_1.actors_[var_4_47.prefab_name] ~= nil then
						local var_4_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_47.prefab_name].transform, "story_v_out_105031", "105031001", "story_v_out_105031.awb")

						arg_1_1:RecordAudio("105031001", var_4_53)
						arg_1_1:RecordAudio("105031001", var_4_53)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105031", "105031001", "story_v_out_105031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105031", "105031001", "story_v_out_105031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_54 = var_4_43 + 0.3
			local var_4_55 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_55

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105031002
		arg_8_1.duration_ = 6.5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play105031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = manager.ui.mainCamera.transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_0.localPosition
			end

			local var_11_2 = 0.600000023841858

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / 0.066
				local var_11_4, var_11_5 = math.modf(var_11_3)

				var_11_0.localPosition = Vector3.New(var_11_5 * 0.13, var_11_5 * 0.13, var_11_5 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				var_11_0.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_7 = 1.5

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Color.New(1, 1, 1)

				var_11_9.a = Mathf.Lerp(0, 1, var_11_8)
				arg_8_1.mask_.color = var_11_9
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				local var_11_10 = Color.New(1, 1, 1)

				var_11_10.a = 1
				arg_8_1.mask_.color = var_11_10
			end

			local var_11_11 = 1.5

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = false

				arg_8_1:SetGaussion(false)
			end

			local var_11_12 = 1.5

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_12 then
				local var_11_13 = (arg_8_1.time_ - var_11_11) / var_11_12
				local var_11_14 = Color.New(1, 1, 1)

				var_11_14.a = Mathf.Lerp(1, 0, var_11_13)
				arg_8_1.mask_.color = var_11_14
			end

			if arg_8_1.time_ >= var_11_11 + var_11_12 and arg_8_1.time_ < var_11_11 + var_11_12 + arg_11_0 then
				local var_11_15 = Color.New(1, 1, 1)
				local var_11_16 = 0

				arg_8_1.mask_.enabled = false
				var_11_15.a = var_11_16
				arg_8_1.mask_.color = var_11_15
			end

			local var_11_17 = "STwhite"

			if arg_8_1.bgs_[var_11_17] == nil then
				local var_11_18 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_17)
				var_11_18.name = var_11_17
				var_11_18.transform.parent = arg_8_1.stage_.transform
				var_11_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_17] = var_11_18
			end

			local var_11_19 = arg_8_1.bgs_.STwhite.transform
			local var_11_20 = 1.5

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.var_.moveOldPosSTwhite = var_11_19.localPosition
				var_11_19.localScale = Vector3.New(12, 12, 12)
			end

			local var_11_21 = 0.001

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_21 then
				local var_11_22 = (arg_8_1.time_ - var_11_20) / var_11_21
				local var_11_23 = Vector3.New(0, 0, 0)

				var_11_19.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPosSTwhite, var_11_23, var_11_22)
			end

			if arg_8_1.time_ >= var_11_20 + var_11_21 and arg_8_1.time_ < var_11_20 + var_11_21 + arg_11_0 then
				var_11_19.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_24 = 1.5
			local var_11_25 = 0.15

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_26 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_26:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_27 = arg_8_1:GetWordFromCfg(105031002)
				local var_11_28 = arg_8_1:FormatText(var_11_27.content)

				arg_8_1.text_.text = var_11_28

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_29 = 6
				local var_11_30 = utf8.len(var_11_28)
				local var_11_31 = var_11_29 <= 0 and var_11_25 or var_11_25 * (var_11_30 / var_11_29)

				if var_11_31 > 0 and var_11_25 < var_11_31 then
					arg_8_1.talkMaxDuration = var_11_31
					var_11_24 = var_11_24 + 0.3

					if var_11_31 + var_11_24 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_31 + var_11_24
					end
				end

				arg_8_1.text_.text = var_11_28
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_32 = var_11_24 + 0.3
			local var_11_33 = math.max(var_11_25, arg_8_1.talkMaxDuration)

			if var_11_32 <= arg_8_1.time_ and arg_8_1.time_ < var_11_32 + var_11_33 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_32) / var_11_33

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_32 + var_11_33 and arg_8_1.time_ < var_11_32 + var_11_33 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play105031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 105031003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play105031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = manager.ui.mainCamera.transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.shakeOldPosMainCamera = var_17_0.localPosition
			end

			local var_17_2 = 0.600000023841858

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / 0.066
				local var_17_4, var_17_5 = math.modf(var_17_3)

				var_17_0.localPosition = Vector3.New(var_17_5 * 0.13, var_17_5 * 0.13, var_17_5 * 0.13) + arg_14_1.var_.shakeOldPosMainCamera
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = arg_14_1.var_.shakeOldPosMainCamera
			end

			local var_17_6 = 0
			local var_17_7 = 0.3

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_8 = arg_14_1:GetWordFromCfg(105031003)
				local var_17_9 = arg_14_1:FormatText(var_17_8.content)

				arg_14_1.text_.text = var_17_9

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_10 = 12
				local var_17_11 = utf8.len(var_17_9)
				local var_17_12 = var_17_10 <= 0 and var_17_7 or var_17_7 * (var_17_11 / var_17_10)

				if var_17_12 > 0 and var_17_7 < var_17_12 then
					arg_14_1.talkMaxDuration = var_17_12

					if var_17_12 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_12 + var_17_6
					end
				end

				arg_14_1.text_.text = var_17_9
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_13 = math.max(var_17_7, arg_14_1.talkMaxDuration)

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_13 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_6) / var_17_13

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_6 + var_17_13 and arg_14_1.time_ < var_17_6 + var_17_13 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play105031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 105031004
		arg_18_1.duration_ = 8.2

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play105031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				local var_21_2 = "play"
				local var_21_3 = "effect"

				arg_18_1:AudioAction(var_21_2, var_21_3, "se_story_5", "se_story_5_horseattack", "")
			end

			local var_21_4 = 0

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_5 = 1.5

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_5 then
				local var_21_6 = (arg_18_1.time_ - var_21_4) / var_21_5
				local var_21_7 = Color.New(1, 1, 1)

				var_21_7.a = Mathf.Lerp(1, 0, var_21_6)
				arg_18_1.mask_.color = var_21_7
			end

			if arg_18_1.time_ >= var_21_4 + var_21_5 and arg_18_1.time_ < var_21_4 + var_21_5 + arg_21_0 then
				local var_21_8 = Color.New(1, 1, 1)
				local var_21_9 = 0

				arg_18_1.mask_.enabled = false
				var_21_8.a = var_21_9
				arg_18_1.mask_.color = var_21_8
			end

			local var_21_10 = "S0506"

			if arg_18_1.bgs_[var_21_10] == nil then
				local var_21_11 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_10)
				var_21_11.name = var_21_10
				var_21_11.transform.parent = arg_18_1.stage_.transform
				var_21_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_10] = var_21_11
			end

			local var_21_12 = 0

			if var_21_12 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 then
				local var_21_13 = manager.ui.mainCamera.transform.localPosition
				local var_21_14 = Vector3.New(0, 0, 10) + Vector3.New(var_21_13.x, var_21_13.y, 0)
				local var_21_15 = arg_18_1.bgs_.S0506

				var_21_15.transform.localPosition = var_21_14
				var_21_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_16 = var_21_15:GetComponent("SpriteRenderer")

				if var_21_16 and var_21_16.sprite then
					local var_21_17 = (var_21_15.transform.localPosition - var_21_13).z
					local var_21_18 = manager.ui.mainCameraCom_
					local var_21_19 = 2 * var_21_17 * Mathf.Tan(var_21_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_20 = var_21_19 * var_21_18.aspect
					local var_21_21 = var_21_16.sprite.bounds.size.x
					local var_21_22 = var_21_16.sprite.bounds.size.y
					local var_21_23 = var_21_20 / var_21_21
					local var_21_24 = var_21_19 / var_21_22
					local var_21_25 = var_21_24 < var_21_23 and var_21_23 or var_21_24

					var_21_15.transform.localScale = Vector3.New(var_21_25, var_21_25, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "S0506" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_26 = arg_18_1.bgs_.S0506.transform
			local var_21_27 = 0

			if var_21_27 < arg_18_1.time_ and arg_18_1.time_ <= var_21_27 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0506 = var_21_26.localPosition
				var_21_26.localScale = Vector3.New(1.4, 1.4, 1.4)
			end

			local var_21_28 = 3.2

			if var_21_27 <= arg_18_1.time_ and arg_18_1.time_ < var_21_27 + var_21_28 then
				local var_21_29 = (arg_18_1.time_ - var_21_27) / var_21_28
				local var_21_30 = Vector3.New(3.8, -1.2, 10)

				var_21_26.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0506, var_21_30, var_21_29)
			end

			if arg_18_1.time_ >= var_21_27 + var_21_28 and arg_18_1.time_ < var_21_27 + var_21_28 + arg_21_0 then
				var_21_26.localPosition = Vector3.New(3.8, -1.2, 10)
			end

			local var_21_31 = manager.ui.mainCamera.transform
			local var_21_32 = 2.8

			if var_21_32 < arg_18_1.time_ and arg_18_1.time_ <= var_21_32 + arg_21_0 then
				arg_18_1.var_.shakeOldPos = var_21_31.localPosition
			end

			local var_21_33 = 0.6

			if var_21_32 <= arg_18_1.time_ and arg_18_1.time_ < var_21_32 + var_21_33 then
				local var_21_34 = (arg_18_1.time_ - var_21_32) / 0.066
				local var_21_35, var_21_36 = math.modf(var_21_34)

				var_21_31.localPosition = Vector3.New(var_21_36 * 0.13, var_21_36 * 0.13, var_21_36 * 0.13) + arg_18_1.var_.shakeOldPos
			end

			if arg_18_1.time_ >= var_21_32 + var_21_33 and arg_18_1.time_ < var_21_32 + var_21_33 + arg_21_0 then
				var_21_31.localPosition = arg_18_1.var_.shakeOldPos
			end

			local var_21_37 = 0

			if var_21_37 < arg_18_1.time_ and arg_18_1.time_ <= var_21_37 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_38 = 3.2

			if arg_18_1.time_ >= var_21_37 + var_21_38 and arg_18_1.time_ < var_21_37 + var_21_38 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_39 = 3.2
			local var_21_40 = 1.025

			if var_21_39 < arg_18_1.time_ and arg_18_1.time_ <= var_21_39 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_41 = arg_18_1:GetWordFromCfg(105031004)
				local var_21_42 = arg_18_1:FormatText(var_21_41.content)

				arg_18_1.text_.text = var_21_42

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_43 = 41
				local var_21_44 = utf8.len(var_21_42)
				local var_21_45 = var_21_43 <= 0 and var_21_40 or var_21_40 * (var_21_44 / var_21_43)

				if var_21_45 > 0 and var_21_40 < var_21_45 then
					arg_18_1.talkMaxDuration = var_21_45

					if var_21_45 + var_21_39 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_45 + var_21_39
					end
				end

				arg_18_1.text_.text = var_21_42
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_46 = math.max(var_21_40, arg_18_1.talkMaxDuration)

			if var_21_39 <= arg_18_1.time_ and arg_18_1.time_ < var_21_39 + var_21_46 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_39) / var_21_46

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_39 + var_21_46 and arg_18_1.time_ < var_21_39 + var_21_46 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0506",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play105031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 105031005
		arg_22_1.duration_ = 6.93

		local var_22_0 = {
			ja = 5.333,
			ko = 5.033,
			zh = 6.666,
			en = 6.933
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play105031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.6

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[49].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(105031005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 24
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031005", "story_v_out_105031.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031005", "story_v_out_105031.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_105031", "105031005", "story_v_out_105031.awb")

						arg_22_1:RecordAudio("105031005", var_25_9)
						arg_22_1:RecordAudio("105031005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_105031", "105031005", "story_v_out_105031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_105031", "105031005", "story_v_out_105031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play105031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 105031006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play105031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1.075

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_2 = arg_26_1:GetWordFromCfg(105031006)
				local var_29_3 = arg_26_1:FormatText(var_29_2.content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 43
				local var_29_5 = utf8.len(var_29_3)
				local var_29_6 = var_29_4 <= 0 and var_29_1 or var_29_1 * (var_29_5 / var_29_4)

				if var_29_6 > 0 and var_29_1 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_7 and arg_26_1.time_ < var_29_0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play105031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 105031007
		arg_30_1.duration_ = 8.1

		local var_30_0 = {
			ja = 8.1,
			ko = 5.466,
			zh = 5.666,
			en = 5.866
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play105031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "1036ui_story"

			if arg_30_1.actors_[var_33_0] == nil then
				local var_33_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_33_1) then
					local var_33_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_30_1.stage_.transform)

					var_33_2.name = var_33_0
					var_33_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_30_1.actors_[var_33_0] = var_33_2

					local var_33_3 = var_33_2:GetComponentInChildren(typeof(CharacterEffect))

					var_33_3.enabled = true

					local var_33_4 = GameObjectTools.GetOrAddComponent(var_33_2, typeof(DynamicBoneHelper))

					if var_33_4 then
						var_33_4:EnableDynamicBone(false)
					end

					arg_30_1:ShowWeapon(var_33_3.transform, false)

					arg_30_1.var_[var_33_0 .. "Animator"] = var_33_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_30_1.var_[var_33_0 .. "Animator"].applyRootMotion = true
					arg_30_1.var_[var_33_0 .. "LipSync"] = var_33_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_33_5 = arg_30_1.actors_["1036ui_story"]
			local var_33_6 = 3

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 and not isNil(var_33_5) and arg_30_1.var_.characterEffect1036ui_story == nil then
				arg_30_1.var_.characterEffect1036ui_story = var_33_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_7 = 0.1

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_7 and not isNil(var_33_5) then
				local var_33_8 = (arg_30_1.time_ - var_33_6) / var_33_7

				if arg_30_1.var_.characterEffect1036ui_story and not isNil(var_33_5) then
					arg_30_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_6 + var_33_7 and arg_30_1.time_ < var_33_6 + var_33_7 + arg_33_0 and not isNil(var_33_5) and arg_30_1.var_.characterEffect1036ui_story then
				arg_30_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_33_9 = arg_30_1.actors_["1036ui_story"].transform
			local var_33_10 = 3

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1.var_.moveOldPos1036ui_story = var_33_9.localPosition
			end

			local var_33_11 = 0.001

			if var_33_10 <= arg_30_1.time_ and arg_30_1.time_ < var_33_10 + var_33_11 then
				local var_33_12 = (arg_30_1.time_ - var_33_10) / var_33_11
				local var_33_13 = Vector3.New(-0.7, -1.09, -5.78)

				var_33_9.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1036ui_story, var_33_13, var_33_12)

				local var_33_14 = manager.ui.mainCamera.transform.position - var_33_9.position

				var_33_9.forward = Vector3.New(var_33_14.x, var_33_14.y, var_33_14.z)

				local var_33_15 = var_33_9.localEulerAngles

				var_33_15.z = 0
				var_33_15.x = 0
				var_33_9.localEulerAngles = var_33_15
			end

			if arg_30_1.time_ >= var_33_10 + var_33_11 and arg_30_1.time_ < var_33_10 + var_33_11 + arg_33_0 then
				var_33_9.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_33_16 = manager.ui.mainCamera.transform.position - var_33_9.position

				var_33_9.forward = Vector3.New(var_33_16.x, var_33_16.y, var_33_16.z)

				local var_33_17 = var_33_9.localEulerAngles

				var_33_17.z = 0
				var_33_17.x = 0
				var_33_9.localEulerAngles = var_33_17
			end

			local var_33_18 = 3

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_33_19 = arg_30_1.bgs_.S0506
			local var_33_20 = 0

			if var_33_20 < arg_30_1.time_ and arg_30_1.time_ <= var_33_20 + arg_33_0 then
				local var_33_21 = var_33_19:GetComponent("SpriteRenderer")

				if var_33_21 then
					arg_30_1.var_.alphaOldValueS0506 = var_33_21.color.a
					arg_30_1.var_.alphaMatValueS0506 = var_33_21
				end

				arg_30_1.var_.alphaOldValueS0506 = 1
			end

			local var_33_22 = 1.5

			if var_33_20 <= arg_30_1.time_ and arg_30_1.time_ < var_33_20 + var_33_22 then
				local var_33_23 = (arg_30_1.time_ - var_33_20) / var_33_22
				local var_33_24 = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0506, 0, var_33_23)

				if arg_30_1.var_.alphaMatValueS0506 then
					local var_33_25 = arg_30_1.var_.alphaMatValueS0506.color

					var_33_25.a = var_33_24
					arg_30_1.var_.alphaMatValueS0506.color = var_33_25
				end
			end

			if arg_30_1.time_ >= var_33_20 + var_33_22 and arg_30_1.time_ < var_33_20 + var_33_22 + arg_33_0 and arg_30_1.var_.alphaMatValueS0506 then
				local var_33_26 = arg_30_1.var_.alphaMatValueS0506
				local var_33_27 = var_33_26.color

				var_33_27.a = 0
				var_33_26.color = var_33_27
			end

			local var_33_28 = "B04f"

			if arg_30_1.bgs_[var_33_28] == nil then
				local var_33_29 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_29:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_28)
				var_33_29.name = var_33_28
				var_33_29.transform.parent = arg_30_1.stage_.transform
				var_33_29.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_28] = var_33_29
			end

			local var_33_30 = arg_30_1.bgs_.B04f
			local var_33_31 = 1.5

			if var_33_31 < arg_30_1.time_ and arg_30_1.time_ <= var_33_31 + arg_33_0 then
				local var_33_32 = var_33_30:GetComponent("SpriteRenderer")

				if var_33_32 then
					arg_30_1.var_.alphaOldValueB04f = var_33_32.color.a
					arg_30_1.var_.alphaMatValueB04f = var_33_32
				end

				arg_30_1.var_.alphaOldValueB04f = 0
			end

			local var_33_33 = 1.5

			if var_33_31 <= arg_30_1.time_ and arg_30_1.time_ < var_33_31 + var_33_33 then
				local var_33_34 = (arg_30_1.time_ - var_33_31) / var_33_33
				local var_33_35 = Mathf.Lerp(arg_30_1.var_.alphaOldValueB04f, 1, var_33_34)

				if arg_30_1.var_.alphaMatValueB04f then
					local var_33_36 = arg_30_1.var_.alphaMatValueB04f.color

					var_33_36.a = var_33_35
					arg_30_1.var_.alphaMatValueB04f.color = var_33_36
				end
			end

			if arg_30_1.time_ >= var_33_31 + var_33_33 and arg_30_1.time_ < var_33_31 + var_33_33 + arg_33_0 and arg_30_1.var_.alphaMatValueB04f then
				local var_33_37 = arg_30_1.var_.alphaMatValueB04f
				local var_33_38 = var_33_37.color

				var_33_38.a = 1
				var_33_37.color = var_33_38
			end

			local var_33_39 = 1.5

			if var_33_39 < arg_30_1.time_ and arg_30_1.time_ <= var_33_39 + arg_33_0 then
				local var_33_40 = manager.ui.mainCamera.transform.localPosition
				local var_33_41 = Vector3.New(0, 0, 10) + Vector3.New(var_33_40.x, var_33_40.y, 0)
				local var_33_42 = arg_30_1.bgs_.B04f

				var_33_42.transform.localPosition = var_33_41
				var_33_42.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_43 = var_33_42:GetComponent("SpriteRenderer")

				if var_33_43 and var_33_43.sprite then
					local var_33_44 = (var_33_42.transform.localPosition - var_33_40).z
					local var_33_45 = manager.ui.mainCameraCom_
					local var_33_46 = 2 * var_33_44 * Mathf.Tan(var_33_45.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_47 = var_33_46 * var_33_45.aspect
					local var_33_48 = var_33_43.sprite.bounds.size.x
					local var_33_49 = var_33_43.sprite.bounds.size.y
					local var_33_50 = var_33_47 / var_33_48
					local var_33_51 = var_33_46 / var_33_49
					local var_33_52 = var_33_51 < var_33_50 and var_33_50 or var_33_51

					var_33_42.transform.localScale = Vector3.New(var_33_52, var_33_52, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "B04f" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_53 = 0

			if var_33_53 < arg_30_1.time_ and arg_30_1.time_ <= var_33_53 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_54 = 3

			if arg_30_1.time_ >= var_33_53 + var_33_54 and arg_30_1.time_ < var_33_53 + var_33_54 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_55 = 0

			if var_33_55 < arg_30_1.time_ and arg_30_1.time_ <= var_33_55 + arg_33_0 then
				arg_30_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_33_56 = 3
			local var_33_57 = 0.325

			if var_33_56 < arg_30_1.time_ and arg_30_1.time_ <= var_33_56 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_58 = arg_30_1:FormatText(StoryNameCfg[5].name)

				arg_30_1.leftNameTxt_.text = var_33_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_59 = arg_30_1:GetWordFromCfg(105031007)
				local var_33_60 = arg_30_1:FormatText(var_33_59.content)

				arg_30_1.text_.text = var_33_60

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_61 = 13
				local var_33_62 = utf8.len(var_33_60)
				local var_33_63 = var_33_61 <= 0 and var_33_57 or var_33_57 * (var_33_62 / var_33_61)

				if var_33_63 > 0 and var_33_57 < var_33_63 then
					arg_30_1.talkMaxDuration = var_33_63

					if var_33_63 + var_33_56 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_63 + var_33_56
					end
				end

				arg_30_1.text_.text = var_33_60
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031007", "story_v_out_105031.awb") ~= 0 then
					local var_33_64 = manager.audio:GetVoiceLength("story_v_out_105031", "105031007", "story_v_out_105031.awb") / 1000

					if var_33_64 + var_33_56 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_64 + var_33_56
					end

					if var_33_59.prefab_name ~= "" and arg_30_1.actors_[var_33_59.prefab_name] ~= nil then
						local var_33_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_59.prefab_name].transform, "story_v_out_105031", "105031007", "story_v_out_105031.awb")

						arg_30_1:RecordAudio("105031007", var_33_65)
						arg_30_1:RecordAudio("105031007", var_33_65)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_105031", "105031007", "story_v_out_105031.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_105031", "105031007", "story_v_out_105031.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_66 = math.max(var_33_57, arg_30_1.talkMaxDuration)

			if var_33_56 <= arg_30_1.time_ and arg_30_1.time_ < var_33_56 + var_33_66 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_56) / var_33_66

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_56 + var_33_66 and arg_30_1.time_ < var_33_56 + var_33_66 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play105031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 105031008
		arg_34_1.duration_ = 8.37

		local var_34_0 = {
			ja = 6.966,
			ko = 7.333,
			zh = 8.366,
			en = 7.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play105031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "1019ui_story"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_37_1) then
					local var_37_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_34_1.stage_.transform)

					var_37_2.name = var_37_0
					var_37_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_0] = var_37_2

					local var_37_3 = var_37_2:GetComponentInChildren(typeof(CharacterEffect))

					var_37_3.enabled = true

					local var_37_4 = GameObjectTools.GetOrAddComponent(var_37_2, typeof(DynamicBoneHelper))

					if var_37_4 then
						var_37_4:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_3.transform, false)

					arg_34_1.var_[var_37_0 .. "Animator"] = var_37_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_0 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_0 .. "LipSync"] = var_37_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_5 = arg_34_1.actors_["1019ui_story"]
			local var_37_6 = 0

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1019ui_story == nil then
				arg_34_1.var_.characterEffect1019ui_story = var_37_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_7 = 0.1

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_7 and not isNil(var_37_5) then
				local var_37_8 = (arg_34_1.time_ - var_37_6) / var_37_7

				if arg_34_1.var_.characterEffect1019ui_story and not isNil(var_37_5) then
					arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_6 + var_37_7 and arg_34_1.time_ < var_37_6 + var_37_7 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect1019ui_story then
				arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_37_9 = arg_34_1.actors_["1036ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.1

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect1036ui_story and not isNil(var_37_9) then
					local var_37_13 = Mathf.Lerp(0, 0.5, var_37_12)

					arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1036ui_story.fillRatio = var_37_13
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1036ui_story then
				local var_37_14 = 0.5

				arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1036ui_story.fillRatio = var_37_14
			end

			local var_37_15 = arg_34_1.actors_["1019ui_story"].transform
			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.var_.moveOldPos1019ui_story = var_37_15.localPosition
			end

			local var_37_17 = 0.001

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 then
				local var_37_18 = (arg_34_1.time_ - var_37_16) / var_37_17
				local var_37_19 = Vector3.New(0.7, -1.08, -5.9)

				var_37_15.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1019ui_story, var_37_19, var_37_18)

				local var_37_20 = manager.ui.mainCamera.transform.position - var_37_15.position

				var_37_15.forward = Vector3.New(var_37_20.x, var_37_20.y, var_37_20.z)

				local var_37_21 = var_37_15.localEulerAngles

				var_37_21.z = 0
				var_37_21.x = 0
				var_37_15.localEulerAngles = var_37_21
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 then
				var_37_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_37_22 = manager.ui.mainCamera.transform.position - var_37_15.position

				var_37_15.forward = Vector3.New(var_37_22.x, var_37_22.y, var_37_22.z)

				local var_37_23 = var_37_15.localEulerAngles

				var_37_23.z = 0
				var_37_23.x = 0
				var_37_15.localEulerAngles = var_37_23
			end

			local var_37_24 = 0

			if var_37_24 < arg_34_1.time_ and arg_34_1.time_ <= var_37_24 + arg_37_0 then
				arg_34_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_37_25 = 0

			if var_37_25 < arg_34_1.time_ and arg_34_1.time_ <= var_37_25 + arg_37_0 then
				arg_34_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_26 = 0
			local var_37_27 = 0.975

			if var_37_26 < arg_34_1.time_ and arg_34_1.time_ <= var_37_26 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_28 = arg_34_1:FormatText(StoryNameCfg[13].name)

				arg_34_1.leftNameTxt_.text = var_37_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_29 = arg_34_1:GetWordFromCfg(105031008)
				local var_37_30 = arg_34_1:FormatText(var_37_29.content)

				arg_34_1.text_.text = var_37_30

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_31 = 39
				local var_37_32 = utf8.len(var_37_30)
				local var_37_33 = var_37_31 <= 0 and var_37_27 or var_37_27 * (var_37_32 / var_37_31)

				if var_37_33 > 0 and var_37_27 < var_37_33 then
					arg_34_1.talkMaxDuration = var_37_33

					if var_37_33 + var_37_26 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_33 + var_37_26
					end
				end

				arg_34_1.text_.text = var_37_30
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031008", "story_v_out_105031.awb") ~= 0 then
					local var_37_34 = manager.audio:GetVoiceLength("story_v_out_105031", "105031008", "story_v_out_105031.awb") / 1000

					if var_37_34 + var_37_26 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_34 + var_37_26
					end

					if var_37_29.prefab_name ~= "" and arg_34_1.actors_[var_37_29.prefab_name] ~= nil then
						local var_37_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_29.prefab_name].transform, "story_v_out_105031", "105031008", "story_v_out_105031.awb")

						arg_34_1:RecordAudio("105031008", var_37_35)
						arg_34_1:RecordAudio("105031008", var_37_35)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_105031", "105031008", "story_v_out_105031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_105031", "105031008", "story_v_out_105031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_36 = math.max(var_37_27, arg_34_1.talkMaxDuration)

			if var_37_26 <= arg_34_1.time_ and arg_34_1.time_ < var_37_26 + var_37_36 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_26) / var_37_36

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_26 + var_37_36 and arg_34_1.time_ < var_37_26 + var_37_36 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play105031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 105031009
		arg_38_1.duration_ = 5.03

		local var_38_0 = {
			ja = 5,
			ko = 5,
			zh = 4.933,
			en = 5.033
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play105031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1036ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1036ui_story == nil then
				arg_38_1.var_.characterEffect1036ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.1

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1036ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1036ui_story then
				arg_38_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_41_4 = arg_38_1.actors_["1019ui_story"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1019ui_story == nil then
				arg_38_1.var_.characterEffect1019ui_story = var_41_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.1

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.characterEffect1019ui_story and not isNil(var_41_4) then
					local var_41_8 = Mathf.Lerp(0, 0.5, var_41_7)

					arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1019ui_story.fillRatio = var_41_8
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1019ui_story then
				local var_41_9 = 0.5

				arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1019ui_story.fillRatio = var_41_9
			end

			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_41_11 = 0
			local var_41_12 = 0.625

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_13 = arg_38_1:FormatText(StoryNameCfg[5].name)

				arg_38_1.leftNameTxt_.text = var_41_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_14 = arg_38_1:GetWordFromCfg(105031009)
				local var_41_15 = arg_38_1:FormatText(var_41_14.content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 25
				local var_41_17 = utf8.len(var_41_15)
				local var_41_18 = var_41_16 <= 0 and var_41_12 or var_41_12 * (var_41_17 / var_41_16)

				if var_41_18 > 0 and var_41_12 < var_41_18 then
					arg_38_1.talkMaxDuration = var_41_18

					if var_41_18 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_18 + var_41_11
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031009", "story_v_out_105031.awb") ~= 0 then
					local var_41_19 = manager.audio:GetVoiceLength("story_v_out_105031", "105031009", "story_v_out_105031.awb") / 1000

					if var_41_19 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_19 + var_41_11
					end

					if var_41_14.prefab_name ~= "" and arg_38_1.actors_[var_41_14.prefab_name] ~= nil then
						local var_41_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_14.prefab_name].transform, "story_v_out_105031", "105031009", "story_v_out_105031.awb")

						arg_38_1:RecordAudio("105031009", var_41_20)
						arg_38_1:RecordAudio("105031009", var_41_20)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_105031", "105031009", "story_v_out_105031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_105031", "105031009", "story_v_out_105031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_21 = math.max(var_41_12, arg_38_1.talkMaxDuration)

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_21 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_11) / var_41_21

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_11 + var_41_21 and arg_38_1.time_ < var_41_11 + var_41_21 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play105031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 105031010
		arg_42_1.duration_ = 10.9

		local var_42_0 = {
			ja = 5.5,
			ko = 8,
			zh = 8.633,
			en = 10.9
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play105031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "10001_tpose"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["10001_tpose"]
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect10001_tpose == nil then
				arg_42_1.var_.characterEffect10001_tpose = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.1

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 and not isNil(var_45_5) then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7

				if arg_42_1.var_.characterEffect10001_tpose and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect10001_tpose then
				arg_42_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_45_9 = arg_42_1.actors_["1036ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1036ui_story == nil then
				arg_42_1.var_.characterEffect1036ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.1

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect1036ui_story and not isNil(var_45_9) then
					local var_45_13 = Mathf.Lerp(0, 0.5, var_45_12)

					arg_42_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1036ui_story.fillRatio = var_45_13
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1036ui_story then
				local var_45_14 = 0.5

				arg_42_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1036ui_story.fillRatio = var_45_14
			end

			local var_45_15 = arg_42_1.actors_["1036ui_story"].transform
			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.var_.moveOldPos1036ui_story = var_45_15.localPosition
			end

			local var_45_17 = 0.001

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_17 then
				local var_45_18 = (arg_42_1.time_ - var_45_16) / var_45_17
				local var_45_19 = Vector3.New(0, 100, 0)

				var_45_15.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1036ui_story, var_45_19, var_45_18)

				local var_45_20 = manager.ui.mainCamera.transform.position - var_45_15.position

				var_45_15.forward = Vector3.New(var_45_20.x, var_45_20.y, var_45_20.z)

				local var_45_21 = var_45_15.localEulerAngles

				var_45_21.z = 0
				var_45_21.x = 0
				var_45_15.localEulerAngles = var_45_21
			end

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 then
				var_45_15.localPosition = Vector3.New(0, 100, 0)

				local var_45_22 = manager.ui.mainCamera.transform.position - var_45_15.position

				var_45_15.forward = Vector3.New(var_45_22.x, var_45_22.y, var_45_22.z)

				local var_45_23 = var_45_15.localEulerAngles

				var_45_23.z = 0
				var_45_23.x = 0
				var_45_15.localEulerAngles = var_45_23
			end

			local var_45_24 = arg_42_1.actors_["1019ui_story"].transform
			local var_45_25 = 0

			if var_45_25 < arg_42_1.time_ and arg_42_1.time_ <= var_45_25 + arg_45_0 then
				arg_42_1.var_.moveOldPos1019ui_story = var_45_24.localPosition
			end

			local var_45_26 = 0.001

			if var_45_25 <= arg_42_1.time_ and arg_42_1.time_ < var_45_25 + var_45_26 then
				local var_45_27 = (arg_42_1.time_ - var_45_25) / var_45_26
				local var_45_28 = Vector3.New(0, 100, 0)

				var_45_24.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1019ui_story, var_45_28, var_45_27)

				local var_45_29 = manager.ui.mainCamera.transform.position - var_45_24.position

				var_45_24.forward = Vector3.New(var_45_29.x, var_45_29.y, var_45_29.z)

				local var_45_30 = var_45_24.localEulerAngles

				var_45_30.z = 0
				var_45_30.x = 0
				var_45_24.localEulerAngles = var_45_30
			end

			if arg_42_1.time_ >= var_45_25 + var_45_26 and arg_42_1.time_ < var_45_25 + var_45_26 + arg_45_0 then
				var_45_24.localPosition = Vector3.New(0, 100, 0)

				local var_45_31 = manager.ui.mainCamera.transform.position - var_45_24.position

				var_45_24.forward = Vector3.New(var_45_31.x, var_45_31.y, var_45_31.z)

				local var_45_32 = var_45_24.localEulerAngles

				var_45_32.z = 0
				var_45_32.x = 0
				var_45_24.localEulerAngles = var_45_32
			end

			local var_45_33 = arg_42_1.actors_["10001_tpose"].transform
			local var_45_34 = 0

			if var_45_34 < arg_42_1.time_ and arg_42_1.time_ <= var_45_34 + arg_45_0 then
				arg_42_1.var_.moveOldPos10001_tpose = var_45_33.localPosition

				local var_45_35 = GameObjectTools.GetOrAddComponent(var_45_33.gameObject, typeof(DynamicBoneHelper))

				if var_45_35 then
					var_45_35:EnableDynamicBone(false)
				end
			end

			local var_45_36 = 0.001

			if var_45_34 <= arg_42_1.time_ and arg_42_1.time_ < var_45_34 + var_45_36 then
				local var_45_37 = (arg_42_1.time_ - var_45_34) / var_45_36
				local var_45_38 = Vector3.New(0, -1.23, -5.8)

				var_45_33.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10001_tpose, var_45_38, var_45_37)

				local var_45_39 = manager.ui.mainCamera.transform.position - var_45_33.position

				var_45_33.forward = Vector3.New(var_45_39.x, var_45_39.y, var_45_39.z)

				local var_45_40 = var_45_33.localEulerAngles

				var_45_40.z = 0
				var_45_40.x = 0
				var_45_33.localEulerAngles = var_45_40
			end

			if arg_42_1.time_ >= var_45_34 + var_45_36 and arg_42_1.time_ < var_45_34 + var_45_36 + arg_45_0 then
				var_45_33.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_45_41 = manager.ui.mainCamera.transform.position - var_45_33.position

				var_45_33.forward = Vector3.New(var_45_41.x, var_45_41.y, var_45_41.z)

				local var_45_42 = var_45_33.localEulerAngles

				var_45_42.z = 0
				var_45_42.x = 0
				var_45_33.localEulerAngles = var_45_42

				local var_45_43 = GameObjectTools.GetOrAddComponent(var_45_33.gameObject, typeof(DynamicBoneHelper))

				if var_45_43 then
					var_45_43:EnableDynamicBone(true)
				end
			end

			local var_45_44 = 0

			if var_45_44 < arg_42_1.time_ and arg_42_1.time_ <= var_45_44 + arg_45_0 then
				arg_42_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_45_45 = 0

			if var_45_45 < arg_42_1.time_ and arg_42_1.time_ <= var_45_45 + arg_45_0 then
				arg_42_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_45_46 = 0
			local var_45_47 = 1.05

			if var_45_46 < arg_42_1.time_ and arg_42_1.time_ <= var_45_46 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_48 = arg_42_1:FormatText(StoryNameCfg[31].name)

				arg_42_1.leftNameTxt_.text = var_45_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_49 = arg_42_1:GetWordFromCfg(105031010)
				local var_45_50 = arg_42_1:FormatText(var_45_49.content)

				arg_42_1.text_.text = var_45_50

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_51 = 42
				local var_45_52 = utf8.len(var_45_50)
				local var_45_53 = var_45_51 <= 0 and var_45_47 or var_45_47 * (var_45_52 / var_45_51)

				if var_45_53 > 0 and var_45_47 < var_45_53 then
					arg_42_1.talkMaxDuration = var_45_53

					if var_45_53 + var_45_46 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_53 + var_45_46
					end
				end

				arg_42_1.text_.text = var_45_50
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031010", "story_v_out_105031.awb") ~= 0 then
					local var_45_54 = manager.audio:GetVoiceLength("story_v_out_105031", "105031010", "story_v_out_105031.awb") / 1000

					if var_45_54 + var_45_46 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_54 + var_45_46
					end

					if var_45_49.prefab_name ~= "" and arg_42_1.actors_[var_45_49.prefab_name] ~= nil then
						local var_45_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_49.prefab_name].transform, "story_v_out_105031", "105031010", "story_v_out_105031.awb")

						arg_42_1:RecordAudio("105031010", var_45_55)
						arg_42_1:RecordAudio("105031010", var_45_55)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_105031", "105031010", "story_v_out_105031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_105031", "105031010", "story_v_out_105031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_56 = math.max(var_45_47, arg_42_1.talkMaxDuration)

			if var_45_46 <= arg_42_1.time_ and arg_42_1.time_ < var_45_46 + var_45_56 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_46) / var_45_56

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_46 + var_45_56 and arg_42_1.time_ < var_45_46 + var_45_56 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play105031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 105031011
		arg_46_1.duration_ = 4.57

		local var_46_0 = {
			ja = 4.5,
			ko = 4.466,
			zh = 3.7,
			en = 4.566
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play105031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_49_1 = 0
			local var_49_2 = 0.475

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_3 = arg_46_1:FormatText(StoryNameCfg[31].name)

				arg_46_1.leftNameTxt_.text = var_49_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(105031011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 19
				local var_49_7 = utf8.len(var_49_5)
				local var_49_8 = var_49_6 <= 0 and var_49_2 or var_49_2 * (var_49_7 / var_49_6)

				if var_49_8 > 0 and var_49_2 < var_49_8 then
					arg_46_1.talkMaxDuration = var_49_8

					if var_49_8 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031011", "story_v_out_105031.awb") ~= 0 then
					local var_49_9 = manager.audio:GetVoiceLength("story_v_out_105031", "105031011", "story_v_out_105031.awb") / 1000

					if var_49_9 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_1
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_105031", "105031011", "story_v_out_105031.awb")

						arg_46_1:RecordAudio("105031011", var_49_10)
						arg_46_1:RecordAudio("105031011", var_49_10)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_105031", "105031011", "story_v_out_105031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_105031", "105031011", "story_v_out_105031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_11 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_11 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_11

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_11 and arg_46_1.time_ < var_49_1 + var_49_11 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play105031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 105031012
		arg_50_1.duration_ = 2.1

		local var_50_0 = {
			ja = 2.1,
			ko = 1.1,
			zh = 1.333,
			en = 1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play105031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1019ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1019ui_story == nil then
				arg_50_1.var_.characterEffect1019ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1019ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1019ui_story then
				arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_53_4 = arg_50_1.actors_["10001_tpose"]
			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_6 = 0.1

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 and not isNil(var_53_4) then
				local var_53_7 = (arg_50_1.time_ - var_53_5) / var_53_6

				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_4) then
					local var_53_8 = Mathf.Lerp(0, 0.5, var_53_7)

					arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_50_1.var_.characterEffect10001_tpose.fillRatio = var_53_8
				end
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect10001_tpose then
				local var_53_9 = 0.5

				arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_50_1.var_.characterEffect10001_tpose.fillRatio = var_53_9
			end

			local var_53_10 = arg_50_1.actors_["10001_tpose"].transform
			local var_53_11 = 0

			if var_53_11 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_10.localPosition

				local var_53_12 = GameObjectTools.GetOrAddComponent(var_53_10.gameObject, typeof(DynamicBoneHelper))

				if var_53_12 then
					var_53_12:EnableDynamicBone(false)
				end
			end

			local var_53_13 = 0.001

			if var_53_11 <= arg_50_1.time_ and arg_50_1.time_ < var_53_11 + var_53_13 then
				local var_53_14 = (arg_50_1.time_ - var_53_11) / var_53_13
				local var_53_15 = Vector3.New(0, 100, 0)

				var_53_10.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, var_53_15, var_53_14)

				local var_53_16 = manager.ui.mainCamera.transform.position - var_53_10.position

				var_53_10.forward = Vector3.New(var_53_16.x, var_53_16.y, var_53_16.z)

				local var_53_17 = var_53_10.localEulerAngles

				var_53_17.z = 0
				var_53_17.x = 0
				var_53_10.localEulerAngles = var_53_17
			end

			if arg_50_1.time_ >= var_53_11 + var_53_13 and arg_50_1.time_ < var_53_11 + var_53_13 + arg_53_0 then
				var_53_10.localPosition = Vector3.New(0, 100, 0)

				local var_53_18 = manager.ui.mainCamera.transform.position - var_53_10.position

				var_53_10.forward = Vector3.New(var_53_18.x, var_53_18.y, var_53_18.z)

				local var_53_19 = var_53_10.localEulerAngles

				var_53_19.z = 0
				var_53_19.x = 0
				var_53_10.localEulerAngles = var_53_19

				local var_53_20 = GameObjectTools.GetOrAddComponent(var_53_10.gameObject, typeof(DynamicBoneHelper))

				if var_53_20 then
					var_53_20:EnableDynamicBone(true)
				end
			end

			local var_53_21 = 0

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_53_22 = 0
			local var_53_23 = 0.075

			if var_53_22 < arg_50_1.time_ and arg_50_1.time_ <= var_53_22 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_24 = arg_50_1:FormatText(StoryNameCfg[13].name)

				arg_50_1.leftNameTxt_.text = var_53_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_25 = arg_50_1:GetWordFromCfg(105031012)
				local var_53_26 = arg_50_1:FormatText(var_53_25.content)

				arg_50_1.text_.text = var_53_26

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_27 = 3
				local var_53_28 = utf8.len(var_53_26)
				local var_53_29 = var_53_27 <= 0 and var_53_23 or var_53_23 * (var_53_28 / var_53_27)

				if var_53_29 > 0 and var_53_23 < var_53_29 then
					arg_50_1.talkMaxDuration = var_53_29

					if var_53_29 + var_53_22 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_29 + var_53_22
					end
				end

				arg_50_1.text_.text = var_53_26
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031012", "story_v_out_105031.awb") ~= 0 then
					local var_53_30 = manager.audio:GetVoiceLength("story_v_out_105031", "105031012", "story_v_out_105031.awb") / 1000

					if var_53_30 + var_53_22 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_30 + var_53_22
					end

					if var_53_25.prefab_name ~= "" and arg_50_1.actors_[var_53_25.prefab_name] ~= nil then
						local var_53_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_25.prefab_name].transform, "story_v_out_105031", "105031012", "story_v_out_105031.awb")

						arg_50_1:RecordAudio("105031012", var_53_31)
						arg_50_1:RecordAudio("105031012", var_53_31)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_105031", "105031012", "story_v_out_105031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_105031", "105031012", "story_v_out_105031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_32 = math.max(var_53_23, arg_50_1.talkMaxDuration)

			if var_53_22 <= arg_50_1.time_ and arg_50_1.time_ < var_53_22 + var_53_32 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_22) / var_53_32

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_22 + var_53_32 and arg_50_1.time_ < var_53_22 + var_53_32 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play105031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 105031013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play105031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1019ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1019ui_story == nil then
				arg_54_1.var_.characterEffect1019ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1019ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1019ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.575

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_8 = arg_54_1:GetWordFromCfg(105031013)
				local var_57_9 = arg_54_1:FormatText(var_57_8.content)

				arg_54_1.text_.text = var_57_9

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 23
				local var_57_11 = utf8.len(var_57_9)
				local var_57_12 = var_57_10 <= 0 and var_57_7 or var_57_7 * (var_57_11 / var_57_10)

				if var_57_12 > 0 and var_57_7 < var_57_12 then
					arg_54_1.talkMaxDuration = var_57_12

					if var_57_12 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_9
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_13 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_13 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_13

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_13 and arg_54_1.time_ < var_57_6 + var_57_13 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play105031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 105031014
		arg_58_1.duration_ = 8.37

		local var_58_0 = {
			ja = 6.266,
			ko = 8.366,
			zh = 5.8,
			en = 6.233
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
				arg_58_0:Play105031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.8

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[31].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(105031014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 32
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031014", "story_v_out_105031.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031014", "story_v_out_105031.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_105031", "105031014", "story_v_out_105031.awb")

						arg_58_1:RecordAudio("105031014", var_61_9)
						arg_58_1:RecordAudio("105031014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_105031", "105031014", "story_v_out_105031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_105031", "105031014", "story_v_out_105031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play105031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 105031015
		arg_62_1.duration_ = 8.73

		local var_62_0 = {
			ja = 8.733,
			ko = 6.733,
			zh = 5.966,
			en = 6.366
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play105031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.825

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[31].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(105031015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 33
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031015", "story_v_out_105031.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031015", "story_v_out_105031.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_105031", "105031015", "story_v_out_105031.awb")

						arg_62_1:RecordAudio("105031015", var_65_9)
						arg_62_1:RecordAudio("105031015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_105031", "105031015", "story_v_out_105031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_105031", "105031015", "story_v_out_105031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play105031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105031016
		arg_66_1.duration_ = 2

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play105031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1019ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["1019ui_story"].transform
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.var_.moveOldPos1019ui_story = var_69_4.localPosition
			end

			local var_69_6 = 0.001

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6
				local var_69_8 = Vector3.New(-0.7, -1.08, -5.9)

				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1019ui_story, var_69_8, var_69_7)

				local var_69_9 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_9.x, var_69_9.y, var_69_9.z)

				local var_69_10 = var_69_4.localEulerAngles

				var_69_10.z = 0
				var_69_10.x = 0
				var_69_4.localEulerAngles = var_69_10
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_4.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_4.localEulerAngles = var_69_12
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_69_15 = 0
			local var_69_16 = 0.075

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[13].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(105031016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 3
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031016", "story_v_out_105031.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_105031", "105031016", "story_v_out_105031.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_105031", "105031016", "story_v_out_105031.awb")

						arg_66_1:RecordAudio("105031016", var_69_24)
						arg_66_1:RecordAudio("105031016", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_105031", "105031016", "story_v_out_105031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_105031", "105031016", "story_v_out_105031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play105031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105031017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "1011ui_story"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_70_1.stage_.transform)

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

			local var_73_5 = arg_70_1.actors_["1011ui_story"]
			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1011ui_story == nil then
				arg_70_1.var_.characterEffect1011ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.1

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 and not isNil(var_73_5) then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7

				if arg_70_1.var_.characterEffect1011ui_story and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1011ui_story then
				arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_73_9 = arg_70_1.actors_["1019ui_story"]
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_11 = 0.1

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 and not isNil(var_73_9) then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11

				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_9) then
					local var_73_13 = Mathf.Lerp(0, 0.5, var_73_12)

					arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1019ui_story.fillRatio = var_73_13
				end
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect1019ui_story then
				local var_73_14 = 0.5

				arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1019ui_story.fillRatio = var_73_14
			end

			local var_73_15 = arg_70_1.actors_["1011ui_story"].transform
			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_15.localPosition
			end

			local var_73_17 = 0.001

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_17 then
				local var_73_18 = (arg_70_1.time_ - var_73_16) / var_73_17
				local var_73_19 = Vector3.New(0.7, -0.71, -6)

				var_73_15.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, var_73_19, var_73_18)

				local var_73_20 = manager.ui.mainCamera.transform.position - var_73_15.position

				var_73_15.forward = Vector3.New(var_73_20.x, var_73_20.y, var_73_20.z)

				local var_73_21 = var_73_15.localEulerAngles

				var_73_21.z = 0
				var_73_21.x = 0
				var_73_15.localEulerAngles = var_73_21
			end

			if arg_70_1.time_ >= var_73_16 + var_73_17 and arg_70_1.time_ < var_73_16 + var_73_17 + arg_73_0 then
				var_73_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_73_22 = manager.ui.mainCamera.transform.position - var_73_15.position

				var_73_15.forward = Vector3.New(var_73_22.x, var_73_22.y, var_73_22.z)

				local var_73_23 = var_73_15.localEulerAngles

				var_73_23.z = 0
				var_73_23.x = 0
				var_73_15.localEulerAngles = var_73_23
			end

			local var_73_24 = 0

			if var_73_24 < arg_70_1.time_ and arg_70_1.time_ <= var_73_24 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_73_25 = 0

			if var_73_25 < arg_70_1.time_ and arg_70_1.time_ <= var_73_25 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_73_26 = 0
			local var_73_27 = 0.125

			if var_73_26 < arg_70_1.time_ and arg_70_1.time_ <= var_73_26 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_28 = arg_70_1:FormatText(StoryNameCfg[37].name)

				arg_70_1.leftNameTxt_.text = var_73_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_29 = arg_70_1:GetWordFromCfg(105031017)
				local var_73_30 = arg_70_1:FormatText(var_73_29.content)

				arg_70_1.text_.text = var_73_30

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_31 = 5
				local var_73_32 = utf8.len(var_73_30)
				local var_73_33 = var_73_31 <= 0 and var_73_27 or var_73_27 * (var_73_32 / var_73_31)

				if var_73_33 > 0 and var_73_27 < var_73_33 then
					arg_70_1.talkMaxDuration = var_73_33

					if var_73_33 + var_73_26 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_33 + var_73_26
					end
				end

				arg_70_1.text_.text = var_73_30
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031017", "story_v_out_105031.awb") ~= 0 then
					local var_73_34 = manager.audio:GetVoiceLength("story_v_out_105031", "105031017", "story_v_out_105031.awb") / 1000

					if var_73_34 + var_73_26 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_34 + var_73_26
					end

					if var_73_29.prefab_name ~= "" and arg_70_1.actors_[var_73_29.prefab_name] ~= nil then
						local var_73_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_29.prefab_name].transform, "story_v_out_105031", "105031017", "story_v_out_105031.awb")

						arg_70_1:RecordAudio("105031017", var_73_35)
						arg_70_1:RecordAudio("105031017", var_73_35)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_105031", "105031017", "story_v_out_105031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_105031", "105031017", "story_v_out_105031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_36 = math.max(var_73_27, arg_70_1.talkMaxDuration)

			if var_73_26 <= arg_70_1.time_ and arg_70_1.time_ < var_73_26 + var_73_36 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_26) / var_73_36

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_26 + var_73_36 and arg_70_1.time_ < var_73_26 + var_73_36 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play105031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105031018
		arg_74_1.duration_ = 4.07

		local var_74_0 = {
			ja = 3.466,
			ko = 2.933,
			zh = 4.066,
			en = 2.766
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
				arg_74_0:Play105031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1011ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1011ui_story == nil then
				arg_74_1.var_.characterEffect1011ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1011ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1011ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1011ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1011ui_story.fillRatio = var_77_5
			end

			local var_77_6 = arg_74_1.actors_["1019ui_story"].transform
			local var_77_7 = 0

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 then
				arg_74_1.var_.moveOldPos1019ui_story = var_77_6.localPosition
			end

			local var_77_8 = 0.001

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_8 then
				local var_77_9 = (arg_74_1.time_ - var_77_7) / var_77_8
				local var_77_10 = Vector3.New(0, 100, 0)

				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1019ui_story, var_77_10, var_77_9)

				local var_77_11 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_11.x, var_77_11.y, var_77_11.z)

				local var_77_12 = var_77_6.localEulerAngles

				var_77_12.z = 0
				var_77_12.x = 0
				var_77_6.localEulerAngles = var_77_12
			end

			if arg_74_1.time_ >= var_77_7 + var_77_8 and arg_74_1.time_ < var_77_7 + var_77_8 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, 100, 0)

				local var_77_13 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_13.x, var_77_13.y, var_77_13.z)

				local var_77_14 = var_77_6.localEulerAngles

				var_77_14.z = 0
				var_77_14.x = 0
				var_77_6.localEulerAngles = var_77_14
			end

			local var_77_15 = arg_74_1.actors_["1011ui_story"].transform
			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.var_.moveOldPos1011ui_story = var_77_15.localPosition
			end

			local var_77_17 = 0.001

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17
				local var_77_19 = Vector3.New(0, 100, 0)

				var_77_15.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1011ui_story, var_77_19, var_77_18)

				local var_77_20 = manager.ui.mainCamera.transform.position - var_77_15.position

				var_77_15.forward = Vector3.New(var_77_20.x, var_77_20.y, var_77_20.z)

				local var_77_21 = var_77_15.localEulerAngles

				var_77_21.z = 0
				var_77_21.x = 0
				var_77_15.localEulerAngles = var_77_21
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 then
				var_77_15.localPosition = Vector3.New(0, 100, 0)

				local var_77_22 = manager.ui.mainCamera.transform.position - var_77_15.position

				var_77_15.forward = Vector3.New(var_77_22.x, var_77_22.y, var_77_22.z)

				local var_77_23 = var_77_15.localEulerAngles

				var_77_23.z = 0
				var_77_23.x = 0
				var_77_15.localEulerAngles = var_77_23
			end

			local var_77_24 = 0
			local var_77_25 = 0.3

			if var_77_24 < arg_74_1.time_ and arg_74_1.time_ <= var_77_24 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_26 = arg_74_1:FormatText(StoryNameCfg[31].name)

				arg_74_1.leftNameTxt_.text = var_77_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_27 = arg_74_1:GetWordFromCfg(105031018)
				local var_77_28 = arg_74_1:FormatText(var_77_27.content)

				arg_74_1.text_.text = var_77_28

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_29 = 12
				local var_77_30 = utf8.len(var_77_28)
				local var_77_31 = var_77_29 <= 0 and var_77_25 or var_77_25 * (var_77_30 / var_77_29)

				if var_77_31 > 0 and var_77_25 < var_77_31 then
					arg_74_1.talkMaxDuration = var_77_31

					if var_77_31 + var_77_24 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_31 + var_77_24
					end
				end

				arg_74_1.text_.text = var_77_28
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031018", "story_v_out_105031.awb") ~= 0 then
					local var_77_32 = manager.audio:GetVoiceLength("story_v_out_105031", "105031018", "story_v_out_105031.awb") / 1000

					if var_77_32 + var_77_24 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_32 + var_77_24
					end

					if var_77_27.prefab_name ~= "" and arg_74_1.actors_[var_77_27.prefab_name] ~= nil then
						local var_77_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_27.prefab_name].transform, "story_v_out_105031", "105031018", "story_v_out_105031.awb")

						arg_74_1:RecordAudio("105031018", var_77_33)
						arg_74_1:RecordAudio("105031018", var_77_33)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105031", "105031018", "story_v_out_105031.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105031", "105031018", "story_v_out_105031.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_34 = math.max(var_77_25, arg_74_1.talkMaxDuration)

			if var_77_24 <= arg_74_1.time_ and arg_74_1.time_ < var_77_24 + var_77_34 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_24) / var_77_34

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_24 + var_77_34 and arg_74_1.time_ < var_77_24 + var_77_34 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play105031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105031019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play105031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = manager.ui.mainCamera.transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.shakeOldPosMainCamera = var_81_0.localPosition
			end

			local var_81_2 = 0.600000023841858

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / 0.066
				local var_81_4, var_81_5 = math.modf(var_81_3)

				var_81_0.localPosition = Vector3.New(var_81_5 * 0.13, var_81_5 * 0.13, var_81_5 * 0.13) + arg_78_1.var_.shakeOldPosMainCamera
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = arg_78_1.var_.shakeOldPosMainCamera
			end

			local var_81_6 = 0
			local var_81_7 = 0.7

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(105031019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 28
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_7 or var_81_7 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_7 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_13 and arg_78_1.time_ < var_81_6 + var_81_13 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play105031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105031020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play105031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.425

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(105031020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 57
				local var_85_5 = utf8.len(var_85_3)
				local var_85_6 = var_85_4 <= 0 and var_85_1 or var_85_1 * (var_85_5 / var_85_4)

				if var_85_6 > 0 and var_85_1 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_7 and arg_82_1.time_ < var_85_0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play105031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105031021
		arg_86_1.duration_ = 3.67

		local var_86_0 = {
			ja = 3.666,
			ko = 1.866,
			zh = 1.933,
			en = 1.833
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play105031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.15

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[13].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(105031021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 6
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031021", "story_v_out_105031.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031021", "story_v_out_105031.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_105031", "105031021", "story_v_out_105031.awb")

						arg_86_1:RecordAudio("105031021", var_89_9)
						arg_86_1:RecordAudio("105031021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_105031", "105031021", "story_v_out_105031.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_105031", "105031021", "story_v_out_105031.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play105031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105031022
		arg_90_1.duration_ = 2.77

		local var_90_0 = {
			ja = 2.766,
			ko = 2.133,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play105031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = "1084ui_story"

			if arg_90_1.actors_[var_93_0] == nil then
				local var_93_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_93_1) then
					local var_93_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_90_1.stage_.transform)

					var_93_2.name = var_93_0
					var_93_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_90_1.actors_[var_93_0] = var_93_2

					local var_93_3 = var_93_2:GetComponentInChildren(typeof(CharacterEffect))

					var_93_3.enabled = true

					local var_93_4 = GameObjectTools.GetOrAddComponent(var_93_2, typeof(DynamicBoneHelper))

					if var_93_4 then
						var_93_4:EnableDynamicBone(false)
					end

					arg_90_1:ShowWeapon(var_93_3.transform, false)

					arg_90_1.var_[var_93_0 .. "Animator"] = var_93_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_90_1.var_[var_93_0 .. "Animator"].applyRootMotion = true
					arg_90_1.var_[var_93_0 .. "LipSync"] = var_93_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_93_5 = arg_90_1.actors_["1084ui_story"]
			local var_93_6 = 0

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_7 = 0.1

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_7 and not isNil(var_93_5) then
				local var_93_8 = (arg_90_1.time_ - var_93_6) / var_93_7

				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_5) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_6 + var_93_7 and arg_90_1.time_ < var_93_6 + var_93_7 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_93_9 = arg_90_1.actors_["1084ui_story"].transform
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_9.localPosition

				local var_93_11 = "1084ui_story"

				arg_90_1:ShowWeapon(arg_90_1.var_[var_93_11 .. "Animator"].transform, true)
			end

			local var_93_12 = 0.001

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_10) / var_93_12
				local var_93_14 = Vector3.New(0, -0.97, -6)

				var_93_9.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, var_93_14, var_93_13)

				local var_93_15 = manager.ui.mainCamera.transform.position - var_93_9.position

				var_93_9.forward = Vector3.New(var_93_15.x, var_93_15.y, var_93_15.z)

				local var_93_16 = var_93_9.localEulerAngles

				var_93_16.z = 0
				var_93_16.x = 0
				var_93_9.localEulerAngles = var_93_16
			end

			if arg_90_1.time_ >= var_93_10 + var_93_12 and arg_90_1.time_ < var_93_10 + var_93_12 + arg_93_0 then
				var_93_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_93_17 = manager.ui.mainCamera.transform.position - var_93_9.position

				var_93_9.forward = Vector3.New(var_93_17.x, var_93_17.y, var_93_17.z)

				local var_93_18 = var_93_9.localEulerAngles

				var_93_18.z = 0
				var_93_18.x = 0
				var_93_9.localEulerAngles = var_93_18
			end

			local var_93_19 = 0

			if var_93_19 < arg_90_1.time_ and arg_90_1.time_ <= var_93_19 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_93_20 = 0

			if var_93_20 < arg_90_1.time_ and arg_90_1.time_ <= var_93_20 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_93_21 = 0
			local var_93_22 = 0.125

			if var_93_21 < arg_90_1.time_ and arg_90_1.time_ <= var_93_21 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_23 = arg_90_1:FormatText(StoryNameCfg[6].name)

				arg_90_1.leftNameTxt_.text = var_93_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_24 = arg_90_1:GetWordFromCfg(105031022)
				local var_93_25 = arg_90_1:FormatText(var_93_24.content)

				arg_90_1.text_.text = var_93_25

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_26 = 5
				local var_93_27 = utf8.len(var_93_25)
				local var_93_28 = var_93_26 <= 0 and var_93_22 or var_93_22 * (var_93_27 / var_93_26)

				if var_93_28 > 0 and var_93_22 < var_93_28 then
					arg_90_1.talkMaxDuration = var_93_28

					if var_93_28 + var_93_21 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_28 + var_93_21
					end
				end

				arg_90_1.text_.text = var_93_25
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031022", "story_v_out_105031.awb") ~= 0 then
					local var_93_29 = manager.audio:GetVoiceLength("story_v_out_105031", "105031022", "story_v_out_105031.awb") / 1000

					if var_93_29 + var_93_21 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_29 + var_93_21
					end

					if var_93_24.prefab_name ~= "" and arg_90_1.actors_[var_93_24.prefab_name] ~= nil then
						local var_93_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_24.prefab_name].transform, "story_v_out_105031", "105031022", "story_v_out_105031.awb")

						arg_90_1:RecordAudio("105031022", var_93_30)
						arg_90_1:RecordAudio("105031022", var_93_30)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105031", "105031022", "story_v_out_105031.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105031", "105031022", "story_v_out_105031.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_31 = math.max(var_93_22, arg_90_1.talkMaxDuration)

			if var_93_21 <= arg_90_1.time_ and arg_90_1.time_ < var_93_21 + var_93_31 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_21) / var_93_31

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_21 + var_93_31 and arg_90_1.time_ < var_93_21 + var_93_31 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play105031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105031023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1084ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_5
			end

			local var_97_6 = arg_94_1.actors_["1084ui_story"].transform
			local var_97_7 = 0

			if var_97_7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_6.localPosition
			end

			local var_97_8 = 0.001

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_8 then
				local var_97_9 = (arg_94_1.time_ - var_97_7) / var_97_8
				local var_97_10 = Vector3.New(0, 100, 0)

				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, var_97_10, var_97_9)

				local var_97_11 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_11.x, var_97_11.y, var_97_11.z)

				local var_97_12 = var_97_6.localEulerAngles

				var_97_12.z = 0
				var_97_12.x = 0
				var_97_6.localEulerAngles = var_97_12
			end

			if arg_94_1.time_ >= var_97_7 + var_97_8 and arg_94_1.time_ < var_97_7 + var_97_8 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(0, 100, 0)

				local var_97_13 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_13.x, var_97_13.y, var_97_13.z)

				local var_97_14 = var_97_6.localEulerAngles

				var_97_14.z = 0
				var_97_14.x = 0
				var_97_6.localEulerAngles = var_97_14
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_97_16 = 0
			local var_97_17 = 1.4

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(105031023)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 55
				local var_97_21 = utf8.len(var_97_19)
				local var_97_22 = var_97_20 <= 0 and var_97_17 or var_97_17 * (var_97_21 / var_97_20)

				if var_97_22 > 0 and var_97_17 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22

					if var_97_22 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_19
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_23 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_23 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_23

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_23 and arg_94_1.time_ < var_97_16 + var_97_23 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play105031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105031024
		arg_98_1.duration_ = 3.33

		local var_98_0 = {
			ja = 3.333,
			ko = 2.7,
			zh = 2.6,
			en = 2.933
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play105031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1084ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1084ui_story"].transform
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_4.localPosition

				local var_101_6 = "1084ui_story"

				arg_98_1:ShowWeapon(arg_98_1.var_[var_101_6 .. "Animator"].transform, false)
			end

			local var_101_7 = 0.001

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_7 then
				local var_101_8 = (arg_98_1.time_ - var_101_5) / var_101_7
				local var_101_9 = Vector3.New(0, -0.97, -6)

				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, var_101_9, var_101_8)

				local var_101_10 = manager.ui.mainCamera.transform.position - var_101_4.position

				var_101_4.forward = Vector3.New(var_101_10.x, var_101_10.y, var_101_10.z)

				local var_101_11 = var_101_4.localEulerAngles

				var_101_11.z = 0
				var_101_11.x = 0
				var_101_4.localEulerAngles = var_101_11
			end

			if arg_98_1.time_ >= var_101_5 + var_101_7 and arg_98_1.time_ < var_101_5 + var_101_7 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_4.position

				var_101_4.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_4.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_4.localEulerAngles = var_101_13
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_101_16 = 0
			local var_101_17 = 0.225

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_18 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(105031024)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 9
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_17 or var_101_17 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_17 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23

					if var_101_23 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_16
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031024", "story_v_out_105031.awb") ~= 0 then
					local var_101_24 = manager.audio:GetVoiceLength("story_v_out_105031", "105031024", "story_v_out_105031.awb") / 1000

					if var_101_24 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_16
					end

					if var_101_19.prefab_name ~= "" and arg_98_1.actors_[var_101_19.prefab_name] ~= nil then
						local var_101_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_19.prefab_name].transform, "story_v_out_105031", "105031024", "story_v_out_105031.awb")

						arg_98_1:RecordAudio("105031024", var_101_25)
						arg_98_1:RecordAudio("105031024", var_101_25)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105031", "105031024", "story_v_out_105031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105031", "105031024", "story_v_out_105031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_26 = math.max(var_101_17, arg_98_1.talkMaxDuration)

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_26 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_16) / var_101_26

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_16 + var_101_26 and arg_98_1.time_ < var_101_16 + var_101_26 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play105031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105031025
		arg_102_1.duration_ = 5.5

		local var_102_0 = {
			ja = 5.5,
			ko = 4.433,
			zh = 3.733,
			en = 5.433
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
				arg_102_0:Play105031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1036ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1036ui_story == nil then
				arg_102_1.var_.characterEffect1036ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1036ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1036ui_story then
				arg_102_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1084ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.1

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_9
			end

			local var_105_10 = arg_102_1.actors_["1084ui_story"].transform
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = var_105_10.localPosition
			end

			local var_105_12 = 0.001

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_11) / var_105_12
				local var_105_14 = Vector3.New(0, -0.97, -6)

				var_105_10.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, var_105_14, var_105_13)

				local var_105_15 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_15.x, var_105_15.y, var_105_15.z)

				local var_105_16 = var_105_10.localEulerAngles

				var_105_16.z = 0
				var_105_16.x = 0
				var_105_10.localEulerAngles = var_105_16
			end

			if arg_102_1.time_ >= var_105_11 + var_105_12 and arg_102_1.time_ < var_105_11 + var_105_12 + arg_105_0 then
				var_105_10.localPosition = Vector3.New(0, -0.97, -6)

				local var_105_17 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_17.x, var_105_17.y, var_105_17.z)

				local var_105_18 = var_105_10.localEulerAngles

				var_105_18.z = 0
				var_105_18.x = 0
				var_105_10.localEulerAngles = var_105_18
			end

			local var_105_19 = arg_102_1.actors_["1084ui_story"].transform
			local var_105_20 = 0.033

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = var_105_19.localPosition
			end

			local var_105_21 = 0.5

			if var_105_20 <= arg_102_1.time_ and arg_102_1.time_ < var_105_20 + var_105_21 then
				local var_105_22 = (arg_102_1.time_ - var_105_20) / var_105_21
				local var_105_23 = Vector3.New(-0.7, -0.97, -6)

				var_105_19.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, var_105_23, var_105_22)

				local var_105_24 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_24.x, var_105_24.y, var_105_24.z)

				local var_105_25 = var_105_19.localEulerAngles

				var_105_25.z = 0
				var_105_25.x = 0
				var_105_19.localEulerAngles = var_105_25
			end

			if arg_102_1.time_ >= var_105_20 + var_105_21 and arg_102_1.time_ < var_105_20 + var_105_21 + arg_105_0 then
				var_105_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_105_26 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_26.x, var_105_26.y, var_105_26.z)

				local var_105_27 = var_105_19.localEulerAngles

				var_105_27.z = 0
				var_105_27.x = 0
				var_105_19.localEulerAngles = var_105_27
			end

			local var_105_28 = arg_102_1.actors_["1036ui_story"].transform
			local var_105_29 = 0

			if var_105_29 < arg_102_1.time_ and arg_102_1.time_ <= var_105_29 + arg_105_0 then
				arg_102_1.var_.moveOldPos1036ui_story = var_105_28.localPosition
			end

			local var_105_30 = 0.001

			if var_105_29 <= arg_102_1.time_ and arg_102_1.time_ < var_105_29 + var_105_30 then
				local var_105_31 = (arg_102_1.time_ - var_105_29) / var_105_30
				local var_105_32 = Vector3.New(0.7, -1.09, -5.78)

				var_105_28.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1036ui_story, var_105_32, var_105_31)

				local var_105_33 = manager.ui.mainCamera.transform.position - var_105_28.position

				var_105_28.forward = Vector3.New(var_105_33.x, var_105_33.y, var_105_33.z)

				local var_105_34 = var_105_28.localEulerAngles

				var_105_34.z = 0
				var_105_34.x = 0
				var_105_28.localEulerAngles = var_105_34
			end

			if arg_102_1.time_ >= var_105_29 + var_105_30 and arg_102_1.time_ < var_105_29 + var_105_30 + arg_105_0 then
				var_105_28.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_105_35 = manager.ui.mainCamera.transform.position - var_105_28.position

				var_105_28.forward = Vector3.New(var_105_35.x, var_105_35.y, var_105_35.z)

				local var_105_36 = var_105_28.localEulerAngles

				var_105_36.z = 0
				var_105_36.x = 0
				var_105_28.localEulerAngles = var_105_36
			end

			local var_105_37 = 0

			if var_105_37 < arg_102_1.time_ and arg_102_1.time_ <= var_105_37 + arg_105_0 then
				arg_102_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_105_38 = 0

			if var_105_38 < arg_102_1.time_ and arg_102_1.time_ <= var_105_38 + arg_105_0 then
				arg_102_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_105_39 = 0
			local var_105_40 = 0.5

			if var_105_39 < arg_102_1.time_ and arg_102_1.time_ <= var_105_39 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_41 = arg_102_1:FormatText(StoryNameCfg[5].name)

				arg_102_1.leftNameTxt_.text = var_105_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_42 = arg_102_1:GetWordFromCfg(105031025)
				local var_105_43 = arg_102_1:FormatText(var_105_42.content)

				arg_102_1.text_.text = var_105_43

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_44 = 19
				local var_105_45 = utf8.len(var_105_43)
				local var_105_46 = var_105_44 <= 0 and var_105_40 or var_105_40 * (var_105_45 / var_105_44)

				if var_105_46 > 0 and var_105_40 < var_105_46 then
					arg_102_1.talkMaxDuration = var_105_46

					if var_105_46 + var_105_39 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_46 + var_105_39
					end
				end

				arg_102_1.text_.text = var_105_43
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031025", "story_v_out_105031.awb") ~= 0 then
					local var_105_47 = manager.audio:GetVoiceLength("story_v_out_105031", "105031025", "story_v_out_105031.awb") / 1000

					if var_105_47 + var_105_39 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_47 + var_105_39
					end

					if var_105_42.prefab_name ~= "" and arg_102_1.actors_[var_105_42.prefab_name] ~= nil then
						local var_105_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_42.prefab_name].transform, "story_v_out_105031", "105031025", "story_v_out_105031.awb")

						arg_102_1:RecordAudio("105031025", var_105_48)
						arg_102_1:RecordAudio("105031025", var_105_48)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105031", "105031025", "story_v_out_105031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105031", "105031025", "story_v_out_105031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_49 = math.max(var_105_40, arg_102_1.talkMaxDuration)

			if var_105_39 <= arg_102_1.time_ and arg_102_1.time_ < var_105_39 + var_105_49 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_39) / var_105_49

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_39 + var_105_49 and arg_102_1.time_ < var_105_39 + var_105_49 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play105031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105031026
		arg_106_1.duration_ = 10.27

		local var_106_0 = {
			ja = 10.266,
			ko = 6.233,
			zh = 5.433,
			en = 7.233
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1036ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1036ui_story == nil then
				arg_106_1.var_.characterEffect1036ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1036ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1036ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1036ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1036ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.5

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[49].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(105031026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031026", "story_v_out_105031.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_105031", "105031026", "story_v_out_105031.awb") / 1000

					if var_109_14 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_6
					end

					if var_109_9.prefab_name ~= "" and arg_106_1.actors_[var_109_9.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_9.prefab_name].transform, "story_v_out_105031", "105031026", "story_v_out_105031.awb")

						arg_106_1:RecordAudio("105031026", var_109_15)
						arg_106_1:RecordAudio("105031026", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105031", "105031026", "story_v_out_105031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105031", "105031026", "story_v_out_105031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_16 and arg_106_1.time_ < var_109_6 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play105031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105031027
		arg_110_1.duration_ = 5.87

		local var_110_0 = {
			ja = 5.866,
			ko = 3.366,
			zh = 3.7,
			en = 4.366
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play105031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1019ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1019ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1036ui_story"].transform
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.var_.moveOldPos1036ui_story = var_113_4.localPosition
			end

			local var_113_6 = 0.001

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6
				local var_113_8 = Vector3.New(0, 100, 0)

				var_113_4.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1036ui_story, var_113_8, var_113_7)

				local var_113_9 = manager.ui.mainCamera.transform.position - var_113_4.position

				var_113_4.forward = Vector3.New(var_113_9.x, var_113_9.y, var_113_9.z)

				local var_113_10 = var_113_4.localEulerAngles

				var_113_10.z = 0
				var_113_10.x = 0
				var_113_4.localEulerAngles = var_113_10
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				var_113_4.localPosition = Vector3.New(0, 100, 0)

				local var_113_11 = manager.ui.mainCamera.transform.position - var_113_4.position

				var_113_4.forward = Vector3.New(var_113_11.x, var_113_11.y, var_113_11.z)

				local var_113_12 = var_113_4.localEulerAngles

				var_113_12.z = 0
				var_113_12.x = 0
				var_113_4.localEulerAngles = var_113_12
			end

			local var_113_13 = arg_110_1.actors_["1019ui_story"].transform
			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_13.localPosition
			end

			local var_113_15 = 0.001

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_15 then
				local var_113_16 = (arg_110_1.time_ - var_113_14) / var_113_15
				local var_113_17 = Vector3.New(0.7, -1.08, -5.9)

				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, var_113_17, var_113_16)

				local var_113_18 = manager.ui.mainCamera.transform.position - var_113_13.position

				var_113_13.forward = Vector3.New(var_113_18.x, var_113_18.y, var_113_18.z)

				local var_113_19 = var_113_13.localEulerAngles

				var_113_19.z = 0
				var_113_19.x = 0
				var_113_13.localEulerAngles = var_113_19
			end

			if arg_110_1.time_ >= var_113_14 + var_113_15 and arg_110_1.time_ < var_113_14 + var_113_15 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_113_20 = manager.ui.mainCamera.transform.position - var_113_13.position

				var_113_13.forward = Vector3.New(var_113_20.x, var_113_20.y, var_113_20.z)

				local var_113_21 = var_113_13.localEulerAngles

				var_113_21.z = 0
				var_113_21.x = 0
				var_113_13.localEulerAngles = var_113_21
			end

			local var_113_22 = 0

			if var_113_22 < arg_110_1.time_ and arg_110_1.time_ <= var_113_22 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_113_23 = 0

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_113_24 = 0
			local var_113_25 = 0.3

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_26 = arg_110_1:FormatText(StoryNameCfg[13].name)

				arg_110_1.leftNameTxt_.text = var_113_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_27 = arg_110_1:GetWordFromCfg(105031027)
				local var_113_28 = arg_110_1:FormatText(var_113_27.content)

				arg_110_1.text_.text = var_113_28

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_29 = 12
				local var_113_30 = utf8.len(var_113_28)
				local var_113_31 = var_113_29 <= 0 and var_113_25 or var_113_25 * (var_113_30 / var_113_29)

				if var_113_31 > 0 and var_113_25 < var_113_31 then
					arg_110_1.talkMaxDuration = var_113_31

					if var_113_31 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_24
					end
				end

				arg_110_1.text_.text = var_113_28
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031027", "story_v_out_105031.awb") ~= 0 then
					local var_113_32 = manager.audio:GetVoiceLength("story_v_out_105031", "105031027", "story_v_out_105031.awb") / 1000

					if var_113_32 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_32 + var_113_24
					end

					if var_113_27.prefab_name ~= "" and arg_110_1.actors_[var_113_27.prefab_name] ~= nil then
						local var_113_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_27.prefab_name].transform, "story_v_out_105031", "105031027", "story_v_out_105031.awb")

						arg_110_1:RecordAudio("105031027", var_113_33)
						arg_110_1:RecordAudio("105031027", var_113_33)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105031", "105031027", "story_v_out_105031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105031", "105031027", "story_v_out_105031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_34 = math.max(var_113_25, arg_110_1.talkMaxDuration)

			if var_113_24 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_34 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_24) / var_113_34

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_24 + var_113_34 and arg_110_1.time_ < var_113_24 + var_113_34 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play105031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105031028
		arg_114_1.duration_ = 5.07

		local var_114_0 = {
			ja = 5.066,
			ko = 4.233,
			zh = 4.2,
			en = 4.366
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
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play105031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1084ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1019ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.1

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4913")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_117_12 = 0
			local var_117_13 = 0.5

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(105031028)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 20
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031028", "story_v_out_105031.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_105031", "105031028", "story_v_out_105031.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_105031", "105031028", "story_v_out_105031.awb")

						arg_114_1:RecordAudio("105031028", var_117_21)
						arg_114_1:RecordAudio("105031028", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105031", "105031028", "story_v_out_105031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105031", "105031028", "story_v_out_105031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play105031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105031029
		arg_118_1.duration_ = 4.57

		local var_118_0 = {
			ja = 1.999999999999,
			ko = 3.433,
			zh = 4.566,
			en = 3.166
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play105031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1019ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1019ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1084ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.1

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1084ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_121_12 = 0
			local var_121_13 = 0.35

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_14 = arg_118_1:FormatText(StoryNameCfg[13].name)

				arg_118_1.leftNameTxt_.text = var_121_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_15 = arg_118_1:GetWordFromCfg(105031029)
				local var_121_16 = arg_118_1:FormatText(var_121_15.content)

				arg_118_1.text_.text = var_121_16

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_17 = 14
				local var_121_18 = utf8.len(var_121_16)
				local var_121_19 = var_121_17 <= 0 and var_121_13 or var_121_13 * (var_121_18 / var_121_17)

				if var_121_19 > 0 and var_121_13 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19

					if var_121_19 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_12
					end
				end

				arg_118_1.text_.text = var_121_16
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031029", "story_v_out_105031.awb") ~= 0 then
					local var_121_20 = manager.audio:GetVoiceLength("story_v_out_105031", "105031029", "story_v_out_105031.awb") / 1000

					if var_121_20 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_20 + var_121_12
					end

					if var_121_15.prefab_name ~= "" and arg_118_1.actors_[var_121_15.prefab_name] ~= nil then
						local var_121_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_15.prefab_name].transform, "story_v_out_105031", "105031029", "story_v_out_105031.awb")

						arg_118_1:RecordAudio("105031029", var_121_21)
						arg_118_1:RecordAudio("105031029", var_121_21)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_105031", "105031029", "story_v_out_105031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_105031", "105031029", "story_v_out_105031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_22 = math.max(var_121_13, arg_118_1.talkMaxDuration)

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_22 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_12) / var_121_22

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_12 + var_121_22 and arg_118_1.time_ < var_121_12 + var_121_22 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play105031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105031030
		arg_122_1.duration_ = 20.1

		local var_122_0 = {
			ja = 20.1,
			ko = 10.033,
			zh = 13.333,
			en = 13.466
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1019ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1019ui_story == nil then
				arg_122_1.var_.characterEffect1019ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1019ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1019ui_story then
				arg_122_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1011ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1011ui_story == nil then
				arg_122_1.var_.characterEffect1011ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1011ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1011ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1011ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1011ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_125_11 = 0
			local var_125_12 = 1.6

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_13 = arg_122_1:FormatText(StoryNameCfg[13].name)

				arg_122_1.leftNameTxt_.text = var_125_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_14 = arg_122_1:GetWordFromCfg(105031030)
				local var_125_15 = arg_122_1:FormatText(var_125_14.content)

				arg_122_1.text_.text = var_125_15

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_16 = 64
				local var_125_17 = utf8.len(var_125_15)
				local var_125_18 = var_125_16 <= 0 and var_125_12 or var_125_12 * (var_125_17 / var_125_16)

				if var_125_18 > 0 and var_125_12 < var_125_18 then
					arg_122_1.talkMaxDuration = var_125_18

					if var_125_18 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_11
					end
				end

				arg_122_1.text_.text = var_125_15
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031030", "story_v_out_105031.awb") ~= 0 then
					local var_125_19 = manager.audio:GetVoiceLength("story_v_out_105031", "105031030", "story_v_out_105031.awb") / 1000

					if var_125_19 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_11
					end

					if var_125_14.prefab_name ~= "" and arg_122_1.actors_[var_125_14.prefab_name] ~= nil then
						local var_125_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_14.prefab_name].transform, "story_v_out_105031", "105031030", "story_v_out_105031.awb")

						arg_122_1:RecordAudio("105031030", var_125_20)
						arg_122_1:RecordAudio("105031030", var_125_20)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_105031", "105031030", "story_v_out_105031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_105031", "105031030", "story_v_out_105031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = math.max(var_125_12, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_21 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_21

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_21 and arg_122_1.time_ < var_125_11 + var_125_21 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play105031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 105031031
		arg_126_1.duration_ = 16.7

		local var_126_0 = {
			ja = 16.7,
			ko = 9.533,
			zh = 13.333,
			en = 13.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play105031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1019ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1019ui_story == nil then
				arg_126_1.var_.characterEffect1019ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1019ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1019ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1019ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1019ui_story.fillRatio = var_129_5
			end

			local var_129_6 = arg_126_1.actors_["1019ui_story"].transform
			local var_129_7 = 0

			if var_129_7 < arg_126_1.time_ and arg_126_1.time_ <= var_129_7 + arg_129_0 then
				arg_126_1.var_.moveOldPos1019ui_story = var_129_6.localPosition
			end

			local var_129_8 = 0.001

			if var_129_7 <= arg_126_1.time_ and arg_126_1.time_ < var_129_7 + var_129_8 then
				local var_129_9 = (arg_126_1.time_ - var_129_7) / var_129_8
				local var_129_10 = Vector3.New(0, 100, 0)

				var_129_6.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1019ui_story, var_129_10, var_129_9)

				local var_129_11 = manager.ui.mainCamera.transform.position - var_129_6.position

				var_129_6.forward = Vector3.New(var_129_11.x, var_129_11.y, var_129_11.z)

				local var_129_12 = var_129_6.localEulerAngles

				var_129_12.z = 0
				var_129_12.x = 0
				var_129_6.localEulerAngles = var_129_12
			end

			if arg_126_1.time_ >= var_129_7 + var_129_8 and arg_126_1.time_ < var_129_7 + var_129_8 + arg_129_0 then
				var_129_6.localPosition = Vector3.New(0, 100, 0)

				local var_129_13 = manager.ui.mainCamera.transform.position - var_129_6.position

				var_129_6.forward = Vector3.New(var_129_13.x, var_129_13.y, var_129_13.z)

				local var_129_14 = var_129_6.localEulerAngles

				var_129_14.z = 0
				var_129_14.x = 0
				var_129_6.localEulerAngles = var_129_14
			end

			local var_129_15 = arg_126_1.actors_["1084ui_story"].transform
			local var_129_16 = 0

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_15.localPosition
			end

			local var_129_17 = 0.001

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_17 then
				local var_129_18 = (arg_126_1.time_ - var_129_16) / var_129_17
				local var_129_19 = Vector3.New(0, 100, 0)

				var_129_15.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, var_129_19, var_129_18)

				local var_129_20 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_20.x, var_129_20.y, var_129_20.z)

				local var_129_21 = var_129_15.localEulerAngles

				var_129_21.z = 0
				var_129_21.x = 0
				var_129_15.localEulerAngles = var_129_21
			end

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				var_129_15.localPosition = Vector3.New(0, 100, 0)

				local var_129_22 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_22.x, var_129_22.y, var_129_22.z)

				local var_129_23 = var_129_15.localEulerAngles

				var_129_23.z = 0
				var_129_23.x = 0
				var_129_15.localEulerAngles = var_129_23
			end

			local var_129_24 = 0
			local var_129_25 = 1.225

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_26 = arg_126_1:FormatText(StoryNameCfg[49].name)

				arg_126_1.leftNameTxt_.text = var_129_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_27 = arg_126_1:GetWordFromCfg(105031031)
				local var_129_28 = arg_126_1:FormatText(var_129_27.content)

				arg_126_1.text_.text = var_129_28

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_29 = 49
				local var_129_30 = utf8.len(var_129_28)
				local var_129_31 = var_129_29 <= 0 and var_129_25 or var_129_25 * (var_129_30 / var_129_29)

				if var_129_31 > 0 and var_129_25 < var_129_31 then
					arg_126_1.talkMaxDuration = var_129_31

					if var_129_31 + var_129_24 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_31 + var_129_24
					end
				end

				arg_126_1.text_.text = var_129_28
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031031", "story_v_out_105031.awb") ~= 0 then
					local var_129_32 = manager.audio:GetVoiceLength("story_v_out_105031", "105031031", "story_v_out_105031.awb") / 1000

					if var_129_32 + var_129_24 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_32 + var_129_24
					end

					if var_129_27.prefab_name ~= "" and arg_126_1.actors_[var_129_27.prefab_name] ~= nil then
						local var_129_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_27.prefab_name].transform, "story_v_out_105031", "105031031", "story_v_out_105031.awb")

						arg_126_1:RecordAudio("105031031", var_129_33)
						arg_126_1:RecordAudio("105031031", var_129_33)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_105031", "105031031", "story_v_out_105031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_105031", "105031031", "story_v_out_105031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_34 = math.max(var_129_25, arg_126_1.talkMaxDuration)

			if var_129_24 <= arg_126_1.time_ and arg_126_1.time_ < var_129_24 + var_129_34 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_24) / var_129_34

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_24 + var_129_34 and arg_126_1.time_ < var_129_24 + var_129_34 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play105031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 105031032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play105031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.bgs_.B04f.transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPosB04f = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, -100, 10)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPosB04f, var_133_4, var_133_3)
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_133_5 = "S0501"

			if arg_130_1.bgs_[var_133_5] == nil then
				local var_133_6 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_133_5)
				var_133_6.name = var_133_5
				var_133_6.transform.parent = arg_130_1.stage_.transform
				var_133_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_[var_133_5] = var_133_6
			end

			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				local var_133_8 = manager.ui.mainCamera.transform.localPosition
				local var_133_9 = Vector3.New(0, 0, 10) + Vector3.New(var_133_8.x, var_133_8.y, 0)
				local var_133_10 = arg_130_1.bgs_.S0501

				var_133_10.transform.localPosition = var_133_9
				var_133_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_11 = var_133_10:GetComponent("SpriteRenderer")

				if var_133_11 and var_133_11.sprite then
					local var_133_12 = (var_133_10.transform.localPosition - var_133_8).z
					local var_133_13 = manager.ui.mainCameraCom_
					local var_133_14 = 2 * var_133_12 * Mathf.Tan(var_133_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_15 = var_133_14 * var_133_13.aspect
					local var_133_16 = var_133_11.sprite.bounds.size.x
					local var_133_17 = var_133_11.sprite.bounds.size.y
					local var_133_18 = var_133_15 / var_133_16
					local var_133_19 = var_133_14 / var_133_17
					local var_133_20 = var_133_19 < var_133_18 and var_133_18 or var_133_19

					var_133_10.transform.localScale = Vector3.New(var_133_20, var_133_20, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "S0501" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_21 = 0
			local var_133_22 = 1.525

			if var_133_21 < arg_130_1.time_ and arg_130_1.time_ <= var_133_21 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_23 = arg_130_1:GetWordFromCfg(105031032)
				local var_133_24 = arg_130_1:FormatText(var_133_23.content)

				arg_130_1.text_.text = var_133_24

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_25 = 61
				local var_133_26 = utf8.len(var_133_24)
				local var_133_27 = var_133_25 <= 0 and var_133_22 or var_133_22 * (var_133_26 / var_133_25)

				if var_133_27 > 0 and var_133_22 < var_133_27 then
					arg_130_1.talkMaxDuration = var_133_27

					if var_133_27 + var_133_21 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_27 + var_133_21
					end
				end

				arg_130_1.text_.text = var_133_24
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_28 = math.max(var_133_22, arg_130_1.talkMaxDuration)

			if var_133_21 <= arg_130_1.time_ and arg_130_1.time_ < var_133_21 + var_133_28 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_21) / var_133_28

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_21 + var_133_28 and arg_130_1.time_ < var_133_21 + var_133_28 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B04f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play105031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 105031033
		arg_134_1.duration_ = 4.57

		local var_134_0 = {
			ja = 4.566,
			ko = 2.633,
			zh = 2.2,
			en = 3.066
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play105031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.2

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[37].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(105031033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 8
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031033", "story_v_out_105031.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031033", "story_v_out_105031.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_105031", "105031033", "story_v_out_105031.awb")

						arg_134_1:RecordAudio("105031033", var_137_9)
						arg_134_1:RecordAudio("105031033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_105031", "105031033", "story_v_out_105031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_105031", "105031033", "story_v_out_105031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play105031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 105031034
		arg_138_1.duration_ = 3.27

		local var_138_0 = {
			ja = 2.566,
			ko = 2.133,
			zh = 3.1,
			en = 3.266
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play105031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.175

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[6].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(105031034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 7
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031034", "story_v_out_105031.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031034", "story_v_out_105031.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_105031", "105031034", "story_v_out_105031.awb")

						arg_138_1:RecordAudio("105031034", var_141_9)
						arg_138_1:RecordAudio("105031034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_105031", "105031034", "story_v_out_105031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_105031", "105031034", "story_v_out_105031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play105031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 105031035
		arg_142_1.duration_ = 8.53

		local var_142_0 = {
			ja = 8.533,
			ko = 6,
			zh = 5.866,
			en = 6.366
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play105031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.8

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[5].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(105031035)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 31
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031035", "story_v_out_105031.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031035", "story_v_out_105031.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_105031", "105031035", "story_v_out_105031.awb")

						arg_142_1:RecordAudio("105031035", var_145_9)
						arg_142_1:RecordAudio("105031035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_105031", "105031035", "story_v_out_105031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_105031", "105031035", "story_v_out_105031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play105031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 105031036
		arg_146_1.duration_ = 2.1

		local var_146_0 = {
			ja = 1.833,
			ko = 2.1,
			zh = 1.733,
			en = 1.7
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
				arg_146_0:Play105031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.175

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(105031036)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 7
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031036", "story_v_out_105031.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031036", "story_v_out_105031.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_105031", "105031036", "story_v_out_105031.awb")

						arg_146_1:RecordAudio("105031036", var_149_9)
						arg_146_1:RecordAudio("105031036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_105031", "105031036", "story_v_out_105031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_105031", "105031036", "story_v_out_105031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play105031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 105031037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play105031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.95

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(105031037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 38
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play105031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 105031038
		arg_154_1.duration_ = 2.47

		local var_154_0 = {
			ja = 2.166,
			ko = 2.466,
			zh = 2.033,
			en = 2.3
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
				arg_154_0:Play105031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.225

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[6].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(105031038)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 9
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031038", "story_v_out_105031.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031038", "story_v_out_105031.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_105031", "105031038", "story_v_out_105031.awb")

						arg_154_1:RecordAudio("105031038", var_157_9)
						arg_154_1:RecordAudio("105031038", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_105031", "105031038", "story_v_out_105031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_105031", "105031038", "story_v_out_105031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play105031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 105031039
		arg_158_1.duration_ = 4.6

		local var_158_0 = {
			ja = 4.6,
			ko = 3.833,
			zh = 2.9,
			en = 3.466
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play105031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.375

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[5].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(105031039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 15
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031039", "story_v_out_105031.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031039", "story_v_out_105031.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_105031", "105031039", "story_v_out_105031.awb")

						arg_158_1:RecordAudio("105031039", var_161_9)
						arg_158_1:RecordAudio("105031039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_105031", "105031039", "story_v_out_105031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_105031", "105031039", "story_v_out_105031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play105031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 105031040
		arg_162_1.duration_ = 2.6

		local var_162_0 = {
			ja = 2.366,
			ko = 1.8,
			zh = 2.6,
			en = 1.8
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
				arg_162_0:Play105031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.2

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[37].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(105031040)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 8
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031040", "story_v_out_105031.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031040", "story_v_out_105031.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_105031", "105031040", "story_v_out_105031.awb")

						arg_162_1:RecordAudio("105031040", var_165_9)
						arg_162_1:RecordAudio("105031040", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_105031", "105031040", "story_v_out_105031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_105031", "105031040", "story_v_out_105031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play105031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 105031041
		arg_166_1.duration_ = 7.8

		local var_166_0 = {
			ja = 6.2,
			ko = 7.633,
			zh = 6.733,
			en = 7.8
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play105031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.85

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[13].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(105031041)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 34
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031041", "story_v_out_105031.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031041", "story_v_out_105031.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_105031", "105031041", "story_v_out_105031.awb")

						arg_166_1:RecordAudio("105031041", var_169_9)
						arg_166_1:RecordAudio("105031041", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_105031", "105031041", "story_v_out_105031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_105031", "105031041", "story_v_out_105031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play105031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 105031042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play105031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				local var_173_2 = "play"
				local var_173_3 = "effect"

				arg_170_1:AudioAction(var_173_2, var_173_3, "se_story_5", "se_story_5_brain", "")
			end

			local var_173_4 = 0
			local var_173_5 = 1

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				local var_173_6 = "play"
				local var_173_7 = "effect"

				arg_170_1:AudioAction(var_173_6, var_173_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_173_8 = arg_170_1.bgs_.S0501.transform
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.var_.moveOldPosS0501 = var_173_8.localPosition
			end

			local var_173_10 = 0.001

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 then
				local var_173_11 = (arg_170_1.time_ - var_173_9) / var_173_10
				local var_173_12 = Vector3.New(0, -100, 10)

				var_173_8.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPosS0501, var_173_12, var_173_11)
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 then
				var_173_8.localPosition = Vector3.New(0, -100, 10)
			end

			local var_173_13 = "STblack"

			if arg_170_1.bgs_[var_173_13] == nil then
				local var_173_14 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_173_13)
				var_173_14.name = var_173_13
				var_173_14.transform.parent = arg_170_1.stage_.transform
				var_173_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_[var_173_13] = var_173_14
			end

			local var_173_15 = 0

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				local var_173_16 = manager.ui.mainCamera.transform.localPosition
				local var_173_17 = Vector3.New(0, 0, 10) + Vector3.New(var_173_16.x, var_173_16.y, 0)
				local var_173_18 = arg_170_1.bgs_.STblack

				var_173_18.transform.localPosition = var_173_17
				var_173_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_19 = var_173_18:GetComponent("SpriteRenderer")

				if var_173_19 and var_173_19.sprite then
					local var_173_20 = (var_173_18.transform.localPosition - var_173_16).z
					local var_173_21 = manager.ui.mainCameraCom_
					local var_173_22 = 2 * var_173_20 * Mathf.Tan(var_173_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_173_23 = var_173_22 * var_173_21.aspect
					local var_173_24 = var_173_19.sprite.bounds.size.x
					local var_173_25 = var_173_19.sprite.bounds.size.y
					local var_173_26 = var_173_23 / var_173_24
					local var_173_27 = var_173_22 / var_173_25
					local var_173_28 = var_173_27 < var_173_26 and var_173_26 or var_173_27

					var_173_18.transform.localScale = Vector3.New(var_173_28, var_173_28, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "STblack" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_29 = 0
			local var_173_30 = 0.15

			if var_173_29 < arg_170_1.time_ and arg_170_1.time_ <= var_173_29 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_31 = arg_170_1:GetWordFromCfg(105031042)
				local var_173_32 = arg_170_1:FormatText(var_173_31.content)

				arg_170_1.text_.text = var_173_32

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_33 = 6
				local var_173_34 = utf8.len(var_173_32)
				local var_173_35 = var_173_33 <= 0 and var_173_30 or var_173_30 * (var_173_34 / var_173_33)

				if var_173_35 > 0 and var_173_30 < var_173_35 then
					arg_170_1.talkMaxDuration = var_173_35

					if var_173_35 + var_173_29 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_35 + var_173_29
					end
				end

				arg_170_1.text_.text = var_173_32
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_36 = math.max(var_173_30, arg_170_1.talkMaxDuration)

			if var_173_29 <= arg_170_1.time_ and arg_170_1.time_ < var_173_29 + var_173_36 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_29) / var_173_36

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_29 + var_173_36 and arg_170_1.time_ < var_173_29 + var_173_36 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play105031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 105031043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play105031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				local var_177_2 = "play"
				local var_177_3 = "effect"

				arg_174_1:AudioAction(var_177_2, var_177_3, "se_story_5", "se_story_5_cup", "")
			end

			local var_177_4 = arg_174_1.bgs_.STblack.transform
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.var_.moveOldPosSTblack = var_177_4.localPosition
			end

			local var_177_6 = 0.001

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6
				local var_177_8 = Vector3.New(0, -100, 10)

				var_177_4.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPosSTblack, var_177_8, var_177_7)
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 then
				var_177_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_177_9 = "A00"

			if arg_174_1.bgs_[var_177_9] == nil then
				local var_177_10 = Object.Instantiate(arg_174_1.paintGo_)

				var_177_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_177_9)
				var_177_10.name = var_177_9
				var_177_10.transform.parent = arg_174_1.stage_.transform
				var_177_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.bgs_[var_177_9] = var_177_10
			end

			local var_177_11 = 0

			if var_177_11 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				local var_177_12 = manager.ui.mainCamera.transform.localPosition
				local var_177_13 = Vector3.New(0, 0, 10) + Vector3.New(var_177_12.x, var_177_12.y, 0)
				local var_177_14 = arg_174_1.bgs_.A00

				var_177_14.transform.localPosition = var_177_13
				var_177_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_177_15 = var_177_14:GetComponent("SpriteRenderer")

				if var_177_15 and var_177_15.sprite then
					local var_177_16 = (var_177_14.transform.localPosition - var_177_12).z
					local var_177_17 = manager.ui.mainCameraCom_
					local var_177_18 = 2 * var_177_16 * Mathf.Tan(var_177_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_177_19 = var_177_18 * var_177_17.aspect
					local var_177_20 = var_177_15.sprite.bounds.size.x
					local var_177_21 = var_177_15.sprite.bounds.size.y
					local var_177_22 = var_177_19 / var_177_20
					local var_177_23 = var_177_18 / var_177_21
					local var_177_24 = var_177_23 < var_177_22 and var_177_22 or var_177_23

					var_177_14.transform.localScale = Vector3.New(var_177_24, var_177_24, 0)
				end

				for iter_177_0, iter_177_1 in pairs(arg_174_1.bgs_) do
					if iter_177_0 ~= "A00" then
						iter_177_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_177_25 = 0
			local var_177_26 = 0.025

			if var_177_25 < arg_174_1.time_ and arg_174_1.time_ <= var_177_25 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_27 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_27

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

				local var_177_28 = arg_174_1:GetWordFromCfg(105031043)
				local var_177_29 = arg_174_1:FormatText(var_177_28.content)

				arg_174_1.text_.text = var_177_29

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_30 = 1
				local var_177_31 = utf8.len(var_177_29)
				local var_177_32 = var_177_30 <= 0 and var_177_26 or var_177_26 * (var_177_31 / var_177_30)

				if var_177_32 > 0 and var_177_26 < var_177_32 then
					arg_174_1.talkMaxDuration = var_177_32

					if var_177_32 + var_177_25 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_32 + var_177_25
					end
				end

				arg_174_1.text_.text = var_177_29
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_33 = math.max(var_177_26, arg_174_1.talkMaxDuration)

			if var_177_25 <= arg_174_1.time_ and arg_174_1.time_ < var_177_25 + var_177_33 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_25) / var_177_33

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_25 + var_177_33 and arg_174_1.time_ < var_177_25 + var_177_33 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STblack",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play105031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 105031044
		arg_178_1.duration_ = 3.27

		local var_178_0 = {
			ja = 2.933,
			ko = 2.533,
			zh = 2.8,
			en = 3.266
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play105031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				local var_181_2 = "play"
				local var_181_3 = "music"

				arg_178_1:AudioAction(var_181_2, var_181_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_181_4 = ""
				local var_181_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_181_5 ~= "" then
					if arg_178_1.bgmTxt_.text ~= var_181_5 and arg_178_1.bgmTxt_.text ~= "" then
						if arg_178_1.bgmTxt2_.text ~= "" then
							arg_178_1.bgmTxt_.text = arg_178_1.bgmTxt2_.text
						end

						arg_178_1.bgmTxt2_.text = var_181_5

						arg_178_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_178_1.bgmTxt_.text = var_181_5
						arg_178_1.bgmTxt2_.text = var_181_5
					end

					if arg_178_1.bgmTimer then
						arg_178_1.bgmTimer:Stop()

						arg_178_1.bgmTimer = nil
					end

					if arg_178_1.settingData.show_music_name == 1 then
						arg_178_1.musicController:SetSelectedState("show")
						arg_178_1.musicAnimator_:Play("open", 0, 0)

						if arg_178_1.settingData.music_time ~= 0 then
							arg_178_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_178_1.settingData.music_time), function()
								if arg_178_1 == nil or isNil(arg_178_1.bgmTxt_) then
									return
								end

								arg_178_1.musicController:SetSelectedState("hide")
								arg_178_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_181_6 = 0
			local var_181_7 = 0.225

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_8 = arg_178_1:FormatText(StoryNameCfg[10].name)

				arg_178_1.leftNameTxt_.text = var_181_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_9 = arg_178_1:GetWordFromCfg(105031044)
				local var_181_10 = arg_178_1:FormatText(var_181_9.content)

				arg_178_1.text_.text = var_181_10

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 9
				local var_181_12 = utf8.len(var_181_10)
				local var_181_13 = var_181_11 <= 0 and var_181_7 or var_181_7 * (var_181_12 / var_181_11)

				if var_181_13 > 0 and var_181_7 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_10
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031044", "story_v_out_105031.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_105031", "105031044", "story_v_out_105031.awb") / 1000

					if var_181_14 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_6
					end

					if var_181_9.prefab_name ~= "" and arg_178_1.actors_[var_181_9.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_9.prefab_name].transform, "story_v_out_105031", "105031044", "story_v_out_105031.awb")

						arg_178_1:RecordAudio("105031044", var_181_15)
						arg_178_1:RecordAudio("105031044", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_105031", "105031044", "story_v_out_105031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_105031", "105031044", "story_v_out_105031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_16 and arg_178_1.time_ < var_181_6 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play105031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 105031045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play105031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.425

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(105031045)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 56
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play105031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 105031046
		arg_187_1.duration_ = 4.07

		local var_187_0 = {
			ja = 4.066,
			ko = 2.4,
			zh = 2.733,
			en = 3.266
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play105031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.325

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[10].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(105031046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 13
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031046", "story_v_out_105031.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031046", "story_v_out_105031.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_105031", "105031046", "story_v_out_105031.awb")

						arg_187_1:RecordAudio("105031046", var_190_9)
						arg_187_1:RecordAudio("105031046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_105031", "105031046", "story_v_out_105031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_105031", "105031046", "story_v_out_105031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play105031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 105031047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play105031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.2

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(105031047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 8
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play105031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 105031048
		arg_195_1.duration_ = 1.8

		local var_195_0 = {
			ja = 1.8,
			ko = 1.233,
			zh = 1.3,
			en = 1.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play105031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.1

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[10].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(105031048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 4
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031048", "story_v_out_105031.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031048", "story_v_out_105031.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_105031", "105031048", "story_v_out_105031.awb")

						arg_195_1:RecordAudio("105031048", var_198_9)
						arg_195_1:RecordAudio("105031048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_105031", "105031048", "story_v_out_105031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_105031", "105031048", "story_v_out_105031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play105031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 105031049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play105031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.8

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(105031049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 32
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play105031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 105031050
		arg_203_1.duration_ = 7.77

		local var_203_0 = {
			ja = 7.766,
			ko = 3.4,
			zh = 4.566,
			en = 5.766
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play105031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.65

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[10].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(105031050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 26
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031050", "story_v_out_105031.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_105031", "105031050", "story_v_out_105031.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_105031", "105031050", "story_v_out_105031.awb")

						arg_203_1:RecordAudio("105031050", var_206_9)
						arg_203_1:RecordAudio("105031050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_105031", "105031050", "story_v_out_105031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_105031", "105031050", "story_v_out_105031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play105031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 105031051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
			arg_207_1.auto_ = false
		end

		function arg_207_1.playNext_(arg_209_0)
			arg_207_1.onStoryFinished_()
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.45

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(105031051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 17
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0506a",
		"TextureConfig/Background/S0506",
		"TextureConfig/Background/B04f",
		"TextureConfig/Background/S0501",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_105031.awb"
	}
}
