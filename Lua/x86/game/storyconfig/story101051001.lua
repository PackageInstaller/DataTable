return {
	Play105101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105101001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			ja = 6.933,
			ko = 7.2,
			zh = 8,
			en = 7.833
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
				arg_1_0:Play105101002(arg_1_1)
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_10 = "B14"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.B14
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB14 = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB14 = var_4_14
				end

				arg_1_1.var_.alphaOldValueB14 = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB14, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueB14 then
					local var_4_18 = arg_1_1.var_.alphaMatValueB14.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueB14.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB14 then
				local var_4_19 = arg_1_1.var_.alphaMatValueB14
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B14

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
					if iter_4_0 ~= "B14" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_36 = 2

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_37 = 2
			local var_4_38 = 0.95

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_40 = arg_1_1:FormatText(StoryNameCfg[70].name)

				arg_1_1.leftNameTxt_.text = var_4_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_41 = arg_1_1:GetWordFromCfg(105101001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 36
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_38 or var_4_38 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_38 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_37 = var_4_37 + 0.3

					if var_4_45 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101001", "story_v_out_105101.awb") ~= 0 then
					local var_4_46 = manager.audio:GetVoiceLength("story_v_out_105101", "105101001", "story_v_out_105101.awb") / 1000

					if var_4_46 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_37
					end

					if var_4_41.prefab_name ~= "" and arg_1_1.actors_[var_4_41.prefab_name] ~= nil then
						local var_4_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_41.prefab_name].transform, "story_v_out_105101", "105101001", "story_v_out_105101.awb")

						arg_1_1:RecordAudio("105101001", var_4_47)
						arg_1_1:RecordAudio("105101001", var_4_47)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105101", "105101001", "story_v_out_105101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105101", "105101001", "story_v_out_105101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_37 + 0.3
			local var_4_49 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105101002
		arg_8_1.duration_ = 8.67

		local var_8_0 = {
			ja = 8.666,
			ko = 4.466,
			zh = 4.266,
			en = 4.766
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
				arg_8_0:Play105101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.675

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[70].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(105101002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101002", "story_v_out_105101.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101002", "story_v_out_105101.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_105101", "105101002", "story_v_out_105101.awb")

						arg_8_1:RecordAudio("105101002", var_11_9)
						arg_8_1:RecordAudio("105101002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105101", "105101002", "story_v_out_105101.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105101", "105101002", "story_v_out_105101.awb")
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
	Play105101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105101003
		arg_12_1.duration_ = 1.6

		local var_12_0 = {
			ja = 0.833,
			ko = 1.6,
			zh = 1.466,
			en = 1.2
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
				arg_12_0:Play105101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.15

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[71].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(105101003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101003", "story_v_out_105101.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101003", "story_v_out_105101.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_105101", "105101003", "story_v_out_105101.awb")

						arg_12_1:RecordAudio("105101003", var_15_9)
						arg_12_1:RecordAudio("105101003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105101", "105101003", "story_v_out_105101.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105101", "105101003", "story_v_out_105101.awb")
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
	Play105101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105101004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play105101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.75

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

				local var_19_2 = arg_16_1:GetWordFromCfg(105101004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 30
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
	Play105101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105101005
		arg_20_1.duration_ = 8.67

		local var_20_0 = {
			ja = 7.533,
			ko = 6.633,
			zh = 8.666,
			en = 7.133
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
				arg_20_0:Play105101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.925

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[70].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(105101005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101005", "story_v_out_105101.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101005", "story_v_out_105101.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_105101", "105101005", "story_v_out_105101.awb")

						arg_20_1:RecordAudio("105101005", var_23_9)
						arg_20_1:RecordAudio("105101005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105101", "105101005", "story_v_out_105101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105101", "105101005", "story_v_out_105101.awb")
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
	Play105101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105101006
		arg_24_1.duration_ = 11.43

		local var_24_0 = {
			ja = 11.433,
			ko = 7.766,
			zh = 5.5,
			en = 7.8
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
				arg_24_0:Play105101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.925

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[70].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(105101006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101006", "story_v_out_105101.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101006", "story_v_out_105101.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_105101", "105101006", "story_v_out_105101.awb")

						arg_24_1:RecordAudio("105101006", var_27_9)
						arg_24_1:RecordAudio("105101006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105101", "105101006", "story_v_out_105101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105101", "105101006", "story_v_out_105101.awb")
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
	Play105101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105101007
		arg_28_1.duration_ = 3.4

		local var_28_0 = {
			ja = 3.4,
			ko = 1.999999999999,
			zh = 2.7,
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
				arg_28_0:Play105101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1080ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["1080ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1080ui_story == nil then
				arg_28_1.var_.characterEffect1080ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1080ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1080ui_story then
				arg_28_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["1080ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos1080ui_story = var_31_9.localPosition
			end

			local var_31_11 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Vector3.New(0, -1.01, -6.05)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1080ui_story, var_31_13, var_31_12)

				local var_31_14 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_14.x, var_31_14.y, var_31_14.z)

				local var_31_15 = var_31_9.localEulerAngles

				var_31_15.z = 0
				var_31_15.x = 0
				var_31_9.localEulerAngles = var_31_15
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 then
				var_31_9.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_9.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_9.localEulerAngles = var_31_17
			end

			local var_31_18 = 0

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_20 = 0
			local var_31_21 = 0.175

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_22 = arg_28_1:FormatText(StoryNameCfg[55].name)

				arg_28_1.leftNameTxt_.text = var_31_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_23 = arg_28_1:GetWordFromCfg(105101007)
				local var_31_24 = arg_28_1:FormatText(var_31_23.content)

				arg_28_1.text_.text = var_31_24

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_25 = 7
				local var_31_26 = utf8.len(var_31_24)
				local var_31_27 = var_31_25 <= 0 and var_31_21 or var_31_21 * (var_31_26 / var_31_25)

				if var_31_27 > 0 and var_31_21 < var_31_27 then
					arg_28_1.talkMaxDuration = var_31_27

					if var_31_27 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_27 + var_31_20
					end
				end

				arg_28_1.text_.text = var_31_24
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101007", "story_v_out_105101.awb") ~= 0 then
					local var_31_28 = manager.audio:GetVoiceLength("story_v_out_105101", "105101007", "story_v_out_105101.awb") / 1000

					if var_31_28 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_20
					end

					if var_31_23.prefab_name ~= "" and arg_28_1.actors_[var_31_23.prefab_name] ~= nil then
						local var_31_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_23.prefab_name].transform, "story_v_out_105101", "105101007", "story_v_out_105101.awb")

						arg_28_1:RecordAudio("105101007", var_31_29)
						arg_28_1:RecordAudio("105101007", var_31_29)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_105101", "105101007", "story_v_out_105101.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_105101", "105101007", "story_v_out_105101.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_21, arg_28_1.talkMaxDuration)

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_20) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_20 + var_31_30 and arg_28_1.time_ < var_31_20 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play105101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105101008
		arg_32_1.duration_ = 7.7

		local var_32_0 = {
			ja = 6.866,
			ko = 6.9,
			zh = 6,
			en = 7.7
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
				arg_32_0:Play105101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1080ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1080ui_story == nil then
				arg_32_1.var_.characterEffect1080ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1080ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1080ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1080ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1080ui_story.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["1080ui_story"].transform
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.var_.moveOldPos1080ui_story = var_35_6.localPosition
			end

			local var_35_8 = 0.001

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 then
				local var_35_9 = (arg_32_1.time_ - var_35_7) / var_35_8
				local var_35_10 = Vector3.New(0, 100, 0)

				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1080ui_story, var_35_10, var_35_9)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_6.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_6.localEulerAngles = var_35_12
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(0, 100, 0)

				local var_35_13 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_13.x, var_35_13.y, var_35_13.z)

				local var_35_14 = var_35_6.localEulerAngles

				var_35_14.z = 0
				var_35_14.x = 0
				var_35_6.localEulerAngles = var_35_14
			end

			local var_35_15 = 0
			local var_35_16 = 0.975

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[70].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_18 = arg_32_1:GetWordFromCfg(105101008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 35
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101008", "story_v_out_105101.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_105101", "105101008", "story_v_out_105101.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_105101", "105101008", "story_v_out_105101.awb")

						arg_32_1:RecordAudio("105101008", var_35_24)
						arg_32_1:RecordAudio("105101008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_105101", "105101008", "story_v_out_105101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_105101", "105101008", "story_v_out_105101.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play105101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105101009
		arg_36_1.duration_ = 5.4

		local var_36_0 = {
			ja = 5.4,
			ko = 1.999999999999,
			zh = 2.266,
			en = 1.999999999999
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
				arg_36_0:Play105101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1059ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["1059ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1059ui_story == nil then
				arg_36_1.var_.characterEffect1059ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect1059ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1059ui_story then
				arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["1059ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1059ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, -1.05, -6)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1059ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, -1.05, -6)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_39_20 = 0
			local var_39_21 = 0.175

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_22 = arg_36_1:FormatText(StoryNameCfg[28].name)

				arg_36_1.leftNameTxt_.text = var_39_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_23 = arg_36_1:GetWordFromCfg(105101009)
				local var_39_24 = arg_36_1:FormatText(var_39_23.content)

				arg_36_1.text_.text = var_39_24

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_25 = 7
				local var_39_26 = utf8.len(var_39_24)
				local var_39_27 = var_39_25 <= 0 and var_39_21 or var_39_21 * (var_39_26 / var_39_25)

				if var_39_27 > 0 and var_39_21 < var_39_27 then
					arg_36_1.talkMaxDuration = var_39_27

					if var_39_27 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_27 + var_39_20
					end
				end

				arg_36_1.text_.text = var_39_24
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101009", "story_v_out_105101.awb") ~= 0 then
					local var_39_28 = manager.audio:GetVoiceLength("story_v_out_105101", "105101009", "story_v_out_105101.awb") / 1000

					if var_39_28 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_28 + var_39_20
					end

					if var_39_23.prefab_name ~= "" and arg_36_1.actors_[var_39_23.prefab_name] ~= nil then
						local var_39_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_23.prefab_name].transform, "story_v_out_105101", "105101009", "story_v_out_105101.awb")

						arg_36_1:RecordAudio("105101009", var_39_29)
						arg_36_1:RecordAudio("105101009", var_39_29)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_105101", "105101009", "story_v_out_105101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_105101", "105101009", "story_v_out_105101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_30 = math.max(var_39_21, arg_36_1.talkMaxDuration)

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_30 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_20) / var_39_30

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_20 + var_39_30 and arg_36_1.time_ < var_39_20 + var_39_30 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play105101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105101010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play105101011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1059ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1059ui_story == nil then
				arg_40_1.var_.characterEffect1059ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1059ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1059ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1059ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1059ui_story.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["1059ui_story"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos1059ui_story = var_43_6.localPosition
			end

			local var_43_8 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_7) / var_43_8
				local var_43_10 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1059ui_story, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_6.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_6.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_7 + var_43_8 and arg_40_1.time_ < var_43_7 + var_43_8 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_6.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_6.localEulerAngles = var_43_14
			end

			local var_43_15 = 0
			local var_43_16 = 0.65

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_18 = arg_40_1:GetWordFromCfg(105101010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 26
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_23 and arg_40_1.time_ < var_43_15 + var_43_23 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play105101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105101011
		arg_44_1.duration_ = 4.4

		local var_44_0 = {
			ja = 4.4,
			ko = 3.4,
			zh = 3.266,
			en = 3.9
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
				arg_44_0:Play105101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1027ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_44_1.stage_.transform)

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

			local var_47_5 = arg_44_1.actors_["1027ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1027ui_story == nil then
				arg_44_1.var_.characterEffect1027ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1027ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1027ui_story then
				arg_44_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["1027ui_story"].transform
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.var_.moveOldPos1027ui_story = var_47_9.localPosition
			end

			local var_47_11 = 0.001

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11
				local var_47_13 = Vector3.New(0, -0.81, -5.8)

				var_47_9.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1027ui_story, var_47_13, var_47_12)

				local var_47_14 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_14.x, var_47_14.y, var_47_14.z)

				local var_47_15 = var_47_9.localEulerAngles

				var_47_15.z = 0
				var_47_15.x = 0
				var_47_9.localEulerAngles = var_47_15
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 then
				var_47_9.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_47_16 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_16.x, var_47_16.y, var_47_16.z)

				local var_47_17 = var_47_9.localEulerAngles

				var_47_17.z = 0
				var_47_17.x = 0
				var_47_9.localEulerAngles = var_47_17
			end

			local var_47_18 = 0

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				arg_44_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_47_20 = 0
			local var_47_21 = 0.375

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_22 = arg_44_1:FormatText(StoryNameCfg[56].name)

				arg_44_1.leftNameTxt_.text = var_47_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_23 = arg_44_1:GetWordFromCfg(105101011)
				local var_47_24 = arg_44_1:FormatText(var_47_23.content)

				arg_44_1.text_.text = var_47_24

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_25 = 15
				local var_47_26 = utf8.len(var_47_24)
				local var_47_27 = var_47_25 <= 0 and var_47_21 or var_47_21 * (var_47_26 / var_47_25)

				if var_47_27 > 0 and var_47_21 < var_47_27 then
					arg_44_1.talkMaxDuration = var_47_27

					if var_47_27 + var_47_20 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_27 + var_47_20
					end
				end

				arg_44_1.text_.text = var_47_24
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101011", "story_v_out_105101.awb") ~= 0 then
					local var_47_28 = manager.audio:GetVoiceLength("story_v_out_105101", "105101011", "story_v_out_105101.awb") / 1000

					if var_47_28 + var_47_20 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_20
					end

					if var_47_23.prefab_name ~= "" and arg_44_1.actors_[var_47_23.prefab_name] ~= nil then
						local var_47_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_23.prefab_name].transform, "story_v_out_105101", "105101011", "story_v_out_105101.awb")

						arg_44_1:RecordAudio("105101011", var_47_29)
						arg_44_1:RecordAudio("105101011", var_47_29)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_105101", "105101011", "story_v_out_105101.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_105101", "105101011", "story_v_out_105101.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_30 = math.max(var_47_21, arg_44_1.talkMaxDuration)

			if var_47_20 <= arg_44_1.time_ and arg_44_1.time_ < var_47_20 + var_47_30 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_20) / var_47_30

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_20 + var_47_30 and arg_44_1.time_ < var_47_20 + var_47_30 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play105101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105101012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1027ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1027ui_story == nil then
				arg_48_1.var_.characterEffect1027ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1027ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1027ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1027ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1027ui_story.fillRatio = var_51_5
			end

			local var_51_6 = arg_48_1.actors_["1027ui_story"].transform
			local var_51_7 = 0

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.var_.moveOldPos1027ui_story = var_51_6.localPosition
			end

			local var_51_8 = 0.001

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_7) / var_51_8
				local var_51_10 = Vector3.New(0, 100, 0)

				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1027ui_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_6.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_6.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_7 + var_51_8 and arg_48_1.time_ < var_51_7 + var_51_8 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0, 100, 0)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_6.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_6.localEulerAngles = var_51_14
			end

			local var_51_15 = 0
			local var_51_16 = 1.275

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_18 = arg_48_1:GetWordFromCfg(105101012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 53
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_23 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_23 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_23

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_23 and arg_48_1.time_ < var_51_15 + var_51_23 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play105101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105101013
		arg_52_1.duration_ = 3.43

		local var_52_0 = {
			ja = 3.433,
			ko = 1.6,
			zh = 1.3,
			en = 1.3
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
				arg_52_0:Play105101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.15

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[70].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(105101013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101013", "story_v_out_105101.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101013", "story_v_out_105101.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_105101", "105101013", "story_v_out_105101.awb")

						arg_52_1:RecordAudio("105101013", var_55_9)
						arg_52_1:RecordAudio("105101013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_105101", "105101013", "story_v_out_105101.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_105101", "105101013", "story_v_out_105101.awb")
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
	Play105101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105101014
		arg_56_1.duration_ = 0.1

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"

			SetActive(arg_56_1.choicesGo_, true)

			for iter_57_0, iter_57_1 in ipairs(arg_56_1.choices_) do
				local var_57_0 = iter_57_0 <= 2

				SetActive(iter_57_1.go, var_57_0)
			end

			arg_56_1.choices_[1].txt.text = arg_56_1:FormatText(StoryChoiceCfg[32].name)
			arg_56_1.choices_[2].txt.text = arg_56_1:FormatText(StoryChoiceCfg[33].name)
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105101015(arg_56_1)
			end

			if arg_58_0 == 2 then
				arg_56_0:Play105101015(arg_56_1)
			end

			arg_56_1:RecordChoiceLog(105101014, 32, 33)
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			return
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play105101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105101015
		arg_60_1.duration_ = 6.4

		local var_60_0 = {
			ja = 6.4,
			ko = 4.2,
			zh = 4.966,
			en = 4.8
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
				arg_60_0:Play105101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.625

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[70].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10011")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(105101015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 24
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101015", "story_v_out_105101.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101015", "story_v_out_105101.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_105101", "105101015", "story_v_out_105101.awb")

						arg_60_1:RecordAudio("105101015", var_63_9)
						arg_60_1:RecordAudio("105101015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_105101", "105101015", "story_v_out_105101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_105101", "105101015", "story_v_out_105101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play105101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 105101016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play105101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.5

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(105101016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 20
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play105101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 105101017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play105101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "1037ui_story"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_68_1.stage_.transform)

					var_71_2.name = var_71_0
					var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_0] = var_71_2

					local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

					var_71_3.enabled = true

					local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

					if var_71_4 then
						var_71_4:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_3.transform, false)

					arg_68_1.var_[var_71_0 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_0 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_0 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			local var_71_6 = 0
			local var_71_7 = 0.1

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_9 = arg_68_1:GetWordFromCfg(105101017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 4
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play105101018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 105101018
		arg_72_1.duration_ = 1.03

		local var_72_0 = {
			ja = 1.033,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 0.999999999999
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
				arg_72_0:Play105101019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1037ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1037ui_story == nil then
				arg_72_1.var_.characterEffect1037ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1037ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1037ui_story then
				arg_72_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1037ui_story"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1037ui_story = var_75_4.localPosition
			end

			local var_75_6 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6
				local var_75_8 = Vector3.New(0, -1.09, -5.81)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1037ui_story, var_75_8, var_75_7)

				local var_75_9 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_9.x, var_75_9.y, var_75_9.z)

				local var_75_10 = var_75_4.localEulerAngles

				var_75_10.z = 0
				var_75_10.x = 0
				var_75_4.localEulerAngles = var_75_10
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_4.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_4.localEulerAngles = var_75_12
			end

			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_75_14 = 0
			local var_75_15 = 0.05

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_16 = arg_72_1:FormatText(StoryNameCfg[15].name)

				arg_72_1.leftNameTxt_.text = var_75_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_17 = arg_72_1:GetWordFromCfg(105101018)
				local var_75_18 = arg_72_1:FormatText(var_75_17.content)

				arg_72_1.text_.text = var_75_18

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_19 = 2
				local var_75_20 = utf8.len(var_75_18)
				local var_75_21 = var_75_19 <= 0 and var_75_15 or var_75_15 * (var_75_20 / var_75_19)

				if var_75_21 > 0 and var_75_15 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21

					if var_75_21 + var_75_14 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_14
					end
				end

				arg_72_1.text_.text = var_75_18
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101018", "story_v_out_105101.awb") ~= 0 then
					local var_75_22 = manager.audio:GetVoiceLength("story_v_out_105101", "105101018", "story_v_out_105101.awb") / 1000

					if var_75_22 + var_75_14 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_14
					end

					if var_75_17.prefab_name ~= "" and arg_72_1.actors_[var_75_17.prefab_name] ~= nil then
						local var_75_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_17.prefab_name].transform, "story_v_out_105101", "105101018", "story_v_out_105101.awb")

						arg_72_1:RecordAudio("105101018", var_75_23)
						arg_72_1:RecordAudio("105101018", var_75_23)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_105101", "105101018", "story_v_out_105101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_105101", "105101018", "story_v_out_105101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_24 = math.max(var_75_15, arg_72_1.talkMaxDuration)

			if var_75_14 <= arg_72_1.time_ and arg_72_1.time_ < var_75_14 + var_75_24 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_14) / var_75_24

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_14 + var_75_24 and arg_72_1.time_ < var_75_14 + var_75_24 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play105101019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 105101019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play105101020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1037ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1037ui_story == nil then
				arg_76_1.var_.characterEffect1037ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1037ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1037ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1037ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1037ui_story.fillRatio = var_79_5
			end

			local var_79_6 = arg_76_1.actors_["1037ui_story"].transform
			local var_79_7 = 0

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				arg_76_1.var_.moveOldPos1037ui_story = var_79_6.localPosition
			end

			local var_79_8 = 0.001

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_8 then
				local var_79_9 = (arg_76_1.time_ - var_79_7) / var_79_8
				local var_79_10 = Vector3.New(0, 100, 0)

				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1037ui_story, var_79_10, var_79_9)

				local var_79_11 = manager.ui.mainCamera.transform.position - var_79_6.position

				var_79_6.forward = Vector3.New(var_79_11.x, var_79_11.y, var_79_11.z)

				local var_79_12 = var_79_6.localEulerAngles

				var_79_12.z = 0
				var_79_12.x = 0
				var_79_6.localEulerAngles = var_79_12
			end

			if arg_76_1.time_ >= var_79_7 + var_79_8 and arg_76_1.time_ < var_79_7 + var_79_8 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(0, 100, 0)

				local var_79_13 = manager.ui.mainCamera.transform.position - var_79_6.position

				var_79_6.forward = Vector3.New(var_79_13.x, var_79_13.y, var_79_13.z)

				local var_79_14 = var_79_6.localEulerAngles

				var_79_14.z = 0
				var_79_14.x = 0
				var_79_6.localEulerAngles = var_79_14
			end

			local var_79_15 = 0
			local var_79_16 = 0.65

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_17 = arg_76_1:GetWordFromCfg(105101019)
				local var_79_18 = arg_76_1:FormatText(var_79_17.content)

				arg_76_1.text_.text = var_79_18

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_19 = 25
				local var_79_20 = utf8.len(var_79_18)
				local var_79_21 = var_79_19 <= 0 and var_79_16 or var_79_16 * (var_79_20 / var_79_19)

				if var_79_21 > 0 and var_79_16 < var_79_21 then
					arg_76_1.talkMaxDuration = var_79_21

					if var_79_21 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_21 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_18
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_22 and arg_76_1.time_ < var_79_15 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play105101020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 105101020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play105101021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_83_1 = 0
			local var_83_2 = 1.3

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(105101020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 52
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_2 or var_83_2 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_2 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_8 and arg_80_1.time_ < var_83_1 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play105101021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 105101021
		arg_84_1.duration_ = 8.6

		local var_84_0 = {
			ja = 8.6,
			ko = 4.566,
			zh = 3.966,
			en = 4.833
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
				arg_84_0:Play105101022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1037ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1037ui_story == nil then
				arg_84_1.var_.characterEffect1037ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1037ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1037ui_story then
				arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1037ui_story"].transform
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.var_.moveOldPos1037ui_story = var_87_4.localPosition
			end

			local var_87_6 = 0.001

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6
				local var_87_8 = Vector3.New(0, -1.09, -5.81)

				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1037ui_story, var_87_8, var_87_7)

				local var_87_9 = manager.ui.mainCamera.transform.position - var_87_4.position

				var_87_4.forward = Vector3.New(var_87_9.x, var_87_9.y, var_87_9.z)

				local var_87_10 = var_87_4.localEulerAngles

				var_87_10.z = 0
				var_87_10.x = 0
				var_87_4.localEulerAngles = var_87_10
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_87_11 = manager.ui.mainCamera.transform.position - var_87_4.position

				var_87_4.forward = Vector3.New(var_87_11.x, var_87_11.y, var_87_11.z)

				local var_87_12 = var_87_4.localEulerAngles

				var_87_12.z = 0
				var_87_12.x = 0
				var_87_4.localEulerAngles = var_87_12
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_87_14 = 0
			local var_87_15 = 0.5

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_16 = arg_84_1:FormatText(StoryNameCfg[15].name)

				arg_84_1.leftNameTxt_.text = var_87_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_17 = arg_84_1:GetWordFromCfg(105101021)
				local var_87_18 = arg_84_1:FormatText(var_87_17.content)

				arg_84_1.text_.text = var_87_18

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 21
				local var_87_20 = utf8.len(var_87_18)
				local var_87_21 = var_87_19 <= 0 and var_87_15 or var_87_15 * (var_87_20 / var_87_19)

				if var_87_21 > 0 and var_87_15 < var_87_21 then
					arg_84_1.talkMaxDuration = var_87_21

					if var_87_21 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_21 + var_87_14
					end
				end

				arg_84_1.text_.text = var_87_18
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101021", "story_v_out_105101.awb") ~= 0 then
					local var_87_22 = manager.audio:GetVoiceLength("story_v_out_105101", "105101021", "story_v_out_105101.awb") / 1000

					if var_87_22 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_14
					end

					if var_87_17.prefab_name ~= "" and arg_84_1.actors_[var_87_17.prefab_name] ~= nil then
						local var_87_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_17.prefab_name].transform, "story_v_out_105101", "105101021", "story_v_out_105101.awb")

						arg_84_1:RecordAudio("105101021", var_87_23)
						arg_84_1:RecordAudio("105101021", var_87_23)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_105101", "105101021", "story_v_out_105101.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_105101", "105101021", "story_v_out_105101.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_24 = math.max(var_87_15, arg_84_1.talkMaxDuration)

			if var_87_14 <= arg_84_1.time_ and arg_84_1.time_ < var_87_14 + var_87_24 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_14) / var_87_24

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_14 + var_87_24 and arg_84_1.time_ < var_87_14 + var_87_24 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play105101022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 105101022
		arg_88_1.duration_ = 8.8

		local var_88_0 = {
			ja = 8.233,
			ko = 7.066,
			zh = 5.733,
			en = 8.8
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
				arg_88_0:Play105101023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1037ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story == nil then
				arg_88_1.var_.characterEffect1037ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1037ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1037ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1037ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action7_1")
			end

			local var_91_7 = 0
			local var_91_8 = 0.75

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_9 = arg_88_1:FormatText(StoryNameCfg[10].name)

				arg_88_1.leftNameTxt_.text = var_91_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_10 = arg_88_1:GetWordFromCfg(105101022)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_12 = 30
				local var_91_13 = utf8.len(var_91_11)
				local var_91_14 = var_91_12 <= 0 and var_91_8 or var_91_8 * (var_91_13 / var_91_12)

				if var_91_14 > 0 and var_91_8 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14

					if var_91_14 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_7
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101022", "story_v_out_105101.awb") ~= 0 then
					local var_91_15 = manager.audio:GetVoiceLength("story_v_out_105101", "105101022", "story_v_out_105101.awb") / 1000

					if var_91_15 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_7
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_105101", "105101022", "story_v_out_105101.awb")

						arg_88_1:RecordAudio("105101022", var_91_16)
						arg_88_1:RecordAudio("105101022", var_91_16)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_105101", "105101022", "story_v_out_105101.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_105101", "105101022", "story_v_out_105101.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_17 = math.max(var_91_8, arg_88_1.talkMaxDuration)

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_17 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_7) / var_91_17

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_7 + var_91_17 and arg_88_1.time_ < var_91_7 + var_91_17 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play105101023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 105101023
		arg_92_1.duration_ = 4.03

		local var_92_0 = {
			ja = 4.033,
			ko = 2.733,
			zh = 3.066,
			en = 2.266
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
				arg_92_0:Play105101024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1080ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1080ui_story == nil then
				arg_92_1.var_.characterEffect1080ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1080ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1080ui_story then
				arg_92_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1037ui_story"].transform
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.var_.moveOldPos1037ui_story = var_95_4.localPosition
			end

			local var_95_6 = 0.001

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6
				local var_95_8 = Vector3.New(0, 100, 0)

				var_95_4.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1037ui_story, var_95_8, var_95_7)

				local var_95_9 = manager.ui.mainCamera.transform.position - var_95_4.position

				var_95_4.forward = Vector3.New(var_95_9.x, var_95_9.y, var_95_9.z)

				local var_95_10 = var_95_4.localEulerAngles

				var_95_10.z = 0
				var_95_10.x = 0
				var_95_4.localEulerAngles = var_95_10
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 then
				var_95_4.localPosition = Vector3.New(0, 100, 0)

				local var_95_11 = manager.ui.mainCamera.transform.position - var_95_4.position

				var_95_4.forward = Vector3.New(var_95_11.x, var_95_11.y, var_95_11.z)

				local var_95_12 = var_95_4.localEulerAngles

				var_95_12.z = 0
				var_95_12.x = 0
				var_95_4.localEulerAngles = var_95_12
			end

			local var_95_13 = arg_92_1.actors_["1080ui_story"].transform
			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1.var_.moveOldPos1080ui_story = var_95_13.localPosition
			end

			local var_95_15 = 0.001

			if var_95_14 <= arg_92_1.time_ and arg_92_1.time_ < var_95_14 + var_95_15 then
				local var_95_16 = (arg_92_1.time_ - var_95_14) / var_95_15
				local var_95_17 = Vector3.New(0, -1.01, -6.05)

				var_95_13.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1080ui_story, var_95_17, var_95_16)

				local var_95_18 = manager.ui.mainCamera.transform.position - var_95_13.position

				var_95_13.forward = Vector3.New(var_95_18.x, var_95_18.y, var_95_18.z)

				local var_95_19 = var_95_13.localEulerAngles

				var_95_19.z = 0
				var_95_19.x = 0
				var_95_13.localEulerAngles = var_95_19
			end

			if arg_92_1.time_ >= var_95_14 + var_95_15 and arg_92_1.time_ < var_95_14 + var_95_15 + arg_95_0 then
				var_95_13.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_95_20 = manager.ui.mainCamera.transform.position - var_95_13.position

				var_95_13.forward = Vector3.New(var_95_20.x, var_95_20.y, var_95_20.z)

				local var_95_21 = var_95_13.localEulerAngles

				var_95_21.z = 0
				var_95_21.x = 0
				var_95_13.localEulerAngles = var_95_21
			end

			local var_95_22 = 0

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_95_23 = 0
			local var_95_24 = 0.35

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_25 = arg_92_1:FormatText(StoryNameCfg[55].name)

				arg_92_1.leftNameTxt_.text = var_95_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(105101023)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 14
				local var_95_29 = utf8.len(var_95_27)
				local var_95_30 = var_95_28 <= 0 and var_95_24 or var_95_24 * (var_95_29 / var_95_28)

				if var_95_30 > 0 and var_95_24 < var_95_30 then
					arg_92_1.talkMaxDuration = var_95_30

					if var_95_30 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_23
					end
				end

				arg_92_1.text_.text = var_95_27
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101023", "story_v_out_105101.awb") ~= 0 then
					local var_95_31 = manager.audio:GetVoiceLength("story_v_out_105101", "105101023", "story_v_out_105101.awb") / 1000

					if var_95_31 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_23
					end

					if var_95_26.prefab_name ~= "" and arg_92_1.actors_[var_95_26.prefab_name] ~= nil then
						local var_95_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_26.prefab_name].transform, "story_v_out_105101", "105101023", "story_v_out_105101.awb")

						arg_92_1:RecordAudio("105101023", var_95_32)
						arg_92_1:RecordAudio("105101023", var_95_32)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_105101", "105101023", "story_v_out_105101.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_105101", "105101023", "story_v_out_105101.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_24, arg_92_1.talkMaxDuration)

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_23) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_23 + var_95_33 and arg_92_1.time_ < var_95_23 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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
				actorName = "1080ui_story",
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
	Play105101024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 105101024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play105101025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1080ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1080ui_story == nil then
				arg_96_1.var_.characterEffect1080ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1080ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1080ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1080ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1080ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.6

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(105101024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 24
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
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play105101025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 105101025
		arg_100_1.duration_ = 4.77

		local var_100_0 = {
			ja = 4.766,
			ko = 3.466,
			zh = 3.333,
			en = 3.733
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
				arg_100_0:Play105101026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1059ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1059ui_story == nil then
				arg_100_1.var_.characterEffect1059ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1059ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1059ui_story then
				arg_100_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1080ui_story"].transform
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.var_.moveOldPos1080ui_story = var_103_4.localPosition
			end

			local var_103_6 = 0.001

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6
				local var_103_8 = Vector3.New(0, -1.01, -6.05)

				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1080ui_story, var_103_8, var_103_7)

				local var_103_9 = manager.ui.mainCamera.transform.position - var_103_4.position

				var_103_4.forward = Vector3.New(var_103_9.x, var_103_9.y, var_103_9.z)

				local var_103_10 = var_103_4.localEulerAngles

				var_103_10.z = 0
				var_103_10.x = 0
				var_103_4.localEulerAngles = var_103_10
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_103_11 = manager.ui.mainCamera.transform.position - var_103_4.position

				var_103_4.forward = Vector3.New(var_103_11.x, var_103_11.y, var_103_11.z)

				local var_103_12 = var_103_4.localEulerAngles

				var_103_12.z = 0
				var_103_12.x = 0
				var_103_4.localEulerAngles = var_103_12
			end

			local var_103_13 = arg_100_1.actors_["1080ui_story"].transform
			local var_103_14 = 0.033

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1.var_.moveOldPos1080ui_story = var_103_13.localPosition
			end

			local var_103_15 = 0.5

			if var_103_14 <= arg_100_1.time_ and arg_100_1.time_ < var_103_14 + var_103_15 then
				local var_103_16 = (arg_100_1.time_ - var_103_14) / var_103_15
				local var_103_17 = Vector3.New(-0.7, -1.01, -6.05)

				var_103_13.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1080ui_story, var_103_17, var_103_16)

				local var_103_18 = manager.ui.mainCamera.transform.position - var_103_13.position

				var_103_13.forward = Vector3.New(var_103_18.x, var_103_18.y, var_103_18.z)

				local var_103_19 = var_103_13.localEulerAngles

				var_103_19.z = 0
				var_103_19.x = 0
				var_103_13.localEulerAngles = var_103_19
			end

			if arg_100_1.time_ >= var_103_14 + var_103_15 and arg_100_1.time_ < var_103_14 + var_103_15 + arg_103_0 then
				var_103_13.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_103_20 = manager.ui.mainCamera.transform.position - var_103_13.position

				var_103_13.forward = Vector3.New(var_103_20.x, var_103_20.y, var_103_20.z)

				local var_103_21 = var_103_13.localEulerAngles

				var_103_21.z = 0
				var_103_21.x = 0
				var_103_13.localEulerAngles = var_103_21
			end

			local var_103_22 = arg_100_1.actors_["1059ui_story"].transform
			local var_103_23 = 0

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 then
				arg_100_1.var_.moveOldPos1059ui_story = var_103_22.localPosition
			end

			local var_103_24 = 0.001

			if var_103_23 <= arg_100_1.time_ and arg_100_1.time_ < var_103_23 + var_103_24 then
				local var_103_25 = (arg_100_1.time_ - var_103_23) / var_103_24
				local var_103_26 = Vector3.New(0.7, -1.05, -6)

				var_103_22.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1059ui_story, var_103_26, var_103_25)

				local var_103_27 = manager.ui.mainCamera.transform.position - var_103_22.position

				var_103_22.forward = Vector3.New(var_103_27.x, var_103_27.y, var_103_27.z)

				local var_103_28 = var_103_22.localEulerAngles

				var_103_28.z = 0
				var_103_28.x = 0
				var_103_22.localEulerAngles = var_103_28
			end

			if arg_100_1.time_ >= var_103_23 + var_103_24 and arg_100_1.time_ < var_103_23 + var_103_24 + arg_103_0 then
				var_103_22.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_103_29 = manager.ui.mainCamera.transform.position - var_103_22.position

				var_103_22.forward = Vector3.New(var_103_29.x, var_103_29.y, var_103_29.z)

				local var_103_30 = var_103_22.localEulerAngles

				var_103_30.z = 0
				var_103_30.x = 0
				var_103_22.localEulerAngles = var_103_30
			end

			local var_103_31 = 0

			if var_103_31 < arg_100_1.time_ and arg_100_1.time_ <= var_103_31 + arg_103_0 then
				arg_100_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_103_32 = 0

			if var_103_32 < arg_100_1.time_ and arg_100_1.time_ <= var_103_32 + arg_103_0 then
				arg_100_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_103_33 = 0
			local var_103_34 = 0.3

			if var_103_33 < arg_100_1.time_ and arg_100_1.time_ <= var_103_33 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_35 = arg_100_1:FormatText(StoryNameCfg[28].name)

				arg_100_1.leftNameTxt_.text = var_103_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_36 = arg_100_1:GetWordFromCfg(105101025)
				local var_103_37 = arg_100_1:FormatText(var_103_36.content)

				arg_100_1.text_.text = var_103_37

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_38 = 12
				local var_103_39 = utf8.len(var_103_37)
				local var_103_40 = var_103_38 <= 0 and var_103_34 or var_103_34 * (var_103_39 / var_103_38)

				if var_103_40 > 0 and var_103_34 < var_103_40 then
					arg_100_1.talkMaxDuration = var_103_40

					if var_103_40 + var_103_33 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_40 + var_103_33
					end
				end

				arg_100_1.text_.text = var_103_37
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101025", "story_v_out_105101.awb") ~= 0 then
					local var_103_41 = manager.audio:GetVoiceLength("story_v_out_105101", "105101025", "story_v_out_105101.awb") / 1000

					if var_103_41 + var_103_33 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_41 + var_103_33
					end

					if var_103_36.prefab_name ~= "" and arg_100_1.actors_[var_103_36.prefab_name] ~= nil then
						local var_103_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_36.prefab_name].transform, "story_v_out_105101", "105101025", "story_v_out_105101.awb")

						arg_100_1:RecordAudio("105101025", var_103_42)
						arg_100_1:RecordAudio("105101025", var_103_42)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_105101", "105101025", "story_v_out_105101.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_105101", "105101025", "story_v_out_105101.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_43 = math.max(var_103_34, arg_100_1.talkMaxDuration)

			if var_103_33 <= arg_100_1.time_ and arg_100_1.time_ < var_103_33 + var_103_43 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_33) / var_103_43

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_33 + var_103_43 and arg_100_1.time_ < var_103_33 + var_103_43 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
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
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play105101026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 105101026
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play105101027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1080ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1080ui_story == nil then
				arg_104_1.var_.characterEffect1080ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1080ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1080ui_story then
				arg_104_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1059ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1059ui_story == nil then
				arg_104_1.var_.characterEffect1059ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1059ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1059ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1059ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1059ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action472")
			end

			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_12 = 0
			local var_107_13 = 0.125

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_14 = arg_104_1:FormatText(StoryNameCfg[55].name)

				arg_104_1.leftNameTxt_.text = var_107_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_15 = arg_104_1:GetWordFromCfg(105101026)
				local var_107_16 = arg_104_1:FormatText(var_107_15.content)

				arg_104_1.text_.text = var_107_16

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_17 = 5
				local var_107_18 = utf8.len(var_107_16)
				local var_107_19 = var_107_17 <= 0 and var_107_13 or var_107_13 * (var_107_18 / var_107_17)

				if var_107_19 > 0 and var_107_13 < var_107_19 then
					arg_104_1.talkMaxDuration = var_107_19

					if var_107_19 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_12
					end
				end

				arg_104_1.text_.text = var_107_16
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101026", "story_v_out_105101.awb") ~= 0 then
					local var_107_20 = manager.audio:GetVoiceLength("story_v_out_105101", "105101026", "story_v_out_105101.awb") / 1000

					if var_107_20 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_12
					end

					if var_107_15.prefab_name ~= "" and arg_104_1.actors_[var_107_15.prefab_name] ~= nil then
						local var_107_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_15.prefab_name].transform, "story_v_out_105101", "105101026", "story_v_out_105101.awb")

						arg_104_1:RecordAudio("105101026", var_107_21)
						arg_104_1:RecordAudio("105101026", var_107_21)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_105101", "105101026", "story_v_out_105101.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_105101", "105101026", "story_v_out_105101.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_13, arg_104_1.talkMaxDuration)

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_12) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_12 + var_107_22 and arg_104_1.time_ < var_107_12 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play105101027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 105101027
		arg_108_1.duration_ = 11.6

		local var_108_0 = {
			ja = 11.6,
			ko = 8.1,
			zh = 7.866,
			en = 9.166
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
				arg_108_0:Play105101028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1080ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1080ui_story == nil then
				arg_108_1.var_.characterEffect1080ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1080ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1080ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1080ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1080ui_story.fillRatio = var_111_5
			end

			local var_111_6 = arg_108_1.actors_["1080ui_story"].transform
			local var_111_7 = 0

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				arg_108_1.var_.moveOldPos1080ui_story = var_111_6.localPosition
			end

			local var_111_8 = 0.001

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_8 then
				local var_111_9 = (arg_108_1.time_ - var_111_7) / var_111_8
				local var_111_10 = Vector3.New(0, 100, 0)

				var_111_6.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1080ui_story, var_111_10, var_111_9)

				local var_111_11 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_11.x, var_111_11.y, var_111_11.z)

				local var_111_12 = var_111_6.localEulerAngles

				var_111_12.z = 0
				var_111_12.x = 0
				var_111_6.localEulerAngles = var_111_12
			end

			if arg_108_1.time_ >= var_111_7 + var_111_8 and arg_108_1.time_ < var_111_7 + var_111_8 + arg_111_0 then
				var_111_6.localPosition = Vector3.New(0, 100, 0)

				local var_111_13 = manager.ui.mainCamera.transform.position - var_111_6.position

				var_111_6.forward = Vector3.New(var_111_13.x, var_111_13.y, var_111_13.z)

				local var_111_14 = var_111_6.localEulerAngles

				var_111_14.z = 0
				var_111_14.x = 0
				var_111_6.localEulerAngles = var_111_14
			end

			local var_111_15 = arg_108_1.actors_["1059ui_story"].transform
			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPos1059ui_story = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, 100, 0)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1059ui_story, var_111_19, var_111_18)

				local var_111_20 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_20.x, var_111_20.y, var_111_20.z)

				local var_111_21 = var_111_15.localEulerAngles

				var_111_21.z = 0
				var_111_21.x = 0
				var_111_15.localEulerAngles = var_111_21
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, 100, 0)

				local var_111_22 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_22.x, var_111_22.y, var_111_22.z)

				local var_111_23 = var_111_15.localEulerAngles

				var_111_23.z = 0
				var_111_23.x = 0
				var_111_15.localEulerAngles = var_111_23
			end

			local var_111_24 = 0
			local var_111_25 = 1.025

			if var_111_24 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_26 = arg_108_1:FormatText(StoryNameCfg[10].name)

				arg_108_1.leftNameTxt_.text = var_111_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_27 = arg_108_1:GetWordFromCfg(105101027)
				local var_111_28 = arg_108_1:FormatText(var_111_27.content)

				arg_108_1.text_.text = var_111_28

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_29 = 52
				local var_111_30 = utf8.len(var_111_28)
				local var_111_31 = var_111_29 <= 0 and var_111_25 or var_111_25 * (var_111_30 / var_111_29)

				if var_111_31 > 0 and var_111_25 < var_111_31 then
					arg_108_1.talkMaxDuration = var_111_31

					if var_111_31 + var_111_24 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_31 + var_111_24
					end
				end

				arg_108_1.text_.text = var_111_28
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101027", "story_v_out_105101.awb") ~= 0 then
					local var_111_32 = manager.audio:GetVoiceLength("story_v_out_105101", "105101027", "story_v_out_105101.awb") / 1000

					if var_111_32 + var_111_24 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_32 + var_111_24
					end

					if var_111_27.prefab_name ~= "" and arg_108_1.actors_[var_111_27.prefab_name] ~= nil then
						local var_111_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_27.prefab_name].transform, "story_v_out_105101", "105101027", "story_v_out_105101.awb")

						arg_108_1:RecordAudio("105101027", var_111_33)
						arg_108_1:RecordAudio("105101027", var_111_33)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_105101", "105101027", "story_v_out_105101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_105101", "105101027", "story_v_out_105101.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_34 = math.max(var_111_25, arg_108_1.talkMaxDuration)

			if var_111_24 <= arg_108_1.time_ and arg_108_1.time_ < var_111_24 + var_111_34 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_24) / var_111_34

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_24 + var_111_34 and arg_108_1.time_ < var_111_24 + var_111_34 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play105101028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 105101028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play105101029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.675

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(105101028)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 26
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play105101029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 105101029
		arg_116_1.duration_ = 8

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play105101030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_1 = 1.5

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_1 then
				local var_119_2 = (arg_116_1.time_ - var_119_0) / var_119_1
				local var_119_3 = Color.New(1, 1, 1)

				var_119_3.a = Mathf.Lerp(0, 1, var_119_2)
				arg_116_1.mask_.color = var_119_3
			end

			if arg_116_1.time_ >= var_119_0 + var_119_1 and arg_116_1.time_ < var_119_0 + var_119_1 + arg_119_0 then
				local var_119_4 = Color.New(1, 1, 1)

				var_119_4.a = 1
				arg_116_1.mask_.color = var_119_4
			end

			local var_119_5 = 1.5

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_6 = 1.5

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6
				local var_119_8 = Color.New(1, 1, 1)

				var_119_8.a = Mathf.Lerp(1, 0, var_119_7)
				arg_116_1.mask_.color = var_119_8
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 then
				local var_119_9 = Color.New(1, 1, 1)
				local var_119_10 = 0

				arg_116_1.mask_.enabled = false
				var_119_9.a = var_119_10
				arg_116_1.mask_.color = var_119_9
			end

			local var_119_11 = "STwhite"

			if arg_116_1.bgs_[var_119_11] == nil then
				local var_119_12 = Object.Instantiate(arg_116_1.paintGo_)

				var_119_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_119_11)
				var_119_12.name = var_119_11
				var_119_12.transform.parent = arg_116_1.stage_.transform
				var_119_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.bgs_[var_119_11] = var_119_12
			end

			local var_119_13 = 1.5

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				local var_119_14 = manager.ui.mainCamera.transform.localPosition
				local var_119_15 = Vector3.New(0, 0, 10) + Vector3.New(var_119_14.x, var_119_14.y, 0)
				local var_119_16 = arg_116_1.bgs_.STwhite

				var_119_16.transform.localPosition = var_119_15
				var_119_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_17 = var_119_16:GetComponent("SpriteRenderer")

				if var_119_17 and var_119_17.sprite then
					local var_119_18 = (var_119_16.transform.localPosition - var_119_14).z
					local var_119_19 = manager.ui.mainCameraCom_
					local var_119_20 = 2 * var_119_18 * Mathf.Tan(var_119_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_119_21 = var_119_20 * var_119_19.aspect
					local var_119_22 = var_119_17.sprite.bounds.size.x
					local var_119_23 = var_119_17.sprite.bounds.size.y
					local var_119_24 = var_119_21 / var_119_22
					local var_119_25 = var_119_20 / var_119_23
					local var_119_26 = var_119_25 < var_119_24 and var_119_24 or var_119_25

					var_119_16.transform.localScale = Vector3.New(var_119_26, var_119_26, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "STwhite" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_27 = 3
			local var_119_28 = 0.875

			if var_119_27 < arg_116_1.time_ and arg_116_1.time_ <= var_119_27 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_29 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_29:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_30 = arg_116_1:GetWordFromCfg(105101029)
				local var_119_31 = arg_116_1:FormatText(var_119_30.content)

				arg_116_1.text_.text = var_119_31

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_32 = 35
				local var_119_33 = utf8.len(var_119_31)
				local var_119_34 = var_119_32 <= 0 and var_119_28 or var_119_28 * (var_119_33 / var_119_32)

				if var_119_34 > 0 and var_119_28 < var_119_34 then
					arg_116_1.talkMaxDuration = var_119_34
					var_119_27 = var_119_27 + 0.3

					if var_119_34 + var_119_27 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_34 + var_119_27
					end
				end

				arg_116_1.text_.text = var_119_31
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_35 = var_119_27 + 0.3
			local var_119_36 = math.max(var_119_28, arg_116_1.talkMaxDuration)

			if var_119_35 <= arg_116_1.time_ and arg_116_1.time_ < var_119_35 + var_119_36 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_35) / var_119_36

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_35 + var_119_36 and arg_116_1.time_ < var_119_35 + var_119_36 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play105101030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105101030
		arg_122_1.duration_ = 4.83

		local var_122_0 = {
			ja = 4.2,
			ko = 4.833,
			zh = 4.266,
			en = 4.3
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
				arg_122_0:Play105101031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.35

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_2 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_2:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_3 = arg_122_1:FormatText(StoryNameCfg[56].name)

				arg_122_1.leftNameTxt_.text = var_125_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_4 = arg_122_1:GetWordFromCfg(105101030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 14
				local var_125_7 = utf8.len(var_125_5)
				local var_125_8 = var_125_6 <= 0 and var_125_1 or var_125_1 * (var_125_7 / var_125_6)

				if var_125_8 > 0 and var_125_1 < var_125_8 then
					arg_122_1.talkMaxDuration = var_125_8
					var_125_0 = var_125_0 + 0.3

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101030", "story_v_out_105101.awb") ~= 0 then
					local var_125_9 = manager.audio:GetVoiceLength("story_v_out_105101", "105101030", "story_v_out_105101.awb") / 1000

					if var_125_9 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_0
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_105101", "105101030", "story_v_out_105101.awb")

						arg_122_1:RecordAudio("105101030", var_125_10)
						arg_122_1:RecordAudio("105101030", var_125_10)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_105101", "105101030", "story_v_out_105101.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_105101", "105101030", "story_v_out_105101.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = var_125_0 + 0.3
			local var_125_12 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_12 and arg_122_1.time_ < var_125_11 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play105101031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105101031
		arg_128_1.duration_ = 5.5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play105101032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1027ui_story"]
			local var_131_1 = 0.5

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1027ui_story == nil then
				arg_128_1.var_.characterEffect1027ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1027ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1027ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1027ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1027ui_story.fillRatio = var_131_5
			end

			local var_131_6 = arg_128_1.bgs_.STwhite.transform
			local var_131_7 = 0

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 then
				arg_128_1.var_.moveOldPosSTwhite = var_131_6.localPosition
			end

			local var_131_8 = 0.001

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_8 then
				local var_131_9 = (arg_128_1.time_ - var_131_7) / var_131_8
				local var_131_10 = Vector3.New(0, -100, 10)

				var_131_6.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPosSTwhite, var_131_10, var_131_9)
			end

			if arg_128_1.time_ >= var_131_7 + var_131_8 and arg_128_1.time_ < var_131_7 + var_131_8 + arg_131_0 then
				var_131_6.localPosition = Vector3.New(0, -100, 10)
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = false

				arg_128_1:SetGaussion(false)
			end

			local var_131_12 = 1.5

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_12 then
				local var_131_13 = (arg_128_1.time_ - var_131_11) / var_131_12
				local var_131_14 = Color.New(1, 1, 1)

				var_131_14.a = Mathf.Lerp(1, 0, var_131_13)
				arg_128_1.mask_.color = var_131_14
			end

			if arg_128_1.time_ >= var_131_11 + var_131_12 and arg_128_1.time_ < var_131_11 + var_131_12 + arg_131_0 then
				local var_131_15 = Color.New(1, 1, 1)
				local var_131_16 = 0

				arg_128_1.mask_.enabled = false
				var_131_15.a = var_131_16
				arg_128_1.mask_.color = var_131_15
			end

			local var_131_17 = "B01a"

			if arg_128_1.bgs_[var_131_17] == nil then
				local var_131_18 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_17)
				var_131_18.name = var_131_17
				var_131_18.transform.parent = arg_128_1.stage_.transform
				var_131_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_17] = var_131_18
			end

			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				local var_131_20 = manager.ui.mainCamera.transform.localPosition
				local var_131_21 = Vector3.New(0, 0, 10) + Vector3.New(var_131_20.x, var_131_20.y, 0)
				local var_131_22 = arg_128_1.bgs_.B01a

				var_131_22.transform.localPosition = var_131_21
				var_131_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_23 = var_131_22:GetComponent("SpriteRenderer")

				if var_131_23 and var_131_23.sprite then
					local var_131_24 = (var_131_22.transform.localPosition - var_131_20).z
					local var_131_25 = manager.ui.mainCameraCom_
					local var_131_26 = 2 * var_131_24 * Mathf.Tan(var_131_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_27 = var_131_26 * var_131_25.aspect
					local var_131_28 = var_131_23.sprite.bounds.size.x
					local var_131_29 = var_131_23.sprite.bounds.size.y
					local var_131_30 = var_131_27 / var_131_28
					local var_131_31 = var_131_26 / var_131_29
					local var_131_32 = var_131_31 < var_131_30 and var_131_30 or var_131_31

					var_131_22.transform.localScale = Vector3.New(var_131_32, var_131_32, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "B01a" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_33 = arg_128_1.actors_["1027ui_story"].transform
			local var_131_34 = 0

			if var_131_34 < arg_128_1.time_ and arg_128_1.time_ <= var_131_34 + arg_131_0 then
				arg_128_1.var_.moveOldPos1027ui_story = var_131_33.localPosition
			end

			local var_131_35 = 0.001

			if var_131_34 <= arg_128_1.time_ and arg_128_1.time_ < var_131_34 + var_131_35 then
				local var_131_36 = (arg_128_1.time_ - var_131_34) / var_131_35
				local var_131_37 = Vector3.New(0, -0.81, -5.8)

				var_131_33.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1027ui_story, var_131_37, var_131_36)

				local var_131_38 = manager.ui.mainCamera.transform.position - var_131_33.position

				var_131_33.forward = Vector3.New(var_131_38.x, var_131_38.y, var_131_38.z)

				local var_131_39 = var_131_33.localEulerAngles

				var_131_39.z = 0
				var_131_39.x = 0
				var_131_33.localEulerAngles = var_131_39
			end

			if arg_128_1.time_ >= var_131_34 + var_131_35 and arg_128_1.time_ < var_131_34 + var_131_35 + arg_131_0 then
				var_131_33.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_131_40 = manager.ui.mainCamera.transform.position - var_131_33.position

				var_131_33.forward = Vector3.New(var_131_40.x, var_131_40.y, var_131_40.z)

				local var_131_41 = var_131_33.localEulerAngles

				var_131_41.z = 0
				var_131_41.x = 0
				var_131_33.localEulerAngles = var_131_41
			end

			local var_131_42 = 0

			if var_131_42 < arg_128_1.time_ and arg_128_1.time_ <= var_131_42 + arg_131_0 then
				arg_128_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_131_43 = 0

			if var_131_43 < arg_128_1.time_ and arg_128_1.time_ <= var_131_43 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_44 = 0.5

			if arg_128_1.time_ >= var_131_43 + var_131_44 and arg_128_1.time_ < var_131_43 + var_131_44 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_45 = 0.5
			local var_131_46 = 0.075

			if var_131_45 < arg_128_1.time_ and arg_128_1.time_ <= var_131_45 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_47 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_47:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_48 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_49 = arg_128_1:GetWordFromCfg(105101031)
				local var_131_50 = arg_128_1:FormatText(var_131_49.content)

				arg_128_1.text_.text = var_131_50

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_51 = 3
				local var_131_52 = utf8.len(var_131_50)
				local var_131_53 = var_131_51 <= 0 and var_131_46 or var_131_46 * (var_131_52 / var_131_51)

				if var_131_53 > 0 and var_131_46 < var_131_53 then
					arg_128_1.talkMaxDuration = var_131_53
					var_131_45 = var_131_45 + 0.3

					if var_131_53 + var_131_45 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_53 + var_131_45
					end
				end

				arg_128_1.text_.text = var_131_50
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_54 = var_131_45 + 0.3
			local var_131_55 = math.max(var_131_46, arg_128_1.talkMaxDuration)

			if var_131_54 <= arg_128_1.time_ and arg_128_1.time_ < var_131_54 + var_131_55 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_54) / var_131_55

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_54 + var_131_55 and arg_128_1.time_ < var_131_54 + var_131_55 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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

		arg_128_1:InitPlayNodeList()
	end,
	Play105101032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 105101032
		arg_134_1.duration_ = 5.73

		local var_134_0 = {
			ja = 5.733,
			ko = 4.233,
			zh = 3.366,
			en = 3.766
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
				arg_134_0:Play105101033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1027ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1027ui_story == nil then
				arg_134_1.var_.characterEffect1027ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1027ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1027ui_story then
				arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_137_4 = 0

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action475")
			end

			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_137_6 = 0
			local var_137_7 = 0.4

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[56].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_9 = arg_134_1:GetWordFromCfg(105101032)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101032", "story_v_out_105101.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_105101", "105101032", "story_v_out_105101.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_105101", "105101032", "story_v_out_105101.awb")

						arg_134_1:RecordAudio("105101032", var_137_15)
						arg_134_1:RecordAudio("105101032", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_105101", "105101032", "story_v_out_105101.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_105101", "105101032", "story_v_out_105101.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play105101033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 105101033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play105101034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1027ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1027ui_story == nil then
				arg_138_1.var_.characterEffect1027ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1027ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1027ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1027ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1027ui_story.fillRatio = var_141_5
			end

			local var_141_6 = arg_138_1.actors_["1027ui_story"].transform
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 then
				arg_138_1.var_.moveOldPos1027ui_story = var_141_6.localPosition
			end

			local var_141_8 = 0.001

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8
				local var_141_10 = Vector3.New(0, 100, 0)

				var_141_6.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1027ui_story, var_141_10, var_141_9)

				local var_141_11 = manager.ui.mainCamera.transform.position - var_141_6.position

				var_141_6.forward = Vector3.New(var_141_11.x, var_141_11.y, var_141_11.z)

				local var_141_12 = var_141_6.localEulerAngles

				var_141_12.z = 0
				var_141_12.x = 0
				var_141_6.localEulerAngles = var_141_12
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 then
				var_141_6.localPosition = Vector3.New(0, 100, 0)

				local var_141_13 = manager.ui.mainCamera.transform.position - var_141_6.position

				var_141_6.forward = Vector3.New(var_141_13.x, var_141_13.y, var_141_13.z)

				local var_141_14 = var_141_6.localEulerAngles

				var_141_14.z = 0
				var_141_14.x = 0
				var_141_6.localEulerAngles = var_141_14
			end

			local var_141_15 = 0
			local var_141_16 = 0.425

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_18 = arg_138_1:GetWordFromCfg(105101033)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 16
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_23 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_23 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_23

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_23 and arg_138_1.time_ < var_141_15 + var_141_23 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play105101034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 105101034
		arg_142_1.duration_ = 3.23

		local var_142_0 = {
			ja = 3.233,
			ko = 3.2,
			zh = 3.166,
			en = 2.4
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
				arg_142_0:Play105101035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1080ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1080ui_story == nil then
				arg_142_1.var_.characterEffect1080ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.1

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1080ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1080ui_story then
				arg_142_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["1080ui_story"].transform
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.var_.moveOldPos1080ui_story = var_145_4.localPosition
			end

			local var_145_6 = 0.001

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6
				local var_145_8 = Vector3.New(0, -1.01, -6.05)

				var_145_4.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1080ui_story, var_145_8, var_145_7)

				local var_145_9 = manager.ui.mainCamera.transform.position - var_145_4.position

				var_145_4.forward = Vector3.New(var_145_9.x, var_145_9.y, var_145_9.z)

				local var_145_10 = var_145_4.localEulerAngles

				var_145_10.z = 0
				var_145_10.x = 0
				var_145_4.localEulerAngles = var_145_10
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 then
				var_145_4.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_145_11 = manager.ui.mainCamera.transform.position - var_145_4.position

				var_145_4.forward = Vector3.New(var_145_11.x, var_145_11.y, var_145_11.z)

				local var_145_12 = var_145_4.localEulerAngles

				var_145_12.z = 0
				var_145_12.x = 0
				var_145_4.localEulerAngles = var_145_12
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_145_14 = 0
			local var_145_15 = 0.35

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_16 = arg_142_1:FormatText(StoryNameCfg[55].name)

				arg_142_1.leftNameTxt_.text = var_145_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_17 = arg_142_1:GetWordFromCfg(105101034)
				local var_145_18 = arg_142_1:FormatText(var_145_17.content)

				arg_142_1.text_.text = var_145_18

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_19 = 14
				local var_145_20 = utf8.len(var_145_18)
				local var_145_21 = var_145_19 <= 0 and var_145_15 or var_145_15 * (var_145_20 / var_145_19)

				if var_145_21 > 0 and var_145_15 < var_145_21 then
					arg_142_1.talkMaxDuration = var_145_21

					if var_145_21 + var_145_14 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_21 + var_145_14
					end
				end

				arg_142_1.text_.text = var_145_18
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101034", "story_v_out_105101.awb") ~= 0 then
					local var_145_22 = manager.audio:GetVoiceLength("story_v_out_105101", "105101034", "story_v_out_105101.awb") / 1000

					if var_145_22 + var_145_14 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_22 + var_145_14
					end

					if var_145_17.prefab_name ~= "" and arg_142_1.actors_[var_145_17.prefab_name] ~= nil then
						local var_145_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_17.prefab_name].transform, "story_v_out_105101", "105101034", "story_v_out_105101.awb")

						arg_142_1:RecordAudio("105101034", var_145_23)
						arg_142_1:RecordAudio("105101034", var_145_23)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_105101", "105101034", "story_v_out_105101.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_105101", "105101034", "story_v_out_105101.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_24 = math.max(var_145_15, arg_142_1.talkMaxDuration)

			if var_145_14 <= arg_142_1.time_ and arg_142_1.time_ < var_145_14 + var_145_24 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_14) / var_145_24

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_14 + var_145_24 and arg_142_1.time_ < var_145_14 + var_145_24 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play105101035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 105101035
		arg_146_1.duration_ = 10.5

		local var_146_0 = {
			ja = 10.5,
			ko = 9.4,
			zh = 7.433,
			en = 8.933
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
				arg_146_0:Play105101036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1037ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1037ui_story == nil then
				arg_146_1.var_.characterEffect1037ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1037ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1037ui_story then
				arg_146_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["1080ui_story"]
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1080ui_story == nil then
				arg_146_1.var_.characterEffect1080ui_story = var_149_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.1

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 and not isNil(var_149_4) then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6

				if arg_146_1.var_.characterEffect1080ui_story and not isNil(var_149_4) then
					local var_149_8 = Mathf.Lerp(0, 0.5, var_149_7)

					arg_146_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1080ui_story.fillRatio = var_149_8
				end
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1080ui_story then
				local var_149_9 = 0.5

				arg_146_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1080ui_story.fillRatio = var_149_9
			end

			local var_149_10 = arg_146_1.actors_["1080ui_story"].transform
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.var_.moveOldPos1080ui_story = var_149_10.localPosition
			end

			local var_149_12 = 0.001

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12
				local var_149_14 = Vector3.New(0, -1.01, -6.05)

				var_149_10.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1080ui_story, var_149_14, var_149_13)

				local var_149_15 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_15.x, var_149_15.y, var_149_15.z)

				local var_149_16 = var_149_10.localEulerAngles

				var_149_16.z = 0
				var_149_16.x = 0
				var_149_10.localEulerAngles = var_149_16
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 then
				var_149_10.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_149_17 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_17.x, var_149_17.y, var_149_17.z)

				local var_149_18 = var_149_10.localEulerAngles

				var_149_18.z = 0
				var_149_18.x = 0
				var_149_10.localEulerAngles = var_149_18
			end

			local var_149_19 = arg_146_1.actors_["1080ui_story"].transform
			local var_149_20 = 0.033

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1.var_.moveOldPos1080ui_story = var_149_19.localPosition
			end

			local var_149_21 = 0.5

			if var_149_20 <= arg_146_1.time_ and arg_146_1.time_ < var_149_20 + var_149_21 then
				local var_149_22 = (arg_146_1.time_ - var_149_20) / var_149_21
				local var_149_23 = Vector3.New(-0.7, -1.01, -6.05)

				var_149_19.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1080ui_story, var_149_23, var_149_22)

				local var_149_24 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_24.x, var_149_24.y, var_149_24.z)

				local var_149_25 = var_149_19.localEulerAngles

				var_149_25.z = 0
				var_149_25.x = 0
				var_149_19.localEulerAngles = var_149_25
			end

			if arg_146_1.time_ >= var_149_20 + var_149_21 and arg_146_1.time_ < var_149_20 + var_149_21 + arg_149_0 then
				var_149_19.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_149_26 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_26.x, var_149_26.y, var_149_26.z)

				local var_149_27 = var_149_19.localEulerAngles

				var_149_27.z = 0
				var_149_27.x = 0
				var_149_19.localEulerAngles = var_149_27
			end

			local var_149_28 = arg_146_1.actors_["1037ui_story"].transform
			local var_149_29 = 0

			if var_149_29 < arg_146_1.time_ and arg_146_1.time_ <= var_149_29 + arg_149_0 then
				arg_146_1.var_.moveOldPos1037ui_story = var_149_28.localPosition
			end

			local var_149_30 = 0.001

			if var_149_29 <= arg_146_1.time_ and arg_146_1.time_ < var_149_29 + var_149_30 then
				local var_149_31 = (arg_146_1.time_ - var_149_29) / var_149_30
				local var_149_32 = Vector3.New(0.7, -1.09, -5.81)

				var_149_28.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1037ui_story, var_149_32, var_149_31)

				local var_149_33 = manager.ui.mainCamera.transform.position - var_149_28.position

				var_149_28.forward = Vector3.New(var_149_33.x, var_149_33.y, var_149_33.z)

				local var_149_34 = var_149_28.localEulerAngles

				var_149_34.z = 0
				var_149_34.x = 0
				var_149_28.localEulerAngles = var_149_34
			end

			if arg_146_1.time_ >= var_149_29 + var_149_30 and arg_146_1.time_ < var_149_29 + var_149_30 + arg_149_0 then
				var_149_28.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_149_35 = manager.ui.mainCamera.transform.position - var_149_28.position

				var_149_28.forward = Vector3.New(var_149_35.x, var_149_35.y, var_149_35.z)

				local var_149_36 = var_149_28.localEulerAngles

				var_149_36.z = 0
				var_149_36.x = 0
				var_149_28.localEulerAngles = var_149_36
			end

			local var_149_37 = 0

			if var_149_37 < arg_146_1.time_ and arg_146_1.time_ <= var_149_37 + arg_149_0 then
				arg_146_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_149_38 = 0

			if var_149_38 < arg_146_1.time_ and arg_146_1.time_ <= var_149_38 + arg_149_0 then
				arg_146_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_149_39 = 0
			local var_149_40 = 0.9

			if var_149_39 < arg_146_1.time_ and arg_146_1.time_ <= var_149_39 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_41 = arg_146_1:FormatText(StoryNameCfg[15].name)

				arg_146_1.leftNameTxt_.text = var_149_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_42 = arg_146_1:GetWordFromCfg(105101035)
				local var_149_43 = arg_146_1:FormatText(var_149_42.content)

				arg_146_1.text_.text = var_149_43

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_44 = 36
				local var_149_45 = utf8.len(var_149_43)
				local var_149_46 = var_149_44 <= 0 and var_149_40 or var_149_40 * (var_149_45 / var_149_44)

				if var_149_46 > 0 and var_149_40 < var_149_46 then
					arg_146_1.talkMaxDuration = var_149_46

					if var_149_46 + var_149_39 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_46 + var_149_39
					end
				end

				arg_146_1.text_.text = var_149_43
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101035", "story_v_out_105101.awb") ~= 0 then
					local var_149_47 = manager.audio:GetVoiceLength("story_v_out_105101", "105101035", "story_v_out_105101.awb") / 1000

					if var_149_47 + var_149_39 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_47 + var_149_39
					end

					if var_149_42.prefab_name ~= "" and arg_146_1.actors_[var_149_42.prefab_name] ~= nil then
						local var_149_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_42.prefab_name].transform, "story_v_out_105101", "105101035", "story_v_out_105101.awb")

						arg_146_1:RecordAudio("105101035", var_149_48)
						arg_146_1:RecordAudio("105101035", var_149_48)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_105101", "105101035", "story_v_out_105101.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_105101", "105101035", "story_v_out_105101.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_49 = math.max(var_149_40, arg_146_1.talkMaxDuration)

			if var_149_39 <= arg_146_1.time_ and arg_146_1.time_ < var_149_39 + var_149_49 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_39) / var_149_49

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_39 + var_149_49 and arg_146_1.time_ < var_149_39 + var_149_49 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_146_1:InitPlayNodeList()
	end,
	Play105101036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 105101036
		arg_150_1.duration_ = 9.17

		local var_150_0 = {
			ja = 9.166,
			ko = 6.133,
			zh = 5.966,
			en = 6.333
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
				arg_150_0:Play105101037(arg_150_1)
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

			local var_153_4 = arg_150_1.actors_["1037ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1037ui_story == nil then
				arg_150_1.var_.characterEffect1037ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1037ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1037ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1037ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1037ui_story.fillRatio = var_153_9
			end

			local var_153_10 = arg_150_1.actors_["1080ui_story"].transform
			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.var_.moveOldPos1080ui_story = var_153_10.localPosition
			end

			local var_153_12 = 0.001

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_11) / var_153_12
				local var_153_14 = Vector3.New(0, 100, 0)

				var_153_10.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1080ui_story, var_153_14, var_153_13)

				local var_153_15 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_15.x, var_153_15.y, var_153_15.z)

				local var_153_16 = var_153_10.localEulerAngles

				var_153_16.z = 0
				var_153_16.x = 0
				var_153_10.localEulerAngles = var_153_16
			end

			if arg_150_1.time_ >= var_153_11 + var_153_12 and arg_150_1.time_ < var_153_11 + var_153_12 + arg_153_0 then
				var_153_10.localPosition = Vector3.New(0, 100, 0)

				local var_153_17 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_17.x, var_153_17.y, var_153_17.z)

				local var_153_18 = var_153_10.localEulerAngles

				var_153_18.z = 0
				var_153_18.x = 0
				var_153_10.localEulerAngles = var_153_18
			end

			local var_153_19 = arg_150_1.actors_["1059ui_story"].transform
			local var_153_20 = 0

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.var_.moveOldPos1059ui_story = var_153_19.localPosition
			end

			local var_153_21 = 0.001

			if var_153_20 <= arg_150_1.time_ and arg_150_1.time_ < var_153_20 + var_153_21 then
				local var_153_22 = (arg_150_1.time_ - var_153_20) / var_153_21
				local var_153_23 = Vector3.New(-0.7, -1.05, -6)

				var_153_19.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1059ui_story, var_153_23, var_153_22)

				local var_153_24 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_24.x, var_153_24.y, var_153_24.z)

				local var_153_25 = var_153_19.localEulerAngles

				var_153_25.z = 0
				var_153_25.x = 0
				var_153_19.localEulerAngles = var_153_25
			end

			if arg_150_1.time_ >= var_153_20 + var_153_21 and arg_150_1.time_ < var_153_20 + var_153_21 + arg_153_0 then
				var_153_19.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_153_26 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_26.x, var_153_26.y, var_153_26.z)

				local var_153_27 = var_153_19.localEulerAngles

				var_153_27.z = 0
				var_153_27.x = 0
				var_153_19.localEulerAngles = var_153_27
			end

			local var_153_28 = 0

			if var_153_28 < arg_150_1.time_ and arg_150_1.time_ <= var_153_28 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_153_29 = 0

			if var_153_29 < arg_150_1.time_ and arg_150_1.time_ <= var_153_29 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_153_30 = 0
			local var_153_31 = 0.8

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_32 = arg_150_1:FormatText(StoryNameCfg[28].name)

				arg_150_1.leftNameTxt_.text = var_153_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_33 = arg_150_1:GetWordFromCfg(105101036)
				local var_153_34 = arg_150_1:FormatText(var_153_33.content)

				arg_150_1.text_.text = var_153_34

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_35 = 32
				local var_153_36 = utf8.len(var_153_34)
				local var_153_37 = var_153_35 <= 0 and var_153_31 or var_153_31 * (var_153_36 / var_153_35)

				if var_153_37 > 0 and var_153_31 < var_153_37 then
					arg_150_1.talkMaxDuration = var_153_37

					if var_153_37 + var_153_30 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_37 + var_153_30
					end
				end

				arg_150_1.text_.text = var_153_34
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101036", "story_v_out_105101.awb") ~= 0 then
					local var_153_38 = manager.audio:GetVoiceLength("story_v_out_105101", "105101036", "story_v_out_105101.awb") / 1000

					if var_153_38 + var_153_30 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_38 + var_153_30
					end

					if var_153_33.prefab_name ~= "" and arg_150_1.actors_[var_153_33.prefab_name] ~= nil then
						local var_153_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_33.prefab_name].transform, "story_v_out_105101", "105101036", "story_v_out_105101.awb")

						arg_150_1:RecordAudio("105101036", var_153_39)
						arg_150_1:RecordAudio("105101036", var_153_39)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_105101", "105101036", "story_v_out_105101.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_105101", "105101036", "story_v_out_105101.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_40 = math.max(var_153_31, arg_150_1.talkMaxDuration)

			if var_153_30 <= arg_150_1.time_ and arg_150_1.time_ < var_153_30 + var_153_40 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_30) / var_153_40

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_30 + var_153_40 and arg_150_1.time_ < var_153_30 + var_153_40 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play105101037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 105101037
		arg_154_1.duration_ = 10.4

		local var_154_0 = {
			ja = 9.166,
			ko = 9.8,
			zh = 10.4,
			en = 9.6
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
				arg_154_0:Play105101038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1037ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1037ui_story == nil then
				arg_154_1.var_.characterEffect1037ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.1

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1037ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1037ui_story then
				arg_154_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["1059ui_story"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1059ui_story == nil then
				arg_154_1.var_.characterEffect1059ui_story = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.1

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect1059ui_story and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1059ui_story.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1059ui_story then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1059ui_story.fillRatio = var_157_9
			end

			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action452")
			end

			local var_157_11 = 0

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_157_12 = 0
			local var_157_13 = 1.2

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_14 = arg_154_1:FormatText(StoryNameCfg[15].name)

				arg_154_1.leftNameTxt_.text = var_157_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_15 = arg_154_1:GetWordFromCfg(105101037)
				local var_157_16 = arg_154_1:FormatText(var_157_15.content)

				arg_154_1.text_.text = var_157_16

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 48
				local var_157_18 = utf8.len(var_157_16)
				local var_157_19 = var_157_17 <= 0 and var_157_13 or var_157_13 * (var_157_18 / var_157_17)

				if var_157_19 > 0 and var_157_13 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_16
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101037", "story_v_out_105101.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_out_105101", "105101037", "story_v_out_105101.awb") / 1000

					if var_157_20 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_12
					end

					if var_157_15.prefab_name ~= "" and arg_154_1.actors_[var_157_15.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_15.prefab_name].transform, "story_v_out_105101", "105101037", "story_v_out_105101.awb")

						arg_154_1:RecordAudio("105101037", var_157_21)
						arg_154_1:RecordAudio("105101037", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_105101", "105101037", "story_v_out_105101.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_105101", "105101037", "story_v_out_105101.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_22 and arg_154_1.time_ < var_157_12 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play105101038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 105101038
		arg_158_1.duration_ = 9.17

		local var_158_0 = {
			ja = 9.166,
			ko = 7.066,
			zh = 5.8,
			en = 4.8
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
				arg_158_0:Play105101039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = "1148ui_story"

			if arg_158_1.actors_[var_161_0] == nil then
				local var_161_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_161_1) then
					local var_161_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_158_1.stage_.transform)

					var_161_2.name = var_161_0
					var_161_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_158_1.actors_[var_161_0] = var_161_2

					local var_161_3 = var_161_2:GetComponentInChildren(typeof(CharacterEffect))

					var_161_3.enabled = true

					local var_161_4 = GameObjectTools.GetOrAddComponent(var_161_2, typeof(DynamicBoneHelper))

					if var_161_4 then
						var_161_4:EnableDynamicBone(false)
					end

					arg_158_1:ShowWeapon(var_161_3.transform, false)

					arg_158_1.var_[var_161_0 .. "Animator"] = var_161_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_158_1.var_[var_161_0 .. "Animator"].applyRootMotion = true
					arg_158_1.var_[var_161_0 .. "LipSync"] = var_161_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_161_5 = arg_158_1.actors_["1148ui_story"]
			local var_161_6 = 0

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1148ui_story == nil then
				arg_158_1.var_.characterEffect1148ui_story = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_7 = 0.1

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_7 and not isNil(var_161_5) then
				local var_161_8 = (arg_158_1.time_ - var_161_6) / var_161_7

				if arg_158_1.var_.characterEffect1148ui_story and not isNil(var_161_5) then
					arg_158_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_6 + var_161_7 and arg_158_1.time_ < var_161_6 + var_161_7 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1148ui_story then
				arg_158_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_161_9 = arg_158_1.actors_["1037ui_story"]
			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1037ui_story == nil then
				arg_158_1.var_.characterEffect1037ui_story = var_161_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_11 = 0.1

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_11 and not isNil(var_161_9) then
				local var_161_12 = (arg_158_1.time_ - var_161_10) / var_161_11

				if arg_158_1.var_.characterEffect1037ui_story and not isNil(var_161_9) then
					local var_161_13 = Mathf.Lerp(0, 0.5, var_161_12)

					arg_158_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1037ui_story.fillRatio = var_161_13
				end
			end

			if arg_158_1.time_ >= var_161_10 + var_161_11 and arg_158_1.time_ < var_161_10 + var_161_11 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1037ui_story then
				local var_161_14 = 0.5

				arg_158_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1037ui_story.fillRatio = var_161_14
			end

			local var_161_15 = arg_158_1.actors_["1037ui_story"].transform
			local var_161_16 = 0

			if var_161_16 < arg_158_1.time_ and arg_158_1.time_ <= var_161_16 + arg_161_0 then
				arg_158_1.var_.moveOldPos1037ui_story = var_161_15.localPosition
			end

			local var_161_17 = 0.001

			if var_161_16 <= arg_158_1.time_ and arg_158_1.time_ < var_161_16 + var_161_17 then
				local var_161_18 = (arg_158_1.time_ - var_161_16) / var_161_17
				local var_161_19 = Vector3.New(0, 100, 0)

				var_161_15.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1037ui_story, var_161_19, var_161_18)

				local var_161_20 = manager.ui.mainCamera.transform.position - var_161_15.position

				var_161_15.forward = Vector3.New(var_161_20.x, var_161_20.y, var_161_20.z)

				local var_161_21 = var_161_15.localEulerAngles

				var_161_21.z = 0
				var_161_21.x = 0
				var_161_15.localEulerAngles = var_161_21
			end

			if arg_158_1.time_ >= var_161_16 + var_161_17 and arg_158_1.time_ < var_161_16 + var_161_17 + arg_161_0 then
				var_161_15.localPosition = Vector3.New(0, 100, 0)

				local var_161_22 = manager.ui.mainCamera.transform.position - var_161_15.position

				var_161_15.forward = Vector3.New(var_161_22.x, var_161_22.y, var_161_22.z)

				local var_161_23 = var_161_15.localEulerAngles

				var_161_23.z = 0
				var_161_23.x = 0
				var_161_15.localEulerAngles = var_161_23
			end

			local var_161_24 = arg_158_1.actors_["1059ui_story"].transform
			local var_161_25 = 0

			if var_161_25 < arg_158_1.time_ and arg_158_1.time_ <= var_161_25 + arg_161_0 then
				arg_158_1.var_.moveOldPos1059ui_story = var_161_24.localPosition
			end

			local var_161_26 = 0.001

			if var_161_25 <= arg_158_1.time_ and arg_158_1.time_ < var_161_25 + var_161_26 then
				local var_161_27 = (arg_158_1.time_ - var_161_25) / var_161_26
				local var_161_28 = Vector3.New(0, 100, 0)

				var_161_24.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1059ui_story, var_161_28, var_161_27)

				local var_161_29 = manager.ui.mainCamera.transform.position - var_161_24.position

				var_161_24.forward = Vector3.New(var_161_29.x, var_161_29.y, var_161_29.z)

				local var_161_30 = var_161_24.localEulerAngles

				var_161_30.z = 0
				var_161_30.x = 0
				var_161_24.localEulerAngles = var_161_30
			end

			if arg_158_1.time_ >= var_161_25 + var_161_26 and arg_158_1.time_ < var_161_25 + var_161_26 + arg_161_0 then
				var_161_24.localPosition = Vector3.New(0, 100, 0)

				local var_161_31 = manager.ui.mainCamera.transform.position - var_161_24.position

				var_161_24.forward = Vector3.New(var_161_31.x, var_161_31.y, var_161_31.z)

				local var_161_32 = var_161_24.localEulerAngles

				var_161_32.z = 0
				var_161_32.x = 0
				var_161_24.localEulerAngles = var_161_32
			end

			local var_161_33 = arg_158_1.actors_["1148ui_story"].transform
			local var_161_34 = 0

			if var_161_34 < arg_158_1.time_ and arg_158_1.time_ <= var_161_34 + arg_161_0 then
				arg_158_1.var_.moveOldPos1148ui_story = var_161_33.localPosition
			end

			local var_161_35 = 0.001

			if var_161_34 <= arg_158_1.time_ and arg_158_1.time_ < var_161_34 + var_161_35 then
				local var_161_36 = (arg_158_1.time_ - var_161_34) / var_161_35
				local var_161_37 = Vector3.New(0, -0.8, -6.2)

				var_161_33.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1148ui_story, var_161_37, var_161_36)

				local var_161_38 = manager.ui.mainCamera.transform.position - var_161_33.position

				var_161_33.forward = Vector3.New(var_161_38.x, var_161_38.y, var_161_38.z)

				local var_161_39 = var_161_33.localEulerAngles

				var_161_39.z = 0
				var_161_39.x = 0
				var_161_33.localEulerAngles = var_161_39
			end

			if arg_158_1.time_ >= var_161_34 + var_161_35 and arg_158_1.time_ < var_161_34 + var_161_35 + arg_161_0 then
				var_161_33.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_161_40 = manager.ui.mainCamera.transform.position - var_161_33.position

				var_161_33.forward = Vector3.New(var_161_40.x, var_161_40.y, var_161_40.z)

				local var_161_41 = var_161_33.localEulerAngles

				var_161_41.z = 0
				var_161_41.x = 0
				var_161_33.localEulerAngles = var_161_41
			end

			local var_161_42 = 0

			if var_161_42 < arg_158_1.time_ and arg_158_1.time_ <= var_161_42 + arg_161_0 then
				arg_158_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_161_43 = 0

			if var_161_43 < arg_158_1.time_ and arg_158_1.time_ <= var_161_43 + arg_161_0 then
				arg_158_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_161_44 = 0
			local var_161_45 = 0.75

			if var_161_44 < arg_158_1.time_ and arg_158_1.time_ <= var_161_44 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_46 = arg_158_1:FormatText(StoryNameCfg[8].name)

				arg_158_1.leftNameTxt_.text = var_161_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_47 = arg_158_1:GetWordFromCfg(105101038)
				local var_161_48 = arg_158_1:FormatText(var_161_47.content)

				arg_158_1.text_.text = var_161_48

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_49 = 30
				local var_161_50 = utf8.len(var_161_48)
				local var_161_51 = var_161_49 <= 0 and var_161_45 or var_161_45 * (var_161_50 / var_161_49)

				if var_161_51 > 0 and var_161_45 < var_161_51 then
					arg_158_1.talkMaxDuration = var_161_51

					if var_161_51 + var_161_44 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_51 + var_161_44
					end
				end

				arg_158_1.text_.text = var_161_48
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101038", "story_v_out_105101.awb") ~= 0 then
					local var_161_52 = manager.audio:GetVoiceLength("story_v_out_105101", "105101038", "story_v_out_105101.awb") / 1000

					if var_161_52 + var_161_44 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_52 + var_161_44
					end

					if var_161_47.prefab_name ~= "" and arg_158_1.actors_[var_161_47.prefab_name] ~= nil then
						local var_161_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_47.prefab_name].transform, "story_v_out_105101", "105101038", "story_v_out_105101.awb")

						arg_158_1:RecordAudio("105101038", var_161_53)
						arg_158_1:RecordAudio("105101038", var_161_53)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_105101", "105101038", "story_v_out_105101.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_105101", "105101038", "story_v_out_105101.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_54 = math.max(var_161_45, arg_158_1.talkMaxDuration)

			if var_161_44 <= arg_158_1.time_ and arg_158_1.time_ < var_161_44 + var_161_54 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_44) / var_161_54

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_44 + var_161_54 and arg_158_1.time_ < var_161_44 + var_161_54 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play105101039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 105101039
		arg_162_1.duration_ = 1.6

		local var_162_0 = {
			ja = 1.4,
			ko = 0.966,
			zh = 1.6,
			en = 1.033
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
				arg_162_0:Play105101040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1080ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1080ui_story == nil then
				arg_162_1.var_.characterEffect1080ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.1

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1080ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1080ui_story then
				arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["1148ui_story"]
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1148ui_story == nil then
				arg_162_1.var_.characterEffect1148ui_story = var_165_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.1

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 and not isNil(var_165_4) then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6

				if arg_162_1.var_.characterEffect1148ui_story and not isNil(var_165_4) then
					local var_165_8 = Mathf.Lerp(0, 0.5, var_165_7)

					arg_162_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1148ui_story.fillRatio = var_165_8
				end
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1148ui_story then
				local var_165_9 = 0.5

				arg_162_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1148ui_story.fillRatio = var_165_9
			end

			local var_165_10 = 0
			local var_165_11 = 0.1

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_12 = arg_162_1:FormatText(StoryNameCfg[55].name)

				arg_162_1.leftNameTxt_.text = var_165_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_13 = arg_162_1:GetWordFromCfg(105101039)
				local var_165_14 = arg_162_1:FormatText(var_165_13.content)

				arg_162_1.text_.text = var_165_14

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 4
				local var_165_16 = utf8.len(var_165_14)
				local var_165_17 = var_165_15 <= 0 and var_165_11 or var_165_11 * (var_165_16 / var_165_15)

				if var_165_17 > 0 and var_165_11 < var_165_17 then
					arg_162_1.talkMaxDuration = var_165_17

					if var_165_17 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_10
					end
				end

				arg_162_1.text_.text = var_165_14
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101039", "story_v_out_105101.awb") ~= 0 then
					local var_165_18 = manager.audio:GetVoiceLength("story_v_out_105101", "105101039", "story_v_out_105101.awb") / 1000

					if var_165_18 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_18 + var_165_10
					end

					if var_165_13.prefab_name ~= "" and arg_162_1.actors_[var_165_13.prefab_name] ~= nil then
						local var_165_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_13.prefab_name].transform, "story_v_out_105101", "105101039", "story_v_out_105101.awb")

						arg_162_1:RecordAudio("105101039", var_165_19)
						arg_162_1:RecordAudio("105101039", var_165_19)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_105101", "105101039", "story_v_out_105101.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_105101", "105101039", "story_v_out_105101.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_20 = math.max(var_165_11, arg_162_1.talkMaxDuration)

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_20 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_10) / var_165_20

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_10 + var_165_20 and arg_162_1.time_ < var_165_10 + var_165_20 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play105101040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 105101040
		arg_166_1.duration_ = 6.07

		local var_166_0 = {
			ja = 6.066,
			ko = 3.766,
			zh = 4.066,
			en = 4.066
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
				arg_166_0:Play105101041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1148ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1148ui_story == nil then
				arg_166_1.var_.characterEffect1148ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.1

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1148ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1148ui_story then
				arg_166_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1080ui_story"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1080ui_story == nil then
				arg_166_1.var_.characterEffect1080ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.1

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.characterEffect1080ui_story and not isNil(var_169_4) then
					local var_169_8 = Mathf.Lerp(0, 0.5, var_169_7)

					arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1080ui_story.fillRatio = var_169_8
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1080ui_story then
				local var_169_9 = 0.5

				arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1080ui_story.fillRatio = var_169_9
			end

			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_169_11 = 0

			if var_169_11 < arg_166_1.time_ and arg_166_1.time_ <= var_169_11 + arg_169_0 then
				arg_166_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_169_12 = 0
			local var_169_13 = 0.475

			if var_169_12 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_14 = arg_166_1:FormatText(StoryNameCfg[8].name)

				arg_166_1.leftNameTxt_.text = var_169_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_15 = arg_166_1:GetWordFromCfg(105101040)
				local var_169_16 = arg_166_1:FormatText(var_169_15.content)

				arg_166_1.text_.text = var_169_16

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_17 = 19
				local var_169_18 = utf8.len(var_169_16)
				local var_169_19 = var_169_17 <= 0 and var_169_13 or var_169_13 * (var_169_18 / var_169_17)

				if var_169_19 > 0 and var_169_13 < var_169_19 then
					arg_166_1.talkMaxDuration = var_169_19

					if var_169_19 + var_169_12 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_19 + var_169_12
					end
				end

				arg_166_1.text_.text = var_169_16
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101040", "story_v_out_105101.awb") ~= 0 then
					local var_169_20 = manager.audio:GetVoiceLength("story_v_out_105101", "105101040", "story_v_out_105101.awb") / 1000

					if var_169_20 + var_169_12 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_20 + var_169_12
					end

					if var_169_15.prefab_name ~= "" and arg_166_1.actors_[var_169_15.prefab_name] ~= nil then
						local var_169_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_15.prefab_name].transform, "story_v_out_105101", "105101040", "story_v_out_105101.awb")

						arg_166_1:RecordAudio("105101040", var_169_21)
						arg_166_1:RecordAudio("105101040", var_169_21)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_105101", "105101040", "story_v_out_105101.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_105101", "105101040", "story_v_out_105101.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_22 = math.max(var_169_13, arg_166_1.talkMaxDuration)

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_22 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_12) / var_169_22

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_12 + var_169_22 and arg_166_1.time_ < var_169_12 + var_169_22 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play105101041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 105101041
		arg_170_1.duration_ = 6.2

		local var_170_0 = {
			ja = 5.533,
			ko = 4.4,
			zh = 4.666,
			en = 6.2
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
				arg_170_0:Play105101042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1080ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1080ui_story == nil then
				arg_170_1.var_.characterEffect1080ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.1

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1080ui_story and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1080ui_story then
				arg_170_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_173_4 = arg_170_1.actors_["1148ui_story"]
			local var_173_5 = 0

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1148ui_story == nil then
				arg_170_1.var_.characterEffect1148ui_story = var_173_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_6 = 0.1

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_6 and not isNil(var_173_4) then
				local var_173_7 = (arg_170_1.time_ - var_173_5) / var_173_6

				if arg_170_1.var_.characterEffect1148ui_story and not isNil(var_173_4) then
					local var_173_8 = Mathf.Lerp(0, 0.5, var_173_7)

					arg_170_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1148ui_story.fillRatio = var_173_8
				end
			end

			if arg_170_1.time_ >= var_173_5 + var_173_6 and arg_170_1.time_ < var_173_5 + var_173_6 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.characterEffect1148ui_story then
				local var_173_9 = 0.5

				arg_170_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1148ui_story.fillRatio = var_173_9
			end

			local var_173_10 = arg_170_1.actors_["1148ui_story"].transform
			local var_173_11 = 0

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				arg_170_1.var_.moveOldPos1148ui_story = var_173_10.localPosition
			end

			local var_173_12 = 0.001

			if var_173_11 <= arg_170_1.time_ and arg_170_1.time_ < var_173_11 + var_173_12 then
				local var_173_13 = (arg_170_1.time_ - var_173_11) / var_173_12
				local var_173_14 = Vector3.New(0, -0.8, -6.2)

				var_173_10.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1148ui_story, var_173_14, var_173_13)

				local var_173_15 = manager.ui.mainCamera.transform.position - var_173_10.position

				var_173_10.forward = Vector3.New(var_173_15.x, var_173_15.y, var_173_15.z)

				local var_173_16 = var_173_10.localEulerAngles

				var_173_16.z = 0
				var_173_16.x = 0
				var_173_10.localEulerAngles = var_173_16
			end

			if arg_170_1.time_ >= var_173_11 + var_173_12 and arg_170_1.time_ < var_173_11 + var_173_12 + arg_173_0 then
				var_173_10.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_173_17 = manager.ui.mainCamera.transform.position - var_173_10.position

				var_173_10.forward = Vector3.New(var_173_17.x, var_173_17.y, var_173_17.z)

				local var_173_18 = var_173_10.localEulerAngles

				var_173_18.z = 0
				var_173_18.x = 0
				var_173_10.localEulerAngles = var_173_18
			end

			local var_173_19 = arg_170_1.actors_["1148ui_story"].transform
			local var_173_20 = 0.033

			if var_173_20 < arg_170_1.time_ and arg_170_1.time_ <= var_173_20 + arg_173_0 then
				arg_170_1.var_.moveOldPos1148ui_story = var_173_19.localPosition
			end

			local var_173_21 = 0.5

			if var_173_20 <= arg_170_1.time_ and arg_170_1.time_ < var_173_20 + var_173_21 then
				local var_173_22 = (arg_170_1.time_ - var_173_20) / var_173_21
				local var_173_23 = Vector3.New(0.7, -0.8, -6.2)

				var_173_19.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1148ui_story, var_173_23, var_173_22)

				local var_173_24 = manager.ui.mainCamera.transform.position - var_173_19.position

				var_173_19.forward = Vector3.New(var_173_24.x, var_173_24.y, var_173_24.z)

				local var_173_25 = var_173_19.localEulerAngles

				var_173_25.z = 0
				var_173_25.x = 0
				var_173_19.localEulerAngles = var_173_25
			end

			if arg_170_1.time_ >= var_173_20 + var_173_21 and arg_170_1.time_ < var_173_20 + var_173_21 + arg_173_0 then
				var_173_19.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_173_26 = manager.ui.mainCamera.transform.position - var_173_19.position

				var_173_19.forward = Vector3.New(var_173_26.x, var_173_26.y, var_173_26.z)

				local var_173_27 = var_173_19.localEulerAngles

				var_173_27.z = 0
				var_173_27.x = 0
				var_173_19.localEulerAngles = var_173_27
			end

			local var_173_28 = arg_170_1.actors_["1080ui_story"].transform
			local var_173_29 = 0

			if var_173_29 < arg_170_1.time_ and arg_170_1.time_ <= var_173_29 + arg_173_0 then
				arg_170_1.var_.moveOldPos1080ui_story = var_173_28.localPosition
			end

			local var_173_30 = 0.001

			if var_173_29 <= arg_170_1.time_ and arg_170_1.time_ < var_173_29 + var_173_30 then
				local var_173_31 = (arg_170_1.time_ - var_173_29) / var_173_30
				local var_173_32 = Vector3.New(-0.7, -1.01, -6.05)

				var_173_28.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1080ui_story, var_173_32, var_173_31)

				local var_173_33 = manager.ui.mainCamera.transform.position - var_173_28.position

				var_173_28.forward = Vector3.New(var_173_33.x, var_173_33.y, var_173_33.z)

				local var_173_34 = var_173_28.localEulerAngles

				var_173_34.z = 0
				var_173_34.x = 0
				var_173_28.localEulerAngles = var_173_34
			end

			if arg_170_1.time_ >= var_173_29 + var_173_30 and arg_170_1.time_ < var_173_29 + var_173_30 + arg_173_0 then
				var_173_28.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_173_35 = manager.ui.mainCamera.transform.position - var_173_28.position

				var_173_28.forward = Vector3.New(var_173_35.x, var_173_35.y, var_173_35.z)

				local var_173_36 = var_173_28.localEulerAngles

				var_173_36.z = 0
				var_173_36.x = 0
				var_173_28.localEulerAngles = var_173_36
			end

			local var_173_37 = 0

			if var_173_37 < arg_170_1.time_ and arg_170_1.time_ <= var_173_37 + arg_173_0 then
				arg_170_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_173_38 = 0
			local var_173_39 = 0.6

			if var_173_38 < arg_170_1.time_ and arg_170_1.time_ <= var_173_38 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_40 = arg_170_1:FormatText(StoryNameCfg[55].name)

				arg_170_1.leftNameTxt_.text = var_173_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_41 = arg_170_1:GetWordFromCfg(105101041)
				local var_173_42 = arg_170_1:FormatText(var_173_41.content)

				arg_170_1.text_.text = var_173_42

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_43 = 23
				local var_173_44 = utf8.len(var_173_42)
				local var_173_45 = var_173_43 <= 0 and var_173_39 or var_173_39 * (var_173_44 / var_173_43)

				if var_173_45 > 0 and var_173_39 < var_173_45 then
					arg_170_1.talkMaxDuration = var_173_45

					if var_173_45 + var_173_38 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_45 + var_173_38
					end
				end

				arg_170_1.text_.text = var_173_42
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101041", "story_v_out_105101.awb") ~= 0 then
					local var_173_46 = manager.audio:GetVoiceLength("story_v_out_105101", "105101041", "story_v_out_105101.awb") / 1000

					if var_173_46 + var_173_38 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_46 + var_173_38
					end

					if var_173_41.prefab_name ~= "" and arg_170_1.actors_[var_173_41.prefab_name] ~= nil then
						local var_173_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_41.prefab_name].transform, "story_v_out_105101", "105101041", "story_v_out_105101.awb")

						arg_170_1:RecordAudio("105101041", var_173_47)
						arg_170_1:RecordAudio("105101041", var_173_47)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_105101", "105101041", "story_v_out_105101.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_105101", "105101041", "story_v_out_105101.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_48 = math.max(var_173_39, arg_170_1.talkMaxDuration)

			if var_173_38 <= arg_170_1.time_ and arg_170_1.time_ < var_173_38 + var_173_48 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_38) / var_173_48

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_38 + var_173_48 and arg_170_1.time_ < var_173_38 + var_173_48 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play105101042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 105101042
		arg_174_1.duration_ = 5.57

		local var_174_0 = {
			ja = 5.566,
			ko = 4.433,
			zh = 4.1,
			en = 3.266
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
				arg_174_0:Play105101043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1027ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1027ui_story == nil then
				arg_174_1.var_.characterEffect1027ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.1

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1027ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1027ui_story then
				arg_174_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_177_4 = arg_174_1.actors_["1148ui_story"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1148ui_story == nil then
				arg_174_1.var_.characterEffect1148ui_story = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.1

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.characterEffect1148ui_story and not isNil(var_177_4) then
					local var_177_8 = Mathf.Lerp(0, 0.5, var_177_7)

					arg_174_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1148ui_story.fillRatio = var_177_8
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1148ui_story then
				local var_177_9 = 0.5

				arg_174_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1148ui_story.fillRatio = var_177_9
			end

			local var_177_10 = arg_174_1.actors_["1080ui_story"].transform
			local var_177_11 = 0

			if var_177_11 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				arg_174_1.var_.moveOldPos1080ui_story = var_177_10.localPosition
			end

			local var_177_12 = 0.001

			if var_177_11 <= arg_174_1.time_ and arg_174_1.time_ < var_177_11 + var_177_12 then
				local var_177_13 = (arg_174_1.time_ - var_177_11) / var_177_12
				local var_177_14 = Vector3.New(0, 100, 0)

				var_177_10.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1080ui_story, var_177_14, var_177_13)

				local var_177_15 = manager.ui.mainCamera.transform.position - var_177_10.position

				var_177_10.forward = Vector3.New(var_177_15.x, var_177_15.y, var_177_15.z)

				local var_177_16 = var_177_10.localEulerAngles

				var_177_16.z = 0
				var_177_16.x = 0
				var_177_10.localEulerAngles = var_177_16
			end

			if arg_174_1.time_ >= var_177_11 + var_177_12 and arg_174_1.time_ < var_177_11 + var_177_12 + arg_177_0 then
				var_177_10.localPosition = Vector3.New(0, 100, 0)

				local var_177_17 = manager.ui.mainCamera.transform.position - var_177_10.position

				var_177_10.forward = Vector3.New(var_177_17.x, var_177_17.y, var_177_17.z)

				local var_177_18 = var_177_10.localEulerAngles

				var_177_18.z = 0
				var_177_18.x = 0
				var_177_10.localEulerAngles = var_177_18
			end

			local var_177_19 = arg_174_1.actors_["1027ui_story"].transform
			local var_177_20 = 0

			if var_177_20 < arg_174_1.time_ and arg_174_1.time_ <= var_177_20 + arg_177_0 then
				arg_174_1.var_.moveOldPos1027ui_story = var_177_19.localPosition
			end

			local var_177_21 = 0.001

			if var_177_20 <= arg_174_1.time_ and arg_174_1.time_ < var_177_20 + var_177_21 then
				local var_177_22 = (arg_174_1.time_ - var_177_20) / var_177_21
				local var_177_23 = Vector3.New(-0.7, -0.81, -5.8)

				var_177_19.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1027ui_story, var_177_23, var_177_22)

				local var_177_24 = manager.ui.mainCamera.transform.position - var_177_19.position

				var_177_19.forward = Vector3.New(var_177_24.x, var_177_24.y, var_177_24.z)

				local var_177_25 = var_177_19.localEulerAngles

				var_177_25.z = 0
				var_177_25.x = 0
				var_177_19.localEulerAngles = var_177_25
			end

			if arg_174_1.time_ >= var_177_20 + var_177_21 and arg_174_1.time_ < var_177_20 + var_177_21 + arg_177_0 then
				var_177_19.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_177_26 = manager.ui.mainCamera.transform.position - var_177_19.position

				var_177_19.forward = Vector3.New(var_177_26.x, var_177_26.y, var_177_26.z)

				local var_177_27 = var_177_19.localEulerAngles

				var_177_27.z = 0
				var_177_27.x = 0
				var_177_19.localEulerAngles = var_177_27
			end

			local var_177_28 = 0

			if var_177_28 < arg_174_1.time_ and arg_174_1.time_ <= var_177_28 + arg_177_0 then
				arg_174_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_177_29 = 0

			if var_177_29 < arg_174_1.time_ and arg_174_1.time_ <= var_177_29 + arg_177_0 then
				arg_174_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_177_30 = 0
			local var_177_31 = 0.525

			if var_177_30 < arg_174_1.time_ and arg_174_1.time_ <= var_177_30 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_32 = arg_174_1:FormatText(StoryNameCfg[56].name)

				arg_174_1.leftNameTxt_.text = var_177_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_33 = arg_174_1:GetWordFromCfg(105101042)
				local var_177_34 = arg_174_1:FormatText(var_177_33.content)

				arg_174_1.text_.text = var_177_34

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_35 = 21
				local var_177_36 = utf8.len(var_177_34)
				local var_177_37 = var_177_35 <= 0 and var_177_31 or var_177_31 * (var_177_36 / var_177_35)

				if var_177_37 > 0 and var_177_31 < var_177_37 then
					arg_174_1.talkMaxDuration = var_177_37

					if var_177_37 + var_177_30 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_37 + var_177_30
					end
				end

				arg_174_1.text_.text = var_177_34
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101042", "story_v_out_105101.awb") ~= 0 then
					local var_177_38 = manager.audio:GetVoiceLength("story_v_out_105101", "105101042", "story_v_out_105101.awb") / 1000

					if var_177_38 + var_177_30 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_38 + var_177_30
					end

					if var_177_33.prefab_name ~= "" and arg_174_1.actors_[var_177_33.prefab_name] ~= nil then
						local var_177_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_33.prefab_name].transform, "story_v_out_105101", "105101042", "story_v_out_105101.awb")

						arg_174_1:RecordAudio("105101042", var_177_39)
						arg_174_1:RecordAudio("105101042", var_177_39)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_105101", "105101042", "story_v_out_105101.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_105101", "105101042", "story_v_out_105101.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_40 = math.max(var_177_31, arg_174_1.talkMaxDuration)

			if var_177_30 <= arg_174_1.time_ and arg_174_1.time_ < var_177_30 + var_177_40 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_30) / var_177_40

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_30 + var_177_40 and arg_174_1.time_ < var_177_30 + var_177_40 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play105101043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 105101043
		arg_178_1.duration_ = 5.27

		local var_178_0 = {
			ja = 5.266,
			ko = 2.3,
			zh = 2.4,
			en = 3.2
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
				arg_178_0:Play105101044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1148ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1148ui_story == nil then
				arg_178_1.var_.characterEffect1148ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.1

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1148ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1148ui_story then
				arg_178_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1027ui_story"]
			local var_181_5 = 0

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1027ui_story == nil then
				arg_178_1.var_.characterEffect1027ui_story = var_181_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.1

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 and not isNil(var_181_4) then
				local var_181_7 = (arg_178_1.time_ - var_181_5) / var_181_6

				if arg_178_1.var_.characterEffect1027ui_story and not isNil(var_181_4) then
					local var_181_8 = Mathf.Lerp(0, 0.5, var_181_7)

					arg_178_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1027ui_story.fillRatio = var_181_8
				end
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1027ui_story then
				local var_181_9 = 0.5

				arg_178_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1027ui_story.fillRatio = var_181_9
			end

			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action479")
			end

			local var_181_11 = 0

			if var_181_11 < arg_178_1.time_ and arg_178_1.time_ <= var_181_11 + arg_181_0 then
				arg_178_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_181_12 = 0
			local var_181_13 = 0.25

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_14 = arg_178_1:FormatText(StoryNameCfg[8].name)

				arg_178_1.leftNameTxt_.text = var_181_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_15 = arg_178_1:GetWordFromCfg(105101043)
				local var_181_16 = arg_178_1:FormatText(var_181_15.content)

				arg_178_1.text_.text = var_181_16

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_17 = 10
				local var_181_18 = utf8.len(var_181_16)
				local var_181_19 = var_181_17 <= 0 and var_181_13 or var_181_13 * (var_181_18 / var_181_17)

				if var_181_19 > 0 and var_181_13 < var_181_19 then
					arg_178_1.talkMaxDuration = var_181_19

					if var_181_19 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_19 + var_181_12
					end
				end

				arg_178_1.text_.text = var_181_16
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101043", "story_v_out_105101.awb") ~= 0 then
					local var_181_20 = manager.audio:GetVoiceLength("story_v_out_105101", "105101043", "story_v_out_105101.awb") / 1000

					if var_181_20 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_20 + var_181_12
					end

					if var_181_15.prefab_name ~= "" and arg_178_1.actors_[var_181_15.prefab_name] ~= nil then
						local var_181_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_15.prefab_name].transform, "story_v_out_105101", "105101043", "story_v_out_105101.awb")

						arg_178_1:RecordAudio("105101043", var_181_21)
						arg_178_1:RecordAudio("105101043", var_181_21)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_105101", "105101043", "story_v_out_105101.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_105101", "105101043", "story_v_out_105101.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_22 = math.max(var_181_13, arg_178_1.talkMaxDuration)

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_22 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_12) / var_181_22

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_12 + var_181_22 and arg_178_1.time_ < var_181_12 + var_181_22 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play105101044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 105101044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play105101045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1148ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1148ui_story == nil then
				arg_182_1.var_.characterEffect1148ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.1

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1148ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1148ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1148ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1148ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1148ui_story"].transform
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.var_.moveOldPos1148ui_story = var_185_6.localPosition
			end

			local var_185_8 = 0.001

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8
				local var_185_10 = Vector3.New(0, 100, 0)

				var_185_6.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1148ui_story, var_185_10, var_185_9)

				local var_185_11 = manager.ui.mainCamera.transform.position - var_185_6.position

				var_185_6.forward = Vector3.New(var_185_11.x, var_185_11.y, var_185_11.z)

				local var_185_12 = var_185_6.localEulerAngles

				var_185_12.z = 0
				var_185_12.x = 0
				var_185_6.localEulerAngles = var_185_12
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 then
				var_185_6.localPosition = Vector3.New(0, 100, 0)

				local var_185_13 = manager.ui.mainCamera.transform.position - var_185_6.position

				var_185_6.forward = Vector3.New(var_185_13.x, var_185_13.y, var_185_13.z)

				local var_185_14 = var_185_6.localEulerAngles

				var_185_14.z = 0
				var_185_14.x = 0
				var_185_6.localEulerAngles = var_185_14
			end

			local var_185_15 = arg_182_1.actors_["1027ui_story"].transform
			local var_185_16 = 0

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.var_.moveOldPos1027ui_story = var_185_15.localPosition
			end

			local var_185_17 = 0.001

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_17 then
				local var_185_18 = (arg_182_1.time_ - var_185_16) / var_185_17
				local var_185_19 = Vector3.New(0, 100, 0)

				var_185_15.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1027ui_story, var_185_19, var_185_18)

				local var_185_20 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_20.x, var_185_20.y, var_185_20.z)

				local var_185_21 = var_185_15.localEulerAngles

				var_185_21.z = 0
				var_185_21.x = 0
				var_185_15.localEulerAngles = var_185_21
			end

			if arg_182_1.time_ >= var_185_16 + var_185_17 and arg_182_1.time_ < var_185_16 + var_185_17 + arg_185_0 then
				var_185_15.localPosition = Vector3.New(0, 100, 0)

				local var_185_22 = manager.ui.mainCamera.transform.position - var_185_15.position

				var_185_15.forward = Vector3.New(var_185_22.x, var_185_22.y, var_185_22.z)

				local var_185_23 = var_185_15.localEulerAngles

				var_185_23.z = 0
				var_185_23.x = 0
				var_185_15.localEulerAngles = var_185_23
			end

			local var_185_24 = 0
			local var_185_25 = 0.75

			if var_185_24 < arg_182_1.time_ and arg_182_1.time_ <= var_185_24 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_26 = arg_182_1:GetWordFromCfg(105101044)
				local var_185_27 = arg_182_1:FormatText(var_185_26.content)

				arg_182_1.text_.text = var_185_27

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_28 = 30
				local var_185_29 = utf8.len(var_185_27)
				local var_185_30 = var_185_28 <= 0 and var_185_25 or var_185_25 * (var_185_29 / var_185_28)

				if var_185_30 > 0 and var_185_25 < var_185_30 then
					arg_182_1.talkMaxDuration = var_185_30

					if var_185_30 + var_185_24 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_30 + var_185_24
					end
				end

				arg_182_1.text_.text = var_185_27
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_31 = math.max(var_185_25, arg_182_1.talkMaxDuration)

			if var_185_24 <= arg_182_1.time_ and arg_182_1.time_ < var_185_24 + var_185_31 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_24) / var_185_31

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_24 + var_185_31 and arg_182_1.time_ < var_185_24 + var_185_31 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play105101045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 105101045
		arg_186_1.duration_ = 3.4

		local var_186_0 = {
			ja = 1.999999999999,
			ko = 3,
			zh = 3.4,
			en = 3.4
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
				arg_186_0:Play105101046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1080ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1080ui_story == nil then
				arg_186_1.var_.characterEffect1080ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.1

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1080ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1080ui_story then
				arg_186_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_189_4 = arg_186_1.actors_["1080ui_story"].transform
			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.var_.moveOldPos1080ui_story = var_189_4.localPosition
			end

			local var_189_6 = 0.001

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6
				local var_189_8 = Vector3.New(0, -1.01, -6.05)

				var_189_4.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1080ui_story, var_189_8, var_189_7)

				local var_189_9 = manager.ui.mainCamera.transform.position - var_189_4.position

				var_189_4.forward = Vector3.New(var_189_9.x, var_189_9.y, var_189_9.z)

				local var_189_10 = var_189_4.localEulerAngles

				var_189_10.z = 0
				var_189_10.x = 0
				var_189_4.localEulerAngles = var_189_10
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 then
				var_189_4.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_189_11 = manager.ui.mainCamera.transform.position - var_189_4.position

				var_189_4.forward = Vector3.New(var_189_11.x, var_189_11.y, var_189_11.z)

				local var_189_12 = var_189_4.localEulerAngles

				var_189_12.z = 0
				var_189_12.x = 0
				var_189_4.localEulerAngles = var_189_12
			end

			local var_189_13 = 0

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_189_15 = 0
			local var_189_16 = 0.3

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[55].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(105101045)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101045", "story_v_out_105101.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_out_105101", "105101045", "story_v_out_105101.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_out_105101", "105101045", "story_v_out_105101.awb")

						arg_186_1:RecordAudio("105101045", var_189_24)
						arg_186_1:RecordAudio("105101045", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_105101", "105101045", "story_v_out_105101.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_105101", "105101045", "story_v_out_105101.awb")
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
				actorName = "1080ui_story",
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
	Play105101046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 105101046
		arg_190_1.duration_ = 2.3

		local var_190_0 = {
			ja = 2.3,
			ko = 1.1,
			zh = 1.366,
			en = 1.1
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
				arg_190_0:Play105101047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1148ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1148ui_story == nil then
				arg_190_1.var_.characterEffect1148ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.1

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1148ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1148ui_story then
				arg_190_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1080ui_story"].transform
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.var_.moveOldPos1080ui_story = var_193_4.localPosition
			end

			local var_193_6 = 0.001

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6
				local var_193_8 = Vector3.New(0, 100, 0)

				var_193_4.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1080ui_story, var_193_8, var_193_7)

				local var_193_9 = manager.ui.mainCamera.transform.position - var_193_4.position

				var_193_4.forward = Vector3.New(var_193_9.x, var_193_9.y, var_193_9.z)

				local var_193_10 = var_193_4.localEulerAngles

				var_193_10.z = 0
				var_193_10.x = 0
				var_193_4.localEulerAngles = var_193_10
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 then
				var_193_4.localPosition = Vector3.New(0, 100, 0)

				local var_193_11 = manager.ui.mainCamera.transform.position - var_193_4.position

				var_193_4.forward = Vector3.New(var_193_11.x, var_193_11.y, var_193_11.z)

				local var_193_12 = var_193_4.localEulerAngles

				var_193_12.z = 0
				var_193_12.x = 0
				var_193_4.localEulerAngles = var_193_12
			end

			local var_193_13 = 0
			local var_193_14 = 0.1

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_15 = arg_190_1:FormatText(StoryNameCfg[8].name)

				arg_190_1.leftNameTxt_.text = var_193_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_16 = arg_190_1:GetWordFromCfg(105101046)
				local var_193_17 = arg_190_1:FormatText(var_193_16.content)

				arg_190_1.text_.text = var_193_17

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_18 = 4
				local var_193_19 = utf8.len(var_193_17)
				local var_193_20 = var_193_18 <= 0 and var_193_14 or var_193_14 * (var_193_19 / var_193_18)

				if var_193_20 > 0 and var_193_14 < var_193_20 then
					arg_190_1.talkMaxDuration = var_193_20

					if var_193_20 + var_193_13 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_20 + var_193_13
					end
				end

				arg_190_1.text_.text = var_193_17
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101046", "story_v_out_105101.awb") ~= 0 then
					local var_193_21 = manager.audio:GetVoiceLength("story_v_out_105101", "105101046", "story_v_out_105101.awb") / 1000

					if var_193_21 + var_193_13 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_21 + var_193_13
					end

					if var_193_16.prefab_name ~= "" and arg_190_1.actors_[var_193_16.prefab_name] ~= nil then
						local var_193_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_16.prefab_name].transform, "story_v_out_105101", "105101046", "story_v_out_105101.awb")

						arg_190_1:RecordAudio("105101046", var_193_22)
						arg_190_1:RecordAudio("105101046", var_193_22)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_105101", "105101046", "story_v_out_105101.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_105101", "105101046", "story_v_out_105101.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_23 = math.max(var_193_14, arg_190_1.talkMaxDuration)

			if var_193_13 <= arg_190_1.time_ and arg_190_1.time_ < var_193_13 + var_193_23 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_13) / var_193_23

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_13 + var_193_23 and arg_190_1.time_ < var_193_13 + var_193_23 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play105101047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 105101047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play105101048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1148ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1148ui_story == nil then
				arg_194_1.var_.characterEffect1148ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.1

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1148ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1148ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1148ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1148ui_story.fillRatio = var_197_5
			end

			local var_197_6 = 0
			local var_197_7 = 0.35

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_8

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

				local var_197_9 = arg_194_1:GetWordFromCfg(105101047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 14
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_14 and arg_194_1.time_ < var_197_6 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play105101048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 105101048
		arg_198_1.duration_ = 4.2

		local var_198_0 = {
			ja = 2.8,
			ko = 3.233,
			zh = 3.666,
			en = 4.2
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play105101049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1148ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1148ui_story == nil then
				arg_198_1.var_.characterEffect1148ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.1

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1148ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1148ui_story then
				arg_198_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_201_4 = arg_198_1.actors_["1148ui_story"].transform
			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.var_.moveOldPos1148ui_story = var_201_4.localPosition
			end

			local var_201_6 = 0.001

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6
				local var_201_8 = Vector3.New(0, -0.8, -6.2)

				var_201_4.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1148ui_story, var_201_8, var_201_7)

				local var_201_9 = manager.ui.mainCamera.transform.position - var_201_4.position

				var_201_4.forward = Vector3.New(var_201_9.x, var_201_9.y, var_201_9.z)

				local var_201_10 = var_201_4.localEulerAngles

				var_201_10.z = 0
				var_201_10.x = 0
				var_201_4.localEulerAngles = var_201_10
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				var_201_4.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_201_11 = manager.ui.mainCamera.transform.position - var_201_4.position

				var_201_4.forward = Vector3.New(var_201_11.x, var_201_11.y, var_201_11.z)

				local var_201_12 = var_201_4.localEulerAngles

				var_201_12.z = 0
				var_201_12.x = 0
				var_201_4.localEulerAngles = var_201_12
			end

			local var_201_13 = 0

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_201_15 = 0
			local var_201_16 = 0.35

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_17 = arg_198_1:FormatText(StoryNameCfg[8].name)

				arg_198_1.leftNameTxt_.text = var_201_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_18 = arg_198_1:GetWordFromCfg(105101048)
				local var_201_19 = arg_198_1:FormatText(var_201_18.content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 14
				local var_201_21 = utf8.len(var_201_19)
				local var_201_22 = var_201_20 <= 0 and var_201_16 or var_201_16 * (var_201_21 / var_201_20)

				if var_201_22 > 0 and var_201_16 < var_201_22 then
					arg_198_1.talkMaxDuration = var_201_22

					if var_201_22 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_22 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101048", "story_v_out_105101.awb") ~= 0 then
					local var_201_23 = manager.audio:GetVoiceLength("story_v_out_105101", "105101048", "story_v_out_105101.awb") / 1000

					if var_201_23 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_23 + var_201_15
					end

					if var_201_18.prefab_name ~= "" and arg_198_1.actors_[var_201_18.prefab_name] ~= nil then
						local var_201_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_18.prefab_name].transform, "story_v_out_105101", "105101048", "story_v_out_105101.awb")

						arg_198_1:RecordAudio("105101048", var_201_24)
						arg_198_1:RecordAudio("105101048", var_201_24)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_105101", "105101048", "story_v_out_105101.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_105101", "105101048", "story_v_out_105101.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_25 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_25 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_25

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_25 and arg_198_1.time_ < var_201_15 + var_201_25 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play105101049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 105101049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play105101050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1148ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1148ui_story == nil then
				arg_202_1.var_.characterEffect1148ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.1

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1148ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1148ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1148ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1148ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.175

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_9 = arg_202_1:GetWordFromCfg(105101049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 7
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play105101050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 105101050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play105101051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1148ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1148ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, 100, 0)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1148ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, 100, 0)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = 0
			local var_209_10 = 0.6

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_11 = arg_206_1:GetWordFromCfg(105101050)
				local var_209_12 = arg_206_1:FormatText(var_209_11.content)

				arg_206_1.text_.text = var_209_12

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 24
				local var_209_14 = utf8.len(var_209_12)
				local var_209_15 = var_209_13 <= 0 and var_209_10 or var_209_10 * (var_209_14 / var_209_13)

				if var_209_15 > 0 and var_209_10 < var_209_15 then
					arg_206_1.talkMaxDuration = var_209_15

					if var_209_15 + var_209_9 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_15 + var_209_9
					end
				end

				arg_206_1.text_.text = var_209_12
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_10, arg_206_1.talkMaxDuration)

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_9) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_9 + var_209_16 and arg_206_1.time_ < var_209_9 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play105101051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 105101051
		arg_210_1.duration_ = 5.9

		local var_210_0 = {
			ja = 5.5,
			ko = 5.9,
			zh = 5.866,
			en = 4.266
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play105101052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1059ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1059ui_story == nil then
				arg_210_1.var_.characterEffect1059ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.1

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1059ui_story and not isNil(var_213_0) then
					arg_210_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1059ui_story then
				arg_210_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_213_4 = arg_210_1.actors_["1059ui_story"].transform
			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.var_.moveOldPos1059ui_story = var_213_4.localPosition
			end

			local var_213_6 = 0.001

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_6 then
				local var_213_7 = (arg_210_1.time_ - var_213_5) / var_213_6
				local var_213_8 = Vector3.New(0, -1.05, -6)

				var_213_4.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1059ui_story, var_213_8, var_213_7)

				local var_213_9 = manager.ui.mainCamera.transform.position - var_213_4.position

				var_213_4.forward = Vector3.New(var_213_9.x, var_213_9.y, var_213_9.z)

				local var_213_10 = var_213_4.localEulerAngles

				var_213_10.z = 0
				var_213_10.x = 0
				var_213_4.localEulerAngles = var_213_10
			end

			if arg_210_1.time_ >= var_213_5 + var_213_6 and arg_210_1.time_ < var_213_5 + var_213_6 + arg_213_0 then
				var_213_4.localPosition = Vector3.New(0, -1.05, -6)

				local var_213_11 = manager.ui.mainCamera.transform.position - var_213_4.position

				var_213_4.forward = Vector3.New(var_213_11.x, var_213_11.y, var_213_11.z)

				local var_213_12 = var_213_4.localEulerAngles

				var_213_12.z = 0
				var_213_12.x = 0
				var_213_4.localEulerAngles = var_213_12
			end

			local var_213_13 = 0

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_213_14 = 0

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_213_15 = 0
			local var_213_16 = 0.775

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[28].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(105101051)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 31
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101051", "story_v_out_105101.awb") ~= 0 then
					local var_213_23 = manager.audio:GetVoiceLength("story_v_out_105101", "105101051", "story_v_out_105101.awb") / 1000

					if var_213_23 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_15
					end

					if var_213_18.prefab_name ~= "" and arg_210_1.actors_[var_213_18.prefab_name] ~= nil then
						local var_213_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_18.prefab_name].transform, "story_v_out_105101", "105101051", "story_v_out_105101.awb")

						arg_210_1:RecordAudio("105101051", var_213_24)
						arg_210_1:RecordAudio("105101051", var_213_24)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_105101", "105101051", "story_v_out_105101.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_105101", "105101051", "story_v_out_105101.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_25 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_25 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_25

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_25 and arg_210_1.time_ < var_213_15 + var_213_25 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play105101052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 105101052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play105101053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1059ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1059ui_story == nil then
				arg_214_1.var_.characterEffect1059ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.1

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1059ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1059ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1059ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1059ui_story.fillRatio = var_217_5
			end

			local var_217_6 = manager.ui.mainCamera.transform
			local var_217_7 = 0

			if var_217_7 < arg_214_1.time_ and arg_214_1.time_ <= var_217_7 + arg_217_0 then
				arg_214_1.var_.shakeOldPosMainCamera = var_217_6.localPosition
			end

			local var_217_8 = 0.600000023841858

			if var_217_7 <= arg_214_1.time_ and arg_214_1.time_ < var_217_7 + var_217_8 then
				local var_217_9 = (arg_214_1.time_ - var_217_7) / 0.066
				local var_217_10, var_217_11 = math.modf(var_217_9)

				var_217_6.localPosition = Vector3.New(var_217_11 * 0.13, var_217_11 * 0.13, var_217_11 * 0.13) + arg_214_1.var_.shakeOldPosMainCamera
			end

			if arg_214_1.time_ >= var_217_7 + var_217_8 and arg_214_1.time_ < var_217_7 + var_217_8 + arg_217_0 then
				var_217_6.localPosition = arg_214_1.var_.shakeOldPosMainCamera
			end

			local var_217_12 = arg_214_1.actors_["1059ui_story"].transform
			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1.var_.moveOldPos1059ui_story = var_217_12.localPosition
			end

			local var_217_14 = 0.001

			if var_217_13 <= arg_214_1.time_ and arg_214_1.time_ < var_217_13 + var_217_14 then
				local var_217_15 = (arg_214_1.time_ - var_217_13) / var_217_14
				local var_217_16 = Vector3.New(0, 100, 0)

				var_217_12.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1059ui_story, var_217_16, var_217_15)

				local var_217_17 = manager.ui.mainCamera.transform.position - var_217_12.position

				var_217_12.forward = Vector3.New(var_217_17.x, var_217_17.y, var_217_17.z)

				local var_217_18 = var_217_12.localEulerAngles

				var_217_18.z = 0
				var_217_18.x = 0
				var_217_12.localEulerAngles = var_217_18
			end

			if arg_214_1.time_ >= var_217_13 + var_217_14 and arg_214_1.time_ < var_217_13 + var_217_14 + arg_217_0 then
				var_217_12.localPosition = Vector3.New(0, 100, 0)

				local var_217_19 = manager.ui.mainCamera.transform.position - var_217_12.position

				var_217_12.forward = Vector3.New(var_217_19.x, var_217_19.y, var_217_19.z)

				local var_217_20 = var_217_12.localEulerAngles

				var_217_20.z = 0
				var_217_20.x = 0
				var_217_12.localEulerAngles = var_217_20
			end

			local var_217_21 = 0
			local var_217_22 = 0.725

			if var_217_21 < arg_214_1.time_ and arg_214_1.time_ <= var_217_21 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_23 = arg_214_1:GetWordFromCfg(105101052)
				local var_217_24 = arg_214_1:FormatText(var_217_23.content)

				arg_214_1.text_.text = var_217_24

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_25 = 29
				local var_217_26 = utf8.len(var_217_24)
				local var_217_27 = var_217_25 <= 0 and var_217_22 or var_217_22 * (var_217_26 / var_217_25)

				if var_217_27 > 0 and var_217_22 < var_217_27 then
					arg_214_1.talkMaxDuration = var_217_27

					if var_217_27 + var_217_21 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_27 + var_217_21
					end
				end

				arg_214_1.text_.text = var_217_24
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_28 = math.max(var_217_22, arg_214_1.talkMaxDuration)

			if var_217_21 <= arg_214_1.time_ and arg_214_1.time_ < var_217_21 + var_217_28 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_21) / var_217_28

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_21 + var_217_28 and arg_214_1.time_ < var_217_21 + var_217_28 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play105101053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 105101053
		arg_218_1.duration_ = 7.23

		local var_218_0 = {
			ja = 7.233,
			ko = 6.5,
			zh = 5.8,
			en = 5.7
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play105101054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.6

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[8].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(105101053)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 23
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101053", "story_v_out_105101.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_105101", "105101053", "story_v_out_105101.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_105101", "105101053", "story_v_out_105101.awb")

						arg_218_1:RecordAudio("105101053", var_221_9)
						arg_218_1:RecordAudio("105101053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_105101", "105101053", "story_v_out_105101.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_105101", "105101053", "story_v_out_105101.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play105101054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 105101054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play105101055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.05

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

				local var_225_3 = arg_222_1:GetWordFromCfg(105101054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 2
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
	Play105101055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 105101055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play105101056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			local var_229_1 = 0
			local var_229_2 = 0.975

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:GetWordFromCfg(105101055)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 39
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_2 or var_229_2 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_2 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_8 and arg_226_1.time_ < var_229_1 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play105101056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 105101056
		arg_230_1.duration_ = 3.43

		local var_230_0 = {
			ja = 1.333,
			ko = 3.433,
			zh = 2.366,
			en = 1.8
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play105101057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1037ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1037ui_story == nil then
				arg_230_1.var_.characterEffect1037ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.1

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1037ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1037ui_story then
				arg_230_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_233_4 = arg_230_1.actors_["1037ui_story"].transform
			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.var_.moveOldPos1037ui_story = var_233_4.localPosition
			end

			local var_233_6 = 0.001

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_6 then
				local var_233_7 = (arg_230_1.time_ - var_233_5) / var_233_6
				local var_233_8 = Vector3.New(0, -1.09, -5.81)

				var_233_4.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1037ui_story, var_233_8, var_233_7)

				local var_233_9 = manager.ui.mainCamera.transform.position - var_233_4.position

				var_233_4.forward = Vector3.New(var_233_9.x, var_233_9.y, var_233_9.z)

				local var_233_10 = var_233_4.localEulerAngles

				var_233_10.z = 0
				var_233_10.x = 0
				var_233_4.localEulerAngles = var_233_10
			end

			if arg_230_1.time_ >= var_233_5 + var_233_6 and arg_230_1.time_ < var_233_5 + var_233_6 + arg_233_0 then
				var_233_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_233_11 = manager.ui.mainCamera.transform.position - var_233_4.position

				var_233_4.forward = Vector3.New(var_233_11.x, var_233_11.y, var_233_11.z)

				local var_233_12 = var_233_4.localEulerAngles

				var_233_12.z = 0
				var_233_12.x = 0
				var_233_4.localEulerAngles = var_233_12
			end

			local var_233_13 = 0

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_233_14 = 0
			local var_233_15 = 0.25

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_16 = arg_230_1:FormatText(StoryNameCfg[15].name)

				arg_230_1.leftNameTxt_.text = var_233_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_17 = arg_230_1:GetWordFromCfg(105101056)
				local var_233_18 = arg_230_1:FormatText(var_233_17.content)

				arg_230_1.text_.text = var_233_18

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_19 = 10
				local var_233_20 = utf8.len(var_233_18)
				local var_233_21 = var_233_19 <= 0 and var_233_15 or var_233_15 * (var_233_20 / var_233_19)

				if var_233_21 > 0 and var_233_15 < var_233_21 then
					arg_230_1.talkMaxDuration = var_233_21

					if var_233_21 + var_233_14 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_21 + var_233_14
					end
				end

				arg_230_1.text_.text = var_233_18
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105101", "105101056", "story_v_out_105101.awb") ~= 0 then
					local var_233_22 = manager.audio:GetVoiceLength("story_v_out_105101", "105101056", "story_v_out_105101.awb") / 1000

					if var_233_22 + var_233_14 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_22 + var_233_14
					end

					if var_233_17.prefab_name ~= "" and arg_230_1.actors_[var_233_17.prefab_name] ~= nil then
						local var_233_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_17.prefab_name].transform, "story_v_out_105101", "105101056", "story_v_out_105101.awb")

						arg_230_1:RecordAudio("105101056", var_233_23)
						arg_230_1:RecordAudio("105101056", var_233_23)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_105101", "105101056", "story_v_out_105101.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_105101", "105101056", "story_v_out_105101.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_24 = math.max(var_233_15, arg_230_1.talkMaxDuration)

			if var_233_14 <= arg_230_1.time_ and arg_230_1.time_ < var_233_14 + var_233_24 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_14) / var_233_24

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_14 + var_233_24 and arg_230_1.time_ < var_233_14 + var_233_24 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play105101057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 105101057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
			arg_234_1.auto_ = false
		end

		function arg_234_1.playNext_(arg_236_0)
			arg_234_1.onStoryFinished_()
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1037ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1037ui_story == nil then
				arg_234_1.var_.characterEffect1037ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.1

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1037ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1037ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1037ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1037ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 0.05

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[7].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_9 = arg_234_1:GetWordFromCfg(105101057)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 2
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
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/B01a"
	},
	voices = {
		"story_v_out_105101.awb"
	}
}
