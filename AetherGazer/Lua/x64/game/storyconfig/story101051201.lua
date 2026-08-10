return {
	Play105121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105121001
		arg_1_1.duration_ = 12.67

		local var_1_0 = {
			ja = 12.666,
			ko = 7.9,
			zh = 9.966,
			en = 12.2
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
				arg_1_0:Play105121002(arg_1_1)
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

			local var_4_6 = 2
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v0_environment_source", "se_story_v0_environment_source", "se_story_v0_environment_source")
			end

			local var_4_10 = 2
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story_5", "se_story_5_steamloop", "")
			end

			local var_4_14 = "B12a"

			if arg_1_1.bgs_[var_4_14] == nil then
				local var_4_15 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_14)
				var_4_15.name = var_4_14
				var_4_15.transform.parent = arg_1_1.stage_.transform
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_14] = var_4_15
			end

			local var_4_16 = arg_1_1.bgs_.B12a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueB12a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueB12a = var_4_18
				end

				arg_1_1.var_.alphaOldValueB12a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB12a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueB12a then
					local var_4_22 = arg_1_1.var_.alphaMatValueB12a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueB12a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueB12a then
				local var_4_23 = arg_1_1.var_.alphaMatValueB12a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = manager.ui.mainCamera.transform.localPosition
				local var_4_27 = Vector3.New(0, 0, 10) + Vector3.New(var_4_26.x, var_4_26.y, 0)
				local var_4_28 = arg_1_1.bgs_.B12a

				var_4_28.transform.localPosition = var_4_27
				var_4_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_29 = var_4_28:GetComponent("SpriteRenderer")

				if var_4_29 and var_4_29.sprite then
					local var_4_30 = (var_4_28.transform.localPosition - var_4_26).z
					local var_4_31 = manager.ui.mainCameraCom_
					local var_4_32 = 2 * var_4_30 * Mathf.Tan(var_4_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_33 = var_4_32 * var_4_31.aspect
					local var_4_34 = var_4_29.sprite.bounds.size.x
					local var_4_35 = var_4_29.sprite.bounds.size.y
					local var_4_36 = var_4_33 / var_4_34
					local var_4_37 = var_4_32 / var_4_35
					local var_4_38 = var_4_37 < var_4_36 and var_4_36 or var_4_37

					var_4_28.transform.localScale = Vector3.New(var_4_38, var_4_38, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B12a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_40 = 2

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_41 = 2
			local var_4_42 = 0.65

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_43 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_43:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_44 = arg_1_1:FormatText(StoryNameCfg[49].name)

				arg_1_1.leftNameTxt_.text = var_4_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_45 = arg_1_1:GetWordFromCfg(105121001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_47 = 25
				local var_4_48 = utf8.len(var_4_46)
				local var_4_49 = var_4_47 <= 0 and var_4_42 or var_4_42 * (var_4_48 / var_4_47)

				if var_4_49 > 0 and var_4_42 < var_4_49 then
					arg_1_1.talkMaxDuration = var_4_49
					var_4_41 = var_4_41 + 0.3

					if var_4_49 + var_4_41 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_41
					end
				end

				arg_1_1.text_.text = var_4_46
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121001", "story_v_out_105121.awb") ~= 0 then
					local var_4_50 = manager.audio:GetVoiceLength("story_v_out_105121", "105121001", "story_v_out_105121.awb") / 1000

					if var_4_50 + var_4_41 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_41
					end

					if var_4_45.prefab_name ~= "" and arg_1_1.actors_[var_4_45.prefab_name] ~= nil then
						local var_4_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_45.prefab_name].transform, "story_v_out_105121", "105121001", "story_v_out_105121.awb")

						arg_1_1:RecordAudio("105121001", var_4_51)
						arg_1_1:RecordAudio("105121001", var_4_51)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105121", "105121001", "story_v_out_105121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105121", "105121001", "story_v_out_105121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_41 + 0.3
			local var_4_53 = math.max(var_4_42, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105121002
		arg_8_1.duration_ = 1.27

		local var_8_0 = {
			ja = 1.133,
			ko = 1.166,
			zh = 1.266,
			en = 1.266
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play105121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.125

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[5].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(105121002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 5
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121002", "story_v_out_105121.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121002", "story_v_out_105121.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_105121", "105121002", "story_v_out_105121.awb")

						arg_8_1:RecordAudio("105121002", var_11_9)
						arg_8_1:RecordAudio("105121002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105121", "105121002", "story_v_out_105121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105121", "105121002", "story_v_out_105121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play105121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105121003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play105121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				local var_15_2 = "play"
				local var_15_3 = "effect"

				arg_12_1:AudioAction(var_15_2, var_15_3, "se_story_5", "se_story_5_bossarrow", "")
			end

			local var_15_4 = manager.ui.mainCamera.transform
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_4.localPosition
			end

			local var_15_6 = 0.6

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / 0.066
				local var_15_8, var_15_9 = math.modf(var_15_7)

				var_15_4.localPosition = Vector3.New(var_15_9 * 0.13, var_15_9 * 0.13, var_15_9 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				var_15_4.localPosition = arg_12_1.var_.shakeOldPos
			end

			local var_15_10 = 0
			local var_15_11 = 1.225

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(105121003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_14 = 49
				local var_15_15 = utf8.len(var_15_13)
				local var_15_16 = var_15_14 <= 0 and var_15_11 or var_15_11 * (var_15_15 / var_15_14)

				if var_15_16 > 0 and var_15_11 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_17 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_17

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_17 and arg_12_1.time_ < var_15_10 + var_15_17 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play105121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105121004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play105121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.275

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(105121004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 51
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play105121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105121005
		arg_20_1.duration_ = 16.08

		local var_20_0 = {
			ja = 16.083,
			ko = 5.95,
			zh = 8.95,
			en = 14.75
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play105121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = manager.ui.mainCamera.transform
			local var_23_1 = 0.25

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = var_23_0.localPosition
			end

			local var_23_2 = 0.6

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / 0.099
				local var_23_4, var_23_5 = math.modf(var_23_3)

				var_23_0.localPosition = Vector3.New(var_23_5 * 0.13, var_23_5 * 0.13, var_23_5 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = arg_20_1.var_.shakeOldPos
			end

			local var_23_6 = 0.25
			local var_23_7 = 0.75

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[49].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(105121005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 30
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121005", "story_v_out_105121.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121005", "story_v_out_105121.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_105121", "105121005", "story_v_out_105121.awb")

						arg_20_1:RecordAudio("105121005", var_23_15)
						arg_20_1:RecordAudio("105121005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105121", "105121005", "story_v_out_105121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105121", "105121005", "story_v_out_105121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play105121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105121006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play105121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1019ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1019ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(-0.7, -1.08, -5.9)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_27_20 = 0
			local var_27_21 = 0.175

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_22 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_23 = arg_24_1:GetWordFromCfg(105121006)
				local var_27_24 = arg_24_1:FormatText(var_27_23.content)

				arg_24_1.text_.text = var_27_24

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_25 = 7
				local var_27_26 = utf8.len(var_27_24)
				local var_27_27 = var_27_25 <= 0 and var_27_21 or var_27_21 * (var_27_26 / var_27_25)

				if var_27_27 > 0 and var_27_21 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27

					if var_27_27 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_20
					end
				end

				arg_24_1.text_.text = var_27_24
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121006", "story_v_out_105121.awb") ~= 0 then
					local var_27_28 = manager.audio:GetVoiceLength("story_v_out_105121", "105121006", "story_v_out_105121.awb") / 1000

					if var_27_28 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_28 + var_27_20
					end

					if var_27_23.prefab_name ~= "" and arg_24_1.actors_[var_27_23.prefab_name] ~= nil then
						local var_27_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_23.prefab_name].transform, "story_v_out_105121", "105121006", "story_v_out_105121.awb")

						arg_24_1:RecordAudio("105121006", var_27_29)
						arg_24_1:RecordAudio("105121006", var_27_29)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105121", "105121006", "story_v_out_105121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105121", "105121006", "story_v_out_105121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_30 = math.max(var_27_21, arg_24_1.talkMaxDuration)

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_20) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_20 + var_27_30 and arg_24_1.time_ < var_27_20 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play105121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105121007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1084ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1084ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["1019ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1019ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_15.localPosition

				local var_31_17 = "1084ui_story"

				arg_28_1:ShowWeapon(arg_28_1.var_[var_31_17 .. "Animator"].transform, true)
			end

			local var_31_18 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_18 then
				local var_31_19 = (arg_28_1.time_ - var_31_16) / var_31_18
				local var_31_20 = Vector3.New(0.7, -0.97, -6)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_20, var_31_19)

				local var_31_21 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_21.x, var_31_21.y, var_31_21.z)

				local var_31_22 = var_31_15.localEulerAngles

				var_31_22.z = 0
				var_31_22.x = 0
				var_31_15.localEulerAngles = var_31_22
			end

			if arg_28_1.time_ >= var_31_16 + var_31_18 and arg_28_1.time_ < var_31_16 + var_31_18 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_31_23 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_23.x, var_31_23.y, var_31_23.z)

				local var_31_24 = var_31_15.localEulerAngles

				var_31_24.z = 0
				var_31_24.x = 0
				var_31_15.localEulerAngles = var_31_24
			end

			local var_31_25 = 0

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_31_26 = 0

			if var_31_26 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_27 = 0
			local var_31_28 = 0.125

			if var_31_27 < arg_28_1.time_ and arg_28_1.time_ <= var_31_27 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_29 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_30 = arg_28_1:GetWordFromCfg(105121007)
				local var_31_31 = arg_28_1:FormatText(var_31_30.content)

				arg_28_1.text_.text = var_31_31

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_32 = 5
				local var_31_33 = utf8.len(var_31_31)
				local var_31_34 = var_31_32 <= 0 and var_31_28 or var_31_28 * (var_31_33 / var_31_32)

				if var_31_34 > 0 and var_31_28 < var_31_34 then
					arg_28_1.talkMaxDuration = var_31_34

					if var_31_34 + var_31_27 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_34 + var_31_27
					end
				end

				arg_28_1.text_.text = var_31_31
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121007", "story_v_out_105121.awb") ~= 0 then
					local var_31_35 = manager.audio:GetVoiceLength("story_v_out_105121", "105121007", "story_v_out_105121.awb") / 1000

					if var_31_35 + var_31_27 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_35 + var_31_27
					end

					if var_31_30.prefab_name ~= "" and arg_28_1.actors_[var_31_30.prefab_name] ~= nil then
						local var_31_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_30.prefab_name].transform, "story_v_out_105121", "105121007", "story_v_out_105121.awb")

						arg_28_1:RecordAudio("105121007", var_31_36)
						arg_28_1:RecordAudio("105121007", var_31_36)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_105121", "105121007", "story_v_out_105121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_105121", "105121007", "story_v_out_105121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_37 = math.max(var_31_28, arg_28_1.talkMaxDuration)

			if var_31_27 <= arg_28_1.time_ and arg_28_1.time_ < var_31_27 + var_31_37 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_27) / var_31_37

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_27 + var_31_37 and arg_28_1.time_ < var_31_27 + var_31_37 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play105121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105121008
		arg_32_1.duration_ = 5.6

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play105121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				local var_35_2 = "play"
				local var_35_3 = "effect"

				arg_32_1:AudioAction(var_35_2, var_35_3, "se_story_5", "se_story_5_bosscollapse", "")
			end

			local var_35_4 = 0
			local var_35_5 = 1

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				local var_35_6 = "play"
				local var_35_7 = "effect"

				arg_32_1:AudioAction(var_35_6, var_35_7, "se_story_5", "se_story_5_bossflee", "")
			end

			local var_35_8 = manager.ui.mainCamera.transform
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.var_.shakeOldPosMainCamera = var_35_8.localPosition
			end

			local var_35_10 = 0.600000023841858

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / 0.066
				local var_35_12, var_35_13 = math.modf(var_35_11)

				var_35_8.localPosition = Vector3.New(var_35_13 * 0.13, var_35_13 * 0.13, var_35_13 * 0.13) + arg_32_1.var_.shakeOldPosMainCamera
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = arg_32_1.var_.shakeOldPosMainCamera
			end

			local var_35_14 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_14.localPosition
			end

			local var_35_16 = 0.001

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16
				local var_35_18 = Vector3.New(0, 100, 0)

				var_35_14.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_18, var_35_17)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_14.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_14.localEulerAngles = var_35_20
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 then
				var_35_14.localPosition = Vector3.New(0, 100, 0)

				local var_35_21 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_21.x, var_35_21.y, var_35_21.z)

				local var_35_22 = var_35_14.localEulerAngles

				var_35_22.z = 0
				var_35_22.x = 0
				var_35_14.localEulerAngles = var_35_22
			end

			local var_35_23 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_23.localPosition

				local var_35_25 = "1084ui_story"

				arg_32_1:ShowWeapon(arg_32_1.var_[var_35_25 .. "Animator"].transform, false)
			end

			local var_35_26 = 0.001

			if var_35_24 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_26 then
				local var_35_27 = (arg_32_1.time_ - var_35_24) / var_35_26
				local var_35_28 = Vector3.New(0, 100, 0)

				var_35_23.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_28, var_35_27)

				local var_35_29 = manager.ui.mainCamera.transform.position - var_35_23.position

				var_35_23.forward = Vector3.New(var_35_29.x, var_35_29.y, var_35_29.z)

				local var_35_30 = var_35_23.localEulerAngles

				var_35_30.z = 0
				var_35_30.x = 0
				var_35_23.localEulerAngles = var_35_30
			end

			if arg_32_1.time_ >= var_35_24 + var_35_26 and arg_32_1.time_ < var_35_24 + var_35_26 + arg_35_0 then
				var_35_23.localPosition = Vector3.New(0, 100, 0)

				local var_35_31 = manager.ui.mainCamera.transform.position - var_35_23.position

				var_35_23.forward = Vector3.New(var_35_31.x, var_35_31.y, var_35_31.z)

				local var_35_32 = var_35_23.localEulerAngles

				var_35_32.z = 0
				var_35_32.x = 0
				var_35_23.localEulerAngles = var_35_32
			end

			local var_35_33 = 0

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_34 = 0.5

			if var_35_33 <= arg_32_1.time_ and arg_32_1.time_ < var_35_33 + var_35_34 then
				local var_35_35 = (arg_32_1.time_ - var_35_33) / var_35_34
				local var_35_36 = Color.New(1, 1, 1)

				var_35_36.a = Mathf.Lerp(1, 0, var_35_35)
				arg_32_1.mask_.color = var_35_36
			end

			if arg_32_1.time_ >= var_35_33 + var_35_34 and arg_32_1.time_ < var_35_33 + var_35_34 + arg_35_0 then
				local var_35_37 = Color.New(1, 1, 1)
				local var_35_38 = 0

				arg_32_1.mask_.enabled = false
				var_35_37.a = var_35_38
				arg_32_1.mask_.color = var_35_37
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_39 = 0.600000023841858
			local var_35_40 = 0.65

			if var_35_39 < arg_32_1.time_ and arg_32_1.time_ <= var_35_39 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_41 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_41:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_42 = arg_32_1:GetWordFromCfg(105121008)
				local var_35_43 = arg_32_1:FormatText(var_35_42.content)

				arg_32_1.text_.text = var_35_43

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_44 = 26
				local var_35_45 = utf8.len(var_35_43)
				local var_35_46 = var_35_44 <= 0 and var_35_40 or var_35_40 * (var_35_45 / var_35_44)

				if var_35_46 > 0 and var_35_40 < var_35_46 then
					arg_32_1.talkMaxDuration = var_35_46
					var_35_39 = var_35_39 + 0.3

					if var_35_46 + var_35_39 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_46 + var_35_39
					end
				end

				arg_32_1.text_.text = var_35_43
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_47 = var_35_39 + 0.3
			local var_35_48 = math.max(var_35_40, arg_32_1.talkMaxDuration)

			if var_35_47 <= arg_32_1.time_ and arg_32_1.time_ < var_35_47 + var_35_48 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_47) / var_35_48

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_47 + var_35_48 and arg_32_1.time_ < var_35_47 + var_35_48 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play105121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 105121009
		arg_38_1.duration_ = 6

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play105121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = false

				arg_38_1:SetGaussion(false)
			end

			local var_41_1 = 1

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_1 then
				local var_41_2 = (arg_38_1.time_ - var_41_0) / var_41_1
				local var_41_3 = Color.New(1, 1, 1)

				var_41_3.a = Mathf.Lerp(0, 1, var_41_2)
				arg_38_1.mask_.color = var_41_3
			end

			if arg_38_1.time_ >= var_41_0 + var_41_1 and arg_38_1.time_ < var_41_0 + var_41_1 + arg_41_0 then
				local var_41_4 = Color.New(1, 1, 1)

				var_41_4.a = 1
				arg_38_1.mask_.color = var_41_4
			end

			local var_41_5 = 1

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = false

				arg_38_1:SetGaussion(false)
			end

			local var_41_6 = 1

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6
				local var_41_8 = Color.New(1, 1, 1)

				var_41_8.a = Mathf.Lerp(1, 0, var_41_7)
				arg_38_1.mask_.color = var_41_8
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 then
				local var_41_9 = Color.New(1, 1, 1)
				local var_41_10 = 0

				arg_38_1.mask_.enabled = false
				var_41_9.a = var_41_10
				arg_38_1.mask_.color = var_41_9
			end

			local var_41_11 = "S0505"

			if arg_38_1.bgs_[var_41_11] == nil then
				local var_41_12 = Object.Instantiate(arg_38_1.paintGo_)

				var_41_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_41_11)
				var_41_12.name = var_41_11
				var_41_12.transform.parent = arg_38_1.stage_.transform
				var_41_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.bgs_[var_41_11] = var_41_12
			end

			local var_41_13 = 1

			if var_41_13 < arg_38_1.time_ and arg_38_1.time_ <= var_41_13 + arg_41_0 then
				local var_41_14 = manager.ui.mainCamera.transform.localPosition
				local var_41_15 = Vector3.New(0, 0, 10) + Vector3.New(var_41_14.x, var_41_14.y, 0)
				local var_41_16 = arg_38_1.bgs_.S0505

				var_41_16.transform.localPosition = var_41_15
				var_41_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_17 = var_41_16:GetComponent("SpriteRenderer")

				if var_41_17 and var_41_17.sprite then
					local var_41_18 = (var_41_16.transform.localPosition - var_41_14).z
					local var_41_19 = manager.ui.mainCameraCom_
					local var_41_20 = 2 * var_41_18 * Mathf.Tan(var_41_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_21 = var_41_20 * var_41_19.aspect
					local var_41_22 = var_41_17.sprite.bounds.size.x
					local var_41_23 = var_41_17.sprite.bounds.size.y
					local var_41_24 = var_41_21 / var_41_22
					local var_41_25 = var_41_20 / var_41_23
					local var_41_26 = var_41_25 < var_41_24 and var_41_24 or var_41_25

					var_41_16.transform.localScale = Vector3.New(var_41_26, var_41_26, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "S0505" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_27 = 1
			local var_41_28 = 1.55

			if var_41_27 < arg_38_1.time_ and arg_38_1.time_ <= var_41_27 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_29 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_29:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_30 = arg_38_1:GetWordFromCfg(105121009)
				local var_41_31 = arg_38_1:FormatText(var_41_30.content)

				arg_38_1.text_.text = var_41_31

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_32 = 62
				local var_41_33 = utf8.len(var_41_31)
				local var_41_34 = var_41_32 <= 0 and var_41_28 or var_41_28 * (var_41_33 / var_41_32)

				if var_41_34 > 0 and var_41_28 < var_41_34 then
					arg_38_1.talkMaxDuration = var_41_34
					var_41_27 = var_41_27 + 0.3

					if var_41_34 + var_41_27 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_34 + var_41_27
					end
				end

				arg_38_1.text_.text = var_41_31
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_35 = var_41_27 + 0.3
			local var_41_36 = math.max(var_41_28, arg_38_1.talkMaxDuration)

			if var_41_35 <= arg_38_1.time_ and arg_38_1.time_ < var_41_35 + var_41_36 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_35) / var_41_36

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_35 + var_41_36 and arg_38_1.time_ < var_41_35 + var_41_36 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play105121010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105121010
		arg_44_1.duration_ = 10.67

		local var_44_0 = {
			ja = 10.666,
			ko = 5.5,
			zh = 8.133,
			en = 9.466
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play105121011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.575

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[49].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(105121010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 23
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121010", "story_v_out_105121.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121010", "story_v_out_105121.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_105121", "105121010", "story_v_out_105121.awb")

						arg_44_1:RecordAudio("105121010", var_47_9)
						arg_44_1:RecordAudio("105121010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_105121", "105121010", "story_v_out_105121.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_105121", "105121010", "story_v_out_105121.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play105121011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105121011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105121012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_2 = "play"
				local var_51_3 = "effect"

				arg_48_1:AudioAction(var_51_2, var_51_3, "se_story_5", "se_story_5_spear", "")
			end

			local var_51_4 = 0
			local var_51_5 = 1.925

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(105121011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_8 = 77
				local var_51_9 = utf8.len(var_51_7)
				local var_51_10 = var_51_8 <= 0 and var_51_5 or var_51_5 * (var_51_9 / var_51_8)

				if var_51_10 > 0 and var_51_5 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_11 and arg_48_1.time_ < var_51_4 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play105121012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105121012
		arg_52_1.duration_ = 10.5

		local var_52_0 = {
			ja = 9,
			ko = 5,
			zh = 9.433,
			en = 10.5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play105121013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_1 = 0.5

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_1 then
				local var_55_2 = (arg_52_1.time_ - var_55_0) / var_55_1
				local var_55_3 = Color.New(1, 1, 1)

				var_55_3.a = Mathf.Lerp(1, 0, var_55_2)
				arg_52_1.mask_.color = var_55_3
			end

			if arg_52_1.time_ >= var_55_0 + var_55_1 and arg_52_1.time_ < var_55_0 + var_55_1 + arg_55_0 then
				local var_55_4 = Color.New(1, 1, 1)
				local var_55_5 = 0

				arg_52_1.mask_.enabled = false
				var_55_4.a = var_55_5
				arg_52_1.mask_.color = var_55_4
			end

			local var_55_6 = manager.ui.mainCamera.transform
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.var_.shakeOldPosMainCamera = var_55_6.localPosition
			end

			local var_55_8 = 0.600000023841858

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / 0.066
				local var_55_10, var_55_11 = math.modf(var_55_9)

				var_55_6.localPosition = Vector3.New(var_55_11 * 0.13, var_55_11 * 0.13, var_55_11 * 0.13) + arg_52_1.var_.shakeOldPosMainCamera
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 then
				var_55_6.localPosition = arg_52_1.var_.shakeOldPosMainCamera
			end

			local var_55_12 = 0.5
			local var_55_13 = 0.4

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[49].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_15 = arg_52_1:GetWordFromCfg(105121012)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 16
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121012", "story_v_out_105121.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121012", "story_v_out_105121.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_105121", "105121012", "story_v_out_105121.awb")

						arg_52_1:RecordAudio("105121012", var_55_21)
						arg_52_1:RecordAudio("105121012", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_105121", "105121012", "story_v_out_105121.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_105121", "105121012", "story_v_out_105121.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play105121013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105121013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105121014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_2 = "play"
				local var_59_3 = "effect"

				arg_56_1:AudioAction(var_59_2, var_59_3, "se_story_5", "se_story_5_sword", "")
			end

			local var_59_4 = 0
			local var_59_5 = 1.875

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(105121013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 75
				local var_59_9 = utf8.len(var_59_7)
				local var_59_10 = var_59_8 <= 0 and var_59_5 or var_59_5 * (var_59_9 / var_59_8)

				if var_59_10 > 0 and var_59_5 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_11 and arg_56_1.time_ < var_59_4 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play105121014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105121014
		arg_60_1.duration_ = 3.97

		local var_60_0 = {
			ja = 3.166,
			ko = 3.3,
			zh = 3.1,
			en = 3.966
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play105121015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.375

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_1 = 0.5

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_1 then
				local var_63_2 = (arg_60_1.time_ - var_63_0) / var_63_1
				local var_63_3 = Color.New(1, 1, 1)

				var_63_3.a = Mathf.Lerp(1, 0, var_63_2)
				arg_60_1.mask_.color = var_63_3
			end

			if arg_60_1.time_ >= var_63_0 + var_63_1 and arg_60_1.time_ < var_63_0 + var_63_1 + arg_63_0 then
				local var_63_4 = Color.New(1, 1, 1)
				local var_63_5 = 0

				arg_60_1.mask_.enabled = false
				var_63_4.a = var_63_5
				arg_60_1.mask_.color = var_63_4
			end

			local var_63_6 = manager.ui.mainCamera.transform
			local var_63_7 = 0.375

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.var_.shakeOldPosMainCamera = var_63_6.localPosition
			end

			local var_63_8 = 0.600000023841858

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_7) / 0.066
				local var_63_10, var_63_11 = math.modf(var_63_9)

				var_63_6.localPosition = Vector3.New(var_63_11 * 0.13, var_63_11 * 0.13, var_63_11 * 0.13) + arg_60_1.var_.shakeOldPosMainCamera
			end

			if arg_60_1.time_ >= var_63_7 + var_63_8 and arg_60_1.time_ < var_63_7 + var_63_8 + arg_63_0 then
				var_63_6.localPosition = arg_60_1.var_.shakeOldPosMainCamera
			end

			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_63_13 = 0
			local var_63_14 = 0.375

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_15 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_16 = arg_60_1:GetWordFromCfg(105121014)
				local var_63_17 = arg_60_1:FormatText(var_63_16.content)

				arg_60_1.text_.text = var_63_17

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_18 = 15
				local var_63_19 = utf8.len(var_63_17)
				local var_63_20 = var_63_18 <= 0 and var_63_14 or var_63_14 * (var_63_19 / var_63_18)

				if var_63_20 > 0 and var_63_14 < var_63_20 then
					arg_60_1.talkMaxDuration = var_63_20

					if var_63_20 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_13
					end
				end

				arg_60_1.text_.text = var_63_17
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121014", "story_v_out_105121.awb") ~= 0 then
					local var_63_21 = manager.audio:GetVoiceLength("story_v_out_105121", "105121014", "story_v_out_105121.awb") / 1000

					if var_63_21 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_13
					end

					if var_63_16.prefab_name ~= "" and arg_60_1.actors_[var_63_16.prefab_name] ~= nil then
						local var_63_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_16.prefab_name].transform, "story_v_out_105121", "105121014", "story_v_out_105121.awb")

						arg_60_1:RecordAudio("105121014", var_63_22)
						arg_60_1:RecordAudio("105121014", var_63_22)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_105121", "105121014", "story_v_out_105121.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_105121", "105121014", "story_v_out_105121.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_23 = math.max(var_63_14, arg_60_1.talkMaxDuration)

			if var_63_13 <= arg_60_1.time_ and arg_60_1.time_ < var_63_13 + var_63_23 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_13) / var_63_23

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_13 + var_63_23 and arg_60_1.time_ < var_63_13 + var_63_23 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play105121015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 105121015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play105121016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_67_4 = 0
			local var_67_5 = 1.225

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(105121015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 49
				local var_67_9 = utf8.len(var_67_7)
				local var_67_10 = var_67_8 <= 0 and var_67_5 or var_67_5 * (var_67_9 / var_67_8)

				if var_67_10 > 0 and var_67_5 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_11 and arg_64_1.time_ < var_67_4 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play105121016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 105121016
		arg_68_1.duration_ = 4.4

		local var_68_0 = {
			ja = 4.4,
			ko = 3.2,
			zh = 3.333,
			en = 3.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play105121017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_71_1 = 0
			local var_71_2 = 0.425

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_3 = arg_68_1:FormatText(StoryNameCfg[13].name)

				arg_68_1.leftNameTxt_.text = var_71_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_4 = arg_68_1:GetWordFromCfg(105121016)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 17
				local var_71_7 = utf8.len(var_71_5)
				local var_71_8 = var_71_6 <= 0 and var_71_2 or var_71_2 * (var_71_7 / var_71_6)

				if var_71_8 > 0 and var_71_2 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121016", "story_v_out_105121.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_105121", "105121016", "story_v_out_105121.awb") / 1000

					if var_71_9 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_1
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_105121", "105121016", "story_v_out_105121.awb")

						arg_68_1:RecordAudio("105121016", var_71_10)
						arg_68_1:RecordAudio("105121016", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_105121", "105121016", "story_v_out_105121.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_105121", "105121016", "story_v_out_105121.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_11 and arg_68_1.time_ < var_71_1 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play105121017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 105121017
		arg_72_1.duration_ = 7.33

		local var_72_0 = {
			ja = 6.966,
			ko = 5.1,
			zh = 5.166,
			en = 7.333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play105121018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.575

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_1 = 0.5

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_1 then
				local var_75_2 = (arg_72_1.time_ - var_75_0) / var_75_1
				local var_75_3 = Color.New(1, 1, 1)

				var_75_3.a = Mathf.Lerp(1, 0, var_75_2)
				arg_72_1.mask_.color = var_75_3
			end

			if arg_72_1.time_ >= var_75_0 + var_75_1 and arg_72_1.time_ < var_75_0 + var_75_1 + arg_75_0 then
				local var_75_4 = Color.New(1, 1, 1)
				local var_75_5 = 0

				arg_72_1.mask_.enabled = false
				var_75_4.a = var_75_5
				arg_72_1.mask_.color = var_75_4
			end

			local var_75_6 = manager.ui.mainCamera.transform
			local var_75_7 = 0.575

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.shakeOldPosMainCamera = var_75_6.localPosition
			end

			local var_75_8 = 0.600000023841858

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / 0.066
				local var_75_10, var_75_11 = math.modf(var_75_9)

				var_75_6.localPosition = Vector3.New(var_75_11 * 0.13, var_75_11 * 0.13, var_75_11 * 0.13) + arg_72_1.var_.shakeOldPosMainCamera
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = arg_72_1.var_.shakeOldPosMainCamera
			end

			local var_75_12 = 0
			local var_75_13 = 0.575

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_15 = arg_72_1:GetWordFromCfg(105121017)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 23
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121017", "story_v_out_105121.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121017", "story_v_out_105121.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_105121", "105121017", "story_v_out_105121.awb")

						arg_72_1:RecordAudio("105121017", var_75_21)
						arg_72_1:RecordAudio("105121017", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_105121", "105121017", "story_v_out_105121.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_105121", "105121017", "story_v_out_105121.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play105121018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 105121018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play105121019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				local var_79_2 = "play"
				local var_79_3 = "effect"

				arg_76_1:AudioAction(var_79_2, var_79_3, "se_story_5", "se_story_5_lastcharge", "")
			end

			local var_79_4 = 0
			local var_79_5 = 0.4

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(105121018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_8 = 16
				local var_79_9 = utf8.len(var_79_7)
				local var_79_10 = var_79_8 <= 0 and var_79_5 or var_79_5 * (var_79_9 / var_79_8)

				if var_79_10 > 0 and var_79_5 < var_79_10 then
					arg_76_1.talkMaxDuration = var_79_10

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_11 and arg_76_1.time_ < var_79_4 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play105121019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 105121019
		arg_80_1.duration_ = 6.5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play105121020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_2 = "play"
				local var_83_3 = "effect"

				arg_80_1:AudioAction(var_83_2, var_83_3, "se_story_5", "se_story_5_laststrike", "")
			end

			local var_83_4 = 0
			local var_83_5 = 1

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				local var_83_6 = "stop"
				local var_83_7 = "effect"

				arg_80_1:AudioAction(var_83_6, var_83_7, "se_story_5", "se_story_5_steamloop", "")
			end

			local var_83_8 = 0
			local var_83_9 = 1

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				local var_83_10 = "stop"
				local var_83_11 = "effect"

				arg_80_1:AudioAction(var_83_10, var_83_11, "se_story_5", "se_story_5_bossflee", "")
			end

			local var_83_12 = 0
			local var_83_13 = 1

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				local var_83_14 = "stop"
				local var_83_15 = "effect"

				arg_80_1:AudioAction(var_83_14, var_83_15, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_17 = 1.5

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Color.New(1, 1, 1)

				var_83_19.a = Mathf.Lerp(0, 1, var_83_18)
				arg_80_1.mask_.color = var_83_19
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				local var_83_20 = Color.New(1, 1, 1)

				var_83_20.a = 1
				arg_80_1.mask_.color = var_83_20
			end

			local var_83_21 = 1.49999999999999

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = false

				arg_80_1:SetGaussion(false)
			end

			local var_83_22 = 1.5

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_22 then
				local var_83_23 = (arg_80_1.time_ - var_83_21) / var_83_22
				local var_83_24 = Color.New(1, 1, 1)

				var_83_24.a = Mathf.Lerp(1, 0, var_83_23)
				arg_80_1.mask_.color = var_83_24
			end

			if arg_80_1.time_ >= var_83_21 + var_83_22 and arg_80_1.time_ < var_83_21 + var_83_22 + arg_83_0 then
				local var_83_25 = Color.New(1, 1, 1)
				local var_83_26 = 0

				arg_80_1.mask_.enabled = false
				var_83_25.a = var_83_26
				arg_80_1.mask_.color = var_83_25
			end

			local var_83_27 = manager.ui.mainCamera.transform
			local var_83_28 = 0

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1.var_.shakeOldPosMainCamera = var_83_27.localPosition
			end

			local var_83_29 = 0.600000023841858

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_29 then
				local var_83_30 = (arg_80_1.time_ - var_83_28) / 0.066
				local var_83_31, var_83_32 = math.modf(var_83_30)

				var_83_27.localPosition = Vector3.New(var_83_32 * 0.13, var_83_32 * 0.13, var_83_32 * 0.13) + arg_80_1.var_.shakeOldPosMainCamera
			end

			if arg_80_1.time_ >= var_83_28 + var_83_29 and arg_80_1.time_ < var_83_28 + var_83_29 + arg_83_0 then
				var_83_27.localPosition = arg_80_1.var_.shakeOldPosMainCamera
			end

			local var_83_33 = arg_80_1.bgs_.S0505.transform
			local var_83_34 = 1.5

			if var_83_34 < arg_80_1.time_ and arg_80_1.time_ <= var_83_34 + arg_83_0 then
				arg_80_1.var_.moveOldPosS0505 = var_83_33.localPosition
			end

			local var_83_35 = 0.001

			if var_83_34 <= arg_80_1.time_ and arg_80_1.time_ < var_83_34 + var_83_35 then
				local var_83_36 = (arg_80_1.time_ - var_83_34) / var_83_35
				local var_83_37 = Vector3.New(0, -100, 0)

				var_83_33.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosS0505, var_83_37, var_83_36)
			end

			if arg_80_1.time_ >= var_83_34 + var_83_35 and arg_80_1.time_ < var_83_34 + var_83_35 + arg_83_0 then
				var_83_33.localPosition = Vector3.New(0, -100, 0)
			end

			local var_83_38 = "STwhite"

			if arg_80_1.bgs_[var_83_38] == nil then
				local var_83_39 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_39:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_83_38)
				var_83_39.name = var_83_38
				var_83_39.transform.parent = arg_80_1.stage_.transform
				var_83_39.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_[var_83_38] = var_83_39
			end

			local var_83_40 = arg_80_1.bgs_.STwhite.transform
			local var_83_41 = 1.5

			if var_83_41 < arg_80_1.time_ and arg_80_1.time_ <= var_83_41 + arg_83_0 then
				arg_80_1.var_.moveOldPosSTwhite = var_83_40.localPosition
				var_83_40.localScale = Vector3.New(12, 12, 12)
			end

			local var_83_42 = 0.001

			if var_83_41 <= arg_80_1.time_ and arg_80_1.time_ < var_83_41 + var_83_42 then
				local var_83_43 = (arg_80_1.time_ - var_83_41) / var_83_42
				local var_83_44 = Vector3.New(0, 0, 0)

				var_83_40.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosSTwhite, var_83_44, var_83_43)
			end

			if arg_80_1.time_ >= var_83_41 + var_83_42 and arg_80_1.time_ < var_83_41 + var_83_42 + arg_83_0 then
				var_83_40.localPosition = Vector3.New(0, 0, 0)
			end

			local var_83_45 = 0

			if var_83_45 < arg_80_1.time_ and arg_80_1.time_ <= var_83_45 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_46 = 1.49999999999999

			if arg_80_1.time_ >= var_83_45 + var_83_46 and arg_80_1.time_ < var_83_45 + var_83_46 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_47 = 1.5
			local var_83_48 = 1.375

			if var_83_47 < arg_80_1.time_ and arg_80_1.time_ <= var_83_47 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_49 = arg_80_1:GetWordFromCfg(105121019)
				local var_83_50 = arg_80_1:FormatText(var_83_49.content)

				arg_80_1.text_.text = var_83_50

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_51 = 55
				local var_83_52 = utf8.len(var_83_50)
				local var_83_53 = var_83_51 <= 0 and var_83_48 or var_83_48 * (var_83_52 / var_83_51)

				if var_83_53 > 0 and var_83_48 < var_83_53 then
					arg_80_1.talkMaxDuration = var_83_53

					if var_83_53 + var_83_47 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_53 + var_83_47
					end
				end

				arg_80_1.text_.text = var_83_50
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_54 = math.max(var_83_48, arg_80_1.talkMaxDuration)

			if var_83_47 <= arg_80_1.time_ and arg_80_1.time_ < var_83_47 + var_83_54 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_47) / var_83_54

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_47 + var_83_54 and arg_80_1.time_ < var_83_47 + var_83_54 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0505",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
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

		arg_80_1:InitPlayNodeList()
	end,
	Play105121020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 105121020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play105121021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_2 = "play"
				local var_87_3 = "effect"

				arg_84_1:AudioAction(var_87_2, var_87_3, "se_story_ui", "se_story_stopenv", "")
			end

			local var_87_4 = 0
			local var_87_5 = 0.05

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(105121020)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_8 = 2
				local var_87_9 = utf8.len(var_87_7)
				local var_87_10 = var_87_8 <= 0 and var_87_5 or var_87_5 * (var_87_9 / var_87_8)

				if var_87_10 > 0 and var_87_5 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_11 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_11 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_11

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_11 and arg_84_1.time_ < var_87_4 + var_87_11 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play105121021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 105121021
		arg_88_1.duration_ = 6.5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play105121022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.5
			local var_91_1 = 1

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "play"
				local var_91_3 = "effect"

				arg_88_1:AudioAction(var_91_2, var_91_3, "se_story_5", "se_story_5_back", "")
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 1.5

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = (arg_88_1.time_ - var_91_4) / var_91_5
				local var_91_7 = Color.New(1, 1, 1)

				var_91_7.a = Mathf.Lerp(1, 0, var_91_6)
				arg_88_1.mask_.color = var_91_7
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_8 = Color.New(1, 1, 1)
				local var_91_9 = 0

				arg_88_1.mask_.enabled = false
				var_91_8.a = var_91_9
				arg_88_1.mask_.color = var_91_8
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				local var_91_11 = manager.ui.mainCamera.transform.localPosition
				local var_91_12 = Vector3.New(0, 0, 10) + Vector3.New(var_91_11.x, var_91_11.y, 0)
				local var_91_13 = arg_88_1.bgs_.B12a

				var_91_13.transform.localPosition = var_91_12
				var_91_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_14 = var_91_13:GetComponent("SpriteRenderer")

				if var_91_14 and var_91_14.sprite then
					local var_91_15 = (var_91_13.transform.localPosition - var_91_11).z
					local var_91_16 = manager.ui.mainCameraCom_
					local var_91_17 = 2 * var_91_15 * Mathf.Tan(var_91_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_18 = var_91_17 * var_91_16.aspect
					local var_91_19 = var_91_14.sprite.bounds.size.x
					local var_91_20 = var_91_14.sprite.bounds.size.y
					local var_91_21 = var_91_18 / var_91_19
					local var_91_22 = var_91_17 / var_91_20
					local var_91_23 = var_91_22 < var_91_21 and var_91_21 or var_91_22

					var_91_13.transform.localScale = Vector3.New(var_91_23, var_91_23, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "B12a" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_24 = 1.5
			local var_91_25 = 0.625

			if var_91_24 < arg_88_1.time_ and arg_88_1.time_ <= var_91_24 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_26 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_26:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_27 = arg_88_1:GetWordFromCfg(105121021)
				local var_91_28 = arg_88_1:FormatText(var_91_27.content)

				arg_88_1.text_.text = var_91_28

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_29 = 25
				local var_91_30 = utf8.len(var_91_28)
				local var_91_31 = var_91_29 <= 0 and var_91_25 or var_91_25 * (var_91_30 / var_91_29)

				if var_91_31 > 0 and var_91_25 < var_91_31 then
					arg_88_1.talkMaxDuration = var_91_31
					var_91_24 = var_91_24 + 0.3

					if var_91_31 + var_91_24 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_31 + var_91_24
					end
				end

				arg_88_1.text_.text = var_91_28
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_32 = var_91_24 + 0.3
			local var_91_33 = math.max(var_91_25, arg_88_1.talkMaxDuration)

			if var_91_32 <= arg_88_1.time_ and arg_88_1.time_ < var_91_32 + var_91_33 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_32) / var_91_33

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_32 + var_91_33 and arg_88_1.time_ < var_91_32 + var_91_33 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play105121022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105121022
		arg_94_1.duration_ = 2.4

		local var_94_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			zh = 2.4,
			en = 1.999999999999
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
				arg_94_0:Play105121023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "1036ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_94_1.stage_.transform)

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

			local var_97_5 = arg_94_1.actors_["1036ui_story"]
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1036ui_story == nil then
				arg_94_1.var_.characterEffect1036ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.1

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 and not isNil(var_97_5) then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7

				if arg_94_1.var_.characterEffect1036ui_story and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1036ui_story then
				arg_94_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_97_9 = arg_94_1.actors_["1036ui_story"].transform
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.var_.moveOldPos1036ui_story = var_97_9.localPosition
			end

			local var_97_11 = 0.001

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_11 then
				local var_97_12 = (arg_94_1.time_ - var_97_10) / var_97_11
				local var_97_13 = Vector3.New(0, -1.09, -5.78)

				var_97_9.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1036ui_story, var_97_13, var_97_12)

				local var_97_14 = manager.ui.mainCamera.transform.position - var_97_9.position

				var_97_9.forward = Vector3.New(var_97_14.x, var_97_14.y, var_97_14.z)

				local var_97_15 = var_97_9.localEulerAngles

				var_97_15.z = 0
				var_97_15.x = 0
				var_97_9.localEulerAngles = var_97_15
			end

			if arg_94_1.time_ >= var_97_10 + var_97_11 and arg_94_1.time_ < var_97_10 + var_97_11 + arg_97_0 then
				var_97_9.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_97_16 = manager.ui.mainCamera.transform.position - var_97_9.position

				var_97_9.forward = Vector3.New(var_97_16.x, var_97_16.y, var_97_16.z)

				local var_97_17 = var_97_9.localEulerAngles

				var_97_17.z = 0
				var_97_17.x = 0
				var_97_9.localEulerAngles = var_97_17
			end

			local var_97_18 = 0

			if var_97_18 < arg_94_1.time_ and arg_94_1.time_ <= var_97_18 + arg_97_0 then
				arg_94_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			local var_97_19 = 0

			if var_97_19 < arg_94_1.time_ and arg_94_1.time_ <= var_97_19 + arg_97_0 then
				arg_94_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_97_20 = 0
			local var_97_21 = 0.15

			if var_97_20 < arg_94_1.time_ and arg_94_1.time_ <= var_97_20 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_22 = arg_94_1:FormatText(StoryNameCfg[5].name)

				arg_94_1.leftNameTxt_.text = var_97_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_23 = arg_94_1:GetWordFromCfg(105121022)
				local var_97_24 = arg_94_1:FormatText(var_97_23.content)

				arg_94_1.text_.text = var_97_24

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_25 = 7
				local var_97_26 = utf8.len(var_97_24)
				local var_97_27 = var_97_25 <= 0 and var_97_21 or var_97_21 * (var_97_26 / var_97_25)

				if var_97_27 > 0 and var_97_21 < var_97_27 then
					arg_94_1.talkMaxDuration = var_97_27

					if var_97_27 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_27 + var_97_20
					end
				end

				arg_94_1.text_.text = var_97_24
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121022", "story_v_out_105121.awb") ~= 0 then
					local var_97_28 = manager.audio:GetVoiceLength("story_v_out_105121", "105121022", "story_v_out_105121.awb") / 1000

					if var_97_28 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_28 + var_97_20
					end

					if var_97_23.prefab_name ~= "" and arg_94_1.actors_[var_97_23.prefab_name] ~= nil then
						local var_97_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_23.prefab_name].transform, "story_v_out_105121", "105121022", "story_v_out_105121.awb")

						arg_94_1:RecordAudio("105121022", var_97_29)
						arg_94_1:RecordAudio("105121022", var_97_29)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_105121", "105121022", "story_v_out_105121.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_105121", "105121022", "story_v_out_105121.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_30 = math.max(var_97_21, arg_94_1.talkMaxDuration)

			if var_97_20 <= arg_94_1.time_ and arg_94_1.time_ < var_97_20 + var_97_30 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_20) / var_97_30

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_20 + var_97_30 and arg_94_1.time_ < var_97_20 + var_97_30 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play105121023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105121023
		arg_98_1.duration_ = 3.63

		local var_98_0 = {
			ja = 3.633,
			ko = 2.2,
			zh = 2.6,
			en = 3.066
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
				arg_98_0:Play105121024(arg_98_1)
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

			local var_101_4 = arg_98_1.actors_["1036ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1036ui_story == nil then
				arg_98_1.var_.characterEffect1036ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1036ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1036ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1036ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1036ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0
			local var_101_11 = 0.15

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_12 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_13 = arg_98_1:GetWordFromCfg(105121023)
				local var_101_14 = arg_98_1:FormatText(var_101_13.content)

				arg_98_1.text_.text = var_101_14

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 6
				local var_101_16 = utf8.len(var_101_14)
				local var_101_17 = var_101_15 <= 0 and var_101_11 or var_101_11 * (var_101_16 / var_101_15)

				if var_101_17 > 0 and var_101_11 < var_101_17 then
					arg_98_1.talkMaxDuration = var_101_17

					if var_101_17 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_17 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_14
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121023", "story_v_out_105121.awb") ~= 0 then
					local var_101_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121023", "story_v_out_105121.awb") / 1000

					if var_101_18 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_10
					end

					if var_101_13.prefab_name ~= "" and arg_98_1.actors_[var_101_13.prefab_name] ~= nil then
						local var_101_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_13.prefab_name].transform, "story_v_out_105121", "105121023", "story_v_out_105121.awb")

						arg_98_1:RecordAudio("105121023", var_101_19)
						arg_98_1:RecordAudio("105121023", var_101_19)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105121", "105121023", "story_v_out_105121.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105121", "105121023", "story_v_out_105121.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_20 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_20 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_20

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_20 and arg_98_1.time_ < var_101_10 + var_101_20 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play105121024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105121024
		arg_102_1.duration_ = 3.67

		local var_102_0 = {
			ja = 3.666,
			ko = 2.766,
			zh = 2.9,
			en = 2.966
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
				arg_102_0:Play105121025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1019ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
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

			local var_105_10 = arg_102_1.actors_["1036ui_story"].transform
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.var_.moveOldPos1036ui_story = var_105_10.localPosition
			end

			local var_105_12 = 0.001

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_11) / var_105_12
				local var_105_14 = Vector3.New(0, 100, 0)

				var_105_10.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1036ui_story, var_105_14, var_105_13)

				local var_105_15 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_15.x, var_105_15.y, var_105_15.z)

				local var_105_16 = var_105_10.localEulerAngles

				var_105_16.z = 0
				var_105_16.x = 0
				var_105_10.localEulerAngles = var_105_16
			end

			if arg_102_1.time_ >= var_105_11 + var_105_12 and arg_102_1.time_ < var_105_11 + var_105_12 + arg_105_0 then
				var_105_10.localPosition = Vector3.New(0, 100, 0)

				local var_105_17 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_17.x, var_105_17.y, var_105_17.z)

				local var_105_18 = var_105_10.localEulerAngles

				var_105_18.z = 0
				var_105_18.x = 0
				var_105_10.localEulerAngles = var_105_18
			end

			local var_105_19 = arg_102_1.actors_["1019ui_story"].transform
			local var_105_20 = 0

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				arg_102_1.var_.moveOldPos1019ui_story = var_105_19.localPosition
			end

			local var_105_21 = 0.001

			if var_105_20 <= arg_102_1.time_ and arg_102_1.time_ < var_105_20 + var_105_21 then
				local var_105_22 = (arg_102_1.time_ - var_105_20) / var_105_21
				local var_105_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_105_19.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1019ui_story, var_105_23, var_105_22)

				local var_105_24 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_24.x, var_105_24.y, var_105_24.z)

				local var_105_25 = var_105_19.localEulerAngles

				var_105_25.z = 0
				var_105_25.x = 0
				var_105_19.localEulerAngles = var_105_25
			end

			if arg_102_1.time_ >= var_105_20 + var_105_21 and arg_102_1.time_ < var_105_20 + var_105_21 + arg_105_0 then
				var_105_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_105_26 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_26.x, var_105_26.y, var_105_26.z)

				local var_105_27 = var_105_19.localEulerAngles

				var_105_27.z = 0
				var_105_27.x = 0
				var_105_19.localEulerAngles = var_105_27
			end

			local var_105_28 = 0

			if var_105_28 < arg_102_1.time_ and arg_102_1.time_ <= var_105_28 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_105_29 = 0

			if var_105_29 < arg_102_1.time_ and arg_102_1.time_ <= var_105_29 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_105_30 = 0
			local var_105_31 = 0.225

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_32 = arg_102_1:FormatText(StoryNameCfg[13].name)

				arg_102_1.leftNameTxt_.text = var_105_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_33 = arg_102_1:GetWordFromCfg(105121024)
				local var_105_34 = arg_102_1:FormatText(var_105_33.content)

				arg_102_1.text_.text = var_105_34

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_35 = 9
				local var_105_36 = utf8.len(var_105_34)
				local var_105_37 = var_105_35 <= 0 and var_105_31 or var_105_31 * (var_105_36 / var_105_35)

				if var_105_37 > 0 and var_105_31 < var_105_37 then
					arg_102_1.talkMaxDuration = var_105_37

					if var_105_37 + var_105_30 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_37 + var_105_30
					end
				end

				arg_102_1.text_.text = var_105_34
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121024", "story_v_out_105121.awb") ~= 0 then
					local var_105_38 = manager.audio:GetVoiceLength("story_v_out_105121", "105121024", "story_v_out_105121.awb") / 1000

					if var_105_38 + var_105_30 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_38 + var_105_30
					end

					if var_105_33.prefab_name ~= "" and arg_102_1.actors_[var_105_33.prefab_name] ~= nil then
						local var_105_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_33.prefab_name].transform, "story_v_out_105121", "105121024", "story_v_out_105121.awb")

						arg_102_1:RecordAudio("105121024", var_105_39)
						arg_102_1:RecordAudio("105121024", var_105_39)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105121", "105121024", "story_v_out_105121.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105121", "105121024", "story_v_out_105121.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_40 = math.max(var_105_31, arg_102_1.talkMaxDuration)

			if var_105_30 <= arg_102_1.time_ and arg_102_1.time_ < var_105_30 + var_105_40 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_30) / var_105_40

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_30 + var_105_40 and arg_102_1.time_ < var_105_30 + var_105_40 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play105121025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105121025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105121026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1019ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1019ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1019ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1019ui_story.fillRatio = var_109_5
			end

			local var_109_6 = arg_106_1.actors_["1019ui_story"].transform
			local var_109_7 = 0

			if var_109_7 < arg_106_1.time_ and arg_106_1.time_ <= var_109_7 + arg_109_0 then
				arg_106_1.var_.moveOldPos1019ui_story = var_109_6.localPosition
			end

			local var_109_8 = 0.001

			if var_109_7 <= arg_106_1.time_ and arg_106_1.time_ < var_109_7 + var_109_8 then
				local var_109_9 = (arg_106_1.time_ - var_109_7) / var_109_8
				local var_109_10 = Vector3.New(0, 100, 0)

				var_109_6.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1019ui_story, var_109_10, var_109_9)

				local var_109_11 = manager.ui.mainCamera.transform.position - var_109_6.position

				var_109_6.forward = Vector3.New(var_109_11.x, var_109_11.y, var_109_11.z)

				local var_109_12 = var_109_6.localEulerAngles

				var_109_12.z = 0
				var_109_12.x = 0
				var_109_6.localEulerAngles = var_109_12
			end

			if arg_106_1.time_ >= var_109_7 + var_109_8 and arg_106_1.time_ < var_109_7 + var_109_8 + arg_109_0 then
				var_109_6.localPosition = Vector3.New(0, 100, 0)

				local var_109_13 = manager.ui.mainCamera.transform.position - var_109_6.position

				var_109_6.forward = Vector3.New(var_109_13.x, var_109_13.y, var_109_13.z)

				local var_109_14 = var_109_6.localEulerAngles

				var_109_14.z = 0
				var_109_14.x = 0
				var_109_6.localEulerAngles = var_109_14
			end

			local var_109_15 = 0
			local var_109_16 = 1.3

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_17 = arg_106_1:GetWordFromCfg(105121025)
				local var_109_18 = arg_106_1:FormatText(var_109_17.content)

				arg_106_1.text_.text = var_109_18

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_19 = 52
				local var_109_20 = utf8.len(var_109_18)
				local var_109_21 = var_109_19 <= 0 and var_109_16 or var_109_16 * (var_109_20 / var_109_19)

				if var_109_21 > 0 and var_109_16 < var_109_21 then
					arg_106_1.talkMaxDuration = var_109_21

					if var_109_21 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_21 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_18
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_22 and arg_106_1.time_ < var_109_15 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play105121026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105121026
		arg_110_1.duration_ = 4.93

		local var_110_0 = {
			ja = 4.933,
			ko = 3.7,
			zh = 2.5,
			en = 4.666
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
				arg_110_0:Play105121027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1036ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1036ui_story == nil then
				arg_110_1.var_.characterEffect1036ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1036ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1036ui_story then
				arg_110_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_113_4 = 0
			local var_113_5 = 0.35

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_6 = arg_110_1:FormatText(StoryNameCfg[5].name)

				arg_110_1.leftNameTxt_.text = var_113_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_7 = arg_110_1:GetWordFromCfg(105121026)
				local var_113_8 = arg_110_1:FormatText(var_113_7.content)

				arg_110_1.text_.text = var_113_8

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 14
				local var_113_10 = utf8.len(var_113_8)
				local var_113_11 = var_113_9 <= 0 and var_113_5 or var_113_5 * (var_113_10 / var_113_9)

				if var_113_11 > 0 and var_113_5 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_8
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121026", "story_v_out_105121.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_105121", "105121026", "story_v_out_105121.awb") / 1000

					if var_113_12 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_4
					end

					if var_113_7.prefab_name ~= "" and arg_110_1.actors_[var_113_7.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_7.prefab_name].transform, "story_v_out_105121", "105121026", "story_v_out_105121.awb")

						arg_110_1:RecordAudio("105121026", var_113_13)
						arg_110_1:RecordAudio("105121026", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105121", "105121026", "story_v_out_105121.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105121", "105121026", "story_v_out_105121.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_14 and arg_110_1.time_ < var_113_4 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play105121027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105121027
		arg_114_1.duration_ = 3.3

		local var_114_0 = {
			ja = 3.3,
			ko = 2,
			zh = 3,
			en = 1.9
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
				arg_114_0:Play105121028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1019ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1019ui_story then
				arg_114_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1036ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1036ui_story == nil then
				arg_114_1.var_.characterEffect1036ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.1

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1036ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1036ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1036ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1036ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0
			local var_117_11 = 0.25

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_12 = arg_114_1:FormatText(StoryNameCfg[13].name)

				arg_114_1.leftNameTxt_.text = var_117_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_13 = arg_114_1:GetWordFromCfg(105121027)
				local var_117_14 = arg_114_1:FormatText(var_117_13.content)

				arg_114_1.text_.text = var_117_14

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 10
				local var_117_16 = utf8.len(var_117_14)
				local var_117_17 = var_117_15 <= 0 and var_117_11 or var_117_11 * (var_117_16 / var_117_15)

				if var_117_17 > 0 and var_117_11 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17

					if var_117_17 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_10
					end
				end

				arg_114_1.text_.text = var_117_14
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121027", "story_v_out_105121.awb") ~= 0 then
					local var_117_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121027", "story_v_out_105121.awb") / 1000

					if var_117_18 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_10
					end

					if var_117_13.prefab_name ~= "" and arg_114_1.actors_[var_117_13.prefab_name] ~= nil then
						local var_117_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_13.prefab_name].transform, "story_v_out_105121", "105121027", "story_v_out_105121.awb")

						arg_114_1:RecordAudio("105121027", var_117_19)
						arg_114_1:RecordAudio("105121027", var_117_19)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105121", "105121027", "story_v_out_105121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105121", "105121027", "story_v_out_105121.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_20 = math.max(var_117_11, arg_114_1.talkMaxDuration)

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_20 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_10) / var_117_20

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_10 + var_117_20 and arg_114_1.time_ < var_117_10 + var_117_20 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play105121028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105121028
		arg_118_1.duration_ = 4.53

		local var_118_0 = {
			ja = 4.533,
			ko = 3.2,
			zh = 3.1,
			en = 3.633
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
				arg_118_0:Play105121029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1019ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.1

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1019ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1019ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1019ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1019ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0
			local var_121_11 = 0.225

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_12 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_13 = arg_118_1:GetWordFromCfg(105121028)
				local var_121_14 = arg_118_1:FormatText(var_121_13.content)

				arg_118_1.text_.text = var_121_14

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 9
				local var_121_16 = utf8.len(var_121_14)
				local var_121_17 = var_121_15 <= 0 and var_121_11 or var_121_11 * (var_121_16 / var_121_15)

				if var_121_17 > 0 and var_121_11 < var_121_17 then
					arg_118_1.talkMaxDuration = var_121_17

					if var_121_17 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_17 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_14
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121028", "story_v_out_105121.awb") ~= 0 then
					local var_121_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121028", "story_v_out_105121.awb") / 1000

					if var_121_18 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_10
					end

					if var_121_13.prefab_name ~= "" and arg_118_1.actors_[var_121_13.prefab_name] ~= nil then
						local var_121_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_13.prefab_name].transform, "story_v_out_105121", "105121028", "story_v_out_105121.awb")

						arg_118_1:RecordAudio("105121028", var_121_19)
						arg_118_1:RecordAudio("105121028", var_121_19)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_105121", "105121028", "story_v_out_105121.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_105121", "105121028", "story_v_out_105121.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_20 and arg_118_1.time_ < var_121_10 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play105121029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105121029
		arg_122_1.duration_ = 8

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105121030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "effect"

				arg_122_1:AudioAction(var_125_2, var_125_3, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_125_4 = arg_122_1.actors_["1084ui_story"]
			local var_125_5 = 2

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_9
			end

			local var_125_10 = arg_122_1.bgs_.B12a
			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				local var_125_12 = var_125_10:GetComponent("SpriteRenderer")

				if var_125_12 then
					arg_122_1.var_.alphaOldValueB12a = var_125_12.color.a
					arg_122_1.var_.alphaMatValueB12a = var_125_12
				end

				arg_122_1.var_.alphaOldValueB12a = 1
			end

			local var_125_13 = 1.5

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_13 then
				local var_125_14 = (arg_122_1.time_ - var_125_11) / var_125_13
				local var_125_15 = Mathf.Lerp(arg_122_1.var_.alphaOldValueB12a, 0, var_125_14)

				if arg_122_1.var_.alphaMatValueB12a then
					local var_125_16 = arg_122_1.var_.alphaMatValueB12a.color

					var_125_16.a = var_125_15
					arg_122_1.var_.alphaMatValueB12a.color = var_125_16
				end
			end

			if arg_122_1.time_ >= var_125_11 + var_125_13 and arg_122_1.time_ < var_125_11 + var_125_13 + arg_125_0 and arg_122_1.var_.alphaMatValueB12a then
				local var_125_17 = arg_122_1.var_.alphaMatValueB12a
				local var_125_18 = var_125_17.color

				var_125_18.a = 0
				var_125_17.color = var_125_18
			end

			local var_125_19 = arg_122_1.bgs_.B12a.transform
			local var_125_20 = 1.5

			if var_125_20 < arg_122_1.time_ and arg_122_1.time_ <= var_125_20 + arg_125_0 then
				arg_122_1.var_.moveOldPosB12a = var_125_19.localPosition
			end

			local var_125_21 = 0.001

			if var_125_20 <= arg_122_1.time_ and arg_122_1.time_ < var_125_20 + var_125_21 then
				local var_125_22 = (arg_122_1.time_ - var_125_20) / var_125_21
				local var_125_23 = Vector3.New(0, -100, 10)

				var_125_19.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPosB12a, var_125_23, var_125_22)
			end

			if arg_122_1.time_ >= var_125_20 + var_125_21 and arg_122_1.time_ < var_125_20 + var_125_21 + arg_125_0 then
				var_125_19.localPosition = Vector3.New(0, -100, 10)
			end

			local var_125_24 = "B01a"

			if arg_122_1.bgs_[var_125_24] == nil then
				local var_125_25 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_125_24)
				var_125_25.name = var_125_24
				var_125_25.transform.parent = arg_122_1.stage_.transform
				var_125_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_[var_125_24] = var_125_25
			end

			local var_125_26 = arg_122_1.bgs_.B01a
			local var_125_27 = 1.5

			if var_125_27 < arg_122_1.time_ and arg_122_1.time_ <= var_125_27 + arg_125_0 then
				local var_125_28 = var_125_26:GetComponent("SpriteRenderer")

				if var_125_28 then
					arg_122_1.var_.alphaOldValueB01a = var_125_28.color.a
					arg_122_1.var_.alphaMatValueB01a = var_125_28
				end

				arg_122_1.var_.alphaOldValueB01a = 0
			end

			local var_125_29 = 1.5

			if var_125_27 <= arg_122_1.time_ and arg_122_1.time_ < var_125_27 + var_125_29 then
				local var_125_30 = (arg_122_1.time_ - var_125_27) / var_125_29
				local var_125_31 = Mathf.Lerp(arg_122_1.var_.alphaOldValueB01a, 1, var_125_30)

				if arg_122_1.var_.alphaMatValueB01a then
					local var_125_32 = arg_122_1.var_.alphaMatValueB01a.color

					var_125_32.a = var_125_31
					arg_122_1.var_.alphaMatValueB01a.color = var_125_32
				end
			end

			if arg_122_1.time_ >= var_125_27 + var_125_29 and arg_122_1.time_ < var_125_27 + var_125_29 + arg_125_0 and arg_122_1.var_.alphaMatValueB01a then
				local var_125_33 = arg_122_1.var_.alphaMatValueB01a
				local var_125_34 = var_125_33.color

				var_125_34.a = 1
				var_125_33.color = var_125_34
			end

			local var_125_35 = 1.5

			if var_125_35 < arg_122_1.time_ and arg_122_1.time_ <= var_125_35 + arg_125_0 then
				local var_125_36 = manager.ui.mainCamera.transform.localPosition
				local var_125_37 = Vector3.New(0, 0, 10) + Vector3.New(var_125_36.x, var_125_36.y, 0)
				local var_125_38 = arg_122_1.bgs_.B01a

				var_125_38.transform.localPosition = var_125_37
				var_125_38.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_39 = var_125_38:GetComponent("SpriteRenderer")

				if var_125_39 and var_125_39.sprite then
					local var_125_40 = (var_125_38.transform.localPosition - var_125_36).z
					local var_125_41 = manager.ui.mainCameraCom_
					local var_125_42 = 2 * var_125_40 * Mathf.Tan(var_125_41.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_43 = var_125_42 * var_125_41.aspect
					local var_125_44 = var_125_39.sprite.bounds.size.x
					local var_125_45 = var_125_39.sprite.bounds.size.y
					local var_125_46 = var_125_43 / var_125_44
					local var_125_47 = var_125_42 / var_125_45
					local var_125_48 = var_125_47 < var_125_46 and var_125_46 or var_125_47

					var_125_38.transform.localScale = Vector3.New(var_125_48, var_125_48, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "B01a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_49 = 0

			if var_125_49 < arg_122_1.time_ and arg_122_1.time_ <= var_125_49 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			local var_125_50 = 3

			if arg_122_1.time_ >= var_125_49 + var_125_50 and arg_122_1.time_ < var_125_49 + var_125_50 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_51 = 3
			local var_125_52 = 0.2

			if var_125_51 < arg_122_1.time_ and arg_122_1.time_ <= var_125_51 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_53 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_53:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_54 = arg_122_1:GetWordFromCfg(105121029)
				local var_125_55 = arg_122_1:FormatText(var_125_54.content)

				arg_122_1.text_.text = var_125_55

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_56 = 8
				local var_125_57 = utf8.len(var_125_55)
				local var_125_58 = var_125_56 <= 0 and var_125_52 or var_125_52 * (var_125_57 / var_125_56)

				if var_125_58 > 0 and var_125_52 < var_125_58 then
					arg_122_1.talkMaxDuration = var_125_58
					var_125_51 = var_125_51 + 0.3

					if var_125_58 + var_125_51 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_58 + var_125_51
					end
				end

				arg_122_1.text_.text = var_125_55
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_59 = var_125_51 + 0.3
			local var_125_60 = math.max(var_125_52, arg_122_1.talkMaxDuration)

			if var_125_59 <= arg_122_1.time_ and arg_122_1.time_ < var_125_59 + var_125_60 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_59) / var_125_60

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_59 + var_125_60 and arg_122_1.time_ < var_125_59 + var_125_60 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B12a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play105121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105121030
		arg_128_1.duration_ = 7.43

		local var_128_0 = {
			ja = 7.433,
			ko = 5.4,
			zh = 5.633,
			en = 6.5
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play105121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "1059ui_story"

			if arg_128_1.actors_[var_131_0] == nil then
				local var_131_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_131_1) then
					local var_131_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_128_1.stage_.transform)

					var_131_2.name = var_131_0
					var_131_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_128_1.actors_[var_131_0] = var_131_2

					local var_131_3 = var_131_2:GetComponentInChildren(typeof(CharacterEffect))

					var_131_3.enabled = true

					local var_131_4 = GameObjectTools.GetOrAddComponent(var_131_2, typeof(DynamicBoneHelper))

					if var_131_4 then
						var_131_4:EnableDynamicBone(false)
					end

					arg_128_1:ShowWeapon(var_131_3.transform, false)

					arg_128_1.var_[var_131_0 .. "Animator"] = var_131_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_128_1.var_[var_131_0 .. "Animator"].applyRootMotion = true
					arg_128_1.var_[var_131_0 .. "LipSync"] = var_131_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_131_5 = arg_128_1.actors_["1059ui_story"]
			local var_131_6 = 0

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1059ui_story == nil then
				arg_128_1.var_.characterEffect1059ui_story = var_131_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_7 = 0.1

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_7 and not isNil(var_131_5) then
				local var_131_8 = (arg_128_1.time_ - var_131_6) / var_131_7

				if arg_128_1.var_.characterEffect1059ui_story and not isNil(var_131_5) then
					arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_6 + var_131_7 and arg_128_1.time_ < var_131_6 + var_131_7 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1059ui_story then
				arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_131_9 = arg_128_1.actors_["1059ui_story"].transform
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.var_.moveOldPos1059ui_story = var_131_9.localPosition
			end

			local var_131_11 = 0.001

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11
				local var_131_13 = Vector3.New(-0.7, -1.05, -6)

				var_131_9.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1059ui_story, var_131_13, var_131_12)

				local var_131_14 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_14.x, var_131_14.y, var_131_14.z)

				local var_131_15 = var_131_9.localEulerAngles

				var_131_15.z = 0
				var_131_15.x = 0
				var_131_9.localEulerAngles = var_131_15
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 then
				var_131_9.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_9.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_9.localEulerAngles = var_131_17
			end

			local var_131_18 = 0

			if var_131_18 < arg_128_1.time_ and arg_128_1.time_ <= var_131_18 + arg_131_0 then
				arg_128_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_131_20 = 0
			local var_131_21 = 0.6

			if var_131_20 < arg_128_1.time_ and arg_128_1.time_ <= var_131_20 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_22 = arg_128_1:FormatText(StoryNameCfg[28].name)

				arg_128_1.leftNameTxt_.text = var_131_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_23 = arg_128_1:GetWordFromCfg(105121030)
				local var_131_24 = arg_128_1:FormatText(var_131_23.content)

				arg_128_1.text_.text = var_131_24

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_25 = 24
				local var_131_26 = utf8.len(var_131_24)
				local var_131_27 = var_131_25 <= 0 and var_131_21 or var_131_21 * (var_131_26 / var_131_25)

				if var_131_27 > 0 and var_131_21 < var_131_27 then
					arg_128_1.talkMaxDuration = var_131_27

					if var_131_27 + var_131_20 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_27 + var_131_20
					end
				end

				arg_128_1.text_.text = var_131_24
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121030", "story_v_out_105121.awb") ~= 0 then
					local var_131_28 = manager.audio:GetVoiceLength("story_v_out_105121", "105121030", "story_v_out_105121.awb") / 1000

					if var_131_28 + var_131_20 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_28 + var_131_20
					end

					if var_131_23.prefab_name ~= "" and arg_128_1.actors_[var_131_23.prefab_name] ~= nil then
						local var_131_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_23.prefab_name].transform, "story_v_out_105121", "105121030", "story_v_out_105121.awb")

						arg_128_1:RecordAudio("105121030", var_131_29)
						arg_128_1:RecordAudio("105121030", var_131_29)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_105121", "105121030", "story_v_out_105121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_105121", "105121030", "story_v_out_105121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_30 = math.max(var_131_21, arg_128_1.talkMaxDuration)

			if var_131_20 <= arg_128_1.time_ and arg_128_1.time_ < var_131_20 + var_131_30 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_20) / var_131_30

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_20 + var_131_30 and arg_128_1.time_ < var_131_20 + var_131_30 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play105121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 105121031
		arg_132_1.duration_ = 4.37

		local var_132_0 = {
			ja = 3.6,
			ko = 4.366,
			zh = 3.4,
			en = 2.333
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play105121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = "1037ui_story"

			if arg_132_1.actors_[var_135_0] == nil then
				local var_135_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_135_1) then
					local var_135_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_132_1.stage_.transform)

					var_135_2.name = var_135_0
					var_135_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_0] = var_135_2

					local var_135_3 = var_135_2:GetComponentInChildren(typeof(CharacterEffect))

					var_135_3.enabled = true

					local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_2, typeof(DynamicBoneHelper))

					if var_135_4 then
						var_135_4:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_3.transform, false)

					arg_132_1.var_[var_135_0 .. "Animator"] = var_135_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_0 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_0 .. "LipSync"] = var_135_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_5 = arg_132_1.actors_["1037ui_story"]
			local var_135_6 = 0

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = var_135_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_7 = 0.1

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_7 and not isNil(var_135_5) then
				local var_135_8 = (arg_132_1.time_ - var_135_6) / var_135_7

				if arg_132_1.var_.characterEffect1037ui_story and not isNil(var_135_5) then
					arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_6 + var_135_7 and arg_132_1.time_ < var_135_6 + var_135_7 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1037ui_story then
				arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_135_9 = arg_132_1.actors_["1059ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1059ui_story == nil then
				arg_132_1.var_.characterEffect1059ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.1

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1059ui_story and not isNil(var_135_9) then
					local var_135_13 = Mathf.Lerp(0, 0.5, var_135_12)

					arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1059ui_story.fillRatio = var_135_13
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1059ui_story then
				local var_135_14 = 0.5

				arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1059ui_story.fillRatio = var_135_14
			end

			local var_135_15 = arg_132_1.actors_["1037ui_story"].transform
			local var_135_16 = 0

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.var_.moveOldPos1037ui_story = var_135_15.localPosition
			end

			local var_135_17 = 0.001

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_17 then
				local var_135_18 = (arg_132_1.time_ - var_135_16) / var_135_17
				local var_135_19 = Vector3.New(0.7, -1.09, -5.81)

				var_135_15.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1037ui_story, var_135_19, var_135_18)

				local var_135_20 = manager.ui.mainCamera.transform.position - var_135_15.position

				var_135_15.forward = Vector3.New(var_135_20.x, var_135_20.y, var_135_20.z)

				local var_135_21 = var_135_15.localEulerAngles

				var_135_21.z = 0
				var_135_21.x = 0
				var_135_15.localEulerAngles = var_135_21
			end

			if arg_132_1.time_ >= var_135_16 + var_135_17 and arg_132_1.time_ < var_135_16 + var_135_17 + arg_135_0 then
				var_135_15.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_135_22 = manager.ui.mainCamera.transform.position - var_135_15.position

				var_135_15.forward = Vector3.New(var_135_22.x, var_135_22.y, var_135_22.z)

				local var_135_23 = var_135_15.localEulerAngles

				var_135_23.z = 0
				var_135_23.x = 0
				var_135_15.localEulerAngles = var_135_23
			end

			local var_135_24 = 0

			if var_135_24 < arg_132_1.time_ and arg_132_1.time_ <= var_135_24 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_135_25 = 0

			if var_135_25 < arg_132_1.time_ and arg_132_1.time_ <= var_135_25 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_135_26 = 0
			local var_135_27 = 0.4

			if var_135_26 < arg_132_1.time_ and arg_132_1.time_ <= var_135_26 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_28 = arg_132_1:FormatText(StoryNameCfg[15].name)

				arg_132_1.leftNameTxt_.text = var_135_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_29 = arg_132_1:GetWordFromCfg(105121031)
				local var_135_30 = arg_132_1:FormatText(var_135_29.content)

				arg_132_1.text_.text = var_135_30

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_31 = 16
				local var_135_32 = utf8.len(var_135_30)
				local var_135_33 = var_135_31 <= 0 and var_135_27 or var_135_27 * (var_135_32 / var_135_31)

				if var_135_33 > 0 and var_135_27 < var_135_33 then
					arg_132_1.talkMaxDuration = var_135_33

					if var_135_33 + var_135_26 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_33 + var_135_26
					end
				end

				arg_132_1.text_.text = var_135_30
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121031", "story_v_out_105121.awb") ~= 0 then
					local var_135_34 = manager.audio:GetVoiceLength("story_v_out_105121", "105121031", "story_v_out_105121.awb") / 1000

					if var_135_34 + var_135_26 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_34 + var_135_26
					end

					if var_135_29.prefab_name ~= "" and arg_132_1.actors_[var_135_29.prefab_name] ~= nil then
						local var_135_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_29.prefab_name].transform, "story_v_out_105121", "105121031", "story_v_out_105121.awb")

						arg_132_1:RecordAudio("105121031", var_135_35)
						arg_132_1:RecordAudio("105121031", var_135_35)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_105121", "105121031", "story_v_out_105121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_105121", "105121031", "story_v_out_105121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_36 = math.max(var_135_27, arg_132_1.talkMaxDuration)

			if var_135_26 <= arg_132_1.time_ and arg_132_1.time_ < var_135_26 + var_135_36 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_26) / var_135_36

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_26 + var_135_36 and arg_132_1.time_ < var_135_26 + var_135_36 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play105121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 105121032
		arg_136_1.duration_ = 5.37

		local var_136_0 = {
			ja = 5.366,
			ko = 4.3,
			zh = 3.066,
			en = 3.066
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
				arg_136_0:Play105121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1036ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1036ui_story == nil then
				arg_136_1.var_.characterEffect1036ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1036ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1036ui_story then
				arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1037ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1037ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1037ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1037ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1037ui_story.fillRatio = var_139_9
			end

			local var_139_10 = arg_136_1.actors_["1037ui_story"].transform
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.var_.moveOldPos1037ui_story = var_139_10.localPosition
			end

			local var_139_12 = 0.001

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_11) / var_139_12
				local var_139_14 = Vector3.New(0, 100, 0)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1037ui_story, var_139_14, var_139_13)

				local var_139_15 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_15.x, var_139_15.y, var_139_15.z)

				local var_139_16 = var_139_10.localEulerAngles

				var_139_16.z = 0
				var_139_16.x = 0
				var_139_10.localEulerAngles = var_139_16
			end

			if arg_136_1.time_ >= var_139_11 + var_139_12 and arg_136_1.time_ < var_139_11 + var_139_12 + arg_139_0 then
				var_139_10.localPosition = Vector3.New(0, 100, 0)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_10.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_10.localEulerAngles = var_139_18
			end

			local var_139_19 = arg_136_1.actors_["1059ui_story"].transform
			local var_139_20 = 0

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_19.localPosition
			end

			local var_139_21 = 0.001

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_21 then
				local var_139_22 = (arg_136_1.time_ - var_139_20) / var_139_21
				local var_139_23 = Vector3.New(0, 100, 0)

				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, var_139_23, var_139_22)

				local var_139_24 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_24.x, var_139_24.y, var_139_24.z)

				local var_139_25 = var_139_19.localEulerAngles

				var_139_25.z = 0
				var_139_25.x = 0
				var_139_19.localEulerAngles = var_139_25
			end

			if arg_136_1.time_ >= var_139_20 + var_139_21 and arg_136_1.time_ < var_139_20 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(0, 100, 0)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_19.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_19.localEulerAngles = var_139_27
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_139_29 = arg_136_1.actors_["1036ui_story"].transform
			local var_139_30 = 0

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.var_.moveOldPos1036ui_story = var_139_29.localPosition
			end

			local var_139_31 = 0.001

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_31 then
				local var_139_32 = (arg_136_1.time_ - var_139_30) / var_139_31
				local var_139_33 = Vector3.New(0, -1.09, -5.78)

				var_139_29.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1036ui_story, var_139_33, var_139_32)

				local var_139_34 = manager.ui.mainCamera.transform.position - var_139_29.position

				var_139_29.forward = Vector3.New(var_139_34.x, var_139_34.y, var_139_34.z)

				local var_139_35 = var_139_29.localEulerAngles

				var_139_35.z = 0
				var_139_35.x = 0
				var_139_29.localEulerAngles = var_139_35
			end

			if arg_136_1.time_ >= var_139_30 + var_139_31 and arg_136_1.time_ < var_139_30 + var_139_31 + arg_139_0 then
				var_139_29.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_139_36 = manager.ui.mainCamera.transform.position - var_139_29.position

				var_139_29.forward = Vector3.New(var_139_36.x, var_139_36.y, var_139_36.z)

				local var_139_37 = var_139_29.localEulerAngles

				var_139_37.z = 0
				var_139_37.x = 0
				var_139_29.localEulerAngles = var_139_37
			end

			local var_139_38 = 0

			if var_139_38 < arg_136_1.time_ and arg_136_1.time_ <= var_139_38 + arg_139_0 then
				arg_136_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_139_39 = 0
			local var_139_40 = 0.45

			if var_139_39 < arg_136_1.time_ and arg_136_1.time_ <= var_139_39 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_41 = arg_136_1:FormatText(StoryNameCfg[5].name)

				arg_136_1.leftNameTxt_.text = var_139_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_42 = arg_136_1:GetWordFromCfg(105121032)
				local var_139_43 = arg_136_1:FormatText(var_139_42.content)

				arg_136_1.text_.text = var_139_43

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_44 = 16
				local var_139_45 = utf8.len(var_139_43)
				local var_139_46 = var_139_44 <= 0 and var_139_40 or var_139_40 * (var_139_45 / var_139_44)

				if var_139_46 > 0 and var_139_40 < var_139_46 then
					arg_136_1.talkMaxDuration = var_139_46

					if var_139_46 + var_139_39 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_46 + var_139_39
					end
				end

				arg_136_1.text_.text = var_139_43
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121032", "story_v_out_105121.awb") ~= 0 then
					local var_139_47 = manager.audio:GetVoiceLength("story_v_out_105121", "105121032", "story_v_out_105121.awb") / 1000

					if var_139_47 + var_139_39 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_47 + var_139_39
					end

					if var_139_42.prefab_name ~= "" and arg_136_1.actors_[var_139_42.prefab_name] ~= nil then
						local var_139_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_42.prefab_name].transform, "story_v_out_105121", "105121032", "story_v_out_105121.awb")

						arg_136_1:RecordAudio("105121032", var_139_48)
						arg_136_1:RecordAudio("105121032", var_139_48)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_105121", "105121032", "story_v_out_105121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_105121", "105121032", "story_v_out_105121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_49 = math.max(var_139_40, arg_136_1.talkMaxDuration)

			if var_139_39 <= arg_136_1.time_ and arg_136_1.time_ < var_139_39 + var_139_49 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_39) / var_139_49

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_39 + var_139_49 and arg_136_1.time_ < var_139_39 + var_139_49 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
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

		arg_136_1:InitPlayNodeList()
	end,
	Play105121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 105121033
		arg_140_1.duration_ = 0.1

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"

			SetActive(arg_140_1.choicesGo_, true)

			for iter_141_0, iter_141_1 in ipairs(arg_140_1.choices_) do
				local var_141_0 = iter_141_0 <= 1

				SetActive(iter_141_1.go, var_141_0)
			end

			arg_140_1.choices_[1].txt.text = arg_140_1:FormatText(StoryChoiceCfg[34].name)
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play105121034(arg_140_1)
			end

			arg_140_1:RecordChoiceLog(105121033, 34)
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1036ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1036ui_story == nil then
				arg_140_1.var_.characterEffect1036ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1036ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1036ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1036ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1036ui_story.fillRatio = var_143_5
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play105121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 105121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play105121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1036ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1036ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1036ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = 0
			local var_147_10 = 0.35

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_11 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_12 = arg_144_1:GetWordFromCfg(105121034)
				local var_147_13 = arg_144_1:FormatText(var_147_12.content)

				arg_144_1.text_.text = var_147_13

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_14 = 14
				local var_147_15 = utf8.len(var_147_13)
				local var_147_16 = var_147_14 <= 0 and var_147_10 or var_147_10 * (var_147_15 / var_147_14)

				if var_147_16 > 0 and var_147_10 < var_147_16 then
					arg_144_1.talkMaxDuration = var_147_16

					if var_147_16 + var_147_9 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_9
					end
				end

				arg_144_1.text_.text = var_147_13
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_17 = math.max(var_147_10, arg_144_1.talkMaxDuration)

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_17 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_9) / var_147_17

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_9 + var_147_17 and arg_144_1.time_ < var_147_9 + var_147_17 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play105121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 105121035
		arg_148_1.duration_ = 5

		local var_148_0 = {
			ja = 5,
			ko = 3.7,
			zh = 3.7,
			en = 4.033
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play105121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1019ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1019ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1019ui_story then
				arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1019ui_story"].transform
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = var_151_4.localPosition
			end

			local var_151_6 = 0.001

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6
				local var_151_8 = Vector3.New(-0.2, -1.08, -5.9)

				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, var_151_8, var_151_7)

				local var_151_9 = manager.ui.mainCamera.transform.position - var_151_4.position

				var_151_4.forward = Vector3.New(var_151_9.x, var_151_9.y, var_151_9.z)

				local var_151_10 = var_151_4.localEulerAngles

				var_151_10.z = 0
				var_151_10.x = 0
				var_151_4.localEulerAngles = var_151_10
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_151_11 = manager.ui.mainCamera.transform.position - var_151_4.position

				var_151_4.forward = Vector3.New(var_151_11.x, var_151_11.y, var_151_11.z)

				local var_151_12 = var_151_4.localEulerAngles

				var_151_12.z = 0
				var_151_12.x = 0
				var_151_4.localEulerAngles = var_151_12
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_151_15 = 0
			local var_151_16 = 0.375

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[13].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(105121035)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 13
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121035", "story_v_out_105121.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_105121", "105121035", "story_v_out_105121.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_105121", "105121035", "story_v_out_105121.awb")

						arg_148_1:RecordAudio("105121035", var_151_24)
						arg_148_1:RecordAudio("105121035", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_105121", "105121035", "story_v_out_105121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_105121", "105121035", "story_v_out_105121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play105121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 105121036
		arg_152_1.duration_ = 10.87

		local var_152_0 = {
			ja = 10.866,
			ko = 3.166,
			zh = 5.266,
			en = 5.066
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play105121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = "1148ui_story"

			if arg_152_1.actors_[var_155_0] == nil then
				local var_155_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_155_1) then
					local var_155_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_152_1.stage_.transform)

					var_155_2.name = var_155_0
					var_155_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_152_1.actors_[var_155_0] = var_155_2

					local var_155_3 = var_155_2:GetComponentInChildren(typeof(CharacterEffect))

					var_155_3.enabled = true

					local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_2, typeof(DynamicBoneHelper))

					if var_155_4 then
						var_155_4:EnableDynamicBone(false)
					end

					arg_152_1:ShowWeapon(var_155_3.transform, false)

					arg_152_1.var_[var_155_0 .. "Animator"] = var_155_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_152_1.var_[var_155_0 .. "Animator"].applyRootMotion = true
					arg_152_1.var_[var_155_0 .. "LipSync"] = var_155_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_155_5 = arg_152_1.actors_["1148ui_story"]
			local var_155_6 = 0

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 and not isNil(var_155_5) and arg_152_1.var_.characterEffect1148ui_story == nil then
				arg_152_1.var_.characterEffect1148ui_story = var_155_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_7 = 0.1

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_7 and not isNil(var_155_5) then
				local var_155_8 = (arg_152_1.time_ - var_155_6) / var_155_7

				if arg_152_1.var_.characterEffect1148ui_story and not isNil(var_155_5) then
					arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_6 + var_155_7 and arg_152_1.time_ < var_155_6 + var_155_7 + arg_155_0 and not isNil(var_155_5) and arg_152_1.var_.characterEffect1148ui_story then
				arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_155_9 = "1011ui_story"

			if arg_152_1.actors_[var_155_9] == nil then
				local var_155_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_155_10) then
					local var_155_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_152_1.stage_.transform)

					var_155_11.name = var_155_9
					var_155_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_152_1.actors_[var_155_9] = var_155_11

					local var_155_12 = var_155_11:GetComponentInChildren(typeof(CharacterEffect))

					var_155_12.enabled = true

					local var_155_13 = GameObjectTools.GetOrAddComponent(var_155_11, typeof(DynamicBoneHelper))

					if var_155_13 then
						var_155_13:EnableDynamicBone(false)
					end

					arg_152_1:ShowWeapon(var_155_12.transform, false)

					arg_152_1.var_[var_155_9 .. "Animator"] = var_155_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_152_1.var_[var_155_9 .. "Animator"].applyRootMotion = true
					arg_152_1.var_[var_155_9 .. "LipSync"] = var_155_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_155_14 = arg_152_1.actors_["1011ui_story"]
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1011ui_story == nil then
				arg_152_1.var_.characterEffect1011ui_story = var_155_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_16 = 0.1

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 and not isNil(var_155_14) then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16

				if arg_152_1.var_.characterEffect1011ui_story and not isNil(var_155_14) then
					local var_155_18 = Mathf.Lerp(0, 0.5, var_155_17)

					arg_152_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1011ui_story.fillRatio = var_155_18
				end
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1011ui_story then
				local var_155_19 = 0.5

				arg_152_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1011ui_story.fillRatio = var_155_19
			end

			local var_155_20 = arg_152_1.actors_["1019ui_story"].transform
			local var_155_21 = 0

			if var_155_21 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				arg_152_1.var_.moveOldPos1019ui_story = var_155_20.localPosition
			end

			local var_155_22 = 0.001

			if var_155_21 <= arg_152_1.time_ and arg_152_1.time_ < var_155_21 + var_155_22 then
				local var_155_23 = (arg_152_1.time_ - var_155_21) / var_155_22
				local var_155_24 = Vector3.New(0, 100, 0)

				var_155_20.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1019ui_story, var_155_24, var_155_23)

				local var_155_25 = manager.ui.mainCamera.transform.position - var_155_20.position

				var_155_20.forward = Vector3.New(var_155_25.x, var_155_25.y, var_155_25.z)

				local var_155_26 = var_155_20.localEulerAngles

				var_155_26.z = 0
				var_155_26.x = 0
				var_155_20.localEulerAngles = var_155_26
			end

			if arg_152_1.time_ >= var_155_21 + var_155_22 and arg_152_1.time_ < var_155_21 + var_155_22 + arg_155_0 then
				var_155_20.localPosition = Vector3.New(0, 100, 0)

				local var_155_27 = manager.ui.mainCamera.transform.position - var_155_20.position

				var_155_20.forward = Vector3.New(var_155_27.x, var_155_27.y, var_155_27.z)

				local var_155_28 = var_155_20.localEulerAngles

				var_155_28.z = 0
				var_155_28.x = 0
				var_155_20.localEulerAngles = var_155_28
			end

			local var_155_29 = arg_152_1.actors_["1148ui_story"].transform
			local var_155_30 = 0

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = var_155_29.localPosition
			end

			local var_155_31 = 0.001

			if var_155_30 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_31 then
				local var_155_32 = (arg_152_1.time_ - var_155_30) / var_155_31
				local var_155_33 = Vector3.New(0, -0.8, -6.2)

				var_155_29.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, var_155_33, var_155_32)

				local var_155_34 = manager.ui.mainCamera.transform.position - var_155_29.position

				var_155_29.forward = Vector3.New(var_155_34.x, var_155_34.y, var_155_34.z)

				local var_155_35 = var_155_29.localEulerAngles

				var_155_35.z = 0
				var_155_35.x = 0
				var_155_29.localEulerAngles = var_155_35
			end

			if arg_152_1.time_ >= var_155_30 + var_155_31 and arg_152_1.time_ < var_155_30 + var_155_31 + arg_155_0 then
				var_155_29.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_155_36 = manager.ui.mainCamera.transform.position - var_155_29.position

				var_155_29.forward = Vector3.New(var_155_36.x, var_155_36.y, var_155_36.z)

				local var_155_37 = var_155_29.localEulerAngles

				var_155_37.z = 0
				var_155_37.x = 0
				var_155_29.localEulerAngles = var_155_37
			end

			local var_155_38 = 0

			if var_155_38 < arg_152_1.time_ and arg_152_1.time_ <= var_155_38 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_155_39 = 0

			if var_155_39 < arg_152_1.time_ and arg_152_1.time_ <= var_155_39 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_155_40 = 0
			local var_155_41 = 0.575

			if var_155_40 < arg_152_1.time_ and arg_152_1.time_ <= var_155_40 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_42 = arg_152_1:FormatText(StoryNameCfg[8].name)

				arg_152_1.leftNameTxt_.text = var_155_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_43 = arg_152_1:GetWordFromCfg(105121036)
				local var_155_44 = arg_152_1:FormatText(var_155_43.content)

				arg_152_1.text_.text = var_155_44

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_45 = 23
				local var_155_46 = utf8.len(var_155_44)
				local var_155_47 = var_155_45 <= 0 and var_155_41 or var_155_41 * (var_155_46 / var_155_45)

				if var_155_47 > 0 and var_155_41 < var_155_47 then
					arg_152_1.talkMaxDuration = var_155_47

					if var_155_47 + var_155_40 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_47 + var_155_40
					end
				end

				arg_152_1.text_.text = var_155_44
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121036", "story_v_out_105121.awb") ~= 0 then
					local var_155_48 = manager.audio:GetVoiceLength("story_v_out_105121", "105121036", "story_v_out_105121.awb") / 1000

					if var_155_48 + var_155_40 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_48 + var_155_40
					end

					if var_155_43.prefab_name ~= "" and arg_152_1.actors_[var_155_43.prefab_name] ~= nil then
						local var_155_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_43.prefab_name].transform, "story_v_out_105121", "105121036", "story_v_out_105121.awb")

						arg_152_1:RecordAudio("105121036", var_155_49)
						arg_152_1:RecordAudio("105121036", var_155_49)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_105121", "105121036", "story_v_out_105121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_105121", "105121036", "story_v_out_105121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_50 = math.max(var_155_41, arg_152_1.talkMaxDuration)

			if var_155_40 <= arg_152_1.time_ and arg_152_1.time_ < var_155_40 + var_155_50 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_40) / var_155_50

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_40 + var_155_50 and arg_152_1.time_ < var_155_40 + var_155_50 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play105121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 105121037
		arg_156_1.duration_ = 5.9

		local var_156_0 = {
			ja = 5.9,
			ko = 5.433,
			zh = 5.533,
			en = 5.133
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play105121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "10001_tpose"

			if arg_156_1.actors_[var_159_0] == nil then
				local var_159_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_159_1) then
					local var_159_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_156_1.stage_.transform)

					var_159_2.name = var_159_0
					var_159_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_156_1.actors_[var_159_0] = var_159_2

					local var_159_3 = var_159_2:GetComponentInChildren(typeof(CharacterEffect))

					var_159_3.enabled = true

					local var_159_4 = GameObjectTools.GetOrAddComponent(var_159_2, typeof(DynamicBoneHelper))

					if var_159_4 then
						var_159_4:EnableDynamicBone(false)
					end

					arg_156_1:ShowWeapon(var_159_3.transform, false)

					arg_156_1.var_[var_159_0 .. "Animator"] = var_159_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_156_1.var_[var_159_0 .. "Animator"].applyRootMotion = true
					arg_156_1.var_[var_159_0 .. "LipSync"] = var_159_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_159_5 = arg_156_1.actors_["10001_tpose"]
			local var_159_6 = 0

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.characterEffect10001_tpose == nil then
				arg_156_1.var_.characterEffect10001_tpose = var_159_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_7 = 0.1

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_7 and not isNil(var_159_5) then
				local var_159_8 = (arg_156_1.time_ - var_159_6) / var_159_7

				if arg_156_1.var_.characterEffect10001_tpose and not isNil(var_159_5) then
					arg_156_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_6 + var_159_7 and arg_156_1.time_ < var_159_6 + var_159_7 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.characterEffect10001_tpose then
				arg_156_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_159_9 = arg_156_1.actors_["1148ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1148ui_story == nil then
				arg_156_1.var_.characterEffect1148ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.1

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1148ui_story and not isNil(var_159_9) then
					local var_159_13 = Mathf.Lerp(0, 0.5, var_159_12)

					arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1148ui_story.fillRatio = var_159_13
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1148ui_story then
				local var_159_14 = 0.5

				arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1148ui_story.fillRatio = var_159_14
			end

			local var_159_15 = arg_156_1.actors_["1148ui_story"].transform
			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.var_.moveOldPos1148ui_story = var_159_15.localPosition
			end

			local var_159_17 = 0.001

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 then
				local var_159_18 = (arg_156_1.time_ - var_159_16) / var_159_17
				local var_159_19 = Vector3.New(0, 100, 0)

				var_159_15.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1148ui_story, var_159_19, var_159_18)

				local var_159_20 = manager.ui.mainCamera.transform.position - var_159_15.position

				var_159_15.forward = Vector3.New(var_159_20.x, var_159_20.y, var_159_20.z)

				local var_159_21 = var_159_15.localEulerAngles

				var_159_21.z = 0
				var_159_21.x = 0
				var_159_15.localEulerAngles = var_159_21
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				var_159_15.localPosition = Vector3.New(0, 100, 0)

				local var_159_22 = manager.ui.mainCamera.transform.position - var_159_15.position

				var_159_15.forward = Vector3.New(var_159_22.x, var_159_22.y, var_159_22.z)

				local var_159_23 = var_159_15.localEulerAngles

				var_159_23.z = 0
				var_159_23.x = 0
				var_159_15.localEulerAngles = var_159_23
			end

			local var_159_24 = 0

			if var_159_24 < arg_156_1.time_ and arg_156_1.time_ <= var_159_24 + arg_159_0 then
				arg_156_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_159_25 = arg_156_1.actors_["10001_tpose"].transform
			local var_159_26 = 0

			if var_159_26 < arg_156_1.time_ and arg_156_1.time_ <= var_159_26 + arg_159_0 then
				arg_156_1.var_.moveOldPos10001_tpose = var_159_25.localPosition

				local var_159_27 = GameObjectTools.GetOrAddComponent(var_159_25.gameObject, typeof(DynamicBoneHelper))

				if var_159_27 then
					var_159_27:EnableDynamicBone(false)
				end
			end

			local var_159_28 = 0.001

			if var_159_26 <= arg_156_1.time_ and arg_156_1.time_ < var_159_26 + var_159_28 then
				local var_159_29 = (arg_156_1.time_ - var_159_26) / var_159_28
				local var_159_30 = Vector3.New(0, -1.23, -5.8)

				var_159_25.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10001_tpose, var_159_30, var_159_29)

				local var_159_31 = manager.ui.mainCamera.transform.position - var_159_25.position

				var_159_25.forward = Vector3.New(var_159_31.x, var_159_31.y, var_159_31.z)

				local var_159_32 = var_159_25.localEulerAngles

				var_159_32.z = 0
				var_159_32.x = 0
				var_159_25.localEulerAngles = var_159_32
			end

			if arg_156_1.time_ >= var_159_26 + var_159_28 and arg_156_1.time_ < var_159_26 + var_159_28 + arg_159_0 then
				var_159_25.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_159_33 = manager.ui.mainCamera.transform.position - var_159_25.position

				var_159_25.forward = Vector3.New(var_159_33.x, var_159_33.y, var_159_33.z)

				local var_159_34 = var_159_25.localEulerAngles

				var_159_34.z = 0
				var_159_34.x = 0
				var_159_25.localEulerAngles = var_159_34

				local var_159_35 = GameObjectTools.GetOrAddComponent(var_159_25.gameObject, typeof(DynamicBoneHelper))

				if var_159_35 then
					var_159_35:EnableDynamicBone(true)
				end
			end

			local var_159_36 = 0

			if var_159_36 < arg_156_1.time_ and arg_156_1.time_ <= var_159_36 + arg_159_0 then
				arg_156_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_159_37 = 0
			local var_159_38 = 0.55

			if var_159_37 < arg_156_1.time_ and arg_156_1.time_ <= var_159_37 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_39 = arg_156_1:FormatText(StoryNameCfg[31].name)

				arg_156_1.leftNameTxt_.text = var_159_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_40 = arg_156_1:GetWordFromCfg(105121037)
				local var_159_41 = arg_156_1:FormatText(var_159_40.content)

				arg_156_1.text_.text = var_159_41

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_42 = 22
				local var_159_43 = utf8.len(var_159_41)
				local var_159_44 = var_159_42 <= 0 and var_159_38 or var_159_38 * (var_159_43 / var_159_42)

				if var_159_44 > 0 and var_159_38 < var_159_44 then
					arg_156_1.talkMaxDuration = var_159_44

					if var_159_44 + var_159_37 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_44 + var_159_37
					end
				end

				arg_156_1.text_.text = var_159_41
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121037", "story_v_out_105121.awb") ~= 0 then
					local var_159_45 = manager.audio:GetVoiceLength("story_v_out_105121", "105121037", "story_v_out_105121.awb") / 1000

					if var_159_45 + var_159_37 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_45 + var_159_37
					end

					if var_159_40.prefab_name ~= "" and arg_156_1.actors_[var_159_40.prefab_name] ~= nil then
						local var_159_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_40.prefab_name].transform, "story_v_out_105121", "105121037", "story_v_out_105121.awb")

						arg_156_1:RecordAudio("105121037", var_159_46)
						arg_156_1:RecordAudio("105121037", var_159_46)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_105121", "105121037", "story_v_out_105121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_105121", "105121037", "story_v_out_105121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_47 = math.max(var_159_38, arg_156_1.talkMaxDuration)

			if var_159_37 <= arg_156_1.time_ and arg_156_1.time_ < var_159_37 + var_159_47 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_37) / var_159_47

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_37 + var_159_47 and arg_156_1.time_ < var_159_37 + var_159_47 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_156_1:InitPlayNodeList()
	end,
	Play105121038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 105121038
		arg_160_1.duration_ = 4.03

		local var_160_0 = {
			ja = 4,
			ko = 2.2,
			zh = 2.933,
			en = 4.033
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play105121039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1036ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1036ui_story == nil then
				arg_160_1.var_.characterEffect1036ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.1

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1036ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1036ui_story then
				arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["10001_tpose"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect10001_tpose == nil then
				arg_160_1.var_.characterEffect10001_tpose = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.1

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect10001_tpose and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_160_1.var_.characterEffect10001_tpose.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect10001_tpose then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_160_1.var_.characterEffect10001_tpose.fillRatio = var_163_9
			end

			local var_163_10 = arg_160_1.actors_["10001_tpose"].transform
			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.var_.moveOldPos10001_tpose = var_163_10.localPosition

				local var_163_12 = GameObjectTools.GetOrAddComponent(var_163_10.gameObject, typeof(DynamicBoneHelper))

				if var_163_12 then
					var_163_12:EnableDynamicBone(false)
				end
			end

			local var_163_13 = 0.001

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_13 then
				local var_163_14 = (arg_160_1.time_ - var_163_11) / var_163_13
				local var_163_15 = Vector3.New(0, 100, 0)

				var_163_10.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10001_tpose, var_163_15, var_163_14)

				local var_163_16 = manager.ui.mainCamera.transform.position - var_163_10.position

				var_163_10.forward = Vector3.New(var_163_16.x, var_163_16.y, var_163_16.z)

				local var_163_17 = var_163_10.localEulerAngles

				var_163_17.z = 0
				var_163_17.x = 0
				var_163_10.localEulerAngles = var_163_17
			end

			if arg_160_1.time_ >= var_163_11 + var_163_13 and arg_160_1.time_ < var_163_11 + var_163_13 + arg_163_0 then
				var_163_10.localPosition = Vector3.New(0, 100, 0)

				local var_163_18 = manager.ui.mainCamera.transform.position - var_163_10.position

				var_163_10.forward = Vector3.New(var_163_18.x, var_163_18.y, var_163_18.z)

				local var_163_19 = var_163_10.localEulerAngles

				var_163_19.z = 0
				var_163_19.x = 0
				var_163_10.localEulerAngles = var_163_19

				local var_163_20 = GameObjectTools.GetOrAddComponent(var_163_10.gameObject, typeof(DynamicBoneHelper))

				if var_163_20 then
					var_163_20:EnableDynamicBone(true)
				end
			end

			local var_163_21 = arg_160_1.actors_["1036ui_story"].transform
			local var_163_22 = 0

			if var_163_22 < arg_160_1.time_ and arg_160_1.time_ <= var_163_22 + arg_163_0 then
				arg_160_1.var_.moveOldPos1036ui_story = var_163_21.localPosition
			end

			local var_163_23 = 0.001

			if var_163_22 <= arg_160_1.time_ and arg_160_1.time_ < var_163_22 + var_163_23 then
				local var_163_24 = (arg_160_1.time_ - var_163_22) / var_163_23
				local var_163_25 = Vector3.New(-0.7, -1.09, -5.78)

				var_163_21.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1036ui_story, var_163_25, var_163_24)

				local var_163_26 = manager.ui.mainCamera.transform.position - var_163_21.position

				var_163_21.forward = Vector3.New(var_163_26.x, var_163_26.y, var_163_26.z)

				local var_163_27 = var_163_21.localEulerAngles

				var_163_27.z = 0
				var_163_27.x = 0
				var_163_21.localEulerAngles = var_163_27
			end

			if arg_160_1.time_ >= var_163_22 + var_163_23 and arg_160_1.time_ < var_163_22 + var_163_23 + arg_163_0 then
				var_163_21.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_163_28 = manager.ui.mainCamera.transform.position - var_163_21.position

				var_163_21.forward = Vector3.New(var_163_28.x, var_163_28.y, var_163_28.z)

				local var_163_29 = var_163_21.localEulerAngles

				var_163_29.z = 0
				var_163_29.x = 0
				var_163_21.localEulerAngles = var_163_29
			end

			local var_163_30 = 0

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_163_31 = 0

			if var_163_31 < arg_160_1.time_ and arg_160_1.time_ <= var_163_31 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_163_32 = 0
			local var_163_33 = 0.35

			if var_163_32 < arg_160_1.time_ and arg_160_1.time_ <= var_163_32 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_34 = arg_160_1:FormatText(StoryNameCfg[5].name)

				arg_160_1.leftNameTxt_.text = var_163_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_35 = arg_160_1:GetWordFromCfg(105121038)
				local var_163_36 = arg_160_1:FormatText(var_163_35.content)

				arg_160_1.text_.text = var_163_36

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_37 = 14
				local var_163_38 = utf8.len(var_163_36)
				local var_163_39 = var_163_37 <= 0 and var_163_33 or var_163_33 * (var_163_38 / var_163_37)

				if var_163_39 > 0 and var_163_33 < var_163_39 then
					arg_160_1.talkMaxDuration = var_163_39

					if var_163_39 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_39 + var_163_32
					end
				end

				arg_160_1.text_.text = var_163_36
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121038", "story_v_out_105121.awb") ~= 0 then
					local var_163_40 = manager.audio:GetVoiceLength("story_v_out_105121", "105121038", "story_v_out_105121.awb") / 1000

					if var_163_40 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_40 + var_163_32
					end

					if var_163_35.prefab_name ~= "" and arg_160_1.actors_[var_163_35.prefab_name] ~= nil then
						local var_163_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_35.prefab_name].transform, "story_v_out_105121", "105121038", "story_v_out_105121.awb")

						arg_160_1:RecordAudio("105121038", var_163_41)
						arg_160_1:RecordAudio("105121038", var_163_41)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_105121", "105121038", "story_v_out_105121.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_105121", "105121038", "story_v_out_105121.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_42 = math.max(var_163_33, arg_160_1.talkMaxDuration)

			if var_163_32 <= arg_160_1.time_ and arg_160_1.time_ < var_163_32 + var_163_42 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_32) / var_163_42

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_32 + var_163_42 and arg_160_1.time_ < var_163_32 + var_163_42 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
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

		arg_160_1:InitPlayNodeList()
	end,
	Play105121039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 105121039
		arg_164_1.duration_ = 6.1

		local var_164_0 = {
			ja = 6.1,
			ko = 4.466,
			zh = 5.733,
			en = 5.333
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play105121040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1148ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1148ui_story == nil then
				arg_164_1.var_.characterEffect1148ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1148ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1148ui_story then
				arg_164_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_167_4 = arg_164_1.actors_["1036ui_story"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect1036ui_story == nil then
				arg_164_1.var_.characterEffect1036ui_story = var_167_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.1

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.characterEffect1036ui_story and not isNil(var_167_4) then
					local var_167_8 = Mathf.Lerp(0, 0.5, var_167_7)

					arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1036ui_story.fillRatio = var_167_8
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect1036ui_story then
				local var_167_9 = 0.5

				arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1036ui_story.fillRatio = var_167_9
			end

			local var_167_10 = arg_164_1.actors_["1148ui_story"].transform
			local var_167_11 = 0

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.var_.moveOldPos1148ui_story = var_167_10.localPosition
			end

			local var_167_12 = 0.001

			if var_167_11 <= arg_164_1.time_ and arg_164_1.time_ < var_167_11 + var_167_12 then
				local var_167_13 = (arg_164_1.time_ - var_167_11) / var_167_12
				local var_167_14 = Vector3.New(0.7, -0.8, -6.2)

				var_167_10.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1148ui_story, var_167_14, var_167_13)

				local var_167_15 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_15.x, var_167_15.y, var_167_15.z)

				local var_167_16 = var_167_10.localEulerAngles

				var_167_16.z = 0
				var_167_16.x = 0
				var_167_10.localEulerAngles = var_167_16
			end

			if arg_164_1.time_ >= var_167_11 + var_167_12 and arg_164_1.time_ < var_167_11 + var_167_12 + arg_167_0 then
				var_167_10.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_167_17 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_17.x, var_167_17.y, var_167_17.z)

				local var_167_18 = var_167_10.localEulerAngles

				var_167_18.z = 0
				var_167_18.x = 0
				var_167_10.localEulerAngles = var_167_18
			end

			local var_167_19 = 0

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_167_20 = 0

			if var_167_20 < arg_164_1.time_ and arg_164_1.time_ <= var_167_20 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_167_21 = 0
			local var_167_22 = 0.55

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_23 = arg_164_1:FormatText(StoryNameCfg[8].name)

				arg_164_1.leftNameTxt_.text = var_167_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_24 = arg_164_1:GetWordFromCfg(105121039)
				local var_167_25 = arg_164_1:FormatText(var_167_24.content)

				arg_164_1.text_.text = var_167_25

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_26 = 22
				local var_167_27 = utf8.len(var_167_25)
				local var_167_28 = var_167_26 <= 0 and var_167_22 or var_167_22 * (var_167_27 / var_167_26)

				if var_167_28 > 0 and var_167_22 < var_167_28 then
					arg_164_1.talkMaxDuration = var_167_28

					if var_167_28 + var_167_21 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_28 + var_167_21
					end
				end

				arg_164_1.text_.text = var_167_25
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121039", "story_v_out_105121.awb") ~= 0 then
					local var_167_29 = manager.audio:GetVoiceLength("story_v_out_105121", "105121039", "story_v_out_105121.awb") / 1000

					if var_167_29 + var_167_21 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_29 + var_167_21
					end

					if var_167_24.prefab_name ~= "" and arg_164_1.actors_[var_167_24.prefab_name] ~= nil then
						local var_167_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_24.prefab_name].transform, "story_v_out_105121", "105121039", "story_v_out_105121.awb")

						arg_164_1:RecordAudio("105121039", var_167_30)
						arg_164_1:RecordAudio("105121039", var_167_30)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_105121", "105121039", "story_v_out_105121.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_105121", "105121039", "story_v_out_105121.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_31 = math.max(var_167_22, arg_164_1.talkMaxDuration)

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_31 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_21) / var_167_31

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_21 + var_167_31 and arg_164_1.time_ < var_167_21 + var_167_31 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play105121040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 105121040
		arg_168_1.duration_ = 14.4

		local var_168_0 = {
			ja = 14.4,
			ko = 6.166,
			zh = 6.8,
			en = 8.066
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play105121041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1019ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1019ui_story == nil then
				arg_168_1.var_.characterEffect1019ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.1

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1019ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1019ui_story then
				arg_168_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_171_4 = arg_168_1.actors_["1148ui_story"]
			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect1148ui_story == nil then
				arg_168_1.var_.characterEffect1148ui_story = var_171_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_6 = 0.1

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_6 and not isNil(var_171_4) then
				local var_171_7 = (arg_168_1.time_ - var_171_5) / var_171_6

				if arg_168_1.var_.characterEffect1148ui_story and not isNil(var_171_4) then
					local var_171_8 = Mathf.Lerp(0, 0.5, var_171_7)

					arg_168_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1148ui_story.fillRatio = var_171_8
				end
			end

			if arg_168_1.time_ >= var_171_5 + var_171_6 and arg_168_1.time_ < var_171_5 + var_171_6 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect1148ui_story then
				local var_171_9 = 0.5

				arg_168_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1148ui_story.fillRatio = var_171_9
			end

			local var_171_10 = arg_168_1.actors_["1148ui_story"].transform
			local var_171_11 = 0

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1.var_.moveOldPos1148ui_story = var_171_10.localPosition
			end

			local var_171_12 = 0.001

			if var_171_11 <= arg_168_1.time_ and arg_168_1.time_ < var_171_11 + var_171_12 then
				local var_171_13 = (arg_168_1.time_ - var_171_11) / var_171_12
				local var_171_14 = Vector3.New(0, 100, 0)

				var_171_10.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1148ui_story, var_171_14, var_171_13)

				local var_171_15 = manager.ui.mainCamera.transform.position - var_171_10.position

				var_171_10.forward = Vector3.New(var_171_15.x, var_171_15.y, var_171_15.z)

				local var_171_16 = var_171_10.localEulerAngles

				var_171_16.z = 0
				var_171_16.x = 0
				var_171_10.localEulerAngles = var_171_16
			end

			if arg_168_1.time_ >= var_171_11 + var_171_12 and arg_168_1.time_ < var_171_11 + var_171_12 + arg_171_0 then
				var_171_10.localPosition = Vector3.New(0, 100, 0)

				local var_171_17 = manager.ui.mainCamera.transform.position - var_171_10.position

				var_171_10.forward = Vector3.New(var_171_17.x, var_171_17.y, var_171_17.z)

				local var_171_18 = var_171_10.localEulerAngles

				var_171_18.z = 0
				var_171_18.x = 0
				var_171_10.localEulerAngles = var_171_18
			end

			local var_171_19 = arg_168_1.actors_["1036ui_story"].transform
			local var_171_20 = 0

			if var_171_20 < arg_168_1.time_ and arg_168_1.time_ <= var_171_20 + arg_171_0 then
				arg_168_1.var_.moveOldPos1036ui_story = var_171_19.localPosition
			end

			local var_171_21 = 0.001

			if var_171_20 <= arg_168_1.time_ and arg_168_1.time_ < var_171_20 + var_171_21 then
				local var_171_22 = (arg_168_1.time_ - var_171_20) / var_171_21
				local var_171_23 = Vector3.New(0, 100, 0)

				var_171_19.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1036ui_story, var_171_23, var_171_22)

				local var_171_24 = manager.ui.mainCamera.transform.position - var_171_19.position

				var_171_19.forward = Vector3.New(var_171_24.x, var_171_24.y, var_171_24.z)

				local var_171_25 = var_171_19.localEulerAngles

				var_171_25.z = 0
				var_171_25.x = 0
				var_171_19.localEulerAngles = var_171_25
			end

			if arg_168_1.time_ >= var_171_20 + var_171_21 and arg_168_1.time_ < var_171_20 + var_171_21 + arg_171_0 then
				var_171_19.localPosition = Vector3.New(0, 100, 0)

				local var_171_26 = manager.ui.mainCamera.transform.position - var_171_19.position

				var_171_19.forward = Vector3.New(var_171_26.x, var_171_26.y, var_171_26.z)

				local var_171_27 = var_171_19.localEulerAngles

				var_171_27.z = 0
				var_171_27.x = 0
				var_171_19.localEulerAngles = var_171_27
			end

			local var_171_28 = arg_168_1.actors_["1019ui_story"].transform
			local var_171_29 = 0

			if var_171_29 < arg_168_1.time_ and arg_168_1.time_ <= var_171_29 + arg_171_0 then
				arg_168_1.var_.moveOldPos1019ui_story = var_171_28.localPosition
			end

			local var_171_30 = 0.001

			if var_171_29 <= arg_168_1.time_ and arg_168_1.time_ < var_171_29 + var_171_30 then
				local var_171_31 = (arg_168_1.time_ - var_171_29) / var_171_30
				local var_171_32 = Vector3.New(-0.2, -1.08, -5.9)

				var_171_28.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1019ui_story, var_171_32, var_171_31)

				local var_171_33 = manager.ui.mainCamera.transform.position - var_171_28.position

				var_171_28.forward = Vector3.New(var_171_33.x, var_171_33.y, var_171_33.z)

				local var_171_34 = var_171_28.localEulerAngles

				var_171_34.z = 0
				var_171_34.x = 0
				var_171_28.localEulerAngles = var_171_34
			end

			if arg_168_1.time_ >= var_171_29 + var_171_30 and arg_168_1.time_ < var_171_29 + var_171_30 + arg_171_0 then
				var_171_28.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_171_35 = manager.ui.mainCamera.transform.position - var_171_28.position

				var_171_28.forward = Vector3.New(var_171_35.x, var_171_35.y, var_171_35.z)

				local var_171_36 = var_171_28.localEulerAngles

				var_171_36.z = 0
				var_171_36.x = 0
				var_171_28.localEulerAngles = var_171_36
			end

			local var_171_37 = 0

			if var_171_37 < arg_168_1.time_ and arg_168_1.time_ <= var_171_37 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_171_38 = 0

			if var_171_38 < arg_168_1.time_ and arg_168_1.time_ <= var_171_38 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_171_39 = 0
			local var_171_40 = 0.925

			if var_171_39 < arg_168_1.time_ and arg_168_1.time_ <= var_171_39 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_41 = arg_168_1:FormatText(StoryNameCfg[13].name)

				arg_168_1.leftNameTxt_.text = var_171_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_42 = arg_168_1:GetWordFromCfg(105121040)
				local var_171_43 = arg_168_1:FormatText(var_171_42.content)

				arg_168_1.text_.text = var_171_43

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_44 = 37
				local var_171_45 = utf8.len(var_171_43)
				local var_171_46 = var_171_44 <= 0 and var_171_40 or var_171_40 * (var_171_45 / var_171_44)

				if var_171_46 > 0 and var_171_40 < var_171_46 then
					arg_168_1.talkMaxDuration = var_171_46

					if var_171_46 + var_171_39 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_46 + var_171_39
					end
				end

				arg_168_1.text_.text = var_171_43
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121040", "story_v_out_105121.awb") ~= 0 then
					local var_171_47 = manager.audio:GetVoiceLength("story_v_out_105121", "105121040", "story_v_out_105121.awb") / 1000

					if var_171_47 + var_171_39 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_47 + var_171_39
					end

					if var_171_42.prefab_name ~= "" and arg_168_1.actors_[var_171_42.prefab_name] ~= nil then
						local var_171_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_42.prefab_name].transform, "story_v_out_105121", "105121040", "story_v_out_105121.awb")

						arg_168_1:RecordAudio("105121040", var_171_48)
						arg_168_1:RecordAudio("105121040", var_171_48)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_105121", "105121040", "story_v_out_105121.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_105121", "105121040", "story_v_out_105121.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_49 = math.max(var_171_40, arg_168_1.talkMaxDuration)

			if var_171_39 <= arg_168_1.time_ and arg_168_1.time_ < var_171_39 + var_171_49 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_39) / var_171_49

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_39 + var_171_49 and arg_168_1.time_ < var_171_39 + var_171_49 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
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

		arg_168_1:InitPlayNodeList()
	end,
	Play105121041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 105121041
		arg_172_1.duration_ = 1.53

		local var_172_0 = {
			ja = 1.3,
			ko = 1.433,
			zh = 1.333,
			en = 1.533
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play105121042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10001_tpose"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10001_tpose == nil then
				arg_172_1.var_.characterEffect10001_tpose = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.1

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10001_tpose and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10001_tpose then
				arg_172_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1019ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1019ui_story == nil then
				arg_172_1.var_.characterEffect1019ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.1

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect1019ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1019ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1019ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1019ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_175_11 = 0
			local var_175_12 = 0.075

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_13 = arg_172_1:FormatText(StoryNameCfg[31].name)

				arg_172_1.leftNameTxt_.text = var_175_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_14 = arg_172_1:GetWordFromCfg(105121041)
				local var_175_15 = arg_172_1:FormatText(var_175_14.content)

				arg_172_1.text_.text = var_175_15

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 3
				local var_175_17 = utf8.len(var_175_15)
				local var_175_18 = var_175_16 <= 0 and var_175_12 or var_175_12 * (var_175_17 / var_175_16)

				if var_175_18 > 0 and var_175_12 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_15
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121041", "story_v_out_105121.awb") ~= 0 then
					local var_175_19 = manager.audio:GetVoiceLength("story_v_out_105121", "105121041", "story_v_out_105121.awb") / 1000

					if var_175_19 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_11
					end

					if var_175_14.prefab_name ~= "" and arg_172_1.actors_[var_175_14.prefab_name] ~= nil then
						local var_175_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_14.prefab_name].transform, "story_v_out_105121", "105121041", "story_v_out_105121.awb")

						arg_172_1:RecordAudio("105121041", var_175_20)
						arg_172_1:RecordAudio("105121041", var_175_20)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_105121", "105121041", "story_v_out_105121.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_105121", "105121041", "story_v_out_105121.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_21 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_21 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_21

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_21 and arg_172_1.time_ < var_175_11 + var_175_21 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play105121042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 105121042
		arg_176_1.duration_ = 8.23

		local var_176_0 = {
			ja = 4.466,
			ko = 8.233,
			zh = 7.366,
			en = 7.9
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play105121043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1036ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1036ui_story == nil then
				arg_176_1.var_.characterEffect1036ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.1

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1036ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1036ui_story then
				arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["10001_tpose"]
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect10001_tpose == nil then
				arg_176_1.var_.characterEffect10001_tpose = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_6 = 0.1

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 and not isNil(var_179_4) then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6

				if arg_176_1.var_.characterEffect10001_tpose and not isNil(var_179_4) then
					local var_179_8 = Mathf.Lerp(0, 0.5, var_179_7)

					arg_176_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_176_1.var_.characterEffect10001_tpose.fillRatio = var_179_8
				end
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect10001_tpose then
				local var_179_9 = 0.5

				arg_176_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_176_1.var_.characterEffect10001_tpose.fillRatio = var_179_9
			end

			local var_179_10 = arg_176_1.actors_["1019ui_story"].transform
			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = var_179_10.localPosition
			end

			local var_179_12 = 0.001

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_11) / var_179_12
				local var_179_14 = Vector3.New(0, 100, 0)

				var_179_10.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, var_179_14, var_179_13)

				local var_179_15 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_15.x, var_179_15.y, var_179_15.z)

				local var_179_16 = var_179_10.localEulerAngles

				var_179_16.z = 0
				var_179_16.x = 0
				var_179_10.localEulerAngles = var_179_16
			end

			if arg_176_1.time_ >= var_179_11 + var_179_12 and arg_176_1.time_ < var_179_11 + var_179_12 + arg_179_0 then
				var_179_10.localPosition = Vector3.New(0, 100, 0)

				local var_179_17 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_17.x, var_179_17.y, var_179_17.z)

				local var_179_18 = var_179_10.localEulerAngles

				var_179_18.z = 0
				var_179_18.x = 0
				var_179_10.localEulerAngles = var_179_18
			end

			local var_179_19 = arg_176_1.actors_["1036ui_story"].transform
			local var_179_20 = 0

			if var_179_20 < arg_176_1.time_ and arg_176_1.time_ <= var_179_20 + arg_179_0 then
				arg_176_1.var_.moveOldPos1036ui_story = var_179_19.localPosition
			end

			local var_179_21 = 0.001

			if var_179_20 <= arg_176_1.time_ and arg_176_1.time_ < var_179_20 + var_179_21 then
				local var_179_22 = (arg_176_1.time_ - var_179_20) / var_179_21
				local var_179_23 = Vector3.New(0, -1.09, -5.78)

				var_179_19.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1036ui_story, var_179_23, var_179_22)

				local var_179_24 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_24.x, var_179_24.y, var_179_24.z)

				local var_179_25 = var_179_19.localEulerAngles

				var_179_25.z = 0
				var_179_25.x = 0
				var_179_19.localEulerAngles = var_179_25
			end

			if arg_176_1.time_ >= var_179_20 + var_179_21 and arg_176_1.time_ < var_179_20 + var_179_21 + arg_179_0 then
				var_179_19.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_179_26 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_26.x, var_179_26.y, var_179_26.z)

				local var_179_27 = var_179_19.localEulerAngles

				var_179_27.z = 0
				var_179_27.x = 0
				var_179_19.localEulerAngles = var_179_27
			end

			local var_179_28 = 0

			if var_179_28 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_179_29 = 0

			if var_179_29 < arg_176_1.time_ and arg_176_1.time_ <= var_179_29 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_179_30 = 0
			local var_179_31 = 1.025

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_32 = arg_176_1:FormatText(StoryNameCfg[5].name)

				arg_176_1.leftNameTxt_.text = var_179_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_33 = arg_176_1:GetWordFromCfg(105121042)
				local var_179_34 = arg_176_1:FormatText(var_179_33.content)

				arg_176_1.text_.text = var_179_34

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_35 = 40
				local var_179_36 = utf8.len(var_179_34)
				local var_179_37 = var_179_35 <= 0 and var_179_31 or var_179_31 * (var_179_36 / var_179_35)

				if var_179_37 > 0 and var_179_31 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end

				arg_176_1.text_.text = var_179_34
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121042", "story_v_out_105121.awb") ~= 0 then
					local var_179_38 = manager.audio:GetVoiceLength("story_v_out_105121", "105121042", "story_v_out_105121.awb") / 1000

					if var_179_38 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_30
					end

					if var_179_33.prefab_name ~= "" and arg_176_1.actors_[var_179_33.prefab_name] ~= nil then
						local var_179_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_33.prefab_name].transform, "story_v_out_105121", "105121042", "story_v_out_105121.awb")

						arg_176_1:RecordAudio("105121042", var_179_39)
						arg_176_1:RecordAudio("105121042", var_179_39)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_105121", "105121042", "story_v_out_105121.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_105121", "105121042", "story_v_out_105121.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_40 = math.max(var_179_31, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_40 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_30) / var_179_40

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_40 and arg_176_1.time_ < var_179_30 + var_179_40 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play105121043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 105121043
		arg_180_1.duration_ = 8.5

		local var_180_0 = {
			ja = 7.533,
			ko = 7.833,
			zh = 8.5,
			en = 7.666
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play105121044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = "1027ui_story"

			if arg_180_1.actors_[var_183_0] == nil then
				local var_183_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_183_1) then
					local var_183_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_180_1.stage_.transform)

					var_183_2.name = var_183_0
					var_183_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_180_1.actors_[var_183_0] = var_183_2

					local var_183_3 = var_183_2:GetComponentInChildren(typeof(CharacterEffect))

					var_183_3.enabled = true

					local var_183_4 = GameObjectTools.GetOrAddComponent(var_183_2, typeof(DynamicBoneHelper))

					if var_183_4 then
						var_183_4:EnableDynamicBone(false)
					end

					arg_180_1:ShowWeapon(var_183_3.transform, false)

					arg_180_1.var_[var_183_0 .. "Animator"] = var_183_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_180_1.var_[var_183_0 .. "Animator"].applyRootMotion = true
					arg_180_1.var_[var_183_0 .. "LipSync"] = var_183_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_183_5 = arg_180_1.actors_["1027ui_story"]
			local var_183_6 = 0

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.characterEffect1027ui_story == nil then
				arg_180_1.var_.characterEffect1027ui_story = var_183_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_7 = 0.1

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_7 and not isNil(var_183_5) then
				local var_183_8 = (arg_180_1.time_ - var_183_6) / var_183_7

				if arg_180_1.var_.characterEffect1027ui_story and not isNil(var_183_5) then
					arg_180_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_6 + var_183_7 and arg_180_1.time_ < var_183_6 + var_183_7 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.characterEffect1027ui_story then
				arg_180_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_183_9 = arg_180_1.actors_["1036ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1036ui_story == nil then
				arg_180_1.var_.characterEffect1036ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.1

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1036ui_story and not isNil(var_183_9) then
					local var_183_13 = Mathf.Lerp(0, 0.5, var_183_12)

					arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1036ui_story.fillRatio = var_183_13
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1036ui_story then
				local var_183_14 = 0.5

				arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1036ui_story.fillRatio = var_183_14
			end

			local var_183_15 = arg_180_1.actors_["1036ui_story"].transform
			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.var_.moveOldPos1036ui_story = var_183_15.localPosition
			end

			local var_183_17 = 0.001

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17
				local var_183_19 = Vector3.New(0, -1.09, -5.78)

				var_183_15.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1036ui_story, var_183_19, var_183_18)

				local var_183_20 = manager.ui.mainCamera.transform.position - var_183_15.position

				var_183_15.forward = Vector3.New(var_183_20.x, var_183_20.y, var_183_20.z)

				local var_183_21 = var_183_15.localEulerAngles

				var_183_21.z = 0
				var_183_21.x = 0
				var_183_15.localEulerAngles = var_183_21
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 then
				var_183_15.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_183_22 = manager.ui.mainCamera.transform.position - var_183_15.position

				var_183_15.forward = Vector3.New(var_183_22.x, var_183_22.y, var_183_22.z)

				local var_183_23 = var_183_15.localEulerAngles

				var_183_23.z = 0
				var_183_23.x = 0
				var_183_15.localEulerAngles = var_183_23
			end

			local var_183_24 = arg_180_1.actors_["1036ui_story"].transform
			local var_183_25 = 0.033

			if var_183_25 < arg_180_1.time_ and arg_180_1.time_ <= var_183_25 + arg_183_0 then
				arg_180_1.var_.moveOldPos1036ui_story = var_183_24.localPosition
			end

			local var_183_26 = 0.5

			if var_183_25 <= arg_180_1.time_ and arg_180_1.time_ < var_183_25 + var_183_26 then
				local var_183_27 = (arg_180_1.time_ - var_183_25) / var_183_26
				local var_183_28 = Vector3.New(0.7, -1.09, -5.78)

				var_183_24.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1036ui_story, var_183_28, var_183_27)

				local var_183_29 = manager.ui.mainCamera.transform.position - var_183_24.position

				var_183_24.forward = Vector3.New(var_183_29.x, var_183_29.y, var_183_29.z)

				local var_183_30 = var_183_24.localEulerAngles

				var_183_30.z = 0
				var_183_30.x = 0
				var_183_24.localEulerAngles = var_183_30
			end

			if arg_180_1.time_ >= var_183_25 + var_183_26 and arg_180_1.time_ < var_183_25 + var_183_26 + arg_183_0 then
				var_183_24.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_183_31 = manager.ui.mainCamera.transform.position - var_183_24.position

				var_183_24.forward = Vector3.New(var_183_31.x, var_183_31.y, var_183_31.z)

				local var_183_32 = var_183_24.localEulerAngles

				var_183_32.z = 0
				var_183_32.x = 0
				var_183_24.localEulerAngles = var_183_32
			end

			local var_183_33 = arg_180_1.actors_["1027ui_story"].transform
			local var_183_34 = 0

			if var_183_34 < arg_180_1.time_ and arg_180_1.time_ <= var_183_34 + arg_183_0 then
				arg_180_1.var_.moveOldPos1027ui_story = var_183_33.localPosition
			end

			local var_183_35 = 0.001

			if var_183_34 <= arg_180_1.time_ and arg_180_1.time_ < var_183_34 + var_183_35 then
				local var_183_36 = (arg_180_1.time_ - var_183_34) / var_183_35
				local var_183_37 = Vector3.New(-0.7, -0.81, -5.8)

				var_183_33.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1027ui_story, var_183_37, var_183_36)

				local var_183_38 = manager.ui.mainCamera.transform.position - var_183_33.position

				var_183_33.forward = Vector3.New(var_183_38.x, var_183_38.y, var_183_38.z)

				local var_183_39 = var_183_33.localEulerAngles

				var_183_39.z = 0
				var_183_39.x = 0
				var_183_33.localEulerAngles = var_183_39
			end

			if arg_180_1.time_ >= var_183_34 + var_183_35 and arg_180_1.time_ < var_183_34 + var_183_35 + arg_183_0 then
				var_183_33.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_183_40 = manager.ui.mainCamera.transform.position - var_183_33.position

				var_183_33.forward = Vector3.New(var_183_40.x, var_183_40.y, var_183_40.z)

				local var_183_41 = var_183_33.localEulerAngles

				var_183_41.z = 0
				var_183_41.x = 0
				var_183_33.localEulerAngles = var_183_41
			end

			local var_183_42 = 0

			if var_183_42 < arg_180_1.time_ and arg_180_1.time_ <= var_183_42 + arg_183_0 then
				arg_180_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_183_43 = 0

			if var_183_43 < arg_180_1.time_ and arg_180_1.time_ <= var_183_43 + arg_183_0 then
				arg_180_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_183_44 = 0
			local var_183_45 = 0.925

			if var_183_44 < arg_180_1.time_ and arg_180_1.time_ <= var_183_44 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_46 = arg_180_1:FormatText(StoryNameCfg[56].name)

				arg_180_1.leftNameTxt_.text = var_183_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_47 = arg_180_1:GetWordFromCfg(105121043)
				local var_183_48 = arg_180_1:FormatText(var_183_47.content)

				arg_180_1.text_.text = var_183_48

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_49 = 37
				local var_183_50 = utf8.len(var_183_48)
				local var_183_51 = var_183_49 <= 0 and var_183_45 or var_183_45 * (var_183_50 / var_183_49)

				if var_183_51 > 0 and var_183_45 < var_183_51 then
					arg_180_1.talkMaxDuration = var_183_51

					if var_183_51 + var_183_44 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_51 + var_183_44
					end
				end

				arg_180_1.text_.text = var_183_48
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121043", "story_v_out_105121.awb") ~= 0 then
					local var_183_52 = manager.audio:GetVoiceLength("story_v_out_105121", "105121043", "story_v_out_105121.awb") / 1000

					if var_183_52 + var_183_44 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_52 + var_183_44
					end

					if var_183_47.prefab_name ~= "" and arg_180_1.actors_[var_183_47.prefab_name] ~= nil then
						local var_183_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_47.prefab_name].transform, "story_v_out_105121", "105121043", "story_v_out_105121.awb")

						arg_180_1:RecordAudio("105121043", var_183_53)
						arg_180_1:RecordAudio("105121043", var_183_53)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_105121", "105121043", "story_v_out_105121.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_105121", "105121043", "story_v_out_105121.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_54 = math.max(var_183_45, arg_180_1.talkMaxDuration)

			if var_183_44 <= arg_180_1.time_ and arg_180_1.time_ < var_183_44 + var_183_54 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_44) / var_183_54

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_44 + var_183_54 and arg_180_1.time_ < var_183_44 + var_183_54 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play105121044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 105121044
		arg_184_1.duration_ = 7.1

		local var_184_0 = {
			ja = 7.1,
			ko = 3.7,
			zh = 3.366,
			en = 3.033
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play105121045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1148ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1148ui_story == nil then
				arg_184_1.var_.characterEffect1148ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.1

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1148ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1148ui_story then
				arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["1027ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1027ui_story == nil then
				arg_184_1.var_.characterEffect1027ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.1

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect1027ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1027ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1027ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1027ui_story.fillRatio = var_187_9
			end

			local var_187_10 = arg_184_1.actors_["1036ui_story"].transform
			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.var_.moveOldPos1036ui_story = var_187_10.localPosition
			end

			local var_187_12 = 0.001

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_12 then
				local var_187_13 = (arg_184_1.time_ - var_187_11) / var_187_12
				local var_187_14 = Vector3.New(0, 100, 0)

				var_187_10.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1036ui_story, var_187_14, var_187_13)

				local var_187_15 = manager.ui.mainCamera.transform.position - var_187_10.position

				var_187_10.forward = Vector3.New(var_187_15.x, var_187_15.y, var_187_15.z)

				local var_187_16 = var_187_10.localEulerAngles

				var_187_16.z = 0
				var_187_16.x = 0
				var_187_10.localEulerAngles = var_187_16
			end

			if arg_184_1.time_ >= var_187_11 + var_187_12 and arg_184_1.time_ < var_187_11 + var_187_12 + arg_187_0 then
				var_187_10.localPosition = Vector3.New(0, 100, 0)

				local var_187_17 = manager.ui.mainCamera.transform.position - var_187_10.position

				var_187_10.forward = Vector3.New(var_187_17.x, var_187_17.y, var_187_17.z)

				local var_187_18 = var_187_10.localEulerAngles

				var_187_18.z = 0
				var_187_18.x = 0
				var_187_10.localEulerAngles = var_187_18
			end

			local var_187_19 = arg_184_1.actors_["1148ui_story"].transform
			local var_187_20 = 0

			if var_187_20 < arg_184_1.time_ and arg_184_1.time_ <= var_187_20 + arg_187_0 then
				arg_184_1.var_.moveOldPos1148ui_story = var_187_19.localPosition
			end

			local var_187_21 = 0.001

			if var_187_20 <= arg_184_1.time_ and arg_184_1.time_ < var_187_20 + var_187_21 then
				local var_187_22 = (arg_184_1.time_ - var_187_20) / var_187_21
				local var_187_23 = Vector3.New(0.7, -0.8, -6.2)

				var_187_19.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1148ui_story, var_187_23, var_187_22)

				local var_187_24 = manager.ui.mainCamera.transform.position - var_187_19.position

				var_187_19.forward = Vector3.New(var_187_24.x, var_187_24.y, var_187_24.z)

				local var_187_25 = var_187_19.localEulerAngles

				var_187_25.z = 0
				var_187_25.x = 0
				var_187_19.localEulerAngles = var_187_25
			end

			if arg_184_1.time_ >= var_187_20 + var_187_21 and arg_184_1.time_ < var_187_20 + var_187_21 + arg_187_0 then
				var_187_19.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_187_26 = manager.ui.mainCamera.transform.position - var_187_19.position

				var_187_19.forward = Vector3.New(var_187_26.x, var_187_26.y, var_187_26.z)

				local var_187_27 = var_187_19.localEulerAngles

				var_187_27.z = 0
				var_187_27.x = 0
				var_187_19.localEulerAngles = var_187_27
			end

			local var_187_28 = 0

			if var_187_28 < arg_184_1.time_ and arg_184_1.time_ <= var_187_28 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_187_29 = 0

			if var_187_29 < arg_184_1.time_ and arg_184_1.time_ <= var_187_29 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_187_30 = 0
			local var_187_31 = 0.4

			if var_187_30 < arg_184_1.time_ and arg_184_1.time_ <= var_187_30 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_32 = arg_184_1:FormatText(StoryNameCfg[8].name)

				arg_184_1.leftNameTxt_.text = var_187_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_33 = arg_184_1:GetWordFromCfg(105121044)
				local var_187_34 = arg_184_1:FormatText(var_187_33.content)

				arg_184_1.text_.text = var_187_34

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_35 = 16
				local var_187_36 = utf8.len(var_187_34)
				local var_187_37 = var_187_35 <= 0 and var_187_31 or var_187_31 * (var_187_36 / var_187_35)

				if var_187_37 > 0 and var_187_31 < var_187_37 then
					arg_184_1.talkMaxDuration = var_187_37

					if var_187_37 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_37 + var_187_30
					end
				end

				arg_184_1.text_.text = var_187_34
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121044", "story_v_out_105121.awb") ~= 0 then
					local var_187_38 = manager.audio:GetVoiceLength("story_v_out_105121", "105121044", "story_v_out_105121.awb") / 1000

					if var_187_38 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_38 + var_187_30
					end

					if var_187_33.prefab_name ~= "" and arg_184_1.actors_[var_187_33.prefab_name] ~= nil then
						local var_187_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_33.prefab_name].transform, "story_v_out_105121", "105121044", "story_v_out_105121.awb")

						arg_184_1:RecordAudio("105121044", var_187_39)
						arg_184_1:RecordAudio("105121044", var_187_39)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_105121", "105121044", "story_v_out_105121.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_105121", "105121044", "story_v_out_105121.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_40 = math.max(var_187_31, arg_184_1.talkMaxDuration)

			if var_187_30 <= arg_184_1.time_ and arg_184_1.time_ < var_187_30 + var_187_40 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_30) / var_187_40

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_30 + var_187_40 and arg_184_1.time_ < var_187_30 + var_187_40 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play105121045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 105121045
		arg_188_1.duration_ = 7.9

		local var_188_0 = {
			ja = 7.9,
			ko = 4.366,
			zh = 4.166,
			en = 4.966
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play105121046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1027ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1027ui_story == nil then
				arg_188_1.var_.characterEffect1027ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.1

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1027ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1027ui_story then
				arg_188_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_191_4 = arg_188_1.actors_["1148ui_story"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1148ui_story == nil then
				arg_188_1.var_.characterEffect1148ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.1

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.characterEffect1148ui_story and not isNil(var_191_4) then
					local var_191_8 = Mathf.Lerp(0, 0.5, var_191_7)

					arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1148ui_story.fillRatio = var_191_8
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1148ui_story then
				local var_191_9 = 0.5

				arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1148ui_story.fillRatio = var_191_9
			end

			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action472")
			end

			local var_191_11 = 0

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_191_12 = 0
			local var_191_13 = 0.475

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_14 = arg_188_1:FormatText(StoryNameCfg[56].name)

				arg_188_1.leftNameTxt_.text = var_191_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_15 = arg_188_1:GetWordFromCfg(105121045)
				local var_191_16 = arg_188_1:FormatText(var_191_15.content)

				arg_188_1.text_.text = var_191_16

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_17 = 19
				local var_191_18 = utf8.len(var_191_16)
				local var_191_19 = var_191_17 <= 0 and var_191_13 or var_191_13 * (var_191_18 / var_191_17)

				if var_191_19 > 0 and var_191_13 < var_191_19 then
					arg_188_1.talkMaxDuration = var_191_19

					if var_191_19 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_12
					end
				end

				arg_188_1.text_.text = var_191_16
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121045", "story_v_out_105121.awb") ~= 0 then
					local var_191_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121045", "story_v_out_105121.awb") / 1000

					if var_191_20 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_20 + var_191_12
					end

					if var_191_15.prefab_name ~= "" and arg_188_1.actors_[var_191_15.prefab_name] ~= nil then
						local var_191_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_15.prefab_name].transform, "story_v_out_105121", "105121045", "story_v_out_105121.awb")

						arg_188_1:RecordAudio("105121045", var_191_21)
						arg_188_1:RecordAudio("105121045", var_191_21)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_105121", "105121045", "story_v_out_105121.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_105121", "105121045", "story_v_out_105121.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_22 = math.max(var_191_13, arg_188_1.talkMaxDuration)

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_22 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_12) / var_191_22

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_12 + var_191_22 and arg_188_1.time_ < var_191_12 + var_191_22 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play105121046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 105121046
		arg_192_1.duration_ = 9.27

		local var_192_0 = {
			ja = 9.266,
			ko = 8.266,
			zh = 7.666,
			en = 8.133
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play105121047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1148ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1148ui_story == nil then
				arg_192_1.var_.characterEffect1148ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.1

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1148ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1148ui_story then
				arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["1027ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1027ui_story == nil then
				arg_192_1.var_.characterEffect1027ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.1

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect1027ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1027ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1027ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1027ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action426")
			end

			local var_195_11 = 0
			local var_195_12 = 0.875

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_13 = arg_192_1:FormatText(StoryNameCfg[8].name)

				arg_192_1.leftNameTxt_.text = var_195_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_14 = arg_192_1:GetWordFromCfg(105121046)
				local var_195_15 = arg_192_1:FormatText(var_195_14.content)

				arg_192_1.text_.text = var_195_15

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_16 = 35
				local var_195_17 = utf8.len(var_195_15)
				local var_195_18 = var_195_16 <= 0 and var_195_12 or var_195_12 * (var_195_17 / var_195_16)

				if var_195_18 > 0 and var_195_12 < var_195_18 then
					arg_192_1.talkMaxDuration = var_195_18

					if var_195_18 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_11
					end
				end

				arg_192_1.text_.text = var_195_15
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121046", "story_v_out_105121.awb") ~= 0 then
					local var_195_19 = manager.audio:GetVoiceLength("story_v_out_105121", "105121046", "story_v_out_105121.awb") / 1000

					if var_195_19 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_11
					end

					if var_195_14.prefab_name ~= "" and arg_192_1.actors_[var_195_14.prefab_name] ~= nil then
						local var_195_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_14.prefab_name].transform, "story_v_out_105121", "105121046", "story_v_out_105121.awb")

						arg_192_1:RecordAudio("105121046", var_195_20)
						arg_192_1:RecordAudio("105121046", var_195_20)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_105121", "105121046", "story_v_out_105121.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_105121", "105121046", "story_v_out_105121.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_21 = math.max(var_195_12, arg_192_1.talkMaxDuration)

			if var_195_11 <= arg_192_1.time_ and arg_192_1.time_ < var_195_11 + var_195_21 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_11) / var_195_21

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_11 + var_195_21 and arg_192_1.time_ < var_195_11 + var_195_21 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play105121047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 105121047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play105121048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1148ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.1

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1148ui_story and not isNil(var_199_0) then
					local var_199_4 = Mathf.Lerp(0, 0.5, var_199_3)

					arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1148ui_story.fillRatio = var_199_4
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1148ui_story then
				local var_199_5 = 0.5

				arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1148ui_story.fillRatio = var_199_5
			end

			local var_199_6 = 0

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_199_7 = 0
			local var_199_8 = 0.05

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_9 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_10 = arg_196_1:GetWordFromCfg(105121047)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_12 = 2
				local var_199_13 = utf8.len(var_199_11)
				local var_199_14 = var_199_12 <= 0 and var_199_8 or var_199_8 * (var_199_13 / var_199_12)

				if var_199_14 > 0 and var_199_8 < var_199_14 then
					arg_196_1.talkMaxDuration = var_199_14

					if var_199_14 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_15 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_15 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_15

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_15 and arg_196_1.time_ < var_199_7 + var_199_15 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play105121048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 105121048
		arg_200_1.duration_ = 6.87

		local var_200_0 = {
			ja = 6.866,
			ko = 4.566,
			zh = 5.033,
			en = 6.066
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play105121049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1019ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.1

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1019ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1019ui_story then
				arg_200_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["1148ui_story"].transform
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.var_.moveOldPos1148ui_story = var_203_4.localPosition
			end

			local var_203_6 = 0.001

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6
				local var_203_8 = Vector3.New(0, 100, 0)

				var_203_4.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1148ui_story, var_203_8, var_203_7)

				local var_203_9 = manager.ui.mainCamera.transform.position - var_203_4.position

				var_203_4.forward = Vector3.New(var_203_9.x, var_203_9.y, var_203_9.z)

				local var_203_10 = var_203_4.localEulerAngles

				var_203_10.z = 0
				var_203_10.x = 0
				var_203_4.localEulerAngles = var_203_10
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 then
				var_203_4.localPosition = Vector3.New(0, 100, 0)

				local var_203_11 = manager.ui.mainCamera.transform.position - var_203_4.position

				var_203_4.forward = Vector3.New(var_203_11.x, var_203_11.y, var_203_11.z)

				local var_203_12 = var_203_4.localEulerAngles

				var_203_12.z = 0
				var_203_12.x = 0
				var_203_4.localEulerAngles = var_203_12
			end

			local var_203_13 = arg_200_1.actors_["1027ui_story"].transform
			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.var_.moveOldPos1027ui_story = var_203_13.localPosition
			end

			local var_203_15 = 0.001

			if var_203_14 <= arg_200_1.time_ and arg_200_1.time_ < var_203_14 + var_203_15 then
				local var_203_16 = (arg_200_1.time_ - var_203_14) / var_203_15
				local var_203_17 = Vector3.New(0, 100, 0)

				var_203_13.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1027ui_story, var_203_17, var_203_16)

				local var_203_18 = manager.ui.mainCamera.transform.position - var_203_13.position

				var_203_13.forward = Vector3.New(var_203_18.x, var_203_18.y, var_203_18.z)

				local var_203_19 = var_203_13.localEulerAngles

				var_203_19.z = 0
				var_203_19.x = 0
				var_203_13.localEulerAngles = var_203_19
			end

			if arg_200_1.time_ >= var_203_14 + var_203_15 and arg_200_1.time_ < var_203_14 + var_203_15 + arg_203_0 then
				var_203_13.localPosition = Vector3.New(0, 100, 0)

				local var_203_20 = manager.ui.mainCamera.transform.position - var_203_13.position

				var_203_13.forward = Vector3.New(var_203_20.x, var_203_20.y, var_203_20.z)

				local var_203_21 = var_203_13.localEulerAngles

				var_203_21.z = 0
				var_203_21.x = 0
				var_203_13.localEulerAngles = var_203_21
			end

			local var_203_22 = arg_200_1.actors_["1019ui_story"].transform
			local var_203_23 = 0

			if var_203_23 < arg_200_1.time_ and arg_200_1.time_ <= var_203_23 + arg_203_0 then
				arg_200_1.var_.moveOldPos1019ui_story = var_203_22.localPosition
			end

			local var_203_24 = 0.001

			if var_203_23 <= arg_200_1.time_ and arg_200_1.time_ < var_203_23 + var_203_24 then
				local var_203_25 = (arg_200_1.time_ - var_203_23) / var_203_24
				local var_203_26 = Vector3.New(-0.2, -1.08, -5.9)

				var_203_22.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1019ui_story, var_203_26, var_203_25)

				local var_203_27 = manager.ui.mainCamera.transform.position - var_203_22.position

				var_203_22.forward = Vector3.New(var_203_27.x, var_203_27.y, var_203_27.z)

				local var_203_28 = var_203_22.localEulerAngles

				var_203_28.z = 0
				var_203_28.x = 0
				var_203_22.localEulerAngles = var_203_28
			end

			if arg_200_1.time_ >= var_203_23 + var_203_24 and arg_200_1.time_ < var_203_23 + var_203_24 + arg_203_0 then
				var_203_22.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_203_29 = manager.ui.mainCamera.transform.position - var_203_22.position

				var_203_22.forward = Vector3.New(var_203_29.x, var_203_29.y, var_203_29.z)

				local var_203_30 = var_203_22.localEulerAngles

				var_203_30.z = 0
				var_203_30.x = 0
				var_203_22.localEulerAngles = var_203_30
			end

			local var_203_31 = 0

			if var_203_31 < arg_200_1.time_ and arg_200_1.time_ <= var_203_31 + arg_203_0 then
				arg_200_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_203_32 = 0
			local var_203_33 = 0.6

			if var_203_32 < arg_200_1.time_ and arg_200_1.time_ <= var_203_32 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_34 = arg_200_1:FormatText(StoryNameCfg[13].name)

				arg_200_1.leftNameTxt_.text = var_203_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_35 = arg_200_1:GetWordFromCfg(105121048)
				local var_203_36 = arg_200_1:FormatText(var_203_35.content)

				arg_200_1.text_.text = var_203_36

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_37 = 24
				local var_203_38 = utf8.len(var_203_36)
				local var_203_39 = var_203_37 <= 0 and var_203_33 or var_203_33 * (var_203_38 / var_203_37)

				if var_203_39 > 0 and var_203_33 < var_203_39 then
					arg_200_1.talkMaxDuration = var_203_39

					if var_203_39 + var_203_32 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_39 + var_203_32
					end
				end

				arg_200_1.text_.text = var_203_36
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121048", "story_v_out_105121.awb") ~= 0 then
					local var_203_40 = manager.audio:GetVoiceLength("story_v_out_105121", "105121048", "story_v_out_105121.awb") / 1000

					if var_203_40 + var_203_32 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_40 + var_203_32
					end

					if var_203_35.prefab_name ~= "" and arg_200_1.actors_[var_203_35.prefab_name] ~= nil then
						local var_203_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_35.prefab_name].transform, "story_v_out_105121", "105121048", "story_v_out_105121.awb")

						arg_200_1:RecordAudio("105121048", var_203_41)
						arg_200_1:RecordAudio("105121048", var_203_41)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_105121", "105121048", "story_v_out_105121.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_105121", "105121048", "story_v_out_105121.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_42 = math.max(var_203_33, arg_200_1.talkMaxDuration)

			if var_203_32 <= arg_200_1.time_ and arg_200_1.time_ < var_203_32 + var_203_42 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_32) / var_203_42

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_32 + var_203_42 and arg_200_1.time_ < var_203_32 + var_203_42 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_200_1:InitPlayNodeList()
	end,
	Play105121049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 105121049
		arg_204_1.duration_ = 3.27

		local var_204_0 = {
			ja = 3.266,
			ko = 2,
			zh = 2.066,
			en = 2.3
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play105121050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1019ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.1

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1019ui_story and not isNil(var_207_0) then
					local var_207_4 = Mathf.Lerp(0, 0.5, var_207_3)

					arg_204_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1019ui_story.fillRatio = var_207_4
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story then
				local var_207_5 = 0.5

				arg_204_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1019ui_story.fillRatio = var_207_5
			end

			local var_207_6 = arg_204_1.actors_["1019ui_story"].transform
			local var_207_7 = 0

			if var_207_7 < arg_204_1.time_ and arg_204_1.time_ <= var_207_7 + arg_207_0 then
				arg_204_1.var_.moveOldPos1019ui_story = var_207_6.localPosition
			end

			local var_207_8 = 0.001

			if var_207_7 <= arg_204_1.time_ and arg_204_1.time_ < var_207_7 + var_207_8 then
				local var_207_9 = (arg_204_1.time_ - var_207_7) / var_207_8
				local var_207_10 = Vector3.New(0, 100, 0)

				var_207_6.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1019ui_story, var_207_10, var_207_9)

				local var_207_11 = manager.ui.mainCamera.transform.position - var_207_6.position

				var_207_6.forward = Vector3.New(var_207_11.x, var_207_11.y, var_207_11.z)

				local var_207_12 = var_207_6.localEulerAngles

				var_207_12.z = 0
				var_207_12.x = 0
				var_207_6.localEulerAngles = var_207_12
			end

			if arg_204_1.time_ >= var_207_7 + var_207_8 and arg_204_1.time_ < var_207_7 + var_207_8 + arg_207_0 then
				var_207_6.localPosition = Vector3.New(0, 100, 0)

				local var_207_13 = manager.ui.mainCamera.transform.position - var_207_6.position

				var_207_6.forward = Vector3.New(var_207_13.x, var_207_13.y, var_207_13.z)

				local var_207_14 = var_207_6.localEulerAngles

				var_207_14.z = 0
				var_207_14.x = 0
				var_207_6.localEulerAngles = var_207_14
			end

			local var_207_15 = 0
			local var_207_16 = 0.175

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[35].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_18 = arg_204_1:GetWordFromCfg(105121049)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 7
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121049", "story_v_out_105121.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_out_105121", "105121049", "story_v_out_105121.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_105121", "105121049", "story_v_out_105121.awb")

						arg_204_1:RecordAudio("105121049", var_207_24)
						arg_204_1:RecordAudio("105121049", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_105121", "105121049", "story_v_out_105121.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_105121", "105121049", "story_v_out_105121.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play105121050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 105121050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play105121051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.425

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(105121050)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 56
				local var_211_5 = utf8.len(var_211_3)
				local var_211_6 = var_211_4 <= 0 and var_211_1 or var_211_1 * (var_211_5 / var_211_4)

				if var_211_6 > 0 and var_211_1 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_7 and arg_208_1.time_ < var_211_0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play105121051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 105121051
		arg_212_1.duration_ = 5.43

		local var_212_0 = {
			ja = 5.433,
			ko = 4,
			zh = 4.1,
			en = 4.066
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play105121052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = "1013ui_story"

			if arg_212_1.actors_[var_215_0] == nil then
				local var_215_1 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_215_1) then
					local var_215_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_212_1.stage_.transform)

					var_215_2.name = var_215_0
					var_215_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_212_1.actors_[var_215_0] = var_215_2

					local var_215_3 = var_215_2:GetComponentInChildren(typeof(CharacterEffect))

					var_215_3.enabled = true

					local var_215_4 = GameObjectTools.GetOrAddComponent(var_215_2, typeof(DynamicBoneHelper))

					if var_215_4 then
						var_215_4:EnableDynamicBone(false)
					end

					arg_212_1:ShowWeapon(var_215_3.transform, false)

					arg_212_1.var_[var_215_0 .. "Animator"] = var_215_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_212_1.var_[var_215_0 .. "Animator"].applyRootMotion = true
					arg_212_1.var_[var_215_0 .. "LipSync"] = var_215_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_215_5 = arg_212_1.actors_["1013ui_story"]
			local var_215_6 = 0

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect1013ui_story == nil then
				arg_212_1.var_.characterEffect1013ui_story = var_215_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_7 = 0.1

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_7 and not isNil(var_215_5) then
				local var_215_8 = (arg_212_1.time_ - var_215_6) / var_215_7

				if arg_212_1.var_.characterEffect1013ui_story and not isNil(var_215_5) then
					arg_212_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_6 + var_215_7 and arg_212_1.time_ < var_215_6 + var_215_7 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect1013ui_story then
				arg_212_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_215_9 = arg_212_1.actors_["1013ui_story"].transform
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1.var_.moveOldPos1013ui_story = var_215_9.localPosition
			end

			local var_215_11 = 0.001

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11
				local var_215_13 = Vector3.New(-0.7, -0.66, -6.15)

				var_215_9.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1013ui_story, var_215_13, var_215_12)

				local var_215_14 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_14.x, var_215_14.y, var_215_14.z)

				local var_215_15 = var_215_9.localEulerAngles

				var_215_15.z = 0
				var_215_15.x = 0
				var_215_9.localEulerAngles = var_215_15
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 then
				var_215_9.localPosition = Vector3.New(-0.7, -0.66, -6.15)

				local var_215_16 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_16.x, var_215_16.y, var_215_16.z)

				local var_215_17 = var_215_9.localEulerAngles

				var_215_17.z = 0
				var_215_17.x = 0
				var_215_9.localEulerAngles = var_215_17
			end

			local var_215_18 = 0

			if var_215_18 < arg_212_1.time_ and arg_212_1.time_ <= var_215_18 + arg_215_0 then
				arg_212_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_215_19 = 0

			if var_215_19 < arg_212_1.time_ and arg_212_1.time_ <= var_215_19 + arg_215_0 then
				arg_212_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_215_20 = 0
			local var_215_21 = 0.525

			if var_215_20 < arg_212_1.time_ and arg_212_1.time_ <= var_215_20 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_22 = arg_212_1:FormatText(StoryNameCfg[35].name)

				arg_212_1.leftNameTxt_.text = var_215_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_23 = arg_212_1:GetWordFromCfg(105121051)
				local var_215_24 = arg_212_1:FormatText(var_215_23.content)

				arg_212_1.text_.text = var_215_24

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_25 = 21
				local var_215_26 = utf8.len(var_215_24)
				local var_215_27 = var_215_25 <= 0 and var_215_21 or var_215_21 * (var_215_26 / var_215_25)

				if var_215_27 > 0 and var_215_21 < var_215_27 then
					arg_212_1.talkMaxDuration = var_215_27

					if var_215_27 + var_215_20 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_27 + var_215_20
					end
				end

				arg_212_1.text_.text = var_215_24
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121051", "story_v_out_105121.awb") ~= 0 then
					local var_215_28 = manager.audio:GetVoiceLength("story_v_out_105121", "105121051", "story_v_out_105121.awb") / 1000

					if var_215_28 + var_215_20 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_28 + var_215_20
					end

					if var_215_23.prefab_name ~= "" and arg_212_1.actors_[var_215_23.prefab_name] ~= nil then
						local var_215_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_23.prefab_name].transform, "story_v_out_105121", "105121051", "story_v_out_105121.awb")

						arg_212_1:RecordAudio("105121051", var_215_29)
						arg_212_1:RecordAudio("105121051", var_215_29)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_105121", "105121051", "story_v_out_105121.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_105121", "105121051", "story_v_out_105121.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_30 = math.max(var_215_21, arg_212_1.talkMaxDuration)

			if var_215_20 <= arg_212_1.time_ and arg_212_1.time_ < var_215_20 + var_215_30 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_20) / var_215_30

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_20 + var_215_30 and arg_212_1.time_ < var_215_20 + var_215_30 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play105121052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 105121052
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play105121053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1084ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1084ui_story == nil then
				arg_216_1.var_.characterEffect1084ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.1

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1084ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1084ui_story then
				arg_216_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_219_4 = arg_216_1.actors_["1013ui_story"]
			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1013ui_story == nil then
				arg_216_1.var_.characterEffect1013ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.1

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_6 and not isNil(var_219_4) then
				local var_219_7 = (arg_216_1.time_ - var_219_5) / var_219_6

				if arg_216_1.var_.characterEffect1013ui_story and not isNil(var_219_4) then
					local var_219_8 = Mathf.Lerp(0, 0.5, var_219_7)

					arg_216_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1013ui_story.fillRatio = var_219_8
				end
			end

			if arg_216_1.time_ >= var_219_5 + var_219_6 and arg_216_1.time_ < var_219_5 + var_219_6 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1013ui_story then
				local var_219_9 = 0.5

				arg_216_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1013ui_story.fillRatio = var_219_9
			end

			local var_219_10 = arg_216_1.actors_["1084ui_story"].transform
			local var_219_11 = 0

			if var_219_11 < arg_216_1.time_ and arg_216_1.time_ <= var_219_11 + arg_219_0 then
				arg_216_1.var_.moveOldPos1084ui_story = var_219_10.localPosition
			end

			local var_219_12 = 0.001

			if var_219_11 <= arg_216_1.time_ and arg_216_1.time_ < var_219_11 + var_219_12 then
				local var_219_13 = (arg_216_1.time_ - var_219_11) / var_219_12
				local var_219_14 = Vector3.New(0.7, -0.97, -6)

				var_219_10.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1084ui_story, var_219_14, var_219_13)

				local var_219_15 = manager.ui.mainCamera.transform.position - var_219_10.position

				var_219_10.forward = Vector3.New(var_219_15.x, var_219_15.y, var_219_15.z)

				local var_219_16 = var_219_10.localEulerAngles

				var_219_16.z = 0
				var_219_16.x = 0
				var_219_10.localEulerAngles = var_219_16
			end

			if arg_216_1.time_ >= var_219_11 + var_219_12 and arg_216_1.time_ < var_219_11 + var_219_12 + arg_219_0 then
				var_219_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_219_17 = manager.ui.mainCamera.transform.position - var_219_10.position

				var_219_10.forward = Vector3.New(var_219_17.x, var_219_17.y, var_219_17.z)

				local var_219_18 = var_219_10.localEulerAngles

				var_219_18.z = 0
				var_219_18.x = 0
				var_219_10.localEulerAngles = var_219_18
			end

			local var_219_19 = 0

			if var_219_19 < arg_216_1.time_ and arg_216_1.time_ <= var_219_19 + arg_219_0 then
				arg_216_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_219_20 = 0

			if var_219_20 < arg_216_1.time_ and arg_216_1.time_ <= var_219_20 + arg_219_0 then
				arg_216_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_219_21 = 0
			local var_219_22 = 0.125

			if var_219_21 < arg_216_1.time_ and arg_216_1.time_ <= var_219_21 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_23 = arg_216_1:FormatText(StoryNameCfg[6].name)

				arg_216_1.leftNameTxt_.text = var_219_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_24 = arg_216_1:GetWordFromCfg(105121052)
				local var_219_25 = arg_216_1:FormatText(var_219_24.content)

				arg_216_1.text_.text = var_219_25

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_26 = 5
				local var_219_27 = utf8.len(var_219_25)
				local var_219_28 = var_219_26 <= 0 and var_219_22 or var_219_22 * (var_219_27 / var_219_26)

				if var_219_28 > 0 and var_219_22 < var_219_28 then
					arg_216_1.talkMaxDuration = var_219_28

					if var_219_28 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_28 + var_219_21
					end
				end

				arg_216_1.text_.text = var_219_25
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121052", "story_v_out_105121.awb") ~= 0 then
					local var_219_29 = manager.audio:GetVoiceLength("story_v_out_105121", "105121052", "story_v_out_105121.awb") / 1000

					if var_219_29 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_29 + var_219_21
					end

					if var_219_24.prefab_name ~= "" and arg_216_1.actors_[var_219_24.prefab_name] ~= nil then
						local var_219_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_24.prefab_name].transform, "story_v_out_105121", "105121052", "story_v_out_105121.awb")

						arg_216_1:RecordAudio("105121052", var_219_30)
						arg_216_1:RecordAudio("105121052", var_219_30)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_105121", "105121052", "story_v_out_105121.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_105121", "105121052", "story_v_out_105121.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_31 = math.max(var_219_22, arg_216_1.talkMaxDuration)

			if var_219_21 <= arg_216_1.time_ and arg_216_1.time_ < var_219_21 + var_219_31 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_21) / var_219_31

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_21 + var_219_31 and arg_216_1.time_ < var_219_21 + var_219_31 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play105121053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 105121053
		arg_220_1.duration_ = 11.73

		local var_220_0 = {
			ja = 9.266,
			ko = 8.6,
			zh = 7.833,
			en = 11.733
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play105121054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = "10002ui_story"

			if arg_220_1.actors_[var_223_0] == nil then
				local var_223_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_223_1) then
					local var_223_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_220_1.stage_.transform)

					var_223_2.name = var_223_0
					var_223_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_220_1.actors_[var_223_0] = var_223_2

					local var_223_3 = var_223_2:GetComponentInChildren(typeof(CharacterEffect))

					var_223_3.enabled = true

					local var_223_4 = GameObjectTools.GetOrAddComponent(var_223_2, typeof(DynamicBoneHelper))

					if var_223_4 then
						var_223_4:EnableDynamicBone(false)
					end

					arg_220_1:ShowWeapon(var_223_3.transform, false)

					arg_220_1.var_[var_223_0 .. "Animator"] = var_223_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_220_1.var_[var_223_0 .. "Animator"].applyRootMotion = true
					arg_220_1.var_[var_223_0 .. "LipSync"] = var_223_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_223_5 = arg_220_1.actors_["10002ui_story"]
			local var_223_6 = 0

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect10002ui_story == nil then
				arg_220_1.var_.characterEffect10002ui_story = var_223_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_7 = 0.1

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_7 and not isNil(var_223_5) then
				local var_223_8 = (arg_220_1.time_ - var_223_6) / var_223_7

				if arg_220_1.var_.characterEffect10002ui_story and not isNil(var_223_5) then
					arg_220_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_6 + var_223_7 and arg_220_1.time_ < var_223_6 + var_223_7 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect10002ui_story then
				arg_220_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_223_9 = arg_220_1.actors_["1084ui_story"]
			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_11 = 0.1

			if var_223_10 <= arg_220_1.time_ and arg_220_1.time_ < var_223_10 + var_223_11 and not isNil(var_223_9) then
				local var_223_12 = (arg_220_1.time_ - var_223_10) / var_223_11

				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_9) then
					local var_223_13 = Mathf.Lerp(0, 0.5, var_223_12)

					arg_220_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1084ui_story.fillRatio = var_223_13
				end
			end

			if arg_220_1.time_ >= var_223_10 + var_223_11 and arg_220_1.time_ < var_223_10 + var_223_11 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1084ui_story then
				local var_223_14 = 0.5

				arg_220_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1084ui_story.fillRatio = var_223_14
			end

			local var_223_15 = arg_220_1.actors_["1013ui_story"].transform
			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.var_.moveOldPos1013ui_story = var_223_15.localPosition
			end

			local var_223_17 = 0.001

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_17 then
				local var_223_18 = (arg_220_1.time_ - var_223_16) / var_223_17
				local var_223_19 = Vector3.New(0, 100, 0)

				var_223_15.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1013ui_story, var_223_19, var_223_18)

				local var_223_20 = manager.ui.mainCamera.transform.position - var_223_15.position

				var_223_15.forward = Vector3.New(var_223_20.x, var_223_20.y, var_223_20.z)

				local var_223_21 = var_223_15.localEulerAngles

				var_223_21.z = 0
				var_223_21.x = 0
				var_223_15.localEulerAngles = var_223_21
			end

			if arg_220_1.time_ >= var_223_16 + var_223_17 and arg_220_1.time_ < var_223_16 + var_223_17 + arg_223_0 then
				var_223_15.localPosition = Vector3.New(0, 100, 0)

				local var_223_22 = manager.ui.mainCamera.transform.position - var_223_15.position

				var_223_15.forward = Vector3.New(var_223_22.x, var_223_22.y, var_223_22.z)

				local var_223_23 = var_223_15.localEulerAngles

				var_223_23.z = 0
				var_223_23.x = 0
				var_223_15.localEulerAngles = var_223_23
			end

			local var_223_24 = arg_220_1.actors_["10002ui_story"].transform
			local var_223_25 = 0

			if var_223_25 < arg_220_1.time_ and arg_220_1.time_ <= var_223_25 + arg_223_0 then
				arg_220_1.var_.moveOldPos10002ui_story = var_223_24.localPosition
			end

			local var_223_26 = 0.001

			if var_223_25 <= arg_220_1.time_ and arg_220_1.time_ < var_223_25 + var_223_26 then
				local var_223_27 = (arg_220_1.time_ - var_223_25) / var_223_26
				local var_223_28 = Vector3.New(-0.7, -1.2, -5.8)

				var_223_24.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10002ui_story, var_223_28, var_223_27)

				local var_223_29 = manager.ui.mainCamera.transform.position - var_223_24.position

				var_223_24.forward = Vector3.New(var_223_29.x, var_223_29.y, var_223_29.z)

				local var_223_30 = var_223_24.localEulerAngles

				var_223_30.z = 0
				var_223_30.x = 0
				var_223_24.localEulerAngles = var_223_30
			end

			if arg_220_1.time_ >= var_223_25 + var_223_26 and arg_220_1.time_ < var_223_25 + var_223_26 + arg_223_0 then
				var_223_24.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_223_31 = manager.ui.mainCamera.transform.position - var_223_24.position

				var_223_24.forward = Vector3.New(var_223_31.x, var_223_31.y, var_223_31.z)

				local var_223_32 = var_223_24.localEulerAngles

				var_223_32.z = 0
				var_223_32.x = 0
				var_223_24.localEulerAngles = var_223_32
			end

			local var_223_33 = 0

			if var_223_33 < arg_220_1.time_ and arg_220_1.time_ <= var_223_33 + arg_223_0 then
				arg_220_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_223_34 = 0

			if var_223_34 < arg_220_1.time_ and arg_220_1.time_ <= var_223_34 + arg_223_0 then
				arg_220_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_35 = 0
			local var_223_36 = 0.75

			if var_223_35 < arg_220_1.time_ and arg_220_1.time_ <= var_223_35 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_37 = arg_220_1:FormatText(StoryNameCfg[72].name)

				arg_220_1.leftNameTxt_.text = var_223_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_38 = arg_220_1:GetWordFromCfg(105121053)
				local var_223_39 = arg_220_1:FormatText(var_223_38.content)

				arg_220_1.text_.text = var_223_39

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_40 = 30
				local var_223_41 = utf8.len(var_223_39)
				local var_223_42 = var_223_40 <= 0 and var_223_36 or var_223_36 * (var_223_41 / var_223_40)

				if var_223_42 > 0 and var_223_36 < var_223_42 then
					arg_220_1.talkMaxDuration = var_223_42

					if var_223_42 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_42 + var_223_35
					end
				end

				arg_220_1.text_.text = var_223_39
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121053", "story_v_out_105121.awb") ~= 0 then
					local var_223_43 = manager.audio:GetVoiceLength("story_v_out_105121", "105121053", "story_v_out_105121.awb") / 1000

					if var_223_43 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_43 + var_223_35
					end

					if var_223_38.prefab_name ~= "" and arg_220_1.actors_[var_223_38.prefab_name] ~= nil then
						local var_223_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_38.prefab_name].transform, "story_v_out_105121", "105121053", "story_v_out_105121.awb")

						arg_220_1:RecordAudio("105121053", var_223_44)
						arg_220_1:RecordAudio("105121053", var_223_44)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_105121", "105121053", "story_v_out_105121.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_105121", "105121053", "story_v_out_105121.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_45 = math.max(var_223_36, arg_220_1.talkMaxDuration)

			if var_223_35 <= arg_220_1.time_ and arg_220_1.time_ < var_223_35 + var_223_45 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_35) / var_223_45

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_35 + var_223_45 and arg_220_1.time_ < var_223_35 + var_223_45 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play105121054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 105121054
		arg_224_1.duration_ = 2.5

		local var_224_0 = {
			ja = 2.5,
			ko = 2.5,
			zh = 2.066,
			en = 2.033
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play105121055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1084ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.1

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_227_4 = arg_224_1.actors_["10002ui_story"]
			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect10002ui_story == nil then
				arg_224_1.var_.characterEffect10002ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.1

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_6 and not isNil(var_227_4) then
				local var_227_7 = (arg_224_1.time_ - var_227_5) / var_227_6

				if arg_224_1.var_.characterEffect10002ui_story and not isNil(var_227_4) then
					local var_227_8 = Mathf.Lerp(0, 0.5, var_227_7)

					arg_224_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10002ui_story.fillRatio = var_227_8
				end
			end

			if arg_224_1.time_ >= var_227_5 + var_227_6 and arg_224_1.time_ < var_227_5 + var_227_6 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect10002ui_story then
				local var_227_9 = 0.5

				arg_224_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10002ui_story.fillRatio = var_227_9
			end

			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			local var_227_11 = 0

			if var_227_11 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_227_12 = 0
			local var_227_13 = 0.225

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[6].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(105121054)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 9
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121054", "story_v_out_105121.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121054", "story_v_out_105121.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_105121", "105121054", "story_v_out_105121.awb")

						arg_224_1:RecordAudio("105121054", var_227_21)
						arg_224_1:RecordAudio("105121054", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_105121", "105121054", "story_v_out_105121.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_105121", "105121054", "story_v_out_105121.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play105121055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 105121055
		arg_228_1.duration_ = 7.5

		local var_228_0 = {
			ja = 6.033,
			ko = 5.3,
			zh = 5.2,
			en = 7.5
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play105121056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10002ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10002ui_story == nil then
				arg_228_1.var_.characterEffect10002ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.1

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect10002ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10002ui_story then
				arg_228_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["1084ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1084ui_story == nil then
				arg_228_1.var_.characterEffect1084ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.1

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect1084ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1084ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1084ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1084ui_story.fillRatio = var_231_9
			end

			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_231_11 = 0

			if var_231_11 < arg_228_1.time_ and arg_228_1.time_ <= var_231_11 + arg_231_0 then
				arg_228_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_231_12 = 0
			local var_231_13 = 0.45

			if var_231_12 < arg_228_1.time_ and arg_228_1.time_ <= var_231_12 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_14 = arg_228_1:FormatText(StoryNameCfg[72].name)

				arg_228_1.leftNameTxt_.text = var_231_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_15 = arg_228_1:GetWordFromCfg(105121055)
				local var_231_16 = arg_228_1:FormatText(var_231_15.content)

				arg_228_1.text_.text = var_231_16

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_17 = 18
				local var_231_18 = utf8.len(var_231_16)
				local var_231_19 = var_231_17 <= 0 and var_231_13 or var_231_13 * (var_231_18 / var_231_17)

				if var_231_19 > 0 and var_231_13 < var_231_19 then
					arg_228_1.talkMaxDuration = var_231_19

					if var_231_19 + var_231_12 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_19 + var_231_12
					end
				end

				arg_228_1.text_.text = var_231_16
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121055", "story_v_out_105121.awb") ~= 0 then
					local var_231_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121055", "story_v_out_105121.awb") / 1000

					if var_231_20 + var_231_12 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_20 + var_231_12
					end

					if var_231_15.prefab_name ~= "" and arg_228_1.actors_[var_231_15.prefab_name] ~= nil then
						local var_231_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_15.prefab_name].transform, "story_v_out_105121", "105121055", "story_v_out_105121.awb")

						arg_228_1:RecordAudio("105121055", var_231_21)
						arg_228_1:RecordAudio("105121055", var_231_21)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_105121", "105121055", "story_v_out_105121.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_105121", "105121055", "story_v_out_105121.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_22 = math.max(var_231_13, arg_228_1.talkMaxDuration)

			if var_231_12 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_22 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_12) / var_231_22

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_12 + var_231_22 and arg_228_1.time_ < var_231_12 + var_231_22 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play105121056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 105121056
		arg_232_1.duration_ = 4.1

		local var_232_0 = {
			ja = 4.1,
			ko = 2.5,
			zh = 2.2,
			en = 1.999999999999
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play105121057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_235_2 = 0
			local var_235_3 = 0.15

			if var_235_2 < arg_232_1.time_ and arg_232_1.time_ <= var_235_2 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_4 = arg_232_1:FormatText(StoryNameCfg[72].name)

				arg_232_1.leftNameTxt_.text = var_235_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_5 = arg_232_1:GetWordFromCfg(105121056)
				local var_235_6 = arg_232_1:FormatText(var_235_5.content)

				arg_232_1.text_.text = var_235_6

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_7 = 6
				local var_235_8 = utf8.len(var_235_6)
				local var_235_9 = var_235_7 <= 0 and var_235_3 or var_235_3 * (var_235_8 / var_235_7)

				if var_235_9 > 0 and var_235_3 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_2 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_2
					end
				end

				arg_232_1.text_.text = var_235_6
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121056", "story_v_out_105121.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121056", "story_v_out_105121.awb") / 1000

					if var_235_10 + var_235_2 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_2
					end

					if var_235_5.prefab_name ~= "" and arg_232_1.actors_[var_235_5.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_5.prefab_name].transform, "story_v_out_105121", "105121056", "story_v_out_105121.awb")

						arg_232_1:RecordAudio("105121056", var_235_11)
						arg_232_1:RecordAudio("105121056", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_105121", "105121056", "story_v_out_105121.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_105121", "105121056", "story_v_out_105121.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_3, arg_232_1.talkMaxDuration)

			if var_235_2 <= arg_232_1.time_ and arg_232_1.time_ < var_235_2 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_2) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_2 + var_235_12 and arg_232_1.time_ < var_235_2 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play105121057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 105121057
		arg_236_1.duration_ = 7.5

		local var_236_0 = {
			ja = 7.5,
			ko = 3.7,
			zh = 3.766,
			en = 4.833
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play105121058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10001_tpose"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10001_tpose == nil then
				arg_236_1.var_.characterEffect10001_tpose = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.1

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect10001_tpose and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10001_tpose then
				arg_236_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_239_4 = arg_236_1.actors_["10002ui_story"]
			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect10002ui_story == nil then
				arg_236_1.var_.characterEffect10002ui_story = var_239_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_6 = 0.1

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_6 and not isNil(var_239_4) then
				local var_239_7 = (arg_236_1.time_ - var_239_5) / var_239_6

				if arg_236_1.var_.characterEffect10002ui_story and not isNil(var_239_4) then
					local var_239_8 = Mathf.Lerp(0, 0.5, var_239_7)

					arg_236_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10002ui_story.fillRatio = var_239_8
				end
			end

			if arg_236_1.time_ >= var_239_5 + var_239_6 and arg_236_1.time_ < var_239_5 + var_239_6 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect10002ui_story then
				local var_239_9 = 0.5

				arg_236_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10002ui_story.fillRatio = var_239_9
			end

			local var_239_10 = arg_236_1.actors_["1084ui_story"].transform
			local var_239_11 = 0

			if var_239_11 < arg_236_1.time_ and arg_236_1.time_ <= var_239_11 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = var_239_10.localPosition
			end

			local var_239_12 = 0.001

			if var_239_11 <= arg_236_1.time_ and arg_236_1.time_ < var_239_11 + var_239_12 then
				local var_239_13 = (arg_236_1.time_ - var_239_11) / var_239_12
				local var_239_14 = Vector3.New(0, 100, 0)

				var_239_10.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, var_239_14, var_239_13)

				local var_239_15 = manager.ui.mainCamera.transform.position - var_239_10.position

				var_239_10.forward = Vector3.New(var_239_15.x, var_239_15.y, var_239_15.z)

				local var_239_16 = var_239_10.localEulerAngles

				var_239_16.z = 0
				var_239_16.x = 0
				var_239_10.localEulerAngles = var_239_16
			end

			if arg_236_1.time_ >= var_239_11 + var_239_12 and arg_236_1.time_ < var_239_11 + var_239_12 + arg_239_0 then
				var_239_10.localPosition = Vector3.New(0, 100, 0)

				local var_239_17 = manager.ui.mainCamera.transform.position - var_239_10.position

				var_239_10.forward = Vector3.New(var_239_17.x, var_239_17.y, var_239_17.z)

				local var_239_18 = var_239_10.localEulerAngles

				var_239_18.z = 0
				var_239_18.x = 0
				var_239_10.localEulerAngles = var_239_18
			end

			local var_239_19 = arg_236_1.actors_["10002ui_story"].transform
			local var_239_20 = 0

			if var_239_20 < arg_236_1.time_ and arg_236_1.time_ <= var_239_20 + arg_239_0 then
				arg_236_1.var_.moveOldPos10002ui_story = var_239_19.localPosition
			end

			local var_239_21 = 0.001

			if var_239_20 <= arg_236_1.time_ and arg_236_1.time_ < var_239_20 + var_239_21 then
				local var_239_22 = (arg_236_1.time_ - var_239_20) / var_239_21
				local var_239_23 = Vector3.New(0, 100, 0)

				var_239_19.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10002ui_story, var_239_23, var_239_22)

				local var_239_24 = manager.ui.mainCamera.transform.position - var_239_19.position

				var_239_19.forward = Vector3.New(var_239_24.x, var_239_24.y, var_239_24.z)

				local var_239_25 = var_239_19.localEulerAngles

				var_239_25.z = 0
				var_239_25.x = 0
				var_239_19.localEulerAngles = var_239_25
			end

			if arg_236_1.time_ >= var_239_20 + var_239_21 and arg_236_1.time_ < var_239_20 + var_239_21 + arg_239_0 then
				var_239_19.localPosition = Vector3.New(0, 100, 0)

				local var_239_26 = manager.ui.mainCamera.transform.position - var_239_19.position

				var_239_19.forward = Vector3.New(var_239_26.x, var_239_26.y, var_239_26.z)

				local var_239_27 = var_239_19.localEulerAngles

				var_239_27.z = 0
				var_239_27.x = 0
				var_239_19.localEulerAngles = var_239_27
			end

			local var_239_28 = 0

			if var_239_28 < arg_236_1.time_ and arg_236_1.time_ <= var_239_28 + arg_239_0 then
				arg_236_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			local var_239_29 = arg_236_1.actors_["10001_tpose"].transform
			local var_239_30 = 0

			if var_239_30 < arg_236_1.time_ and arg_236_1.time_ <= var_239_30 + arg_239_0 then
				arg_236_1.var_.moveOldPos10001_tpose = var_239_29.localPosition

				local var_239_31 = GameObjectTools.GetOrAddComponent(var_239_29.gameObject, typeof(DynamicBoneHelper))

				if var_239_31 then
					var_239_31:EnableDynamicBone(false)
				end
			end

			local var_239_32 = 0.001

			if var_239_30 <= arg_236_1.time_ and arg_236_1.time_ < var_239_30 + var_239_32 then
				local var_239_33 = (arg_236_1.time_ - var_239_30) / var_239_32
				local var_239_34 = Vector3.New(0, -1.23, -5.8)

				var_239_29.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10001_tpose, var_239_34, var_239_33)

				local var_239_35 = manager.ui.mainCamera.transform.position - var_239_29.position

				var_239_29.forward = Vector3.New(var_239_35.x, var_239_35.y, var_239_35.z)

				local var_239_36 = var_239_29.localEulerAngles

				var_239_36.z = 0
				var_239_36.x = 0
				var_239_29.localEulerAngles = var_239_36
			end

			if arg_236_1.time_ >= var_239_30 + var_239_32 and arg_236_1.time_ < var_239_30 + var_239_32 + arg_239_0 then
				var_239_29.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_239_37 = manager.ui.mainCamera.transform.position - var_239_29.position

				var_239_29.forward = Vector3.New(var_239_37.x, var_239_37.y, var_239_37.z)

				local var_239_38 = var_239_29.localEulerAngles

				var_239_38.z = 0
				var_239_38.x = 0
				var_239_29.localEulerAngles = var_239_38

				local var_239_39 = GameObjectTools.GetOrAddComponent(var_239_29.gameObject, typeof(DynamicBoneHelper))

				if var_239_39 then
					var_239_39:EnableDynamicBone(true)
				end
			end

			local var_239_40 = 0

			if var_239_40 < arg_236_1.time_ and arg_236_1.time_ <= var_239_40 + arg_239_0 then
				arg_236_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_239_41 = 0
			local var_239_42 = 0.225

			if var_239_41 < arg_236_1.time_ and arg_236_1.time_ <= var_239_41 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_43 = arg_236_1:FormatText(StoryNameCfg[31].name)

				arg_236_1.leftNameTxt_.text = var_239_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_44 = arg_236_1:GetWordFromCfg(105121057)
				local var_239_45 = arg_236_1:FormatText(var_239_44.content)

				arg_236_1.text_.text = var_239_45

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_46 = 9
				local var_239_47 = utf8.len(var_239_45)
				local var_239_48 = var_239_46 <= 0 and var_239_42 or var_239_42 * (var_239_47 / var_239_46)

				if var_239_48 > 0 and var_239_42 < var_239_48 then
					arg_236_1.talkMaxDuration = var_239_48

					if var_239_48 + var_239_41 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_48 + var_239_41
					end
				end

				arg_236_1.text_.text = var_239_45
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121057", "story_v_out_105121.awb") ~= 0 then
					local var_239_49 = manager.audio:GetVoiceLength("story_v_out_105121", "105121057", "story_v_out_105121.awb") / 1000

					if var_239_49 + var_239_41 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_49 + var_239_41
					end

					if var_239_44.prefab_name ~= "" and arg_236_1.actors_[var_239_44.prefab_name] ~= nil then
						local var_239_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_44.prefab_name].transform, "story_v_out_105121", "105121057", "story_v_out_105121.awb")

						arg_236_1:RecordAudio("105121057", var_239_50)
						arg_236_1:RecordAudio("105121057", var_239_50)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_105121", "105121057", "story_v_out_105121.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_105121", "105121057", "story_v_out_105121.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_51 = math.max(var_239_42, arg_236_1.talkMaxDuration)

			if var_239_41 <= arg_236_1.time_ and arg_236_1.time_ < var_239_41 + var_239_51 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_41) / var_239_51

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_41 + var_239_51 and arg_236_1.time_ < var_239_41 + var_239_51 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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
				actorName = "10002ui_story",
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

		arg_236_1:InitPlayNodeList()
	end,
	Play105121058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 105121058
		arg_240_1.duration_ = 1.33

		local var_240_0 = {
			ja = 0.766,
			ko = 1.266,
			zh = 1,
			en = 1.333
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
				arg_240_0:Play105121059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1084ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1084ui_story == nil then
				arg_240_1.var_.characterEffect1084ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.1

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1084ui_story and not isNil(var_243_0) then
					arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1084ui_story then
				arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_243_4 = arg_240_1.actors_["10001_tpose"]
			local var_243_5 = 0

			if var_243_5 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect10001_tpose == nil then
				arg_240_1.var_.characterEffect10001_tpose = var_243_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_6 = 0.1

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_6 and not isNil(var_243_4) then
				local var_243_7 = (arg_240_1.time_ - var_243_5) / var_243_6

				if arg_240_1.var_.characterEffect10001_tpose and not isNil(var_243_4) then
					local var_243_8 = Mathf.Lerp(0, 0.5, var_243_7)

					arg_240_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_240_1.var_.characterEffect10001_tpose.fillRatio = var_243_8
				end
			end

			if arg_240_1.time_ >= var_243_5 + var_243_6 and arg_240_1.time_ < var_243_5 + var_243_6 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect10001_tpose then
				local var_243_9 = 0.5

				arg_240_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_240_1.var_.characterEffect10001_tpose.fillRatio = var_243_9
			end

			local var_243_10 = 0
			local var_243_11 = 0.05

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_12 = arg_240_1:FormatText(StoryNameCfg[6].name)

				arg_240_1.leftNameTxt_.text = var_243_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_13 = arg_240_1:GetWordFromCfg(105121058)
				local var_243_14 = arg_240_1:FormatText(var_243_13.content)

				arg_240_1.text_.text = var_243_14

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_15 = 2
				local var_243_16 = utf8.len(var_243_14)
				local var_243_17 = var_243_15 <= 0 and var_243_11 or var_243_11 * (var_243_16 / var_243_15)

				if var_243_17 > 0 and var_243_11 < var_243_17 then
					arg_240_1.talkMaxDuration = var_243_17

					if var_243_17 + var_243_10 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_17 + var_243_10
					end
				end

				arg_240_1.text_.text = var_243_14
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121058", "story_v_out_105121.awb") ~= 0 then
					local var_243_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121058", "story_v_out_105121.awb") / 1000

					if var_243_18 + var_243_10 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_18 + var_243_10
					end

					if var_243_13.prefab_name ~= "" and arg_240_1.actors_[var_243_13.prefab_name] ~= nil then
						local var_243_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_13.prefab_name].transform, "story_v_out_105121", "105121058", "story_v_out_105121.awb")

						arg_240_1:RecordAudio("105121058", var_243_19)
						arg_240_1:RecordAudio("105121058", var_243_19)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_105121", "105121058", "story_v_out_105121.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_105121", "105121058", "story_v_out_105121.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_20 = math.max(var_243_11, arg_240_1.talkMaxDuration)

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_20 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_10) / var_243_20

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_10 + var_243_20 and arg_240_1.time_ < var_243_10 + var_243_20 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play105121059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 105121059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play105121060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1019ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1019ui_story == nil then
				arg_244_1.var_.characterEffect1019ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.1

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1019ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1019ui_story then
				arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["1084ui_story"]
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1084ui_story == nil then
				arg_244_1.var_.characterEffect1084ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.1

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_6 and not isNil(var_247_4) then
				local var_247_7 = (arg_244_1.time_ - var_247_5) / var_247_6

				if arg_244_1.var_.characterEffect1084ui_story and not isNil(var_247_4) then
					local var_247_8 = Mathf.Lerp(0, 0.5, var_247_7)

					arg_244_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1084ui_story.fillRatio = var_247_8
				end
			end

			if arg_244_1.time_ >= var_247_5 + var_247_6 and arg_244_1.time_ < var_247_5 + var_247_6 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1084ui_story then
				local var_247_9 = 0.5

				arg_244_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1084ui_story.fillRatio = var_247_9
			end

			local var_247_10 = 0
			local var_247_11 = 0.075

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_12 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_13 = arg_244_1:GetWordFromCfg(105121059)
				local var_247_14 = arg_244_1:FormatText(var_247_13.content)

				arg_244_1.text_.text = var_247_14

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_15 = 3
				local var_247_16 = utf8.len(var_247_14)
				local var_247_17 = var_247_15 <= 0 and var_247_11 or var_247_11 * (var_247_16 / var_247_15)

				if var_247_17 > 0 and var_247_11 < var_247_17 then
					arg_244_1.talkMaxDuration = var_247_17

					if var_247_17 + var_247_10 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_17 + var_247_10
					end
				end

				arg_244_1.text_.text = var_247_14
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_18 = math.max(var_247_11, arg_244_1.talkMaxDuration)

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_18 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_10) / var_247_18

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_10 + var_247_18 and arg_244_1.time_ < var_247_10 + var_247_18 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play105121060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 105121060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play105121061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.25

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(105121060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 10
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play105121061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 105121061
		arg_252_1.duration_ = 1.77

		local var_252_0 = {
			ja = 0.933,
			ko = 1.766,
			zh = 0.9,
			en = 0.933
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play105121062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_1 = 0.5

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_1 then
				local var_255_2 = (arg_252_1.time_ - var_255_0) / var_255_1
				local var_255_3 = Color.New(1, 1, 1)

				var_255_3.a = Mathf.Lerp(1, 0, var_255_2)
				arg_252_1.mask_.color = var_255_3
			end

			if arg_252_1.time_ >= var_255_0 + var_255_1 and arg_252_1.time_ < var_255_0 + var_255_1 + arg_255_0 then
				local var_255_4 = Color.New(1, 1, 1)
				local var_255_5 = 0

				arg_252_1.mask_.enabled = false
				var_255_4.a = var_255_5
				arg_252_1.mask_.color = var_255_4
			end

			local var_255_6 = manager.ui.mainCamera.transform
			local var_255_7 = 0

			if var_255_7 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 then
				arg_252_1.var_.shakeOldPosMainCamera = var_255_6.localPosition
			end

			local var_255_8 = 0.600000023841858

			if var_255_7 <= arg_252_1.time_ and arg_252_1.time_ < var_255_7 + var_255_8 then
				local var_255_9 = (arg_252_1.time_ - var_255_7) / 0.066
				local var_255_10, var_255_11 = math.modf(var_255_9)

				var_255_6.localPosition = Vector3.New(var_255_11 * 0.13, var_255_11 * 0.13, var_255_11 * 0.13) + arg_252_1.var_.shakeOldPosMainCamera
			end

			if arg_252_1.time_ >= var_255_7 + var_255_8 and arg_252_1.time_ < var_255_7 + var_255_8 + arg_255_0 then
				var_255_6.localPosition = arg_252_1.var_.shakeOldPosMainCamera
			end

			local var_255_12 = 0
			local var_255_13 = 0.075

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_14 = arg_252_1:FormatText(StoryNameCfg[5].name)

				arg_252_1.leftNameTxt_.text = var_255_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_15 = arg_252_1:GetWordFromCfg(105121061)
				local var_255_16 = arg_252_1:FormatText(var_255_15.content)

				arg_252_1.text_.text = var_255_16

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_17 = 3
				local var_255_18 = utf8.len(var_255_16)
				local var_255_19 = var_255_17 <= 0 and var_255_13 or var_255_13 * (var_255_18 / var_255_17)

				if var_255_19 > 0 and var_255_13 < var_255_19 then
					arg_252_1.talkMaxDuration = var_255_19

					if var_255_19 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_19 + var_255_12
					end
				end

				arg_252_1.text_.text = var_255_16
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121061", "story_v_out_105121.awb") ~= 0 then
					local var_255_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121061", "story_v_out_105121.awb") / 1000

					if var_255_20 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_20 + var_255_12
					end

					if var_255_15.prefab_name ~= "" and arg_252_1.actors_[var_255_15.prefab_name] ~= nil then
						local var_255_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_15.prefab_name].transform, "story_v_out_105121", "105121061", "story_v_out_105121.awb")

						arg_252_1:RecordAudio("105121061", var_255_21)
						arg_252_1:RecordAudio("105121061", var_255_21)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_105121", "105121061", "story_v_out_105121.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_105121", "105121061", "story_v_out_105121.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_22 = math.max(var_255_13, arg_252_1.talkMaxDuration)

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_22 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_12) / var_255_22

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_12 + var_255_22 and arg_252_1.time_ < var_255_12 + var_255_22 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play105121062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 105121062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play105121063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10001_tpose"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos10001_tpose = var_259_0.localPosition

				local var_259_2 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(false)
				end
			end

			local var_259_3 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_3 then
				local var_259_4 = (arg_256_1.time_ - var_259_1) / var_259_3
				local var_259_5 = Vector3.New(0, 100, 0)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10001_tpose, var_259_5, var_259_4)

				local var_259_6 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_6.x, var_259_6.y, var_259_6.z)

				local var_259_7 = var_259_0.localEulerAngles

				var_259_7.z = 0
				var_259_7.x = 0
				var_259_0.localEulerAngles = var_259_7
			end

			if arg_256_1.time_ >= var_259_1 + var_259_3 and arg_256_1.time_ < var_259_1 + var_259_3 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, 100, 0)

				local var_259_8 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_8.x, var_259_8.y, var_259_8.z)

				local var_259_9 = var_259_0.localEulerAngles

				var_259_9.z = 0
				var_259_9.x = 0
				var_259_0.localEulerAngles = var_259_9

				local var_259_10 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_10 then
					var_259_10:EnableDynamicBone(true)
				end
			end

			local var_259_11 = 0
			local var_259_12 = 1.55

			if var_259_11 < arg_256_1.time_ and arg_256_1.time_ <= var_259_11 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_13 = arg_256_1:GetWordFromCfg(105121062)
				local var_259_14 = arg_256_1:FormatText(var_259_13.content)

				arg_256_1.text_.text = var_259_14

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_15 = 62
				local var_259_16 = utf8.len(var_259_14)
				local var_259_17 = var_259_15 <= 0 and var_259_12 or var_259_12 * (var_259_16 / var_259_15)

				if var_259_17 > 0 and var_259_12 < var_259_17 then
					arg_256_1.talkMaxDuration = var_259_17

					if var_259_17 + var_259_11 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_17 + var_259_11
					end
				end

				arg_256_1.text_.text = var_259_14
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_18 = math.max(var_259_12, arg_256_1.talkMaxDuration)

			if var_259_11 <= arg_256_1.time_ and arg_256_1.time_ < var_259_11 + var_259_18 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_11) / var_259_18

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_11 + var_259_18 and arg_256_1.time_ < var_259_11 + var_259_18 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
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

		arg_256_1:InitPlayNodeList()
	end,
	Play105121063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 105121063
		arg_260_1.duration_ = 2.57

		local var_260_0 = {
			ja = 1.233,
			ko = 2.4,
			zh = 2.566,
			en = 1.5
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play105121064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1019ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1019ui_story == nil then
				arg_260_1.var_.characterEffect1019ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.1

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1019ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1019ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1019ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1019ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 0.225

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[5].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_9 = arg_260_1:GetWordFromCfg(105121063)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 9
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121063", "story_v_out_105121.awb") ~= 0 then
					local var_263_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121063", "story_v_out_105121.awb") / 1000

					if var_263_14 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_6
					end

					if var_263_9.prefab_name ~= "" and arg_260_1.actors_[var_263_9.prefab_name] ~= nil then
						local var_263_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_9.prefab_name].transform, "story_v_out_105121", "105121063", "story_v_out_105121.awb")

						arg_260_1:RecordAudio("105121063", var_263_15)
						arg_260_1:RecordAudio("105121063", var_263_15)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_105121", "105121063", "story_v_out_105121.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_105121", "105121063", "story_v_out_105121.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_16 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_16 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_16

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_16 and arg_260_1.time_ < var_263_6 + var_263_16 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play105121064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 105121064
		arg_264_1.duration_ = 3.67

		local var_264_0 = {
			ja = 3.466,
			ko = 3.233,
			zh = 3.666,
			en = 3.266
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play105121065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = "S0504"

			if arg_264_1.bgs_[var_267_0] == nil then
				local var_267_1 = Object.Instantiate(arg_264_1.paintGo_)

				var_267_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_267_0)
				var_267_1.name = var_267_0
				var_267_1.transform.parent = arg_264_1.stage_.transform
				var_267_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.bgs_[var_267_0] = var_267_1
			end

			local var_267_2 = 1.5

			if var_267_2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				local var_267_3 = manager.ui.mainCamera.transform.localPosition
				local var_267_4 = Vector3.New(0, 0, 10) + Vector3.New(var_267_3.x, var_267_3.y, 0)
				local var_267_5 = arg_264_1.bgs_.S0504

				var_267_5.transform.localPosition = var_267_4
				var_267_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_6 = var_267_5:GetComponent("SpriteRenderer")

				if var_267_6 and var_267_6.sprite then
					local var_267_7 = (var_267_5.transform.localPosition - var_267_3).z
					local var_267_8 = manager.ui.mainCameraCom_
					local var_267_9 = 2 * var_267_7 * Mathf.Tan(var_267_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_10 = var_267_9 * var_267_8.aspect
					local var_267_11 = var_267_6.sprite.bounds.size.x
					local var_267_12 = var_267_6.sprite.bounds.size.y
					local var_267_13 = var_267_10 / var_267_11
					local var_267_14 = var_267_9 / var_267_12
					local var_267_15 = var_267_14 < var_267_13 and var_267_13 or var_267_14

					var_267_5.transform.localScale = Vector3.New(var_267_15, var_267_15, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "S0504" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_16 = arg_264_1.bgs_.B01a.transform
			local var_267_17 = 1.5

			if var_267_17 < arg_264_1.time_ and arg_264_1.time_ <= var_267_17 + arg_267_0 then
				arg_264_1.var_.moveOldPosB01a = var_267_16.localPosition
			end

			local var_267_18 = 0.001

			if var_267_17 <= arg_264_1.time_ and arg_264_1.time_ < var_267_17 + var_267_18 then
				local var_267_19 = (arg_264_1.time_ - var_267_17) / var_267_18
				local var_267_20 = Vector3.New(0, -100, 10)

				var_267_16.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPosB01a, var_267_20, var_267_19)
			end

			if arg_264_1.time_ >= var_267_17 + var_267_18 and arg_264_1.time_ < var_267_17 + var_267_18 + arg_267_0 then
				var_267_16.localPosition = Vector3.New(0, -100, 10)
			end

			local var_267_21 = arg_264_1.bgs_.B01a
			local var_267_22 = 0

			if var_267_22 < arg_264_1.time_ and arg_264_1.time_ <= var_267_22 + arg_267_0 then
				local var_267_23 = var_267_21:GetComponent("SpriteRenderer")

				if var_267_23 then
					arg_264_1.var_.alphaOldValueB01a = var_267_23.color.a
					arg_264_1.var_.alphaMatValueB01a = var_267_23
				end

				arg_264_1.var_.alphaOldValueB01a = 1
			end

			local var_267_24 = 1.5

			if var_267_22 <= arg_264_1.time_ and arg_264_1.time_ < var_267_22 + var_267_24 then
				local var_267_25 = (arg_264_1.time_ - var_267_22) / var_267_24
				local var_267_26 = Mathf.Lerp(arg_264_1.var_.alphaOldValueB01a, 0, var_267_25)

				if arg_264_1.var_.alphaMatValueB01a then
					local var_267_27 = arg_264_1.var_.alphaMatValueB01a.color

					var_267_27.a = var_267_26
					arg_264_1.var_.alphaMatValueB01a.color = var_267_27
				end
			end

			if arg_264_1.time_ >= var_267_22 + var_267_24 and arg_264_1.time_ < var_267_22 + var_267_24 + arg_267_0 and arg_264_1.var_.alphaMatValueB01a then
				local var_267_28 = arg_264_1.var_.alphaMatValueB01a
				local var_267_29 = var_267_28.color

				var_267_29.a = 0
				var_267_28.color = var_267_29
			end

			local var_267_30 = arg_264_1.bgs_.S0504
			local var_267_31 = 1.5

			if var_267_31 < arg_264_1.time_ and arg_264_1.time_ <= var_267_31 + arg_267_0 then
				local var_267_32 = var_267_30:GetComponent("SpriteRenderer")

				if var_267_32 then
					arg_264_1.var_.alphaOldValueS0504 = var_267_32.color.a
					arg_264_1.var_.alphaMatValueS0504 = var_267_32
				end

				arg_264_1.var_.alphaOldValueS0504 = 0
			end

			local var_267_33 = 1.5

			if var_267_31 <= arg_264_1.time_ and arg_264_1.time_ < var_267_31 + var_267_33 then
				local var_267_34 = (arg_264_1.time_ - var_267_31) / var_267_33
				local var_267_35 = Mathf.Lerp(arg_264_1.var_.alphaOldValueS0504, 1, var_267_34)

				if arg_264_1.var_.alphaMatValueS0504 then
					local var_267_36 = arg_264_1.var_.alphaMatValueS0504.color

					var_267_36.a = var_267_35
					arg_264_1.var_.alphaMatValueS0504.color = var_267_36
				end
			end

			if arg_264_1.time_ >= var_267_31 + var_267_33 and arg_264_1.time_ < var_267_31 + var_267_33 + arg_267_0 and arg_264_1.var_.alphaMatValueS0504 then
				local var_267_37 = arg_264_1.var_.alphaMatValueS0504
				local var_267_38 = var_267_37.color

				var_267_38.a = 1
				var_267_37.color = var_267_38
			end

			local var_267_39 = 0

			if var_267_39 < arg_264_1.time_ and arg_264_1.time_ <= var_267_39 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_40 = 1.5

			if arg_264_1.time_ >= var_267_39 + var_267_40 and arg_264_1.time_ < var_267_39 + var_267_40 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_41 = 2
			local var_267_42 = 0.15

			if var_267_41 < arg_264_1.time_ and arg_264_1.time_ <= var_267_41 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_43 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_43:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_44 = arg_264_1:FormatText(StoryNameCfg[13].name)

				arg_264_1.leftNameTxt_.text = var_267_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_45 = arg_264_1:GetWordFromCfg(105121064)
				local var_267_46 = arg_264_1:FormatText(var_267_45.content)

				arg_264_1.text_.text = var_267_46

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_47 = 6
				local var_267_48 = utf8.len(var_267_46)
				local var_267_49 = var_267_47 <= 0 and var_267_42 or var_267_42 * (var_267_48 / var_267_47)

				if var_267_49 > 0 and var_267_42 < var_267_49 then
					arg_264_1.talkMaxDuration = var_267_49
					var_267_41 = var_267_41 + 0.3

					if var_267_49 + var_267_41 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_49 + var_267_41
					end
				end

				arg_264_1.text_.text = var_267_46
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121064", "story_v_out_105121.awb") ~= 0 then
					local var_267_50 = manager.audio:GetVoiceLength("story_v_out_105121", "105121064", "story_v_out_105121.awb") / 1000

					if var_267_50 + var_267_41 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_50 + var_267_41
					end

					if var_267_45.prefab_name ~= "" and arg_264_1.actors_[var_267_45.prefab_name] ~= nil then
						local var_267_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_45.prefab_name].transform, "story_v_out_105121", "105121064", "story_v_out_105121.awb")

						arg_264_1:RecordAudio("105121064", var_267_51)
						arg_264_1:RecordAudio("105121064", var_267_51)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_105121", "105121064", "story_v_out_105121.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_105121", "105121064", "story_v_out_105121.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_52 = var_267_41 + 0.3
			local var_267_53 = math.max(var_267_42, arg_264_1.talkMaxDuration)

			if var_267_52 <= arg_264_1.time_ and arg_264_1.time_ < var_267_52 + var_267_53 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_52) / var_267_53

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_52 + var_267_53 and arg_264_1.time_ < var_267_52 + var_267_53 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B01a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play105121065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 105121065
		arg_270_1.duration_ = 1.9

		local var_270_0 = {
			ja = 1.5,
			ko = 1.9,
			zh = 1.433,
			en = 1.3
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play105121066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.175

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[15].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(105121065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121065", "story_v_out_105121.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121065", "story_v_out_105121.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_105121", "105121065", "story_v_out_105121.awb")

						arg_270_1:RecordAudio("105121065", var_273_9)
						arg_270_1:RecordAudio("105121065", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_105121", "105121065", "story_v_out_105121.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_105121", "105121065", "story_v_out_105121.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play105121066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 105121066
		arg_274_1.duration_ = 2.43

		local var_274_0 = {
			ja = 1.533,
			ko = 1.333,
			zh = 1.233,
			en = 2.433
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play105121067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = "1080ui_story"

			if arg_274_1.actors_[var_277_0] == nil then
				local var_277_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_277_1) then
					local var_277_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_274_1.stage_.transform)

					var_277_2.name = var_277_0
					var_277_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_274_1.actors_[var_277_0] = var_277_2

					local var_277_3 = var_277_2:GetComponentInChildren(typeof(CharacterEffect))

					var_277_3.enabled = true

					local var_277_4 = GameObjectTools.GetOrAddComponent(var_277_2, typeof(DynamicBoneHelper))

					if var_277_4 then
						var_277_4:EnableDynamicBone(false)
					end

					arg_274_1:ShowWeapon(var_277_3.transform, false)

					arg_274_1.var_[var_277_0 .. "Animator"] = var_277_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_274_1.var_[var_277_0 .. "Animator"].applyRootMotion = true
					arg_274_1.var_[var_277_0 .. "LipSync"] = var_277_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_277_5 = arg_274_1.actors_["1080ui_story"]
			local var_277_6 = 0

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1080ui_story == nil then
				arg_274_1.var_.characterEffect1080ui_story = var_277_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_7 = 0.1

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_7 and not isNil(var_277_5) then
				local var_277_8 = (arg_274_1.time_ - var_277_6) / var_277_7

				if arg_274_1.var_.characterEffect1080ui_story and not isNil(var_277_5) then
					arg_274_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_6 + var_277_7 and arg_274_1.time_ < var_277_6 + var_277_7 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1080ui_story then
				arg_274_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_277_9 = 0
			local var_277_10 = 0.25

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_11 = arg_274_1:FormatText(StoryNameCfg[55].name)

				arg_274_1.leftNameTxt_.text = var_277_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_12 = arg_274_1:GetWordFromCfg(105121066)
				local var_277_13 = arg_274_1:FormatText(var_277_12.content)

				arg_274_1.text_.text = var_277_13

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_14 = 6
				local var_277_15 = utf8.len(var_277_13)
				local var_277_16 = var_277_14 <= 0 and var_277_10 or var_277_10 * (var_277_15 / var_277_14)

				if var_277_16 > 0 and var_277_10 < var_277_16 then
					arg_274_1.talkMaxDuration = var_277_16

					if var_277_16 + var_277_9 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_16 + var_277_9
					end
				end

				arg_274_1.text_.text = var_277_13
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121066", "story_v_out_105121.awb") ~= 0 then
					local var_277_17 = manager.audio:GetVoiceLength("story_v_out_105121", "105121066", "story_v_out_105121.awb") / 1000

					if var_277_17 + var_277_9 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_17 + var_277_9
					end

					if var_277_12.prefab_name ~= "" and arg_274_1.actors_[var_277_12.prefab_name] ~= nil then
						local var_277_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_12.prefab_name].transform, "story_v_out_105121", "105121066", "story_v_out_105121.awb")

						arg_274_1:RecordAudio("105121066", var_277_18)
						arg_274_1:RecordAudio("105121066", var_277_18)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_105121", "105121066", "story_v_out_105121.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_105121", "105121066", "story_v_out_105121.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_19 = math.max(var_277_10, arg_274_1.talkMaxDuration)

			if var_277_9 <= arg_274_1.time_ and arg_274_1.time_ < var_277_9 + var_277_19 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_9) / var_277_19

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_9 + var_277_19 and arg_274_1.time_ < var_277_9 + var_277_19 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play105121067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 105121067
		arg_278_1.duration_ = 4.83

		local var_278_0 = {
			ja = 2.8,
			ko = 4.233,
			zh = 4.566,
			en = 4.833
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play105121068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.475

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[45].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(105121067)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121067", "story_v_out_105121.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121067", "story_v_out_105121.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_105121", "105121067", "story_v_out_105121.awb")

						arg_278_1:RecordAudio("105121067", var_281_9)
						arg_278_1:RecordAudio("105121067", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_105121", "105121067", "story_v_out_105121.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_105121", "105121067", "story_v_out_105121.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play105121068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 105121068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play105121069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1080ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1080ui_story == nil then
				arg_282_1.var_.characterEffect1080ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.1

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1080ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1080ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1080ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1080ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.2

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(105121068)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 8
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play105121069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 105121069
		arg_286_1.duration_ = 7.83

		local var_286_0 = {
			ja = 5.6,
			ko = 7.833,
			zh = 6.2,
			en = 7.366
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play105121070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.575

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[72].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(105121069)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 25
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121069", "story_v_out_105121.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121069", "story_v_out_105121.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_105121", "105121069", "story_v_out_105121.awb")

						arg_286_1:RecordAudio("105121069", var_289_9)
						arg_286_1:RecordAudio("105121069", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_105121", "105121069", "story_v_out_105121.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_105121", "105121069", "story_v_out_105121.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play105121070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 105121070
		arg_290_1.duration_ = 3.83

		local var_290_0 = {
			ja = 3.833,
			ko = 1.833,
			zh = 1.866,
			en = 1.666
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play105121071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.15

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[6].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(105121070)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 6
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121070", "story_v_out_105121.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121070", "story_v_out_105121.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_105121", "105121070", "story_v_out_105121.awb")

						arg_290_1:RecordAudio("105121070", var_293_9)
						arg_290_1:RecordAudio("105121070", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_105121", "105121070", "story_v_out_105121.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_105121", "105121070", "story_v_out_105121.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play105121071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 105121071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play105121072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10001_tpose"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10001_tpose == nil then
				arg_294_1.var_.characterEffect10001_tpose = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.1

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect10001_tpose and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_294_1.var_.characterEffect10001_tpose.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10001_tpose then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_294_1.var_.characterEffect10001_tpose.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 1.25

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(105121071)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 50
				local var_297_11 = utf8.len(var_297_9)
				local var_297_12 = var_297_10 <= 0 and var_297_7 or var_297_7 * (var_297_11 / var_297_10)

				if var_297_12 > 0 and var_297_7 < var_297_12 then
					arg_294_1.talkMaxDuration = var_297_12

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_13 and arg_294_1.time_ < var_297_6 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play105121072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 105121072
		arg_298_1.duration_ = 7

		local var_298_0 = {
			ja = 5.8,
			ko = 3.5,
			zh = 7,
			en = 5.5
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play105121073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10001_tpose"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10001_tpose == nil then
				arg_298_1.var_.characterEffect10001_tpose = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.1

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect10001_tpose and not isNil(var_301_0) then
					arg_298_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10001_tpose then
				arg_298_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_301_4 = arg_298_1.actors_["1084ui_story"]
			local var_301_5 = 0

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 and not isNil(var_301_4) and arg_298_1.var_.characterEffect1084ui_story == nil then
				arg_298_1.var_.characterEffect1084ui_story = var_301_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_6 = 0.1

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_6 and not isNil(var_301_4) then
				local var_301_7 = (arg_298_1.time_ - var_301_5) / var_301_6

				if arg_298_1.var_.characterEffect1084ui_story and not isNil(var_301_4) then
					local var_301_8 = Mathf.Lerp(0, 0.5, var_301_7)

					arg_298_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1084ui_story.fillRatio = var_301_8
				end
			end

			if arg_298_1.time_ >= var_301_5 + var_301_6 and arg_298_1.time_ < var_301_5 + var_301_6 + arg_301_0 and not isNil(var_301_4) and arg_298_1.var_.characterEffect1084ui_story then
				local var_301_9 = 0.5

				arg_298_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1084ui_story.fillRatio = var_301_9
			end

			local var_301_10 = 0
			local var_301_11 = 0.375

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_12 = arg_298_1:FormatText(StoryNameCfg[45].name)

				arg_298_1.leftNameTxt_.text = var_301_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_13 = arg_298_1:GetWordFromCfg(105121072)
				local var_301_14 = arg_298_1:FormatText(var_301_13.content)

				arg_298_1.text_.text = var_301_14

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_15 = 15
				local var_301_16 = utf8.len(var_301_14)
				local var_301_17 = var_301_15 <= 0 and var_301_11 or var_301_11 * (var_301_16 / var_301_15)

				if var_301_17 > 0 and var_301_11 < var_301_17 then
					arg_298_1.talkMaxDuration = var_301_17

					if var_301_17 + var_301_10 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_17 + var_301_10
					end
				end

				arg_298_1.text_.text = var_301_14
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121072", "story_v_out_105121.awb") ~= 0 then
					local var_301_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121072", "story_v_out_105121.awb") / 1000

					if var_301_18 + var_301_10 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_18 + var_301_10
					end

					if var_301_13.prefab_name ~= "" and arg_298_1.actors_[var_301_13.prefab_name] ~= nil then
						local var_301_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_13.prefab_name].transform, "story_v_out_105121", "105121072", "story_v_out_105121.awb")

						arg_298_1:RecordAudio("105121072", var_301_19)
						arg_298_1:RecordAudio("105121072", var_301_19)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_105121", "105121072", "story_v_out_105121.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_105121", "105121072", "story_v_out_105121.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_20 = math.max(var_301_11, arg_298_1.talkMaxDuration)

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_20 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_10) / var_301_20

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_10 + var_301_20 and arg_298_1.time_ < var_301_10 + var_301_20 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play105121073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 105121073
		arg_302_1.duration_ = 9.97

		local var_302_0 = {
			ja = 9.966,
			ko = 4.766,
			zh = 5.366,
			en = 3.8
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play105121074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.525

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_2 = arg_302_1:FormatText(StoryNameCfg[45].name)

				arg_302_1.leftNameTxt_.text = var_305_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:GetWordFromCfg(105121073)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 21
				local var_305_6 = utf8.len(var_305_4)
				local var_305_7 = var_305_5 <= 0 and var_305_1 or var_305_1 * (var_305_6 / var_305_5)

				if var_305_7 > 0 and var_305_1 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121073", "story_v_out_105121.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121073", "story_v_out_105121.awb") / 1000

					if var_305_8 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_0
					end

					if var_305_3.prefab_name ~= "" and arg_302_1.actors_[var_305_3.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_3.prefab_name].transform, "story_v_out_105121", "105121073", "story_v_out_105121.awb")

						arg_302_1:RecordAudio("105121073", var_305_9)
						arg_302_1:RecordAudio("105121073", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_105121", "105121073", "story_v_out_105121.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_105121", "105121073", "story_v_out_105121.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_10 and arg_302_1.time_ < var_305_0 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play105121074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 105121074
		arg_306_1.duration_ = 10.4

		local var_306_0 = {
			ja = 5.2,
			ko = 5.433,
			zh = 8.466,
			en = 10.4
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play105121075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.775

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[45].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:GetWordFromCfg(105121074)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 31
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121074", "story_v_out_105121.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121074", "story_v_out_105121.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_105121", "105121074", "story_v_out_105121.awb")

						arg_306_1:RecordAudio("105121074", var_309_9)
						arg_306_1:RecordAudio("105121074", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_105121", "105121074", "story_v_out_105121.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_105121", "105121074", "story_v_out_105121.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play105121075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 105121075
		arg_310_1.duration_ = 6.2

		local var_310_0 = {
			ja = 6.2,
			ko = 5.666,
			zh = 4.866,
			en = 3.7
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play105121076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1037ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1037ui_story == nil then
				arg_310_1.var_.characterEffect1037ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.1

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1037ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1037ui_story then
				arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_313_4 = arg_310_1.actors_["10001_tpose"]
			local var_313_5 = 0

			if var_313_5 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect10001_tpose == nil then
				arg_310_1.var_.characterEffect10001_tpose = var_313_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_6 = 0.1

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_6 and not isNil(var_313_4) then
				local var_313_7 = (arg_310_1.time_ - var_313_5) / var_313_6

				if arg_310_1.var_.characterEffect10001_tpose and not isNil(var_313_4) then
					local var_313_8 = Mathf.Lerp(0, 0.5, var_313_7)

					arg_310_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_310_1.var_.characterEffect10001_tpose.fillRatio = var_313_8
				end
			end

			if arg_310_1.time_ >= var_313_5 + var_313_6 and arg_310_1.time_ < var_313_5 + var_313_6 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect10001_tpose then
				local var_313_9 = 0.5

				arg_310_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_310_1.var_.characterEffect10001_tpose.fillRatio = var_313_9
			end

			local var_313_10 = 0
			local var_313_11 = 0.425

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_12 = arg_310_1:FormatText(StoryNameCfg[15].name)

				arg_310_1.leftNameTxt_.text = var_313_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_13 = arg_310_1:GetWordFromCfg(105121075)
				local var_313_14 = arg_310_1:FormatText(var_313_13.content)

				arg_310_1.text_.text = var_313_14

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_15 = 17
				local var_313_16 = utf8.len(var_313_14)
				local var_313_17 = var_313_15 <= 0 and var_313_11 or var_313_11 * (var_313_16 / var_313_15)

				if var_313_17 > 0 and var_313_11 < var_313_17 then
					arg_310_1.talkMaxDuration = var_313_17

					if var_313_17 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_10
					end
				end

				arg_310_1.text_.text = var_313_14
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121075", "story_v_out_105121.awb") ~= 0 then
					local var_313_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121075", "story_v_out_105121.awb") / 1000

					if var_313_18 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_18 + var_313_10
					end

					if var_313_13.prefab_name ~= "" and arg_310_1.actors_[var_313_13.prefab_name] ~= nil then
						local var_313_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_13.prefab_name].transform, "story_v_out_105121", "105121075", "story_v_out_105121.awb")

						arg_310_1:RecordAudio("105121075", var_313_19)
						arg_310_1:RecordAudio("105121075", var_313_19)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_105121", "105121075", "story_v_out_105121.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_105121", "105121075", "story_v_out_105121.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_11, arg_310_1.talkMaxDuration)

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_10) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_10 + var_313_20 and arg_310_1.time_ < var_313_10 + var_313_20 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play105121076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 105121076
		arg_314_1.duration_ = 4.87

		local var_314_0 = {
			ja = 3.6,
			ko = 3.266,
			zh = 4.866,
			en = 4.366
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play105121077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1036ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1036ui_story == nil then
				arg_314_1.var_.characterEffect1036ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.1

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1036ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1036ui_story then
				arg_314_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_317_4 = arg_314_1.actors_["1037ui_story"]
			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect1037ui_story == nil then
				arg_314_1.var_.characterEffect1037ui_story = var_317_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_6 = 0.1

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_6 and not isNil(var_317_4) then
				local var_317_7 = (arg_314_1.time_ - var_317_5) / var_317_6

				if arg_314_1.var_.characterEffect1037ui_story and not isNil(var_317_4) then
					local var_317_8 = Mathf.Lerp(0, 0.5, var_317_7)

					arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1037ui_story.fillRatio = var_317_8
				end
			end

			if arg_314_1.time_ >= var_317_5 + var_317_6 and arg_314_1.time_ < var_317_5 + var_317_6 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect1037ui_story then
				local var_317_9 = 0.5

				arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1037ui_story.fillRatio = var_317_9
			end

			local var_317_10 = 0
			local var_317_11 = 0.25

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_12 = arg_314_1:FormatText(StoryNameCfg[5].name)

				arg_314_1.leftNameTxt_.text = var_317_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_13 = arg_314_1:GetWordFromCfg(105121076)
				local var_317_14 = arg_314_1:FormatText(var_317_13.content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_15 = 10
				local var_317_16 = utf8.len(var_317_14)
				local var_317_17 = var_317_15 <= 0 and var_317_11 or var_317_11 * (var_317_16 / var_317_15)

				if var_317_17 > 0 and var_317_11 < var_317_17 then
					arg_314_1.talkMaxDuration = var_317_17

					if var_317_17 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_17 + var_317_10
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121076", "story_v_out_105121.awb") ~= 0 then
					local var_317_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121076", "story_v_out_105121.awb") / 1000

					if var_317_18 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_18 + var_317_10
					end

					if var_317_13.prefab_name ~= "" and arg_314_1.actors_[var_317_13.prefab_name] ~= nil then
						local var_317_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_13.prefab_name].transform, "story_v_out_105121", "105121076", "story_v_out_105121.awb")

						arg_314_1:RecordAudio("105121076", var_317_19)
						arg_314_1:RecordAudio("105121076", var_317_19)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_105121", "105121076", "story_v_out_105121.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_105121", "105121076", "story_v_out_105121.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_20 = math.max(var_317_11, arg_314_1.talkMaxDuration)

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_20 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_10) / var_317_20

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_10 + var_317_20 and arg_314_1.time_ < var_317_10 + var_317_20 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play105121077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 105121077
		arg_318_1.duration_ = 6.27

		local var_318_0 = {
			ja = 4.866,
			ko = 5.233,
			zh = 5.7,
			en = 6.266
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play105121078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1019ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1019ui_story == nil then
				arg_318_1.var_.characterEffect1019ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.1

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1019ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1019ui_story then
				arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_321_4 = arg_318_1.actors_["1036ui_story"]
			local var_321_5 = 0

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1036ui_story == nil then
				arg_318_1.var_.characterEffect1036ui_story = var_321_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_6 = 0.1

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_6 and not isNil(var_321_4) then
				local var_321_7 = (arg_318_1.time_ - var_321_5) / var_321_6

				if arg_318_1.var_.characterEffect1036ui_story and not isNil(var_321_4) then
					local var_321_8 = Mathf.Lerp(0, 0.5, var_321_7)

					arg_318_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1036ui_story.fillRatio = var_321_8
				end
			end

			if arg_318_1.time_ >= var_321_5 + var_321_6 and arg_318_1.time_ < var_321_5 + var_321_6 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1036ui_story then
				local var_321_9 = 0.5

				arg_318_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1036ui_story.fillRatio = var_321_9
			end

			local var_321_10 = 0
			local var_321_11 = 0.6

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_12 = arg_318_1:FormatText(StoryNameCfg[13].name)

				arg_318_1.leftNameTxt_.text = var_321_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_13 = arg_318_1:GetWordFromCfg(105121077)
				local var_321_14 = arg_318_1:FormatText(var_321_13.content)

				arg_318_1.text_.text = var_321_14

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_15 = 25
				local var_321_16 = utf8.len(var_321_14)
				local var_321_17 = var_321_15 <= 0 and var_321_11 or var_321_11 * (var_321_16 / var_321_15)

				if var_321_17 > 0 and var_321_11 < var_321_17 then
					arg_318_1.talkMaxDuration = var_321_17

					if var_321_17 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_17 + var_321_10
					end
				end

				arg_318_1.text_.text = var_321_14
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121077", "story_v_out_105121.awb") ~= 0 then
					local var_321_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121077", "story_v_out_105121.awb") / 1000

					if var_321_18 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_18 + var_321_10
					end

					if var_321_13.prefab_name ~= "" and arg_318_1.actors_[var_321_13.prefab_name] ~= nil then
						local var_321_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_13.prefab_name].transform, "story_v_out_105121", "105121077", "story_v_out_105121.awb")

						arg_318_1:RecordAudio("105121077", var_321_19)
						arg_318_1:RecordAudio("105121077", var_321_19)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_105121", "105121077", "story_v_out_105121.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_105121", "105121077", "story_v_out_105121.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_20 = math.max(var_321_11, arg_318_1.talkMaxDuration)

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_20 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_10) / var_321_20

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_10 + var_321_20 and arg_318_1.time_ < var_321_10 + var_321_20 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play105121078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 105121078
		arg_322_1.duration_ = 11.37

		local var_322_0 = {
			ja = 11.366,
			ko = 3.233,
			zh = 5.833,
			en = 7.866
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play105121079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10001_tpose"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10001_tpose == nil then
				arg_322_1.var_.characterEffect10001_tpose = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.1

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect10001_tpose and not isNil(var_325_0) then
					arg_322_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10001_tpose then
				arg_322_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_325_4 = arg_322_1.actors_["1019ui_story"]
			local var_325_5 = 0

			if var_325_5 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect1019ui_story == nil then
				arg_322_1.var_.characterEffect1019ui_story = var_325_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_6 = 0.1

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_6 and not isNil(var_325_4) then
				local var_325_7 = (arg_322_1.time_ - var_325_5) / var_325_6

				if arg_322_1.var_.characterEffect1019ui_story and not isNil(var_325_4) then
					local var_325_8 = Mathf.Lerp(0, 0.5, var_325_7)

					arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1019ui_story.fillRatio = var_325_8
				end
			end

			if arg_322_1.time_ >= var_325_5 + var_325_6 and arg_322_1.time_ < var_325_5 + var_325_6 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect1019ui_story then
				local var_325_9 = 0.5

				arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1019ui_story.fillRatio = var_325_9
			end

			local var_325_10 = 0
			local var_325_11 = 0.525

			if var_325_10 < arg_322_1.time_ and arg_322_1.time_ <= var_325_10 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_12 = arg_322_1:FormatText(StoryNameCfg[45].name)

				arg_322_1.leftNameTxt_.text = var_325_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_13 = arg_322_1:GetWordFromCfg(105121078)
				local var_325_14 = arg_322_1:FormatText(var_325_13.content)

				arg_322_1.text_.text = var_325_14

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_15 = 21
				local var_325_16 = utf8.len(var_325_14)
				local var_325_17 = var_325_15 <= 0 and var_325_11 or var_325_11 * (var_325_16 / var_325_15)

				if var_325_17 > 0 and var_325_11 < var_325_17 then
					arg_322_1.talkMaxDuration = var_325_17

					if var_325_17 + var_325_10 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_17 + var_325_10
					end
				end

				arg_322_1.text_.text = var_325_14
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121078", "story_v_out_105121.awb") ~= 0 then
					local var_325_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121078", "story_v_out_105121.awb") / 1000

					if var_325_18 + var_325_10 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_18 + var_325_10
					end

					if var_325_13.prefab_name ~= "" and arg_322_1.actors_[var_325_13.prefab_name] ~= nil then
						local var_325_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_13.prefab_name].transform, "story_v_out_105121", "105121078", "story_v_out_105121.awb")

						arg_322_1:RecordAudio("105121078", var_325_19)
						arg_322_1:RecordAudio("105121078", var_325_19)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_105121", "105121078", "story_v_out_105121.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_105121", "105121078", "story_v_out_105121.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_20 = math.max(var_325_11, arg_322_1.talkMaxDuration)

			if var_325_10 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_20 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_10) / var_325_20

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_10 + var_325_20 and arg_322_1.time_ < var_325_10 + var_325_20 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play105121079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 105121079
		arg_326_1.duration_ = 0.1

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"

			SetActive(arg_326_1.choicesGo_, true)

			for iter_327_0, iter_327_1 in ipairs(arg_326_1.choices_) do
				local var_327_0 = iter_327_0 <= 1

				SetActive(iter_327_1.go, var_327_0)
			end

			arg_326_1.choices_[1].txt.text = arg_326_1:FormatText(StoryChoiceCfg[35].name)
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play105121080(arg_326_1)
			end

			arg_326_1:RecordChoiceLog(105121079, 35)
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			return
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play105121080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 105121080
		arg_330_1.duration_ = 1.7

		local var_330_0 = {
			ja = 1.7,
			ko = 0.966,
			zh = 1.633,
			en = 1.2
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play105121081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10001_tpose"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10001_tpose == nil then
				arg_330_1.var_.characterEffect10001_tpose = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.1

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect10001_tpose and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_330_1.var_.characterEffect10001_tpose.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10001_tpose then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_330_1.var_.characterEffect10001_tpose.fillRatio = var_333_5
			end

			local var_333_6 = 0
			local var_333_7 = 0.125

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_8 = arg_330_1:FormatText(StoryNameCfg[55].name)

				arg_330_1.leftNameTxt_.text = var_333_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_9 = arg_330_1:GetWordFromCfg(105121080)
				local var_333_10 = arg_330_1:FormatText(var_333_9.content)

				arg_330_1.text_.text = var_333_10

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_11 = 5
				local var_333_12 = utf8.len(var_333_10)
				local var_333_13 = var_333_11 <= 0 and var_333_7 or var_333_7 * (var_333_12 / var_333_11)

				if var_333_13 > 0 and var_333_7 < var_333_13 then
					arg_330_1.talkMaxDuration = var_333_13

					if var_333_13 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_10
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121080", "story_v_out_105121.awb") ~= 0 then
					local var_333_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121080", "story_v_out_105121.awb") / 1000

					if var_333_14 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_14 + var_333_6
					end

					if var_333_9.prefab_name ~= "" and arg_330_1.actors_[var_333_9.prefab_name] ~= nil then
						local var_333_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_9.prefab_name].transform, "story_v_out_105121", "105121080", "story_v_out_105121.awb")

						arg_330_1:RecordAudio("105121080", var_333_15)
						arg_330_1:RecordAudio("105121080", var_333_15)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_105121", "105121080", "story_v_out_105121.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_105121", "105121080", "story_v_out_105121.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_16 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_16 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_16

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_16 and arg_330_1.time_ < var_333_6 + var_333_16 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play105121081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 105121081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play105121082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.95

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(105121081)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 38
				local var_337_5 = utf8.len(var_337_3)
				local var_337_6 = var_337_4 <= 0 and var_337_1 or var_337_1 * (var_337_5 / var_337_4)

				if var_337_6 > 0 and var_337_1 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_7 and arg_334_1.time_ < var_337_0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play105121082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 105121082
		arg_338_1.duration_ = 3.5

		local var_338_0 = {
			ja = 2.7,
			ko = 2.2,
			zh = 3.5,
			en = 1.6
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play105121083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.25

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[56].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(105121082)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 10
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121082", "story_v_out_105121.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121082", "story_v_out_105121.awb") / 1000

					if var_341_8 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_0
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_105121", "105121082", "story_v_out_105121.awb")

						arg_338_1:RecordAudio("105121082", var_341_9)
						arg_338_1:RecordAudio("105121082", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_105121", "105121082", "story_v_out_105121.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_105121", "105121082", "story_v_out_105121.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_10 and arg_338_1.time_ < var_341_0 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play105121083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 105121083
		arg_342_1.duration_ = 4

		local var_342_0 = {
			ja = 4,
			ko = 3.433,
			zh = 3.533,
			en = 3.866
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1084ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1084ui_story == nil then
				arg_342_1.var_.characterEffect1084ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.1

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1084ui_story and not isNil(var_345_0) then
					arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1084ui_story then
				arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_345_4 = 0
			local var_345_5 = 0.45

			if var_345_4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_6 = arg_342_1:FormatText(StoryNameCfg[6].name)

				arg_342_1.leftNameTxt_.text = var_345_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_7 = arg_342_1:GetWordFromCfg(105121083)
				local var_345_8 = arg_342_1:FormatText(var_345_7.content)

				arg_342_1.text_.text = var_345_8

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 18
				local var_345_10 = utf8.len(var_345_8)
				local var_345_11 = var_345_9 <= 0 and var_345_5 or var_345_5 * (var_345_10 / var_345_9)

				if var_345_11 > 0 and var_345_5 < var_345_11 then
					arg_342_1.talkMaxDuration = var_345_11

					if var_345_11 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_11 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_8
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121083", "story_v_out_105121.awb") ~= 0 then
					local var_345_12 = manager.audio:GetVoiceLength("story_v_out_105121", "105121083", "story_v_out_105121.awb") / 1000

					if var_345_12 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_12 + var_345_4
					end

					if var_345_7.prefab_name ~= "" and arg_342_1.actors_[var_345_7.prefab_name] ~= nil then
						local var_345_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_7.prefab_name].transform, "story_v_out_105121", "105121083", "story_v_out_105121.awb")

						arg_342_1:RecordAudio("105121083", var_345_13)
						arg_342_1:RecordAudio("105121083", var_345_13)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_105121", "105121083", "story_v_out_105121.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_105121", "105121083", "story_v_out_105121.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_14 and arg_342_1.time_ < var_345_4 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12a",
		"TextureConfig/Background/S0505",
		"TextureConfig/Background/B01a",
		"TextureConfig/Background/S0504"
	},
	voices = {
		"story_v_out_105121.awb"
	}
}
