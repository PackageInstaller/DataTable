return {
	Play115042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115042001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "G02a"

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
				local var_4_5 = arg_1_1.bgs_.G02a

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
					if iter_4_0 ~= "G02a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1.36666666666667
			local var_4_29 = 1.59999999999933

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_15", "se_story_15_gun05", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.675

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(115042001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 27
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115042002
		arg_9_1.duration_ = 7.63

		local var_9_0 = {
			ja = 7.633,
			ko = 6.933,
			zh = 4.466,
			en = 5.9
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
				arg_9_0:Play115042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.65

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[261].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(115042002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042002", "story_v_out_115042.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_115042", "115042002", "story_v_out_115042.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_115042", "115042002", "story_v_out_115042.awb")

						arg_9_1:RecordAudio("115042002", var_12_9)
						arg_9_1:RecordAudio("115042002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115042", "115042002", "story_v_out_115042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115042", "115042002", "story_v_out_115042.awb")
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
	Play115042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115042003
		arg_13_1.duration_ = 4.23

		local var_13_0 = {
			ja = 4.233,
			ko = 2.6,
			zh = 2.1,
			en = 2.866
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
				arg_13_0:Play115042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.25

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[263].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(115042003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042003", "story_v_out_115042.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_115042", "115042003", "story_v_out_115042.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_115042", "115042003", "story_v_out_115042.awb")

						arg_13_1:RecordAudio("115042003", var_16_9)
						arg_13_1:RecordAudio("115042003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115042", "115042003", "story_v_out_115042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115042", "115042003", "story_v_out_115042.awb")
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
	Play115042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115042004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.75

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(115042004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 30
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play115042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115042005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play115042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.725

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(115042005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 29
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115042006
		arg_25_1.duration_ = 3.67

		local var_25_0 = {
			ja = 1.999999999999,
			ko = 3.666,
			zh = 3.4,
			en = 1.999999999999
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
				arg_25_0:Play115042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1016ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1016ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1016ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1016ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0, -18.66, -121.78)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1016ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -18.66, -121.78)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_28_16 = arg_25_1.actors_["1016ui_story"]
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1016ui_story == nil then
				arg_25_1.var_.characterEffect1016ui_story = var_28_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_18 = 0.2

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_18 and not isNil(var_28_16) then
				local var_28_19 = (arg_25_1.time_ - var_28_17) / var_28_18

				if arg_25_1.var_.characterEffect1016ui_story and not isNil(var_28_16) then
					arg_25_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_17 + var_28_18 and arg_25_1.time_ < var_28_17 + var_28_18 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1016ui_story then
				arg_25_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_28_20 = 0
			local var_28_21 = 0.275

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[260].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(115042006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 11
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042006", "story_v_out_115042.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_115042", "115042006", "story_v_out_115042.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_115042", "115042006", "story_v_out_115042.awb")

						arg_25_1:RecordAudio("115042006", var_28_29)
						arg_25_1:RecordAudio("115042006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115042", "115042006", "story_v_out_115042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115042", "115042006", "story_v_out_115042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play115042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115042007
		arg_29_1.duration_ = 7.97

		local var_29_0 = {
			ja = 7.966,
			ko = 4.633,
			zh = 5.666,
			en = 4.466
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
				arg_29_0:Play115042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1016ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1016ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1016ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0
			local var_32_10 = 0.5

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_11 = arg_29_1:FormatText(StoryNameCfg[260].name)

				arg_29_1.leftNameTxt_.text = var_32_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_12 = arg_29_1:GetWordFromCfg(115042007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_14 = 20
				local var_32_15 = utf8.len(var_32_13)
				local var_32_16 = var_32_14 <= 0 and var_32_10 or var_32_10 * (var_32_15 / var_32_14)

				if var_32_16 > 0 and var_32_10 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16

					if var_32_16 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042007", "story_v_out_115042.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_115042", "115042007", "story_v_out_115042.awb") / 1000

					if var_32_17 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_9
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_115042", "115042007", "story_v_out_115042.awb")

						arg_29_1:RecordAudio("115042007", var_32_18)
						arg_29_1:RecordAudio("115042007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115042", "115042007", "story_v_out_115042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115042", "115042007", "story_v_out_115042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_9) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_9 + var_32_19 and arg_29_1.time_ < var_32_9 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play115042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115042008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play115042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.55

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(115042008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 22
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play115042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115042009
		arg_37_1.duration_ = 2.4

		local var_37_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 1.999999999999,
			en = 2.4
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1016ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1016ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.7, -0.95, -6.2)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1016ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_11 = arg_37_1.actors_["1016ui_story"]
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1016ui_story == nil then
				arg_37_1.var_.characterEffect1016ui_story = var_40_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_13 = 0.2

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_13 and not isNil(var_40_11) then
				local var_40_14 = (arg_37_1.time_ - var_40_12) / var_40_13

				if arg_37_1.var_.characterEffect1016ui_story and not isNil(var_40_11) then
					arg_37_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_12 + var_40_13 and arg_37_1.time_ < var_40_12 + var_40_13 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1016ui_story then
				arg_37_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_40_15 = 0
			local var_40_16 = 0.15

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[260].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(115042009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 6
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042009", "story_v_out_115042.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_115042", "115042009", "story_v_out_115042.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_115042", "115042009", "story_v_out_115042.awb")

						arg_37_1:RecordAudio("115042009", var_40_24)
						arg_37_1:RecordAudio("115042009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115042", "115042009", "story_v_out_115042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115042", "115042009", "story_v_out_115042.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play115042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115042010
		arg_41_1.duration_ = 2.23

		local var_41_0 = {
			ja = 2.133,
			ko = 2.233,
			zh = 1.999999999999,
			en = 2.066
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play115042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1016ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1016ui_story == nil then
				arg_41_1.var_.characterEffect1016ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1016ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1016ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1016ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1016ui_story.fillRatio = var_44_5
			end

			local var_44_6 = "1052ui_story"

			if arg_41_1.actors_[var_44_6] == nil then
				local var_44_7 = Asset.Load("Char/" .. "1052ui_story")

				if not isNil(var_44_7) then
					local var_44_8 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_41_1.stage_.transform)

					var_44_8.name = var_44_6
					var_44_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_41_1.actors_[var_44_6] = var_44_8

					local var_44_9 = var_44_8:GetComponentInChildren(typeof(CharacterEffect))

					var_44_9.enabled = true

					local var_44_10 = GameObjectTools.GetOrAddComponent(var_44_8, typeof(DynamicBoneHelper))

					if var_44_10 then
						var_44_10:EnableDynamicBone(false)
					end

					arg_41_1:ShowWeapon(var_44_9.transform, false)

					arg_41_1.var_[var_44_6 .. "Animator"] = var_44_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_41_1.var_[var_44_6 .. "Animator"].applyRootMotion = true
					arg_41_1.var_[var_44_6 .. "LipSync"] = var_44_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_44_11 = arg_41_1.actors_["1052ui_story"].transform
			local var_44_12 = 0

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.var_.moveOldPos1052ui_story = var_44_11.localPosition
			end

			local var_44_13 = 0.001

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_13 then
				local var_44_14 = (arg_41_1.time_ - var_44_12) / var_44_13
				local var_44_15 = Vector3.New(0.7, -1.05, -6.2)

				var_44_11.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1052ui_story, var_44_15, var_44_14)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_11.position

				var_44_11.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_11.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_11.localEulerAngles = var_44_17
			end

			if arg_41_1.time_ >= var_44_12 + var_44_13 and arg_41_1.time_ < var_44_12 + var_44_13 + arg_44_0 then
				var_44_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_44_18 = manager.ui.mainCamera.transform.position - var_44_11.position

				var_44_11.forward = Vector3.New(var_44_18.x, var_44_18.y, var_44_18.z)

				local var_44_19 = var_44_11.localEulerAngles

				var_44_19.z = 0
				var_44_19.x = 0
				var_44_11.localEulerAngles = var_44_19
			end

			local var_44_20 = 0

			if var_44_20 < arg_41_1.time_ and arg_41_1.time_ <= var_44_20 + arg_44_0 then
				arg_41_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_44_22 = arg_41_1.actors_["1052ui_story"]
			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.characterEffect1052ui_story == nil then
				arg_41_1.var_.characterEffect1052ui_story = var_44_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_24 = 0.2

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 and not isNil(var_44_22) then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24

				if arg_41_1.var_.characterEffect1052ui_story and not isNil(var_44_22) then
					arg_41_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.characterEffect1052ui_story then
				arg_41_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_44_26 = 0
			local var_44_27 = 0.125

			if var_44_26 < arg_41_1.time_ and arg_41_1.time_ <= var_44_26 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_28 = arg_41_1:FormatText(StoryNameCfg[263].name)

				arg_41_1.leftNameTxt_.text = var_44_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_29 = arg_41_1:GetWordFromCfg(115042010)
				local var_44_30 = arg_41_1:FormatText(var_44_29.content)

				arg_41_1.text_.text = var_44_30

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_31 = 5
				local var_44_32 = utf8.len(var_44_30)
				local var_44_33 = var_44_31 <= 0 and var_44_27 or var_44_27 * (var_44_32 / var_44_31)

				if var_44_33 > 0 and var_44_27 < var_44_33 then
					arg_41_1.talkMaxDuration = var_44_33

					if var_44_33 + var_44_26 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_33 + var_44_26
					end
				end

				arg_41_1.text_.text = var_44_30
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042010", "story_v_out_115042.awb") ~= 0 then
					local var_44_34 = manager.audio:GetVoiceLength("story_v_out_115042", "115042010", "story_v_out_115042.awb") / 1000

					if var_44_34 + var_44_26 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_34 + var_44_26
					end

					if var_44_29.prefab_name ~= "" and arg_41_1.actors_[var_44_29.prefab_name] ~= nil then
						local var_44_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_29.prefab_name].transform, "story_v_out_115042", "115042010", "story_v_out_115042.awb")

						arg_41_1:RecordAudio("115042010", var_44_35)
						arg_41_1:RecordAudio("115042010", var_44_35)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115042", "115042010", "story_v_out_115042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115042", "115042010", "story_v_out_115042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_36 = math.max(var_44_27, arg_41_1.talkMaxDuration)

			if var_44_26 <= arg_41_1.time_ and arg_41_1.time_ < var_44_26 + var_44_36 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_26) / var_44_36

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_26 + var_44_36 and arg_41_1.time_ < var_44_26 + var_44_36 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play115042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115042011
		arg_45_1.duration_ = 3

		local var_45_0 = {
			ja = 1.766,
			ko = 3,
			zh = 2.4,
			en = 1.733
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1052ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1052ui_story == nil then
				arg_45_1.var_.characterEffect1052ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1052ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1052ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1052ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1052ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.3

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[261].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(115042011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 12
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042011", "story_v_out_115042.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_115042", "115042011", "story_v_out_115042.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_115042", "115042011", "story_v_out_115042.awb")

						arg_45_1:RecordAudio("115042011", var_48_15)
						arg_45_1:RecordAudio("115042011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115042", "115042011", "story_v_out_115042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115042", "115042011", "story_v_out_115042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115042012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			ja = 4.5,
			ko = 5.9,
			zh = 5.366,
			en = 4.333
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
				arg_49_0:Play115042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_52_1 = arg_49_1.actors_["1016ui_story"]
			local var_52_2 = 0

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1016ui_story == nil then
				arg_49_1.var_.characterEffect1016ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_3 and not isNil(var_52_1) then
				local var_52_4 = (arg_49_1.time_ - var_52_2) / var_52_3

				if arg_49_1.var_.characterEffect1016ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_2 + var_52_3 and arg_49_1.time_ < var_52_2 + var_52_3 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1016ui_story then
				arg_49_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_52_5 = 0
			local var_52_6 = 0.65

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_7 = arg_49_1:FormatText(StoryNameCfg[260].name)

				arg_49_1.leftNameTxt_.text = var_52_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(115042012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 26
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_6 or var_52_6 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_6 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042012", "story_v_out_115042.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_out_115042", "115042012", "story_v_out_115042.awb") / 1000

					if var_52_13 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_5
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_115042", "115042012", "story_v_out_115042.awb")

						arg_49_1:RecordAudio("115042012", var_52_14)
						arg_49_1:RecordAudio("115042012", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115042", "115042012", "story_v_out_115042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115042", "115042012", "story_v_out_115042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_15 and arg_49_1.time_ < var_52_5 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115042013
		arg_53_1.duration_ = 7.1

		local var_53_0 = {
			ja = 5.966,
			ko = 4.7,
			zh = 4.966,
			en = 7.1
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
				arg_53_0:Play115042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_1 = 0
			local var_56_2 = 0.65

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[260].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(115042013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 26
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042013", "story_v_out_115042.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_115042", "115042013", "story_v_out_115042.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_115042", "115042013", "story_v_out_115042.awb")

						arg_53_1:RecordAudio("115042013", var_56_10)
						arg_53_1:RecordAudio("115042013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115042", "115042013", "story_v_out_115042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115042", "115042013", "story_v_out_115042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115042014
		arg_57_1.duration_ = 7.4

		local var_57_0 = {
			ja = 5.1,
			ko = 7.4,
			zh = 6.233,
			en = 7.266
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play115042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1016ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1016ui_story == nil then
				arg_57_1.var_.characterEffect1016ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1016ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1016ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1016ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1016ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.775

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[261].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(115042014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 31
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042014", "story_v_out_115042.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_115042", "115042014", "story_v_out_115042.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_115042", "115042014", "story_v_out_115042.awb")

						arg_57_1:RecordAudio("115042014", var_60_15)
						arg_57_1:RecordAudio("115042014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115042", "115042014", "story_v_out_115042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115042", "115042014", "story_v_out_115042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115042015
		arg_61_1.duration_ = 8.4

		local var_61_0 = {
			ja = 8.4,
			ko = 3.9,
			zh = 6.633,
			en = 5.266
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play115042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action3_1")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_2 = arg_61_1.actors_["1016ui_story"]
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1016ui_story == nil then
				arg_61_1.var_.characterEffect1016ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 and not isNil(var_64_2) then
				local var_64_5 = (arg_61_1.time_ - var_64_3) / var_64_4

				if arg_61_1.var_.characterEffect1016ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1016ui_story then
				arg_61_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_64_6 = 0
			local var_64_7 = 0.55

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[260].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(115042015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 22
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042015", "story_v_out_115042.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_115042", "115042015", "story_v_out_115042.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_115042", "115042015", "story_v_out_115042.awb")

						arg_61_1:RecordAudio("115042015", var_64_15)
						arg_61_1:RecordAudio("115042015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_115042", "115042015", "story_v_out_115042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_115042", "115042015", "story_v_out_115042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115042016
		arg_65_1.duration_ = 6.3

		local var_65_0 = {
			ja = 6.3,
			ko = 6.266,
			zh = 5.366,
			en = 4.066
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
				arg_65_0:Play115042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016actionlink/1016action435")
			end

			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_2 = arg_65_1.actors_["1016ui_story"]
			local var_68_3 = 0

			if var_68_3 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1016ui_story == nil then
				arg_65_1.var_.characterEffect1016ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.2

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_4 and not isNil(var_68_2) then
				local var_68_5 = (arg_65_1.time_ - var_68_3) / var_68_4

				if arg_65_1.var_.characterEffect1016ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_3 + var_68_4 and arg_65_1.time_ < var_68_3 + var_68_4 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1016ui_story then
				arg_65_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_68_6 = 0
			local var_68_7 = 0.7

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[260].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(115042016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 28
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042016", "story_v_out_115042.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_115042", "115042016", "story_v_out_115042.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_115042", "115042016", "story_v_out_115042.awb")

						arg_65_1:RecordAudio("115042016", var_68_15)
						arg_65_1:RecordAudio("115042016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115042", "115042016", "story_v_out_115042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115042", "115042016", "story_v_out_115042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115042017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play115042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1016ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1016ui_story == nil then
				arg_69_1.var_.characterEffect1016ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1016ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1016ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1016ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1016ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.45

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(115042017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 18
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play115042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115042018
		arg_73_1.duration_ = 11.5

		local var_73_0 = {
			ja = 8,
			ko = 9,
			zh = 11.5,
			en = 9.266
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
				arg_73_0:Play115042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action5_2")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_2 = arg_73_1.actors_["1052ui_story"]
			local var_76_3 = 0

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1052ui_story == nil then
				arg_73_1.var_.characterEffect1052ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_4 and not isNil(var_76_2) then
				local var_76_5 = (arg_73_1.time_ - var_76_3) / var_76_4

				if arg_73_1.var_.characterEffect1052ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_3 + var_76_4 and arg_73_1.time_ < var_76_3 + var_76_4 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1052ui_story then
				arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_76_6 = 0
			local var_76_7 = 0.8

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[263].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(115042018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 32
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042018", "story_v_out_115042.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_115042", "115042018", "story_v_out_115042.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_115042", "115042018", "story_v_out_115042.awb")

						arg_73_1:RecordAudio("115042018", var_76_15)
						arg_73_1:RecordAudio("115042018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_115042", "115042018", "story_v_out_115042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_115042", "115042018", "story_v_out_115042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play115042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115042019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1052ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1052ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1052ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1016ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos1016ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1016ui_story, var_80_13, var_80_12)

				local var_80_14 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_14.x, var_80_14.y, var_80_14.z)

				local var_80_15 = var_80_9.localEulerAngles

				var_80_15.z = 0
				var_80_15.x = 0
				var_80_9.localEulerAngles = var_80_15
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(0, 100, 0)

				local var_80_16 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_16.x, var_80_16.y, var_80_16.z)

				local var_80_17 = var_80_9.localEulerAngles

				var_80_17.z = 0
				var_80_17.x = 0
				var_80_9.localEulerAngles = var_80_17
			end

			local var_80_18 = 0
			local var_80_19 = 1

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				local var_80_20 = "play"
				local var_80_21 = "effect"

				arg_77_1:AudioAction(var_80_20, var_80_21, "se_story_15", "se_story_15_gun02", "")
			end

			local var_80_22 = 0
			local var_80_23 = 1.075

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(115042019)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 43
				local var_80_27 = utf8.len(var_80_25)
				local var_80_28 = var_80_26 <= 0 and var_80_23 or var_80_23 * (var_80_27 / var_80_26)

				if var_80_28 > 0 and var_80_23 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28

					if var_80_28 + var_80_22 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_22
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_29 = math.max(var_80_23, arg_77_1.talkMaxDuration)

			if var_80_22 <= arg_77_1.time_ and arg_77_1.time_ < var_80_22 + var_80_29 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_22) / var_80_29

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_22 + var_80_29 and arg_77_1.time_ < var_80_22 + var_80_29 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play115042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115042020
		arg_81_1.duration_ = 3.87

		local var_81_0 = {
			ja = 3.866,
			ko = 2.933,
			zh = 2.833,
			en = 2.4
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play115042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.35

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[276].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(115042020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 14
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042020", "story_v_out_115042.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_115042", "115042020", "story_v_out_115042.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_115042", "115042020", "story_v_out_115042.awb")

						arg_81_1:RecordAudio("115042020", var_84_9)
						arg_81_1:RecordAudio("115042020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115042", "115042020", "story_v_out_115042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115042", "115042020", "story_v_out_115042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115042021
		arg_85_1.duration_ = 3.87

		local var_85_0 = {
			ja = 3.866,
			ko = 2.2,
			zh = 2.333,
			en = 2
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play115042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.275

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[277].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(115042021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 11
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042021", "story_v_out_115042.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_115042", "115042021", "story_v_out_115042.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_115042", "115042021", "story_v_out_115042.awb")

						arg_85_1:RecordAudio("115042021", var_88_9)
						arg_85_1:RecordAudio("115042021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115042", "115042021", "story_v_out_115042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115042", "115042021", "story_v_out_115042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play115042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115042022
		arg_89_1.duration_ = 4.07

		local var_89_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3.166
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1016ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1016ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(-0.7, -0.95, -6.2)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1016ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_92_11 = arg_89_1.actors_["1016ui_story"]
			local var_92_12 = 0

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 and not isNil(var_92_11) and arg_89_1.var_.characterEffect1016ui_story == nil then
				arg_89_1.var_.characterEffect1016ui_story = var_92_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_13 = 0.2

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_13 and not isNil(var_92_11) then
				local var_92_14 = (arg_89_1.time_ - var_92_12) / var_92_13

				if arg_89_1.var_.characterEffect1016ui_story and not isNil(var_92_11) then
					arg_89_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_12 + var_92_13 and arg_89_1.time_ < var_92_12 + var_92_13 + arg_92_0 and not isNil(var_92_11) and arg_89_1.var_.characterEffect1016ui_story then
				arg_89_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_92_15 = arg_89_1.actors_["1052ui_story"].transform
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.var_.moveOldPos1052ui_story = var_92_15.localPosition
			end

			local var_92_17 = 0.001

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17
				local var_92_19 = Vector3.New(0.7, -1.05, -6.2)

				var_92_15.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1052ui_story, var_92_19, var_92_18)

				local var_92_20 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_20.x, var_92_20.y, var_92_20.z)

				local var_92_21 = var_92_15.localEulerAngles

				var_92_21.z = 0
				var_92_21.x = 0
				var_92_15.localEulerAngles = var_92_21
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				var_92_15.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_92_22 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_22.x, var_92_22.y, var_92_22.z)

				local var_92_23 = var_92_15.localEulerAngles

				var_92_23.z = 0
				var_92_23.x = 0
				var_92_15.localEulerAngles = var_92_23
			end

			local var_92_24 = arg_89_1.actors_["1052ui_story"]
			local var_92_25 = 0

			if var_92_25 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect1052ui_story == nil then
				arg_89_1.var_.characterEffect1052ui_story = var_92_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_26 = 0.2

			if var_92_25 <= arg_89_1.time_ and arg_89_1.time_ < var_92_25 + var_92_26 and not isNil(var_92_24) then
				local var_92_27 = (arg_89_1.time_ - var_92_25) / var_92_26

				if arg_89_1.var_.characterEffect1052ui_story and not isNil(var_92_24) then
					local var_92_28 = Mathf.Lerp(0, 0.5, var_92_27)

					arg_89_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1052ui_story.fillRatio = var_92_28
				end
			end

			if arg_89_1.time_ >= var_92_25 + var_92_26 and arg_89_1.time_ < var_92_25 + var_92_26 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect1052ui_story then
				local var_92_29 = 0.5

				arg_89_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1052ui_story.fillRatio = var_92_29
			end

			local var_92_30 = 0
			local var_92_31 = 0.125

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_32 = arg_89_1:FormatText(StoryNameCfg[260].name)

				arg_89_1.leftNameTxt_.text = var_92_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_33 = arg_89_1:GetWordFromCfg(115042022)
				local var_92_34 = arg_89_1:FormatText(var_92_33.content)

				arg_89_1.text_.text = var_92_34

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_35 = 5
				local var_92_36 = utf8.len(var_92_34)
				local var_92_37 = var_92_35 <= 0 and var_92_31 or var_92_31 * (var_92_36 / var_92_35)

				if var_92_37 > 0 and var_92_31 < var_92_37 then
					arg_89_1.talkMaxDuration = var_92_37

					if var_92_37 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_37 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_34
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042022", "story_v_out_115042.awb") ~= 0 then
					local var_92_38 = manager.audio:GetVoiceLength("story_v_out_115042", "115042022", "story_v_out_115042.awb") / 1000

					if var_92_38 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_30
					end

					if var_92_33.prefab_name ~= "" and arg_89_1.actors_[var_92_33.prefab_name] ~= nil then
						local var_92_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_33.prefab_name].transform, "story_v_out_115042", "115042022", "story_v_out_115042.awb")

						arg_89_1:RecordAudio("115042022", var_92_39)
						arg_89_1:RecordAudio("115042022", var_92_39)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_115042", "115042022", "story_v_out_115042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_115042", "115042022", "story_v_out_115042.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_40 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_40 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_40

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_40 and arg_89_1.time_ < var_92_30 + var_92_40 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play115042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115042023
		arg_93_1.duration_ = 10.4

		local var_93_0 = {
			ja = 8.866,
			ko = 9,
			zh = 10.4,
			en = 9.133
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play115042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1052ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1052ui_story == nil then
				arg_93_1.var_.characterEffect1052ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1052ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1052ui_story then
				arg_93_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_5 = arg_93_1.actors_["1016ui_story"]
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1016ui_story == nil then
				arg_93_1.var_.characterEffect1016ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.2

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 and not isNil(var_96_5) then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7

				if arg_93_1.var_.characterEffect1016ui_story and not isNil(var_96_5) then
					local var_96_9 = Mathf.Lerp(0, 0.5, var_96_8)

					arg_93_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1016ui_story.fillRatio = var_96_9
				end
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1016ui_story then
				local var_96_10 = 0.5

				arg_93_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1016ui_story.fillRatio = var_96_10
			end

			local var_96_11 = 0
			local var_96_12 = 1.1

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[263].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(115042023)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 44
				local var_96_17 = utf8.len(var_96_15)
				local var_96_18 = var_96_16 <= 0 and var_96_12 or var_96_12 * (var_96_17 / var_96_16)

				if var_96_18 > 0 and var_96_12 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18

					if var_96_18 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042023", "story_v_out_115042.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042023", "story_v_out_115042.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_115042", "115042023", "story_v_out_115042.awb")

						arg_93_1:RecordAudio("115042023", var_96_20)
						arg_93_1:RecordAudio("115042023", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115042", "115042023", "story_v_out_115042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115042", "115042023", "story_v_out_115042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_21 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_21 and arg_93_1.time_ < var_96_11 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115042024
		arg_97_1.duration_ = 2.13

		local var_97_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.133,
			en = 1.999999999999
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play115042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1052ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1052ui_story == nil then
				arg_97_1.var_.characterEffect1052ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1052ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1052ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1052ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1052ui_story.fillRatio = var_100_5
			end

			local var_100_6 = arg_97_1.actors_["1016ui_story"]
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1016ui_story == nil then
				arg_97_1.var_.characterEffect1016ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_8 = 0.2

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_8 and not isNil(var_100_6) then
				local var_100_9 = (arg_97_1.time_ - var_100_7) / var_100_8

				if arg_97_1.var_.characterEffect1016ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_7 + var_100_8 and arg_97_1.time_ < var_100_7 + var_100_8 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1016ui_story then
				arg_97_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_100_11 = 0
			local var_100_12 = 0.125

			if var_100_11 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_13 = arg_97_1:FormatText(StoryNameCfg[260].name)

				arg_97_1.leftNameTxt_.text = var_100_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(115042024)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 5
				local var_100_17 = utf8.len(var_100_15)
				local var_100_18 = var_100_16 <= 0 and var_100_12 or var_100_12 * (var_100_17 / var_100_16)

				if var_100_18 > 0 and var_100_12 < var_100_18 then
					arg_97_1.talkMaxDuration = var_100_18

					if var_100_18 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042024", "story_v_out_115042.awb") ~= 0 then
					local var_100_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042024", "story_v_out_115042.awb") / 1000

					if var_100_19 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_19 + var_100_11
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_115042", "115042024", "story_v_out_115042.awb")

						arg_97_1:RecordAudio("115042024", var_100_20)
						arg_97_1:RecordAudio("115042024", var_100_20)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115042", "115042024", "story_v_out_115042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115042", "115042024", "story_v_out_115042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_21 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_21 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_21

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_21 and arg_97_1.time_ < var_100_11 + var_100_21 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play115042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115042025
		arg_101_1.duration_ = 13.33

		local var_101_0 = {
			ja = 10.966,
			ko = 13.333,
			zh = 11.6,
			en = 13
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play115042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1052ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1052ui_story == nil then
				arg_101_1.var_.characterEffect1052ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1052ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1052ui_story then
				arg_101_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_104_5 = arg_101_1.actors_["1016ui_story"]
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1016ui_story == nil then
				arg_101_1.var_.characterEffect1016ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.2

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_7 and not isNil(var_104_5) then
				local var_104_8 = (arg_101_1.time_ - var_104_6) / var_104_7

				if arg_101_1.var_.characterEffect1016ui_story and not isNil(var_104_5) then
					local var_104_9 = Mathf.Lerp(0, 0.5, var_104_8)

					arg_101_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1016ui_story.fillRatio = var_104_9
				end
			end

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1016ui_story then
				local var_104_10 = 0.5

				arg_101_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1016ui_story.fillRatio = var_104_10
			end

			local var_104_11 = 0
			local var_104_12 = 1.4

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_13 = arg_101_1:FormatText(StoryNameCfg[263].name)

				arg_101_1.leftNameTxt_.text = var_104_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_14 = arg_101_1:GetWordFromCfg(115042025)
				local var_104_15 = arg_101_1:FormatText(var_104_14.content)

				arg_101_1.text_.text = var_104_15

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 56
				local var_104_17 = utf8.len(var_104_15)
				local var_104_18 = var_104_16 <= 0 and var_104_12 or var_104_12 * (var_104_17 / var_104_16)

				if var_104_18 > 0 and var_104_12 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18

					if var_104_18 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_11
					end
				end

				arg_101_1.text_.text = var_104_15
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042025", "story_v_out_115042.awb") ~= 0 then
					local var_104_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042025", "story_v_out_115042.awb") / 1000

					if var_104_19 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_11
					end

					if var_104_14.prefab_name ~= "" and arg_101_1.actors_[var_104_14.prefab_name] ~= nil then
						local var_104_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_14.prefab_name].transform, "story_v_out_115042", "115042025", "story_v_out_115042.awb")

						arg_101_1:RecordAudio("115042025", var_104_20)
						arg_101_1:RecordAudio("115042025", var_104_20)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115042", "115042025", "story_v_out_115042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115042", "115042025", "story_v_out_115042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_21 = math.max(var_104_12, arg_101_1.talkMaxDuration)

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_21 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_21

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_21 and arg_101_1.time_ < var_104_11 + var_104_21 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115042026
		arg_105_1.duration_ = 6.07

		local var_105_0 = {
			ja = 4.7,
			ko = 6.066,
			zh = 5.8,
			en = 3.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play115042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1052ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1052ui_story == nil then
				arg_105_1.var_.characterEffect1052ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1052ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1052ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1052ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1052ui_story.fillRatio = var_108_5
			end

			local var_108_6 = arg_105_1.actors_["1016ui_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1016ui_story == nil then
				arg_105_1.var_.characterEffect1016ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.2

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect1016ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1016ui_story then
				arg_105_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_11 = 0
			local var_108_12 = 0.85

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_13 = arg_105_1:FormatText(StoryNameCfg[260].name)

				arg_105_1.leftNameTxt_.text = var_108_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(115042026)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 34
				local var_108_17 = utf8.len(var_108_15)
				local var_108_18 = var_108_16 <= 0 and var_108_12 or var_108_12 * (var_108_17 / var_108_16)

				if var_108_18 > 0 and var_108_12 < var_108_18 then
					arg_105_1.talkMaxDuration = var_108_18

					if var_108_18 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042026", "story_v_out_115042.awb") ~= 0 then
					local var_108_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042026", "story_v_out_115042.awb") / 1000

					if var_108_19 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_11
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_115042", "115042026", "story_v_out_115042.awb")

						arg_105_1:RecordAudio("115042026", var_108_20)
						arg_105_1:RecordAudio("115042026", var_108_20)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115042", "115042026", "story_v_out_115042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115042", "115042026", "story_v_out_115042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_21 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_21 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_21

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_21 and arg_105_1.time_ < var_108_11 + var_108_21 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play115042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115042027
		arg_109_1.duration_ = 10.13

		local var_109_0 = {
			ja = 10.133,
			ko = 5.933,
			zh = 5.4,
			en = 6.366
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
				arg_109_0:Play115042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1052ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1052ui_story == nil then
				arg_109_1.var_.characterEffect1052ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1052ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1052ui_story then
				arg_109_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_5 = arg_109_1.actors_["1016ui_story"]
			local var_112_6 = 0

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1016ui_story == nil then
				arg_109_1.var_.characterEffect1016ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_7 = 0.2

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_7 and not isNil(var_112_5) then
				local var_112_8 = (arg_109_1.time_ - var_112_6) / var_112_7

				if arg_109_1.var_.characterEffect1016ui_story and not isNil(var_112_5) then
					local var_112_9 = Mathf.Lerp(0, 0.5, var_112_8)

					arg_109_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1016ui_story.fillRatio = var_112_9
				end
			end

			if arg_109_1.time_ >= var_112_6 + var_112_7 and arg_109_1.time_ < var_112_6 + var_112_7 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1016ui_story then
				local var_112_10 = 0.5

				arg_109_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1016ui_story.fillRatio = var_112_10
			end

			local var_112_11 = 0
			local var_112_12 = 0.575

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_13 = arg_109_1:FormatText(StoryNameCfg[263].name)

				arg_109_1.leftNameTxt_.text = var_112_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_14 = arg_109_1:GetWordFromCfg(115042027)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 23
				local var_112_17 = utf8.len(var_112_15)
				local var_112_18 = var_112_16 <= 0 and var_112_12 or var_112_12 * (var_112_17 / var_112_16)

				if var_112_18 > 0 and var_112_12 < var_112_18 then
					arg_109_1.talkMaxDuration = var_112_18

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042027", "story_v_out_115042.awb") ~= 0 then
					local var_112_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042027", "story_v_out_115042.awb") / 1000

					if var_112_19 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_115042", "115042027", "story_v_out_115042.awb")

						arg_109_1:RecordAudio("115042027", var_112_20)
						arg_109_1:RecordAudio("115042027", var_112_20)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115042", "115042027", "story_v_out_115042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115042", "115042027", "story_v_out_115042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_21 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_21 and arg_109_1.time_ < var_112_11 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play115042028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115042028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play115042029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_116_1 = 0
			local var_116_2 = 0.175

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(115042028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 7
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_2 or var_116_2 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_2 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_8 and arg_113_1.time_ < var_116_1 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play115042029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115042029
		arg_117_1.duration_ = 11.1

		local var_117_0 = {
			ja = 11.1,
			ko = 7.9,
			zh = 8.366,
			en = 4.7
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
				arg_117_0:Play115042030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1052ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1052ui_story == nil then
				arg_117_1.var_.characterEffect1052ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1052ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1052ui_story then
				arg_117_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_120_4 = 0

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_5 = arg_117_1.actors_["1016ui_story"]
			local var_120_6 = 0

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1016ui_story == nil then
				arg_117_1.var_.characterEffect1016ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.2

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_7 and not isNil(var_120_5) then
				local var_120_8 = (arg_117_1.time_ - var_120_6) / var_120_7

				if arg_117_1.var_.characterEffect1016ui_story and not isNil(var_120_5) then
					local var_120_9 = Mathf.Lerp(0, 0.5, var_120_8)

					arg_117_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1016ui_story.fillRatio = var_120_9
				end
			end

			if arg_117_1.time_ >= var_120_6 + var_120_7 and arg_117_1.time_ < var_120_6 + var_120_7 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1016ui_story then
				local var_120_10 = 0.5

				arg_117_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1016ui_story.fillRatio = var_120_10
			end

			local var_120_11 = 0
			local var_120_12 = 0.7

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_13 = arg_117_1:FormatText(StoryNameCfg[263].name)

				arg_117_1.leftNameTxt_.text = var_120_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(115042029)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 28
				local var_120_17 = utf8.len(var_120_15)
				local var_120_18 = var_120_16 <= 0 and var_120_12 or var_120_12 * (var_120_17 / var_120_16)

				if var_120_18 > 0 and var_120_12 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18

					if var_120_18 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042029", "story_v_out_115042.awb") ~= 0 then
					local var_120_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042029", "story_v_out_115042.awb") / 1000

					if var_120_19 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_11
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_115042", "115042029", "story_v_out_115042.awb")

						arg_117_1:RecordAudio("115042029", var_120_20)
						arg_117_1:RecordAudio("115042029", var_120_20)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_115042", "115042029", "story_v_out_115042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_115042", "115042029", "story_v_out_115042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_21 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_21

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_21 and arg_117_1.time_ < var_120_11 + var_120_21 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play115042030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115042030
		arg_121_1.duration_ = 10.6

		local var_121_0 = {
			ja = 4.533,
			ko = 9.933,
			zh = 10.6,
			en = 9.066
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play115042031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_124_2 = 0
			local var_124_3 = 1.025

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_4 = arg_121_1:FormatText(StoryNameCfg[263].name)

				arg_121_1.leftNameTxt_.text = var_124_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(115042030)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 41
				local var_124_8 = utf8.len(var_124_6)
				local var_124_9 = var_124_7 <= 0 and var_124_3 or var_124_3 * (var_124_8 / var_124_7)

				if var_124_9 > 0 and var_124_3 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042030", "story_v_out_115042.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_115042", "115042030", "story_v_out_115042.awb") / 1000

					if var_124_10 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_2
					end

					if var_124_5.prefab_name ~= "" and arg_121_1.actors_[var_124_5.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_5.prefab_name].transform, "story_v_out_115042", "115042030", "story_v_out_115042.awb")

						arg_121_1:RecordAudio("115042030", var_124_11)
						arg_121_1:RecordAudio("115042030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_115042", "115042030", "story_v_out_115042.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_115042", "115042030", "story_v_out_115042.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_12 and arg_121_1.time_ < var_124_2 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play115042031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115042031
		arg_125_1.duration_ = 5.93

		local var_125_0 = {
			ja = 3.7,
			ko = 3.1,
			zh = 4.033,
			en = 5.933
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
				arg_125_0:Play115042032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1052ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1052ui_story == nil then
				arg_125_1.var_.characterEffect1052ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1052ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1052ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1052ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1052ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["1016ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1016ui_story == nil then
				arg_125_1.var_.characterEffect1016ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.2

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect1016ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1016ui_story then
				arg_125_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_128_11 = 0
			local var_128_12 = 0.475

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_13 = arg_125_1:FormatText(StoryNameCfg[260].name)

				arg_125_1.leftNameTxt_.text = var_128_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(115042031)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 19
				local var_128_17 = utf8.len(var_128_15)
				local var_128_18 = var_128_16 <= 0 and var_128_12 or var_128_12 * (var_128_17 / var_128_16)

				if var_128_18 > 0 and var_128_12 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042031", "story_v_out_115042.awb") ~= 0 then
					local var_128_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042031", "story_v_out_115042.awb") / 1000

					if var_128_19 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_11
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_115042", "115042031", "story_v_out_115042.awb")

						arg_125_1:RecordAudio("115042031", var_128_20)
						arg_125_1:RecordAudio("115042031", var_128_20)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_115042", "115042031", "story_v_out_115042.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_115042", "115042031", "story_v_out_115042.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_21 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_21

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_21 and arg_125_1.time_ < var_128_11 + var_128_21 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play115042032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115042032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play115042033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			local var_132_2 = arg_129_1.actors_["1016ui_story"]
			local var_132_3 = 0

			if var_132_3 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1016ui_story == nil then
				arg_129_1.var_.characterEffect1016ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.2

			if var_132_3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_3 + var_132_4 and not isNil(var_132_2) then
				local var_132_5 = (arg_129_1.time_ - var_132_3) / var_132_4

				if arg_129_1.var_.characterEffect1016ui_story and not isNil(var_132_2) then
					local var_132_6 = Mathf.Lerp(0, 0.5, var_132_5)

					arg_129_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1016ui_story.fillRatio = var_132_6
				end
			end

			if arg_129_1.time_ >= var_132_3 + var_132_4 and arg_129_1.time_ < var_132_3 + var_132_4 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1016ui_story then
				local var_132_7 = 0.5

				arg_129_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1016ui_story.fillRatio = var_132_7
			end

			local var_132_8 = 0
			local var_132_9 = 1

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				local var_132_10 = "play"
				local var_132_11 = "effect"

				arg_129_1:AudioAction(var_132_10, var_132_11, "se_story_15", "se_story_15_gun06", "")
			end

			local var_132_12 = 0
			local var_132_13 = 0.625

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(115042032)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 25
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_13 or var_132_13 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_13 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_19 and arg_129_1.time_ < var_132_12 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play115042033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 115042033
		arg_133_1.duration_ = 8.4

		local var_133_0 = {
			ja = 7.433,
			ko = 8.033,
			zh = 8.4,
			en = 4.166
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play115042034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1052ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1052ui_story == nil then
				arg_133_1.var_.characterEffect1052ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1052ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1052ui_story then
				arg_133_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_5 = 0
			local var_136_6 = 0.75

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_7 = arg_133_1:FormatText(StoryNameCfg[263].name)

				arg_133_1.leftNameTxt_.text = var_136_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(115042033)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 30
				local var_136_11 = utf8.len(var_136_9)
				local var_136_12 = var_136_10 <= 0 and var_136_6 or var_136_6 * (var_136_11 / var_136_10)

				if var_136_12 > 0 and var_136_6 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042033", "story_v_out_115042.awb") ~= 0 then
					local var_136_13 = manager.audio:GetVoiceLength("story_v_out_115042", "115042033", "story_v_out_115042.awb") / 1000

					if var_136_13 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_5
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_115042", "115042033", "story_v_out_115042.awb")

						arg_133_1:RecordAudio("115042033", var_136_14)
						arg_133_1:RecordAudio("115042033", var_136_14)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_115042", "115042033", "story_v_out_115042.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_115042", "115042033", "story_v_out_115042.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_15 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_15 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_15

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_15 and arg_133_1.time_ < var_136_5 + var_136_15 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play115042034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 115042034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play115042035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1052ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1052ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1052ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1016ui_story"].transform
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.var_.moveOldPos1016ui_story = var_140_9.localPosition
			end

			local var_140_11 = 0.001

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11
				local var_140_13 = Vector3.New(0, 100, 0)

				var_140_9.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1016ui_story, var_140_13, var_140_12)

				local var_140_14 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_14.x, var_140_14.y, var_140_14.z)

				local var_140_15 = var_140_9.localEulerAngles

				var_140_15.z = 0
				var_140_15.x = 0
				var_140_9.localEulerAngles = var_140_15
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 then
				var_140_9.localPosition = Vector3.New(0, 100, 0)

				local var_140_16 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_16.x, var_140_16.y, var_140_16.z)

				local var_140_17 = var_140_9.localEulerAngles

				var_140_17.z = 0
				var_140_17.x = 0
				var_140_9.localEulerAngles = var_140_17
			end

			local var_140_18 = 0
			local var_140_19 = 0.875

			if var_140_18 < arg_137_1.time_ and arg_137_1.time_ <= var_140_18 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_20 = arg_137_1:GetWordFromCfg(115042034)
				local var_140_21 = arg_137_1:FormatText(var_140_20.content)

				arg_137_1.text_.text = var_140_21

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_22 = 35
				local var_140_23 = utf8.len(var_140_21)
				local var_140_24 = var_140_22 <= 0 and var_140_19 or var_140_19 * (var_140_23 / var_140_22)

				if var_140_24 > 0 and var_140_19 < var_140_24 then
					arg_137_1.talkMaxDuration = var_140_24

					if var_140_24 + var_140_18 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_18
					end
				end

				arg_137_1.text_.text = var_140_21
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_19, arg_137_1.talkMaxDuration)

			if var_140_18 <= arg_137_1.time_ and arg_137_1.time_ < var_140_18 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_18) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_18 + var_140_25 and arg_137_1.time_ < var_140_18 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play115042035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 115042035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play115042036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = manager.ui.mainCamera.transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_0.localPosition
			end

			local var_144_2 = 1

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / 0.066
				local var_144_4, var_144_5 = math.modf(var_144_3)

				var_144_0.localPosition = Vector3.New(var_144_5 * 0.13, var_144_5 * 0.13, var_144_5 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_7 = 1

			if arg_141_1.time_ >= var_144_6 + var_144_7 and arg_141_1.time_ < var_144_6 + var_144_7 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_8 = 0
			local var_144_9 = 1

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				local var_144_10 = "play"
				local var_144_11 = "effect"

				arg_141_1:AudioAction(var_144_10, var_144_11, "se_story_15", "se_story_15_gun07", "")
			end

			local var_144_12 = 0
			local var_144_13 = 0.85

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_14 = arg_141_1:GetWordFromCfg(115042035)
				local var_144_15 = arg_141_1:FormatText(var_144_14.content)

				arg_141_1.text_.text = var_144_15

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 34
				local var_144_17 = utf8.len(var_144_15)
				local var_144_18 = var_144_16 <= 0 and var_144_13 or var_144_13 * (var_144_17 / var_144_16)

				if var_144_18 > 0 and var_144_13 < var_144_18 then
					arg_141_1.talkMaxDuration = var_144_18

					if var_144_18 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_15
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_19 and arg_141_1.time_ < var_144_12 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play115042036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 115042036
		arg_145_1.duration_ = 8.07

		local var_145_0 = {
			ja = 7.133,
			ko = 7.433,
			zh = 7.4,
			en = 8.066
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play115042037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_148_2 = arg_145_1.actors_["1052ui_story"]
			local var_148_3 = 0

			if var_148_3 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1052ui_story == nil then
				arg_145_1.var_.characterEffect1052ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.2

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_4 and not isNil(var_148_2) then
				local var_148_5 = (arg_145_1.time_ - var_148_3) / var_148_4

				if arg_145_1.var_.characterEffect1052ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_3 + var_148_4 and arg_145_1.time_ < var_148_3 + var_148_4 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1052ui_story then
				arg_145_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_148_6 = arg_145_1.actors_["1052ui_story"].transform
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.var_.moveOldPos1052ui_story = var_148_6.localPosition
			end

			local var_148_8 = 0.001

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8
				local var_148_10 = Vector3.New(0.7, -1.05, -6.2)

				var_148_6.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1052ui_story, var_148_10, var_148_9)

				local var_148_11 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_11.x, var_148_11.y, var_148_11.z)

				local var_148_12 = var_148_6.localEulerAngles

				var_148_12.z = 0
				var_148_12.x = 0
				var_148_6.localEulerAngles = var_148_12
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 then
				var_148_6.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_148_13 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_13.x, var_148_13.y, var_148_13.z)

				local var_148_14 = var_148_6.localEulerAngles

				var_148_14.z = 0
				var_148_14.x = 0
				var_148_6.localEulerAngles = var_148_14
			end

			local var_148_15 = 0
			local var_148_16 = 0.85

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[263].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(115042036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 34
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042036", "story_v_out_115042.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_115042", "115042036", "story_v_out_115042.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_115042", "115042036", "story_v_out_115042.awb")

						arg_145_1:RecordAudio("115042036", var_148_24)
						arg_145_1:RecordAudio("115042036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_115042", "115042036", "story_v_out_115042.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_115042", "115042036", "story_v_out_115042.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play115042037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 115042037
		arg_149_1.duration_ = 9.7

		local var_149_0 = {
			ja = 9.133,
			ko = 9.2,
			zh = 9.2,
			en = 9.7
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play115042038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_152_1 = arg_149_1.actors_["1016ui_story"].transform
			local var_152_2 = 0

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.var_.moveOldPos1016ui_story = var_152_1.localPosition
			end

			local var_152_3 = 0.001

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_2) / var_152_3
				local var_152_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_152_1.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1016ui_story, var_152_5, var_152_4)

				local var_152_6 = manager.ui.mainCamera.transform.position - var_152_1.position

				var_152_1.forward = Vector3.New(var_152_6.x, var_152_6.y, var_152_6.z)

				local var_152_7 = var_152_1.localEulerAngles

				var_152_7.z = 0
				var_152_7.x = 0
				var_152_1.localEulerAngles = var_152_7
			end

			if arg_149_1.time_ >= var_152_2 + var_152_3 and arg_149_1.time_ < var_152_2 + var_152_3 + arg_152_0 then
				var_152_1.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_152_8 = manager.ui.mainCamera.transform.position - var_152_1.position

				var_152_1.forward = Vector3.New(var_152_8.x, var_152_8.y, var_152_8.z)

				local var_152_9 = var_152_1.localEulerAngles

				var_152_9.z = 0
				var_152_9.x = 0
				var_152_1.localEulerAngles = var_152_9
			end

			local var_152_10 = arg_149_1.actors_["1016ui_story"]
			local var_152_11 = 0

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1016ui_story == nil then
				arg_149_1.var_.characterEffect1016ui_story = var_152_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_12 = 0.2

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_12 and not isNil(var_152_10) then
				local var_152_13 = (arg_149_1.time_ - var_152_11) / var_152_12

				if arg_149_1.var_.characterEffect1016ui_story and not isNil(var_152_10) then
					local var_152_14 = Mathf.Lerp(0, 0.5, var_152_13)

					arg_149_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1016ui_story.fillRatio = var_152_14
				end
			end

			if arg_149_1.time_ >= var_152_11 + var_152_12 and arg_149_1.time_ < var_152_11 + var_152_12 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1016ui_story then
				local var_152_15 = 0.5

				arg_149_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1016ui_story.fillRatio = var_152_15
			end

			local var_152_16 = 0
			local var_152_17 = 1.05

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_18 = arg_149_1:FormatText(StoryNameCfg[263].name)

				arg_149_1.leftNameTxt_.text = var_152_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(115042037)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 42
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_17 or var_152_17 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_17 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_16
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042037", "story_v_out_115042.awb") ~= 0 then
					local var_152_24 = manager.audio:GetVoiceLength("story_v_out_115042", "115042037", "story_v_out_115042.awb") / 1000

					if var_152_24 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_16
					end

					if var_152_19.prefab_name ~= "" and arg_149_1.actors_[var_152_19.prefab_name] ~= nil then
						local var_152_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_19.prefab_name].transform, "story_v_out_115042", "115042037", "story_v_out_115042.awb")

						arg_149_1:RecordAudio("115042037", var_152_25)
						arg_149_1:RecordAudio("115042037", var_152_25)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_115042", "115042037", "story_v_out_115042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_115042", "115042037", "story_v_out_115042.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_26 = math.max(var_152_17, arg_149_1.talkMaxDuration)

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_26 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_16) / var_152_26

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_16 + var_152_26 and arg_149_1.time_ < var_152_16 + var_152_26 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play115042038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 115042038
		arg_153_1.duration_ = 4.97

		local var_153_0 = {
			ja = 4.966,
			ko = 4.233,
			zh = 4.733,
			en = 3
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play115042039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1052ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1052ui_story == nil then
				arg_153_1.var_.characterEffect1052ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1052ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1052ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1052ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1052ui_story.fillRatio = var_156_5
			end

			local var_156_6 = arg_153_1.actors_["1016ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1016ui_story == nil then
				arg_153_1.var_.characterEffect1016ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.2

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect1016ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1016ui_story then
				arg_153_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_156_11 = 0
			local var_156_12 = 0.45

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[260].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(115042038)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 18
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042038", "story_v_out_115042.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042038", "story_v_out_115042.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_115042", "115042038", "story_v_out_115042.awb")

						arg_153_1:RecordAudio("115042038", var_156_20)
						arg_153_1:RecordAudio("115042038", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_115042", "115042038", "story_v_out_115042.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_115042", "115042038", "story_v_out_115042.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play115042039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 115042039
		arg_157_1.duration_ = 9.2

		local var_157_0 = {
			ja = 9.2,
			ko = 6.266,
			zh = 5.966,
			en = 7.8
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play115042040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1052ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1052ui_story == nil then
				arg_157_1.var_.characterEffect1052ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1052ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1052ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1052ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1052ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["1016ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1016ui_story == nil then
				arg_157_1.var_.characterEffect1016ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1016ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1016ui_story then
				arg_157_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_160_11 = 0
			local var_160_12 = 0.675

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_13 = arg_157_1:FormatText(StoryNameCfg[260].name)

				arg_157_1.leftNameTxt_.text = var_160_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_14 = arg_157_1:GetWordFromCfg(115042039)
				local var_160_15 = arg_157_1:FormatText(var_160_14.content)

				arg_157_1.text_.text = var_160_15

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 27
				local var_160_17 = utf8.len(var_160_15)
				local var_160_18 = var_160_16 <= 0 and var_160_12 or var_160_12 * (var_160_17 / var_160_16)

				if var_160_18 > 0 and var_160_12 < var_160_18 then
					arg_157_1.talkMaxDuration = var_160_18

					if var_160_18 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_11
					end
				end

				arg_157_1.text_.text = var_160_15
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042039", "story_v_out_115042.awb") ~= 0 then
					local var_160_19 = manager.audio:GetVoiceLength("story_v_out_115042", "115042039", "story_v_out_115042.awb") / 1000

					if var_160_19 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_11
					end

					if var_160_14.prefab_name ~= "" and arg_157_1.actors_[var_160_14.prefab_name] ~= nil then
						local var_160_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_14.prefab_name].transform, "story_v_out_115042", "115042039", "story_v_out_115042.awb")

						arg_157_1:RecordAudio("115042039", var_160_20)
						arg_157_1:RecordAudio("115042039", var_160_20)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_115042", "115042039", "story_v_out_115042.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_115042", "115042039", "story_v_out_115042.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_21 = math.max(var_160_12, arg_157_1.talkMaxDuration)

			if var_160_11 <= arg_157_1.time_ and arg_157_1.time_ < var_160_11 + var_160_21 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_11) / var_160_21

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_11 + var_160_21 and arg_157_1.time_ < var_160_11 + var_160_21 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play115042040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 115042040
		arg_161_1.duration_ = 3.87

		local var_161_0 = {
			ja = 3.4,
			ko = 3.5,
			zh = 2.9,
			en = 3.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play115042041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_1 = arg_161_1.actors_["1052ui_story"]
			local var_164_2 = 0

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1052ui_story == nil then
				arg_161_1.var_.characterEffect1052ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_3 and not isNil(var_164_1) then
				local var_164_4 = (arg_161_1.time_ - var_164_2) / var_164_3

				if arg_161_1.var_.characterEffect1052ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_2 + var_164_3 and arg_161_1.time_ < var_164_2 + var_164_3 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1052ui_story then
				arg_161_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_164_5 = arg_161_1.actors_["1016ui_story"]
			local var_164_6 = 0

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1016ui_story == nil then
				arg_161_1.var_.characterEffect1016ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.2

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_7 and not isNil(var_164_5) then
				local var_164_8 = (arg_161_1.time_ - var_164_6) / var_164_7

				if arg_161_1.var_.characterEffect1016ui_story and not isNil(var_164_5) then
					local var_164_9 = Mathf.Lerp(0, 0.5, var_164_8)

					arg_161_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1016ui_story.fillRatio = var_164_9
				end
			end

			if arg_161_1.time_ >= var_164_6 + var_164_7 and arg_161_1.time_ < var_164_6 + var_164_7 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1016ui_story then
				local var_164_10 = 0.5

				arg_161_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1016ui_story.fillRatio = var_164_10
			end

			local var_164_11 = 0

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action2_1")
			end

			local var_164_12 = arg_161_1.actors_["1052ui_story"].transform
			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1.var_.moveOldPos1052ui_story = var_164_12.localPosition

				local var_164_14 = "1052ui_story"

				arg_161_1:ShowWeapon(arg_161_1.var_[var_164_14 .. "Animator"].transform, true)
			end

			local var_164_15 = 0.001

			if var_164_13 <= arg_161_1.time_ and arg_161_1.time_ < var_164_13 + var_164_15 then
				local var_164_16 = (arg_161_1.time_ - var_164_13) / var_164_15
				local var_164_17 = Vector3.New(0.7, -1.05, -6.2)

				var_164_12.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1052ui_story, var_164_17, var_164_16)

				local var_164_18 = manager.ui.mainCamera.transform.position - var_164_12.position

				var_164_12.forward = Vector3.New(var_164_18.x, var_164_18.y, var_164_18.z)

				local var_164_19 = var_164_12.localEulerAngles

				var_164_19.z = 0
				var_164_19.x = 0
				var_164_12.localEulerAngles = var_164_19
			end

			if arg_161_1.time_ >= var_164_13 + var_164_15 and arg_161_1.time_ < var_164_13 + var_164_15 + arg_164_0 then
				var_164_12.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_164_20 = manager.ui.mainCamera.transform.position - var_164_12.position

				var_164_12.forward = Vector3.New(var_164_20.x, var_164_20.y, var_164_20.z)

				local var_164_21 = var_164_12.localEulerAngles

				var_164_21.z = 0
				var_164_21.x = 0
				var_164_12.localEulerAngles = var_164_21
			end

			local var_164_22 = 0
			local var_164_23 = 0.25

			if var_164_22 < arg_161_1.time_ and arg_161_1.time_ <= var_164_22 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_24 = arg_161_1:FormatText(StoryNameCfg[263].name)

				arg_161_1.leftNameTxt_.text = var_164_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_25 = arg_161_1:GetWordFromCfg(115042040)
				local var_164_26 = arg_161_1:FormatText(var_164_25.content)

				arg_161_1.text_.text = var_164_26

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_27 = 10
				local var_164_28 = utf8.len(var_164_26)
				local var_164_29 = var_164_27 <= 0 and var_164_23 or var_164_23 * (var_164_28 / var_164_27)

				if var_164_29 > 0 and var_164_23 < var_164_29 then
					arg_161_1.talkMaxDuration = var_164_29

					if var_164_29 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_29 + var_164_22
					end
				end

				arg_161_1.text_.text = var_164_26
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042040", "story_v_out_115042.awb") ~= 0 then
					local var_164_30 = manager.audio:GetVoiceLength("story_v_out_115042", "115042040", "story_v_out_115042.awb") / 1000

					if var_164_30 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_30 + var_164_22
					end

					if var_164_25.prefab_name ~= "" and arg_161_1.actors_[var_164_25.prefab_name] ~= nil then
						local var_164_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_25.prefab_name].transform, "story_v_out_115042", "115042040", "story_v_out_115042.awb")

						arg_161_1:RecordAudio("115042040", var_164_31)
						arg_161_1:RecordAudio("115042040", var_164_31)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_115042", "115042040", "story_v_out_115042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_115042", "115042040", "story_v_out_115042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_32 = math.max(var_164_23, arg_161_1.talkMaxDuration)

			if var_164_22 <= arg_161_1.time_ and arg_161_1.time_ < var_164_22 + var_164_32 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_22) / var_164_32

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_22 + var_164_32 and arg_161_1.time_ < var_164_22 + var_164_32 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play115042041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 115042041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play115042042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1052ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1052ui_story == nil then
				arg_165_1.var_.characterEffect1052ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1052ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1052ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1052ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1052ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 1

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				local var_168_8 = "play"
				local var_168_9 = "effect"

				arg_165_1:AudioAction(var_168_8, var_168_9, "se_story_15", "se_story_15_gun03", "")
			end

			local var_168_10 = 0
			local var_168_11 = 0.325

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_12 = arg_165_1:GetWordFromCfg(115042041)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_14 = 13
				local var_168_15 = utf8.len(var_168_13)
				local var_168_16 = var_168_14 <= 0 and var_168_11 or var_168_11 * (var_168_15 / var_168_14)

				if var_168_16 > 0 and var_168_11 < var_168_16 then
					arg_165_1.talkMaxDuration = var_168_16

					if var_168_16 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_17 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_17 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_17

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_17 and arg_165_1.time_ < var_168_10 + var_168_17 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play115042042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 115042042
		arg_169_1.duration_ = 8.57

		local var_169_0 = {
			ja = 8.566,
			ko = 5.9,
			zh = 7.4,
			en = 3.566
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
			arg_169_1.auto_ = false
		end

		function arg_169_1.playNext_(arg_171_0)
			arg_169_1.onStoryFinished_()
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1052ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1052ui_story == nil then
				arg_169_1.var_.characterEffect1052ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1052ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1052ui_story then
				arg_169_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_5 = 0
			local var_172_6 = 0.65

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_7 = arg_169_1:FormatText(StoryNameCfg[263].name)

				arg_169_1.leftNameTxt_.text = var_172_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(115042042)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 26
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_6 or var_172_6 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_6 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115042", "115042042", "story_v_out_115042.awb") ~= 0 then
					local var_172_13 = manager.audio:GetVoiceLength("story_v_out_115042", "115042042", "story_v_out_115042.awb") / 1000

					if var_172_13 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_5
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_115042", "115042042", "story_v_out_115042.awb")

						arg_169_1:RecordAudio("115042042", var_172_14)
						arg_169_1:RecordAudio("115042042", var_172_14)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_115042", "115042042", "story_v_out_115042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_115042", "115042042", "story_v_out_115042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_15 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_15 and arg_169_1.time_ < var_172_5 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G02a"
	},
	voices = {
		"story_v_out_115042.awb"
	}
}
