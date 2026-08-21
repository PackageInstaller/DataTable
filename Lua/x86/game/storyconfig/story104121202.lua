return {
	Play412122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I09h"

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
				local var_4_5 = arg_1_1.bgs_.I09h

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
					if iter_4_0 ~= "I09h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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
			local var_4_25 = 0.233333333333333

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

			local var_4_30 = 0.266666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.3

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(412122001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 12
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.375

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(412122002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 55
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play412122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412122003
		arg_13_1.duration_ = 2.67

		local var_13_0 = {
			zh = 2.2,
			ja = 2.666
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
				arg_13_0:Play412122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.15

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[930].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(412122003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122003", "story_v_out_412122.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122003", "story_v_out_412122.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_412122", "412122003", "story_v_out_412122.awb")

						arg_13_1:RecordAudio("412122003", var_16_9)
						arg_13_1:RecordAudio("412122003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412122", "412122003", "story_v_out_412122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412122", "412122003", "story_v_out_412122.awb")
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
	Play412122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412122004
		arg_17_1.duration_ = 6.2

		local var_17_0 = {
			zh = 5.499999999999,
			ja = 6.2
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
				arg_17_0:Play412122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "EN0109"

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
				local var_20_5 = arg_17_1.bgs_.EN0109

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
					if iter_20_0 ~= "EN0109" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 3.999999999999

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_17 = 0.3

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_19 = 2

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19
				local var_20_21 = Color.New(0, 0, 0)

				var_20_21.a = Mathf.Lerp(0, 1, var_20_20)
				arg_17_1.mask_.color = var_20_21
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 then
				local var_20_22 = Color.New(0, 0, 0)

				var_20_22.a = 1
				arg_17_1.mask_.color = var_20_22
			end

			local var_20_23 = 2

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_24 = 2

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24
				local var_20_26 = Color.New(0, 0, 0)

				var_20_26.a = Mathf.Lerp(1, 0, var_20_25)
				arg_17_1.mask_.color = var_20_26
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 then
				local var_20_27 = Color.New(0, 0, 0)
				local var_20_28 = 0

				arg_17_1.mask_.enabled = false
				var_20_27.a = var_20_28
				arg_17_1.mask_.color = var_20_27
			end

			local var_20_29 = arg_17_1.bgs_.EN0109.transform
			local var_20_30 = 2

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.var_.moveOldPosEN0109 = var_20_29.localPosition
			end

			local var_20_31 = 3.5

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31
				local var_20_33 = Vector3.New(0, 1, 9.5)

				var_20_29.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPosEN0109, var_20_33, var_20_32)
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 then
				var_20_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_20_34 = 3.999999999999

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_35 = 1.500000000001

			if arg_17_1.time_ >= var_20_34 + var_20_35 and arg_17_1.time_ < var_20_34 + var_20_35 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_36 = 4
			local var_20_37 = 0.125

			if var_20_36 < arg_17_1.time_ and arg_17_1.time_ <= var_20_36 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_38 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_38:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_39 = arg_17_1:FormatText(StoryNameCfg[205].name)

				arg_17_1.leftNameTxt_.text = var_20_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_40 = arg_17_1:GetWordFromCfg(412122004)
				local var_20_41 = arg_17_1:FormatText(var_20_40.content)

				arg_17_1.text_.text = var_20_41

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_42 = 5
				local var_20_43 = utf8.len(var_20_41)
				local var_20_44 = var_20_42 <= 0 and var_20_37 or var_20_37 * (var_20_43 / var_20_42)

				if var_20_44 > 0 and var_20_37 < var_20_44 then
					arg_17_1.talkMaxDuration = var_20_44
					var_20_36 = var_20_36 + 0.3

					if var_20_44 + var_20_36 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_44 + var_20_36
					end
				end

				arg_17_1.text_.text = var_20_41
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122004", "story_v_out_412122.awb") ~= 0 then
					local var_20_45 = manager.audio:GetVoiceLength("story_v_out_412122", "412122004", "story_v_out_412122.awb") / 1000

					if var_20_45 + var_20_36 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_36
					end

					if var_20_40.prefab_name ~= "" and arg_17_1.actors_[var_20_40.prefab_name] ~= nil then
						local var_20_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_40.prefab_name].transform, "story_v_out_412122", "412122004", "story_v_out_412122.awb")

						arg_17_1:RecordAudio("412122004", var_20_46)
						arg_17_1:RecordAudio("412122004", var_20_46)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412122", "412122004", "story_v_out_412122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412122", "412122004", "story_v_out_412122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_47 = var_20_36 + 0.3
			local var_20_48 = math.max(var_20_37, arg_17_1.talkMaxDuration)

			if var_20_47 <= arg_17_1.time_ and arg_17_1.time_ < var_20_47 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_47) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_47 + var_20_48 and arg_17_1.time_ < var_20_47 + var_20_48 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play412122005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 412122005
		arg_23_1.duration_ = 4.6

		local var_23_0 = {
			zh = 4.6,
			ja = 2.7
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play412122006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.325

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[930].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(412122005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 13
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122005", "story_v_out_412122.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122005", "story_v_out_412122.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_412122", "412122005", "story_v_out_412122.awb")

						arg_23_1:RecordAudio("412122005", var_26_9)
						arg_23_1:RecordAudio("412122005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_412122", "412122005", "story_v_out_412122.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_412122", "412122005", "story_v_out_412122.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_10 and arg_23_1.time_ < var_26_0 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play412122006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 412122006
		arg_27_1.duration_ = 8.5

		local var_27_0 = {
			zh = 5.566,
			ja = 8.5
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
				arg_27_0:Play412122007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.65

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[930].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(412122006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 26
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122006", "story_v_out_412122.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122006", "story_v_out_412122.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_412122", "412122006", "story_v_out_412122.awb")

						arg_27_1:RecordAudio("412122006", var_30_9)
						arg_27_1:RecordAudio("412122006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_412122", "412122006", "story_v_out_412122.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_412122", "412122006", "story_v_out_412122.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play412122007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 412122007
		arg_31_1.duration_ = 3.7

		local var_31_0 = {
			zh = 1.7,
			ja = 3.7
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play412122008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.15

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[205].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(412122007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 6
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122007", "story_v_out_412122.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122007", "story_v_out_412122.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_412122", "412122007", "story_v_out_412122.awb")

						arg_31_1:RecordAudio("412122007", var_34_9)
						arg_31_1:RecordAudio("412122007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_412122", "412122007", "story_v_out_412122.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_412122", "412122007", "story_v_out_412122.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play412122008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412122008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412122009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.675

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(412122008)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 27
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_7 and arg_35_1.time_ < var_38_0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play412122009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412122009
		arg_39_1.duration_ = 7

		local var_39_0 = {
			zh = 7,
			ja = 5.1
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
				arg_39_0:Play412122010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.675

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[930].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(412122009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122009", "story_v_out_412122.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122009", "story_v_out_412122.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_412122", "412122009", "story_v_out_412122.awb")

						arg_39_1:RecordAudio("412122009", var_42_9)
						arg_39_1:RecordAudio("412122009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_412122", "412122009", "story_v_out_412122.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_412122", "412122009", "story_v_out_412122.awb")
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
	Play412122010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412122010
		arg_43_1.duration_ = 6.03

		local var_43_0 = {
			zh = 5.3,
			ja = 6.033
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
				arg_43_0:Play412122011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.575

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[930].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(412122010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 23
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122010", "story_v_out_412122.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122010", "story_v_out_412122.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_412122", "412122010", "story_v_out_412122.awb")

						arg_43_1:RecordAudio("412122010", var_46_9)
						arg_43_1:RecordAudio("412122010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412122", "412122010", "story_v_out_412122.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412122", "412122010", "story_v_out_412122.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play412122011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 412122011
		arg_47_1.duration_ = 7.33

		local var_47_0 = {
			zh = 3.8,
			ja = 7.333
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
				arg_47_0:Play412122012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.3

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[930].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(412122011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 12
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122011", "story_v_out_412122.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122011", "story_v_out_412122.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_412122", "412122011", "story_v_out_412122.awb")

						arg_47_1:RecordAudio("412122011", var_50_9)
						arg_47_1:RecordAudio("412122011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_412122", "412122011", "story_v_out_412122.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_412122", "412122011", "story_v_out_412122.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play412122012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 412122012
		arg_51_1.duration_ = 5.3

		local var_51_0 = {
			zh = 5.3,
			ja = 3.9
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play412122013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.475

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[205].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(412122012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 19
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122012", "story_v_out_412122.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122012", "story_v_out_412122.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_412122", "412122012", "story_v_out_412122.awb")

						arg_51_1:RecordAudio("412122012", var_54_9)
						arg_51_1:RecordAudio("412122012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_412122", "412122012", "story_v_out_412122.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_412122", "412122012", "story_v_out_412122.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play412122013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 412122013
		arg_55_1.duration_ = 4.1

		local var_55_0 = {
			zh = 2.5,
			ja = 4.1
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play412122014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.225

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[930].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(412122013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 9
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122013", "story_v_out_412122.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122013", "story_v_out_412122.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_412122", "412122013", "story_v_out_412122.awb")

						arg_55_1:RecordAudio("412122013", var_58_9)
						arg_55_1:RecordAudio("412122013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_412122", "412122013", "story_v_out_412122.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_412122", "412122013", "story_v_out_412122.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play412122014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 412122014
		arg_59_1.duration_ = 2.4

		local var_59_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play412122015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "EN0109a"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 0

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.EN0109a

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "EN0109a" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 1

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_17 = 0.3

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_19 = 1

			if var_62_18 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				local var_62_20 = (arg_59_1.time_ - var_62_18) / var_62_19
				local var_62_21 = Color.New(1, 1, 1)

				var_62_21.a = Mathf.Lerp(1, 0, var_62_20)
				arg_59_1.mask_.color = var_62_21
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				local var_62_22 = Color.New(1, 1, 1)
				local var_62_23 = 0

				arg_59_1.mask_.enabled = false
				var_62_22.a = var_62_23
				arg_59_1.mask_.color = var_62_22
			end

			local var_62_24 = manager.ui.mainCamera.transform
			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_24.localPosition
			end

			local var_62_26 = 1

			if var_62_25 <= arg_59_1.time_ and arg_59_1.time_ < var_62_25 + var_62_26 then
				local var_62_27 = (arg_59_1.time_ - var_62_25) / 0.066
				local var_62_28, var_62_29 = math.modf(var_62_27)

				var_62_24.localPosition = Vector3.New(var_62_29 * 0.13, var_62_29 * 0.13, var_62_29 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= var_62_25 + var_62_26 and arg_59_1.time_ < var_62_25 + var_62_26 + arg_62_0 then
				var_62_24.localPosition = arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_30 = 1
			local var_62_31 = 0.075

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_32 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_32:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_33 = arg_59_1:FormatText(StoryNameCfg[930].name)

				arg_59_1.leftNameTxt_.text = var_62_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_34 = arg_59_1:GetWordFromCfg(412122014)
				local var_62_35 = arg_59_1:FormatText(var_62_34.content)

				arg_59_1.text_.text = var_62_35

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_36 = 3
				local var_62_37 = utf8.len(var_62_35)
				local var_62_38 = var_62_36 <= 0 and var_62_31 or var_62_31 * (var_62_37 / var_62_36)

				if var_62_38 > 0 and var_62_31 < var_62_38 then
					arg_59_1.talkMaxDuration = var_62_38
					var_62_30 = var_62_30 + 0.3

					if var_62_38 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_38 + var_62_30
					end
				end

				arg_59_1.text_.text = var_62_35
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122014", "story_v_out_412122.awb") ~= 0 then
					local var_62_39 = manager.audio:GetVoiceLength("story_v_out_412122", "412122014", "story_v_out_412122.awb") / 1000

					if var_62_39 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_39 + var_62_30
					end

					if var_62_34.prefab_name ~= "" and arg_59_1.actors_[var_62_34.prefab_name] ~= nil then
						local var_62_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_34.prefab_name].transform, "story_v_out_412122", "412122014", "story_v_out_412122.awb")

						arg_59_1:RecordAudio("412122014", var_62_40)
						arg_59_1:RecordAudio("412122014", var_62_40)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_412122", "412122014", "story_v_out_412122.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_412122", "412122014", "story_v_out_412122.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_41 = var_62_30 + 0.3
			local var_62_42 = math.max(var_62_31, arg_59_1.talkMaxDuration)

			if var_62_41 <= arg_59_1.time_ and arg_59_1.time_ < var_62_41 + var_62_42 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_41) / var_62_42

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_41 + var_62_42 and arg_59_1.time_ < var_62_41 + var_62_42 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play412122015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412122015
		arg_65_1.duration_ = 2.5

		local var_65_0 = {
			zh = 1.8,
			ja = 2.5
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
				arg_65_0:Play412122016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.1

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[205].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(412122015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 4
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122015", "story_v_out_412122.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122015", "story_v_out_412122.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_412122", "412122015", "story_v_out_412122.awb")

						arg_65_1:RecordAudio("412122015", var_68_9)
						arg_65_1:RecordAudio("412122015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412122", "412122015", "story_v_out_412122.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412122", "412122015", "story_v_out_412122.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play412122016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412122016
		arg_69_1.duration_ = 6.1

		local var_69_0 = {
			zh = 5.4,
			ja = 6.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play412122017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.7

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[205].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(412122016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 28
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122016", "story_v_out_412122.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122016", "story_v_out_412122.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_412122", "412122016", "story_v_out_412122.awb")

						arg_69_1:RecordAudio("412122016", var_72_9)
						arg_69_1:RecordAudio("412122016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412122", "412122016", "story_v_out_412122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412122", "412122016", "story_v_out_412122.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play412122017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412122017
		arg_73_1.duration_ = 7.7

		local var_73_0 = {
			zh = 4.033,
			ja = 7.7
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
				arg_73_0:Play412122018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.475

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[205].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(412122017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 19
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122017", "story_v_out_412122.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122017", "story_v_out_412122.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_412122", "412122017", "story_v_out_412122.awb")

						arg_73_1:RecordAudio("412122017", var_76_9)
						arg_73_1:RecordAudio("412122017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412122", "412122017", "story_v_out_412122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412122", "412122017", "story_v_out_412122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play412122018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412122018
		arg_77_1.duration_ = 6.8

		local var_77_0 = {
			zh = 6.333,
			ja = 6.8
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
				arg_77_0:Play412122019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 2

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				local var_80_1 = manager.ui.mainCamera.transform.localPosition
				local var_80_2 = Vector3.New(0, 0, 10) + Vector3.New(var_80_1.x, var_80_1.y, 0)
				local var_80_3 = arg_77_1.bgs_.I09h

				var_80_3.transform.localPosition = var_80_2
				var_80_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_4 = var_80_3:GetComponent("SpriteRenderer")

				if var_80_4 and var_80_4.sprite then
					local var_80_5 = (var_80_3.transform.localPosition - var_80_1).z
					local var_80_6 = manager.ui.mainCameraCom_
					local var_80_7 = 2 * var_80_5 * Mathf.Tan(var_80_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_8 = var_80_7 * var_80_6.aspect
					local var_80_9 = var_80_4.sprite.bounds.size.x
					local var_80_10 = var_80_4.sprite.bounds.size.y
					local var_80_11 = var_80_8 / var_80_9
					local var_80_12 = var_80_7 / var_80_10
					local var_80_13 = var_80_12 < var_80_11 and var_80_11 or var_80_12

					var_80_3.transform.localScale = Vector3.New(var_80_13, var_80_13, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "I09h" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_14 = 4

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_15 = 0.3

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_17 = 2

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Color.New(0, 0, 0)

				var_80_19.a = Mathf.Lerp(0, 1, var_80_18)
				arg_77_1.mask_.color = var_80_19
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				local var_80_20 = Color.New(0, 0, 0)

				var_80_20.a = 1
				arg_77_1.mask_.color = var_80_20
			end

			local var_80_21 = 2

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_22 = 2

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Color.New(0, 0, 0)

				var_80_24.a = Mathf.Lerp(1, 0, var_80_23)
				arg_77_1.mask_.color = var_80_24
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				local var_80_25 = Color.New(0, 0, 0)
				local var_80_26 = 0

				arg_77_1.mask_.enabled = false
				var_80_25.a = var_80_26
				arg_77_1.mask_.color = var_80_25
			end

			local var_80_27 = "1042ui_story"

			if arg_77_1.actors_[var_80_27] == nil then
				local var_80_28 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_80_28) then
					local var_80_29 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_77_1.stage_.transform)

					var_80_29.name = var_80_27
					var_80_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_27] = var_80_29

					local var_80_30 = var_80_29:GetComponentInChildren(typeof(CharacterEffect))

					var_80_30.enabled = true

					local var_80_31 = GameObjectTools.GetOrAddComponent(var_80_29, typeof(DynamicBoneHelper))

					if var_80_31 then
						var_80_31:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_30.transform, false)

					arg_77_1.var_[var_80_27 .. "Animator"] = var_80_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_27 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_27 .. "LipSync"] = var_80_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_32 = arg_77_1.actors_["1042ui_story"].transform
			local var_80_33 = 4

			if var_80_33 < arg_77_1.time_ and arg_77_1.time_ <= var_80_33 + arg_80_0 then
				arg_77_1.var_.moveOldPos1042ui_story = var_80_32.localPosition
			end

			local var_80_34 = 0.001

			if var_80_33 <= arg_77_1.time_ and arg_77_1.time_ < var_80_33 + var_80_34 then
				local var_80_35 = (arg_77_1.time_ - var_80_33) / var_80_34
				local var_80_36 = Vector3.New(0, -1.06, -6.2)

				var_80_32.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1042ui_story, var_80_36, var_80_35)

				local var_80_37 = manager.ui.mainCamera.transform.position - var_80_32.position

				var_80_32.forward = Vector3.New(var_80_37.x, var_80_37.y, var_80_37.z)

				local var_80_38 = var_80_32.localEulerAngles

				var_80_38.z = 0
				var_80_38.x = 0
				var_80_32.localEulerAngles = var_80_38
			end

			if arg_77_1.time_ >= var_80_33 + var_80_34 and arg_77_1.time_ < var_80_33 + var_80_34 + arg_80_0 then
				var_80_32.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_80_39 = manager.ui.mainCamera.transform.position - var_80_32.position

				var_80_32.forward = Vector3.New(var_80_39.x, var_80_39.y, var_80_39.z)

				local var_80_40 = var_80_32.localEulerAngles

				var_80_40.z = 0
				var_80_40.x = 0
				var_80_32.localEulerAngles = var_80_40
			end

			local var_80_41 = 4

			if var_80_41 < arg_77_1.time_ and arg_77_1.time_ <= var_80_41 + arg_80_0 then
				arg_77_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_80_42 = 4

			if var_80_42 < arg_77_1.time_ and arg_77_1.time_ <= var_80_42 + arg_80_0 then
				arg_77_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_80_43 = arg_77_1.actors_["1042ui_story"]
			local var_80_44 = 4

			if var_80_44 < arg_77_1.time_ and arg_77_1.time_ <= var_80_44 + arg_80_0 and not isNil(var_80_43) and arg_77_1.var_.characterEffect1042ui_story == nil then
				arg_77_1.var_.characterEffect1042ui_story = var_80_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_45 = 0.2

			if var_80_44 <= arg_77_1.time_ and arg_77_1.time_ < var_80_44 + var_80_45 and not isNil(var_80_43) then
				local var_80_46 = (arg_77_1.time_ - var_80_44) / var_80_45

				if arg_77_1.var_.characterEffect1042ui_story and not isNil(var_80_43) then
					arg_77_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_44 + var_80_45 and arg_77_1.time_ < var_80_44 + var_80_45 + arg_80_0 and not isNil(var_80_43) and arg_77_1.var_.characterEffect1042ui_story then
				arg_77_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_47 = 4
			local var_80_48 = 0.175

			if var_80_47 < arg_77_1.time_ and arg_77_1.time_ <= var_80_47 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_49 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_49:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_50 = arg_77_1:FormatText(StoryNameCfg[205].name)

				arg_77_1.leftNameTxt_.text = var_80_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_51 = arg_77_1:GetWordFromCfg(412122018)
				local var_80_52 = arg_77_1:FormatText(var_80_51.content)

				arg_77_1.text_.text = var_80_52

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_53 = 7
				local var_80_54 = utf8.len(var_80_52)
				local var_80_55 = var_80_53 <= 0 and var_80_48 or var_80_48 * (var_80_54 / var_80_53)

				if var_80_55 > 0 and var_80_48 < var_80_55 then
					arg_77_1.talkMaxDuration = var_80_55
					var_80_47 = var_80_47 + 0.3

					if var_80_55 + var_80_47 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_55 + var_80_47
					end
				end

				arg_77_1.text_.text = var_80_52
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122018", "story_v_out_412122.awb") ~= 0 then
					local var_80_56 = manager.audio:GetVoiceLength("story_v_out_412122", "412122018", "story_v_out_412122.awb") / 1000

					if var_80_56 + var_80_47 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_56 + var_80_47
					end

					if var_80_51.prefab_name ~= "" and arg_77_1.actors_[var_80_51.prefab_name] ~= nil then
						local var_80_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_51.prefab_name].transform, "story_v_out_412122", "412122018", "story_v_out_412122.awb")

						arg_77_1:RecordAudio("412122018", var_80_57)
						arg_77_1:RecordAudio("412122018", var_80_57)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412122", "412122018", "story_v_out_412122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412122", "412122018", "story_v_out_412122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_58 = var_80_47 + 0.3
			local var_80_59 = math.max(var_80_48, arg_77_1.talkMaxDuration)

			if var_80_58 <= arg_77_1.time_ and arg_77_1.time_ < var_80_58 + var_80_59 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_58) / var_80_59

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_58 + var_80_59 and arg_77_1.time_ < var_80_58 + var_80_59 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play412122019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 412122019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play412122020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1042ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1042ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1042ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = 0
			local var_86_10 = 0.475

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_11 = arg_83_1:GetWordFromCfg(412122019)
				local var_86_12 = arg_83_1:FormatText(var_86_11.content)

				arg_83_1.text_.text = var_86_12

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 19
				local var_86_14 = utf8.len(var_86_12)
				local var_86_15 = var_86_13 <= 0 and var_86_10 or var_86_10 * (var_86_14 / var_86_13)

				if var_86_15 > 0 and var_86_10 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_12
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_9) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_9 + var_86_16 and arg_83_1.time_ < var_86_9 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play412122020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 412122020
		arg_87_1.duration_ = 1.3

		local var_87_0 = {
			zh = 1,
			ja = 1.3
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play412122021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "3043ui_story"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Char/" .. "3043ui_story")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(Asset.Load("Char/" .. "3043ui_story"), arg_87_1.stage_.transform)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentInChildren(typeof(CharacterEffect))

					var_90_3.enabled = true

					local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_2, typeof(DynamicBoneHelper))

					if var_90_4 then
						var_90_4:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_3.transform, false)

					arg_87_1.var_[var_90_0 .. "Animator"] = var_90_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_0 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_0 .. "LipSync"] = var_90_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_5 = arg_87_1.actors_["3043ui_story"].transform
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.var_.moveOldPos3043ui_story = var_90_5.localPosition
			end

			local var_90_7 = 0.001

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 then
				local var_90_8 = (arg_87_1.time_ - var_90_6) / var_90_7
				local var_90_9 = Vector3.New(-0.7, -1.41, -5.7)

				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos3043ui_story, var_90_9, var_90_8)

				local var_90_10 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_10.x, var_90_10.y, var_90_10.z)

				local var_90_11 = var_90_5.localEulerAngles

				var_90_11.z = 0
				var_90_11.x = 0
				var_90_5.localEulerAngles = var_90_11
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(-0.7, -1.41, -5.7)

				local var_90_12 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_12.x, var_90_12.y, var_90_12.z)

				local var_90_13 = var_90_5.localEulerAngles

				var_90_13.z = 0
				var_90_13.x = 0
				var_90_5.localEulerAngles = var_90_13
			end

			local var_90_14 = arg_87_1.actors_["3043ui_story"]
			local var_90_15 = 0

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect3043ui_story == nil then
				arg_87_1.var_.characterEffect3043ui_story = var_90_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.200000002980232

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_16 and not isNil(var_90_14) then
				local var_90_17 = (arg_87_1.time_ - var_90_15) / var_90_16

				if arg_87_1.var_.characterEffect3043ui_story and not isNil(var_90_14) then
					arg_87_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_15 + var_90_16 and arg_87_1.time_ < var_90_15 + var_90_16 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect3043ui_story then
				arg_87_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_20 = 0
			local var_90_21 = 0.05

			if var_90_20 < arg_87_1.time_ and arg_87_1.time_ <= var_90_20 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_22 = arg_87_1:FormatText(StoryNameCfg[920].name)

				arg_87_1.leftNameTxt_.text = var_90_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_23 = arg_87_1:GetWordFromCfg(412122020)
				local var_90_24 = arg_87_1:FormatText(var_90_23.content)

				arg_87_1.text_.text = var_90_24

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_25 = 2
				local var_90_26 = utf8.len(var_90_24)
				local var_90_27 = var_90_25 <= 0 and var_90_21 or var_90_21 * (var_90_26 / var_90_25)

				if var_90_27 > 0 and var_90_21 < var_90_27 then
					arg_87_1.talkMaxDuration = var_90_27

					if var_90_27 + var_90_20 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_27 + var_90_20
					end
				end

				arg_87_1.text_.text = var_90_24
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122020", "story_v_out_412122.awb") ~= 0 then
					local var_90_28 = manager.audio:GetVoiceLength("story_v_out_412122", "412122020", "story_v_out_412122.awb") / 1000

					if var_90_28 + var_90_20 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_28 + var_90_20
					end

					if var_90_23.prefab_name ~= "" and arg_87_1.actors_[var_90_23.prefab_name] ~= nil then
						local var_90_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_23.prefab_name].transform, "story_v_out_412122", "412122020", "story_v_out_412122.awb")

						arg_87_1:RecordAudio("412122020", var_90_29)
						arg_87_1:RecordAudio("412122020", var_90_29)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_412122", "412122020", "story_v_out_412122.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_412122", "412122020", "story_v_out_412122.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_30 = math.max(var_90_21, arg_87_1.talkMaxDuration)

			if var_90_20 <= arg_87_1.time_ and arg_87_1.time_ < var_90_20 + var_90_30 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_20) / var_90_30

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_20 + var_90_30 and arg_87_1.time_ < var_90_20 + var_90_30 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play412122021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 412122021
		arg_91_1.duration_ = 4.43

		local var_91_0 = {
			zh = 2.166,
			ja = 4.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play412122022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1042ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1042ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0.7, -1.06, -6.2)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1042ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1042ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1042ui_story == nil then
				arg_91_1.var_.characterEffect1042ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect1042ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1042ui_story then
				arg_91_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_15 = arg_91_1.actors_["3043ui_story"]
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.characterEffect3043ui_story == nil then
				arg_91_1.var_.characterEffect3043ui_story = var_94_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_17 = 0.200000002980232

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 and not isNil(var_94_15) then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17

				if arg_91_1.var_.characterEffect3043ui_story and not isNil(var_94_15) then
					local var_94_19 = Mathf.Lerp(0, 0.5, var_94_18)

					arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_91_1.var_.characterEffect3043ui_story.fillRatio = var_94_19
				end
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.characterEffect3043ui_story then
				local var_94_20 = 0.5

				arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_91_1.var_.characterEffect3043ui_story.fillRatio = var_94_20
			end

			local var_94_21 = 0
			local var_94_22 = 0.275

			if var_94_21 < arg_91_1.time_ and arg_91_1.time_ <= var_94_21 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_23 = arg_91_1:FormatText(StoryNameCfg[205].name)

				arg_91_1.leftNameTxt_.text = var_94_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_24 = arg_91_1:GetWordFromCfg(412122021)
				local var_94_25 = arg_91_1:FormatText(var_94_24.content)

				arg_91_1.text_.text = var_94_25

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_26 = 11
				local var_94_27 = utf8.len(var_94_25)
				local var_94_28 = var_94_26 <= 0 and var_94_22 or var_94_22 * (var_94_27 / var_94_26)

				if var_94_28 > 0 and var_94_22 < var_94_28 then
					arg_91_1.talkMaxDuration = var_94_28

					if var_94_28 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_28 + var_94_21
					end
				end

				arg_91_1.text_.text = var_94_25
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122021", "story_v_out_412122.awb") ~= 0 then
					local var_94_29 = manager.audio:GetVoiceLength("story_v_out_412122", "412122021", "story_v_out_412122.awb") / 1000

					if var_94_29 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_29 + var_94_21
					end

					if var_94_24.prefab_name ~= "" and arg_91_1.actors_[var_94_24.prefab_name] ~= nil then
						local var_94_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_24.prefab_name].transform, "story_v_out_412122", "412122021", "story_v_out_412122.awb")

						arg_91_1:RecordAudio("412122021", var_94_30)
						arg_91_1:RecordAudio("412122021", var_94_30)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_412122", "412122021", "story_v_out_412122.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_412122", "412122021", "story_v_out_412122.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_31 = math.max(var_94_22, arg_91_1.talkMaxDuration)

			if var_94_21 <= arg_91_1.time_ and arg_91_1.time_ < var_94_21 + var_94_31 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_21) / var_94_31

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_21 + var_94_31 and arg_91_1.time_ < var_94_21 + var_94_31 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play412122022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 412122022
		arg_95_1.duration_ = 6.5

		local var_95_0 = {
			zh = 3.833,
			ja = 6.5
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play412122023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["3043ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect3043ui_story == nil then
				arg_95_1.var_.characterEffect3043ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect3043ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect3043ui_story then
				arg_95_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_6 = arg_95_1.actors_["1042ui_story"]
			local var_98_7 = 0

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1042ui_story == nil then
				arg_95_1.var_.characterEffect1042ui_story = var_98_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_8 = 0.200000002980232

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 and not isNil(var_98_6) then
				local var_98_9 = (arg_95_1.time_ - var_98_7) / var_98_8

				if arg_95_1.var_.characterEffect1042ui_story and not isNil(var_98_6) then
					local var_98_10 = Mathf.Lerp(0, 0.5, var_98_9)

					arg_95_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1042ui_story.fillRatio = var_98_10
				end
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1042ui_story then
				local var_98_11 = 0.5

				arg_95_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1042ui_story.fillRatio = var_98_11
			end

			local var_98_12 = 0
			local var_98_13 = 0.45

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[920].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(412122022)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 18
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122022", "story_v_out_412122.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122022", "story_v_out_412122.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_412122", "412122022", "story_v_out_412122.awb")

						arg_95_1:RecordAudio("412122022", var_98_21)
						arg_95_1:RecordAudio("412122022", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_412122", "412122022", "story_v_out_412122.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_412122", "412122022", "story_v_out_412122.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play412122023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412122023
		arg_99_1.duration_ = 3.17

		local var_99_0 = {
			zh = 3.166,
			ja = 2.966
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play412122024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1042ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1042ui_story == nil then
				arg_99_1.var_.characterEffect1042ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1042ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1042ui_story then
				arg_99_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_6 = arg_99_1.actors_["3043ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect3043ui_story == nil then
				arg_99_1.var_.characterEffect3043ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.200000002980232

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect3043ui_story and not isNil(var_102_6) then
					local var_102_10 = Mathf.Lerp(0, 0.5, var_102_9)

					arg_99_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_99_1.var_.characterEffect3043ui_story.fillRatio = var_102_10
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect3043ui_story then
				local var_102_11 = 0.5

				arg_99_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_99_1.var_.characterEffect3043ui_story.fillRatio = var_102_11
			end

			local var_102_12 = 0
			local var_102_13 = 0.325

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_14 = arg_99_1:FormatText(StoryNameCfg[205].name)

				arg_99_1.leftNameTxt_.text = var_102_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_15 = arg_99_1:GetWordFromCfg(412122023)
				local var_102_16 = arg_99_1:FormatText(var_102_15.content)

				arg_99_1.text_.text = var_102_16

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_17 = 13
				local var_102_18 = utf8.len(var_102_16)
				local var_102_19 = var_102_17 <= 0 and var_102_13 or var_102_13 * (var_102_18 / var_102_17)

				if var_102_19 > 0 and var_102_13 < var_102_19 then
					arg_99_1.talkMaxDuration = var_102_19

					if var_102_19 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_16
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122023", "story_v_out_412122.awb") ~= 0 then
					local var_102_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122023", "story_v_out_412122.awb") / 1000

					if var_102_20 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_20 + var_102_12
					end

					if var_102_15.prefab_name ~= "" and arg_99_1.actors_[var_102_15.prefab_name] ~= nil then
						local var_102_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_15.prefab_name].transform, "story_v_out_412122", "412122023", "story_v_out_412122.awb")

						arg_99_1:RecordAudio("412122023", var_102_21)
						arg_99_1:RecordAudio("412122023", var_102_21)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_412122", "412122023", "story_v_out_412122.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_412122", "412122023", "story_v_out_412122.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_22 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_22 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_12) / var_102_22

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_12 + var_102_22 and arg_99_1.time_ < var_102_12 + var_102_22 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play412122024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412122024
		arg_103_1.duration_ = 9.73

		local var_103_0 = {
			zh = 3.966,
			ja = 9.733
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play412122025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.45

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[205].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(412122024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 18
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122024", "story_v_out_412122.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122024", "story_v_out_412122.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_412122", "412122024", "story_v_out_412122.awb")

						arg_103_1:RecordAudio("412122024", var_106_9)
						arg_103_1:RecordAudio("412122024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_412122", "412122024", "story_v_out_412122.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_412122", "412122024", "story_v_out_412122.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play412122025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412122025
		arg_107_1.duration_ = 6.5

		local var_107_0 = {
			zh = 4.033,
			ja = 6.5
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play412122026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["3043ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect3043ui_story == nil then
				arg_107_1.var_.characterEffect3043ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect3043ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect3043ui_story then
				arg_107_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_6 = arg_107_1.actors_["1042ui_story"]
			local var_110_7 = 0

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1042ui_story == nil then
				arg_107_1.var_.characterEffect1042ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_8 = 0.200000002980232

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 and not isNil(var_110_6) then
				local var_110_9 = (arg_107_1.time_ - var_110_7) / var_110_8

				if arg_107_1.var_.characterEffect1042ui_story and not isNil(var_110_6) then
					local var_110_10 = Mathf.Lerp(0, 0.5, var_110_9)

					arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1042ui_story.fillRatio = var_110_10
				end
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1042ui_story then
				local var_110_11 = 0.5

				arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1042ui_story.fillRatio = var_110_11
			end

			local var_110_12 = 0
			local var_110_13 = 0.45

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_14 = arg_107_1:FormatText(StoryNameCfg[920].name)

				arg_107_1.leftNameTxt_.text = var_110_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_15 = arg_107_1:GetWordFromCfg(412122025)
				local var_110_16 = arg_107_1:FormatText(var_110_15.content)

				arg_107_1.text_.text = var_110_16

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_17 = 18
				local var_110_18 = utf8.len(var_110_16)
				local var_110_19 = var_110_17 <= 0 and var_110_13 or var_110_13 * (var_110_18 / var_110_17)

				if var_110_19 > 0 and var_110_13 < var_110_19 then
					arg_107_1.talkMaxDuration = var_110_19

					if var_110_19 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_12
					end
				end

				arg_107_1.text_.text = var_110_16
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122025", "story_v_out_412122.awb") ~= 0 then
					local var_110_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122025", "story_v_out_412122.awb") / 1000

					if var_110_20 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_12
					end

					if var_110_15.prefab_name ~= "" and arg_107_1.actors_[var_110_15.prefab_name] ~= nil then
						local var_110_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_15.prefab_name].transform, "story_v_out_412122", "412122025", "story_v_out_412122.awb")

						arg_107_1:RecordAudio("412122025", var_110_21)
						arg_107_1:RecordAudio("412122025", var_110_21)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412122", "412122025", "story_v_out_412122.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412122", "412122025", "story_v_out_412122.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = math.max(var_110_13, arg_107_1.talkMaxDuration)

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_22 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_12) / var_110_22

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_12 + var_110_22 and arg_107_1.time_ < var_110_12 + var_110_22 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play412122026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412122026
		arg_111_1.duration_ = 1.43

		local var_111_0 = {
			zh = 1.433,
			ja = 1.333
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play412122027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.1

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[920].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(412122026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 4
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122026", "story_v_out_412122.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122026", "story_v_out_412122.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_412122", "412122026", "story_v_out_412122.awb")

						arg_111_1:RecordAudio("412122026", var_114_9)
						arg_111_1:RecordAudio("412122026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_412122", "412122026", "story_v_out_412122.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_412122", "412122026", "story_v_out_412122.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412122027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412122027
		arg_115_1.duration_ = 2.4

		local var_115_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_115_0:Play412122028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1042ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_6 = arg_115_1.actors_["3043ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect3043ui_story == nil then
				arg_115_1.var_.characterEffect3043ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect3043ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_115_1.var_.characterEffect3043ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect3043ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_115_1.var_.characterEffect3043ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.15

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[205].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(412122027)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 6
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122027", "story_v_out_412122.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122027", "story_v_out_412122.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_412122", "412122027", "story_v_out_412122.awb")

						arg_115_1:RecordAudio("412122027", var_118_21)
						arg_115_1:RecordAudio("412122027", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412122", "412122027", "story_v_out_412122.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412122", "412122027", "story_v_out_412122.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play412122028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412122028
		arg_119_1.duration_ = 9.27

		local var_119_0 = {
			zh = 7.6,
			ja = 9.266
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
				arg_119_0:Play412122029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["3043ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect3043ui_story == nil then
				arg_119_1.var_.characterEffect3043ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect3043ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect3043ui_story then
				arg_119_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_6 = arg_119_1.actors_["1042ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1042ui_story == nil then
				arg_119_1.var_.characterEffect1042ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1042ui_story and not isNil(var_122_6) then
					local var_122_10 = Mathf.Lerp(0, 0.5, var_122_9)

					arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1042ui_story.fillRatio = var_122_10
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1042ui_story then
				local var_122_11 = 0.5

				arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1042ui_story.fillRatio = var_122_11
			end

			local var_122_12 = 0
			local var_122_13 = 0.9

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[920].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(412122028)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 37
				local var_122_18 = utf8.len(var_122_16)
				local var_122_19 = var_122_17 <= 0 and var_122_13 or var_122_13 * (var_122_18 / var_122_17)

				if var_122_19 > 0 and var_122_13 < var_122_19 then
					arg_119_1.talkMaxDuration = var_122_19

					if var_122_19 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122028", "story_v_out_412122.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122028", "story_v_out_412122.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_412122", "412122028", "story_v_out_412122.awb")

						arg_119_1:RecordAudio("412122028", var_122_21)
						arg_119_1:RecordAudio("412122028", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_412122", "412122028", "story_v_out_412122.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_412122", "412122028", "story_v_out_412122.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_22 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_22

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_22 and arg_119_1.time_ < var_122_12 + var_122_22 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play412122029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412122029
		arg_123_1.duration_ = 4.63

		local var_123_0 = {
			zh = 3.766,
			ja = 4.633
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
				arg_123_0:Play412122030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1042ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1042ui_story == nil then
				arg_123_1.var_.characterEffect1042ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1042ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1042ui_story then
				arg_123_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_6 = arg_123_1.actors_["3043ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect3043ui_story == nil then
				arg_123_1.var_.characterEffect3043ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect3043ui_story and not isNil(var_126_6) then
					local var_126_10 = Mathf.Lerp(0, 0.5, var_126_9)

					arg_123_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_123_1.var_.characterEffect3043ui_story.fillRatio = var_126_10
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect3043ui_story then
				local var_126_11 = 0.5

				arg_123_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_123_1.var_.characterEffect3043ui_story.fillRatio = var_126_11
			end

			local var_126_12 = 0
			local var_126_13 = 0.45

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_14 = arg_123_1:FormatText(StoryNameCfg[205].name)

				arg_123_1.leftNameTxt_.text = var_126_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:GetWordFromCfg(412122029)
				local var_126_16 = arg_123_1:FormatText(var_126_15.content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122029", "story_v_out_412122.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122029", "story_v_out_412122.awb") / 1000

					if var_126_20 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_12
					end

					if var_126_15.prefab_name ~= "" and arg_123_1.actors_[var_126_15.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_15.prefab_name].transform, "story_v_out_412122", "412122029", "story_v_out_412122.awb")

						arg_123_1:RecordAudio("412122029", var_126_21)
						arg_123_1:RecordAudio("412122029", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412122", "412122029", "story_v_out_412122.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412122", "412122029", "story_v_out_412122.awb")
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
	Play412122030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412122030
		arg_127_1.duration_ = 12.6

		local var_127_0 = {
			zh = 12.6,
			ja = 11.566
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
				arg_127_0:Play412122031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["3043ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect3043ui_story == nil then
				arg_127_1.var_.characterEffect3043ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect3043ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect3043ui_story then
				arg_127_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_130_4 = 0

			if var_130_4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_6 = arg_127_1.actors_["1042ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1042ui_story == nil then
				arg_127_1.var_.characterEffect1042ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1042ui_story and not isNil(var_130_6) then
					local var_130_10 = Mathf.Lerp(0, 0.5, var_130_9)

					arg_127_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1042ui_story.fillRatio = var_130_10
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1042ui_story then
				local var_130_11 = 0.5

				arg_127_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1042ui_story.fillRatio = var_130_11
			end

			local var_130_12 = 0
			local var_130_13 = 1.325

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[920].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(412122030)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 53
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122030", "story_v_out_412122.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122030", "story_v_out_412122.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_412122", "412122030", "story_v_out_412122.awb")

						arg_127_1:RecordAudio("412122030", var_130_21)
						arg_127_1:RecordAudio("412122030", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_412122", "412122030", "story_v_out_412122.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_412122", "412122030", "story_v_out_412122.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play412122031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412122031
		arg_131_1.duration_ = 7.93

		local var_131_0 = {
			zh = 3.866,
			ja = 7.933
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
				arg_131_0:Play412122032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.375

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[920].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(412122031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 15
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122031", "story_v_out_412122.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122031", "story_v_out_412122.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_412122", "412122031", "story_v_out_412122.awb")

						arg_131_1:RecordAudio("412122031", var_134_9)
						arg_131_1:RecordAudio("412122031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412122", "412122031", "story_v_out_412122.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412122", "412122031", "story_v_out_412122.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play412122032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412122032
		arg_135_1.duration_ = 3

		local var_135_0 = {
			zh = 2.6,
			ja = 3
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
				arg_135_0:Play412122033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1042ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1042ui_story == nil then
				arg_135_1.var_.characterEffect1042ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1042ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1042ui_story then
				arg_135_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action448")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_6 = arg_135_1.actors_["3043ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect3043ui_story == nil then
				arg_135_1.var_.characterEffect3043ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect3043ui_story and not isNil(var_138_6) then
					local var_138_10 = Mathf.Lerp(0, 0.5, var_138_9)

					arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_135_1.var_.characterEffect3043ui_story.fillRatio = var_138_10
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect3043ui_story then
				local var_138_11 = 0.5

				arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_135_1.var_.characterEffect3043ui_story.fillRatio = var_138_11
			end

			local var_138_12 = 0
			local var_138_13 = 0.25

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[205].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(412122032)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 10
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122032", "story_v_out_412122.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122032", "story_v_out_412122.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_412122", "412122032", "story_v_out_412122.awb")

						arg_135_1:RecordAudio("412122032", var_138_21)
						arg_135_1:RecordAudio("412122032", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412122", "412122032", "story_v_out_412122.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412122", "412122032", "story_v_out_412122.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play412122033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412122033
		arg_139_1.duration_ = 8.23

		local var_139_0 = {
			zh = 6.766,
			ja = 8.233
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
				arg_139_0:Play412122034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["3043ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect3043ui_story == nil then
				arg_139_1.var_.characterEffect3043ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect3043ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect3043ui_story then
				arg_139_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_6 = arg_139_1.actors_["1042ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1042ui_story == nil then
				arg_139_1.var_.characterEffect1042ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1042ui_story and not isNil(var_142_6) then
					local var_142_10 = Mathf.Lerp(0, 0.5, var_142_9)

					arg_139_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1042ui_story.fillRatio = var_142_10
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1042ui_story then
				local var_142_11 = 0.5

				arg_139_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1042ui_story.fillRatio = var_142_11
			end

			local var_142_12 = 0
			local var_142_13 = 0.575

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_14 = arg_139_1:FormatText(StoryNameCfg[920].name)

				arg_139_1.leftNameTxt_.text = var_142_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(412122033)
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122033", "story_v_out_412122.awb") ~= 0 then
					local var_142_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122033", "story_v_out_412122.awb") / 1000

					if var_142_20 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_12
					end

					if var_142_15.prefab_name ~= "" and arg_139_1.actors_[var_142_15.prefab_name] ~= nil then
						local var_142_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_15.prefab_name].transform, "story_v_out_412122", "412122033", "story_v_out_412122.awb")

						arg_139_1:RecordAudio("412122033", var_142_21)
						arg_139_1:RecordAudio("412122033", var_142_21)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412122", "412122033", "story_v_out_412122.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412122", "412122033", "story_v_out_412122.awb")
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
	Play412122034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 412122034
		arg_143_1.duration_ = 5.7

		local var_143_0 = {
			zh = 3.6,
			ja = 5.7
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
				arg_143_0:Play412122035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["3043ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect3043ui_story == nil then
				arg_143_1.var_.characterEffect3043ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect3043ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_143_1.var_.characterEffect3043ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect3043ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_143_1.var_.characterEffect3043ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["1042ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1042ui_story == nil then
				arg_143_1.var_.characterEffect1042ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.200000002980232

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect1042ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1042ui_story then
				arg_143_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			local var_146_11 = 0
			local var_146_12 = 0.35

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[205].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(412122034)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122034", "story_v_out_412122.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_412122", "412122034", "story_v_out_412122.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_412122", "412122034", "story_v_out_412122.awb")

						arg_143_1:RecordAudio("412122034", var_146_20)
						arg_143_1:RecordAudio("412122034", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_412122", "412122034", "story_v_out_412122.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_412122", "412122034", "story_v_out_412122.awb")
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
	Play412122035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 412122035
		arg_147_1.duration_ = 7.2

		local var_147_0 = {
			zh = 4.433,
			ja = 7.2
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
				arg_147_0:Play412122036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["3043ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect3043ui_story == nil then
				arg_147_1.var_.characterEffect3043ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect3043ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect3043ui_story then
				arg_147_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_6 = arg_147_1.actors_["1042ui_story"]
			local var_150_7 = 0

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1042ui_story == nil then
				arg_147_1.var_.characterEffect1042ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_8 = 0.200000002980232

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 and not isNil(var_150_6) then
				local var_150_9 = (arg_147_1.time_ - var_150_7) / var_150_8

				if arg_147_1.var_.characterEffect1042ui_story and not isNil(var_150_6) then
					local var_150_10 = Mathf.Lerp(0, 0.5, var_150_9)

					arg_147_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1042ui_story.fillRatio = var_150_10
				end
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1042ui_story then
				local var_150_11 = 0.5

				arg_147_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1042ui_story.fillRatio = var_150_11
			end

			local var_150_12 = 0
			local var_150_13 = 0.55

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_14 = arg_147_1:FormatText(StoryNameCfg[920].name)

				arg_147_1.leftNameTxt_.text = var_150_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_15 = arg_147_1:GetWordFromCfg(412122035)
				local var_150_16 = arg_147_1:FormatText(var_150_15.content)

				arg_147_1.text_.text = var_150_16

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_17 = 22
				local var_150_18 = utf8.len(var_150_16)
				local var_150_19 = var_150_17 <= 0 and var_150_13 or var_150_13 * (var_150_18 / var_150_17)

				if var_150_19 > 0 and var_150_13 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19

					if var_150_19 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_12
					end
				end

				arg_147_1.text_.text = var_150_16
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122035", "story_v_out_412122.awb") ~= 0 then
					local var_150_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122035", "story_v_out_412122.awb") / 1000

					if var_150_20 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_20 + var_150_12
					end

					if var_150_15.prefab_name ~= "" and arg_147_1.actors_[var_150_15.prefab_name] ~= nil then
						local var_150_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_15.prefab_name].transform, "story_v_out_412122", "412122035", "story_v_out_412122.awb")

						arg_147_1:RecordAudio("412122035", var_150_21)
						arg_147_1:RecordAudio("412122035", var_150_21)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_412122", "412122035", "story_v_out_412122.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_412122", "412122035", "story_v_out_412122.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_22 = math.max(var_150_13, arg_147_1.talkMaxDuration)

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_22 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_12) / var_150_22

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_12 + var_150_22 and arg_147_1.time_ < var_150_12 + var_150_22 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play412122036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 412122036
		arg_151_1.duration_ = 7.23

		local var_151_0 = {
			zh = 3.866,
			ja = 7.233
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
				arg_151_0:Play412122037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1042ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1042ui_story == nil then
				arg_151_1.var_.characterEffect1042ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1042ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1042ui_story then
				arg_151_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_6 = arg_151_1.actors_["3043ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect3043ui_story == nil then
				arg_151_1.var_.characterEffect3043ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect3043ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_151_1.var_.characterEffect3043ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect3043ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_151_1.var_.characterEffect3043ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.5

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[205].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(412122036)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 20
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122036", "story_v_out_412122.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122036", "story_v_out_412122.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_412122", "412122036", "story_v_out_412122.awb")

						arg_151_1:RecordAudio("412122036", var_154_21)
						arg_151_1:RecordAudio("412122036", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_412122", "412122036", "story_v_out_412122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_412122", "412122036", "story_v_out_412122.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play412122037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 412122037
		arg_155_1.duration_ = 11.57

		local var_155_0 = {
			zh = 8.366,
			ja = 11.566
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play412122038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[205].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(412122037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 40
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122037", "story_v_out_412122.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122037", "story_v_out_412122.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_412122", "412122037", "story_v_out_412122.awb")

						arg_155_1:RecordAudio("412122037", var_158_9)
						arg_155_1:RecordAudio("412122037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_412122", "412122037", "story_v_out_412122.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_412122", "412122037", "story_v_out_412122.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play412122038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 412122038
		arg_159_1.duration_ = 3.1

		local var_159_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_159_0:Play412122039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["3043ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect3043ui_story == nil then
				arg_159_1.var_.characterEffect3043ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect3043ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect3043ui_story then
				arg_159_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_6 = arg_159_1.actors_["1042ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1042ui_story == nil then
				arg_159_1.var_.characterEffect1042ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect1042ui_story and not isNil(var_162_6) then
					local var_162_10 = Mathf.Lerp(0, 0.5, var_162_9)

					arg_159_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1042ui_story.fillRatio = var_162_10
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1042ui_story then
				local var_162_11 = 0.5

				arg_159_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1042ui_story.fillRatio = var_162_11
			end

			local var_162_12 = 0
			local var_162_13 = 0.1

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[920].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(412122038)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122038", "story_v_out_412122.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_412122", "412122038", "story_v_out_412122.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_412122", "412122038", "story_v_out_412122.awb")

						arg_159_1:RecordAudio("412122038", var_162_21)
						arg_159_1:RecordAudio("412122038", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_412122", "412122038", "story_v_out_412122.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_412122", "412122038", "story_v_out_412122.awb")
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
	Play412122039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 412122039
		arg_163_1.duration_ = 4.63

		local var_163_0 = {
			zh = 4.6,
			ja = 4.633
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
				arg_163_0:Play412122040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.575

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[920].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(412122039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122039", "story_v_out_412122.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122039", "story_v_out_412122.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_412122", "412122039", "story_v_out_412122.awb")

						arg_163_1:RecordAudio("412122039", var_166_9)
						arg_163_1:RecordAudio("412122039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_412122", "412122039", "story_v_out_412122.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_412122", "412122039", "story_v_out_412122.awb")
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
	Play412122040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 412122040
		arg_167_1.duration_ = 6.1

		local var_167_0 = {
			zh = 4.766,
			ja = 6.1
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
				arg_167_0:Play412122041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.5

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[920].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(412122040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 20
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122040", "story_v_out_412122.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_412122", "412122040", "story_v_out_412122.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_412122", "412122040", "story_v_out_412122.awb")

						arg_167_1:RecordAudio("412122040", var_170_9)
						arg_167_1:RecordAudio("412122040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_412122", "412122040", "story_v_out_412122.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_412122", "412122040", "story_v_out_412122.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play412122041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 412122041
		arg_171_1.duration_ = 9

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play412122042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = "ST84a"

			if arg_171_1.bgs_[var_174_0] == nil then
				local var_174_1 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_0)
				var_174_1.name = var_174_0
				var_174_1.transform.parent = arg_171_1.stage_.transform
				var_174_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_0] = var_174_1
			end

			local var_174_2 = 2

			if var_174_2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				local var_174_3 = manager.ui.mainCamera.transform.localPosition
				local var_174_4 = Vector3.New(0, 0, 10) + Vector3.New(var_174_3.x, var_174_3.y, 0)
				local var_174_5 = arg_171_1.bgs_.ST84a

				var_174_5.transform.localPosition = var_174_4
				var_174_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_6 = var_174_5:GetComponent("SpriteRenderer")

				if var_174_6 and var_174_6.sprite then
					local var_174_7 = (var_174_5.transform.localPosition - var_174_3).z
					local var_174_8 = manager.ui.mainCameraCom_
					local var_174_9 = 2 * var_174_7 * Mathf.Tan(var_174_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_10 = var_174_9 * var_174_8.aspect
					local var_174_11 = var_174_6.sprite.bounds.size.x
					local var_174_12 = var_174_6.sprite.bounds.size.y
					local var_174_13 = var_174_10 / var_174_11
					local var_174_14 = var_174_9 / var_174_12
					local var_174_15 = var_174_14 < var_174_13 and var_174_13 or var_174_14

					var_174_5.transform.localScale = Vector3.New(var_174_15, var_174_15, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "ST84a" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_16 = 4

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_17 = 0.3

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_18 = 0

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_19 = 2

			if var_174_18 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				local var_174_20 = (arg_171_1.time_ - var_174_18) / var_174_19
				local var_174_21 = Color.New(0, 0, 0)

				var_174_21.a = Mathf.Lerp(0, 1, var_174_20)
				arg_171_1.mask_.color = var_174_21
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				local var_174_22 = Color.New(0, 0, 0)

				var_174_22.a = 1
				arg_171_1.mask_.color = var_174_22
			end

			local var_174_23 = 2

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_24 = 2

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24
				local var_174_26 = Color.New(0, 0, 0)

				var_174_26.a = Mathf.Lerp(1, 0, var_174_25)
				arg_171_1.mask_.color = var_174_26
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 then
				local var_174_27 = Color.New(0, 0, 0)
				local var_174_28 = 0

				arg_171_1.mask_.enabled = false
				var_174_27.a = var_174_28
				arg_171_1.mask_.color = var_174_27
			end

			local var_174_29 = arg_171_1.actors_["3043ui_story"].transform
			local var_174_30 = 1.96599999815226

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.var_.moveOldPos3043ui_story = var_174_29.localPosition
			end

			local var_174_31 = 0.001

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_31 then
				local var_174_32 = (arg_171_1.time_ - var_174_30) / var_174_31
				local var_174_33 = Vector3.New(0, 100, 0)

				var_174_29.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos3043ui_story, var_174_33, var_174_32)

				local var_174_34 = manager.ui.mainCamera.transform.position - var_174_29.position

				var_174_29.forward = Vector3.New(var_174_34.x, var_174_34.y, var_174_34.z)

				local var_174_35 = var_174_29.localEulerAngles

				var_174_35.z = 0
				var_174_35.x = 0
				var_174_29.localEulerAngles = var_174_35
			end

			if arg_171_1.time_ >= var_174_30 + var_174_31 and arg_171_1.time_ < var_174_30 + var_174_31 + arg_174_0 then
				var_174_29.localPosition = Vector3.New(0, 100, 0)

				local var_174_36 = manager.ui.mainCamera.transform.position - var_174_29.position

				var_174_29.forward = Vector3.New(var_174_36.x, var_174_36.y, var_174_36.z)

				local var_174_37 = var_174_29.localEulerAngles

				var_174_37.z = 0
				var_174_37.x = 0
				var_174_29.localEulerAngles = var_174_37
			end

			local var_174_38 = arg_171_1.actors_["3043ui_story"]
			local var_174_39 = 1.96599999815226

			if var_174_39 < arg_171_1.time_ and arg_171_1.time_ <= var_174_39 + arg_174_0 and not isNil(var_174_38) and arg_171_1.var_.characterEffect3043ui_story == nil then
				arg_171_1.var_.characterEffect3043ui_story = var_174_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_40 = 0.034000001847744

			if var_174_39 <= arg_171_1.time_ and arg_171_1.time_ < var_174_39 + var_174_40 and not isNil(var_174_38) then
				local var_174_41 = (arg_171_1.time_ - var_174_39) / var_174_40

				if arg_171_1.var_.characterEffect3043ui_story and not isNil(var_174_38) then
					local var_174_42 = Mathf.Lerp(0, 0.5, var_174_41)

					arg_171_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_171_1.var_.characterEffect3043ui_story.fillRatio = var_174_42
				end
			end

			if arg_171_1.time_ >= var_174_39 + var_174_40 and arg_171_1.time_ < var_174_39 + var_174_40 + arg_174_0 and not isNil(var_174_38) and arg_171_1.var_.characterEffect3043ui_story then
				local var_174_43 = 0.5

				arg_171_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_171_1.var_.characterEffect3043ui_story.fillRatio = var_174_43
			end

			local var_174_44 = arg_171_1.actors_["1042ui_story"].transform
			local var_174_45 = 1.96599999815226

			if var_174_45 < arg_171_1.time_ and arg_171_1.time_ <= var_174_45 + arg_174_0 then
				arg_171_1.var_.moveOldPos1042ui_story = var_174_44.localPosition
			end

			local var_174_46 = 0.001

			if var_174_45 <= arg_171_1.time_ and arg_171_1.time_ < var_174_45 + var_174_46 then
				local var_174_47 = (arg_171_1.time_ - var_174_45) / var_174_46
				local var_174_48 = Vector3.New(0, 100, 0)

				var_174_44.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1042ui_story, var_174_48, var_174_47)

				local var_174_49 = manager.ui.mainCamera.transform.position - var_174_44.position

				var_174_44.forward = Vector3.New(var_174_49.x, var_174_49.y, var_174_49.z)

				local var_174_50 = var_174_44.localEulerAngles

				var_174_50.z = 0
				var_174_50.x = 0
				var_174_44.localEulerAngles = var_174_50
			end

			if arg_171_1.time_ >= var_174_45 + var_174_46 and arg_171_1.time_ < var_174_45 + var_174_46 + arg_174_0 then
				var_174_44.localPosition = Vector3.New(0, 100, 0)

				local var_174_51 = manager.ui.mainCamera.transform.position - var_174_44.position

				var_174_44.forward = Vector3.New(var_174_51.x, var_174_51.y, var_174_51.z)

				local var_174_52 = var_174_44.localEulerAngles

				var_174_52.z = 0
				var_174_52.x = 0
				var_174_44.localEulerAngles = var_174_52
			end

			local var_174_53 = arg_171_1.actors_["1042ui_story"]
			local var_174_54 = 1.96599999815226

			if var_174_54 < arg_171_1.time_ and arg_171_1.time_ <= var_174_54 + arg_174_0 and not isNil(var_174_53) and arg_171_1.var_.characterEffect1042ui_story == nil then
				arg_171_1.var_.characterEffect1042ui_story = var_174_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_55 = 0.034000001847744

			if var_174_54 <= arg_171_1.time_ and arg_171_1.time_ < var_174_54 + var_174_55 and not isNil(var_174_53) then
				local var_174_56 = (arg_171_1.time_ - var_174_54) / var_174_55

				if arg_171_1.var_.characterEffect1042ui_story and not isNil(var_174_53) then
					local var_174_57 = Mathf.Lerp(0, 0.5, var_174_56)

					arg_171_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1042ui_story.fillRatio = var_174_57
				end
			end

			if arg_171_1.time_ >= var_174_54 + var_174_55 and arg_171_1.time_ < var_174_54 + var_174_55 + arg_174_0 and not isNil(var_174_53) and arg_171_1.var_.characterEffect1042ui_story then
				local var_174_58 = 0.5

				arg_171_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1042ui_story.fillRatio = var_174_58
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_59 = 4
			local var_174_60 = 0.175

			if var_174_59 < arg_171_1.time_ and arg_171_1.time_ <= var_174_59 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_61 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_61:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_62 = arg_171_1:GetWordFromCfg(412122041)
				local var_174_63 = arg_171_1:FormatText(var_174_62.content)

				arg_171_1.text_.text = var_174_63

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_64 = 7
				local var_174_65 = utf8.len(var_174_63)
				local var_174_66 = var_174_64 <= 0 and var_174_60 or var_174_60 * (var_174_65 / var_174_64)

				if var_174_66 > 0 and var_174_60 < var_174_66 then
					arg_171_1.talkMaxDuration = var_174_66
					var_174_59 = var_174_59 + 0.3

					if var_174_66 + var_174_59 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_66 + var_174_59
					end
				end

				arg_171_1.text_.text = var_174_63
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_67 = var_174_59 + 0.3
			local var_174_68 = math.max(var_174_60, arg_171_1.talkMaxDuration)

			if var_174_67 <= arg_171_1.time_ and arg_171_1.time_ < var_174_67 + var_174_68 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_67) / var_174_68

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_67 + var_174_68 and arg_171_1.time_ < var_174_67 + var_174_68 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play412122042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412122042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play412122043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.475

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(412122042)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 19
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play412122043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412122043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play412122044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.55

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(412122043)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 22
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play412122044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412122044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play412122045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.15

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(412122044)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 46
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play412122045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 412122045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play412122046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.5

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(412122045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 20
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play412122046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 412122046
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play412122047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "1097ui_story"

			if arg_193_1.actors_[var_196_0] == nil then
				local var_196_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_196_1) then
					local var_196_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_193_1.stage_.transform)

					var_196_2.name = var_196_0
					var_196_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_193_1.actors_[var_196_0] = var_196_2

					local var_196_3 = var_196_2:GetComponentInChildren(typeof(CharacterEffect))

					var_196_3.enabled = true

					local var_196_4 = GameObjectTools.GetOrAddComponent(var_196_2, typeof(DynamicBoneHelper))

					if var_196_4 then
						var_196_4:EnableDynamicBone(false)
					end

					arg_193_1:ShowWeapon(var_196_3.transform, false)

					arg_193_1.var_[var_196_0 .. "Animator"] = var_196_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_193_1.var_[var_196_0 .. "Animator"].applyRootMotion = true
					arg_193_1.var_[var_196_0 .. "LipSync"] = var_196_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_196_5 = arg_193_1.actors_["1097ui_story"].transform
			local var_196_6 = 0

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.var_.moveOldPos1097ui_story = var_196_5.localPosition
			end

			local var_196_7 = 0.001

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_7 then
				local var_196_8 = (arg_193_1.time_ - var_196_6) / var_196_7
				local var_196_9 = Vector3.New(0, -0.54, -6.3)

				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1097ui_story, var_196_9, var_196_8)

				local var_196_10 = manager.ui.mainCamera.transform.position - var_196_5.position

				var_196_5.forward = Vector3.New(var_196_10.x, var_196_10.y, var_196_10.z)

				local var_196_11 = var_196_5.localEulerAngles

				var_196_11.z = 0
				var_196_11.x = 0
				var_196_5.localEulerAngles = var_196_11
			end

			if arg_193_1.time_ >= var_196_6 + var_196_7 and arg_193_1.time_ < var_196_6 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_196_12 = manager.ui.mainCamera.transform.position - var_196_5.position

				var_196_5.forward = Vector3.New(var_196_12.x, var_196_12.y, var_196_12.z)

				local var_196_13 = var_196_5.localEulerAngles

				var_196_13.z = 0
				var_196_13.x = 0
				var_196_5.localEulerAngles = var_196_13
			end

			local var_196_14 = arg_193_1.actors_["1097ui_story"]
			local var_196_15 = 0

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.characterEffect1097ui_story == nil then
				arg_193_1.var_.characterEffect1097ui_story = var_196_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_16 = 0.200000002980232

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_16 and not isNil(var_196_14) then
				local var_196_17 = (arg_193_1.time_ - var_196_15) / var_196_16

				if arg_193_1.var_.characterEffect1097ui_story and not isNil(var_196_14) then
					arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_15 + var_196_16 and arg_193_1.time_ < var_196_15 + var_196_16 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.characterEffect1097ui_story then
				arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_196_18 = 0

			if var_196_18 < arg_193_1.time_ and arg_193_1.time_ <= var_196_18 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_196_20 = 0
			local var_196_21 = 0.05

			if var_196_20 < arg_193_1.time_ and arg_193_1.time_ <= var_196_20 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_22 = arg_193_1:FormatText(StoryNameCfg[216].name)

				arg_193_1.leftNameTxt_.text = var_196_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_23 = arg_193_1:GetWordFromCfg(412122046)
				local var_196_24 = arg_193_1:FormatText(var_196_23.content)

				arg_193_1.text_.text = var_196_24

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_25 = 2
				local var_196_26 = utf8.len(var_196_24)
				local var_196_27 = var_196_25 <= 0 and var_196_21 or var_196_21 * (var_196_26 / var_196_25)

				if var_196_27 > 0 and var_196_21 < var_196_27 then
					arg_193_1.talkMaxDuration = var_196_27

					if var_196_27 + var_196_20 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_27 + var_196_20
					end
				end

				arg_193_1.text_.text = var_196_24
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122046", "story_v_out_412122.awb") ~= 0 then
					local var_196_28 = manager.audio:GetVoiceLength("story_v_out_412122", "412122046", "story_v_out_412122.awb") / 1000

					if var_196_28 + var_196_20 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_28 + var_196_20
					end

					if var_196_23.prefab_name ~= "" and arg_193_1.actors_[var_196_23.prefab_name] ~= nil then
						local var_196_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_23.prefab_name].transform, "story_v_out_412122", "412122046", "story_v_out_412122.awb")

						arg_193_1:RecordAudio("412122046", var_196_29)
						arg_193_1:RecordAudio("412122046", var_196_29)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_412122", "412122046", "story_v_out_412122.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_412122", "412122046", "story_v_out_412122.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_30 = math.max(var_196_21, arg_193_1.talkMaxDuration)

			if var_196_20 <= arg_193_1.time_ and arg_193_1.time_ < var_196_20 + var_196_30 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_20) / var_196_30

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_20 + var_196_30 and arg_193_1.time_ < var_196_20 + var_196_30 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play412122047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 412122047
		arg_197_1.duration_ = 4.73

		local var_197_0 = {
			zh = 1.999999999999,
			ja = 4.733
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
			arg_197_1.auto_ = false
		end

		function arg_197_1.playNext_(arg_199_0)
			arg_197_1.onStoryFinished_()
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_200_2 = 0
			local var_200_3 = 0.175

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_4 = arg_197_1:FormatText(StoryNameCfg[216].name)

				arg_197_1.leftNameTxt_.text = var_200_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_5 = arg_197_1:GetWordFromCfg(412122047)
				local var_200_6 = arg_197_1:FormatText(var_200_5.content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 7
				local var_200_8 = utf8.len(var_200_6)
				local var_200_9 = var_200_7 <= 0 and var_200_3 or var_200_3 * (var_200_8 / var_200_7)

				if var_200_9 > 0 and var_200_3 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412122", "412122047", "story_v_out_412122.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_412122", "412122047", "story_v_out_412122.awb") / 1000

					if var_200_10 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_2
					end

					if var_200_5.prefab_name ~= "" and arg_197_1.actors_[var_200_5.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_5.prefab_name].transform, "story_v_out_412122", "412122047", "story_v_out_412122.awb")

						arg_197_1:RecordAudio("412122047", var_200_11)
						arg_197_1:RecordAudio("412122047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_412122", "412122047", "story_v_out_412122.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_412122", "412122047", "story_v_out_412122.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_12 and arg_197_1.time_ < var_200_2 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09h",
		"TextureConfig/Background/EN0109",
		"TextureConfig/Background/EN0109a",
		"TextureConfig/Background/ST84a"
	},
	voices = {
		"story_v_out_412122.awb"
	}
}
