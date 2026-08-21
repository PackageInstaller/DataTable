return {
	Play320311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320311001
		arg_1_1.duration_ = 6.88

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0502"

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
				local var_4_5 = arg_1_1.bgs_.ST0502

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
					if iter_4_0 ~= "ST0502" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.333333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech")

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

			local var_4_36 = 1.875
			local var_4_37 = 0.125

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(320311001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 5
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
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320311002
		arg_9_1.duration_ = 3.67

		local var_9_0 = {
			zh = 1.7,
			ja = 3.666
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
				arg_9_0:Play320311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1030].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(320311002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311002", "story_v_out_320311.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311002", "story_v_out_320311.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_320311", "320311002", "story_v_out_320311.awb")

						arg_9_1:RecordAudio("320311002", var_12_9)
						arg_9_1:RecordAudio("320311002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320311", "320311002", "story_v_out_320311.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320311", "320311002", "story_v_out_320311.awb")
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
	Play320311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.25

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(320311003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 50
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play320311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320311004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.15

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

				local var_20_2 = arg_17_1:GetWordFromCfg(320311004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 46
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
	Play320311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1

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

				local var_24_2 = arg_21_1:GetWordFromCfg(320311005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 40
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
	Play320311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320311006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.125

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(320311006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 5
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320311007
		arg_29_1.duration_ = 3.87

		local var_29_0 = {
			zh = 3.233,
			ja = 3.866
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
				arg_29_0:Play320311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.4

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1030].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(320311007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 16
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311007", "story_v_out_320311.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311007", "story_v_out_320311.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_320311", "320311007", "story_v_out_320311.awb")

						arg_29_1:RecordAudio("320311007", var_32_9)
						arg_29_1:RecordAudio("320311007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320311", "320311007", "story_v_out_320311.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320311", "320311007", "story_v_out_320311.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320311008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play320311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.55

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

				local var_36_2 = arg_33_1:GetWordFromCfg(320311008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 62
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
	Play320311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320311009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.3

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(320311009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 12
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320311010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.575

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(320311010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 63
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320311011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.875

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(320311011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 35
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320311012
		arg_49_1.duration_ = 4

		local var_49_0 = {
			zh = 2.233,
			ja = 4
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
				arg_49_0:Play320311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.3

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1030].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(320311012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 12
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311012", "story_v_out_320311.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311012", "story_v_out_320311.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_320311", "320311012", "story_v_out_320311.awb")

						arg_49_1:RecordAudio("320311012", var_52_9)
						arg_49_1:RecordAudio("320311012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320311", "320311012", "story_v_out_320311.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320311", "320311012", "story_v_out_320311.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320311013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.975

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(320311013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 39
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320311014
		arg_57_1.duration_ = 1.3

		local var_57_0 = {
			zh = 1.3,
			ja = 1.266
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
				arg_57_0:Play320311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.075

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1030].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(320311014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 3
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311014", "story_v_out_320311.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311014", "story_v_out_320311.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_320311", "320311014", "story_v_out_320311.awb")

						arg_57_1:RecordAudio("320311014", var_60_9)
						arg_57_1:RecordAudio("320311014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320311", "320311014", "story_v_out_320311.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320311", "320311014", "story_v_out_320311.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320311015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.575

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(320311015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 23
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320311016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.475

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(320311016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 19
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
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320311017
		arg_69_1.duration_ = 8.37

		local var_69_0 = {
			zh = 5.9,
			ja = 8.366
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
				arg_69_0:Play320311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.65

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1030].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(320311017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311017", "story_v_out_320311.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311017", "story_v_out_320311.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_320311", "320311017", "story_v_out_320311.awb")

						arg_69_1:RecordAudio("320311017", var_72_9)
						arg_69_1:RecordAudio("320311017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320311", "320311017", "story_v_out_320311.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320311", "320311017", "story_v_out_320311.awb")
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
	Play320311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320311018
		arg_73_1.duration_ = 9.1

		local var_73_0 = {
			zh = 6.9,
			ja = 9.1
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
				arg_73_0:Play320311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.75

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[1030].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(320311018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311018", "story_v_out_320311.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311018", "story_v_out_320311.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_320311", "320311018", "story_v_out_320311.awb")

						arg_73_1:RecordAudio("320311018", var_76_9)
						arg_73_1:RecordAudio("320311018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320311", "320311018", "story_v_out_320311.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320311", "320311018", "story_v_out_320311.awb")
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
	Play320311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320311019
		arg_77_1.duration_ = 4.5

		local var_77_0 = {
			zh = 2.433,
			ja = 4.5
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
				arg_77_0:Play320311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.275

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1030].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(320311019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 11
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311019", "story_v_out_320311.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311019", "story_v_out_320311.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_320311", "320311019", "story_v_out_320311.awb")

						arg_77_1:RecordAudio("320311019", var_80_9)
						arg_77_1:RecordAudio("320311019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320311", "320311019", "story_v_out_320311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320311", "320311019", "story_v_out_320311.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320311020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play320311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.5

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(320311020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 20
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
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320311021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320311021
		arg_85_1.duration_ = 1.8

		local var_85_0 = {
			zh = 1.8,
			ja = 1.233
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
				arg_85_0:Play320311022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(320311021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311021", "story_v_out_320311.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311021", "story_v_out_320311.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_320311", "320311021", "story_v_out_320311.awb")

						arg_85_1:RecordAudio("320311021", var_88_9)
						arg_85_1:RecordAudio("320311021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320311", "320311021", "story_v_out_320311.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320311", "320311021", "story_v_out_320311.awb")
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
	Play320311022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320311022
		arg_89_1.duration_ = 5.27

		local var_89_0 = {
			zh = 3.7,
			ja = 5.266
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
				arg_89_0:Play320311023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.475

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[36].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(320311022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 19
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311022", "story_v_out_320311.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311022", "story_v_out_320311.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_320311", "320311022", "story_v_out_320311.awb")

						arg_89_1:RecordAudio("320311022", var_92_9)
						arg_89_1:RecordAudio("320311022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320311", "320311022", "story_v_out_320311.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320311", "320311022", "story_v_out_320311.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play320311023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320311023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320311024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.2

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(320311023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 8
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320311024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320311024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320311025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.3

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(320311024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 52
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320311025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320311025
		arg_101_1.duration_ = 2.83

		local var_101_0 = {
			zh = 2.833,
			ja = 1.566
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
				arg_101_0:Play320311026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.325

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[1030].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(320311025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 13
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311025", "story_v_out_320311.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311025", "story_v_out_320311.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_320311", "320311025", "story_v_out_320311.awb")

						arg_101_1:RecordAudio("320311025", var_104_9)
						arg_101_1:RecordAudio("320311025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320311", "320311025", "story_v_out_320311.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320311", "320311025", "story_v_out_320311.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320311026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320311026
		arg_105_1.duration_ = 7.03

		local var_105_0 = {
			zh = 7.033,
			ja = 6.533
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
				arg_105_0:Play320311027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.85

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[1030].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(320311026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 34
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311026", "story_v_out_320311.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311026", "story_v_out_320311.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_320311", "320311026", "story_v_out_320311.awb")

						arg_105_1:RecordAudio("320311026", var_108_9)
						arg_105_1:RecordAudio("320311026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320311", "320311026", "story_v_out_320311.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320311", "320311026", "story_v_out_320311.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320311027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320311027
		arg_109_1.duration_ = 5.8

		local var_109_0 = {
			zh = 3.9,
			ja = 5.8
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
				arg_109_0:Play320311028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.425

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[1041].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320311027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 17
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311027", "story_v_out_320311.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311027", "story_v_out_320311.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320311", "320311027", "story_v_out_320311.awb")

						arg_109_1:RecordAudio("320311027", var_112_9)
						arg_109_1:RecordAudio("320311027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320311", "320311027", "story_v_out_320311.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320311", "320311027", "story_v_out_320311.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320311028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320311028
		arg_113_1.duration_ = 5.2

		local var_113_0 = {
			zh = 2.766,
			ja = 5.2
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320311029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.3

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[1041].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(320311028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 12
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311028", "story_v_out_320311.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311028", "story_v_out_320311.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_320311", "320311028", "story_v_out_320311.awb")

						arg_113_1:RecordAudio("320311028", var_116_9)
						arg_113_1:RecordAudio("320311028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320311", "320311028", "story_v_out_320311.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320311", "320311028", "story_v_out_320311.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320311029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320311029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play320311030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.575

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(320311029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 23
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play320311030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320311030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320311031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.65

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(320311030)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 66
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play320311031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320311031
		arg_125_1.duration_ = 6.9

		local var_125_0 = {
			zh = 6.9,
			ja = 3.6
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
				arg_125_0:Play320311032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.725

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[1030].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:GetWordFromCfg(320311031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 29
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311031", "story_v_out_320311.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311031", "story_v_out_320311.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_320311", "320311031", "story_v_out_320311.awb")

						arg_125_1:RecordAudio("320311031", var_128_9)
						arg_125_1:RecordAudio("320311031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320311", "320311031", "story_v_out_320311.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320311", "320311031", "story_v_out_320311.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320311032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320311032
		arg_129_1.duration_ = 5.47

		local var_129_0 = {
			zh = 5.466,
			ja = 4.766
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play320311033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.65

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[1041].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(320311032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 26
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311032", "story_v_out_320311.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311032", "story_v_out_320311.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_320311", "320311032", "story_v_out_320311.awb")

						arg_129_1:RecordAudio("320311032", var_132_9)
						arg_129_1:RecordAudio("320311032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320311", "320311032", "story_v_out_320311.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320311", "320311032", "story_v_out_320311.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320311033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320311033
		arg_133_1.duration_ = 14.67

		local var_133_0 = {
			zh = 12.466,
			ja = 14.666
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
				arg_133_0:Play320311034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.35

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1030].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(320311033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 54
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311033", "story_v_out_320311.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311033", "story_v_out_320311.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_320311", "320311033", "story_v_out_320311.awb")

						arg_133_1:RecordAudio("320311033", var_136_9)
						arg_133_1:RecordAudio("320311033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320311", "320311033", "story_v_out_320311.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320311", "320311033", "story_v_out_320311.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320311034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320311034
		arg_137_1.duration_ = 6.17

		local var_137_0 = {
			zh = 2.533,
			ja = 6.166
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320311035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.3

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1030].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(320311034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 12
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311034", "story_v_out_320311.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311034", "story_v_out_320311.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_320311", "320311034", "story_v_out_320311.awb")

						arg_137_1:RecordAudio("320311034", var_140_9)
						arg_137_1:RecordAudio("320311034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320311", "320311034", "story_v_out_320311.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320311", "320311034", "story_v_out_320311.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320311035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320311035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play320311036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.575

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(320311035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 23
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320311036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320311036
		arg_145_1.duration_ = 4.4

		local var_145_0 = {
			zh = 4.4,
			ja = 3.8
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
				arg_145_0:Play320311037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.425

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1041].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(320311036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 17
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311036", "story_v_out_320311.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311036", "story_v_out_320311.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_320311", "320311036", "story_v_out_320311.awb")

						arg_145_1:RecordAudio("320311036", var_148_9)
						arg_145_1:RecordAudio("320311036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320311", "320311036", "story_v_out_320311.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320311", "320311036", "story_v_out_320311.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320311037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320311037
		arg_149_1.duration_ = 6.3

		local var_149_0 = {
			zh = 5.2,
			ja = 6.3
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
				arg_149_0:Play320311038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.45

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[1030].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(320311037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 18
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311037", "story_v_out_320311.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311037", "story_v_out_320311.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_320311", "320311037", "story_v_out_320311.awb")

						arg_149_1:RecordAudio("320311037", var_152_9)
						arg_149_1:RecordAudio("320311037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320311", "320311037", "story_v_out_320311.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320311", "320311037", "story_v_out_320311.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320311038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320311038
		arg_153_1.duration_ = 7.13

		local var_153_0 = {
			zh = 4.666,
			ja = 7.133
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
				arg_153_0:Play320311039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.625

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1041].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(320311038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 25
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311038", "story_v_out_320311.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311038", "story_v_out_320311.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_320311", "320311038", "story_v_out_320311.awb")

						arg_153_1:RecordAudio("320311038", var_156_9)
						arg_153_1:RecordAudio("320311038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320311", "320311038", "story_v_out_320311.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320311", "320311038", "story_v_out_320311.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320311039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320311039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320311040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.9

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(320311039)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 36
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320311040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320311040
		arg_161_1.duration_ = 4.8

		local var_161_0 = {
			zh = 2.733,
			ja = 4.8
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
				arg_161_0:Play320311041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = "1284ui_story"

			if arg_161_1.actors_[var_164_0] == nil then
				local var_164_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_164_1) then
					local var_164_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_161_1.stage_.transform)

					var_164_2.name = var_164_0
					var_164_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_161_1.actors_[var_164_0] = var_164_2

					local var_164_3 = var_164_2:GetComponentInChildren(typeof(CharacterEffect))

					var_164_3.enabled = true

					local var_164_4 = GameObjectTools.GetOrAddComponent(var_164_2, typeof(DynamicBoneHelper))

					if var_164_4 then
						var_164_4:EnableDynamicBone(false)
					end

					arg_161_1:ShowWeapon(var_164_3.transform, false)

					arg_161_1.var_[var_164_0 .. "Animator"] = var_164_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_161_1.var_[var_164_0 .. "Animator"].applyRootMotion = true
					arg_161_1.var_[var_164_0 .. "LipSync"] = var_164_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_164_5 = arg_161_1.actors_["1284ui_story"].transform
			local var_164_6 = 0

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.var_.moveOldPos1284ui_story = var_164_5.localPosition

				local var_164_7 = "1284ui_story"

				arg_161_1:ShowWeapon(arg_161_1.var_[var_164_7 .. "Animator"].transform, false)
			end

			local var_164_8 = 0.001

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_8 then
				local var_164_9 = (arg_161_1.time_ - var_164_6) / var_164_8
				local var_164_10 = Vector3.New(0, -0.985, -6.22)

				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1284ui_story, var_164_10, var_164_9)

				local var_164_11 = manager.ui.mainCamera.transform.position - var_164_5.position

				var_164_5.forward = Vector3.New(var_164_11.x, var_164_11.y, var_164_11.z)

				local var_164_12 = var_164_5.localEulerAngles

				var_164_12.z = 0
				var_164_12.x = 0
				var_164_5.localEulerAngles = var_164_12
			end

			if arg_161_1.time_ >= var_164_6 + var_164_8 and arg_161_1.time_ < var_164_6 + var_164_8 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_164_13 = manager.ui.mainCamera.transform.position - var_164_5.position

				var_164_5.forward = Vector3.New(var_164_13.x, var_164_13.y, var_164_13.z)

				local var_164_14 = var_164_5.localEulerAngles

				var_164_14.z = 0
				var_164_14.x = 0
				var_164_5.localEulerAngles = var_164_14
			end

			local var_164_15 = arg_161_1.actors_["1284ui_story"]
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 and not isNil(var_164_15) and arg_161_1.var_.characterEffect1284ui_story == nil then
				arg_161_1.var_.characterEffect1284ui_story = var_164_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_17 = 0.200000002980232

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_17 and not isNil(var_164_15) then
				local var_164_18 = (arg_161_1.time_ - var_164_16) / var_164_17

				if arg_161_1.var_.characterEffect1284ui_story and not isNil(var_164_15) then
					arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 and not isNil(var_164_15) and arg_161_1.var_.characterEffect1284ui_story then
				arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_164_19 = 0

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 then
				arg_161_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_164_20 = 0

			if var_164_20 < arg_161_1.time_ and arg_161_1.time_ <= var_164_20 + arg_164_0 then
				arg_161_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_164_21 = 0
			local var_164_22 = 0.45

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_23 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_24 = arg_161_1:GetWordFromCfg(320311040)
				local var_164_25 = arg_161_1:FormatText(var_164_24.content)

				arg_161_1.text_.text = var_164_25

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 18
				local var_164_27 = utf8.len(var_164_25)
				local var_164_28 = var_164_26 <= 0 and var_164_22 or var_164_22 * (var_164_27 / var_164_26)

				if var_164_28 > 0 and var_164_22 < var_164_28 then
					arg_161_1.talkMaxDuration = var_164_28

					if var_164_28 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_28 + var_164_21
					end
				end

				arg_161_1.text_.text = var_164_25
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311040", "story_v_out_320311.awb") ~= 0 then
					local var_164_29 = manager.audio:GetVoiceLength("story_v_out_320311", "320311040", "story_v_out_320311.awb") / 1000

					if var_164_29 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_29 + var_164_21
					end

					if var_164_24.prefab_name ~= "" and arg_161_1.actors_[var_164_24.prefab_name] ~= nil then
						local var_164_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_24.prefab_name].transform, "story_v_out_320311", "320311040", "story_v_out_320311.awb")

						arg_161_1:RecordAudio("320311040", var_164_30)
						arg_161_1:RecordAudio("320311040", var_164_30)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320311", "320311040", "story_v_out_320311.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320311", "320311040", "story_v_out_320311.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_31 = math.max(var_164_22, arg_161_1.talkMaxDuration)

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_31 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_21) / var_164_31

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_21 + var_164_31 and arg_161_1.time_ < var_164_21 + var_164_31 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play320311041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320311041
		arg_165_1.duration_ = 9.4

		local var_165_0 = {
			zh = 9.39966666666667,
			ja = 8.53266666666667
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320311042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "L05j"

			if arg_165_1.bgs_[var_168_0] == nil then
				local var_168_1 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_168_0)
				var_168_1.name = var_168_0
				var_168_1.transform.parent = arg_165_1.stage_.transform
				var_168_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_[var_168_0] = var_168_1
			end

			local var_168_2 = 1.4

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				local var_168_3 = manager.ui.mainCamera.transform.localPosition
				local var_168_4 = Vector3.New(0, 0, 10) + Vector3.New(var_168_3.x, var_168_3.y, 0)
				local var_168_5 = arg_165_1.bgs_.L05j

				var_168_5.transform.localPosition = var_168_4
				var_168_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_6 = var_168_5:GetComponent("SpriteRenderer")

				if var_168_6 and var_168_6.sprite then
					local var_168_7 = (var_168_5.transform.localPosition - var_168_3).z
					local var_168_8 = manager.ui.mainCameraCom_
					local var_168_9 = 2 * var_168_7 * Mathf.Tan(var_168_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_168_10 = var_168_9 * var_168_8.aspect
					local var_168_11 = var_168_6.sprite.bounds.size.x
					local var_168_12 = var_168_6.sprite.bounds.size.y
					local var_168_13 = var_168_10 / var_168_11
					local var_168_14 = var_168_9 / var_168_12
					local var_168_15 = var_168_14 < var_168_13 and var_168_13 or var_168_14

					var_168_5.transform.localScale = Vector3.New(var_168_15, var_168_15, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "L05j" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_17 = 0.3

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_18 = 0

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_19 = 1.4

			if var_168_18 <= arg_165_1.time_ and arg_165_1.time_ < var_168_18 + var_168_19 then
				local var_168_20 = (arg_165_1.time_ - var_168_18) / var_168_19
				local var_168_21 = Color.New(0, 0, 0)

				var_168_21.a = Mathf.Lerp(0, 1, var_168_20)
				arg_165_1.mask_.color = var_168_21
			end

			if arg_165_1.time_ >= var_168_18 + var_168_19 and arg_165_1.time_ < var_168_18 + var_168_19 + arg_168_0 then
				local var_168_22 = Color.New(0, 0, 0)

				var_168_22.a = 1
				arg_165_1.mask_.color = var_168_22
			end

			local var_168_23 = 1.4

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_24 = 1.7

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 then
				local var_168_25 = (arg_165_1.time_ - var_168_23) / var_168_24
				local var_168_26 = Color.New(0, 0, 0)

				var_168_26.a = Mathf.Lerp(1, 0, var_168_25)
				arg_165_1.mask_.color = var_168_26
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 then
				local var_168_27 = Color.New(0, 0, 0)
				local var_168_28 = 0

				arg_165_1.mask_.enabled = false
				var_168_27.a = var_168_28
				arg_165_1.mask_.color = var_168_27
			end

			local var_168_29 = arg_165_1.actors_["1284ui_story"].transform
			local var_168_30 = 1.36666666666667

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.var_.moveOldPos1284ui_story = var_168_29.localPosition
			end

			local var_168_31 = 0.001

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_31 then
				local var_168_32 = (arg_165_1.time_ - var_168_30) / var_168_31
				local var_168_33 = Vector3.New(0, 100, 0)

				var_168_29.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1284ui_story, var_168_33, var_168_32)

				local var_168_34 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_34.x, var_168_34.y, var_168_34.z)

				local var_168_35 = var_168_29.localEulerAngles

				var_168_35.z = 0
				var_168_35.x = 0
				var_168_29.localEulerAngles = var_168_35
			end

			if arg_165_1.time_ >= var_168_30 + var_168_31 and arg_165_1.time_ < var_168_30 + var_168_31 + arg_168_0 then
				var_168_29.localPosition = Vector3.New(0, 100, 0)

				local var_168_36 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_36.x, var_168_36.y, var_168_36.z)

				local var_168_37 = var_168_29.localEulerAngles

				var_168_37.z = 0
				var_168_37.x = 0
				var_168_29.localEulerAngles = var_168_37
			end

			local var_168_38 = "1011ui_story"

			if arg_165_1.actors_[var_168_38] == nil then
				local var_168_39 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_168_39) then
					local var_168_40 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_165_1.stage_.transform)

					var_168_40.name = var_168_38
					var_168_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_165_1.actors_[var_168_38] = var_168_40

					local var_168_41 = var_168_40:GetComponentInChildren(typeof(CharacterEffect))

					var_168_41.enabled = true

					local var_168_42 = GameObjectTools.GetOrAddComponent(var_168_40, typeof(DynamicBoneHelper))

					if var_168_42 then
						var_168_42:EnableDynamicBone(false)
					end

					arg_165_1:ShowWeapon(var_168_41.transform, false)

					arg_165_1.var_[var_168_38 .. "Animator"] = var_168_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_165_1.var_[var_168_38 .. "Animator"].applyRootMotion = true
					arg_165_1.var_[var_168_38 .. "LipSync"] = var_168_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_168_43 = arg_165_1.actors_["1011ui_story"].transform
			local var_168_44 = 3

			if var_168_44 < arg_165_1.time_ and arg_165_1.time_ <= var_168_44 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = var_168_43.localPosition
			end

			local var_168_45 = 0.001

			if var_168_44 <= arg_165_1.time_ and arg_165_1.time_ < var_168_44 + var_168_45 then
				local var_168_46 = (arg_165_1.time_ - var_168_44) / var_168_45
				local var_168_47 = Vector3.New(0, -0.71, -6)

				var_168_43.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, var_168_47, var_168_46)

				local var_168_48 = manager.ui.mainCamera.transform.position - var_168_43.position

				var_168_43.forward = Vector3.New(var_168_48.x, var_168_48.y, var_168_48.z)

				local var_168_49 = var_168_43.localEulerAngles

				var_168_49.z = 0
				var_168_49.x = 0
				var_168_43.localEulerAngles = var_168_49
			end

			if arg_165_1.time_ >= var_168_44 + var_168_45 and arg_165_1.time_ < var_168_44 + var_168_45 + arg_168_0 then
				var_168_43.localPosition = Vector3.New(0, -0.71, -6)

				local var_168_50 = manager.ui.mainCamera.transform.position - var_168_43.position

				var_168_43.forward = Vector3.New(var_168_50.x, var_168_50.y, var_168_50.z)

				local var_168_51 = var_168_43.localEulerAngles

				var_168_51.z = 0
				var_168_51.x = 0
				var_168_43.localEulerAngles = var_168_51
			end

			local var_168_52 = arg_165_1.actors_["1011ui_story"]
			local var_168_53 = 3

			if var_168_53 < arg_165_1.time_ and arg_165_1.time_ <= var_168_53 + arg_168_0 and not isNil(var_168_52) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_54 = 0.200000002980232

			if var_168_53 <= arg_165_1.time_ and arg_165_1.time_ < var_168_53 + var_168_54 and not isNil(var_168_52) then
				local var_168_55 = (arg_165_1.time_ - var_168_53) / var_168_54

				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_52) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_53 + var_168_54 and arg_165_1.time_ < var_168_53 + var_168_54 + arg_168_0 and not isNil(var_168_52) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_168_56 = 3

			if var_168_56 < arg_165_1.time_ and arg_165_1.time_ <= var_168_56 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_168_57 = 3

			if var_168_57 < arg_165_1.time_ and arg_165_1.time_ <= var_168_57 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_58 = 3.16666666666667
			local var_168_59 = 0.775

			if var_168_58 < arg_165_1.time_ and arg_165_1.time_ <= var_168_58 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_60 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_60:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_61 = arg_165_1:FormatText(StoryNameCfg[37].name)

				arg_165_1.leftNameTxt_.text = var_168_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_62 = arg_165_1:GetWordFromCfg(320311041)
				local var_168_63 = arg_165_1:FormatText(var_168_62.content)

				arg_165_1.text_.text = var_168_63

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_64 = 31
				local var_168_65 = utf8.len(var_168_63)
				local var_168_66 = var_168_64 <= 0 and var_168_59 or var_168_59 * (var_168_65 / var_168_64)

				if var_168_66 > 0 and var_168_59 < var_168_66 then
					arg_165_1.talkMaxDuration = var_168_66
					var_168_58 = var_168_58 + 0.3

					if var_168_66 + var_168_58 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_66 + var_168_58
					end
				end

				arg_165_1.text_.text = var_168_63
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311041", "story_v_out_320311.awb") ~= 0 then
					local var_168_67 = manager.audio:GetVoiceLength("story_v_out_320311", "320311041", "story_v_out_320311.awb") / 1000

					if var_168_67 + var_168_58 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_67 + var_168_58
					end

					if var_168_62.prefab_name ~= "" and arg_165_1.actors_[var_168_62.prefab_name] ~= nil then
						local var_168_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_62.prefab_name].transform, "story_v_out_320311", "320311041", "story_v_out_320311.awb")

						arg_165_1:RecordAudio("320311041", var_168_68)
						arg_165_1:RecordAudio("320311041", var_168_68)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320311", "320311041", "story_v_out_320311.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320311", "320311041", "story_v_out_320311.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_69 = var_168_58 + 0.3
			local var_168_70 = math.max(var_168_59, arg_165_1.talkMaxDuration)

			if var_168_69 <= arg_165_1.time_ and arg_165_1.time_ < var_168_69 + var_168_70 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_69) / var_168_70

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_69 + var_168_70 and arg_165_1.time_ < var_168_69 + var_168_70 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play320311042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320311042
		arg_171_1.duration_ = 3

		local var_171_0 = {
			zh = 3,
			ja = 1.833
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
				arg_171_0:Play320311043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1011ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1011ui_story == nil then
				arg_171_1.var_.characterEffect1011ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1011ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1011ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1011ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1011ui_story.fillRatio = var_174_5
			end

			local var_174_6 = 0
			local var_174_7 = 0.25

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_8 = arg_171_1:FormatText(StoryNameCfg[67].name)

				arg_171_1.leftNameTxt_.text = var_174_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_9 = arg_171_1:GetWordFromCfg(320311042)
				local var_174_10 = arg_171_1:FormatText(var_174_9.content)

				arg_171_1.text_.text = var_174_10

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 10
				local var_174_12 = utf8.len(var_174_10)
				local var_174_13 = var_174_11 <= 0 and var_174_7 or var_174_7 * (var_174_12 / var_174_11)

				if var_174_13 > 0 and var_174_7 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_10
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311042", "story_v_out_320311.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311042", "story_v_out_320311.awb") / 1000

					if var_174_14 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_6
					end

					if var_174_9.prefab_name ~= "" and arg_171_1.actors_[var_174_9.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_9.prefab_name].transform, "story_v_out_320311", "320311042", "story_v_out_320311.awb")

						arg_171_1:RecordAudio("320311042", var_174_15)
						arg_171_1:RecordAudio("320311042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_320311", "320311042", "story_v_out_320311.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_320311", "320311042", "story_v_out_320311.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_16 and arg_171_1.time_ < var_174_6 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play320311043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320311043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play320311044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1011ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1011ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1011ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = 0
			local var_178_10 = 1.5

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_11 = arg_175_1:GetWordFromCfg(320311043)
				local var_178_12 = arg_175_1:FormatText(var_178_11.content)

				arg_175_1.text_.text = var_178_12

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 60
				local var_178_14 = utf8.len(var_178_12)
				local var_178_15 = var_178_13 <= 0 and var_178_10 or var_178_10 * (var_178_14 / var_178_13)

				if var_178_15 > 0 and var_178_10 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_9
					end
				end

				arg_175_1.text_.text = var_178_12
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_10, arg_175_1.talkMaxDuration)

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_9) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_9 + var_178_16 and arg_175_1.time_ < var_178_9 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play320311044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320311044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play320311045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.65

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(320311044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 26
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play320311045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320311045
		arg_183_1.duration_ = 4.73

		local var_183_0 = {
			zh = 4.266,
			ja = 4.733
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
				arg_183_0:Play320311046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1011ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1011ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.71, -6)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1011ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1011ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1011ui_story == nil then
				arg_183_1.var_.characterEffect1011ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1011ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1011ui_story then
				arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action468")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_186_15 = 0
			local var_186_16 = 0.375

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[37].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(320311045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 15
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311045", "story_v_out_320311.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_320311", "320311045", "story_v_out_320311.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_320311", "320311045", "story_v_out_320311.awb")

						arg_183_1:RecordAudio("320311045", var_186_24)
						arg_183_1:RecordAudio("320311045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320311", "320311045", "story_v_out_320311.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320311", "320311045", "story_v_out_320311.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play320311046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320311046
		arg_187_1.duration_ = 6.3

		local var_187_0 = {
			zh = 3.7,
			ja = 6.3
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
				arg_187_0:Play320311047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1011ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1011ui_story == nil then
				arg_187_1.var_.characterEffect1011ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1011ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1011ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1011ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1011ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.45

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[67].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(320311046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 18
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311046", "story_v_out_320311.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311046", "story_v_out_320311.awb") / 1000

					if var_190_14 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_6
					end

					if var_190_9.prefab_name ~= "" and arg_187_1.actors_[var_190_9.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_9.prefab_name].transform, "story_v_out_320311", "320311046", "story_v_out_320311.awb")

						arg_187_1:RecordAudio("320311046", var_190_15)
						arg_187_1:RecordAudio("320311046", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_320311", "320311046", "story_v_out_320311.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_320311", "320311046", "story_v_out_320311.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_16 and arg_187_1.time_ < var_190_6 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play320311047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320311047
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play320311048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_194_1 = arg_191_1.actors_["1011ui_story"]
			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1011ui_story == nil then
				arg_191_1.var_.characterEffect1011ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_3 = 0.200000002980232

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_3 and not isNil(var_194_1) then
				local var_194_4 = (arg_191_1.time_ - var_194_2) / var_194_3

				if arg_191_1.var_.characterEffect1011ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_2 + var_194_3 and arg_191_1.time_ < var_194_2 + var_194_3 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1011ui_story then
				arg_191_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_194_5 = 0
			local var_194_6 = 0.05

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[37].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(320311047)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 2
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311047", "story_v_out_320311.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_320311", "320311047", "story_v_out_320311.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_320311", "320311047", "story_v_out_320311.awb")

						arg_191_1:RecordAudio("320311047", var_194_14)
						arg_191_1:RecordAudio("320311047", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320311", "320311047", "story_v_out_320311.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320311", "320311047", "story_v_out_320311.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play320311048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320311048
		arg_195_1.duration_ = 5.73

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play320311049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1011ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1011ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1011ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = manager.ui.mainCamera.transform
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1.var_.shakeOldPos = var_198_9.localPosition
			end

			local var_198_11 = 0.5

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / 0.066
				local var_198_13, var_198_14 = math.modf(var_198_12)

				var_198_9.localPosition = Vector3.New(var_198_14 * 0.13, var_198_14 * 0.13, var_198_14 * 0.13) + arg_195_1.var_.shakeOldPos
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 then
				var_198_9.localPosition = arg_195_1.var_.shakeOldPos
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_15 = 0.733333333333333
			local var_198_16 = 1.05

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_17 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_17:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(320311048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 42
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22
					var_198_15 = var_198_15 + 0.3

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_23 = var_198_15 + 0.3
			local var_198_24 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_23 <= arg_195_1.time_ and arg_195_1.time_ < var_198_23 + var_198_24 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_23) / var_198_24

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_23 + var_198_24 and arg_195_1.time_ < var_198_23 + var_198_24 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play320311049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320311049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play320311050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.333333333333333
			local var_204_1 = 0.691666666666667

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_2 = "play"
				local var_204_3 = "effect"

				arg_201_1:AudioAction(var_204_2, var_204_3, "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			local var_204_4 = 0
			local var_204_5 = 1.025

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(320311049)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_8 = 41
				local var_204_9 = utf8.len(var_204_7)
				local var_204_10 = var_204_8 <= 0 and var_204_5 or var_204_5 * (var_204_9 / var_204_8)

				if var_204_10 > 0 and var_204_5 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_11 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_11 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_11

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_11 and arg_201_1.time_ < var_204_4 + var_204_11 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play320311050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320311050
		arg_205_1.duration_ = 2.9

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play320311051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = "1111ui_story"

			if arg_205_1.actors_[var_208_0] == nil then
				local var_208_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_208_1) then
					local var_208_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_205_1.stage_.transform)

					var_208_2.name = var_208_0
					var_208_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_205_1.actors_[var_208_0] = var_208_2

					local var_208_3 = var_208_2:GetComponentInChildren(typeof(CharacterEffect))

					var_208_3.enabled = true

					local var_208_4 = GameObjectTools.GetOrAddComponent(var_208_2, typeof(DynamicBoneHelper))

					if var_208_4 then
						var_208_4:EnableDynamicBone(false)
					end

					arg_205_1:ShowWeapon(var_208_3.transform, false)

					arg_205_1.var_[var_208_0 .. "Animator"] = var_208_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_205_1.var_[var_208_0 .. "Animator"].applyRootMotion = true
					arg_205_1.var_[var_208_0 .. "LipSync"] = var_208_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_208_5 = arg_205_1.actors_["1111ui_story"].transform
			local var_208_6 = 0

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.var_.moveOldPos1111ui_story = var_208_5.localPosition
			end

			local var_208_7 = 0.001

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_7 then
				local var_208_8 = (arg_205_1.time_ - var_208_6) / var_208_7
				local var_208_9 = Vector3.New(0, -0.87, -5.7)

				var_208_5.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1111ui_story, var_208_9, var_208_8)

				local var_208_10 = manager.ui.mainCamera.transform.position - var_208_5.position

				var_208_5.forward = Vector3.New(var_208_10.x, var_208_10.y, var_208_10.z)

				local var_208_11 = var_208_5.localEulerAngles

				var_208_11.z = 0
				var_208_11.x = 0
				var_208_5.localEulerAngles = var_208_11
			end

			if arg_205_1.time_ >= var_208_6 + var_208_7 and arg_205_1.time_ < var_208_6 + var_208_7 + arg_208_0 then
				var_208_5.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_208_12 = manager.ui.mainCamera.transform.position - var_208_5.position

				var_208_5.forward = Vector3.New(var_208_12.x, var_208_12.y, var_208_12.z)

				local var_208_13 = var_208_5.localEulerAngles

				var_208_13.z = 0
				var_208_13.x = 0
				var_208_5.localEulerAngles = var_208_13
			end

			local var_208_14 = arg_205_1.actors_["1111ui_story"]
			local var_208_15 = 0

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.characterEffect1111ui_story == nil then
				arg_205_1.var_.characterEffect1111ui_story = var_208_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_16 = 0.200000002980232

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_16 and not isNil(var_208_14) then
				local var_208_17 = (arg_205_1.time_ - var_208_15) / var_208_16

				if arg_205_1.var_.characterEffect1111ui_story and not isNil(var_208_14) then
					arg_205_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_15 + var_208_16 and arg_205_1.time_ < var_208_15 + var_208_16 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.characterEffect1111ui_story then
				arg_205_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_208_18 = 0

			if var_208_18 < arg_205_1.time_ and arg_205_1.time_ <= var_208_18 + arg_208_0 then
				arg_205_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 then
				arg_205_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_208_20 = 0
			local var_208_21 = 0.1

			if var_208_20 < arg_205_1.time_ and arg_205_1.time_ <= var_208_20 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_22 = arg_205_1:FormatText(StoryNameCfg[67].name)

				arg_205_1.leftNameTxt_.text = var_208_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_23 = arg_205_1:GetWordFromCfg(320311050)
				local var_208_24 = arg_205_1:FormatText(var_208_23.content)

				arg_205_1.text_.text = var_208_24

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_25 = 4
				local var_208_26 = utf8.len(var_208_24)
				local var_208_27 = var_208_25 <= 0 and var_208_21 or var_208_21 * (var_208_26 / var_208_25)

				if var_208_27 > 0 and var_208_21 < var_208_27 then
					arg_205_1.talkMaxDuration = var_208_27

					if var_208_27 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_27 + var_208_20
					end
				end

				arg_205_1.text_.text = var_208_24
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311050", "story_v_out_320311.awb") ~= 0 then
					local var_208_28 = manager.audio:GetVoiceLength("story_v_out_320311", "320311050", "story_v_out_320311.awb") / 1000

					if var_208_28 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_28 + var_208_20
					end

					if var_208_23.prefab_name ~= "" and arg_205_1.actors_[var_208_23.prefab_name] ~= nil then
						local var_208_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_23.prefab_name].transform, "story_v_out_320311", "320311050", "story_v_out_320311.awb")

						arg_205_1:RecordAudio("320311050", var_208_29)
						arg_205_1:RecordAudio("320311050", var_208_29)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320311", "320311050", "story_v_out_320311.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320311", "320311050", "story_v_out_320311.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_30 = math.max(var_208_21, arg_205_1.talkMaxDuration)

			if var_208_20 <= arg_205_1.time_ and arg_205_1.time_ < var_208_20 + var_208_30 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_20) / var_208_30

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_20 + var_208_30 and arg_205_1.time_ < var_208_20 + var_208_30 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play320311051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320311051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play320311052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1111ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1111ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1111ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = 0
			local var_212_10 = 1.075

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:GetWordFromCfg(320311051)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 43
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_10 or var_212_10 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_10 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_9 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_9
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_10, arg_209_1.talkMaxDuration)

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_9) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_9 + var_212_16 and arg_209_1.time_ < var_212_9 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play320311052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320311052
		arg_213_1.duration_ = 5.6

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play320311053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_1 = 0.433333333333333

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_1 then
				local var_216_2 = (arg_213_1.time_ - var_216_0) / var_216_1
				local var_216_3 = Color.New(1, 1, 1)

				var_216_3.a = Mathf.Lerp(1, 0, var_216_2)
				arg_213_1.mask_.color = var_216_3
			end

			if arg_213_1.time_ >= var_216_0 + var_216_1 and arg_213_1.time_ < var_216_0 + var_216_1 + arg_216_0 then
				local var_216_4 = Color.New(1, 1, 1)
				local var_216_5 = 0

				arg_213_1.mask_.enabled = false
				var_216_4.a = var_216_5
				arg_213_1.mask_.color = var_216_4
			end

			local var_216_6 = 0.125
			local var_216_7 = 1

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				local var_216_8 = "play"
				local var_216_9 = "effect"

				arg_213_1:AudioAction(var_216_8, var_216_9, "se_story_120_00", "se_story_120_00_sword02", "")
			end

			local var_216_10 = 0.77
			local var_216_11 = 1

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				local var_216_12 = "play"
				local var_216_13 = "effect"

				arg_213_1:AudioAction(var_216_12, var_216_13, "se_story_3", "se_story_3_shoot", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_14 = 0.6
			local var_216_15 = 1.7

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_16 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_16:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_17 = arg_213_1:GetWordFromCfg(320311052)
				local var_216_18 = arg_213_1:FormatText(var_216_17.content)

				arg_213_1.text_.text = var_216_18

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 68
				local var_216_20 = utf8.len(var_216_18)
				local var_216_21 = var_216_19 <= 0 and var_216_15 or var_216_15 * (var_216_20 / var_216_19)

				if var_216_21 > 0 and var_216_15 < var_216_21 then
					arg_213_1.talkMaxDuration = var_216_21
					var_216_14 = var_216_14 + 0.3

					if var_216_21 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_21 + var_216_14
					end
				end

				arg_213_1.text_.text = var_216_18
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = var_216_14 + 0.3
			local var_216_23 = math.max(var_216_15, arg_213_1.talkMaxDuration)

			if var_216_22 <= arg_213_1.time_ and arg_213_1.time_ < var_216_22 + var_216_23 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_22) / var_216_23

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_22 + var_216_23 and arg_213_1.time_ < var_216_22 + var_216_23 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320311053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320311053
		arg_219_1.duration_ = 1.53

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play320311054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.125

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[37].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(320311053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 5
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311053", "story_v_out_320311.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311053", "story_v_out_320311.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_320311", "320311053", "story_v_out_320311.awb")

						arg_219_1:RecordAudio("320311053", var_222_9)
						arg_219_1:RecordAudio("320311053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320311", "320311053", "story_v_out_320311.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320311", "320311053", "story_v_out_320311.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play320311054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320311054
		arg_223_1.duration_ = 1.2

		local var_223_0 = {
			zh = 0.999999999999,
			ja = 1.2
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play320311055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.125

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[67].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(320311054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 5
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311054", "story_v_out_320311.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311054", "story_v_out_320311.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_320311", "320311054", "story_v_out_320311.awb")

						arg_223_1:RecordAudio("320311054", var_226_9)
						arg_223_1:RecordAudio("320311054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_320311", "320311054", "story_v_out_320311.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_320311", "320311054", "story_v_out_320311.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play320311055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 320311055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play320311056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 1.175

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(320311055)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 47
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play320311056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 320311056
		arg_231_1.duration_ = 3.6

		local var_231_0 = {
			zh = 3.6,
			ja = 3.233
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play320311057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.25

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[67].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(320311056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 10
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311056", "story_v_out_320311.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311056", "story_v_out_320311.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_320311", "320311056", "story_v_out_320311.awb")

						arg_231_1:RecordAudio("320311056", var_234_9)
						arg_231_1:RecordAudio("320311056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_320311", "320311056", "story_v_out_320311.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_320311", "320311056", "story_v_out_320311.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play320311057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 320311057
		arg_235_1.duration_ = 2.57

		local var_235_0 = {
			zh = 1.8,
			ja = 2.566
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play320311058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1111ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1111ui_story == nil then
				arg_235_1.var_.characterEffect1111ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1111ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1111ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1111ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1111ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.25

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[37].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_9 = arg_235_1:GetWordFromCfg(320311057)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 10
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311057", "story_v_out_320311.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311057", "story_v_out_320311.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_320311", "320311057", "story_v_out_320311.awb")

						arg_235_1:RecordAudio("320311057", var_238_15)
						arg_235_1:RecordAudio("320311057", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_320311", "320311057", "story_v_out_320311.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_320311", "320311057", "story_v_out_320311.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play320311058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 320311058
		arg_239_1.duration_ = 4.23

		local var_239_0 = {
			zh = 2.2,
			ja = 4.233
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play320311059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.3

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[67].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(320311058)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 12
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311058", "story_v_out_320311.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311058", "story_v_out_320311.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_320311", "320311058", "story_v_out_320311.awb")

						arg_239_1:RecordAudio("320311058", var_242_9)
						arg_239_1:RecordAudio("320311058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_320311", "320311058", "story_v_out_320311.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_320311", "320311058", "story_v_out_320311.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play320311059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 320311059
		arg_243_1.duration_ = 7.8

		local var_243_0 = {
			zh = 5.9,
			ja = 7.8
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play320311060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.425

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[1049].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(320311059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 17
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311059", "story_v_out_320311.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311059", "story_v_out_320311.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_320311", "320311059", "story_v_out_320311.awb")

						arg_243_1:RecordAudio("320311059", var_246_9)
						arg_243_1:RecordAudio("320311059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_320311", "320311059", "story_v_out_320311.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_320311", "320311059", "story_v_out_320311.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play320311060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 320311060
		arg_247_1.duration_ = 5.97

		local var_247_0 = {
			zh = 5.966,
			ja = 4.933
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play320311061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1111ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1111ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -0.87, -5.7)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1111ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1111ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1111ui_story == nil then
				arg_247_1.var_.characterEffect1111ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1111ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1111ui_story then
				arg_247_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.725

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[67].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(320311060)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 29
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311060", "story_v_out_320311.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_320311", "320311060", "story_v_out_320311.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_320311", "320311060", "story_v_out_320311.awb")

						arg_247_1:RecordAudio("320311060", var_250_24)
						arg_247_1:RecordAudio("320311060", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_320311", "320311060", "story_v_out_320311.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_320311", "320311060", "story_v_out_320311.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play320311061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 320311061
		arg_251_1.duration_ = 7.1

		local var_251_0 = {
			zh = 7.1,
			ja = 6.1
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play320311062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1111ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1111ui_story == nil then
				arg_251_1.var_.characterEffect1111ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1111ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1111ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1111ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1111ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.575

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[1049].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(320311061)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 23
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311061", "story_v_out_320311.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311061", "story_v_out_320311.awb") / 1000

					if var_254_14 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_6
					end

					if var_254_9.prefab_name ~= "" and arg_251_1.actors_[var_254_9.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_9.prefab_name].transform, "story_v_out_320311", "320311061", "story_v_out_320311.awb")

						arg_251_1:RecordAudio("320311061", var_254_15)
						arg_251_1:RecordAudio("320311061", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_320311", "320311061", "story_v_out_320311.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_320311", "320311061", "story_v_out_320311.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_16 and arg_251_1.time_ < var_254_6 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play320311062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 320311062
		arg_255_1.duration_ = 8.8

		local var_255_0 = {
			zh = 6.533,
			ja = 8.8
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play320311063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.45

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1049].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(320311062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 18
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311062", "story_v_out_320311.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311062", "story_v_out_320311.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_320311", "320311062", "story_v_out_320311.awb")

						arg_255_1:RecordAudio("320311062", var_258_9)
						arg_255_1:RecordAudio("320311062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_320311", "320311062", "story_v_out_320311.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_320311", "320311062", "story_v_out_320311.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play320311063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 320311063
		arg_259_1.duration_ = 3.73

		local var_259_0 = {
			zh = 3.733,
			ja = 3.2
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play320311064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1111ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1111ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, -0.87, -5.7)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1111ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1111ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1111ui_story == nil then
				arg_259_1.var_.characterEffect1111ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect1111ui_story and not isNil(var_262_9) then
					arg_259_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1111ui_story then
				arg_259_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_262_13 = 0

			if var_262_13 < arg_259_1.time_ and arg_259_1.time_ <= var_262_13 + arg_262_0 then
				arg_259_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_262_14 = 0
			local var_262_15 = 0.35

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_16 = arg_259_1:FormatText(StoryNameCfg[67].name)

				arg_259_1.leftNameTxt_.text = var_262_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_17 = arg_259_1:GetWordFromCfg(320311063)
				local var_262_18 = arg_259_1:FormatText(var_262_17.content)

				arg_259_1.text_.text = var_262_18

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_19 = 14
				local var_262_20 = utf8.len(var_262_18)
				local var_262_21 = var_262_19 <= 0 and var_262_15 or var_262_15 * (var_262_20 / var_262_19)

				if var_262_21 > 0 and var_262_15 < var_262_21 then
					arg_259_1.talkMaxDuration = var_262_21

					if var_262_21 + var_262_14 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_21 + var_262_14
					end
				end

				arg_259_1.text_.text = var_262_18
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311063", "story_v_out_320311.awb") ~= 0 then
					local var_262_22 = manager.audio:GetVoiceLength("story_v_out_320311", "320311063", "story_v_out_320311.awb") / 1000

					if var_262_22 + var_262_14 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_14
					end

					if var_262_17.prefab_name ~= "" and arg_259_1.actors_[var_262_17.prefab_name] ~= nil then
						local var_262_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_17.prefab_name].transform, "story_v_out_320311", "320311063", "story_v_out_320311.awb")

						arg_259_1:RecordAudio("320311063", var_262_23)
						arg_259_1:RecordAudio("320311063", var_262_23)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_320311", "320311063", "story_v_out_320311.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_320311", "320311063", "story_v_out_320311.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_24 = math.max(var_262_15, arg_259_1.talkMaxDuration)

			if var_262_14 <= arg_259_1.time_ and arg_259_1.time_ < var_262_14 + var_262_24 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_14) / var_262_24

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_14 + var_262_24 and arg_259_1.time_ < var_262_14 + var_262_24 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play320311064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 320311064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play320311065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1111ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1111ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, 100, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1111ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, 100, 0)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1111ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1111ui_story == nil then
				arg_263_1.var_.characterEffect1111ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1111ui_story and not isNil(var_266_9) then
					local var_266_13 = Mathf.Lerp(0, 0.5, var_266_12)

					arg_263_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1111ui_story.fillRatio = var_266_13
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1111ui_story then
				local var_266_14 = 0.5

				arg_263_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1111ui_story.fillRatio = var_266_14
			end

			local var_266_15 = 0
			local var_266_16 = 1.15

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_17 = arg_263_1:GetWordFromCfg(320311064)
				local var_266_18 = arg_263_1:FormatText(var_266_17.content)

				arg_263_1.text_.text = var_266_18

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_19 = 46
				local var_266_20 = utf8.len(var_266_18)
				local var_266_21 = var_266_19 <= 0 and var_266_16 or var_266_16 * (var_266_20 / var_266_19)

				if var_266_21 > 0 and var_266_16 < var_266_21 then
					arg_263_1.talkMaxDuration = var_266_21

					if var_266_21 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_21 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_18
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_22 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_22 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_22

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_22 and arg_263_1.time_ < var_266_15 + var_266_22 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play320311065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 320311065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play320311066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.45

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(320311065)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 58
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play320311066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 320311066
		arg_271_1.duration_ = 7.67

		local var_271_0 = {
			zh = 3.433,
			ja = 7.666
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play320311067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1111ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1111ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(0, -0.87, -5.7)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1111ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["1111ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1111ui_story == nil then
				arg_271_1.var_.characterEffect1111ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 and not isNil(var_274_9) then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect1111ui_story and not isNil(var_274_9) then
					arg_271_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1111ui_story then
				arg_271_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_274_13 = 0

			if var_274_13 < arg_271_1.time_ and arg_271_1.time_ <= var_274_13 + arg_274_0 then
				arg_271_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				arg_271_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_274_15 = 0
			local var_274_16 = 0.3

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[67].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(320311066)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 12
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311066", "story_v_out_320311.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_320311", "320311066", "story_v_out_320311.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_320311", "320311066", "story_v_out_320311.awb")

						arg_271_1:RecordAudio("320311066", var_274_24)
						arg_271_1:RecordAudio("320311066", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_320311", "320311066", "story_v_out_320311.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_320311", "320311066", "story_v_out_320311.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play320311067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 320311067
		arg_275_1.duration_ = 6.2

		local var_275_0 = {
			zh = 6.2,
			ja = 5.4
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play320311068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1111ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1111ui_story == nil then
				arg_275_1.var_.characterEffect1111ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1111ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1111ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1111ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1111ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.525

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[1049].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(320311067)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 21
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311067", "story_v_out_320311.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311067", "story_v_out_320311.awb") / 1000

					if var_278_14 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_6
					end

					if var_278_9.prefab_name ~= "" and arg_275_1.actors_[var_278_9.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_9.prefab_name].transform, "story_v_out_320311", "320311067", "story_v_out_320311.awb")

						arg_275_1:RecordAudio("320311067", var_278_15)
						arg_275_1:RecordAudio("320311067", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_320311", "320311067", "story_v_out_320311.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_320311", "320311067", "story_v_out_320311.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_16 and arg_275_1.time_ < var_278_6 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play320311068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 320311068
		arg_279_1.duration_ = 9.2

		local var_279_0 = {
			zh = 9.2,
			ja = 7.433
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play320311069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1111ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1111ui_story == nil then
				arg_279_1.var_.characterEffect1111ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1111ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1111ui_story then
				arg_279_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_282_4 = 0

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_282_6 = 0
			local var_282_7 = 0.925

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[67].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_9 = arg_279_1:GetWordFromCfg(320311068)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 37
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311068", "story_v_out_320311.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311068", "story_v_out_320311.awb") / 1000

					if var_282_14 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_6
					end

					if var_282_9.prefab_name ~= "" and arg_279_1.actors_[var_282_9.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_9.prefab_name].transform, "story_v_out_320311", "320311068", "story_v_out_320311.awb")

						arg_279_1:RecordAudio("320311068", var_282_15)
						arg_279_1:RecordAudio("320311068", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_320311", "320311068", "story_v_out_320311.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_320311", "320311068", "story_v_out_320311.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_16 and arg_279_1.time_ < var_282_6 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play320311069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 320311069
		arg_283_1.duration_ = 7.13

		local var_283_0 = {
			zh = 7.133,
			ja = 4.433
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play320311070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1111ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1111ui_story == nil then
				arg_283_1.var_.characterEffect1111ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1111ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1111ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1111ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1111ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 0.55

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[1049].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_9 = arg_283_1:GetWordFromCfg(320311069)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 22
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311069", "story_v_out_320311.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_320311", "320311069", "story_v_out_320311.awb") / 1000

					if var_286_14 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_6
					end

					if var_286_9.prefab_name ~= "" and arg_283_1.actors_[var_286_9.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_9.prefab_name].transform, "story_v_out_320311", "320311069", "story_v_out_320311.awb")

						arg_283_1:RecordAudio("320311069", var_286_15)
						arg_283_1:RecordAudio("320311069", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_320311", "320311069", "story_v_out_320311.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_320311", "320311069", "story_v_out_320311.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_16 and arg_283_1.time_ < var_286_6 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play320311070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320311070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play320311071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1111ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1111ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, 100, 0)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1111ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, 100, 0)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1111ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1111ui_story == nil then
				arg_287_1.var_.characterEffect1111ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1111ui_story and not isNil(var_290_9) then
					local var_290_13 = Mathf.Lerp(0, 0.5, var_290_12)

					arg_287_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1111ui_story.fillRatio = var_290_13
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1111ui_story then
				local var_290_14 = 0.5

				arg_287_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1111ui_story.fillRatio = var_290_14
			end

			local var_290_15 = 0
			local var_290_16 = 0.975

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_17 = arg_287_1:GetWordFromCfg(320311070)
				local var_290_18 = arg_287_1:FormatText(var_290_17.content)

				arg_287_1.text_.text = var_290_18

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_19 = 39
				local var_290_20 = utf8.len(var_290_18)
				local var_290_21 = var_290_19 <= 0 and var_290_16 or var_290_16 * (var_290_20 / var_290_19)

				if var_290_21 > 0 and var_290_16 < var_290_21 then
					arg_287_1.talkMaxDuration = var_290_21

					if var_290_21 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_21 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_18
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_22 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_22

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_22 and arg_287_1.time_ < var_290_15 + var_290_22 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play320311071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320311071
		arg_291_1.duration_ = 7.6

		local var_291_0 = {
			zh = 7.6,
			ja = 3.666
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play320311072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.475

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[1049].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(320311071)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 19
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311071", "story_v_out_320311.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311071", "story_v_out_320311.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_320311", "320311071", "story_v_out_320311.awb")

						arg_291_1:RecordAudio("320311071", var_294_9)
						arg_291_1:RecordAudio("320311071", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_320311", "320311071", "story_v_out_320311.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_320311", "320311071", "story_v_out_320311.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play320311072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320311072
		arg_295_1.duration_ = 5.4

		local var_295_0 = {
			zh = 5.4,
			ja = 4.433
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play320311073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1111ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1111ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, -0.87, -5.7)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1111ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1111ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1111ui_story == nil then
				arg_295_1.var_.characterEffect1111ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1111ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1111ui_story then
				arg_295_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_298_13 = 0

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_298_14 = 0

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_298_15 = 0
			local var_298_16 = 0.35

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_17 = arg_295_1:FormatText(StoryNameCfg[67].name)

				arg_295_1.leftNameTxt_.text = var_298_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:GetWordFromCfg(320311072)
				local var_298_19 = arg_295_1:FormatText(var_298_18.content)

				arg_295_1.text_.text = var_298_19

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 14
				local var_298_21 = utf8.len(var_298_19)
				local var_298_22 = var_298_20 <= 0 and var_298_16 or var_298_16 * (var_298_21 / var_298_20)

				if var_298_22 > 0 and var_298_16 < var_298_22 then
					arg_295_1.talkMaxDuration = var_298_22

					if var_298_22 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_22 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_19
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311072", "story_v_out_320311.awb") ~= 0 then
					local var_298_23 = manager.audio:GetVoiceLength("story_v_out_320311", "320311072", "story_v_out_320311.awb") / 1000

					if var_298_23 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_15
					end

					if var_298_18.prefab_name ~= "" and arg_295_1.actors_[var_298_18.prefab_name] ~= nil then
						local var_298_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_18.prefab_name].transform, "story_v_out_320311", "320311072", "story_v_out_320311.awb")

						arg_295_1:RecordAudio("320311072", var_298_24)
						arg_295_1:RecordAudio("320311072", var_298_24)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320311", "320311072", "story_v_out_320311.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320311", "320311072", "story_v_out_320311.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_25 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_25 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_25

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_25 and arg_295_1.time_ < var_298_15 + var_298_25 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play320311073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320311073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play320311074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1111ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1111ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(0, 100, 0)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1111ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, 100, 0)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1111ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1111ui_story == nil then
				arg_299_1.var_.characterEffect1111ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1111ui_story and not isNil(var_302_9) then
					local var_302_13 = Mathf.Lerp(0, 0.5, var_302_12)

					arg_299_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1111ui_story.fillRatio = var_302_13
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1111ui_story then
				local var_302_14 = 0.5

				arg_299_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1111ui_story.fillRatio = var_302_14
			end

			local var_302_15 = 0
			local var_302_16 = 1.125

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_17 = arg_299_1:GetWordFromCfg(320311073)
				local var_302_18 = arg_299_1:FormatText(var_302_17.content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_19 = 45
				local var_302_20 = utf8.len(var_302_18)
				local var_302_21 = var_302_19 <= 0 and var_302_16 or var_302_16 * (var_302_20 / var_302_19)

				if var_302_21 > 0 and var_302_16 < var_302_21 then
					arg_299_1.talkMaxDuration = var_302_21

					if var_302_21 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_21 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_22 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_22 and arg_299_1.time_ < var_302_15 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play320311074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320311074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320311075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.333333333333333
			local var_306_1 = 1

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				local var_306_2 = "play"
				local var_306_3 = "effect"

				arg_303_1:AudioAction(var_306_2, var_306_3, "se_story_1210", "se_story_1210_cut", "")
			end

			local var_306_4 = 0
			local var_306_5 = 1.4

			if var_306_4 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(320311074)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_8 = 56
				local var_306_9 = utf8.len(var_306_7)
				local var_306_10 = var_306_8 <= 0 and var_306_5 or var_306_5 * (var_306_9 / var_306_8)

				if var_306_10 > 0 and var_306_5 < var_306_10 then
					arg_303_1.talkMaxDuration = var_306_10

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_11 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_11 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_11

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_11 and arg_303_1.time_ < var_306_4 + var_306_11 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play320311075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320311075
		arg_307_1.duration_ = 6.3

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320311076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = manager.ui.mainCamera.transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.shakeOldPos = var_310_0.localPosition
			end

			local var_310_2 = 0.633333333333333

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / 0.066
				local var_310_4, var_310_5 = math.modf(var_310_3)

				var_310_0.localPosition = Vector3.New(var_310_5 * 0.13, var_310_5 * 0.13, var_310_5 * 0.13) + arg_307_1.var_.shakeOldPos
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = arg_307_1.var_.shakeOldPos
			end

			local var_310_6 = 0.433333333333333

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_7 = 0.366666666666667

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_7 then
				local var_310_8 = (arg_307_1.time_ - var_310_6) / var_310_7
				local var_310_9 = Color.New(0.05660379, 0.05660379, 0.05660379)

				var_310_9.a = Mathf.Lerp(1, 0, var_310_8)
				arg_307_1.mask_.color = var_310_9
			end

			if arg_307_1.time_ >= var_310_6 + var_310_7 and arg_307_1.time_ < var_310_6 + var_310_7 + arg_310_0 then
				local var_310_10 = Color.New(0.05660379, 0.05660379, 0.05660379)
				local var_310_11 = 0

				arg_307_1.mask_.enabled = false
				var_310_10.a = var_310_11
				arg_307_1.mask_.color = var_310_10
			end

			local var_310_12 = manager.ui.mainCamera.transform
			local var_310_13 = 0.433333333333333

			if var_310_13 < arg_307_1.time_ and arg_307_1.time_ <= var_310_13 + arg_310_0 then
				local var_310_14 = arg_307_1.var_.effect909
				local var_310_15
				local var_310_16 = var_310_12

				if not var_310_14 then
					var_310_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_310_16)
					var_310_14.name = "909"
					arg_307_1.var_.effect909 = var_310_14
				else
					var_310_14.transform:SetParent(var_310_16)
				end

				var_310_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_310_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_310_17 = manager.ui.mainCamera.transform
			local var_310_18 = 2.23333333333333

			if var_310_18 < arg_307_1.time_ and arg_307_1.time_ <= var_310_18 + arg_310_0 then
				local var_310_19 = arg_307_1.var_.effect909

				if var_310_19 then
					Object.Destroy(var_310_19)

					arg_307_1.var_.effect909 = nil
				end
			end

			local var_310_20 = 0
			local var_310_21 = 1

			if var_310_20 < arg_307_1.time_ and arg_307_1.time_ <= var_310_20 + arg_310_0 then
				local var_310_22 = "play"
				local var_310_23 = "effect"

				arg_307_1:AudioAction(var_310_22, var_310_23, "se_story_120_00", "se_story_120_00_mountainbreak", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_24 = 1.3
			local var_310_25 = 2.075

			if var_310_24 < arg_307_1.time_ and arg_307_1.time_ <= var_310_24 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_26 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_26:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_27 = arg_307_1:GetWordFromCfg(320311075)
				local var_310_28 = arg_307_1:FormatText(var_310_27.content)

				arg_307_1.text_.text = var_310_28

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_29 = 83
				local var_310_30 = utf8.len(var_310_28)
				local var_310_31 = var_310_29 <= 0 and var_310_25 or var_310_25 * (var_310_30 / var_310_29)

				if var_310_31 > 0 and var_310_25 < var_310_31 then
					arg_307_1.talkMaxDuration = var_310_31
					var_310_24 = var_310_24 + 0.3

					if var_310_31 + var_310_24 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_31 + var_310_24
					end
				end

				arg_307_1.text_.text = var_310_28
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_32 = var_310_24 + 0.3
			local var_310_33 = math.max(var_310_25, arg_307_1.talkMaxDuration)

			if var_310_32 <= arg_307_1.time_ and arg_307_1.time_ < var_310_32 + var_310_33 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_32) / var_310_33

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_32 + var_310_33 and arg_307_1.time_ < var_310_32 + var_310_33 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320311076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320311076
		arg_313_1.duration_ = 2.03

		local var_313_0 = {
			zh = 1.933,
			ja = 2.033
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play320311077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.075

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[67].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(320311076)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 3
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311076", "story_v_out_320311.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311076", "story_v_out_320311.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_320311", "320311076", "story_v_out_320311.awb")

						arg_313_1:RecordAudio("320311076", var_316_9)
						arg_313_1:RecordAudio("320311076", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_320311", "320311076", "story_v_out_320311.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_320311", "320311076", "story_v_out_320311.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320311077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320311077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320311078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.3

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(320311077)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 52
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320311078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320311078
		arg_321_1.duration_ = 5

		local var_321_0 = {
			zh = 3.566,
			ja = 5
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play320311079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.325

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[67].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(320311078)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 13
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311078", "story_v_out_320311.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311078", "story_v_out_320311.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_320311", "320311078", "story_v_out_320311.awb")

						arg_321_1:RecordAudio("320311078", var_324_9)
						arg_321_1:RecordAudio("320311078", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_320311", "320311078", "story_v_out_320311.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_320311", "320311078", "story_v_out_320311.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play320311079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320311079
		arg_325_1.duration_ = 3.3

		local var_325_0 = {
			zh = 3.3,
			ja = 3.033
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320311080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.325

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[37].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(320311079)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 13
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311079", "story_v_out_320311.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311079", "story_v_out_320311.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_320311", "320311079", "story_v_out_320311.awb")

						arg_325_1:RecordAudio("320311079", var_328_9)
						arg_325_1:RecordAudio("320311079", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320311", "320311079", "story_v_out_320311.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320311", "320311079", "story_v_out_320311.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play320311080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320311080
		arg_329_1.duration_ = 7.9

		local var_329_0 = {
			zh = 5.733,
			ja = 7.9
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320311081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.75

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[67].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(320311080)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 30
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311080", "story_v_out_320311.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311080", "story_v_out_320311.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_out_320311", "320311080", "story_v_out_320311.awb")

						arg_329_1:RecordAudio("320311080", var_332_9)
						arg_329_1:RecordAudio("320311080", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_320311", "320311080", "story_v_out_320311.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_320311", "320311080", "story_v_out_320311.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_10 and arg_329_1.time_ < var_332_0 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play320311081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320311081
		arg_333_1.duration_ = 3.97

		local var_333_0 = {
			zh = 3.966,
			ja = 3.466
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320311082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.5

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[67].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(320311081)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 20
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311081", "story_v_out_320311.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311081", "story_v_out_320311.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_320311", "320311081", "story_v_out_320311.awb")

						arg_333_1:RecordAudio("320311081", var_336_9)
						arg_333_1:RecordAudio("320311081", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320311", "320311081", "story_v_out_320311.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320311", "320311081", "story_v_out_320311.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_10 and arg_333_1.time_ < var_336_0 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play320311082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320311082
		arg_337_1.duration_ = 4.37

		local var_337_0 = {
			zh = 3.566,
			ja = 4.366
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play320311083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.35

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[37].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(320311082)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 14
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311082", "story_v_out_320311.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311082", "story_v_out_320311.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_320311", "320311082", "story_v_out_320311.awb")

						arg_337_1:RecordAudio("320311082", var_340_9)
						arg_337_1:RecordAudio("320311082", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_320311", "320311082", "story_v_out_320311.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_320311", "320311082", "story_v_out_320311.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play320311083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320311083
		arg_341_1.duration_ = 2

		local var_341_0 = {
			zh = 2,
			ja = 1.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320311084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.2

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[67].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:GetWordFromCfg(320311083)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 8
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311083", "story_v_out_320311.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311083", "story_v_out_320311.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_320311", "320311083", "story_v_out_320311.awb")

						arg_341_1:RecordAudio("320311083", var_344_9)
						arg_341_1:RecordAudio("320311083", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_320311", "320311083", "story_v_out_320311.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_320311", "320311083", "story_v_out_320311.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320311084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 320311084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play320311085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.333333333333333
			local var_348_1 = 1

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				local var_348_2 = "play"
				local var_348_3 = "effect"

				arg_345_1:AudioAction(var_348_2, var_348_3, "se_story_121_00", "se_story_121_00_spear01", "")
			end

			local var_348_4 = 0
			local var_348_5 = 1.875

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(320311084)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_8 = 75
				local var_348_9 = utf8.len(var_348_7)
				local var_348_10 = var_348_8 <= 0 and var_348_5 or var_348_5 * (var_348_9 / var_348_8)

				if var_348_10 > 0 and var_348_5 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_11 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_11 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_11

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_11 and arg_345_1.time_ < var_348_4 + var_348_11 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play320311085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 320311085
		arg_349_1.duration_ = 3.37

		local var_349_0 = {
			zh = 2.766,
			ja = 3.366
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play320311086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = "STwhite"

			if arg_349_1.bgs_[var_352_0] == nil then
				local var_352_1 = Object.Instantiate(arg_349_1.paintGo_)

				var_352_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_352_0)
				var_352_1.name = var_352_0
				var_352_1.transform.parent = arg_349_1.stage_.transform
				var_352_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.bgs_[var_352_0] = var_352_1
			end

			local var_352_2 = 0

			if var_352_2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				local var_352_3 = manager.ui.mainCamera.transform.localPosition
				local var_352_4 = Vector3.New(0, 0, 10) + Vector3.New(var_352_3.x, var_352_3.y, 0)
				local var_352_5 = arg_349_1.bgs_.STwhite

				var_352_5.transform.localPosition = var_352_4
				var_352_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_6 = var_352_5:GetComponent("SpriteRenderer")

				if var_352_6 and var_352_6.sprite then
					local var_352_7 = (var_352_5.transform.localPosition - var_352_3).z
					local var_352_8 = manager.ui.mainCameraCom_
					local var_352_9 = 2 * var_352_7 * Mathf.Tan(var_352_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_352_10 = var_352_9 * var_352_8.aspect
					local var_352_11 = var_352_6.sprite.bounds.size.x
					local var_352_12 = var_352_6.sprite.bounds.size.y
					local var_352_13 = var_352_10 / var_352_11
					local var_352_14 = var_352_9 / var_352_12
					local var_352_15 = var_352_14 < var_352_13 and var_352_13 or var_352_14

					var_352_5.transform.localScale = Vector3.New(var_352_15, var_352_15, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "STwhite" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_352_16 = 0

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.allBtn_.enabled = false
			end

			local var_352_17 = 0.3

			if arg_349_1.time_ >= var_352_16 + var_352_17 and arg_349_1.time_ < var_352_16 + var_352_17 + arg_352_0 then
				arg_349_1.allBtn_.enabled = true
			end

			local var_352_18 = 0

			if var_352_18 < arg_349_1.time_ and arg_349_1.time_ <= var_352_18 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_19 = 2

			if var_352_18 <= arg_349_1.time_ and arg_349_1.time_ < var_352_18 + var_352_19 then
				local var_352_20 = (arg_349_1.time_ - var_352_18) / var_352_19
				local var_352_21 = Color.New(0, 0, 0)

				var_352_21.a = Mathf.Lerp(1, 0, var_352_20)
				arg_349_1.mask_.color = var_352_21
			end

			if arg_349_1.time_ >= var_352_18 + var_352_19 and arg_349_1.time_ < var_352_18 + var_352_19 + arg_352_0 then
				local var_352_22 = Color.New(0, 0, 0)
				local var_352_23 = 0

				arg_349_1.mask_.enabled = false
				var_352_22.a = var_352_23
				arg_349_1.mask_.color = var_352_22
			end

			if arg_349_1.frameCnt_ <= 1 then
				arg_349_1.dialog_:SetActive(false)
			end

			local var_352_24 = 2
			local var_352_25 = 0.05

			if var_352_24 < arg_349_1.time_ and arg_349_1.time_ <= var_352_24 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_26 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_26:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_27 = arg_349_1:FormatText(StoryNameCfg[1049].name)

				arg_349_1.leftNameTxt_.text = var_352_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_28 = arg_349_1:GetWordFromCfg(320311085)
				local var_352_29 = arg_349_1:FormatText(var_352_28.content)

				arg_349_1.text_.text = var_352_29

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_30 = 2
				local var_352_31 = utf8.len(var_352_29)
				local var_352_32 = var_352_30 <= 0 and var_352_25 or var_352_25 * (var_352_31 / var_352_30)

				if var_352_32 > 0 and var_352_25 < var_352_32 then
					arg_349_1.talkMaxDuration = var_352_32
					var_352_24 = var_352_24 + 0.3

					if var_352_32 + var_352_24 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_32 + var_352_24
					end
				end

				arg_349_1.text_.text = var_352_29
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311085", "story_v_out_320311.awb") ~= 0 then
					local var_352_33 = manager.audio:GetVoiceLength("story_v_out_320311", "320311085", "story_v_out_320311.awb") / 1000

					if var_352_33 + var_352_24 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_33 + var_352_24
					end

					if var_352_28.prefab_name ~= "" and arg_349_1.actors_[var_352_28.prefab_name] ~= nil then
						local var_352_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_28.prefab_name].transform, "story_v_out_320311", "320311085", "story_v_out_320311.awb")

						arg_349_1:RecordAudio("320311085", var_352_34)
						arg_349_1:RecordAudio("320311085", var_352_34)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_320311", "320311085", "story_v_out_320311.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_320311", "320311085", "story_v_out_320311.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_35 = var_352_24 + 0.3
			local var_352_36 = math.max(var_352_25, arg_349_1.talkMaxDuration)

			if var_352_35 <= arg_349_1.time_ and arg_349_1.time_ < var_352_35 + var_352_36 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_35) / var_352_36

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_35 + var_352_36 and arg_349_1.time_ < var_352_35 + var_352_36 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play320311086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320311086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320311087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.333333333333333
			local var_358_1 = 1

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				local var_358_2 = "play"
				local var_358_3 = "effect"

				arg_355_1:AudioAction(var_358_2, var_358_3, "se_story_137", "se_story_137_break", "")
			end

			local var_358_4 = 0
			local var_358_5 = 1

			if var_358_4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				local var_358_6 = "stop"
				local var_358_7 = "effect"

				arg_355_1:AudioAction(var_358_6, var_358_7, "se_story_121_00", "se_story_121_00_spear01", "")
			end

			local var_358_8 = 0
			local var_358_9 = 1.175

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(320311086)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_12 = 47
				local var_358_13 = utf8.len(var_358_11)
				local var_358_14 = var_358_12 <= 0 and var_358_9 or var_358_9 * (var_358_13 / var_358_12)

				if var_358_14 > 0 and var_358_9 < var_358_14 then
					arg_355_1.talkMaxDuration = var_358_14

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_15 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_15 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_15

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_15 and arg_355_1.time_ < var_358_8 + var_358_15 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play320311087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320311087
		arg_359_1.duration_ = 1.43

		local var_359_0 = {
			zh = 1.433,
			ja = 1.2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play320311088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.15

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[37].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:GetWordFromCfg(320311087)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 6
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311087", "story_v_out_320311.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311087", "story_v_out_320311.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_320311", "320311087", "story_v_out_320311.awb")

						arg_359_1:RecordAudio("320311087", var_362_9)
						arg_359_1:RecordAudio("320311087", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_320311", "320311087", "story_v_out_320311.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_320311", "320311087", "story_v_out_320311.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play320311088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 320311088
		arg_363_1.duration_ = 10.4

		local var_363_0 = {
			zh = 7.6,
			ja = 10.4
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play320311089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.925

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[67].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(320311088)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 37
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311088", "story_v_out_320311.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311088", "story_v_out_320311.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_320311", "320311088", "story_v_out_320311.awb")

						arg_363_1:RecordAudio("320311088", var_366_9)
						arg_363_1:RecordAudio("320311088", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_320311", "320311088", "story_v_out_320311.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_320311", "320311088", "story_v_out_320311.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play320311089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 320311089
		arg_367_1.duration_ = 3.93

		local var_367_0 = {
			zh = 3.933,
			ja = 2.1
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play320311090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.275

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[37].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(320311089)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 11
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311089", "story_v_out_320311.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311089", "story_v_out_320311.awb") / 1000

					if var_370_8 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_0
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_320311", "320311089", "story_v_out_320311.awb")

						arg_367_1:RecordAudio("320311089", var_370_9)
						arg_367_1:RecordAudio("320311089", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_320311", "320311089", "story_v_out_320311.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_320311", "320311089", "story_v_out_320311.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_10 and arg_367_1.time_ < var_370_0 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play320311090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 320311090
		arg_371_1.duration_ = 7.73

		local var_371_0 = {
			zh = 7.633,
			ja = 7.733
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play320311091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.875

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[67].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(320311090)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 35
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311090", "story_v_out_320311.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311090", "story_v_out_320311.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_320311", "320311090", "story_v_out_320311.awb")

						arg_371_1:RecordAudio("320311090", var_374_9)
						arg_371_1:RecordAudio("320311090", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_320311", "320311090", "story_v_out_320311.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_320311", "320311090", "story_v_out_320311.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_10 and arg_371_1.time_ < var_374_0 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play320311091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 320311091
		arg_375_1.duration_ = 11.13

		local var_375_0 = {
			zh = 11.133,
			ja = 9.7
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play320311092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 1.35

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[67].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(320311091)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 54
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311091", "story_v_out_320311.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311091", "story_v_out_320311.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_320311", "320311091", "story_v_out_320311.awb")

						arg_375_1:RecordAudio("320311091", var_378_9)
						arg_375_1:RecordAudio("320311091", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_320311", "320311091", "story_v_out_320311.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_320311", "320311091", "story_v_out_320311.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_10 and arg_375_1.time_ < var_378_0 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play320311092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 320311092
		arg_379_1.duration_ = 9.2

		local var_379_0 = {
			zh = 7.8,
			ja = 9.2
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play320311093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.9

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[67].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(320311092)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 37
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311092", "story_v_out_320311.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311092", "story_v_out_320311.awb") / 1000

					if var_382_8 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_0
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_320311", "320311092", "story_v_out_320311.awb")

						arg_379_1:RecordAudio("320311092", var_382_9)
						arg_379_1:RecordAudio("320311092", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_320311", "320311092", "story_v_out_320311.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_320311", "320311092", "story_v_out_320311.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_10 and arg_379_1.time_ < var_382_0 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play320311093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 320311093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play320311094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 1.35

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_2 = arg_383_1:GetWordFromCfg(320311093)
				local var_386_3 = arg_383_1:FormatText(var_386_2.content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 54
				local var_386_5 = utf8.len(var_386_3)
				local var_386_6 = var_386_4 <= 0 and var_386_1 or var_386_1 * (var_386_5 / var_386_4)

				if var_386_6 > 0 and var_386_1 < var_386_6 then
					arg_383_1.talkMaxDuration = var_386_6

					if var_386_6 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_6 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_7 and arg_383_1.time_ < var_386_0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play320311094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 320311094
		arg_387_1.duration_ = 8.93

		local var_387_0 = {
			zh = 8.933,
			ja = 5.366
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play320311095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.95

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[67].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(320311094)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 38
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311094", "story_v_out_320311.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311094", "story_v_out_320311.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_320311", "320311094", "story_v_out_320311.awb")

						arg_387_1:RecordAudio("320311094", var_390_9)
						arg_387_1:RecordAudio("320311094", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_320311", "320311094", "story_v_out_320311.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_320311", "320311094", "story_v_out_320311.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play320311095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 320311095
		arg_391_1.duration_ = 4.8

		local var_391_0 = {
			zh = 2.3,
			ja = 4.8
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play320311096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.35

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[67].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(320311095)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 14
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311095", "story_v_out_320311.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311095", "story_v_out_320311.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_320311", "320311095", "story_v_out_320311.awb")

						arg_391_1:RecordAudio("320311095", var_394_9)
						arg_391_1:RecordAudio("320311095", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_320311", "320311095", "story_v_out_320311.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_320311", "320311095", "story_v_out_320311.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play320311096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 320311096
		arg_395_1.duration_ = 5.7

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play320311097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = manager.ui.mainCamera.transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				local var_398_2 = arg_395_1.var_.effect111
				local var_398_3
				local var_398_4 = var_398_0

				if not var_398_2 then
					var_398_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_398_4)
					var_398_2.name = "111"
					arg_395_1.var_.effect111 = var_398_2
				else
					var_398_2.transform:SetParent(var_398_4)
				end

				var_398_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_5 = 0.533333333333333
			local var_398_6 = 1

			if var_398_5 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				local var_398_7 = "play"
				local var_398_8 = "effect"

				arg_395_1:AudioAction(var_398_7, var_398_8, "se_story_16", "se_story_16_archery", "")
			end

			local var_398_9 = 0.333333333333333
			local var_398_10 = 1

			if var_398_9 < arg_395_1.time_ and arg_395_1.time_ <= var_398_9 + arg_398_0 then
				local var_398_11 = "play"
				local var_398_12 = "effect"

				arg_395_1:AudioAction(var_398_11, var_398_12, "se_story_16", "se_story_16_hit", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_13 = 0.7
			local var_398_14 = 1.4

			if var_398_13 < arg_395_1.time_ and arg_395_1.time_ <= var_398_13 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_15 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_15:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_16 = arg_395_1:GetWordFromCfg(320311096)
				local var_398_17 = arg_395_1:FormatText(var_398_16.content)

				arg_395_1.text_.text = var_398_17

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_18 = 56
				local var_398_19 = utf8.len(var_398_17)
				local var_398_20 = var_398_18 <= 0 and var_398_14 or var_398_14 * (var_398_19 / var_398_18)

				if var_398_20 > 0 and var_398_14 < var_398_20 then
					arg_395_1.talkMaxDuration = var_398_20
					var_398_13 = var_398_13 + 0.3

					if var_398_20 + var_398_13 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_20 + var_398_13
					end
				end

				arg_395_1.text_.text = var_398_17
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_21 = var_398_13 + 0.3
			local var_398_22 = math.max(var_398_14, arg_395_1.talkMaxDuration)

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_22 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_21) / var_398_22

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_21 + var_398_22 and arg_395_1.time_ < var_398_21 + var_398_22 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play320311097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320311097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320311098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.3

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(320311097)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 52
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320311098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320311098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320311099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.333333333333333
			local var_408_1 = 1

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				local var_408_2 = "play"
				local var_408_3 = "effect"

				arg_405_1:AudioAction(var_408_2, var_408_3, "se_story_6", "se_story_6_black_fog", "")
			end

			local var_408_4 = 0
			local var_408_5 = 1.175

			if var_408_4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(320311098)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_8 = 47
				local var_408_9 = utf8.len(var_408_7)
				local var_408_10 = var_408_8 <= 0 and var_408_5 or var_408_5 * (var_408_9 / var_408_8)

				if var_408_10 > 0 and var_408_5 < var_408_10 then
					arg_405_1.talkMaxDuration = var_408_10

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_11 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_11 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_11

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_11 and arg_405_1.time_ < var_408_4 + var_408_11 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320311099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320311099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320311100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 1.35

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_2 = arg_409_1:GetWordFromCfg(320311099)
				local var_412_3 = arg_409_1:FormatText(var_412_2.content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 54
				local var_412_5 = utf8.len(var_412_3)
				local var_412_6 = var_412_4 <= 0 and var_412_1 or var_412_1 * (var_412_5 / var_412_4)

				if var_412_6 > 0 and var_412_1 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_7 and arg_409_1.time_ < var_412_0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play320311100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 320311100
		arg_413_1.duration_ = 9.2

		local var_413_0 = {
			zh = 9.19966666666667,
			ja = 7.83266666666667
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play320311101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = "XS0204a"

			if arg_413_1.bgs_[var_416_0] == nil then
				local var_416_1 = Object.Instantiate(arg_413_1.paintGo_)

				var_416_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_416_0)
				var_416_1.name = var_416_0
				var_416_1.transform.parent = arg_413_1.stage_.transform
				var_416_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.bgs_[var_416_0] = var_416_1
			end

			local var_416_2 = 1

			if var_416_2 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				local var_416_3 = manager.ui.mainCamera.transform.localPosition
				local var_416_4 = Vector3.New(0, 0, 10) + Vector3.New(var_416_3.x, var_416_3.y, 0)
				local var_416_5 = arg_413_1.bgs_.XS0204a

				var_416_5.transform.localPosition = var_416_4
				var_416_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_6 = var_416_5:GetComponent("SpriteRenderer")

				if var_416_6 and var_416_6.sprite then
					local var_416_7 = (var_416_5.transform.localPosition - var_416_3).z
					local var_416_8 = manager.ui.mainCameraCom_
					local var_416_9 = 2 * var_416_7 * Mathf.Tan(var_416_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_416_10 = var_416_9 * var_416_8.aspect
					local var_416_11 = var_416_6.sprite.bounds.size.x
					local var_416_12 = var_416_6.sprite.bounds.size.y
					local var_416_13 = var_416_10 / var_416_11
					local var_416_14 = var_416_9 / var_416_12
					local var_416_15 = var_416_14 < var_416_13 and var_416_13 or var_416_14

					var_416_5.transform.localScale = Vector3.New(var_416_15, var_416_15, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "XS0204a" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_16 = 2.76666666666667

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			local var_416_17 = 0.3

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_18 = 0

			if var_416_18 < arg_413_1.time_ and arg_413_1.time_ <= var_416_18 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_19 = 1

			if var_416_18 <= arg_413_1.time_ and arg_413_1.time_ < var_416_18 + var_416_19 then
				local var_416_20 = (arg_413_1.time_ - var_416_18) / var_416_19
				local var_416_21 = Color.New(0, 0, 0)

				var_416_21.a = Mathf.Lerp(0, 1, var_416_20)
				arg_413_1.mask_.color = var_416_21
			end

			if arg_413_1.time_ >= var_416_18 + var_416_19 and arg_413_1.time_ < var_416_18 + var_416_19 + arg_416_0 then
				local var_416_22 = Color.New(0, 0, 0)

				var_416_22.a = 1
				arg_413_1.mask_.color = var_416_22
			end

			local var_416_23 = 1

			if var_416_23 < arg_413_1.time_ and arg_413_1.time_ <= var_416_23 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_24 = 2

			if var_416_23 <= arg_413_1.time_ and arg_413_1.time_ < var_416_23 + var_416_24 then
				local var_416_25 = (arg_413_1.time_ - var_416_23) / var_416_24
				local var_416_26 = Color.New(0, 0, 0)

				var_416_26.a = Mathf.Lerp(1, 0, var_416_25)
				arg_413_1.mask_.color = var_416_26
			end

			if arg_413_1.time_ >= var_416_23 + var_416_24 and arg_413_1.time_ < var_416_23 + var_416_24 + arg_416_0 then
				local var_416_27 = Color.New(0, 0, 0)
				local var_416_28 = 0

				arg_413_1.mask_.enabled = false
				var_416_27.a = var_416_28
				arg_413_1.mask_.color = var_416_27
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_29 = 2.76666666666667
			local var_416_30 = 0.425

			if var_416_29 < arg_413_1.time_ and arg_413_1.time_ <= var_416_29 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_31 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_31:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_32 = arg_413_1:FormatText(StoryNameCfg[1049].name)

				arg_413_1.leftNameTxt_.text = var_416_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_33 = arg_413_1:GetWordFromCfg(320311100)
				local var_416_34 = arg_413_1:FormatText(var_416_33.content)

				arg_413_1.text_.text = var_416_34

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_35 = 17
				local var_416_36 = utf8.len(var_416_34)
				local var_416_37 = var_416_35 <= 0 and var_416_30 or var_416_30 * (var_416_36 / var_416_35)

				if var_416_37 > 0 and var_416_30 < var_416_37 then
					arg_413_1.talkMaxDuration = var_416_37
					var_416_29 = var_416_29 + 0.3

					if var_416_37 + var_416_29 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_37 + var_416_29
					end
				end

				arg_413_1.text_.text = var_416_34
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311100", "story_v_out_320311.awb") ~= 0 then
					local var_416_38 = manager.audio:GetVoiceLength("story_v_out_320311", "320311100", "story_v_out_320311.awb") / 1000

					if var_416_38 + var_416_29 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_38 + var_416_29
					end

					if var_416_33.prefab_name ~= "" and arg_413_1.actors_[var_416_33.prefab_name] ~= nil then
						local var_416_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_33.prefab_name].transform, "story_v_out_320311", "320311100", "story_v_out_320311.awb")

						arg_413_1:RecordAudio("320311100", var_416_39)
						arg_413_1:RecordAudio("320311100", var_416_39)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_320311", "320311100", "story_v_out_320311.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_320311", "320311100", "story_v_out_320311.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_40 = var_416_29 + 0.3
			local var_416_41 = math.max(var_416_30, arg_413_1.talkMaxDuration)

			if var_416_40 <= arg_413_1.time_ and arg_413_1.time_ < var_416_40 + var_416_41 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_40) / var_416_41

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_40 + var_416_41 and arg_413_1.time_ < var_416_40 + var_416_41 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play320311101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 320311101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play320311102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.875

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(320311101)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 35
				local var_422_5 = utf8.len(var_422_3)
				local var_422_6 = var_422_4 <= 0 and var_422_1 or var_422_1 * (var_422_5 / var_422_4)

				if var_422_6 > 0 and var_422_1 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_7 and arg_419_1.time_ < var_422_0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play320311102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 320311102
		arg_423_1.duration_ = 7.5

		local var_423_0 = {
			zh = 6.566,
			ja = 7.5
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play320311103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.375

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[1049].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(320311102)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 15
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311102", "story_v_out_320311.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311102", "story_v_out_320311.awb") / 1000

					if var_426_8 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_0
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_320311", "320311102", "story_v_out_320311.awb")

						arg_423_1:RecordAudio("320311102", var_426_9)
						arg_423_1:RecordAudio("320311102", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_320311", "320311102", "story_v_out_320311.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_320311", "320311102", "story_v_out_320311.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_10 and arg_423_1.time_ < var_426_0 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play320311103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 320311103
		arg_427_1.duration_ = 5.8

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play320311104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = manager.ui.mainCamera.transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				local var_430_2 = arg_427_1.var_.effect155
				local var_430_3
				local var_430_4 = var_430_0

				if not var_430_2 then
					var_430_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), var_430_4)
					var_430_2.name = "155"
					arg_427_1.var_.effect155 = var_430_2
				else
					var_430_2.transform:SetParent(var_430_4)
				end

				var_430_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_430_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_430_5 = manager.ui.mainCamera.transform
			local var_430_6 = 0.8

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				local var_430_7 = arg_427_1.var_.effect155

				if var_430_7 then
					Object.Destroy(var_430_7)

					arg_427_1.var_.effect155 = nil
				end
			end

			if arg_427_1.frameCnt_ <= 1 then
				arg_427_1.dialog_:SetActive(false)
			end

			local var_430_8 = 0.8
			local var_430_9 = 1.95

			if var_430_8 < arg_427_1.time_ and arg_427_1.time_ <= var_430_8 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				arg_427_1.dialog_:SetActive(true)

				arg_427_1.dialogCg_.alpha = 0

				local var_430_10 = LeanTween.value(arg_427_1.dialog_, 0, 1, 0.3)

				var_430_10:setOnUpdate(LuaHelper.FloatAction(function(arg_431_0)
					arg_427_1.dialogCg_.alpha = arg_431_0
				end))
				var_430_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_427_1.dialog_)
					var_430_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_427_1.duration_ = arg_427_1.duration_ + 0.3

				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_11 = arg_427_1:GetWordFromCfg(320311103)
				local var_430_12 = arg_427_1:FormatText(var_430_11.content)

				arg_427_1.text_.text = var_430_12

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_13 = 78
				local var_430_14 = utf8.len(var_430_12)
				local var_430_15 = var_430_13 <= 0 and var_430_9 or var_430_9 * (var_430_14 / var_430_13)

				if var_430_15 > 0 and var_430_9 < var_430_15 then
					arg_427_1.talkMaxDuration = var_430_15
					var_430_8 = var_430_8 + 0.3

					if var_430_15 + var_430_8 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_15 + var_430_8
					end
				end

				arg_427_1.text_.text = var_430_12
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = var_430_8 + 0.3
			local var_430_17 = math.max(var_430_9, arg_427_1.talkMaxDuration)

			if var_430_16 <= arg_427_1.time_ and arg_427_1.time_ < var_430_16 + var_430_17 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_16) / var_430_17

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_16 + var_430_17 and arg_427_1.time_ < var_430_16 + var_430_17 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play320311104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 320311104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play320311105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 1.45

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_2 = arg_433_1:GetWordFromCfg(320311104)
				local var_436_3 = arg_433_1:FormatText(var_436_2.content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 58
				local var_436_5 = utf8.len(var_436_3)
				local var_436_6 = var_436_4 <= 0 and var_436_1 or var_436_1 * (var_436_5 / var_436_4)

				if var_436_6 > 0 and var_436_1 < var_436_6 then
					arg_433_1.talkMaxDuration = var_436_6

					if var_436_6 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_6 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_7 and arg_433_1.time_ < var_436_0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play320311105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 320311105
		arg_437_1.duration_ = 8

		local var_437_0 = {
			zh = 7.83266666666667,
			ja = 7.99966666666667
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play320311106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = "XS0204"

			if arg_437_1.bgs_[var_440_0] == nil then
				local var_440_1 = Object.Instantiate(arg_437_1.paintGo_)

				var_440_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_440_0)
				var_440_1.name = var_440_0
				var_440_1.transform.parent = arg_437_1.stage_.transform
				var_440_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_437_1.bgs_[var_440_0] = var_440_1
			end

			local var_440_2 = 0.883333333333333

			if var_440_2 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				local var_440_3 = manager.ui.mainCamera.transform.localPosition
				local var_440_4 = Vector3.New(0, 0, 10) + Vector3.New(var_440_3.x, var_440_3.y, 0)
				local var_440_5 = arg_437_1.bgs_.XS0204

				var_440_5.transform.localPosition = var_440_4
				var_440_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_440_6 = var_440_5:GetComponent("SpriteRenderer")

				if var_440_6 and var_440_6.sprite then
					local var_440_7 = (var_440_5.transform.localPosition - var_440_3).z
					local var_440_8 = manager.ui.mainCameraCom_
					local var_440_9 = 2 * var_440_7 * Mathf.Tan(var_440_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_440_10 = var_440_9 * var_440_8.aspect
					local var_440_11 = var_440_6.sprite.bounds.size.x
					local var_440_12 = var_440_6.sprite.bounds.size.y
					local var_440_13 = var_440_10 / var_440_11
					local var_440_14 = var_440_9 / var_440_12
					local var_440_15 = var_440_14 < var_440_13 and var_440_13 or var_440_14

					var_440_5.transform.localScale = Vector3.New(var_440_15, var_440_15, 0)
				end

				for iter_440_0, iter_440_1 in pairs(arg_437_1.bgs_) do
					if iter_440_0 ~= "XS0204" then
						iter_440_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_440_16 = 0

			if var_440_16 < arg_437_1.time_ and arg_437_1.time_ <= var_440_16 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			local var_440_17 = 0.3

			if arg_437_1.time_ >= var_440_16 + var_440_17 and arg_437_1.time_ < var_440_16 + var_440_17 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			local var_440_18 = 0

			if var_440_18 < arg_437_1.time_ and arg_437_1.time_ <= var_440_18 + arg_440_0 then
				arg_437_1.mask_.enabled = true
				arg_437_1.mask_.raycastTarget = true

				arg_437_1:SetGaussion(false)
			end

			local var_440_19 = 0.9

			if var_440_18 <= arg_437_1.time_ and arg_437_1.time_ < var_440_18 + var_440_19 then
				local var_440_20 = (arg_437_1.time_ - var_440_18) / var_440_19
				local var_440_21 = Color.New(0, 0, 0)

				var_440_21.a = Mathf.Lerp(0, 1, var_440_20)
				arg_437_1.mask_.color = var_440_21
			end

			if arg_437_1.time_ >= var_440_18 + var_440_19 and arg_437_1.time_ < var_440_18 + var_440_19 + arg_440_0 then
				local var_440_22 = Color.New(0, 0, 0)

				var_440_22.a = 1
				arg_437_1.mask_.color = var_440_22
			end

			local var_440_23 = 0.9

			if var_440_23 < arg_437_1.time_ and arg_437_1.time_ <= var_440_23 + arg_440_0 then
				arg_437_1.mask_.enabled = true
				arg_437_1.mask_.raycastTarget = true

				arg_437_1:SetGaussion(false)
			end

			local var_440_24 = 1.86666666666667

			if var_440_23 <= arg_437_1.time_ and arg_437_1.time_ < var_440_23 + var_440_24 then
				local var_440_25 = (arg_437_1.time_ - var_440_23) / var_440_24
				local var_440_26 = Color.New(0, 0, 0)

				var_440_26.a = Mathf.Lerp(1, 0, var_440_25)
				arg_437_1.mask_.color = var_440_26
			end

			if arg_437_1.time_ >= var_440_23 + var_440_24 and arg_437_1.time_ < var_440_23 + var_440_24 + arg_440_0 then
				local var_440_27 = Color.New(0, 0, 0)
				local var_440_28 = 0

				arg_437_1.mask_.enabled = false
				var_440_27.a = var_440_28
				arg_437_1.mask_.color = var_440_27
			end

			local var_440_29 = arg_437_1.bgs_.XS0204.transform
			local var_440_30 = 0.9

			if var_440_30 < arg_437_1.time_ and arg_437_1.time_ <= var_440_30 + arg_440_0 then
				arg_437_1.var_.moveOldPosXS0204 = var_440_29.localPosition
			end

			local var_440_31 = 0.001

			if var_440_30 <= arg_437_1.time_ and arg_437_1.time_ < var_440_30 + var_440_31 then
				local var_440_32 = (arg_437_1.time_ - var_440_30) / var_440_31
				local var_440_33 = Vector3.New(0, 1, 10)

				var_440_29.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPosXS0204, var_440_33, var_440_32)
			end

			if arg_437_1.time_ >= var_440_30 + var_440_31 and arg_437_1.time_ < var_440_30 + var_440_31 + arg_440_0 then
				var_440_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_440_34 = arg_437_1.bgs_.XS0204.transform
			local var_440_35 = 0.934

			if var_440_35 < arg_437_1.time_ and arg_437_1.time_ <= var_440_35 + arg_440_0 then
				arg_437_1.var_.moveOldPosXS0204 = var_440_34.localPosition
			end

			local var_440_36 = 1.73266666666667

			if var_440_35 <= arg_437_1.time_ and arg_437_1.time_ < var_440_35 + var_440_36 then
				local var_440_37 = (arg_437_1.time_ - var_440_35) / var_440_36
				local var_440_38 = Vector3.New(0, 1, 8.51)

				var_440_34.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPosXS0204, var_440_38, var_440_37)
			end

			if arg_437_1.time_ >= var_440_35 + var_440_36 and arg_437_1.time_ < var_440_35 + var_440_36 + arg_440_0 then
				var_440_34.localPosition = Vector3.New(0, 1, 8.51)
			end

			local var_440_39 = 0.9

			if var_440_39 < arg_437_1.time_ and arg_437_1.time_ <= var_440_39 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			local var_440_40 = 1.76666666666667

			if arg_437_1.time_ >= var_440_39 + var_440_40 and arg_437_1.time_ < var_440_39 + var_440_40 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			if arg_437_1.frameCnt_ <= 1 then
				arg_437_1.dialog_:SetActive(false)
			end

			local var_440_41 = 2.46666666666667
			local var_440_42 = 0.5

			if var_440_41 < arg_437_1.time_ and arg_437_1.time_ <= var_440_41 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0

				arg_437_1.dialog_:SetActive(true)

				arg_437_1.dialogCg_.alpha = 0

				local var_440_43 = LeanTween.value(arg_437_1.dialog_, 0, 1, 0.3)

				var_440_43:setOnUpdate(LuaHelper.FloatAction(function(arg_441_0)
					arg_437_1.dialogCg_.alpha = arg_441_0
				end))
				var_440_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_437_1.dialog_)
					var_440_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_437_1.duration_ = arg_437_1.duration_ + 0.3

				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_44 = arg_437_1:FormatText(StoryNameCfg[67].name)

				arg_437_1.leftNameTxt_.text = var_440_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_45 = arg_437_1:GetWordFromCfg(320311105)
				local var_440_46 = arg_437_1:FormatText(var_440_45.content)

				arg_437_1.text_.text = var_440_46

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_47 = 20
				local var_440_48 = utf8.len(var_440_46)
				local var_440_49 = var_440_47 <= 0 and var_440_42 or var_440_42 * (var_440_48 / var_440_47)

				if var_440_49 > 0 and var_440_42 < var_440_49 then
					arg_437_1.talkMaxDuration = var_440_49
					var_440_41 = var_440_41 + 0.3

					if var_440_49 + var_440_41 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_49 + var_440_41
					end
				end

				arg_437_1.text_.text = var_440_46
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311105", "story_v_out_320311.awb") ~= 0 then
					local var_440_50 = manager.audio:GetVoiceLength("story_v_out_320311", "320311105", "story_v_out_320311.awb") / 1000

					if var_440_50 + var_440_41 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_50 + var_440_41
					end

					if var_440_45.prefab_name ~= "" and arg_437_1.actors_[var_440_45.prefab_name] ~= nil then
						local var_440_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_45.prefab_name].transform, "story_v_out_320311", "320311105", "story_v_out_320311.awb")

						arg_437_1:RecordAudio("320311105", var_440_51)
						arg_437_1:RecordAudio("320311105", var_440_51)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_320311", "320311105", "story_v_out_320311.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_320311", "320311105", "story_v_out_320311.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_52 = var_440_41 + 0.3
			local var_440_53 = math.max(var_440_42, arg_437_1.talkMaxDuration)

			if var_440_52 <= arg_437_1.time_ and arg_437_1.time_ < var_440_52 + var_440_53 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_52) / var_440_53

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_52 + var_440_53 and arg_437_1.time_ < var_440_52 + var_440_53 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XS0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.73266666666667,
				className = "StoryMoveNode",
				startTime = 0.934,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play320311106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 320311106
		arg_443_1.duration_ = 4.9

		local var_443_0 = {
			zh = 3.3,
			ja = 4.9
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play320311107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.225

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[1049].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(320311106)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 9
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311106", "story_v_out_320311.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311106", "story_v_out_320311.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_320311", "320311106", "story_v_out_320311.awb")

						arg_443_1:RecordAudio("320311106", var_446_9)
						arg_443_1:RecordAudio("320311106", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_320311", "320311106", "story_v_out_320311.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_320311", "320311106", "story_v_out_320311.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_10 and arg_443_1.time_ < var_446_0 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play320311107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 320311107
		arg_447_1.duration_ = 8.13

		local var_447_0 = {
			zh = 8.133,
			ja = 5.6
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play320311108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.75

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[67].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(320311107)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 30
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311107", "story_v_out_320311.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311107", "story_v_out_320311.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_320311", "320311107", "story_v_out_320311.awb")

						arg_447_1:RecordAudio("320311107", var_450_9)
						arg_447_1:RecordAudio("320311107", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_320311", "320311107", "story_v_out_320311.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_320311", "320311107", "story_v_out_320311.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play320311108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 320311108
		arg_451_1.duration_ = 3.63

		local var_451_0 = {
			zh = 3.633,
			ja = 3.566
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play320311109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 0.25

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[1049].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:GetWordFromCfg(320311108)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 10
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311108", "story_v_out_320311.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311108", "story_v_out_320311.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_320311", "320311108", "story_v_out_320311.awb")

						arg_451_1:RecordAudio("320311108", var_454_9)
						arg_451_1:RecordAudio("320311108", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_320311", "320311108", "story_v_out_320311.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_320311", "320311108", "story_v_out_320311.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_10 and arg_451_1.time_ < var_454_0 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play320311109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 320311109
		arg_455_1.duration_ = 6.23

		local var_455_0 = {
			zh = 3.4,
			ja = 6.233
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play320311110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.2

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[1049].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(320311109)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 8
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311109", "story_v_out_320311.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311109", "story_v_out_320311.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_320311", "320311109", "story_v_out_320311.awb")

						arg_455_1:RecordAudio("320311109", var_458_9)
						arg_455_1:RecordAudio("320311109", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_320311", "320311109", "story_v_out_320311.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_320311", "320311109", "story_v_out_320311.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play320311110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 320311110
		arg_459_1.duration_ = 3.27

		local var_459_0 = {
			zh = 2.233,
			ja = 3.266
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play320311111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.075

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[67].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:GetWordFromCfg(320311110)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 3
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311110", "story_v_out_320311.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311110", "story_v_out_320311.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_320311", "320311110", "story_v_out_320311.awb")

						arg_459_1:RecordAudio("320311110", var_462_9)
						arg_459_1:RecordAudio("320311110", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_320311", "320311110", "story_v_out_320311.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_320311", "320311110", "story_v_out_320311.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_10 and arg_459_1.time_ < var_462_0 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play320311111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 320311111
		arg_463_1.duration_ = 7.53

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play320311112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1.26666666666667

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				local var_466_1 = manager.ui.mainCamera.transform.localPosition
				local var_466_2 = Vector3.New(0, 0, 10) + Vector3.New(var_466_1.x, var_466_1.y, 0)
				local var_466_3 = arg_463_1.bgs_.L05j

				var_466_3.transform.localPosition = var_466_2
				var_466_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_4 = var_466_3:GetComponent("SpriteRenderer")

				if var_466_4 and var_466_4.sprite then
					local var_466_5 = (var_466_3.transform.localPosition - var_466_1).z
					local var_466_6 = manager.ui.mainCameraCom_
					local var_466_7 = 2 * var_466_5 * Mathf.Tan(var_466_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_466_8 = var_466_7 * var_466_6.aspect
					local var_466_9 = var_466_4.sprite.bounds.size.x
					local var_466_10 = var_466_4.sprite.bounds.size.y
					local var_466_11 = var_466_8 / var_466_9
					local var_466_12 = var_466_7 / var_466_10
					local var_466_13 = var_466_12 < var_466_11 and var_466_11 or var_466_12

					var_466_3.transform.localScale = Vector3.New(var_466_13, var_466_13, 0)
				end

				for iter_466_0, iter_466_1 in pairs(arg_463_1.bgs_) do
					if iter_466_0 ~= "L05j" then
						iter_466_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_466_14 = 0

			if var_466_14 < arg_463_1.time_ and arg_463_1.time_ <= var_466_14 + arg_466_0 then
				arg_463_1.allBtn_.enabled = false
			end

			local var_466_15 = 0.3

			if arg_463_1.time_ >= var_466_14 + var_466_15 and arg_463_1.time_ < var_466_14 + var_466_15 + arg_466_0 then
				arg_463_1.allBtn_.enabled = true
			end

			local var_466_16 = 0

			if var_466_16 < arg_463_1.time_ and arg_463_1.time_ <= var_466_16 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_17 = 1.26666666666667

			if var_466_16 <= arg_463_1.time_ and arg_463_1.time_ < var_466_16 + var_466_17 then
				local var_466_18 = (arg_463_1.time_ - var_466_16) / var_466_17
				local var_466_19 = Color.New(0, 0, 0)

				var_466_19.a = Mathf.Lerp(0, 1, var_466_18)
				arg_463_1.mask_.color = var_466_19
			end

			if arg_463_1.time_ >= var_466_16 + var_466_17 and arg_463_1.time_ < var_466_16 + var_466_17 + arg_466_0 then
				local var_466_20 = Color.New(0, 0, 0)

				var_466_20.a = 1
				arg_463_1.mask_.color = var_466_20
			end

			local var_466_21 = 1.26666666666667

			if var_466_21 < arg_463_1.time_ and arg_463_1.time_ <= var_466_21 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_22 = 1.26666666666667

			if var_466_21 <= arg_463_1.time_ and arg_463_1.time_ < var_466_21 + var_466_22 then
				local var_466_23 = (arg_463_1.time_ - var_466_21) / var_466_22
				local var_466_24 = Color.New(0, 0, 0)

				var_466_24.a = Mathf.Lerp(1, 0, var_466_23)
				arg_463_1.mask_.color = var_466_24
			end

			if arg_463_1.time_ >= var_466_21 + var_466_22 and arg_463_1.time_ < var_466_21 + var_466_22 + arg_466_0 then
				local var_466_25 = Color.New(0, 0, 0)
				local var_466_26 = 0

				arg_463_1.mask_.enabled = false
				var_466_25.a = var_466_26
				arg_463_1.mask_.color = var_466_25
			end

			if arg_463_1.frameCnt_ <= 1 then
				arg_463_1.dialog_:SetActive(false)
			end

			local var_466_27 = 2.53333333333333
			local var_466_28 = 1.925

			if var_466_27 < arg_463_1.time_ and arg_463_1.time_ <= var_466_27 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				arg_463_1.dialog_:SetActive(true)

				arg_463_1.dialogCg_.alpha = 0

				local var_466_29 = LeanTween.value(arg_463_1.dialog_, 0, 1, 0.3)

				var_466_29:setOnUpdate(LuaHelper.FloatAction(function(arg_467_0)
					arg_463_1.dialogCg_.alpha = arg_467_0
				end))
				var_466_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_463_1.dialog_)
					var_466_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_463_1.duration_ = arg_463_1.duration_ + 0.3

				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_30 = arg_463_1:GetWordFromCfg(320311111)
				local var_466_31 = arg_463_1:FormatText(var_466_30.content)

				arg_463_1.text_.text = var_466_31

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_32 = 77
				local var_466_33 = utf8.len(var_466_31)
				local var_466_34 = var_466_32 <= 0 and var_466_28 or var_466_28 * (var_466_33 / var_466_32)

				if var_466_34 > 0 and var_466_28 < var_466_34 then
					arg_463_1.talkMaxDuration = var_466_34
					var_466_27 = var_466_27 + 0.3

					if var_466_34 + var_466_27 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_34 + var_466_27
					end
				end

				arg_463_1.text_.text = var_466_31
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_35 = var_466_27 + 0.3
			local var_466_36 = math.max(var_466_28, arg_463_1.talkMaxDuration)

			if var_466_35 <= arg_463_1.time_ and arg_463_1.time_ < var_466_35 + var_466_36 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_35) / var_466_36

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_35 + var_466_36 and arg_463_1.time_ < var_466_35 + var_466_36 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play320311112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 320311112
		arg_469_1.duration_ = 2.83

		local var_469_0 = {
			zh = 1.8,
			ja = 2.833
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play320311113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.125

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[1049].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(320311112)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 5
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311112", "story_v_out_320311.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_320311", "320311112", "story_v_out_320311.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_out_320311", "320311112", "story_v_out_320311.awb")

						arg_469_1:RecordAudio("320311112", var_472_9)
						arg_469_1:RecordAudio("320311112", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_320311", "320311112", "story_v_out_320311.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_320311", "320311112", "story_v_out_320311.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_10 and arg_469_1.time_ < var_472_0 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play320311113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 320311113
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play320311114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.675

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(320311113)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 27
				local var_476_5 = utf8.len(var_476_3)
				local var_476_6 = var_476_4 <= 0 and var_476_1 or var_476_1 * (var_476_5 / var_476_4)

				if var_476_6 > 0 and var_476_1 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_7 and arg_473_1.time_ < var_476_0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play320311114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 320311114
		arg_477_1.duration_ = 6

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play320311115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = manager.ui.mainCamera.transform
			local var_480_1 = 0.366666666666667

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.shakeOldPos = var_480_0.localPosition
			end

			local var_480_2 = 0.633333333333333

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / 0.066
				local var_480_4, var_480_5 = math.modf(var_480_3)

				var_480_0.localPosition = Vector3.New(var_480_5 * 0.13, var_480_5 * 0.13, var_480_5 * 0.13) + arg_477_1.var_.shakeOldPos
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = arg_477_1.var_.shakeOldPos
			end

			local var_480_6 = 0

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = false

				arg_477_1:SetGaussion(false)
			end

			local var_480_7 = 0.566666666666667

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_7 then
				local var_480_8 = (arg_477_1.time_ - var_480_6) / var_480_7
				local var_480_9 = Color.New(1, 1, 1)

				var_480_9.a = Mathf.Lerp(1, 0, var_480_8)
				arg_477_1.mask_.color = var_480_9
			end

			if arg_477_1.time_ >= var_480_6 + var_480_7 and arg_477_1.time_ < var_480_6 + var_480_7 + arg_480_0 then
				local var_480_10 = Color.New(1, 1, 1)
				local var_480_11 = 0

				arg_477_1.mask_.enabled = false
				var_480_10.a = var_480_11
				arg_477_1.mask_.color = var_480_10
			end

			local var_480_12 = 1.13333333333333
			local var_480_13 = 1

			if var_480_12 < arg_477_1.time_ and arg_477_1.time_ <= var_480_12 + arg_480_0 then
				local var_480_14 = "play"
				local var_480_15 = "effect"

				arg_477_1:AudioAction(var_480_14, var_480_15, "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_16 = 1
			local var_480_17 = 1.325

			if var_480_16 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_18 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_18:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_19 = arg_477_1:GetWordFromCfg(320311114)
				local var_480_20 = arg_477_1:FormatText(var_480_19.content)

				arg_477_1.text_.text = var_480_20

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_21 = 53
				local var_480_22 = utf8.len(var_480_20)
				local var_480_23 = var_480_21 <= 0 and var_480_17 or var_480_17 * (var_480_22 / var_480_21)

				if var_480_23 > 0 and var_480_17 < var_480_23 then
					arg_477_1.talkMaxDuration = var_480_23
					var_480_16 = var_480_16 + 0.3

					if var_480_23 + var_480_16 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_16
					end
				end

				arg_477_1.text_.text = var_480_20
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_24 = var_480_16 + 0.3
			local var_480_25 = math.max(var_480_17, arg_477_1.talkMaxDuration)

			if var_480_24 <= arg_477_1.time_ and arg_477_1.time_ < var_480_24 + var_480_25 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_24) / var_480_25

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_24 + var_480_25 and arg_477_1.time_ < var_480_24 + var_480_25 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play320311115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 320311115
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play320311116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.3

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(320311115)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 52
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play320311116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 320311116
		arg_487_1.duration_ = 7.47

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play320311117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 1

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				local var_490_1 = manager.ui.mainCamera.transform.localPosition
				local var_490_2 = Vector3.New(0, 0, 10) + Vector3.New(var_490_1.x, var_490_1.y, 0)
				local var_490_3 = arg_487_1.bgs_.ST0502

				var_490_3.transform.localPosition = var_490_2
				var_490_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_490_4 = var_490_3:GetComponent("SpriteRenderer")

				if var_490_4 and var_490_4.sprite then
					local var_490_5 = (var_490_3.transform.localPosition - var_490_1).z
					local var_490_6 = manager.ui.mainCameraCom_
					local var_490_7 = 2 * var_490_5 * Mathf.Tan(var_490_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_490_8 = var_490_7 * var_490_6.aspect
					local var_490_9 = var_490_4.sprite.bounds.size.x
					local var_490_10 = var_490_4.sprite.bounds.size.y
					local var_490_11 = var_490_8 / var_490_9
					local var_490_12 = var_490_7 / var_490_10
					local var_490_13 = var_490_12 < var_490_11 and var_490_11 or var_490_12

					var_490_3.transform.localScale = Vector3.New(var_490_13, var_490_13, 0)
				end

				for iter_490_0, iter_490_1 in pairs(arg_487_1.bgs_) do
					if iter_490_0 ~= "ST0502" then
						iter_490_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_490_14 = 0

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.allBtn_.enabled = false
			end

			local var_490_15 = 0.3

			if arg_487_1.time_ >= var_490_14 + var_490_15 and arg_487_1.time_ < var_490_14 + var_490_15 + arg_490_0 then
				arg_487_1.allBtn_.enabled = true
			end

			local var_490_16 = 0

			if var_490_16 < arg_487_1.time_ and arg_487_1.time_ <= var_490_16 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_17 = 1

			if var_490_16 <= arg_487_1.time_ and arg_487_1.time_ < var_490_16 + var_490_17 then
				local var_490_18 = (arg_487_1.time_ - var_490_16) / var_490_17
				local var_490_19 = Color.New(0, 0, 0)

				var_490_19.a = Mathf.Lerp(0, 1, var_490_18)
				arg_487_1.mask_.color = var_490_19
			end

			if arg_487_1.time_ >= var_490_16 + var_490_17 and arg_487_1.time_ < var_490_16 + var_490_17 + arg_490_0 then
				local var_490_20 = Color.New(0, 0, 0)

				var_490_20.a = 1
				arg_487_1.mask_.color = var_490_20
			end

			local var_490_21 = 1

			if var_490_21 < arg_487_1.time_ and arg_487_1.time_ <= var_490_21 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_22 = 1.46666666666667

			if var_490_21 <= arg_487_1.time_ and arg_487_1.time_ < var_490_21 + var_490_22 then
				local var_490_23 = (arg_487_1.time_ - var_490_21) / var_490_22
				local var_490_24 = Color.New(0, 0, 0)

				var_490_24.a = Mathf.Lerp(1, 0, var_490_23)
				arg_487_1.mask_.color = var_490_24
			end

			if arg_487_1.time_ >= var_490_21 + var_490_22 and arg_487_1.time_ < var_490_21 + var_490_22 + arg_490_0 then
				local var_490_25 = Color.New(0, 0, 0)
				local var_490_26 = 0

				arg_487_1.mask_.enabled = false
				var_490_25.a = var_490_26
				arg_487_1.mask_.color = var_490_25
			end

			if arg_487_1.frameCnt_ <= 1 then
				arg_487_1.dialog_:SetActive(false)
			end

			local var_490_27 = 2.46666666666667
			local var_490_28 = 1.1

			if var_490_27 < arg_487_1.time_ and arg_487_1.time_ <= var_490_27 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0

				arg_487_1.dialog_:SetActive(true)

				arg_487_1.dialogCg_.alpha = 0

				local var_490_29 = LeanTween.value(arg_487_1.dialog_, 0, 1, 0.3)

				var_490_29:setOnUpdate(LuaHelper.FloatAction(function(arg_491_0)
					arg_487_1.dialogCg_.alpha = arg_491_0
				end))
				var_490_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_487_1.dialog_)
					var_490_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_487_1.duration_ = arg_487_1.duration_ + 0.3

				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_30 = arg_487_1:GetWordFromCfg(320311116)
				local var_490_31 = arg_487_1:FormatText(var_490_30.content)

				arg_487_1.text_.text = var_490_31

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_32 = 44
				local var_490_33 = utf8.len(var_490_31)
				local var_490_34 = var_490_32 <= 0 and var_490_28 or var_490_28 * (var_490_33 / var_490_32)

				if var_490_34 > 0 and var_490_28 < var_490_34 then
					arg_487_1.talkMaxDuration = var_490_34
					var_490_27 = var_490_27 + 0.3

					if var_490_34 + var_490_27 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_34 + var_490_27
					end
				end

				arg_487_1.text_.text = var_490_31
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_35 = var_490_27 + 0.3
			local var_490_36 = math.max(var_490_28, arg_487_1.talkMaxDuration)

			if var_490_35 <= arg_487_1.time_ and arg_487_1.time_ < var_490_35 + var_490_36 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_35) / var_490_36

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_35 + var_490_36 and arg_487_1.time_ < var_490_35 + var_490_36 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play320311117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 320311117
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play320311118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.525

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_2 = arg_493_1:GetWordFromCfg(320311117)
				local var_496_3 = arg_493_1:FormatText(var_496_2.content)

				arg_493_1.text_.text = var_496_3

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 21
				local var_496_5 = utf8.len(var_496_3)
				local var_496_6 = var_496_4 <= 0 and var_496_1 or var_496_1 * (var_496_5 / var_496_4)

				if var_496_6 > 0 and var_496_1 < var_496_6 then
					arg_493_1.talkMaxDuration = var_496_6

					if var_496_6 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_6 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_3
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_7 and arg_493_1.time_ < var_496_0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play320311118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 320311118
		arg_497_1.duration_ = 4.2

		local var_497_0 = {
			zh = 2.766,
			ja = 4.2
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play320311119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1284ui_story"].transform
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.var_.moveOldPos1284ui_story = var_500_0.localPosition
			end

			local var_500_2 = 0.001

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2
				local var_500_4 = Vector3.New(0, -0.985, -6.22)

				var_500_0.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1284ui_story, var_500_4, var_500_3)

				local var_500_5 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_5.x, var_500_5.y, var_500_5.z)

				local var_500_6 = var_500_0.localEulerAngles

				var_500_6.z = 0
				var_500_6.x = 0
				var_500_0.localEulerAngles = var_500_6
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 then
				var_500_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_500_7 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_7.x, var_500_7.y, var_500_7.z)

				local var_500_8 = var_500_0.localEulerAngles

				var_500_8.z = 0
				var_500_8.x = 0
				var_500_0.localEulerAngles = var_500_8
			end

			local var_500_9 = arg_497_1.actors_["1284ui_story"]
			local var_500_10 = 0

			if var_500_10 < arg_497_1.time_ and arg_497_1.time_ <= var_500_10 + arg_500_0 and not isNil(var_500_9) and arg_497_1.var_.characterEffect1284ui_story == nil then
				arg_497_1.var_.characterEffect1284ui_story = var_500_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_11 = 0.200000002980232

			if var_500_10 <= arg_497_1.time_ and arg_497_1.time_ < var_500_10 + var_500_11 and not isNil(var_500_9) then
				local var_500_12 = (arg_497_1.time_ - var_500_10) / var_500_11

				if arg_497_1.var_.characterEffect1284ui_story and not isNil(var_500_9) then
					arg_497_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_10 + var_500_11 and arg_497_1.time_ < var_500_10 + var_500_11 + arg_500_0 and not isNil(var_500_9) and arg_497_1.var_.characterEffect1284ui_story then
				arg_497_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_500_13 = 0

			if var_500_13 < arg_497_1.time_ and arg_497_1.time_ <= var_500_13 + arg_500_0 then
				arg_497_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action9_1")
			end

			local var_500_14 = 0

			if var_500_14 < arg_497_1.time_ and arg_497_1.time_ <= var_500_14 + arg_500_0 then
				arg_497_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_500_15 = 0
			local var_500_16 = 0.325

			if var_500_15 < arg_497_1.time_ and arg_497_1.time_ <= var_500_15 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_17 = arg_497_1:FormatText(StoryNameCfg[6].name)

				arg_497_1.leftNameTxt_.text = var_500_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_18 = arg_497_1:GetWordFromCfg(320311118)
				local var_500_19 = arg_497_1:FormatText(var_500_18.content)

				arg_497_1.text_.text = var_500_19

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_20 = 13
				local var_500_21 = utf8.len(var_500_19)
				local var_500_22 = var_500_20 <= 0 and var_500_16 or var_500_16 * (var_500_21 / var_500_20)

				if var_500_22 > 0 and var_500_16 < var_500_22 then
					arg_497_1.talkMaxDuration = var_500_22

					if var_500_22 + var_500_15 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_22 + var_500_15
					end
				end

				arg_497_1.text_.text = var_500_19
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320311", "320311118", "story_v_out_320311.awb") ~= 0 then
					local var_500_23 = manager.audio:GetVoiceLength("story_v_out_320311", "320311118", "story_v_out_320311.awb") / 1000

					if var_500_23 + var_500_15 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_23 + var_500_15
					end

					if var_500_18.prefab_name ~= "" and arg_497_1.actors_[var_500_18.prefab_name] ~= nil then
						local var_500_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_18.prefab_name].transform, "story_v_out_320311", "320311118", "story_v_out_320311.awb")

						arg_497_1:RecordAudio("320311118", var_500_24)
						arg_497_1:RecordAudio("320311118", var_500_24)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_320311", "320311118", "story_v_out_320311.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_320311", "320311118", "story_v_out_320311.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_25 = math.max(var_500_16, arg_497_1.talkMaxDuration)

			if var_500_15 <= arg_497_1.time_ and arg_497_1.time_ < var_500_15 + var_500_25 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_15) / var_500_25

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_15 + var_500_25 and arg_497_1.time_ < var_500_15 + var_500_25 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play320311119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 320311119
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play320311120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1284ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1284ui_story == nil then
				arg_501_1.var_.characterEffect1284ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect1284ui_story and not isNil(var_504_0) then
					local var_504_4 = Mathf.Lerp(0, 0.5, var_504_3)

					arg_501_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1284ui_story.fillRatio = var_504_4
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1284ui_story then
				local var_504_5 = 0.5

				arg_501_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1284ui_story.fillRatio = var_504_5
			end

			local var_504_6 = 0
			local var_504_7 = 0.55

			if var_504_6 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_8 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_9 = arg_501_1:GetWordFromCfg(320311119)
				local var_504_10 = arg_501_1:FormatText(var_504_9.content)

				arg_501_1.text_.text = var_504_10

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 22
				local var_504_12 = utf8.len(var_504_10)
				local var_504_13 = var_504_11 <= 0 and var_504_7 or var_504_7 * (var_504_12 / var_504_11)

				if var_504_13 > 0 and var_504_7 < var_504_13 then
					arg_501_1.talkMaxDuration = var_504_13

					if var_504_13 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_6
					end
				end

				arg_501_1.text_.text = var_504_10
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_7, arg_501_1.talkMaxDuration)

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_6) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_6 + var_504_14 and arg_501_1.time_ < var_504_6 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play320311120 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 320311120
		arg_505_1.duration_ = 5.3

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
			arg_505_1.auto_ = false
		end

		function arg_505_1.playNext_(arg_507_0)
			arg_505_1.onStoryFinished_()
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if arg_505_1.frameCnt_ <= 1 then
				arg_505_1.dialog_:SetActive(false)
			end

			local var_508_0 = 0.3
			local var_508_1 = 0.175

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0

				arg_505_1.dialog_:SetActive(true)

				arg_505_1.dialogCg_.alpha = 0

				local var_508_2 = LeanTween.value(arg_505_1.dialog_, 0, 1, 0.3)

				var_508_2:setOnUpdate(LuaHelper.FloatAction(function(arg_509_0)
					arg_505_1.dialogCg_.alpha = arg_509_0
				end))
				var_508_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_505_1.dialog_)
					var_508_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_505_1.duration_ = arg_505_1.duration_ + 0.3

				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_3 = arg_505_1:FormatText(StoryNameCfg[7].name)

				arg_505_1.leftNameTxt_.text = var_508_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_4 = arg_505_1:GetWordFromCfg(320311120)
				local var_508_5 = arg_505_1:FormatText(var_508_4.content)

				arg_505_1.text_.text = var_508_5

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_6 = 7
				local var_508_7 = utf8.len(var_508_5)
				local var_508_8 = var_508_6 <= 0 and var_508_1 or var_508_1 * (var_508_7 / var_508_6)

				if var_508_8 > 0 and var_508_1 < var_508_8 then
					arg_505_1.talkMaxDuration = var_508_8
					var_508_0 = var_508_0 + 0.3

					if var_508_8 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_8 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_5
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_9 = var_508_0 + 0.3
			local var_508_10 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_9 <= arg_505_1.time_ and arg_505_1.time_ < var_508_9 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_9) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_9 + var_508_10 and arg_505_1.time_ < var_508_9 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0502",
		"TextureConfig/Background/L05j",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/XS0204a",
		"TextureConfig/Background/XS0204"
	},
	voices = {
		"story_v_out_320311.awb"
	}
}
