return {
	Play101021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_6 = "B10a"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B10a
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB10a = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB10a = var_4_10
				end

				arg_1_1.var_.alphaOldValueB10a = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB10a, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB10a then
					local var_4_14 = arg_1_1.var_.alphaMatValueB10a.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB10a.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB10a then
				local var_4_15 = arg_1_1.var_.alphaMatValueB10a
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B10a

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.525

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(101021001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 20
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play101021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101021002
		arg_8_1.duration_ = 10.4

		local var_8_0 = {
			ja = 9.866,
			ko = 10.2,
			zh = 7.733,
			en = 10.4
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
				arg_8_0:Play101021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd")
			end

			local var_11_4 = 0
			local var_11_5 = 1

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				local var_11_6 = "play"
				local var_11_7 = "effect"

				arg_8_1:AudioAction(var_11_6, var_11_7, "se_story_1", "se_story_1_protest", "")
			end

			local var_11_8 = manager.ui.mainCamera.transform
			local var_11_9 = 0

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_8.localPosition
			end

			local var_11_10 = 0.600000023841858

			if var_11_9 <= arg_8_1.time_ and arg_8_1.time_ < var_11_9 + var_11_10 then
				local var_11_11 = (arg_8_1.time_ - var_11_9) / 0.066
				local var_11_12, var_11_13 = math.modf(var_11_11)

				var_11_8.localPosition = Vector3.New(var_11_13 * 0.13, var_11_13 * 0.13, var_11_13 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= var_11_9 + var_11_10 and arg_8_1.time_ < var_11_9 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_14 = 0
			local var_11_15 = 0.75

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_16 = arg_8_1:FormatText(StoryNameCfg[16].name)

				arg_8_1.leftNameTxt_.text = var_11_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_17 = arg_8_1:GetWordFromCfg(101021002)
				local var_11_18 = arg_8_1:FormatText(var_11_17.content)

				arg_8_1.text_.text = var_11_18

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 30
				local var_11_20 = utf8.len(var_11_18)
				local var_11_21 = var_11_19 <= 0 and var_11_15 or var_11_15 * (var_11_20 / var_11_19)

				if var_11_21 > 0 and var_11_15 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_18
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021002", "story_v_out_101021.awb") ~= 0 then
					local var_11_22 = manager.audio:GetVoiceLength("story_v_out_101021", "101021002", "story_v_out_101021.awb") / 1000

					if var_11_22 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_14
					end

					if var_11_17.prefab_name ~= "" and arg_8_1.actors_[var_11_17.prefab_name] ~= nil then
						local var_11_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_17.prefab_name].transform, "story_v_out_101021", "101021002", "story_v_out_101021.awb")

						arg_8_1:RecordAudio("101021002", var_11_23)
						arg_8_1:RecordAudio("101021002", var_11_23)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101021", "101021002", "story_v_out_101021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101021", "101021002", "story_v_out_101021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_24 and arg_8_1.time_ < var_11_14 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play101021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101021003
		arg_12_1.duration_ = 3.6

		local var_12_0 = {
			ja = 2.566,
			ko = 3.6,
			zh = 2.733,
			en = 2.2
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.25

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[17].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(101021003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 10
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021003", "story_v_out_101021.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021003", "story_v_out_101021.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_101021", "101021003", "story_v_out_101021.awb")

						arg_12_1:RecordAudio("101021003", var_15_9)
						arg_12_1:RecordAudio("101021003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101021", "101021003", "story_v_out_101021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101021", "101021003", "story_v_out_101021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101021004
		arg_16_1.duration_ = 7.23

		local var_16_0 = {
			ja = 7.1,
			ko = 4.966,
			zh = 4.333,
			en = 7.233
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
				arg_16_0:Play101021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.55

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[18].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(101021004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 22
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021004", "story_v_out_101021.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021004", "story_v_out_101021.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_101021", "101021004", "story_v_out_101021.awb")

						arg_16_1:RecordAudio("101021004", var_19_9)
						arg_16_1:RecordAudio("101021004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101021", "101021004", "story_v_out_101021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101021", "101021004", "story_v_out_101021.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play101021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101021005
		arg_20_1.duration_ = 4.5

		local var_20_0 = {
			ja = 3.233,
			ko = 2.166,
			zh = 4.5,
			en = 4.466
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
				arg_20_0:Play101021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "2020_tpose"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["2020_tpose"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect2020_tpose then
				arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["2020_tpose"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos2020_tpose = var_23_9.localPosition

				local var_23_11 = GameObjectTools.GetOrAddComponent(var_23_9.gameObject, typeof(DynamicBoneHelper))

				if var_23_11 then
					var_23_11:EnableDynamicBone(false)
				end
			end

			local var_23_12 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_10) / var_23_12
				local var_23_14 = Vector3.New(-0.7, -1.2, -4.1)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2020_tpose, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_9.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_9.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_10 + var_23_12 and arg_20_1.time_ < var_23_10 + var_23_12 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_9.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_9.localEulerAngles = var_23_18

				local var_23_19 = GameObjectTools.GetOrAddComponent(var_23_9.gameObject, typeof(DynamicBoneHelper))

				if var_23_19 then
					var_23_19:EnableDynamicBone(true)
				end
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_23_21 = 0
			local var_23_22 = 0.375

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_23 = arg_20_1:FormatText(StoryNameCfg[19].name)

				arg_20_1.leftNameTxt_.text = var_23_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(101021005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 15
				local var_23_27 = utf8.len(var_23_25)
				local var_23_28 = var_23_26 <= 0 and var_23_22 or var_23_22 * (var_23_27 / var_23_26)

				if var_23_28 > 0 and var_23_22 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_21
					end
				end

				arg_20_1.text_.text = var_23_25
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021005", "story_v_out_101021.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_101021", "101021005", "story_v_out_101021.awb") / 1000

					if var_23_29 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_21
					end

					if var_23_24.prefab_name ~= "" and arg_20_1.actors_[var_23_24.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_24.prefab_name].transform, "story_v_out_101021", "101021005", "story_v_out_101021.awb")

						arg_20_1:RecordAudio("101021005", var_23_30)
						arg_20_1:RecordAudio("101021005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101021", "101021005", "story_v_out_101021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101021", "101021005", "story_v_out_101021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_31 = math.max(var_23_22, arg_20_1.talkMaxDuration)

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_31 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_21) / var_23_31

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_21 + var_23_31 and arg_20_1.time_ < var_23_21 + var_23_31 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play101021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101021006
		arg_24_1.duration_ = 8

		local var_24_0 = {
			ja = 8,
			ko = 6.9,
			zh = 7.2,
			en = 6.7
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play101021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "3008ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_24_1.stage_.transform)

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

			local var_27_5 = arg_24_1.actors_["3008ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["2020_tpose"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2020_tpose.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect2020_tpose then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2020_tpose.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["3008ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0.7, -1.51, -4.3)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_26 = 0
			local var_27_27 = 0.8

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_28 = arg_24_1:FormatText(StoryNameCfg[20].name)

				arg_24_1.leftNameTxt_.text = var_27_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_29 = arg_24_1:GetWordFromCfg(101021006)
				local var_27_30 = arg_24_1:FormatText(var_27_29.content)

				arg_24_1.text_.text = var_27_30

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_31 = 32
				local var_27_32 = utf8.len(var_27_30)
				local var_27_33 = var_27_31 <= 0 and var_27_27 or var_27_27 * (var_27_32 / var_27_31)

				if var_27_33 > 0 and var_27_27 < var_27_33 then
					arg_24_1.talkMaxDuration = var_27_33

					if var_27_33 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_26
					end
				end

				arg_24_1.text_.text = var_27_30
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021006", "story_v_out_101021.awb") ~= 0 then
					local var_27_34 = manager.audio:GetVoiceLength("story_v_out_101021", "101021006", "story_v_out_101021.awb") / 1000

					if var_27_34 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_26
					end

					if var_27_29.prefab_name ~= "" and arg_24_1.actors_[var_27_29.prefab_name] ~= nil then
						local var_27_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_29.prefab_name].transform, "story_v_out_101021", "101021006", "story_v_out_101021.awb")

						arg_24_1:RecordAudio("101021006", var_27_35)
						arg_24_1:RecordAudio("101021006", var_27_35)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101021", "101021006", "story_v_out_101021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101021", "101021006", "story_v_out_101021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_36 = math.max(var_27_27, arg_24_1.talkMaxDuration)

			if var_27_26 <= arg_24_1.time_ and arg_24_1.time_ < var_27_26 + var_27_36 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_26) / var_27_36

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_26 + var_27_36 and arg_24_1.time_ < var_27_26 + var_27_36 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play101021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101021007
		arg_28_1.duration_ = 5.97

		local var_28_0 = {
			ja = 5.966,
			ko = 4.033,
			zh = 4.533,
			en = 3.033
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play101021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["2020_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["3008ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0
			local var_31_11 = 0.425

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_12 = arg_28_1:FormatText(StoryNameCfg[19].name)

				arg_28_1.leftNameTxt_.text = var_31_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_13 = arg_28_1:GetWordFromCfg(101021007)
				local var_31_14 = arg_28_1:FormatText(var_31_13.content)

				arg_28_1.text_.text = var_31_14

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 15
				local var_31_16 = utf8.len(var_31_14)
				local var_31_17 = var_31_15 <= 0 and var_31_11 or var_31_11 * (var_31_16 / var_31_15)

				if var_31_17 > 0 and var_31_11 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_14
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021007", "story_v_out_101021.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_101021", "101021007", "story_v_out_101021.awb") / 1000

					if var_31_18 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_10
					end

					if var_31_13.prefab_name ~= "" and arg_28_1.actors_[var_31_13.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_13.prefab_name].transform, "story_v_out_101021", "101021007", "story_v_out_101021.awb")

						arg_28_1:RecordAudio("101021007", var_31_19)
						arg_28_1:RecordAudio("101021007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101021", "101021007", "story_v_out_101021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101021", "101021007", "story_v_out_101021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_20 and arg_28_1.time_ < var_31_10 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101021008
		arg_32_1.duration_ = 6.5

		local var_32_0 = {
			ja = 4.7,
			ko = 6.5,
			zh = 5.5,
			en = 5.1
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
				arg_32_0:Play101021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3008ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["2020_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2020_tpose.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2020_tpose then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2020_tpose.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_35_11 = 0
			local var_35_12 = 0.6

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_13 = arg_32_1:FormatText(StoryNameCfg[20].name)

				arg_32_1.leftNameTxt_.text = var_35_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(101021008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 24
				local var_35_17 = utf8.len(var_35_15)
				local var_35_18 = var_35_16 <= 0 and var_35_12 or var_35_12 * (var_35_17 / var_35_16)

				if var_35_18 > 0 and var_35_12 < var_35_18 then
					arg_32_1.talkMaxDuration = var_35_18

					if var_35_18 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021008", "story_v_out_101021.awb") ~= 0 then
					local var_35_19 = manager.audio:GetVoiceLength("story_v_out_101021", "101021008", "story_v_out_101021.awb") / 1000

					if var_35_19 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_11
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_101021", "101021008", "story_v_out_101021.awb")

						arg_32_1:RecordAudio("101021008", var_35_20)
						arg_32_1:RecordAudio("101021008", var_35_20)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101021", "101021008", "story_v_out_101021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101021", "101021008", "story_v_out_101021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_21 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_21

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_21 and arg_32_1.time_ < var_35_11 + var_35_21 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101021009
		arg_36_1.duration_ = 8.5

		local var_36_0 = {
			ja = 8.5,
			ko = 6.6,
			zh = 6.266,
			en = 7.566
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play101021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["2020_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["3008ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.675

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[19].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(101021009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 27
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021009", "story_v_out_101021.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_101021", "101021009", "story_v_out_101021.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_101021", "101021009", "story_v_out_101021.awb")

						arg_36_1:RecordAudio("101021009", var_39_19)
						arg_36_1:RecordAudio("101021009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101021", "101021009", "story_v_out_101021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101021", "101021009", "story_v_out_101021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101021010
		arg_40_1.duration_ = 3.53

		local var_40_0 = {
			ja = 3.433,
			ko = 2.333,
			zh = 3.533,
			en = 2.4
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
				arg_40_0:Play101021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["3008ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect3008ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3008ui_story then
				arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["2020_tpose"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect2020_tpose == nil then
				arg_40_1.var_.characterEffect2020_tpose = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect2020_tpose and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect2020_tpose then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			local var_43_12 = 0
			local var_43_13 = 0.3

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[20].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(101021010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 12
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021010", "story_v_out_101021.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021010", "story_v_out_101021.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_101021", "101021010", "story_v_out_101021.awb")

						arg_40_1:RecordAudio("101021010", var_43_21)
						arg_40_1:RecordAudio("101021010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101021", "101021010", "story_v_out_101021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101021", "101021010", "story_v_out_101021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101021011
		arg_44_1.duration_ = 8.07

		local var_44_0 = {
			ja = 8.066,
			ko = 4.7,
			zh = 4.766,
			en = 5.366
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
				arg_44_0:Play101021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				local var_47_2 = "stop"
				local var_47_3 = "effect"

				arg_44_1:AudioAction(var_47_2, var_47_3, "se_story_1", "se_story_1_protest", "")
			end

			local var_47_4 = arg_44_1.actors_["3008ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect3008ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_44_1.var_.characterEffect3008ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect3008ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_44_1.var_.characterEffect3008ui_story.fillRatio = var_47_9
			end

			local var_47_10 = manager.ui.mainCamera.transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.shakeOldPosMainCamera = var_47_10.localPosition
			end

			local var_47_12 = 0.600000023841858

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / 0.066
				local var_47_14, var_47_15 = math.modf(var_47_13)

				var_47_10.localPosition = Vector3.New(var_47_15 * 0.13, var_47_15 * 0.13, var_47_15 * 0.13) + arg_44_1.var_.shakeOldPosMainCamera
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = arg_44_1.var_.shakeOldPosMainCamera
			end

			local var_47_16 = arg_44_1.actors_["2020_tpose"].transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_16.localPosition

				local var_47_18 = GameObjectTools.GetOrAddComponent(var_47_16.gameObject, typeof(DynamicBoneHelper))

				if var_47_18 then
					var_47_18:EnableDynamicBone(false)
				end
			end

			local var_47_19 = 0.001

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_17) / var_47_19
				local var_47_21 = Vector3.New(0, 100, 0)

				var_47_16.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, var_47_21, var_47_20)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_16.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_16.localEulerAngles = var_47_23
			end

			if arg_44_1.time_ >= var_47_17 + var_47_19 and arg_44_1.time_ < var_47_17 + var_47_19 + arg_47_0 then
				var_47_16.localPosition = Vector3.New(0, 100, 0)

				local var_47_24 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_24.x, var_47_24.y, var_47_24.z)

				local var_47_25 = var_47_16.localEulerAngles

				var_47_25.z = 0
				var_47_25.x = 0
				var_47_16.localEulerAngles = var_47_25

				local var_47_26 = GameObjectTools.GetOrAddComponent(var_47_16.gameObject, typeof(DynamicBoneHelper))

				if var_47_26 then
					var_47_26:EnableDynamicBone(true)
				end
			end

			local var_47_27 = arg_44_1.actors_["3008ui_story"].transform
			local var_47_28 = 0

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 then
				arg_44_1.var_.moveOldPos3008ui_story = var_47_27.localPosition
			end

			local var_47_29 = 0.001

			if var_47_28 <= arg_44_1.time_ and arg_44_1.time_ < var_47_28 + var_47_29 then
				local var_47_30 = (arg_44_1.time_ - var_47_28) / var_47_29
				local var_47_31 = Vector3.New(0, 100, 0)

				var_47_27.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3008ui_story, var_47_31, var_47_30)

				local var_47_32 = manager.ui.mainCamera.transform.position - var_47_27.position

				var_47_27.forward = Vector3.New(var_47_32.x, var_47_32.y, var_47_32.z)

				local var_47_33 = var_47_27.localEulerAngles

				var_47_33.z = 0
				var_47_33.x = 0
				var_47_27.localEulerAngles = var_47_33
			end

			if arg_44_1.time_ >= var_47_28 + var_47_29 and arg_44_1.time_ < var_47_28 + var_47_29 + arg_47_0 then
				var_47_27.localPosition = Vector3.New(0, 100, 0)

				local var_47_34 = manager.ui.mainCamera.transform.position - var_47_27.position

				var_47_27.forward = Vector3.New(var_47_34.x, var_47_34.y, var_47_34.z)

				local var_47_35 = var_47_27.localEulerAngles

				var_47_35.z = 0
				var_47_35.x = 0
				var_47_27.localEulerAngles = var_47_35
			end

			local var_47_36 = "1035ui_story"

			if arg_44_1.actors_[var_47_36] == nil then
				local var_47_37 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_47_37) then
					local var_47_38 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_44_1.stage_.transform)

					var_47_38.name = var_47_36
					var_47_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_36] = var_47_38

					local var_47_39 = var_47_38:GetComponentInChildren(typeof(CharacterEffect))

					var_47_39.enabled = true

					local var_47_40 = GameObjectTools.GetOrAddComponent(var_47_38, typeof(DynamicBoneHelper))

					if var_47_40 then
						var_47_40:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_39.transform, false)

					arg_44_1.var_[var_47_36 .. "Animator"] = var_47_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_36 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_36 .. "LipSync"] = var_47_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_41 = arg_44_1.actors_["1035ui_story"].transform
			local var_47_42 = 0

			if var_47_42 < arg_44_1.time_ and arg_44_1.time_ <= var_47_42 + arg_47_0 then
				arg_44_1.var_.moveOldPos1035ui_story = var_47_41.localPosition
			end

			local var_47_43 = 0.001

			if var_47_42 <= arg_44_1.time_ and arg_44_1.time_ < var_47_42 + var_47_43 then
				local var_47_44 = (arg_44_1.time_ - var_47_42) / var_47_43
				local var_47_45 = Vector3.New(0, -1.05, -5.6)

				var_47_41.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1035ui_story, var_47_45, var_47_44)

				local var_47_46 = manager.ui.mainCamera.transform.position - var_47_41.position

				var_47_41.forward = Vector3.New(var_47_46.x, var_47_46.y, var_47_46.z)

				local var_47_47 = var_47_41.localEulerAngles

				var_47_47.z = 0
				var_47_47.x = 0
				var_47_41.localEulerAngles = var_47_47
			end

			if arg_44_1.time_ >= var_47_42 + var_47_43 and arg_44_1.time_ < var_47_42 + var_47_43 + arg_47_0 then
				var_47_41.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_47_48 = manager.ui.mainCamera.transform.position - var_47_41.position

				var_47_41.forward = Vector3.New(var_47_48.x, var_47_48.y, var_47_48.z)

				local var_47_49 = var_47_41.localEulerAngles

				var_47_49.z = 0
				var_47_49.x = 0
				var_47_41.localEulerAngles = var_47_49
			end

			local var_47_50 = arg_44_1.actors_["1035ui_story"]
			local var_47_51 = 0

			if var_47_51 < arg_44_1.time_ and arg_44_1.time_ <= var_47_51 + arg_47_0 and not isNil(var_47_50) and arg_44_1.var_.characterEffect1035ui_story == nil then
				arg_44_1.var_.characterEffect1035ui_story = var_47_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_52 = 0.1

			if var_47_51 <= arg_44_1.time_ and arg_44_1.time_ < var_47_51 + var_47_52 and not isNil(var_47_50) then
				local var_47_53 = (arg_44_1.time_ - var_47_51) / var_47_52

				if arg_44_1.var_.characterEffect1035ui_story and not isNil(var_47_50) then
					arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_51 + var_47_52 and arg_44_1.time_ < var_47_51 + var_47_52 + arg_47_0 and not isNil(var_47_50) and arg_44_1.var_.characterEffect1035ui_story then
				arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_47_54 = 0

			if var_47_54 < arg_44_1.time_ and arg_44_1.time_ <= var_47_54 + arg_47_0 then
				arg_44_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			local var_47_55 = 0
			local var_47_56 = 0.5

			if var_47_55 < arg_44_1.time_ and arg_44_1.time_ <= var_47_55 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_57 = arg_44_1:FormatText(StoryNameCfg[21].name)

				arg_44_1.leftNameTxt_.text = var_47_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_58 = arg_44_1:GetWordFromCfg(101021011)
				local var_47_59 = arg_44_1:FormatText(var_47_58.content)

				arg_44_1.text_.text = var_47_59

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_60 = 20
				local var_47_61 = utf8.len(var_47_59)
				local var_47_62 = var_47_60 <= 0 and var_47_56 or var_47_56 * (var_47_61 / var_47_60)

				if var_47_62 > 0 and var_47_56 < var_47_62 then
					arg_44_1.talkMaxDuration = var_47_62

					if var_47_62 + var_47_55 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_62 + var_47_55
					end
				end

				arg_44_1.text_.text = var_47_59
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021011", "story_v_out_101021.awb") ~= 0 then
					local var_47_63 = manager.audio:GetVoiceLength("story_v_out_101021", "101021011", "story_v_out_101021.awb") / 1000

					if var_47_63 + var_47_55 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_63 + var_47_55
					end

					if var_47_58.prefab_name ~= "" and arg_44_1.actors_[var_47_58.prefab_name] ~= nil then
						local var_47_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_58.prefab_name].transform, "story_v_out_101021", "101021011", "story_v_out_101021.awb")

						arg_44_1:RecordAudio("101021011", var_47_64)
						arg_44_1:RecordAudio("101021011", var_47_64)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101021", "101021011", "story_v_out_101021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101021", "101021011", "story_v_out_101021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_65 = math.max(var_47_56, arg_44_1.talkMaxDuration)

			if var_47_55 <= arg_44_1.time_ and arg_44_1.time_ < var_47_55 + var_47_65 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_55) / var_47_65

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_55 + var_47_65 and arg_44_1.time_ < var_47_55 + var_47_65 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play101021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101021012
		arg_48_1.duration_ = 5.47

		local var_48_0 = {
			ja = 3.1,
			ko = 5.466,
			zh = 3.9,
			en = 3.7
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play101021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1035ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1035ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1035ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = 0
			local var_51_10 = 0.475

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_11 = arg_48_1:FormatText(StoryNameCfg[16].name)

				arg_48_1.leftNameTxt_.text = var_51_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_12 = arg_48_1:GetWordFromCfg(101021012)
				local var_51_13 = arg_48_1:FormatText(var_51_12.content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_14 = 17
				local var_51_15 = utf8.len(var_51_13)
				local var_51_16 = var_51_14 <= 0 and var_51_10 or var_51_10 * (var_51_15 / var_51_14)

				if var_51_16 > 0 and var_51_10 < var_51_16 then
					arg_48_1.talkMaxDuration = var_51_16

					if var_51_16 + var_51_9 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_9
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021012", "story_v_out_101021.awb") ~= 0 then
					local var_51_17 = manager.audio:GetVoiceLength("story_v_out_101021", "101021012", "story_v_out_101021.awb") / 1000

					if var_51_17 + var_51_9 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_9
					end

					if var_51_12.prefab_name ~= "" and arg_48_1.actors_[var_51_12.prefab_name] ~= nil then
						local var_51_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_12.prefab_name].transform, "story_v_out_101021", "101021012", "story_v_out_101021.awb")

						arg_48_1:RecordAudio("101021012", var_51_18)
						arg_48_1:RecordAudio("101021012", var_51_18)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101021", "101021012", "story_v_out_101021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101021", "101021012", "story_v_out_101021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_19 = math.max(var_51_10, arg_48_1.talkMaxDuration)

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_19 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_9) / var_51_19

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_9 + var_51_19 and arg_48_1.time_ < var_51_9 + var_51_19 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play101021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101021013
		arg_52_1.duration_ = 5.77

		local var_52_0 = {
			ja = 5.766,
			ko = 3.1,
			zh = 3.2,
			en = 4.733
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
				arg_52_0:Play101021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.35

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[17].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(101021013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 14
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021013", "story_v_out_101021.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021013", "story_v_out_101021.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_101021", "101021013", "story_v_out_101021.awb")

						arg_52_1:RecordAudio("101021013", var_55_9)
						arg_52_1:RecordAudio("101021013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101021", "101021013", "story_v_out_101021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101021", "101021013", "story_v_out_101021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play101021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101021014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play101021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.675

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_2 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_2:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(101021014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 27
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7
					var_59_0 = var_59_0 + 0.3

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = var_59_0 + 0.3
			local var_59_9 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_9 and arg_56_1.time_ < var_59_8 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101021015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 101021015
		arg_62_1.duration_ = 7.73

		local var_62_0 = {
			ja = 6.166,
			ko = 7.1,
			zh = 7,
			en = 7.733
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
				arg_62_0:Play101021016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["3008ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["3008ui_story"].transform
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_4.localPosition
			end

			local var_65_6 = 0.001

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6
				local var_65_8 = Vector3.New(-0.7, -1.51, -4.3)

				var_65_4.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, var_65_8, var_65_7)

				local var_65_9 = manager.ui.mainCamera.transform.position - var_65_4.position

				var_65_4.forward = Vector3.New(var_65_9.x, var_65_9.y, var_65_9.z)

				local var_65_10 = var_65_4.localEulerAngles

				var_65_10.z = 0
				var_65_10.x = 0
				var_65_4.localEulerAngles = var_65_10
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 then
				var_65_4.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_65_11 = manager.ui.mainCamera.transform.position - var_65_4.position

				var_65_4.forward = Vector3.New(var_65_11.x, var_65_11.y, var_65_11.z)

				local var_65_12 = var_65_4.localEulerAngles

				var_65_12.z = 0
				var_65_12.x = 0
				var_65_4.localEulerAngles = var_65_12
			end

			local var_65_13 = 0

			if var_65_13 < arg_62_1.time_ and arg_62_1.time_ <= var_65_13 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_65_14 = 0

			if var_65_14 < arg_62_1.time_ and arg_62_1.time_ <= var_65_14 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_65_15 = 0
			local var_65_16 = 0.85

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[22].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(101021015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 33
				local var_65_21 = utf8.len(var_65_19)
				local var_65_22 = var_65_20 <= 0 and var_65_16 or var_65_16 * (var_65_21 / var_65_20)

				if var_65_22 > 0 and var_65_16 < var_65_22 then
					arg_62_1.talkMaxDuration = var_65_22

					if var_65_22 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_15
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021015", "story_v_out_101021.awb") ~= 0 then
					local var_65_23 = manager.audio:GetVoiceLength("story_v_out_101021", "101021015", "story_v_out_101021.awb") / 1000

					if var_65_23 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_15
					end

					if var_65_18.prefab_name ~= "" and arg_62_1.actors_[var_65_18.prefab_name] ~= nil then
						local var_65_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_18.prefab_name].transform, "story_v_out_101021", "101021015", "story_v_out_101021.awb")

						arg_62_1:RecordAudio("101021015", var_65_24)
						arg_62_1:RecordAudio("101021015", var_65_24)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_101021", "101021015", "story_v_out_101021.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_101021", "101021015", "story_v_out_101021.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_25 = math.max(var_65_16, arg_62_1.talkMaxDuration)

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_25 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_15) / var_65_25

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_15 + var_65_25 and arg_62_1.time_ < var_65_15 + var_65_25 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play101021016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 101021016
		arg_66_1.duration_ = 4.93

		local var_66_0 = {
			ja = 4.933,
			ko = 4.8,
			zh = 4.5,
			en = 4.566
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
				arg_66_0:Play101021017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["3008ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect3008ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_5
			end

			local var_69_6 = arg_66_1.actors_["1035ui_story"].transform
			local var_69_7 = 0

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.var_.moveOldPos1035ui_story = var_69_6.localPosition
			end

			local var_69_8 = 0.001

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_8 then
				local var_69_9 = (arg_66_1.time_ - var_69_7) / var_69_8
				local var_69_10 = Vector3.New(0.7, -1.05, -5.6)

				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1035ui_story, var_69_10, var_69_9)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_6.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_6.localEulerAngles = var_69_12
			end

			if arg_66_1.time_ >= var_69_7 + var_69_8 and arg_66_1.time_ < var_69_7 + var_69_8 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0.7, -1.05, -5.6)

				local var_69_13 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_13.x, var_69_13.y, var_69_13.z)

				local var_69_14 = var_69_6.localEulerAngles

				var_69_14.z = 0
				var_69_14.x = 0
				var_69_6.localEulerAngles = var_69_14
			end

			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_1")
			end

			local var_69_16 = 0
			local var_69_17 = 0.475

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_18 = arg_66_1:FormatText(StoryNameCfg[21].name)

				arg_66_1.leftNameTxt_.text = var_69_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_19 = arg_66_1:GetWordFromCfg(101021016)
				local var_69_20 = arg_66_1:FormatText(var_69_19.content)

				arg_66_1.text_.text = var_69_20

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_21 = 19
				local var_69_22 = utf8.len(var_69_20)
				local var_69_23 = var_69_21 <= 0 and var_69_17 or var_69_17 * (var_69_22 / var_69_21)

				if var_69_23 > 0 and var_69_17 < var_69_23 then
					arg_66_1.talkMaxDuration = var_69_23

					if var_69_23 + var_69_16 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_16
					end
				end

				arg_66_1.text_.text = var_69_20
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021016", "story_v_out_101021.awb") ~= 0 then
					local var_69_24 = manager.audio:GetVoiceLength("story_v_out_101021", "101021016", "story_v_out_101021.awb") / 1000

					if var_69_24 + var_69_16 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_16
					end

					if var_69_19.prefab_name ~= "" and arg_66_1.actors_[var_69_19.prefab_name] ~= nil then
						local var_69_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_19.prefab_name].transform, "story_v_out_101021", "101021016", "story_v_out_101021.awb")

						arg_66_1:RecordAudio("101021016", var_69_25)
						arg_66_1:RecordAudio("101021016", var_69_25)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_101021", "101021016", "story_v_out_101021.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_101021", "101021016", "story_v_out_101021.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_26 = math.max(var_69_17, arg_66_1.talkMaxDuration)

			if var_69_16 <= arg_66_1.time_ and arg_66_1.time_ < var_69_16 + var_69_26 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_16) / var_69_26

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_16 + var_69_26 and arg_66_1.time_ < var_69_16 + var_69_26 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play101021017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 101021017
		arg_70_1.duration_ = 3.07

		local var_70_0 = {
			ja = 3,
			ko = 2.6,
			zh = 3.066,
			en = 1.999999999999
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play101021018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["3008ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect3008ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1035ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1035ui_story == nil then
				arg_70_1.var_.characterEffect1035ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.100000001490116

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1035ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1035ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1035ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1035ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_73_11 = 0
			local var_73_12 = 0.25

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_13 = arg_70_1:FormatText(StoryNameCfg[22].name)

				arg_70_1.leftNameTxt_.text = var_73_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(101021017)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_16 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021017", "story_v_out_101021.awb") ~= 0 then
					local var_73_19 = manager.audio:GetVoiceLength("story_v_out_101021", "101021017", "story_v_out_101021.awb") / 1000

					if var_73_19 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_11
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_101021", "101021017", "story_v_out_101021.awb")

						arg_70_1:RecordAudio("101021017", var_73_20)
						arg_70_1:RecordAudio("101021017", var_73_20)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_101021", "101021017", "story_v_out_101021.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_101021", "101021017", "story_v_out_101021.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_21 = math.max(var_73_12, arg_70_1.talkMaxDuration)

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_21 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_11) / var_73_21

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_11 + var_73_21 and arg_70_1.time_ < var_73_11 + var_73_21 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play101021018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 101021018
		arg_74_1.duration_ = 7.7

		local var_74_0 = {
			ja = 7.7,
			ko = 2.533,
			zh = 4.066,
			en = 5.233
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
				arg_74_0:Play101021019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_1 = 0
			local var_77_2 = 0.525

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_3 = arg_74_1:FormatText(StoryNameCfg[22].name)

				arg_74_1.leftNameTxt_.text = var_77_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(101021018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 21
				local var_77_7 = utf8.len(var_77_5)
				local var_77_8 = var_77_6 <= 0 and var_77_2 or var_77_2 * (var_77_7 / var_77_6)

				if var_77_8 > 0 and var_77_2 < var_77_8 then
					arg_74_1.talkMaxDuration = var_77_8

					if var_77_8 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021018", "story_v_out_101021.awb") ~= 0 then
					local var_77_9 = manager.audio:GetVoiceLength("story_v_out_101021", "101021018", "story_v_out_101021.awb") / 1000

					if var_77_9 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_1
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_101021", "101021018", "story_v_out_101021.awb")

						arg_74_1:RecordAudio("101021018", var_77_10)
						arg_74_1:RecordAudio("101021018", var_77_10)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_101021", "101021018", "story_v_out_101021.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_101021", "101021018", "story_v_out_101021.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_11 and arg_74_1.time_ < var_77_1 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play101021019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 101021019
		arg_78_1.duration_ = 6.97

		local var_78_0 = {
			ja = 6.966,
			ko = 2.466,
			zh = 5.066,
			en = 5
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
				arg_78_0:Play101021020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["3008ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect3008ui_story == nil then
				arg_78_1.var_.characterEffect3008ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect3008ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_78_1.var_.characterEffect3008ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect3008ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_78_1.var_.characterEffect3008ui_story.fillRatio = var_81_5
			end

			local var_81_6 = arg_78_1.actors_["1035ui_story"]
			local var_81_7 = 0

			if var_81_7 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1035ui_story == nil then
				arg_78_1.var_.characterEffect1035ui_story = var_81_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_8 = 0.1

			if var_81_7 <= arg_78_1.time_ and arg_78_1.time_ < var_81_7 + var_81_8 and not isNil(var_81_6) then
				local var_81_9 = (arg_78_1.time_ - var_81_7) / var_81_8

				if arg_78_1.var_.characterEffect1035ui_story and not isNil(var_81_6) then
					arg_78_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_7 + var_81_8 and arg_78_1.time_ < var_81_7 + var_81_8 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1035ui_story then
				arg_78_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_2")
			end

			local var_81_11 = 0
			local var_81_12 = 0.65

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_13 = arg_78_1:FormatText(StoryNameCfg[21].name)

				arg_78_1.leftNameTxt_.text = var_81_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_14 = arg_78_1:GetWordFromCfg(101021019)
				local var_81_15 = arg_78_1:FormatText(var_81_14.content)

				arg_78_1.text_.text = var_81_15

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_16 = 26
				local var_81_17 = utf8.len(var_81_15)
				local var_81_18 = var_81_16 <= 0 and var_81_12 or var_81_12 * (var_81_17 / var_81_16)

				if var_81_18 > 0 and var_81_12 < var_81_18 then
					arg_78_1.talkMaxDuration = var_81_18

					if var_81_18 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_15
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021019", "story_v_out_101021.awb") ~= 0 then
					local var_81_19 = manager.audio:GetVoiceLength("story_v_out_101021", "101021019", "story_v_out_101021.awb") / 1000

					if var_81_19 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_11
					end

					if var_81_14.prefab_name ~= "" and arg_78_1.actors_[var_81_14.prefab_name] ~= nil then
						local var_81_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_14.prefab_name].transform, "story_v_out_101021", "101021019", "story_v_out_101021.awb")

						arg_78_1:RecordAudio("101021019", var_81_20)
						arg_78_1:RecordAudio("101021019", var_81_20)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_101021", "101021019", "story_v_out_101021.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_101021", "101021019", "story_v_out_101021.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_21 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_21 and arg_78_1.time_ < var_81_11 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play101021020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 101021020
		arg_82_1.duration_ = 8.6

		local var_82_0 = {
			ja = 8.6,
			ko = 6.133,
			zh = 4.1,
			en = 4.533
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play101021021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["3008ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect3008ui_story == nil then
				arg_82_1.var_.characterEffect3008ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect3008ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect3008ui_story then
				arg_82_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1035ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1035ui_story == nil then
				arg_82_1.var_.characterEffect1035ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.1

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect1035ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1035ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1035ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1035ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_85_11 = 0

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_85_12 = 0
			local var_85_13 = 0.475

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_14 = arg_82_1:FormatText(StoryNameCfg[22].name)

				arg_82_1.leftNameTxt_.text = var_85_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_15 = arg_82_1:GetWordFromCfg(101021020)
				local var_85_16 = arg_82_1:FormatText(var_85_15.content)

				arg_82_1.text_.text = var_85_16

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_17 = 19
				local var_85_18 = utf8.len(var_85_16)
				local var_85_19 = var_85_17 <= 0 and var_85_13 or var_85_13 * (var_85_18 / var_85_17)

				if var_85_19 > 0 and var_85_13 < var_85_19 then
					arg_82_1.talkMaxDuration = var_85_19

					if var_85_19 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_12
					end
				end

				arg_82_1.text_.text = var_85_16
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021020", "story_v_out_101021.awb") ~= 0 then
					local var_85_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021020", "story_v_out_101021.awb") / 1000

					if var_85_20 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_20 + var_85_12
					end

					if var_85_15.prefab_name ~= "" and arg_82_1.actors_[var_85_15.prefab_name] ~= nil then
						local var_85_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_15.prefab_name].transform, "story_v_out_101021", "101021020", "story_v_out_101021.awb")

						arg_82_1:RecordAudio("101021020", var_85_21)
						arg_82_1:RecordAudio("101021020", var_85_21)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_101021", "101021020", "story_v_out_101021.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_101021", "101021020", "story_v_out_101021.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = math.max(var_85_13, arg_82_1.talkMaxDuration)

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_22 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_12) / var_85_22

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_12 + var_85_22 and arg_82_1.time_ < var_85_12 + var_85_22 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play101021021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 101021021
		arg_86_1.duration_ = 9

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play101021022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_1 = 2

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_1 then
				local var_89_2 = (arg_86_1.time_ - var_89_0) / var_89_1
				local var_89_3 = Color.New(0, 0, 0)

				var_89_3.a = Mathf.Lerp(0, 1, var_89_2)
				arg_86_1.mask_.color = var_89_3
			end

			if arg_86_1.time_ >= var_89_0 + var_89_1 and arg_86_1.time_ < var_89_0 + var_89_1 + arg_89_0 then
				local var_89_4 = Color.New(0, 0, 0)

				var_89_4.a = 1
				arg_86_1.mask_.color = var_89_4
			end

			local var_89_5 = 2

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_6 = 2

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6
				local var_89_8 = Color.New(0, 0, 0)

				var_89_8.a = Mathf.Lerp(1, 0, var_89_7)
				arg_86_1.mask_.color = var_89_8
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 then
				local var_89_9 = Color.New(0, 0, 0)
				local var_89_10 = 0

				arg_86_1.mask_.enabled = false
				var_89_9.a = var_89_10
				arg_86_1.mask_.color = var_89_9
			end

			local var_89_11 = "B10f"

			if arg_86_1.bgs_[var_89_11] == nil then
				local var_89_12 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_11)
				var_89_12.name = var_89_11
				var_89_12.transform.parent = arg_86_1.stage_.transform
				var_89_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_11] = var_89_12
			end

			local var_89_13 = 2

			if var_89_13 < arg_86_1.time_ and arg_86_1.time_ <= var_89_13 + arg_89_0 then
				local var_89_14 = manager.ui.mainCamera.transform.localPosition
				local var_89_15 = Vector3.New(0, 0, 10) + Vector3.New(var_89_14.x, var_89_14.y, 0)
				local var_89_16 = arg_86_1.bgs_.B10f

				var_89_16.transform.localPosition = var_89_15
				var_89_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_17 = var_89_16:GetComponent("SpriteRenderer")

				if var_89_17 and var_89_17.sprite then
					local var_89_18 = (var_89_16.transform.localPosition - var_89_14).z
					local var_89_19 = manager.ui.mainCameraCom_
					local var_89_20 = 2 * var_89_18 * Mathf.Tan(var_89_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_21 = var_89_20 * var_89_19.aspect
					local var_89_22 = var_89_17.sprite.bounds.size.x
					local var_89_23 = var_89_17.sprite.bounds.size.y
					local var_89_24 = var_89_21 / var_89_22
					local var_89_25 = var_89_20 / var_89_23
					local var_89_26 = var_89_25 < var_89_24 and var_89_24 or var_89_25

					var_89_16.transform.localScale = Vector3.New(var_89_26, var_89_26, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "B10f" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_27 = arg_86_1.actors_["3008ui_story"].transform
			local var_89_28 = 1.967

			if var_89_28 < arg_86_1.time_ and arg_86_1.time_ <= var_89_28 + arg_89_0 then
				arg_86_1.var_.moveOldPos3008ui_story = var_89_27.localPosition
			end

			local var_89_29 = 0.001

			if var_89_28 <= arg_86_1.time_ and arg_86_1.time_ < var_89_28 + var_89_29 then
				local var_89_30 = (arg_86_1.time_ - var_89_28) / var_89_29
				local var_89_31 = Vector3.New(0, 100, 0)

				var_89_27.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos3008ui_story, var_89_31, var_89_30)

				local var_89_32 = manager.ui.mainCamera.transform.position - var_89_27.position

				var_89_27.forward = Vector3.New(var_89_32.x, var_89_32.y, var_89_32.z)

				local var_89_33 = var_89_27.localEulerAngles

				var_89_33.z = 0
				var_89_33.x = 0
				var_89_27.localEulerAngles = var_89_33
			end

			if arg_86_1.time_ >= var_89_28 + var_89_29 and arg_86_1.time_ < var_89_28 + var_89_29 + arg_89_0 then
				var_89_27.localPosition = Vector3.New(0, 100, 0)

				local var_89_34 = manager.ui.mainCamera.transform.position - var_89_27.position

				var_89_27.forward = Vector3.New(var_89_34.x, var_89_34.y, var_89_34.z)

				local var_89_35 = var_89_27.localEulerAngles

				var_89_35.z = 0
				var_89_35.x = 0
				var_89_27.localEulerAngles = var_89_35
			end

			local var_89_36 = arg_86_1.actors_["1035ui_story"].transform
			local var_89_37 = 1.967

			if var_89_37 < arg_86_1.time_ and arg_86_1.time_ <= var_89_37 + arg_89_0 then
				arg_86_1.var_.moveOldPos1035ui_story = var_89_36.localPosition
			end

			local var_89_38 = 0.001

			if var_89_37 <= arg_86_1.time_ and arg_86_1.time_ < var_89_37 + var_89_38 then
				local var_89_39 = (arg_86_1.time_ - var_89_37) / var_89_38
				local var_89_40 = Vector3.New(0, 100, 0)

				var_89_36.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1035ui_story, var_89_40, var_89_39)

				local var_89_41 = manager.ui.mainCamera.transform.position - var_89_36.position

				var_89_36.forward = Vector3.New(var_89_41.x, var_89_41.y, var_89_41.z)

				local var_89_42 = var_89_36.localEulerAngles

				var_89_42.z = 0
				var_89_42.x = 0
				var_89_36.localEulerAngles = var_89_42
			end

			if arg_86_1.time_ >= var_89_37 + var_89_38 and arg_86_1.time_ < var_89_37 + var_89_38 + arg_89_0 then
				var_89_36.localPosition = Vector3.New(0, 100, 0)

				local var_89_43 = manager.ui.mainCamera.transform.position - var_89_36.position

				var_89_36.forward = Vector3.New(var_89_43.x, var_89_43.y, var_89_43.z)

				local var_89_44 = var_89_36.localEulerAngles

				var_89_44.z = 0
				var_89_44.x = 0
				var_89_36.localEulerAngles = var_89_44
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_45 = 4
			local var_89_46 = 0.625

			if var_89_45 < arg_86_1.time_ and arg_86_1.time_ <= var_89_45 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_47 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_47:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_48 = arg_86_1:GetWordFromCfg(101021021)
				local var_89_49 = arg_86_1:FormatText(var_89_48.content)

				arg_86_1.text_.text = var_89_49

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_50 = 24
				local var_89_51 = utf8.len(var_89_49)
				local var_89_52 = var_89_50 <= 0 and var_89_46 or var_89_46 * (var_89_51 / var_89_50)

				if var_89_52 > 0 and var_89_46 < var_89_52 then
					arg_86_1.talkMaxDuration = var_89_52
					var_89_45 = var_89_45 + 0.3

					if var_89_52 + var_89_45 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_52 + var_89_45
					end
				end

				arg_86_1.text_.text = var_89_49
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_53 = var_89_45 + 0.3
			local var_89_54 = math.max(var_89_46, arg_86_1.talkMaxDuration)

			if var_89_53 <= arg_86_1.time_ and arg_86_1.time_ < var_89_53 + var_89_54 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_53) / var_89_54

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_53 + var_89_54 and arg_86_1.time_ < var_89_53 + var_89_54 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play101021022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101021022
		arg_92_1.duration_ = 12.8

		local var_92_0 = {
			ja = 12.8,
			ko = 6.866,
			zh = 6.5,
			en = 8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play101021023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "10001_tpose"

			if arg_92_1.actors_[var_95_0] == nil then
				local var_95_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_95_1) then
					local var_95_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_92_1.stage_.transform)

					var_95_2.name = var_95_0
					var_95_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_92_1.actors_[var_95_0] = var_95_2

					local var_95_3 = var_95_2:GetComponentInChildren(typeof(CharacterEffect))

					var_95_3.enabled = true

					local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_2, typeof(DynamicBoneHelper))

					if var_95_4 then
						var_95_4:EnableDynamicBone(false)
					end

					arg_92_1:ShowWeapon(var_95_3.transform, false)

					arg_92_1.var_[var_95_0 .. "Animator"] = var_95_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_92_1.var_[var_95_0 .. "Animator"].applyRootMotion = true
					arg_92_1.var_[var_95_0 .. "LipSync"] = var_95_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_95_5 = arg_92_1.actors_["10001_tpose"].transform
			local var_95_6 = 0

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.var_.moveOldPos10001_tpose = var_95_5.localPosition

				local var_95_7 = GameObjectTools.GetOrAddComponent(var_95_5.gameObject, typeof(DynamicBoneHelper))

				if var_95_7 then
					var_95_7:EnableDynamicBone(false)
				end
			end

			local var_95_8 = 0.001

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_8 then
				local var_95_9 = (arg_92_1.time_ - var_95_6) / var_95_8
				local var_95_10 = Vector3.New(0, -1.23, -5.8)

				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10001_tpose, var_95_10, var_95_9)

				local var_95_11 = manager.ui.mainCamera.transform.position - var_95_5.position

				var_95_5.forward = Vector3.New(var_95_11.x, var_95_11.y, var_95_11.z)

				local var_95_12 = var_95_5.localEulerAngles

				var_95_12.z = 0
				var_95_12.x = 0
				var_95_5.localEulerAngles = var_95_12
			end

			if arg_92_1.time_ >= var_95_6 + var_95_8 and arg_92_1.time_ < var_95_6 + var_95_8 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_95_13 = manager.ui.mainCamera.transform.position - var_95_5.position

				var_95_5.forward = Vector3.New(var_95_13.x, var_95_13.y, var_95_13.z)

				local var_95_14 = var_95_5.localEulerAngles

				var_95_14.z = 0
				var_95_14.x = 0
				var_95_5.localEulerAngles = var_95_14

				local var_95_15 = GameObjectTools.GetOrAddComponent(var_95_5.gameObject, typeof(DynamicBoneHelper))

				if var_95_15 then
					var_95_15:EnableDynamicBone(true)
				end
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			local var_95_17 = 0
			local var_95_18 = 1.05

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_19 = arg_92_1:FormatText(StoryNameCfg[23].name)

				arg_92_1.leftNameTxt_.text = var_95_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_20 = arg_92_1:GetWordFromCfg(101021022)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 42
				local var_95_23 = utf8.len(var_95_21)
				local var_95_24 = var_95_22 <= 0 and var_95_18 or var_95_18 * (var_95_23 / var_95_22)

				if var_95_24 > 0 and var_95_18 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24

					if var_95_24 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_17
					end
				end

				arg_92_1.text_.text = var_95_21
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021022", "story_v_out_101021.awb") ~= 0 then
					local var_95_25 = manager.audio:GetVoiceLength("story_v_out_101021", "101021022", "story_v_out_101021.awb") / 1000

					if var_95_25 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_17
					end

					if var_95_20.prefab_name ~= "" and arg_92_1.actors_[var_95_20.prefab_name] ~= nil then
						local var_95_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_20.prefab_name].transform, "story_v_out_101021", "101021022", "story_v_out_101021.awb")

						arg_92_1:RecordAudio("101021022", var_95_26)
						arg_92_1:RecordAudio("101021022", var_95_26)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101021", "101021022", "story_v_out_101021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101021", "101021022", "story_v_out_101021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_27 = math.max(var_95_18, arg_92_1.talkMaxDuration)

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_27 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_17) / var_95_27

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_17 + var_95_27 and arg_92_1.time_ < var_95_17 + var_95_27 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play101021023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101021023
		arg_96_1.duration_ = 6.9

		local var_96_0 = {
			ja = 4.266,
			ko = 3.3,
			zh = 3.866,
			en = 6.9
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play101021024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10001_tpose"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10001_tpose == nil then
				arg_96_1.var_.characterEffect10001_tpose = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10001_tpose and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10001_tpose then
				arg_96_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_6 = 0
			local var_99_7 = 0.425

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[24].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(101021023)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 17
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021023", "story_v_out_101021.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021023", "story_v_out_101021.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_101021", "101021023", "story_v_out_101021.awb")

						arg_96_1:RecordAudio("101021023", var_99_15)
						arg_96_1:RecordAudio("101021023", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101021", "101021023", "story_v_out_101021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101021", "101021023", "story_v_out_101021.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101021024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101021024
		arg_100_1.duration_ = 11.9

		local var_100_0 = {
			ja = 11.9,
			ko = 9.9,
			zh = 9.6,
			en = 11.666
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play101021025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10001_tpose"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10001_tpose == nil then
				arg_100_1.var_.characterEffect10001_tpose = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect10001_tpose and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_100_1.var_.characterEffect10001_tpose.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10001_tpose then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_100_1.var_.characterEffect10001_tpose.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 1.425

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[25].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(101021024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 57
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021024", "story_v_out_101021.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021024", "story_v_out_101021.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_101021", "101021024", "story_v_out_101021.awb")

						arg_100_1:RecordAudio("101021024", var_103_15)
						arg_100_1:RecordAudio("101021024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101021", "101021024", "story_v_out_101021.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101021", "101021024", "story_v_out_101021.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play101021025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101021025
		arg_104_1.duration_ = 3.67

		local var_104_0 = {
			ja = 3.666,
			ko = 2,
			zh = 1.999999999998,
			en = 2.433
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play101021026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10001_tpose"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10001_tpose == nil then
				arg_104_1.var_.characterEffect10001_tpose = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10001_tpose and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10001_tpose then
				arg_104_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action424")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_6 = 0
			local var_107_7 = 0.125

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[24].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(101021025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 5
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021025", "story_v_out_101021.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021025", "story_v_out_101021.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_101021", "101021025", "story_v_out_101021.awb")

						arg_104_1:RecordAudio("101021025", var_107_15)
						arg_104_1:RecordAudio("101021025", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101021", "101021025", "story_v_out_101021.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101021", "101021025", "story_v_out_101021.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101021026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101021026
		arg_108_1.duration_ = 9.97

		local var_108_0 = {
			ja = 9.966,
			ko = 4.5,
			zh = 6.3,
			en = 9.233
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play101021027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10001_tpose"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10001_tpose == nil then
				arg_108_1.var_.characterEffect10001_tpose = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect10001_tpose and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_108_1.var_.characterEffect10001_tpose.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10001_tpose then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_108_1.var_.characterEffect10001_tpose.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.975

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[26].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(101021026)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 40
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021026", "story_v_out_101021.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021026", "story_v_out_101021.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_101021", "101021026", "story_v_out_101021.awb")

						arg_108_1:RecordAudio("101021026", var_111_15)
						arg_108_1:RecordAudio("101021026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101021", "101021026", "story_v_out_101021.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101021", "101021026", "story_v_out_101021.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101021027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101021027
		arg_112_1.duration_ = 16.83

		local var_112_0 = {
			ja = 14.7,
			ko = 12.1,
			zh = 12.333,
			en = 16.833
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play101021028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10001_tpose"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10001_tpose == nil then
				arg_112_1.var_.characterEffect10001_tpose = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10001_tpose and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10001_tpose then
				arg_112_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_2")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_115_6 = 0
			local var_115_7 = 1.525

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[24].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(101021027)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 61
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021027", "story_v_out_101021.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021027", "story_v_out_101021.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_101021", "101021027", "story_v_out_101021.awb")

						arg_112_1:RecordAudio("101021027", var_115_15)
						arg_112_1:RecordAudio("101021027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101021", "101021027", "story_v_out_101021.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101021", "101021027", "story_v_out_101021.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play101021028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101021028
		arg_116_1.duration_ = 6.87

		local var_116_0 = {
			ja = 6.866,
			ko = 4.033,
			zh = 4.533,
			en = 6.466
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play101021029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10001_tpose"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10001_tpose == nil then
				arg_116_1.var_.characterEffect10001_tpose = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10001_tpose and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_116_1.var_.characterEffect10001_tpose.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10001_tpose then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_116_1.var_.characterEffect10001_tpose.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.625

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[27].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(101021028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 25
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021028", "story_v_out_101021.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021028", "story_v_out_101021.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_101021", "101021028", "story_v_out_101021.awb")

						arg_116_1:RecordAudio("101021028", var_119_15)
						arg_116_1:RecordAudio("101021028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101021", "101021028", "story_v_out_101021.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101021", "101021028", "story_v_out_101021.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play101021029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101021029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101021030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				local var_123_2 = "play"
				local var_123_3 = "effect"

				arg_120_1:AudioAction(var_123_2, var_123_3, "se_story_ui", "se_story_env_highcut_open", "")
			end

			local var_123_4 = arg_120_1.actors_["10001_tpose"].transform
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.var_.moveOldPos10001_tpose = var_123_4.localPosition

				local var_123_6 = GameObjectTools.GetOrAddComponent(var_123_4.gameObject, typeof(DynamicBoneHelper))

				if var_123_6 then
					var_123_6:EnableDynamicBone(false)
				end
			end

			local var_123_7 = 0.001

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_7 then
				local var_123_8 = (arg_120_1.time_ - var_123_5) / var_123_7
				local var_123_9 = Vector3.New(0, 100, 0)

				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10001_tpose, var_123_9, var_123_8)

				local var_123_10 = manager.ui.mainCamera.transform.position - var_123_4.position

				var_123_4.forward = Vector3.New(var_123_10.x, var_123_10.y, var_123_10.z)

				local var_123_11 = var_123_4.localEulerAngles

				var_123_11.z = 0
				var_123_11.x = 0
				var_123_4.localEulerAngles = var_123_11
			end

			if arg_120_1.time_ >= var_123_5 + var_123_7 and arg_120_1.time_ < var_123_5 + var_123_7 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(0, 100, 0)

				local var_123_12 = manager.ui.mainCamera.transform.position - var_123_4.position

				var_123_4.forward = Vector3.New(var_123_12.x, var_123_12.y, var_123_12.z)

				local var_123_13 = var_123_4.localEulerAngles

				var_123_13.z = 0
				var_123_13.x = 0
				var_123_4.localEulerAngles = var_123_13

				local var_123_14 = GameObjectTools.GetOrAddComponent(var_123_4.gameObject, typeof(DynamicBoneHelper))

				if var_123_14 then
					var_123_14:EnableDynamicBone(true)
				end
			end

			local var_123_15 = 0
			local var_123_16 = 1.3

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_17 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_17:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(101021029)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 52
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22
					var_123_15 = var_123_15 + 0.3

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_23 = var_123_15 + 0.3
			local var_123_24 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_24 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_23) / var_123_24

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_23 + var_123_24 and arg_120_1.time_ < var_123_23 + var_123_24 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play101021030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 101021030
		arg_126_1.duration_ = 15.7

		local var_126_0 = {
			ja = 15.7,
			ko = 10.533,
			zh = 8.9,
			en = 10.666
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
				arg_126_0:Play101021031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "1148ui_story"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_126_1.stage_.transform)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

					var_129_3.enabled = true

					local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

					if var_129_4 then
						var_129_4:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_3.transform, false)

					arg_126_1.var_[var_129_0 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_0 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_0 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_5 = arg_126_1.actors_["1148ui_story"]
			local var_129_6 = 0

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1148ui_story == nil then
				arg_126_1.var_.characterEffect1148ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_7 = 0.1

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_7 and not isNil(var_129_5) then
				local var_129_8 = (arg_126_1.time_ - var_129_6) / var_129_7

				if arg_126_1.var_.characterEffect1148ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_6 + var_129_7 and arg_126_1.time_ < var_129_6 + var_129_7 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1148ui_story then
				arg_126_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_129_9 = arg_126_1.actors_["1148ui_story"].transform
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1.var_.moveOldPos1148ui_story = var_129_9.localPosition
			end

			local var_129_11 = 0.001

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11
				local var_129_13 = Vector3.New(-0.7, -0.8, -6.2)

				var_129_9.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1148ui_story, var_129_13, var_129_12)

				local var_129_14 = manager.ui.mainCamera.transform.position - var_129_9.position

				var_129_9.forward = Vector3.New(var_129_14.x, var_129_14.y, var_129_14.z)

				local var_129_15 = var_129_9.localEulerAngles

				var_129_15.z = 0
				var_129_15.x = 0
				var_129_9.localEulerAngles = var_129_15
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 then
				var_129_9.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_129_16 = manager.ui.mainCamera.transform.position - var_129_9.position

				var_129_9.forward = Vector3.New(var_129_16.x, var_129_16.y, var_129_16.z)

				local var_129_17 = var_129_9.localEulerAngles

				var_129_17.z = 0
				var_129_17.x = 0
				var_129_9.localEulerAngles = var_129_17
			end

			local var_129_18 = 0

			if var_129_18 < arg_126_1.time_ and arg_126_1.time_ <= var_129_18 + arg_129_0 then
				arg_126_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_20 = 0
			local var_129_21 = 1.175

			if var_129_20 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_22 = arg_126_1:FormatText(StoryNameCfg[8].name)

				arg_126_1.leftNameTxt_.text = var_129_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_23 = arg_126_1:GetWordFromCfg(101021030)
				local var_129_24 = arg_126_1:FormatText(var_129_23.content)

				arg_126_1.text_.text = var_129_24

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_25 = 47
				local var_129_26 = utf8.len(var_129_24)
				local var_129_27 = var_129_25 <= 0 and var_129_21 or var_129_21 * (var_129_26 / var_129_25)

				if var_129_27 > 0 and var_129_21 < var_129_27 then
					arg_126_1.talkMaxDuration = var_129_27

					if var_129_27 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_20
					end
				end

				arg_126_1.text_.text = var_129_24
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021030", "story_v_out_101021.awb") ~= 0 then
					local var_129_28 = manager.audio:GetVoiceLength("story_v_out_101021", "101021030", "story_v_out_101021.awb") / 1000

					if var_129_28 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_28 + var_129_20
					end

					if var_129_23.prefab_name ~= "" and arg_126_1.actors_[var_129_23.prefab_name] ~= nil then
						local var_129_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_23.prefab_name].transform, "story_v_out_101021", "101021030", "story_v_out_101021.awb")

						arg_126_1:RecordAudio("101021030", var_129_29)
						arg_126_1:RecordAudio("101021030", var_129_29)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_101021", "101021030", "story_v_out_101021.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_101021", "101021030", "story_v_out_101021.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_30 = math.max(var_129_21, arg_126_1.talkMaxDuration)

			if var_129_20 <= arg_126_1.time_ and arg_126_1.time_ < var_129_20 + var_129_30 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_20) / var_129_30

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_20 + var_129_30 and arg_126_1.time_ < var_129_20 + var_129_30 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play101021031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 101021031
		arg_130_1.duration_ = 9.17

		local var_130_0 = {
			ja = 9.166,
			ko = 5.8,
			zh = 7.433,
			en = 6.3
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play101021032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "1059ui_story"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_130_1.stage_.transform)

					var_133_2.name = var_133_0
					var_133_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_130_1.actors_[var_133_0] = var_133_2

					local var_133_3 = var_133_2:GetComponentInChildren(typeof(CharacterEffect))

					var_133_3.enabled = true

					local var_133_4 = GameObjectTools.GetOrAddComponent(var_133_2, typeof(DynamicBoneHelper))

					if var_133_4 then
						var_133_4:EnableDynamicBone(false)
					end

					arg_130_1:ShowWeapon(var_133_3.transform, false)

					arg_130_1.var_[var_133_0 .. "Animator"] = var_133_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_130_1.var_[var_133_0 .. "Animator"].applyRootMotion = true
					arg_130_1.var_[var_133_0 .. "LipSync"] = var_133_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_133_5 = arg_130_1.actors_["1059ui_story"]
			local var_133_6 = 0

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = var_133_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.1

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 and not isNil(var_133_5) then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7

				if arg_130_1.var_.characterEffect1059ui_story and not isNil(var_133_5) then
					arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1059ui_story then
				arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_133_9 = arg_130_1.actors_["1148ui_story"]
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1148ui_story == nil then
				arg_130_1.var_.characterEffect1148ui_story = var_133_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_11 = 0.1

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 and not isNil(var_133_9) then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11

				if arg_130_1.var_.characterEffect1148ui_story and not isNil(var_133_9) then
					local var_133_13 = Mathf.Lerp(0, 0.5, var_133_12)

					arg_130_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1148ui_story.fillRatio = var_133_13
				end
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1148ui_story then
				local var_133_14 = 0.5

				arg_130_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1148ui_story.fillRatio = var_133_14
			end

			local var_133_15 = arg_130_1.actors_["1059ui_story"].transform
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.var_.moveOldPos1059ui_story = var_133_15.localPosition
			end

			local var_133_17 = 0.001

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Vector3.New(0.7, -1.05, -6)

				var_133_15.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1059ui_story, var_133_19, var_133_18)

				local var_133_20 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_20.x, var_133_20.y, var_133_20.z)

				local var_133_21 = var_133_15.localEulerAngles

				var_133_21.z = 0
				var_133_21.x = 0
				var_133_15.localEulerAngles = var_133_21
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				var_133_15.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_133_22 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_22.x, var_133_22.y, var_133_22.z)

				local var_133_23 = var_133_15.localEulerAngles

				var_133_23.z = 0
				var_133_23.x = 0
				var_133_15.localEulerAngles = var_133_23
			end

			local var_133_24 = 0

			if var_133_24 < arg_130_1.time_ and arg_130_1.time_ <= var_133_24 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_133_25 = 0

			if var_133_25 < arg_130_1.time_ and arg_130_1.time_ <= var_133_25 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_133_26 = 0
			local var_133_27 = 0.675

			if var_133_26 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_28 = arg_130_1:FormatText(StoryNameCfg[28].name)

				arg_130_1.leftNameTxt_.text = var_133_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_29 = arg_130_1:GetWordFromCfg(101021031)
				local var_133_30 = arg_130_1:FormatText(var_133_29.content)

				arg_130_1.text_.text = var_133_30

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_31 = 27
				local var_133_32 = utf8.len(var_133_30)
				local var_133_33 = var_133_31 <= 0 and var_133_27 or var_133_27 * (var_133_32 / var_133_31)

				if var_133_33 > 0 and var_133_27 < var_133_33 then
					arg_130_1.talkMaxDuration = var_133_33

					if var_133_33 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_33 + var_133_26
					end
				end

				arg_130_1.text_.text = var_133_30
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021031", "story_v_out_101021.awb") ~= 0 then
					local var_133_34 = manager.audio:GetVoiceLength("story_v_out_101021", "101021031", "story_v_out_101021.awb") / 1000

					if var_133_34 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_34 + var_133_26
					end

					if var_133_29.prefab_name ~= "" and arg_130_1.actors_[var_133_29.prefab_name] ~= nil then
						local var_133_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_29.prefab_name].transform, "story_v_out_101021", "101021031", "story_v_out_101021.awb")

						arg_130_1:RecordAudio("101021031", var_133_35)
						arg_130_1:RecordAudio("101021031", var_133_35)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_101021", "101021031", "story_v_out_101021.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_101021", "101021031", "story_v_out_101021.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_36 = math.max(var_133_27, arg_130_1.talkMaxDuration)

			if var_133_26 <= arg_130_1.time_ and arg_130_1.time_ < var_133_26 + var_133_36 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_26) / var_133_36

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_26 + var_133_36 and arg_130_1.time_ < var_133_26 + var_133_36 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play101021032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 101021032
		arg_134_1.duration_ = 6.43

		local var_134_0 = {
			ja = 6.433,
			ko = 5.633,
			zh = 3.7,
			en = 2.433
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
				arg_134_0:Play101021033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1148ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1148ui_story == nil then
				arg_134_1.var_.characterEffect1148ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1148ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1148ui_story then
				arg_134_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1059ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1059ui_story == nil then
				arg_134_1.var_.characterEffect1059ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.1

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1059ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1059ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1059ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1059ui_story.fillRatio = var_137_9
			end

			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			local var_137_11 = 0

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_137_12 = 0
			local var_137_13 = 0.35

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_14 = arg_134_1:FormatText(StoryNameCfg[8].name)

				arg_134_1.leftNameTxt_.text = var_137_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_15 = arg_134_1:GetWordFromCfg(101021032)
				local var_137_16 = arg_134_1:FormatText(var_137_15.content)

				arg_134_1.text_.text = var_137_16

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 14
				local var_137_18 = utf8.len(var_137_16)
				local var_137_19 = var_137_17 <= 0 and var_137_13 or var_137_13 * (var_137_18 / var_137_17)

				if var_137_19 > 0 and var_137_13 < var_137_19 then
					arg_134_1.talkMaxDuration = var_137_19

					if var_137_19 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_19 + var_137_12
					end
				end

				arg_134_1.text_.text = var_137_16
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021032", "story_v_out_101021.awb") ~= 0 then
					local var_137_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021032", "story_v_out_101021.awb") / 1000

					if var_137_20 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_20 + var_137_12
					end

					if var_137_15.prefab_name ~= "" and arg_134_1.actors_[var_137_15.prefab_name] ~= nil then
						local var_137_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_15.prefab_name].transform, "story_v_out_101021", "101021032", "story_v_out_101021.awb")

						arg_134_1:RecordAudio("101021032", var_137_21)
						arg_134_1:RecordAudio("101021032", var_137_21)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_101021", "101021032", "story_v_out_101021.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_101021", "101021032", "story_v_out_101021.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_22 = math.max(var_137_13, arg_134_1.talkMaxDuration)

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_22 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_12) / var_137_22

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_12 + var_137_22 and arg_134_1.time_ < var_137_12 + var_137_22 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play101021033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 101021033
		arg_138_1.duration_ = 6.7

		local var_138_0 = {
			ja = 6.7,
			ko = 3.3,
			zh = 3.266,
			en = 2.9
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
				arg_138_0:Play101021034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1059ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1059ui_story == nil then
				arg_138_1.var_.characterEffect1059ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1059ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1059ui_story then
				arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1148ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1148ui_story == nil then
				arg_138_1.var_.characterEffect1148ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.1

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1148ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1148ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1148ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1148ui_story.fillRatio = var_141_9
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action434")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_141_12 = 0
			local var_141_13 = 0.425

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[28].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(101021033)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 17
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021033", "story_v_out_101021.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021033", "story_v_out_101021.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_101021", "101021033", "story_v_out_101021.awb")

						arg_138_1:RecordAudio("101021033", var_141_21)
						arg_138_1:RecordAudio("101021033", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_101021", "101021033", "story_v_out_101021.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_101021", "101021033", "story_v_out_101021.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play101021034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 101021034
		arg_142_1.duration_ = 9.17

		local var_142_0 = {
			ja = 8.4,
			ko = 9.166,
			zh = 6.133,
			en = 7.533
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
				arg_142_0:Play101021035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action447")
			end

			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_145_2 = 0
			local var_145_3 = 0.85

			if var_145_2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_4 = arg_142_1:FormatText(StoryNameCfg[28].name)

				arg_142_1.leftNameTxt_.text = var_145_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_5 = arg_142_1:GetWordFromCfg(101021034)
				local var_145_6 = arg_142_1:FormatText(var_145_5.content)

				arg_142_1.text_.text = var_145_6

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 34
				local var_145_8 = utf8.len(var_145_6)
				local var_145_9 = var_145_7 <= 0 and var_145_3 or var_145_3 * (var_145_8 / var_145_7)

				if var_145_9 > 0 and var_145_3 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_6
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021034", "story_v_out_101021.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021034", "story_v_out_101021.awb") / 1000

					if var_145_10 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_2
					end

					if var_145_5.prefab_name ~= "" and arg_142_1.actors_[var_145_5.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_5.prefab_name].transform, "story_v_out_101021", "101021034", "story_v_out_101021.awb")

						arg_142_1:RecordAudio("101021034", var_145_11)
						arg_142_1:RecordAudio("101021034", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_101021", "101021034", "story_v_out_101021.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_101021", "101021034", "story_v_out_101021.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_12 and arg_142_1.time_ < var_145_2 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play101021035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 101021035
		arg_146_1.duration_ = 9.13

		local var_146_0 = {
			ja = 9.133,
			ko = 5.4,
			zh = 5.066,
			en = 6.833
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
				arg_146_0:Play101021036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1148ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story == nil then
				arg_146_1.var_.characterEffect1148ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1148ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story then
				arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["1059ui_story"]
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1059ui_story == nil then
				arg_146_1.var_.characterEffect1059ui_story = var_149_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.1

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 and not isNil(var_149_4) then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6

				if arg_146_1.var_.characterEffect1059ui_story and not isNil(var_149_4) then
					local var_149_8 = Mathf.Lerp(0, 0.5, var_149_7)

					arg_146_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1059ui_story.fillRatio = var_149_8
				end
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1059ui_story then
				local var_149_9 = 0.5

				arg_146_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1059ui_story.fillRatio = var_149_9
			end

			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_149_12 = 0
			local var_149_13 = 0.425

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_14 = arg_146_1:FormatText(StoryNameCfg[8].name)

				arg_146_1.leftNameTxt_.text = var_149_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_15 = arg_146_1:GetWordFromCfg(101021035)
				local var_149_16 = arg_146_1:FormatText(var_149_15.content)

				arg_146_1.text_.text = var_149_16

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_17 = 17
				local var_149_18 = utf8.len(var_149_16)
				local var_149_19 = var_149_17 <= 0 and var_149_13 or var_149_13 * (var_149_18 / var_149_17)

				if var_149_19 > 0 and var_149_13 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19

					if var_149_19 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_12
					end
				end

				arg_146_1.text_.text = var_149_16
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021035", "story_v_out_101021.awb") ~= 0 then
					local var_149_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021035", "story_v_out_101021.awb") / 1000

					if var_149_20 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_12
					end

					if var_149_15.prefab_name ~= "" and arg_146_1.actors_[var_149_15.prefab_name] ~= nil then
						local var_149_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_15.prefab_name].transform, "story_v_out_101021", "101021035", "story_v_out_101021.awb")

						arg_146_1:RecordAudio("101021035", var_149_21)
						arg_146_1:RecordAudio("101021035", var_149_21)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_101021", "101021035", "story_v_out_101021.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_101021", "101021035", "story_v_out_101021.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = math.max(var_149_13, arg_146_1.talkMaxDuration)

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_12) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_12 + var_149_22 and arg_146_1.time_ < var_149_12 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play101021036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 101021036
		arg_150_1.duration_ = 9.27

		local var_150_0 = {
			ja = 9.266,
			ko = 7.333,
			zh = 6.1,
			en = 5.1
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play101021037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1059ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1059ui_story == nil then
				arg_150_1.var_.characterEffect1059ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.1

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1059ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1059ui_story then
				arg_150_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1148ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1148ui_story == nil then
				arg_150_1.var_.characterEffect1148ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1148ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1148ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1148ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1148ui_story.fillRatio = var_153_9
			end

			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action476")
			end

			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_153_12 = 0
			local var_153_13 = 0.65

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_14 = arg_150_1:FormatText(StoryNameCfg[28].name)

				arg_150_1.leftNameTxt_.text = var_153_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_15 = arg_150_1:GetWordFromCfg(101021036)
				local var_153_16 = arg_150_1:FormatText(var_153_15.content)

				arg_150_1.text_.text = var_153_16

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_17 = 26
				local var_153_18 = utf8.len(var_153_16)
				local var_153_19 = var_153_17 <= 0 and var_153_13 or var_153_13 * (var_153_18 / var_153_17)

				if var_153_19 > 0 and var_153_13 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_16
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021036", "story_v_out_101021.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021036", "story_v_out_101021.awb") / 1000

					if var_153_20 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_12
					end

					if var_153_15.prefab_name ~= "" and arg_150_1.actors_[var_153_15.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_15.prefab_name].transform, "story_v_out_101021", "101021036", "story_v_out_101021.awb")

						arg_150_1:RecordAudio("101021036", var_153_21)
						arg_150_1:RecordAudio("101021036", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_101021", "101021036", "story_v_out_101021.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_101021", "101021036", "story_v_out_101021.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_22 and arg_150_1.time_ < var_153_12 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play101021037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 101021037
		arg_154_1.duration_ = 7.7

		local var_154_0 = {
			ja = 7.7,
			ko = 5.966,
			zh = 5.566,
			en = 5.4
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
				arg_154_0:Play101021038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 1

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				local var_157_2 = "play"
				local var_157_3 = "effect"

				arg_154_1:AudioAction(var_157_2, var_157_3, "se_story_ui", "se_story_env_highcut_close", "")
			end

			local var_157_4 = 0
			local var_157_5 = 1

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				local var_157_6 = "play"
				local var_157_7 = "effect"

				arg_154_1:AudioAction(var_157_6, var_157_7, "se_story", "se_story_robot_long", "")
			end

			local var_157_8 = "2044_tpose"

			if arg_154_1.actors_[var_157_8] == nil then
				local var_157_9 = Asset.Load("Char/" .. "2044_tpose")

				if not isNil(var_157_9) then
					local var_157_10 = Object.Instantiate(Asset.Load("Char/" .. "2044_tpose"), arg_154_1.stage_.transform)

					var_157_10.name = var_157_8
					var_157_10.transform.localPosition = Vector3.New(0, 100, 0)
					arg_154_1.actors_[var_157_8] = var_157_10

					local var_157_11 = var_157_10:GetComponentInChildren(typeof(CharacterEffect))

					var_157_11.enabled = true

					local var_157_12 = GameObjectTools.GetOrAddComponent(var_157_10, typeof(DynamicBoneHelper))

					if var_157_12 then
						var_157_12:EnableDynamicBone(false)
					end

					arg_154_1:ShowWeapon(var_157_11.transform, false)

					arg_154_1.var_[var_157_8 .. "Animator"] = var_157_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_154_1.var_[var_157_8 .. "Animator"].applyRootMotion = true
					arg_154_1.var_[var_157_8 .. "LipSync"] = var_157_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_157_13 = arg_154_1.actors_["2044_tpose"]
			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 and not isNil(var_157_13) and arg_154_1.var_.characterEffect2044_tpose == nil then
				arg_154_1.var_.characterEffect2044_tpose = var_157_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_15 = 0.1

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_15 and not isNil(var_157_13) then
				local var_157_16 = (arg_154_1.time_ - var_157_14) / var_157_15

				if arg_154_1.var_.characterEffect2044_tpose and not isNil(var_157_13) then
					arg_154_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_14 + var_157_15 and arg_154_1.time_ < var_157_14 + var_157_15 + arg_157_0 and not isNil(var_157_13) and arg_154_1.var_.characterEffect2044_tpose then
				arg_154_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_157_17 = arg_154_1.actors_["1059ui_story"]
			local var_157_18 = 0

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 and not isNil(var_157_17) and arg_154_1.var_.characterEffect1059ui_story == nil then
				arg_154_1.var_.characterEffect1059ui_story = var_157_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_19 = 0.1

			if var_157_18 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_19 and not isNil(var_157_17) then
				local var_157_20 = (arg_154_1.time_ - var_157_18) / var_157_19

				if arg_154_1.var_.characterEffect1059ui_story and not isNil(var_157_17) then
					local var_157_21 = Mathf.Lerp(0, 0.5, var_157_20)

					arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1059ui_story.fillRatio = var_157_21
				end
			end

			if arg_154_1.time_ >= var_157_18 + var_157_19 and arg_154_1.time_ < var_157_18 + var_157_19 + arg_157_0 and not isNil(var_157_17) and arg_154_1.var_.characterEffect1059ui_story then
				local var_157_22 = 0.5

				arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1059ui_story.fillRatio = var_157_22
			end

			local var_157_23 = arg_154_1.actors_["1059ui_story"].transform
			local var_157_24 = 0

			if var_157_24 < arg_154_1.time_ and arg_154_1.time_ <= var_157_24 + arg_157_0 then
				arg_154_1.var_.moveOldPos1059ui_story = var_157_23.localPosition
			end

			local var_157_25 = 0.001

			if var_157_24 <= arg_154_1.time_ and arg_154_1.time_ < var_157_24 + var_157_25 then
				local var_157_26 = (arg_154_1.time_ - var_157_24) / var_157_25
				local var_157_27 = Vector3.New(0, 100, 0)

				var_157_23.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1059ui_story, var_157_27, var_157_26)

				local var_157_28 = manager.ui.mainCamera.transform.position - var_157_23.position

				var_157_23.forward = Vector3.New(var_157_28.x, var_157_28.y, var_157_28.z)

				local var_157_29 = var_157_23.localEulerAngles

				var_157_29.z = 0
				var_157_29.x = 0
				var_157_23.localEulerAngles = var_157_29
			end

			if arg_154_1.time_ >= var_157_24 + var_157_25 and arg_154_1.time_ < var_157_24 + var_157_25 + arg_157_0 then
				var_157_23.localPosition = Vector3.New(0, 100, 0)

				local var_157_30 = manager.ui.mainCamera.transform.position - var_157_23.position

				var_157_23.forward = Vector3.New(var_157_30.x, var_157_30.y, var_157_30.z)

				local var_157_31 = var_157_23.localEulerAngles

				var_157_31.z = 0
				var_157_31.x = 0
				var_157_23.localEulerAngles = var_157_31
			end

			local var_157_32 = arg_154_1.actors_["1148ui_story"].transform
			local var_157_33 = 0

			if var_157_33 < arg_154_1.time_ and arg_154_1.time_ <= var_157_33 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148ui_story = var_157_32.localPosition
			end

			local var_157_34 = 0.001

			if var_157_33 <= arg_154_1.time_ and arg_154_1.time_ < var_157_33 + var_157_34 then
				local var_157_35 = (arg_154_1.time_ - var_157_33) / var_157_34
				local var_157_36 = Vector3.New(0, 100, 0)

				var_157_32.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148ui_story, var_157_36, var_157_35)

				local var_157_37 = manager.ui.mainCamera.transform.position - var_157_32.position

				var_157_32.forward = Vector3.New(var_157_37.x, var_157_37.y, var_157_37.z)

				local var_157_38 = var_157_32.localEulerAngles

				var_157_38.z = 0
				var_157_38.x = 0
				var_157_32.localEulerAngles = var_157_38
			end

			if arg_154_1.time_ >= var_157_33 + var_157_34 and arg_154_1.time_ < var_157_33 + var_157_34 + arg_157_0 then
				var_157_32.localPosition = Vector3.New(0, 100, 0)

				local var_157_39 = manager.ui.mainCamera.transform.position - var_157_32.position

				var_157_32.forward = Vector3.New(var_157_39.x, var_157_39.y, var_157_39.z)

				local var_157_40 = var_157_32.localEulerAngles

				var_157_40.z = 0
				var_157_40.x = 0
				var_157_32.localEulerAngles = var_157_40
			end

			local var_157_41 = arg_154_1.actors_["2044_tpose"].transform
			local var_157_42 = 0

			if var_157_42 < arg_154_1.time_ and arg_154_1.time_ <= var_157_42 + arg_157_0 then
				arg_154_1.var_.moveOldPos2044_tpose = var_157_41.localPosition

				local var_157_43 = GameObjectTools.GetOrAddComponent(var_157_41.gameObject, typeof(DynamicBoneHelper))

				if var_157_43 then
					var_157_43:EnableDynamicBone(false)
				end
			end

			local var_157_44 = 0.001

			if var_157_42 <= arg_154_1.time_ and arg_154_1.time_ < var_157_42 + var_157_44 then
				local var_157_45 = (arg_154_1.time_ - var_157_42) / var_157_44
				local var_157_46 = Vector3.New(0, -1.15, -2.3)

				var_157_41.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos2044_tpose, var_157_46, var_157_45)

				local var_157_47 = manager.ui.mainCamera.transform.position - var_157_41.position

				var_157_41.forward = Vector3.New(var_157_47.x, var_157_47.y, var_157_47.z)

				local var_157_48 = var_157_41.localEulerAngles

				var_157_48.z = 0
				var_157_48.x = 0
				var_157_41.localEulerAngles = var_157_48
			end

			if arg_154_1.time_ >= var_157_42 + var_157_44 and arg_154_1.time_ < var_157_42 + var_157_44 + arg_157_0 then
				var_157_41.localPosition = Vector3.New(0, -1.15, -2.3)

				local var_157_49 = manager.ui.mainCamera.transform.position - var_157_41.position

				var_157_41.forward = Vector3.New(var_157_49.x, var_157_49.y, var_157_49.z)

				local var_157_50 = var_157_41.localEulerAngles

				var_157_50.z = 0
				var_157_50.x = 0
				var_157_41.localEulerAngles = var_157_50

				local var_157_51 = GameObjectTools.GetOrAddComponent(var_157_41.gameObject, typeof(DynamicBoneHelper))

				if var_157_51 then
					var_157_51:EnableDynamicBone(true)
				end
			end

			local var_157_52 = 0

			if var_157_52 < arg_154_1.time_ and arg_154_1.time_ <= var_157_52 + arg_157_0 then
				arg_154_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_157_53 = 0
			local var_157_54 = 0.6

			if var_157_53 < arg_154_1.time_ and arg_154_1.time_ <= var_157_53 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_55 = arg_154_1:FormatText(StoryNameCfg[29].name)

				arg_154_1.leftNameTxt_.text = var_157_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_56 = arg_154_1:GetWordFromCfg(101021037)
				local var_157_57 = arg_154_1:FormatText(var_157_56.content)

				arg_154_1.text_.text = var_157_57

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_58 = 23
				local var_157_59 = utf8.len(var_157_57)
				local var_157_60 = var_157_58 <= 0 and var_157_54 or var_157_54 * (var_157_59 / var_157_58)

				if var_157_60 > 0 and var_157_54 < var_157_60 then
					arg_154_1.talkMaxDuration = var_157_60

					if var_157_60 + var_157_53 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_60 + var_157_53
					end
				end

				arg_154_1.text_.text = var_157_57
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021037", "story_v_out_101021.awb") ~= 0 then
					local var_157_61 = manager.audio:GetVoiceLength("story_v_out_101021", "101021037", "story_v_out_101021.awb") / 1000

					if var_157_61 + var_157_53 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_61 + var_157_53
					end

					if var_157_56.prefab_name ~= "" and arg_154_1.actors_[var_157_56.prefab_name] ~= nil then
						local var_157_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_56.prefab_name].transform, "story_v_out_101021", "101021037", "story_v_out_101021.awb")

						arg_154_1:RecordAudio("101021037", var_157_62)
						arg_154_1:RecordAudio("101021037", var_157_62)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_101021", "101021037", "story_v_out_101021.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_101021", "101021037", "story_v_out_101021.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_63 = math.max(var_157_54, arg_154_1.talkMaxDuration)

			if var_157_53 <= arg_154_1.time_ and arg_154_1.time_ < var_157_53 + var_157_63 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_53) / var_157_63

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_53 + var_157_63 and arg_154_1.time_ < var_157_53 + var_157_63 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play101021038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 101021038
		arg_158_1.duration_ = 7.07

		local var_158_0 = {
			ja = 7.066,
			ko = 4.933,
			zh = 4.433,
			en = 5.1
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
				arg_158_0:Play101021039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["2044_tpose"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect2044_tpose == nil then
				arg_158_1.var_.characterEffect2044_tpose = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.1

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect2044_tpose and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_158_1.var_.characterEffect2044_tpose.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect2044_tpose then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_158_1.var_.characterEffect2044_tpose.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.5

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[30].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_9 = arg_158_1:GetWordFromCfg(101021038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021038", "story_v_out_101021.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021038", "story_v_out_101021.awb") / 1000

					if var_161_14 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_6
					end

					if var_161_9.prefab_name ~= "" and arg_158_1.actors_[var_161_9.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_9.prefab_name].transform, "story_v_out_101021", "101021038", "story_v_out_101021.awb")

						arg_158_1:RecordAudio("101021038", var_161_15)
						arg_158_1:RecordAudio("101021038", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_101021", "101021038", "story_v_out_101021.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_101021", "101021038", "story_v_out_101021.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_16 and arg_158_1.time_ < var_161_6 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play101021039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 101021039
		arg_162_1.duration_ = 3.2

		local var_162_0 = {
			ja = 1.999999999999,
			ko = 2.8,
			zh = 1.999999999999,
			en = 3.2
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
				arg_162_0:Play101021040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10001_tpose"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10001_tpose == nil then
				arg_162_1.var_.characterEffect10001_tpose = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.1

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect10001_tpose and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10001_tpose then
				arg_162_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["2044_tpose"].transform
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.var_.moveOldPos2044_tpose = var_165_4.localPosition

				local var_165_6 = GameObjectTools.GetOrAddComponent(var_165_4.gameObject, typeof(DynamicBoneHelper))

				if var_165_6 then
					var_165_6:EnableDynamicBone(false)
				end
			end

			local var_165_7 = 0.001

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_7 then
				local var_165_8 = (arg_162_1.time_ - var_165_5) / var_165_7
				local var_165_9 = Vector3.New(0, 100, 0)

				var_165_4.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos2044_tpose, var_165_9, var_165_8)

				local var_165_10 = manager.ui.mainCamera.transform.position - var_165_4.position

				var_165_4.forward = Vector3.New(var_165_10.x, var_165_10.y, var_165_10.z)

				local var_165_11 = var_165_4.localEulerAngles

				var_165_11.z = 0
				var_165_11.x = 0
				var_165_4.localEulerAngles = var_165_11
			end

			if arg_162_1.time_ >= var_165_5 + var_165_7 and arg_162_1.time_ < var_165_5 + var_165_7 + arg_165_0 then
				var_165_4.localPosition = Vector3.New(0, 100, 0)

				local var_165_12 = manager.ui.mainCamera.transform.position - var_165_4.position

				var_165_4.forward = Vector3.New(var_165_12.x, var_165_12.y, var_165_12.z)

				local var_165_13 = var_165_4.localEulerAngles

				var_165_13.z = 0
				var_165_13.x = 0
				var_165_4.localEulerAngles = var_165_13

				local var_165_14 = GameObjectTools.GetOrAddComponent(var_165_4.gameObject, typeof(DynamicBoneHelper))

				if var_165_14 then
					var_165_14:EnableDynamicBone(true)
				end
			end

			local var_165_15 = arg_162_1.actors_["10001_tpose"].transform
			local var_165_16 = 0

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1.var_.moveOldPos10001_tpose = var_165_15.localPosition

				local var_165_17 = GameObjectTools.GetOrAddComponent(var_165_15.gameObject, typeof(DynamicBoneHelper))

				if var_165_17 then
					var_165_17:EnableDynamicBone(false)
				end
			end

			local var_165_18 = 0.001

			if var_165_16 <= arg_162_1.time_ and arg_162_1.time_ < var_165_16 + var_165_18 then
				local var_165_19 = (arg_162_1.time_ - var_165_16) / var_165_18
				local var_165_20 = Vector3.New(0, -1.23, -5.8)

				var_165_15.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10001_tpose, var_165_20, var_165_19)

				local var_165_21 = manager.ui.mainCamera.transform.position - var_165_15.position

				var_165_15.forward = Vector3.New(var_165_21.x, var_165_21.y, var_165_21.z)

				local var_165_22 = var_165_15.localEulerAngles

				var_165_22.z = 0
				var_165_22.x = 0
				var_165_15.localEulerAngles = var_165_22
			end

			if arg_162_1.time_ >= var_165_16 + var_165_18 and arg_162_1.time_ < var_165_16 + var_165_18 + arg_165_0 then
				var_165_15.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_165_23 = manager.ui.mainCamera.transform.position - var_165_15.position

				var_165_15.forward = Vector3.New(var_165_23.x, var_165_23.y, var_165_23.z)

				local var_165_24 = var_165_15.localEulerAngles

				var_165_24.z = 0
				var_165_24.x = 0
				var_165_15.localEulerAngles = var_165_24

				local var_165_25 = GameObjectTools.GetOrAddComponent(var_165_15.gameObject, typeof(DynamicBoneHelper))

				if var_165_25 then
					var_165_25:EnableDynamicBone(true)
				end
			end

			local var_165_26 = 0

			if var_165_26 < arg_162_1.time_ and arg_162_1.time_ <= var_165_26 + arg_165_0 then
				arg_162_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_1")
			end

			local var_165_27 = 0

			if var_165_27 < arg_162_1.time_ and arg_162_1.time_ <= var_165_27 + arg_165_0 then
				arg_162_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_165_28 = 0
			local var_165_29 = 0.175

			if var_165_28 < arg_162_1.time_ and arg_162_1.time_ <= var_165_28 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_30 = arg_162_1:FormatText(StoryNameCfg[31].name)

				arg_162_1.leftNameTxt_.text = var_165_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_31 = arg_162_1:GetWordFromCfg(101021039)
				local var_165_32 = arg_162_1:FormatText(var_165_31.content)

				arg_162_1.text_.text = var_165_32

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_33 = 7
				local var_165_34 = utf8.len(var_165_32)
				local var_165_35 = var_165_33 <= 0 and var_165_29 or var_165_29 * (var_165_34 / var_165_33)

				if var_165_35 > 0 and var_165_29 < var_165_35 then
					arg_162_1.talkMaxDuration = var_165_35

					if var_165_35 + var_165_28 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_35 + var_165_28
					end
				end

				arg_162_1.text_.text = var_165_32
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021039", "story_v_out_101021.awb") ~= 0 then
					local var_165_36 = manager.audio:GetVoiceLength("story_v_out_101021", "101021039", "story_v_out_101021.awb") / 1000

					if var_165_36 + var_165_28 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_36 + var_165_28
					end

					if var_165_31.prefab_name ~= "" and arg_162_1.actors_[var_165_31.prefab_name] ~= nil then
						local var_165_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_31.prefab_name].transform, "story_v_out_101021", "101021039", "story_v_out_101021.awb")

						arg_162_1:RecordAudio("101021039", var_165_37)
						arg_162_1:RecordAudio("101021039", var_165_37)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_101021", "101021039", "story_v_out_101021.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_101021", "101021039", "story_v_out_101021.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_38 = math.max(var_165_29, arg_162_1.talkMaxDuration)

			if var_165_28 <= arg_162_1.time_ and arg_162_1.time_ < var_165_28 + var_165_38 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_28) / var_165_38

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_28 + var_165_38 and arg_162_1.time_ < var_165_28 + var_165_38 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
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

		arg_162_1:InitPlayNodeList()
	end,
	Play101021040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 101021040
		arg_166_1.duration_ = 10.13

		local var_166_0 = {
			ja = 10.133,
			ko = 7.9,
			zh = 7.366,
			en = 8
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
				arg_166_0:Play101021041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10001_tpose"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10001_tpose == nil then
				arg_166_1.var_.characterEffect10001_tpose = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.1

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect10001_tpose and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_166_1.var_.characterEffect10001_tpose.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10001_tpose then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_166_1.var_.characterEffect10001_tpose.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 0.7

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[30].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_9 = arg_166_1:GetWordFromCfg(101021040)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 28
				local var_169_12 = utf8.len(var_169_10)
				local var_169_13 = var_169_11 <= 0 and var_169_7 or var_169_7 * (var_169_12 / var_169_11)

				if var_169_13 > 0 and var_169_7 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021040", "story_v_out_101021.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021040", "story_v_out_101021.awb") / 1000

					if var_169_14 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_6
					end

					if var_169_9.prefab_name ~= "" and arg_166_1.actors_[var_169_9.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_9.prefab_name].transform, "story_v_out_101021", "101021040", "story_v_out_101021.awb")

						arg_166_1:RecordAudio("101021040", var_169_15)
						arg_166_1:RecordAudio("101021040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_101021", "101021040", "story_v_out_101021.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_101021", "101021040", "story_v_out_101021.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_16 and arg_166_1.time_ < var_169_6 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play101021041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 101021041
		arg_170_1.duration_ = 2.03

		local var_170_0 = {
			ja = 1.680999999999,
			ko = 1.680999999999,
			zh = 2.033,
			en = 1.680999999999
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play101021042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10001_tpose"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10001_tpose == nil then
				arg_170_1.var_.characterEffect10001_tpose = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.1

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect10001_tpose and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10001_tpose then
				arg_170_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_173_4 = 0

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			local var_173_5 = 0

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_173_6 = 0
			local var_173_7 = 0.175

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_8 = arg_170_1:FormatText(StoryNameCfg[31].name)

				arg_170_1.leftNameTxt_.text = var_173_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_9 = arg_170_1:GetWordFromCfg(101021041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 7
				local var_173_12 = utf8.len(var_173_10)
				local var_173_13 = var_173_11 <= 0 and var_173_7 or var_173_7 * (var_173_12 / var_173_11)

				if var_173_13 > 0 and var_173_7 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021041", "story_v_out_101021.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021041", "story_v_out_101021.awb") / 1000

					if var_173_14 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_6
					end

					if var_173_9.prefab_name ~= "" and arg_170_1.actors_[var_173_9.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_9.prefab_name].transform, "story_v_out_101021", "101021041", "story_v_out_101021.awb")

						arg_170_1:RecordAudio("101021041", var_173_15)
						arg_170_1:RecordAudio("101021041", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_101021", "101021041", "story_v_out_101021.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_101021", "101021041", "story_v_out_101021.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_16 and arg_170_1.time_ < var_173_6 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play101021042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 101021042
		arg_174_1.duration_ = 9.73

		local var_174_0 = {
			ja = 6.866,
			ko = 8.233,
			zh = 8.4,
			en = 9.733
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play101021043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				local var_177_2 = "play"
				local var_177_3 = "effect"

				arg_174_1:AudioAction(var_177_2, var_177_3, "se_story", "se_story_robot_long", "")
			end

			local var_177_4 = arg_174_1.actors_["2044_tpose"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect2044_tpose == nil then
				arg_174_1.var_.characterEffect2044_tpose = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.1

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.characterEffect2044_tpose and not isNil(var_177_4) then
					arg_174_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect2044_tpose then
				arg_174_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_177_8 = arg_174_1.actors_["10001_tpose"]
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.characterEffect10001_tpose == nil then
				arg_174_1.var_.characterEffect10001_tpose = var_177_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_10 = 0.1

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_10 and not isNil(var_177_8) then
				local var_177_11 = (arg_174_1.time_ - var_177_9) / var_177_10

				if arg_174_1.var_.characterEffect10001_tpose and not isNil(var_177_8) then
					local var_177_12 = Mathf.Lerp(0, 0.5, var_177_11)

					arg_174_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_174_1.var_.characterEffect10001_tpose.fillRatio = var_177_12
				end
			end

			if arg_174_1.time_ >= var_177_9 + var_177_10 and arg_174_1.time_ < var_177_9 + var_177_10 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.characterEffect10001_tpose then
				local var_177_13 = 0.5

				arg_174_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_174_1.var_.characterEffect10001_tpose.fillRatio = var_177_13
			end

			local var_177_14 = arg_174_1.actors_["10001_tpose"].transform
			local var_177_15 = 0

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.var_.moveOldPos10001_tpose = var_177_14.localPosition

				local var_177_16 = GameObjectTools.GetOrAddComponent(var_177_14.gameObject, typeof(DynamicBoneHelper))

				if var_177_16 then
					var_177_16:EnableDynamicBone(false)
				end
			end

			local var_177_17 = 0.001

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_17 then
				local var_177_18 = (arg_174_1.time_ - var_177_15) / var_177_17
				local var_177_19 = Vector3.New(0, 100, 0)

				var_177_14.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10001_tpose, var_177_19, var_177_18)

				local var_177_20 = manager.ui.mainCamera.transform.position - var_177_14.position

				var_177_14.forward = Vector3.New(var_177_20.x, var_177_20.y, var_177_20.z)

				local var_177_21 = var_177_14.localEulerAngles

				var_177_21.z = 0
				var_177_21.x = 0
				var_177_14.localEulerAngles = var_177_21
			end

			if arg_174_1.time_ >= var_177_15 + var_177_17 and arg_174_1.time_ < var_177_15 + var_177_17 + arg_177_0 then
				var_177_14.localPosition = Vector3.New(0, 100, 0)

				local var_177_22 = manager.ui.mainCamera.transform.position - var_177_14.position

				var_177_14.forward = Vector3.New(var_177_22.x, var_177_22.y, var_177_22.z)

				local var_177_23 = var_177_14.localEulerAngles

				var_177_23.z = 0
				var_177_23.x = 0
				var_177_14.localEulerAngles = var_177_23

				local var_177_24 = GameObjectTools.GetOrAddComponent(var_177_14.gameObject, typeof(DynamicBoneHelper))

				if var_177_24 then
					var_177_24:EnableDynamicBone(true)
				end
			end

			local var_177_25 = arg_174_1.actors_["2044_tpose"].transform
			local var_177_26 = 0

			if var_177_26 < arg_174_1.time_ and arg_174_1.time_ <= var_177_26 + arg_177_0 then
				arg_174_1.var_.moveOldPos2044_tpose = var_177_25.localPosition

				local var_177_27 = GameObjectTools.GetOrAddComponent(var_177_25.gameObject, typeof(DynamicBoneHelper))

				if var_177_27 then
					var_177_27:EnableDynamicBone(false)
				end
			end

			local var_177_28 = 0.001

			if var_177_26 <= arg_174_1.time_ and arg_174_1.time_ < var_177_26 + var_177_28 then
				local var_177_29 = (arg_174_1.time_ - var_177_26) / var_177_28
				local var_177_30 = Vector3.New(0, -1.15, -2.3)

				var_177_25.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos2044_tpose, var_177_30, var_177_29)

				local var_177_31 = manager.ui.mainCamera.transform.position - var_177_25.position

				var_177_25.forward = Vector3.New(var_177_31.x, var_177_31.y, var_177_31.z)

				local var_177_32 = var_177_25.localEulerAngles

				var_177_32.z = 0
				var_177_32.x = 0
				var_177_25.localEulerAngles = var_177_32
			end

			if arg_174_1.time_ >= var_177_26 + var_177_28 and arg_174_1.time_ < var_177_26 + var_177_28 + arg_177_0 then
				var_177_25.localPosition = Vector3.New(0, -1.15, -2.3)

				local var_177_33 = manager.ui.mainCamera.transform.position - var_177_25.position

				var_177_25.forward = Vector3.New(var_177_33.x, var_177_33.y, var_177_33.z)

				local var_177_34 = var_177_25.localEulerAngles

				var_177_34.z = 0
				var_177_34.x = 0
				var_177_25.localEulerAngles = var_177_34

				local var_177_35 = GameObjectTools.GetOrAddComponent(var_177_25.gameObject, typeof(DynamicBoneHelper))

				if var_177_35 then
					var_177_35:EnableDynamicBone(true)
				end
			end

			local var_177_36 = 0

			if var_177_36 < arg_174_1.time_ and arg_174_1.time_ <= var_177_36 + arg_177_0 then
				arg_174_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_177_37 = 0
			local var_177_38 = 0.775

			if var_177_37 < arg_174_1.time_ and arg_174_1.time_ <= var_177_37 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_39 = arg_174_1:FormatText(StoryNameCfg[29].name)

				arg_174_1.leftNameTxt_.text = var_177_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_40 = arg_174_1:GetWordFromCfg(101021042)
				local var_177_41 = arg_174_1:FormatText(var_177_40.content)

				arg_174_1.text_.text = var_177_41

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_42 = 30
				local var_177_43 = utf8.len(var_177_41)
				local var_177_44 = var_177_42 <= 0 and var_177_38 or var_177_38 * (var_177_43 / var_177_42)

				if var_177_44 > 0 and var_177_38 < var_177_44 then
					arg_174_1.talkMaxDuration = var_177_44

					if var_177_44 + var_177_37 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_44 + var_177_37
					end
				end

				arg_174_1.text_.text = var_177_41
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021042", "story_v_out_101021.awb") ~= 0 then
					local var_177_45 = manager.audio:GetVoiceLength("story_v_out_101021", "101021042", "story_v_out_101021.awb") / 1000

					if var_177_45 + var_177_37 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_45 + var_177_37
					end

					if var_177_40.prefab_name ~= "" and arg_174_1.actors_[var_177_40.prefab_name] ~= nil then
						local var_177_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_40.prefab_name].transform, "story_v_out_101021", "101021042", "story_v_out_101021.awb")

						arg_174_1:RecordAudio("101021042", var_177_46)
						arg_174_1:RecordAudio("101021042", var_177_46)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_101021", "101021042", "story_v_out_101021.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_101021", "101021042", "story_v_out_101021.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_47 = math.max(var_177_38, arg_174_1.talkMaxDuration)

			if var_177_37 <= arg_174_1.time_ and arg_174_1.time_ < var_177_37 + var_177_47 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_37) / var_177_47

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_37 + var_177_47 and arg_174_1.time_ < var_177_37 + var_177_47 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play101021043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 101021043
		arg_178_1.duration_ = 1

		local var_178_0 = {
			ja = 0.8,
			ko = 0.9,
			zh = 1,
			en = 0.833
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
				arg_178_0:Play101021044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["2044_tpose"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect2044_tpose == nil then
				arg_178_1.var_.characterEffect2044_tpose = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.1

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect2044_tpose and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_178_1.var_.characterEffect2044_tpose.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect2044_tpose then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_178_1.var_.characterEffect2044_tpose.fillRatio = var_181_5
			end

			local var_181_6 = 0
			local var_181_7 = 0.05

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_8 = arg_178_1:FormatText(StoryNameCfg[30].name)

				arg_178_1.leftNameTxt_.text = var_181_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_9 = arg_178_1:GetWordFromCfg(101021043)
				local var_181_10 = arg_178_1:FormatText(var_181_9.content)

				arg_178_1.text_.text = var_181_10

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021043", "story_v_out_101021.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021043", "story_v_out_101021.awb") / 1000

					if var_181_14 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_6
					end

					if var_181_9.prefab_name ~= "" and arg_178_1.actors_[var_181_9.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_9.prefab_name].transform, "story_v_out_101021", "101021043", "story_v_out_101021.awb")

						arg_178_1:RecordAudio("101021043", var_181_15)
						arg_178_1:RecordAudio("101021043", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_101021", "101021043", "story_v_out_101021.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_101021", "101021043", "story_v_out_101021.awb")
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
	Play101021044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 101021044
		arg_182_1.duration_ = 2.87

		local var_182_0 = {
			ja = 2.866,
			ko = 1.466,
			zh = 2.2,
			en = 1.333
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play101021045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 1

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				local var_185_2 = "play"
				local var_185_3 = "effect"

				arg_182_1:AudioAction(var_185_2, var_185_3, "se_story", "se_story_robot_excited", "")
			end

			local var_185_4 = arg_182_1.actors_["2044_tpose"]
			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect2044_tpose == nil then
				arg_182_1.var_.characterEffect2044_tpose = var_185_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_6 = 0.1

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_6 and not isNil(var_185_4) then
				local var_185_7 = (arg_182_1.time_ - var_185_5) / var_185_6

				if arg_182_1.var_.characterEffect2044_tpose and not isNil(var_185_4) then
					arg_182_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_5 + var_185_6 and arg_182_1.time_ < var_185_5 + var_185_6 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect2044_tpose then
				arg_182_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_185_8 = 0

			if var_185_8 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_9 = 0.5

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_9 then
				local var_185_10 = (arg_182_1.time_ - var_185_8) / var_185_9
				local var_185_11 = Color.New(1, 1, 1)

				var_185_11.a = Mathf.Lerp(1, 0, var_185_10)
				arg_182_1.mask_.color = var_185_11
			end

			if arg_182_1.time_ >= var_185_8 + var_185_9 and arg_182_1.time_ < var_185_8 + var_185_9 + arg_185_0 then
				local var_185_12 = Color.New(1, 1, 1)
				local var_185_13 = 0

				arg_182_1.mask_.enabled = false
				var_185_12.a = var_185_13
				arg_182_1.mask_.color = var_185_12
			end

			local var_185_14 = manager.ui.mainCamera.transform
			local var_185_15 = 0

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.var_.shakeOldPosMainCamera = var_185_14.localPosition
			end

			local var_185_16 = 0.600000023841858

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_16 then
				local var_185_17 = (arg_182_1.time_ - var_185_15) / 0.066
				local var_185_18, var_185_19 = math.modf(var_185_17)

				var_185_14.localPosition = Vector3.New(var_185_19 * 0.13, var_185_19 * 0.13, var_185_19 * 0.13) + arg_182_1.var_.shakeOldPosMainCamera
			end

			if arg_182_1.time_ >= var_185_15 + var_185_16 and arg_182_1.time_ < var_185_15 + var_185_16 + arg_185_0 then
				var_185_14.localPosition = arg_182_1.var_.shakeOldPosMainCamera
			end

			local var_185_20 = 0
			local var_185_21 = 0.125

			if var_185_20 < arg_182_1.time_ and arg_182_1.time_ <= var_185_20 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_22 = arg_182_1:FormatText(StoryNameCfg[29].name)

				arg_182_1.leftNameTxt_.text = var_185_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_23 = arg_182_1:GetWordFromCfg(101021044)
				local var_185_24 = arg_182_1:FormatText(var_185_23.content)

				arg_182_1.text_.text = var_185_24

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_25 = 5
				local var_185_26 = utf8.len(var_185_24)
				local var_185_27 = var_185_25 <= 0 and var_185_21 or var_185_21 * (var_185_26 / var_185_25)

				if var_185_27 > 0 and var_185_21 < var_185_27 then
					arg_182_1.talkMaxDuration = var_185_27

					if var_185_27 + var_185_20 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_27 + var_185_20
					end
				end

				arg_182_1.text_.text = var_185_24
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021044", "story_v_out_101021.awb") ~= 0 then
					local var_185_28 = manager.audio:GetVoiceLength("story_v_out_101021", "101021044", "story_v_out_101021.awb") / 1000

					if var_185_28 + var_185_20 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_28 + var_185_20
					end

					if var_185_23.prefab_name ~= "" and arg_182_1.actors_[var_185_23.prefab_name] ~= nil then
						local var_185_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_23.prefab_name].transform, "story_v_out_101021", "101021044", "story_v_out_101021.awb")

						arg_182_1:RecordAudio("101021044", var_185_29)
						arg_182_1:RecordAudio("101021044", var_185_29)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_101021", "101021044", "story_v_out_101021.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_101021", "101021044", "story_v_out_101021.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_30 = math.max(var_185_21, arg_182_1.talkMaxDuration)

			if var_185_20 <= arg_182_1.time_ and arg_182_1.time_ < var_185_20 + var_185_30 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_20) / var_185_30

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_20 + var_185_30 and arg_182_1.time_ < var_185_20 + var_185_30 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play101021045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 101021045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play101021046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 1

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				local var_189_2 = "play"
				local var_189_3 = "effect"

				arg_186_1:AudioAction(var_189_2, var_189_3, "se_story_1", "se_story_1_apollo_bow", "")
			end

			local var_189_4 = arg_186_1.actors_["2044_tpose"]
			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect2044_tpose == nil then
				arg_186_1.var_.characterEffect2044_tpose = var_189_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.1

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 and not isNil(var_189_4) then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6

				if arg_186_1.var_.characterEffect2044_tpose and not isNil(var_189_4) then
					local var_189_8 = Mathf.Lerp(0, 0.5, var_189_7)

					arg_186_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_186_1.var_.characterEffect2044_tpose.fillRatio = var_189_8
				end
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect2044_tpose then
				local var_189_9 = 0.5

				arg_186_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_186_1.var_.characterEffect2044_tpose.fillRatio = var_189_9
			end

			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_11 = 0.5

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11
				local var_189_13 = Color.New(1, 1, 1)

				var_189_13.a = Mathf.Lerp(1, 0, var_189_12)
				arg_186_1.mask_.color = var_189_13
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 then
				local var_189_14 = Color.New(1, 1, 1)
				local var_189_15 = 0

				arg_186_1.mask_.enabled = false
				var_189_14.a = var_189_15
				arg_186_1.mask_.color = var_189_14
			end

			local var_189_16 = arg_186_1.actors_["2044_tpose"].transform
			local var_189_17 = 0

			if var_189_17 < arg_186_1.time_ and arg_186_1.time_ <= var_189_17 + arg_189_0 then
				arg_186_1.var_.moveOldPos2044_tpose = var_189_16.localPosition

				local var_189_18 = GameObjectTools.GetOrAddComponent(var_189_16.gameObject, typeof(DynamicBoneHelper))

				if var_189_18 then
					var_189_18:EnableDynamicBone(false)
				end
			end

			local var_189_19 = 0.001

			if var_189_17 <= arg_186_1.time_ and arg_186_1.time_ < var_189_17 + var_189_19 then
				local var_189_20 = (arg_186_1.time_ - var_189_17) / var_189_19
				local var_189_21 = Vector3.New(0, 100, 0)

				var_189_16.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos2044_tpose, var_189_21, var_189_20)

				local var_189_22 = manager.ui.mainCamera.transform.position - var_189_16.position

				var_189_16.forward = Vector3.New(var_189_22.x, var_189_22.y, var_189_22.z)

				local var_189_23 = var_189_16.localEulerAngles

				var_189_23.z = 0
				var_189_23.x = 0
				var_189_16.localEulerAngles = var_189_23
			end

			if arg_186_1.time_ >= var_189_17 + var_189_19 and arg_186_1.time_ < var_189_17 + var_189_19 + arg_189_0 then
				var_189_16.localPosition = Vector3.New(0, 100, 0)

				local var_189_24 = manager.ui.mainCamera.transform.position - var_189_16.position

				var_189_16.forward = Vector3.New(var_189_24.x, var_189_24.y, var_189_24.z)

				local var_189_25 = var_189_16.localEulerAngles

				var_189_25.z = 0
				var_189_25.x = 0
				var_189_16.localEulerAngles = var_189_25

				local var_189_26 = GameObjectTools.GetOrAddComponent(var_189_16.gameObject, typeof(DynamicBoneHelper))

				if var_189_26 then
					var_189_26:EnableDynamicBone(true)
				end
			end

			local var_189_27 = manager.ui.mainCamera.transform
			local var_189_28 = 0

			if var_189_28 < arg_186_1.time_ and arg_186_1.time_ <= var_189_28 + arg_189_0 then
				arg_186_1.var_.shakeOldPosMainCamera = var_189_27.localPosition
			end

			local var_189_29 = 0.300000011920929

			if var_189_28 <= arg_186_1.time_ and arg_186_1.time_ < var_189_28 + var_189_29 then
				local var_189_30 = (arg_186_1.time_ - var_189_28) / 0.066
				local var_189_31, var_189_32 = math.modf(var_189_30)

				var_189_27.localPosition = Vector3.New(var_189_32 * 0.13, var_189_32 * 0.13, var_189_32 * 0.13) + arg_186_1.var_.shakeOldPosMainCamera
			end

			if arg_186_1.time_ >= var_189_28 + var_189_29 and arg_186_1.time_ < var_189_28 + var_189_29 + arg_189_0 then
				var_189_27.localPosition = arg_186_1.var_.shakeOldPosMainCamera
			end

			local var_189_33 = 0
			local var_189_34 = 0.9

			if var_189_33 < arg_186_1.time_ and arg_186_1.time_ <= var_189_33 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_35 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_35:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_36 = arg_186_1:GetWordFromCfg(101021045)
				local var_189_37 = arg_186_1:FormatText(var_189_36.content)

				arg_186_1.text_.text = var_189_37

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_38 = 36
				local var_189_39 = utf8.len(var_189_37)
				local var_189_40 = var_189_38 <= 0 and var_189_34 or var_189_34 * (var_189_39 / var_189_38)

				if var_189_40 > 0 and var_189_34 < var_189_40 then
					arg_186_1.talkMaxDuration = var_189_40
					var_189_33 = var_189_33 + 0.3

					if var_189_40 + var_189_33 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_40 + var_189_33
					end
				end

				arg_186_1.text_.text = var_189_37
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_41 = var_189_33 + 0.3
			local var_189_42 = math.max(var_189_34, arg_186_1.talkMaxDuration)

			if var_189_41 <= arg_186_1.time_ and arg_186_1.time_ < var_189_41 + var_189_42 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_41) / var_189_42

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_41 + var_189_42 and arg_186_1.time_ < var_189_41 + var_189_42 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play101021046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 101021046
		arg_192_1.duration_ = 9.37

		local var_192_0 = {
			ja = 7.733,
			ko = 9.366,
			zh = 7.6,
			en = 6.766
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
			arg_192_1.auto_ = false
		end

		function arg_192_1.playNext_(arg_194_0)
			arg_192_1.onStoryFinished_()
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1059ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1059ui_story == nil then
				arg_192_1.var_.characterEffect1059ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.1

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1059ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1059ui_story then
				arg_192_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["1059ui_story"].transform
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.var_.moveOldPos1059ui_story = var_195_4.localPosition
			end

			local var_195_6 = 0.001

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6
				local var_195_8 = Vector3.New(0, -1.05, -6)

				var_195_4.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1059ui_story, var_195_8, var_195_7)

				local var_195_9 = manager.ui.mainCamera.transform.position - var_195_4.position

				var_195_4.forward = Vector3.New(var_195_9.x, var_195_9.y, var_195_9.z)

				local var_195_10 = var_195_4.localEulerAngles

				var_195_10.z = 0
				var_195_10.x = 0
				var_195_4.localEulerAngles = var_195_10
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 then
				var_195_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_195_11 = manager.ui.mainCamera.transform.position - var_195_4.position

				var_195_4.forward = Vector3.New(var_195_11.x, var_195_11.y, var_195_11.z)

				local var_195_12 = var_195_4.localEulerAngles

				var_195_12.z = 0
				var_195_12.x = 0
				var_195_4.localEulerAngles = var_195_12
			end

			local var_195_13 = 0

			if var_195_13 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_195_14 = 0

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_195_15 = 0
			local var_195_16 = 0.9

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_17 = arg_192_1:FormatText(StoryNameCfg[28].name)

				arg_192_1.leftNameTxt_.text = var_195_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_18 = arg_192_1:GetWordFromCfg(101021046)
				local var_195_19 = arg_192_1:FormatText(var_195_18.content)

				arg_192_1.text_.text = var_195_19

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_20 = 36
				local var_195_21 = utf8.len(var_195_19)
				local var_195_22 = var_195_20 <= 0 and var_195_16 or var_195_16 * (var_195_21 / var_195_20)

				if var_195_22 > 0 and var_195_16 < var_195_22 then
					arg_192_1.talkMaxDuration = var_195_22

					if var_195_22 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_22 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_19
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021046", "story_v_out_101021.awb") ~= 0 then
					local var_195_23 = manager.audio:GetVoiceLength("story_v_out_101021", "101021046", "story_v_out_101021.awb") / 1000

					if var_195_23 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_23 + var_195_15
					end

					if var_195_18.prefab_name ~= "" and arg_192_1.actors_[var_195_18.prefab_name] ~= nil then
						local var_195_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_18.prefab_name].transform, "story_v_out_101021", "101021046", "story_v_out_101021.awb")

						arg_192_1:RecordAudio("101021046", var_195_24)
						arg_192_1:RecordAudio("101021046", var_195_24)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_101021", "101021046", "story_v_out_101021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_101021", "101021046", "story_v_out_101021.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_25 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_25 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_25

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_25 and arg_192_1.time_ < var_195_15 + var_195_25 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B10f"
	},
	voices = {
		"story_v_out_101021.awb"
	}
}
