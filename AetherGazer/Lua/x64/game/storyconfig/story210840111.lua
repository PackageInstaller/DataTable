return {
	Play1108411001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108411001
		arg_1_1.duration_ = 3.93

		local var_1_0 = {
			zh = 3.33333333333333,
			ja = 3.93333333333333
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
				arg_1_0:Play1108411002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 1.13333333333333
			local var_4_31 = 0.5

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_33 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:GetWordFromCfg(1108411001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 20
				local var_4_37 = utf8.len(var_4_35)
				local var_4_38 = var_4_36 <= 0 and var_4_31 or var_4_31 * (var_4_37 / var_4_36)

				if var_4_38 > 0 and var_4_31 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_30 = var_4_30 + 0.3

					if var_4_38 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb") / 1000

					if var_4_39 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_30
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")

						arg_1_1:RecordAudio("1108411001", var_4_40)
						arg_1_1:RecordAudio("1108411001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_30 + 0.3
			local var_4_42 = math.max(var_4_31, arg_1_1.talkMaxDuration)

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
	Play1108411002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108411002
		arg_8_1.duration_ = 5.83

		local var_8_0 = {
			zh = 4.9,
			ja = 5.833
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
				arg_8_0:Play1108411003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.425

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(1108411002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")

						arg_8_1:RecordAudio("1108411002", var_11_9)
						arg_8_1:RecordAudio("1108411002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")
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
	Play1108411003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108411003
		arg_12_1.duration_ = 3.77

		local var_12_0 = {
			zh = 3,
			ja = 3.766
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
				arg_12_0:Play1108411004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.35

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(1108411003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")

						arg_12_1:RecordAudio("1108411003", var_15_9)
						arg_12_1:RecordAudio("1108411003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")
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
	Play1108411004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108411004
		arg_16_1.duration_ = 3.7

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108411005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "ST01"

			if arg_16_1.bgs_[var_19_0] == nil then
				local var_19_1 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_0)
				var_19_1.name = var_19_0
				var_19_1.transform.parent = arg_16_1.stage_.transform
				var_19_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_0] = var_19_1
			end

			local var_19_2 = 0

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_3 = manager.ui.mainCamera.transform.localPosition
				local var_19_4 = Vector3.New(0, 0, 10) + Vector3.New(var_19_3.x, var_19_3.y, 0)
				local var_19_5 = arg_16_1.bgs_.ST01

				var_19_5.transform.localPosition = var_19_4
				var_19_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_6 = var_19_5:GetComponent("SpriteRenderer")

				if var_19_6 and var_19_6.sprite then
					local var_19_7 = (var_19_5.transform.localPosition - var_19_3).z
					local var_19_8 = manager.ui.mainCameraCom_
					local var_19_9 = 2 * var_19_7 * Mathf.Tan(var_19_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_10 = var_19_9 * var_19_8.aspect
					local var_19_11 = var_19_6.sprite.bounds.size.x
					local var_19_12 = var_19_6.sprite.bounds.size.y
					local var_19_13 = var_19_10 / var_19_11
					local var_19_14 = var_19_9 / var_19_12
					local var_19_15 = var_19_14 < var_19_13 and var_19_13 or var_19_14

					var_19_5.transform.localScale = Vector3.New(var_19_15, var_19_15, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST01" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_17 = 0.3

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_19 = 1.999999999999

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_19 then
				local var_19_20 = (arg_16_1.time_ - var_19_18) / var_19_19
				local var_19_21 = Color.New(0, 0, 0)

				var_19_21.a = Mathf.Lerp(1, 0, var_19_20)
				arg_16_1.mask_.color = var_19_21
			end

			if arg_16_1.time_ >= var_19_18 + var_19_19 and arg_16_1.time_ < var_19_18 + var_19_19 + arg_19_0 then
				local var_19_22 = Color.New(0, 0, 0)
				local var_19_23 = 0

				arg_16_1.mask_.enabled = false
				var_19_22.a = var_19_23
				arg_16_1.mask_.color = var_19_22
			end

			local var_19_24 = "10102ui_story"

			if arg_16_1.actors_[var_19_24] == nil then
				local var_19_25 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_19_25) then
					local var_19_26 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_16_1.stage_.transform)

					var_19_26.name = var_19_24
					var_19_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_24] = var_19_26

					local var_19_27 = var_19_26:GetComponentInChildren(typeof(CharacterEffect))

					var_19_27.enabled = true

					local var_19_28 = GameObjectTools.GetOrAddComponent(var_19_26, typeof(DynamicBoneHelper))

					if var_19_28 then
						var_19_28:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_27.transform, false)

					arg_16_1.var_[var_19_24 .. "Animator"] = var_19_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_24 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_24 .. "LipSync"] = var_19_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_29 = arg_16_1.actors_["10102ui_story"].transform
			local var_19_30 = 1.7

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				arg_16_1.var_.moveOldPos10102ui_story = var_19_29.localPosition
			end

			local var_19_31 = 0.001

			if var_19_30 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_31 then
				local var_19_32 = (arg_16_1.time_ - var_19_30) / var_19_31
				local var_19_33 = Vector3.New(0, -0.985, -6.275)

				var_19_29.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10102ui_story, var_19_33, var_19_32)

				local var_19_34 = manager.ui.mainCamera.transform.position - var_19_29.position

				var_19_29.forward = Vector3.New(var_19_34.x, var_19_34.y, var_19_34.z)

				local var_19_35 = var_19_29.localEulerAngles

				var_19_35.z = 0
				var_19_35.x = 0
				var_19_29.localEulerAngles = var_19_35
			end

			if arg_16_1.time_ >= var_19_30 + var_19_31 and arg_16_1.time_ < var_19_30 + var_19_31 + arg_19_0 then
				var_19_29.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_19_36 = manager.ui.mainCamera.transform.position - var_19_29.position

				var_19_29.forward = Vector3.New(var_19_36.x, var_19_36.y, var_19_36.z)

				local var_19_37 = var_19_29.localEulerAngles

				var_19_37.z = 0
				var_19_37.x = 0
				var_19_29.localEulerAngles = var_19_37
			end

			local var_19_38 = arg_16_1.actors_["10102ui_story"]
			local var_19_39 = 1.7

			if var_19_39 < arg_16_1.time_ and arg_16_1.time_ <= var_19_39 + arg_19_0 and not isNil(var_19_38) and arg_16_1.var_.characterEffect10102ui_story == nil then
				arg_16_1.var_.characterEffect10102ui_story = var_19_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_40 = 0.200000002980232

			if var_19_39 <= arg_16_1.time_ and arg_16_1.time_ < var_19_39 + var_19_40 and not isNil(var_19_38) then
				local var_19_41 = (arg_16_1.time_ - var_19_39) / var_19_40

				if arg_16_1.var_.characterEffect10102ui_story and not isNil(var_19_38) then
					arg_16_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_39 + var_19_40 and arg_16_1.time_ < var_19_39 + var_19_40 + arg_19_0 and not isNil(var_19_38) and arg_16_1.var_.characterEffect10102ui_story then
				arg_16_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_19_42 = 1.7

			if var_19_42 < arg_16_1.time_ and arg_16_1.time_ <= var_19_42 + arg_19_0 then
				arg_16_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_19_43 = 1.13333333333333

			if var_19_43 < arg_16_1.time_ and arg_16_1.time_ <= var_19_43 + arg_19_0 then
				arg_16_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_19_44 = 0
			local var_19_45 = 0.3

			if var_19_44 < arg_16_1.time_ and arg_16_1.time_ <= var_19_44 + arg_19_0 then
				local var_19_46 = "play"
				local var_19_47 = "music"

				arg_16_1:AudioAction(var_19_46, var_19_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_19_48 = ""
				local var_19_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_19_49 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_49 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_49

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_49
						arg_16_1.bgmTxt2_.text = var_19_49
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_50 = 0.466666666666667
			local var_19_51 = 1

			if var_19_50 < arg_16_1.time_ and arg_16_1.time_ <= var_19_50 + arg_19_0 then
				local var_19_52 = "play"
				local var_19_53 = "music"

				arg_16_1:AudioAction(var_19_52, var_19_53, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_19_54 = ""
				local var_19_55 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_19_55 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_55 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_55

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_55
						arg_16_1.bgmTxt2_.text = var_19_55
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_56 = 0.166666666666667
			local var_19_57 = 1

			if var_19_56 < arg_16_1.time_ and arg_16_1.time_ <= var_19_56 + arg_19_0 then
				local var_19_58 = "play"
				local var_19_59 = "effect"

				arg_16_1:AudioAction(var_19_58, var_19_59, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_19_60 = 1.46666666666667
			local var_19_61 = 1

			if var_19_60 < arg_16_1.time_ and arg_16_1.time_ <= var_19_60 + arg_19_0 then
				local var_19_62 = "play"
				local var_19_63 = "effect"

				arg_16_1:AudioAction(var_19_62, var_19_63, "se_story_144", "se_story_144_door_open", "")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_64 = 1.949999999999
			local var_19_65 = 0.05

			if var_19_64 < arg_16_1.time_ and arg_16_1.time_ <= var_19_64 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_66 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_66:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_67 = arg_16_1:FormatText(StoryNameCfg[334].name)

				arg_16_1.leftNameTxt_.text = var_19_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_68 = arg_16_1:GetWordFromCfg(1108411004)
				local var_19_69 = arg_16_1:FormatText(var_19_68.content)

				arg_16_1.text_.text = var_19_69

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_70 = 2
				local var_19_71 = utf8.len(var_19_69)
				local var_19_72 = var_19_70 <= 0 and var_19_65 or var_19_65 * (var_19_71 / var_19_70)

				if var_19_72 > 0 and var_19_65 < var_19_72 then
					arg_16_1.talkMaxDuration = var_19_72
					var_19_64 = var_19_64 + 0.3

					if var_19_72 + var_19_64 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_72 + var_19_64
					end
				end

				arg_16_1.text_.text = var_19_69
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb") ~= 0 then
					local var_19_73 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb") / 1000

					if var_19_73 + var_19_64 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_73 + var_19_64
					end

					if var_19_68.prefab_name ~= "" and arg_16_1.actors_[var_19_68.prefab_name] ~= nil then
						local var_19_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_68.prefab_name].transform, "story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")

						arg_16_1:RecordAudio("1108411004", var_19_74)
						arg_16_1:RecordAudio("1108411004", var_19_74)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_75 = var_19_64 + 0.3
			local var_19_76 = math.max(var_19_65, arg_16_1.talkMaxDuration)

			if var_19_75 <= arg_16_1.time_ and arg_16_1.time_ < var_19_75 + var_19_76 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_75) / var_19_76

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_75 + var_19_76 and arg_16_1.time_ < var_19_75 + var_19_76 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1108411005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108411005
		arg_24_1.duration_ = 1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"

			SetActive(arg_24_1.choicesGo_, true)

			for iter_25_0, iter_25_1 in ipairs(arg_24_1.choices_) do
				local var_25_0 = iter_25_0 <= 2

				SetActive(iter_25_1.go, var_25_0)
			end

			arg_24_1.choices_[1].txt.text = arg_24_1:FormatText(StoryChoiceCfg[1541].name)
			arg_24_1.choices_[2].txt.text = arg_24_1:FormatText(StoryChoiceCfg[1542].name)
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108411006(arg_24_1)
			end

			if arg_26_0 == 2 then
				arg_24_0:Play1108411009(arg_24_1)
			end

			arg_24_1:RecordChoiceLog(1108411005, 1541, 1542)
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10102ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10102ui_story == nil then
				arg_24_1.var_.characterEffect10102ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10102ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10102ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10102ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10102ui_story.fillRatio = var_27_5
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108411006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108411006
		arg_28_1.duration_ = 5.9

		local var_28_0 = {
			zh = 3.2,
			ja = 5.9
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
				arg_28_0:Play1108411007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10102ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10102ui_story == nil then
				arg_28_1.var_.characterEffect10102ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10102ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10102ui_story then
				arg_28_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_31_5 = 0
			local var_31_6 = 0.325

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_7 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(1108411006)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 13
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_6 or var_31_6 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_6 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb") ~= 0 then
					local var_31_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb") / 1000

					if var_31_13 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_5
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")

						arg_28_1:RecordAudio("1108411006", var_31_14)
						arg_28_1:RecordAudio("1108411006", var_31_14)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_15 and arg_28_1.time_ < var_31_5 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108411007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108411007
		arg_32_1.duration_ = 4.7

		local var_32_0 = {
			zh = 4,
			ja = 4.7
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
				arg_32_0:Play1108411008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.325

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(1108411007)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 13
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")

						arg_32_1:RecordAudio("1108411007", var_35_9)
						arg_32_1:RecordAudio("1108411007", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1108411008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108411008
		arg_36_1.duration_ = 3.5

		local var_36_0 = {
			zh = 3,
			ja = 3.5
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
				arg_36_0:Play1108411009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.325

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_4 = arg_36_1:FormatText(StoryNameCfg[334].name)

				arg_36_1.leftNameTxt_.text = var_39_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(1108411008)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 13
				local var_39_8 = utf8.len(var_39_6)
				local var_39_9 = var_39_7 <= 0 and var_39_3 or var_39_3 * (var_39_8 / var_39_7)

				if var_39_9 > 0 and var_39_3 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb") / 1000

					if var_39_10 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_2
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")

						arg_36_1:RecordAudio("1108411008", var_39_11)
						arg_36_1:RecordAudio("1108411008", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_12 and arg_36_1.time_ < var_39_2 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1108411009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108411009
		arg_40_1.duration_ = 4.67

		local var_40_0 = {
			zh = 3.066,
			ja = 4.666
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
				arg_40_0:Play1108411010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "10102ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_43_6 = "10102ui_story"

			if arg_40_1.actors_[var_43_6] == nil then
				local var_43_7 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_43_7) then
					local var_43_8 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_40_1.stage_.transform)

					var_43_8.name = var_43_6
					var_43_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_6] = var_43_8

					local var_43_9 = var_43_8:GetComponentInChildren(typeof(CharacterEffect))

					var_43_9.enabled = true

					local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_8, typeof(DynamicBoneHelper))

					if var_43_10 then
						var_43_10:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_9.transform, false)

					arg_40_1.var_[var_43_6 .. "Animator"] = var_43_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_6 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_6 .. "LipSync"] = var_43_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_43_12 = arg_40_1.actors_["10102ui_story"]
			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 and not isNil(var_43_12) and arg_40_1.var_.characterEffect10102ui_story == nil then
				arg_40_1.var_.characterEffect10102ui_story = var_43_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_14 = 0.200000002980232

			if var_43_13 <= arg_40_1.time_ and arg_40_1.time_ < var_43_13 + var_43_14 and not isNil(var_43_12) then
				local var_43_15 = (arg_40_1.time_ - var_43_13) / var_43_14

				if arg_40_1.var_.characterEffect10102ui_story and not isNil(var_43_12) then
					arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_13 + var_43_14 and arg_40_1.time_ < var_43_13 + var_43_14 + arg_43_0 and not isNil(var_43_12) and arg_40_1.var_.characterEffect10102ui_story then
				arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_43_16 = 0
			local var_43_17 = 0.35

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_18 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_19 = arg_40_1:GetWordFromCfg(1108411009)
				local var_43_20 = arg_40_1:FormatText(var_43_19.content)

				arg_40_1.text_.text = var_43_20

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_21 = 14
				local var_43_22 = utf8.len(var_43_20)
				local var_43_23 = var_43_21 <= 0 and var_43_17 or var_43_17 * (var_43_22 / var_43_21)

				if var_43_23 > 0 and var_43_17 < var_43_23 then
					arg_40_1.talkMaxDuration = var_43_23

					if var_43_23 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_16
					end
				end

				arg_40_1.text_.text = var_43_20
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb") ~= 0 then
					local var_43_24 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb") / 1000

					if var_43_24 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_24 + var_43_16
					end

					if var_43_19.prefab_name ~= "" and arg_40_1.actors_[var_43_19.prefab_name] ~= nil then
						local var_43_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_19.prefab_name].transform, "story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")

						arg_40_1:RecordAudio("1108411009", var_43_25)
						arg_40_1:RecordAudio("1108411009", var_43_25)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_26 = math.max(var_43_17, arg_40_1.talkMaxDuration)

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_26 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_16) / var_43_26

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_16 + var_43_26 and arg_40_1.time_ < var_43_16 + var_43_26 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108411010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108411010
		arg_44_1.duration_ = 10.63

		local var_44_0 = {
			zh = 6.5,
			ja = 10.633
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
				arg_44_0:Play1108411011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_47_1 = 0
			local var_47_2 = 0.75

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_3 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(1108411010)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 30
				local var_47_7 = utf8.len(var_47_5)
				local var_47_8 = var_47_6 <= 0 and var_47_2 or var_47_2 * (var_47_7 / var_47_6)

				if var_47_8 > 0 and var_47_2 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb") / 1000

					if var_47_9 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_1
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")

						arg_44_1:RecordAudio("1108411010", var_47_10)
						arg_44_1:RecordAudio("1108411010", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_11 and arg_44_1.time_ < var_47_1 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108411011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108411011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108411012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10102ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10102ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10102ui_story, var_51_4, var_51_3)

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

			local var_51_9 = arg_48_1.actors_["10102ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect10102ui_story == nil then
				arg_48_1.var_.characterEffect10102ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect10102ui_story and not isNil(var_51_9) then
					local var_51_13 = Mathf.Lerp(0, 0.5, var_51_12)

					arg_48_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10102ui_story.fillRatio = var_51_13
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect10102ui_story then
				local var_51_14 = 0.5

				arg_48_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10102ui_story.fillRatio = var_51_14
			end

			local var_51_15 = 0
			local var_51_16 = 1.3

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_17 = arg_48_1:GetWordFromCfg(1108411011)
				local var_51_18 = arg_48_1:FormatText(var_51_17.content)

				arg_48_1.text_.text = var_51_18

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 52
				local var_51_20 = utf8.len(var_51_18)
				local var_51_21 = var_51_19 <= 0 and var_51_16 or var_51_16 * (var_51_20 / var_51_19)

				if var_51_21 > 0 and var_51_16 < var_51_21 then
					arg_48_1.talkMaxDuration = var_51_21

					if var_51_21 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_21 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_18
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_22 and arg_48_1.time_ < var_51_15 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108411012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108411012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108411013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1.15

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(1108411012)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 46
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108411013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108411013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108411014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.7

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(1108411013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 28
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

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

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108411014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108411014
		arg_60_1.duration_ = 5.5

		local var_60_0 = {
			zh = 3.666,
			ja = 5.5
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
				arg_60_0:Play1108411015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10102ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10102ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -0.985, -6.275)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10102ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["10102ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10102ui_story == nil then
				arg_60_1.var_.characterEffect10102ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect10102ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10102ui_story then
				arg_60_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_63_15 = 0
			local var_63_16 = 0.475

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(1108411014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 19
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")

						arg_60_1:RecordAudio("1108411014", var_63_24)
						arg_60_1:RecordAudio("1108411014", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108411015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108411015
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"

			SetActive(arg_64_1.choicesGo_, true)

			for iter_65_0, iter_65_1 in ipairs(arg_64_1.choices_) do
				local var_65_0 = iter_65_0 <= 2

				SetActive(iter_65_1.go, var_65_0)
			end

			arg_64_1.choices_[1].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1543].name)
			arg_64_1.choices_[2].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1544].name)
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108411016(arg_64_1)
			end

			if arg_66_0 == 2 then
				arg_64_0:Play1108411016(arg_64_1)
			end

			arg_64_1:RecordChoiceLog(1108411015, 1543, 1544)
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10102ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10102ui_story == nil then
				arg_64_1.var_.characterEffect10102ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10102ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10102ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10102ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10102ui_story.fillRatio = var_67_5
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108411016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108411016
		arg_68_1.duration_ = 6.3

		local var_68_0 = {
			zh = 5.133,
			ja = 6.3
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
				arg_68_0:Play1108411017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10102ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10102ui_story == nil then
				arg_68_1.var_.characterEffect10102ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10102ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10102ui_story then
				arg_68_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_71_4 = "10102ui_story"

			if arg_68_1.actors_[var_71_4] == nil then
				local var_71_5 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_71_5) then
					local var_71_6 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_68_1.stage_.transform)

					var_71_6.name = var_71_4
					var_71_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_4] = var_71_6

					local var_71_7 = var_71_6:GetComponentInChildren(typeof(CharacterEffect))

					var_71_7.enabled = true

					local var_71_8 = GameObjectTools.GetOrAddComponent(var_71_6, typeof(DynamicBoneHelper))

					if var_71_8 then
						var_71_8:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_7.transform, false)

					arg_68_1.var_[var_71_4 .. "Animator"] = var_71_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_4 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_4 .. "LipSync"] = var_71_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			local var_71_10 = "10102ui_story"

			if arg_68_1.actors_[var_71_10] == nil then
				local var_71_11 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_71_11) then
					local var_71_12 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_68_1.stage_.transform)

					var_71_12.name = var_71_10
					var_71_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_10] = var_71_12

					local var_71_13 = var_71_12:GetComponentInChildren(typeof(CharacterEffect))

					var_71_13.enabled = true

					local var_71_14 = GameObjectTools.GetOrAddComponent(var_71_12, typeof(DynamicBoneHelper))

					if var_71_14 then
						var_71_14:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_13.transform, false)

					arg_68_1.var_[var_71_10 .. "Animator"] = var_71_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_10 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_10 .. "LipSync"] = var_71_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_15 = 0

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_16 = 0
			local var_71_17 = 0.7

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_18 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_19 = arg_68_1:GetWordFromCfg(1108411016)
				local var_71_20 = arg_68_1:FormatText(var_71_19.content)

				arg_68_1.text_.text = var_71_20

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_21 = 28
				local var_71_22 = utf8.len(var_71_20)
				local var_71_23 = var_71_21 <= 0 and var_71_17 or var_71_17 * (var_71_22 / var_71_21)

				if var_71_23 > 0 and var_71_17 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23

					if var_71_23 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_16
					end
				end

				arg_68_1.text_.text = var_71_20
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb") ~= 0 then
					local var_71_24 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb") / 1000

					if var_71_24 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_16
					end

					if var_71_19.prefab_name ~= "" and arg_68_1.actors_[var_71_19.prefab_name] ~= nil then
						local var_71_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_19.prefab_name].transform, "story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")

						arg_68_1:RecordAudio("1108411016", var_71_25)
						arg_68_1:RecordAudio("1108411016", var_71_25)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = math.max(var_71_17, arg_68_1.talkMaxDuration)

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_26 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_16) / var_71_26

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_16 + var_71_26 and arg_68_1.time_ < var_71_16 + var_71_26 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108411017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108411017
		arg_72_1.duration_ = 4.73

		local var_72_0 = {
			zh = 3.066,
			ja = 4.733
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
				arg_72_0:Play1108411018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.4

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(1108411017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 16
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")

						arg_72_1:RecordAudio("1108411017", var_75_9)
						arg_72_1:RecordAudio("1108411017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108411018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108411018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108411019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10102ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10102ui_story == nil then
				arg_76_1.var_.characterEffect10102ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10102ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10102ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10102ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10102ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.3

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(1108411018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 12
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108411019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108411019
		arg_80_1.duration_ = 9.93

		local var_80_0 = {
			zh = 5.666,
			ja = 9.933
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108411020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10102ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10102ui_story == nil then
				arg_80_1.var_.characterEffect10102ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10102ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10102ui_story then
				arg_80_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_83_4 = 0

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_83_6 = 0
			local var_83_7 = 0.725

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:GetWordFromCfg(1108411019)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 29
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")

						arg_80_1:RecordAudio("1108411019", var_83_15)
						arg_80_1:RecordAudio("1108411019", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_16 and arg_80_1.time_ < var_83_6 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108411020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108411020
		arg_84_1.duration_ = 6.47

		local var_84_0 = {
			zh = 3.5,
			ja = 6.466
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108411021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.525

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(1108411020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 21
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")

						arg_84_1:RecordAudio("1108411020", var_87_9)
						arg_84_1:RecordAudio("1108411020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108411021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108411021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108411022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10102ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10102ui_story == nil then
				arg_88_1.var_.characterEffect10102ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10102ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10102ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10102ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10102ui_story.fillRatio = var_91_5
			end

			local var_91_6 = arg_88_1.actors_["10102ui_story"].transform
			local var_91_7 = 0

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.var_.moveOldPos10102ui_story = var_91_6.localPosition
			end

			local var_91_8 = 0.001

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_8 then
				local var_91_9 = (arg_88_1.time_ - var_91_7) / var_91_8
				local var_91_10 = Vector3.New(0, 100, 0)

				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10102ui_story, var_91_10, var_91_9)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_6.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_6.localEulerAngles = var_91_12
			end

			if arg_88_1.time_ >= var_91_7 + var_91_8 and arg_88_1.time_ < var_91_7 + var_91_8 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0, 100, 0)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_6.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_6.localEulerAngles = var_91_14
			end

			local var_91_15 = 0
			local var_91_16 = 0.85

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_17 = arg_88_1:GetWordFromCfg(1108411021)
				local var_91_18 = arg_88_1:FormatText(var_91_17.content)

				arg_88_1.text_.text = var_91_18

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 34
				local var_91_20 = utf8.len(var_91_18)
				local var_91_21 = var_91_19 <= 0 and var_91_16 or var_91_16 * (var_91_20 / var_91_19)

				if var_91_21 > 0 and var_91_16 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21

					if var_91_21 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_18
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_22 and arg_88_1.time_ < var_91_15 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108411022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108411022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108411023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.225

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(1108411022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 9
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108411023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108411023
		arg_96_1.duration_ = 5.37

		local var_96_0 = {
			zh = 3.3,
			ja = 5.366
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
				arg_96_0:Play1108411024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10102ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10102ui_story == nil then
				arg_96_1.var_.characterEffect10102ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10102ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10102ui_story then
				arg_96_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action462")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_99_6 = arg_96_1.actors_["10102ui_story"].transform
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.var_.moveOldPos10102ui_story = var_99_6.localPosition
			end

			local var_99_8 = 0.001

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8
				local var_99_10 = Vector3.New(0, -0.985, -6.275)

				var_99_6.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10102ui_story, var_99_10, var_99_9)

				local var_99_11 = manager.ui.mainCamera.transform.position - var_99_6.position

				var_99_6.forward = Vector3.New(var_99_11.x, var_99_11.y, var_99_11.z)

				local var_99_12 = var_99_6.localEulerAngles

				var_99_12.z = 0
				var_99_12.x = 0
				var_99_6.localEulerAngles = var_99_12
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 then
				var_99_6.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_99_13 = manager.ui.mainCamera.transform.position - var_99_6.position

				var_99_6.forward = Vector3.New(var_99_13.x, var_99_13.y, var_99_13.z)

				local var_99_14 = var_99_6.localEulerAngles

				var_99_14.z = 0
				var_99_14.x = 0
				var_99_6.localEulerAngles = var_99_14
			end

			local var_99_15 = 0
			local var_99_16 = 0.425

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[6].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(1108411023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 17
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")

						arg_96_1:RecordAudio("1108411023", var_99_24)
						arg_96_1:RecordAudio("1108411023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108411024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108411024
		arg_100_1.duration_ = 7.72

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108411025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				local var_103_1 = manager.ui.mainCamera.transform.localPosition
				local var_103_2 = Vector3.New(0, 0, 10) + Vector3.New(var_103_1.x, var_103_1.y, 0)
				local var_103_3 = arg_100_1.bgs_.ST01

				var_103_3.transform.localPosition = var_103_2
				var_103_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_4 = var_103_3:GetComponent("SpriteRenderer")

				if var_103_4 and var_103_4.sprite then
					local var_103_5 = (var_103_3.transform.localPosition - var_103_1).z
					local var_103_6 = manager.ui.mainCameraCom_
					local var_103_7 = 2 * var_103_5 * Mathf.Tan(var_103_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_103_8 = var_103_7 * var_103_6.aspect
					local var_103_9 = var_103_4.sprite.bounds.size.x
					local var_103_10 = var_103_4.sprite.bounds.size.y
					local var_103_11 = var_103_8 / var_103_9
					local var_103_12 = var_103_7 / var_103_10
					local var_103_13 = var_103_12 < var_103_11 and var_103_11 or var_103_12

					var_103_3.transform.localScale = Vector3.New(var_103_13, var_103_13, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "ST01" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1.allBtn_.enabled = false
			end

			local var_103_15 = 0.3

			if arg_100_1.time_ >= var_103_14 + var_103_15 and arg_100_1.time_ < var_103_14 + var_103_15 + arg_103_0 then
				arg_100_1.allBtn_.enabled = true
			end

			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_17 = 1.46666666666667

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17
				local var_103_19 = Color.New(0, 0, 0)

				var_103_19.a = Mathf.Lerp(0, 1, var_103_18)
				arg_100_1.mask_.color = var_103_19
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 then
				local var_103_20 = Color.New(0, 0, 0)

				var_103_20.a = 1
				arg_100_1.mask_.color = var_103_20
			end

			local var_103_21 = 1.46666666666667

			if var_103_21 < arg_100_1.time_ and arg_100_1.time_ <= var_103_21 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_22 = 1.33333333333333

			if var_103_21 <= arg_100_1.time_ and arg_100_1.time_ < var_103_21 + var_103_22 then
				local var_103_23 = (arg_100_1.time_ - var_103_21) / var_103_22
				local var_103_24 = Color.New(0, 0, 0)

				var_103_24.a = Mathf.Lerp(1, 0, var_103_23)
				arg_100_1.mask_.color = var_103_24
			end

			if arg_100_1.time_ >= var_103_21 + var_103_22 and arg_100_1.time_ < var_103_21 + var_103_22 + arg_103_0 then
				local var_103_25 = Color.New(0, 0, 0)
				local var_103_26 = 0

				arg_100_1.mask_.enabled = false
				var_103_25.a = var_103_26
				arg_100_1.mask_.color = var_103_25
			end

			local var_103_27 = arg_100_1.actors_["10102ui_story"].transform
			local var_103_28 = 1.46666666666667

			if var_103_28 < arg_100_1.time_ and arg_100_1.time_ <= var_103_28 + arg_103_0 then
				arg_100_1.var_.moveOldPos10102ui_story = var_103_27.localPosition
			end

			local var_103_29 = 0.001

			if var_103_28 <= arg_100_1.time_ and arg_100_1.time_ < var_103_28 + var_103_29 then
				local var_103_30 = (arg_100_1.time_ - var_103_28) / var_103_29
				local var_103_31 = Vector3.New(0, 100, 0)

				var_103_27.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10102ui_story, var_103_31, var_103_30)

				local var_103_32 = manager.ui.mainCamera.transform.position - var_103_27.position

				var_103_27.forward = Vector3.New(var_103_32.x, var_103_32.y, var_103_32.z)

				local var_103_33 = var_103_27.localEulerAngles

				var_103_33.z = 0
				var_103_33.x = 0
				var_103_27.localEulerAngles = var_103_33
			end

			if arg_100_1.time_ >= var_103_28 + var_103_29 and arg_100_1.time_ < var_103_28 + var_103_29 + arg_103_0 then
				var_103_27.localPosition = Vector3.New(0, 100, 0)

				local var_103_34 = manager.ui.mainCamera.transform.position - var_103_27.position

				var_103_27.forward = Vector3.New(var_103_34.x, var_103_34.y, var_103_34.z)

				local var_103_35 = var_103_27.localEulerAngles

				var_103_35.z = 0
				var_103_35.x = 0
				var_103_27.localEulerAngles = var_103_35
			end

			local var_103_36 = arg_100_1.actors_["10102ui_story"]
			local var_103_37 = 1.46666666666667

			if var_103_37 < arg_100_1.time_ and arg_100_1.time_ <= var_103_37 + arg_103_0 and not isNil(var_103_36) and arg_100_1.var_.characterEffect10102ui_story == nil then
				arg_100_1.var_.characterEffect10102ui_story = var_103_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_38 = 0.200000002980232

			if var_103_37 <= arg_100_1.time_ and arg_100_1.time_ < var_103_37 + var_103_38 and not isNil(var_103_36) then
				local var_103_39 = (arg_100_1.time_ - var_103_37) / var_103_38

				if arg_100_1.var_.characterEffect10102ui_story and not isNil(var_103_36) then
					local var_103_40 = Mathf.Lerp(0, 0.5, var_103_39)

					arg_100_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10102ui_story.fillRatio = var_103_40
				end
			end

			if arg_100_1.time_ >= var_103_37 + var_103_38 and arg_100_1.time_ < var_103_37 + var_103_38 + arg_103_0 and not isNil(var_103_36) and arg_100_1.var_.characterEffect10102ui_story then
				local var_103_41 = 0.5

				arg_100_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10102ui_story.fillRatio = var_103_41
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_42 = 2.724999999999
			local var_103_43 = 0.075

			if var_103_42 < arg_100_1.time_ and arg_100_1.time_ <= var_103_42 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_44 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_44:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_45 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_46 = arg_100_1:GetWordFromCfg(1108411024)
				local var_103_47 = arg_100_1:FormatText(var_103_46.content)

				arg_100_1.text_.text = var_103_47

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_48 = 3
				local var_103_49 = utf8.len(var_103_47)
				local var_103_50 = var_103_48 <= 0 and var_103_43 or var_103_43 * (var_103_49 / var_103_48)

				if var_103_50 > 0 and var_103_43 < var_103_50 then
					arg_100_1.talkMaxDuration = var_103_50
					var_103_42 = var_103_42 + 0.3

					if var_103_50 + var_103_42 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_50 + var_103_42
					end
				end

				arg_100_1.text_.text = var_103_47
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_51 = var_103_42 + 0.3
			local var_103_52 = math.max(var_103_43, arg_100_1.talkMaxDuration)

			if var_103_51 <= arg_100_1.time_ and arg_100_1.time_ < var_103_51 + var_103_52 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_51) / var_103_52

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_51 + var_103_52 and arg_100_1.time_ < var_103_51 + var_103_52 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108411025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1108411025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1108411026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 1.075

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(1108411025)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 43
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1108411026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1108411026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1108411027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.7

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(1108411026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 28
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1108411027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1108411027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1108411028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.85

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(1108411027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 34
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1108411028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1108411028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1108411029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.125

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(1108411028)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 45
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1108411029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1108411029
		arg_122_1.duration_ = 5.6

		local var_122_0 = {
			zh = 5.6,
			ja = 4.133
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
				arg_122_0:Play1108411030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10102ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10102ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, -0.985, -6.275)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10102ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = arg_122_1.actors_["10102ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect10102ui_story == nil then
				arg_122_1.var_.characterEffect10102ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.200000002980232

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect10102ui_story and not isNil(var_125_9) then
					arg_122_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect10102ui_story then
				arg_122_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_125_13 = 0

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action10_1")
			end

			local var_125_14 = 0

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_125_15 = 0
			local var_125_16 = 0.575

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:GetWordFromCfg(1108411029)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 23
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb") ~= 0 then
					local var_125_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb") / 1000

					if var_125_23 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_15
					end

					if var_125_18.prefab_name ~= "" and arg_122_1.actors_[var_125_18.prefab_name] ~= nil then
						local var_125_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_18.prefab_name].transform, "story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")

						arg_122_1:RecordAudio("1108411029", var_125_24)
						arg_122_1:RecordAudio("1108411029", var_125_24)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_25 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_25 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_25

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_25 and arg_122_1.time_ < var_125_15 + var_125_25 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1108411030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1108411030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1108411031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10102ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10102ui_story == nil then
				arg_126_1.var_.characterEffect10102ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect10102ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10102ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10102ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10102ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.5

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(1108411030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 20
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1108411031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1108411031
		arg_130_1.duration_ = 6.33

		local var_130_0 = {
			zh = 4.4,
			ja = 6.333
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
				arg_130_0:Play1108411032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10102ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10102ui_story == nil then
				arg_130_1.var_.characterEffect10102ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect10102ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10102ui_story then
				arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_133_4 = 0

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action10_2")
			end

			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_133_6 = 0
			local var_133_7 = 0.55

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_8 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_9 = arg_130_1:GetWordFromCfg(1108411031)
				local var_133_10 = arg_130_1:FormatText(var_133_9.content)

				arg_130_1.text_.text = var_133_10

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 22
				local var_133_12 = utf8.len(var_133_10)
				local var_133_13 = var_133_11 <= 0 and var_133_7 or var_133_7 * (var_133_12 / var_133_11)

				if var_133_13 > 0 and var_133_7 < var_133_13 then
					arg_130_1.talkMaxDuration = var_133_13

					if var_133_13 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_10
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb") ~= 0 then
					local var_133_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb") / 1000

					if var_133_14 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_6
					end

					if var_133_9.prefab_name ~= "" and arg_130_1.actors_[var_133_9.prefab_name] ~= nil then
						local var_133_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_9.prefab_name].transform, "story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")

						arg_130_1:RecordAudio("1108411031", var_133_15)
						arg_130_1:RecordAudio("1108411031", var_133_15)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_16 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_16 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_16

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_16 and arg_130_1.time_ < var_133_6 + var_133_16 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1108411032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1108411032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1108411033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10102ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect10102ui_story == nil then
				arg_134_1.var_.characterEffect10102ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect10102ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10102ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect10102ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10102ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.5

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(1108411032)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 20
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1108411033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1108411033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1108411034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10102ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos10102ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10102ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = 0
			local var_141_10 = 1.1

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_11 = arg_138_1:GetWordFromCfg(1108411033)
				local var_141_12 = arg_138_1:FormatText(var_141_11.content)

				arg_138_1.text_.text = var_141_12

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 44
				local var_141_14 = utf8.len(var_141_12)
				local var_141_15 = var_141_13 <= 0 and var_141_10 or var_141_10 * (var_141_14 / var_141_13)

				if var_141_15 > 0 and var_141_10 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_9 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_9
					end
				end

				arg_138_1.text_.text = var_141_12
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_10, arg_138_1.talkMaxDuration)

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_9) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_9 + var_141_16 and arg_138_1.time_ < var_141_9 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1108411034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1108411034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1108411035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.175

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(1108411034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 47
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
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1108411035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1108411035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1108411036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.8

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(1108411035)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 32
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
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_8 and arg_146_1.time_ < var_149_0 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1108411036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1108411036
		arg_150_1.duration_ = 8.3

		local var_150_0 = {
			zh = 5.766,
			ja = 8.3
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
				arg_150_0:Play1108411037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10102ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos10102ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, -0.985, -6.275)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10102ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["10102ui_story"]
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect10102ui_story == nil then
				arg_150_1.var_.characterEffect10102ui_story = var_153_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_11 = 0.200000002980232

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 and not isNil(var_153_9) then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11

				if arg_150_1.var_.characterEffect10102ui_story and not isNil(var_153_9) then
					arg_150_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect10102ui_story then
				arg_150_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_153_13 = 0

			if var_153_13 < arg_150_1.time_ and arg_150_1.time_ <= var_153_13 + arg_153_0 then
				arg_150_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_153_14 = 0

			if var_153_14 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_153_15 = 0
			local var_153_16 = 0.65

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_17 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_18 = arg_150_1:GetWordFromCfg(1108411036)
				local var_153_19 = arg_150_1:FormatText(var_153_18.content)

				arg_150_1.text_.text = var_153_19

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_20 = 26
				local var_153_21 = utf8.len(var_153_19)
				local var_153_22 = var_153_20 <= 0 and var_153_16 or var_153_16 * (var_153_21 / var_153_20)

				if var_153_22 > 0 and var_153_16 < var_153_22 then
					arg_150_1.talkMaxDuration = var_153_22

					if var_153_22 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_22 + var_153_15
					end
				end

				arg_150_1.text_.text = var_153_19
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb") ~= 0 then
					local var_153_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb") / 1000

					if var_153_23 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_15
					end

					if var_153_18.prefab_name ~= "" and arg_150_1.actors_[var_153_18.prefab_name] ~= nil then
						local var_153_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_18.prefab_name].transform, "story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")

						arg_150_1:RecordAudio("1108411036", var_153_24)
						arg_150_1:RecordAudio("1108411036", var_153_24)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_25 = math.max(var_153_16, arg_150_1.talkMaxDuration)

			if var_153_15 <= arg_150_1.time_ and arg_150_1.time_ < var_153_15 + var_153_25 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_15) / var_153_25

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_15 + var_153_25 and arg_150_1.time_ < var_153_15 + var_153_25 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play1108411037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1108411037
		arg_154_1.duration_ = 3.7

		local var_154_0 = {
			zh = 3.466,
			ja = 3.7
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
				arg_154_0:Play1108411038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action446")
			end

			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_157_2 = 0
			local var_157_3 = 0.475

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_4 = arg_154_1:FormatText(StoryNameCfg[6].name)

				arg_154_1.leftNameTxt_.text = var_157_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_5 = arg_154_1:GetWordFromCfg(1108411037)
				local var_157_6 = arg_154_1:FormatText(var_157_5.content)

				arg_154_1.text_.text = var_157_6

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_7 = 19
				local var_157_8 = utf8.len(var_157_6)
				local var_157_9 = var_157_7 <= 0 and var_157_3 or var_157_3 * (var_157_8 / var_157_7)

				if var_157_9 > 0 and var_157_3 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_6
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb") / 1000

					if var_157_10 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_2
					end

					if var_157_5.prefab_name ~= "" and arg_154_1.actors_[var_157_5.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_5.prefab_name].transform, "story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")

						arg_154_1:RecordAudio("1108411037", var_157_11)
						arg_154_1:RecordAudio("1108411037", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_12 and arg_154_1.time_ < var_157_2 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1108411038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1108411038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1108411039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10102ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10102ui_story == nil then
				arg_158_1.var_.characterEffect10102ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect10102ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10102ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10102ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10102ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 1.625

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(1108411038)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 65
				local var_161_11 = utf8.len(var_161_9)
				local var_161_12 = var_161_10 <= 0 and var_161_7 or var_161_7 * (var_161_11 / var_161_10)

				if var_161_12 > 0 and var_161_7 < var_161_12 then
					arg_158_1.talkMaxDuration = var_161_12

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_13 and arg_158_1.time_ < var_161_6 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1108411039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1108411039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1108411040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.425

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[7].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(1108411039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 17
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
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_8 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_8 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_8

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_8 and arg_162_1.time_ < var_165_0 + var_165_8 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1108411040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1108411040
		arg_166_1.duration_ = 7.17

		local var_166_0 = {
			zh = 4.633,
			ja = 7.166
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
				arg_166_0:Play1108411041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10102ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10102ui_story == nil then
				arg_166_1.var_.characterEffect10102ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect10102ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10102ui_story then
				arg_166_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_169_4 = 0

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_169_6 = 0
			local var_169_7 = 0.575

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[6].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_9 = arg_166_1:GetWordFromCfg(1108411040)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb") / 1000

					if var_169_14 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_6
					end

					if var_169_9.prefab_name ~= "" and arg_166_1.actors_[var_169_9.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_9.prefab_name].transform, "story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")

						arg_166_1:RecordAudio("1108411040", var_169_15)
						arg_166_1:RecordAudio("1108411040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")
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
	Play1108411041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1108411041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1108411042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10102ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10102ui_story == nil then
				arg_170_1.var_.characterEffect10102ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect10102ui_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10102ui_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10102ui_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10102ui_story.fillRatio = var_173_5
			end

			local var_173_6 = 0
			local var_173_7 = 0.325

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_8 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_9 = arg_170_1:GetWordFromCfg(1108411041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 13
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
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_14 and arg_170_1.time_ < var_173_6 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1108411042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1108411042
		arg_174_1.duration_ = 10.53

		local var_174_0 = {
			zh = 8.6,
			ja = 10.533
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
				arg_174_0:Play1108411043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10102ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10102ui_story == nil then
				arg_174_1.var_.characterEffect10102ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect10102ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10102ui_story then
				arg_174_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_177_4 = 0
			local var_177_5 = 1.05

			if var_177_4 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_6 = arg_174_1:FormatText(StoryNameCfg[6].name)

				arg_174_1.leftNameTxt_.text = var_177_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(1108411042)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 42
				local var_177_10 = utf8.len(var_177_8)
				local var_177_11 = var_177_9 <= 0 and var_177_5 or var_177_5 * (var_177_10 / var_177_9)

				if var_177_11 > 0 and var_177_5 < var_177_11 then
					arg_174_1.talkMaxDuration = var_177_11

					if var_177_11 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb") ~= 0 then
					local var_177_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb") / 1000

					if var_177_12 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_4
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")

						arg_174_1:RecordAudio("1108411042", var_177_13)
						arg_174_1:RecordAudio("1108411042", var_177_13)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_14 and arg_174_1.time_ < var_177_4 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1108411043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1108411043
		arg_178_1.duration_ = 6.47

		local var_178_0 = {
			zh = 4.5,
			ja = 6.466
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
				arg_178_0:Play1108411044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_181_2 = 0
			local var_181_3 = 0.475

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_4 = arg_178_1:FormatText(StoryNameCfg[6].name)

				arg_178_1.leftNameTxt_.text = var_181_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_5 = arg_178_1:GetWordFromCfg(1108411043)
				local var_181_6 = arg_178_1:FormatText(var_181_5.content)

				arg_178_1.text_.text = var_181_6

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 19
				local var_181_8 = utf8.len(var_181_6)
				local var_181_9 = var_181_7 <= 0 and var_181_3 or var_181_3 * (var_181_8 / var_181_7)

				if var_181_9 > 0 and var_181_3 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_6
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb") / 1000

					if var_181_10 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_2
					end

					if var_181_5.prefab_name ~= "" and arg_178_1.actors_[var_181_5.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_5.prefab_name].transform, "story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")

						arg_178_1:RecordAudio("1108411043", var_181_11)
						arg_178_1:RecordAudio("1108411043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_12 and arg_178_1.time_ < var_181_2 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1108411044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1108411044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1108411045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10102ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10102ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, 100, 0)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10102ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, 100, 0)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["10102ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect10102ui_story == nil then
				arg_182_1.var_.characterEffect10102ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect10102ui_story and not isNil(var_185_9) then
					local var_185_13 = Mathf.Lerp(0, 0.5, var_185_12)

					arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_182_1.var_.characterEffect10102ui_story.fillRatio = var_185_13
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect10102ui_story then
				local var_185_14 = 0.5

				arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_182_1.var_.characterEffect10102ui_story.fillRatio = var_185_14
			end

			local var_185_15 = 0
			local var_185_16 = 1

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_17 = arg_182_1:GetWordFromCfg(1108411044)
				local var_185_18 = arg_182_1:FormatText(var_185_17.content)

				arg_182_1.text_.text = var_185_18

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_19 = 40
				local var_185_20 = utf8.len(var_185_18)
				local var_185_21 = var_185_19 <= 0 and var_185_16 or var_185_16 * (var_185_20 / var_185_19)

				if var_185_21 > 0 and var_185_16 < var_185_21 then
					arg_182_1.talkMaxDuration = var_185_21

					if var_185_21 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_21 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_18
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_22 and arg_182_1.time_ < var_185_15 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play1108411045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1108411045
		arg_186_1.duration_ = 5.67

		local var_186_0 = {
			zh = 5.633,
			ja = 5.666
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1108411046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10102ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos10102ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0, -0.985, -6.275)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10102ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["10102ui_story"]
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect10102ui_story == nil then
				arg_186_1.var_.characterEffect10102ui_story = var_189_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_11 = 0.200000002980232

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 and not isNil(var_189_9) then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11

				if arg_186_1.var_.characterEffect10102ui_story and not isNil(var_189_9) then
					arg_186_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect10102ui_story then
				arg_186_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_189_13 = 0

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_189_15 = 0
			local var_189_16 = 0.775

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[6].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(1108411045)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 31
				local var_189_21 = utf8.len(var_189_19)
				local var_189_22 = var_189_20 <= 0 and var_189_16 or var_189_16 * (var_189_21 / var_189_20)

				if var_189_22 > 0 and var_189_16 < var_189_22 then
					arg_186_1.talkMaxDuration = var_189_22

					if var_189_22 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_22 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_19
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")

						arg_186_1:RecordAudio("1108411045", var_189_24)
						arg_186_1:RecordAudio("1108411045", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_25 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_25

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_25 and arg_186_1.time_ < var_189_15 + var_189_25 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1108411046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1108411046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1108411047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10102ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10102ui_story == nil then
				arg_190_1.var_.characterEffect10102ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect10102ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10102ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10102ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10102ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.55

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_9 = arg_190_1:GetWordFromCfg(1108411046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 22
				local var_193_12 = utf8.len(var_193_10)
				local var_193_13 = var_193_11 <= 0 and var_193_7 or var_193_7 * (var_193_12 / var_193_11)

				if var_193_13 > 0 and var_193_7 < var_193_13 then
					arg_190_1.talkMaxDuration = var_193_13

					if var_193_13 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1108411047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1108411047
		arg_194_1.duration_ = 4.33

		local var_194_0 = {
			zh = 4.333,
			ja = 3.666
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1108411048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["10102ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10102ui_story == nil then
				arg_194_1.var_.characterEffect10102ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect10102ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10102ui_story then
				arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_197_4 = 0
			local var_197_5 = 0.4

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_6 = arg_194_1:FormatText(StoryNameCfg[6].name)

				arg_194_1.leftNameTxt_.text = var_197_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:GetWordFromCfg(1108411047)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 16
				local var_197_10 = utf8.len(var_197_8)
				local var_197_11 = var_197_9 <= 0 and var_197_5 or var_197_5 * (var_197_10 / var_197_9)

				if var_197_11 > 0 and var_197_5 < var_197_11 then
					arg_194_1.talkMaxDuration = var_197_11

					if var_197_11 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb") ~= 0 then
					local var_197_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb") / 1000

					if var_197_12 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_4
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")

						arg_194_1:RecordAudio("1108411047", var_197_13)
						arg_194_1:RecordAudio("1108411047", var_197_13)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_14 and arg_194_1.time_ < var_197_4 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1108411048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1108411048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1108411049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10102ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10102ui_story == nil then
				arg_198_1.var_.characterEffect10102ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect10102ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10102ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10102ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10102ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.675

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(1108411048)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 27
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_14 and arg_198_1.time_ < var_201_6 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1108411049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1108411049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1108411050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.2

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(1108411049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 8
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_8 and arg_202_1.time_ < var_205_0 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1108411050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1108411050
		arg_206_1.duration_ = 5.7

		local var_206_0 = {
			zh = 3.433,
			ja = 5.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1108411051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10102ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect10102ui_story == nil then
				arg_206_1.var_.characterEffect10102ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect10102ui_story and not isNil(var_209_0) then
					arg_206_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect10102ui_story then
				arg_206_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_209_4 = 0

			if var_209_4 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_209_5 = 0
			local var_209_6 = 0.325

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_7 = arg_206_1:FormatText(StoryNameCfg[6].name)

				arg_206_1.leftNameTxt_.text = var_209_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(1108411050)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_10 = 13
				local var_209_11 = utf8.len(var_209_9)
				local var_209_12 = var_209_10 <= 0 and var_209_6 or var_209_6 * (var_209_11 / var_209_10)

				if var_209_12 > 0 and var_209_6 < var_209_12 then
					arg_206_1.talkMaxDuration = var_209_12

					if var_209_12 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb") ~= 0 then
					local var_209_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb") / 1000

					if var_209_13 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_5
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")

						arg_206_1:RecordAudio("1108411050", var_209_14)
						arg_206_1:RecordAudio("1108411050", var_209_14)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_15 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_15 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_15

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_15 and arg_206_1.time_ < var_209_5 + var_209_15 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1108411051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1108411051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1108411052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10102ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10102ui_story == nil then
				arg_210_1.var_.characterEffect10102ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect10102ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10102ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10102ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10102ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 0.45

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[7].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_9 = arg_210_1:GetWordFromCfg(1108411051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 18
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_14 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_14 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_14

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_14 and arg_210_1.time_ < var_213_6 + var_213_14 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1108411052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1108411052
		arg_214_1.duration_ = 3.77

		local var_214_0 = {
			zh = 2.966,
			ja = 3.766
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1108411053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10102ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10102ui_story == nil then
				arg_214_1.var_.characterEffect10102ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect10102ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10102ui_story then
				arg_214_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_217_4 = 0
			local var_217_5 = 0.25

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_6 = arg_214_1:FormatText(StoryNameCfg[6].name)

				arg_214_1.leftNameTxt_.text = var_217_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(1108411052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 10
				local var_217_10 = utf8.len(var_217_8)
				local var_217_11 = var_217_9 <= 0 and var_217_5 or var_217_5 * (var_217_10 / var_217_9)

				if var_217_11 > 0 and var_217_5 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb") / 1000

					if var_217_12 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_4
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")

						arg_214_1:RecordAudio("1108411052", var_217_13)
						arg_214_1:RecordAudio("1108411052", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_14 and arg_214_1.time_ < var_217_4 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1108411053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1108411053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1108411054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10102ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10102ui_story == nil then
				arg_218_1.var_.characterEffect10102ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect10102ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10102ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10102ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10102ui_story.fillRatio = var_221_5
			end

			local var_221_6 = 0
			local var_221_7 = 0.275

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_8 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_9 = arg_218_1:GetWordFromCfg(1108411053)
				local var_221_10 = arg_218_1:FormatText(var_221_9.content)

				arg_218_1.text_.text = var_221_10

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 11
				local var_221_12 = utf8.len(var_221_10)
				local var_221_13 = var_221_11 <= 0 and var_221_7 or var_221_7 * (var_221_12 / var_221_11)

				if var_221_13 > 0 and var_221_7 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_10
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_14 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_14 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_14

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_14 and arg_218_1.time_ < var_221_6 + var_221_14 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1108411054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108411054
		arg_222_1.duration_ = 5.47

		local var_222_0 = {
			zh = 2.933,
			ja = 5.466
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108411055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10102ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10102ui_story == nil then
				arg_222_1.var_.characterEffect10102ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect10102ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10102ui_story then
				arg_222_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_225_4 = 0

			if var_225_4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			local var_225_5 = 0
			local var_225_6 = 0.35

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_7 = arg_222_1:FormatText(StoryNameCfg[6].name)

				arg_222_1.leftNameTxt_.text = var_225_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(1108411054)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 14
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_6 or var_225_6 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_6 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb") ~= 0 then
					local var_225_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb") / 1000

					if var_225_13 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_5
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")

						arg_222_1:RecordAudio("1108411054", var_225_14)
						arg_222_1:RecordAudio("1108411054", var_225_14)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_15 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_15 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_15

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_15 and arg_222_1.time_ < var_225_5 + var_225_15 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108411055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1108411055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1108411056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10102ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10102ui_story == nil then
				arg_226_1.var_.characterEffect10102ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect10102ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10102ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10102ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10102ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.425

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(1108411055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 17
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1108411056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1108411056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1108411057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.3

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

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:GetWordFromCfg(1108411056)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 12
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
	Play1108411057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1108411057
		arg_234_1.duration_ = 5.1

		local var_234_0 = {
			zh = 4.233,
			ja = 5.1
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
				arg_234_0:Play1108411058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10102ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10102ui_story == nil then
				arg_234_1.var_.characterEffect10102ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect10102ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10102ui_story then
				arg_234_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_237_4 = 0

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_237_6 = 0
			local var_237_7 = 0.45

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[6].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_9 = arg_234_1:GetWordFromCfg(1108411057)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 18
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_7 or var_237_7 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_7 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb") / 1000

					if var_237_14 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_6
					end

					if var_237_9.prefab_name ~= "" and arg_234_1.actors_[var_237_9.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_9.prefab_name].transform, "story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")

						arg_234_1:RecordAudio("1108411057", var_237_15)
						arg_234_1:RecordAudio("1108411057", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_16 and arg_234_1.time_ < var_237_6 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1108411058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1108411058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1108411059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10102ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10102ui_story == nil then
				arg_238_1.var_.characterEffect10102ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect10102ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10102ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10102ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10102ui_story.fillRatio = var_241_5
			end

			local var_241_6 = 0
			local var_241_7 = 0.5

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_9 = arg_238_1:GetWordFromCfg(1108411058)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 20
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_14 and arg_238_1.time_ < var_241_6 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1108411059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1108411059
		arg_242_1.duration_ = 9.7

		local var_242_0 = {
			zh = 8.866,
			ja = 9.7
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1108411060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = "ST02"

			if arg_242_1.bgs_[var_245_0] == nil then
				local var_245_1 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_245_0)
				var_245_1.name = var_245_0
				var_245_1.transform.parent = arg_242_1.stage_.transform
				var_245_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_[var_245_0] = var_245_1
			end

			local var_245_2 = 2

			if var_245_2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				local var_245_3 = manager.ui.mainCamera.transform.localPosition
				local var_245_4 = Vector3.New(0, 0, 10) + Vector3.New(var_245_3.x, var_245_3.y, 0)
				local var_245_5 = arg_242_1.bgs_.ST02

				var_245_5.transform.localPosition = var_245_4
				var_245_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_6 = var_245_5:GetComponent("SpriteRenderer")

				if var_245_6 and var_245_6.sprite then
					local var_245_7 = (var_245_5.transform.localPosition - var_245_3).z
					local var_245_8 = manager.ui.mainCameraCom_
					local var_245_9 = 2 * var_245_7 * Mathf.Tan(var_245_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_245_10 = var_245_9 * var_245_8.aspect
					local var_245_11 = var_245_6.sprite.bounds.size.x
					local var_245_12 = var_245_6.sprite.bounds.size.y
					local var_245_13 = var_245_10 / var_245_11
					local var_245_14 = var_245_9 / var_245_12
					local var_245_15 = var_245_14 < var_245_13 and var_245_13 or var_245_14

					var_245_5.transform.localScale = Vector3.New(var_245_15, var_245_15, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "ST02" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			local var_245_17 = 0.3

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_18 = 0

			if var_245_18 < arg_242_1.time_ and arg_242_1.time_ <= var_245_18 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_19 = 2

			if var_245_18 <= arg_242_1.time_ and arg_242_1.time_ < var_245_18 + var_245_19 then
				local var_245_20 = (arg_242_1.time_ - var_245_18) / var_245_19
				local var_245_21 = Color.New(0, 0, 0)

				var_245_21.a = Mathf.Lerp(0, 1, var_245_20)
				arg_242_1.mask_.color = var_245_21
			end

			if arg_242_1.time_ >= var_245_18 + var_245_19 and arg_242_1.time_ < var_245_18 + var_245_19 + arg_245_0 then
				local var_245_22 = Color.New(0, 0, 0)

				var_245_22.a = 1
				arg_242_1.mask_.color = var_245_22
			end

			local var_245_23 = 2

			if var_245_23 < arg_242_1.time_ and arg_242_1.time_ <= var_245_23 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_24 = 2

			if var_245_23 <= arg_242_1.time_ and arg_242_1.time_ < var_245_23 + var_245_24 then
				local var_245_25 = (arg_242_1.time_ - var_245_23) / var_245_24
				local var_245_26 = Color.New(0, 0, 0)

				var_245_26.a = Mathf.Lerp(1, 0, var_245_25)
				arg_242_1.mask_.color = var_245_26
			end

			if arg_242_1.time_ >= var_245_23 + var_245_24 and arg_242_1.time_ < var_245_23 + var_245_24 + arg_245_0 then
				local var_245_27 = Color.New(0, 0, 0)
				local var_245_28 = 0

				arg_242_1.mask_.enabled = false
				var_245_27.a = var_245_28
				arg_242_1.mask_.color = var_245_27
			end

			local var_245_29 = arg_242_1.actors_["10102ui_story"].transform
			local var_245_30 = 1.98333333333333

			if var_245_30 < arg_242_1.time_ and arg_242_1.time_ <= var_245_30 + arg_245_0 then
				arg_242_1.var_.moveOldPos10102ui_story = var_245_29.localPosition
			end

			local var_245_31 = 0.001

			if var_245_30 <= arg_242_1.time_ and arg_242_1.time_ < var_245_30 + var_245_31 then
				local var_245_32 = (arg_242_1.time_ - var_245_30) / var_245_31
				local var_245_33 = Vector3.New(0, 100, 0)

				var_245_29.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10102ui_story, var_245_33, var_245_32)

				local var_245_34 = manager.ui.mainCamera.transform.position - var_245_29.position

				var_245_29.forward = Vector3.New(var_245_34.x, var_245_34.y, var_245_34.z)

				local var_245_35 = var_245_29.localEulerAngles

				var_245_35.z = 0
				var_245_35.x = 0
				var_245_29.localEulerAngles = var_245_35
			end

			if arg_242_1.time_ >= var_245_30 + var_245_31 and arg_242_1.time_ < var_245_30 + var_245_31 + arg_245_0 then
				var_245_29.localPosition = Vector3.New(0, 100, 0)

				local var_245_36 = manager.ui.mainCamera.transform.position - var_245_29.position

				var_245_29.forward = Vector3.New(var_245_36.x, var_245_36.y, var_245_36.z)

				local var_245_37 = var_245_29.localEulerAngles

				var_245_37.z = 0
				var_245_37.x = 0
				var_245_29.localEulerAngles = var_245_37
			end

			local var_245_38 = 0.166666666666667
			local var_245_39 = 1

			if var_245_38 < arg_242_1.time_ and arg_242_1.time_ <= var_245_38 + arg_245_0 then
				local var_245_40 = "stop"
				local var_245_41 = "effect"

				arg_242_1:AudioAction(var_245_40, var_245_41, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_245_42 = 1.63333333333333
			local var_245_43 = 1

			if var_245_42 < arg_242_1.time_ and arg_242_1.time_ <= var_245_42 + arg_245_0 then
				local var_245_44 = "play"
				local var_245_45 = "effect"

				arg_242_1:AudioAction(var_245_44, var_245_45, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			local var_245_46 = 0.166666666666667
			local var_245_47 = 0.3

			if var_245_46 < arg_242_1.time_ and arg_242_1.time_ <= var_245_46 + arg_245_0 then
				local var_245_48 = "play"
				local var_245_49 = "music"

				arg_242_1:AudioAction(var_245_48, var_245_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_245_50 = ""
				local var_245_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_245_51 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_51 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_51

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_51
						arg_242_1.bgmTxt2_.text = var_245_51
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_52 = 1.63333333333333
			local var_245_53 = 1

			if var_245_52 < arg_242_1.time_ and arg_242_1.time_ <= var_245_52 + arg_245_0 then
				local var_245_54 = "play"
				local var_245_55 = "music"

				arg_242_1:AudioAction(var_245_54, var_245_55, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_245_56 = ""
				local var_245_57 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_245_57 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_57 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_57

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_57
						arg_242_1.bgmTxt2_.text = var_245_57
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_58 = 4
			local var_245_59 = 0.375

			if var_245_58 < arg_242_1.time_ and arg_242_1.time_ <= var_245_58 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_60 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_60:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_242_1.dialogCg_.alpha = arg_248_0
				end))
				var_245_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_61 = arg_242_1:FormatText(StoryNameCfg[6].name)

				arg_242_1.leftNameTxt_.text = var_245_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_62 = arg_242_1:GetWordFromCfg(1108411059)
				local var_245_63 = arg_242_1:FormatText(var_245_62.content)

				arg_242_1.text_.text = var_245_63

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_64 = 15
				local var_245_65 = utf8.len(var_245_63)
				local var_245_66 = var_245_64 <= 0 and var_245_59 or var_245_59 * (var_245_65 / var_245_64)

				if var_245_66 > 0 and var_245_59 < var_245_66 then
					arg_242_1.talkMaxDuration = var_245_66
					var_245_58 = var_245_58 + 0.3

					if var_245_66 + var_245_58 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_66 + var_245_58
					end
				end

				arg_242_1.text_.text = var_245_63
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb") ~= 0 then
					local var_245_67 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb") / 1000

					if var_245_67 + var_245_58 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_67 + var_245_58
					end

					if var_245_62.prefab_name ~= "" and arg_242_1.actors_[var_245_62.prefab_name] ~= nil then
						local var_245_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_62.prefab_name].transform, "story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")

						arg_242_1:RecordAudio("1108411059", var_245_68)
						arg_242_1:RecordAudio("1108411059", var_245_68)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_69 = var_245_58 + 0.3
			local var_245_70 = math.max(var_245_59, arg_242_1.talkMaxDuration)

			if var_245_69 <= arg_242_1.time_ and arg_242_1.time_ < var_245_69 + var_245_70 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_69) / var_245_70

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_69 + var_245_70 and arg_242_1.time_ < var_245_69 + var_245_70 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1108411060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1108411060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1108411061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10102ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10102ui_story == nil then
				arg_250_1.var_.characterEffect10102ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect10102ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10102ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10102ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10102ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 1.175

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_8 = arg_250_1:GetWordFromCfg(1108411060)
				local var_253_9 = arg_250_1:FormatText(var_253_8.content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 47
				local var_253_11 = utf8.len(var_253_9)
				local var_253_12 = var_253_10 <= 0 and var_253_7 or var_253_7 * (var_253_11 / var_253_10)

				if var_253_12 > 0 and var_253_7 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_13 and arg_250_1.time_ < var_253_6 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1108411061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1108411061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1108411062(arg_254_1)
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

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:GetWordFromCfg(1108411061)
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
	Play1108411062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1108411062
		arg_258_1.duration_ = 5.6

		local var_258_0 = {
			zh = 4.5,
			ja = 5.6
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1108411063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10102ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10102ui_story == nil then
				arg_258_1.var_.characterEffect10102ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect10102ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10102ui_story then
				arg_258_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_261_5 = arg_258_1.actors_["10102ui_story"].transform
			local var_261_6 = 0

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.var_.moveOldPos10102ui_story = var_261_5.localPosition
			end

			local var_261_7 = 0.001

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_7 then
				local var_261_8 = (arg_258_1.time_ - var_261_6) / var_261_7
				local var_261_9 = Vector3.New(0, -0.985, -6.275)

				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10102ui_story, var_261_9, var_261_8)

				local var_261_10 = manager.ui.mainCamera.transform.position - var_261_5.position

				var_261_5.forward = Vector3.New(var_261_10.x, var_261_10.y, var_261_10.z)

				local var_261_11 = var_261_5.localEulerAngles

				var_261_11.z = 0
				var_261_11.x = 0
				var_261_5.localEulerAngles = var_261_11
			end

			if arg_258_1.time_ >= var_261_6 + var_261_7 and arg_258_1.time_ < var_261_6 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_261_12 = manager.ui.mainCamera.transform.position - var_261_5.position

				var_261_5.forward = Vector3.New(var_261_12.x, var_261_12.y, var_261_12.z)

				local var_261_13 = var_261_5.localEulerAngles

				var_261_13.z = 0
				var_261_13.x = 0
				var_261_5.localEulerAngles = var_261_13
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_261_15 = 0
			local var_261_16 = 0.5

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[6].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(1108411062)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 20
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")

						arg_258_1:RecordAudio("1108411062", var_261_24)
						arg_258_1:RecordAudio("1108411062", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1108411063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1108411063
		arg_262_1.duration_ = 9.2

		local var_262_0 = {
			zh = 7.666,
			ja = 9.2
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1108411064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.75

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[6].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:GetWordFromCfg(1108411063)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")

						arg_262_1:RecordAudio("1108411063", var_265_9)
						arg_262_1:RecordAudio("1108411063", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1108411064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1108411064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1108411065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10102ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10102ui_story == nil then
				arg_266_1.var_.characterEffect10102ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect10102ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10102ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10102ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10102ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0
			local var_269_7 = 0.175

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_8 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_9 = arg_266_1:GetWordFromCfg(1108411064)
				local var_269_10 = arg_266_1:FormatText(var_269_9.content)

				arg_266_1.text_.text = var_269_10

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 7
				local var_269_12 = utf8.len(var_269_10)
				local var_269_13 = var_269_11 <= 0 and var_269_7 or var_269_7 * (var_269_12 / var_269_11)

				if var_269_13 > 0 and var_269_7 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_10
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_14 and arg_266_1.time_ < var_269_6 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1108411065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1108411065
		arg_270_1.duration_ = 6.1

		local var_270_0 = {
			zh = 6.1,
			ja = 5.9
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
				arg_270_0:Play1108411066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10102ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10102ui_story == nil then
				arg_270_1.var_.characterEffect10102ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect10102ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10102ui_story then
				arg_270_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_273_4 = 0

			if var_273_4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_273_6 = 0
			local var_273_7 = 0.475

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[6].name)

				arg_270_1.leftNameTxt_.text = var_273_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(1108411065)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 19
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb") / 1000

					if var_273_14 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_6
					end

					if var_273_9.prefab_name ~= "" and arg_270_1.actors_[var_273_9.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_9.prefab_name].transform, "story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")

						arg_270_1:RecordAudio("1108411065", var_273_15)
						arg_270_1:RecordAudio("1108411065", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_16 and arg_270_1.time_ < var_273_6 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1108411066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1108411066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1108411067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10102ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10102ui_story == nil then
				arg_274_1.var_.characterEffect10102ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect10102ui_story and not isNil(var_277_0) then
					local var_277_4 = Mathf.Lerp(0, 0.5, var_277_3)

					arg_274_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_274_1.var_.characterEffect10102ui_story.fillRatio = var_277_4
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10102ui_story then
				local var_277_5 = 0.5

				arg_274_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_274_1.var_.characterEffect10102ui_story.fillRatio = var_277_5
			end

			local var_277_6 = 0
			local var_277_7 = 0.65

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_9 = arg_274_1:GetWordFromCfg(1108411066)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 26
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_14 and arg_274_1.time_ < var_277_6 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1108411067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1108411067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1108411068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.675

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

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(1108411067)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 27
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
	Play1108411068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1108411068
		arg_282_1.duration_ = 2.13

		local var_282_0 = {
			zh = 2.1,
			ja = 2.133
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1108411069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10102ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10102ui_story == nil then
				arg_282_1.var_.characterEffect10102ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect10102ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10102ui_story then
				arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_285_4 = 0

			if var_285_4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_285_5 = 0

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_285_6 = 0
			local var_285_7 = 0.2

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[6].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_9 = arg_282_1:GetWordFromCfg(1108411068)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb") ~= 0 then
					local var_285_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb") / 1000

					if var_285_14 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_14 + var_285_6
					end

					if var_285_9.prefab_name ~= "" and arg_282_1.actors_[var_285_9.prefab_name] ~= nil then
						local var_285_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_9.prefab_name].transform, "story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")

						arg_282_1:RecordAudio("1108411068", var_285_15)
						arg_282_1:RecordAudio("1108411068", var_285_15)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_16 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_16 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_16

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_16 and arg_282_1.time_ < var_285_6 + var_285_16 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1108411069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1108411069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1108411070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10102ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect10102ui_story == nil then
				arg_286_1.var_.characterEffect10102ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect10102ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10102ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect10102ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10102ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 0.2

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_9 = arg_286_1:GetWordFromCfg(1108411069)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 8
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_14 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_14 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_14

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_14 and arg_286_1.time_ < var_289_6 + var_289_14 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1108411070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1108411070
		arg_290_1.duration_ = 2.97

		local var_290_0 = {
			zh = 2.3,
			ja = 2.966
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
				arg_290_0:Play1108411071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10102ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect10102ui_story == nil then
				arg_290_1.var_.characterEffect10102ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect10102ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect10102ui_story then
				arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_293_4 = 0

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_293_6 = 0
			local var_293_7 = 0.125

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[6].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_9 = arg_290_1:GetWordFromCfg(1108411070)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 5
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb") ~= 0 then
					local var_293_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb") / 1000

					if var_293_14 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_6
					end

					if var_293_9.prefab_name ~= "" and arg_290_1.actors_[var_293_9.prefab_name] ~= nil then
						local var_293_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_9.prefab_name].transform, "story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")

						arg_290_1:RecordAudio("1108411070", var_293_15)
						arg_290_1:RecordAudio("1108411070", var_293_15)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_16 and arg_290_1.time_ < var_293_6 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1108411071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1108411071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1108411072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10102ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10102ui_story == nil then
				arg_294_1.var_.characterEffect10102ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect10102ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10102ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10102ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10102ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 0.55

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_8 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_9 = arg_294_1:GetWordFromCfg(1108411071)
				local var_297_10 = arg_294_1:FormatText(var_297_9.content)

				arg_294_1.text_.text = var_297_10

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 22
				local var_297_12 = utf8.len(var_297_10)
				local var_297_13 = var_297_11 <= 0 and var_297_7 or var_297_7 * (var_297_12 / var_297_11)

				if var_297_13 > 0 and var_297_7 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_10
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1108411072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1108411072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1108411073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.75

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(1108411072)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 30
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1108411073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1108411073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1108411074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 1.1

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_2 = arg_302_1:GetWordFromCfg(1108411073)
				local var_305_3 = arg_302_1:FormatText(var_305_2.content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 44
				local var_305_5 = utf8.len(var_305_3)
				local var_305_6 = var_305_4 <= 0 and var_305_1 or var_305_1 * (var_305_5 / var_305_4)

				if var_305_6 > 0 and var_305_1 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_7 and arg_302_1.time_ < var_305_0 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1108411074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1108411074
		arg_306_1.duration_ = 7.2

		local var_306_0 = {
			zh = 6.166,
			ja = 7.2
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
				arg_306_0:Play1108411075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10102ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10102ui_story == nil then
				arg_306_1.var_.characterEffect10102ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect10102ui_story and not isNil(var_309_0) then
					arg_306_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10102ui_story then
				arg_306_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_309_4 = 0

			if var_309_4 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_309_5 = 0

			if var_309_5 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_309_6 = 0
			local var_309_7 = 0.65

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[6].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_9 = arg_306_1:GetWordFromCfg(1108411074)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 26
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb") ~= 0 then
					local var_309_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb") / 1000

					if var_309_14 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_14 + var_309_6
					end

					if var_309_9.prefab_name ~= "" and arg_306_1.actors_[var_309_9.prefab_name] ~= nil then
						local var_309_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_9.prefab_name].transform, "story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")

						arg_306_1:RecordAudio("1108411074", var_309_15)
						arg_306_1:RecordAudio("1108411074", var_309_15)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_16 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_16 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_16

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_16 and arg_306_1.time_ < var_309_6 + var_309_16 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1108411075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1108411075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1108411076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10102ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10102ui_story == nil then
				arg_310_1.var_.characterEffect10102ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect10102ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10102ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10102ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10102ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 0.35

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_9 = arg_310_1:GetWordFromCfg(1108411075)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 14
				local var_313_12 = utf8.len(var_313_10)
				local var_313_13 = var_313_11 <= 0 and var_313_7 or var_313_7 * (var_313_12 / var_313_11)

				if var_313_13 > 0 and var_313_7 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_10
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_14 and arg_310_1.time_ < var_313_6 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1108411076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1108411076
		arg_314_1.duration_ = 9.33

		local var_314_0 = {
			zh = 6.1,
			ja = 9.333
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
				arg_314_0:Play1108411077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10102ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10102ui_story == nil then
				arg_314_1.var_.characterEffect10102ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect10102ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10102ui_story then
				arg_314_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_317_4 = 0

			if var_317_4 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_317_6 = 0
			local var_317_7 = 0.85

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[6].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_9 = arg_314_1:GetWordFromCfg(1108411076)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 34
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb") / 1000

					if var_317_14 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_6
					end

					if var_317_9.prefab_name ~= "" and arg_314_1.actors_[var_317_9.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_9.prefab_name].transform, "story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")

						arg_314_1:RecordAudio("1108411076", var_317_15)
						arg_314_1:RecordAudio("1108411076", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_16 and arg_314_1.time_ < var_317_6 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1108411077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1108411077
		arg_318_1.duration_ = 4.4

		local var_318_0 = {
			zh = 3.333,
			ja = 4.4
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
				arg_318_0:Play1108411078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.375

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[6].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(1108411077)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 15
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")

						arg_318_1:RecordAudio("1108411077", var_321_9)
						arg_318_1:RecordAudio("1108411077", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1108411078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1108411078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1108411079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10102ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10102ui_story == nil then
				arg_322_1.var_.characterEffect10102ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect10102ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_322_1.var_.characterEffect10102ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10102ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_322_1.var_.characterEffect10102ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.2

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_9 = arg_322_1:GetWordFromCfg(1108411078)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 8
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_14 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_14 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_14

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_14 and arg_322_1.time_ < var_325_6 + var_325_14 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1108411079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1108411079
		arg_326_1.duration_ = 8.17

		local var_326_0 = {
			zh = 8.066,
			ja = 8.166
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1108411080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10102ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect10102ui_story == nil then
				arg_326_1.var_.characterEffect10102ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect10102ui_story and not isNil(var_329_0) then
					arg_326_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect10102ui_story then
				arg_326_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_329_4 = 0

			if var_329_4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_329_5 = 0

			if var_329_5 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_329_6 = 0
			local var_329_7 = 0.675

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_8 = arg_326_1:FormatText(StoryNameCfg[6].name)

				arg_326_1.leftNameTxt_.text = var_329_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_9 = arg_326_1:GetWordFromCfg(1108411079)
				local var_329_10 = arg_326_1:FormatText(var_329_9.content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 27
				local var_329_12 = utf8.len(var_329_10)
				local var_329_13 = var_329_11 <= 0 and var_329_7 or var_329_7 * (var_329_12 / var_329_11)

				if var_329_13 > 0 and var_329_7 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb") / 1000

					if var_329_14 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_6
					end

					if var_329_9.prefab_name ~= "" and arg_326_1.actors_[var_329_9.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_9.prefab_name].transform, "story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")

						arg_326_1:RecordAudio("1108411079", var_329_15)
						arg_326_1:RecordAudio("1108411079", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_16 and arg_326_1.time_ < var_329_6 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1108411080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1108411080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1108411081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10102ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10102ui_story == nil then
				arg_330_1.var_.characterEffect10102ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect10102ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_330_1.var_.characterEffect10102ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10102ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_330_1.var_.characterEffect10102ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0
			local var_333_7 = 0.925

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(1108411080)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 37
				local var_333_11 = utf8.len(var_333_9)
				local var_333_12 = var_333_10 <= 0 and var_333_7 or var_333_7 * (var_333_11 / var_333_10)

				if var_333_12 > 0 and var_333_7 < var_333_12 then
					arg_330_1.talkMaxDuration = var_333_12

					if var_333_12 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_13 and arg_330_1.time_ < var_333_6 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1108411081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1108411081
		arg_334_1.duration_ = 2.33

		local var_334_0 = {
			zh = 2.3,
			ja = 2.333
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1108411082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10102ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect10102ui_story == nil then
				arg_334_1.var_.characterEffect10102ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect10102ui_story and not isNil(var_337_0) then
					arg_334_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect10102ui_story then
				arg_334_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_337_4 = 0

			if var_337_4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_337_5 = 0
			local var_337_6 = 0.175

			if var_337_5 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_7 = arg_334_1:FormatText(StoryNameCfg[6].name)

				arg_334_1.leftNameTxt_.text = var_337_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(1108411081)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 7
				local var_337_11 = utf8.len(var_337_9)
				local var_337_12 = var_337_10 <= 0 and var_337_6 or var_337_6 * (var_337_11 / var_337_10)

				if var_337_12 > 0 and var_337_6 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb") ~= 0 then
					local var_337_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb") / 1000

					if var_337_13 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_5
					end

					if var_337_8.prefab_name ~= "" and arg_334_1.actors_[var_337_8.prefab_name] ~= nil then
						local var_337_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_8.prefab_name].transform, "story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")

						arg_334_1:RecordAudio("1108411081", var_337_14)
						arg_334_1:RecordAudio("1108411081", var_337_14)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_15 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_15 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_15

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_15 and arg_334_1.time_ < var_337_5 + var_337_15 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1108411082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1108411082
		arg_338_1.duration_ = 8.77

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1108411083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = "I18f"

			if arg_338_1.bgs_[var_341_0] == nil then
				local var_341_1 = Object.Instantiate(arg_338_1.paintGo_)

				var_341_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_341_0)
				var_341_1.name = var_341_0
				var_341_1.transform.parent = arg_338_1.stage_.transform
				var_341_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.bgs_[var_341_0] = var_341_1
			end

			local var_341_2 = 1.999999999999

			if var_341_2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				local var_341_3 = manager.ui.mainCamera.transform.localPosition
				local var_341_4 = Vector3.New(0, 0, 10) + Vector3.New(var_341_3.x, var_341_3.y, 0)
				local var_341_5 = arg_338_1.bgs_.I18f

				var_341_5.transform.localPosition = var_341_4
				var_341_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_6 = var_341_5:GetComponent("SpriteRenderer")

				if var_341_6 and var_341_6.sprite then
					local var_341_7 = (var_341_5.transform.localPosition - var_341_3).z
					local var_341_8 = manager.ui.mainCameraCom_
					local var_341_9 = 2 * var_341_7 * Mathf.Tan(var_341_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_341_10 = var_341_9 * var_341_8.aspect
					local var_341_11 = var_341_6.sprite.bounds.size.x
					local var_341_12 = var_341_6.sprite.bounds.size.y
					local var_341_13 = var_341_10 / var_341_11
					local var_341_14 = var_341_9 / var_341_12
					local var_341_15 = var_341_14 < var_341_13 and var_341_13 or var_341_14

					var_341_5.transform.localScale = Vector3.New(var_341_15, var_341_15, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "I18f" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			local var_341_17 = 0.3

			if arg_338_1.time_ >= var_341_16 + var_341_17 and arg_338_1.time_ < var_341_16 + var_341_17 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end

			local var_341_18 = 0

			if var_341_18 < arg_338_1.time_ and arg_338_1.time_ <= var_341_18 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_19 = 2

			if var_341_18 <= arg_338_1.time_ and arg_338_1.time_ < var_341_18 + var_341_19 then
				local var_341_20 = (arg_338_1.time_ - var_341_18) / var_341_19
				local var_341_21 = Color.New(0, 0, 0)

				var_341_21.a = Mathf.Lerp(0, 1, var_341_20)
				arg_338_1.mask_.color = var_341_21
			end

			if arg_338_1.time_ >= var_341_18 + var_341_19 and arg_338_1.time_ < var_341_18 + var_341_19 + arg_341_0 then
				local var_341_22 = Color.New(0, 0, 0)

				var_341_22.a = 1
				arg_338_1.mask_.color = var_341_22
			end

			local var_341_23 = 2

			if var_341_23 < arg_338_1.time_ and arg_338_1.time_ <= var_341_23 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_24 = 2

			if var_341_23 <= arg_338_1.time_ and arg_338_1.time_ < var_341_23 + var_341_24 then
				local var_341_25 = (arg_338_1.time_ - var_341_23) / var_341_24
				local var_341_26 = Color.New(0, 0, 0)

				var_341_26.a = Mathf.Lerp(1, 0, var_341_25)
				arg_338_1.mask_.color = var_341_26
			end

			if arg_338_1.time_ >= var_341_23 + var_341_24 and arg_338_1.time_ < var_341_23 + var_341_24 + arg_341_0 then
				local var_341_27 = Color.New(0, 0, 0)
				local var_341_28 = 0

				arg_338_1.mask_.enabled = false
				var_341_27.a = var_341_28
				arg_338_1.mask_.color = var_341_27
			end

			local var_341_29 = arg_338_1.actors_["10102ui_story"].transform
			local var_341_30 = 1.96599999815126

			if var_341_30 < arg_338_1.time_ and arg_338_1.time_ <= var_341_30 + arg_341_0 then
				arg_338_1.var_.moveOldPos10102ui_story = var_341_29.localPosition
			end

			local var_341_31 = 0.001

			if var_341_30 <= arg_338_1.time_ and arg_338_1.time_ < var_341_30 + var_341_31 then
				local var_341_32 = (arg_338_1.time_ - var_341_30) / var_341_31
				local var_341_33 = Vector3.New(0, 100, 0)

				var_341_29.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10102ui_story, var_341_33, var_341_32)

				local var_341_34 = manager.ui.mainCamera.transform.position - var_341_29.position

				var_341_29.forward = Vector3.New(var_341_34.x, var_341_34.y, var_341_34.z)

				local var_341_35 = var_341_29.localEulerAngles

				var_341_35.z = 0
				var_341_35.x = 0
				var_341_29.localEulerAngles = var_341_35
			end

			if arg_338_1.time_ >= var_341_30 + var_341_31 and arg_338_1.time_ < var_341_30 + var_341_31 + arg_341_0 then
				var_341_29.localPosition = Vector3.New(0, 100, 0)

				local var_341_36 = manager.ui.mainCamera.transform.position - var_341_29.position

				var_341_29.forward = Vector3.New(var_341_36.x, var_341_36.y, var_341_36.z)

				local var_341_37 = var_341_29.localEulerAngles

				var_341_37.z = 0
				var_341_37.x = 0
				var_341_29.localEulerAngles = var_341_37
			end

			local var_341_38 = 0.166666666666667
			local var_341_39 = 0.3

			if var_341_38 < arg_338_1.time_ and arg_338_1.time_ <= var_341_38 + arg_341_0 then
				local var_341_40 = "play"
				local var_341_41 = "music"

				arg_338_1:AudioAction(var_341_40, var_341_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_341_42 = ""
				local var_341_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_341_43 ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_43 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_43

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_43
						arg_338_1.bgmTxt2_.text = var_341_43
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_341_44 = 1.63333333333333
			local var_341_45 = 1

			if var_341_44 < arg_338_1.time_ and arg_338_1.time_ <= var_341_44 + arg_341_0 then
				local var_341_46 = "play"
				local var_341_47 = "music"

				arg_338_1:AudioAction(var_341_46, var_341_47, "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_341_48 = ""
				local var_341_49 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if var_341_49 ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_49 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_49

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_49
						arg_338_1.bgmTxt2_.text = var_341_49
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_341_50 = 1.63333333333333
			local var_341_51 = 1

			if var_341_50 < arg_338_1.time_ and arg_338_1.time_ <= var_341_50 + arg_341_0 then
				local var_341_52 = "play"
				local var_341_53 = "effect"

				arg_338_1:AudioAction(var_341_52, var_341_53, "se_story_1210", "se_story_1210_morning_loop", "")
			end

			local var_341_54 = 0.166666666666667
			local var_341_55 = 1

			if var_341_54 < arg_338_1.time_ and arg_338_1.time_ <= var_341_54 + arg_341_0 then
				local var_341_56 = "stop"
				local var_341_57 = "effect"

				arg_338_1:AudioAction(var_341_56, var_341_57, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_58 = 3.774999999999
			local var_341_59 = 0.225

			if var_341_58 < arg_338_1.time_ and arg_338_1.time_ <= var_341_58 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_60 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_60:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_338_1.dialogCg_.alpha = arg_344_0
				end))
				var_341_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_61 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_62 = arg_338_1:GetWordFromCfg(1108411082)
				local var_341_63 = arg_338_1:FormatText(var_341_62.content)

				arg_338_1.text_.text = var_341_63

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_64 = 9
				local var_341_65 = utf8.len(var_341_63)
				local var_341_66 = var_341_64 <= 0 and var_341_59 or var_341_59 * (var_341_65 / var_341_64)

				if var_341_66 > 0 and var_341_59 < var_341_66 then
					arg_338_1.talkMaxDuration = var_341_66
					var_341_58 = var_341_58 + 0.3

					if var_341_66 + var_341_58 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_66 + var_341_58
					end
				end

				arg_338_1.text_.text = var_341_63
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_67 = var_341_58 + 0.3
			local var_341_68 = math.max(var_341_59, arg_338_1.talkMaxDuration)

			if var_341_67 <= arg_338_1.time_ and arg_338_1.time_ < var_341_67 + var_341_68 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_67) / var_341_68

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_67 + var_341_68 and arg_338_1.time_ < var_341_67 + var_341_68 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1108411083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1108411083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1108411084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.0946596038993449
			local var_349_1 = 1

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				local var_349_2 = "play"
				local var_349_3 = "effect"

				arg_346_1:AudioAction(var_349_2, var_349_3, "se_story_side_128402", "se_story_side_128402_wind", "")
			end

			local var_349_4 = 0
			local var_349_5 = 1.525

			if var_349_4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(1108411083)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_8 = 61
				local var_349_9 = utf8.len(var_349_7)
				local var_349_10 = var_349_8 <= 0 and var_349_5 or var_349_5 * (var_349_9 / var_349_8)

				if var_349_10 > 0 and var_349_5 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_11 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_11 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_11

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_11 and arg_346_1.time_ < var_349_4 + var_349_11 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1108411084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1108411084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1108411085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 1.5

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(1108411084)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 60
				local var_353_5 = utf8.len(var_353_3)
				local var_353_6 = var_353_4 <= 0 and var_353_1 or var_353_1 * (var_353_5 / var_353_4)

				if var_353_6 > 0 and var_353_1 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_7 and arg_350_1.time_ < var_353_0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1108411085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1108411085
		arg_354_1.duration_ = 9.7

		local var_354_0 = {
			zh = 8.333,
			ja = 9.7
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1108411086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10102ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect10102ui_story == nil then
				arg_354_1.var_.characterEffect10102ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect10102ui_story and not isNil(var_357_0) then
					arg_354_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect10102ui_story then
				arg_354_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_357_4 = 0

			if var_357_4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_357_5 = 0

			if var_357_5 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_357_6 = arg_354_1.actors_["10102ui_story"].transform
			local var_357_7 = 0

			if var_357_7 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.var_.moveOldPos10102ui_story = var_357_6.localPosition
			end

			local var_357_8 = 0.001

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_8 then
				local var_357_9 = (arg_354_1.time_ - var_357_7) / var_357_8
				local var_357_10 = Vector3.New(0, -0.985, -6.275)

				var_357_6.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10102ui_story, var_357_10, var_357_9)

				local var_357_11 = manager.ui.mainCamera.transform.position - var_357_6.position

				var_357_6.forward = Vector3.New(var_357_11.x, var_357_11.y, var_357_11.z)

				local var_357_12 = var_357_6.localEulerAngles

				var_357_12.z = 0
				var_357_12.x = 0
				var_357_6.localEulerAngles = var_357_12
			end

			if arg_354_1.time_ >= var_357_7 + var_357_8 and arg_354_1.time_ < var_357_7 + var_357_8 + arg_357_0 then
				var_357_6.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_357_13 = manager.ui.mainCamera.transform.position - var_357_6.position

				var_357_6.forward = Vector3.New(var_357_13.x, var_357_13.y, var_357_13.z)

				local var_357_14 = var_357_6.localEulerAngles

				var_357_14.z = 0
				var_357_14.x = 0
				var_357_6.localEulerAngles = var_357_14
			end

			local var_357_15 = 0
			local var_357_16 = 1.05

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[6].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(1108411085)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 42
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")

						arg_354_1:RecordAudio("1108411085", var_357_24)
						arg_354_1:RecordAudio("1108411085", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1108411086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1108411086
		arg_358_1.duration_ = 6

		local var_358_0 = {
			zh = 3.333,
			ja = 6
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1108411087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.425

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[6].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_3 = arg_358_1:GetWordFromCfg(1108411086)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 17
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")

						arg_358_1:RecordAudio("1108411086", var_361_9)
						arg_358_1:RecordAudio("1108411086", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1108411087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108411087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108411088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10102ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect10102ui_story == nil then
				arg_362_1.var_.characterEffect10102ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect10102ui_story and not isNil(var_365_0) then
					local var_365_4 = Mathf.Lerp(0, 0.5, var_365_3)

					arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10102ui_story.fillRatio = var_365_4
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect10102ui_story then
				local var_365_5 = 0.5

				arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10102ui_story.fillRatio = var_365_5
			end

			local var_365_6 = 0
			local var_365_7 = 0.575

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_9 = arg_362_1:GetWordFromCfg(1108411087)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 23
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_14 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_14 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_14

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_14 and arg_362_1.time_ < var_365_6 + var_365_14 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1108411088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108411088
		arg_366_1.duration_ = 5.93

		local var_366_0 = {
			zh = 3.133,
			ja = 5.933
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108411089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10102ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect10102ui_story == nil then
				arg_366_1.var_.characterEffect10102ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect10102ui_story and not isNil(var_369_0) then
					arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect10102ui_story then
				arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_369_4 = 0

			if var_369_4 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_369_5 = 0

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_369_6 = 0
			local var_369_7 = 0.375

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[6].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_9 = arg_366_1:GetWordFromCfg(1108411088)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 15
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb") / 1000

					if var_369_14 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_6
					end

					if var_369_9.prefab_name ~= "" and arg_366_1.actors_[var_369_9.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_9.prefab_name].transform, "story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")

						arg_366_1:RecordAudio("1108411088", var_369_15)
						arg_366_1:RecordAudio("1108411088", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_16 and arg_366_1.time_ < var_369_6 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108411089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108411089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108411090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10102ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect10102ui_story == nil then
				arg_370_1.var_.characterEffect10102ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect10102ui_story and not isNil(var_373_0) then
					local var_373_4 = Mathf.Lerp(0, 0.5, var_373_3)

					arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10102ui_story.fillRatio = var_373_4
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect10102ui_story then
				local var_373_5 = 0.5

				arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10102ui_story.fillRatio = var_373_5
			end

			local var_373_6 = 0
			local var_373_7 = 0.525

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_8 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_9 = arg_370_1:GetWordFromCfg(1108411089)
				local var_373_10 = arg_370_1:FormatText(var_373_9.content)

				arg_370_1.text_.text = var_373_10

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_11 = 21
				local var_373_12 = utf8.len(var_373_10)
				local var_373_13 = var_373_11 <= 0 and var_373_7 or var_373_7 * (var_373_12 / var_373_11)

				if var_373_13 > 0 and var_373_7 < var_373_13 then
					arg_370_1.talkMaxDuration = var_373_13

					if var_373_13 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_13 + var_373_6
					end
				end

				arg_370_1.text_.text = var_373_10
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_14 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_14 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_14

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_14 and arg_370_1.time_ < var_373_6 + var_373_14 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108411090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108411090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108411091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.875

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(1108411090)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 35
				local var_377_5 = utf8.len(var_377_3)
				local var_377_6 = var_377_4 <= 0 and var_377_1 or var_377_1 * (var_377_5 / var_377_4)

				if var_377_6 > 0 and var_377_1 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_7 and arg_374_1.time_ < var_377_0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108411091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108411091
		arg_378_1.duration_ = 8.03

		local var_378_0 = {
			zh = 7.033,
			ja = 8.033
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108411092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["10102ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect10102ui_story == nil then
				arg_378_1.var_.characterEffect10102ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect10102ui_story and not isNil(var_381_0) then
					arg_378_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect10102ui_story then
				arg_378_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_381_4 = 0

			if var_381_4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action426")
			end

			local var_381_5 = 0
			local var_381_6 = 0.7

			if var_381_5 < arg_378_1.time_ and arg_378_1.time_ <= var_381_5 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_7 = arg_378_1:FormatText(StoryNameCfg[6].name)

				arg_378_1.leftNameTxt_.text = var_381_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_8 = arg_378_1:GetWordFromCfg(1108411091)
				local var_381_9 = arg_378_1:FormatText(var_381_8.content)

				arg_378_1.text_.text = var_381_9

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_10 = 28
				local var_381_11 = utf8.len(var_381_9)
				local var_381_12 = var_381_10 <= 0 and var_381_6 or var_381_6 * (var_381_11 / var_381_10)

				if var_381_12 > 0 and var_381_6 < var_381_12 then
					arg_378_1.talkMaxDuration = var_381_12

					if var_381_12 + var_381_5 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_5
					end
				end

				arg_378_1.text_.text = var_381_9
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb") ~= 0 then
					local var_381_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb") / 1000

					if var_381_13 + var_381_5 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_5
					end

					if var_381_8.prefab_name ~= "" and arg_378_1.actors_[var_381_8.prefab_name] ~= nil then
						local var_381_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_8.prefab_name].transform, "story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")

						arg_378_1:RecordAudio("1108411091", var_381_14)
						arg_378_1:RecordAudio("1108411091", var_381_14)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_15 = math.max(var_381_6, arg_378_1.talkMaxDuration)

			if var_381_5 <= arg_378_1.time_ and arg_378_1.time_ < var_381_5 + var_381_15 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_5) / var_381_15

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_5 + var_381_15 and arg_378_1.time_ < var_381_5 + var_381_15 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108411092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108411092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108411093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10102ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect10102ui_story == nil then
				arg_382_1.var_.characterEffect10102ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect10102ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_382_1.var_.characterEffect10102ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect10102ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_382_1.var_.characterEffect10102ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 0.35

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_8 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_9 = arg_382_1:GetWordFromCfg(1108411092)
				local var_385_10 = arg_382_1:FormatText(var_385_9.content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 14
				local var_385_12 = utf8.len(var_385_10)
				local var_385_13 = var_385_11 <= 0 and var_385_7 or var_385_7 * (var_385_12 / var_385_11)

				if var_385_13 > 0 and var_385_7 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_14 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_14 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_14

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_14 and arg_382_1.time_ < var_385_6 + var_385_14 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108411093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108411093
		arg_386_1.duration_ = 4.9

		local var_386_0 = {
			zh = 3.433,
			ja = 4.9
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108411094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10102ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10102ui_story == nil then
				arg_386_1.var_.characterEffect10102ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect10102ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10102ui_story then
				arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_389_4 = 0
			local var_389_5 = 0.45

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_6 = arg_386_1:FormatText(StoryNameCfg[6].name)

				arg_386_1.leftNameTxt_.text = var_389_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_7 = arg_386_1:GetWordFromCfg(1108411093)
				local var_389_8 = arg_386_1:FormatText(var_389_7.content)

				arg_386_1.text_.text = var_389_8

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 18
				local var_389_10 = utf8.len(var_389_8)
				local var_389_11 = var_389_9 <= 0 and var_389_5 or var_389_5 * (var_389_10 / var_389_9)

				if var_389_11 > 0 and var_389_5 < var_389_11 then
					arg_386_1.talkMaxDuration = var_389_11

					if var_389_11 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_11 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_8
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb") ~= 0 then
					local var_389_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb") / 1000

					if var_389_12 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_12 + var_389_4
					end

					if var_389_7.prefab_name ~= "" and arg_386_1.actors_[var_389_7.prefab_name] ~= nil then
						local var_389_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_7.prefab_name].transform, "story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")

						arg_386_1:RecordAudio("1108411093", var_389_13)
						arg_386_1:RecordAudio("1108411093", var_389_13)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_14 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_14 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_14

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_14 and arg_386_1.time_ < var_389_4 + var_389_14 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108411094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108411094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108411095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["10102ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect10102ui_story == nil then
				arg_390_1.var_.characterEffect10102ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect10102ui_story and not isNil(var_393_0) then
					local var_393_4 = Mathf.Lerp(0, 0.5, var_393_3)

					arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10102ui_story.fillRatio = var_393_4
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect10102ui_story then
				local var_393_5 = 0.5

				arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10102ui_story.fillRatio = var_393_5
			end

			local var_393_6 = 0
			local var_393_7 = 0.425

			if var_393_6 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_8 = arg_390_1:FormatText(StoryNameCfg[7].name)

				arg_390_1.leftNameTxt_.text = var_393_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_9 = arg_390_1:GetWordFromCfg(1108411094)
				local var_393_10 = arg_390_1:FormatText(var_393_9.content)

				arg_390_1.text_.text = var_393_10

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_11 = 17
				local var_393_12 = utf8.len(var_393_10)
				local var_393_13 = var_393_11 <= 0 and var_393_7 or var_393_7 * (var_393_12 / var_393_11)

				if var_393_13 > 0 and var_393_7 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_6
					end
				end

				arg_390_1.text_.text = var_393_10
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_14 = math.max(var_393_7, arg_390_1.talkMaxDuration)

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_14 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_6) / var_393_14

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_6 + var_393_14 and arg_390_1.time_ < var_393_6 + var_393_14 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108411095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108411095
		arg_394_1.duration_ = 3.97

		local var_394_0 = {
			zh = 3.133,
			ja = 3.966
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108411096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["10102ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect10102ui_story == nil then
				arg_394_1.var_.characterEffect10102ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect10102ui_story and not isNil(var_397_0) then
					arg_394_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect10102ui_story then
				arg_394_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_397_4 = 0

			if var_397_4 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			local var_397_5 = 0
			local var_397_6 = 0.525

			if var_397_5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_7 = arg_394_1:FormatText(StoryNameCfg[6].name)

				arg_394_1.leftNameTxt_.text = var_397_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_8 = arg_394_1:GetWordFromCfg(1108411095)
				local var_397_9 = arg_394_1:FormatText(var_397_8.content)

				arg_394_1.text_.text = var_397_9

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_10 = 21
				local var_397_11 = utf8.len(var_397_9)
				local var_397_12 = var_397_10 <= 0 and var_397_6 or var_397_6 * (var_397_11 / var_397_10)

				if var_397_12 > 0 and var_397_6 < var_397_12 then
					arg_394_1.talkMaxDuration = var_397_12

					if var_397_12 + var_397_5 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_12 + var_397_5
					end
				end

				arg_394_1.text_.text = var_397_9
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb") ~= 0 then
					local var_397_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb") / 1000

					if var_397_13 + var_397_5 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_5
					end

					if var_397_8.prefab_name ~= "" and arg_394_1.actors_[var_397_8.prefab_name] ~= nil then
						local var_397_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_8.prefab_name].transform, "story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")

						arg_394_1:RecordAudio("1108411095", var_397_14)
						arg_394_1:RecordAudio("1108411095", var_397_14)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_15 = math.max(var_397_6, arg_394_1.talkMaxDuration)

			if var_397_5 <= arg_394_1.time_ and arg_394_1.time_ < var_397_5 + var_397_15 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_5) / var_397_15

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_5 + var_397_15 and arg_394_1.time_ < var_397_5 + var_397_15 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108411096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108411096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108411097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["10102ui_story"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect10102ui_story == nil then
				arg_398_1.var_.characterEffect10102ui_story = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.characterEffect10102ui_story and not isNil(var_401_0) then
					local var_401_4 = Mathf.Lerp(0, 0.5, var_401_3)

					arg_398_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_398_1.var_.characterEffect10102ui_story.fillRatio = var_401_4
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect10102ui_story then
				local var_401_5 = 0.5

				arg_398_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_398_1.var_.characterEffect10102ui_story.fillRatio = var_401_5
			end

			local var_401_6 = 0
			local var_401_7 = 0.5

			if var_401_6 < arg_398_1.time_ and arg_398_1.time_ <= var_401_6 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_8 = arg_398_1:FormatText(StoryNameCfg[7].name)

				arg_398_1.leftNameTxt_.text = var_401_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_9 = arg_398_1:GetWordFromCfg(1108411096)
				local var_401_10 = arg_398_1:FormatText(var_401_9.content)

				arg_398_1.text_.text = var_401_10

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_11 = 20
				local var_401_12 = utf8.len(var_401_10)
				local var_401_13 = var_401_11 <= 0 and var_401_7 or var_401_7 * (var_401_12 / var_401_11)

				if var_401_13 > 0 and var_401_7 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_6 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_6
					end
				end

				arg_398_1.text_.text = var_401_10
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_14 = math.max(var_401_7, arg_398_1.talkMaxDuration)

			if var_401_6 <= arg_398_1.time_ and arg_398_1.time_ < var_401_6 + var_401_14 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_6) / var_401_14

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_6 + var_401_14 and arg_398_1.time_ < var_401_6 + var_401_14 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108411097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1108411097
		arg_402_1.duration_ = 7.33

		local var_402_0 = {
			zh = 5.2,
			ja = 7.333
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1108411098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10102ui_story"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect10102ui_story == nil then
				arg_402_1.var_.characterEffect10102ui_story = var_405_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.characterEffect10102ui_story and not isNil(var_405_0) then
					arg_402_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect10102ui_story then
				arg_402_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_405_4 = 0
			local var_405_5 = 0.65

			if var_405_4 < arg_402_1.time_ and arg_402_1.time_ <= var_405_4 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_6 = arg_402_1:FormatText(StoryNameCfg[6].name)

				arg_402_1.leftNameTxt_.text = var_405_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_7 = arg_402_1:GetWordFromCfg(1108411097)
				local var_405_8 = arg_402_1:FormatText(var_405_7.content)

				arg_402_1.text_.text = var_405_8

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_9 = 26
				local var_405_10 = utf8.len(var_405_8)
				local var_405_11 = var_405_9 <= 0 and var_405_5 or var_405_5 * (var_405_10 / var_405_9)

				if var_405_11 > 0 and var_405_5 < var_405_11 then
					arg_402_1.talkMaxDuration = var_405_11

					if var_405_11 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_11 + var_405_4
					end
				end

				arg_402_1.text_.text = var_405_8
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb") ~= 0 then
					local var_405_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb") / 1000

					if var_405_12 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_12 + var_405_4
					end

					if var_405_7.prefab_name ~= "" and arg_402_1.actors_[var_405_7.prefab_name] ~= nil then
						local var_405_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_7.prefab_name].transform, "story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")

						arg_402_1:RecordAudio("1108411097", var_405_13)
						arg_402_1:RecordAudio("1108411097", var_405_13)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_14 = math.max(var_405_5, arg_402_1.talkMaxDuration)

			if var_405_4 <= arg_402_1.time_ and arg_402_1.time_ < var_405_4 + var_405_14 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_4) / var_405_14

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_4 + var_405_14 and arg_402_1.time_ < var_405_4 + var_405_14 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1108411098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1108411098
		arg_406_1.duration_ = 6.07

		local var_406_0 = {
			zh = 4.966,
			ja = 6.066
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1108411099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.55

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[6].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_3 = arg_406_1:GetWordFromCfg(1108411098)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 22
				local var_409_6 = utf8.len(var_409_4)
				local var_409_7 = var_409_5 <= 0 and var_409_1 or var_409_1 * (var_409_6 / var_409_5)

				if var_409_7 > 0 and var_409_1 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_4
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb") / 1000

					if var_409_8 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_0
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")

						arg_406_1:RecordAudio("1108411098", var_409_9)
						arg_406_1:RecordAudio("1108411098", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_10 and arg_406_1.time_ < var_409_0 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1108411099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1108411099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1108411100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["10102ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect10102ui_story == nil then
				arg_410_1.var_.characterEffect10102ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect10102ui_story and not isNil(var_413_0) then
					local var_413_4 = Mathf.Lerp(0, 0.5, var_413_3)

					arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_410_1.var_.characterEffect10102ui_story.fillRatio = var_413_4
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect10102ui_story then
				local var_413_5 = 0.5

				arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_410_1.var_.characterEffect10102ui_story.fillRatio = var_413_5
			end

			local var_413_6 = 0
			local var_413_7 = 0.25

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_8 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_9 = arg_410_1:GetWordFromCfg(1108411099)
				local var_413_10 = arg_410_1:FormatText(var_413_9.content)

				arg_410_1.text_.text = var_413_10

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_11 = 10
				local var_413_12 = utf8.len(var_413_10)
				local var_413_13 = var_413_11 <= 0 and var_413_7 or var_413_7 * (var_413_12 / var_413_11)

				if var_413_13 > 0 and var_413_7 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_10
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_14 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_14 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_14

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_14 and arg_410_1.time_ < var_413_6 + var_413_14 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1108411100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1108411100
		arg_414_1.duration_ = 5.1

		local var_414_0 = {
			zh = 5.1,
			ja = 4.6
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1108411101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["10102ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect10102ui_story == nil then
				arg_414_1.var_.characterEffect10102ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect10102ui_story and not isNil(var_417_0) then
					arg_414_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect10102ui_story then
				arg_414_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_417_4 = 0

			if var_417_4 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				arg_414_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_417_5 = 0

			if var_417_5 < arg_414_1.time_ and arg_414_1.time_ <= var_417_5 + arg_417_0 then
				arg_414_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_417_6 = 0
			local var_417_7 = 0.65

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_8 = arg_414_1:FormatText(StoryNameCfg[6].name)

				arg_414_1.leftNameTxt_.text = var_417_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_9 = arg_414_1:GetWordFromCfg(1108411100)
				local var_417_10 = arg_414_1:FormatText(var_417_9.content)

				arg_414_1.text_.text = var_417_10

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 26
				local var_417_12 = utf8.len(var_417_10)
				local var_417_13 = var_417_11 <= 0 and var_417_7 or var_417_7 * (var_417_12 / var_417_11)

				if var_417_13 > 0 and var_417_7 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_10
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb") / 1000

					if var_417_14 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_6
					end

					if var_417_9.prefab_name ~= "" and arg_414_1.actors_[var_417_9.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_9.prefab_name].transform, "story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")

						arg_414_1:RecordAudio("1108411100", var_417_15)
						arg_414_1:RecordAudio("1108411100", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_16 and arg_414_1.time_ < var_417_6 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1108411101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1108411101
		arg_418_1.duration_ = 7.27

		local var_418_0 = {
			zh = 4.733,
			ja = 7.266
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1108411102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_421_1 = 0
			local var_421_2 = 0.575

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_3 = arg_418_1:FormatText(StoryNameCfg[6].name)

				arg_418_1.leftNameTxt_.text = var_421_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(1108411101)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_6 = 23
				local var_421_7 = utf8.len(var_421_5)
				local var_421_8 = var_421_6 <= 0 and var_421_2 or var_421_2 * (var_421_7 / var_421_6)

				if var_421_8 > 0 and var_421_2 < var_421_8 then
					arg_418_1.talkMaxDuration = var_421_8

					if var_421_8 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb") ~= 0 then
					local var_421_9 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb") / 1000

					if var_421_9 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_9 + var_421_1
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")

						arg_418_1:RecordAudio("1108411101", var_421_10)
						arg_418_1:RecordAudio("1108411101", var_421_10)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_11 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_11 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_11

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_11 and arg_418_1.time_ < var_421_1 + var_421_11 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1108411102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1108411102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1108411103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["10102ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect10102ui_story == nil then
				arg_422_1.var_.characterEffect10102ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect10102ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_422_1.var_.characterEffect10102ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect10102ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_422_1.var_.characterEffect10102ui_story.fillRatio = var_425_5
			end

			local var_425_6 = 0
			local var_425_7 = 0.325

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_8 = arg_422_1:FormatText(StoryNameCfg[7].name)

				arg_422_1.leftNameTxt_.text = var_425_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_9 = arg_422_1:GetWordFromCfg(1108411102)
				local var_425_10 = arg_422_1:FormatText(var_425_9.content)

				arg_422_1.text_.text = var_425_10

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 13
				local var_425_12 = utf8.len(var_425_10)
				local var_425_13 = var_425_11 <= 0 and var_425_7 or var_425_7 * (var_425_12 / var_425_11)

				if var_425_13 > 0 and var_425_7 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_10
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_14 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_14 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_14

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_14 and arg_422_1.time_ < var_425_6 + var_425_14 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1108411103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1108411103
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1108411104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.425

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[7].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(1108411103)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 17
				local var_429_6 = utf8.len(var_429_4)
				local var_429_7 = var_429_5 <= 0 and var_429_1 or var_429_1 * (var_429_6 / var_429_5)

				if var_429_7 > 0 and var_429_1 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_4
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_8 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_8 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_8

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_8 and arg_426_1.time_ < var_429_0 + var_429_8 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1108411104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1108411104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1108411105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["10102ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos10102ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(0, 100, 0)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos10102ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, 100, 0)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = 0
			local var_433_10 = 1.575

			if var_433_9 < arg_430_1.time_ and arg_430_1.time_ <= var_433_9 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_11 = arg_430_1:GetWordFromCfg(1108411104)
				local var_433_12 = arg_430_1:FormatText(var_433_11.content)

				arg_430_1.text_.text = var_433_12

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_13 = 63
				local var_433_14 = utf8.len(var_433_12)
				local var_433_15 = var_433_13 <= 0 and var_433_10 or var_433_10 * (var_433_14 / var_433_13)

				if var_433_15 > 0 and var_433_10 < var_433_15 then
					arg_430_1.talkMaxDuration = var_433_15

					if var_433_15 + var_433_9 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_15 + var_433_9
					end
				end

				arg_430_1.text_.text = var_433_12
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_10, arg_430_1.talkMaxDuration)

			if var_433_9 <= arg_430_1.time_ and arg_430_1.time_ < var_433_9 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_9) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_9 + var_433_16 and arg_430_1.time_ < var_433_9 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1108411105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1108411105
		arg_434_1.duration_ = 1.6

		local var_434_0 = {
			zh = 1.6,
			ja = 1.266
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1108411106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["10102ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10102ui_story == nil then
				arg_434_1.var_.characterEffect10102ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect10102ui_story and not isNil(var_437_0) then
					arg_434_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10102ui_story then
				arg_434_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_437_4 = 0
			local var_437_5 = 0.05

			if var_437_4 < arg_434_1.time_ and arg_434_1.time_ <= var_437_4 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_6 = arg_434_1:FormatText(StoryNameCfg[6].name)

				arg_434_1.leftNameTxt_.text = var_437_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_7 = arg_434_1:GetWordFromCfg(1108411105)
				local var_437_8 = arg_434_1:FormatText(var_437_7.content)

				arg_434_1.text_.text = var_437_8

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_9 = 2
				local var_437_10 = utf8.len(var_437_8)
				local var_437_11 = var_437_9 <= 0 and var_437_5 or var_437_5 * (var_437_10 / var_437_9)

				if var_437_11 > 0 and var_437_5 < var_437_11 then
					arg_434_1.talkMaxDuration = var_437_11

					if var_437_11 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_11 + var_437_4
					end
				end

				arg_434_1.text_.text = var_437_8
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb") ~= 0 then
					local var_437_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb") / 1000

					if var_437_12 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_12 + var_437_4
					end

					if var_437_7.prefab_name ~= "" and arg_434_1.actors_[var_437_7.prefab_name] ~= nil then
						local var_437_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_7.prefab_name].transform, "story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")

						arg_434_1:RecordAudio("1108411105", var_437_13)
						arg_434_1:RecordAudio("1108411105", var_437_13)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_5, arg_434_1.talkMaxDuration)

			if var_437_4 <= arg_434_1.time_ and arg_434_1.time_ < var_437_4 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_4) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_4 + var_437_14 and arg_434_1.time_ < var_437_4 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1108411106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1108411106
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1108411107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10102ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10102ui_story == nil then
				arg_438_1.var_.characterEffect10102ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect10102ui_story and not isNil(var_441_0) then
					local var_441_4 = Mathf.Lerp(0, 0.5, var_441_3)

					arg_438_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_438_1.var_.characterEffect10102ui_story.fillRatio = var_441_4
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10102ui_story then
				local var_441_5 = 0.5

				arg_438_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_438_1.var_.characterEffect10102ui_story.fillRatio = var_441_5
			end

			local var_441_6 = 0
			local var_441_7 = 0.25

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_9 = arg_438_1:GetWordFromCfg(1108411106)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 10
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_14 and arg_438_1.time_ < var_441_6 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1108411107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1108411107
		arg_442_1.duration_ = 8.97

		local var_442_0 = {
			zh = 7.133,
			ja = 8.966
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1108411108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["10102ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos10102ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, -0.985, -6.275)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos10102ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["10102ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect10102ui_story == nil then
				arg_442_1.var_.characterEffect10102ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect10102ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect10102ui_story then
				arg_442_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_445_14 = 0

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_445_15 = 0
			local var_445_16 = 0.875

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_17 = arg_442_1:FormatText(StoryNameCfg[6].name)

				arg_442_1.leftNameTxt_.text = var_445_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_18 = arg_442_1:GetWordFromCfg(1108411107)
				local var_445_19 = arg_442_1:FormatText(var_445_18.content)

				arg_442_1.text_.text = var_445_19

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_20 = 35
				local var_445_21 = utf8.len(var_445_19)
				local var_445_22 = var_445_20 <= 0 and var_445_16 or var_445_16 * (var_445_21 / var_445_20)

				if var_445_22 > 0 and var_445_16 < var_445_22 then
					arg_442_1.talkMaxDuration = var_445_22

					if var_445_22 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_15
					end
				end

				arg_442_1.text_.text = var_445_19
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb") ~= 0 then
					local var_445_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb") / 1000

					if var_445_23 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_23 + var_445_15
					end

					if var_445_18.prefab_name ~= "" and arg_442_1.actors_[var_445_18.prefab_name] ~= nil then
						local var_445_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_18.prefab_name].transform, "story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")

						arg_442_1:RecordAudio("1108411107", var_445_24)
						arg_442_1:RecordAudio("1108411107", var_445_24)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_25 = math.max(var_445_16, arg_442_1.talkMaxDuration)

			if var_445_15 <= arg_442_1.time_ and arg_442_1.time_ < var_445_15 + var_445_25 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_15) / var_445_25

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_15 + var_445_25 and arg_442_1.time_ < var_445_15 + var_445_25 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1108411108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1108411108
		arg_446_1.duration_ = 6.63

		local var_446_0 = {
			zh = 5,
			ja = 6.633
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1108411109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.6

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[6].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_3 = arg_446_1:GetWordFromCfg(1108411108)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 24
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb") / 1000

					if var_449_8 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_0
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")

						arg_446_1:RecordAudio("1108411108", var_449_9)
						arg_446_1:RecordAudio("1108411108", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_10 and arg_446_1.time_ < var_449_0 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1108411109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1108411109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1108411110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["10102ui_story"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect10102ui_story == nil then
				arg_450_1.var_.characterEffect10102ui_story = var_453_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.characterEffect10102ui_story and not isNil(var_453_0) then
					local var_453_4 = Mathf.Lerp(0, 0.5, var_453_3)

					arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_450_1.var_.characterEffect10102ui_story.fillRatio = var_453_4
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect10102ui_story then
				local var_453_5 = 0.5

				arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_450_1.var_.characterEffect10102ui_story.fillRatio = var_453_5
			end

			local var_453_6 = 0
			local var_453_7 = 0.525

			if var_453_6 < arg_450_1.time_ and arg_450_1.time_ <= var_453_6 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_8 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_9 = arg_450_1:GetWordFromCfg(1108411109)
				local var_453_10 = arg_450_1:FormatText(var_453_9.content)

				arg_450_1.text_.text = var_453_10

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_11 = 21
				local var_453_12 = utf8.len(var_453_10)
				local var_453_13 = var_453_11 <= 0 and var_453_7 or var_453_7 * (var_453_12 / var_453_11)

				if var_453_13 > 0 and var_453_7 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_6 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_6
					end
				end

				arg_450_1.text_.text = var_453_10
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_14 = math.max(var_453_7, arg_450_1.talkMaxDuration)

			if var_453_6 <= arg_450_1.time_ and arg_450_1.time_ < var_453_6 + var_453_14 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_6) / var_453_14

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_6 + var_453_14 and arg_450_1.time_ < var_453_6 + var_453_14 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1108411110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1108411110
		arg_454_1.duration_ = 7.27

		local var_454_0 = {
			zh = 5.9326666696469,
			ja = 7.2666666696469
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1108411111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = "ST0115a"

			if arg_454_1.bgs_[var_457_0] == nil then
				local var_457_1 = Object.Instantiate(arg_454_1.paintGo_)

				var_457_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_457_0)
				var_457_1.name = var_457_0
				var_457_1.transform.parent = arg_454_1.stage_.transform
				var_457_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_454_1.bgs_[var_457_0] = var_457_1
			end

			local var_457_2 = 1.33333333333333

			if var_457_2 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				local var_457_3 = manager.ui.mainCamera.transform.localPosition
				local var_457_4 = Vector3.New(0, 0, 10) + Vector3.New(var_457_3.x, var_457_3.y, 0)
				local var_457_5 = arg_454_1.bgs_.ST0115a

				var_457_5.transform.localPosition = var_457_4
				var_457_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_457_6 = var_457_5:GetComponent("SpriteRenderer")

				if var_457_6 and var_457_6.sprite then
					local var_457_7 = (var_457_5.transform.localPosition - var_457_3).z
					local var_457_8 = manager.ui.mainCameraCom_
					local var_457_9 = 2 * var_457_7 * Mathf.Tan(var_457_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_457_10 = var_457_9 * var_457_8.aspect
					local var_457_11 = var_457_6.sprite.bounds.size.x
					local var_457_12 = var_457_6.sprite.bounds.size.y
					local var_457_13 = var_457_10 / var_457_11
					local var_457_14 = var_457_9 / var_457_12
					local var_457_15 = var_457_14 < var_457_13 and var_457_13 or var_457_14

					var_457_5.transform.localScale = Vector3.New(var_457_15, var_457_15, 0)
				end

				for iter_457_0, iter_457_1 in pairs(arg_454_1.bgs_) do
					if iter_457_0 ~= "ST0115a" then
						iter_457_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_457_16 = 0

			if var_457_16 < arg_454_1.time_ and arg_454_1.time_ <= var_457_16 + arg_457_0 then
				arg_454_1.allBtn_.enabled = false
			end

			local var_457_17 = 0.3

			if arg_454_1.time_ >= var_457_16 + var_457_17 and arg_454_1.time_ < var_457_16 + var_457_17 + arg_457_0 then
				arg_454_1.allBtn_.enabled = true
			end

			local var_457_18 = 0

			if var_457_18 < arg_454_1.time_ and arg_454_1.time_ <= var_457_18 + arg_457_0 then
				arg_454_1.mask_.enabled = true
				arg_454_1.mask_.raycastTarget = true

				arg_454_1:SetGaussion(false)
			end

			local var_457_19 = 1.33333333333333

			if var_457_18 <= arg_454_1.time_ and arg_454_1.time_ < var_457_18 + var_457_19 then
				local var_457_20 = (arg_454_1.time_ - var_457_18) / var_457_19
				local var_457_21 = Color.New(0, 0, 0)

				var_457_21.a = Mathf.Lerp(0, 1, var_457_20)
				arg_454_1.mask_.color = var_457_21
			end

			if arg_454_1.time_ >= var_457_18 + var_457_19 and arg_454_1.time_ < var_457_18 + var_457_19 + arg_457_0 then
				local var_457_22 = Color.New(0, 0, 0)

				var_457_22.a = 1
				arg_454_1.mask_.color = var_457_22
			end

			local var_457_23 = 1.33333333333333

			if var_457_23 < arg_454_1.time_ and arg_454_1.time_ <= var_457_23 + arg_457_0 then
				arg_454_1.mask_.enabled = true
				arg_454_1.mask_.raycastTarget = true

				arg_454_1:SetGaussion(false)
			end

			local var_457_24 = 2.1

			if var_457_23 <= arg_454_1.time_ and arg_454_1.time_ < var_457_23 + var_457_24 then
				local var_457_25 = (arg_454_1.time_ - var_457_23) / var_457_24
				local var_457_26 = Color.New(0, 0, 0)

				var_457_26.a = Mathf.Lerp(1, 0, var_457_25)
				arg_454_1.mask_.color = var_457_26
			end

			if arg_454_1.time_ >= var_457_23 + var_457_24 and arg_454_1.time_ < var_457_23 + var_457_24 + arg_457_0 then
				local var_457_27 = Color.New(0, 0, 0)
				local var_457_28 = 0

				arg_454_1.mask_.enabled = false
				var_457_27.a = var_457_28
				arg_454_1.mask_.color = var_457_27
			end

			local var_457_29 = arg_454_1.actors_["10102ui_story"].transform
			local var_457_30 = 1.33333333333333

			if var_457_30 < arg_454_1.time_ and arg_454_1.time_ <= var_457_30 + arg_457_0 then
				arg_454_1.var_.moveOldPos10102ui_story = var_457_29.localPosition
			end

			local var_457_31 = 0.001

			if var_457_30 <= arg_454_1.time_ and arg_454_1.time_ < var_457_30 + var_457_31 then
				local var_457_32 = (arg_454_1.time_ - var_457_30) / var_457_31
				local var_457_33 = Vector3.New(0, 100, 0)

				var_457_29.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10102ui_story, var_457_33, var_457_32)

				local var_457_34 = manager.ui.mainCamera.transform.position - var_457_29.position

				var_457_29.forward = Vector3.New(var_457_34.x, var_457_34.y, var_457_34.z)

				local var_457_35 = var_457_29.localEulerAngles

				var_457_35.z = 0
				var_457_35.x = 0
				var_457_29.localEulerAngles = var_457_35
			end

			if arg_454_1.time_ >= var_457_30 + var_457_31 and arg_454_1.time_ < var_457_30 + var_457_31 + arg_457_0 then
				var_457_29.localPosition = Vector3.New(0, 100, 0)

				local var_457_36 = manager.ui.mainCamera.transform.position - var_457_29.position

				var_457_29.forward = Vector3.New(var_457_36.x, var_457_36.y, var_457_36.z)

				local var_457_37 = var_457_29.localEulerAngles

				var_457_37.z = 0
				var_457_37.x = 0
				var_457_29.localEulerAngles = var_457_37
			end

			local var_457_38 = 0.133333333333333
			local var_457_39 = 0.3

			if var_457_38 < arg_454_1.time_ and arg_454_1.time_ <= var_457_38 + arg_457_0 then
				local var_457_40 = "play"
				local var_457_41 = "music"

				arg_454_1:AudioAction(var_457_40, var_457_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_457_42 = ""
				local var_457_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_457_43 ~= "" then
					if arg_454_1.bgmTxt_.text ~= var_457_43 and arg_454_1.bgmTxt_.text ~= "" then
						if arg_454_1.bgmTxt2_.text ~= "" then
							arg_454_1.bgmTxt_.text = arg_454_1.bgmTxt2_.text
						end

						arg_454_1.bgmTxt2_.text = var_457_43

						arg_454_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_454_1.bgmTxt_.text = var_457_43
						arg_454_1.bgmTxt2_.text = var_457_43
					end

					if arg_454_1.bgmTimer then
						arg_454_1.bgmTimer:Stop()

						arg_454_1.bgmTimer = nil
					end

					if arg_454_1.settingData.show_music_name == 1 then
						arg_454_1.musicController:SetSelectedState("show")
						arg_454_1.musicAnimator_:Play("open", 0, 0)

						if arg_454_1.settingData.music_time ~= 0 then
							arg_454_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_454_1.settingData.music_time), function()
								if arg_454_1 == nil or isNil(arg_454_1.bgmTxt_) then
									return
								end

								arg_454_1.musicController:SetSelectedState("hide")
								arg_454_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_457_44 = 0.166666666666667
			local var_457_45 = 1

			if var_457_44 < arg_454_1.time_ and arg_454_1.time_ <= var_457_44 + arg_457_0 then
				local var_457_46 = "stop"
				local var_457_47 = "effect"

				arg_454_1:AudioAction(var_457_46, var_457_47, "se_story_1210", "se_story_1210_morning_loop", "")
			end

			local var_457_48 = 1
			local var_457_49 = 1

			if var_457_48 < arg_454_1.time_ and arg_454_1.time_ <= var_457_48 + arg_457_0 then
				local var_457_50 = "play"
				local var_457_51 = "effect"

				arg_454_1:AudioAction(var_457_50, var_457_51, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_457_52 = 3.2666666696469
			local var_457_53 = 1

			if var_457_52 < arg_454_1.time_ and arg_454_1.time_ <= var_457_52 + arg_457_0 then
				local var_457_54 = "play"
				local var_457_55 = "effect"

				arg_454_1:AudioAction(var_457_54, var_457_55, "se_story_side_128402", "se_story_side_128402_bed", "")
			end

			if arg_454_1.frameCnt_ <= 1 then
				arg_454_1.dialog_:SetActive(false)
			end

			local var_457_56 = 3.2666666696469
			local var_457_57 = 0.2

			if var_457_56 < arg_454_1.time_ and arg_454_1.time_ <= var_457_56 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0

				arg_454_1.dialog_:SetActive(true)

				arg_454_1.dialogCg_.alpha = 0

				local var_457_58 = LeanTween.value(arg_454_1.dialog_, 0, 1, 0.3)

				var_457_58:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_454_1.dialogCg_.alpha = arg_459_0
				end))
				var_457_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_454_1.dialog_)
					var_457_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_454_1.duration_ = arg_454_1.duration_ + 0.3

				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_59 = arg_454_1:FormatText(StoryNameCfg[6].name)

				arg_454_1.leftNameTxt_.text = var_457_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_60 = arg_454_1:GetWordFromCfg(1108411110)
				local var_457_61 = arg_454_1:FormatText(var_457_60.content)

				arg_454_1.text_.text = var_457_61

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_62 = 8
				local var_457_63 = utf8.len(var_457_61)
				local var_457_64 = var_457_62 <= 0 and var_457_57 or var_457_57 * (var_457_63 / var_457_62)

				if var_457_64 > 0 and var_457_57 < var_457_64 then
					arg_454_1.talkMaxDuration = var_457_64
					var_457_56 = var_457_56 + 0.3

					if var_457_64 + var_457_56 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_64 + var_457_56
					end
				end

				arg_454_1.text_.text = var_457_61
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb") ~= 0 then
					local var_457_65 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb") / 1000

					if var_457_65 + var_457_56 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_65 + var_457_56
					end

					if var_457_60.prefab_name ~= "" and arg_454_1.actors_[var_457_60.prefab_name] ~= nil then
						local var_457_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_60.prefab_name].transform, "story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")

						arg_454_1:RecordAudio("1108411110", var_457_66)
						arg_454_1:RecordAudio("1108411110", var_457_66)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_67 = var_457_56 + 0.3
			local var_457_68 = math.max(var_457_57, arg_454_1.talkMaxDuration)

			if var_457_67 <= arg_454_1.time_ and arg_454_1.time_ < var_457_67 + var_457_68 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_67) / var_457_68

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_67 + var_457_68 and arg_454_1.time_ < var_457_67 + var_457_68 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play1108411111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108411111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108411112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10102ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos10102ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, 100, 0)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10102ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, 100, 0)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["10102ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect10102ui_story == nil then
				arg_461_1.var_.characterEffect10102ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect10102ui_story and not isNil(var_464_9) then
					local var_464_13 = Mathf.Lerp(0, 0.5, var_464_12)

					arg_461_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10102ui_story.fillRatio = var_464_13
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect10102ui_story then
				local var_464_14 = 0.5

				arg_461_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10102ui_story.fillRatio = var_464_14
			end

			local var_464_15 = 0
			local var_464_16 = 0.3

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				local var_464_17 = "play"
				local var_464_18 = "music"

				arg_461_1:AudioAction(var_464_17, var_464_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_464_19 = ""
				local var_464_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_464_20 ~= "" then
					if arg_461_1.bgmTxt_.text ~= var_464_20 and arg_461_1.bgmTxt_.text ~= "" then
						if arg_461_1.bgmTxt2_.text ~= "" then
							arg_461_1.bgmTxt_.text = arg_461_1.bgmTxt2_.text
						end

						arg_461_1.bgmTxt2_.text = var_464_20

						arg_461_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_461_1.bgmTxt_.text = var_464_20
						arg_461_1.bgmTxt2_.text = var_464_20
					end

					if arg_461_1.bgmTimer then
						arg_461_1.bgmTimer:Stop()

						arg_461_1.bgmTimer = nil
					end

					if arg_461_1.settingData.show_music_name == 1 then
						arg_461_1.musicController:SetSelectedState("show")
						arg_461_1.musicAnimator_:Play("open", 0, 0)

						if arg_461_1.settingData.music_time ~= 0 then
							arg_461_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_461_1.settingData.music_time), function()
								if arg_461_1 == nil or isNil(arg_461_1.bgmTxt_) then
									return
								end

								arg_461_1.musicController:SetSelectedState("hide")
								arg_461_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_464_21 = 0.3
			local var_464_22 = 1

			if var_464_21 < arg_461_1.time_ and arg_461_1.time_ <= var_464_21 + arg_464_0 then
				local var_464_23 = "play"
				local var_464_24 = "music"

				arg_461_1:AudioAction(var_464_23, var_464_24, "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_464_25 = ""
				local var_464_26 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if var_464_26 ~= "" then
					if arg_461_1.bgmTxt_.text ~= var_464_26 and arg_461_1.bgmTxt_.text ~= "" then
						if arg_461_1.bgmTxt2_.text ~= "" then
							arg_461_1.bgmTxt_.text = arg_461_1.bgmTxt2_.text
						end

						arg_461_1.bgmTxt2_.text = var_464_26

						arg_461_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_461_1.bgmTxt_.text = var_464_26
						arg_461_1.bgmTxt2_.text = var_464_26
					end

					if arg_461_1.bgmTimer then
						arg_461_1.bgmTimer:Stop()

						arg_461_1.bgmTimer = nil
					end

					if arg_461_1.settingData.show_music_name == 1 then
						arg_461_1.musicController:SetSelectedState("show")
						arg_461_1.musicAnimator_:Play("open", 0, 0)

						if arg_461_1.settingData.music_time ~= 0 then
							arg_461_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_461_1.settingData.music_time), function()
								if arg_461_1 == nil or isNil(arg_461_1.bgmTxt_) then
									return
								end

								arg_461_1.musicController:SetSelectedState("hide")
								arg_461_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_464_27 = 0
			local var_464_28 = 1.175

			if var_464_27 < arg_461_1.time_ and arg_461_1.time_ <= var_464_27 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_29 = arg_461_1:GetWordFromCfg(1108411111)
				local var_464_30 = arg_461_1:FormatText(var_464_29.content)

				arg_461_1.text_.text = var_464_30

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_31 = 47
				local var_464_32 = utf8.len(var_464_30)
				local var_464_33 = var_464_31 <= 0 and var_464_28 or var_464_28 * (var_464_32 / var_464_31)

				if var_464_33 > 0 and var_464_28 < var_464_33 then
					arg_461_1.talkMaxDuration = var_464_33

					if var_464_33 + var_464_27 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_33 + var_464_27
					end
				end

				arg_461_1.text_.text = var_464_30
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_34 = math.max(var_464_28, arg_461_1.talkMaxDuration)

			if var_464_27 <= arg_461_1.time_ and arg_461_1.time_ < var_464_27 + var_464_34 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_27) / var_464_34

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_27 + var_464_34 and arg_461_1.time_ < var_464_27 + var_464_34 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108411112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108411112
		arg_467_1.duration_ = 3.3

		local var_467_0 = {
			zh = 2.6,
			ja = 3.3
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108411113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["10102ui_story"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect10102ui_story == nil then
				arg_467_1.var_.characterEffect10102ui_story = var_470_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.characterEffect10102ui_story and not isNil(var_470_0) then
					arg_467_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect10102ui_story then
				arg_467_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_470_4 = 0
			local var_470_5 = 0.525

			if var_470_4 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_6 = arg_467_1:FormatText(StoryNameCfg[6].name)

				arg_467_1.leftNameTxt_.text = var_470_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_7 = arg_467_1:GetWordFromCfg(1108411112)
				local var_470_8 = arg_467_1:FormatText(var_470_7.content)

				arg_467_1.text_.text = var_470_8

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 21
				local var_470_10 = utf8.len(var_470_8)
				local var_470_11 = var_470_9 <= 0 and var_470_5 or var_470_5 * (var_470_10 / var_470_9)

				if var_470_11 > 0 and var_470_5 < var_470_11 then
					arg_467_1.talkMaxDuration = var_470_11

					if var_470_11 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_11 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_8
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb") ~= 0 then
					local var_470_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb") / 1000

					if var_470_12 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_4
					end

					if var_470_7.prefab_name ~= "" and arg_467_1.actors_[var_470_7.prefab_name] ~= nil then
						local var_470_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_7.prefab_name].transform, "story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")

						arg_467_1:RecordAudio("1108411112", var_470_13)
						arg_467_1:RecordAudio("1108411112", var_470_13)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_14 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_14 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_14

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_14 and arg_467_1.time_ < var_470_4 + var_470_14 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108411113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108411113
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108411114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["10102ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect10102ui_story == nil then
				arg_471_1.var_.characterEffect10102ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect10102ui_story and not isNil(var_474_0) then
					local var_474_4 = Mathf.Lerp(0, 0.5, var_474_3)

					arg_471_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_471_1.var_.characterEffect10102ui_story.fillRatio = var_474_4
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect10102ui_story then
				local var_474_5 = 0.5

				arg_471_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_471_1.var_.characterEffect10102ui_story.fillRatio = var_474_5
			end

			local var_474_6 = 0
			local var_474_7 = 0.375

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_8 = arg_471_1:FormatText(StoryNameCfg[7].name)

				arg_471_1.leftNameTxt_.text = var_474_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_9 = arg_471_1:GetWordFromCfg(1108411113)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_11 = 15
				local var_474_12 = utf8.len(var_474_10)
				local var_474_13 = var_474_11 <= 0 and var_474_7 or var_474_7 * (var_474_12 / var_474_11)

				if var_474_13 > 0 and var_474_7 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_10
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_14 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_14 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_14

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_14 and arg_471_1.time_ < var_474_6 + var_474_14 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1108411114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108411114
		arg_475_1.duration_ = 4.5

		local var_475_0 = {
			zh = 3.033,
			ja = 4.5
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108411115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["10102ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect10102ui_story == nil then
				arg_475_1.var_.characterEffect10102ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect10102ui_story and not isNil(var_478_0) then
					arg_475_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect10102ui_story then
				arg_475_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_478_4 = 0
			local var_478_5 = 0.375

			if var_478_4 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_6 = arg_475_1:FormatText(StoryNameCfg[6].name)

				arg_475_1.leftNameTxt_.text = var_478_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_7 = arg_475_1:GetWordFromCfg(1108411114)
				local var_478_8 = arg_475_1:FormatText(var_478_7.content)

				arg_475_1.text_.text = var_478_8

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_9 = 15
				local var_478_10 = utf8.len(var_478_8)
				local var_478_11 = var_478_9 <= 0 and var_478_5 or var_478_5 * (var_478_10 / var_478_9)

				if var_478_11 > 0 and var_478_5 < var_478_11 then
					arg_475_1.talkMaxDuration = var_478_11

					if var_478_11 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_4
					end
				end

				arg_475_1.text_.text = var_478_8
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb") ~= 0 then
					local var_478_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb") / 1000

					if var_478_12 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_12 + var_478_4
					end

					if var_478_7.prefab_name ~= "" and arg_475_1.actors_[var_478_7.prefab_name] ~= nil then
						local var_478_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_7.prefab_name].transform, "story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")

						arg_475_1:RecordAudio("1108411114", var_478_13)
						arg_475_1:RecordAudio("1108411114", var_478_13)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_14 = math.max(var_478_5, arg_475_1.talkMaxDuration)

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_14 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_4) / var_478_14

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_4 + var_478_14 and arg_475_1.time_ < var_478_4 + var_478_14 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1108411115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1108411115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1108411116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["10102ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect10102ui_story == nil then
				arg_479_1.var_.characterEffect10102ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect10102ui_story and not isNil(var_482_0) then
					local var_482_4 = Mathf.Lerp(0, 0.5, var_482_3)

					arg_479_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_479_1.var_.characterEffect10102ui_story.fillRatio = var_482_4
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect10102ui_story then
				local var_482_5 = 0.5

				arg_479_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_479_1.var_.characterEffect10102ui_story.fillRatio = var_482_5
			end

			local var_482_6 = 0
			local var_482_7 = 0.7

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_8 = arg_479_1:FormatText(StoryNameCfg[7].name)

				arg_479_1.leftNameTxt_.text = var_482_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_9 = arg_479_1:GetWordFromCfg(1108411115)
				local var_482_10 = arg_479_1:FormatText(var_482_9.content)

				arg_479_1.text_.text = var_482_10

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_11 = 28
				local var_482_12 = utf8.len(var_482_10)
				local var_482_13 = var_482_11 <= 0 and var_482_7 or var_482_7 * (var_482_12 / var_482_11)

				if var_482_13 > 0 and var_482_7 < var_482_13 then
					arg_479_1.talkMaxDuration = var_482_13

					if var_482_13 + var_482_6 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_13 + var_482_6
					end
				end

				arg_479_1.text_.text = var_482_10
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_14 = math.max(var_482_7, arg_479_1.talkMaxDuration)

			if var_482_6 <= arg_479_1.time_ and arg_479_1.time_ < var_482_6 + var_482_14 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_6) / var_482_14

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_6 + var_482_14 and arg_479_1.time_ < var_482_6 + var_482_14 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1108411116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1108411116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1108411117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.35

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[7].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:GetWordFromCfg(1108411116)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 14
				local var_486_6 = utf8.len(var_486_4)
				local var_486_7 = var_486_5 <= 0 and var_486_1 or var_486_1 * (var_486_6 / var_486_5)

				if var_486_7 > 0 and var_486_1 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_8 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_8 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_8

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_8 and arg_483_1.time_ < var_486_0 + var_486_8 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1108411117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1108411117
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1108411118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.875

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_2 = arg_487_1:GetWordFromCfg(1108411117)
				local var_490_3 = arg_487_1:FormatText(var_490_2.content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 35
				local var_490_5 = utf8.len(var_490_3)
				local var_490_6 = var_490_4 <= 0 and var_490_1 or var_490_1 * (var_490_5 / var_490_4)

				if var_490_6 > 0 and var_490_1 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_7 and arg_487_1.time_ < var_490_0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1108411118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1108411118
		arg_491_1.duration_ = 8.97

		local var_491_0 = {
			zh = 8.966,
			ja = 8.7
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1108411119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.95

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[6].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_3 = arg_491_1:GetWordFromCfg(1108411118)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 38
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")

						arg_491_1:RecordAudio("1108411118", var_494_9)
						arg_491_1:RecordAudio("1108411118", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1108411119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108411119
		arg_495_1.duration_ = 6

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108411120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["10102ui_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10102ui_story == nil then
				arg_495_1.var_.characterEffect10102ui_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect10102ui_story and not isNil(var_498_0) then
					local var_498_4 = Mathf.Lerp(0, 0.5, var_498_3)

					arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10102ui_story.fillRatio = var_498_4
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10102ui_story then
				local var_498_5 = 0.5

				arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10102ui_story.fillRatio = var_498_5
			end

			local var_498_6 = manager.ui.mainCamera.transform
			local var_498_7 = 0

			if var_498_7 < arg_495_1.time_ and arg_495_1.time_ <= var_498_7 + arg_498_0 then
				local var_498_8 = arg_495_1.var_.effect1232
				local var_498_9
				local var_498_10 = var_498_6

				if not var_498_8 then
					var_498_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), var_498_10)
					var_498_8.name = "1232"
					arg_495_1.var_.effect1232 = var_498_8
				else
					var_498_8.transform:SetParent(var_498_10)
				end

				var_498_8.transform.localPosition = Vector3.New(0.09, -0.41, 3.42)
				var_498_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_498_11 = 1.7777777777777777
				local var_498_12 = Screen.width / Screen.height
				local var_498_13 = var_498_12 / var_498_11
				local var_498_14 = Mathf.Max(var_498_11 / var_498_12, 1)

				var_498_8.transform.localScale = Vector3.New(var_498_8.transform.localScale.x * var_498_13, var_498_8.transform.localScale.y * var_498_14, var_498_8.transform.localScale.z)
			end

			local var_498_15 = manager.ui.mainCamera.transform
			local var_498_16 = 1.76666666666667

			if var_498_16 < arg_495_1.time_ and arg_495_1.time_ <= var_498_16 + arg_498_0 then
				local var_498_17 = arg_495_1.var_.effect1232

				if var_498_17 then
					Object.Destroy(var_498_17)

					arg_495_1.var_.effect1232 = nil
				end
			end

			local var_498_18 = 0

			if var_498_18 < arg_495_1.time_ and arg_495_1.time_ <= var_498_18 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			local var_498_19 = 1.6

			if arg_495_1.time_ >= var_498_18 + var_498_19 and arg_495_1.time_ < var_498_18 + var_498_19 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end

			if arg_495_1.frameCnt_ <= 1 then
				arg_495_1.dialog_:SetActive(false)
			end

			local var_498_20 = 1
			local var_498_21 = 1.25

			if var_498_20 < arg_495_1.time_ and arg_495_1.time_ <= var_498_20 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0

				arg_495_1.dialog_:SetActive(true)

				arg_495_1.dialogCg_.alpha = 0

				local var_498_22 = LeanTween.value(arg_495_1.dialog_, 0, 1, 0.3)

				var_498_22:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_495_1.dialogCg_.alpha = arg_499_0
				end))
				var_498_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_495_1.dialog_)
					var_498_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_495_1.duration_ = arg_495_1.duration_ + 0.3

				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_23 = arg_495_1:GetWordFromCfg(1108411119)
				local var_498_24 = arg_495_1:FormatText(var_498_23.content)

				arg_495_1.text_.text = var_498_24

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_25 = 50
				local var_498_26 = utf8.len(var_498_24)
				local var_498_27 = var_498_25 <= 0 and var_498_21 or var_498_21 * (var_498_26 / var_498_25)

				if var_498_27 > 0 and var_498_21 < var_498_27 then
					arg_495_1.talkMaxDuration = var_498_27
					var_498_20 = var_498_20 + 0.3

					if var_498_27 + var_498_20 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_27 + var_498_20
					end
				end

				arg_495_1.text_.text = var_498_24
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_28 = var_498_20 + 0.3
			local var_498_29 = math.max(var_498_21, arg_495_1.talkMaxDuration)

			if var_498_28 <= arg_495_1.time_ and arg_495_1.time_ < var_498_28 + var_498_29 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_28) / var_498_29

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_28 + var_498_29 and arg_495_1.time_ < var_498_28 + var_498_29 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108411120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1108411120
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1108411121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.1

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:GetWordFromCfg(1108411120)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 4
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_8 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_8 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_8

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_8 and arg_501_1.time_ < var_504_0 + var_504_8 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1108411121 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1108411121
		arg_505_1.duration_ = 8.1

		local var_505_0 = {
			zh = 5.733,
			ja = 8.1
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1108411122(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.65

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_2 = arg_505_1:FormatText(StoryNameCfg[6].name)

				arg_505_1.leftNameTxt_.text = var_508_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_3 = arg_505_1:GetWordFromCfg(1108411121)
				local var_508_4 = arg_505_1:FormatText(var_508_3.content)

				arg_505_1.text_.text = var_508_4

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 26
				local var_508_6 = utf8.len(var_508_4)
				local var_508_7 = var_508_5 <= 0 and var_508_1 or var_508_1 * (var_508_6 / var_508_5)

				if var_508_7 > 0 and var_508_1 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_4
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb") ~= 0 then
					local var_508_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb") / 1000

					if var_508_8 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_8 + var_508_0
					end

					if var_508_3.prefab_name ~= "" and arg_505_1.actors_[var_508_3.prefab_name] ~= nil then
						local var_508_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_3.prefab_name].transform, "story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")

						arg_505_1:RecordAudio("1108411121", var_508_9)
						arg_505_1:RecordAudio("1108411121", var_508_9)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_10 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_10 and arg_505_1.time_ < var_508_0 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1108411122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1108411122
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1108411123(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["10102ui_story"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect10102ui_story == nil then
				arg_509_1.var_.characterEffect10102ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.200000002980232

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.characterEffect10102ui_story and not isNil(var_512_0) then
					local var_512_4 = Mathf.Lerp(0, 0.5, var_512_3)

					arg_509_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_509_1.var_.characterEffect10102ui_story.fillRatio = var_512_4
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect10102ui_story then
				local var_512_5 = 0.5

				arg_509_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_509_1.var_.characterEffect10102ui_story.fillRatio = var_512_5
			end

			local var_512_6 = 0
			local var_512_7 = 0.525

			if var_512_6 < arg_509_1.time_ and arg_509_1.time_ <= var_512_6 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_8 = arg_509_1:FormatText(StoryNameCfg[7].name)

				arg_509_1.leftNameTxt_.text = var_512_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_9 = arg_509_1:GetWordFromCfg(1108411122)
				local var_512_10 = arg_509_1:FormatText(var_512_9.content)

				arg_509_1.text_.text = var_512_10

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_11 = 21
				local var_512_12 = utf8.len(var_512_10)
				local var_512_13 = var_512_11 <= 0 and var_512_7 or var_512_7 * (var_512_12 / var_512_11)

				if var_512_13 > 0 and var_512_7 < var_512_13 then
					arg_509_1.talkMaxDuration = var_512_13

					if var_512_13 + var_512_6 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_13 + var_512_6
					end
				end

				arg_509_1.text_.text = var_512_10
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_14 = math.max(var_512_7, arg_509_1.talkMaxDuration)

			if var_512_6 <= arg_509_1.time_ and arg_509_1.time_ < var_512_6 + var_512_14 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_6) / var_512_14

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_6 + var_512_14 and arg_509_1.time_ < var_512_6 + var_512_14 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1108411123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1108411123
		arg_513_1.duration_ = 5.57

		local var_513_0 = {
			zh = 3.4,
			ja = 5.566
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1108411124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["10102ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect10102ui_story == nil then
				arg_513_1.var_.characterEffect10102ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect10102ui_story and not isNil(var_516_0) then
					arg_513_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect10102ui_story then
				arg_513_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_516_4 = 0
			local var_516_5 = 0.35

			if var_516_4 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_6 = arg_513_1:FormatText(StoryNameCfg[6].name)

				arg_513_1.leftNameTxt_.text = var_516_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_7 = arg_513_1:GetWordFromCfg(1108411123)
				local var_516_8 = arg_513_1:FormatText(var_516_7.content)

				arg_513_1.text_.text = var_516_8

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 14
				local var_516_10 = utf8.len(var_516_8)
				local var_516_11 = var_516_9 <= 0 and var_516_5 or var_516_5 * (var_516_10 / var_516_9)

				if var_516_11 > 0 and var_516_5 < var_516_11 then
					arg_513_1.talkMaxDuration = var_516_11

					if var_516_11 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_11 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_8
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb") ~= 0 then
					local var_516_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb") / 1000

					if var_516_12 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_12 + var_516_4
					end

					if var_516_7.prefab_name ~= "" and arg_513_1.actors_[var_516_7.prefab_name] ~= nil then
						local var_516_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_7.prefab_name].transform, "story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")

						arg_513_1:RecordAudio("1108411123", var_516_13)
						arg_513_1:RecordAudio("1108411123", var_516_13)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_14 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 <= arg_513_1.time_ and arg_513_1.time_ < var_516_4 + var_516_14 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_4) / var_516_14

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_4 + var_516_14 and arg_513_1.time_ < var_516_4 + var_516_14 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1108411124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1108411124
		arg_517_1.duration_ = 3.63

		local var_517_0 = {
			zh = 2.166,
			ja = 3.633
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1108411125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.275

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[6].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1108411124)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 11
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb") / 1000

					if var_520_8 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_0
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")

						arg_517_1:RecordAudio("1108411124", var_520_9)
						arg_517_1:RecordAudio("1108411124", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_10 and arg_517_1.time_ < var_520_0 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1108411125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1108411125
		arg_521_1.duration_ = 6.03

		local var_521_0 = {
			zh = 4.366,
			ja = 6.033
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1108411126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.575

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[6].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:GetWordFromCfg(1108411125)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 23
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")

						arg_521_1:RecordAudio("1108411125", var_524_9)
						arg_521_1:RecordAudio("1108411125", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_10 and arg_521_1.time_ < var_524_0 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1108411126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1108411126
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1108411127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["10102ui_story"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect10102ui_story == nil then
				arg_525_1.var_.characterEffect10102ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect10102ui_story and not isNil(var_528_0) then
					local var_528_4 = Mathf.Lerp(0, 0.5, var_528_3)

					arg_525_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_525_1.var_.characterEffect10102ui_story.fillRatio = var_528_4
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect10102ui_story then
				local var_528_5 = 0.5

				arg_525_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_525_1.var_.characterEffect10102ui_story.fillRatio = var_528_5
			end

			local var_528_6 = 0
			local var_528_7 = 0.425

			if var_528_6 < arg_525_1.time_ and arg_525_1.time_ <= var_528_6 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_8 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_9 = arg_525_1:GetWordFromCfg(1108411126)
				local var_528_10 = arg_525_1:FormatText(var_528_9.content)

				arg_525_1.text_.text = var_528_10

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_11 = 17
				local var_528_12 = utf8.len(var_528_10)
				local var_528_13 = var_528_11 <= 0 and var_528_7 or var_528_7 * (var_528_12 / var_528_11)

				if var_528_13 > 0 and var_528_7 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_6
					end
				end

				arg_525_1.text_.text = var_528_10
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_14 = math.max(var_528_7, arg_525_1.talkMaxDuration)

			if var_528_6 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_14 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_14

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_14 and arg_525_1.time_ < var_528_6 + var_528_14 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1108411127 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1108411127
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1108411128(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 0.3

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_2 = arg_529_1:FormatText(StoryNameCfg[7].name)

				arg_529_1.leftNameTxt_.text = var_532_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:GetWordFromCfg(1108411127)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 12
				local var_532_6 = utf8.len(var_532_4)
				local var_532_7 = var_532_5 <= 0 and var_532_1 or var_532_1 * (var_532_6 / var_532_5)

				if var_532_7 > 0 and var_532_1 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_8 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_8 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_8

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_8 and arg_529_1.time_ < var_532_0 + var_532_8 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1108411128 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1108411128
		arg_533_1.duration_ = 1.7

		local var_533_0 = {
			zh = 1.333,
			ja = 1.7
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1108411129(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.075

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[6].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:GetWordFromCfg(1108411128)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 3
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")

						arg_533_1:RecordAudio("1108411128", var_536_9)
						arg_533_1:RecordAudio("1108411128", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_10 and arg_533_1.time_ < var_536_0 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1108411129 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1108411129
		arg_537_1.duration_ = 7.97

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1108411130(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = "ST0116a"

			if arg_537_1.bgs_[var_540_0] == nil then
				local var_540_1 = Object.Instantiate(arg_537_1.paintGo_)

				var_540_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_540_0)
				var_540_1.name = var_540_0
				var_540_1.transform.parent = arg_537_1.stage_.transform
				var_540_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_537_1.bgs_[var_540_0] = var_540_1
			end

			local var_540_2 = 1.43333333333333

			if var_540_2 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				local var_540_3 = manager.ui.mainCamera.transform.localPosition
				local var_540_4 = Vector3.New(0, 0, 10) + Vector3.New(var_540_3.x, var_540_3.y, 0)
				local var_540_5 = arg_537_1.bgs_.ST0116a

				var_540_5.transform.localPosition = var_540_4
				var_540_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_540_6 = var_540_5:GetComponent("SpriteRenderer")

				if var_540_6 and var_540_6.sprite then
					local var_540_7 = (var_540_5.transform.localPosition - var_540_3).z
					local var_540_8 = manager.ui.mainCameraCom_
					local var_540_9 = 2 * var_540_7 * Mathf.Tan(var_540_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_540_10 = var_540_9 * var_540_8.aspect
					local var_540_11 = var_540_6.sprite.bounds.size.x
					local var_540_12 = var_540_6.sprite.bounds.size.y
					local var_540_13 = var_540_10 / var_540_11
					local var_540_14 = var_540_9 / var_540_12
					local var_540_15 = var_540_14 < var_540_13 and var_540_13 or var_540_14

					var_540_5.transform.localScale = Vector3.New(var_540_15, var_540_15, 0)
				end

				for iter_540_0, iter_540_1 in pairs(arg_537_1.bgs_) do
					if iter_540_0 ~= "ST0116a" then
						iter_540_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_540_16 = 0

			if var_540_16 < arg_537_1.time_ and arg_537_1.time_ <= var_540_16 + arg_540_0 then
				arg_537_1.allBtn_.enabled = false
			end

			local var_540_17 = 0.3

			if arg_537_1.time_ >= var_540_16 + var_540_17 and arg_537_1.time_ < var_540_16 + var_540_17 + arg_540_0 then
				arg_537_1.allBtn_.enabled = true
			end

			local var_540_18 = 0

			if var_540_18 < arg_537_1.time_ and arg_537_1.time_ <= var_540_18 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_19 = 1.43333333333333

			if var_540_18 <= arg_537_1.time_ and arg_537_1.time_ < var_540_18 + var_540_19 then
				local var_540_20 = (arg_537_1.time_ - var_540_18) / var_540_19
				local var_540_21 = Color.New(0, 0, 0)

				var_540_21.a = Mathf.Lerp(0, 1, var_540_20)
				arg_537_1.mask_.color = var_540_21
			end

			if arg_537_1.time_ >= var_540_18 + var_540_19 and arg_537_1.time_ < var_540_18 + var_540_19 + arg_540_0 then
				local var_540_22 = Color.New(0, 0, 0)

				var_540_22.a = 1
				arg_537_1.mask_.color = var_540_22
			end

			local var_540_23 = 1.43333333333333

			if var_540_23 < arg_537_1.time_ and arg_537_1.time_ <= var_540_23 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_24 = 2

			if var_540_23 <= arg_537_1.time_ and arg_537_1.time_ < var_540_23 + var_540_24 then
				local var_540_25 = (arg_537_1.time_ - var_540_23) / var_540_24
				local var_540_26 = Color.New(0, 0, 0)

				var_540_26.a = Mathf.Lerp(1, 0, var_540_25)
				arg_537_1.mask_.color = var_540_26
			end

			if arg_537_1.time_ >= var_540_23 + var_540_24 and arg_537_1.time_ < var_540_23 + var_540_24 + arg_540_0 then
				local var_540_27 = Color.New(0, 0, 0)
				local var_540_28 = 0

				arg_537_1.mask_.enabled = false
				var_540_27.a = var_540_28
				arg_537_1.mask_.color = var_540_27
			end

			local var_540_29 = 0.166666666666667
			local var_540_30 = 1

			if var_540_29 < arg_537_1.time_ and arg_537_1.time_ <= var_540_29 + arg_540_0 then
				local var_540_31 = "stop"
				local var_540_32 = "effect"

				arg_537_1:AudioAction(var_540_31, var_540_32, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_540_33 = 1
			local var_540_34 = 1

			if var_540_33 < arg_537_1.time_ and arg_537_1.time_ <= var_540_33 + arg_540_0 then
				local var_540_35 = "play"
				local var_540_36 = "effect"

				arg_537_1:AudioAction(var_540_35, var_540_36, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if arg_537_1.frameCnt_ <= 1 then
				arg_537_1.dialog_:SetActive(false)
			end

			local var_540_37 = 2.96666666666667
			local var_540_38 = 1.35

			if var_540_37 < arg_537_1.time_ and arg_537_1.time_ <= var_540_37 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0

				arg_537_1.dialog_:SetActive(true)

				arg_537_1.dialogCg_.alpha = 0

				local var_540_39 = LeanTween.value(arg_537_1.dialog_, 0, 1, 0.3)

				var_540_39:setOnUpdate(LuaHelper.FloatAction(function(arg_541_0)
					arg_537_1.dialogCg_.alpha = arg_541_0
				end))
				var_540_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_537_1.dialog_)
					var_540_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_537_1.duration_ = arg_537_1.duration_ + 0.3

				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_40 = arg_537_1:GetWordFromCfg(1108411129)
				local var_540_41 = arg_537_1:FormatText(var_540_40.content)

				arg_537_1.text_.text = var_540_41

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_42 = 54
				local var_540_43 = utf8.len(var_540_41)
				local var_540_44 = var_540_42 <= 0 and var_540_38 or var_540_38 * (var_540_43 / var_540_42)

				if var_540_44 > 0 and var_540_38 < var_540_44 then
					arg_537_1.talkMaxDuration = var_540_44
					var_540_37 = var_540_37 + 0.3

					if var_540_44 + var_540_37 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_44 + var_540_37
					end
				end

				arg_537_1.text_.text = var_540_41
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_45 = var_540_37 + 0.3
			local var_540_46 = math.max(var_540_38, arg_537_1.talkMaxDuration)

			if var_540_45 <= arg_537_1.time_ and arg_537_1.time_ < var_540_45 + var_540_46 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_45) / var_540_46

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_45 + var_540_46 and arg_537_1.time_ < var_540_45 + var_540_46 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1108411130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108411130
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108411131(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 0.675

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_2 = arg_543_1:GetWordFromCfg(1108411130)
				local var_546_3 = arg_543_1:FormatText(var_546_2.content)

				arg_543_1.text_.text = var_546_3

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_4 = 27
				local var_546_5 = utf8.len(var_546_3)
				local var_546_6 = var_546_4 <= 0 and var_546_1 or var_546_1 * (var_546_5 / var_546_4)

				if var_546_6 > 0 and var_546_1 < var_546_6 then
					arg_543_1.talkMaxDuration = var_546_6

					if var_546_6 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_6 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_3
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_7 and arg_543_1.time_ < var_546_0 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1108411131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108411131
		arg_547_1.duration_ = 8.67

		local var_547_0 = {
			zh = 5.366,
			ja = 8.666
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108411132(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["10102ui_story"].transform
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.var_.moveOldPos10102ui_story = var_550_0.localPosition
			end

			local var_550_2 = 0.001

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2
				local var_550_4 = Vector3.New(0, -0.985, -6.275)

				var_550_0.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10102ui_story, var_550_4, var_550_3)

				local var_550_5 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_5.x, var_550_5.y, var_550_5.z)

				local var_550_6 = var_550_0.localEulerAngles

				var_550_6.z = 0
				var_550_6.x = 0
				var_550_0.localEulerAngles = var_550_6
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 then
				var_550_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_550_7 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_7.x, var_550_7.y, var_550_7.z)

				local var_550_8 = var_550_0.localEulerAngles

				var_550_8.z = 0
				var_550_8.x = 0
				var_550_0.localEulerAngles = var_550_8
			end

			local var_550_9 = arg_547_1.actors_["10102ui_story"]
			local var_550_10 = 0

			if var_550_10 < arg_547_1.time_ and arg_547_1.time_ <= var_550_10 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect10102ui_story == nil then
				arg_547_1.var_.characterEffect10102ui_story = var_550_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_11 = 0.200000002980232

			if var_550_10 <= arg_547_1.time_ and arg_547_1.time_ < var_550_10 + var_550_11 and not isNil(var_550_9) then
				local var_550_12 = (arg_547_1.time_ - var_550_10) / var_550_11

				if arg_547_1.var_.characterEffect10102ui_story and not isNil(var_550_9) then
					arg_547_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= var_550_10 + var_550_11 and arg_547_1.time_ < var_550_10 + var_550_11 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect10102ui_story then
				arg_547_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_550_13 = 0

			if var_550_13 < arg_547_1.time_ and arg_547_1.time_ <= var_550_13 + arg_550_0 then
				arg_547_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_550_14 = 0

			if var_550_14 < arg_547_1.time_ and arg_547_1.time_ <= var_550_14 + arg_550_0 then
				arg_547_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_550_15 = 0
			local var_550_16 = 0.525

			if var_550_15 < arg_547_1.time_ and arg_547_1.time_ <= var_550_15 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_17 = arg_547_1:FormatText(StoryNameCfg[6].name)

				arg_547_1.leftNameTxt_.text = var_550_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_18 = arg_547_1:GetWordFromCfg(1108411131)
				local var_550_19 = arg_547_1:FormatText(var_550_18.content)

				arg_547_1.text_.text = var_550_19

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_20 = 21
				local var_550_21 = utf8.len(var_550_19)
				local var_550_22 = var_550_20 <= 0 and var_550_16 or var_550_16 * (var_550_21 / var_550_20)

				if var_550_22 > 0 and var_550_16 < var_550_22 then
					arg_547_1.talkMaxDuration = var_550_22

					if var_550_22 + var_550_15 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_22 + var_550_15
					end
				end

				arg_547_1.text_.text = var_550_19
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb") ~= 0 then
					local var_550_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb") / 1000

					if var_550_23 + var_550_15 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_23 + var_550_15
					end

					if var_550_18.prefab_name ~= "" and arg_547_1.actors_[var_550_18.prefab_name] ~= nil then
						local var_550_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_18.prefab_name].transform, "story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")

						arg_547_1:RecordAudio("1108411131", var_550_24)
						arg_547_1:RecordAudio("1108411131", var_550_24)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_25 = math.max(var_550_16, arg_547_1.talkMaxDuration)

			if var_550_15 <= arg_547_1.time_ and arg_547_1.time_ < var_550_15 + var_550_25 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_15) / var_550_25

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_15 + var_550_25 and arg_547_1.time_ < var_550_15 + var_550_25 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108411132 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108411132
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108411133(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["10102ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10102ui_story == nil then
				arg_551_1.var_.characterEffect10102ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect10102ui_story and not isNil(var_554_0) then
					local var_554_4 = Mathf.Lerp(0, 0.5, var_554_3)

					arg_551_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_551_1.var_.characterEffect10102ui_story.fillRatio = var_554_4
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10102ui_story then
				local var_554_5 = 0.5

				arg_551_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_551_1.var_.characterEffect10102ui_story.fillRatio = var_554_5
			end

			local var_554_6 = 0
			local var_554_7 = 0.575

			if var_554_6 < arg_551_1.time_ and arg_551_1.time_ <= var_554_6 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_8 = arg_551_1:FormatText(StoryNameCfg[7].name)

				arg_551_1.leftNameTxt_.text = var_554_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_9 = arg_551_1:GetWordFromCfg(1108411132)
				local var_554_10 = arg_551_1:FormatText(var_554_9.content)

				arg_551_1.text_.text = var_554_10

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_11 = 23
				local var_554_12 = utf8.len(var_554_10)
				local var_554_13 = var_554_11 <= 0 and var_554_7 or var_554_7 * (var_554_12 / var_554_11)

				if var_554_13 > 0 and var_554_7 < var_554_13 then
					arg_551_1.talkMaxDuration = var_554_13

					if var_554_13 + var_554_6 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_13 + var_554_6
					end
				end

				arg_551_1.text_.text = var_554_10
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_14 = math.max(var_554_7, arg_551_1.talkMaxDuration)

			if var_554_6 <= arg_551_1.time_ and arg_551_1.time_ < var_554_6 + var_554_14 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_6) / var_554_14

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_6 + var_554_14 and arg_551_1.time_ < var_554_6 + var_554_14 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108411133 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108411133
		arg_555_1.duration_ = 6.2

		local var_555_0 = {
			zh = 5.366,
			ja = 6.2
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1108411134(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["10102ui_story"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect10102ui_story == nil then
				arg_555_1.var_.characterEffect10102ui_story = var_558_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.characterEffect10102ui_story and not isNil(var_558_0) then
					arg_555_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect10102ui_story then
				arg_555_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_558_4 = 0

			if var_558_4 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_558_5 = 0
			local var_558_6 = 0.7

			if var_558_5 < arg_555_1.time_ and arg_555_1.time_ <= var_558_5 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_7 = arg_555_1:FormatText(StoryNameCfg[6].name)

				arg_555_1.leftNameTxt_.text = var_558_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_8 = arg_555_1:GetWordFromCfg(1108411133)
				local var_558_9 = arg_555_1:FormatText(var_558_8.content)

				arg_555_1.text_.text = var_558_9

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_10 = 28
				local var_558_11 = utf8.len(var_558_9)
				local var_558_12 = var_558_10 <= 0 and var_558_6 or var_558_6 * (var_558_11 / var_558_10)

				if var_558_12 > 0 and var_558_6 < var_558_12 then
					arg_555_1.talkMaxDuration = var_558_12

					if var_558_12 + var_558_5 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_12 + var_558_5
					end
				end

				arg_555_1.text_.text = var_558_9
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb") ~= 0 then
					local var_558_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb") / 1000

					if var_558_13 + var_558_5 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_13 + var_558_5
					end

					if var_558_8.prefab_name ~= "" and arg_555_1.actors_[var_558_8.prefab_name] ~= nil then
						local var_558_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_8.prefab_name].transform, "story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")

						arg_555_1:RecordAudio("1108411133", var_558_14)
						arg_555_1:RecordAudio("1108411133", var_558_14)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_15 = math.max(var_558_6, arg_555_1.talkMaxDuration)

			if var_558_5 <= arg_555_1.time_ and arg_555_1.time_ < var_558_5 + var_558_15 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_5) / var_558_15

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_5 + var_558_15 and arg_555_1.time_ < var_558_5 + var_558_15 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1108411134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1108411134
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1108411135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["10102ui_story"]
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect10102ui_story == nil then
				arg_559_1.var_.characterEffect10102ui_story = var_562_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 and not isNil(var_562_0) then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2

				if arg_559_1.var_.characterEffect10102ui_story and not isNil(var_562_0) then
					local var_562_4 = Mathf.Lerp(0, 0.5, var_562_3)

					arg_559_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_559_1.var_.characterEffect10102ui_story.fillRatio = var_562_4
				end
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect10102ui_story then
				local var_562_5 = 0.5

				arg_559_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_559_1.var_.characterEffect10102ui_story.fillRatio = var_562_5
			end

			local var_562_6 = 0
			local var_562_7 = 0.075

			if var_562_6 < arg_559_1.time_ and arg_559_1.time_ <= var_562_6 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_8 = arg_559_1:FormatText(StoryNameCfg[7].name)

				arg_559_1.leftNameTxt_.text = var_562_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_9 = arg_559_1:GetWordFromCfg(1108411134)
				local var_562_10 = arg_559_1:FormatText(var_562_9.content)

				arg_559_1.text_.text = var_562_10

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_11 = 3
				local var_562_12 = utf8.len(var_562_10)
				local var_562_13 = var_562_11 <= 0 and var_562_7 or var_562_7 * (var_562_12 / var_562_11)

				if var_562_13 > 0 and var_562_7 < var_562_13 then
					arg_559_1.talkMaxDuration = var_562_13

					if var_562_13 + var_562_6 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_13 + var_562_6
					end
				end

				arg_559_1.text_.text = var_562_10
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_14 = math.max(var_562_7, arg_559_1.talkMaxDuration)

			if var_562_6 <= arg_559_1.time_ and arg_559_1.time_ < var_562_6 + var_562_14 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_6) / var_562_14

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_6 + var_562_14 and arg_559_1.time_ < var_562_6 + var_562_14 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1108411135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1108411135
		arg_563_1.duration_ = 10.07

		local var_563_0 = {
			zh = 7.9,
			ja = 10.066
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1108411136(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["10102ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect10102ui_story == nil then
				arg_563_1.var_.characterEffect10102ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect10102ui_story and not isNil(var_566_0) then
					arg_563_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect10102ui_story then
				arg_563_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_566_4 = 0
			local var_566_5 = 0.925

			if var_566_4 < arg_563_1.time_ and arg_563_1.time_ <= var_566_4 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_6 = arg_563_1:FormatText(StoryNameCfg[6].name)

				arg_563_1.leftNameTxt_.text = var_566_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_7 = arg_563_1:GetWordFromCfg(1108411135)
				local var_566_8 = arg_563_1:FormatText(var_566_7.content)

				arg_563_1.text_.text = var_566_8

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_9 = 37
				local var_566_10 = utf8.len(var_566_8)
				local var_566_11 = var_566_9 <= 0 and var_566_5 or var_566_5 * (var_566_10 / var_566_9)

				if var_566_11 > 0 and var_566_5 < var_566_11 then
					arg_563_1.talkMaxDuration = var_566_11

					if var_566_11 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_11 + var_566_4
					end
				end

				arg_563_1.text_.text = var_566_8
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb") ~= 0 then
					local var_566_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb") / 1000

					if var_566_12 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_12 + var_566_4
					end

					if var_566_7.prefab_name ~= "" and arg_563_1.actors_[var_566_7.prefab_name] ~= nil then
						local var_566_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_7.prefab_name].transform, "story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")

						arg_563_1:RecordAudio("1108411135", var_566_13)
						arg_563_1:RecordAudio("1108411135", var_566_13)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_14 = math.max(var_566_5, arg_563_1.talkMaxDuration)

			if var_566_4 <= arg_563_1.time_ and arg_563_1.time_ < var_566_4 + var_566_14 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_4) / var_566_14

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_4 + var_566_14 and arg_563_1.time_ < var_566_4 + var_566_14 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1108411136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1108411136
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1108411137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["10102ui_story"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect10102ui_story == nil then
				arg_567_1.var_.characterEffect10102ui_story = var_570_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_2 = 0.200000002980232

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 and not isNil(var_570_0) then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.characterEffect10102ui_story and not isNil(var_570_0) then
					local var_570_4 = Mathf.Lerp(0, 0.5, var_570_3)

					arg_567_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_567_1.var_.characterEffect10102ui_story.fillRatio = var_570_4
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect10102ui_story then
				local var_570_5 = 0.5

				arg_567_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_567_1.var_.characterEffect10102ui_story.fillRatio = var_570_5
			end

			local var_570_6 = 0
			local var_570_7 = 0.4

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_8 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_9 = arg_567_1:GetWordFromCfg(1108411136)
				local var_570_10 = arg_567_1:FormatText(var_570_9.content)

				arg_567_1.text_.text = var_570_10

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_11 = 16
				local var_570_12 = utf8.len(var_570_10)
				local var_570_13 = var_570_11 <= 0 and var_570_7 or var_570_7 * (var_570_12 / var_570_11)

				if var_570_13 > 0 and var_570_7 < var_570_13 then
					arg_567_1.talkMaxDuration = var_570_13

					if var_570_13 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_13 + var_570_6
					end
				end

				arg_567_1.text_.text = var_570_10
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_14 = math.max(var_570_7, arg_567_1.talkMaxDuration)

			if var_570_6 <= arg_567_1.time_ and arg_567_1.time_ < var_570_6 + var_570_14 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_6) / var_570_14

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_6 + var_570_14 and arg_567_1.time_ < var_570_6 + var_570_14 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1108411137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1108411137
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1108411138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.95

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_2 = arg_571_1:FormatText(StoryNameCfg[7].name)

				arg_571_1.leftNameTxt_.text = var_574_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:GetWordFromCfg(1108411137)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 38
				local var_574_6 = utf8.len(var_574_4)
				local var_574_7 = var_574_5 <= 0 and var_574_1 or var_574_1 * (var_574_6 / var_574_5)

				if var_574_7 > 0 and var_574_1 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_8 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_8 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_8

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_8 and arg_571_1.time_ < var_574_0 + var_574_8 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1108411138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1108411138
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1108411139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.35

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[7].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_3 = arg_575_1:GetWordFromCfg(1108411138)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 14
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_8 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_8 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_8

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_8 and arg_575_1.time_ < var_578_0 + var_578_8 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1108411139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1108411139
		arg_579_1.duration_ = 5.8

		local var_579_0 = {
			zh = 4.2,
			ja = 5.8
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1108411140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["10102ui_story"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect10102ui_story == nil then
				arg_579_1.var_.characterEffect10102ui_story = var_582_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_2 = 0.200000002980232

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 and not isNil(var_582_0) then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.characterEffect10102ui_story and not isNil(var_582_0) then
					arg_579_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect10102ui_story then
				arg_579_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_582_4 = 0

			if var_582_4 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action462")
			end

			local var_582_5 = 0

			if var_582_5 < arg_579_1.time_ and arg_579_1.time_ <= var_582_5 + arg_582_0 then
				arg_579_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_582_6 = 0
			local var_582_7 = 0.45

			if var_582_6 < arg_579_1.time_ and arg_579_1.time_ <= var_582_6 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_8 = arg_579_1:FormatText(StoryNameCfg[6].name)

				arg_579_1.leftNameTxt_.text = var_582_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_9 = arg_579_1:GetWordFromCfg(1108411139)
				local var_582_10 = arg_579_1:FormatText(var_582_9.content)

				arg_579_1.text_.text = var_582_10

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_11 = 18
				local var_582_12 = utf8.len(var_582_10)
				local var_582_13 = var_582_11 <= 0 and var_582_7 or var_582_7 * (var_582_12 / var_582_11)

				if var_582_13 > 0 and var_582_7 < var_582_13 then
					arg_579_1.talkMaxDuration = var_582_13

					if var_582_13 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_13 + var_582_6
					end
				end

				arg_579_1.text_.text = var_582_10
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb") ~= 0 then
					local var_582_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb") / 1000

					if var_582_14 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_14 + var_582_6
					end

					if var_582_9.prefab_name ~= "" and arg_579_1.actors_[var_582_9.prefab_name] ~= nil then
						local var_582_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_9.prefab_name].transform, "story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")

						arg_579_1:RecordAudio("1108411139", var_582_15)
						arg_579_1:RecordAudio("1108411139", var_582_15)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_16 = math.max(var_582_7, arg_579_1.talkMaxDuration)

			if var_582_6 <= arg_579_1.time_ and arg_579_1.time_ < var_582_6 + var_582_16 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_6) / var_582_16

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_6 + var_582_16 and arg_579_1.time_ < var_582_6 + var_582_16 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1108411140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1108411140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1108411141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["10102ui_story"]
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect10102ui_story == nil then
				arg_583_1.var_.characterEffect10102ui_story = var_586_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_2 = 0.200000002980232

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 and not isNil(var_586_0) then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2

				if arg_583_1.var_.characterEffect10102ui_story and not isNil(var_586_0) then
					local var_586_4 = Mathf.Lerp(0, 0.5, var_586_3)

					arg_583_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_583_1.var_.characterEffect10102ui_story.fillRatio = var_586_4
				end
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect10102ui_story then
				local var_586_5 = 0.5

				arg_583_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_583_1.var_.characterEffect10102ui_story.fillRatio = var_586_5
			end

			local var_586_6 = 0
			local var_586_7 = 0.475

			if var_586_6 < arg_583_1.time_ and arg_583_1.time_ <= var_586_6 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_8 = arg_583_1:FormatText(StoryNameCfg[7].name)

				arg_583_1.leftNameTxt_.text = var_586_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_9 = arg_583_1:GetWordFromCfg(1108411140)
				local var_586_10 = arg_583_1:FormatText(var_586_9.content)

				arg_583_1.text_.text = var_586_10

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_11 = 19
				local var_586_12 = utf8.len(var_586_10)
				local var_586_13 = var_586_11 <= 0 and var_586_7 or var_586_7 * (var_586_12 / var_586_11)

				if var_586_13 > 0 and var_586_7 < var_586_13 then
					arg_583_1.talkMaxDuration = var_586_13

					if var_586_13 + var_586_6 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_13 + var_586_6
					end
				end

				arg_583_1.text_.text = var_586_10
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_14 = math.max(var_586_7, arg_583_1.talkMaxDuration)

			if var_586_6 <= arg_583_1.time_ and arg_583_1.time_ < var_586_6 + var_586_14 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_6) / var_586_14

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_6 + var_586_14 and arg_583_1.time_ < var_586_6 + var_586_14 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1108411141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1108411141
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1108411142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["10102ui_story"].transform
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.var_.moveOldPos10102ui_story = var_590_0.localPosition
			end

			local var_590_2 = 0.001

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2
				local var_590_4 = Vector3.New(0, 100, 0)

				var_590_0.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10102ui_story, var_590_4, var_590_3)

				local var_590_5 = manager.ui.mainCamera.transform.position - var_590_0.position

				var_590_0.forward = Vector3.New(var_590_5.x, var_590_5.y, var_590_5.z)

				local var_590_6 = var_590_0.localEulerAngles

				var_590_6.z = 0
				var_590_6.x = 0
				var_590_0.localEulerAngles = var_590_6
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 then
				var_590_0.localPosition = Vector3.New(0, 100, 0)

				local var_590_7 = manager.ui.mainCamera.transform.position - var_590_0.position

				var_590_0.forward = Vector3.New(var_590_7.x, var_590_7.y, var_590_7.z)

				local var_590_8 = var_590_0.localEulerAngles

				var_590_8.z = 0
				var_590_8.x = 0
				var_590_0.localEulerAngles = var_590_8
			end

			local var_590_9 = 0
			local var_590_10 = 1.2

			if var_590_9 < arg_587_1.time_ and arg_587_1.time_ <= var_590_9 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_11 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_12 = arg_587_1:GetWordFromCfg(1108411141)
				local var_590_13 = arg_587_1:FormatText(var_590_12.content)

				arg_587_1.text_.text = var_590_13

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_14 = 48
				local var_590_15 = utf8.len(var_590_13)
				local var_590_16 = var_590_14 <= 0 and var_590_10 or var_590_10 * (var_590_15 / var_590_14)

				if var_590_16 > 0 and var_590_10 < var_590_16 then
					arg_587_1.talkMaxDuration = var_590_16

					if var_590_16 + var_590_9 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_16 + var_590_9
					end
				end

				arg_587_1.text_.text = var_590_13
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_17 = math.max(var_590_10, arg_587_1.talkMaxDuration)

			if var_590_9 <= arg_587_1.time_ and arg_587_1.time_ < var_590_9 + var_590_17 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_9) / var_590_17

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_9 + var_590_17 and arg_587_1.time_ < var_590_9 + var_590_17 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play1108411142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1108411142
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1108411143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 1

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[7].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(1108411142)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 40
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_8 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_8 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_8

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_8 and arg_591_1.time_ < var_594_0 + var_594_8 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1108411143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1108411143
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1108411144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.775

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[7].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(1108411143)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 31
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_8 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_8 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_8

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_8 and arg_595_1.time_ < var_598_0 + var_598_8 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1108411144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1108411144
		arg_599_1.duration_ = 7.6

		local var_599_0 = {
			zh = 3.9,
			ja = 7.6
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1108411145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["10102ui_story"].transform
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.var_.moveOldPos10102ui_story = var_602_0.localPosition
			end

			local var_602_2 = 0.001

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2
				local var_602_4 = Vector3.New(0, 100, 0)

				var_602_0.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos10102ui_story, var_602_4, var_602_3)

				local var_602_5 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_5.x, var_602_5.y, var_602_5.z)

				local var_602_6 = var_602_0.localEulerAngles

				var_602_6.z = 0
				var_602_6.x = 0
				var_602_0.localEulerAngles = var_602_6
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 then
				var_602_0.localPosition = Vector3.New(0, 100, 0)

				local var_602_7 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_7.x, var_602_7.y, var_602_7.z)

				local var_602_8 = var_602_0.localEulerAngles

				var_602_8.z = 0
				var_602_8.x = 0
				var_602_0.localEulerAngles = var_602_8
			end

			local var_602_9 = arg_599_1.actors_["10102ui_story"]
			local var_602_10 = 0

			if var_602_10 < arg_599_1.time_ and arg_599_1.time_ <= var_602_10 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect10102ui_story == nil then
				arg_599_1.var_.characterEffect10102ui_story = var_602_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_11 = 0.200000002980232

			if var_602_10 <= arg_599_1.time_ and arg_599_1.time_ < var_602_10 + var_602_11 and not isNil(var_602_9) then
				local var_602_12 = (arg_599_1.time_ - var_602_10) / var_602_11

				if arg_599_1.var_.characterEffect10102ui_story and not isNil(var_602_9) then
					arg_599_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= var_602_10 + var_602_11 and arg_599_1.time_ < var_602_10 + var_602_11 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect10102ui_story then
				arg_599_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_602_13 = 0

			if var_602_13 < arg_599_1.time_ and arg_599_1.time_ <= var_602_13 + arg_602_0 then
				arg_599_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_602_14 = 0

			if var_602_14 < arg_599_1.time_ and arg_599_1.time_ <= var_602_14 + arg_602_0 then
				arg_599_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_602_15 = 0
			local var_602_16 = 0.375

			if var_602_15 < arg_599_1.time_ and arg_599_1.time_ <= var_602_15 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_17 = arg_599_1:FormatText(StoryNameCfg[6].name)

				arg_599_1.leftNameTxt_.text = var_602_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_18 = arg_599_1:GetWordFromCfg(1108411144)
				local var_602_19 = arg_599_1:FormatText(var_602_18.content)

				arg_599_1.text_.text = var_602_19

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_20 = 15
				local var_602_21 = utf8.len(var_602_19)
				local var_602_22 = var_602_20 <= 0 and var_602_16 or var_602_16 * (var_602_21 / var_602_20)

				if var_602_22 > 0 and var_602_16 < var_602_22 then
					arg_599_1.talkMaxDuration = var_602_22

					if var_602_22 + var_602_15 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_22 + var_602_15
					end
				end

				arg_599_1.text_.text = var_602_19
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb") ~= 0 then
					local var_602_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb") / 1000

					if var_602_23 + var_602_15 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_23 + var_602_15
					end

					if var_602_18.prefab_name ~= "" and arg_599_1.actors_[var_602_18.prefab_name] ~= nil then
						local var_602_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_18.prefab_name].transform, "story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")

						arg_599_1:RecordAudio("1108411144", var_602_24)
						arg_599_1:RecordAudio("1108411144", var_602_24)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_25 = math.max(var_602_16, arg_599_1.talkMaxDuration)

			if var_602_15 <= arg_599_1.time_ and arg_599_1.time_ < var_602_15 + var_602_25 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_15) / var_602_25

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_15 + var_602_25 and arg_599_1.time_ < var_602_15 + var_602_25 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play1108411145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108411145
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108411146(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["10102ui_story"].transform
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.var_.moveOldPos10102ui_story = var_606_0.localPosition
			end

			local var_606_2 = 0.001

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2
				local var_606_4 = Vector3.New(0, 100, 0)

				var_606_0.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos10102ui_story, var_606_4, var_606_3)

				local var_606_5 = manager.ui.mainCamera.transform.position - var_606_0.position

				var_606_0.forward = Vector3.New(var_606_5.x, var_606_5.y, var_606_5.z)

				local var_606_6 = var_606_0.localEulerAngles

				var_606_6.z = 0
				var_606_6.x = 0
				var_606_0.localEulerAngles = var_606_6
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 then
				var_606_0.localPosition = Vector3.New(0, 100, 0)

				local var_606_7 = manager.ui.mainCamera.transform.position - var_606_0.position

				var_606_0.forward = Vector3.New(var_606_7.x, var_606_7.y, var_606_7.z)

				local var_606_8 = var_606_0.localEulerAngles

				var_606_8.z = 0
				var_606_8.x = 0
				var_606_0.localEulerAngles = var_606_8
			end

			local var_606_9 = arg_603_1.actors_["10102ui_story"]
			local var_606_10 = 0

			if var_606_10 < arg_603_1.time_ and arg_603_1.time_ <= var_606_10 + arg_606_0 and not isNil(var_606_9) and arg_603_1.var_.characterEffect10102ui_story == nil then
				arg_603_1.var_.characterEffect10102ui_story = var_606_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_11 = 0.200000002980232

			if var_606_10 <= arg_603_1.time_ and arg_603_1.time_ < var_606_10 + var_606_11 and not isNil(var_606_9) then
				local var_606_12 = (arg_603_1.time_ - var_606_10) / var_606_11

				if arg_603_1.var_.characterEffect10102ui_story and not isNil(var_606_9) then
					local var_606_13 = Mathf.Lerp(0, 0.5, var_606_12)

					arg_603_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_603_1.var_.characterEffect10102ui_story.fillRatio = var_606_13
				end
			end

			if arg_603_1.time_ >= var_606_10 + var_606_11 and arg_603_1.time_ < var_606_10 + var_606_11 + arg_606_0 and not isNil(var_606_9) and arg_603_1.var_.characterEffect10102ui_story then
				local var_606_14 = 0.5

				arg_603_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_603_1.var_.characterEffect10102ui_story.fillRatio = var_606_14
			end

			local var_606_15 = 0
			local var_606_16 = 1.7

			if var_606_15 < arg_603_1.time_ and arg_603_1.time_ <= var_606_15 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_17 = arg_603_1:GetWordFromCfg(1108411145)
				local var_606_18 = arg_603_1:FormatText(var_606_17.content)

				arg_603_1.text_.text = var_606_18

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_19 = 68
				local var_606_20 = utf8.len(var_606_18)
				local var_606_21 = var_606_19 <= 0 and var_606_16 or var_606_16 * (var_606_20 / var_606_19)

				if var_606_21 > 0 and var_606_16 < var_606_21 then
					arg_603_1.talkMaxDuration = var_606_21

					if var_606_21 + var_606_15 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_21 + var_606_15
					end
				end

				arg_603_1.text_.text = var_606_18
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_22 = math.max(var_606_16, arg_603_1.talkMaxDuration)

			if var_606_15 <= arg_603_1.time_ and arg_603_1.time_ < var_606_15 + var_606_22 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_15) / var_606_22

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_15 + var_606_22 and arg_603_1.time_ < var_606_15 + var_606_22 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108411146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1108411146
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1108411147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = manager.ui.mainCamera.transform
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				local var_610_2 = arg_607_1.var_.effect5454
				local var_610_3
				local var_610_4 = var_610_0

				if not var_610_2 then
					var_610_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan1"), var_610_4)
					var_610_2.name = "5454"
					arg_607_1.var_.effect5454 = var_610_2
				else
					var_610_2.transform:SetParent(var_610_4)
				end

				var_610_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_610_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_610_5 = 1.7777777777777777
				local var_610_6 = Screen.width / Screen.height
				local var_610_7 = var_610_6 / var_610_5
				local var_610_8 = Mathf.Max(var_610_5 / var_610_6, 1)

				var_610_2.transform.localScale = Vector3.New(var_610_2.transform.localScale.x * var_610_7, var_610_2.transform.localScale.y * var_610_8, var_610_2.transform.localScale.z)
			end

			local var_610_9 = 0
			local var_610_10 = 1.175

			if var_610_9 < arg_607_1.time_ and arg_607_1.time_ <= var_610_9 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_11 = arg_607_1:GetWordFromCfg(1108411146)
				local var_610_12 = arg_607_1:FormatText(var_610_11.content)

				arg_607_1.text_.text = var_610_12

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_13 = 47
				local var_610_14 = utf8.len(var_610_12)
				local var_610_15 = var_610_13 <= 0 and var_610_10 or var_610_10 * (var_610_14 / var_610_13)

				if var_610_15 > 0 and var_610_10 < var_610_15 then
					arg_607_1.talkMaxDuration = var_610_15

					if var_610_15 + var_610_9 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_15 + var_610_9
					end
				end

				arg_607_1.text_.text = var_610_12
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_16 = math.max(var_610_10, arg_607_1.talkMaxDuration)

			if var_610_9 <= arg_607_1.time_ and arg_607_1.time_ < var_610_9 + var_610_16 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_9) / var_610_16

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_9 + var_610_16 and arg_607_1.time_ < var_610_9 + var_610_16 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1108411147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1108411147
		arg_611_1.duration_ = 2.8

		local var_611_0 = {
			zh = 1.933,
			ja = 2.8
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1108411148(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["10102ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect10102ui_story == nil then
				arg_611_1.var_.characterEffect10102ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect10102ui_story and not isNil(var_614_0) then
					arg_611_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect10102ui_story then
				arg_611_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_614_4 = 0
			local var_614_5 = 0.15

			if var_614_4 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_6 = arg_611_1:FormatText(StoryNameCfg[6].name)

				arg_611_1.leftNameTxt_.text = var_614_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_7 = arg_611_1:GetWordFromCfg(1108411147)
				local var_614_8 = arg_611_1:FormatText(var_614_7.content)

				arg_611_1.text_.text = var_614_8

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_9 = 6
				local var_614_10 = utf8.len(var_614_8)
				local var_614_11 = var_614_9 <= 0 and var_614_5 or var_614_5 * (var_614_10 / var_614_9)

				if var_614_11 > 0 and var_614_5 < var_614_11 then
					arg_611_1.talkMaxDuration = var_614_11

					if var_614_11 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_11 + var_614_4
					end
				end

				arg_611_1.text_.text = var_614_8
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb") ~= 0 then
					local var_614_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb") / 1000

					if var_614_12 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_12 + var_614_4
					end

					if var_614_7.prefab_name ~= "" and arg_611_1.actors_[var_614_7.prefab_name] ~= nil then
						local var_614_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_7.prefab_name].transform, "story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")

						arg_611_1:RecordAudio("1108411147", var_614_13)
						arg_611_1:RecordAudio("1108411147", var_614_13)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_5, arg_611_1.talkMaxDuration)

			if var_614_4 <= arg_611_1.time_ and arg_611_1.time_ < var_614_4 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_4) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_4 + var_614_14 and arg_611_1.time_ < var_614_4 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1108411148 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1108411148
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1108411149(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["10102ui_story"]
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect10102ui_story == nil then
				arg_615_1.var_.characterEffect10102ui_story = var_618_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.200000002980232

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 and not isNil(var_618_0) then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2

				if arg_615_1.var_.characterEffect10102ui_story and not isNil(var_618_0) then
					local var_618_4 = Mathf.Lerp(0, 0.5, var_618_3)

					arg_615_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_615_1.var_.characterEffect10102ui_story.fillRatio = var_618_4
				end
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect10102ui_story then
				local var_618_5 = 0.5

				arg_615_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_615_1.var_.characterEffect10102ui_story.fillRatio = var_618_5
			end

			local var_618_6 = 0
			local var_618_7 = 0.65

			if var_618_6 < arg_615_1.time_ and arg_615_1.time_ <= var_618_6 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_8 = arg_615_1:FormatText(StoryNameCfg[7].name)

				arg_615_1.leftNameTxt_.text = var_618_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_9 = arg_615_1:GetWordFromCfg(1108411148)
				local var_618_10 = arg_615_1:FormatText(var_618_9.content)

				arg_615_1.text_.text = var_618_10

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_11 = 26
				local var_618_12 = utf8.len(var_618_10)
				local var_618_13 = var_618_11 <= 0 and var_618_7 or var_618_7 * (var_618_12 / var_618_11)

				if var_618_13 > 0 and var_618_7 < var_618_13 then
					arg_615_1.talkMaxDuration = var_618_13

					if var_618_13 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_13 + var_618_6
					end
				end

				arg_615_1.text_.text = var_618_10
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_14 = math.max(var_618_7, arg_615_1.talkMaxDuration)

			if var_618_6 <= arg_615_1.time_ and arg_615_1.time_ < var_618_6 + var_618_14 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_6) / var_618_14

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_6 + var_618_14 and arg_615_1.time_ < var_618_6 + var_618_14 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1108411149 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1108411149
		arg_619_1.duration_ = 6

		local var_619_0 = {
			zh = 4.666,
			ja = 6
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1108411150(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["10102ui_story"]
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect10102ui_story == nil then
				arg_619_1.var_.characterEffect10102ui_story = var_622_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 and not isNil(var_622_0) then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2

				if arg_619_1.var_.characterEffect10102ui_story and not isNil(var_622_0) then
					arg_619_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect10102ui_story then
				arg_619_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_622_4 = 0
			local var_622_5 = 0.5

			if var_622_4 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_6 = arg_619_1:FormatText(StoryNameCfg[6].name)

				arg_619_1.leftNameTxt_.text = var_622_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_7 = arg_619_1:GetWordFromCfg(1108411149)
				local var_622_8 = arg_619_1:FormatText(var_622_7.content)

				arg_619_1.text_.text = var_622_8

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_9 = 20
				local var_622_10 = utf8.len(var_622_8)
				local var_622_11 = var_622_9 <= 0 and var_622_5 or var_622_5 * (var_622_10 / var_622_9)

				if var_622_11 > 0 and var_622_5 < var_622_11 then
					arg_619_1.talkMaxDuration = var_622_11

					if var_622_11 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_11 + var_622_4
					end
				end

				arg_619_1.text_.text = var_622_8
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb") ~= 0 then
					local var_622_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb") / 1000

					if var_622_12 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_12 + var_622_4
					end

					if var_622_7.prefab_name ~= "" and arg_619_1.actors_[var_622_7.prefab_name] ~= nil then
						local var_622_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_7.prefab_name].transform, "story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")

						arg_619_1:RecordAudio("1108411149", var_622_13)
						arg_619_1:RecordAudio("1108411149", var_622_13)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_5, arg_619_1.talkMaxDuration)

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_4) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_4 + var_622_14 and arg_619_1.time_ < var_622_4 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1108411150 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1108411150
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1108411151(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["10102ui_story"]
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect10102ui_story == nil then
				arg_623_1.var_.characterEffect10102ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 and not isNil(var_626_0) then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2

				if arg_623_1.var_.characterEffect10102ui_story and not isNil(var_626_0) then
					local var_626_4 = Mathf.Lerp(0, 0.5, var_626_3)

					arg_623_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_623_1.var_.characterEffect10102ui_story.fillRatio = var_626_4
				end
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect10102ui_story then
				local var_626_5 = 0.5

				arg_623_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_623_1.var_.characterEffect10102ui_story.fillRatio = var_626_5
			end

			local var_626_6 = 0
			local var_626_7 = 0.9

			if var_626_6 < arg_623_1.time_ and arg_623_1.time_ <= var_626_6 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_8 = arg_623_1:GetWordFromCfg(1108411150)
				local var_626_9 = arg_623_1:FormatText(var_626_8.content)

				arg_623_1.text_.text = var_626_9

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_10 = 36
				local var_626_11 = utf8.len(var_626_9)
				local var_626_12 = var_626_10 <= 0 and var_626_7 or var_626_7 * (var_626_11 / var_626_10)

				if var_626_12 > 0 and var_626_7 < var_626_12 then
					arg_623_1.talkMaxDuration = var_626_12

					if var_626_12 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_12 + var_626_6
					end
				end

				arg_623_1.text_.text = var_626_9
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_13 = math.max(var_626_7, arg_623_1.talkMaxDuration)

			if var_626_6 <= arg_623_1.time_ and arg_623_1.time_ < var_626_6 + var_626_13 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_6) / var_626_13

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_6 + var_626_13 and arg_623_1.time_ < var_626_6 + var_626_13 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1108411151 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1108411151
		arg_627_1.duration_ = 8.27

		local var_627_0 = {
			zh = 5.166,
			ja = 8.266
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1108411152(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["10102ui_story"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect10102ui_story == nil then
				arg_627_1.var_.characterEffect10102ui_story = var_630_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.200000002980232

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.characterEffect10102ui_story and not isNil(var_630_0) then
					arg_627_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect10102ui_story then
				arg_627_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_630_4 = 0
			local var_630_5 = 0.5

			if var_630_4 < arg_627_1.time_ and arg_627_1.time_ <= var_630_4 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_6 = arg_627_1:FormatText(StoryNameCfg[6].name)

				arg_627_1.leftNameTxt_.text = var_630_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_7 = arg_627_1:GetWordFromCfg(1108411151)
				local var_630_8 = arg_627_1:FormatText(var_630_7.content)

				arg_627_1.text_.text = var_630_8

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_9 = 20
				local var_630_10 = utf8.len(var_630_8)
				local var_630_11 = var_630_9 <= 0 and var_630_5 or var_630_5 * (var_630_10 / var_630_9)

				if var_630_11 > 0 and var_630_5 < var_630_11 then
					arg_627_1.talkMaxDuration = var_630_11

					if var_630_11 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_11 + var_630_4
					end
				end

				arg_627_1.text_.text = var_630_8
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb") ~= 0 then
					local var_630_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb") / 1000

					if var_630_12 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_12 + var_630_4
					end

					if var_630_7.prefab_name ~= "" and arg_627_1.actors_[var_630_7.prefab_name] ~= nil then
						local var_630_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_7.prefab_name].transform, "story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")

						arg_627_1:RecordAudio("1108411151", var_630_13)
						arg_627_1:RecordAudio("1108411151", var_630_13)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_14 = math.max(var_630_5, arg_627_1.talkMaxDuration)

			if var_630_4 <= arg_627_1.time_ and arg_627_1.time_ < var_630_4 + var_630_14 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_4) / var_630_14

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_4 + var_630_14 and arg_627_1.time_ < var_630_4 + var_630_14 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1108411152 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1108411152
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1108411153(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["10102ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect10102ui_story == nil then
				arg_631_1.var_.characterEffect10102ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect10102ui_story and not isNil(var_634_0) then
					local var_634_4 = Mathf.Lerp(0, 0.5, var_634_3)

					arg_631_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_631_1.var_.characterEffect10102ui_story.fillRatio = var_634_4
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect10102ui_story then
				local var_634_5 = 0.5

				arg_631_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_631_1.var_.characterEffect10102ui_story.fillRatio = var_634_5
			end

			local var_634_6 = 0
			local var_634_7 = 0.225

			if var_634_6 < arg_631_1.time_ and arg_631_1.time_ <= var_634_6 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_8 = arg_631_1:FormatText(StoryNameCfg[7].name)

				arg_631_1.leftNameTxt_.text = var_634_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_9 = arg_631_1:GetWordFromCfg(1108411152)
				local var_634_10 = arg_631_1:FormatText(var_634_9.content)

				arg_631_1.text_.text = var_634_10

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_11 = 9
				local var_634_12 = utf8.len(var_634_10)
				local var_634_13 = var_634_11 <= 0 and var_634_7 or var_634_7 * (var_634_12 / var_634_11)

				if var_634_13 > 0 and var_634_7 < var_634_13 then
					arg_631_1.talkMaxDuration = var_634_13

					if var_634_13 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_13 + var_634_6
					end
				end

				arg_631_1.text_.text = var_634_10
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_14 = math.max(var_634_7, arg_631_1.talkMaxDuration)

			if var_634_6 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_14 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_14

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_14 and arg_631_1.time_ < var_634_6 + var_634_14 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1108411153 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1108411153
		arg_635_1.duration_ = 3.7

		local var_635_0 = {
			zh = 3.2,
			ja = 3.7
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1108411154(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["10102ui_story"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect10102ui_story == nil then
				arg_635_1.var_.characterEffect10102ui_story = var_638_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 and not isNil(var_638_0) then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2

				if arg_635_1.var_.characterEffect10102ui_story and not isNil(var_638_0) then
					arg_635_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect10102ui_story then
				arg_635_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_638_4 = 0
			local var_638_5 = 0.35

			if var_638_4 < arg_635_1.time_ and arg_635_1.time_ <= var_638_4 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_6 = arg_635_1:FormatText(StoryNameCfg[6].name)

				arg_635_1.leftNameTxt_.text = var_638_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_7 = arg_635_1:GetWordFromCfg(1108411153)
				local var_638_8 = arg_635_1:FormatText(var_638_7.content)

				arg_635_1.text_.text = var_638_8

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_9 = 14
				local var_638_10 = utf8.len(var_638_8)
				local var_638_11 = var_638_9 <= 0 and var_638_5 or var_638_5 * (var_638_10 / var_638_9)

				if var_638_11 > 0 and var_638_5 < var_638_11 then
					arg_635_1.talkMaxDuration = var_638_11

					if var_638_11 + var_638_4 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_11 + var_638_4
					end
				end

				arg_635_1.text_.text = var_638_8
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb") ~= 0 then
					local var_638_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb") / 1000

					if var_638_12 + var_638_4 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_12 + var_638_4
					end

					if var_638_7.prefab_name ~= "" and arg_635_1.actors_[var_638_7.prefab_name] ~= nil then
						local var_638_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_7.prefab_name].transform, "story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")

						arg_635_1:RecordAudio("1108411153", var_638_13)
						arg_635_1:RecordAudio("1108411153", var_638_13)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_14 = math.max(var_638_5, arg_635_1.talkMaxDuration)

			if var_638_4 <= arg_635_1.time_ and arg_635_1.time_ < var_638_4 + var_638_14 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_4) / var_638_14

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_4 + var_638_14 and arg_635_1.time_ < var_638_4 + var_638_14 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1108411154 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1108411154
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1108411155(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["10102ui_story"]
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect10102ui_story == nil then
				arg_639_1.var_.characterEffect10102ui_story = var_642_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.200000002980232

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 and not isNil(var_642_0) then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2

				if arg_639_1.var_.characterEffect10102ui_story and not isNil(var_642_0) then
					local var_642_4 = Mathf.Lerp(0, 0.5, var_642_3)

					arg_639_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_639_1.var_.characterEffect10102ui_story.fillRatio = var_642_4
				end
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect10102ui_story then
				local var_642_5 = 0.5

				arg_639_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_639_1.var_.characterEffect10102ui_story.fillRatio = var_642_5
			end

			local var_642_6 = 0
			local var_642_7 = 0.4

			if var_642_6 < arg_639_1.time_ and arg_639_1.time_ <= var_642_6 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_8 = arg_639_1:FormatText(StoryNameCfg[7].name)

				arg_639_1.leftNameTxt_.text = var_642_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_9 = arg_639_1:GetWordFromCfg(1108411154)
				local var_642_10 = arg_639_1:FormatText(var_642_9.content)

				arg_639_1.text_.text = var_642_10

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_11 = 16
				local var_642_12 = utf8.len(var_642_10)
				local var_642_13 = var_642_11 <= 0 and var_642_7 or var_642_7 * (var_642_12 / var_642_11)

				if var_642_13 > 0 and var_642_7 < var_642_13 then
					arg_639_1.talkMaxDuration = var_642_13

					if var_642_13 + var_642_6 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_13 + var_642_6
					end
				end

				arg_639_1.text_.text = var_642_10
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_14 = math.max(var_642_7, arg_639_1.talkMaxDuration)

			if var_642_6 <= arg_639_1.time_ and arg_639_1.time_ < var_642_6 + var_642_14 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_6) / var_642_14

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_6 + var_642_14 and arg_639_1.time_ < var_642_6 + var_642_14 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1108411155 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1108411155
		arg_643_1.duration_ = 2.13

		local var_643_0 = {
			zh = 2.133,
			ja = 2.033
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1108411156(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["10102ui_story"]
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect10102ui_story == nil then
				arg_643_1.var_.characterEffect10102ui_story = var_646_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 and not isNil(var_646_0) then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2

				if arg_643_1.var_.characterEffect10102ui_story and not isNil(var_646_0) then
					arg_643_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect10102ui_story then
				arg_643_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_646_4 = 0
			local var_646_5 = 0.225

			if var_646_4 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_6 = arg_643_1:FormatText(StoryNameCfg[6].name)

				arg_643_1.leftNameTxt_.text = var_646_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_7 = arg_643_1:GetWordFromCfg(1108411155)
				local var_646_8 = arg_643_1:FormatText(var_646_7.content)

				arg_643_1.text_.text = var_646_8

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 9
				local var_646_10 = utf8.len(var_646_8)
				local var_646_11 = var_646_9 <= 0 and var_646_5 or var_646_5 * (var_646_10 / var_646_9)

				if var_646_11 > 0 and var_646_5 < var_646_11 then
					arg_643_1.talkMaxDuration = var_646_11

					if var_646_11 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_11 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_8
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb") ~= 0 then
					local var_646_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb") / 1000

					if var_646_12 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_12 + var_646_4
					end

					if var_646_7.prefab_name ~= "" and arg_643_1.actors_[var_646_7.prefab_name] ~= nil then
						local var_646_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_7.prefab_name].transform, "story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")

						arg_643_1:RecordAudio("1108411155", var_646_13)
						arg_643_1:RecordAudio("1108411155", var_646_13)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_14 = math.max(var_646_5, arg_643_1.talkMaxDuration)

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_14 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_4) / var_646_14

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_4 + var_646_14 and arg_643_1.time_ < var_646_4 + var_646_14 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1108411156 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1108411156
		arg_647_1.duration_ = 6.83

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1108411157(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				local var_650_1 = manager.ui.mainCamera.transform.localPosition
				local var_650_2 = Vector3.New(0, 0, 10) + Vector3.New(var_650_1.x, var_650_1.y, 0)
				local var_650_3 = arg_647_1.bgs_.ST0116a

				var_650_3.transform.localPosition = var_650_2
				var_650_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_650_4 = var_650_3:GetComponent("SpriteRenderer")

				if var_650_4 and var_650_4.sprite then
					local var_650_5 = (var_650_3.transform.localPosition - var_650_1).z
					local var_650_6 = manager.ui.mainCameraCom_
					local var_650_7 = 2 * var_650_5 * Mathf.Tan(var_650_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_650_8 = var_650_7 * var_650_6.aspect
					local var_650_9 = var_650_4.sprite.bounds.size.x
					local var_650_10 = var_650_4.sprite.bounds.size.y
					local var_650_11 = var_650_8 / var_650_9
					local var_650_12 = var_650_7 / var_650_10
					local var_650_13 = var_650_12 < var_650_11 and var_650_11 or var_650_12

					var_650_3.transform.localScale = Vector3.New(var_650_13, var_650_13, 0)
				end

				for iter_650_0, iter_650_1 in pairs(arg_647_1.bgs_) do
					if iter_650_0 ~= "ST0116a" then
						iter_650_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_650_14 = 0

			if var_650_14 < arg_647_1.time_ and arg_647_1.time_ <= var_650_14 + arg_650_0 then
				arg_647_1.allBtn_.enabled = false
			end

			local var_650_15 = 0.3

			if arg_647_1.time_ >= var_650_14 + var_650_15 and arg_647_1.time_ < var_650_14 + var_650_15 + arg_650_0 then
				arg_647_1.allBtn_.enabled = true
			end

			local var_650_16 = 0

			if var_650_16 < arg_647_1.time_ and arg_647_1.time_ <= var_650_16 + arg_650_0 then
				arg_647_1.mask_.enabled = true
				arg_647_1.mask_.raycastTarget = true

				arg_647_1:SetGaussion(false)
			end

			local var_650_17 = 2

			if var_650_16 <= arg_647_1.time_ and arg_647_1.time_ < var_650_16 + var_650_17 then
				local var_650_18 = (arg_647_1.time_ - var_650_16) / var_650_17
				local var_650_19 = Color.New(0, 0, 0)

				var_650_19.a = Mathf.Lerp(1, 0, var_650_18)
				arg_647_1.mask_.color = var_650_19
			end

			if arg_647_1.time_ >= var_650_16 + var_650_17 and arg_647_1.time_ < var_650_16 + var_650_17 + arg_650_0 then
				local var_650_20 = Color.New(0, 0, 0)
				local var_650_21 = 0

				arg_647_1.mask_.enabled = false
				var_650_20.a = var_650_21
				arg_647_1.mask_.color = var_650_20
			end

			local var_650_22 = arg_647_1.actors_["10102ui_story"]
			local var_650_23 = 0

			if var_650_23 < arg_647_1.time_ and arg_647_1.time_ <= var_650_23 + arg_650_0 and not isNil(var_650_22) and arg_647_1.var_.characterEffect10102ui_story == nil then
				arg_647_1.var_.characterEffect10102ui_story = var_650_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_24 = 0.200000002980232

			if var_650_23 <= arg_647_1.time_ and arg_647_1.time_ < var_650_23 + var_650_24 and not isNil(var_650_22) then
				local var_650_25 = (arg_647_1.time_ - var_650_23) / var_650_24

				if arg_647_1.var_.characterEffect10102ui_story and not isNil(var_650_22) then
					local var_650_26 = Mathf.Lerp(0, 0.5, var_650_25)

					arg_647_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_647_1.var_.characterEffect10102ui_story.fillRatio = var_650_26
				end
			end

			if arg_647_1.time_ >= var_650_23 + var_650_24 and arg_647_1.time_ < var_650_23 + var_650_24 + arg_650_0 and not isNil(var_650_22) and arg_647_1.var_.characterEffect10102ui_story then
				local var_650_27 = 0.5

				arg_647_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_647_1.var_.characterEffect10102ui_story.fillRatio = var_650_27
			end

			local var_650_28 = manager.ui.mainCamera.transform
			local var_650_29 = 0

			if var_650_29 < arg_647_1.time_ and arg_647_1.time_ <= var_650_29 + arg_650_0 then
				local var_650_30 = arg_647_1.var_.effect5454

				if var_650_30 then
					Object.Destroy(var_650_30)

					arg_647_1.var_.effect5454 = nil
				end
			end

			local var_650_31 = manager.ui.mainCamera.transform
			local var_650_32 = 0

			if var_650_32 < arg_647_1.time_ and arg_647_1.time_ <= var_650_32 + arg_650_0 then
				local var_650_33 = arg_647_1.var_.effect54543
				local var_650_34
				local var_650_35 = var_650_31

				if not var_650_33 then
					var_650_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), var_650_35)
					var_650_33.name = "54543"
					arg_647_1.var_.effect54543 = var_650_33
				else
					var_650_33.transform:SetParent(var_650_35)
				end

				var_650_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_650_33.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_650_36 = 1.7777777777777777
				local var_650_37 = Screen.width / Screen.height
				local var_650_38 = var_650_37 / var_650_36
				local var_650_39 = Mathf.Max(var_650_36 / var_650_37, 1)

				var_650_33.transform.localScale = Vector3.New(var_650_33.transform.localScale.x * var_650_38, var_650_33.transform.localScale.y * var_650_39, var_650_33.transform.localScale.z)
			end

			local var_650_40 = arg_647_1.bgs_.ST0116a.transform
			local var_650_41 = 0.0166666666666667

			if var_650_41 < arg_647_1.time_ and arg_647_1.time_ <= var_650_41 + arg_650_0 then
				arg_647_1.var_.moveOldPosST0116a = var_650_40.localPosition
			end

			local var_650_42 = 0.001

			if var_650_41 <= arg_647_1.time_ and arg_647_1.time_ < var_650_41 + var_650_42 then
				local var_650_43 = (arg_647_1.time_ - var_650_41) / var_650_42
				local var_650_44 = Vector3.New(0, 0.46, 4.83)

				var_650_40.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPosST0116a, var_650_44, var_650_43)
			end

			if arg_647_1.time_ >= var_650_41 + var_650_42 and arg_647_1.time_ < var_650_41 + var_650_42 + arg_650_0 then
				var_650_40.localPosition = Vector3.New(0, 0.46, 4.83)
			end

			local var_650_45 = arg_647_1.bgs_.ST0116a.transform
			local var_650_46 = 0.0333333333333333

			if var_650_46 < arg_647_1.time_ and arg_647_1.time_ <= var_650_46 + arg_650_0 then
				arg_647_1.var_.moveOldPosST0116a = var_650_45.localPosition
			end

			local var_650_47 = 2.66666666666567

			if var_650_46 <= arg_647_1.time_ and arg_647_1.time_ < var_650_46 + var_650_47 then
				local var_650_48 = (arg_647_1.time_ - var_650_46) / var_650_47
				local var_650_49 = Vector3.New(0, 1, 8.31)

				var_650_45.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPosST0116a, var_650_49, var_650_48)
			end

			if arg_647_1.time_ >= var_650_46 + var_650_47 and arg_647_1.time_ < var_650_46 + var_650_47 + arg_650_0 then
				var_650_45.localPosition = Vector3.New(0, 1, 8.31)
			end

			if arg_647_1.frameCnt_ <= 1 then
				arg_647_1.dialog_:SetActive(false)
			end

			local var_650_50 = 1.83333333333333
			local var_650_51 = 1.45

			if var_650_50 < arg_647_1.time_ and arg_647_1.time_ <= var_650_50 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0

				arg_647_1.dialog_:SetActive(true)

				arg_647_1.dialogCg_.alpha = 0

				local var_650_52 = LeanTween.value(arg_647_1.dialog_, 0, 1, 0.3)

				var_650_52:setOnUpdate(LuaHelper.FloatAction(function(arg_651_0)
					arg_647_1.dialogCg_.alpha = arg_651_0
				end))
				var_650_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_647_1.dialog_)
					var_650_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_647_1.duration_ = arg_647_1.duration_ + 0.3

				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_53 = arg_647_1:GetWordFromCfg(1108411156)
				local var_650_54 = arg_647_1:FormatText(var_650_53.content)

				arg_647_1.text_.text = var_650_54

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_55 = 58
				local var_650_56 = utf8.len(var_650_54)
				local var_650_57 = var_650_55 <= 0 and var_650_51 or var_650_51 * (var_650_56 / var_650_55)

				if var_650_57 > 0 and var_650_51 < var_650_57 then
					arg_647_1.talkMaxDuration = var_650_57
					var_650_50 = var_650_50 + 0.3

					if var_650_57 + var_650_50 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_57 + var_650_50
					end
				end

				arg_647_1.text_.text = var_650_54
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_58 = var_650_50 + 0.3
			local var_650_59 = math.max(var_650_51, arg_647_1.talkMaxDuration)

			if var_650_58 <= arg_647_1.time_ and arg_647_1.time_ < var_650_58 + var_650_59 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_58) / var_650_59

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_58 + var_650_59 and arg_647_1.time_ < var_650_58 + var_650_59 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST0116a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0116a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.66666666666567,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play1108411157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1108411157
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1108411158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0
			local var_656_1 = 1.3

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_2 = arg_653_1:GetWordFromCfg(1108411157)
				local var_656_3 = arg_653_1:FormatText(var_656_2.content)

				arg_653_1.text_.text = var_656_3

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_4 = 52
				local var_656_5 = utf8.len(var_656_3)
				local var_656_6 = var_656_4 <= 0 and var_656_1 or var_656_1 * (var_656_5 / var_656_4)

				if var_656_6 > 0 and var_656_1 < var_656_6 then
					arg_653_1.talkMaxDuration = var_656_6

					if var_656_6 + var_656_0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_6 + var_656_0
					end
				end

				arg_653_1.text_.text = var_656_3
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_7 = math.max(var_656_1, arg_653_1.talkMaxDuration)

			if var_656_0 <= arg_653_1.time_ and arg_653_1.time_ < var_656_0 + var_656_7 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_0) / var_656_7

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_0 + var_656_7 and arg_653_1.time_ < var_656_0 + var_656_7 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1108411158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1108411158
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1108411159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0
			local var_660_1 = 1.35

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_2 = arg_657_1:GetWordFromCfg(1108411158)
				local var_660_3 = arg_657_1:FormatText(var_660_2.content)

				arg_657_1.text_.text = var_660_3

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_4 = 54
				local var_660_5 = utf8.len(var_660_3)
				local var_660_6 = var_660_4 <= 0 and var_660_1 or var_660_1 * (var_660_5 / var_660_4)

				if var_660_6 > 0 and var_660_1 < var_660_6 then
					arg_657_1.talkMaxDuration = var_660_6

					if var_660_6 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_6 + var_660_0
					end
				end

				arg_657_1.text_.text = var_660_3
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_7 = math.max(var_660_1, arg_657_1.talkMaxDuration)

			if var_660_0 <= arg_657_1.time_ and arg_657_1.time_ < var_660_0 + var_660_7 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_0) / var_660_7

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_0 + var_660_7 and arg_657_1.time_ < var_660_0 + var_660_7 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1108411159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1108411159
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1108411160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0
			local var_664_1 = 0.175

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_2 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_3 = arg_661_1:GetWordFromCfg(1108411159)
				local var_664_4 = arg_661_1:FormatText(var_664_3.content)

				arg_661_1.text_.text = var_664_4

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 7
				local var_664_6 = utf8.len(var_664_4)
				local var_664_7 = var_664_5 <= 0 and var_664_1 or var_664_1 * (var_664_6 / var_664_5)

				if var_664_7 > 0 and var_664_1 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_0
					end
				end

				arg_661_1.text_.text = var_664_4
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_8 = math.max(var_664_1, arg_661_1.talkMaxDuration)

			if var_664_0 <= arg_661_1.time_ and arg_661_1.time_ < var_664_0 + var_664_8 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_0) / var_664_8

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_0 + var_664_8 and arg_661_1.time_ < var_664_0 + var_664_8 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1108411160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1108411160
		arg_665_1.duration_ = 2.5

		local var_665_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1108411161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["10102ui_story"].transform
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.var_.moveOldPos10102ui_story = var_668_0.localPosition
			end

			local var_668_2 = 0.001

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2
				local var_668_4 = Vector3.New(0, -0.985, -6.275)

				var_668_0.localPosition = Vector3.Lerp(arg_665_1.var_.moveOldPos10102ui_story, var_668_4, var_668_3)

				local var_668_5 = manager.ui.mainCamera.transform.position - var_668_0.position

				var_668_0.forward = Vector3.New(var_668_5.x, var_668_5.y, var_668_5.z)

				local var_668_6 = var_668_0.localEulerAngles

				var_668_6.z = 0
				var_668_6.x = 0
				var_668_0.localEulerAngles = var_668_6
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 then
				var_668_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_668_7 = manager.ui.mainCamera.transform.position - var_668_0.position

				var_668_0.forward = Vector3.New(var_668_7.x, var_668_7.y, var_668_7.z)

				local var_668_8 = var_668_0.localEulerAngles

				var_668_8.z = 0
				var_668_8.x = 0
				var_668_0.localEulerAngles = var_668_8
			end

			local var_668_9 = arg_665_1.actors_["10102ui_story"]
			local var_668_10 = 0

			if var_668_10 < arg_665_1.time_ and arg_665_1.time_ <= var_668_10 + arg_668_0 and not isNil(var_668_9) and arg_665_1.var_.characterEffect10102ui_story == nil then
				arg_665_1.var_.characterEffect10102ui_story = var_668_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_11 = 0.200000002980232

			if var_668_10 <= arg_665_1.time_ and arg_665_1.time_ < var_668_10 + var_668_11 and not isNil(var_668_9) then
				local var_668_12 = (arg_665_1.time_ - var_668_10) / var_668_11

				if arg_665_1.var_.characterEffect10102ui_story and not isNil(var_668_9) then
					arg_665_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= var_668_10 + var_668_11 and arg_665_1.time_ < var_668_10 + var_668_11 + arg_668_0 and not isNil(var_668_9) and arg_665_1.var_.characterEffect10102ui_story then
				arg_665_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_668_13 = 0

			if var_668_13 < arg_665_1.time_ and arg_665_1.time_ <= var_668_13 + arg_668_0 then
				arg_665_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_668_14 = 0

			if var_668_14 < arg_665_1.time_ and arg_665_1.time_ <= var_668_14 + arg_668_0 then
				arg_665_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_668_15 = 0
			local var_668_16 = 0.45

			if var_668_15 < arg_665_1.time_ and arg_665_1.time_ <= var_668_15 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_17 = arg_665_1:FormatText(StoryNameCfg[6].name)

				arg_665_1.leftNameTxt_.text = var_668_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_18 = arg_665_1:GetWordFromCfg(1108411160)
				local var_668_19 = arg_665_1:FormatText(var_668_18.content)

				arg_665_1.text_.text = var_668_19

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_20 = 18
				local var_668_21 = utf8.len(var_668_19)
				local var_668_22 = var_668_20 <= 0 and var_668_16 or var_668_16 * (var_668_21 / var_668_20)

				if var_668_22 > 0 and var_668_16 < var_668_22 then
					arg_665_1.talkMaxDuration = var_668_22

					if var_668_22 + var_668_15 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_22 + var_668_15
					end
				end

				arg_665_1.text_.text = var_668_19
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb") ~= 0 then
					local var_668_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb") / 1000

					if var_668_23 + var_668_15 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_23 + var_668_15
					end

					if var_668_18.prefab_name ~= "" and arg_665_1.actors_[var_668_18.prefab_name] ~= nil then
						local var_668_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_18.prefab_name].transform, "story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")

						arg_665_1:RecordAudio("1108411160", var_668_24)
						arg_665_1:RecordAudio("1108411160", var_668_24)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_25 = math.max(var_668_16, arg_665_1.talkMaxDuration)

			if var_668_15 <= arg_665_1.time_ and arg_665_1.time_ < var_668_15 + var_668_25 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_15) / var_668_25

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_15 + var_668_25 and arg_665_1.time_ < var_668_15 + var_668_25 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_665_1:InitPlayNodeList()
	end,
	Play1108411161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1108411161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1108411162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["10102ui_story"]
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10102ui_story == nil then
				arg_669_1.var_.characterEffect10102ui_story = var_672_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 and not isNil(var_672_0) then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2

				if arg_669_1.var_.characterEffect10102ui_story and not isNil(var_672_0) then
					local var_672_4 = Mathf.Lerp(0, 0.5, var_672_3)

					arg_669_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_669_1.var_.characterEffect10102ui_story.fillRatio = var_672_4
				end
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10102ui_story then
				local var_672_5 = 0.5

				arg_669_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_669_1.var_.characterEffect10102ui_story.fillRatio = var_672_5
			end

			local var_672_6 = 0
			local var_672_7 = 0.55

			if var_672_6 < arg_669_1.time_ and arg_669_1.time_ <= var_672_6 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_8 = arg_669_1:FormatText(StoryNameCfg[7].name)

				arg_669_1.leftNameTxt_.text = var_672_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_9 = arg_669_1:GetWordFromCfg(1108411161)
				local var_672_10 = arg_669_1:FormatText(var_672_9.content)

				arg_669_1.text_.text = var_672_10

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_11 = 22
				local var_672_12 = utf8.len(var_672_10)
				local var_672_13 = var_672_11 <= 0 and var_672_7 or var_672_7 * (var_672_12 / var_672_11)

				if var_672_13 > 0 and var_672_7 < var_672_13 then
					arg_669_1.talkMaxDuration = var_672_13

					if var_672_13 + var_672_6 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_13 + var_672_6
					end
				end

				arg_669_1.text_.text = var_672_10
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_14 = math.max(var_672_7, arg_669_1.talkMaxDuration)

			if var_672_6 <= arg_669_1.time_ and arg_669_1.time_ < var_672_6 + var_672_14 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_6) / var_672_14

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_6 + var_672_14 and arg_669_1.time_ < var_672_6 + var_672_14 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1108411162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1108411162
		arg_673_1.duration_ = 3.03

		local var_673_0 = {
			zh = 3,
			ja = 3.033
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1108411163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["10102ui_story"]
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect10102ui_story == nil then
				arg_673_1.var_.characterEffect10102ui_story = var_676_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_2 = 0.200000002980232

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 and not isNil(var_676_0) then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2

				if arg_673_1.var_.characterEffect10102ui_story and not isNil(var_676_0) then
					arg_673_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect10102ui_story then
				arg_673_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_676_4 = 0

			if var_676_4 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action453")
			end

			local var_676_5 = 0

			if var_676_5 < arg_673_1.time_ and arg_673_1.time_ <= var_676_5 + arg_676_0 then
				arg_673_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_676_6 = 0
			local var_676_7 = 0.3

			if var_676_6 < arg_673_1.time_ and arg_673_1.time_ <= var_676_6 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_8 = arg_673_1:FormatText(StoryNameCfg[6].name)

				arg_673_1.leftNameTxt_.text = var_676_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_9 = arg_673_1:GetWordFromCfg(1108411162)
				local var_676_10 = arg_673_1:FormatText(var_676_9.content)

				arg_673_1.text_.text = var_676_10

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_11 = 12
				local var_676_12 = utf8.len(var_676_10)
				local var_676_13 = var_676_11 <= 0 and var_676_7 or var_676_7 * (var_676_12 / var_676_11)

				if var_676_13 > 0 and var_676_7 < var_676_13 then
					arg_673_1.talkMaxDuration = var_676_13

					if var_676_13 + var_676_6 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_13 + var_676_6
					end
				end

				arg_673_1.text_.text = var_676_10
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb") ~= 0 then
					local var_676_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb") / 1000

					if var_676_14 + var_676_6 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_14 + var_676_6
					end

					if var_676_9.prefab_name ~= "" and arg_673_1.actors_[var_676_9.prefab_name] ~= nil then
						local var_676_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_9.prefab_name].transform, "story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")

						arg_673_1:RecordAudio("1108411162", var_676_15)
						arg_673_1:RecordAudio("1108411162", var_676_15)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_16 = math.max(var_676_7, arg_673_1.talkMaxDuration)

			if var_676_6 <= arg_673_1.time_ and arg_673_1.time_ < var_676_6 + var_676_16 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_6) / var_676_16

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_6 + var_676_16 and arg_673_1.time_ < var_676_6 + var_676_16 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1108411163 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1108411163
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1108411164(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["10102ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10102ui_story == nil then
				arg_677_1.var_.characterEffect10102ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect10102ui_story and not isNil(var_680_0) then
					local var_680_4 = Mathf.Lerp(0, 0.5, var_680_3)

					arg_677_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_677_1.var_.characterEffect10102ui_story.fillRatio = var_680_4
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10102ui_story then
				local var_680_5 = 0.5

				arg_677_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_677_1.var_.characterEffect10102ui_story.fillRatio = var_680_5
			end

			local var_680_6 = 0
			local var_680_7 = 0.2

			if var_680_6 < arg_677_1.time_ and arg_677_1.time_ <= var_680_6 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_8 = arg_677_1:FormatText(StoryNameCfg[7].name)

				arg_677_1.leftNameTxt_.text = var_680_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_9 = arg_677_1:GetWordFromCfg(1108411163)
				local var_680_10 = arg_677_1:FormatText(var_680_9.content)

				arg_677_1.text_.text = var_680_10

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_11 = 8
				local var_680_12 = utf8.len(var_680_10)
				local var_680_13 = var_680_11 <= 0 and var_680_7 or var_680_7 * (var_680_12 / var_680_11)

				if var_680_13 > 0 and var_680_7 < var_680_13 then
					arg_677_1.talkMaxDuration = var_680_13

					if var_680_13 + var_680_6 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_13 + var_680_6
					end
				end

				arg_677_1.text_.text = var_680_10
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_14 = math.max(var_680_7, arg_677_1.talkMaxDuration)

			if var_680_6 <= arg_677_1.time_ and arg_677_1.time_ < var_680_6 + var_680_14 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_6) / var_680_14

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_6 + var_680_14 and arg_677_1.time_ < var_680_6 + var_680_14 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play1108411164 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 1108411164
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play1108411165(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = arg_681_1.actors_["10102ui_story"].transform
			local var_684_1 = 0

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 then
				arg_681_1.var_.moveOldPos10102ui_story = var_684_0.localPosition
			end

			local var_684_2 = 0.001

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_2 then
				local var_684_3 = (arg_681_1.time_ - var_684_1) / var_684_2
				local var_684_4 = Vector3.New(0, 100, 0)

				var_684_0.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos10102ui_story, var_684_4, var_684_3)

				local var_684_5 = manager.ui.mainCamera.transform.position - var_684_0.position

				var_684_0.forward = Vector3.New(var_684_5.x, var_684_5.y, var_684_5.z)

				local var_684_6 = var_684_0.localEulerAngles

				var_684_6.z = 0
				var_684_6.x = 0
				var_684_0.localEulerAngles = var_684_6
			end

			if arg_681_1.time_ >= var_684_1 + var_684_2 and arg_681_1.time_ < var_684_1 + var_684_2 + arg_684_0 then
				var_684_0.localPosition = Vector3.New(0, 100, 0)

				local var_684_7 = manager.ui.mainCamera.transform.position - var_684_0.position

				var_684_0.forward = Vector3.New(var_684_7.x, var_684_7.y, var_684_7.z)

				local var_684_8 = var_684_0.localEulerAngles

				var_684_8.z = 0
				var_684_8.x = 0
				var_684_0.localEulerAngles = var_684_8
			end

			local var_684_9 = 0
			local var_684_10 = 1.275

			if var_684_9 < arg_681_1.time_ and arg_681_1.time_ <= var_684_9 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, false)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_11 = arg_681_1:GetWordFromCfg(1108411164)
				local var_684_12 = arg_681_1:FormatText(var_684_11.content)

				arg_681_1.text_.text = var_684_12

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_13 = 51
				local var_684_14 = utf8.len(var_684_12)
				local var_684_15 = var_684_13 <= 0 and var_684_10 or var_684_10 * (var_684_14 / var_684_13)

				if var_684_15 > 0 and var_684_10 < var_684_15 then
					arg_681_1.talkMaxDuration = var_684_15

					if var_684_15 + var_684_9 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_15 + var_684_9
					end
				end

				arg_681_1.text_.text = var_684_12
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_16 = math.max(var_684_10, arg_681_1.talkMaxDuration)

			if var_684_9 <= arg_681_1.time_ and arg_681_1.time_ < var_684_9 + var_684_16 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_9) / var_684_16

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_9 + var_684_16 and arg_681_1.time_ < var_684_9 + var_684_16 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play1108411165 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 1108411165
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play1108411166(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0
			local var_688_1 = 0.2

			if var_688_0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_2 = arg_685_1:FormatText(StoryNameCfg[7].name)

				arg_685_1.leftNameTxt_.text = var_688_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_3 = arg_685_1:GetWordFromCfg(1108411165)
				local var_688_4 = arg_685_1:FormatText(var_688_3.content)

				arg_685_1.text_.text = var_688_4

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_5 = 8
				local var_688_6 = utf8.len(var_688_4)
				local var_688_7 = var_688_5 <= 0 and var_688_1 or var_688_1 * (var_688_6 / var_688_5)

				if var_688_7 > 0 and var_688_1 < var_688_7 then
					arg_685_1.talkMaxDuration = var_688_7

					if var_688_7 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_7 + var_688_0
					end
				end

				arg_685_1.text_.text = var_688_4
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_8 = math.max(var_688_1, arg_685_1.talkMaxDuration)

			if var_688_0 <= arg_685_1.time_ and arg_685_1.time_ < var_688_0 + var_688_8 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_0) / var_688_8

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_0 + var_688_8 and arg_685_1.time_ < var_688_0 + var_688_8 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play1108411166 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 1108411166
		arg_689_1.duration_ = 6.73

		local var_689_0 = {
			zh = 6.266,
			ja = 6.733
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play1108411167(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.actors_["10102ui_story"].transform
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.var_.moveOldPos10102ui_story = var_692_0.localPosition
			end

			local var_692_2 = 0.001

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2
				local var_692_4 = Vector3.New(0, -0.985, -6.275)

				var_692_0.localPosition = Vector3.Lerp(arg_689_1.var_.moveOldPos10102ui_story, var_692_4, var_692_3)

				local var_692_5 = manager.ui.mainCamera.transform.position - var_692_0.position

				var_692_0.forward = Vector3.New(var_692_5.x, var_692_5.y, var_692_5.z)

				local var_692_6 = var_692_0.localEulerAngles

				var_692_6.z = 0
				var_692_6.x = 0
				var_692_0.localEulerAngles = var_692_6
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 then
				var_692_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_692_7 = manager.ui.mainCamera.transform.position - var_692_0.position

				var_692_0.forward = Vector3.New(var_692_7.x, var_692_7.y, var_692_7.z)

				local var_692_8 = var_692_0.localEulerAngles

				var_692_8.z = 0
				var_692_8.x = 0
				var_692_0.localEulerAngles = var_692_8
			end

			local var_692_9 = arg_689_1.actors_["10102ui_story"]
			local var_692_10 = 0

			if var_692_10 < arg_689_1.time_ and arg_689_1.time_ <= var_692_10 + arg_692_0 and not isNil(var_692_9) and arg_689_1.var_.characterEffect10102ui_story == nil then
				arg_689_1.var_.characterEffect10102ui_story = var_692_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_11 = 0.200000002980232

			if var_692_10 <= arg_689_1.time_ and arg_689_1.time_ < var_692_10 + var_692_11 and not isNil(var_692_9) then
				local var_692_12 = (arg_689_1.time_ - var_692_10) / var_692_11

				if arg_689_1.var_.characterEffect10102ui_story and not isNil(var_692_9) then
					arg_689_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_689_1.time_ >= var_692_10 + var_692_11 and arg_689_1.time_ < var_692_10 + var_692_11 + arg_692_0 and not isNil(var_692_9) and arg_689_1.var_.characterEffect10102ui_story then
				arg_689_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_692_13 = 0

			if var_692_13 < arg_689_1.time_ and arg_689_1.time_ <= var_692_13 + arg_692_0 then
				arg_689_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_2")
			end

			local var_692_14 = 0

			if var_692_14 < arg_689_1.time_ and arg_689_1.time_ <= var_692_14 + arg_692_0 then
				arg_689_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_692_15 = 0
			local var_692_16 = 0.75

			if var_692_15 < arg_689_1.time_ and arg_689_1.time_ <= var_692_15 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_17 = arg_689_1:FormatText(StoryNameCfg[6].name)

				arg_689_1.leftNameTxt_.text = var_692_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_18 = arg_689_1:GetWordFromCfg(1108411166)
				local var_692_19 = arg_689_1:FormatText(var_692_18.content)

				arg_689_1.text_.text = var_692_19

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_20 = 30
				local var_692_21 = utf8.len(var_692_19)
				local var_692_22 = var_692_20 <= 0 and var_692_16 or var_692_16 * (var_692_21 / var_692_20)

				if var_692_22 > 0 and var_692_16 < var_692_22 then
					arg_689_1.talkMaxDuration = var_692_22

					if var_692_22 + var_692_15 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_22 + var_692_15
					end
				end

				arg_689_1.text_.text = var_692_19
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb") ~= 0 then
					local var_692_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb") / 1000

					if var_692_23 + var_692_15 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_23 + var_692_15
					end

					if var_692_18.prefab_name ~= "" and arg_689_1.actors_[var_692_18.prefab_name] ~= nil then
						local var_692_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_18.prefab_name].transform, "story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")

						arg_689_1:RecordAudio("1108411166", var_692_24)
						arg_689_1:RecordAudio("1108411166", var_692_24)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_25 = math.max(var_692_16, arg_689_1.talkMaxDuration)

			if var_692_15 <= arg_689_1.time_ and arg_689_1.time_ < var_692_15 + var_692_25 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_15) / var_692_25

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_15 + var_692_25 and arg_689_1.time_ < var_692_15 + var_692_25 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_689_1:InitPlayNodeList()
	end,
	Play1108411167 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 1108411167
		arg_693_1.duration_ = 9

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play1108411168(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = "ST0115"

			if arg_693_1.bgs_[var_696_0] == nil then
				local var_696_1 = Object.Instantiate(arg_693_1.paintGo_)

				var_696_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_696_0)
				var_696_1.name = var_696_0
				var_696_1.transform.parent = arg_693_1.stage_.transform
				var_696_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.bgs_[var_696_0] = var_696_1
			end

			local var_696_2 = 2

			if var_696_2 < arg_693_1.time_ and arg_693_1.time_ <= var_696_2 + arg_696_0 then
				local var_696_3 = manager.ui.mainCamera.transform.localPosition
				local var_696_4 = Vector3.New(0, 0, 10) + Vector3.New(var_696_3.x, var_696_3.y, 0)
				local var_696_5 = arg_693_1.bgs_.ST0115

				var_696_5.transform.localPosition = var_696_4
				var_696_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_696_6 = var_696_5:GetComponent("SpriteRenderer")

				if var_696_6 and var_696_6.sprite then
					local var_696_7 = (var_696_5.transform.localPosition - var_696_3).z
					local var_696_8 = manager.ui.mainCameraCom_
					local var_696_9 = 2 * var_696_7 * Mathf.Tan(var_696_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_696_10 = var_696_9 * var_696_8.aspect
					local var_696_11 = var_696_6.sprite.bounds.size.x
					local var_696_12 = var_696_6.sprite.bounds.size.y
					local var_696_13 = var_696_10 / var_696_11
					local var_696_14 = var_696_9 / var_696_12
					local var_696_15 = var_696_14 < var_696_13 and var_696_13 or var_696_14

					var_696_5.transform.localScale = Vector3.New(var_696_15, var_696_15, 0)
				end

				for iter_696_0, iter_696_1 in pairs(arg_693_1.bgs_) do
					if iter_696_0 ~= "ST0115" then
						iter_696_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_696_16 = 0

			if var_696_16 < arg_693_1.time_ and arg_693_1.time_ <= var_696_16 + arg_696_0 then
				arg_693_1.allBtn_.enabled = false
			end

			local var_696_17 = 0.3

			if arg_693_1.time_ >= var_696_16 + var_696_17 and arg_693_1.time_ < var_696_16 + var_696_17 + arg_696_0 then
				arg_693_1.allBtn_.enabled = true
			end

			local var_696_18 = 0

			if var_696_18 < arg_693_1.time_ and arg_693_1.time_ <= var_696_18 + arg_696_0 then
				arg_693_1.mask_.enabled = true
				arg_693_1.mask_.raycastTarget = true

				arg_693_1:SetGaussion(false)
			end

			local var_696_19 = 2

			if var_696_18 <= arg_693_1.time_ and arg_693_1.time_ < var_696_18 + var_696_19 then
				local var_696_20 = (arg_693_1.time_ - var_696_18) / var_696_19
				local var_696_21 = Color.New(0, 0, 0)

				var_696_21.a = Mathf.Lerp(0, 1, var_696_20)
				arg_693_1.mask_.color = var_696_21
			end

			if arg_693_1.time_ >= var_696_18 + var_696_19 and arg_693_1.time_ < var_696_18 + var_696_19 + arg_696_0 then
				local var_696_22 = Color.New(0, 0, 0)

				var_696_22.a = 1
				arg_693_1.mask_.color = var_696_22
			end

			local var_696_23 = 2

			if var_696_23 < arg_693_1.time_ and arg_693_1.time_ <= var_696_23 + arg_696_0 then
				arg_693_1.mask_.enabled = true
				arg_693_1.mask_.raycastTarget = true

				arg_693_1:SetGaussion(false)
			end

			local var_696_24 = 2

			if var_696_23 <= arg_693_1.time_ and arg_693_1.time_ < var_696_23 + var_696_24 then
				local var_696_25 = (arg_693_1.time_ - var_696_23) / var_696_24
				local var_696_26 = Color.New(0, 0, 0)

				var_696_26.a = Mathf.Lerp(1, 0, var_696_25)
				arg_693_1.mask_.color = var_696_26
			end

			if arg_693_1.time_ >= var_696_23 + var_696_24 and arg_693_1.time_ < var_696_23 + var_696_24 + arg_696_0 then
				local var_696_27 = Color.New(0, 0, 0)
				local var_696_28 = 0

				arg_693_1.mask_.enabled = false
				var_696_27.a = var_696_28
				arg_693_1.mask_.color = var_696_27
			end

			local var_696_29 = arg_693_1.actors_["10102ui_story"].transform
			local var_696_30 = 2

			if var_696_30 < arg_693_1.time_ and arg_693_1.time_ <= var_696_30 + arg_696_0 then
				arg_693_1.var_.moveOldPos10102ui_story = var_696_29.localPosition
			end

			local var_696_31 = 0.001

			if var_696_30 <= arg_693_1.time_ and arg_693_1.time_ < var_696_30 + var_696_31 then
				local var_696_32 = (arg_693_1.time_ - var_696_30) / var_696_31
				local var_696_33 = Vector3.New(0, 100, 0)

				var_696_29.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos10102ui_story, var_696_33, var_696_32)

				local var_696_34 = manager.ui.mainCamera.transform.position - var_696_29.position

				var_696_29.forward = Vector3.New(var_696_34.x, var_696_34.y, var_696_34.z)

				local var_696_35 = var_696_29.localEulerAngles

				var_696_35.z = 0
				var_696_35.x = 0
				var_696_29.localEulerAngles = var_696_35
			end

			if arg_693_1.time_ >= var_696_30 + var_696_31 and arg_693_1.time_ < var_696_30 + var_696_31 + arg_696_0 then
				var_696_29.localPosition = Vector3.New(0, 100, 0)

				local var_696_36 = manager.ui.mainCamera.transform.position - var_696_29.position

				var_696_29.forward = Vector3.New(var_696_36.x, var_696_36.y, var_696_36.z)

				local var_696_37 = var_696_29.localEulerAngles

				var_696_37.z = 0
				var_696_37.x = 0
				var_696_29.localEulerAngles = var_696_37
			end

			local var_696_38 = arg_693_1.actors_["10102ui_story"]
			local var_696_39 = 2

			if var_696_39 < arg_693_1.time_ and arg_693_1.time_ <= var_696_39 + arg_696_0 and not isNil(var_696_38) and arg_693_1.var_.characterEffect10102ui_story == nil then
				arg_693_1.var_.characterEffect10102ui_story = var_696_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_40 = 0.200000002980232

			if var_696_39 <= arg_693_1.time_ and arg_693_1.time_ < var_696_39 + var_696_40 and not isNil(var_696_38) then
				local var_696_41 = (arg_693_1.time_ - var_696_39) / var_696_40

				if arg_693_1.var_.characterEffect10102ui_story and not isNil(var_696_38) then
					local var_696_42 = Mathf.Lerp(0, 0.5, var_696_41)

					arg_693_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_693_1.var_.characterEffect10102ui_story.fillRatio = var_696_42
				end
			end

			if arg_693_1.time_ >= var_696_39 + var_696_40 and arg_693_1.time_ < var_696_39 + var_696_40 + arg_696_0 and not isNil(var_696_38) and arg_693_1.var_.characterEffect10102ui_story then
				local var_696_43 = 0.5

				arg_693_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_693_1.var_.characterEffect10102ui_story.fillRatio = var_696_43
			end

			local var_696_44 = manager.ui.mainCamera.transform
			local var_696_45 = 2

			if var_696_45 < arg_693_1.time_ and arg_693_1.time_ <= var_696_45 + arg_696_0 then
				local var_696_46 = arg_693_1.var_.effect54543

				if var_696_46 then
					Object.Destroy(var_696_46)

					arg_693_1.var_.effect54543 = nil
				end
			end

			local var_696_47 = 0.166666666666667
			local var_696_48 = 0.3

			if var_696_47 < arg_693_1.time_ and arg_693_1.time_ <= var_696_47 + arg_696_0 then
				local var_696_49 = "play"
				local var_696_50 = "music"

				arg_693_1:AudioAction(var_696_49, var_696_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_696_51 = ""
				local var_696_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_696_52 ~= "" then
					if arg_693_1.bgmTxt_.text ~= var_696_52 and arg_693_1.bgmTxt_.text ~= "" then
						if arg_693_1.bgmTxt2_.text ~= "" then
							arg_693_1.bgmTxt_.text = arg_693_1.bgmTxt2_.text
						end

						arg_693_1.bgmTxt2_.text = var_696_52

						arg_693_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_693_1.bgmTxt_.text = var_696_52
						arg_693_1.bgmTxt2_.text = var_696_52
					end

					if arg_693_1.bgmTimer then
						arg_693_1.bgmTimer:Stop()

						arg_693_1.bgmTimer = nil
					end

					if arg_693_1.settingData.show_music_name == 1 then
						arg_693_1.musicController:SetSelectedState("show")
						arg_693_1.musicAnimator_:Play("open", 0, 0)

						if arg_693_1.settingData.music_time ~= 0 then
							arg_693_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_693_1.settingData.music_time), function()
								if arg_693_1 == nil or isNil(arg_693_1.bgmTxt_) then
									return
								end

								arg_693_1.musicController:SetSelectedState("hide")
								arg_693_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_696_53 = 1.66666666666667
			local var_696_54 = 1

			if var_696_53 < arg_693_1.time_ and arg_693_1.time_ <= var_696_53 + arg_696_0 then
				local var_696_55 = "play"
				local var_696_56 = "music"

				arg_693_1:AudioAction(var_696_55, var_696_56, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_696_57 = ""
				local var_696_58 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_696_58 ~= "" then
					if arg_693_1.bgmTxt_.text ~= var_696_58 and arg_693_1.bgmTxt_.text ~= "" then
						if arg_693_1.bgmTxt2_.text ~= "" then
							arg_693_1.bgmTxt_.text = arg_693_1.bgmTxt2_.text
						end

						arg_693_1.bgmTxt2_.text = var_696_58

						arg_693_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_693_1.bgmTxt_.text = var_696_58
						arg_693_1.bgmTxt2_.text = var_696_58
					end

					if arg_693_1.bgmTimer then
						arg_693_1.bgmTimer:Stop()

						arg_693_1.bgmTimer = nil
					end

					if arg_693_1.settingData.show_music_name == 1 then
						arg_693_1.musicController:SetSelectedState("show")
						arg_693_1.musicAnimator_:Play("open", 0, 0)

						if arg_693_1.settingData.music_time ~= 0 then
							arg_693_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_693_1.settingData.music_time), function()
								if arg_693_1 == nil or isNil(arg_693_1.bgmTxt_) then
									return
								end

								arg_693_1.musicController:SetSelectedState("hide")
								arg_693_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_696_59 = 0.166666666666667
			local var_696_60 = 1

			if var_696_59 < arg_693_1.time_ and arg_693_1.time_ <= var_696_59 + arg_696_0 then
				local var_696_61 = "stop"
				local var_696_62 = "effect"

				arg_693_1:AudioAction(var_696_61, var_696_62, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			local var_696_63 = 1.66666666666667
			local var_696_64 = 1

			if var_696_63 < arg_693_1.time_ and arg_693_1.time_ <= var_696_63 + arg_696_0 then
				local var_696_65 = "play"
				local var_696_66 = "effect"

				arg_693_1:AudioAction(var_696_65, var_696_66, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_696_67 = 4.3
			local var_696_68 = 1

			if var_696_67 < arg_693_1.time_ and arg_693_1.time_ <= var_696_67 + arg_696_0 then
				local var_696_69 = "play"
				local var_696_70 = "effect"

				arg_693_1:AudioAction(var_696_69, var_696_70, "se_story_side_128402", "se_story_side_128402_cook", "")
			end

			if arg_693_1.frameCnt_ <= 1 then
				arg_693_1.dialog_:SetActive(false)
			end

			local var_696_71 = 3.999999999999
			local var_696_72 = 1.65

			if var_696_71 < arg_693_1.time_ and arg_693_1.time_ <= var_696_71 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0

				arg_693_1.dialog_:SetActive(true)

				arg_693_1.dialogCg_.alpha = 0

				local var_696_73 = LeanTween.value(arg_693_1.dialog_, 0, 1, 0.3)

				var_696_73:setOnUpdate(LuaHelper.FloatAction(function(arg_699_0)
					arg_693_1.dialogCg_.alpha = arg_699_0
				end))
				var_696_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_693_1.dialog_)
					var_696_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_693_1.duration_ = arg_693_1.duration_ + 0.3

				SetActive(arg_693_1.leftNameGo_, false)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_74 = arg_693_1:GetWordFromCfg(1108411167)
				local var_696_75 = arg_693_1:FormatText(var_696_74.content)

				arg_693_1.text_.text = var_696_75

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_76 = 66
				local var_696_77 = utf8.len(var_696_75)
				local var_696_78 = var_696_76 <= 0 and var_696_72 or var_696_72 * (var_696_77 / var_696_76)

				if var_696_78 > 0 and var_696_72 < var_696_78 then
					arg_693_1.talkMaxDuration = var_696_78
					var_696_71 = var_696_71 + 0.3

					if var_696_78 + var_696_71 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_78 + var_696_71
					end
				end

				arg_693_1.text_.text = var_696_75
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_79 = var_696_71 + 0.3
			local var_696_80 = math.max(var_696_72, arg_693_1.talkMaxDuration)

			if var_696_79 <= arg_693_1.time_ and arg_693_1.time_ < var_696_79 + var_696_80 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_79) / var_696_80

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_79 + var_696_80 and arg_693_1.time_ < var_696_79 + var_696_80 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_693_1:InitPlayNodeList()
	end,
	Play1108411168 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1108411168
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1108411169(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0
			local var_704_1 = 0.325

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				local var_704_2 = arg_701_1:FormatText(StoryNameCfg[7].name)

				arg_701_1.leftNameTxt_.text = var_704_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_3 = arg_701_1:GetWordFromCfg(1108411168)
				local var_704_4 = arg_701_1:FormatText(var_704_3.content)

				arg_701_1.text_.text = var_704_4

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_5 = 13
				local var_704_6 = utf8.len(var_704_4)
				local var_704_7 = var_704_5 <= 0 and var_704_1 or var_704_1 * (var_704_6 / var_704_5)

				if var_704_7 > 0 and var_704_1 < var_704_7 then
					arg_701_1.talkMaxDuration = var_704_7

					if var_704_7 + var_704_0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_7 + var_704_0
					end
				end

				arg_701_1.text_.text = var_704_4
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_8 = math.max(var_704_1, arg_701_1.talkMaxDuration)

			if var_704_0 <= arg_701_1.time_ and arg_701_1.time_ < var_704_0 + var_704_8 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_0) / var_704_8

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_0 + var_704_8 and arg_701_1.time_ < var_704_0 + var_704_8 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play1108411169 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1108411169
		arg_705_1.duration_ = 6.33

		local var_705_0 = {
			zh = 3.166,
			ja = 6.333
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1108411170(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = arg_705_1.actors_["10102ui_story"].transform
			local var_708_1 = 0

			if var_708_1 < arg_705_1.time_ and arg_705_1.time_ <= var_708_1 + arg_708_0 then
				arg_705_1.var_.moveOldPos10102ui_story = var_708_0.localPosition
			end

			local var_708_2 = 0.001

			if var_708_1 <= arg_705_1.time_ and arg_705_1.time_ < var_708_1 + var_708_2 then
				local var_708_3 = (arg_705_1.time_ - var_708_1) / var_708_2
				local var_708_4 = Vector3.New(0, -0.985, -6.275)

				var_708_0.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos10102ui_story, var_708_4, var_708_3)

				local var_708_5 = manager.ui.mainCamera.transform.position - var_708_0.position

				var_708_0.forward = Vector3.New(var_708_5.x, var_708_5.y, var_708_5.z)

				local var_708_6 = var_708_0.localEulerAngles

				var_708_6.z = 0
				var_708_6.x = 0
				var_708_0.localEulerAngles = var_708_6
			end

			if arg_705_1.time_ >= var_708_1 + var_708_2 and arg_705_1.time_ < var_708_1 + var_708_2 + arg_708_0 then
				var_708_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_708_7 = manager.ui.mainCamera.transform.position - var_708_0.position

				var_708_0.forward = Vector3.New(var_708_7.x, var_708_7.y, var_708_7.z)

				local var_708_8 = var_708_0.localEulerAngles

				var_708_8.z = 0
				var_708_8.x = 0
				var_708_0.localEulerAngles = var_708_8
			end

			local var_708_9 = arg_705_1.actors_["10102ui_story"]
			local var_708_10 = 0

			if var_708_10 < arg_705_1.time_ and arg_705_1.time_ <= var_708_10 + arg_708_0 and not isNil(var_708_9) and arg_705_1.var_.characterEffect10102ui_story == nil then
				arg_705_1.var_.characterEffect10102ui_story = var_708_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_11 = 0.200000002980232

			if var_708_10 <= arg_705_1.time_ and arg_705_1.time_ < var_708_10 + var_708_11 and not isNil(var_708_9) then
				local var_708_12 = (arg_705_1.time_ - var_708_10) / var_708_11

				if arg_705_1.var_.characterEffect10102ui_story and not isNil(var_708_9) then
					arg_705_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= var_708_10 + var_708_11 and arg_705_1.time_ < var_708_10 + var_708_11 + arg_708_0 and not isNil(var_708_9) and arg_705_1.var_.characterEffect10102ui_story then
				arg_705_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_708_13 = 0

			if var_708_13 < arg_705_1.time_ and arg_705_1.time_ <= var_708_13 + arg_708_0 then
				arg_705_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_708_14 = 0

			if var_708_14 < arg_705_1.time_ and arg_705_1.time_ <= var_708_14 + arg_708_0 then
				arg_705_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_708_15 = 0
			local var_708_16 = 0.35

			if var_708_15 < arg_705_1.time_ and arg_705_1.time_ <= var_708_15 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				local var_708_17 = arg_705_1:FormatText(StoryNameCfg[6].name)

				arg_705_1.leftNameTxt_.text = var_708_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_18 = arg_705_1:GetWordFromCfg(1108411169)
				local var_708_19 = arg_705_1:FormatText(var_708_18.content)

				arg_705_1.text_.text = var_708_19

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_20 = 14
				local var_708_21 = utf8.len(var_708_19)
				local var_708_22 = var_708_20 <= 0 and var_708_16 or var_708_16 * (var_708_21 / var_708_20)

				if var_708_22 > 0 and var_708_16 < var_708_22 then
					arg_705_1.talkMaxDuration = var_708_22

					if var_708_22 + var_708_15 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_22 + var_708_15
					end
				end

				arg_705_1.text_.text = var_708_19
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb") ~= 0 then
					local var_708_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb") / 1000

					if var_708_23 + var_708_15 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_23 + var_708_15
					end

					if var_708_18.prefab_name ~= "" and arg_705_1.actors_[var_708_18.prefab_name] ~= nil then
						local var_708_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_18.prefab_name].transform, "story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")

						arg_705_1:RecordAudio("1108411169", var_708_24)
						arg_705_1:RecordAudio("1108411169", var_708_24)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_25 = math.max(var_708_16, arg_705_1.talkMaxDuration)

			if var_708_15 <= arg_705_1.time_ and arg_705_1.time_ < var_708_15 + var_708_25 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_15) / var_708_25

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_15 + var_708_25 and arg_705_1.time_ < var_708_15 + var_708_25 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_705_1:InitPlayNodeList()
	end,
	Play1108411170 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1108411170
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1108411171(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = arg_709_1.actors_["10102ui_story"]
			local var_712_1 = 0

			if var_712_1 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 and not isNil(var_712_0) and arg_709_1.var_.characterEffect10102ui_story == nil then
				arg_709_1.var_.characterEffect10102ui_story = var_712_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_2 = 0.200000002980232

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_2 and not isNil(var_712_0) then
				local var_712_3 = (arg_709_1.time_ - var_712_1) / var_712_2

				if arg_709_1.var_.characterEffect10102ui_story and not isNil(var_712_0) then
					local var_712_4 = Mathf.Lerp(0, 0.5, var_712_3)

					arg_709_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_709_1.var_.characterEffect10102ui_story.fillRatio = var_712_4
				end
			end

			if arg_709_1.time_ >= var_712_1 + var_712_2 and arg_709_1.time_ < var_712_1 + var_712_2 + arg_712_0 and not isNil(var_712_0) and arg_709_1.var_.characterEffect10102ui_story then
				local var_712_5 = 0.5

				arg_709_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_709_1.var_.characterEffect10102ui_story.fillRatio = var_712_5
			end

			local var_712_6 = 0.333333333333333
			local var_712_7 = 1

			if var_712_6 < arg_709_1.time_ and arg_709_1.time_ <= var_712_6 + arg_712_0 then
				local var_712_8 = "play"
				local var_712_9 = "effect"

				arg_709_1:AudioAction(var_712_8, var_712_9, "se_story_1310", "se_story_1310_plate", "")
			end

			local var_712_10 = 0
			local var_712_11 = 1.9

			if var_712_10 < arg_709_1.time_ and arg_709_1.time_ <= var_712_10 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_12 = arg_709_1:GetWordFromCfg(1108411170)
				local var_712_13 = arg_709_1:FormatText(var_712_12.content)

				arg_709_1.text_.text = var_712_13

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_14 = 76
				local var_712_15 = utf8.len(var_712_13)
				local var_712_16 = var_712_14 <= 0 and var_712_11 or var_712_11 * (var_712_15 / var_712_14)

				if var_712_16 > 0 and var_712_11 < var_712_16 then
					arg_709_1.talkMaxDuration = var_712_16

					if var_712_16 + var_712_10 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_16 + var_712_10
					end
				end

				arg_709_1.text_.text = var_712_13
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_17 = math.max(var_712_11, arg_709_1.talkMaxDuration)

			if var_712_10 <= arg_709_1.time_ and arg_709_1.time_ < var_712_10 + var_712_17 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_10) / var_712_17

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_10 + var_712_17 and arg_709_1.time_ < var_712_10 + var_712_17 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1108411171 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1108411171
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1108411172(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0
			local var_716_1 = 0.35

			if var_716_0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_2 = arg_713_1:FormatText(StoryNameCfg[7].name)

				arg_713_1.leftNameTxt_.text = var_716_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_3 = arg_713_1:GetWordFromCfg(1108411171)
				local var_716_4 = arg_713_1:FormatText(var_716_3.content)

				arg_713_1.text_.text = var_716_4

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_5 = 14
				local var_716_6 = utf8.len(var_716_4)
				local var_716_7 = var_716_5 <= 0 and var_716_1 or var_716_1 * (var_716_6 / var_716_5)

				if var_716_7 > 0 and var_716_1 < var_716_7 then
					arg_713_1.talkMaxDuration = var_716_7

					if var_716_7 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_7 + var_716_0
					end
				end

				arg_713_1.text_.text = var_716_4
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_8 = math.max(var_716_1, arg_713_1.talkMaxDuration)

			if var_716_0 <= arg_713_1.time_ and arg_713_1.time_ < var_716_0 + var_716_8 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_0) / var_716_8

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_0 + var_716_8 and arg_713_1.time_ < var_716_0 + var_716_8 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1108411172 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1108411172
		arg_717_1.duration_ = 5.73

		local var_717_0 = {
			zh = 4.633,
			ja = 5.733
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1108411173(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = arg_717_1.actors_["10102ui_story"]
			local var_720_1 = 0

			if var_720_1 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect10102ui_story == nil then
				arg_717_1.var_.characterEffect10102ui_story = var_720_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.200000002980232

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_2 and not isNil(var_720_0) then
				local var_720_3 = (arg_717_1.time_ - var_720_1) / var_720_2

				if arg_717_1.var_.characterEffect10102ui_story and not isNil(var_720_0) then
					arg_717_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_717_1.time_ >= var_720_1 + var_720_2 and arg_717_1.time_ < var_720_1 + var_720_2 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect10102ui_story then
				arg_717_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_720_4 = 0

			if var_720_4 < arg_717_1.time_ and arg_717_1.time_ <= var_720_4 + arg_720_0 then
				arg_717_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			local var_720_5 = 0

			if var_720_5 < arg_717_1.time_ and arg_717_1.time_ <= var_720_5 + arg_720_0 then
				arg_717_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_720_6 = 0
			local var_720_7 = 0.55

			if var_720_6 < arg_717_1.time_ and arg_717_1.time_ <= var_720_6 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_8 = arg_717_1:FormatText(StoryNameCfg[6].name)

				arg_717_1.leftNameTxt_.text = var_720_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_9 = arg_717_1:GetWordFromCfg(1108411172)
				local var_720_10 = arg_717_1:FormatText(var_720_9.content)

				arg_717_1.text_.text = var_720_10

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_11 = 22
				local var_720_12 = utf8.len(var_720_10)
				local var_720_13 = var_720_11 <= 0 and var_720_7 or var_720_7 * (var_720_12 / var_720_11)

				if var_720_13 > 0 and var_720_7 < var_720_13 then
					arg_717_1.talkMaxDuration = var_720_13

					if var_720_13 + var_720_6 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_13 + var_720_6
					end
				end

				arg_717_1.text_.text = var_720_10
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb") ~= 0 then
					local var_720_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb") / 1000

					if var_720_14 + var_720_6 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_14 + var_720_6
					end

					if var_720_9.prefab_name ~= "" and arg_717_1.actors_[var_720_9.prefab_name] ~= nil then
						local var_720_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_9.prefab_name].transform, "story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")

						arg_717_1:RecordAudio("1108411172", var_720_15)
						arg_717_1:RecordAudio("1108411172", var_720_15)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_16 = math.max(var_720_7, arg_717_1.talkMaxDuration)

			if var_720_6 <= arg_717_1.time_ and arg_717_1.time_ < var_720_6 + var_720_16 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_6) / var_720_16

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_6 + var_720_16 and arg_717_1.time_ < var_720_6 + var_720_16 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1108411173 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1108411173
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1108411174(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = arg_721_1.actors_["10102ui_story"]
			local var_724_1 = 0

			if var_724_1 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect10102ui_story == nil then
				arg_721_1.var_.characterEffect10102ui_story = var_724_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_2 = 0.200000002980232

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_2 and not isNil(var_724_0) then
				local var_724_3 = (arg_721_1.time_ - var_724_1) / var_724_2

				if arg_721_1.var_.characterEffect10102ui_story and not isNil(var_724_0) then
					local var_724_4 = Mathf.Lerp(0, 0.5, var_724_3)

					arg_721_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_721_1.var_.characterEffect10102ui_story.fillRatio = var_724_4
				end
			end

			if arg_721_1.time_ >= var_724_1 + var_724_2 and arg_721_1.time_ < var_724_1 + var_724_2 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect10102ui_story then
				local var_724_5 = 0.5

				arg_721_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_721_1.var_.characterEffect10102ui_story.fillRatio = var_724_5
			end

			local var_724_6 = 0
			local var_724_7 = 0.225

			if var_724_6 < arg_721_1.time_ and arg_721_1.time_ <= var_724_6 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				local var_724_8 = arg_721_1:FormatText(StoryNameCfg[7].name)

				arg_721_1.leftNameTxt_.text = var_724_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, true)
				arg_721_1.iconController_:SetSelectedState("hero")

				arg_721_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_721_1.callingController_:SetSelectedState("normal")

				arg_721_1.keyicon_.color = Color.New(1, 1, 1)
				arg_721_1.icon_.color = Color.New(1, 1, 1)

				local var_724_9 = arg_721_1:GetWordFromCfg(1108411173)
				local var_724_10 = arg_721_1:FormatText(var_724_9.content)

				arg_721_1.text_.text = var_724_10

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_11 = 9
				local var_724_12 = utf8.len(var_724_10)
				local var_724_13 = var_724_11 <= 0 and var_724_7 or var_724_7 * (var_724_12 / var_724_11)

				if var_724_13 > 0 and var_724_7 < var_724_13 then
					arg_721_1.talkMaxDuration = var_724_13

					if var_724_13 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_13 + var_724_6
					end
				end

				arg_721_1.text_.text = var_724_10
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_14 = math.max(var_724_7, arg_721_1.talkMaxDuration)

			if var_724_6 <= arg_721_1.time_ and arg_721_1.time_ < var_724_6 + var_724_14 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_6) / var_724_14

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_6 + var_724_14 and arg_721_1.time_ < var_724_6 + var_724_14 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1108411174 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1108411174
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1108411175(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = arg_725_1.actors_["10102ui_story"].transform
			local var_728_1 = 0

			if var_728_1 < arg_725_1.time_ and arg_725_1.time_ <= var_728_1 + arg_728_0 then
				arg_725_1.var_.moveOldPos10102ui_story = var_728_0.localPosition
			end

			local var_728_2 = 0.001

			if var_728_1 <= arg_725_1.time_ and arg_725_1.time_ < var_728_1 + var_728_2 then
				local var_728_3 = (arg_725_1.time_ - var_728_1) / var_728_2
				local var_728_4 = Vector3.New(0, 100, 0)

				var_728_0.localPosition = Vector3.Lerp(arg_725_1.var_.moveOldPos10102ui_story, var_728_4, var_728_3)

				local var_728_5 = manager.ui.mainCamera.transform.position - var_728_0.position

				var_728_0.forward = Vector3.New(var_728_5.x, var_728_5.y, var_728_5.z)

				local var_728_6 = var_728_0.localEulerAngles

				var_728_6.z = 0
				var_728_6.x = 0
				var_728_0.localEulerAngles = var_728_6
			end

			if arg_725_1.time_ >= var_728_1 + var_728_2 and arg_725_1.time_ < var_728_1 + var_728_2 + arg_728_0 then
				var_728_0.localPosition = Vector3.New(0, 100, 0)

				local var_728_7 = manager.ui.mainCamera.transform.position - var_728_0.position

				var_728_0.forward = Vector3.New(var_728_7.x, var_728_7.y, var_728_7.z)

				local var_728_8 = var_728_0.localEulerAngles

				var_728_8.z = 0
				var_728_8.x = 0
				var_728_0.localEulerAngles = var_728_8
			end

			local var_728_9 = 0
			local var_728_10 = 1.25

			if var_728_9 < arg_725_1.time_ and arg_725_1.time_ <= var_728_9 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, false)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_11 = arg_725_1:GetWordFromCfg(1108411174)
				local var_728_12 = arg_725_1:FormatText(var_728_11.content)

				arg_725_1.text_.text = var_728_12

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_13 = 50
				local var_728_14 = utf8.len(var_728_12)
				local var_728_15 = var_728_13 <= 0 and var_728_10 or var_728_10 * (var_728_14 / var_728_13)

				if var_728_15 > 0 and var_728_10 < var_728_15 then
					arg_725_1.talkMaxDuration = var_728_15

					if var_728_15 + var_728_9 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_15 + var_728_9
					end
				end

				arg_725_1.text_.text = var_728_12
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_16 = math.max(var_728_10, arg_725_1.talkMaxDuration)

			if var_728_9 <= arg_725_1.time_ and arg_725_1.time_ < var_728_9 + var_728_16 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_9) / var_728_16

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_9 + var_728_16 and arg_725_1.time_ < var_728_9 + var_728_16 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_725_1:InitPlayNodeList()
	end,
	Play1108411175 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1108411175
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1108411176(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0
			local var_732_1 = 0.55

			if var_732_0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_2 = arg_729_1:FormatText(StoryNameCfg[7].name)

				arg_729_1.leftNameTxt_.text = var_732_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_3 = arg_729_1:GetWordFromCfg(1108411175)
				local var_732_4 = arg_729_1:FormatText(var_732_3.content)

				arg_729_1.text_.text = var_732_4

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 22
				local var_732_6 = utf8.len(var_732_4)
				local var_732_7 = var_732_5 <= 0 and var_732_1 or var_732_1 * (var_732_6 / var_732_5)

				if var_732_7 > 0 and var_732_1 < var_732_7 then
					arg_729_1.talkMaxDuration = var_732_7

					if var_732_7 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_7 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_4
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1108411176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1108411176
		arg_733_1.duration_ = 3.23

		local var_733_0 = {
			zh = 3.233,
			ja = 3.1
		}
		local var_733_1 = manager.audio:GetLocalizationFlag()

		if var_733_0[var_733_1] ~= nil then
			arg_733_1.duration_ = var_733_0[var_733_1]
		end

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1108411177(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = arg_733_1.actors_["10102ui_story"].transform
			local var_736_1 = 0

			if var_736_1 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 then
				arg_733_1.var_.moveOldPos10102ui_story = var_736_0.localPosition
			end

			local var_736_2 = 0.001

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_2 then
				local var_736_3 = (arg_733_1.time_ - var_736_1) / var_736_2
				local var_736_4 = Vector3.New(0, -0.985, -6.275)

				var_736_0.localPosition = Vector3.Lerp(arg_733_1.var_.moveOldPos10102ui_story, var_736_4, var_736_3)

				local var_736_5 = manager.ui.mainCamera.transform.position - var_736_0.position

				var_736_0.forward = Vector3.New(var_736_5.x, var_736_5.y, var_736_5.z)

				local var_736_6 = var_736_0.localEulerAngles

				var_736_6.z = 0
				var_736_6.x = 0
				var_736_0.localEulerAngles = var_736_6
			end

			if arg_733_1.time_ >= var_736_1 + var_736_2 and arg_733_1.time_ < var_736_1 + var_736_2 + arg_736_0 then
				var_736_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_736_7 = manager.ui.mainCamera.transform.position - var_736_0.position

				var_736_0.forward = Vector3.New(var_736_7.x, var_736_7.y, var_736_7.z)

				local var_736_8 = var_736_0.localEulerAngles

				var_736_8.z = 0
				var_736_8.x = 0
				var_736_0.localEulerAngles = var_736_8
			end

			local var_736_9 = arg_733_1.actors_["10102ui_story"]
			local var_736_10 = 0

			if var_736_10 < arg_733_1.time_ and arg_733_1.time_ <= var_736_10 + arg_736_0 and not isNil(var_736_9) and arg_733_1.var_.characterEffect10102ui_story == nil then
				arg_733_1.var_.characterEffect10102ui_story = var_736_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_11 = 0.200000002980232

			if var_736_10 <= arg_733_1.time_ and arg_733_1.time_ < var_736_10 + var_736_11 and not isNil(var_736_9) then
				local var_736_12 = (arg_733_1.time_ - var_736_10) / var_736_11

				if arg_733_1.var_.characterEffect10102ui_story and not isNil(var_736_9) then
					arg_733_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_733_1.time_ >= var_736_10 + var_736_11 and arg_733_1.time_ < var_736_10 + var_736_11 + arg_736_0 and not isNil(var_736_9) and arg_733_1.var_.characterEffect10102ui_story then
				arg_733_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_736_13 = 0

			if var_736_13 < arg_733_1.time_ and arg_733_1.time_ <= var_736_13 + arg_736_0 then
				arg_733_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_736_14 = 0

			if var_736_14 < arg_733_1.time_ and arg_733_1.time_ <= var_736_14 + arg_736_0 then
				arg_733_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_736_15 = 0
			local var_736_16 = 0.4

			if var_736_15 < arg_733_1.time_ and arg_733_1.time_ <= var_736_15 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				local var_736_17 = arg_733_1:FormatText(StoryNameCfg[6].name)

				arg_733_1.leftNameTxt_.text = var_736_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_18 = arg_733_1:GetWordFromCfg(1108411176)
				local var_736_19 = arg_733_1:FormatText(var_736_18.content)

				arg_733_1.text_.text = var_736_19

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_20 = 16
				local var_736_21 = utf8.len(var_736_19)
				local var_736_22 = var_736_20 <= 0 and var_736_16 or var_736_16 * (var_736_21 / var_736_20)

				if var_736_22 > 0 and var_736_16 < var_736_22 then
					arg_733_1.talkMaxDuration = var_736_22

					if var_736_22 + var_736_15 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_22 + var_736_15
					end
				end

				arg_733_1.text_.text = var_736_19
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb") ~= 0 then
					local var_736_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb") / 1000

					if var_736_23 + var_736_15 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_23 + var_736_15
					end

					if var_736_18.prefab_name ~= "" and arg_733_1.actors_[var_736_18.prefab_name] ~= nil then
						local var_736_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_733_1.actors_[var_736_18.prefab_name].transform, "story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")

						arg_733_1:RecordAudio("1108411176", var_736_24)
						arg_733_1:RecordAudio("1108411176", var_736_24)
					else
						arg_733_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")
					end

					arg_733_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")
				end

				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_25 = math.max(var_736_16, arg_733_1.talkMaxDuration)

			if var_736_15 <= arg_733_1.time_ and arg_733_1.time_ < var_736_15 + var_736_25 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_15) / var_736_25

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_15 + var_736_25 and arg_733_1.time_ < var_736_15 + var_736_25 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_733_1:InitPlayNodeList()
	end,
	Play1108411177 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1108411177
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1108411178(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = arg_737_1.actors_["10102ui_story"]
			local var_740_1 = 0

			if var_740_1 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect10102ui_story == nil then
				arg_737_1.var_.characterEffect10102ui_story = var_740_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_2 = 0.200000002980232

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_2 and not isNil(var_740_0) then
				local var_740_3 = (arg_737_1.time_ - var_740_1) / var_740_2

				if arg_737_1.var_.characterEffect10102ui_story and not isNil(var_740_0) then
					local var_740_4 = Mathf.Lerp(0, 0.5, var_740_3)

					arg_737_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_737_1.var_.characterEffect10102ui_story.fillRatio = var_740_4
				end
			end

			if arg_737_1.time_ >= var_740_1 + var_740_2 and arg_737_1.time_ < var_740_1 + var_740_2 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect10102ui_story then
				local var_740_5 = 0.5

				arg_737_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_737_1.var_.characterEffect10102ui_story.fillRatio = var_740_5
			end

			local var_740_6 = 0
			local var_740_7 = 0.725

			if var_740_6 < arg_737_1.time_ and arg_737_1.time_ <= var_740_6 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_8 = arg_737_1:FormatText(StoryNameCfg[7].name)

				arg_737_1.leftNameTxt_.text = var_740_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_9 = arg_737_1:GetWordFromCfg(1108411177)
				local var_740_10 = arg_737_1:FormatText(var_740_9.content)

				arg_737_1.text_.text = var_740_10

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_11 = 29
				local var_740_12 = utf8.len(var_740_10)
				local var_740_13 = var_740_11 <= 0 and var_740_7 or var_740_7 * (var_740_12 / var_740_11)

				if var_740_13 > 0 and var_740_7 < var_740_13 then
					arg_737_1.talkMaxDuration = var_740_13

					if var_740_13 + var_740_6 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_13 + var_740_6
					end
				end

				arg_737_1.text_.text = var_740_10
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_14 = math.max(var_740_7, arg_737_1.talkMaxDuration)

			if var_740_6 <= arg_737_1.time_ and arg_737_1.time_ < var_740_6 + var_740_14 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_6) / var_740_14

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_6 + var_740_14 and arg_737_1.time_ < var_740_6 + var_740_14 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1108411178 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1108411178
		arg_741_1.duration_ = 7.73

		local var_741_0 = {
			zh = 7.3,
			ja = 7.733
		}
		local var_741_1 = manager.audio:GetLocalizationFlag()

		if var_741_0[var_741_1] ~= nil then
			arg_741_1.duration_ = var_741_0[var_741_1]
		end

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1108411179(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = arg_741_1.actors_["10102ui_story"]
			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 and not isNil(var_744_0) and arg_741_1.var_.characterEffect10102ui_story == nil then
				arg_741_1.var_.characterEffect10102ui_story = var_744_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_2 = 0.200000002980232

			if var_744_1 <= arg_741_1.time_ and arg_741_1.time_ < var_744_1 + var_744_2 and not isNil(var_744_0) then
				local var_744_3 = (arg_741_1.time_ - var_744_1) / var_744_2

				if arg_741_1.var_.characterEffect10102ui_story and not isNil(var_744_0) then
					arg_741_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= var_744_1 + var_744_2 and arg_741_1.time_ < var_744_1 + var_744_2 + arg_744_0 and not isNil(var_744_0) and arg_741_1.var_.characterEffect10102ui_story then
				arg_741_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_744_4 = 0

			if var_744_4 < arg_741_1.time_ and arg_741_1.time_ <= var_744_4 + arg_744_0 then
				arg_741_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_744_5 = 0

			if var_744_5 < arg_741_1.time_ and arg_741_1.time_ <= var_744_5 + arg_744_0 then
				arg_741_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_744_6 = 0
			local var_744_7 = 0.925

			if var_744_6 < arg_741_1.time_ and arg_741_1.time_ <= var_744_6 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_8 = arg_741_1:FormatText(StoryNameCfg[6].name)

				arg_741_1.leftNameTxt_.text = var_744_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_9 = arg_741_1:GetWordFromCfg(1108411178)
				local var_744_10 = arg_741_1:FormatText(var_744_9.content)

				arg_741_1.text_.text = var_744_10

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_11 = 37
				local var_744_12 = utf8.len(var_744_10)
				local var_744_13 = var_744_11 <= 0 and var_744_7 or var_744_7 * (var_744_12 / var_744_11)

				if var_744_13 > 0 and var_744_7 < var_744_13 then
					arg_741_1.talkMaxDuration = var_744_13

					if var_744_13 + var_744_6 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_13 + var_744_6
					end
				end

				arg_741_1.text_.text = var_744_10
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb") ~= 0 then
					local var_744_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb") / 1000

					if var_744_14 + var_744_6 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_14 + var_744_6
					end

					if var_744_9.prefab_name ~= "" and arg_741_1.actors_[var_744_9.prefab_name] ~= nil then
						local var_744_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_9.prefab_name].transform, "story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")

						arg_741_1:RecordAudio("1108411178", var_744_15)
						arg_741_1:RecordAudio("1108411178", var_744_15)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_16 = math.max(var_744_7, arg_741_1.talkMaxDuration)

			if var_744_6 <= arg_741_1.time_ and arg_741_1.time_ < var_744_6 + var_744_16 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_6) / var_744_16

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_6 + var_744_16 and arg_741_1.time_ < var_744_6 + var_744_16 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1108411179 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1108411179
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1108411180(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = arg_745_1.actors_["10102ui_story"]
			local var_748_1 = 0

			if var_748_1 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 and not isNil(var_748_0) and arg_745_1.var_.characterEffect10102ui_story == nil then
				arg_745_1.var_.characterEffect10102ui_story = var_748_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_748_2 = 0.200000002980232

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_2 and not isNil(var_748_0) then
				local var_748_3 = (arg_745_1.time_ - var_748_1) / var_748_2

				if arg_745_1.var_.characterEffect10102ui_story and not isNil(var_748_0) then
					local var_748_4 = Mathf.Lerp(0, 0.5, var_748_3)

					arg_745_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_745_1.var_.characterEffect10102ui_story.fillRatio = var_748_4
				end
			end

			if arg_745_1.time_ >= var_748_1 + var_748_2 and arg_745_1.time_ < var_748_1 + var_748_2 + arg_748_0 and not isNil(var_748_0) and arg_745_1.var_.characterEffect10102ui_story then
				local var_748_5 = 0.5

				arg_745_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_745_1.var_.characterEffect10102ui_story.fillRatio = var_748_5
			end

			local var_748_6 = 0
			local var_748_7 = 0.425

			if var_748_6 < arg_745_1.time_ and arg_745_1.time_ <= var_748_6 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				local var_748_8 = arg_745_1:FormatText(StoryNameCfg[7].name)

				arg_745_1.leftNameTxt_.text = var_748_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, true)
				arg_745_1.iconController_:SetSelectedState("hero")

				arg_745_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_745_1.callingController_:SetSelectedState("normal")

				arg_745_1.keyicon_.color = Color.New(1, 1, 1)
				arg_745_1.icon_.color = Color.New(1, 1, 1)

				local var_748_9 = arg_745_1:GetWordFromCfg(1108411179)
				local var_748_10 = arg_745_1:FormatText(var_748_9.content)

				arg_745_1.text_.text = var_748_10

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_11 = 17
				local var_748_12 = utf8.len(var_748_10)
				local var_748_13 = var_748_11 <= 0 and var_748_7 or var_748_7 * (var_748_12 / var_748_11)

				if var_748_13 > 0 and var_748_7 < var_748_13 then
					arg_745_1.talkMaxDuration = var_748_13

					if var_748_13 + var_748_6 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_13 + var_748_6
					end
				end

				arg_745_1.text_.text = var_748_10
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_14 = math.max(var_748_7, arg_745_1.talkMaxDuration)

			if var_748_6 <= arg_745_1.time_ and arg_745_1.time_ < var_748_6 + var_748_14 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_6) / var_748_14

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_6 + var_748_14 and arg_745_1.time_ < var_748_6 + var_748_14 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1108411180 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1108411180
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1108411181(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0
			local var_752_1 = 0.55

			if var_752_0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				local var_752_2 = arg_749_1:FormatText(StoryNameCfg[7].name)

				arg_749_1.leftNameTxt_.text = var_752_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, true)
				arg_749_1.iconController_:SetSelectedState("hero")

				arg_749_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_749_1.callingController_:SetSelectedState("normal")

				arg_749_1.keyicon_.color = Color.New(1, 1, 1)
				arg_749_1.icon_.color = Color.New(1, 1, 1)

				local var_752_3 = arg_749_1:GetWordFromCfg(1108411180)
				local var_752_4 = arg_749_1:FormatText(var_752_3.content)

				arg_749_1.text_.text = var_752_4

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_5 = 22
				local var_752_6 = utf8.len(var_752_4)
				local var_752_7 = var_752_5 <= 0 and var_752_1 or var_752_1 * (var_752_6 / var_752_5)

				if var_752_7 > 0 and var_752_1 < var_752_7 then
					arg_749_1.talkMaxDuration = var_752_7

					if var_752_7 + var_752_0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_7 + var_752_0
					end
				end

				arg_749_1.text_.text = var_752_4
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_8 = math.max(var_752_1, arg_749_1.talkMaxDuration)

			if var_752_0 <= arg_749_1.time_ and arg_749_1.time_ < var_752_0 + var_752_8 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_0) / var_752_8

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_0 + var_752_8 and arg_749_1.time_ < var_752_0 + var_752_8 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play1108411181 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1108411181
		arg_753_1.duration_ = 5.87

		local var_753_0 = {
			zh = 3.966,
			ja = 5.866
		}
		local var_753_1 = manager.audio:GetLocalizationFlag()

		if var_753_0[var_753_1] ~= nil then
			arg_753_1.duration_ = var_753_0[var_753_1]
		end

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1108411182(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = arg_753_1.actors_["10102ui_story"]
			local var_756_1 = 0

			if var_756_1 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect10102ui_story == nil then
				arg_753_1.var_.characterEffect10102ui_story = var_756_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_2 = 0.200000002980232

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_2 and not isNil(var_756_0) then
				local var_756_3 = (arg_753_1.time_ - var_756_1) / var_756_2

				if arg_753_1.var_.characterEffect10102ui_story and not isNil(var_756_0) then
					arg_753_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_753_1.time_ >= var_756_1 + var_756_2 and arg_753_1.time_ < var_756_1 + var_756_2 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect10102ui_story then
				arg_753_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_756_4 = 0

			if var_756_4 < arg_753_1.time_ and arg_753_1.time_ <= var_756_4 + arg_756_0 then
				arg_753_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_756_5 = 0

			if var_756_5 < arg_753_1.time_ and arg_753_1.time_ <= var_756_5 + arg_756_0 then
				arg_753_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_756_6 = 0
			local var_756_7 = 0.55

			if var_756_6 < arg_753_1.time_ and arg_753_1.time_ <= var_756_6 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				local var_756_8 = arg_753_1:FormatText(StoryNameCfg[6].name)

				arg_753_1.leftNameTxt_.text = var_756_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_9 = arg_753_1:GetWordFromCfg(1108411181)
				local var_756_10 = arg_753_1:FormatText(var_756_9.content)

				arg_753_1.text_.text = var_756_10

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_11 = 22
				local var_756_12 = utf8.len(var_756_10)
				local var_756_13 = var_756_11 <= 0 and var_756_7 or var_756_7 * (var_756_12 / var_756_11)

				if var_756_13 > 0 and var_756_7 < var_756_13 then
					arg_753_1.talkMaxDuration = var_756_13

					if var_756_13 + var_756_6 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_13 + var_756_6
					end
				end

				arg_753_1.text_.text = var_756_10
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb") ~= 0 then
					local var_756_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb") / 1000

					if var_756_14 + var_756_6 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_14 + var_756_6
					end

					if var_756_9.prefab_name ~= "" and arg_753_1.actors_[var_756_9.prefab_name] ~= nil then
						local var_756_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_753_1.actors_[var_756_9.prefab_name].transform, "story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")

						arg_753_1:RecordAudio("1108411181", var_756_15)
						arg_753_1:RecordAudio("1108411181", var_756_15)
					else
						arg_753_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")
					end

					arg_753_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")
				end

				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_16 = math.max(var_756_7, arg_753_1.talkMaxDuration)

			if var_756_6 <= arg_753_1.time_ and arg_753_1.time_ < var_756_6 + var_756_16 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_6) / var_756_16

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_6 + var_756_16 and arg_753_1.time_ < var_756_6 + var_756_16 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1108411182 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1108411182
		arg_757_1.duration_ = 7.4

		local var_757_0 = {
			zh = 5.1,
			ja = 7.4
		}
		local var_757_1 = manager.audio:GetLocalizationFlag()

		if var_757_0[var_757_1] ~= nil then
			arg_757_1.duration_ = var_757_0[var_757_1]
		end

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1108411183(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0
			local var_760_1 = 0.7

			if var_760_0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				local var_760_2 = arg_757_1:FormatText(StoryNameCfg[6].name)

				arg_757_1.leftNameTxt_.text = var_760_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_3 = arg_757_1:GetWordFromCfg(1108411182)
				local var_760_4 = arg_757_1:FormatText(var_760_3.content)

				arg_757_1.text_.text = var_760_4

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_5 = 28
				local var_760_6 = utf8.len(var_760_4)
				local var_760_7 = var_760_5 <= 0 and var_760_1 or var_760_1 * (var_760_6 / var_760_5)

				if var_760_7 > 0 and var_760_1 < var_760_7 then
					arg_757_1.talkMaxDuration = var_760_7

					if var_760_7 + var_760_0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_7 + var_760_0
					end
				end

				arg_757_1.text_.text = var_760_4
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb") ~= 0 then
					local var_760_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb") / 1000

					if var_760_8 + var_760_0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_8 + var_760_0
					end

					if var_760_3.prefab_name ~= "" and arg_757_1.actors_[var_760_3.prefab_name] ~= nil then
						local var_760_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_3.prefab_name].transform, "story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")

						arg_757_1:RecordAudio("1108411182", var_760_9)
						arg_757_1:RecordAudio("1108411182", var_760_9)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_10 = math.max(var_760_1, arg_757_1.talkMaxDuration)

			if var_760_0 <= arg_757_1.time_ and arg_757_1.time_ < var_760_0 + var_760_10 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_0) / var_760_10

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_0 + var_760_10 and arg_757_1.time_ < var_760_0 + var_760_10 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1108411183 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1108411183
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1108411184(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = arg_761_1.actors_["10102ui_story"]
			local var_764_1 = 0

			if var_764_1 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect10102ui_story == nil then
				arg_761_1.var_.characterEffect10102ui_story = var_764_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_2 = 0.200000002980232

			if var_764_1 <= arg_761_1.time_ and arg_761_1.time_ < var_764_1 + var_764_2 and not isNil(var_764_0) then
				local var_764_3 = (arg_761_1.time_ - var_764_1) / var_764_2

				if arg_761_1.var_.characterEffect10102ui_story and not isNil(var_764_0) then
					local var_764_4 = Mathf.Lerp(0, 0.5, var_764_3)

					arg_761_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_761_1.var_.characterEffect10102ui_story.fillRatio = var_764_4
				end
			end

			if arg_761_1.time_ >= var_764_1 + var_764_2 and arg_761_1.time_ < var_764_1 + var_764_2 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect10102ui_story then
				local var_764_5 = 0.5

				arg_761_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_761_1.var_.characterEffect10102ui_story.fillRatio = var_764_5
			end

			local var_764_6 = 0
			local var_764_7 = 0.2

			if var_764_6 < arg_761_1.time_ and arg_761_1.time_ <= var_764_6 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				local var_764_8 = arg_761_1:FormatText(StoryNameCfg[7].name)

				arg_761_1.leftNameTxt_.text = var_764_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_9 = arg_761_1:GetWordFromCfg(1108411183)
				local var_764_10 = arg_761_1:FormatText(var_764_9.content)

				arg_761_1.text_.text = var_764_10

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_11 = 8
				local var_764_12 = utf8.len(var_764_10)
				local var_764_13 = var_764_11 <= 0 and var_764_7 or var_764_7 * (var_764_12 / var_764_11)

				if var_764_13 > 0 and var_764_7 < var_764_13 then
					arg_761_1.talkMaxDuration = var_764_13

					if var_764_13 + var_764_6 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_13 + var_764_6
					end
				end

				arg_761_1.text_.text = var_764_10
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_14 = math.max(var_764_7, arg_761_1.talkMaxDuration)

			if var_764_6 <= arg_761_1.time_ and arg_761_1.time_ < var_764_6 + var_764_14 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_6) / var_764_14

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_6 + var_764_14 and arg_761_1.time_ < var_764_6 + var_764_14 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1108411184 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1108411184
		arg_765_1.duration_ = 4.63

		local var_765_0 = {
			zh = 2.966,
			ja = 4.633
		}
		local var_765_1 = manager.audio:GetLocalizationFlag()

		if var_765_0[var_765_1] ~= nil then
			arg_765_1.duration_ = var_765_0[var_765_1]
		end

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1108411185(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = arg_765_1.actors_["10102ui_story"]
			local var_768_1 = 0

			if var_768_1 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect10102ui_story == nil then
				arg_765_1.var_.characterEffect10102ui_story = var_768_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_2 = 0.200000002980232

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_2 and not isNil(var_768_0) then
				local var_768_3 = (arg_765_1.time_ - var_768_1) / var_768_2

				if arg_765_1.var_.characterEffect10102ui_story and not isNil(var_768_0) then
					arg_765_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_765_1.time_ >= var_768_1 + var_768_2 and arg_765_1.time_ < var_768_1 + var_768_2 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect10102ui_story then
				arg_765_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_768_4 = 0
			local var_768_5 = 0.375

			if var_768_4 < arg_765_1.time_ and arg_765_1.time_ <= var_768_4 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				local var_768_6 = arg_765_1:FormatText(StoryNameCfg[6].name)

				arg_765_1.leftNameTxt_.text = var_768_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_7 = arg_765_1:GetWordFromCfg(1108411184)
				local var_768_8 = arg_765_1:FormatText(var_768_7.content)

				arg_765_1.text_.text = var_768_8

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_9 = 15
				local var_768_10 = utf8.len(var_768_8)
				local var_768_11 = var_768_9 <= 0 and var_768_5 or var_768_5 * (var_768_10 / var_768_9)

				if var_768_11 > 0 and var_768_5 < var_768_11 then
					arg_765_1.talkMaxDuration = var_768_11

					if var_768_11 + var_768_4 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_11 + var_768_4
					end
				end

				arg_765_1.text_.text = var_768_8
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb") ~= 0 then
					local var_768_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb") / 1000

					if var_768_12 + var_768_4 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_12 + var_768_4
					end

					if var_768_7.prefab_name ~= "" and arg_765_1.actors_[var_768_7.prefab_name] ~= nil then
						local var_768_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_765_1.actors_[var_768_7.prefab_name].transform, "story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")

						arg_765_1:RecordAudio("1108411184", var_768_13)
						arg_765_1:RecordAudio("1108411184", var_768_13)
					else
						arg_765_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")
					end

					arg_765_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")
				end

				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_14 = math.max(var_768_5, arg_765_1.talkMaxDuration)

			if var_768_4 <= arg_765_1.time_ and arg_765_1.time_ < var_768_4 + var_768_14 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_4) / var_768_14

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_4 + var_768_14 and arg_765_1.time_ < var_768_4 + var_768_14 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1108411185 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1108411185
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1108411186(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = arg_769_1.actors_["10102ui_story"]
			local var_772_1 = 0

			if var_772_1 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect10102ui_story == nil then
				arg_769_1.var_.characterEffect10102ui_story = var_772_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_2 = 0.200000002980232

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_2 and not isNil(var_772_0) then
				local var_772_3 = (arg_769_1.time_ - var_772_1) / var_772_2

				if arg_769_1.var_.characterEffect10102ui_story and not isNil(var_772_0) then
					local var_772_4 = Mathf.Lerp(0, 0.5, var_772_3)

					arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_769_1.var_.characterEffect10102ui_story.fillRatio = var_772_4
				end
			end

			if arg_769_1.time_ >= var_772_1 + var_772_2 and arg_769_1.time_ < var_772_1 + var_772_2 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect10102ui_story then
				local var_772_5 = 0.5

				arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_769_1.var_.characterEffect10102ui_story.fillRatio = var_772_5
			end

			local var_772_6 = 0
			local var_772_7 = 1.05

			if var_772_6 < arg_769_1.time_ and arg_769_1.time_ <= var_772_6 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				local var_772_8 = arg_769_1:FormatText(StoryNameCfg[7].name)

				arg_769_1.leftNameTxt_.text = var_772_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, true)
				arg_769_1.iconController_:SetSelectedState("hero")

				arg_769_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_769_1.callingController_:SetSelectedState("normal")

				arg_769_1.keyicon_.color = Color.New(1, 1, 1)
				arg_769_1.icon_.color = Color.New(1, 1, 1)

				local var_772_9 = arg_769_1:GetWordFromCfg(1108411185)
				local var_772_10 = arg_769_1:FormatText(var_772_9.content)

				arg_769_1.text_.text = var_772_10

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_11 = 42
				local var_772_12 = utf8.len(var_772_10)
				local var_772_13 = var_772_11 <= 0 and var_772_7 or var_772_7 * (var_772_12 / var_772_11)

				if var_772_13 > 0 and var_772_7 < var_772_13 then
					arg_769_1.talkMaxDuration = var_772_13

					if var_772_13 + var_772_6 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_13 + var_772_6
					end
				end

				arg_769_1.text_.text = var_772_10
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_14 = math.max(var_772_7, arg_769_1.talkMaxDuration)

			if var_772_6 <= arg_769_1.time_ and arg_769_1.time_ < var_772_6 + var_772_14 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_6) / var_772_14

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_6 + var_772_14 and arg_769_1.time_ < var_772_6 + var_772_14 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1108411186 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1108411186
		arg_773_1.duration_ = 6.6

		local var_773_0 = {
			zh = 4,
			ja = 6.6
		}
		local var_773_1 = manager.audio:GetLocalizationFlag()

		if var_773_0[var_773_1] ~= nil then
			arg_773_1.duration_ = var_773_0[var_773_1]
		end

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1108411187(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = arg_773_1.actors_["10102ui_story"]
			local var_776_1 = 0

			if var_776_1 < arg_773_1.time_ and arg_773_1.time_ <= var_776_1 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect10102ui_story == nil then
				arg_773_1.var_.characterEffect10102ui_story = var_776_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_2 = 0.200000002980232

			if var_776_1 <= arg_773_1.time_ and arg_773_1.time_ < var_776_1 + var_776_2 and not isNil(var_776_0) then
				local var_776_3 = (arg_773_1.time_ - var_776_1) / var_776_2

				if arg_773_1.var_.characterEffect10102ui_story and not isNil(var_776_0) then
					arg_773_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_773_1.time_ >= var_776_1 + var_776_2 and arg_773_1.time_ < var_776_1 + var_776_2 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect10102ui_story then
				arg_773_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_776_4 = 0

			if var_776_4 < arg_773_1.time_ and arg_773_1.time_ <= var_776_4 + arg_776_0 then
				arg_773_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_776_5 = 0

			if var_776_5 < arg_773_1.time_ and arg_773_1.time_ <= var_776_5 + arg_776_0 then
				arg_773_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_776_6 = 0
			local var_776_7 = 0.5

			if var_776_6 < arg_773_1.time_ and arg_773_1.time_ <= var_776_6 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				local var_776_8 = arg_773_1:FormatText(StoryNameCfg[6].name)

				arg_773_1.leftNameTxt_.text = var_776_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_9 = arg_773_1:GetWordFromCfg(1108411186)
				local var_776_10 = arg_773_1:FormatText(var_776_9.content)

				arg_773_1.text_.text = var_776_10

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_11 = 20
				local var_776_12 = utf8.len(var_776_10)
				local var_776_13 = var_776_11 <= 0 and var_776_7 or var_776_7 * (var_776_12 / var_776_11)

				if var_776_13 > 0 and var_776_7 < var_776_13 then
					arg_773_1.talkMaxDuration = var_776_13

					if var_776_13 + var_776_6 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_13 + var_776_6
					end
				end

				arg_773_1.text_.text = var_776_10
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb") ~= 0 then
					local var_776_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb") / 1000

					if var_776_14 + var_776_6 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_14 + var_776_6
					end

					if var_776_9.prefab_name ~= "" and arg_773_1.actors_[var_776_9.prefab_name] ~= nil then
						local var_776_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_9.prefab_name].transform, "story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")

						arg_773_1:RecordAudio("1108411186", var_776_15)
						arg_773_1:RecordAudio("1108411186", var_776_15)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_16 = math.max(var_776_7, arg_773_1.talkMaxDuration)

			if var_776_6 <= arg_773_1.time_ and arg_773_1.time_ < var_776_6 + var_776_16 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_6) / var_776_16

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_6 + var_776_16 and arg_773_1.time_ < var_776_6 + var_776_16 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play1108411187 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1108411187
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1108411188(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = arg_777_1.actors_["10102ui_story"]
			local var_780_1 = 0

			if var_780_1 < arg_777_1.time_ and arg_777_1.time_ <= var_780_1 + arg_780_0 and not isNil(var_780_0) and arg_777_1.var_.characterEffect10102ui_story == nil then
				arg_777_1.var_.characterEffect10102ui_story = var_780_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_2 = 0.200000002980232

			if var_780_1 <= arg_777_1.time_ and arg_777_1.time_ < var_780_1 + var_780_2 and not isNil(var_780_0) then
				local var_780_3 = (arg_777_1.time_ - var_780_1) / var_780_2

				if arg_777_1.var_.characterEffect10102ui_story and not isNil(var_780_0) then
					local var_780_4 = Mathf.Lerp(0, 0.5, var_780_3)

					arg_777_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_777_1.var_.characterEffect10102ui_story.fillRatio = var_780_4
				end
			end

			if arg_777_1.time_ >= var_780_1 + var_780_2 and arg_777_1.time_ < var_780_1 + var_780_2 + arg_780_0 and not isNil(var_780_0) and arg_777_1.var_.characterEffect10102ui_story then
				local var_780_5 = 0.5

				arg_777_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_777_1.var_.characterEffect10102ui_story.fillRatio = var_780_5
			end

			local var_780_6 = 0
			local var_780_7 = 0.45

			if var_780_6 < arg_777_1.time_ and arg_777_1.time_ <= var_780_6 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				local var_780_8 = arg_777_1:FormatText(StoryNameCfg[7].name)

				arg_777_1.leftNameTxt_.text = var_780_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_9 = arg_777_1:GetWordFromCfg(1108411187)
				local var_780_10 = arg_777_1:FormatText(var_780_9.content)

				arg_777_1.text_.text = var_780_10

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_11 = 18
				local var_780_12 = utf8.len(var_780_10)
				local var_780_13 = var_780_11 <= 0 and var_780_7 or var_780_7 * (var_780_12 / var_780_11)

				if var_780_13 > 0 and var_780_7 < var_780_13 then
					arg_777_1.talkMaxDuration = var_780_13

					if var_780_13 + var_780_6 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_13 + var_780_6
					end
				end

				arg_777_1.text_.text = var_780_10
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_14 = math.max(var_780_7, arg_777_1.talkMaxDuration)

			if var_780_6 <= arg_777_1.time_ and arg_777_1.time_ < var_780_6 + var_780_14 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_6) / var_780_14

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_6 + var_780_14 and arg_777_1.time_ < var_780_6 + var_780_14 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1108411188 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1108411188
		arg_781_1.duration_ = 6.73

		local var_781_0 = {
			zh = 6.2,
			ja = 6.733
		}
		local var_781_1 = manager.audio:GetLocalizationFlag()

		if var_781_0[var_781_1] ~= nil then
			arg_781_1.duration_ = var_781_0[var_781_1]
		end

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1108411189(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = arg_781_1.actors_["10102ui_story"]
			local var_784_1 = 0

			if var_784_1 < arg_781_1.time_ and arg_781_1.time_ <= var_784_1 + arg_784_0 and not isNil(var_784_0) and arg_781_1.var_.characterEffect10102ui_story == nil then
				arg_781_1.var_.characterEffect10102ui_story = var_784_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_784_2 = 0.200000002980232

			if var_784_1 <= arg_781_1.time_ and arg_781_1.time_ < var_784_1 + var_784_2 and not isNil(var_784_0) then
				local var_784_3 = (arg_781_1.time_ - var_784_1) / var_784_2

				if arg_781_1.var_.characterEffect10102ui_story and not isNil(var_784_0) then
					arg_781_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_781_1.time_ >= var_784_1 + var_784_2 and arg_781_1.time_ < var_784_1 + var_784_2 + arg_784_0 and not isNil(var_784_0) and arg_781_1.var_.characterEffect10102ui_story then
				arg_781_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_784_4 = 0

			if var_784_4 < arg_781_1.time_ and arg_781_1.time_ <= var_784_4 + arg_784_0 then
				arg_781_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_784_5 = 0
			local var_784_6 = 0.7

			if var_784_5 < arg_781_1.time_ and arg_781_1.time_ <= var_784_5 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				local var_784_7 = arg_781_1:FormatText(StoryNameCfg[6].name)

				arg_781_1.leftNameTxt_.text = var_784_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_8 = arg_781_1:GetWordFromCfg(1108411188)
				local var_784_9 = arg_781_1:FormatText(var_784_8.content)

				arg_781_1.text_.text = var_784_9

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_10 = 29
				local var_784_11 = utf8.len(var_784_9)
				local var_784_12 = var_784_10 <= 0 and var_784_6 or var_784_6 * (var_784_11 / var_784_10)

				if var_784_12 > 0 and var_784_6 < var_784_12 then
					arg_781_1.talkMaxDuration = var_784_12

					if var_784_12 + var_784_5 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_12 + var_784_5
					end
				end

				arg_781_1.text_.text = var_784_9
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb") ~= 0 then
					local var_784_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb") / 1000

					if var_784_13 + var_784_5 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_13 + var_784_5
					end

					if var_784_8.prefab_name ~= "" and arg_781_1.actors_[var_784_8.prefab_name] ~= nil then
						local var_784_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_781_1.actors_[var_784_8.prefab_name].transform, "story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")

						arg_781_1:RecordAudio("1108411188", var_784_14)
						arg_781_1:RecordAudio("1108411188", var_784_14)
					else
						arg_781_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")
					end

					arg_781_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")
				end

				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_15 = math.max(var_784_6, arg_781_1.talkMaxDuration)

			if var_784_5 <= arg_781_1.time_ and arg_781_1.time_ < var_784_5 + var_784_15 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_5) / var_784_15

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_5 + var_784_15 and arg_781_1.time_ < var_784_5 + var_784_15 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1108411189 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1108411189
		arg_785_1.duration_ = 4.7

		local var_785_0 = {
			zh = 3.8,
			ja = 4.7
		}
		local var_785_1 = manager.audio:GetLocalizationFlag()

		if var_785_0[var_785_1] ~= nil then
			arg_785_1.duration_ = var_785_0[var_785_1]
		end

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1108411190(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = 0

			if var_788_0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_0 + arg_788_0 then
				arg_785_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_788_1 = 0
			local var_788_2 = 0.5

			if var_788_1 < arg_785_1.time_ and arg_785_1.time_ <= var_788_1 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				local var_788_3 = arg_785_1:FormatText(StoryNameCfg[6].name)

				arg_785_1.leftNameTxt_.text = var_788_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_4 = arg_785_1:GetWordFromCfg(1108411189)
				local var_788_5 = arg_785_1:FormatText(var_788_4.content)

				arg_785_1.text_.text = var_788_5

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_6 = 20
				local var_788_7 = utf8.len(var_788_5)
				local var_788_8 = var_788_6 <= 0 and var_788_2 or var_788_2 * (var_788_7 / var_788_6)

				if var_788_8 > 0 and var_788_2 < var_788_8 then
					arg_785_1.talkMaxDuration = var_788_8

					if var_788_8 + var_788_1 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_8 + var_788_1
					end
				end

				arg_785_1.text_.text = var_788_5
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb") ~= 0 then
					local var_788_9 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb") / 1000

					if var_788_9 + var_788_1 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_9 + var_788_1
					end

					if var_788_4.prefab_name ~= "" and arg_785_1.actors_[var_788_4.prefab_name] ~= nil then
						local var_788_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_4.prefab_name].transform, "story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")

						arg_785_1:RecordAudio("1108411189", var_788_10)
						arg_785_1:RecordAudio("1108411189", var_788_10)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_11 = math.max(var_788_2, arg_785_1.talkMaxDuration)

			if var_788_1 <= arg_785_1.time_ and arg_785_1.time_ < var_788_1 + var_788_11 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_1) / var_788_11

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_1 + var_788_11 and arg_785_1.time_ < var_788_1 + var_788_11 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1108411190 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1108411190
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1108411191(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = arg_789_1.actors_["10102ui_story"]
			local var_792_1 = 0

			if var_792_1 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 and not isNil(var_792_0) and arg_789_1.var_.characterEffect10102ui_story == nil then
				arg_789_1.var_.characterEffect10102ui_story = var_792_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_792_2 = 0.200000002980232

			if var_792_1 <= arg_789_1.time_ and arg_789_1.time_ < var_792_1 + var_792_2 and not isNil(var_792_0) then
				local var_792_3 = (arg_789_1.time_ - var_792_1) / var_792_2

				if arg_789_1.var_.characterEffect10102ui_story and not isNil(var_792_0) then
					local var_792_4 = Mathf.Lerp(0, 0.5, var_792_3)

					arg_789_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_789_1.var_.characterEffect10102ui_story.fillRatio = var_792_4
				end
			end

			if arg_789_1.time_ >= var_792_1 + var_792_2 and arg_789_1.time_ < var_792_1 + var_792_2 + arg_792_0 and not isNil(var_792_0) and arg_789_1.var_.characterEffect10102ui_story then
				local var_792_5 = 0.5

				arg_789_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_789_1.var_.characterEffect10102ui_story.fillRatio = var_792_5
			end

			local var_792_6 = 0
			local var_792_7 = 0.325

			if var_792_6 < arg_789_1.time_ and arg_789_1.time_ <= var_792_6 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				local var_792_8 = arg_789_1:FormatText(StoryNameCfg[7].name)

				arg_789_1.leftNameTxt_.text = var_792_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, true)
				arg_789_1.iconController_:SetSelectedState("hero")

				arg_789_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_789_1.callingController_:SetSelectedState("normal")

				arg_789_1.keyicon_.color = Color.New(1, 1, 1)
				arg_789_1.icon_.color = Color.New(1, 1, 1)

				local var_792_9 = arg_789_1:GetWordFromCfg(1108411190)
				local var_792_10 = arg_789_1:FormatText(var_792_9.content)

				arg_789_1.text_.text = var_792_10

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_11 = 13
				local var_792_12 = utf8.len(var_792_10)
				local var_792_13 = var_792_11 <= 0 and var_792_7 or var_792_7 * (var_792_12 / var_792_11)

				if var_792_13 > 0 and var_792_7 < var_792_13 then
					arg_789_1.talkMaxDuration = var_792_13

					if var_792_13 + var_792_6 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_13 + var_792_6
					end
				end

				arg_789_1.text_.text = var_792_10
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_14 = math.max(var_792_7, arg_789_1.talkMaxDuration)

			if var_792_6 <= arg_789_1.time_ and arg_789_1.time_ < var_792_6 + var_792_14 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_6) / var_792_14

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_6 + var_792_14 and arg_789_1.time_ < var_792_6 + var_792_14 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play1108411191 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1108411191
		arg_793_1.duration_ = 7.23

		local var_793_0 = {
			zh = 4.933,
			ja = 7.233
		}
		local var_793_1 = manager.audio:GetLocalizationFlag()

		if var_793_0[var_793_1] ~= nil then
			arg_793_1.duration_ = var_793_0[var_793_1]
		end

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1108411192(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			local var_796_0 = arg_793_1.actors_["10102ui_story"]
			local var_796_1 = 0

			if var_796_1 < arg_793_1.time_ and arg_793_1.time_ <= var_796_1 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect10102ui_story == nil then
				arg_793_1.var_.characterEffect10102ui_story = var_796_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_2 = 0.200000002980232

			if var_796_1 <= arg_793_1.time_ and arg_793_1.time_ < var_796_1 + var_796_2 and not isNil(var_796_0) then
				local var_796_3 = (arg_793_1.time_ - var_796_1) / var_796_2

				if arg_793_1.var_.characterEffect10102ui_story and not isNil(var_796_0) then
					arg_793_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_793_1.time_ >= var_796_1 + var_796_2 and arg_793_1.time_ < var_796_1 + var_796_2 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect10102ui_story then
				arg_793_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_796_4 = 0

			if var_796_4 < arg_793_1.time_ and arg_793_1.time_ <= var_796_4 + arg_796_0 then
				arg_793_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_796_5 = 0
			local var_796_6 = 0.575

			if var_796_5 < arg_793_1.time_ and arg_793_1.time_ <= var_796_5 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				local var_796_7 = arg_793_1:FormatText(StoryNameCfg[6].name)

				arg_793_1.leftNameTxt_.text = var_796_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, false)
				arg_793_1.callingController_:SetSelectedState("normal")

				local var_796_8 = arg_793_1:GetWordFromCfg(1108411191)
				local var_796_9 = arg_793_1:FormatText(var_796_8.content)

				arg_793_1.text_.text = var_796_9

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_10 = 23
				local var_796_11 = utf8.len(var_796_9)
				local var_796_12 = var_796_10 <= 0 and var_796_6 or var_796_6 * (var_796_11 / var_796_10)

				if var_796_12 > 0 and var_796_6 < var_796_12 then
					arg_793_1.talkMaxDuration = var_796_12

					if var_796_12 + var_796_5 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_12 + var_796_5
					end
				end

				arg_793_1.text_.text = var_796_9
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb") ~= 0 then
					local var_796_13 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb") / 1000

					if var_796_13 + var_796_5 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_13 + var_796_5
					end

					if var_796_8.prefab_name ~= "" and arg_793_1.actors_[var_796_8.prefab_name] ~= nil then
						local var_796_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_793_1.actors_[var_796_8.prefab_name].transform, "story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")

						arg_793_1:RecordAudio("1108411191", var_796_14)
						arg_793_1:RecordAudio("1108411191", var_796_14)
					else
						arg_793_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")
					end

					arg_793_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")
				end

				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_15 = math.max(var_796_6, arg_793_1.talkMaxDuration)

			if var_796_5 <= arg_793_1.time_ and arg_793_1.time_ < var_796_5 + var_796_15 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_5) / var_796_15

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_5 + var_796_15 and arg_793_1.time_ < var_796_5 + var_796_15 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1108411192 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1108411192
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1108411193(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = arg_797_1.actors_["10102ui_story"]
			local var_800_1 = 0

			if var_800_1 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 and not isNil(var_800_0) and arg_797_1.var_.characterEffect10102ui_story == nil then
				arg_797_1.var_.characterEffect10102ui_story = var_800_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_2 = 0.200000002980232

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_2 and not isNil(var_800_0) then
				local var_800_3 = (arg_797_1.time_ - var_800_1) / var_800_2

				if arg_797_1.var_.characterEffect10102ui_story and not isNil(var_800_0) then
					local var_800_4 = Mathf.Lerp(0, 0.5, var_800_3)

					arg_797_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_797_1.var_.characterEffect10102ui_story.fillRatio = var_800_4
				end
			end

			if arg_797_1.time_ >= var_800_1 + var_800_2 and arg_797_1.time_ < var_800_1 + var_800_2 + arg_800_0 and not isNil(var_800_0) and arg_797_1.var_.characterEffect10102ui_story then
				local var_800_5 = 0.5

				arg_797_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_797_1.var_.characterEffect10102ui_story.fillRatio = var_800_5
			end

			local var_800_6 = 0
			local var_800_7 = 0.4

			if var_800_6 < arg_797_1.time_ and arg_797_1.time_ <= var_800_6 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				local var_800_8 = arg_797_1:FormatText(StoryNameCfg[7].name)

				arg_797_1.leftNameTxt_.text = var_800_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, true)
				arg_797_1.iconController_:SetSelectedState("hero")

				arg_797_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_797_1.callingController_:SetSelectedState("normal")

				arg_797_1.keyicon_.color = Color.New(1, 1, 1)
				arg_797_1.icon_.color = Color.New(1, 1, 1)

				local var_800_9 = arg_797_1:GetWordFromCfg(1108411192)
				local var_800_10 = arg_797_1:FormatText(var_800_9.content)

				arg_797_1.text_.text = var_800_10

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_11 = 16
				local var_800_12 = utf8.len(var_800_10)
				local var_800_13 = var_800_11 <= 0 and var_800_7 or var_800_7 * (var_800_12 / var_800_11)

				if var_800_13 > 0 and var_800_7 < var_800_13 then
					arg_797_1.talkMaxDuration = var_800_13

					if var_800_13 + var_800_6 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_13 + var_800_6
					end
				end

				arg_797_1.text_.text = var_800_10
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_14 = math.max(var_800_7, arg_797_1.talkMaxDuration)

			if var_800_6 <= arg_797_1.time_ and arg_797_1.time_ < var_800_6 + var_800_14 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_6) / var_800_14

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_6 + var_800_14 and arg_797_1.time_ < var_800_6 + var_800_14 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1108411193 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1108411193
		arg_801_1.duration_ = 2

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1108411194(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = arg_801_1.actors_["10102ui_story"]
			local var_804_1 = 0

			if var_804_1 < arg_801_1.time_ and arg_801_1.time_ <= var_804_1 + arg_804_0 and not isNil(var_804_0) and arg_801_1.var_.characterEffect10102ui_story == nil then
				arg_801_1.var_.characterEffect10102ui_story = var_804_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_2 = 0.200000002980232

			if var_804_1 <= arg_801_1.time_ and arg_801_1.time_ < var_804_1 + var_804_2 and not isNil(var_804_0) then
				local var_804_3 = (arg_801_1.time_ - var_804_1) / var_804_2

				if arg_801_1.var_.characterEffect10102ui_story and not isNil(var_804_0) then
					arg_801_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_801_1.time_ >= var_804_1 + var_804_2 and arg_801_1.time_ < var_804_1 + var_804_2 + arg_804_0 and not isNil(var_804_0) and arg_801_1.var_.characterEffect10102ui_story then
				arg_801_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_804_4 = 0

			if var_804_4 < arg_801_1.time_ and arg_801_1.time_ <= var_804_4 + arg_804_0 then
				arg_801_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_804_5 = 0

			if var_804_5 < arg_801_1.time_ and arg_801_1.time_ <= var_804_5 + arg_804_0 then
				arg_801_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action467")
			end

			local var_804_6 = 0
			local var_804_7 = 0.125

			if var_804_6 < arg_801_1.time_ and arg_801_1.time_ <= var_804_6 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				local var_804_8 = arg_801_1:FormatText(StoryNameCfg[6].name)

				arg_801_1.leftNameTxt_.text = var_804_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_9 = arg_801_1:GetWordFromCfg(1108411193)
				local var_804_10 = arg_801_1:FormatText(var_804_9.content)

				arg_801_1.text_.text = var_804_10

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_11 = 5
				local var_804_12 = utf8.len(var_804_10)
				local var_804_13 = var_804_11 <= 0 and var_804_7 or var_804_7 * (var_804_12 / var_804_11)

				if var_804_13 > 0 and var_804_7 < var_804_13 then
					arg_801_1.talkMaxDuration = var_804_13

					if var_804_13 + var_804_6 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_13 + var_804_6
					end
				end

				arg_801_1.text_.text = var_804_10
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb") ~= 0 then
					local var_804_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb") / 1000

					if var_804_14 + var_804_6 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_14 + var_804_6
					end

					if var_804_9.prefab_name ~= "" and arg_801_1.actors_[var_804_9.prefab_name] ~= nil then
						local var_804_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_801_1.actors_[var_804_9.prefab_name].transform, "story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")

						arg_801_1:RecordAudio("1108411193", var_804_15)
						arg_801_1:RecordAudio("1108411193", var_804_15)
					else
						arg_801_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")
					end

					arg_801_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")
				end

				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_16 = math.max(var_804_7, arg_801_1.talkMaxDuration)

			if var_804_6 <= arg_801_1.time_ and arg_801_1.time_ < var_804_6 + var_804_16 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_6) / var_804_16

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_6 + var_804_16 and arg_801_1.time_ < var_804_6 + var_804_16 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1108411194 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1108411194
		arg_805_1.duration_ = 9.2

		local var_805_0 = {
			zh = 7.4,
			ja = 9.2
		}
		local var_805_1 = manager.audio:GetLocalizationFlag()

		if var_805_0[var_805_1] ~= nil then
			arg_805_1.duration_ = var_805_0[var_805_1]
		end

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1108411195(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			local var_808_0 = 0
			local var_808_1 = 0.95

			if var_808_0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_0 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				local var_808_2 = arg_805_1:FormatText(StoryNameCfg[6].name)

				arg_805_1.leftNameTxt_.text = var_808_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_3 = arg_805_1:GetWordFromCfg(1108411194)
				local var_808_4 = arg_805_1:FormatText(var_808_3.content)

				arg_805_1.text_.text = var_808_4

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_5 = 38
				local var_808_6 = utf8.len(var_808_4)
				local var_808_7 = var_808_5 <= 0 and var_808_1 or var_808_1 * (var_808_6 / var_808_5)

				if var_808_7 > 0 and var_808_1 < var_808_7 then
					arg_805_1.talkMaxDuration = var_808_7

					if var_808_7 + var_808_0 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_7 + var_808_0
					end
				end

				arg_805_1.text_.text = var_808_4
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb") ~= 0 then
					local var_808_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb") / 1000

					if var_808_8 + var_808_0 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_8 + var_808_0
					end

					if var_808_3.prefab_name ~= "" and arg_805_1.actors_[var_808_3.prefab_name] ~= nil then
						local var_808_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_805_1.actors_[var_808_3.prefab_name].transform, "story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")

						arg_805_1:RecordAudio("1108411194", var_808_9)
						arg_805_1:RecordAudio("1108411194", var_808_9)
					else
						arg_805_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")
					end

					arg_805_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")
				end

				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_10 = math.max(var_808_1, arg_805_1.talkMaxDuration)

			if var_808_0 <= arg_805_1.time_ and arg_805_1.time_ < var_808_0 + var_808_10 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_0) / var_808_10

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_0 + var_808_10 and arg_805_1.time_ < var_808_0 + var_808_10 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {}

		arg_805_1:InitPlayNodeList()
	end,
	Play1108411195 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1108411195
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1108411196(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0
			local var_812_1 = 0.1

			if var_812_0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				local var_812_2 = arg_809_1:FormatText(StoryNameCfg[7].name)

				arg_809_1.leftNameTxt_.text = var_812_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_3 = arg_809_1:GetWordFromCfg(1108411195)
				local var_812_4 = arg_809_1:FormatText(var_812_3.content)

				arg_809_1.text_.text = var_812_4

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_5 = 4
				local var_812_6 = utf8.len(var_812_4)
				local var_812_7 = var_812_5 <= 0 and var_812_1 or var_812_1 * (var_812_6 / var_812_5)

				if var_812_7 > 0 and var_812_1 < var_812_7 then
					arg_809_1.talkMaxDuration = var_812_7

					if var_812_7 + var_812_0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_7 + var_812_0
					end
				end

				arg_809_1.text_.text = var_812_4
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_8 = math.max(var_812_1, arg_809_1.talkMaxDuration)

			if var_812_0 <= arg_809_1.time_ and arg_809_1.time_ < var_812_0 + var_812_8 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_0) / var_812_8

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_0 + var_812_8 and arg_809_1.time_ < var_812_0 + var_812_8 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play1108411196 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1108411196
		arg_813_1.duration_ = 4.33

		local var_813_0 = {
			zh = 4.333,
			ja = 4.033
		}
		local var_813_1 = manager.audio:GetLocalizationFlag()

		if var_813_0[var_813_1] ~= nil then
			arg_813_1.duration_ = var_813_0[var_813_1]
		end

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1108411197(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = arg_813_1.actors_["10102ui_story"]
			local var_816_1 = 0

			if var_816_1 < arg_813_1.time_ and arg_813_1.time_ <= var_816_1 + arg_816_0 and not isNil(var_816_0) and arg_813_1.var_.characterEffect10102ui_story == nil then
				arg_813_1.var_.characterEffect10102ui_story = var_816_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_816_2 = 0.200000002980232

			if var_816_1 <= arg_813_1.time_ and arg_813_1.time_ < var_816_1 + var_816_2 and not isNil(var_816_0) then
				local var_816_3 = (arg_813_1.time_ - var_816_1) / var_816_2

				if arg_813_1.var_.characterEffect10102ui_story and not isNil(var_816_0) then
					arg_813_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_813_1.time_ >= var_816_1 + var_816_2 and arg_813_1.time_ < var_816_1 + var_816_2 + arg_816_0 and not isNil(var_816_0) and arg_813_1.var_.characterEffect10102ui_story then
				arg_813_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_816_4 = 0

			if var_816_4 < arg_813_1.time_ and arg_813_1.time_ <= var_816_4 + arg_816_0 then
				arg_813_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			local var_816_5 = 0

			if var_816_5 < arg_813_1.time_ and arg_813_1.time_ <= var_816_5 + arg_816_0 then
				arg_813_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_816_6 = 0
			local var_816_7 = 0.425

			if var_816_6 < arg_813_1.time_ and arg_813_1.time_ <= var_816_6 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				local var_816_8 = arg_813_1:FormatText(StoryNameCfg[6].name)

				arg_813_1.leftNameTxt_.text = var_816_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, false)
				arg_813_1.callingController_:SetSelectedState("normal")

				local var_816_9 = arg_813_1:GetWordFromCfg(1108411196)
				local var_816_10 = arg_813_1:FormatText(var_816_9.content)

				arg_813_1.text_.text = var_816_10

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_11 = 17
				local var_816_12 = utf8.len(var_816_10)
				local var_816_13 = var_816_11 <= 0 and var_816_7 or var_816_7 * (var_816_12 / var_816_11)

				if var_816_13 > 0 and var_816_7 < var_816_13 then
					arg_813_1.talkMaxDuration = var_816_13

					if var_816_13 + var_816_6 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_13 + var_816_6
					end
				end

				arg_813_1.text_.text = var_816_10
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb") ~= 0 then
					local var_816_14 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb") / 1000

					if var_816_14 + var_816_6 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_14 + var_816_6
					end

					if var_816_9.prefab_name ~= "" and arg_813_1.actors_[var_816_9.prefab_name] ~= nil then
						local var_816_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_813_1.actors_[var_816_9.prefab_name].transform, "story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")

						arg_813_1:RecordAudio("1108411196", var_816_15)
						arg_813_1:RecordAudio("1108411196", var_816_15)
					else
						arg_813_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")
					end

					arg_813_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")
				end

				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_16 = math.max(var_816_7, arg_813_1.talkMaxDuration)

			if var_816_6 <= arg_813_1.time_ and arg_813_1.time_ < var_816_6 + var_816_16 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_6) / var_816_16

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_6 + var_816_16 and arg_813_1.time_ < var_816_6 + var_816_16 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1108411197 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1108411197
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1108411198(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = arg_817_1.actors_["10102ui_story"]
			local var_820_1 = 0

			if var_820_1 < arg_817_1.time_ and arg_817_1.time_ <= var_820_1 + arg_820_0 and not isNil(var_820_0) and arg_817_1.var_.characterEffect10102ui_story == nil then
				arg_817_1.var_.characterEffect10102ui_story = var_820_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_2 = 0.200000002980232

			if var_820_1 <= arg_817_1.time_ and arg_817_1.time_ < var_820_1 + var_820_2 and not isNil(var_820_0) then
				local var_820_3 = (arg_817_1.time_ - var_820_1) / var_820_2

				if arg_817_1.var_.characterEffect10102ui_story and not isNil(var_820_0) then
					local var_820_4 = Mathf.Lerp(0, 0.5, var_820_3)

					arg_817_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_817_1.var_.characterEffect10102ui_story.fillRatio = var_820_4
				end
			end

			if arg_817_1.time_ >= var_820_1 + var_820_2 and arg_817_1.time_ < var_820_1 + var_820_2 + arg_820_0 and not isNil(var_820_0) and arg_817_1.var_.characterEffect10102ui_story then
				local var_820_5 = 0.5

				arg_817_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_817_1.var_.characterEffect10102ui_story.fillRatio = var_820_5
			end

			local var_820_6 = 0
			local var_820_7 = 0.575

			if var_820_6 < arg_817_1.time_ and arg_817_1.time_ <= var_820_6 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				local var_820_8 = arg_817_1:FormatText(StoryNameCfg[7].name)

				arg_817_1.leftNameTxt_.text = var_820_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, true)
				arg_817_1.iconController_:SetSelectedState("hero")

				arg_817_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_817_1.callingController_:SetSelectedState("normal")

				arg_817_1.keyicon_.color = Color.New(1, 1, 1)
				arg_817_1.icon_.color = Color.New(1, 1, 1)

				local var_820_9 = arg_817_1:GetWordFromCfg(1108411197)
				local var_820_10 = arg_817_1:FormatText(var_820_9.content)

				arg_817_1.text_.text = var_820_10

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_11 = 23
				local var_820_12 = utf8.len(var_820_10)
				local var_820_13 = var_820_11 <= 0 and var_820_7 or var_820_7 * (var_820_12 / var_820_11)

				if var_820_13 > 0 and var_820_7 < var_820_13 then
					arg_817_1.talkMaxDuration = var_820_13

					if var_820_13 + var_820_6 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_13 + var_820_6
					end
				end

				arg_817_1.text_.text = var_820_10
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_14 = math.max(var_820_7, arg_817_1.talkMaxDuration)

			if var_820_6 <= arg_817_1.time_ and arg_817_1.time_ < var_820_6 + var_820_14 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_6) / var_820_14

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_6 + var_820_14 and arg_817_1.time_ < var_820_6 + var_820_14 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1108411198 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1108411198
		arg_821_1.duration_ = 10.67

		local var_821_0 = {
			zh = 8.2,
			ja = 10.666
		}
		local var_821_1 = manager.audio:GetLocalizationFlag()

		if var_821_0[var_821_1] ~= nil then
			arg_821_1.duration_ = var_821_0[var_821_1]
		end

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1108411199(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = arg_821_1.actors_["10102ui_story"]
			local var_824_1 = 0

			if var_824_1 < arg_821_1.time_ and arg_821_1.time_ <= var_824_1 + arg_824_0 and not isNil(var_824_0) and arg_821_1.var_.characterEffect10102ui_story == nil then
				arg_821_1.var_.characterEffect10102ui_story = var_824_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_2 = 0.200000002980232

			if var_824_1 <= arg_821_1.time_ and arg_821_1.time_ < var_824_1 + var_824_2 and not isNil(var_824_0) then
				local var_824_3 = (arg_821_1.time_ - var_824_1) / var_824_2

				if arg_821_1.var_.characterEffect10102ui_story and not isNil(var_824_0) then
					arg_821_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_821_1.time_ >= var_824_1 + var_824_2 and arg_821_1.time_ < var_824_1 + var_824_2 + arg_824_0 and not isNil(var_824_0) and arg_821_1.var_.characterEffect10102ui_story then
				arg_821_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_824_4 = 0
			local var_824_5 = 1.025

			if var_824_4 < arg_821_1.time_ and arg_821_1.time_ <= var_824_4 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				local var_824_6 = arg_821_1:FormatText(StoryNameCfg[6].name)

				arg_821_1.leftNameTxt_.text = var_824_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_7 = arg_821_1:GetWordFromCfg(1108411198)
				local var_824_8 = arg_821_1:FormatText(var_824_7.content)

				arg_821_1.text_.text = var_824_8

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_9 = 41
				local var_824_10 = utf8.len(var_824_8)
				local var_824_11 = var_824_9 <= 0 and var_824_5 or var_824_5 * (var_824_10 / var_824_9)

				if var_824_11 > 0 and var_824_5 < var_824_11 then
					arg_821_1.talkMaxDuration = var_824_11

					if var_824_11 + var_824_4 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_11 + var_824_4
					end
				end

				arg_821_1.text_.text = var_824_8
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb") ~= 0 then
					local var_824_12 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb") / 1000

					if var_824_12 + var_824_4 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_12 + var_824_4
					end

					if var_824_7.prefab_name ~= "" and arg_821_1.actors_[var_824_7.prefab_name] ~= nil then
						local var_824_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_821_1.actors_[var_824_7.prefab_name].transform, "story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")

						arg_821_1:RecordAudio("1108411198", var_824_13)
						arg_821_1:RecordAudio("1108411198", var_824_13)
					else
						arg_821_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")
					end

					arg_821_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")
				end

				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_14 = math.max(var_824_5, arg_821_1.talkMaxDuration)

			if var_824_4 <= arg_821_1.time_ and arg_821_1.time_ < var_824_4 + var_824_14 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_4) / var_824_14

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_4 + var_824_14 and arg_821_1.time_ < var_824_4 + var_824_14 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1108411199 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1108411199
		arg_825_1.duration_ = 5

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1108411200(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			local var_828_0 = arg_825_1.actors_["10102ui_story"].transform
			local var_828_1 = 0

			if var_828_1 < arg_825_1.time_ and arg_825_1.time_ <= var_828_1 + arg_828_0 then
				arg_825_1.var_.moveOldPos10102ui_story = var_828_0.localPosition
			end

			local var_828_2 = 0.001

			if var_828_1 <= arg_825_1.time_ and arg_825_1.time_ < var_828_1 + var_828_2 then
				local var_828_3 = (arg_825_1.time_ - var_828_1) / var_828_2
				local var_828_4 = Vector3.New(0, 100, 0)

				var_828_0.localPosition = Vector3.Lerp(arg_825_1.var_.moveOldPos10102ui_story, var_828_4, var_828_3)

				local var_828_5 = manager.ui.mainCamera.transform.position - var_828_0.position

				var_828_0.forward = Vector3.New(var_828_5.x, var_828_5.y, var_828_5.z)

				local var_828_6 = var_828_0.localEulerAngles

				var_828_6.z = 0
				var_828_6.x = 0
				var_828_0.localEulerAngles = var_828_6
			end

			if arg_825_1.time_ >= var_828_1 + var_828_2 and arg_825_1.time_ < var_828_1 + var_828_2 + arg_828_0 then
				var_828_0.localPosition = Vector3.New(0, 100, 0)

				local var_828_7 = manager.ui.mainCamera.transform.position - var_828_0.position

				var_828_0.forward = Vector3.New(var_828_7.x, var_828_7.y, var_828_7.z)

				local var_828_8 = var_828_0.localEulerAngles

				var_828_8.z = 0
				var_828_8.x = 0
				var_828_0.localEulerAngles = var_828_8
			end

			local var_828_9 = arg_825_1.actors_["10102ui_story"]
			local var_828_10 = 0

			if var_828_10 < arg_825_1.time_ and arg_825_1.time_ <= var_828_10 + arg_828_0 and not isNil(var_828_9) and arg_825_1.var_.characterEffect10102ui_story == nil then
				arg_825_1.var_.characterEffect10102ui_story = var_828_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_11 = 0.200000002980232

			if var_828_10 <= arg_825_1.time_ and arg_825_1.time_ < var_828_10 + var_828_11 and not isNil(var_828_9) then
				local var_828_12 = (arg_825_1.time_ - var_828_10) / var_828_11

				if arg_825_1.var_.characterEffect10102ui_story and not isNil(var_828_9) then
					local var_828_13 = Mathf.Lerp(0, 0.5, var_828_12)

					arg_825_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_825_1.var_.characterEffect10102ui_story.fillRatio = var_828_13
				end
			end

			if arg_825_1.time_ >= var_828_10 + var_828_11 and arg_825_1.time_ < var_828_10 + var_828_11 + arg_828_0 and not isNil(var_828_9) and arg_825_1.var_.characterEffect10102ui_story then
				local var_828_14 = 0.5

				arg_825_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_825_1.var_.characterEffect10102ui_story.fillRatio = var_828_14
			end

			local var_828_15 = 0
			local var_828_16 = 1.475

			if var_828_15 < arg_825_1.time_ and arg_825_1.time_ <= var_828_15 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, false)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_17 = arg_825_1:GetWordFromCfg(1108411199)
				local var_828_18 = arg_825_1:FormatText(var_828_17.content)

				arg_825_1.text_.text = var_828_18

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_19 = 59
				local var_828_20 = utf8.len(var_828_18)
				local var_828_21 = var_828_19 <= 0 and var_828_16 or var_828_16 * (var_828_20 / var_828_19)

				if var_828_21 > 0 and var_828_16 < var_828_21 then
					arg_825_1.talkMaxDuration = var_828_21

					if var_828_21 + var_828_15 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_21 + var_828_15
					end
				end

				arg_825_1.text_.text = var_828_18
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)
				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_22 = math.max(var_828_16, arg_825_1.talkMaxDuration)

			if var_828_15 <= arg_825_1.time_ and arg_825_1.time_ < var_828_15 + var_828_22 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_15) / var_828_22

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_15 + var_828_22 and arg_825_1.time_ < var_828_15 + var_828_22 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_825_1:InitPlayNodeList()
	end,
	Play1108411200 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1108411200
		arg_829_1.duration_ = 7.83

		local var_829_0 = {
			zh = 5.166,
			ja = 7.833
		}
		local var_829_1 = manager.audio:GetLocalizationFlag()

		if var_829_0[var_829_1] ~= nil then
			arg_829_1.duration_ = var_829_0[var_829_1]
		end

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
			arg_829_1.auto_ = false
		end

		function arg_829_1.playNext_(arg_831_0)
			arg_829_1.onStoryFinished_()
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			local var_832_0 = arg_829_1.actors_["10102ui_story"].transform
			local var_832_1 = 0

			if var_832_1 < arg_829_1.time_ and arg_829_1.time_ <= var_832_1 + arg_832_0 then
				arg_829_1.var_.moveOldPos10102ui_story = var_832_0.localPosition
			end

			local var_832_2 = 0.001

			if var_832_1 <= arg_829_1.time_ and arg_829_1.time_ < var_832_1 + var_832_2 then
				local var_832_3 = (arg_829_1.time_ - var_832_1) / var_832_2
				local var_832_4 = Vector3.New(0, -0.985, -6.275)

				var_832_0.localPosition = Vector3.Lerp(arg_829_1.var_.moveOldPos10102ui_story, var_832_4, var_832_3)

				local var_832_5 = manager.ui.mainCamera.transform.position - var_832_0.position

				var_832_0.forward = Vector3.New(var_832_5.x, var_832_5.y, var_832_5.z)

				local var_832_6 = var_832_0.localEulerAngles

				var_832_6.z = 0
				var_832_6.x = 0
				var_832_0.localEulerAngles = var_832_6
			end

			if arg_829_1.time_ >= var_832_1 + var_832_2 and arg_829_1.time_ < var_832_1 + var_832_2 + arg_832_0 then
				var_832_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_832_7 = manager.ui.mainCamera.transform.position - var_832_0.position

				var_832_0.forward = Vector3.New(var_832_7.x, var_832_7.y, var_832_7.z)

				local var_832_8 = var_832_0.localEulerAngles

				var_832_8.z = 0
				var_832_8.x = 0
				var_832_0.localEulerAngles = var_832_8
			end

			local var_832_9 = arg_829_1.actors_["10102ui_story"]
			local var_832_10 = 0

			if var_832_10 < arg_829_1.time_ and arg_829_1.time_ <= var_832_10 + arg_832_0 and not isNil(var_832_9) and arg_829_1.var_.characterEffect10102ui_story == nil then
				arg_829_1.var_.characterEffect10102ui_story = var_832_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_11 = 0.200000002980232

			if var_832_10 <= arg_829_1.time_ and arg_829_1.time_ < var_832_10 + var_832_11 and not isNil(var_832_9) then
				local var_832_12 = (arg_829_1.time_ - var_832_10) / var_832_11

				if arg_829_1.var_.characterEffect10102ui_story and not isNil(var_832_9) then
					arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_829_1.time_ >= var_832_10 + var_832_11 and arg_829_1.time_ < var_832_10 + var_832_11 + arg_832_0 and not isNil(var_832_9) and arg_829_1.var_.characterEffect10102ui_story then
				arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_832_13 = 0

			if var_832_13 < arg_829_1.time_ and arg_829_1.time_ <= var_832_13 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_832_14 = 0

			if var_832_14 < arg_829_1.time_ and arg_829_1.time_ <= var_832_14 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_832_15 = 0
			local var_832_16 = 0.525

			if var_832_15 < arg_829_1.time_ and arg_829_1.time_ <= var_832_15 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				local var_832_17 = arg_829_1:FormatText(StoryNameCfg[6].name)

				arg_829_1.leftNameTxt_.text = var_832_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, false)
				arg_829_1.callingController_:SetSelectedState("normal")

				local var_832_18 = arg_829_1:GetWordFromCfg(1108411200)
				local var_832_19 = arg_829_1:FormatText(var_832_18.content)

				arg_829_1.text_.text = var_832_19

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_20 = 21
				local var_832_21 = utf8.len(var_832_19)
				local var_832_22 = var_832_20 <= 0 and var_832_16 or var_832_16 * (var_832_21 / var_832_20)

				if var_832_22 > 0 and var_832_16 < var_832_22 then
					arg_829_1.talkMaxDuration = var_832_22

					if var_832_22 + var_832_15 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_22 + var_832_15
					end
				end

				arg_829_1.text_.text = var_832_19
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb") ~= 0 then
					local var_832_23 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb") / 1000

					if var_832_23 + var_832_15 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_23 + var_832_15
					end

					if var_832_18.prefab_name ~= "" and arg_829_1.actors_[var_832_18.prefab_name] ~= nil then
						local var_832_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_829_1.actors_[var_832_18.prefab_name].transform, "story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")

						arg_829_1:RecordAudio("1108411200", var_832_24)
						arg_829_1:RecordAudio("1108411200", var_832_24)
					else
						arg_829_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")
					end

					arg_829_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")
				end

				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_25 = math.max(var_832_16, arg_829_1.talkMaxDuration)

			if var_832_15 <= arg_829_1.time_ and arg_829_1.time_ < var_832_15 + var_832_25 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_15) / var_832_25

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_15 + var_832_25 and arg_829_1.time_ < var_832_15 + var_832_25 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_829_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/I18f",
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/ST0115"
	},
	voices = {
		"story_v_side_new_1108411.awb"
	}
}
