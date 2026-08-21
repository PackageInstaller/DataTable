return {
	Play110141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110141001
		arg_1_1.duration_ = 6.5

		local var_1_0 = {
			ja = 5.7,
			ko = 6.5,
			zh = 5.4,
			en = 3.766
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
				arg_1_0:Play110141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.6

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_6 = 0.738461699336767
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if var_4_11 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 0
			local var_4_13 = 0.575

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_15 = arg_1_1:FormatText(StoryNameCfg[37].name)

				arg_1_1.leftNameTxt_.text = var_4_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:GetWordFromCfg(110141001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 22
				local var_4_19 = utf8.len(var_4_17)
				local var_4_20 = var_4_18 <= 0 and var_4_13 or var_4_13 * (var_4_19 / var_4_18)

				if var_4_20 > 0 and var_4_13 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_12 = var_4_12 + 0.3

					if var_4_20 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141001", "story_v_out_110141.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_110141", "110141001", "story_v_out_110141.awb") / 1000

					if var_4_21 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_12
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_110141", "110141001", "story_v_out_110141.awb")

						arg_1_1:RecordAudio("110141001", var_4_22)
						arg_1_1:RecordAudio("110141001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_110141", "110141001", "story_v_out_110141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_110141", "110141001", "story_v_out_110141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_12 + 0.3
			local var_4_24 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play110141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 110141002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play110141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.95

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(110141002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 38
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
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play110141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 110141003
		arg_13_1.duration_ = 7.33

		local var_13_0 = {
			ja = 3.466,
			ko = 6.7,
			zh = 7.333,
			en = 7.3
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
				arg_13_0:Play110141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "OS0102a"

			if arg_13_1.bgs_[var_16_0] == nil then
				local var_16_1 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_16_0)
				var_16_1.name = var_16_0
				var_16_1.transform.parent = arg_13_1.stage_.transform
				var_16_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_[var_16_0] = var_16_1
			end

			local var_16_2 = 0

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				local var_16_3 = manager.ui.mainCamera.transform.localPosition
				local var_16_4 = Vector3.New(0, 0, 10) + Vector3.New(var_16_3.x, var_16_3.y, 0)
				local var_16_5 = arg_13_1.bgs_.OS0102a

				var_16_5.transform.localPosition = var_16_4
				var_16_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_6 = var_16_5:GetComponent("SpriteRenderer")

				if var_16_6 and var_16_6.sprite then
					local var_16_7 = (var_16_5.transform.localPosition - var_16_3).z
					local var_16_8 = manager.ui.mainCameraCom_
					local var_16_9 = 2 * var_16_7 * Mathf.Tan(var_16_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_16_10 = var_16_9 * var_16_8.aspect
					local var_16_11 = var_16_6.sprite.bounds.size.x
					local var_16_12 = var_16_6.sprite.bounds.size.y
					local var_16_13 = var_16_10 / var_16_11
					local var_16_14 = var_16_9 / var_16_12
					local var_16_15 = var_16_14 < var_16_13 and var_16_13 or var_16_14

					var_16_5.transform.localScale = Vector3.New(var_16_15, var_16_15, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "OS0102a" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_16 = arg_13_1.bgs_.OS0102a
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 then
				local var_16_18 = var_16_16:GetComponent("SpriteRenderer")

				if var_16_18 then
					arg_13_1.var_.alphaOldValueOS0102a = var_16_18.color.a
					arg_13_1.var_.alphaMatValueOS0102a = var_16_18
				end

				arg_13_1.var_.alphaOldValueOS0102a = 0
			end

			local var_16_19 = 1.5

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_19 then
				local var_16_20 = (arg_13_1.time_ - var_16_17) / var_16_19
				local var_16_21 = Mathf.Lerp(arg_13_1.var_.alphaOldValueOS0102a, 1, var_16_20)

				if arg_13_1.var_.alphaMatValueOS0102a then
					local var_16_22 = arg_13_1.var_.alphaMatValueOS0102a.color

					var_16_22.a = var_16_21
					arg_13_1.var_.alphaMatValueOS0102a.color = var_16_22
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_19 and arg_13_1.time_ < var_16_17 + var_16_19 + arg_16_0 and arg_13_1.var_.alphaMatValueOS0102a then
				local var_16_23 = arg_13_1.var_.alphaMatValueOS0102a
				local var_16_24 = var_16_23.color

				var_16_24.a = 1
				var_16_23.color = var_16_24
			end

			local var_16_25 = 0

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_26 = 2

			if arg_13_1.time_ >= var_16_25 + var_16_26 and arg_13_1.time_ < var_16_25 + var_16_26 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_27 = 2
			local var_16_28 = 0.35

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_29 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_29:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_30 = arg_13_1:FormatText(StoryNameCfg[37].name)

				arg_13_1.leftNameTxt_.text = var_16_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_31 = arg_13_1:GetWordFromCfg(110141003)
				local var_16_32 = arg_13_1:FormatText(var_16_31.content)

				arg_13_1.text_.text = var_16_32

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_33 = 14
				local var_16_34 = utf8.len(var_16_32)
				local var_16_35 = var_16_33 <= 0 and var_16_28 or var_16_28 * (var_16_34 / var_16_33)

				if var_16_35 > 0 and var_16_28 < var_16_35 then
					arg_13_1.talkMaxDuration = var_16_35
					var_16_27 = var_16_27 + 0.3

					if var_16_35 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_35 + var_16_27
					end
				end

				arg_13_1.text_.text = var_16_32
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141003", "story_v_out_110141.awb") ~= 0 then
					local var_16_36 = manager.audio:GetVoiceLength("story_v_out_110141", "110141003", "story_v_out_110141.awb") / 1000

					if var_16_36 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_36 + var_16_27
					end

					if var_16_31.prefab_name ~= "" and arg_13_1.actors_[var_16_31.prefab_name] ~= nil then
						local var_16_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_31.prefab_name].transform, "story_v_out_110141", "110141003", "story_v_out_110141.awb")

						arg_13_1:RecordAudio("110141003", var_16_37)
						arg_13_1:RecordAudio("110141003", var_16_37)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_110141", "110141003", "story_v_out_110141.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_110141", "110141003", "story_v_out_110141.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_38 = var_16_27 + 0.3
			local var_16_39 = math.max(var_16_28, arg_13_1.talkMaxDuration)

			if var_16_38 <= arg_13_1.time_ and arg_13_1.time_ < var_16_38 + var_16_39 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_38) / var_16_39

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_38 + var_16_39 and arg_13_1.time_ < var_16_38 + var_16_39 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play110141004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 110141004
		arg_19_1.duration_ = 6.6

		local var_19_0 = {
			ja = 6.6,
			ko = 4.433,
			zh = 3.133,
			en = 2.133
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play110141005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.325

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[37].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(110141004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 13
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141004", "story_v_out_110141.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_110141", "110141004", "story_v_out_110141.awb") / 1000

					if var_22_8 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_110141", "110141004", "story_v_out_110141.awb")

						arg_19_1:RecordAudio("110141004", var_22_9)
						arg_19_1:RecordAudio("110141004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_110141", "110141004", "story_v_out_110141.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_110141", "110141004", "story_v_out_110141.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_10 and arg_19_1.time_ < var_22_0 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play110141005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110141005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110141006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = manager.ui.mainCamera.transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.shakeOldPos = var_26_0.localPosition
			end

			local var_26_2 = 0.6

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / 0.066
				local var_26_4, var_26_5 = math.modf(var_26_3)

				var_26_0.localPosition = Vector3.New(var_26_5 * 0.13, var_26_5 * 0.13, var_26_5 * 0.13) + arg_23_1.var_.shakeOldPos
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = arg_23_1.var_.shakeOldPos
			end

			local var_26_6 = 0
			local var_26_7 = 0.2

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_8 = arg_23_1:GetWordFromCfg(110141005)
				local var_26_9 = arg_23_1:FormatText(var_26_8.content)

				arg_23_1.text_.text = var_26_9

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 8
				local var_26_11 = utf8.len(var_26_9)
				local var_26_12 = var_26_10 <= 0 and var_26_7 or var_26_7 * (var_26_11 / var_26_10)

				if var_26_12 > 0 and var_26_7 < var_26_12 then
					arg_23_1.talkMaxDuration = var_26_12

					if var_26_12 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_12 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_9
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_13 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_13 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_13

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_13 and arg_23_1.time_ < var_26_6 + var_26_13 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110141006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110141006
		arg_27_1.duration_ = 8.11

		local var_27_0 = {
			ja = 7.308,
			ko = 7.841,
			zh = 8.108,
			en = 7.141
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
				arg_27_0:Play110141007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.bgs_.OS0102a
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				local var_30_2 = var_30_0:GetComponent("SpriteRenderer")

				if var_30_2 then
					arg_27_1.var_.alphaOldValueOS0102a = var_30_2.color.a
					arg_27_1.var_.alphaMatValueOS0102a = var_30_2
				end

				arg_27_1.var_.alphaOldValueOS0102a = 1
			end

			local var_30_3 = 1.5

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_3 then
				local var_30_4 = (arg_27_1.time_ - var_30_1) / var_30_3
				local var_30_5 = Mathf.Lerp(arg_27_1.var_.alphaOldValueOS0102a, 0, var_30_4)

				if arg_27_1.var_.alphaMatValueOS0102a then
					local var_30_6 = arg_27_1.var_.alphaMatValueOS0102a.color

					var_30_6.a = var_30_5
					arg_27_1.var_.alphaMatValueOS0102a.color = var_30_6
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_3 and arg_27_1.time_ < var_30_1 + var_30_3 + arg_30_0 and arg_27_1.var_.alphaMatValueOS0102a then
				local var_30_7 = arg_27_1.var_.alphaMatValueOS0102a
				local var_30_8 = var_30_7.color

				var_30_8.a = 0
				var_30_7.color = var_30_8
			end

			local var_30_9 = "OS0102b"

			if arg_27_1.bgs_[var_30_9] == nil then
				local var_30_10 = Object.Instantiate(arg_27_1.paintGo_)

				var_30_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_30_9)
				var_30_10.name = var_30_9
				var_30_10.transform.parent = arg_27_1.stage_.transform
				var_30_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.bgs_[var_30_9] = var_30_10
			end

			local var_30_11 = arg_27_1.bgs_.OS0102b
			local var_30_12 = 1.5

			if var_30_12 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				local var_30_13 = var_30_11:GetComponent("SpriteRenderer")

				if var_30_13 then
					arg_27_1.var_.alphaOldValueOS0102b = var_30_13.color.a
					arg_27_1.var_.alphaMatValueOS0102b = var_30_13
				end

				arg_27_1.var_.alphaOldValueOS0102b = 0
			end

			local var_30_14 = 1.5

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_14 then
				local var_30_15 = (arg_27_1.time_ - var_30_12) / var_30_14
				local var_30_16 = Mathf.Lerp(arg_27_1.var_.alphaOldValueOS0102b, 1, var_30_15)

				if arg_27_1.var_.alphaMatValueOS0102b then
					local var_30_17 = arg_27_1.var_.alphaMatValueOS0102b.color

					var_30_17.a = var_30_16
					arg_27_1.var_.alphaMatValueOS0102b.color = var_30_17
				end
			end

			if arg_27_1.time_ >= var_30_12 + var_30_14 and arg_27_1.time_ < var_30_12 + var_30_14 + arg_30_0 and arg_27_1.var_.alphaMatValueOS0102b then
				local var_30_18 = arg_27_1.var_.alphaMatValueOS0102b
				local var_30_19 = var_30_18.color

				var_30_19.a = 1
				var_30_18.color = var_30_19
			end

			local var_30_20 = 1.5

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				local var_30_21 = manager.ui.mainCamera.transform.localPosition
				local var_30_22 = Vector3.New(0, 0, 10) + Vector3.New(var_30_21.x, var_30_21.y, 0)
				local var_30_23 = arg_27_1.bgs_.OS0102b

				var_30_23.transform.localPosition = var_30_22
				var_30_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_24 = var_30_23:GetComponent("SpriteRenderer")

				if var_30_24 and var_30_24.sprite then
					local var_30_25 = (var_30_23.transform.localPosition - var_30_21).z
					local var_30_26 = manager.ui.mainCameraCom_
					local var_30_27 = 2 * var_30_25 * Mathf.Tan(var_30_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_30_28 = var_30_27 * var_30_26.aspect
					local var_30_29 = var_30_24.sprite.bounds.size.x
					local var_30_30 = var_30_24.sprite.bounds.size.y
					local var_30_31 = var_30_28 / var_30_29
					local var_30_32 = var_30_27 / var_30_30
					local var_30_33 = var_30_32 < var_30_31 and var_30_31 or var_30_32

					var_30_23.transform.localScale = Vector3.New(var_30_33, var_30_33, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "OS0102b" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_34 = 0

			if var_30_34 < arg_27_1.time_ and arg_27_1.time_ <= var_30_34 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			local var_30_35 = 2.375

			if arg_27_1.time_ >= var_30_34 + var_30_35 and arg_27_1.time_ < var_30_34 + var_30_35 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_36 = 2.375
			local var_30_37 = 0.625

			if var_30_36 < arg_27_1.time_ and arg_27_1.time_ <= var_30_36 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_38 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_38:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_39 = arg_27_1:FormatText(StoryNameCfg[37].name)

				arg_27_1.leftNameTxt_.text = var_30_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_40 = arg_27_1:GetWordFromCfg(110141006)
				local var_30_41 = arg_27_1:FormatText(var_30_40.content)

				arg_27_1.text_.text = var_30_41

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_42 = 25
				local var_30_43 = utf8.len(var_30_41)
				local var_30_44 = var_30_42 <= 0 and var_30_37 or var_30_37 * (var_30_43 / var_30_42)

				if var_30_44 > 0 and var_30_37 < var_30_44 then
					arg_27_1.talkMaxDuration = var_30_44
					var_30_36 = var_30_36 + 0.3

					if var_30_44 + var_30_36 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_44 + var_30_36
					end
				end

				arg_27_1.text_.text = var_30_41
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141006", "story_v_out_110141.awb") ~= 0 then
					local var_30_45 = manager.audio:GetVoiceLength("story_v_out_110141", "110141006", "story_v_out_110141.awb") / 1000

					if var_30_45 + var_30_36 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_45 + var_30_36
					end

					if var_30_40.prefab_name ~= "" and arg_27_1.actors_[var_30_40.prefab_name] ~= nil then
						local var_30_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_40.prefab_name].transform, "story_v_out_110141", "110141006", "story_v_out_110141.awb")

						arg_27_1:RecordAudio("110141006", var_30_46)
						arg_27_1:RecordAudio("110141006", var_30_46)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_110141", "110141006", "story_v_out_110141.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_110141", "110141006", "story_v_out_110141.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_47 = var_30_36 + 0.3
			local var_30_48 = math.max(var_30_37, arg_27_1.talkMaxDuration)

			if var_30_47 <= arg_27_1.time_ and arg_27_1.time_ < var_30_47 + var_30_48 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_47) / var_30_48

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_47 + var_30_48 and arg_27_1.time_ < var_30_47 + var_30_48 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110141007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 110141007
		arg_33_1.duration_ = 4.83

		local var_33_0 = {
			ja = 3.5,
			ko = 4.433,
			zh = 4.833,
			en = 3.566
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play110141008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.45

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[37].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(110141007)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 18
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141007", "story_v_out_110141.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_110141", "110141007", "story_v_out_110141.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_110141", "110141007", "story_v_out_110141.awb")

						arg_33_1:RecordAudio("110141007", var_36_9)
						arg_33_1:RecordAudio("110141007", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_110141", "110141007", "story_v_out_110141.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_110141", "110141007", "story_v_out_110141.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play110141008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 110141008
		arg_37_1.duration_ = 4.17

		local var_37_0 = {
			ja = 3.033,
			ko = 4.166,
			zh = 3.5,
			en = 4
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
				arg_37_0:Play110141009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = false

				arg_37_1:SetGaussion(false)
			end

			local var_40_1 = 1.5

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_1 then
				local var_40_2 = (arg_37_1.time_ - var_40_0) / var_40_1
				local var_40_3 = Color.New(1, 1, 1)

				var_40_3.a = Mathf.Lerp(1, 0, var_40_2)
				arg_37_1.mask_.color = var_40_3
			end

			if arg_37_1.time_ >= var_40_0 + var_40_1 and arg_37_1.time_ < var_40_0 + var_40_1 + arg_40_0 then
				local var_40_4 = Color.New(1, 1, 1)
				local var_40_5 = 0

				arg_37_1.mask_.enabled = false
				var_40_4.a = var_40_5
				arg_37_1.mask_.color = var_40_4
			end

			local var_40_6 = arg_37_1.bgs_.OS0102b
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				local var_40_8 = var_40_6:GetComponent("SpriteRenderer")

				if var_40_8 then
					arg_37_1.var_.alphaOldValueOS0102b = var_40_8.color.a
					arg_37_1.var_.alphaMatValueOS0102b = var_40_8
				end

				arg_37_1.var_.alphaOldValueOS0102b = 1
			end

			local var_40_9 = 0.0166666666666667

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_9 then
				local var_40_10 = (arg_37_1.time_ - var_40_7) / var_40_9
				local var_40_11 = Mathf.Lerp(arg_37_1.var_.alphaOldValueOS0102b, 0, var_40_10)

				if arg_37_1.var_.alphaMatValueOS0102b then
					local var_40_12 = arg_37_1.var_.alphaMatValueOS0102b.color

					var_40_12.a = var_40_11
					arg_37_1.var_.alphaMatValueOS0102b.color = var_40_12
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_9 and arg_37_1.time_ < var_40_7 + var_40_9 + arg_40_0 and arg_37_1.var_.alphaMatValueOS0102b then
				local var_40_13 = arg_37_1.var_.alphaMatValueOS0102b
				local var_40_14 = var_40_13.color

				var_40_14.a = 0
				var_40_13.color = var_40_14
			end

			local var_40_15 = manager.ui.mainCamera.transform
			local var_40_16 = 1.2

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_15.localPosition
			end

			local var_40_17 = 0.6

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / 0.066
				local var_40_19, var_40_20 = math.modf(var_40_18)

				var_40_15.localPosition = Vector3.New(var_40_20 * 0.13, var_40_20 * 0.13, var_40_20 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_21 = 0

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_22 = 1.2

			if arg_37_1.time_ >= var_40_21 + var_40_22 and arg_37_1.time_ < var_40_21 + var_40_22 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_23 = 1.2
			local var_40_24 = 0.3

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_25 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_25:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_26 = arg_37_1:FormatText(StoryNameCfg[37].name)

				arg_37_1.leftNameTxt_.text = var_40_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_27 = arg_37_1:GetWordFromCfg(110141008)
				local var_40_28 = arg_37_1:FormatText(var_40_27.content)

				arg_37_1.text_.text = var_40_28

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_29 = 12
				local var_40_30 = utf8.len(var_40_28)
				local var_40_31 = var_40_29 <= 0 and var_40_24 or var_40_24 * (var_40_30 / var_40_29)

				if var_40_31 > 0 and var_40_24 < var_40_31 then
					arg_37_1.talkMaxDuration = var_40_31
					var_40_23 = var_40_23 + 0.3

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end
				end

				arg_37_1.text_.text = var_40_28
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141008", "story_v_out_110141.awb") ~= 0 then
					local var_40_32 = manager.audio:GetVoiceLength("story_v_out_110141", "110141008", "story_v_out_110141.awb") / 1000

					if var_40_32 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_23
					end

					if var_40_27.prefab_name ~= "" and arg_37_1.actors_[var_40_27.prefab_name] ~= nil then
						local var_40_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_27.prefab_name].transform, "story_v_out_110141", "110141008", "story_v_out_110141.awb")

						arg_37_1:RecordAudio("110141008", var_40_33)
						arg_37_1:RecordAudio("110141008", var_40_33)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_110141", "110141008", "story_v_out_110141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_110141", "110141008", "story_v_out_110141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_34 = var_40_23 + 0.3
			local var_40_35 = math.max(var_40_24, arg_37_1.talkMaxDuration)

			if var_40_34 <= arg_37_1.time_ and arg_37_1.time_ < var_40_34 + var_40_35 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_34) / var_40_35

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_34 + var_40_35 and arg_37_1.time_ < var_40_34 + var_40_35 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play110141009 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 110141009
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play110141010(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.95

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(110141009)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 38
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play110141010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 110141010
		arg_47_1.duration_ = 9.03

		local var_47_0 = {
			ja = 7.433,
			ko = 9.033,
			zh = 7.233,
			en = 7.233
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110141011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "1011ui_story"

			if arg_47_1.actors_[var_50_0] == nil then
				local var_50_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_50_1) then
					local var_50_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_47_1.stage_.transform)

					var_50_2.name = var_50_0
					var_50_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_47_1.actors_[var_50_0] = var_50_2

					local var_50_3 = var_50_2:GetComponentInChildren(typeof(CharacterEffect))

					var_50_3.enabled = true

					local var_50_4 = GameObjectTools.GetOrAddComponent(var_50_2, typeof(DynamicBoneHelper))

					if var_50_4 then
						var_50_4:EnableDynamicBone(false)
					end

					arg_47_1:ShowWeapon(var_50_3.transform, false)

					arg_47_1.var_[var_50_0 .. "Animator"] = var_50_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_47_1.var_[var_50_0 .. "Animator"].applyRootMotion = true
					arg_47_1.var_[var_50_0 .. "LipSync"] = var_50_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_50_5 = arg_47_1.actors_["1011ui_story"].transform
			local var_50_6 = 1.8

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.var_.moveOldPos1011ui_story = var_50_5.localPosition
			end

			local var_50_7 = 0.001

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_7 then
				local var_50_8 = (arg_47_1.time_ - var_50_6) / var_50_7
				local var_50_9 = Vector3.New(0, -0.71, -6)

				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1011ui_story, var_50_9, var_50_8)

				local var_50_10 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_10.x, var_50_10.y, var_50_10.z)

				local var_50_11 = var_50_5.localEulerAngles

				var_50_11.z = 0
				var_50_11.x = 0
				var_50_5.localEulerAngles = var_50_11
			end

			if arg_47_1.time_ >= var_50_6 + var_50_7 and arg_47_1.time_ < var_50_6 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_50_12 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_12.x, var_50_12.y, var_50_12.z)

				local var_50_13 = var_50_5.localEulerAngles

				var_50_13.z = 0
				var_50_13.x = 0
				var_50_5.localEulerAngles = var_50_13
			end

			local var_50_14 = "ST19"

			if arg_47_1.bgs_[var_50_14] == nil then
				local var_50_15 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_14)
				var_50_15.name = var_50_14
				var_50_15.transform.parent = arg_47_1.stage_.transform
				var_50_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_14] = var_50_15
			end

			local var_50_16 = arg_47_1.bgs_.ST19
			local var_50_17 = 0

			if var_50_17 < arg_47_1.time_ and arg_47_1.time_ <= var_50_17 + arg_50_0 then
				local var_50_18 = var_50_16:GetComponent("SpriteRenderer")

				if var_50_18 then
					arg_47_1.var_.alphaOldValueST19 = var_50_18.color.a
					arg_47_1.var_.alphaMatValueST19 = var_50_18
				end

				arg_47_1.var_.alphaOldValueST19 = 0
			end

			local var_50_19 = 1.5

			if var_50_17 <= arg_47_1.time_ and arg_47_1.time_ < var_50_17 + var_50_19 then
				local var_50_20 = (arg_47_1.time_ - var_50_17) / var_50_19
				local var_50_21 = Mathf.Lerp(arg_47_1.var_.alphaOldValueST19, 1, var_50_20)

				if arg_47_1.var_.alphaMatValueST19 then
					local var_50_22 = arg_47_1.var_.alphaMatValueST19.color

					var_50_22.a = var_50_21
					arg_47_1.var_.alphaMatValueST19.color = var_50_22
				end
			end

			if arg_47_1.time_ >= var_50_17 + var_50_19 and arg_47_1.time_ < var_50_17 + var_50_19 + arg_50_0 and arg_47_1.var_.alphaMatValueST19 then
				local var_50_23 = arg_47_1.var_.alphaMatValueST19
				local var_50_24 = var_50_23.color

				var_50_24.a = 1
				var_50_23.color = var_50_24
			end

			local var_50_25 = 0

			if var_50_25 < arg_47_1.time_ and arg_47_1.time_ <= var_50_25 + arg_50_0 then
				local var_50_26 = manager.ui.mainCamera.transform.localPosition
				local var_50_27 = Vector3.New(0, 0, 10) + Vector3.New(var_50_26.x, var_50_26.y, 0)
				local var_50_28 = arg_47_1.bgs_.ST19

				var_50_28.transform.localPosition = var_50_27
				var_50_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_29 = var_50_28:GetComponent("SpriteRenderer")

				if var_50_29 and var_50_29.sprite then
					local var_50_30 = (var_50_28.transform.localPosition - var_50_26).z
					local var_50_31 = manager.ui.mainCameraCom_
					local var_50_32 = 2 * var_50_30 * Mathf.Tan(var_50_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_33 = var_50_32 * var_50_31.aspect
					local var_50_34 = var_50_29.sprite.bounds.size.x
					local var_50_35 = var_50_29.sprite.bounds.size.y
					local var_50_36 = var_50_33 / var_50_34
					local var_50_37 = var_50_32 / var_50_35
					local var_50_38 = var_50_37 < var_50_36 and var_50_36 or var_50_37

					var_50_28.transform.localScale = Vector3.New(var_50_38, var_50_38, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST19" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_39 = arg_47_1.actors_["1011ui_story"]
			local var_50_40 = 1.8

			if var_50_40 < arg_47_1.time_ and arg_47_1.time_ <= var_50_40 + arg_50_0 and not isNil(var_50_39) and arg_47_1.var_.characterEffect1011ui_story == nil then
				arg_47_1.var_.characterEffect1011ui_story = var_50_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_41 = 0.2

			if var_50_40 <= arg_47_1.time_ and arg_47_1.time_ < var_50_40 + var_50_41 and not isNil(var_50_39) then
				local var_50_42 = (arg_47_1.time_ - var_50_40) / var_50_41

				if arg_47_1.var_.characterEffect1011ui_story and not isNil(var_50_39) then
					arg_47_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_40 + var_50_41 and arg_47_1.time_ < var_50_40 + var_50_41 + arg_50_0 and not isNil(var_50_39) and arg_47_1.var_.characterEffect1011ui_story then
				arg_47_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_50_43 = 1.8

			if var_50_43 < arg_47_1.time_ and arg_47_1.time_ <= var_50_43 + arg_50_0 then
				arg_47_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action9_2")
			end

			local var_50_44 = 1.8

			if var_50_44 < arg_47_1.time_ and arg_47_1.time_ <= var_50_44 + arg_50_0 then
				arg_47_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_45 = 2
			local var_50_46 = 1

			if var_50_45 < arg_47_1.time_ and arg_47_1.time_ <= var_50_45 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_47 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_47:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_48 = arg_47_1:FormatText(StoryNameCfg[37].name)

				arg_47_1.leftNameTxt_.text = var_50_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_49 = arg_47_1:GetWordFromCfg(110141010)
				local var_50_50 = arg_47_1:FormatText(var_50_49.content)

				arg_47_1.text_.text = var_50_50

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_51 = 20
				local var_50_52 = utf8.len(var_50_50)
				local var_50_53 = var_50_51 <= 0 and var_50_46 or var_50_46 * (var_50_52 / var_50_51)

				if var_50_53 > 0 and var_50_46 < var_50_53 then
					arg_47_1.talkMaxDuration = var_50_53
					var_50_45 = var_50_45 + 0.3

					if var_50_53 + var_50_45 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_53 + var_50_45
					end
				end

				arg_47_1.text_.text = var_50_50
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141010", "story_v_out_110141.awb") ~= 0 then
					local var_50_54 = manager.audio:GetVoiceLength("story_v_out_110141", "110141010", "story_v_out_110141.awb") / 1000

					if var_50_54 + var_50_45 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_54 + var_50_45
					end

					if var_50_49.prefab_name ~= "" and arg_47_1.actors_[var_50_49.prefab_name] ~= nil then
						local var_50_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_49.prefab_name].transform, "story_v_out_110141", "110141010", "story_v_out_110141.awb")

						arg_47_1:RecordAudio("110141010", var_50_55)
						arg_47_1:RecordAudio("110141010", var_50_55)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_110141", "110141010", "story_v_out_110141.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_110141", "110141010", "story_v_out_110141.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_56 = var_50_45 + 0.3
			local var_50_57 = math.max(var_50_46, arg_47_1.talkMaxDuration)

			if var_50_56 <= arg_47_1.time_ and arg_47_1.time_ < var_50_56 + var_50_57 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_56) / var_50_57

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_56 + var_50_57 and arg_47_1.time_ < var_50_56 + var_50_57 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play110141011 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 110141011
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play110141012(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1011ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1011ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1011ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = 0
			local var_56_10 = 0.65

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_11 = arg_53_1:GetWordFromCfg(110141011)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 26
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_10 or var_56_10 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_10 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_9) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_9 + var_56_16 and arg_53_1.time_ < var_56_9 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play110141012 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 110141012
		arg_57_1.duration_ = 6.5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play110141013(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_1 = 1.5

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_1 then
				local var_60_2 = (arg_57_1.time_ - var_60_0) / var_60_1
				local var_60_3 = Color.New(1, 1, 1)

				var_60_3.a = Mathf.Lerp(0, 1, var_60_2)
				arg_57_1.mask_.color = var_60_3
			end

			if arg_57_1.time_ >= var_60_0 + var_60_1 and arg_57_1.time_ < var_60_0 + var_60_1 + arg_60_0 then
				local var_60_4 = Color.New(1, 1, 1)

				var_60_4.a = 1
				arg_57_1.mask_.color = var_60_4
			end

			local var_60_5 = 1.5

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = false

				arg_57_1:SetGaussion(false)
			end

			local var_60_6 = 0.0166666666666667

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6
				local var_60_8 = Color.New(1, 1, 1)

				var_60_8.a = Mathf.Lerp(1, 0, var_60_7)
				arg_57_1.mask_.color = var_60_8
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 then
				local var_60_9 = Color.New(1, 1, 1)
				local var_60_10 = 0

				arg_57_1.mask_.enabled = false
				var_60_9.a = var_60_10
				arg_57_1.mask_.color = var_60_9
			end

			local var_60_11 = arg_57_1.bgs_.ST19
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				local var_60_13 = var_60_11:GetComponent("SpriteRenderer")

				if var_60_13 then
					arg_57_1.var_.alphaOldValueST19 = var_60_13.color.a
					arg_57_1.var_.alphaMatValueST19 = var_60_13
				end

				arg_57_1.var_.alphaOldValueST19 = 1
			end

			local var_60_14 = 0.0166666666666667

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_14 then
				local var_60_15 = (arg_57_1.time_ - var_60_12) / var_60_14
				local var_60_16 = Mathf.Lerp(arg_57_1.var_.alphaOldValueST19, 0, var_60_15)

				if arg_57_1.var_.alphaMatValueST19 then
					local var_60_17 = arg_57_1.var_.alphaMatValueST19.color

					var_60_17.a = var_60_16
					arg_57_1.var_.alphaMatValueST19.color = var_60_17
				end
			end

			if arg_57_1.time_ >= var_60_12 + var_60_14 and arg_57_1.time_ < var_60_12 + var_60_14 + arg_60_0 and arg_57_1.var_.alphaMatValueST19 then
				local var_60_18 = arg_57_1.var_.alphaMatValueST19
				local var_60_19 = var_60_18.color

				var_60_19.a = 0
				var_60_18.color = var_60_19
			end

			local var_60_20 = "STwhite"

			if arg_57_1.bgs_[var_60_20] == nil then
				local var_60_21 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_60_20)
				var_60_21.name = var_60_20
				var_60_21.transform.parent = arg_57_1.stage_.transform
				var_60_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_[var_60_20] = var_60_21
			end

			local var_60_22 = arg_57_1.bgs_.STwhite.transform
			local var_60_23 = 1.466

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.var_.moveOldPosSTwhite = var_60_22.localPosition
				var_60_22.localScale = Vector3.New(10, 10, 10)
			end

			local var_60_24 = 0.001

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24
				local var_60_26 = Vector3.New(0, 0, 0)

				var_60_22.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosSTwhite, var_60_26, var_60_25)
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 then
				var_60_22.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_27 = 1.5
			local var_60_28 = 0.65

			if var_60_27 < arg_57_1.time_ and arg_57_1.time_ <= var_60_27 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_29 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_29:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_30 = arg_57_1:GetWordFromCfg(110141012)
				local var_60_31 = arg_57_1:FormatText(var_60_30.content)

				arg_57_1.text_.text = var_60_31

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_32 = 26
				local var_60_33 = utf8.len(var_60_31)
				local var_60_34 = var_60_32 <= 0 and var_60_28 or var_60_28 * (var_60_33 / var_60_32)

				if var_60_34 > 0 and var_60_28 < var_60_34 then
					arg_57_1.talkMaxDuration = var_60_34
					var_60_27 = var_60_27 + 0.3

					if var_60_34 + var_60_27 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_34 + var_60_27
					end
				end

				arg_57_1.text_.text = var_60_31
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_35 = var_60_27 + 0.3
			local var_60_36 = math.max(var_60_28, arg_57_1.talkMaxDuration)

			if var_60_35 <= arg_57_1.time_ and arg_57_1.time_ < var_60_35 + var_60_36 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_35) / var_60_36

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_35 + var_60_36 and arg_57_1.time_ < var_60_35 + var_60_36 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play110141013 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 110141013
		arg_63_1.duration_ = 3.43

		local var_63_0 = {
			ja = 2.866,
			ko = 1.166,
			zh = 3.433,
			en = 1.3
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play110141014(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.125

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[37].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(110141013)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 5
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141013", "story_v_out_110141.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_110141", "110141013", "story_v_out_110141.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_110141", "110141013", "story_v_out_110141.awb")

						arg_63_1:RecordAudio("110141013", var_66_9)
						arg_63_1:RecordAudio("110141013", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_110141", "110141013", "story_v_out_110141.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_110141", "110141013", "story_v_out_110141.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play110141014 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 110141014
		arg_67_1.duration_ = 7.53

		local var_67_0 = {
			ja = 7.533,
			ko = 4.466,
			zh = 4.933,
			en = 4.833
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play110141015(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = false

				arg_67_1:SetGaussion(false)
			end

			local var_70_1 = 1.5

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_1 then
				local var_70_2 = (arg_67_1.time_ - var_70_0) / var_70_1
				local var_70_3 = Color.New(1, 1, 1)

				var_70_3.a = Mathf.Lerp(1, 0, var_70_2)
				arg_67_1.mask_.color = var_70_3
			end

			if arg_67_1.time_ >= var_70_0 + var_70_1 and arg_67_1.time_ < var_70_0 + var_70_1 + arg_70_0 then
				local var_70_4 = Color.New(1, 1, 1)
				local var_70_5 = 0

				arg_67_1.mask_.enabled = false
				var_70_4.a = var_70_5
				arg_67_1.mask_.color = var_70_4
			end

			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_7 = 2

			if arg_67_1.time_ >= var_70_6 + var_70_7 and arg_67_1.time_ < var_70_6 + var_70_7 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_8 = arg_67_1.actors_["1011ui_story"].transform
			local var_70_9 = 1.8

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.var_.moveOldPos1011ui_story = var_70_8.localPosition
			end

			local var_70_10 = 0.001

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 then
				local var_70_11 = (arg_67_1.time_ - var_70_9) / var_70_10
				local var_70_12 = Vector3.New(0, -0.71, -6)

				var_70_8.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1011ui_story, var_70_12, var_70_11)

				local var_70_13 = manager.ui.mainCamera.transform.position - var_70_8.position

				var_70_8.forward = Vector3.New(var_70_13.x, var_70_13.y, var_70_13.z)

				local var_70_14 = var_70_8.localEulerAngles

				var_70_14.z = 0
				var_70_14.x = 0
				var_70_8.localEulerAngles = var_70_14
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 then
				var_70_8.localPosition = Vector3.New(0, -0.71, -6)

				local var_70_15 = manager.ui.mainCamera.transform.position - var_70_8.position

				var_70_8.forward = Vector3.New(var_70_15.x, var_70_15.y, var_70_15.z)

				local var_70_16 = var_70_8.localEulerAngles

				var_70_16.z = 0
				var_70_16.x = 0
				var_70_8.localEulerAngles = var_70_16
			end

			local var_70_17 = 1.8

			if var_70_17 < arg_67_1.time_ and arg_67_1.time_ <= var_70_17 + arg_70_0 then
				arg_67_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_70_18 = 1.8

			if var_70_18 < arg_67_1.time_ and arg_67_1.time_ <= var_70_18 + arg_70_0 then
				arg_67_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_19 = arg_67_1.actors_["1011ui_story"]
			local var_70_20 = 1.8

			if var_70_20 < arg_67_1.time_ and arg_67_1.time_ <= var_70_20 + arg_70_0 and not isNil(var_70_19) and arg_67_1.var_.characterEffect1011ui_story == nil then
				arg_67_1.var_.characterEffect1011ui_story = var_70_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_21 = 0.2

			if var_70_20 <= arg_67_1.time_ and arg_67_1.time_ < var_70_20 + var_70_21 and not isNil(var_70_19) then
				local var_70_22 = (arg_67_1.time_ - var_70_20) / var_70_21

				if arg_67_1.var_.characterEffect1011ui_story and not isNil(var_70_19) then
					arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_20 + var_70_21 and arg_67_1.time_ < var_70_20 + var_70_21 + arg_70_0 and not isNil(var_70_19) and arg_67_1.var_.characterEffect1011ui_story then
				arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_70_23 = arg_67_1.bgs_.ST19
			local var_70_24 = 0

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				local var_70_25 = var_70_23:GetComponent("SpriteRenderer")

				if var_70_25 then
					arg_67_1.var_.alphaOldValueST19 = var_70_25.color.a
					arg_67_1.var_.alphaMatValueST19 = var_70_25
				end

				arg_67_1.var_.alphaOldValueST19 = 0
			end

			local var_70_26 = 0.0166666666666667

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_26 then
				local var_70_27 = (arg_67_1.time_ - var_70_24) / var_70_26
				local var_70_28 = Mathf.Lerp(arg_67_1.var_.alphaOldValueST19, 1, var_70_27)

				if arg_67_1.var_.alphaMatValueST19 then
					local var_70_29 = arg_67_1.var_.alphaMatValueST19.color

					var_70_29.a = var_70_28
					arg_67_1.var_.alphaMatValueST19.color = var_70_29
				end
			end

			if arg_67_1.time_ >= var_70_24 + var_70_26 and arg_67_1.time_ < var_70_24 + var_70_26 + arg_70_0 and arg_67_1.var_.alphaMatValueST19 then
				local var_70_30 = arg_67_1.var_.alphaMatValueST19
				local var_70_31 = var_70_30.color

				var_70_31.a = 1
				var_70_30.color = var_70_31
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_32 = 2
			local var_70_33 = 0.225

			if var_70_32 < arg_67_1.time_ and arg_67_1.time_ <= var_70_32 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_34 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_34:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_35 = arg_67_1:FormatText(StoryNameCfg[37].name)

				arg_67_1.leftNameTxt_.text = var_70_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_36 = arg_67_1:GetWordFromCfg(110141014)
				local var_70_37 = arg_67_1:FormatText(var_70_36.content)

				arg_67_1.text_.text = var_70_37

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_38 = 9
				local var_70_39 = utf8.len(var_70_37)
				local var_70_40 = var_70_38 <= 0 and var_70_33 or var_70_33 * (var_70_39 / var_70_38)

				if var_70_40 > 0 and var_70_33 < var_70_40 then
					arg_67_1.talkMaxDuration = var_70_40
					var_70_32 = var_70_32 + 0.3

					if var_70_40 + var_70_32 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_40 + var_70_32
					end
				end

				arg_67_1.text_.text = var_70_37
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141014", "story_v_out_110141.awb") ~= 0 then
					local var_70_41 = manager.audio:GetVoiceLength("story_v_out_110141", "110141014", "story_v_out_110141.awb") / 1000

					if var_70_41 + var_70_32 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_41 + var_70_32
					end

					if var_70_36.prefab_name ~= "" and arg_67_1.actors_[var_70_36.prefab_name] ~= nil then
						local var_70_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_36.prefab_name].transform, "story_v_out_110141", "110141014", "story_v_out_110141.awb")

						arg_67_1:RecordAudio("110141014", var_70_42)
						arg_67_1:RecordAudio("110141014", var_70_42)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_110141", "110141014", "story_v_out_110141.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_110141", "110141014", "story_v_out_110141.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_43 = var_70_32 + 0.3
			local var_70_44 = math.max(var_70_33, arg_67_1.talkMaxDuration)

			if var_70_43 <= arg_67_1.time_ and arg_67_1.time_ < var_70_43 + var_70_44 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_43) / var_70_44

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_43 + var_70_44 and arg_67_1.time_ < var_70_43 + var_70_44 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play110141015 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 110141015
		arg_73_1.duration_ = 10.3

		local var_73_0 = {
			ja = 10.3,
			ko = 6.933,
			zh = 8.233,
			en = 5.566
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
				arg_73_0:Play110141016(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_76_1 = 0
			local var_76_2 = 0.825

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_3 = arg_73_1:FormatText(StoryNameCfg[37].name)

				arg_73_1.leftNameTxt_.text = var_76_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(110141015)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 33
				local var_76_7 = utf8.len(var_76_5)
				local var_76_8 = var_76_6 <= 0 and var_76_2 or var_76_2 * (var_76_7 / var_76_6)

				if var_76_8 > 0 and var_76_2 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141015", "story_v_out_110141.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_110141", "110141015", "story_v_out_110141.awb") / 1000

					if var_76_9 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_1
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_110141", "110141015", "story_v_out_110141.awb")

						arg_73_1:RecordAudio("110141015", var_76_10)
						arg_73_1:RecordAudio("110141015", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_110141", "110141015", "story_v_out_110141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_110141", "110141015", "story_v_out_110141.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_11 and arg_73_1.time_ < var_76_1 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play110141016 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 110141016
		arg_77_1.duration_ = 11.03

		local var_77_0 = {
			ja = 11.033,
			ko = 6.766,
			zh = 7.833,
			en = 5.933
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play110141017(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_80_1 = 0
			local var_80_2 = 0.8

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_3 = arg_77_1:FormatText(StoryNameCfg[37].name)

				arg_77_1.leftNameTxt_.text = var_80_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(110141016)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 32
				local var_80_7 = utf8.len(var_80_5)
				local var_80_8 = var_80_6 <= 0 and var_80_2 or var_80_2 * (var_80_7 / var_80_6)

				if var_80_8 > 0 and var_80_2 < var_80_8 then
					arg_77_1.talkMaxDuration = var_80_8

					if var_80_8 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141016", "story_v_out_110141.awb") ~= 0 then
					local var_80_9 = manager.audio:GetVoiceLength("story_v_out_110141", "110141016", "story_v_out_110141.awb") / 1000

					if var_80_9 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_1
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_110141", "110141016", "story_v_out_110141.awb")

						arg_77_1:RecordAudio("110141016", var_80_10)
						arg_77_1:RecordAudio("110141016", var_80_10)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_110141", "110141016", "story_v_out_110141.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_110141", "110141016", "story_v_out_110141.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_11 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_11 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_11

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_11 and arg_77_1.time_ < var_80_1 + var_80_11 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play110141017 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 110141017
		arg_81_1.duration_ = 7.8

		local var_81_0 = {
			ja = 7.8,
			ko = 3.7,
			zh = 4.266,
			en = 4.1
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
				arg_81_0:Play110141018(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_84_1 = 0
			local var_84_2 = 0.425

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_3 = arg_81_1:FormatText(StoryNameCfg[37].name)

				arg_81_1.leftNameTxt_.text = var_84_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(110141017)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 17
				local var_84_7 = utf8.len(var_84_5)
				local var_84_8 = var_84_6 <= 0 and var_84_2 or var_84_2 * (var_84_7 / var_84_6)

				if var_84_8 > 0 and var_84_2 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141017", "story_v_out_110141.awb") ~= 0 then
					local var_84_9 = manager.audio:GetVoiceLength("story_v_out_110141", "110141017", "story_v_out_110141.awb") / 1000

					if var_84_9 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_1
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_110141", "110141017", "story_v_out_110141.awb")

						arg_81_1:RecordAudio("110141017", var_84_10)
						arg_81_1:RecordAudio("110141017", var_84_10)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_110141", "110141017", "story_v_out_110141.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_110141", "110141017", "story_v_out_110141.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_11 and arg_81_1.time_ < var_84_1 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play110141018 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 110141018
		arg_85_1.duration_ = 6.37

		local var_85_0 = {
			ja = 6.366,
			ko = 2.333,
			zh = 2.8,
			en = 2.466
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
			arg_85_1.auto_ = false
		end

		function arg_85_1.playNext_(arg_87_0)
			arg_85_1.onStoryFinished_()
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_88_1 = 0
			local var_88_2 = 0.2

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_3 = arg_85_1:FormatText(StoryNameCfg[37].name)

				arg_85_1.leftNameTxt_.text = var_88_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(110141018)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 8
				local var_88_7 = utf8.len(var_88_5)
				local var_88_8 = var_88_6 <= 0 and var_88_2 or var_88_2 * (var_88_7 / var_88_6)

				if var_88_8 > 0 and var_88_2 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110141", "110141018", "story_v_out_110141.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_out_110141", "110141018", "story_v_out_110141.awb") / 1000

					if var_88_9 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_1
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_110141", "110141018", "story_v_out_110141.awb")

						arg_85_1:RecordAudio("110141018", var_88_10)
						arg_85_1:RecordAudio("110141018", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_110141", "110141018", "story_v_out_110141.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_110141", "110141018", "story_v_out_110141.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_11 and arg_85_1.time_ < var_88_1 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OS0102a",
		"TextureConfig/Background/OS0102b",
		"TextureConfig/Background/ST19"
	},
	voices = {
		"story_v_out_110141.awb"
	}
}
