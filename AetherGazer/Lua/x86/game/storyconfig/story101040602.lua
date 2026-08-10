return {
	Play104062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			local var_4_6 = "B13"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B13
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB13 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_10
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB13 then
					local var_4_14 = arg_1_1.var_.alphaMatValueB13.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB13.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				local var_4_15 = arg_1_1.var_.alphaMatValueB13
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B13

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
					if iter_4_0 ~= "B13" then
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
			local var_4_34 = 0.275

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

				local var_4_36 = arg_1_1:GetWordFromCfg(104062001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 11
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
	Play104062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104062002
		arg_8_1.duration_ = 7.23

		local var_8_0 = {
			ja = 7.233,
			ko = 2.266,
			zh = 4.066,
			en = 3.166
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
				arg_8_0:Play104062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.35

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[59].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(104062002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062002", "story_v_out_104062.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062002", "story_v_out_104062.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_104062", "104062002", "story_v_out_104062.awb")

						arg_8_1:RecordAudio("104062002", var_11_9)
						arg_8_1:RecordAudio("104062002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104062", "104062002", "story_v_out_104062.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104062", "104062002", "story_v_out_104062.awb")
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
	Play104062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104062003
		arg_12_1.duration_ = 9.03

		local var_12_0 = {
			ja = 9.033,
			ko = 6.3,
			zh = 8.533,
			en = 8.8
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
				arg_12_0:Play104062004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.75

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[59].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(104062003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062003", "story_v_out_104062.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062003", "story_v_out_104062.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_104062", "104062003", "story_v_out_104062.awb")

						arg_12_1:RecordAudio("104062003", var_15_9)
						arg_12_1:RecordAudio("104062003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104062", "104062003", "story_v_out_104062.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104062", "104062003", "story_v_out_104062.awb")
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
	Play104062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104062004
		arg_16_1.duration_ = 7.5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.bgs_.B13
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				local var_19_2 = var_19_0:GetComponent("SpriteRenderer")

				if var_19_2 then
					arg_16_1.var_.alphaOldValueB13 = var_19_2.color.a
					arg_16_1.var_.alphaMatValueB13 = var_19_2
				end

				arg_16_1.var_.alphaOldValueB13 = 1
			end

			local var_19_3 = 1.5

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Mathf.Lerp(arg_16_1.var_.alphaOldValueB13, 0, var_19_4)

				if arg_16_1.var_.alphaMatValueB13 then
					local var_19_6 = arg_16_1.var_.alphaMatValueB13.color

					var_19_6.a = var_19_5
					arg_16_1.var_.alphaMatValueB13.color = var_19_6
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 and arg_16_1.var_.alphaMatValueB13 then
				local var_19_7 = arg_16_1.var_.alphaMatValueB13
				local var_19_8 = var_19_7.color

				var_19_8.a = 0
				var_19_7.color = var_19_8
			end

			local var_19_9 = arg_16_1.bgs_.B13.transform
			local var_19_10 = 1.5

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPosB13 = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(0, -100, 10)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosB13, var_19_13, var_19_12)
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, -100, 10)
			end

			local var_19_14 = "ST03a"

			if arg_16_1.bgs_[var_19_14] == nil then
				local var_19_15 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_14)
				var_19_15.name = var_19_14
				var_19_15.transform.parent = arg_16_1.stage_.transform
				var_19_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_14] = var_19_15
			end

			local var_19_16 = arg_16_1.bgs_.ST03a
			local var_19_17 = 1.5

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				local var_19_18 = var_19_16:GetComponent("SpriteRenderer")

				if var_19_18 then
					arg_16_1.var_.alphaOldValueST03a = var_19_18.color.a
					arg_16_1.var_.alphaMatValueST03a = var_19_18
				end

				arg_16_1.var_.alphaOldValueST03a = 0
			end

			local var_19_19 = 1.5

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_19 then
				local var_19_20 = (arg_16_1.time_ - var_19_17) / var_19_19
				local var_19_21 = Mathf.Lerp(arg_16_1.var_.alphaOldValueST03a, 1, var_19_20)

				if arg_16_1.var_.alphaMatValueST03a then
					local var_19_22 = arg_16_1.var_.alphaMatValueST03a.color

					var_19_22.a = var_19_21
					arg_16_1.var_.alphaMatValueST03a.color = var_19_22
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_19 and arg_16_1.time_ < var_19_17 + var_19_19 + arg_19_0 and arg_16_1.var_.alphaMatValueST03a then
				local var_19_23 = arg_16_1.var_.alphaMatValueST03a
				local var_19_24 = var_19_23.color

				var_19_24.a = 1
				var_19_23.color = var_19_24
			end

			local var_19_25 = 1.5

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				local var_19_26 = manager.ui.mainCamera.transform.localPosition
				local var_19_27 = Vector3.New(0, 0, 10) + Vector3.New(var_19_26.x, var_19_26.y, 0)
				local var_19_28 = arg_16_1.bgs_.ST03a

				var_19_28.transform.localPosition = var_19_27
				var_19_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_29 = var_19_28:GetComponent("SpriteRenderer")

				if var_19_29 and var_19_29.sprite then
					local var_19_30 = (var_19_28.transform.localPosition - var_19_26).z
					local var_19_31 = manager.ui.mainCameraCom_
					local var_19_32 = 2 * var_19_30 * Mathf.Tan(var_19_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_33 = var_19_32 * var_19_31.aspect
					local var_19_34 = var_19_29.sprite.bounds.size.x
					local var_19_35 = var_19_29.sprite.bounds.size.y
					local var_19_36 = var_19_33 / var_19_34
					local var_19_37 = var_19_32 / var_19_35
					local var_19_38 = var_19_37 < var_19_36 and var_19_36 or var_19_37

					var_19_28.transform.localScale = Vector3.New(var_19_38, var_19_38, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST03a" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_39 = 0

			if var_19_39 < arg_16_1.time_ and arg_16_1.time_ <= var_19_39 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_40 = 1.5

			if arg_16_1.time_ >= var_19_39 + var_19_40 and arg_16_1.time_ < var_19_39 + var_19_40 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_41 = 2.5
			local var_19_42 = 0.45

			if var_19_41 < arg_16_1.time_ and arg_16_1.time_ <= var_19_41 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_43 = arg_16_1:GetWordFromCfg(104062004)
				local var_19_44 = arg_16_1:FormatText(var_19_43.content)

				arg_16_1.text_.text = var_19_44

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_45 = 18
				local var_19_46 = utf8.len(var_19_44)
				local var_19_47 = var_19_45 <= 0 and var_19_42 or var_19_42 * (var_19_46 / var_19_45)

				if var_19_47 > 0 and var_19_42 < var_19_47 then
					arg_16_1.talkMaxDuration = var_19_47

					if var_19_47 + var_19_41 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_47 + var_19_41
					end
				end

				arg_16_1.text_.text = var_19_44
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_48 = math.max(var_19_42, arg_16_1.talkMaxDuration)

			if var_19_41 <= arg_16_1.time_ and arg_16_1.time_ < var_19_41 + var_19_48 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_41) / var_19_48

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_41 + var_19_48 and arg_16_1.time_ < var_19_41 + var_19_48 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104062005
		arg_20_1.duration_ = 10.53

		local var_20_0 = {
			ja = 10.533,
			ko = 6.833,
			zh = 9,
			en = 6.9
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
				arg_20_0:Play104062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.875

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[59].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(104062005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 35
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062005", "story_v_out_104062.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062005", "story_v_out_104062.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_104062", "104062005", "story_v_out_104062.awb")

						arg_20_1:RecordAudio("104062005", var_23_9)
						arg_20_1:RecordAudio("104062005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104062", "104062005", "story_v_out_104062.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104062", "104062005", "story_v_out_104062.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104062006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.6

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

				local var_27_2 = arg_24_1:GetWordFromCfg(104062006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 24
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
	Play104062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104062007
		arg_28_1.duration_ = 5.2

		local var_28_0 = {
			ja = 5.2,
			ko = 4.133,
			zh = 3.733,
			en = 3.866
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
				arg_28_0:Play104062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "se_story", "se_story_robot_long", "")
			end

			local var_31_4 = "2070_tpose"

			if arg_28_1.actors_[var_31_4] == nil then
				local var_31_5 = Asset.Load("Char/" .. "2070_tpose")

				if not isNil(var_31_5) then
					local var_31_6 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_28_1.stage_.transform)

					var_31_6.name = var_31_4
					var_31_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_4] = var_31_6

					local var_31_7 = var_31_6:GetComponentInChildren(typeof(CharacterEffect))

					var_31_7.enabled = true

					local var_31_8 = GameObjectTools.GetOrAddComponent(var_31_6, typeof(DynamicBoneHelper))

					if var_31_8 then
						var_31_8:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_7.transform, false)

					arg_28_1.var_[var_31_4 .. "Animator"] = var_31_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_4 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_4 .. "LipSync"] = var_31_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_9 = arg_28_1.actors_["2070_tpose"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect2070_tpose == nil then
				arg_28_1.var_.characterEffect2070_tpose = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect2070_tpose and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect2070_tpose then
				arg_28_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_31_13 = 0
			local var_31_14 = 0.275

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_15 = arg_28_1:FormatText(StoryNameCfg[60].name)

				arg_28_1.leftNameTxt_.text = var_31_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_16 = arg_28_1:GetWordFromCfg(104062007)
				local var_31_17 = arg_28_1:FormatText(var_31_16.content)

				arg_28_1.text_.text = var_31_17

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_18 = 11
				local var_31_19 = utf8.len(var_31_17)
				local var_31_20 = var_31_18 <= 0 and var_31_14 or var_31_14 * (var_31_19 / var_31_18)

				if var_31_20 > 0 and var_31_14 < var_31_20 then
					arg_28_1.talkMaxDuration = var_31_20

					if var_31_20 + var_31_13 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_13
					end
				end

				arg_28_1.text_.text = var_31_17
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062007", "story_v_out_104062.awb") ~= 0 then
					local var_31_21 = manager.audio:GetVoiceLength("story_v_out_104062", "104062007", "story_v_out_104062.awb") / 1000

					if var_31_21 + var_31_13 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_21 + var_31_13
					end

					if var_31_16.prefab_name ~= "" and arg_28_1.actors_[var_31_16.prefab_name] ~= nil then
						local var_31_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_16.prefab_name].transform, "story_v_out_104062", "104062007", "story_v_out_104062.awb")

						arg_28_1:RecordAudio("104062007", var_31_22)
						arg_28_1:RecordAudio("104062007", var_31_22)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104062", "104062007", "story_v_out_104062.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104062", "104062007", "story_v_out_104062.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_23 = math.max(var_31_14, arg_28_1.talkMaxDuration)

			if var_31_13 <= arg_28_1.time_ and arg_28_1.time_ < var_31_13 + var_31_23 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_13) / var_31_23

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_13 + var_31_23 and arg_28_1.time_ < var_31_13 + var_31_23 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104062008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104062008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play104062009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["2070_tpose"]
			local var_35_1 = 2

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2070_tpose == nil then
				arg_32_1.var_.characterEffect2070_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect2070_tpose and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2070_tpose.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2070_tpose then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2070_tpose.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.bgs_.ST03a
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				local var_35_8 = var_35_6:GetComponent("SpriteRenderer")

				if var_35_8 then
					arg_32_1.var_.alphaOldValueST03a = var_35_8.color.a
					arg_32_1.var_.alphaMatValueST03a = var_35_8
				end

				arg_32_1.var_.alphaOldValueST03a = 1
			end

			local var_35_9 = 1.5

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_9 then
				local var_35_10 = (arg_32_1.time_ - var_35_7) / var_35_9
				local var_35_11 = Mathf.Lerp(arg_32_1.var_.alphaOldValueST03a, 0, var_35_10)

				if arg_32_1.var_.alphaMatValueST03a then
					local var_35_12 = arg_32_1.var_.alphaMatValueST03a.color

					var_35_12.a = var_35_11
					arg_32_1.var_.alphaMatValueST03a.color = var_35_12
				end
			end

			if arg_32_1.time_ >= var_35_7 + var_35_9 and arg_32_1.time_ < var_35_7 + var_35_9 + arg_35_0 and arg_32_1.var_.alphaMatValueST03a then
				local var_35_13 = arg_32_1.var_.alphaMatValueST03a
				local var_35_14 = var_35_13.color

				var_35_14.a = 0
				var_35_13.color = var_35_14
			end

			local var_35_15 = arg_32_1.bgs_.ST03a.transform
			local var_35_16 = 1.5

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.var_.moveOldPosST03a = var_35_15.localPosition
			end

			local var_35_17 = 0.001

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Vector3.New(0, -100, 10)

				var_35_15.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPosST03a, var_35_19, var_35_18)
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				var_35_15.localPosition = Vector3.New(0, -100, 10)
			end

			local var_35_20 = arg_32_1.bgs_.B13
			local var_35_21 = 1.5

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				local var_35_22 = var_35_20:GetComponent("SpriteRenderer")

				if var_35_22 then
					arg_32_1.var_.alphaOldValueB13 = var_35_22.color.a
					arg_32_1.var_.alphaMatValueB13 = var_35_22
				end

				arg_32_1.var_.alphaOldValueB13 = 0
			end

			local var_35_23 = 1.5

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_23 then
				local var_35_24 = (arg_32_1.time_ - var_35_21) / var_35_23
				local var_35_25 = Mathf.Lerp(arg_32_1.var_.alphaOldValueB13, 1, var_35_24)

				if arg_32_1.var_.alphaMatValueB13 then
					local var_35_26 = arg_32_1.var_.alphaMatValueB13.color

					var_35_26.a = var_35_25
					arg_32_1.var_.alphaMatValueB13.color = var_35_26
				end
			end

			if arg_32_1.time_ >= var_35_21 + var_35_23 and arg_32_1.time_ < var_35_21 + var_35_23 + arg_35_0 and arg_32_1.var_.alphaMatValueB13 then
				local var_35_27 = arg_32_1.var_.alphaMatValueB13
				local var_35_28 = var_35_27.color

				var_35_28.a = 1
				var_35_27.color = var_35_28
			end

			local var_35_29 = 1.5

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				local var_35_30 = manager.ui.mainCamera.transform.localPosition
				local var_35_31 = Vector3.New(0, 0, 10) + Vector3.New(var_35_30.x, var_35_30.y, 0)
				local var_35_32 = arg_32_1.bgs_.B13

				var_35_32.transform.localPosition = var_35_31
				var_35_32.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_33 = var_35_32:GetComponent("SpriteRenderer")

				if var_35_33 and var_35_33.sprite then
					local var_35_34 = (var_35_32.transform.localPosition - var_35_30).z
					local var_35_35 = manager.ui.mainCameraCom_
					local var_35_36 = 2 * var_35_34 * Mathf.Tan(var_35_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_37 = var_35_36 * var_35_35.aspect
					local var_35_38 = var_35_33.sprite.bounds.size.x
					local var_35_39 = var_35_33.sprite.bounds.size.y
					local var_35_40 = var_35_37 / var_35_38
					local var_35_41 = var_35_36 / var_35_39
					local var_35_42 = var_35_41 < var_35_40 and var_35_40 or var_35_41

					var_35_32.transform.localScale = Vector3.New(var_35_42, var_35_42, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "B13" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_43 = arg_32_1.actors_["2070_tpose"].transform
			local var_35_44 = 1.79999995231628

			if var_35_44 < arg_32_1.time_ and arg_32_1.time_ <= var_35_44 + arg_35_0 then
				arg_32_1.var_.moveOldPos2070_tpose = var_35_43.localPosition

				local var_35_45 = GameObjectTools.GetOrAddComponent(var_35_43.gameObject, typeof(DynamicBoneHelper))

				if var_35_45 then
					var_35_45:EnableDynamicBone(false)
				end
			end

			local var_35_46 = 0.001

			if var_35_44 <= arg_32_1.time_ and arg_32_1.time_ < var_35_44 + var_35_46 then
				local var_35_47 = (arg_32_1.time_ - var_35_44) / var_35_46
				local var_35_48 = Vector3.New(0, -0.49, -3.1)

				var_35_43.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos2070_tpose, var_35_48, var_35_47)

				local var_35_49 = manager.ui.mainCamera.transform.position - var_35_43.position

				var_35_43.forward = Vector3.New(var_35_49.x, var_35_49.y, var_35_49.z)

				local var_35_50 = var_35_43.localEulerAngles

				var_35_50.z = 0
				var_35_50.x = 0
				var_35_43.localEulerAngles = var_35_50
			end

			if arg_32_1.time_ >= var_35_44 + var_35_46 and arg_32_1.time_ < var_35_44 + var_35_46 + arg_35_0 then
				var_35_43.localPosition = Vector3.New(0, -0.49, -3.1)

				local var_35_51 = manager.ui.mainCamera.transform.position - var_35_43.position

				var_35_43.forward = Vector3.New(var_35_51.x, var_35_51.y, var_35_51.z)

				local var_35_52 = var_35_43.localEulerAngles

				var_35_52.z = 0
				var_35_52.x = 0
				var_35_43.localEulerAngles = var_35_52

				local var_35_53 = GameObjectTools.GetOrAddComponent(var_35_43.gameObject, typeof(DynamicBoneHelper))

				if var_35_53 then
					var_35_53:EnableDynamicBone(true)
				end
			end

			local var_35_54 = 0

			if var_35_54 < arg_32_1.time_ and arg_32_1.time_ <= var_35_54 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_55 = 2

			if arg_32_1.time_ >= var_35_54 + var_35_55 and arg_32_1.time_ < var_35_54 + var_35_55 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_56 = 2
			local var_35_57 = 0.7

			if var_35_56 < arg_32_1.time_ and arg_32_1.time_ <= var_35_56 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_58 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_58:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_59 = arg_32_1:GetWordFromCfg(104062008)
				local var_35_60 = arg_32_1:FormatText(var_35_59.content)

				arg_32_1.text_.text = var_35_60

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_61 = 28
				local var_35_62 = utf8.len(var_35_60)
				local var_35_63 = var_35_61 <= 0 and var_35_57 or var_35_57 * (var_35_62 / var_35_61)

				if var_35_63 > 0 and var_35_57 < var_35_63 then
					arg_32_1.talkMaxDuration = var_35_63
					var_35_56 = var_35_56 + 0.3

					if var_35_63 + var_35_56 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_63 + var_35_56
					end
				end

				arg_32_1.text_.text = var_35_60
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_64 = var_35_56 + 0.3
			local var_35_65 = math.max(var_35_57, arg_32_1.talkMaxDuration)

			if var_35_64 <= arg_32_1.time_ and arg_32_1.time_ < var_35_64 + var_35_65 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_64) / var_35_65

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_64 + var_35_65 and arg_32_1.time_ < var_35_64 + var_35_65 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104062009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104062009
		arg_38_1.duration_ = 6.87

		local var_38_0 = {
			ja = 6.866,
			ko = 6.266,
			zh = 4.4,
			en = 4.7
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
				arg_38_0:Play104062010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 1

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				local var_41_2 = "play"
				local var_41_3 = "effect"

				arg_38_1:AudioAction(var_41_2, var_41_3, "se_story", "se_story_robot_short", "")
			end

			local var_41_4 = arg_38_1.actors_["2070_tpose"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect2070_tpose == nil then
				arg_38_1.var_.characterEffect2070_tpose = var_41_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.1

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.characterEffect2070_tpose and not isNil(var_41_4) then
					arg_38_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect2070_tpose then
				arg_38_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_41_8 = 0
			local var_41_9 = 0.325

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_10 = arg_38_1:FormatText(StoryNameCfg[60].name)

				arg_38_1.leftNameTxt_.text = var_41_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_11 = arg_38_1:GetWordFromCfg(104062009)
				local var_41_12 = arg_38_1:FormatText(var_41_11.content)

				arg_38_1.text_.text = var_41_12

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 13
				local var_41_14 = utf8.len(var_41_12)
				local var_41_15 = var_41_13 <= 0 and var_41_9 or var_41_9 * (var_41_14 / var_41_13)

				if var_41_15 > 0 and var_41_9 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_12
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062009", "story_v_out_104062.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_out_104062", "104062009", "story_v_out_104062.awb") / 1000

					if var_41_16 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_8
					end

					if var_41_11.prefab_name ~= "" and arg_38_1.actors_[var_41_11.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_11.prefab_name].transform, "story_v_out_104062", "104062009", "story_v_out_104062.awb")

						arg_38_1:RecordAudio("104062009", var_41_17)
						arg_38_1:RecordAudio("104062009", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_104062", "104062009", "story_v_out_104062.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_104062", "104062009", "story_v_out_104062.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_18 and arg_38_1.time_ < var_41_8 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play104062010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104062010
		arg_42_1.duration_ = 1.6

		local var_42_0 = {
			ja = 1.466,
			ko = 1.3,
			zh = 1.2,
			en = 1.6
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
				arg_42_0:Play104062011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["2070_tpose"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect2070_tpose == nil then
				arg_42_1.var_.characterEffect2070_tpose = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.1

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect2070_tpose and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_42_1.var_.characterEffect2070_tpose.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect2070_tpose then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_42_1.var_.characterEffect2070_tpose.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.125

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[59].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_9 = arg_42_1:GetWordFromCfg(104062010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 5
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062010", "story_v_out_104062.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062010", "story_v_out_104062.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_out_104062", "104062010", "story_v_out_104062.awb")

						arg_42_1:RecordAudio("104062010", var_45_15)
						arg_42_1:RecordAudio("104062010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104062", "104062010", "story_v_out_104062.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104062", "104062010", "story_v_out_104062.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104062011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104062011
		arg_46_1.duration_ = 3.57

		local var_46_0 = {
			ja = 1.766,
			ko = 2.566,
			zh = 3.166,
			en = 3.566
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
				arg_46_0:Play104062012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["2070_tpose"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect2070_tpose == nil then
				arg_46_1.var_.characterEffect2070_tpose = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.1

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect2070_tpose and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect2070_tpose then
				arg_46_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_49_4 = 0
			local var_49_5 = 0.15

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_6 = arg_46_1:FormatText(StoryNameCfg[60].name)

				arg_46_1.leftNameTxt_.text = var_49_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(104062011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 6
				local var_49_10 = utf8.len(var_49_8)
				local var_49_11 = var_49_9 <= 0 and var_49_5 or var_49_5 * (var_49_10 / var_49_9)

				if var_49_11 > 0 and var_49_5 < var_49_11 then
					arg_46_1.talkMaxDuration = var_49_11

					if var_49_11 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062011", "story_v_out_104062.awb") ~= 0 then
					local var_49_12 = manager.audio:GetVoiceLength("story_v_out_104062", "104062011", "story_v_out_104062.awb") / 1000

					if var_49_12 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_4
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_104062", "104062011", "story_v_out_104062.awb")

						arg_46_1:RecordAudio("104062011", var_49_13)
						arg_46_1:RecordAudio("104062011", var_49_13)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104062", "104062011", "story_v_out_104062.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104062", "104062011", "story_v_out_104062.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_14 and arg_46_1.time_ < var_49_4 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104062012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104062012
		arg_50_1.duration_ = 8.2

		local var_50_0 = {
			ja = 8.2,
			ko = 4.933,
			zh = 5.766,
			en = 5.733
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
				arg_50_0:Play104062013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["2070_tpose"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect2070_tpose == nil then
				arg_50_1.var_.characterEffect2070_tpose = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect2070_tpose and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_50_1.var_.characterEffect2070_tpose.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect2070_tpose then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_50_1.var_.characterEffect2070_tpose.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.775

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[59].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(104062012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 31
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062012", "story_v_out_104062.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062012", "story_v_out_104062.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_104062", "104062012", "story_v_out_104062.awb")

						arg_50_1:RecordAudio("104062012", var_53_15)
						arg_50_1:RecordAudio("104062012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104062", "104062012", "story_v_out_104062.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104062", "104062012", "story_v_out_104062.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104062013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104062013
		arg_54_1.duration_ = 8.77

		local var_54_0 = {
			ja = 8.766,
			ko = 5.9,
			zh = 6,
			en = 6.1
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104062014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 1

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				local var_57_2 = "play"
				local var_57_3 = "effect"

				arg_54_1:AudioAction(var_57_2, var_57_3, "se_story", "se_story_robot_long", "")
			end

			local var_57_4 = arg_54_1.actors_["2070_tpose"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect2070_tpose == nil then
				arg_54_1.var_.characterEffect2070_tpose = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.1

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect2070_tpose and not isNil(var_57_4) then
					arg_54_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect2070_tpose then
				arg_54_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_57_8 = 0
			local var_57_9 = 0.45

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_10 = arg_54_1:FormatText(StoryNameCfg[60].name)

				arg_54_1.leftNameTxt_.text = var_57_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_11 = arg_54_1:GetWordFromCfg(104062013)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 18
				local var_57_14 = utf8.len(var_57_12)
				local var_57_15 = var_57_13 <= 0 and var_57_9 or var_57_9 * (var_57_14 / var_57_13)

				if var_57_15 > 0 and var_57_9 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_12
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062013", "story_v_out_104062.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_104062", "104062013", "story_v_out_104062.awb") / 1000

					if var_57_16 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_8
					end

					if var_57_11.prefab_name ~= "" and arg_54_1.actors_[var_57_11.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_11.prefab_name].transform, "story_v_out_104062", "104062013", "story_v_out_104062.awb")

						arg_54_1:RecordAudio("104062013", var_57_17)
						arg_54_1:RecordAudio("104062013", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104062", "104062013", "story_v_out_104062.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104062", "104062013", "story_v_out_104062.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_18 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_18

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_18 and arg_54_1.time_ < var_57_8 + var_57_18 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104062014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104062014
		arg_58_1.duration_ = 0.97

		local var_58_0 = {
			ja = 0.733,
			ko = 0.933,
			zh = 0.966,
			en = 0.7
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
				arg_58_0:Play104062015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["2070_tpose"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect2070_tpose == nil then
				arg_58_1.var_.characterEffect2070_tpose = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect2070_tpose and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_58_1.var_.characterEffect2070_tpose.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect2070_tpose then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_58_1.var_.characterEffect2070_tpose.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.05

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[59].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:GetWordFromCfg(104062014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 2
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062014", "story_v_out_104062.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062014", "story_v_out_104062.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_104062", "104062014", "story_v_out_104062.awb")

						arg_58_1:RecordAudio("104062014", var_61_15)
						arg_58_1:RecordAudio("104062014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_104062", "104062014", "story_v_out_104062.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_104062", "104062014", "story_v_out_104062.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play104062015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104062015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104062016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["2070_tpose"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos2070_tpose = var_65_0.localPosition

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end
			end

			local var_65_3 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_3 then
				local var_65_4 = (arg_62_1.time_ - var_65_1) / var_65_3
				local var_65_5 = Vector3.New(0, 100, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos2070_tpose, var_65_5, var_65_4)

				local var_65_6 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_6.x, var_65_6.y, var_65_6.z)

				local var_65_7 = var_65_0.localEulerAngles

				var_65_7.z = 0
				var_65_7.x = 0
				var_65_0.localEulerAngles = var_65_7
			end

			if arg_62_1.time_ >= var_65_1 + var_65_3 and arg_62_1.time_ < var_65_1 + var_65_3 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, 100, 0)

				local var_65_8 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_8.x, var_65_8.y, var_65_8.z)

				local var_65_9 = var_65_0.localEulerAngles

				var_65_9.z = 0
				var_65_9.x = 0
				var_65_0.localEulerAngles = var_65_9

				local var_65_10 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_10 then
					var_65_10:EnableDynamicBone(true)
				end
			end

			local var_65_11 = 0
			local var_65_12 = 0.925

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_13 = arg_62_1:GetWordFromCfg(104062015)
				local var_65_14 = arg_62_1:FormatText(var_65_13.content)

				arg_62_1.text_.text = var_65_14

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_15 = 37
				local var_65_16 = utf8.len(var_65_14)
				local var_65_17 = var_65_15 <= 0 and var_65_12 or var_65_12 * (var_65_16 / var_65_15)

				if var_65_17 > 0 and var_65_12 < var_65_17 then
					arg_62_1.talkMaxDuration = var_65_17

					if var_65_17 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_17 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_14
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_18 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_18 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_11) / var_65_18

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_11 + var_65_18 and arg_62_1.time_ < var_65_11 + var_65_18 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
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
	Play104062016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104062016
		arg_66_1.duration_ = 5.77

		local var_66_0 = {
			ja = 5.766,
			ko = 2.666,
			zh = 2.666,
			en = 4.266
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
				arg_66_0:Play104062017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.3

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[59].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(104062016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 10
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062016", "story_v_out_104062.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062016", "story_v_out_104062.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_104062", "104062016", "story_v_out_104062.awb")

						arg_66_1:RecordAudio("104062016", var_69_9)
						arg_66_1:RecordAudio("104062016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104062", "104062016", "story_v_out_104062.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104062", "104062016", "story_v_out_104062.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104062017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104062017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104062018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.875

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(104062017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 35
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104062018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104062018
		arg_74_1.duration_ = 4.9

		local var_74_0 = {
			ja = 4.9,
			ko = 2.3,
			zh = 3.1,
			en = 3.066
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
				arg_74_0:Play104062019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.4

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[59].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(104062018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 16
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062018", "story_v_out_104062.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062018", "story_v_out_104062.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_104062", "104062018", "story_v_out_104062.awb")

						arg_74_1:RecordAudio("104062018", var_77_9)
						arg_74_1:RecordAudio("104062018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104062", "104062018", "story_v_out_104062.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104062", "104062018", "story_v_out_104062.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104062019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104062019
		arg_78_1.duration_ = 6.67

		local var_78_0 = {
			ja = 6.666,
			ko = 4.566,
			zh = 4.7,
			en = 4.6
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
				arg_78_0:Play104062020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_2 = "play"
				local var_81_3 = "effect"

				arg_78_1:AudioAction(var_81_2, var_81_3, "se_story", "se_story_robot_short", "")
			end

			local var_81_4 = arg_78_1.actors_["2070_tpose"].transform
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.var_.moveOldPos2070_tpose = var_81_4.localPosition

				local var_81_6 = GameObjectTools.GetOrAddComponent(var_81_4.gameObject, typeof(DynamicBoneHelper))

				if var_81_6 then
					var_81_6:EnableDynamicBone(false)
				end
			end

			local var_81_7 = 0.001

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_7 then
				local var_81_8 = (arg_78_1.time_ - var_81_5) / var_81_7
				local var_81_9 = Vector3.New(0, -0.49, -3.1)

				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2070_tpose, var_81_9, var_81_8)

				local var_81_10 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_10.x, var_81_10.y, var_81_10.z)

				local var_81_11 = var_81_4.localEulerAngles

				var_81_11.z = 0
				var_81_11.x = 0
				var_81_4.localEulerAngles = var_81_11
			end

			if arg_78_1.time_ >= var_81_5 + var_81_7 and arg_78_1.time_ < var_81_5 + var_81_7 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(0, -0.49, -3.1)

				local var_81_12 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_12.x, var_81_12.y, var_81_12.z)

				local var_81_13 = var_81_4.localEulerAngles

				var_81_13.z = 0
				var_81_13.x = 0
				var_81_4.localEulerAngles = var_81_13

				local var_81_14 = GameObjectTools.GetOrAddComponent(var_81_4.gameObject, typeof(DynamicBoneHelper))

				if var_81_14 then
					var_81_14:EnableDynamicBone(true)
				end
			end

			local var_81_15 = arg_78_1.actors_["2070_tpose"]
			local var_81_16 = 0

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 and not isNil(var_81_15) and arg_78_1.var_.characterEffect2070_tpose == nil then
				arg_78_1.var_.characterEffect2070_tpose = var_81_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_17 = 0.1

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_17 and not isNil(var_81_15) then
				local var_81_18 = (arg_78_1.time_ - var_81_16) / var_81_17

				if arg_78_1.var_.characterEffect2070_tpose and not isNil(var_81_15) then
					arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 and not isNil(var_81_15) and arg_78_1.var_.characterEffect2070_tpose then
				arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_81_19 = 0
			local var_81_20 = 0.25

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_21 = arg_78_1:FormatText(StoryNameCfg[60].name)

				arg_78_1.leftNameTxt_.text = var_81_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_22 = arg_78_1:GetWordFromCfg(104062019)
				local var_81_23 = arg_78_1:FormatText(var_81_22.content)

				arg_78_1.text_.text = var_81_23

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_24 = 10
				local var_81_25 = utf8.len(var_81_23)
				local var_81_26 = var_81_24 <= 0 and var_81_20 or var_81_20 * (var_81_25 / var_81_24)

				if var_81_26 > 0 and var_81_20 < var_81_26 then
					arg_78_1.talkMaxDuration = var_81_26

					if var_81_26 + var_81_19 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_26 + var_81_19
					end
				end

				arg_78_1.text_.text = var_81_23
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062019", "story_v_out_104062.awb") ~= 0 then
					local var_81_27 = manager.audio:GetVoiceLength("story_v_out_104062", "104062019", "story_v_out_104062.awb") / 1000

					if var_81_27 + var_81_19 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_27 + var_81_19
					end

					if var_81_22.prefab_name ~= "" and arg_78_1.actors_[var_81_22.prefab_name] ~= nil then
						local var_81_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_22.prefab_name].transform, "story_v_out_104062", "104062019", "story_v_out_104062.awb")

						arg_78_1:RecordAudio("104062019", var_81_28)
						arg_78_1:RecordAudio("104062019", var_81_28)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104062", "104062019", "story_v_out_104062.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104062", "104062019", "story_v_out_104062.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_29 = math.max(var_81_20, arg_78_1.talkMaxDuration)

			if var_81_19 <= arg_78_1.time_ and arg_78_1.time_ < var_81_19 + var_81_29 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_19) / var_81_29

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_19 + var_81_29 and arg_78_1.time_ < var_81_19 + var_81_29 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104062020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104062020
		arg_82_1.duration_ = 5.53

		local var_82_0 = {
			ja = 5.533,
			ko = 2.6,
			zh = 3.8,
			en = 3.6
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
				arg_82_0:Play104062021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["2070_tpose"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2070_tpose == nil then
				arg_82_1.var_.characterEffect2070_tpose = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect2070_tpose and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_82_1.var_.characterEffect2070_tpose.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2070_tpose then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_82_1.var_.characterEffect2070_tpose.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.3

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[59].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_9 = arg_82_1:GetWordFromCfg(104062020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 12
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062020", "story_v_out_104062.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062020", "story_v_out_104062.awb") / 1000

					if var_85_14 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_6
					end

					if var_85_9.prefab_name ~= "" and arg_82_1.actors_[var_85_9.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_9.prefab_name].transform, "story_v_out_104062", "104062020", "story_v_out_104062.awb")

						arg_82_1:RecordAudio("104062020", var_85_15)
						arg_82_1:RecordAudio("104062020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104062", "104062020", "story_v_out_104062.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104062", "104062020", "story_v_out_104062.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_16 and arg_82_1.time_ < var_85_6 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play104062021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104062021
		arg_86_1.duration_ = 7.5

		local var_86_0 = {
			ja = 4.6,
			ko = 5.066,
			zh = 7.5,
			en = 7.333
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
				arg_86_0:Play104062022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				local var_89_2 = "play"
				local var_89_3 = "effect"

				arg_86_1:AudioAction(var_89_2, var_89_3, "se_story", "se_story_robot_excited", "")
			end

			local var_89_4 = arg_86_1.actors_["2070_tpose"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect2070_tpose == nil then
				arg_86_1.var_.characterEffect2070_tpose = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.1

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect2070_tpose and not isNil(var_89_4) then
					arg_86_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect2070_tpose then
				arg_86_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_89_8 = 0
			local var_89_9 = 0.475

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_10 = arg_86_1:FormatText(StoryNameCfg[60].name)

				arg_86_1.leftNameTxt_.text = var_89_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_11 = arg_86_1:GetWordFromCfg(104062021)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 19
				local var_89_14 = utf8.len(var_89_12)
				local var_89_15 = var_89_13 <= 0 and var_89_9 or var_89_9 * (var_89_14 / var_89_13)

				if var_89_15 > 0 and var_89_9 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_12
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062021", "story_v_out_104062.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_104062", "104062021", "story_v_out_104062.awb") / 1000

					if var_89_16 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_8
					end

					if var_89_11.prefab_name ~= "" and arg_86_1.actors_[var_89_11.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_11.prefab_name].transform, "story_v_out_104062", "104062021", "story_v_out_104062.awb")

						arg_86_1:RecordAudio("104062021", var_89_17)
						arg_86_1:RecordAudio("104062021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_104062", "104062021", "story_v_out_104062.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_104062", "104062021", "story_v_out_104062.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_18 and arg_86_1.time_ < var_89_8 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play104062022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104062022
		arg_90_1.duration_ = 7.4

		local var_90_0 = {
			ja = 2.8,
			ko = 3.166,
			zh = 4.6,
			en = 7.4
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
			arg_90_1.auto_ = false
		end

		function arg_90_1.playNext_(arg_92_0)
			arg_90_1.onStoryFinished_()
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_1 = 0.5

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_1 then
				local var_93_2 = (arg_90_1.time_ - var_93_0) / var_93_1
				local var_93_3 = Color.New(1, 1, 1)

				var_93_3.a = Mathf.Lerp(1, 0, var_93_2)
				arg_90_1.mask_.color = var_93_3
			end

			if arg_90_1.time_ >= var_93_0 + var_93_1 and arg_90_1.time_ < var_93_0 + var_93_1 + arg_93_0 then
				local var_93_4 = Color.New(1, 1, 1)
				local var_93_5 = 0

				arg_90_1.mask_.enabled = false
				var_93_4.a = var_93_5
				arg_90_1.mask_.color = var_93_4
			end

			local var_93_6 = manager.ui.mainCamera.transform
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.var_.shakeOldPosMainCamera = var_93_6.localPosition
			end

			local var_93_8 = 0.600000023841858

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / 0.066
				local var_93_10, var_93_11 = math.modf(var_93_9)

				var_93_6.localPosition = Vector3.New(var_93_11 * 0.13, var_93_11 * 0.13, var_93_11 * 0.13) + arg_90_1.var_.shakeOldPosMainCamera
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 then
				var_93_6.localPosition = arg_90_1.var_.shakeOldPosMainCamera
			end

			local var_93_12 = arg_90_1.actors_["2070_tpose"]
			local var_93_13 = 0

			if var_93_13 < arg_90_1.time_ and arg_90_1.time_ <= var_93_13 + arg_93_0 and not isNil(var_93_12) and arg_90_1.var_.characterEffect2070_tpose == nil then
				arg_90_1.var_.characterEffect2070_tpose = var_93_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_14 = 0.1

			if var_93_13 <= arg_90_1.time_ and arg_90_1.time_ < var_93_13 + var_93_14 and not isNil(var_93_12) then
				local var_93_15 = (arg_90_1.time_ - var_93_13) / var_93_14

				if arg_90_1.var_.characterEffect2070_tpose and not isNil(var_93_12) then
					local var_93_16 = Mathf.Lerp(0, 0.5, var_93_15)

					arg_90_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_90_1.var_.characterEffect2070_tpose.fillRatio = var_93_16
				end
			end

			if arg_90_1.time_ >= var_93_13 + var_93_14 and arg_90_1.time_ < var_93_13 + var_93_14 + arg_93_0 and not isNil(var_93_12) and arg_90_1.var_.characterEffect2070_tpose then
				local var_93_17 = 0.5

				arg_90_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_90_1.var_.characterEffect2070_tpose.fillRatio = var_93_17
			end

			local var_93_18 = 0
			local var_93_19 = 0.45

			if var_93_18 < arg_90_1.time_ and arg_90_1.time_ <= var_93_18 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_20 = arg_90_1:FormatText(StoryNameCfg[59].name)

				arg_90_1.leftNameTxt_.text = var_93_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_21 = arg_90_1:GetWordFromCfg(104062022)
				local var_93_22 = arg_90_1:FormatText(var_93_21.content)

				arg_90_1.text_.text = var_93_22

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_23 = 18
				local var_93_24 = utf8.len(var_93_22)
				local var_93_25 = var_93_23 <= 0 and var_93_19 or var_93_19 * (var_93_24 / var_93_23)

				if var_93_25 > 0 and var_93_19 < var_93_25 then
					arg_90_1.talkMaxDuration = var_93_25

					if var_93_25 + var_93_18 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_25 + var_93_18
					end
				end

				arg_90_1.text_.text = var_93_22
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062022", "story_v_out_104062.awb") ~= 0 then
					local var_93_26 = manager.audio:GetVoiceLength("story_v_out_104062", "104062022", "story_v_out_104062.awb") / 1000

					if var_93_26 + var_93_18 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_26 + var_93_18
					end

					if var_93_21.prefab_name ~= "" and arg_90_1.actors_[var_93_21.prefab_name] ~= nil then
						local var_93_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_21.prefab_name].transform, "story_v_out_104062", "104062022", "story_v_out_104062.awb")

						arg_90_1:RecordAudio("104062022", var_93_27)
						arg_90_1:RecordAudio("104062022", var_93_27)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104062", "104062022", "story_v_out_104062.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104062", "104062022", "story_v_out_104062.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_28 = math.max(var_93_19, arg_90_1.talkMaxDuration)

			if var_93_18 <= arg_90_1.time_ and arg_90_1.time_ < var_93_18 + var_93_28 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_18) / var_93_28

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_18 + var_93_28 and arg_90_1.time_ < var_93_18 + var_93_28 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_104062.awb"
	}
}
