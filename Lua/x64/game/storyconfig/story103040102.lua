return {
	Play304012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304012001
		arg_1_1.duration_ = 9.83

		local var_1_0 = {
			zh = 9.133,
			ja = 9.833
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
				arg_1_0:Play304012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10f"

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
				local var_4_5 = arg_1_1.bgs_.B10f

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
					if iter_4_0 ~= "B10f" then
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

			local var_4_24 = arg_1_1.actors_["2044ui_story"]
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect2044ui_story == nil then
				arg_1_1.var_.characterEffect2044ui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffect2044ui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffect2044ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect2044ui_story then
				arg_1_1.var_.characterEffect2044ui_story.fillFlat = false
			end

			local var_4_28 = 0.2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_4_32 = 0
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "effect"

				arg_1_1:AudioAction(var_4_34, var_4_35, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.425

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[29].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2044")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(304012001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 17
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012001", "story_v_out_304012.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_304012", "304012001", "story_v_out_304012.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_304012", "304012001", "story_v_out_304012.awb")

						arg_1_1:RecordAudio("304012001", var_4_46)
						arg_1_1:RecordAudio("304012001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304012", "304012001", "story_v_out_304012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304012", "304012001", "story_v_out_304012.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304012002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 304012002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play304012003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["2044ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect2044ui_story == nil then
				arg_7_1.var_.characterEffect2044ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 and not isNil(var_10_0) then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect2044ui_story and not isNil(var_10_0) then
					local var_10_4 = Mathf.Lerp(0, 0.5, var_10_3)

					arg_7_1.var_.characterEffect2044ui_story.fillFlat = true
					arg_7_1.var_.characterEffect2044ui_story.fillRatio = var_10_4
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect2044ui_story then
				local var_10_5 = 0.5

				arg_7_1.var_.characterEffect2044ui_story.fillFlat = true
				arg_7_1.var_.characterEffect2044ui_story.fillRatio = var_10_5
			end

			local var_10_6 = 0
			local var_10_7 = 1.15

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_8 = arg_7_1:GetWordFromCfg(304012002)
				local var_10_9 = arg_7_1:FormatText(var_10_8.content)

				arg_7_1.text_.text = var_10_9

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 46
				local var_10_11 = utf8.len(var_10_9)
				local var_10_12 = var_10_10 <= 0 and var_10_7 or var_10_7 * (var_10_11 / var_10_10)

				if var_10_12 > 0 and var_10_7 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_9
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_13 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_13 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_13

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_13 and arg_7_1.time_ < var_10_6 + var_10_13 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play304012003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 304012003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play304012004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.7
			local var_14_1 = 1

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "play"
				local var_14_3 = "effect"

				arg_11_1:AudioAction(var_14_2, var_14_3, "se_story_152", "se_story_152_camera", "")
			end

			local var_14_4 = 0
			local var_14_5 = 1.55

			if var_14_4 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:GetWordFromCfg(304012003)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_8 = 62
				local var_14_9 = utf8.len(var_14_7)
				local var_14_10 = var_14_8 <= 0 and var_14_5 or var_14_5 * (var_14_9 / var_14_8)

				if var_14_10 > 0 and var_14_5 < var_14_10 then
					arg_11_1.talkMaxDuration = var_14_10

					if var_14_10 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_11 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_11 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_11

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_11 and arg_11_1.time_ < var_14_4 + var_14_11 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play304012004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 304012004
		arg_15_1.duration_ = 6.6

		local var_15_0 = {
			zh = 5.5,
			ja = 6.6
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play304012005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 1
			local var_18_1 = 1

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				local var_18_2 = "play"
				local var_18_3 = "music"

				arg_15_1:AudioAction(var_18_2, var_18_3, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_18_4 = ""
				local var_18_5 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_18_5 ~= "" then
					if arg_15_1.bgmTxt_.text ~= var_18_5 and arg_15_1.bgmTxt_.text ~= "" then
						if arg_15_1.bgmTxt2_.text ~= "" then
							arg_15_1.bgmTxt_.text = arg_15_1.bgmTxt2_.text
						end

						arg_15_1.bgmTxt2_.text = var_18_5

						arg_15_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_15_1.bgmTxt_.text = var_18_5
						arg_15_1.bgmTxt2_.text = var_18_5
					end

					if arg_15_1.bgmTimer then
						arg_15_1.bgmTimer:Stop()

						arg_15_1.bgmTimer = nil
					end

					if arg_15_1.settingData.show_music_name == 1 then
						arg_15_1.musicController:SetSelectedState("show")
						arg_15_1.musicAnimator_:Play("open", 0, 0)

						if arg_15_1.settingData.music_time ~= 0 then
							arg_15_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_15_1.settingData.music_time), function()
								if arg_15_1 == nil or isNil(arg_15_1.bgmTxt_) then
									return
								end

								arg_15_1.musicController:SetSelectedState("hide")
								arg_15_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_18_6 = 0
			local var_18_7 = 0.675

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_8 = arg_15_1:FormatText(StoryNameCfg[23].name)

				arg_15_1.leftNameTxt_.text = var_18_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_9 = arg_15_1:GetWordFromCfg(304012004)
				local var_18_10 = arg_15_1:FormatText(var_18_9.content)

				arg_15_1.text_.text = var_18_10

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_11 = 27
				local var_18_12 = utf8.len(var_18_10)
				local var_18_13 = var_18_11 <= 0 and var_18_7 or var_18_7 * (var_18_12 / var_18_11)

				if var_18_13 > 0 and var_18_7 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_10
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012004", "story_v_out_304012.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_304012", "304012004", "story_v_out_304012.awb") / 1000

					if var_18_14 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_6
					end

					if var_18_9.prefab_name ~= "" and arg_15_1.actors_[var_18_9.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_9.prefab_name].transform, "story_v_out_304012", "304012004", "story_v_out_304012.awb")

						arg_15_1:RecordAudio("304012004", var_18_15)
						arg_15_1:RecordAudio("304012004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_304012", "304012004", "story_v_out_304012.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_304012", "304012004", "story_v_out_304012.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_16 and arg_15_1.time_ < var_18_6 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play304012005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304012005
		arg_20_1.duration_ = 8.37

		local var_20_0 = {
			zh = 5.333,
			ja = 8.366
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
				arg_20_0:Play304012006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.75

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[25].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(304012005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012005", "story_v_out_304012.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012005", "story_v_out_304012.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_304012", "304012005", "story_v_out_304012.awb")

						arg_20_1:RecordAudio("304012005", var_23_9)
						arg_20_1:RecordAudio("304012005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304012", "304012005", "story_v_out_304012.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304012", "304012005", "story_v_out_304012.awb")
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
	Play304012006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304012006
		arg_24_1.duration_ = 8.47

		local var_24_0 = {
			zh = 4.2,
			ja = 8.466
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
				arg_24_0:Play304012007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.55

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[25].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(304012006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 22
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012006", "story_v_out_304012.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012006", "story_v_out_304012.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_304012", "304012006", "story_v_out_304012.awb")

						arg_24_1:RecordAudio("304012006", var_27_9)
						arg_24_1:RecordAudio("304012006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304012", "304012006", "story_v_out_304012.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304012", "304012006", "story_v_out_304012.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304012007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304012007
		arg_28_1.duration_ = 6.13

		local var_28_0 = {
			zh = 4.366,
			ja = 6.133
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
				arg_28_0:Play304012008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "2020_tpose"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["2020_tpose"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos2020_tpose = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(0, -1.2, -4.1)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos2020_tpose, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_5.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_5.localEulerAngles = var_31_14

				local var_31_15 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_15 then
					var_31_15:EnableDynamicBone(true)
				end
			end

			local var_31_16 = arg_28_1.actors_["2020_tpose"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_31_21 = 0
			local var_31_22 = 0.475

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_23 = arg_28_1:FormatText(StoryNameCfg[19].name)

				arg_28_1.leftNameTxt_.text = var_31_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_24 = arg_28_1:GetWordFromCfg(304012007)
				local var_31_25 = arg_28_1:FormatText(var_31_24.content)

				arg_28_1.text_.text = var_31_25

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_26 = 19
				local var_31_27 = utf8.len(var_31_25)
				local var_31_28 = var_31_26 <= 0 and var_31_22 or var_31_22 * (var_31_27 / var_31_26)

				if var_31_28 > 0 and var_31_22 < var_31_28 then
					arg_28_1.talkMaxDuration = var_31_28

					if var_31_28 + var_31_21 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_21
					end
				end

				arg_28_1.text_.text = var_31_25
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012007", "story_v_out_304012.awb") ~= 0 then
					local var_31_29 = manager.audio:GetVoiceLength("story_v_out_304012", "304012007", "story_v_out_304012.awb") / 1000

					if var_31_29 + var_31_21 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_21
					end

					if var_31_24.prefab_name ~= "" and arg_28_1.actors_[var_31_24.prefab_name] ~= nil then
						local var_31_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_24.prefab_name].transform, "story_v_out_304012", "304012007", "story_v_out_304012.awb")

						arg_28_1:RecordAudio("304012007", var_31_30)
						arg_28_1:RecordAudio("304012007", var_31_30)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304012", "304012007", "story_v_out_304012.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304012", "304012007", "story_v_out_304012.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_31 = math.max(var_31_22, arg_28_1.talkMaxDuration)

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_31 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_21) / var_31_31

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_21 + var_31_31 and arg_28_1.time_ < var_31_21 + var_31_31 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play304012008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304012008
		arg_32_1.duration_ = 7.7

		local var_32_0 = {
			zh = 6.933,
			ja = 7.7
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
				arg_32_0:Play304012009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.8

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[19].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(304012008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012008", "story_v_out_304012.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012008", "story_v_out_304012.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_304012", "304012008", "story_v_out_304012.awb")

						arg_32_1:RecordAudio("304012008", var_35_9)
						arg_32_1:RecordAudio("304012008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304012", "304012008", "story_v_out_304012.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304012", "304012008", "story_v_out_304012.awb")
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
	Play304012009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304012009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play304012010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["2020_tpose"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos2020_tpose = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos2020_tpose, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["2020_tpose"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_11) then
					local var_39_15 = Mathf.Lerp(0, 0.5, var_39_14)

					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_15
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect2020_tpose then
				local var_39_16 = 0.5

				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_16
			end

			local var_39_17 = 0
			local var_39_18 = 1.275

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(304012009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 51
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_18 or var_39_18 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_18 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_24 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_24

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_24 and arg_36_1.time_ < var_39_17 + var_39_24 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play304012010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304012010
		arg_40_1.duration_ = 10.83

		local var_40_0 = {
			zh = 5.7,
			ja = 10.833
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
				arg_40_0:Play304012011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "3008ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_40_1.stage_.transform)

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

			local var_43_5 = arg_40_1.actors_["3008ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_5.localPosition
			end

			local var_43_7 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7
				local var_43_9 = Vector3.New(0, -1.51, -4.3)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_5.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_5.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_5.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_5.localEulerAngles = var_43_13
			end

			local var_43_14 = arg_40_1.actors_["3008ui_story"]
			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 and not isNil(var_43_14) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = var_43_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_16 = 0.200000002980232

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_16 and not isNil(var_43_14) then
				local var_43_17 = (arg_40_1.time_ - var_43_15) / var_43_16

				if arg_40_1.var_.characterEffect3008ui_story and not isNil(var_43_14) then
					arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 and not isNil(var_43_14) and arg_40_1.var_.characterEffect3008ui_story then
				arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_43_18 = 0

			if var_43_18 < arg_40_1.time_ and arg_40_1.time_ <= var_43_18 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_43_19 = 0

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_43_20 = 0
			local var_43_21 = 0.825

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_22 = arg_40_1:FormatText(StoryNameCfg[20].name)

				arg_40_1.leftNameTxt_.text = var_43_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_23 = arg_40_1:GetWordFromCfg(304012010)
				local var_43_24 = arg_40_1:FormatText(var_43_23.content)

				arg_40_1.text_.text = var_43_24

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_25 = 33
				local var_43_26 = utf8.len(var_43_24)
				local var_43_27 = var_43_25 <= 0 and var_43_21 or var_43_21 * (var_43_26 / var_43_25)

				if var_43_27 > 0 and var_43_21 < var_43_27 then
					arg_40_1.talkMaxDuration = var_43_27

					if var_43_27 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_27 + var_43_20
					end
				end

				arg_40_1.text_.text = var_43_24
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012010", "story_v_out_304012.awb") ~= 0 then
					local var_43_28 = manager.audio:GetVoiceLength("story_v_out_304012", "304012010", "story_v_out_304012.awb") / 1000

					if var_43_28 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_20
					end

					if var_43_23.prefab_name ~= "" and arg_40_1.actors_[var_43_23.prefab_name] ~= nil then
						local var_43_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_23.prefab_name].transform, "story_v_out_304012", "304012010", "story_v_out_304012.awb")

						arg_40_1:RecordAudio("304012010", var_43_29)
						arg_40_1:RecordAudio("304012010", var_43_29)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304012", "304012010", "story_v_out_304012.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304012", "304012010", "story_v_out_304012.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_30 = math.max(var_43_21, arg_40_1.talkMaxDuration)

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_30 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_20) / var_43_30

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_20 + var_43_30 and arg_40_1.time_ < var_43_20 + var_43_30 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play304012011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304012011
		arg_44_1.duration_ = 5.33

		local var_44_0 = {
			zh = 4.7,
			ja = 5.333
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
				arg_44_0:Play304012012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1035ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1035ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1035ui_story == nil then
				arg_44_1.var_.characterEffect1035ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.200000002980232

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1035ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1035ui_story then
				arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["3008ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect3008ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_44_1.var_.characterEffect3008ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect3008ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_44_1.var_.characterEffect3008ui_story.fillRatio = var_47_14
			end

			local var_47_15 = 0
			local var_47_16 = 0.425

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[36].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_18 = arg_44_1:GetWordFromCfg(304012011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 17
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012011", "story_v_out_304012.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_304012", "304012011", "story_v_out_304012.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_304012", "304012011", "story_v_out_304012.awb")

						arg_44_1:RecordAudio("304012011", var_47_24)
						arg_44_1:RecordAudio("304012011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304012", "304012011", "story_v_out_304012.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304012", "304012011", "story_v_out_304012.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304012012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304012012
		arg_48_1.duration_ = 9.33

		local var_48_0 = {
			zh = 6.266,
			ja = 9.333
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
				arg_48_0:Play304012013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["3008ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1035ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1035ui_story == nil then
				arg_48_1.var_.characterEffect1035ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1035ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1035ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1035ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1035ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action427")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_12 = 0
			local var_51_13 = 0.8

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[20].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(304012012)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 32
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012012", "story_v_out_304012.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012012", "story_v_out_304012.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_304012", "304012012", "story_v_out_304012.awb")

						arg_48_1:RecordAudio("304012012", var_51_21)
						arg_48_1:RecordAudio("304012012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304012", "304012012", "story_v_out_304012.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304012", "304012012", "story_v_out_304012.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304012013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304012013
		arg_52_1.duration_ = 7.57

		local var_52_0 = {
			zh = 4.966,
			ja = 7.566
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
				arg_52_0:Play304012014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1035ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1035ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(-0.7, -1.05, -5.6)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1035ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.7, -1.05, -5.6)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["3008ui_story"].transform
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.var_.moveOldPos3008ui_story = var_55_9.localPosition
			end

			local var_55_11 = 0.001

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11
				local var_55_13 = Vector3.New(0.7, -1.51, -4.3)

				var_55_9.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3008ui_story, var_55_13, var_55_12)

				local var_55_14 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_14.x, var_55_14.y, var_55_14.z)

				local var_55_15 = var_55_9.localEulerAngles

				var_55_15.z = 0
				var_55_15.x = 0
				var_55_9.localEulerAngles = var_55_15
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 then
				var_55_9.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_55_16 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_16.x, var_55_16.y, var_55_16.z)

				local var_55_17 = var_55_9.localEulerAngles

				var_55_17.z = 0
				var_55_17.x = 0
				var_55_9.localEulerAngles = var_55_17
			end

			local var_55_18 = arg_52_1.actors_["1035ui_story"]
			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 and not isNil(var_55_18) and arg_52_1.var_.characterEffect1035ui_story == nil then
				arg_52_1.var_.characterEffect1035ui_story = var_55_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_20 = 0.200000002980232

			if var_55_19 <= arg_52_1.time_ and arg_52_1.time_ < var_55_19 + var_55_20 and not isNil(var_55_18) then
				local var_55_21 = (arg_52_1.time_ - var_55_19) / var_55_20

				if arg_52_1.var_.characterEffect1035ui_story and not isNil(var_55_18) then
					arg_52_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_19 + var_55_20 and arg_52_1.time_ < var_55_19 + var_55_20 + arg_55_0 and not isNil(var_55_18) and arg_52_1.var_.characterEffect1035ui_story then
				arg_52_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_55_22 = arg_52_1.actors_["3008ui_story"]
			local var_55_23 = 0

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 and not isNil(var_55_22) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = var_55_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_24 = 0.200000002980232

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 and not isNil(var_55_22) then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24

				if arg_52_1.var_.characterEffect3008ui_story and not isNil(var_55_22) then
					local var_55_26 = Mathf.Lerp(0, 0.5, var_55_25)

					arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_26
				end
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 and not isNil(var_55_22) and arg_52_1.var_.characterEffect3008ui_story then
				local var_55_27 = 0.5

				arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_27
			end

			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_1")
			end

			local var_55_29 = 0

			if var_55_29 < arg_52_1.time_ and arg_52_1.time_ <= var_55_29 + arg_55_0 then
				arg_52_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_30 = 0
			local var_55_31 = 0.675

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_32 = arg_52_1:FormatText(StoryNameCfg[21].name)

				arg_52_1.leftNameTxt_.text = var_55_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_33 = arg_52_1:GetWordFromCfg(304012013)
				local var_55_34 = arg_52_1:FormatText(var_55_33.content)

				arg_52_1.text_.text = var_55_34

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_35 = 27
				local var_55_36 = utf8.len(var_55_34)
				local var_55_37 = var_55_35 <= 0 and var_55_31 or var_55_31 * (var_55_36 / var_55_35)

				if var_55_37 > 0 and var_55_31 < var_55_37 then
					arg_52_1.talkMaxDuration = var_55_37

					if var_55_37 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_37 + var_55_30
					end
				end

				arg_52_1.text_.text = var_55_34
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012013", "story_v_out_304012.awb") ~= 0 then
					local var_55_38 = manager.audio:GetVoiceLength("story_v_out_304012", "304012013", "story_v_out_304012.awb") / 1000

					if var_55_38 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_38 + var_55_30
					end

					if var_55_33.prefab_name ~= "" and arg_52_1.actors_[var_55_33.prefab_name] ~= nil then
						local var_55_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_33.prefab_name].transform, "story_v_out_304012", "304012013", "story_v_out_304012.awb")

						arg_52_1:RecordAudio("304012013", var_55_39)
						arg_52_1:RecordAudio("304012013", var_55_39)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304012", "304012013", "story_v_out_304012.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304012", "304012013", "story_v_out_304012.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_40 = math.max(var_55_31, arg_52_1.talkMaxDuration)

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_40 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_30) / var_55_40

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_30 + var_55_40 and arg_52_1.time_ < var_55_30 + var_55_40 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play304012014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304012014
		arg_56_1.duration_ = 8.13

		local var_56_0 = {
			zh = 5.733,
			ja = 8.133
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play304012015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["3008ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3008ui_story == nil then
				arg_56_1.var_.characterEffect3008ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect3008ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3008ui_story then
				arg_56_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1035ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1035ui_story == nil then
				arg_56_1.var_.characterEffect1035ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1035ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1035ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1035ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1035ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.7

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[20].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(304012014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 28
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012014", "story_v_out_304012.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012014", "story_v_out_304012.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_304012", "304012014", "story_v_out_304012.awb")

						arg_56_1:RecordAudio("304012014", var_59_19)
						arg_56_1:RecordAudio("304012014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304012", "304012014", "story_v_out_304012.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304012", "304012014", "story_v_out_304012.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play304012015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304012015
		arg_60_1.duration_ = 8.93

		local var_60_0 = {
			zh = 5.5,
			ja = 8.933
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
				arg_60_0:Play304012016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1035ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1035ui_story == nil then
				arg_60_1.var_.characterEffect1035ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1035ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1035ui_story then
				arg_60_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["3008ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect3008ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_60_1.var_.characterEffect3008ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect3008ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_60_1.var_.characterEffect3008ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action434")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.7

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[21].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(304012015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 28
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012015", "story_v_out_304012.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012015", "story_v_out_304012.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_304012", "304012015", "story_v_out_304012.awb")

						arg_60_1:RecordAudio("304012015", var_63_21)
						arg_60_1:RecordAudio("304012015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304012", "304012015", "story_v_out_304012.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304012", "304012015", "story_v_out_304012.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304012016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304012016
		arg_64_1.duration_ = 6.33

		local var_64_0 = {
			zh = 5.033,
			ja = 6.333
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304012017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["3008ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect3008ui_story == nil then
				arg_64_1.var_.characterEffect3008ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect3008ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect3008ui_story then
				arg_64_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1035ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1035ui_story == nil then
				arg_64_1.var_.characterEffect1035ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1035ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1035ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1035ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1035ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action476")
			end

			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_12 = 0
			local var_67_13 = 0.6

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_14 = arg_64_1:FormatText(StoryNameCfg[20].name)

				arg_64_1.leftNameTxt_.text = var_67_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_15 = arg_64_1:GetWordFromCfg(304012016)
				local var_67_16 = arg_64_1:FormatText(var_67_15.content)

				arg_64_1.text_.text = var_67_16

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 24
				local var_67_18 = utf8.len(var_67_16)
				local var_67_19 = var_67_17 <= 0 and var_67_13 or var_67_13 * (var_67_18 / var_67_17)

				if var_67_19 > 0 and var_67_13 < var_67_19 then
					arg_64_1.talkMaxDuration = var_67_19

					if var_67_19 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_16
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012016", "story_v_out_304012.awb") ~= 0 then
					local var_67_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012016", "story_v_out_304012.awb") / 1000

					if var_67_20 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_20 + var_67_12
					end

					if var_67_15.prefab_name ~= "" and arg_64_1.actors_[var_67_15.prefab_name] ~= nil then
						local var_67_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_15.prefab_name].transform, "story_v_out_304012", "304012016", "story_v_out_304012.awb")

						arg_64_1:RecordAudio("304012016", var_67_21)
						arg_64_1:RecordAudio("304012016", var_67_21)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304012", "304012016", "story_v_out_304012.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304012", "304012016", "story_v_out_304012.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_22 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_22 and arg_64_1.time_ < var_67_12 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304012017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304012017
		arg_68_1.duration_ = 10.23

		local var_68_0 = {
			zh = 8.633,
			ja = 10.233
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
				arg_68_0:Play304012018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["2020_tpose"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos2020_tpose = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(-0.7, -1.2, -4.1)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos2020_tpose, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["1035ui_story"].transform
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.var_.moveOldPos1035ui_story = var_71_11.localPosition
			end

			local var_71_13 = 0.001

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_13 then
				local var_71_14 = (arg_68_1.time_ - var_71_12) / var_71_13
				local var_71_15 = Vector3.New(0, 100, 0)

				var_71_11.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1035ui_story, var_71_15, var_71_14)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_11.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_11.localEulerAngles = var_71_17
			end

			if arg_68_1.time_ >= var_71_12 + var_71_13 and arg_68_1.time_ < var_71_12 + var_71_13 + arg_71_0 then
				var_71_11.localPosition = Vector3.New(0, 100, 0)

				local var_71_18 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_18.x, var_71_18.y, var_71_18.z)

				local var_71_19 = var_71_11.localEulerAngles

				var_71_19.z = 0
				var_71_19.x = 0
				var_71_11.localEulerAngles = var_71_19
			end

			local var_71_20 = arg_68_1.actors_["2020_tpose"]
			local var_71_21 = 0

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 and not isNil(var_71_20) and arg_68_1.var_.characterEffect2020_tpose == nil then
				arg_68_1.var_.characterEffect2020_tpose = var_71_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_22 = 0.200000002980232

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_22 and not isNil(var_71_20) then
				local var_71_23 = (arg_68_1.time_ - var_71_21) / var_71_22

				if arg_68_1.var_.characterEffect2020_tpose and not isNil(var_71_20) then
					arg_68_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_21 + var_71_22 and arg_68_1.time_ < var_71_21 + var_71_22 + arg_71_0 and not isNil(var_71_20) and arg_68_1.var_.characterEffect2020_tpose then
				arg_68_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_71_24 = arg_68_1.actors_["3008ui_story"]
			local var_71_25 = 0

			if var_71_25 < arg_68_1.time_ and arg_68_1.time_ <= var_71_25 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect3008ui_story == nil then
				arg_68_1.var_.characterEffect3008ui_story = var_71_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_26 = 0.200000002980232

			if var_71_25 <= arg_68_1.time_ and arg_68_1.time_ < var_71_25 + var_71_26 and not isNil(var_71_24) then
				local var_71_27 = (arg_68_1.time_ - var_71_25) / var_71_26

				if arg_68_1.var_.characterEffect3008ui_story and not isNil(var_71_24) then
					local var_71_28 = Mathf.Lerp(0, 0.5, var_71_27)

					arg_68_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_68_1.var_.characterEffect3008ui_story.fillRatio = var_71_28
				end
			end

			if arg_68_1.time_ >= var_71_25 + var_71_26 and arg_68_1.time_ < var_71_25 + var_71_26 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect3008ui_story then
				local var_71_29 = 0.5

				arg_68_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_68_1.var_.characterEffect3008ui_story.fillRatio = var_71_29
			end

			local var_71_30 = 0

			if var_71_30 < arg_68_1.time_ and arg_68_1.time_ <= var_71_30 + arg_71_0 then
				arg_68_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_71_31 = 0
			local var_71_32 = 0.95

			if var_71_31 < arg_68_1.time_ and arg_68_1.time_ <= var_71_31 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_33 = arg_68_1:FormatText(StoryNameCfg[19].name)

				arg_68_1.leftNameTxt_.text = var_71_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_34 = arg_68_1:GetWordFromCfg(304012017)
				local var_71_35 = arg_68_1:FormatText(var_71_34.content)

				arg_68_1.text_.text = var_71_35

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_36 = 38
				local var_71_37 = utf8.len(var_71_35)
				local var_71_38 = var_71_36 <= 0 and var_71_32 or var_71_32 * (var_71_37 / var_71_36)

				if var_71_38 > 0 and var_71_32 < var_71_38 then
					arg_68_1.talkMaxDuration = var_71_38

					if var_71_38 + var_71_31 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_38 + var_71_31
					end
				end

				arg_68_1.text_.text = var_71_35
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012017", "story_v_out_304012.awb") ~= 0 then
					local var_71_39 = manager.audio:GetVoiceLength("story_v_out_304012", "304012017", "story_v_out_304012.awb") / 1000

					if var_71_39 + var_71_31 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_39 + var_71_31
					end

					if var_71_34.prefab_name ~= "" and arg_68_1.actors_[var_71_34.prefab_name] ~= nil then
						local var_71_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_34.prefab_name].transform, "story_v_out_304012", "304012017", "story_v_out_304012.awb")

						arg_68_1:RecordAudio("304012017", var_71_40)
						arg_68_1:RecordAudio("304012017", var_71_40)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304012", "304012017", "story_v_out_304012.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304012", "304012017", "story_v_out_304012.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_41 = math.max(var_71_32, arg_68_1.talkMaxDuration)

			if var_71_31 <= arg_68_1.time_ and arg_68_1.time_ < var_71_31 + var_71_41 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_31) / var_71_41

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_31 + var_71_41 and arg_68_1.time_ < var_71_31 + var_71_41 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play304012018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304012018
		arg_72_1.duration_ = 4.9

		local var_72_0 = {
			zh = 2.266,
			ja = 4.9
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
				arg_72_0:Play304012019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["3008ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3008ui_story == nil then
				arg_72_1.var_.characterEffect3008ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect3008ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect3008ui_story then
				arg_72_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["2020_tpose"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect2020_tpose == nil then
				arg_72_1.var_.characterEffect2020_tpose = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect2020_tpose and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_72_1.var_.characterEffect2020_tpose.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect2020_tpose then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_72_1.var_.characterEffect2020_tpose.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_12 = 0
			local var_75_13 = 0.2

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[20].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(304012018)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012018", "story_v_out_304012.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012018", "story_v_out_304012.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_304012", "304012018", "story_v_out_304012.awb")

						arg_72_1:RecordAudio("304012018", var_75_21)
						arg_72_1:RecordAudio("304012018", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304012", "304012018", "story_v_out_304012.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304012", "304012018", "story_v_out_304012.awb")
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
	Play304012019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304012019
		arg_76_1.duration_ = 9.17

		local var_76_0 = {
			zh = 9.166,
			ja = 8.666
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play304012020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["2020_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2020_tpose == nil then
				arg_76_1.var_.characterEffect2020_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect2020_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2020_tpose then
				arg_76_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["3008ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect3008ui_story == nil then
				arg_76_1.var_.characterEffect3008ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.200000002980232

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect3008ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_76_1.var_.characterEffect3008ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect3008ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_76_1.var_.characterEffect3008ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 1

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_12 = arg_76_1:FormatText(StoryNameCfg[19].name)

				arg_76_1.leftNameTxt_.text = var_79_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_13 = arg_76_1:GetWordFromCfg(304012019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 40
				local var_79_16 = utf8.len(var_79_14)
				local var_79_17 = var_79_15 <= 0 and var_79_11 or var_79_11 * (var_79_16 / var_79_15)

				if var_79_17 > 0 and var_79_11 < var_79_17 then
					arg_76_1.talkMaxDuration = var_79_17

					if var_79_17 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012019", "story_v_out_304012.awb") ~= 0 then
					local var_79_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012019", "story_v_out_304012.awb") / 1000

					if var_79_18 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_10
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_304012", "304012019", "story_v_out_304012.awb")

						arg_76_1:RecordAudio("304012019", var_79_19)
						arg_76_1:RecordAudio("304012019", var_79_19)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304012", "304012019", "story_v_out_304012.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304012", "304012019", "story_v_out_304012.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_20 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_20 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_20

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_20 and arg_76_1.time_ < var_79_10 + var_79_20 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304012020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304012020
		arg_80_1.duration_ = 4.23

		local var_80_0 = {
			zh = 2.366,
			ja = 4.233
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
				arg_80_0:Play304012021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["3008ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3008ui_story == nil then
				arg_80_1.var_.characterEffect3008ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect3008ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3008ui_story then
				arg_80_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["2020_tpose"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2020_tpose == nil then
				arg_80_1.var_.characterEffect2020_tpose = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect2020_tpose and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_80_1.var_.characterEffect2020_tpose.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2020_tpose then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_80_1.var_.characterEffect2020_tpose.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_83_12 = 0
			local var_83_13 = 0.25

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_14 = arg_80_1:FormatText(StoryNameCfg[20].name)

				arg_80_1.leftNameTxt_.text = var_83_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(304012020)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 10
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_13 or var_83_13 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_13 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012020", "story_v_out_304012.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012020", "story_v_out_304012.awb") / 1000

					if var_83_20 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_12
					end

					if var_83_15.prefab_name ~= "" and arg_80_1.actors_[var_83_15.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_15.prefab_name].transform, "story_v_out_304012", "304012020", "story_v_out_304012.awb")

						arg_80_1:RecordAudio("304012020", var_83_21)
						arg_80_1:RecordAudio("304012020", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304012", "304012020", "story_v_out_304012.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304012", "304012020", "story_v_out_304012.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_22 and arg_80_1.time_ < var_83_12 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play304012021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304012021
		arg_84_1.duration_ = 8.33

		local var_84_0 = {
			zh = 8.333,
			ja = 4.466
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
				arg_84_0:Play304012022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["2020_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect2020_tpose == nil then
				arg_84_1.var_.characterEffect2020_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect2020_tpose and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect2020_tpose then
				arg_84_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["3008ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect3008ui_story == nil then
				arg_84_1.var_.characterEffect3008ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect3008ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_84_1.var_.characterEffect3008ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect3008ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_84_1.var_.characterEffect3008ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0
			local var_87_11 = 0.75

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_12 = arg_84_1:FormatText(StoryNameCfg[19].name)

				arg_84_1.leftNameTxt_.text = var_87_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_13 = arg_84_1:GetWordFromCfg(304012021)
				local var_87_14 = arg_84_1:FormatText(var_87_13.content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 30
				local var_87_16 = utf8.len(var_87_14)
				local var_87_17 = var_87_15 <= 0 and var_87_11 or var_87_11 * (var_87_16 / var_87_15)

				if var_87_17 > 0 and var_87_11 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012021", "story_v_out_304012.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012021", "story_v_out_304012.awb") / 1000

					if var_87_18 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_10
					end

					if var_87_13.prefab_name ~= "" and arg_84_1.actors_[var_87_13.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_13.prefab_name].transform, "story_v_out_304012", "304012021", "story_v_out_304012.awb")

						arg_84_1:RecordAudio("304012021", var_87_19)
						arg_84_1:RecordAudio("304012021", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_304012", "304012021", "story_v_out_304012.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_304012", "304012021", "story_v_out_304012.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_20 and arg_84_1.time_ < var_87_10 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play304012022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304012022
		arg_88_1.duration_ = 2.4

		local var_88_0 = {
			zh = 2.4,
			ja = 2.366
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play304012023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.225

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[19].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(304012022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 9
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012022", "story_v_out_304012.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012022", "story_v_out_304012.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_304012", "304012022", "story_v_out_304012.awb")

						arg_88_1:RecordAudio("304012022", var_91_9)
						arg_88_1:RecordAudio("304012022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_304012", "304012022", "story_v_out_304012.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_304012", "304012022", "story_v_out_304012.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play304012023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 304012023
		arg_92_1.duration_ = 6.9

		local var_92_0 = {
			zh = 6.733,
			ja = 6.9
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
				arg_92_0:Play304012024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["3008ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3008ui_story == nil then
				arg_92_1.var_.characterEffect3008ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect3008ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3008ui_story then
				arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["2020_tpose"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect2020_tpose == nil then
				arg_92_1.var_.characterEffect2020_tpose = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect2020_tpose and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_92_1.var_.characterEffect2020_tpose.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect2020_tpose then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_92_1.var_.characterEffect2020_tpose.fillRatio = var_95_9
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_95_11 = 0
			local var_95_12 = 0.925

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_13 = arg_92_1:FormatText(StoryNameCfg[20].name)

				arg_92_1.leftNameTxt_.text = var_95_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(304012023)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_16 = 37
				local var_95_17 = utf8.len(var_95_15)
				local var_95_18 = var_95_16 <= 0 and var_95_12 or var_95_12 * (var_95_17 / var_95_16)

				if var_95_18 > 0 and var_95_12 < var_95_18 then
					arg_92_1.talkMaxDuration = var_95_18

					if var_95_18 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_11
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012023", "story_v_out_304012.awb") ~= 0 then
					local var_95_19 = manager.audio:GetVoiceLength("story_v_out_304012", "304012023", "story_v_out_304012.awb") / 1000

					if var_95_19 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_11
					end

					if var_95_14.prefab_name ~= "" and arg_92_1.actors_[var_95_14.prefab_name] ~= nil then
						local var_95_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_14.prefab_name].transform, "story_v_out_304012", "304012023", "story_v_out_304012.awb")

						arg_92_1:RecordAudio("304012023", var_95_20)
						arg_92_1:RecordAudio("304012023", var_95_20)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_304012", "304012023", "story_v_out_304012.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_304012", "304012023", "story_v_out_304012.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_21 = math.max(var_95_12, arg_92_1.talkMaxDuration)

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_21 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_11) / var_95_21

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_11 + var_95_21 and arg_92_1.time_ < var_95_11 + var_95_21 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play304012024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304012024
		arg_96_1.duration_ = 5.8

		local var_96_0 = {
			zh = 5.8,
			ja = 4.933
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
				arg_96_0:Play304012025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.475

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[20].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(304012024)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 19
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012024", "story_v_out_304012.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012024", "story_v_out_304012.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_304012", "304012024", "story_v_out_304012.awb")

						arg_96_1:RecordAudio("304012024", var_99_9)
						arg_96_1:RecordAudio("304012024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_304012", "304012024", "story_v_out_304012.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_304012", "304012024", "story_v_out_304012.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play304012025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304012025
		arg_100_1.duration_ = 5.07

		local var_100_0 = {
			zh = 5.066,
			ja = 4.033
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
				arg_100_0:Play304012026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 1

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				local var_103_4 = "play"
				local var_103_5 = "effect"

				arg_100_1:AudioAction(var_103_4, var_103_5, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_103_6 = 0
			local var_103_7 = 0.8

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[20].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(304012025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012025", "story_v_out_304012.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_304012", "304012025", "story_v_out_304012.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_304012", "304012025", "story_v_out_304012.awb")

						arg_100_1:RecordAudio("304012025", var_103_15)
						arg_100_1:RecordAudio("304012025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_304012", "304012025", "story_v_out_304012.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_304012", "304012025", "story_v_out_304012.awb")
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
	Play304012026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304012026
		arg_104_1.duration_ = 4.9

		local var_104_0 = {
			zh = 4.26633333333333,
			ja = 4.89933333333333
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
				arg_104_0:Play304012027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "ST10"

			if arg_104_1.bgs_[var_107_0] == nil then
				local var_107_1 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_107_0)
				var_107_1.name = var_107_0
				var_107_1.transform.parent = arg_104_1.stage_.transform
				var_107_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_[var_107_0] = var_107_1
			end

			local var_107_2 = 1.4

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				local var_107_3 = manager.ui.mainCamera.transform.localPosition
				local var_107_4 = Vector3.New(0, 0, 10) + Vector3.New(var_107_3.x, var_107_3.y, 0)
				local var_107_5 = arg_104_1.bgs_.ST10

				var_107_5.transform.localPosition = var_107_4
				var_107_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_6 = var_107_5:GetComponent("SpriteRenderer")

				if var_107_6 and var_107_6.sprite then
					local var_107_7 = (var_107_5.transform.localPosition - var_107_3).z
					local var_107_8 = manager.ui.mainCameraCom_
					local var_107_9 = 2 * var_107_7 * Mathf.Tan(var_107_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_107_10 = var_107_9 * var_107_8.aspect
					local var_107_11 = var_107_6.sprite.bounds.size.x
					local var_107_12 = var_107_6.sprite.bounds.size.y
					local var_107_13 = var_107_10 / var_107_11
					local var_107_14 = var_107_9 / var_107_12
					local var_107_15 = var_107_14 < var_107_13 and var_107_13 or var_107_14

					var_107_5.transform.localScale = Vector3.New(var_107_15, var_107_15, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "ST10" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_16 = 1.4

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			local var_107_17 = 0.3

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			local var_107_18 = 0

			if var_107_18 < arg_104_1.time_ and arg_104_1.time_ <= var_107_18 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_19 = 1.4

			if var_107_18 <= arg_104_1.time_ and arg_104_1.time_ < var_107_18 + var_107_19 then
				local var_107_20 = (arg_104_1.time_ - var_107_18) / var_107_19
				local var_107_21 = Color.New(0, 0, 0)

				var_107_21.a = Mathf.Lerp(0, 1, var_107_20)
				arg_104_1.mask_.color = var_107_21
			end

			if arg_104_1.time_ >= var_107_18 + var_107_19 and arg_104_1.time_ < var_107_18 + var_107_19 + arg_107_0 then
				local var_107_22 = Color.New(0, 0, 0)

				var_107_22.a = 1
				arg_104_1.mask_.color = var_107_22
			end

			local var_107_23 = 1.4

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_24 = 2

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 then
				local var_107_25 = (arg_104_1.time_ - var_107_23) / var_107_24
				local var_107_26 = Color.New(0, 0, 0)

				var_107_26.a = Mathf.Lerp(1, 0, var_107_25)
				arg_104_1.mask_.color = var_107_26
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 then
				local var_107_27 = Color.New(0, 0, 0)
				local var_107_28 = 0

				arg_104_1.mask_.enabled = false
				var_107_27.a = var_107_28
				arg_104_1.mask_.color = var_107_27
			end

			local var_107_29 = arg_104_1.actors_["2020_tpose"].transform
			local var_107_30 = 1.4

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.var_.moveOldPos2020_tpose = var_107_29.localPosition

				local var_107_31 = GameObjectTools.GetOrAddComponent(var_107_29.gameObject, typeof(DynamicBoneHelper))

				if var_107_31 then
					var_107_31:EnableDynamicBone(false)
				end
			end

			local var_107_32 = 0.001

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_32 then
				local var_107_33 = (arg_104_1.time_ - var_107_30) / var_107_32
				local var_107_34 = Vector3.New(0, 100, 0)

				var_107_29.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos2020_tpose, var_107_34, var_107_33)

				local var_107_35 = manager.ui.mainCamera.transform.position - var_107_29.position

				var_107_29.forward = Vector3.New(var_107_35.x, var_107_35.y, var_107_35.z)

				local var_107_36 = var_107_29.localEulerAngles

				var_107_36.z = 0
				var_107_36.x = 0
				var_107_29.localEulerAngles = var_107_36
			end

			if arg_104_1.time_ >= var_107_30 + var_107_32 and arg_104_1.time_ < var_107_30 + var_107_32 + arg_107_0 then
				var_107_29.localPosition = Vector3.New(0, 100, 0)

				local var_107_37 = manager.ui.mainCamera.transform.position - var_107_29.position

				var_107_29.forward = Vector3.New(var_107_37.x, var_107_37.y, var_107_37.z)

				local var_107_38 = var_107_29.localEulerAngles

				var_107_38.z = 0
				var_107_38.x = 0
				var_107_29.localEulerAngles = var_107_38

				local var_107_39 = GameObjectTools.GetOrAddComponent(var_107_29.gameObject, typeof(DynamicBoneHelper))

				if var_107_39 then
					var_107_39:EnableDynamicBone(true)
				end
			end

			local var_107_40 = arg_104_1.actors_["3008ui_story"].transform
			local var_107_41 = 1.4

			if var_107_41 < arg_104_1.time_ and arg_104_1.time_ <= var_107_41 + arg_107_0 then
				arg_104_1.var_.moveOldPos3008ui_story = var_107_40.localPosition
			end

			local var_107_42 = 0.001

			if var_107_41 <= arg_104_1.time_ and arg_104_1.time_ < var_107_41 + var_107_42 then
				local var_107_43 = (arg_104_1.time_ - var_107_41) / var_107_42
				local var_107_44 = Vector3.New(0, 100, 0)

				var_107_40.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3008ui_story, var_107_44, var_107_43)

				local var_107_45 = manager.ui.mainCamera.transform.position - var_107_40.position

				var_107_40.forward = Vector3.New(var_107_45.x, var_107_45.y, var_107_45.z)

				local var_107_46 = var_107_40.localEulerAngles

				var_107_46.z = 0
				var_107_46.x = 0
				var_107_40.localEulerAngles = var_107_46
			end

			if arg_104_1.time_ >= var_107_41 + var_107_42 and arg_104_1.time_ < var_107_41 + var_107_42 + arg_107_0 then
				var_107_40.localPosition = Vector3.New(0, 100, 0)

				local var_107_47 = manager.ui.mainCamera.transform.position - var_107_40.position

				var_107_40.forward = Vector3.New(var_107_47.x, var_107_47.y, var_107_47.z)

				local var_107_48 = var_107_40.localEulerAngles

				var_107_48.z = 0
				var_107_48.x = 0
				var_107_40.localEulerAngles = var_107_48
			end

			local var_107_49 = "1019ui_story"

			if arg_104_1.actors_[var_107_49] == nil then
				local var_107_50 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_107_50) then
					local var_107_51 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_104_1.stage_.transform)

					var_107_51.name = var_107_49
					var_107_51.transform.localPosition = Vector3.New(0, 100, 0)
					arg_104_1.actors_[var_107_49] = var_107_51

					local var_107_52 = var_107_51:GetComponentInChildren(typeof(CharacterEffect))

					var_107_52.enabled = true

					local var_107_53 = GameObjectTools.GetOrAddComponent(var_107_51, typeof(DynamicBoneHelper))

					if var_107_53 then
						var_107_53:EnableDynamicBone(false)
					end

					arg_104_1:ShowWeapon(var_107_52.transform, false)

					arg_104_1.var_[var_107_49 .. "Animator"] = var_107_52.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_104_1.var_[var_107_49 .. "Animator"].applyRootMotion = true
					arg_104_1.var_[var_107_49 .. "LipSync"] = var_107_52.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_107_54 = arg_104_1.actors_["1019ui_story"]
			local var_107_55 = 1.4

			if var_107_55 < arg_104_1.time_ and arg_104_1.time_ <= var_107_55 + arg_107_0 and not isNil(var_107_54) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_56 = 0.200000002980232

			if var_107_55 <= arg_104_1.time_ and arg_104_1.time_ < var_107_55 + var_107_56 and not isNil(var_107_54) then
				local var_107_57 = (arg_104_1.time_ - var_107_55) / var_107_56

				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_54) then
					arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_55 + var_107_56 and arg_104_1.time_ < var_107_55 + var_107_56 + arg_107_0 and not isNil(var_107_54) and arg_104_1.var_.characterEffect1019ui_story then
				arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_107_58 = arg_104_1.actors_["3008ui_story"]
			local var_107_59 = 1.4

			if var_107_59 < arg_104_1.time_ and arg_104_1.time_ <= var_107_59 + arg_107_0 and not isNil(var_107_58) and arg_104_1.var_.characterEffect3008ui_story == nil then
				arg_104_1.var_.characterEffect3008ui_story = var_107_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_60 = 0.200000002980232

			if var_107_59 <= arg_104_1.time_ and arg_104_1.time_ < var_107_59 + var_107_60 and not isNil(var_107_58) then
				local var_107_61 = (arg_104_1.time_ - var_107_59) / var_107_60

				if arg_104_1.var_.characterEffect3008ui_story and not isNil(var_107_58) then
					local var_107_62 = Mathf.Lerp(0, 0.5, var_107_61)

					arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_104_1.var_.characterEffect3008ui_story.fillRatio = var_107_62
				end
			end

			if arg_104_1.time_ >= var_107_59 + var_107_60 and arg_104_1.time_ < var_107_59 + var_107_60 + arg_107_0 and not isNil(var_107_58) and arg_104_1.var_.characterEffect3008ui_story then
				local var_107_63 = 0.5

				arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_104_1.var_.characterEffect3008ui_story.fillRatio = var_107_63
			end

			local var_107_64 = 1.2
			local var_107_65 = 1

			if var_107_64 < arg_104_1.time_ and arg_104_1.time_ <= var_107_64 + arg_107_0 then
				local var_107_66 = "play"
				local var_107_67 = "effect"

				arg_104_1:AudioAction(var_107_66, var_107_67, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_107_68 = 0.2
			local var_107_69 = 1

			if var_107_68 < arg_104_1.time_ and arg_104_1.time_ <= var_107_68 + arg_107_0 then
				local var_107_70 = "stop"
				local var_107_71 = "effect"

				arg_104_1:AudioAction(var_107_70, var_107_71, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_107_72 = 1
			local var_107_73 = 1

			if var_107_72 < arg_104_1.time_ and arg_104_1.time_ <= var_107_72 + arg_107_0 then
				local var_107_74 = "play"
				local var_107_75 = "music"

				arg_104_1:AudioAction(var_107_74, var_107_75, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_107_76 = ""
				local var_107_77 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if var_107_77 ~= "" then
					if arg_104_1.bgmTxt_.text ~= var_107_77 and arg_104_1.bgmTxt_.text ~= "" then
						if arg_104_1.bgmTxt2_.text ~= "" then
							arg_104_1.bgmTxt_.text = arg_104_1.bgmTxt2_.text
						end

						arg_104_1.bgmTxt2_.text = var_107_77

						arg_104_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_104_1.bgmTxt_.text = var_107_77
						arg_104_1.bgmTxt2_.text = var_107_77
					end

					if arg_104_1.bgmTimer then
						arg_104_1.bgmTimer:Stop()

						arg_104_1.bgmTimer = nil
					end

					if arg_104_1.settingData.show_music_name == 1 then
						arg_104_1.musicController:SetSelectedState("show")
						arg_104_1.musicAnimator_:Play("open", 0, 0)

						if arg_104_1.settingData.music_time ~= 0 then
							arg_104_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_104_1.settingData.music_time), function()
								if arg_104_1 == nil or isNil(arg_104_1.bgmTxt_) then
									return
								end

								arg_104_1.musicController:SetSelectedState("hide")
								arg_104_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_78 = 2.93333333333333
			local var_107_79 = 0.125

			if var_107_78 < arg_104_1.time_ and arg_104_1.time_ <= var_107_78 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_80 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_80:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_104_1.dialogCg_.alpha = arg_109_0
				end))
				var_107_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_81 = arg_104_1:FormatText(StoryNameCfg[13].name)

				arg_104_1.leftNameTxt_.text = var_107_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_82 = arg_104_1:GetWordFromCfg(304012026)
				local var_107_83 = arg_104_1:FormatText(var_107_82.content)

				arg_104_1.text_.text = var_107_83

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_84 = 5
				local var_107_85 = utf8.len(var_107_83)
				local var_107_86 = var_107_84 <= 0 and var_107_79 or var_107_79 * (var_107_85 / var_107_84)

				if var_107_86 > 0 and var_107_79 < var_107_86 then
					arg_104_1.talkMaxDuration = var_107_86
					var_107_78 = var_107_78 + 0.3

					if var_107_86 + var_107_78 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_86 + var_107_78
					end
				end

				arg_104_1.text_.text = var_107_83
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012026", "story_v_out_304012.awb") ~= 0 then
					local var_107_87 = manager.audio:GetVoiceLength("story_v_out_304012", "304012026", "story_v_out_304012.awb") / 1000

					if var_107_87 + var_107_78 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_87 + var_107_78
					end

					if var_107_82.prefab_name ~= "" and arg_104_1.actors_[var_107_82.prefab_name] ~= nil then
						local var_107_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_82.prefab_name].transform, "story_v_out_304012", "304012026", "story_v_out_304012.awb")

						arg_104_1:RecordAudio("304012026", var_107_88)
						arg_104_1:RecordAudio("304012026", var_107_88)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_304012", "304012026", "story_v_out_304012.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_304012", "304012026", "story_v_out_304012.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_89 = var_107_78 + 0.3
			local var_107_90 = math.max(var_107_79, arg_104_1.talkMaxDuration)

			if var_107_89 <= arg_104_1.time_ and arg_104_1.time_ < var_107_89 + var_107_90 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_89) / var_107_90

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_89 + var_107_90 and arg_104_1.time_ < var_107_89 + var_107_90 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play304012027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 304012027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play304012028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1019ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story == nil then
				arg_111_1.var_.characterEffect1019ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1019ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1019ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1019ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 1.25

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(304012027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 50
				local var_114_11 = utf8.len(var_114_9)
				local var_114_12 = var_114_10 <= 0 and var_114_7 or var_114_7 * (var_114_11 / var_114_10)

				if var_114_12 > 0 and var_114_7 < var_114_12 then
					arg_111_1.talkMaxDuration = var_114_12

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_13 and arg_111_1.time_ < var_114_6 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play304012028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 304012028
		arg_115_1.duration_ = 12.13

		local var_115_0 = {
			zh = 12.133,
			ja = 1.999999999999
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play304012029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "1066ui_story"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_115_1.stage_.transform)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentInChildren(typeof(CharacterEffect))

					var_118_3.enabled = true

					local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_2, typeof(DynamicBoneHelper))

					if var_118_4 then
						var_118_4:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_3.transform, false)

					arg_115_1.var_[var_118_0 .. "Animator"] = var_118_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_0 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_0 .. "LipSync"] = var_118_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_5 = arg_115_1.actors_["1066ui_story"].transform
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.var_.moveOldPos1066ui_story = var_118_5.localPosition
			end

			local var_118_7 = 0.001

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7
				local var_118_9 = Vector3.New(0, -0.77, -6.1)

				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1066ui_story, var_118_9, var_118_8)

				local var_118_10 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_10.x, var_118_10.y, var_118_10.z)

				local var_118_11 = var_118_5.localEulerAngles

				var_118_11.z = 0
				var_118_11.x = 0
				var_118_5.localEulerAngles = var_118_11
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_118_12 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_12.x, var_118_12.y, var_118_12.z)

				local var_118_13 = var_118_5.localEulerAngles

				var_118_13.z = 0
				var_118_13.x = 0
				var_118_5.localEulerAngles = var_118_13
			end

			local var_118_14 = arg_115_1.actors_["1066ui_story"]
			local var_118_15 = 0

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 and not isNil(var_118_14) and arg_115_1.var_.characterEffect1066ui_story == nil then
				arg_115_1.var_.characterEffect1066ui_story = var_118_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_16 = 0.200000002980232

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 and not isNil(var_118_14) then
				local var_118_17 = (arg_115_1.time_ - var_118_15) / var_118_16

				if arg_115_1.var_.characterEffect1066ui_story and not isNil(var_118_14) then
					arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 and not isNil(var_118_14) and arg_115_1.var_.characterEffect1066ui_story then
				arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_118_18 = 0

			if var_118_18 < arg_115_1.time_ and arg_115_1.time_ <= var_118_18 + arg_118_0 then
				arg_115_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_20 = 0
			local var_118_21 = 1.4

			if var_118_20 < arg_115_1.time_ and arg_115_1.time_ <= var_118_20 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_22 = arg_115_1:FormatText(StoryNameCfg[32].name)

				arg_115_1.leftNameTxt_.text = var_118_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_23 = arg_115_1:GetWordFromCfg(304012028)
				local var_118_24 = arg_115_1:FormatText(var_118_23.content)

				arg_115_1.text_.text = var_118_24

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_25 = 56
				local var_118_26 = utf8.len(var_118_24)
				local var_118_27 = var_118_25 <= 0 and var_118_21 or var_118_21 * (var_118_26 / var_118_25)

				if var_118_27 > 0 and var_118_21 < var_118_27 then
					arg_115_1.talkMaxDuration = var_118_27

					if var_118_27 + var_118_20 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_20
					end
				end

				arg_115_1.text_.text = var_118_24
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012028", "story_v_out_304012.awb") ~= 0 then
					local var_118_28 = manager.audio:GetVoiceLength("story_v_out_304012", "304012028", "story_v_out_304012.awb") / 1000

					if var_118_28 + var_118_20 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_28 + var_118_20
					end

					if var_118_23.prefab_name ~= "" and arg_115_1.actors_[var_118_23.prefab_name] ~= nil then
						local var_118_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_23.prefab_name].transform, "story_v_out_304012", "304012028", "story_v_out_304012.awb")

						arg_115_1:RecordAudio("304012028", var_118_29)
						arg_115_1:RecordAudio("304012028", var_118_29)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_304012", "304012028", "story_v_out_304012.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_304012", "304012028", "story_v_out_304012.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_30 = math.max(var_118_21, arg_115_1.talkMaxDuration)

			if var_118_20 <= arg_115_1.time_ and arg_115_1.time_ < var_118_20 + var_118_30 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_20) / var_118_30

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_20 + var_118_30 and arg_115_1.time_ < var_118_20 + var_118_30 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play304012029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 304012029
		arg_119_1.duration_ = 7.23

		local var_119_0 = {
			zh = 4.1,
			ja = 7.233
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play304012030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "1036ui_story"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_119_1.stage_.transform)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentInChildren(typeof(CharacterEffect))

					var_122_3.enabled = true

					local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_2, typeof(DynamicBoneHelper))

					if var_122_4 then
						var_122_4:EnableDynamicBone(false)
					end

					arg_119_1:ShowWeapon(var_122_3.transform, false)

					arg_119_1.var_[var_122_0 .. "Animator"] = var_122_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_119_1.var_[var_122_0 .. "Animator"].applyRootMotion = true
					arg_119_1.var_[var_122_0 .. "LipSync"] = var_122_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_122_5 = arg_119_1.actors_["1036ui_story"]
			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1036ui_story == nil then
				arg_119_1.var_.characterEffect1036ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_7 and not isNil(var_122_5) then
				local var_122_8 = (arg_119_1.time_ - var_122_6) / var_122_7

				if arg_119_1.var_.characterEffect1036ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_6 + var_122_7 and arg_119_1.time_ < var_122_6 + var_122_7 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1036ui_story then
				arg_119_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_122_9 = arg_119_1.actors_["1066ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1066ui_story == nil then
				arg_119_1.var_.characterEffect1066ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1066ui_story and not isNil(var_122_9) then
					local var_122_13 = Mathf.Lerp(0, 0.5, var_122_12)

					arg_119_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1066ui_story.fillRatio = var_122_13
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1066ui_story then
				local var_122_14 = 0.5

				arg_119_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1066ui_story.fillRatio = var_122_14
			end

			local var_122_15 = 0
			local var_122_16 = 0.5

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[36].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_18 = arg_119_1:GetWordFromCfg(304012029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 20
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012029", "story_v_out_304012.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_304012", "304012029", "story_v_out_304012.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_304012", "304012029", "story_v_out_304012.awb")

						arg_119_1:RecordAudio("304012029", var_122_24)
						arg_119_1:RecordAudio("304012029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_304012", "304012029", "story_v_out_304012.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_304012", "304012029", "story_v_out_304012.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play304012030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 304012030
		arg_123_1.duration_ = 6.87

		local var_123_0 = {
			zh = 6.866,
			ja = 1.999999999999
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play304012031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1066ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1066ui_story == nil then
				arg_123_1.var_.characterEffect1066ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1066ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1066ui_story then
				arg_123_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["1036ui_story"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1036ui_story == nil then
				arg_123_1.var_.characterEffect1036ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.characterEffect1036ui_story and not isNil(var_126_4) then
					local var_126_8 = Mathf.Lerp(0, 0.5, var_126_7)

					arg_123_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1036ui_story.fillRatio = var_126_8
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1036ui_story then
				local var_126_9 = 0.5

				arg_123_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1036ui_story.fillRatio = var_126_9
			end

			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_12 = 0
			local var_126_13 = 0.7

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_14 = arg_123_1:FormatText(StoryNameCfg[32].name)

				arg_123_1.leftNameTxt_.text = var_126_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:GetWordFromCfg(304012030)
				local var_126_16 = arg_123_1:FormatText(var_126_15.content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 28
				local var_126_18 = utf8.len(var_126_16)
				local var_126_19 = var_126_17 <= 0 and var_126_13 or var_126_13 * (var_126_18 / var_126_17)

				if var_126_19 > 0 and var_126_13 < var_126_19 then
					arg_123_1.talkMaxDuration = var_126_19

					if var_126_19 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_16
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012030", "story_v_out_304012.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012030", "story_v_out_304012.awb") / 1000

					if var_126_20 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_12
					end

					if var_126_15.prefab_name ~= "" and arg_123_1.actors_[var_126_15.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_15.prefab_name].transform, "story_v_out_304012", "304012030", "story_v_out_304012.awb")

						arg_123_1:RecordAudio("304012030", var_126_21)
						arg_123_1:RecordAudio("304012030", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_304012", "304012030", "story_v_out_304012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_304012", "304012030", "story_v_out_304012.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_22 and arg_123_1.time_ < var_126_12 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play304012031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 304012031
		arg_127_1.duration_ = 10.3

		local var_127_0 = {
			zh = 10.3,
			ja = 1.333
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play304012032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 1.15

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[32].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(304012031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 46
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012031", "story_v_out_304012.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012031", "story_v_out_304012.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_304012", "304012031", "story_v_out_304012.awb")

						arg_127_1:RecordAudio("304012031", var_130_9)
						arg_127_1:RecordAudio("304012031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_304012", "304012031", "story_v_out_304012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_304012", "304012031", "story_v_out_304012.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play304012032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 304012032
		arg_131_1.duration_ = 3.2

		local var_131_0 = {
			zh = 3.2,
			ja = 1.333
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play304012033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_2 = 0
			local var_134_3 = 0.375

			if var_134_2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_4 = arg_131_1:FormatText(StoryNameCfg[32].name)

				arg_131_1.leftNameTxt_.text = var_134_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:GetWordFromCfg(304012032)
				local var_134_6 = arg_131_1:FormatText(var_134_5.content)

				arg_131_1.text_.text = var_134_6

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 15
				local var_134_8 = utf8.len(var_134_6)
				local var_134_9 = var_134_7 <= 0 and var_134_3 or var_134_3 * (var_134_8 / var_134_7)

				if var_134_9 > 0 and var_134_3 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_6
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012032", "story_v_out_304012.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_304012", "304012032", "story_v_out_304012.awb") / 1000

					if var_134_10 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_2
					end

					if var_134_5.prefab_name ~= "" and arg_131_1.actors_[var_134_5.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_5.prefab_name].transform, "story_v_out_304012", "304012032", "story_v_out_304012.awb")

						arg_131_1:RecordAudio("304012032", var_134_11)
						arg_131_1:RecordAudio("304012032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_304012", "304012032", "story_v_out_304012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_304012", "304012032", "story_v_out_304012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_12 and arg_131_1.time_ < var_134_2 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play304012033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 304012033
		arg_135_1.duration_ = 10.43

		local var_135_0 = {
			zh = 8,
			ja = 10.433
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play304012034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1036ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1036ui_story == nil then
				arg_135_1.var_.characterEffect1036ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1036ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1036ui_story then
				arg_135_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_138_4 = arg_135_1.actors_["1066ui_story"]
			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1066ui_story == nil then
				arg_135_1.var_.characterEffect1066ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 and not isNil(var_138_4) then
				local var_138_7 = (arg_135_1.time_ - var_138_5) / var_138_6

				if arg_135_1.var_.characterEffect1066ui_story and not isNil(var_138_4) then
					local var_138_8 = Mathf.Lerp(0, 0.5, var_138_7)

					arg_135_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1066ui_story.fillRatio = var_138_8
				end
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1066ui_story then
				local var_138_9 = 0.5

				arg_135_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1066ui_story.fillRatio = var_138_9
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action3_1")
			end

			local var_138_11 = 0

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_138_12 = arg_135_1.actors_["1036ui_story"].transform
			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1.var_.moveOldPos1036ui_story = var_138_12.localPosition
			end

			local var_138_14 = 0.001

			if var_138_13 <= arg_135_1.time_ and arg_135_1.time_ < var_138_13 + var_138_14 then
				local var_138_15 = (arg_135_1.time_ - var_138_13) / var_138_14
				local var_138_16 = Vector3.New(-0.7, -1.09, -5.78)

				var_138_12.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1036ui_story, var_138_16, var_138_15)

				local var_138_17 = manager.ui.mainCamera.transform.position - var_138_12.position

				var_138_12.forward = Vector3.New(var_138_17.x, var_138_17.y, var_138_17.z)

				local var_138_18 = var_138_12.localEulerAngles

				var_138_18.z = 0
				var_138_18.x = 0
				var_138_12.localEulerAngles = var_138_18
			end

			if arg_135_1.time_ >= var_138_13 + var_138_14 and arg_135_1.time_ < var_138_13 + var_138_14 + arg_138_0 then
				var_138_12.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_138_19 = manager.ui.mainCamera.transform.position - var_138_12.position

				var_138_12.forward = Vector3.New(var_138_19.x, var_138_19.y, var_138_19.z)

				local var_138_20 = var_138_12.localEulerAngles

				var_138_20.z = 0
				var_138_20.x = 0
				var_138_12.localEulerAngles = var_138_20
			end

			local var_138_21 = arg_135_1.actors_["1066ui_story"].transform
			local var_138_22 = 0

			if var_138_22 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				arg_135_1.var_.moveOldPos1066ui_story = var_138_21.localPosition
			end

			local var_138_23 = 0.001

			if var_138_22 <= arg_135_1.time_ and arg_135_1.time_ < var_138_22 + var_138_23 then
				local var_138_24 = (arg_135_1.time_ - var_138_22) / var_138_23
				local var_138_25 = Vector3.New(0.7, -0.77, -6.1)

				var_138_21.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1066ui_story, var_138_25, var_138_24)

				local var_138_26 = manager.ui.mainCamera.transform.position - var_138_21.position

				var_138_21.forward = Vector3.New(var_138_26.x, var_138_26.y, var_138_26.z)

				local var_138_27 = var_138_21.localEulerAngles

				var_138_27.z = 0
				var_138_27.x = 0
				var_138_21.localEulerAngles = var_138_27
			end

			if arg_135_1.time_ >= var_138_22 + var_138_23 and arg_135_1.time_ < var_138_22 + var_138_23 + arg_138_0 then
				var_138_21.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_138_28 = manager.ui.mainCamera.transform.position - var_138_21.position

				var_138_21.forward = Vector3.New(var_138_28.x, var_138_28.y, var_138_28.z)

				local var_138_29 = var_138_21.localEulerAngles

				var_138_29.z = 0
				var_138_29.x = 0
				var_138_21.localEulerAngles = var_138_29
			end

			local var_138_30 = 0
			local var_138_31 = 1.125

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_32 = arg_135_1:FormatText(StoryNameCfg[5].name)

				arg_135_1.leftNameTxt_.text = var_138_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_33 = arg_135_1:GetWordFromCfg(304012033)
				local var_138_34 = arg_135_1:FormatText(var_138_33.content)

				arg_135_1.text_.text = var_138_34

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_35 = 45
				local var_138_36 = utf8.len(var_138_34)
				local var_138_37 = var_138_35 <= 0 and var_138_31 or var_138_31 * (var_138_36 / var_138_35)

				if var_138_37 > 0 and var_138_31 < var_138_37 then
					arg_135_1.talkMaxDuration = var_138_37

					if var_138_37 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_37 + var_138_30
					end
				end

				arg_135_1.text_.text = var_138_34
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012033", "story_v_out_304012.awb") ~= 0 then
					local var_138_38 = manager.audio:GetVoiceLength("story_v_out_304012", "304012033", "story_v_out_304012.awb") / 1000

					if var_138_38 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_38 + var_138_30
					end

					if var_138_33.prefab_name ~= "" and arg_135_1.actors_[var_138_33.prefab_name] ~= nil then
						local var_138_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_33.prefab_name].transform, "story_v_out_304012", "304012033", "story_v_out_304012.awb")

						arg_135_1:RecordAudio("304012033", var_138_39)
						arg_135_1:RecordAudio("304012033", var_138_39)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_304012", "304012033", "story_v_out_304012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_304012", "304012033", "story_v_out_304012.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_40 = math.max(var_138_31, arg_135_1.talkMaxDuration)

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_40 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_30) / var_138_40

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_30 + var_138_40 and arg_135_1.time_ < var_138_30 + var_138_40 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play304012034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 304012034
		arg_139_1.duration_ = 4.8

		local var_139_0 = {
			zh = 4.8,
			ja = 1.999999999999
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play304012035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1066ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1066ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1066ui_story then
				arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["1036ui_story"]
			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1036ui_story == nil then
				arg_139_1.var_.characterEffect1036ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_6 and not isNil(var_142_4) then
				local var_142_7 = (arg_139_1.time_ - var_142_5) / var_142_6

				if arg_139_1.var_.characterEffect1036ui_story and not isNil(var_142_4) then
					local var_142_8 = Mathf.Lerp(0, 0.5, var_142_7)

					arg_139_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1036ui_story.fillRatio = var_142_8
				end
			end

			if arg_139_1.time_ >= var_142_5 + var_142_6 and arg_139_1.time_ < var_142_5 + var_142_6 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1036ui_story then
				local var_142_9 = 0.5

				arg_139_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1036ui_story.fillRatio = var_142_9
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_142_11 = 0

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_142_12 = 0
			local var_142_13 = 0.575

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_14 = arg_139_1:FormatText(StoryNameCfg[32].name)

				arg_139_1.leftNameTxt_.text = var_142_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(304012034)
				local var_142_16 = arg_139_1:FormatText(var_142_15.content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 23
				local var_142_18 = utf8.len(var_142_16)
				local var_142_19 = var_142_17 <= 0 and var_142_13 or var_142_13 * (var_142_18 / var_142_17)

				if var_142_19 > 0 and var_142_13 < var_142_19 then
					arg_139_1.talkMaxDuration = var_142_19

					if var_142_19 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012034", "story_v_out_304012.awb") ~= 0 then
					local var_142_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012034", "story_v_out_304012.awb") / 1000

					if var_142_20 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_12
					end

					if var_142_15.prefab_name ~= "" and arg_139_1.actors_[var_142_15.prefab_name] ~= nil then
						local var_142_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_15.prefab_name].transform, "story_v_out_304012", "304012034", "story_v_out_304012.awb")

						arg_139_1:RecordAudio("304012034", var_142_21)
						arg_139_1:RecordAudio("304012034", var_142_21)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_304012", "304012034", "story_v_out_304012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_304012", "304012034", "story_v_out_304012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_22 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_22 and arg_139_1.time_ < var_142_12 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play304012035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 304012035
		arg_143_1.duration_ = 8.3

		local var_143_0 = {
			zh = 6.233,
			ja = 8.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play304012036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1036ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1036ui_story == nil then
				arg_143_1.var_.characterEffect1036ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1036ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1036ui_story then
				arg_143_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_146_4 = arg_143_1.actors_["1066ui_story"]
			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1066ui_story == nil then
				arg_143_1.var_.characterEffect1066ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_6 = 0.200000002980232

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_6 and not isNil(var_146_4) then
				local var_146_7 = (arg_143_1.time_ - var_146_5) / var_146_6

				if arg_143_1.var_.characterEffect1066ui_story and not isNil(var_146_4) then
					local var_146_8 = Mathf.Lerp(0, 0.5, var_146_7)

					arg_143_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1066ui_story.fillRatio = var_146_8
				end
			end

			if arg_143_1.time_ >= var_146_5 + var_146_6 and arg_143_1.time_ < var_146_5 + var_146_6 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1066ui_story then
				local var_146_9 = 0.5

				arg_143_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1066ui_story.fillRatio = var_146_9
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action3_2")
			end

			local var_146_11 = 0
			local var_146_12 = 0.7

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[5].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(304012035)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 28
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012035", "story_v_out_304012.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_304012", "304012035", "story_v_out_304012.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_304012", "304012035", "story_v_out_304012.awb")

						arg_143_1:RecordAudio("304012035", var_146_20)
						arg_143_1:RecordAudio("304012035", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_304012", "304012035", "story_v_out_304012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_304012", "304012035", "story_v_out_304012.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play304012036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 304012036
		arg_147_1.duration_ = 6.53

		local var_147_0 = {
			zh = 6.533,
			ja = 6.2
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play304012037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.85

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[5].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(304012036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 34
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012036", "story_v_out_304012.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012036", "story_v_out_304012.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_304012", "304012036", "story_v_out_304012.awb")

						arg_147_1:RecordAudio("304012036", var_150_9)
						arg_147_1:RecordAudio("304012036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_304012", "304012036", "story_v_out_304012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_304012", "304012036", "story_v_out_304012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play304012037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 304012037
		arg_151_1.duration_ = 3.07

		local var_151_0 = {
			zh = 3.066,
			ja = 1.999999999999
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play304012038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1066ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1066ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_154_4 = arg_151_1.actors_["1036ui_story"]
			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1036ui_story == nil then
				arg_151_1.var_.characterEffect1036ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.200000002980232

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 and not isNil(var_154_4) then
				local var_154_7 = (arg_151_1.time_ - var_154_5) / var_154_6

				if arg_151_1.var_.characterEffect1036ui_story and not isNil(var_154_4) then
					local var_154_8 = Mathf.Lerp(0, 0.5, var_154_7)

					arg_151_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1036ui_story.fillRatio = var_154_8
				end
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1036ui_story then
				local var_154_9 = 0.5

				arg_151_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1036ui_story.fillRatio = var_154_9
			end

			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_2")
			end

			local var_154_11 = 0
			local var_154_12 = 0.325

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_13 = arg_151_1:FormatText(StoryNameCfg[32].name)

				arg_151_1.leftNameTxt_.text = var_154_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(304012037)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 13
				local var_154_17 = utf8.len(var_154_15)
				local var_154_18 = var_154_16 <= 0 and var_154_12 or var_154_12 * (var_154_17 / var_154_16)

				if var_154_18 > 0 and var_154_12 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_11
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012037", "story_v_out_304012.awb") ~= 0 then
					local var_154_19 = manager.audio:GetVoiceLength("story_v_out_304012", "304012037", "story_v_out_304012.awb") / 1000

					if var_154_19 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_11
					end

					if var_154_14.prefab_name ~= "" and arg_151_1.actors_[var_154_14.prefab_name] ~= nil then
						local var_154_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_14.prefab_name].transform, "story_v_out_304012", "304012037", "story_v_out_304012.awb")

						arg_151_1:RecordAudio("304012037", var_154_20)
						arg_151_1:RecordAudio("304012037", var_154_20)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_304012", "304012037", "story_v_out_304012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_304012", "304012037", "story_v_out_304012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_21 = math.max(var_154_12, arg_151_1.talkMaxDuration)

			if var_154_11 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_21 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_21

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_21 and arg_151_1.time_ < var_154_11 + var_154_21 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play304012038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 304012038
		arg_155_1.duration_ = 2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play304012039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1036ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1036ui_story == nil then
				arg_155_1.var_.characterEffect1036ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1036ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1036ui_story then
				arg_155_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_158_4 = arg_155_1.actors_["1066ui_story"]
			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1066ui_story == nil then
				arg_155_1.var_.characterEffect1066ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_6 = 0.200000002980232

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_6 and not isNil(var_158_4) then
				local var_158_7 = (arg_155_1.time_ - var_158_5) / var_158_6

				if arg_155_1.var_.characterEffect1066ui_story and not isNil(var_158_4) then
					local var_158_8 = Mathf.Lerp(0, 0.5, var_158_7)

					arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1066ui_story.fillRatio = var_158_8
				end
			end

			if arg_155_1.time_ >= var_158_5 + var_158_6 and arg_155_1.time_ < var_158_5 + var_158_6 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1066ui_story then
				local var_158_9 = 0.5

				arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1066ui_story.fillRatio = var_158_9
			end

			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_158_11 = 0

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_12 = 0
			local var_158_13 = 0.2

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_14 = arg_155_1:FormatText(StoryNameCfg[5].name)

				arg_155_1.leftNameTxt_.text = var_158_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:GetWordFromCfg(304012038)
				local var_158_16 = arg_155_1:FormatText(var_158_15.content)

				arg_155_1.text_.text = var_158_16

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 8
				local var_158_18 = utf8.len(var_158_16)
				local var_158_19 = var_158_17 <= 0 and var_158_13 or var_158_13 * (var_158_18 / var_158_17)

				if var_158_19 > 0 and var_158_13 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_16
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012038", "story_v_out_304012.awb") ~= 0 then
					local var_158_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012038", "story_v_out_304012.awb") / 1000

					if var_158_20 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_12
					end

					if var_158_15.prefab_name ~= "" and arg_155_1.actors_[var_158_15.prefab_name] ~= nil then
						local var_158_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_15.prefab_name].transform, "story_v_out_304012", "304012038", "story_v_out_304012.awb")

						arg_155_1:RecordAudio("304012038", var_158_21)
						arg_155_1:RecordAudio("304012038", var_158_21)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_304012", "304012038", "story_v_out_304012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_304012", "304012038", "story_v_out_304012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_22 and arg_155_1.time_ < var_158_12 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play304012039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 304012039
		arg_159_1.duration_ = 3.5

		local var_159_0 = {
			zh = 3.5,
			ja = 3.2
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play304012040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1066ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1066ui_story == nil then
				arg_159_1.var_.characterEffect1066ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1066ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1066ui_story then
				arg_159_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["1036ui_story"]
			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1036ui_story == nil then
				arg_159_1.var_.characterEffect1036ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 and not isNil(var_162_4) then
				local var_162_7 = (arg_159_1.time_ - var_162_5) / var_162_6

				if arg_159_1.var_.characterEffect1036ui_story and not isNil(var_162_4) then
					local var_162_8 = Mathf.Lerp(0, 0.5, var_162_7)

					arg_159_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1036ui_story.fillRatio = var_162_8
				end
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1036ui_story then
				local var_162_9 = 0.5

				arg_159_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1036ui_story.fillRatio = var_162_9
			end

			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_162_11 = 0

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_12 = 0
			local var_162_13 = 0.4

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[32].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(304012039)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 16
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012039", "story_v_out_304012.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012039", "story_v_out_304012.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_304012", "304012039", "story_v_out_304012.awb")

						arg_159_1:RecordAudio("304012039", var_162_21)
						arg_159_1:RecordAudio("304012039", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_304012", "304012039", "story_v_out_304012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_304012", "304012039", "story_v_out_304012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play304012040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 304012040
		arg_163_1.duration_ = 7.93

		local var_163_0 = {
			zh = 7.933,
			ja = 1.333
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play304012041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.875

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[32].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(304012040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 35
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012040", "story_v_out_304012.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012040", "story_v_out_304012.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_304012", "304012040", "story_v_out_304012.awb")

						arg_163_1:RecordAudio("304012040", var_166_9)
						arg_163_1:RecordAudio("304012040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_304012", "304012040", "story_v_out_304012.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_304012", "304012040", "story_v_out_304012.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play304012041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 304012041
		arg_167_1.duration_ = 13.4

		local var_167_0 = {
			zh = 9.5,
			ja = 13.4
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play304012042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1019ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1019ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1019ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1036ui_story"].transform
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.var_.moveOldPos1036ui_story = var_170_9.localPosition
			end

			local var_170_11 = 0.001

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11
				local var_170_13 = Vector3.New(0, 100, 0)

				var_170_9.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1036ui_story, var_170_13, var_170_12)

				local var_170_14 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_14.x, var_170_14.y, var_170_14.z)

				local var_170_15 = var_170_9.localEulerAngles

				var_170_15.z = 0
				var_170_15.x = 0
				var_170_9.localEulerAngles = var_170_15
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 then
				var_170_9.localPosition = Vector3.New(0, 100, 0)

				local var_170_16 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_16.x, var_170_16.y, var_170_16.z)

				local var_170_17 = var_170_9.localEulerAngles

				var_170_17.z = 0
				var_170_17.x = 0
				var_170_9.localEulerAngles = var_170_17
			end

			local var_170_18 = arg_167_1.actors_["1019ui_story"]
			local var_170_19 = 0

			if var_170_19 < arg_167_1.time_ and arg_167_1.time_ <= var_170_19 + arg_170_0 and not isNil(var_170_18) and arg_167_1.var_.characterEffect1019ui_story == nil then
				arg_167_1.var_.characterEffect1019ui_story = var_170_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_20 = 0.200000002980232

			if var_170_19 <= arg_167_1.time_ and arg_167_1.time_ < var_170_19 + var_170_20 and not isNil(var_170_18) then
				local var_170_21 = (arg_167_1.time_ - var_170_19) / var_170_20

				if arg_167_1.var_.characterEffect1019ui_story and not isNil(var_170_18) then
					arg_167_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_19 + var_170_20 and arg_167_1.time_ < var_170_19 + var_170_20 + arg_170_0 and not isNil(var_170_18) and arg_167_1.var_.characterEffect1019ui_story then
				arg_167_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_170_22 = arg_167_1.actors_["1066ui_story"]
			local var_170_23 = 0

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.characterEffect1066ui_story == nil then
				arg_167_1.var_.characterEffect1066ui_story = var_170_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_24 = 0.200000002980232

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_24 and not isNil(var_170_22) then
				local var_170_25 = (arg_167_1.time_ - var_170_23) / var_170_24

				if arg_167_1.var_.characterEffect1066ui_story and not isNil(var_170_22) then
					local var_170_26 = Mathf.Lerp(0, 0.5, var_170_25)

					arg_167_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1066ui_story.fillRatio = var_170_26
				end
			end

			if arg_167_1.time_ >= var_170_23 + var_170_24 and arg_167_1.time_ < var_170_23 + var_170_24 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.characterEffect1066ui_story then
				local var_170_27 = 0.5

				arg_167_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1066ui_story.fillRatio = var_170_27
			end

			local var_170_28 = 0

			if var_170_28 < arg_167_1.time_ and arg_167_1.time_ <= var_170_28 + arg_170_0 then
				arg_167_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_170_29 = 0

			if var_170_29 < arg_167_1.time_ and arg_167_1.time_ <= var_170_29 + arg_170_0 then
				arg_167_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_30 = 0
			local var_170_31 = 0.95

			if var_170_30 < arg_167_1.time_ and arg_167_1.time_ <= var_170_30 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_32 = arg_167_1:FormatText(StoryNameCfg[13].name)

				arg_167_1.leftNameTxt_.text = var_170_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_33 = arg_167_1:GetWordFromCfg(304012041)
				local var_170_34 = arg_167_1:FormatText(var_170_33.content)

				arg_167_1.text_.text = var_170_34

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_35 = 39
				local var_170_36 = utf8.len(var_170_34)
				local var_170_37 = var_170_35 <= 0 and var_170_31 or var_170_31 * (var_170_36 / var_170_35)

				if var_170_37 > 0 and var_170_31 < var_170_37 then
					arg_167_1.talkMaxDuration = var_170_37

					if var_170_37 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_37 + var_170_30
					end
				end

				arg_167_1.text_.text = var_170_34
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012041", "story_v_out_304012.awb") ~= 0 then
					local var_170_38 = manager.audio:GetVoiceLength("story_v_out_304012", "304012041", "story_v_out_304012.awb") / 1000

					if var_170_38 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_38 + var_170_30
					end

					if var_170_33.prefab_name ~= "" and arg_167_1.actors_[var_170_33.prefab_name] ~= nil then
						local var_170_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_33.prefab_name].transform, "story_v_out_304012", "304012041", "story_v_out_304012.awb")

						arg_167_1:RecordAudio("304012041", var_170_39)
						arg_167_1:RecordAudio("304012041", var_170_39)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_304012", "304012041", "story_v_out_304012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_304012", "304012041", "story_v_out_304012.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_40 = math.max(var_170_31, arg_167_1.talkMaxDuration)

			if var_170_30 <= arg_167_1.time_ and arg_167_1.time_ < var_170_30 + var_170_40 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_30) / var_170_40

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_30 + var_170_40 and arg_167_1.time_ < var_170_30 + var_170_40 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play304012042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 304012042
		arg_171_1.duration_ = 4.27

		local var_171_0 = {
			zh = 4.266,
			ja = 1.999999999999
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play304012043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1066ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1066ui_story == nil then
				arg_171_1.var_.characterEffect1066ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1066ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1066ui_story then
				arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1019ui_story"]
			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1019ui_story == nil then
				arg_171_1.var_.characterEffect1019ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 and not isNil(var_174_4) then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / var_174_6

				if arg_171_1.var_.characterEffect1019ui_story and not isNil(var_174_4) then
					local var_174_8 = Mathf.Lerp(0, 0.5, var_174_7)

					arg_171_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1019ui_story.fillRatio = var_174_8
				end
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1019ui_story then
				local var_174_9 = 0.5

				arg_171_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1019ui_story.fillRatio = var_174_9
			end

			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_174_11 = 0

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_174_12 = 0
			local var_174_13 = 0.375

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_14 = arg_171_1:FormatText(StoryNameCfg[32].name)

				arg_171_1.leftNameTxt_.text = var_174_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:GetWordFromCfg(304012042)
				local var_174_16 = arg_171_1:FormatText(var_174_15.content)

				arg_171_1.text_.text = var_174_16

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 15
				local var_174_18 = utf8.len(var_174_16)
				local var_174_19 = var_174_17 <= 0 and var_174_13 or var_174_13 * (var_174_18 / var_174_17)

				if var_174_19 > 0 and var_174_13 < var_174_19 then
					arg_171_1.talkMaxDuration = var_174_19

					if var_174_19 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_19 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_16
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012042", "story_v_out_304012.awb") ~= 0 then
					local var_174_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012042", "story_v_out_304012.awb") / 1000

					if var_174_20 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_20 + var_174_12
					end

					if var_174_15.prefab_name ~= "" and arg_171_1.actors_[var_174_15.prefab_name] ~= nil then
						local var_174_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_15.prefab_name].transform, "story_v_out_304012", "304012042", "story_v_out_304012.awb")

						arg_171_1:RecordAudio("304012042", var_174_21)
						arg_171_1:RecordAudio("304012042", var_174_21)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_304012", "304012042", "story_v_out_304012.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_304012", "304012042", "story_v_out_304012.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_22 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_22 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_12) / var_174_22

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_12 + var_174_22 and arg_171_1.time_ < var_174_12 + var_174_22 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play304012043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 304012043
		arg_175_1.duration_ = 9.1

		local var_175_0 = {
			zh = 9.1,
			ja = 8.433
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play304012044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1019ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1019ui_story == nil then
				arg_175_1.var_.characterEffect1019ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1019ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1019ui_story then
				arg_175_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_178_4 = arg_175_1.actors_["1066ui_story"]
			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1066ui_story == nil then
				arg_175_1.var_.characterEffect1066ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 and not isNil(var_178_4) then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6

				if arg_175_1.var_.characterEffect1066ui_story and not isNil(var_178_4) then
					local var_178_8 = Mathf.Lerp(0, 0.5, var_178_7)

					arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1066ui_story.fillRatio = var_178_8
				end
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1066ui_story then
				local var_178_9 = 0.5

				arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1066ui_story.fillRatio = var_178_9
			end

			local var_178_10 = 0
			local var_178_11 = 1.05

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_12 = arg_175_1:FormatText(StoryNameCfg[13].name)

				arg_175_1.leftNameTxt_.text = var_178_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:GetWordFromCfg(304012043)
				local var_178_14 = arg_175_1:FormatText(var_178_13.content)

				arg_175_1.text_.text = var_178_14

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 42
				local var_178_16 = utf8.len(var_178_14)
				local var_178_17 = var_178_15 <= 0 and var_178_11 or var_178_11 * (var_178_16 / var_178_15)

				if var_178_17 > 0 and var_178_11 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17

					if var_178_17 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_14
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012043", "story_v_out_304012.awb") ~= 0 then
					local var_178_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012043", "story_v_out_304012.awb") / 1000

					if var_178_18 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_18 + var_178_10
					end

					if var_178_13.prefab_name ~= "" and arg_175_1.actors_[var_178_13.prefab_name] ~= nil then
						local var_178_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_13.prefab_name].transform, "story_v_out_304012", "304012043", "story_v_out_304012.awb")

						arg_175_1:RecordAudio("304012043", var_178_19)
						arg_175_1:RecordAudio("304012043", var_178_19)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_304012", "304012043", "story_v_out_304012.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_304012", "304012043", "story_v_out_304012.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_20 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_20 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_20

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_20 and arg_175_1.time_ < var_178_10 + var_178_20 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play304012044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 304012044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play304012045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1019ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1019ui_story == nil then
				arg_179_1.var_.characterEffect1019ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1019ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1019ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1019ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1019ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_182_8 = 0
			local var_182_9 = 1.3

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(304012044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_12 = 52
				local var_182_13 = utf8.len(var_182_11)
				local var_182_14 = var_182_12 <= 0 and var_182_9 or var_182_9 * (var_182_13 / var_182_12)

				if var_182_14 > 0 and var_182_9 < var_182_14 then
					arg_179_1.talkMaxDuration = var_182_14

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_15 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_15 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_15

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_15 and arg_179_1.time_ < var_182_8 + var_182_15 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play304012045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 304012045
		arg_183_1.duration_ = 10.87

		local var_183_0 = {
			zh = 10.866,
			ja = 10.4
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play304012046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1019ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1019ui_story == nil then
				arg_183_1.var_.characterEffect1019ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1019ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1019ui_story then
				arg_183_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_186_4 = 0

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_6 = 0
			local var_186_7 = 1.325

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[13].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_9 = arg_183_1:GetWordFromCfg(304012045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 53
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012045", "story_v_out_304012.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_304012", "304012045", "story_v_out_304012.awb") / 1000

					if var_186_14 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_6
					end

					if var_186_9.prefab_name ~= "" and arg_183_1.actors_[var_186_9.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_9.prefab_name].transform, "story_v_out_304012", "304012045", "story_v_out_304012.awb")

						arg_183_1:RecordAudio("304012045", var_186_15)
						arg_183_1:RecordAudio("304012045", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_304012", "304012045", "story_v_out_304012.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_304012", "304012045", "story_v_out_304012.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_16 and arg_183_1.time_ < var_186_6 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play304012046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 304012046
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play304012047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1066ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1066ui_story == nil then
				arg_187_1.var_.characterEffect1066ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1066ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1066ui_story then
				arg_187_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["1019ui_story"]
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1019ui_story == nil then
				arg_187_1.var_.characterEffect1019ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 and not isNil(var_190_4) then
				local var_190_7 = (arg_187_1.time_ - var_190_5) / var_190_6

				if arg_187_1.var_.characterEffect1019ui_story and not isNil(var_190_4) then
					local var_190_8 = Mathf.Lerp(0, 0.5, var_190_7)

					arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_8
				end
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1019ui_story then
				local var_190_9 = 0.5

				arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_9
			end

			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action7_1")
			end

			local var_190_11 = 0

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_190_12 = 0
			local var_190_13 = 0.075

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[32].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(304012046)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 3
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012046", "story_v_out_304012.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_304012", "304012046", "story_v_out_304012.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_304012", "304012046", "story_v_out_304012.awb")

						arg_187_1:RecordAudio("304012046", var_190_21)
						arg_187_1:RecordAudio("304012046", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_304012", "304012046", "story_v_out_304012.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_304012", "304012046", "story_v_out_304012.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play304012047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 304012047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play304012048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1066ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1066ui_story == nil then
				arg_191_1.var_.characterEffect1066ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1066ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1066ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1066ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1066ui_story.fillRatio = var_194_5
			end

			local var_194_6 = arg_191_1.actors_["1019ui_story"].transform
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.var_.moveOldPos1019ui_story = var_194_6.localPosition
			end

			local var_194_8 = 0.001

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8
				local var_194_10 = Vector3.New(0, 100, 0)

				var_194_6.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1019ui_story, var_194_10, var_194_9)

				local var_194_11 = manager.ui.mainCamera.transform.position - var_194_6.position

				var_194_6.forward = Vector3.New(var_194_11.x, var_194_11.y, var_194_11.z)

				local var_194_12 = var_194_6.localEulerAngles

				var_194_12.z = 0
				var_194_12.x = 0
				var_194_6.localEulerAngles = var_194_12
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 then
				var_194_6.localPosition = Vector3.New(0, 100, 0)

				local var_194_13 = manager.ui.mainCamera.transform.position - var_194_6.position

				var_194_6.forward = Vector3.New(var_194_13.x, var_194_13.y, var_194_13.z)

				local var_194_14 = var_194_6.localEulerAngles

				var_194_14.z = 0
				var_194_14.x = 0
				var_194_6.localEulerAngles = var_194_14
			end

			local var_194_15 = arg_191_1.actors_["1066ui_story"].transform
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.var_.moveOldPos1066ui_story = var_194_15.localPosition
			end

			local var_194_17 = 0.001

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17
				local var_194_19 = Vector3.New(0, 100, 0)

				var_194_15.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1066ui_story, var_194_19, var_194_18)

				local var_194_20 = manager.ui.mainCamera.transform.position - var_194_15.position

				var_194_15.forward = Vector3.New(var_194_20.x, var_194_20.y, var_194_20.z)

				local var_194_21 = var_194_15.localEulerAngles

				var_194_21.z = 0
				var_194_21.x = 0
				var_194_15.localEulerAngles = var_194_21
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				var_194_15.localPosition = Vector3.New(0, 100, 0)

				local var_194_22 = manager.ui.mainCamera.transform.position - var_194_15.position

				var_194_15.forward = Vector3.New(var_194_22.x, var_194_22.y, var_194_22.z)

				local var_194_23 = var_194_15.localEulerAngles

				var_194_23.z = 0
				var_194_23.x = 0
				var_194_15.localEulerAngles = var_194_23
			end

			local var_194_24 = 0
			local var_194_25 = 0.775

			if var_194_24 < arg_191_1.time_ and arg_191_1.time_ <= var_194_24 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_26 = arg_191_1:GetWordFromCfg(304012047)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 31
				local var_194_29 = utf8.len(var_194_27)
				local var_194_30 = var_194_28 <= 0 and var_194_25 or var_194_25 * (var_194_29 / var_194_28)

				if var_194_30 > 0 and var_194_25 < var_194_30 then
					arg_191_1.talkMaxDuration = var_194_30

					if var_194_30 + var_194_24 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_30 + var_194_24
					end
				end

				arg_191_1.text_.text = var_194_27
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = math.max(var_194_25, arg_191_1.talkMaxDuration)

			if var_194_24 <= arg_191_1.time_ and arg_191_1.time_ < var_194_24 + var_194_31 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_24) / var_194_31

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_24 + var_194_31 and arg_191_1.time_ < var_194_24 + var_194_31 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play304012048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 304012048
		arg_195_1.duration_ = 2.6

		local var_195_0 = {
			zh = 2.6,
			ja = 1.333
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
				arg_195_0:Play304012049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1066ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1066ui_story == nil then
				arg_195_1.var_.characterEffect1066ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1066ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1066ui_story then
				arg_195_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_198_4 = 0.1
			local var_198_5 = 1

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				local var_198_6 = "play"
				local var_198_7 = "effect"

				arg_195_1:AudioAction(var_198_6, var_198_7, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_198_8 = 0
			local var_198_9 = 0.3

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_10 = arg_195_1:FormatText(StoryNameCfg[32].name)

				arg_195_1.leftNameTxt_.text = var_198_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_11 = arg_195_1:GetWordFromCfg(304012048)
				local var_198_12 = arg_195_1:FormatText(var_198_11.content)

				arg_195_1.text_.text = var_198_12

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 12
				local var_198_14 = utf8.len(var_198_12)
				local var_198_15 = var_198_13 <= 0 and var_198_9 or var_198_9 * (var_198_14 / var_198_13)

				if var_198_15 > 0 and var_198_9 < var_198_15 then
					arg_195_1.talkMaxDuration = var_198_15

					if var_198_15 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_15 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_12
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012048", "story_v_out_304012.awb") ~= 0 then
					local var_198_16 = manager.audio:GetVoiceLength("story_v_out_304012", "304012048", "story_v_out_304012.awb") / 1000

					if var_198_16 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_8
					end

					if var_198_11.prefab_name ~= "" and arg_195_1.actors_[var_198_11.prefab_name] ~= nil then
						local var_198_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_11.prefab_name].transform, "story_v_out_304012", "304012048", "story_v_out_304012.awb")

						arg_195_1:RecordAudio("304012048", var_198_17)
						arg_195_1:RecordAudio("304012048", var_198_17)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_304012", "304012048", "story_v_out_304012.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_304012", "304012048", "story_v_out_304012.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_18 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_18 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_18

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_18 and arg_195_1.time_ < var_198_8 + var_198_18 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play304012049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 304012049
		arg_199_1.duration_ = 2.9

		local var_199_0 = {
			zh = 2.333,
			ja = 2.9
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play304012050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1036ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1036ui_story == nil then
				arg_199_1.var_.characterEffect1036ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1036ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1036ui_story then
				arg_199_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["1066ui_story"]
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1066ui_story == nil then
				arg_199_1.var_.characterEffect1066ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.200000002980232

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 and not isNil(var_202_4) then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6

				if arg_199_1.var_.characterEffect1066ui_story and not isNil(var_202_4) then
					local var_202_8 = Mathf.Lerp(0, 0.5, var_202_7)

					arg_199_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1066ui_story.fillRatio = var_202_8
				end
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1066ui_story then
				local var_202_9 = 0.5

				arg_199_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1066ui_story.fillRatio = var_202_9
			end

			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_2")
			end

			local var_202_11 = 0

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_202_12 = arg_199_1.actors_["1036ui_story"].transform
			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1.var_.moveOldPos1036ui_story = var_202_12.localPosition
			end

			local var_202_14 = 0.001

			if var_202_13 <= arg_199_1.time_ and arg_199_1.time_ < var_202_13 + var_202_14 then
				local var_202_15 = (arg_199_1.time_ - var_202_13) / var_202_14
				local var_202_16 = Vector3.New(-0.7, -1.09, -5.78)

				var_202_12.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1036ui_story, var_202_16, var_202_15)

				local var_202_17 = manager.ui.mainCamera.transform.position - var_202_12.position

				var_202_12.forward = Vector3.New(var_202_17.x, var_202_17.y, var_202_17.z)

				local var_202_18 = var_202_12.localEulerAngles

				var_202_18.z = 0
				var_202_18.x = 0
				var_202_12.localEulerAngles = var_202_18
			end

			if arg_199_1.time_ >= var_202_13 + var_202_14 and arg_199_1.time_ < var_202_13 + var_202_14 + arg_202_0 then
				var_202_12.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_202_19 = manager.ui.mainCamera.transform.position - var_202_12.position

				var_202_12.forward = Vector3.New(var_202_19.x, var_202_19.y, var_202_19.z)

				local var_202_20 = var_202_12.localEulerAngles

				var_202_20.z = 0
				var_202_20.x = 0
				var_202_12.localEulerAngles = var_202_20
			end

			local var_202_21 = 0
			local var_202_22 = 0.3

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_23 = arg_199_1:FormatText(StoryNameCfg[5].name)

				arg_199_1.leftNameTxt_.text = var_202_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_24 = arg_199_1:GetWordFromCfg(304012049)
				local var_202_25 = arg_199_1:FormatText(var_202_24.content)

				arg_199_1.text_.text = var_202_25

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_26 = 12
				local var_202_27 = utf8.len(var_202_25)
				local var_202_28 = var_202_26 <= 0 and var_202_22 or var_202_22 * (var_202_27 / var_202_26)

				if var_202_28 > 0 and var_202_22 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28

					if var_202_28 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_21
					end
				end

				arg_199_1.text_.text = var_202_25
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012049", "story_v_out_304012.awb") ~= 0 then
					local var_202_29 = manager.audio:GetVoiceLength("story_v_out_304012", "304012049", "story_v_out_304012.awb") / 1000

					if var_202_29 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_29 + var_202_21
					end

					if var_202_24.prefab_name ~= "" and arg_199_1.actors_[var_202_24.prefab_name] ~= nil then
						local var_202_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_24.prefab_name].transform, "story_v_out_304012", "304012049", "story_v_out_304012.awb")

						arg_199_1:RecordAudio("304012049", var_202_30)
						arg_199_1:RecordAudio("304012049", var_202_30)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_304012", "304012049", "story_v_out_304012.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_304012", "304012049", "story_v_out_304012.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_31 = math.max(var_202_22, arg_199_1.talkMaxDuration)

			if var_202_21 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_31 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_21) / var_202_31

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_21 + var_202_31 and arg_199_1.time_ < var_202_21 + var_202_31 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play304012050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304012050
		arg_203_1.duration_ = 5.17

		local var_203_0 = {
			zh = 4.8,
			ja = 5.166
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
				arg_203_0:Play304012051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1019ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1019ui_story then
				arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["1036ui_story"]
			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1036ui_story == nil then
				arg_203_1.var_.characterEffect1036ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.200000002980232

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 and not isNil(var_206_4) then
				local var_206_7 = (arg_203_1.time_ - var_206_5) / var_206_6

				if arg_203_1.var_.characterEffect1036ui_story and not isNil(var_206_4) then
					local var_206_8 = Mathf.Lerp(0, 0.5, var_206_7)

					arg_203_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1036ui_story.fillRatio = var_206_8
				end
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1036ui_story then
				local var_206_9 = 0.5

				arg_203_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1036ui_story.fillRatio = var_206_9
			end

			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_206_11 = 0

			if var_206_11 < arg_203_1.time_ and arg_203_1.time_ <= var_206_11 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_206_12 = arg_203_1.actors_["1019ui_story"].transform
			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = var_206_12.localPosition
			end

			local var_206_14 = 0.001

			if var_206_13 <= arg_203_1.time_ and arg_203_1.time_ < var_206_13 + var_206_14 then
				local var_206_15 = (arg_203_1.time_ - var_206_13) / var_206_14
				local var_206_16 = Vector3.New(0.7, -1.08, -5.9)

				var_206_12.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, var_206_16, var_206_15)

				local var_206_17 = manager.ui.mainCamera.transform.position - var_206_12.position

				var_206_12.forward = Vector3.New(var_206_17.x, var_206_17.y, var_206_17.z)

				local var_206_18 = var_206_12.localEulerAngles

				var_206_18.z = 0
				var_206_18.x = 0
				var_206_12.localEulerAngles = var_206_18
			end

			if arg_203_1.time_ >= var_206_13 + var_206_14 and arg_203_1.time_ < var_206_13 + var_206_14 + arg_206_0 then
				var_206_12.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_206_19 = manager.ui.mainCamera.transform.position - var_206_12.position

				var_206_12.forward = Vector3.New(var_206_19.x, var_206_19.y, var_206_19.z)

				local var_206_20 = var_206_12.localEulerAngles

				var_206_20.z = 0
				var_206_20.x = 0
				var_206_12.localEulerAngles = var_206_20
			end

			local var_206_21 = 0
			local var_206_22 = 0.6

			if var_206_21 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_23 = arg_203_1:FormatText(StoryNameCfg[13].name)

				arg_203_1.leftNameTxt_.text = var_206_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_24 = arg_203_1:GetWordFromCfg(304012050)
				local var_206_25 = arg_203_1:FormatText(var_206_24.content)

				arg_203_1.text_.text = var_206_25

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 24
				local var_206_27 = utf8.len(var_206_25)
				local var_206_28 = var_206_26 <= 0 and var_206_22 or var_206_22 * (var_206_27 / var_206_26)

				if var_206_28 > 0 and var_206_22 < var_206_28 then
					arg_203_1.talkMaxDuration = var_206_28

					if var_206_28 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_28 + var_206_21
					end
				end

				arg_203_1.text_.text = var_206_25
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012050", "story_v_out_304012.awb") ~= 0 then
					local var_206_29 = manager.audio:GetVoiceLength("story_v_out_304012", "304012050", "story_v_out_304012.awb") / 1000

					if var_206_29 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_29 + var_206_21
					end

					if var_206_24.prefab_name ~= "" and arg_203_1.actors_[var_206_24.prefab_name] ~= nil then
						local var_206_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_24.prefab_name].transform, "story_v_out_304012", "304012050", "story_v_out_304012.awb")

						arg_203_1:RecordAudio("304012050", var_206_30)
						arg_203_1:RecordAudio("304012050", var_206_30)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304012", "304012050", "story_v_out_304012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304012", "304012050", "story_v_out_304012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_31 = math.max(var_206_22, arg_203_1.talkMaxDuration)

			if var_206_21 <= arg_203_1.time_ and arg_203_1.time_ < var_206_21 + var_206_31 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_21) / var_206_31

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_21 + var_206_31 and arg_203_1.time_ < var_206_21 + var_206_31 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play304012051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 304012051
		arg_207_1.duration_ = 11.03

		local var_207_0 = {
			zh = 7.5,
			ja = 11.033
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play304012052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.975

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[13].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(304012051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012051", "story_v_out_304012.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012051", "story_v_out_304012.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_304012", "304012051", "story_v_out_304012.awb")

						arg_207_1:RecordAudio("304012051", var_210_9)
						arg_207_1:RecordAudio("304012051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_304012", "304012051", "story_v_out_304012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_304012", "304012051", "story_v_out_304012.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play304012052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 304012052
		arg_211_1.duration_ = 8.5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play304012053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = "S0106"

			if arg_211_1.bgs_[var_214_0] == nil then
				local var_214_1 = Object.Instantiate(arg_211_1.paintGo_)

				var_214_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_214_0)
				var_214_1.name = var_214_0
				var_214_1.transform.parent = arg_211_1.stage_.transform
				var_214_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.bgs_[var_214_0] = var_214_1
			end

			local var_214_2 = 1.76666666666667

			if var_214_2 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				local var_214_3 = manager.ui.mainCamera.transform.localPosition
				local var_214_4 = Vector3.New(0, 0, 10) + Vector3.New(var_214_3.x, var_214_3.y, 0)
				local var_214_5 = arg_211_1.bgs_.S0106

				var_214_5.transform.localPosition = var_214_4
				var_214_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_6 = var_214_5:GetComponent("SpriteRenderer")

				if var_214_6 and var_214_6.sprite then
					local var_214_7 = (var_214_5.transform.localPosition - var_214_3).z
					local var_214_8 = manager.ui.mainCameraCom_
					local var_214_9 = 2 * var_214_7 * Mathf.Tan(var_214_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_214_10 = var_214_9 * var_214_8.aspect
					local var_214_11 = var_214_6.sprite.bounds.size.x
					local var_214_12 = var_214_6.sprite.bounds.size.y
					local var_214_13 = var_214_10 / var_214_11
					local var_214_14 = var_214_9 / var_214_12
					local var_214_15 = var_214_14 < var_214_13 and var_214_13 or var_214_14

					var_214_5.transform.localScale = Vector3.New(var_214_15, var_214_15, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "S0106" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_16 = 1.76666666666667

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			local var_214_17 = 0.3

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_18 = 0

			if var_214_18 < arg_211_1.time_ and arg_211_1.time_ <= var_214_18 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_19 = 1.76666666666667

			if var_214_18 <= arg_211_1.time_ and arg_211_1.time_ < var_214_18 + var_214_19 then
				local var_214_20 = (arg_211_1.time_ - var_214_18) / var_214_19
				local var_214_21 = Color.New(0, 0, 0)

				var_214_21.a = Mathf.Lerp(0, 1, var_214_20)
				arg_211_1.mask_.color = var_214_21
			end

			if arg_211_1.time_ >= var_214_18 + var_214_19 and arg_211_1.time_ < var_214_18 + var_214_19 + arg_214_0 then
				local var_214_22 = Color.New(0, 0, 0)

				var_214_22.a = 1
				arg_211_1.mask_.color = var_214_22
			end

			local var_214_23 = 1.76666666666667

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_24 = 2

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_24 then
				local var_214_25 = (arg_211_1.time_ - var_214_23) / var_214_24
				local var_214_26 = Color.New(0, 0, 0)

				var_214_26.a = Mathf.Lerp(1, 0, var_214_25)
				arg_211_1.mask_.color = var_214_26
			end

			if arg_211_1.time_ >= var_214_23 + var_214_24 and arg_211_1.time_ < var_214_23 + var_214_24 + arg_214_0 then
				local var_214_27 = Color.New(0, 0, 0)
				local var_214_28 = 0

				arg_211_1.mask_.enabled = false
				var_214_27.a = var_214_28
				arg_211_1.mask_.color = var_214_27
			end

			local var_214_29 = arg_211_1.actors_["1019ui_story"].transform
			local var_214_30 = 1.76666666666667

			if var_214_30 < arg_211_1.time_ and arg_211_1.time_ <= var_214_30 + arg_214_0 then
				arg_211_1.var_.moveOldPos1019ui_story = var_214_29.localPosition
			end

			local var_214_31 = 0.001

			if var_214_30 <= arg_211_1.time_ and arg_211_1.time_ < var_214_30 + var_214_31 then
				local var_214_32 = (arg_211_1.time_ - var_214_30) / var_214_31
				local var_214_33 = Vector3.New(0, 100, 0)

				var_214_29.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1019ui_story, var_214_33, var_214_32)

				local var_214_34 = manager.ui.mainCamera.transform.position - var_214_29.position

				var_214_29.forward = Vector3.New(var_214_34.x, var_214_34.y, var_214_34.z)

				local var_214_35 = var_214_29.localEulerAngles

				var_214_35.z = 0
				var_214_35.x = 0
				var_214_29.localEulerAngles = var_214_35
			end

			if arg_211_1.time_ >= var_214_30 + var_214_31 and arg_211_1.time_ < var_214_30 + var_214_31 + arg_214_0 then
				var_214_29.localPosition = Vector3.New(0, 100, 0)

				local var_214_36 = manager.ui.mainCamera.transform.position - var_214_29.position

				var_214_29.forward = Vector3.New(var_214_36.x, var_214_36.y, var_214_36.z)

				local var_214_37 = var_214_29.localEulerAngles

				var_214_37.z = 0
				var_214_37.x = 0
				var_214_29.localEulerAngles = var_214_37
			end

			local var_214_38 = arg_211_1.actors_["1036ui_story"].transform
			local var_214_39 = 1.76666666666667

			if var_214_39 < arg_211_1.time_ and arg_211_1.time_ <= var_214_39 + arg_214_0 then
				arg_211_1.var_.moveOldPos1036ui_story = var_214_38.localPosition
			end

			local var_214_40 = 0.001

			if var_214_39 <= arg_211_1.time_ and arg_211_1.time_ < var_214_39 + var_214_40 then
				local var_214_41 = (arg_211_1.time_ - var_214_39) / var_214_40
				local var_214_42 = Vector3.New(0, 100, 0)

				var_214_38.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1036ui_story, var_214_42, var_214_41)

				local var_214_43 = manager.ui.mainCamera.transform.position - var_214_38.position

				var_214_38.forward = Vector3.New(var_214_43.x, var_214_43.y, var_214_43.z)

				local var_214_44 = var_214_38.localEulerAngles

				var_214_44.z = 0
				var_214_44.x = 0
				var_214_38.localEulerAngles = var_214_44
			end

			if arg_211_1.time_ >= var_214_39 + var_214_40 and arg_211_1.time_ < var_214_39 + var_214_40 + arg_214_0 then
				var_214_38.localPosition = Vector3.New(0, 100, 0)

				local var_214_45 = manager.ui.mainCamera.transform.position - var_214_38.position

				var_214_38.forward = Vector3.New(var_214_45.x, var_214_45.y, var_214_45.z)

				local var_214_46 = var_214_38.localEulerAngles

				var_214_46.z = 0
				var_214_46.x = 0
				var_214_38.localEulerAngles = var_214_46
			end

			local var_214_47 = arg_211_1.actors_["1019ui_story"]
			local var_214_48 = 1.76666666666667

			if var_214_48 < arg_211_1.time_ and arg_211_1.time_ <= var_214_48 + arg_214_0 and not isNil(var_214_47) and arg_211_1.var_.characterEffect1019ui_story == nil then
				arg_211_1.var_.characterEffect1019ui_story = var_214_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_49 = 0.200000002980232

			if var_214_48 <= arg_211_1.time_ and arg_211_1.time_ < var_214_48 + var_214_49 and not isNil(var_214_47) then
				local var_214_50 = (arg_211_1.time_ - var_214_48) / var_214_49

				if arg_211_1.var_.characterEffect1019ui_story and not isNil(var_214_47) then
					local var_214_51 = Mathf.Lerp(0, 0.5, var_214_50)

					arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1019ui_story.fillRatio = var_214_51
				end
			end

			if arg_211_1.time_ >= var_214_48 + var_214_49 and arg_211_1.time_ < var_214_48 + var_214_49 + arg_214_0 and not isNil(var_214_47) and arg_211_1.var_.characterEffect1019ui_story then
				local var_214_52 = 0.5

				arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1019ui_story.fillRatio = var_214_52
			end

			local var_214_53 = arg_211_1.bgs_.S0106.transform
			local var_214_54 = 1.76666666666667

			if var_214_54 < arg_211_1.time_ and arg_211_1.time_ <= var_214_54 + arg_214_0 then
				arg_211_1.var_.moveOldPosS0106 = var_214_53.localPosition
			end

			local var_214_55 = 2

			if var_214_54 <= arg_211_1.time_ and arg_211_1.time_ < var_214_54 + var_214_55 then
				local var_214_56 = (arg_211_1.time_ - var_214_54) / var_214_55
				local var_214_57 = Vector3.New(0, 0.56, 8)

				var_214_53.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPosS0106, var_214_57, var_214_56)
			end

			if arg_211_1.time_ >= var_214_54 + var_214_55 and arg_211_1.time_ < var_214_54 + var_214_55 + arg_214_0 then
				var_214_53.localPosition = Vector3.New(0, 0.56, 8)
			end

			local var_214_58 = 1
			local var_214_59 = 1

			if var_214_58 < arg_211_1.time_ and arg_211_1.time_ <= var_214_58 + arg_214_0 then
				local var_214_60 = "play"
				local var_214_61 = "effect"

				arg_211_1:AudioAction(var_214_60, var_214_61, "se_story_144", "se_story_144_door_open", "")
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_62 = 3.5
			local var_214_63 = 1.25

			if var_214_62 < arg_211_1.time_ and arg_211_1.time_ <= var_214_62 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_64 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_64:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_65 = arg_211_1:GetWordFromCfg(304012052)
				local var_214_66 = arg_211_1:FormatText(var_214_65.content)

				arg_211_1.text_.text = var_214_66

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_67 = 50
				local var_214_68 = utf8.len(var_214_66)
				local var_214_69 = var_214_67 <= 0 and var_214_63 or var_214_63 * (var_214_68 / var_214_67)

				if var_214_69 > 0 and var_214_63 < var_214_69 then
					arg_211_1.talkMaxDuration = var_214_69
					var_214_62 = var_214_62 + 0.3

					if var_214_69 + var_214_62 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_69 + var_214_62
					end
				end

				arg_211_1.text_.text = var_214_66
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_70 = var_214_62 + 0.3
			local var_214_71 = math.max(var_214_63, arg_211_1.talkMaxDuration)

			if var_214_70 <= arg_211_1.time_ and arg_211_1.time_ < var_214_70 + var_214_71 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_70) / var_214_71

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_70 + var_214_71 and arg_211_1.time_ < var_214_70 + var_214_71 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0106",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 0.56, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play304012053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 304012053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play304012054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.5

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(304012053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 60
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play304012054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 304012054
		arg_221_1.duration_ = 4.8

		local var_221_0 = {
			zh = 4.8,
			ja = 4.233
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play304012055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["2044ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect2044ui_story == nil then
				arg_221_1.var_.characterEffect2044ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect2044ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect2044ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect2044ui_story then
				arg_221_1.var_.characterEffect2044ui_story.fillFlat = false
			end

			local var_224_4 = 0
			local var_224_5 = 0.25

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_6 = arg_221_1:FormatText(StoryNameCfg[29].name)

				arg_221_1.leftNameTxt_.text = var_224_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(304012054)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 10
				local var_224_10 = utf8.len(var_224_8)
				local var_224_11 = var_224_9 <= 0 and var_224_5 or var_224_5 * (var_224_10 / var_224_9)

				if var_224_11 > 0 and var_224_5 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012054", "story_v_out_304012.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_out_304012", "304012054", "story_v_out_304012.awb") / 1000

					if var_224_12 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_4
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_304012", "304012054", "story_v_out_304012.awb")

						arg_221_1:RecordAudio("304012054", var_224_13)
						arg_221_1:RecordAudio("304012054", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_304012", "304012054", "story_v_out_304012.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_304012", "304012054", "story_v_out_304012.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_14 and arg_221_1.time_ < var_224_4 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play304012055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 304012055
		arg_225_1.duration_ = 6.27

		local var_225_0 = {
			zh = 6.266,
			ja = 1.333
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play304012056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.75

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[32].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(304012055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 30
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012055", "story_v_out_304012.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012055", "story_v_out_304012.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_304012", "304012055", "story_v_out_304012.awb")

						arg_225_1:RecordAudio("304012055", var_228_9)
						arg_225_1:RecordAudio("304012055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_304012", "304012055", "story_v_out_304012.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_304012", "304012055", "story_v_out_304012.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play304012056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 304012056
		arg_229_1.duration_ = 10.63

		local var_229_0 = {
			zh = 10.633,
			ja = 10.566
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play304012057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.125

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[13].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(304012056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 46
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012056", "story_v_out_304012.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012056", "story_v_out_304012.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_304012", "304012056", "story_v_out_304012.awb")

						arg_229_1:RecordAudio("304012056", var_232_9)
						arg_229_1:RecordAudio("304012056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_304012", "304012056", "story_v_out_304012.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_304012", "304012056", "story_v_out_304012.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play304012057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 304012057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play304012058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1019ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1019ui_story == nil then
				arg_233_1.var_.characterEffect1019ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1019ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1019ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1019ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1019ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.825

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(304012057)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 33
				local var_236_11 = utf8.len(var_236_9)
				local var_236_12 = var_236_10 <= 0 and var_236_7 or var_236_7 * (var_236_11 / var_236_10)

				if var_236_12 > 0 and var_236_7 < var_236_12 then
					arg_233_1.talkMaxDuration = var_236_12

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_13 and arg_233_1.time_ < var_236_6 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play304012058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 304012058
		arg_237_1.duration_ = 7.87

		local var_237_0 = {
			zh = 7.866,
			ja = 1.333
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play304012059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.875

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[32].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(304012058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 35
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012058", "story_v_out_304012.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012058", "story_v_out_304012.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_304012", "304012058", "story_v_out_304012.awb")

						arg_237_1:RecordAudio("304012058", var_240_9)
						arg_237_1:RecordAudio("304012058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_304012", "304012058", "story_v_out_304012.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_304012", "304012058", "story_v_out_304012.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play304012059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 304012059
		arg_241_1.duration_ = 6.83

		local var_241_0 = {
			zh = 6,
			ja = 6.833
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play304012060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1019ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1019ui_story == nil then
				arg_241_1.var_.characterEffect1019ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1019ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1019ui_story then
				arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["1066ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1066ui_story == nil then
				arg_241_1.var_.characterEffect1066ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect1066ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1066ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1066ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1066ui_story.fillRatio = var_244_9
			end

			local var_244_10 = 0
			local var_244_11 = 0.7

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_12 = arg_241_1:FormatText(StoryNameCfg[13].name)

				arg_241_1.leftNameTxt_.text = var_244_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_13 = arg_241_1:GetWordFromCfg(304012059)
				local var_244_14 = arg_241_1:FormatText(var_244_13.content)

				arg_241_1.text_.text = var_244_14

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_15 = 28
				local var_244_16 = utf8.len(var_244_14)
				local var_244_17 = var_244_15 <= 0 and var_244_11 or var_244_11 * (var_244_16 / var_244_15)

				if var_244_17 > 0 and var_244_11 < var_244_17 then
					arg_241_1.talkMaxDuration = var_244_17

					if var_244_17 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_10
					end
				end

				arg_241_1.text_.text = var_244_14
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012059", "story_v_out_304012.awb") ~= 0 then
					local var_244_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012059", "story_v_out_304012.awb") / 1000

					if var_244_18 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_10
					end

					if var_244_13.prefab_name ~= "" and arg_241_1.actors_[var_244_13.prefab_name] ~= nil then
						local var_244_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_13.prefab_name].transform, "story_v_out_304012", "304012059", "story_v_out_304012.awb")

						arg_241_1:RecordAudio("304012059", var_244_19)
						arg_241_1:RecordAudio("304012059", var_244_19)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_304012", "304012059", "story_v_out_304012.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_304012", "304012059", "story_v_out_304012.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_20 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_20 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_10) / var_244_20

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_10 + var_244_20 and arg_241_1.time_ < var_244_10 + var_244_20 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play304012060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 304012060
		arg_245_1.duration_ = 1

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play304012061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			return
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play304012061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 304012061
		arg_249_1.duration_ = 8.83

		local var_249_0 = {
			zh = 8.833,
			ja = 1.333
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play304012062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.525

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[32].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(304012061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 40
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012061", "story_v_out_304012.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012061", "story_v_out_304012.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_304012", "304012061", "story_v_out_304012.awb")

						arg_249_1:RecordAudio("304012061", var_252_9)
						arg_249_1:RecordAudio("304012061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_304012", "304012061", "story_v_out_304012.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_304012", "304012061", "story_v_out_304012.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play304012062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 304012062
		arg_253_1.duration_ = 8.03

		local var_253_0 = {
			zh = 4.833,
			ja = 8.033
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play304012063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.65

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[13].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(304012062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 26
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012062", "story_v_out_304012.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012062", "story_v_out_304012.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_304012", "304012062", "story_v_out_304012.awb")

						arg_253_1:RecordAudio("304012062", var_256_9)
						arg_253_1:RecordAudio("304012062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_304012", "304012062", "story_v_out_304012.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_304012", "304012062", "story_v_out_304012.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play304012063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 304012063
		arg_257_1.duration_ = 4.7

		local var_257_0 = {
			zh = 4.466,
			ja = 4.7
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play304012064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.525

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[13].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(304012063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 21
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012063", "story_v_out_304012.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012063", "story_v_out_304012.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_304012", "304012063", "story_v_out_304012.awb")

						arg_257_1:RecordAudio("304012063", var_260_9)
						arg_257_1:RecordAudio("304012063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_304012", "304012063", "story_v_out_304012.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_304012", "304012063", "story_v_out_304012.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play304012064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 304012064
		arg_261_1.duration_ = 3.3

		local var_261_0 = {
			zh = 2.133,
			ja = 3.3
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play304012065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1036ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1036ui_story == nil then
				arg_261_1.var_.characterEffect1036ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1036ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1036ui_story then
				arg_261_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["1019ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1019ui_story == nil then
				arg_261_1.var_.characterEffect1019ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect1019ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1019ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1019ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1019ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0
			local var_264_11 = 0.225

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_12 = arg_261_1:FormatText(StoryNameCfg[5].name)

				arg_261_1.leftNameTxt_.text = var_264_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_13 = arg_261_1:GetWordFromCfg(304012064)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 9
				local var_264_16 = utf8.len(var_264_14)
				local var_264_17 = var_264_15 <= 0 and var_264_11 or var_264_11 * (var_264_16 / var_264_15)

				if var_264_17 > 0 and var_264_11 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012064", "story_v_out_304012.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_304012", "304012064", "story_v_out_304012.awb") / 1000

					if var_264_18 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_10
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_out_304012", "304012064", "story_v_out_304012.awb")

						arg_261_1:RecordAudio("304012064", var_264_19)
						arg_261_1:RecordAudio("304012064", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_304012", "304012064", "story_v_out_304012.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_304012", "304012064", "story_v_out_304012.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_20 and arg_261_1.time_ < var_264_10 + var_264_20 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play304012065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 304012065
		arg_265_1.duration_ = 6.17

		local var_265_0 = {
			zh = 5.7,
			ja = 6.166
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
			arg_265_1.auto_ = false
		end

		function arg_265_1.playNext_(arg_267_0)
			arg_265_1.onStoryFinished_()
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.7

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[13].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(304012065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 28
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304012", "304012065", "story_v_out_304012.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_304012", "304012065", "story_v_out_304012.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_304012", "304012065", "story_v_out_304012.awb")

						arg_265_1:RecordAudio("304012065", var_268_9)
						arg_265_1:RecordAudio("304012065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_304012", "304012065", "story_v_out_304012.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_304012", "304012065", "story_v_out_304012.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10f",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/S0106"
	},
	voices = {
		"story_v_out_304012.awb"
	}
}
