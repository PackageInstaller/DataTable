return {
	Play1109511001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109511001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109511002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0104"

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
				local var_4_5 = arg_1_1.bgs_.ST0104

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
					if iter_4_0 ~= "ST0104" then
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

			local var_4_24 = 1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 1.83333333333333
			local var_4_39 = 0.275

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[1140].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(1109511001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 11
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")

						arg_1_1:RecordAudio("1109511001", var_4_48)
						arg_1_1:RecordAudio("1109511001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_38 + 0.3
			local var_4_50 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109511002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1109511002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1109511003(arg_8_1)
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

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(1109511002)
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
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1109511003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1109511003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1109511004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.625

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(1109511003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 25
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1109511004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1109511004
		arg_16_1.duration_ = 3.23

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1109511005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.35

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1140].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(1109511004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")

						arg_16_1:RecordAudio("1109511004", var_19_9)
						arg_16_1:RecordAudio("1109511004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")
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
	Play1109511005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1109511005
		arg_20_1.duration_ = 1

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"

			SetActive(arg_20_1.choicesGo_, true)

			for iter_21_0, iter_21_1 in ipairs(arg_20_1.choices_) do
				local var_21_0 = iter_21_0 <= 2

				SetActive(iter_21_1.go, var_21_0)
			end

			arg_20_1.choices_[1].txt.text = arg_20_1:FormatText(StoryChoiceCfg[1743].name)
			arg_20_1.choices_[2].txt.text = arg_20_1:FormatText(StoryChoiceCfg[1744].name)
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1109511006(arg_20_1)
			end

			if arg_22_0 == 2 then
				arg_20_0:Play1109511006(arg_20_1)
			end

			arg_20_1:RecordChoiceLog(1109511005, 1743, 1744)
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			return
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1109511006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1109511006
		arg_24_1.duration_ = 4.97

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1109511007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.5

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1140].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(1109511006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")

						arg_24_1:RecordAudio("1109511006", var_27_9)
						arg_24_1:RecordAudio("1109511006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")
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
	Play1109511007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1109511007
		arg_28_1.duration_ = 2.67

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1109511008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.3

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[1140].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(1109511007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 12
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")

						arg_28_1:RecordAudio("1109511007", var_31_9)
						arg_28_1:RecordAudio("1109511007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1109511008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1109511008
		arg_32_1.duration_ = 1

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"

			SetActive(arg_32_1.choicesGo_, true)

			for iter_33_0, iter_33_1 in ipairs(arg_32_1.choices_) do
				local var_33_0 = iter_33_0 <= 1

				SetActive(iter_33_1.go, var_33_0)
			end

			arg_32_1.choices_[1].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1745].name)
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1109511009(arg_32_1)
			end

			arg_32_1:RecordChoiceLog(1109511008, 1745)
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			return
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1109511009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1109511009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1109511010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.875

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(1109511009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 35
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1109511010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1109511010
		arg_40_1.duration_ = 5.9

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1109511011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.4

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1140].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(1109511010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 16
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")

						arg_40_1:RecordAudio("1109511010", var_43_9)
						arg_40_1:RecordAudio("1109511010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1109511011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1109511011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1109511012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.325

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(1109511011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 13
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
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1109511012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1109511012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1109511013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.15

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(1109511012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 46
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1109511013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1109511013
		arg_52_1.duration_ = 6.12

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1109511014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "STblack"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 1.11666666666667

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.STblack

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "STblack" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_17 = 0.3

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_19 = 1.11666666666667

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				local var_55_20 = (arg_52_1.time_ - var_55_18) / var_55_19
				local var_55_21 = Color.New(0, 0, 0)

				var_55_21.a = Mathf.Lerp(0, 1, var_55_20)
				arg_52_1.mask_.color = var_55_21
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				local var_55_22 = Color.New(0, 0, 0)

				var_55_22.a = 1
				arg_52_1.mask_.color = var_55_22
			end

			local var_55_23 = 1.11666666666667

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_24 = 1.31666666666667

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Color.New(0, 0, 0)

				var_55_26.a = Mathf.Lerp(1, 0, var_55_25)
				arg_52_1.mask_.color = var_55_26
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				local var_55_27 = Color.New(0, 0, 0)
				local var_55_28 = 0

				arg_52_1.mask_.enabled = false
				var_55_27.a = var_55_28
				arg_52_1.mask_.color = var_55_27
			end

			local var_55_29 = 1.11666666666667

			if var_55_29 < arg_52_1.time_ and arg_52_1.time_ <= var_55_29 + arg_55_0 then
				local var_55_30 = arg_52_1.fswbg_.transform:Find("textbox/adapt/content") or arg_52_1.fswbg_.transform:Find("textbox/content")
				local var_55_31 = arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_55_32 = var_55_30:GetComponent("Text")
				local var_55_33 = var_55_30:GetComponent("RectTransform")

				var_55_32.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_55_33.offsetMin = Vector2.New(0, 0)
				var_55_33.offsetMax = Vector2.New(0, 0)
			end

			local var_55_34 = 1.11666666666667

			if var_55_34 < arg_52_1.time_ and arg_52_1.time_ <= var_55_34 + arg_55_0 then
				arg_52_1.fswbg_:SetActive(true)
				arg_52_1.dialog_:SetActive(false)

				arg_52_1.fswtw_.percent = 0

				local var_55_35 = arg_52_1:GetWordFromCfg(102)
				local var_55_36 = arg_52_1:FormatText(var_55_35.content)

				arg_52_1.fswt_.text = var_55_36

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.fswt_)

				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_52_1.fswtw_:SetDirty()

				arg_52_1.typewritterCharCountI18N = 0

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_52_1:ShowNextGo(false)
			end

			local var_55_37 = 0
			local var_55_38 = 1

			if var_55_37 < arg_52_1.time_ and arg_52_1.time_ <= var_55_37 + arg_55_0 then
				local var_55_39 = "play"
				local var_55_40 = "effect"

				arg_52_1:AudioAction(var_55_39, var_55_40, "ui_battle", "ui_battle_stopbgm", "")
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = true,
				className = "StoryTextGroupNode",
				contentID = 1109511013,
				charCount = 23,
				enableLayoutChange = true,
				duration = 1.53333333333333,
				groupID = "2323",
				startTime = 2.08333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1109511014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1109511014
		arg_56_1.duration_ = 3.93

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1109511015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "X203I"

			if arg_56_1.bgs_[var_59_0] == nil then
				local var_59_1 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_59_0)
				var_59_1.name = var_59_0
				var_59_1.transform.parent = arg_56_1.stage_.transform
				var_59_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_[var_59_0] = var_59_1
			end

			local var_59_2 = 1.20000000298023

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				local var_59_3 = manager.ui.mainCamera.transform.localPosition
				local var_59_4 = Vector3.New(0, 0, 10) + Vector3.New(var_59_3.x, var_59_3.y, 0)
				local var_59_5 = arg_56_1.bgs_.X203I

				var_59_5.transform.localPosition = var_59_4
				var_59_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_6 = var_59_5:GetComponent("SpriteRenderer")

				if var_59_6 and var_59_6.sprite then
					local var_59_7 = (var_59_5.transform.localPosition - var_59_3).z
					local var_59_8 = manager.ui.mainCameraCom_
					local var_59_9 = 2 * var_59_7 * Mathf.Tan(var_59_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_59_10 = var_59_9 * var_59_8.aspect
					local var_59_11 = var_59_6.sprite.bounds.size.x
					local var_59_12 = var_59_6.sprite.bounds.size.y
					local var_59_13 = var_59_10 / var_59_11
					local var_59_14 = var_59_9 / var_59_12
					local var_59_15 = var_59_14 < var_59_13 and var_59_13 or var_59_14

					var_59_5.transform.localScale = Vector3.New(var_59_15, var_59_15, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "X203I" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_16 = 1.20000000298023

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_17 = 0.3

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			local var_59_18 = 0

			if var_59_18 < arg_56_1.time_ and arg_56_1.time_ <= var_59_18 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_19 = 1.20000000298023

			if var_59_18 <= arg_56_1.time_ and arg_56_1.time_ < var_59_18 + var_59_19 then
				local var_59_20 = (arg_56_1.time_ - var_59_18) / var_59_19
				local var_59_21 = Color.New(0, 0, 0)

				var_59_21.a = Mathf.Lerp(0, 1, var_59_20)
				arg_56_1.mask_.color = var_59_21
			end

			if arg_56_1.time_ >= var_59_18 + var_59_19 and arg_56_1.time_ < var_59_18 + var_59_19 + arg_59_0 then
				local var_59_22 = Color.New(0, 0, 0)

				var_59_22.a = 1
				arg_56_1.mask_.color = var_59_22
			end

			local var_59_23 = 1.20000000298023

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_24 = 1.65

			if var_59_23 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_24 then
				local var_59_25 = (arg_56_1.time_ - var_59_23) / var_59_24
				local var_59_26 = Color.New(0, 0, 0)

				var_59_26.a = Mathf.Lerp(1, 0, var_59_25)
				arg_56_1.mask_.color = var_59_26
			end

			if arg_56_1.time_ >= var_59_23 + var_59_24 and arg_56_1.time_ < var_59_23 + var_59_24 + arg_59_0 then
				local var_59_27 = Color.New(0, 0, 0)
				local var_59_28 = 0

				arg_56_1.mask_.enabled = false
				var_59_27.a = var_59_28
				arg_56_1.mask_.color = var_59_27
			end

			local var_59_29 = "10058ui_story"

			if arg_56_1.actors_[var_59_29] == nil then
				local var_59_30 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_59_30) then
					local var_59_31 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_56_1.stage_.transform)

					var_59_31.name = var_59_29
					var_59_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_29] = var_59_31

					local var_59_32 = var_59_31:GetComponentInChildren(typeof(CharacterEffect))

					var_59_32.enabled = true

					local var_59_33 = GameObjectTools.GetOrAddComponent(var_59_31, typeof(DynamicBoneHelper))

					if var_59_33 then
						var_59_33:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_32.transform, false)

					arg_56_1.var_[var_59_29 .. "Animator"] = var_59_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_29 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_29 .. "LipSync"] = var_59_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_34 = arg_56_1.actors_["10058ui_story"]
			local var_59_35 = 0

			if var_59_35 < arg_56_1.time_ and arg_56_1.time_ <= var_59_35 + arg_59_0 and not isNil(var_59_34) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = var_59_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_36 = 0.200000002980232

			if var_59_35 <= arg_56_1.time_ and arg_56_1.time_ < var_59_35 + var_59_36 and not isNil(var_59_34) then
				local var_59_37 = (arg_56_1.time_ - var_59_35) / var_59_36

				if arg_56_1.var_.characterEffect10058ui_story and not isNil(var_59_34) then
					arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_35 + var_59_36 and arg_56_1.time_ < var_59_35 + var_59_36 + arg_59_0 and not isNil(var_59_34) and arg_56_1.var_.characterEffect10058ui_story then
				arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_59_38 = 1.20000000298023

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(false)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_39 = 1.2166666696469

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(false)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_40 = 1
			local var_59_41 = 1

			if var_59_40 < arg_56_1.time_ and arg_56_1.time_ <= var_59_40 + arg_59_0 then
				local var_59_42 = "play"
				local var_59_43 = "effect"

				arg_56_1:AudioAction(var_59_42, var_59_43, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_59_44 = 0.2
			local var_59_45 = 1

			if var_59_44 < arg_56_1.time_ and arg_56_1.time_ <= var_59_44 + arg_59_0 then
				local var_59_46 = "stop"
				local var_59_47 = "effect"

				arg_56_1:AudioAction(var_59_46, var_59_47, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_59_48 = 1
			local var_59_49 = 1

			if var_59_48 < arg_56_1.time_ and arg_56_1.time_ <= var_59_48 + arg_59_0 then
				local var_59_50 = "play"
				local var_59_51 = "music"

				arg_56_1:AudioAction(var_59_50, var_59_51, "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night.awb")

				local var_59_52 = ""
				local var_59_53 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night")

				if var_59_53 ~= "" then
					if arg_56_1.bgmTxt_.text ~= var_59_53 and arg_56_1.bgmTxt_.text ~= "" then
						if arg_56_1.bgmTxt2_.text ~= "" then
							arg_56_1.bgmTxt_.text = arg_56_1.bgmTxt2_.text
						end

						arg_56_1.bgmTxt2_.text = var_59_53

						arg_56_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_56_1.bgmTxt_.text = var_59_53
						arg_56_1.bgmTxt2_.text = var_59_53
					end

					if arg_56_1.bgmTimer then
						arg_56_1.bgmTimer:Stop()

						arg_56_1.bgmTimer = nil
					end

					if arg_56_1.settingData.show_music_name == 1 then
						arg_56_1.musicController:SetSelectedState("show")
						arg_56_1.musicAnimator_:Play("open", 0, 0)

						if arg_56_1.settingData.music_time ~= 0 then
							arg_56_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_56_1.settingData.music_time), function()
								if arg_56_1 == nil or isNil(arg_56_1.bgmTxt_) then
									return
								end

								arg_56_1.musicController:SetSelectedState("hide")
								arg_56_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_54 = 2.43333333333333
			local var_59_55 = 0.075

			if var_59_54 < arg_56_1.time_ and arg_56_1.time_ <= var_59_54 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_56 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_56:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_56_1.dialogCg_.alpha = arg_61_0
				end))
				var_59_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_57 = arg_56_1:FormatText(StoryNameCfg[471].name)

				arg_56_1.leftNameTxt_.text = var_59_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_58 = arg_56_1:GetWordFromCfg(1109511014)
				local var_59_59 = arg_56_1:FormatText(var_59_58.content)

				arg_56_1.text_.text = var_59_59

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_60 = 3
				local var_59_61 = utf8.len(var_59_59)
				local var_59_62 = var_59_60 <= 0 and var_59_55 or var_59_55 * (var_59_61 / var_59_60)

				if var_59_62 > 0 and var_59_55 < var_59_62 then
					arg_56_1.talkMaxDuration = var_59_62
					var_59_54 = var_59_54 + 0.3

					if var_59_62 + var_59_54 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_62 + var_59_54
					end
				end

				arg_56_1.text_.text = var_59_59
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb") ~= 0 then
					local var_59_63 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb") / 1000

					if var_59_63 + var_59_54 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_63 + var_59_54
					end

					if var_59_58.prefab_name ~= "" and arg_56_1.actors_[var_59_58.prefab_name] ~= nil then
						local var_59_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_58.prefab_name].transform, "story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")

						arg_56_1:RecordAudio("1109511014", var_59_64)
						arg_56_1:RecordAudio("1109511014", var_59_64)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_65 = var_59_54 + 0.3
			local var_59_66 = math.max(var_59_55, arg_56_1.talkMaxDuration)

			if var_59_65 <= arg_56_1.time_ and arg_56_1.time_ < var_59_65 + var_59_66 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_65) / var_59_66

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_65 + var_59_66 and arg_56_1.time_ < var_59_65 + var_59_66 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				groupID = "2323",
				duration = 1.53333333333333,
				className = "StoryTextGroupNode",
				startTime = 1.20000000298023,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play1109511015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109511015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109511016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10058ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10058ui_story == nil then
				arg_63_1.var_.characterEffect10058ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10058ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10058ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10058ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10058ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.225

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(1109511015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 9
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109511016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109511016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109511017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.65

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(1109511016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 26
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109511017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109511017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1109511018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.75

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(1109511017)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 30
				local var_74_5 = utf8.len(var_74_3)
				local var_74_6 = var_74_4 <= 0 and var_74_1 or var_74_1 * (var_74_5 / var_74_4)

				if var_74_6 > 0 and var_74_1 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_7 and arg_71_1.time_ < var_74_0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109511018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109511018
		arg_75_1.duration_ = 3.83

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109511019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10058ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10058ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -0.98, -6.1)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10058ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["10058ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect10058ui_story == nil then
				arg_75_1.var_.characterEffect10058ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect10058ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect10058ui_story then
				arg_75_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_78_13 = 0

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_78_15 = 0
			local var_78_16 = 0.45

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_17 = arg_75_1:FormatText(StoryNameCfg[471].name)

				arg_75_1.leftNameTxt_.text = var_78_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_18 = arg_75_1:GetWordFromCfg(1109511018)
				local var_78_19 = arg_75_1:FormatText(var_78_18.content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_20 = 18
				local var_78_21 = utf8.len(var_78_19)
				local var_78_22 = var_78_20 <= 0 and var_78_16 or var_78_16 * (var_78_21 / var_78_20)

				if var_78_22 > 0 and var_78_16 < var_78_22 then
					arg_75_1.talkMaxDuration = var_78_22

					if var_78_22 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_22 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_19
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb") ~= 0 then
					local var_78_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb") / 1000

					if var_78_23 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_15
					end

					if var_78_18.prefab_name ~= "" and arg_75_1.actors_[var_78_18.prefab_name] ~= nil then
						local var_78_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_18.prefab_name].transform, "story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")

						arg_75_1:RecordAudio("1109511018", var_78_24)
						arg_75_1:RecordAudio("1109511018", var_78_24)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_25 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_25 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_25

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_25 and arg_75_1.time_ < var_78_15 + var_78_25 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109511019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109511019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109511020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10058ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10058ui_story == nil then
				arg_79_1.var_.characterEffect10058ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10058ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10058ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10058ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10058ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.5

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(1109511019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 20
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109511020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109511020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109511021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.525

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(1109511020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 21
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109511021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109511021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109511022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10058ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0
			local var_90_10 = 0.825

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:GetWordFromCfg(1109511021)
				local var_90_12 = arg_87_1:FormatText(var_90_11.content)

				arg_87_1.text_.text = var_90_12

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 33
				local var_90_14 = utf8.len(var_90_12)
				local var_90_15 = var_90_13 <= 0 and var_90_10 or var_90_10 * (var_90_14 / var_90_13)

				if var_90_15 > 0 and var_90_10 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_9 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_9
					end
				end

				arg_87_1.text_.text = var_90_12
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_10, arg_87_1.talkMaxDuration)

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_9) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_9 + var_90_16 and arg_87_1.time_ < var_90_9 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109511022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109511022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1109511023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.5

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(1109511022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 20
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109511023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109511023
		arg_95_1.duration_ = 6.2

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109511024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10058ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10058ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -0.98, -6.1)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10058ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["10058ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10058ui_story == nil then
				arg_95_1.var_.characterEffect10058ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect10058ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10058ui_story then
				arg_95_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action425")
			end

			local var_98_14 = 0
			local var_98_15 = 0.725

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_16 = arg_95_1:FormatText(StoryNameCfg[471].name)

				arg_95_1.leftNameTxt_.text = var_98_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_17 = arg_95_1:GetWordFromCfg(1109511023)
				local var_98_18 = arg_95_1:FormatText(var_98_17.content)

				arg_95_1.text_.text = var_98_18

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_19 = 29
				local var_98_20 = utf8.len(var_98_18)
				local var_98_21 = var_98_19 <= 0 and var_98_15 or var_98_15 * (var_98_20 / var_98_19)

				if var_98_21 > 0 and var_98_15 < var_98_21 then
					arg_95_1.talkMaxDuration = var_98_21

					if var_98_21 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_21 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_18
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb") ~= 0 then
					local var_98_22 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb") / 1000

					if var_98_22 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_14
					end

					if var_98_17.prefab_name ~= "" and arg_95_1.actors_[var_98_17.prefab_name] ~= nil then
						local var_98_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_17.prefab_name].transform, "story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")

						arg_95_1:RecordAudio("1109511023", var_98_23)
						arg_95_1:RecordAudio("1109511023", var_98_23)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_24 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_24 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_24

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_24 and arg_95_1.time_ < var_98_14 + var_98_24 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109511024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109511024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109511025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10058ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10058ui_story == nil then
				arg_99_1.var_.characterEffect10058ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect10058ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10058ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10058ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10058ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0
			local var_102_7 = 0.525

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_9 = arg_99_1:GetWordFromCfg(1109511024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 21
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109511025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109511025
		arg_103_1.duration_ = 8.73

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1109511026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10058ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10058ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_106_4 = 0
			local var_106_5 = 0.975

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_6 = arg_103_1:FormatText(StoryNameCfg[471].name)

				arg_103_1.leftNameTxt_.text = var_106_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(1109511025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 39
				local var_106_10 = utf8.len(var_106_8)
				local var_106_11 = var_106_9 <= 0 and var_106_5 or var_106_5 * (var_106_10 / var_106_9)

				if var_106_11 > 0 and var_106_5 < var_106_11 then
					arg_103_1.talkMaxDuration = var_106_11

					if var_106_11 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb") ~= 0 then
					local var_106_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb") / 1000

					if var_106_12 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_4
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")

						arg_103_1:RecordAudio("1109511025", var_106_13)
						arg_103_1:RecordAudio("1109511025", var_106_13)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_14 and arg_103_1.time_ < var_106_4 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109511026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109511026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109511027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10058ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10058ui_story == nil then
				arg_107_1.var_.characterEffect10058ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10058ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10058ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10058ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10058ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.25

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(1109511026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 10
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109511027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109511027
		arg_111_1.duration_ = 2.2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109511028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10058ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10058ui_story == nil then
				arg_111_1.var_.characterEffect10058ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10058ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10058ui_story then
				arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_114_5 = 0
			local var_114_6 = 0.15

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_7 = arg_111_1:FormatText(StoryNameCfg[471].name)

				arg_111_1.leftNameTxt_.text = var_114_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(1109511027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 6
				local var_114_11 = utf8.len(var_114_9)
				local var_114_12 = var_114_10 <= 0 and var_114_6 or var_114_6 * (var_114_11 / var_114_10)

				if var_114_12 > 0 and var_114_6 < var_114_12 then
					arg_111_1.talkMaxDuration = var_114_12

					if var_114_12 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb") ~= 0 then
					local var_114_13 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb") / 1000

					if var_114_13 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_5
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")

						arg_111_1:RecordAudio("1109511027", var_114_14)
						arg_111_1:RecordAudio("1109511027", var_114_14)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_15 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_15 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_15

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_15 and arg_111_1.time_ < var_114_5 + var_114_15 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109511028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109511028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1109511029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10058ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect10058ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10058ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10058ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10058ui_story.fillRatio = var_118_5
			end

			local var_118_6 = arg_115_1.actors_["10058ui_story"].transform
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = var_118_6.localPosition
			end

			local var_118_8 = 0.001

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8
				local var_118_10 = Vector3.New(0, 100, 0)

				var_118_6.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, var_118_10, var_118_9)

				local var_118_11 = manager.ui.mainCamera.transform.position - var_118_6.position

				var_118_6.forward = Vector3.New(var_118_11.x, var_118_11.y, var_118_11.z)

				local var_118_12 = var_118_6.localEulerAngles

				var_118_12.z = 0
				var_118_12.x = 0
				var_118_6.localEulerAngles = var_118_12
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 then
				var_118_6.localPosition = Vector3.New(0, 100, 0)

				local var_118_13 = manager.ui.mainCamera.transform.position - var_118_6.position

				var_118_6.forward = Vector3.New(var_118_13.x, var_118_13.y, var_118_13.z)

				local var_118_14 = var_118_6.localEulerAngles

				var_118_14.z = 0
				var_118_14.x = 0
				var_118_6.localEulerAngles = var_118_14
			end

			local var_118_15 = 0
			local var_118_16 = 0.85

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:GetWordFromCfg(1109511028)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 34
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_16 or var_118_16 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_16 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_22 and arg_115_1.time_ < var_118_15 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109511029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109511029
		arg_119_1.duration_ = 1

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"

			SetActive(arg_119_1.choicesGo_, true)

			for iter_120_0, iter_120_1 in ipairs(arg_119_1.choices_) do
				local var_120_0 = iter_120_0 <= 2

				SetActive(iter_120_1.go, var_120_0)
			end

			arg_119_1.choices_[1].txt.text = arg_119_1:FormatText(StoryChoiceCfg[1746].name)
			arg_119_1.choices_[2].txt.text = arg_119_1:FormatText(StoryChoiceCfg[1747].name)
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109511030(arg_119_1)
			end

			if arg_121_0 == 2 then
				arg_119_0:Play1109511030(arg_119_1)
			end

			arg_119_1:RecordChoiceLog(1109511029, 1746, 1747)
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			return
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109511030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109511030
		arg_123_1.duration_ = 2.13

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1109511031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10058ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10058ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -0.98, -6.1)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10058ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["10058ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect10058ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_126_13 = "10058ui_story"

			if arg_123_1.actors_[var_126_13] == nil then
				local var_126_14 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_126_14) then
					local var_126_15 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_123_1.stage_.transform)

					var_126_15.name = var_126_13
					var_126_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_123_1.actors_[var_126_13] = var_126_15

					local var_126_16 = var_126_15:GetComponentInChildren(typeof(CharacterEffect))

					var_126_16.enabled = true

					local var_126_17 = GameObjectTools.GetOrAddComponent(var_126_15, typeof(DynamicBoneHelper))

					if var_126_17 then
						var_126_17:EnableDynamicBone(false)
					end

					arg_123_1:ShowWeapon(var_126_16.transform, false)

					arg_123_1.var_[var_126_13 .. "Animator"] = var_126_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_123_1.var_[var_126_13 .. "Animator"].applyRootMotion = true
					arg_123_1.var_[var_126_13 .. "LipSync"] = var_126_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_126_18 = 0

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_126_19 = "10058ui_story"

			if arg_123_1.actors_[var_126_19] == nil then
				local var_126_20 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_126_20) then
					local var_126_21 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_123_1.stage_.transform)

					var_126_21.name = var_126_19
					var_126_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_123_1.actors_[var_126_19] = var_126_21

					local var_126_22 = var_126_21:GetComponentInChildren(typeof(CharacterEffect))

					var_126_22.enabled = true

					local var_126_23 = GameObjectTools.GetOrAddComponent(var_126_21, typeof(DynamicBoneHelper))

					if var_126_23 then
						var_126_23:EnableDynamicBone(false)
					end

					arg_123_1:ShowWeapon(var_126_22.transform, false)

					arg_123_1.var_[var_126_19 .. "Animator"] = var_126_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_123_1.var_[var_126_19 .. "Animator"].applyRootMotion = true
					arg_123_1.var_[var_126_19 .. "LipSync"] = var_126_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_126_24 = 0

			if var_126_24 < arg_123_1.time_ and arg_123_1.time_ <= var_126_24 + arg_126_0 then
				arg_123_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_25 = 0
			local var_126_26 = 0.2

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_27 = arg_123_1:FormatText(StoryNameCfg[471].name)

				arg_123_1.leftNameTxt_.text = var_126_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_28 = arg_123_1:GetWordFromCfg(1109511030)
				local var_126_29 = arg_123_1:FormatText(var_126_28.content)

				arg_123_1.text_.text = var_126_29

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_30 = 8
				local var_126_31 = utf8.len(var_126_29)
				local var_126_32 = var_126_30 <= 0 and var_126_26 or var_126_26 * (var_126_31 / var_126_30)

				if var_126_32 > 0 and var_126_26 < var_126_32 then
					arg_123_1.talkMaxDuration = var_126_32

					if var_126_32 + var_126_25 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_32 + var_126_25
					end
				end

				arg_123_1.text_.text = var_126_29
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb") ~= 0 then
					local var_126_33 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb") / 1000

					if var_126_33 + var_126_25 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_33 + var_126_25
					end

					if var_126_28.prefab_name ~= "" and arg_123_1.actors_[var_126_28.prefab_name] ~= nil then
						local var_126_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_28.prefab_name].transform, "story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")

						arg_123_1:RecordAudio("1109511030", var_126_34)
						arg_123_1:RecordAudio("1109511030", var_126_34)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_35 = math.max(var_126_26, arg_123_1.talkMaxDuration)

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_35 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_25) / var_126_35

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_25 + var_126_35 and arg_123_1.time_ < var_126_25 + var_126_35 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play1109511031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109511031
		arg_127_1.duration_ = 9.07

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109511032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.95

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[471].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(1109511031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")

						arg_127_1:RecordAudio("1109511031", var_130_9)
						arg_127_1:RecordAudio("1109511031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")
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
	Play1109511032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109511032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1109511033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10058ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10058ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10058ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10058ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10058ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.5

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(1109511032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 20
				local var_134_11 = utf8.len(var_134_9)
				local var_134_12 = var_134_10 <= 0 and var_134_7 or var_134_7 * (var_134_11 / var_134_10)

				if var_134_12 > 0 and var_134_7 < var_134_12 then
					arg_131_1.talkMaxDuration = var_134_12

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_13 and arg_131_1.time_ < var_134_6 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1109511033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109511033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1109511034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.525

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(1109511033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 21
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1109511034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109511034
		arg_139_1.duration_ = 3.57

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109511035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10058ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10058ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_142_6 = 0
			local var_142_7 = 0.5

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_9 = arg_139_1:GetWordFromCfg(1109511034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 20
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")

						arg_139_1:RecordAudio("1109511034", var_142_15)
						arg_139_1:RecordAudio("1109511034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1109511035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109511035
		arg_143_1.duration_ = 6.7

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109511036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.7

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[471].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(1109511035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 28
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")

						arg_143_1:RecordAudio("1109511035", var_146_9)
						arg_143_1:RecordAudio("1109511035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109511036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109511036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109511037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10058ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10058ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.625

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_9 = arg_147_1:GetWordFromCfg(1109511036)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 25
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109511037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109511037
		arg_151_1.duration_ = 6.8

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109511038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10058ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10058ui_story == nil then
				arg_151_1.var_.characterEffect10058ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10058ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10058ui_story then
				arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_154_6 = 0
			local var_154_7 = 0.55

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[471].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(1109511037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 22
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")

						arg_151_1:RecordAudio("1109511037", var_154_15)
						arg_151_1:RecordAudio("1109511037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109511038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109511038
		arg_155_1.duration_ = 6.7

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109511039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.7

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[471].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(1109511038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")

						arg_155_1:RecordAudio("1109511038", var_158_9)
						arg_155_1:RecordAudio("1109511038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")
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
	Play1109511039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109511039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109511040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10058ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10058ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.075

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(1109511039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 3
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109511040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109511040
		arg_163_1.duration_ = 9.3

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1109511041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10058ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10058ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10058ui_story then
				arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.725

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[471].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(1109511040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 29
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb") / 1000

					if var_166_14 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_6
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")

						arg_163_1:RecordAudio("1109511040", var_166_15)
						arg_163_1:RecordAudio("1109511040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_16 and arg_163_1.time_ < var_166_6 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109511041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109511041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109511042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10058ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10058ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.375

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(1109511041)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 15
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109511042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109511042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109511043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.55

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(1109511042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 22
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109511043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109511043
		arg_175_1.duration_ = 5.6

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109511044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10058ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story then
				arg_175_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_178_4 = 0

			if var_178_4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_6 = 0
			local var_178_7 = 0.7

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[471].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_9 = arg_175_1:GetWordFromCfg(1109511043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 28
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb") / 1000

					if var_178_14 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_6
					end

					if var_178_9.prefab_name ~= "" and arg_175_1.actors_[var_178_9.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_9.prefab_name].transform, "story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")

						arg_175_1:RecordAudio("1109511043", var_178_15)
						arg_175_1:RecordAudio("1109511043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_16 and arg_175_1.time_ < var_178_6 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1109511044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109511044
		arg_179_1.duration_ = 7.6

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109511045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.675

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[471].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(1109511044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 27
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")

						arg_179_1:RecordAudio("1109511044", var_182_9)
						arg_179_1:RecordAudio("1109511044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109511045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109511045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109511046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10058ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect10058ui_story == nil then
				arg_183_1.var_.characterEffect10058ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect10058ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10058ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect10058ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10058ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.975

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(1109511045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 39
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
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109511046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109511046
		arg_187_1.duration_ = 11.33

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109511047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10058ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 1.05

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_6 = arg_187_1:FormatText(StoryNameCfg[471].name)

				arg_187_1.leftNameTxt_.text = var_190_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(1109511046)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 42
				local var_190_10 = utf8.len(var_190_8)
				local var_190_11 = var_190_9 <= 0 and var_190_5 or var_190_5 * (var_190_10 / var_190_9)

				if var_190_11 > 0 and var_190_5 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb") ~= 0 then
					local var_190_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb") / 1000

					if var_190_12 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_4
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")

						arg_187_1:RecordAudio("1109511046", var_190_13)
						arg_187_1:RecordAudio("1109511046", var_190_13)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_14 and arg_187_1.time_ < var_190_4 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109511047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109511047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109511048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10058ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10058ui_story == nil then
				arg_191_1.var_.characterEffect10058ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10058ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10058ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.2

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(1109511047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 8
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1109511048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109511048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109511049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10058ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, var_198_4, var_198_3)

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

			local var_198_9 = 0.3
			local var_198_10 = 1

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				local var_198_11 = "play"
				local var_198_12 = "effect"

				arg_195_1:AudioAction(var_198_11, var_198_12, "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_198_13 = 0
			local var_198_14 = 0.85

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_15 = arg_195_1:GetWordFromCfg(1109511048)
				local var_198_16 = arg_195_1:FormatText(var_198_15.content)

				arg_195_1.text_.text = var_198_16

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_17 = 34
				local var_198_18 = utf8.len(var_198_16)
				local var_198_19 = var_198_17 <= 0 and var_198_14 or var_198_14 * (var_198_18 / var_198_17)

				if var_198_19 > 0 and var_198_14 < var_198_19 then
					arg_195_1.talkMaxDuration = var_198_19

					if var_198_19 + var_198_13 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_19 + var_198_13
					end
				end

				arg_195_1.text_.text = var_198_16
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_14, arg_195_1.talkMaxDuration)

			if var_198_13 <= arg_195_1.time_ and arg_195_1.time_ < var_198_13 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_13) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_13 + var_198_20 and arg_195_1.time_ < var_198_13 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109511049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109511049
		arg_199_1.duration_ = 3.43

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1109511050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10058ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10058ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -0.98, -6.1)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10058ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["10058ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect10058ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10058ui_story then
				arg_199_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.325

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[471].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(1109511049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 13
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")

						arg_199_1:RecordAudio("1109511049", var_202_24)
						arg_199_1:RecordAudio("1109511049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109511050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109511050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1109511051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10058ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect10058ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10058ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10058ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10058ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.65

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(1109511050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 26
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109511051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109511051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109511052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.65

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(1109511051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 26
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
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109511052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109511052
		arg_211_1.duration_ = 6.48

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109511053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = "X203K"

			if arg_211_1.bgs_[var_214_0] == nil then
				local var_214_1 = Object.Instantiate(arg_211_1.paintGo_)

				var_214_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_214_0)
				var_214_1.name = var_214_0
				var_214_1.transform.parent = arg_211_1.stage_.transform
				var_214_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.bgs_[var_214_0] = var_214_1
			end

			local var_214_2 = 1.71666666666667

			if var_214_2 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				local var_214_3 = manager.ui.mainCamera.transform.localPosition
				local var_214_4 = Vector3.New(0, 0, 10) + Vector3.New(var_214_3.x, var_214_3.y, 0)
				local var_214_5 = arg_211_1.bgs_.X203K

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
					if iter_214_0 ~= "X203K" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_16 = 1.71666666666667

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

			local var_214_19 = 1.71666666666667

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

			local var_214_23 = 1.71666666666667

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

			local var_214_29 = arg_211_1.actors_["10058ui_story"].transform
			local var_214_30 = 1.71666666666667

			if var_214_30 < arg_211_1.time_ and arg_211_1.time_ <= var_214_30 + arg_214_0 then
				arg_211_1.var_.moveOldPos10058ui_story = var_214_29.localPosition
			end

			local var_214_31 = 0.001

			if var_214_30 <= arg_211_1.time_ and arg_211_1.time_ < var_214_30 + var_214_31 then
				local var_214_32 = (arg_211_1.time_ - var_214_30) / var_214_31
				local var_214_33 = Vector3.New(0, 100, 0)

				var_214_29.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10058ui_story, var_214_33, var_214_32)

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

			local var_214_38 = arg_211_1.actors_["10058ui_story"].transform
			local var_214_39 = 3.28333333333333

			if var_214_39 < arg_211_1.time_ and arg_211_1.time_ <= var_214_39 + arg_214_0 then
				arg_211_1.var_.moveOldPos10058ui_story = var_214_38.localPosition
			end

			local var_214_40 = 0.001

			if var_214_39 <= arg_211_1.time_ and arg_211_1.time_ < var_214_39 + var_214_40 then
				local var_214_41 = (arg_211_1.time_ - var_214_39) / var_214_40
				local var_214_42 = Vector3.New(0, -0.98, -6.1)

				var_214_38.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10058ui_story, var_214_42, var_214_41)

				local var_214_43 = manager.ui.mainCamera.transform.position - var_214_38.position

				var_214_38.forward = Vector3.New(var_214_43.x, var_214_43.y, var_214_43.z)

				local var_214_44 = var_214_38.localEulerAngles

				var_214_44.z = 0
				var_214_44.x = 0
				var_214_38.localEulerAngles = var_214_44
			end

			if arg_211_1.time_ >= var_214_39 + var_214_40 and arg_211_1.time_ < var_214_39 + var_214_40 + arg_214_0 then
				var_214_38.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_214_45 = manager.ui.mainCamera.transform.position - var_214_38.position

				var_214_38.forward = Vector3.New(var_214_45.x, var_214_45.y, var_214_45.z)

				local var_214_46 = var_214_38.localEulerAngles

				var_214_46.z = 0
				var_214_46.x = 0
				var_214_38.localEulerAngles = var_214_46
			end

			local var_214_47 = arg_211_1.actors_["10058ui_story"]
			local var_214_48 = 3.28333333333333

			if var_214_48 < arg_211_1.time_ and arg_211_1.time_ <= var_214_48 + arg_214_0 and not isNil(var_214_47) and arg_211_1.var_.characterEffect10058ui_story == nil then
				arg_211_1.var_.characterEffect10058ui_story = var_214_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_49 = 0.200000002980232

			if var_214_48 <= arg_211_1.time_ and arg_211_1.time_ < var_214_48 + var_214_49 and not isNil(var_214_47) then
				local var_214_50 = (arg_211_1.time_ - var_214_48) / var_214_49

				if arg_211_1.var_.characterEffect10058ui_story and not isNil(var_214_47) then
					arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_48 + var_214_49 and arg_211_1.time_ < var_214_48 + var_214_49 + arg_214_0 and not isNil(var_214_47) and arg_211_1.var_.characterEffect10058ui_story then
				arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_214_51 = 3.28333333333333

			if var_214_51 < arg_211_1.time_ and arg_211_1.time_ <= var_214_51 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_214_52 = 3.28333333333333

			if var_214_52 < arg_211_1.time_ and arg_211_1.time_ <= var_214_52 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_53 = 3.55
			local var_214_54 = 0.35

			if var_214_53 < arg_211_1.time_ and arg_211_1.time_ <= var_214_53 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_55 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_55:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_56 = arg_211_1:FormatText(StoryNameCfg[471].name)

				arg_211_1.leftNameTxt_.text = var_214_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_57 = arg_211_1:GetWordFromCfg(1109511052)
				local var_214_58 = arg_211_1:FormatText(var_214_57.content)

				arg_211_1.text_.text = var_214_58

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_59 = 14
				local var_214_60 = utf8.len(var_214_58)
				local var_214_61 = var_214_59 <= 0 and var_214_54 or var_214_54 * (var_214_60 / var_214_59)

				if var_214_61 > 0 and var_214_54 < var_214_61 then
					arg_211_1.talkMaxDuration = var_214_61
					var_214_53 = var_214_53 + 0.3

					if var_214_61 + var_214_53 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_61 + var_214_53
					end
				end

				arg_211_1.text_.text = var_214_58
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb") ~= 0 then
					local var_214_62 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb") / 1000

					if var_214_62 + var_214_53 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_62 + var_214_53
					end

					if var_214_57.prefab_name ~= "" and arg_211_1.actors_[var_214_57.prefab_name] ~= nil then
						local var_214_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_57.prefab_name].transform, "story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")

						arg_211_1:RecordAudio("1109511052", var_214_63)
						arg_211_1:RecordAudio("1109511052", var_214_63)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_64 = var_214_53 + 0.3
			local var_214_65 = math.max(var_214_54, arg_211_1.talkMaxDuration)

			if var_214_64 <= arg_211_1.time_ and arg_211_1.time_ < var_214_64 + var_214_65 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_64) / var_214_65

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_64 + var_214_65 and arg_211_1.time_ < var_214_64 + var_214_65 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.71666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.28333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109511053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109511053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109511054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10058ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10058ui_story == nil then
				arg_217_1.var_.characterEffect10058ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect10058ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10058ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10058ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10058ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.725

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1109511053)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 29
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109511054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109511054
		arg_221_1.duration_ = 2.8

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109511055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10058ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10058ui_story == nil then
				arg_221_1.var_.characterEffect10058ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect10058ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10058ui_story then
				arg_221_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_224_4 = 0
			local var_224_5 = 0.325

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_6 = arg_221_1:FormatText(StoryNameCfg[471].name)

				arg_221_1.leftNameTxt_.text = var_224_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(1109511054)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb") / 1000

					if var_224_12 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_4
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")

						arg_221_1:RecordAudio("1109511054", var_224_13)
						arg_221_1:RecordAudio("1109511054", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")
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
	Play1109511055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109511055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109511056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10058ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10058ui_story == nil then
				arg_225_1.var_.characterEffect10058ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect10058ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10058ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10058ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10058ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.425

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(1109511055)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 17
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109511056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109511056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109511057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10058ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10058ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, 100, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10058ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, 100, 0)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = 0
			local var_232_10 = 0.95

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_11 = arg_229_1:GetWordFromCfg(1109511056)
				local var_232_12 = arg_229_1:FormatText(var_232_11.content)

				arg_229_1.text_.text = var_232_12

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 38
				local var_232_14 = utf8.len(var_232_12)
				local var_232_15 = var_232_13 <= 0 and var_232_10 or var_232_10 * (var_232_14 / var_232_13)

				if var_232_15 > 0 and var_232_10 < var_232_15 then
					arg_229_1.talkMaxDuration = var_232_15

					if var_232_15 + var_232_9 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_9
					end
				end

				arg_229_1.text_.text = var_232_12
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_10, arg_229_1.talkMaxDuration)

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_9) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_9 + var_232_16 and arg_229_1.time_ < var_232_9 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109511057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109511057
		arg_233_1.duration_ = 3.6

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109511058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10058ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect10058ui_story == nil then
				arg_233_1.var_.characterEffect10058ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect10058ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect10058ui_story then
				arg_233_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["10058ui_story"].transform
			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.var_.moveOldPos10058ui_story = var_236_4.localPosition
			end

			local var_236_6 = 0.001

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6
				local var_236_8 = Vector3.New(0, -0.98, -6.1)

				var_236_4.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10058ui_story, var_236_8, var_236_7)

				local var_236_9 = manager.ui.mainCamera.transform.position - var_236_4.position

				var_236_4.forward = Vector3.New(var_236_9.x, var_236_9.y, var_236_9.z)

				local var_236_10 = var_236_4.localEulerAngles

				var_236_10.z = 0
				var_236_10.x = 0
				var_236_4.localEulerAngles = var_236_10
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				var_236_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_236_11 = manager.ui.mainCamera.transform.position - var_236_4.position

				var_236_4.forward = Vector3.New(var_236_11.x, var_236_11.y, var_236_11.z)

				local var_236_12 = var_236_4.localEulerAngles

				var_236_12.z = 0
				var_236_12.x = 0
				var_236_4.localEulerAngles = var_236_12
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_236_14 = 0
			local var_236_15 = 0.325

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_16 = arg_233_1:FormatText(StoryNameCfg[471].name)

				arg_233_1.leftNameTxt_.text = var_236_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_17 = arg_233_1:GetWordFromCfg(1109511057)
				local var_236_18 = arg_233_1:FormatText(var_236_17.content)

				arg_233_1.text_.text = var_236_18

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_19 = 13
				local var_236_20 = utf8.len(var_236_18)
				local var_236_21 = var_236_19 <= 0 and var_236_15 or var_236_15 * (var_236_20 / var_236_19)

				if var_236_21 > 0 and var_236_15 < var_236_21 then
					arg_233_1.talkMaxDuration = var_236_21

					if var_236_21 + var_236_14 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_21 + var_236_14
					end
				end

				arg_233_1.text_.text = var_236_18
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb") ~= 0 then
					local var_236_22 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb") / 1000

					if var_236_22 + var_236_14 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_14
					end

					if var_236_17.prefab_name ~= "" and arg_233_1.actors_[var_236_17.prefab_name] ~= nil then
						local var_236_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_17.prefab_name].transform, "story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")

						arg_233_1:RecordAudio("1109511057", var_236_23)
						arg_233_1:RecordAudio("1109511057", var_236_23)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_24 = math.max(var_236_15, arg_233_1.talkMaxDuration)

			if var_236_14 <= arg_233_1.time_ and arg_233_1.time_ < var_236_14 + var_236_24 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_14) / var_236_24

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_14 + var_236_24 and arg_233_1.time_ < var_236_14 + var_236_24 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109511058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109511058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109511059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10058ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10058ui_story == nil then
				arg_237_1.var_.characterEffect10058ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect10058ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10058ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10058ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10058ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.075

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(1109511058)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 3
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109511059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109511059
		arg_241_1.duration_ = 2.9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109511060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10058ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10058ui_story == nil then
				arg_241_1.var_.characterEffect10058ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect10058ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10058ui_story then
				arg_241_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_244_4 = 0

			if var_244_4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_6 = 0
			local var_244_7 = 0.3

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[471].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:GetWordFromCfg(1109511059)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 12
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb") / 1000

					if var_244_14 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_6
					end

					if var_244_9.prefab_name ~= "" and arg_241_1.actors_[var_244_9.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_9.prefab_name].transform, "story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")

						arg_241_1:RecordAudio("1109511059", var_244_15)
						arg_241_1:RecordAudio("1109511059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_16 and arg_241_1.time_ < var_244_6 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109511060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109511060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109511061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10058ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10058ui_story == nil then
				arg_245_1.var_.characterEffect10058ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect10058ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10058ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10058ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10058ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.675

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(1109511060)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 27
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1109511061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109511061
		arg_249_1.duration_ = 4.6

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109511062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10058ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10058ui_story == nil then
				arg_249_1.var_.characterEffect10058ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect10058ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10058ui_story then
				arg_249_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_252_4 = 0
			local var_252_5 = 0.45

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_6 = arg_249_1:FormatText(StoryNameCfg[471].name)

				arg_249_1.leftNameTxt_.text = var_252_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(1109511061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 18
				local var_252_10 = utf8.len(var_252_8)
				local var_252_11 = var_252_9 <= 0 and var_252_5 or var_252_5 * (var_252_10 / var_252_9)

				if var_252_11 > 0 and var_252_5 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb") ~= 0 then
					local var_252_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb") / 1000

					if var_252_12 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_4
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")

						arg_249_1:RecordAudio("1109511061", var_252_13)
						arg_249_1:RecordAudio("1109511061", var_252_13)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_14 and arg_249_1.time_ < var_252_4 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109511062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109511062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109511063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10058ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10058ui_story == nil then
				arg_253_1.var_.characterEffect10058ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10058ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10058ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10058ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10058ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.25

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(1109511062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 10
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109511063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109511063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109511064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.85

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(1109511063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 34
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
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109511064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109511064
		arg_261_1.duration_ = 3.17

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109511065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10058ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10058ui_story == nil then
				arg_261_1.var_.characterEffect10058ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect10058ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10058ui_story then
				arg_261_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_264_4 = 0
			local var_264_5 = 1

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				local var_264_6 = "play"
				local var_264_7 = "effect"

				arg_261_1:AudioAction(var_264_6, var_264_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_264_8 = 0
			local var_264_9 = 0.325

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_10 = arg_261_1:FormatText(StoryNameCfg[471].name)

				arg_261_1.leftNameTxt_.text = var_264_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_11 = arg_261_1:GetWordFromCfg(1109511064)
				local var_264_12 = arg_261_1:FormatText(var_264_11.content)

				arg_261_1.text_.text = var_264_12

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 13
				local var_264_14 = utf8.len(var_264_12)
				local var_264_15 = var_264_13 <= 0 and var_264_9 or var_264_9 * (var_264_14 / var_264_13)

				if var_264_15 > 0 and var_264_9 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_12
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb") ~= 0 then
					local var_264_16 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb") / 1000

					if var_264_16 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_8
					end

					if var_264_11.prefab_name ~= "" and arg_261_1.actors_[var_264_11.prefab_name] ~= nil then
						local var_264_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_11.prefab_name].transform, "story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")

						arg_261_1:RecordAudio("1109511064", var_264_17)
						arg_261_1:RecordAudio("1109511064", var_264_17)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_18 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_18

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_18 and arg_261_1.time_ < var_264_8 + var_264_18 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1109511065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109511065
		arg_265_1.duration_ = 8.05

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1109511066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = "X203g"

			if arg_265_1.bgs_[var_268_0] == nil then
				local var_268_1 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_268_0)
				var_268_1.name = var_268_0
				var_268_1.transform.parent = arg_265_1.stage_.transform
				var_268_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_[var_268_0] = var_268_1
			end

			local var_268_2 = 1.46666666666667

			if var_268_2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				local var_268_3 = manager.ui.mainCamera.transform.localPosition
				local var_268_4 = Vector3.New(0, 0, 10) + Vector3.New(var_268_3.x, var_268_3.y, 0)
				local var_268_5 = arg_265_1.bgs_.X203g

				var_268_5.transform.localPosition = var_268_4
				var_268_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_6 = var_268_5:GetComponent("SpriteRenderer")

				if var_268_6 and var_268_6.sprite then
					local var_268_7 = (var_268_5.transform.localPosition - var_268_3).z
					local var_268_8 = manager.ui.mainCameraCom_
					local var_268_9 = 2 * var_268_7 * Mathf.Tan(var_268_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_268_10 = var_268_9 * var_268_8.aspect
					local var_268_11 = var_268_6.sprite.bounds.size.x
					local var_268_12 = var_268_6.sprite.bounds.size.y
					local var_268_13 = var_268_10 / var_268_11
					local var_268_14 = var_268_9 / var_268_12
					local var_268_15 = var_268_14 < var_268_13 and var_268_13 or var_268_14

					var_268_5.transform.localScale = Vector3.New(var_268_15, var_268_15, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "X203g" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_16 = 1.46666666666667

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_17 = 0.3

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_18 = 0

			if var_268_18 < arg_265_1.time_ and arg_265_1.time_ <= var_268_18 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_19 = 1.46666666666667

			if var_268_18 <= arg_265_1.time_ and arg_265_1.time_ < var_268_18 + var_268_19 then
				local var_268_20 = (arg_265_1.time_ - var_268_18) / var_268_19
				local var_268_21 = Color.New(0, 0, 0)

				var_268_21.a = Mathf.Lerp(0, 1, var_268_20)
				arg_265_1.mask_.color = var_268_21
			end

			if arg_265_1.time_ >= var_268_18 + var_268_19 and arg_265_1.time_ < var_268_18 + var_268_19 + arg_268_0 then
				local var_268_22 = Color.New(0, 0, 0)

				var_268_22.a = 1
				arg_265_1.mask_.color = var_268_22
			end

			local var_268_23 = 1.46666666666667

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_24 = 2

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_24 then
				local var_268_25 = (arg_265_1.time_ - var_268_23) / var_268_24
				local var_268_26 = Color.New(0, 0, 0)

				var_268_26.a = Mathf.Lerp(1, 0, var_268_25)
				arg_265_1.mask_.color = var_268_26
			end

			if arg_265_1.time_ >= var_268_23 + var_268_24 and arg_265_1.time_ < var_268_23 + var_268_24 + arg_268_0 then
				local var_268_27 = Color.New(0, 0, 0)
				local var_268_28 = 0

				arg_265_1.mask_.enabled = false
				var_268_27.a = var_268_28
				arg_265_1.mask_.color = var_268_27
			end

			local var_268_29 = arg_265_1.actors_["10058ui_story"].transform
			local var_268_30 = 1.46666666666667

			if var_268_30 < arg_265_1.time_ and arg_265_1.time_ <= var_268_30 + arg_268_0 then
				arg_265_1.var_.moveOldPos10058ui_story = var_268_29.localPosition
			end

			local var_268_31 = 0.001

			if var_268_30 <= arg_265_1.time_ and arg_265_1.time_ < var_268_30 + var_268_31 then
				local var_268_32 = (arg_265_1.time_ - var_268_30) / var_268_31
				local var_268_33 = Vector3.New(0, 100, 0)

				var_268_29.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10058ui_story, var_268_33, var_268_32)

				local var_268_34 = manager.ui.mainCamera.transform.position - var_268_29.position

				var_268_29.forward = Vector3.New(var_268_34.x, var_268_34.y, var_268_34.z)

				local var_268_35 = var_268_29.localEulerAngles

				var_268_35.z = 0
				var_268_35.x = 0
				var_268_29.localEulerAngles = var_268_35
			end

			if arg_265_1.time_ >= var_268_30 + var_268_31 and arg_265_1.time_ < var_268_30 + var_268_31 + arg_268_0 then
				var_268_29.localPosition = Vector3.New(0, 100, 0)

				local var_268_36 = manager.ui.mainCamera.transform.position - var_268_29.position

				var_268_29.forward = Vector3.New(var_268_36.x, var_268_36.y, var_268_36.z)

				local var_268_37 = var_268_29.localEulerAngles

				var_268_37.z = 0
				var_268_37.x = 0
				var_268_29.localEulerAngles = var_268_37
			end

			local var_268_38 = arg_265_1.actors_["10058ui_story"]
			local var_268_39 = 1.46666666666667

			if var_268_39 < arg_265_1.time_ and arg_265_1.time_ <= var_268_39 + arg_268_0 and not isNil(var_268_38) and arg_265_1.var_.characterEffect10058ui_story == nil then
				arg_265_1.var_.characterEffect10058ui_story = var_268_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_40 = 0.200000002980232

			if var_268_39 <= arg_265_1.time_ and arg_265_1.time_ < var_268_39 + var_268_40 and not isNil(var_268_38) then
				local var_268_41 = (arg_265_1.time_ - var_268_39) / var_268_40

				if arg_265_1.var_.characterEffect10058ui_story and not isNil(var_268_38) then
					local var_268_42 = Mathf.Lerp(0, 0.5, var_268_41)

					arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10058ui_story.fillRatio = var_268_42
				end
			end

			if arg_265_1.time_ >= var_268_39 + var_268_40 and arg_265_1.time_ < var_268_39 + var_268_40 + arg_268_0 and not isNil(var_268_38) and arg_265_1.var_.characterEffect10058ui_story then
				local var_268_43 = 0.5

				arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10058ui_story.fillRatio = var_268_43
			end

			local var_268_44 = 1
			local var_268_45 = 1

			if var_268_44 < arg_265_1.time_ and arg_265_1.time_ <= var_268_44 + arg_268_0 then
				local var_268_46 = "play"
				local var_268_47 = "effect"

				arg_265_1:AudioAction(var_268_46, var_268_47, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_268_48 = 0.2
			local var_268_49 = 1

			if var_268_48 < arg_265_1.time_ and arg_265_1.time_ <= var_268_48 + arg_268_0 then
				local var_268_50 = "stop"
				local var_268_51 = "effect"

				arg_265_1:AudioAction(var_268_50, var_268_51, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_268_52 = 1.4
			local var_268_53 = 1

			if var_268_52 < arg_265_1.time_ and arg_265_1.time_ <= var_268_52 + arg_268_0 then
				local var_268_54 = "play"
				local var_268_55 = "effect"

				arg_265_1:AudioAction(var_268_54, var_268_55, "se_story_139", "se_story_139_bed", "")
			end

			local var_268_56 = 1
			local var_268_57 = 1

			if var_268_56 < arg_265_1.time_ and arg_265_1.time_ <= var_268_56 + arg_268_0 then
				local var_268_58 = "play"
				local var_268_59 = "music"

				arg_265_1:AudioAction(var_268_58, var_268_59, "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day.awb")

				local var_268_60 = ""
				local var_268_61 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day")

				if var_268_61 ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_61 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_61

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_61
						arg_265_1.bgmTxt2_.text = var_268_61
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_62 = 3.05
			local var_268_63 = 0.9

			if var_268_62 < arg_265_1.time_ and arg_265_1.time_ <= var_268_62 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_64 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_64:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_265_1.dialogCg_.alpha = arg_270_0
				end))
				var_268_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_65 = arg_265_1:GetWordFromCfg(1109511065)
				local var_268_66 = arg_265_1:FormatText(var_268_65.content)

				arg_265_1.text_.text = var_268_66

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_67 = 36
				local var_268_68 = utf8.len(var_268_66)
				local var_268_69 = var_268_67 <= 0 and var_268_63 or var_268_63 * (var_268_68 / var_268_67)

				if var_268_69 > 0 and var_268_63 < var_268_69 then
					arg_265_1.talkMaxDuration = var_268_69
					var_268_62 = var_268_62 + 0.3

					if var_268_69 + var_268_62 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_69 + var_268_62
					end
				end

				arg_265_1.text_.text = var_268_66
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_70 = var_268_62 + 0.3
			local var_268_71 = math.max(var_268_63, arg_265_1.talkMaxDuration)

			if var_268_70 <= arg_265_1.time_ and arg_265_1.time_ < var_268_70 + var_268_71 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_70) / var_268_71

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_70 + var_268_71 and arg_265_1.time_ < var_268_70 + var_268_71 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109511066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1109511066
		arg_272_1.duration_ = 4.63

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1109511067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10058ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos10058ui_story = var_275_0.localPosition
			end

			local var_275_2 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2
				local var_275_4 = Vector3.New(0, 100, 0)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10058ui_story, var_275_4, var_275_3)

				local var_275_5 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_5.x, var_275_5.y, var_275_5.z)

				local var_275_6 = var_275_0.localEulerAngles

				var_275_6.z = 0
				var_275_6.x = 0
				var_275_0.localEulerAngles = var_275_6
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, 100, 0)

				local var_275_7 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_7.x, var_275_7.y, var_275_7.z)

				local var_275_8 = var_275_0.localEulerAngles

				var_275_8.z = 0
				var_275_8.x = 0
				var_275_0.localEulerAngles = var_275_8
			end

			local var_275_9 = arg_272_1.actors_["10058ui_story"]
			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect10058ui_story == nil then
				arg_272_1.var_.characterEffect10058ui_story = var_275_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_11 = 0.200000002980232

			if var_275_10 <= arg_272_1.time_ and arg_272_1.time_ < var_275_10 + var_275_11 and not isNil(var_275_9) then
				local var_275_12 = (arg_272_1.time_ - var_275_10) / var_275_11

				if arg_272_1.var_.characterEffect10058ui_story and not isNil(var_275_9) then
					arg_272_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_10 + var_275_11 and arg_272_1.time_ < var_275_10 + var_275_11 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect10058ui_story then
				arg_272_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_275_13 = 0

			if var_275_13 < arg_272_1.time_ and arg_272_1.time_ <= var_275_13 + arg_275_0 then
				arg_272_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_275_14 = 0

			if var_275_14 < arg_272_1.time_ and arg_272_1.time_ <= var_275_14 + arg_275_0 then
				arg_272_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_15 = 0
			local var_275_16 = 0.375

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_17 = arg_272_1:FormatText(StoryNameCfg[471].name)

				arg_272_1.leftNameTxt_.text = var_275_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_18 = arg_272_1:GetWordFromCfg(1109511066)
				local var_275_19 = arg_272_1:FormatText(var_275_18.content)

				arg_272_1.text_.text = var_275_19

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_20 = 15
				local var_275_21 = utf8.len(var_275_19)
				local var_275_22 = var_275_20 <= 0 and var_275_16 or var_275_16 * (var_275_21 / var_275_20)

				if var_275_22 > 0 and var_275_16 < var_275_22 then
					arg_272_1.talkMaxDuration = var_275_22

					if var_275_22 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_22 + var_275_15
					end
				end

				arg_272_1.text_.text = var_275_19
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb") ~= 0 then
					local var_275_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb") / 1000

					if var_275_23 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_23 + var_275_15
					end

					if var_275_18.prefab_name ~= "" and arg_272_1.actors_[var_275_18.prefab_name] ~= nil then
						local var_275_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_18.prefab_name].transform, "story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")

						arg_272_1:RecordAudio("1109511066", var_275_24)
						arg_272_1:RecordAudio("1109511066", var_275_24)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_25 = math.max(var_275_16, arg_272_1.talkMaxDuration)

			if var_275_15 <= arg_272_1.time_ and arg_272_1.time_ < var_275_15 + var_275_25 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_15) / var_275_25

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_15 + var_275_25 and arg_272_1.time_ < var_275_15 + var_275_25 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play1109511067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1109511067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1109511068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10058ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10058ui_story == nil then
				arg_276_1.var_.characterEffect10058ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect10058ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10058ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10058ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10058ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.2

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(1109511067)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 8
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1109511068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1109511068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1109511069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.65

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(1109511068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 26
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1109511069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1109511069
		arg_284_1.duration_ = 6.33

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1109511070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10058ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10058ui_story == nil then
				arg_284_1.var_.characterEffect10058ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect10058ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10058ui_story then
				arg_284_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_287_4 = 0

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_287_6 = 0
			local var_287_7 = 0.775

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[471].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(1109511069)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 31
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb") / 1000

					if var_287_14 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_6
					end

					if var_287_9.prefab_name ~= "" and arg_284_1.actors_[var_287_9.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_9.prefab_name].transform, "story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")

						arg_284_1:RecordAudio("1109511069", var_287_15)
						arg_284_1:RecordAudio("1109511069", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_16 and arg_284_1.time_ < var_287_6 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1109511070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1109511070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1109511071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10058ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10058ui_story == nil then
				arg_288_1.var_.characterEffect10058ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect10058ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_288_1.var_.characterEffect10058ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10058ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_288_1.var_.characterEffect10058ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.625

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_9 = arg_288_1:GetWordFromCfg(1109511070)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 25
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1109511071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1109511071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1109511072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 1.075

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:GetWordFromCfg(1109511071)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 43
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1109511072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1109511072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1109511074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 1

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				local var_299_2 = "play"
				local var_299_3 = "effect"

				arg_296_1:AudioAction(var_299_2, var_299_3, "se_story_152", "se_story_152_snack", "")
			end

			local var_299_4 = 0
			local var_299_5 = 0.85

			if var_299_4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(1109511072)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_8 = 34
				local var_299_9 = utf8.len(var_299_7)
				local var_299_10 = var_299_8 <= 0 and var_299_5 or var_299_5 * (var_299_9 / var_299_8)

				if var_299_10 > 0 and var_299_5 < var_299_10 then
					arg_296_1.talkMaxDuration = var_299_10

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_11 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_11 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_11

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_11 and arg_296_1.time_ < var_299_4 + var_299_11 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play1109511074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1109511074
		arg_300_1.duration_ = 6.67

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1109511075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_303_2 = arg_300_1.actors_["10058ui_story"].transform
			local var_303_3 = 0

			if var_303_3 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.var_.moveOldPos10058ui_story = var_303_2.localPosition
			end

			local var_303_4 = 0.001

			if var_303_3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_3 + var_303_4 then
				local var_303_5 = (arg_300_1.time_ - var_303_3) / var_303_4
				local var_303_6 = Vector3.New(0, -0.98, -6.1)

				var_303_2.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10058ui_story, var_303_6, var_303_5)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_2.position

				var_303_2.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_2.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_2.localEulerAngles = var_303_8
			end

			if arg_300_1.time_ >= var_303_3 + var_303_4 and arg_300_1.time_ < var_303_3 + var_303_4 + arg_303_0 then
				var_303_2.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_303_9 = manager.ui.mainCamera.transform.position - var_303_2.position

				var_303_2.forward = Vector3.New(var_303_9.x, var_303_9.y, var_303_9.z)

				local var_303_10 = var_303_2.localEulerAngles

				var_303_10.z = 0
				var_303_10.x = 0
				var_303_2.localEulerAngles = var_303_10
			end

			local var_303_11 = arg_300_1.actors_["10058ui_story"]
			local var_303_12 = 0

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10058ui_story == nil then
				arg_300_1.var_.characterEffect10058ui_story = var_303_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_13 = 0.200000002980232

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_13 and not isNil(var_303_11) then
				local var_303_14 = (arg_300_1.time_ - var_303_12) / var_303_13

				if arg_300_1.var_.characterEffect10058ui_story and not isNil(var_303_11) then
					arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_12 + var_303_13 and arg_300_1.time_ < var_303_12 + var_303_13 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10058ui_story then
				arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_303_15 = 0
			local var_303_16 = 0.825

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_17 = arg_300_1:FormatText(StoryNameCfg[471].name)

				arg_300_1.leftNameTxt_.text = var_303_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_18 = arg_300_1:GetWordFromCfg(1109511074)
				local var_303_19 = arg_300_1:FormatText(var_303_18.content)

				arg_300_1.text_.text = var_303_19

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_20 = 33
				local var_303_21 = utf8.len(var_303_19)
				local var_303_22 = var_303_20 <= 0 and var_303_16 or var_303_16 * (var_303_21 / var_303_20)

				if var_303_22 > 0 and var_303_16 < var_303_22 then
					arg_300_1.talkMaxDuration = var_303_22

					if var_303_22 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_15
					end
				end

				arg_300_1.text_.text = var_303_19
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb") ~= 0 then
					local var_303_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb") / 1000

					if var_303_23 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_23 + var_303_15
					end

					if var_303_18.prefab_name ~= "" and arg_300_1.actors_[var_303_18.prefab_name] ~= nil then
						local var_303_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_18.prefab_name].transform, "story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")

						arg_300_1:RecordAudio("1109511074", var_303_24)
						arg_300_1:RecordAudio("1109511074", var_303_24)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_25 = math.max(var_303_16, arg_300_1.talkMaxDuration)

			if var_303_15 <= arg_300_1.time_ and arg_300_1.time_ < var_303_15 + var_303_25 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_15) / var_303_25

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_15 + var_303_25 and arg_300_1.time_ < var_303_15 + var_303_25 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1109511075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1109511075
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1109511076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.075

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(1109511075)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 43
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1109511076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1109511076
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1109511077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 1.1

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:GetWordFromCfg(1109511076)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 44
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_8 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_8 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_8

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_8 and arg_308_1.time_ < var_311_0 + var_311_8 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1109511077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1109511077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1109511078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.45

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[7].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(1109511077)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 18
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_8 and arg_312_1.time_ < var_315_0 + var_315_8 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1109511078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1109511078
		arg_316_1.duration_ = 6.43

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1109511079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10058ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos10058ui_story = var_319_0.localPosition
			end

			local var_319_2 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0, -0.98, -6.1)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10058ui_story, var_319_4, var_319_3)

				local var_319_5 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_5.x, var_319_5.y, var_319_5.z)

				local var_319_6 = var_319_0.localEulerAngles

				var_319_6.z = 0
				var_319_6.x = 0
				var_319_0.localEulerAngles = var_319_6
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_319_7 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_7.x, var_319_7.y, var_319_7.z)

				local var_319_8 = var_319_0.localEulerAngles

				var_319_8.z = 0
				var_319_8.x = 0
				var_319_0.localEulerAngles = var_319_8
			end

			local var_319_9 = arg_316_1.actors_["10058ui_story"]
			local var_319_10 = 0

			if var_319_10 < arg_316_1.time_ and arg_316_1.time_ <= var_319_10 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect10058ui_story == nil then
				arg_316_1.var_.characterEffect10058ui_story = var_319_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_11 = 0.200000002980232

			if var_319_10 <= arg_316_1.time_ and arg_316_1.time_ < var_319_10 + var_319_11 and not isNil(var_319_9) then
				local var_319_12 = (arg_316_1.time_ - var_319_10) / var_319_11

				if arg_316_1.var_.characterEffect10058ui_story and not isNil(var_319_9) then
					arg_316_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_10 + var_319_11 and arg_316_1.time_ < var_319_10 + var_319_11 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect10058ui_story then
				arg_316_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_319_13 = 0

			if var_319_13 < arg_316_1.time_ and arg_316_1.time_ <= var_319_13 + arg_319_0 then
				arg_316_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_319_14 = 0

			if var_319_14 < arg_316_1.time_ and arg_316_1.time_ <= var_319_14 + arg_319_0 then
				arg_316_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_319_15 = 0
			local var_319_16 = 0.7

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_17 = arg_316_1:FormatText(StoryNameCfg[471].name)

				arg_316_1.leftNameTxt_.text = var_319_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_18 = arg_316_1:GetWordFromCfg(1109511078)
				local var_319_19 = arg_316_1:FormatText(var_319_18.content)

				arg_316_1.text_.text = var_319_19

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_20 = 28
				local var_319_21 = utf8.len(var_319_19)
				local var_319_22 = var_319_20 <= 0 and var_319_16 or var_319_16 * (var_319_21 / var_319_20)

				if var_319_22 > 0 and var_319_16 < var_319_22 then
					arg_316_1.talkMaxDuration = var_319_22

					if var_319_22 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_22 + var_319_15
					end
				end

				arg_316_1.text_.text = var_319_19
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb") / 1000

					if var_319_23 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_15
					end

					if var_319_18.prefab_name ~= "" and arg_316_1.actors_[var_319_18.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_18.prefab_name].transform, "story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")

						arg_316_1:RecordAudio("1109511078", var_319_24)
						arg_316_1:RecordAudio("1109511078", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_25 = math.max(var_319_16, arg_316_1.talkMaxDuration)

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_25 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_15) / var_319_25

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_15 + var_319_25 and arg_316_1.time_ < var_319_15 + var_319_25 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1109511079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1109511079
		arg_320_1.duration_ = 7.6

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1109511080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.825

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[471].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_3 = arg_320_1:GetWordFromCfg(1109511079)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 33
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")

						arg_320_1:RecordAudio("1109511079", var_323_9)
						arg_320_1:RecordAudio("1109511079", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1109511080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1109511080
		arg_324_1.duration_ = 9.7

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1109511081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_2 = 0
			local var_327_3 = 1.1

			if var_327_2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_4 = arg_324_1:FormatText(StoryNameCfg[471].name)

				arg_324_1.leftNameTxt_.text = var_327_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_5 = arg_324_1:GetWordFromCfg(1109511080)
				local var_327_6 = arg_324_1:FormatText(var_327_5.content)

				arg_324_1.text_.text = var_327_6

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 44
				local var_327_8 = utf8.len(var_327_6)
				local var_327_9 = var_327_7 <= 0 and var_327_3 or var_327_3 * (var_327_8 / var_327_7)

				if var_327_9 > 0 and var_327_3 < var_327_9 then
					arg_324_1.talkMaxDuration = var_327_9

					if var_327_9 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_9 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_6
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb") ~= 0 then
					local var_327_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb") / 1000

					if var_327_10 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_2
					end

					if var_327_5.prefab_name ~= "" and arg_324_1.actors_[var_327_5.prefab_name] ~= nil then
						local var_327_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_5.prefab_name].transform, "story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")

						arg_324_1:RecordAudio("1109511080", var_327_11)
						arg_324_1:RecordAudio("1109511080", var_327_11)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_12 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_12 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_12

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_12 and arg_324_1.time_ < var_327_2 + var_327_12 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1109511081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1109511081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1109511082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10058ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10058ui_story == nil then
				arg_328_1.var_.characterEffect10058ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect10058ui_story and not isNil(var_331_0) then
					local var_331_4 = Mathf.Lerp(0, 0.5, var_331_3)

					arg_328_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10058ui_story.fillRatio = var_331_4
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10058ui_story then
				local var_331_5 = 0.5

				arg_328_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10058ui_story.fillRatio = var_331_5
			end

			local var_331_6 = 0
			local var_331_7 = 0.2

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_9 = arg_328_1:GetWordFromCfg(1109511081)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 8
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_14 and arg_328_1.time_ < var_331_6 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1109511082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1109511082
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1109511083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10058ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos10058ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 100, 0)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10058ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 100, 0)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = 0
			local var_335_10 = 0.875

			if var_335_9 < arg_332_1.time_ and arg_332_1.time_ <= var_335_9 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_11 = arg_332_1:GetWordFromCfg(1109511082)
				local var_335_12 = arg_332_1:FormatText(var_335_11.content)

				arg_332_1.text_.text = var_335_12

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 35
				local var_335_14 = utf8.len(var_335_12)
				local var_335_15 = var_335_13 <= 0 and var_335_10 or var_335_10 * (var_335_14 / var_335_13)

				if var_335_15 > 0 and var_335_10 < var_335_15 then
					arg_332_1.talkMaxDuration = var_335_15

					if var_335_15 + var_335_9 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_15 + var_335_9
					end
				end

				arg_332_1.text_.text = var_335_12
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_10, arg_332_1.talkMaxDuration)

			if var_335_9 <= arg_332_1.time_ and arg_332_1.time_ < var_335_9 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_9) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_9 + var_335_16 and arg_332_1.time_ < var_335_9 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1109511083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1109511083
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1109511084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.875

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_2 = arg_336_1:GetWordFromCfg(1109511083)
				local var_339_3 = arg_336_1:FormatText(var_339_2.content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 35
				local var_339_5 = utf8.len(var_339_3)
				local var_339_6 = var_339_4 <= 0 and var_339_1 or var_339_1 * (var_339_5 / var_339_4)

				if var_339_6 > 0 and var_339_1 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_7 and arg_336_1.time_ < var_339_0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1109511084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109511084
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109511085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.4

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[7].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:GetWordFromCfg(1109511084)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 16
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_8 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_8 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_8

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_8 and arg_340_1.time_ < var_343_0 + var_343_8 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109511085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109511085
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109511086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10058ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos10058ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0, 100, 0)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10058ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0, 100, 0)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = 0
			local var_347_10 = 0.7

			if var_347_9 < arg_344_1.time_ and arg_344_1.time_ <= var_347_9 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_11 = arg_344_1:GetWordFromCfg(1109511085)
				local var_347_12 = arg_344_1:FormatText(var_347_11.content)

				arg_344_1.text_.text = var_347_12

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 28
				local var_347_14 = utf8.len(var_347_12)
				local var_347_15 = var_347_13 <= 0 and var_347_10 or var_347_10 * (var_347_14 / var_347_13)

				if var_347_15 > 0 and var_347_10 < var_347_15 then
					arg_344_1.talkMaxDuration = var_347_15

					if var_347_15 + var_347_9 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_15 + var_347_9
					end
				end

				arg_344_1.text_.text = var_347_12
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_10, arg_344_1.talkMaxDuration)

			if var_347_9 <= arg_344_1.time_ and arg_344_1.time_ < var_347_9 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_9) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_9 + var_347_16 and arg_344_1.time_ < var_347_9 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play1109511086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109511086
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109511087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.425

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(1109511086)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 17
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1109511087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109511087
		arg_352_1.duration_ = 2

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109511088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10058ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos10058ui_story = var_355_0.localPosition
			end

			local var_355_2 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2
				local var_355_4 = Vector3.New(0, -0.98, -6.1)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10058ui_story, var_355_4, var_355_3)

				local var_355_5 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_5.x, var_355_5.y, var_355_5.z)

				local var_355_6 = var_355_0.localEulerAngles

				var_355_6.z = 0
				var_355_6.x = 0
				var_355_0.localEulerAngles = var_355_6
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_355_7 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_7.x, var_355_7.y, var_355_7.z)

				local var_355_8 = var_355_0.localEulerAngles

				var_355_8.z = 0
				var_355_8.x = 0
				var_355_0.localEulerAngles = var_355_8
			end

			local var_355_9 = arg_352_1.actors_["10058ui_story"]
			local var_355_10 = 0

			if var_355_10 < arg_352_1.time_ and arg_352_1.time_ <= var_355_10 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect10058ui_story == nil then
				arg_352_1.var_.characterEffect10058ui_story = var_355_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_11 = 0.200000002980232

			if var_355_10 <= arg_352_1.time_ and arg_352_1.time_ < var_355_10 + var_355_11 and not isNil(var_355_9) then
				local var_355_12 = (arg_352_1.time_ - var_355_10) / var_355_11

				if arg_352_1.var_.characterEffect10058ui_story and not isNil(var_355_9) then
					arg_352_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_10 + var_355_11 and arg_352_1.time_ < var_355_10 + var_355_11 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect10058ui_story then
				arg_352_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_355_13 = 0

			if var_355_13 < arg_352_1.time_ and arg_352_1.time_ <= var_355_13 + arg_355_0 then
				arg_352_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_355_14 = 0
			local var_355_15 = 0.075

			if var_355_14 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_16 = arg_352_1:FormatText(StoryNameCfg[471].name)

				arg_352_1.leftNameTxt_.text = var_355_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_17 = arg_352_1:GetWordFromCfg(1109511087)
				local var_355_18 = arg_352_1:FormatText(var_355_17.content)

				arg_352_1.text_.text = var_355_18

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_19 = 3
				local var_355_20 = utf8.len(var_355_18)
				local var_355_21 = var_355_19 <= 0 and var_355_15 or var_355_15 * (var_355_20 / var_355_19)

				if var_355_21 > 0 and var_355_15 < var_355_21 then
					arg_352_1.talkMaxDuration = var_355_21

					if var_355_21 + var_355_14 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_21 + var_355_14
					end
				end

				arg_352_1.text_.text = var_355_18
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb") ~= 0 then
					local var_355_22 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb") / 1000

					if var_355_22 + var_355_14 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_22 + var_355_14
					end

					if var_355_17.prefab_name ~= "" and arg_352_1.actors_[var_355_17.prefab_name] ~= nil then
						local var_355_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_17.prefab_name].transform, "story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")

						arg_352_1:RecordAudio("1109511087", var_355_23)
						arg_352_1:RecordAudio("1109511087", var_355_23)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_24 = math.max(var_355_15, arg_352_1.talkMaxDuration)

			if var_355_14 <= arg_352_1.time_ and arg_352_1.time_ < var_355_14 + var_355_24 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_14) / var_355_24

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_14 + var_355_24 and arg_352_1.time_ < var_355_14 + var_355_24 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play1109511088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1109511088
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1109511089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10058ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10058ui_story == nil then
				arg_356_1.var_.characterEffect10058ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect10058ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10058ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10058ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10058ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 1

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(1109511088)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 40
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_14 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_14 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_14

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_14 and arg_356_1.time_ < var_359_6 + var_359_14 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1109511089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109511089
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109511090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.625

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(1109511089)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 25
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_8 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_8 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_8

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_8 and arg_360_1.time_ < var_363_0 + var_363_8 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109511090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1109511090
		arg_364_1.duration_ = 8.23

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1109511091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10058ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10058ui_story == nil then
				arg_364_1.var_.characterEffect10058ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10058ui_story and not isNil(var_367_0) then
					arg_364_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10058ui_story then
				arg_364_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_367_4 = 0
			local var_367_5 = 0.825

			if var_367_4 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_6 = arg_364_1:FormatText(StoryNameCfg[471].name)

				arg_364_1.leftNameTxt_.text = var_367_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_7 = arg_364_1:GetWordFromCfg(1109511090)
				local var_367_8 = arg_364_1:FormatText(var_367_7.content)

				arg_364_1.text_.text = var_367_8

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_9 = 33
				local var_367_10 = utf8.len(var_367_8)
				local var_367_11 = var_367_9 <= 0 and var_367_5 or var_367_5 * (var_367_10 / var_367_9)

				if var_367_11 > 0 and var_367_5 < var_367_11 then
					arg_364_1.talkMaxDuration = var_367_11

					if var_367_11 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_11 + var_367_4
					end
				end

				arg_364_1.text_.text = var_367_8
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb") ~= 0 then
					local var_367_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb") / 1000

					if var_367_12 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_12 + var_367_4
					end

					if var_367_7.prefab_name ~= "" and arg_364_1.actors_[var_367_7.prefab_name] ~= nil then
						local var_367_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_7.prefab_name].transform, "story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")

						arg_364_1:RecordAudio("1109511090", var_367_13)
						arg_364_1:RecordAudio("1109511090", var_367_13)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_14 = math.max(var_367_5, arg_364_1.talkMaxDuration)

			if var_367_4 <= arg_364_1.time_ and arg_364_1.time_ < var_367_4 + var_367_14 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_4) / var_367_14

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_4 + var_367_14 and arg_364_1.time_ < var_367_4 + var_367_14 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1109511091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1109511091
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1109511092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10058ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10058ui_story == nil then
				arg_368_1.var_.characterEffect10058ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10058ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10058ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10058ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10058ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0
			local var_371_7 = 0.575

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_9 = arg_368_1:GetWordFromCfg(1109511091)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 23
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_14 and arg_368_1.time_ < var_371_6 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1109511092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109511092
		arg_372_1.duration_ = 8.37

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109511093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10058ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10058ui_story == nil then
				arg_372_1.var_.characterEffect10058ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10058ui_story and not isNil(var_375_0) then
					arg_372_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10058ui_story then
				arg_372_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_375_4 = 0

			if var_375_4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_375_5 = 0
			local var_375_6 = 0.825

			if var_375_5 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_7 = arg_372_1:FormatText(StoryNameCfg[471].name)

				arg_372_1.leftNameTxt_.text = var_375_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_8 = arg_372_1:GetWordFromCfg(1109511092)
				local var_375_9 = arg_372_1:FormatText(var_375_8.content)

				arg_372_1.text_.text = var_375_9

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_10 = 33
				local var_375_11 = utf8.len(var_375_9)
				local var_375_12 = var_375_10 <= 0 and var_375_6 or var_375_6 * (var_375_11 / var_375_10)

				if var_375_12 > 0 and var_375_6 < var_375_12 then
					arg_372_1.talkMaxDuration = var_375_12

					if var_375_12 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_12 + var_375_5
					end
				end

				arg_372_1.text_.text = var_375_9
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb") ~= 0 then
					local var_375_13 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb") / 1000

					if var_375_13 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_5
					end

					if var_375_8.prefab_name ~= "" and arg_372_1.actors_[var_375_8.prefab_name] ~= nil then
						local var_375_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_8.prefab_name].transform, "story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")

						arg_372_1:RecordAudio("1109511092", var_375_14)
						arg_372_1:RecordAudio("1109511092", var_375_14)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_15 = math.max(var_375_6, arg_372_1.talkMaxDuration)

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_15 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_5) / var_375_15

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_5 + var_375_15 and arg_372_1.time_ < var_375_5 + var_375_15 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109511093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109511093
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109511094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10058ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10058ui_story == nil then
				arg_376_1.var_.characterEffect10058ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10058ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10058ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10058ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10058ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 0.4

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_9 = arg_376_1:GetWordFromCfg(1109511093)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 16
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_14 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_14 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_14

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_14 and arg_376_1.time_ < var_379_6 + var_379_14 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109511094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109511094
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109511095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.475

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(1109511094)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 19
				local var_383_5 = utf8.len(var_383_3)
				local var_383_6 = var_383_4 <= 0 and var_383_1 or var_383_1 * (var_383_5 / var_383_4)

				if var_383_6 > 0 and var_383_1 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_7 and arg_380_1.time_ < var_383_0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109511095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109511095
		arg_384_1.duration_ = 8.2

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109511096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10058ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10058ui_story == nil then
				arg_384_1.var_.characterEffect10058ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10058ui_story and not isNil(var_387_0) then
					arg_384_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10058ui_story then
				arg_384_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_387_4 = 0

			if var_387_4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			local var_387_5 = 0

			if var_387_5 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_387_6 = 0
			local var_387_7 = 0.75

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[471].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_9 = arg_384_1:GetWordFromCfg(1109511095)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 30
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb") / 1000

					if var_387_14 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_6
					end

					if var_387_9.prefab_name ~= "" and arg_384_1.actors_[var_387_9.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_9.prefab_name].transform, "story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")

						arg_384_1:RecordAudio("1109511095", var_387_15)
						arg_384_1:RecordAudio("1109511095", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_16 and arg_384_1.time_ < var_387_6 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109511096 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109511096
		arg_388_1.duration_ = 7.97

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109511097(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 1.31666666666667

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				local var_391_1 = manager.ui.mainCamera.transform.localPosition
				local var_391_2 = Vector3.New(0, 0, 10) + Vector3.New(var_391_1.x, var_391_1.y, 0)
				local var_391_3 = arg_388_1.bgs_.X203g

				var_391_3.transform.localPosition = var_391_2
				var_391_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_4 = var_391_3:GetComponent("SpriteRenderer")

				if var_391_4 and var_391_4.sprite then
					local var_391_5 = (var_391_3.transform.localPosition - var_391_1).z
					local var_391_6 = manager.ui.mainCameraCom_
					local var_391_7 = 2 * var_391_5 * Mathf.Tan(var_391_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_391_8 = var_391_7 * var_391_6.aspect
					local var_391_9 = var_391_4.sprite.bounds.size.x
					local var_391_10 = var_391_4.sprite.bounds.size.y
					local var_391_11 = var_391_8 / var_391_9
					local var_391_12 = var_391_7 / var_391_10
					local var_391_13 = var_391_12 < var_391_11 and var_391_11 or var_391_12

					var_391_3.transform.localScale = Vector3.New(var_391_13, var_391_13, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "X203g" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_14 = 1.31666666666667

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_15 = 0.3

			if arg_388_1.time_ >= var_391_14 + var_391_15 and arg_388_1.time_ < var_391_14 + var_391_15 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_16 = 0

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_17 = 1.31666666666667

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_17 then
				local var_391_18 = (arg_388_1.time_ - var_391_16) / var_391_17
				local var_391_19 = Color.New(0, 0, 0)

				var_391_19.a = Mathf.Lerp(0, 1, var_391_18)
				arg_388_1.mask_.color = var_391_19
			end

			if arg_388_1.time_ >= var_391_16 + var_391_17 and arg_388_1.time_ < var_391_16 + var_391_17 + arg_391_0 then
				local var_391_20 = Color.New(0, 0, 0)

				var_391_20.a = 1
				arg_388_1.mask_.color = var_391_20
			end

			local var_391_21 = 1.31666666666667

			if var_391_21 < arg_388_1.time_ and arg_388_1.time_ <= var_391_21 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_22 = 2

			if var_391_21 <= arg_388_1.time_ and arg_388_1.time_ < var_391_21 + var_391_22 then
				local var_391_23 = (arg_388_1.time_ - var_391_21) / var_391_22
				local var_391_24 = Color.New(0, 0, 0)

				var_391_24.a = Mathf.Lerp(1, 0, var_391_23)
				arg_388_1.mask_.color = var_391_24
			end

			if arg_388_1.time_ >= var_391_21 + var_391_22 and arg_388_1.time_ < var_391_21 + var_391_22 + arg_391_0 then
				local var_391_25 = Color.New(0, 0, 0)
				local var_391_26 = 0

				arg_388_1.mask_.enabled = false
				var_391_25.a = var_391_26
				arg_388_1.mask_.color = var_391_25
			end

			local var_391_27 = arg_388_1.actors_["10058ui_story"].transform
			local var_391_28 = 1.31666666666667

			if var_391_28 < arg_388_1.time_ and arg_388_1.time_ <= var_391_28 + arg_391_0 then
				arg_388_1.var_.moveOldPos10058ui_story = var_391_27.localPosition
			end

			local var_391_29 = 0.001

			if var_391_28 <= arg_388_1.time_ and arg_388_1.time_ < var_391_28 + var_391_29 then
				local var_391_30 = (arg_388_1.time_ - var_391_28) / var_391_29
				local var_391_31 = Vector3.New(0, 100, 0)

				var_391_27.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10058ui_story, var_391_31, var_391_30)

				local var_391_32 = manager.ui.mainCamera.transform.position - var_391_27.position

				var_391_27.forward = Vector3.New(var_391_32.x, var_391_32.y, var_391_32.z)

				local var_391_33 = var_391_27.localEulerAngles

				var_391_33.z = 0
				var_391_33.x = 0
				var_391_27.localEulerAngles = var_391_33
			end

			if arg_388_1.time_ >= var_391_28 + var_391_29 and arg_388_1.time_ < var_391_28 + var_391_29 + arg_391_0 then
				var_391_27.localPosition = Vector3.New(0, 100, 0)

				local var_391_34 = manager.ui.mainCamera.transform.position - var_391_27.position

				var_391_27.forward = Vector3.New(var_391_34.x, var_391_34.y, var_391_34.z)

				local var_391_35 = var_391_27.localEulerAngles

				var_391_35.z = 0
				var_391_35.x = 0
				var_391_27.localEulerAngles = var_391_35
			end

			local var_391_36 = arg_388_1.actors_["10058ui_story"]
			local var_391_37 = 1.31666666666667

			if var_391_37 < arg_388_1.time_ and arg_388_1.time_ <= var_391_37 + arg_391_0 and not isNil(var_391_36) and arg_388_1.var_.characterEffect10058ui_story == nil then
				arg_388_1.var_.characterEffect10058ui_story = var_391_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_38 = 0.200000002980232

			if var_391_37 <= arg_388_1.time_ and arg_388_1.time_ < var_391_37 + var_391_38 and not isNil(var_391_36) then
				local var_391_39 = (arg_388_1.time_ - var_391_37) / var_391_38

				if arg_388_1.var_.characterEffect10058ui_story and not isNil(var_391_36) then
					local var_391_40 = Mathf.Lerp(0, 0.5, var_391_39)

					arg_388_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_388_1.var_.characterEffect10058ui_story.fillRatio = var_391_40
				end
			end

			if arg_388_1.time_ >= var_391_37 + var_391_38 and arg_388_1.time_ < var_391_37 + var_391_38 + arg_391_0 and not isNil(var_391_36) and arg_388_1.var_.characterEffect10058ui_story then
				local var_391_41 = 0.5

				arg_388_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_388_1.var_.characterEffect10058ui_story.fillRatio = var_391_41
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_42 = 2.96666666666667
			local var_391_43 = 0.5

			if var_391_42 < arg_388_1.time_ and arg_388_1.time_ <= var_391_42 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_44 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_44:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_45 = arg_388_1:FormatText(StoryNameCfg[7].name)

				arg_388_1.leftNameTxt_.text = var_391_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_46 = arg_388_1:GetWordFromCfg(1109511096)
				local var_391_47 = arg_388_1:FormatText(var_391_46.content)

				arg_388_1.text_.text = var_391_47

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_48 = 20
				local var_391_49 = utf8.len(var_391_47)
				local var_391_50 = var_391_48 <= 0 and var_391_43 or var_391_43 * (var_391_49 / var_391_48)

				if var_391_50 > 0 and var_391_43 < var_391_50 then
					arg_388_1.talkMaxDuration = var_391_50
					var_391_42 = var_391_42 + 0.3

					if var_391_50 + var_391_42 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_50 + var_391_42
					end
				end

				arg_388_1.text_.text = var_391_47
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_51 = var_391_42 + 0.3
			local var_391_52 = math.max(var_391_43, arg_388_1.talkMaxDuration)

			if var_391_51 <= arg_388_1.time_ and arg_388_1.time_ < var_391_51 + var_391_52 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_51) / var_391_52

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_51 + var_391_52 and arg_388_1.time_ < var_391_51 + var_391_52 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.31666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109511097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1109511097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1109511098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.975

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(1109511097)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 39
				local var_397_5 = utf8.len(var_397_3)
				local var_397_6 = var_397_4 <= 0 and var_397_1 or var_397_1 * (var_397_5 / var_397_4)

				if var_397_6 > 0 and var_397_1 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_7 and arg_394_1.time_ < var_397_0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1109511098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1109511098
		arg_398_1.duration_ = 4.67

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1109511099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["10058ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos10058ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, -0.98, -6.1)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10058ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["10058ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect10058ui_story == nil then
				arg_398_1.var_.characterEffect10058ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect10058ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect10058ui_story then
				arg_398_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_401_13 = 0

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_15 = 0
			local var_401_16 = 0.45

			if var_401_15 < arg_398_1.time_ and arg_398_1.time_ <= var_401_15 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_17 = arg_398_1:FormatText(StoryNameCfg[471].name)

				arg_398_1.leftNameTxt_.text = var_401_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_18 = arg_398_1:GetWordFromCfg(1109511098)
				local var_401_19 = arg_398_1:FormatText(var_401_18.content)

				arg_398_1.text_.text = var_401_19

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_20 = 18
				local var_401_21 = utf8.len(var_401_19)
				local var_401_22 = var_401_20 <= 0 and var_401_16 or var_401_16 * (var_401_21 / var_401_20)

				if var_401_22 > 0 and var_401_16 < var_401_22 then
					arg_398_1.talkMaxDuration = var_401_22

					if var_401_22 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_22 + var_401_15
					end
				end

				arg_398_1.text_.text = var_401_19
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb") ~= 0 then
					local var_401_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb") / 1000

					if var_401_23 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_15
					end

					if var_401_18.prefab_name ~= "" and arg_398_1.actors_[var_401_18.prefab_name] ~= nil then
						local var_401_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_18.prefab_name].transform, "story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")

						arg_398_1:RecordAudio("1109511098", var_401_24)
						arg_398_1:RecordAudio("1109511098", var_401_24)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_25 = math.max(var_401_16, arg_398_1.talkMaxDuration)

			if var_401_15 <= arg_398_1.time_ and arg_398_1.time_ < var_401_15 + var_401_25 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_15) / var_401_25

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_15 + var_401_25 and arg_398_1.time_ < var_401_15 + var_401_25 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play1109511099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1109511099
		arg_402_1.duration_ = 4.1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1109511100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.475

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[471].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_3 = arg_402_1:GetWordFromCfg(1109511099)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 19
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")

						arg_402_1:RecordAudio("1109511099", var_405_9)
						arg_402_1:RecordAudio("1109511099", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1109511100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1109511100
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1109511101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["10058ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect10058ui_story == nil then
				arg_406_1.var_.characterEffect10058ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect10058ui_story and not isNil(var_409_0) then
					local var_409_4 = Mathf.Lerp(0, 0.5, var_409_3)

					arg_406_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_406_1.var_.characterEffect10058ui_story.fillRatio = var_409_4
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect10058ui_story then
				local var_409_5 = 0.5

				arg_406_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_406_1.var_.characterEffect10058ui_story.fillRatio = var_409_5
			end

			local var_409_6 = 0
			local var_409_7 = 0.525

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_8 = arg_406_1:FormatText(StoryNameCfg[7].name)

				arg_406_1.leftNameTxt_.text = var_409_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_9 = arg_406_1:GetWordFromCfg(1109511100)
				local var_409_10 = arg_406_1:FormatText(var_409_9.content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_11 = 21
				local var_409_12 = utf8.len(var_409_10)
				local var_409_13 = var_409_11 <= 0 and var_409_7 or var_409_7 * (var_409_12 / var_409_11)

				if var_409_13 > 0 and var_409_7 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_6
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_14 = math.max(var_409_7, arg_406_1.talkMaxDuration)

			if var_409_6 <= arg_406_1.time_ and arg_406_1.time_ < var_409_6 + var_409_14 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_6) / var_409_14

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_6 + var_409_14 and arg_406_1.time_ < var_409_6 + var_409_14 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1109511101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1109511101
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1109511102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.25

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_2

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

				local var_413_3 = arg_410_1:GetWordFromCfg(1109511101)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 10
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_8 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_8 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_8

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_8 and arg_410_1.time_ < var_413_0 + var_413_8 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1109511102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1109511102
		arg_414_1.duration_ = 3.7

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1109511103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["10058ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect10058ui_story == nil then
				arg_414_1.var_.characterEffect10058ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect10058ui_story and not isNil(var_417_0) then
					arg_414_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect10058ui_story then
				arg_414_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_417_4 = 0
			local var_417_5 = 0.45

			if var_417_4 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_6 = arg_414_1:FormatText(StoryNameCfg[471].name)

				arg_414_1.leftNameTxt_.text = var_417_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_7 = arg_414_1:GetWordFromCfg(1109511102)
				local var_417_8 = arg_414_1:FormatText(var_417_7.content)

				arg_414_1.text_.text = var_417_8

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_9 = 18
				local var_417_10 = utf8.len(var_417_8)
				local var_417_11 = var_417_9 <= 0 and var_417_5 or var_417_5 * (var_417_10 / var_417_9)

				if var_417_11 > 0 and var_417_5 < var_417_11 then
					arg_414_1.talkMaxDuration = var_417_11

					if var_417_11 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_11 + var_417_4
					end
				end

				arg_414_1.text_.text = var_417_8
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb") ~= 0 then
					local var_417_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb") / 1000

					if var_417_12 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_12 + var_417_4
					end

					if var_417_7.prefab_name ~= "" and arg_414_1.actors_[var_417_7.prefab_name] ~= nil then
						local var_417_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_7.prefab_name].transform, "story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")

						arg_414_1:RecordAudio("1109511102", var_417_13)
						arg_414_1:RecordAudio("1109511102", var_417_13)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_5, arg_414_1.talkMaxDuration)

			if var_417_4 <= arg_414_1.time_ and arg_414_1.time_ < var_417_4 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_4) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_4 + var_417_14 and arg_414_1.time_ < var_417_4 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1109511103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109511103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109511104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["10058ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect10058ui_story == nil then
				arg_418_1.var_.characterEffect10058ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect10058ui_story and not isNil(var_421_0) then
					local var_421_4 = Mathf.Lerp(0, 0.5, var_421_3)

					arg_418_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_418_1.var_.characterEffect10058ui_story.fillRatio = var_421_4
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect10058ui_story then
				local var_421_5 = 0.5

				arg_418_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_418_1.var_.characterEffect10058ui_story.fillRatio = var_421_5
			end

			local var_421_6 = 0
			local var_421_7 = 0.375

			if var_421_6 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_8 = arg_418_1:FormatText(StoryNameCfg[7].name)

				arg_418_1.leftNameTxt_.text = var_421_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_9 = arg_418_1:GetWordFromCfg(1109511103)
				local var_421_10 = arg_418_1:FormatText(var_421_9.content)

				arg_418_1.text_.text = var_421_10

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 15
				local var_421_12 = utf8.len(var_421_10)
				local var_421_13 = var_421_11 <= 0 and var_421_7 or var_421_7 * (var_421_12 / var_421_11)

				if var_421_13 > 0 and var_421_7 < var_421_13 then
					arg_418_1.talkMaxDuration = var_421_13

					if var_421_13 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_13 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_10
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_14 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_14 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_14

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_14 and arg_418_1.time_ < var_421_6 + var_421_14 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1109511104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109511104
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109511105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.85

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_2 = arg_422_1:FormatText(StoryNameCfg[7].name)

				arg_422_1.leftNameTxt_.text = var_425_2

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

				local var_425_3 = arg_422_1:GetWordFromCfg(1109511104)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 34
				local var_425_6 = utf8.len(var_425_4)
				local var_425_7 = var_425_5 <= 0 and var_425_1 or var_425_1 * (var_425_6 / var_425_5)

				if var_425_7 > 0 and var_425_1 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_8 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_8 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_8

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_8 and arg_422_1.time_ < var_425_0 + var_425_8 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109511105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109511105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109511106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.675

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_2 = arg_426_1:GetWordFromCfg(1109511105)
				local var_429_3 = arg_426_1:FormatText(var_429_2.content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 27
				local var_429_5 = utf8.len(var_429_3)
				local var_429_6 = var_429_4 <= 0 and var_429_1 or var_429_1 * (var_429_5 / var_429_4)

				if var_429_6 > 0 and var_429_1 < var_429_6 then
					arg_426_1.talkMaxDuration = var_429_6

					if var_429_6 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_6 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_7 and arg_426_1.time_ < var_429_0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109511106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109511106
		arg_430_1.duration_ = 9.13

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109511107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["10058ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10058ui_story == nil then
				arg_430_1.var_.characterEffect10058ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect10058ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10058ui_story then
				arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_433_4 = 0

			if var_433_4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_433_5 = 0

			if var_433_5 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_433_6 = 0
			local var_433_7 = 0.875

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[471].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_9 = arg_430_1:GetWordFromCfg(1109511106)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 35
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb") / 1000

					if var_433_14 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_6
					end

					if var_433_9.prefab_name ~= "" and arg_430_1.actors_[var_433_9.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_9.prefab_name].transform, "story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")

						arg_430_1:RecordAudio("1109511106", var_433_15)
						arg_430_1:RecordAudio("1109511106", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_16 and arg_430_1.time_ < var_433_6 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109511107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109511107
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109511108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["10058ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10058ui_story == nil then
				arg_434_1.var_.characterEffect10058ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect10058ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_434_1.var_.characterEffect10058ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10058ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_434_1.var_.characterEffect10058ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 0.725

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_9 = arg_434_1:GetWordFromCfg(1109511107)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 29
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_14 and arg_434_1.time_ < var_437_6 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109511108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109511108
		arg_438_1.duration_ = 4.4

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109511109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10058ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10058ui_story == nil then
				arg_438_1.var_.characterEffect10058ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect10058ui_story and not isNil(var_441_0) then
					arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10058ui_story then
				arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_441_4 = 0
			local var_441_5 = 0.475

			if var_441_4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_6 = arg_438_1:FormatText(StoryNameCfg[471].name)

				arg_438_1.leftNameTxt_.text = var_441_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:GetWordFromCfg(1109511108)
				local var_441_8 = arg_438_1:FormatText(var_441_7.content)

				arg_438_1.text_.text = var_441_8

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 19
				local var_441_10 = utf8.len(var_441_8)
				local var_441_11 = var_441_9 <= 0 and var_441_5 or var_441_5 * (var_441_10 / var_441_9)

				if var_441_11 > 0 and var_441_5 < var_441_11 then
					arg_438_1.talkMaxDuration = var_441_11

					if var_441_11 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_11 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_8
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb") ~= 0 then
					local var_441_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb") / 1000

					if var_441_12 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_12 + var_441_4
					end

					if var_441_7.prefab_name ~= "" and arg_438_1.actors_[var_441_7.prefab_name] ~= nil then
						local var_441_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_7.prefab_name].transform, "story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")

						arg_438_1:RecordAudio("1109511108", var_441_13)
						arg_438_1:RecordAudio("1109511108", var_441_13)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_14 and arg_438_1.time_ < var_441_4 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109511109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109511109
		arg_442_1.duration_ = 5.3

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109511110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_445_2 = 0
			local var_445_3 = 0.6

			if var_445_2 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_4 = arg_442_1:FormatText(StoryNameCfg[471].name)

				arg_442_1.leftNameTxt_.text = var_445_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_5 = arg_442_1:GetWordFromCfg(1109511109)
				local var_445_6 = arg_442_1:FormatText(var_445_5.content)

				arg_442_1.text_.text = var_445_6

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 24
				local var_445_8 = utf8.len(var_445_6)
				local var_445_9 = var_445_7 <= 0 and var_445_3 or var_445_3 * (var_445_8 / var_445_7)

				if var_445_9 > 0 and var_445_3 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_6
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb") / 1000

					if var_445_10 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_2
					end

					if var_445_5.prefab_name ~= "" and arg_442_1.actors_[var_445_5.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_5.prefab_name].transform, "story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")

						arg_442_1:RecordAudio("1109511109", var_445_11)
						arg_442_1:RecordAudio("1109511109", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_12 and arg_442_1.time_ < var_445_2 + var_445_12 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109511110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109511110
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109511111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["10058ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10058ui_story == nil then
				arg_446_1.var_.characterEffect10058ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect10058ui_story and not isNil(var_449_0) then
					local var_449_4 = Mathf.Lerp(0, 0.5, var_449_3)

					arg_446_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10058ui_story.fillRatio = var_449_4
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10058ui_story then
				local var_449_5 = 0.5

				arg_446_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10058ui_story.fillRatio = var_449_5
			end

			local var_449_6 = 0
			local var_449_7 = 0.75

			if var_449_6 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_8 = arg_446_1:FormatText(StoryNameCfg[7].name)

				arg_446_1.leftNameTxt_.text = var_449_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_9 = arg_446_1:GetWordFromCfg(1109511110)
				local var_449_10 = arg_446_1:FormatText(var_449_9.content)

				arg_446_1.text_.text = var_449_10

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_11 = 30
				local var_449_12 = utf8.len(var_449_10)
				local var_449_13 = var_449_11 <= 0 and var_449_7 or var_449_7 * (var_449_12 / var_449_11)

				if var_449_13 > 0 and var_449_7 < var_449_13 then
					arg_446_1.talkMaxDuration = var_449_13

					if var_449_13 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_13 + var_449_6
					end
				end

				arg_446_1.text_.text = var_449_10
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_14 = math.max(var_449_7, arg_446_1.talkMaxDuration)

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_14 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_6) / var_449_14

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_6 + var_449_14 and arg_446_1.time_ < var_449_6 + var_449_14 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109511111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109511111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109511112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.85

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_2

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

				local var_453_3 = arg_450_1:GetWordFromCfg(1109511111)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 34
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_8 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_8 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_8

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_8 and arg_450_1.time_ < var_453_0 + var_453_8 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109511112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109511112
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109511113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.975

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(1109511112)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 39
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_8 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_8 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_8

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_8 and arg_454_1.time_ < var_457_0 + var_457_8 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109511113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109511113
		arg_458_1.duration_ = 1.23

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109511114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["10058ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect10058ui_story == nil then
				arg_458_1.var_.characterEffect10058ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect10058ui_story and not isNil(var_461_0) then
					arg_458_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect10058ui_story then
				arg_458_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_461_4 = 0
			local var_461_5 = 0.1

			if var_461_4 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_6 = arg_458_1:FormatText(StoryNameCfg[471].name)

				arg_458_1.leftNameTxt_.text = var_461_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_7 = arg_458_1:GetWordFromCfg(1109511113)
				local var_461_8 = arg_458_1:FormatText(var_461_7.content)

				arg_458_1.text_.text = var_461_8

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_9 = 4
				local var_461_10 = utf8.len(var_461_8)
				local var_461_11 = var_461_9 <= 0 and var_461_5 or var_461_5 * (var_461_10 / var_461_9)

				if var_461_11 > 0 and var_461_5 < var_461_11 then
					arg_458_1.talkMaxDuration = var_461_11

					if var_461_11 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_11 + var_461_4
					end
				end

				arg_458_1.text_.text = var_461_8
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb") ~= 0 then
					local var_461_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb") / 1000

					if var_461_12 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_4
					end

					if var_461_7.prefab_name ~= "" and arg_458_1.actors_[var_461_7.prefab_name] ~= nil then
						local var_461_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_7.prefab_name].transform, "story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")

						arg_458_1:RecordAudio("1109511113", var_461_13)
						arg_458_1:RecordAudio("1109511113", var_461_13)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_14 = math.max(var_461_5, arg_458_1.talkMaxDuration)

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_14 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_4) / var_461_14

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_4 + var_461_14 and arg_458_1.time_ < var_461_4 + var_461_14 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109511114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109511114
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109511115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["10058ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos10058ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, 100, 0)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10058ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, 100, 0)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = 0
			local var_465_10 = 0.425

			if var_465_9 < arg_462_1.time_ and arg_462_1.time_ <= var_465_9 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_11 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_12 = arg_462_1:GetWordFromCfg(1109511114)
				local var_465_13 = arg_462_1:FormatText(var_465_12.content)

				arg_462_1.text_.text = var_465_13

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_14 = 17
				local var_465_15 = utf8.len(var_465_13)
				local var_465_16 = var_465_14 <= 0 and var_465_10 or var_465_10 * (var_465_15 / var_465_14)

				if var_465_16 > 0 and var_465_10 < var_465_16 then
					arg_462_1.talkMaxDuration = var_465_16

					if var_465_16 + var_465_9 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_16 + var_465_9
					end
				end

				arg_462_1.text_.text = var_465_13
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_17 = math.max(var_465_10, arg_462_1.talkMaxDuration)

			if var_465_9 <= arg_462_1.time_ and arg_462_1.time_ < var_465_9 + var_465_17 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_9) / var_465_17

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_9 + var_465_17 and arg_462_1.time_ < var_465_9 + var_465_17 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play1109511115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109511115
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109511116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.75

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_2 = arg_466_1:GetWordFromCfg(1109511115)
				local var_469_3 = arg_466_1:FormatText(var_469_2.content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 30
				local var_469_5 = utf8.len(var_469_3)
				local var_469_6 = var_469_4 <= 0 and var_469_1 or var_469_1 * (var_469_5 / var_469_4)

				if var_469_6 > 0 and var_469_1 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_7 and arg_466_1.time_ < var_469_0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109511116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109511116
		arg_470_1.duration_ = 4.7

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109511117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["10058ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect10058ui_story == nil then
				arg_470_1.var_.characterEffect10058ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect10058ui_story and not isNil(var_473_0) then
					arg_470_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect10058ui_story then
				arg_470_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_473_4 = 0

			if var_473_4 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_473_5 = 0

			if var_473_5 < arg_470_1.time_ and arg_470_1.time_ <= var_473_5 + arg_473_0 then
				arg_470_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_473_6 = arg_470_1.actors_["10058ui_story"].transform
			local var_473_7 = 0

			if var_473_7 < arg_470_1.time_ and arg_470_1.time_ <= var_473_7 + arg_473_0 then
				arg_470_1.var_.moveOldPos10058ui_story = var_473_6.localPosition
			end

			local var_473_8 = 0.001

			if var_473_7 <= arg_470_1.time_ and arg_470_1.time_ < var_473_7 + var_473_8 then
				local var_473_9 = (arg_470_1.time_ - var_473_7) / var_473_8
				local var_473_10 = Vector3.New(0, -0.98, -6.1)

				var_473_6.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10058ui_story, var_473_10, var_473_9)

				local var_473_11 = manager.ui.mainCamera.transform.position - var_473_6.position

				var_473_6.forward = Vector3.New(var_473_11.x, var_473_11.y, var_473_11.z)

				local var_473_12 = var_473_6.localEulerAngles

				var_473_12.z = 0
				var_473_12.x = 0
				var_473_6.localEulerAngles = var_473_12
			end

			if arg_470_1.time_ >= var_473_7 + var_473_8 and arg_470_1.time_ < var_473_7 + var_473_8 + arg_473_0 then
				var_473_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_473_13 = manager.ui.mainCamera.transform.position - var_473_6.position

				var_473_6.forward = Vector3.New(var_473_13.x, var_473_13.y, var_473_13.z)

				local var_473_14 = var_473_6.localEulerAngles

				var_473_14.z = 0
				var_473_14.x = 0
				var_473_6.localEulerAngles = var_473_14
			end

			local var_473_15 = 0
			local var_473_16 = 0.4

			if var_473_15 < arg_470_1.time_ and arg_470_1.time_ <= var_473_15 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_17 = arg_470_1:FormatText(StoryNameCfg[471].name)

				arg_470_1.leftNameTxt_.text = var_473_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_18 = arg_470_1:GetWordFromCfg(1109511116)
				local var_473_19 = arg_470_1:FormatText(var_473_18.content)

				arg_470_1.text_.text = var_473_19

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_20 = 16
				local var_473_21 = utf8.len(var_473_19)
				local var_473_22 = var_473_20 <= 0 and var_473_16 or var_473_16 * (var_473_21 / var_473_20)

				if var_473_22 > 0 and var_473_16 < var_473_22 then
					arg_470_1.talkMaxDuration = var_473_22

					if var_473_22 + var_473_15 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_22 + var_473_15
					end
				end

				arg_470_1.text_.text = var_473_19
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb") ~= 0 then
					local var_473_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb") / 1000

					if var_473_23 + var_473_15 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_23 + var_473_15
					end

					if var_473_18.prefab_name ~= "" and arg_470_1.actors_[var_473_18.prefab_name] ~= nil then
						local var_473_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_18.prefab_name].transform, "story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")

						arg_470_1:RecordAudio("1109511116", var_473_24)
						arg_470_1:RecordAudio("1109511116", var_473_24)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_25 = math.max(var_473_16, arg_470_1.talkMaxDuration)

			if var_473_15 <= arg_470_1.time_ and arg_470_1.time_ < var_473_15 + var_473_25 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_15) / var_473_25

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_15 + var_473_25 and arg_470_1.time_ < var_473_15 + var_473_25 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play1109511117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1109511117
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1109511118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["10058ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10058ui_story == nil then
				arg_474_1.var_.characterEffect10058ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect10058ui_story and not isNil(var_477_0) then
					local var_477_4 = Mathf.Lerp(0, 0.5, var_477_3)

					arg_474_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_474_1.var_.characterEffect10058ui_story.fillRatio = var_477_4
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10058ui_story then
				local var_477_5 = 0.5

				arg_474_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_474_1.var_.characterEffect10058ui_story.fillRatio = var_477_5
			end

			local var_477_6 = 0
			local var_477_7 = 0.525

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_8 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_9 = arg_474_1:GetWordFromCfg(1109511117)
				local var_477_10 = arg_474_1:FormatText(var_477_9.content)

				arg_474_1.text_.text = var_477_10

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 21
				local var_477_12 = utf8.len(var_477_10)
				local var_477_13 = var_477_11 <= 0 and var_477_7 or var_477_7 * (var_477_12 / var_477_11)

				if var_477_13 > 0 and var_477_7 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_10
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_14 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_14 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_14

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_14 and arg_474_1.time_ < var_477_6 + var_477_14 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play1109511118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1109511118
		arg_478_1.duration_ = 5.27

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1109511119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["10058ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10058ui_story == nil then
				arg_478_1.var_.characterEffect10058ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect10058ui_story and not isNil(var_481_0) then
					arg_478_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10058ui_story then
				arg_478_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_481_4 = 0
			local var_481_5 = 0.6

			if var_481_4 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_6 = arg_478_1:FormatText(StoryNameCfg[471].name)

				arg_478_1.leftNameTxt_.text = var_481_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_7 = arg_478_1:GetWordFromCfg(1109511118)
				local var_481_8 = arg_478_1:FormatText(var_481_7.content)

				arg_478_1.text_.text = var_481_8

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_9 = 24
				local var_481_10 = utf8.len(var_481_8)
				local var_481_11 = var_481_9 <= 0 and var_481_5 or var_481_5 * (var_481_10 / var_481_9)

				if var_481_11 > 0 and var_481_5 < var_481_11 then
					arg_478_1.talkMaxDuration = var_481_11

					if var_481_11 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_11 + var_481_4
					end
				end

				arg_478_1.text_.text = var_481_8
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb") ~= 0 then
					local var_481_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb") / 1000

					if var_481_12 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_4
					end

					if var_481_7.prefab_name ~= "" and arg_478_1.actors_[var_481_7.prefab_name] ~= nil then
						local var_481_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_7.prefab_name].transform, "story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")

						arg_478_1:RecordAudio("1109511118", var_481_13)
						arg_478_1:RecordAudio("1109511118", var_481_13)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_14 = math.max(var_481_5, arg_478_1.talkMaxDuration)

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_14 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_4) / var_481_14

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_4 + var_481_14 and arg_478_1.time_ < var_481_4 + var_481_14 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1109511119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1109511119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1109511120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["10058ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect10058ui_story == nil then
				arg_482_1.var_.characterEffect10058ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect10058ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_482_1.var_.characterEffect10058ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect10058ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_482_1.var_.characterEffect10058ui_story.fillRatio = var_485_5
			end

			local var_485_6 = 0
			local var_485_7 = 0.825

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_8 = arg_482_1:GetWordFromCfg(1109511119)
				local var_485_9 = arg_482_1:FormatText(var_485_8.content)

				arg_482_1.text_.text = var_485_9

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_10 = 33
				local var_485_11 = utf8.len(var_485_9)
				local var_485_12 = var_485_10 <= 0 and var_485_7 or var_485_7 * (var_485_11 / var_485_10)

				if var_485_12 > 0 and var_485_7 < var_485_12 then
					arg_482_1.talkMaxDuration = var_485_12

					if var_485_12 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_12 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_9
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_13 = math.max(var_485_7, arg_482_1.talkMaxDuration)

			if var_485_6 <= arg_482_1.time_ and arg_482_1.time_ < var_485_6 + var_485_13 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_6) / var_485_13

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_6 + var_485_13 and arg_482_1.time_ < var_485_6 + var_485_13 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1109511120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1109511120
		arg_486_1.duration_ = 4.3

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1109511121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["10058ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect10058ui_story == nil then
				arg_486_1.var_.characterEffect10058ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect10058ui_story and not isNil(var_489_0) then
					arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect10058ui_story then
				arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_489_4 = 0

			if var_489_4 < arg_486_1.time_ and arg_486_1.time_ <= var_489_4 + arg_489_0 then
				arg_486_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_489_5 = 0

			if var_489_5 < arg_486_1.time_ and arg_486_1.time_ <= var_489_5 + arg_489_0 then
				arg_486_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_489_6 = 0
			local var_489_7 = 0.35

			if var_489_6 < arg_486_1.time_ and arg_486_1.time_ <= var_489_6 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_8 = arg_486_1:FormatText(StoryNameCfg[471].name)

				arg_486_1.leftNameTxt_.text = var_489_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_9 = arg_486_1:GetWordFromCfg(1109511120)
				local var_489_10 = arg_486_1:FormatText(var_489_9.content)

				arg_486_1.text_.text = var_489_10

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_11 = 14
				local var_489_12 = utf8.len(var_489_10)
				local var_489_13 = var_489_11 <= 0 and var_489_7 or var_489_7 * (var_489_12 / var_489_11)

				if var_489_13 > 0 and var_489_7 < var_489_13 then
					arg_486_1.talkMaxDuration = var_489_13

					if var_489_13 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_13 + var_489_6
					end
				end

				arg_486_1.text_.text = var_489_10
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb") ~= 0 then
					local var_489_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb") / 1000

					if var_489_14 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_14 + var_489_6
					end

					if var_489_9.prefab_name ~= "" and arg_486_1.actors_[var_489_9.prefab_name] ~= nil then
						local var_489_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_9.prefab_name].transform, "story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")

						arg_486_1:RecordAudio("1109511120", var_489_15)
						arg_486_1:RecordAudio("1109511120", var_489_15)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_16 = math.max(var_489_7, arg_486_1.talkMaxDuration)

			if var_489_6 <= arg_486_1.time_ and arg_486_1.time_ < var_489_6 + var_489_16 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_6) / var_489_16

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_6 + var_489_16 and arg_486_1.time_ < var_489_6 + var_489_16 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1109511121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1109511121
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1109511122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["10058ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect10058ui_story == nil then
				arg_490_1.var_.characterEffect10058ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect10058ui_story and not isNil(var_493_0) then
					local var_493_4 = Mathf.Lerp(0, 0.5, var_493_3)

					arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_490_1.var_.characterEffect10058ui_story.fillRatio = var_493_4
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect10058ui_story then
				local var_493_5 = 0.5

				arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_490_1.var_.characterEffect10058ui_story.fillRatio = var_493_5
			end

			local var_493_6 = 0
			local var_493_7 = 0.425

			if var_493_6 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_8 = arg_490_1:FormatText(StoryNameCfg[7].name)

				arg_490_1.leftNameTxt_.text = var_493_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_9 = arg_490_1:GetWordFromCfg(1109511121)
				local var_493_10 = arg_490_1:FormatText(var_493_9.content)

				arg_490_1.text_.text = var_493_10

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_11 = 17
				local var_493_12 = utf8.len(var_493_10)
				local var_493_13 = var_493_11 <= 0 and var_493_7 or var_493_7 * (var_493_12 / var_493_11)

				if var_493_13 > 0 and var_493_7 < var_493_13 then
					arg_490_1.talkMaxDuration = var_493_13

					if var_493_13 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_13 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_10
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_14 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_14 and arg_490_1.time_ < var_493_6 + var_493_14 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1109511122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109511122
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109511123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.575

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[7].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:GetWordFromCfg(1109511122)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 23
				local var_497_6 = utf8.len(var_497_4)
				local var_497_7 = var_497_5 <= 0 and var_497_1 or var_497_1 * (var_497_6 / var_497_5)

				if var_497_7 > 0 and var_497_1 < var_497_7 then
					arg_494_1.talkMaxDuration = var_497_7

					if var_497_7 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_8 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_8 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_8

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_8 and arg_494_1.time_ < var_497_0 + var_497_8 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1109511123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109511123
		arg_498_1.duration_ = 9.23

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109511124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["10058ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10058ui_story == nil then
				arg_498_1.var_.characterEffect10058ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect10058ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10058ui_story then
				arg_498_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_501_4 = 0
			local var_501_5 = 0.925

			if var_501_4 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_6 = arg_498_1:FormatText(StoryNameCfg[471].name)

				arg_498_1.leftNameTxt_.text = var_501_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_7 = arg_498_1:GetWordFromCfg(1109511123)
				local var_501_8 = arg_498_1:FormatText(var_501_7.content)

				arg_498_1.text_.text = var_501_8

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 37
				local var_501_10 = utf8.len(var_501_8)
				local var_501_11 = var_501_9 <= 0 and var_501_5 or var_501_5 * (var_501_10 / var_501_9)

				if var_501_11 > 0 and var_501_5 < var_501_11 then
					arg_498_1.talkMaxDuration = var_501_11

					if var_501_11 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_11 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_8
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb") ~= 0 then
					local var_501_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb") / 1000

					if var_501_12 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_12 + var_501_4
					end

					if var_501_7.prefab_name ~= "" and arg_498_1.actors_[var_501_7.prefab_name] ~= nil then
						local var_501_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_7.prefab_name].transform, "story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")

						arg_498_1:RecordAudio("1109511123", var_501_13)
						arg_498_1:RecordAudio("1109511123", var_501_13)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_14 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_14 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_14

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_14 and arg_498_1.time_ < var_501_4 + var_501_14 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109511124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109511124
		arg_502_1.duration_ = 7.53

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109511125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_505_2 = 0
			local var_505_3 = 0.775

			if var_505_2 < arg_502_1.time_ and arg_502_1.time_ <= var_505_2 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_4 = arg_502_1:FormatText(StoryNameCfg[471].name)

				arg_502_1.leftNameTxt_.text = var_505_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_5 = arg_502_1:GetWordFromCfg(1109511124)
				local var_505_6 = arg_502_1:FormatText(var_505_5.content)

				arg_502_1.text_.text = var_505_6

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_7 = 31
				local var_505_8 = utf8.len(var_505_6)
				local var_505_9 = var_505_7 <= 0 and var_505_3 or var_505_3 * (var_505_8 / var_505_7)

				if var_505_9 > 0 and var_505_3 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_2 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_2
					end
				end

				arg_502_1.text_.text = var_505_6
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb") / 1000

					if var_505_10 + var_505_2 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_2
					end

					if var_505_5.prefab_name ~= "" and arg_502_1.actors_[var_505_5.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_5.prefab_name].transform, "story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")

						arg_502_1:RecordAudio("1109511124", var_505_11)
						arg_502_1:RecordAudio("1109511124", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_3, arg_502_1.talkMaxDuration)

			if var_505_2 <= arg_502_1.time_ and arg_502_1.time_ < var_505_2 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_2) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_2 + var_505_12 and arg_502_1.time_ < var_505_2 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109511125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109511125
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109511126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["10058ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect10058ui_story == nil then
				arg_506_1.var_.characterEffect10058ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect10058ui_story and not isNil(var_509_0) then
					local var_509_4 = Mathf.Lerp(0, 0.5, var_509_3)

					arg_506_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_506_1.var_.characterEffect10058ui_story.fillRatio = var_509_4
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect10058ui_story then
				local var_509_5 = 0.5

				arg_506_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_506_1.var_.characterEffect10058ui_story.fillRatio = var_509_5
			end

			local var_509_6 = 0
			local var_509_7 = 0.675

			if var_509_6 < arg_506_1.time_ and arg_506_1.time_ <= var_509_6 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_8 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_9 = arg_506_1:GetWordFromCfg(1109511125)
				local var_509_10 = arg_506_1:FormatText(var_509_9.content)

				arg_506_1.text_.text = var_509_10

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_11 = 27
				local var_509_12 = utf8.len(var_509_10)
				local var_509_13 = var_509_11 <= 0 and var_509_7 or var_509_7 * (var_509_12 / var_509_11)

				if var_509_13 > 0 and var_509_7 < var_509_13 then
					arg_506_1.talkMaxDuration = var_509_13

					if var_509_13 + var_509_6 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_13 + var_509_6
					end
				end

				arg_506_1.text_.text = var_509_10
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_14 = math.max(var_509_7, arg_506_1.talkMaxDuration)

			if var_509_6 <= arg_506_1.time_ and arg_506_1.time_ < var_509_6 + var_509_14 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_6) / var_509_14

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_6 + var_509_14 and arg_506_1.time_ < var_509_6 + var_509_14 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109511126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109511126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109511127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 0.875

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_2 = arg_510_1:FormatText(StoryNameCfg[7].name)

				arg_510_1.leftNameTxt_.text = var_513_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_3 = arg_510_1:GetWordFromCfg(1109511126)
				local var_513_4 = arg_510_1:FormatText(var_513_3.content)

				arg_510_1.text_.text = var_513_4

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 35
				local var_513_6 = utf8.len(var_513_4)
				local var_513_7 = var_513_5 <= 0 and var_513_1 or var_513_1 * (var_513_6 / var_513_5)

				if var_513_7 > 0 and var_513_1 < var_513_7 then
					arg_510_1.talkMaxDuration = var_513_7

					if var_513_7 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_7 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_4
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_8 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_8 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_8

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_8 and arg_510_1.time_ < var_513_0 + var_513_8 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109511127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1109511127
		arg_514_1.duration_ = 8.25

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1109511128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = "ST70"

			if arg_514_1.bgs_[var_517_0] == nil then
				local var_517_1 = Object.Instantiate(arg_514_1.paintGo_)

				var_517_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_517_0)
				var_517_1.name = var_517_0
				var_517_1.transform.parent = arg_514_1.stage_.transform
				var_517_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.bgs_[var_517_0] = var_517_1
			end

			local var_517_2 = 1.5

			if var_517_2 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				local var_517_3 = manager.ui.mainCamera.transform.localPosition
				local var_517_4 = Vector3.New(0, 0, 10) + Vector3.New(var_517_3.x, var_517_3.y, 0)
				local var_517_5 = arg_514_1.bgs_.ST70

				var_517_5.transform.localPosition = var_517_4
				var_517_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_6 = var_517_5:GetComponent("SpriteRenderer")

				if var_517_6 and var_517_6.sprite then
					local var_517_7 = (var_517_5.transform.localPosition - var_517_3).z
					local var_517_8 = manager.ui.mainCameraCom_
					local var_517_9 = 2 * var_517_7 * Mathf.Tan(var_517_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_517_10 = var_517_9 * var_517_8.aspect
					local var_517_11 = var_517_6.sprite.bounds.size.x
					local var_517_12 = var_517_6.sprite.bounds.size.y
					local var_517_13 = var_517_10 / var_517_11
					local var_517_14 = var_517_9 / var_517_12
					local var_517_15 = var_517_14 < var_517_13 and var_517_13 or var_517_14

					var_517_5.transform.localScale = Vector3.New(var_517_15, var_517_15, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "ST70" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_16 = 1.5

			if var_517_16 < arg_514_1.time_ and arg_514_1.time_ <= var_517_16 + arg_517_0 then
				arg_514_1.allBtn_.enabled = false
			end

			local var_517_17 = 0.3

			if arg_514_1.time_ >= var_517_16 + var_517_17 and arg_514_1.time_ < var_517_16 + var_517_17 + arg_517_0 then
				arg_514_1.allBtn_.enabled = true
			end

			local var_517_18 = 0

			if var_517_18 < arg_514_1.time_ and arg_514_1.time_ <= var_517_18 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_19 = 1.5

			if var_517_18 <= arg_514_1.time_ and arg_514_1.time_ < var_517_18 + var_517_19 then
				local var_517_20 = (arg_514_1.time_ - var_517_18) / var_517_19
				local var_517_21 = Color.New(0, 0, 0)

				var_517_21.a = Mathf.Lerp(0, 1, var_517_20)
				arg_514_1.mask_.color = var_517_21
			end

			if arg_514_1.time_ >= var_517_18 + var_517_19 and arg_514_1.time_ < var_517_18 + var_517_19 + arg_517_0 then
				local var_517_22 = Color.New(0, 0, 0)

				var_517_22.a = 1
				arg_514_1.mask_.color = var_517_22
			end

			local var_517_23 = 1.5

			if var_517_23 < arg_514_1.time_ and arg_514_1.time_ <= var_517_23 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_24 = 2

			if var_517_23 <= arg_514_1.time_ and arg_514_1.time_ < var_517_23 + var_517_24 then
				local var_517_25 = (arg_514_1.time_ - var_517_23) / var_517_24
				local var_517_26 = Color.New(0, 0, 0)

				var_517_26.a = Mathf.Lerp(1, 0, var_517_25)
				arg_514_1.mask_.color = var_517_26
			end

			if arg_514_1.time_ >= var_517_23 + var_517_24 and arg_514_1.time_ < var_517_23 + var_517_24 + arg_517_0 then
				local var_517_27 = Color.New(0, 0, 0)
				local var_517_28 = 0

				arg_514_1.mask_.enabled = false
				var_517_27.a = var_517_28
				arg_514_1.mask_.color = var_517_27
			end

			local var_517_29 = arg_514_1.actors_["10058ui_story"].transform
			local var_517_30 = 1.5

			if var_517_30 < arg_514_1.time_ and arg_514_1.time_ <= var_517_30 + arg_517_0 then
				arg_514_1.var_.moveOldPos10058ui_story = var_517_29.localPosition
			end

			local var_517_31 = 0.001

			if var_517_30 <= arg_514_1.time_ and arg_514_1.time_ < var_517_30 + var_517_31 then
				local var_517_32 = (arg_514_1.time_ - var_517_30) / var_517_31
				local var_517_33 = Vector3.New(0, 100, 0)

				var_517_29.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10058ui_story, var_517_33, var_517_32)

				local var_517_34 = manager.ui.mainCamera.transform.position - var_517_29.position

				var_517_29.forward = Vector3.New(var_517_34.x, var_517_34.y, var_517_34.z)

				local var_517_35 = var_517_29.localEulerAngles

				var_517_35.z = 0
				var_517_35.x = 0
				var_517_29.localEulerAngles = var_517_35
			end

			if arg_514_1.time_ >= var_517_30 + var_517_31 and arg_514_1.time_ < var_517_30 + var_517_31 + arg_517_0 then
				var_517_29.localPosition = Vector3.New(0, 100, 0)

				local var_517_36 = manager.ui.mainCamera.transform.position - var_517_29.position

				var_517_29.forward = Vector3.New(var_517_36.x, var_517_36.y, var_517_36.z)

				local var_517_37 = var_517_29.localEulerAngles

				var_517_37.z = 0
				var_517_37.x = 0
				var_517_29.localEulerAngles = var_517_37
			end

			local var_517_38 = 1
			local var_517_39 = 1

			if var_517_38 < arg_514_1.time_ and arg_514_1.time_ <= var_517_38 + arg_517_0 then
				local var_517_40 = "play"
				local var_517_41 = "effect"

				arg_514_1:AudioAction(var_517_40, var_517_41, "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			local var_517_42 = 0.2
			local var_517_43 = 1

			if var_517_42 < arg_514_1.time_ and arg_514_1.time_ <= var_517_42 + arg_517_0 then
				local var_517_44 = "stop"
				local var_517_45 = "effect"

				arg_514_1:AudioAction(var_517_44, var_517_45, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_517_46 = 1
			local var_517_47 = 1

			if var_517_46 < arg_514_1.time_ and arg_514_1.time_ <= var_517_46 + arg_517_0 then
				local var_517_48 = "play"
				local var_517_49 = "music"

				arg_514_1:AudioAction(var_517_48, var_517_49, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_517_50 = ""
				local var_517_51 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if var_517_51 ~= "" then
					if arg_514_1.bgmTxt_.text ~= var_517_51 and arg_514_1.bgmTxt_.text ~= "" then
						if arg_514_1.bgmTxt2_.text ~= "" then
							arg_514_1.bgmTxt_.text = arg_514_1.bgmTxt2_.text
						end

						arg_514_1.bgmTxt2_.text = var_517_51

						arg_514_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_514_1.bgmTxt_.text = var_517_51
						arg_514_1.bgmTxt2_.text = var_517_51
					end

					if arg_514_1.bgmTimer then
						arg_514_1.bgmTimer:Stop()

						arg_514_1.bgmTimer = nil
					end

					if arg_514_1.settingData.show_music_name == 1 then
						arg_514_1.musicController:SetSelectedState("show")
						arg_514_1.musicAnimator_:Play("open", 0, 0)

						if arg_514_1.settingData.music_time ~= 0 then
							arg_514_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_514_1.settingData.music_time), function()
								if arg_514_1 == nil or isNil(arg_514_1.bgmTxt_) then
									return
								end

								arg_514_1.musicController:SetSelectedState("hide")
								arg_514_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_517_52 = 0
			local var_517_53 = 1

			if var_517_52 < arg_514_1.time_ and arg_514_1.time_ <= var_517_52 + arg_517_0 then
				local var_517_54 = "play"
				local var_517_55 = "effect"

				arg_514_1:AudioAction(var_517_54, var_517_55, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_56 = 3.25
			local var_517_57 = 1.375

			if var_517_56 < arg_514_1.time_ and arg_514_1.time_ <= var_517_56 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_58 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_58:setOnUpdate(LuaHelper.FloatAction(function(arg_519_0)
					arg_514_1.dialogCg_.alpha = arg_519_0
				end))
				var_517_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_59 = arg_514_1:GetWordFromCfg(1109511127)
				local var_517_60 = arg_514_1:FormatText(var_517_59.content)

				arg_514_1.text_.text = var_517_60

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_61 = 55
				local var_517_62 = utf8.len(var_517_60)
				local var_517_63 = var_517_61 <= 0 and var_517_57 or var_517_57 * (var_517_62 / var_517_61)

				if var_517_63 > 0 and var_517_57 < var_517_63 then
					arg_514_1.talkMaxDuration = var_517_63
					var_517_56 = var_517_56 + 0.3

					if var_517_63 + var_517_56 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_63 + var_517_56
					end
				end

				arg_514_1.text_.text = var_517_60
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_64 = var_517_56 + 0.3
			local var_517_65 = math.max(var_517_57, arg_514_1.talkMaxDuration)

			if var_517_64 <= arg_514_1.time_ and arg_514_1.time_ < var_517_64 + var_517_65 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_64) / var_517_65

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_64 + var_517_65 and arg_514_1.time_ < var_517_64 + var_517_65 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1109511128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109511128
		arg_521_1.duration_ = 6.53

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109511129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.9

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[1555].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:GetWordFromCfg(1109511128)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")

						arg_521_1:RecordAudio("1109511128", var_524_9)
						arg_521_1:RecordAudio("1109511128", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")
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
	Play1109511129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1109511129
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1109511130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.65

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_2 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_2

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

				local var_528_3 = arg_525_1:GetWordFromCfg(1109511129)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 26
				local var_528_6 = utf8.len(var_528_4)
				local var_528_7 = var_528_5 <= 0 and var_528_1 or var_528_1 * (var_528_6 / var_528_5)

				if var_528_7 > 0 and var_528_1 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_8 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_8 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_8

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_8 and arg_525_1.time_ < var_528_0 + var_528_8 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1109511130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1109511130
		arg_529_1.duration_ = 11.53

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1109511131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 1.45

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_2 = arg_529_1:FormatText(StoryNameCfg[1555].name)

				arg_529_1.leftNameTxt_.text = var_532_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:GetWordFromCfg(1109511130)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb") ~= 0 then
					local var_532_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb") / 1000

					if var_532_8 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_8 + var_532_0
					end

					if var_532_3.prefab_name ~= "" and arg_529_1.actors_[var_532_3.prefab_name] ~= nil then
						local var_532_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_3.prefab_name].transform, "story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")

						arg_529_1:RecordAudio("1109511130", var_532_9)
						arg_529_1:RecordAudio("1109511130", var_532_9)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_10 and arg_529_1.time_ < var_532_0 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1109511131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1109511131
		arg_533_1.duration_ = 6.73

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1109511132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.825

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[1555].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:GetWordFromCfg(1109511131)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")

						arg_533_1:RecordAudio("1109511131", var_536_9)
						arg_533_1:RecordAudio("1109511131", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")
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
	Play1109511132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109511132
		arg_537_1.duration_ = 3.43

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1109511133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["10058ui_story"].transform
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.var_.moveOldPos10058ui_story = var_540_0.localPosition
			end

			local var_540_2 = 0.001

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2
				local var_540_4 = Vector3.New(0, -0.98, -6.1)

				var_540_0.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10058ui_story, var_540_4, var_540_3)

				local var_540_5 = manager.ui.mainCamera.transform.position - var_540_0.position

				var_540_0.forward = Vector3.New(var_540_5.x, var_540_5.y, var_540_5.z)

				local var_540_6 = var_540_0.localEulerAngles

				var_540_6.z = 0
				var_540_6.x = 0
				var_540_0.localEulerAngles = var_540_6
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 then
				var_540_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_540_7 = manager.ui.mainCamera.transform.position - var_540_0.position

				var_540_0.forward = Vector3.New(var_540_7.x, var_540_7.y, var_540_7.z)

				local var_540_8 = var_540_0.localEulerAngles

				var_540_8.z = 0
				var_540_8.x = 0
				var_540_0.localEulerAngles = var_540_8
			end

			local var_540_9 = arg_537_1.actors_["10058ui_story"]
			local var_540_10 = 0

			if var_540_10 < arg_537_1.time_ and arg_537_1.time_ <= var_540_10 + arg_540_0 and not isNil(var_540_9) and arg_537_1.var_.characterEffect10058ui_story == nil then
				arg_537_1.var_.characterEffect10058ui_story = var_540_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_11 = 0.200000002980232

			if var_540_10 <= arg_537_1.time_ and arg_537_1.time_ < var_540_10 + var_540_11 and not isNil(var_540_9) then
				local var_540_12 = (arg_537_1.time_ - var_540_10) / var_540_11

				if arg_537_1.var_.characterEffect10058ui_story and not isNil(var_540_9) then
					arg_537_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= var_540_10 + var_540_11 and arg_537_1.time_ < var_540_10 + var_540_11 + arg_540_0 and not isNil(var_540_9) and arg_537_1.var_.characterEffect10058ui_story then
				arg_537_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_540_13 = 0

			if var_540_13 < arg_537_1.time_ and arg_537_1.time_ <= var_540_13 + arg_540_0 then
				arg_537_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_540_14 = 0
			local var_540_15 = 0.45

			if var_540_14 < arg_537_1.time_ and arg_537_1.time_ <= var_540_14 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_16 = arg_537_1:FormatText(StoryNameCfg[471].name)

				arg_537_1.leftNameTxt_.text = var_540_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_17 = arg_537_1:GetWordFromCfg(1109511132)
				local var_540_18 = arg_537_1:FormatText(var_540_17.content)

				arg_537_1.text_.text = var_540_18

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_19 = 18
				local var_540_20 = utf8.len(var_540_18)
				local var_540_21 = var_540_19 <= 0 and var_540_15 or var_540_15 * (var_540_20 / var_540_19)

				if var_540_21 > 0 and var_540_15 < var_540_21 then
					arg_537_1.talkMaxDuration = var_540_21

					if var_540_21 + var_540_14 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_21 + var_540_14
					end
				end

				arg_537_1.text_.text = var_540_18
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb") ~= 0 then
					local var_540_22 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb") / 1000

					if var_540_22 + var_540_14 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_22 + var_540_14
					end

					if var_540_17.prefab_name ~= "" and arg_537_1.actors_[var_540_17.prefab_name] ~= nil then
						local var_540_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_17.prefab_name].transform, "story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")

						arg_537_1:RecordAudio("1109511132", var_540_23)
						arg_537_1:RecordAudio("1109511132", var_540_23)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_24 = math.max(var_540_15, arg_537_1.talkMaxDuration)

			if var_540_14 <= arg_537_1.time_ and arg_537_1.time_ < var_540_14 + var_540_24 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_14) / var_540_24

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_14 + var_540_24 and arg_537_1.time_ < var_540_14 + var_540_24 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play1109511133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109511133
		arg_541_1.duration_ = 6.9

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109511134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.925

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[471].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(1109511133)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 37
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")

						arg_541_1:RecordAudio("1109511133", var_544_9)
						arg_541_1:RecordAudio("1109511133", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109511134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109511134
		arg_545_1.duration_ = 3.87

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109511135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["10058ui_story"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10058ui_story == nil then
				arg_545_1.var_.characterEffect10058ui_story = var_548_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.characterEffect10058ui_story and not isNil(var_548_0) then
					local var_548_4 = Mathf.Lerp(0, 0.5, var_548_3)

					arg_545_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_545_1.var_.characterEffect10058ui_story.fillRatio = var_548_4
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10058ui_story then
				local var_548_5 = 0.5

				arg_545_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_545_1.var_.characterEffect10058ui_story.fillRatio = var_548_5
			end

			local var_548_6 = 0
			local var_548_7 = 0.5

			if var_548_6 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_8 = arg_545_1:FormatText(StoryNameCfg[1555].name)

				arg_545_1.leftNameTxt_.text = var_548_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_9 = arg_545_1:GetWordFromCfg(1109511134)
				local var_548_10 = arg_545_1:FormatText(var_548_9.content)

				arg_545_1.text_.text = var_548_10

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_11 = 20
				local var_548_12 = utf8.len(var_548_10)
				local var_548_13 = var_548_11 <= 0 and var_548_7 or var_548_7 * (var_548_12 / var_548_11)

				if var_548_13 > 0 and var_548_7 < var_548_13 then
					arg_545_1.talkMaxDuration = var_548_13

					if var_548_13 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_13 + var_548_6
					end
				end

				arg_545_1.text_.text = var_548_10
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb") ~= 0 then
					local var_548_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb") / 1000

					if var_548_14 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_14 + var_548_6
					end

					if var_548_9.prefab_name ~= "" and arg_545_1.actors_[var_548_9.prefab_name] ~= nil then
						local var_548_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_9.prefab_name].transform, "story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")

						arg_545_1:RecordAudio("1109511134", var_548_15)
						arg_545_1:RecordAudio("1109511134", var_548_15)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_16 = math.max(var_548_7, arg_545_1.talkMaxDuration)

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_16 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_6) / var_548_16

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_6 + var_548_16 and arg_545_1.time_ < var_548_6 + var_548_16 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109511135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1109511135
		arg_549_1.duration_ = 5.9

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1109511136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.725

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[1555].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:GetWordFromCfg(1109511135)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 29
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")

						arg_549_1:RecordAudio("1109511135", var_552_9)
						arg_549_1:RecordAudio("1109511135", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1109511136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1109511136
		arg_553_1.duration_ = 6.07

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1109511137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["10058ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect10058ui_story == nil then
				arg_553_1.var_.characterEffect10058ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect10058ui_story and not isNil(var_556_0) then
					arg_553_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect10058ui_story then
				arg_553_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_556_4 = 0

			if var_556_4 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_556_5 = 0
			local var_556_6 = 0.85

			if var_556_5 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_7 = arg_553_1:FormatText(StoryNameCfg[471].name)

				arg_553_1.leftNameTxt_.text = var_556_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_8 = arg_553_1:GetWordFromCfg(1109511136)
				local var_556_9 = arg_553_1:FormatText(var_556_8.content)

				arg_553_1.text_.text = var_556_9

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 34
				local var_556_11 = utf8.len(var_556_9)
				local var_556_12 = var_556_10 <= 0 and var_556_6 or var_556_6 * (var_556_11 / var_556_10)

				if var_556_12 > 0 and var_556_6 < var_556_12 then
					arg_553_1.talkMaxDuration = var_556_12

					if var_556_12 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_12 + var_556_5
					end
				end

				arg_553_1.text_.text = var_556_9
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb") ~= 0 then
					local var_556_13 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb") / 1000

					if var_556_13 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_5
					end

					if var_556_8.prefab_name ~= "" and arg_553_1.actors_[var_556_8.prefab_name] ~= nil then
						local var_556_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_8.prefab_name].transform, "story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")

						arg_553_1:RecordAudio("1109511136", var_556_14)
						arg_553_1:RecordAudio("1109511136", var_556_14)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_15 = math.max(var_556_6, arg_553_1.talkMaxDuration)

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_15 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_5) / var_556_15

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_5 + var_556_15 and arg_553_1.time_ < var_556_5 + var_556_15 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1109511137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1109511137
		arg_557_1.duration_ = 5.5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1109511138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10058ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect10058ui_story == nil then
				arg_557_1.var_.characterEffect10058ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.200000002980232

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect10058ui_story and not isNil(var_560_0) then
					local var_560_4 = Mathf.Lerp(0, 0.5, var_560_3)

					arg_557_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_557_1.var_.characterEffect10058ui_story.fillRatio = var_560_4
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect10058ui_story then
				local var_560_5 = 0.5

				arg_557_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_557_1.var_.characterEffect10058ui_story.fillRatio = var_560_5
			end

			local var_560_6 = 0
			local var_560_7 = 0.675

			if var_560_6 < arg_557_1.time_ and arg_557_1.time_ <= var_560_6 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_8 = arg_557_1:FormatText(StoryNameCfg[1555].name)

				arg_557_1.leftNameTxt_.text = var_560_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_9 = arg_557_1:GetWordFromCfg(1109511137)
				local var_560_10 = arg_557_1:FormatText(var_560_9.content)

				arg_557_1.text_.text = var_560_10

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_11 = 27
				local var_560_12 = utf8.len(var_560_10)
				local var_560_13 = var_560_11 <= 0 and var_560_7 or var_560_7 * (var_560_12 / var_560_11)

				if var_560_13 > 0 and var_560_7 < var_560_13 then
					arg_557_1.talkMaxDuration = var_560_13

					if var_560_13 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_13 + var_560_6
					end
				end

				arg_557_1.text_.text = var_560_10
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb") ~= 0 then
					local var_560_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb") / 1000

					if var_560_14 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_14 + var_560_6
					end

					if var_560_9.prefab_name ~= "" and arg_557_1.actors_[var_560_9.prefab_name] ~= nil then
						local var_560_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_9.prefab_name].transform, "story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")

						arg_557_1:RecordAudio("1109511137", var_560_15)
						arg_557_1:RecordAudio("1109511137", var_560_15)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_16 = math.max(var_560_7, arg_557_1.talkMaxDuration)

			if var_560_6 <= arg_557_1.time_ and arg_557_1.time_ < var_560_6 + var_560_16 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_6) / var_560_16

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_6 + var_560_16 and arg_557_1.time_ < var_560_6 + var_560_16 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1109511138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1109511138
		arg_561_1.duration_ = 4.77

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1109511139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.65

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[1555].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:GetWordFromCfg(1109511138)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 26
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb") / 1000

					if var_564_8 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_0
					end

					if var_564_3.prefab_name ~= "" and arg_561_1.actors_[var_564_3.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_3.prefab_name].transform, "story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")

						arg_561_1:RecordAudio("1109511138", var_564_9)
						arg_561_1:RecordAudio("1109511138", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_10 and arg_561_1.time_ < var_564_0 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1109511139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1109511139
		arg_565_1.duration_ = 9.07

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1109511140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["10058ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect10058ui_story == nil then
				arg_565_1.var_.characterEffect10058ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect10058ui_story and not isNil(var_568_0) then
					arg_565_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect10058ui_story then
				arg_565_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_568_4 = 0

			if var_568_4 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action427")
			end

			local var_568_5 = 0
			local var_568_6 = 0.925

			if var_568_5 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_7 = arg_565_1:FormatText(StoryNameCfg[471].name)

				arg_565_1.leftNameTxt_.text = var_568_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_8 = arg_565_1:GetWordFromCfg(1109511139)
				local var_568_9 = arg_565_1:FormatText(var_568_8.content)

				arg_565_1.text_.text = var_568_9

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_10 = 37
				local var_568_11 = utf8.len(var_568_9)
				local var_568_12 = var_568_10 <= 0 and var_568_6 or var_568_6 * (var_568_11 / var_568_10)

				if var_568_12 > 0 and var_568_6 < var_568_12 then
					arg_565_1.talkMaxDuration = var_568_12

					if var_568_12 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_12 + var_568_5
					end
				end

				arg_565_1.text_.text = var_568_9
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb") ~= 0 then
					local var_568_13 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb") / 1000

					if var_568_13 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_13 + var_568_5
					end

					if var_568_8.prefab_name ~= "" and arg_565_1.actors_[var_568_8.prefab_name] ~= nil then
						local var_568_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_8.prefab_name].transform, "story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")

						arg_565_1:RecordAudio("1109511139", var_568_14)
						arg_565_1:RecordAudio("1109511139", var_568_14)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_15 = math.max(var_568_6, arg_565_1.talkMaxDuration)

			if var_568_5 <= arg_565_1.time_ and arg_565_1.time_ < var_568_5 + var_568_15 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_5) / var_568_15

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_5 + var_568_15 and arg_565_1.time_ < var_568_5 + var_568_15 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1109511140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1109511140
		arg_569_1.duration_ = 7.92

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1109511141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 1.35

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				local var_572_1 = manager.ui.mainCamera.transform.localPosition
				local var_572_2 = Vector3.New(0, 0, 10) + Vector3.New(var_572_1.x, var_572_1.y, 0)
				local var_572_3 = arg_569_1.bgs_.ST70

				var_572_3.transform.localPosition = var_572_2
				var_572_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_572_4 = var_572_3:GetComponent("SpriteRenderer")

				if var_572_4 and var_572_4.sprite then
					local var_572_5 = (var_572_3.transform.localPosition - var_572_1).z
					local var_572_6 = manager.ui.mainCameraCom_
					local var_572_7 = 2 * var_572_5 * Mathf.Tan(var_572_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_572_8 = var_572_7 * var_572_6.aspect
					local var_572_9 = var_572_4.sprite.bounds.size.x
					local var_572_10 = var_572_4.sprite.bounds.size.y
					local var_572_11 = var_572_8 / var_572_9
					local var_572_12 = var_572_7 / var_572_10
					local var_572_13 = var_572_12 < var_572_11 and var_572_11 or var_572_12

					var_572_3.transform.localScale = Vector3.New(var_572_13, var_572_13, 0)
				end

				for iter_572_0, iter_572_1 in pairs(arg_569_1.bgs_) do
					if iter_572_0 ~= "ST70" then
						iter_572_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_572_14 = 0

			if var_572_14 < arg_569_1.time_ and arg_569_1.time_ <= var_572_14 + arg_572_0 then
				arg_569_1.allBtn_.enabled = false
			end

			local var_572_15 = 0.3

			if arg_569_1.time_ >= var_572_14 + var_572_15 and arg_569_1.time_ < var_572_14 + var_572_15 + arg_572_0 then
				arg_569_1.allBtn_.enabled = true
			end

			local var_572_16 = 0

			if var_572_16 < arg_569_1.time_ and arg_569_1.time_ <= var_572_16 + arg_572_0 then
				arg_569_1.mask_.enabled = true
				arg_569_1.mask_.raycastTarget = true

				arg_569_1:SetGaussion(false)
			end

			local var_572_17 = 1.35

			if var_572_16 <= arg_569_1.time_ and arg_569_1.time_ < var_572_16 + var_572_17 then
				local var_572_18 = (arg_569_1.time_ - var_572_16) / var_572_17
				local var_572_19 = Color.New(0, 0, 0)

				var_572_19.a = Mathf.Lerp(0, 1, var_572_18)
				arg_569_1.mask_.color = var_572_19
			end

			if arg_569_1.time_ >= var_572_16 + var_572_17 and arg_569_1.time_ < var_572_16 + var_572_17 + arg_572_0 then
				local var_572_20 = Color.New(0, 0, 0)

				var_572_20.a = 1
				arg_569_1.mask_.color = var_572_20
			end

			local var_572_21 = 1.35

			if var_572_21 < arg_569_1.time_ and arg_569_1.time_ <= var_572_21 + arg_572_0 then
				arg_569_1.mask_.enabled = true
				arg_569_1.mask_.raycastTarget = true

				arg_569_1:SetGaussion(false)
			end

			local var_572_22 = 2

			if var_572_21 <= arg_569_1.time_ and arg_569_1.time_ < var_572_21 + var_572_22 then
				local var_572_23 = (arg_569_1.time_ - var_572_21) / var_572_22
				local var_572_24 = Color.New(0, 0, 0)

				var_572_24.a = Mathf.Lerp(1, 0, var_572_23)
				arg_569_1.mask_.color = var_572_24
			end

			if arg_569_1.time_ >= var_572_21 + var_572_22 and arg_569_1.time_ < var_572_21 + var_572_22 + arg_572_0 then
				local var_572_25 = Color.New(0, 0, 0)
				local var_572_26 = 0

				arg_569_1.mask_.enabled = false
				var_572_25.a = var_572_26
				arg_569_1.mask_.color = var_572_25
			end

			local var_572_27 = arg_569_1.actors_["10058ui_story"]
			local var_572_28 = 0

			if var_572_28 < arg_569_1.time_ and arg_569_1.time_ <= var_572_28 + arg_572_0 and not isNil(var_572_27) and arg_569_1.var_.characterEffect10058ui_story == nil then
				arg_569_1.var_.characterEffect10058ui_story = var_572_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_29 = 0.200000002980232

			if var_572_28 <= arg_569_1.time_ and arg_569_1.time_ < var_572_28 + var_572_29 and not isNil(var_572_27) then
				local var_572_30 = (arg_569_1.time_ - var_572_28) / var_572_29

				if arg_569_1.var_.characterEffect10058ui_story and not isNil(var_572_27) then
					local var_572_31 = Mathf.Lerp(0, 0.5, var_572_30)

					arg_569_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_569_1.var_.characterEffect10058ui_story.fillRatio = var_572_31
				end
			end

			if arg_569_1.time_ >= var_572_28 + var_572_29 and arg_569_1.time_ < var_572_28 + var_572_29 + arg_572_0 and not isNil(var_572_27) and arg_569_1.var_.characterEffect10058ui_story then
				local var_572_32 = 0.5

				arg_569_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_569_1.var_.characterEffect10058ui_story.fillRatio = var_572_32
			end

			local var_572_33 = arg_569_1.actors_["10058ui_story"].transform
			local var_572_34 = 1.35

			if var_572_34 < arg_569_1.time_ and arg_569_1.time_ <= var_572_34 + arg_572_0 then
				arg_569_1.var_.moveOldPos10058ui_story = var_572_33.localPosition
			end

			local var_572_35 = 0.001

			if var_572_34 <= arg_569_1.time_ and arg_569_1.time_ < var_572_34 + var_572_35 then
				local var_572_36 = (arg_569_1.time_ - var_572_34) / var_572_35
				local var_572_37 = Vector3.New(0, 100, 0)

				var_572_33.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos10058ui_story, var_572_37, var_572_36)

				local var_572_38 = manager.ui.mainCamera.transform.position - var_572_33.position

				var_572_33.forward = Vector3.New(var_572_38.x, var_572_38.y, var_572_38.z)

				local var_572_39 = var_572_33.localEulerAngles

				var_572_39.z = 0
				var_572_39.x = 0
				var_572_33.localEulerAngles = var_572_39
			end

			if arg_569_1.time_ >= var_572_34 + var_572_35 and arg_569_1.time_ < var_572_34 + var_572_35 + arg_572_0 then
				var_572_33.localPosition = Vector3.New(0, 100, 0)

				local var_572_40 = manager.ui.mainCamera.transform.position - var_572_33.position

				var_572_33.forward = Vector3.New(var_572_40.x, var_572_40.y, var_572_40.z)

				local var_572_41 = var_572_33.localEulerAngles

				var_572_41.z = 0
				var_572_41.x = 0
				var_572_33.localEulerAngles = var_572_41
			end

			if arg_569_1.frameCnt_ <= 1 then
				arg_569_1.dialog_:SetActive(false)
			end

			local var_572_42 = 2.91666666666667
			local var_572_43 = 1

			if var_572_42 < arg_569_1.time_ and arg_569_1.time_ <= var_572_42 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0

				arg_569_1.dialog_:SetActive(true)

				arg_569_1.dialogCg_.alpha = 0

				local var_572_44 = LeanTween.value(arg_569_1.dialog_, 0, 1, 0.3)

				var_572_44:setOnUpdate(LuaHelper.FloatAction(function(arg_573_0)
					arg_569_1.dialogCg_.alpha = arg_573_0
				end))
				var_572_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_569_1.dialog_)
					var_572_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_569_1.duration_ = arg_569_1.duration_ + 0.3

				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_45 = arg_569_1:GetWordFromCfg(1109511140)
				local var_572_46 = arg_569_1:FormatText(var_572_45.content)

				arg_569_1.text_.text = var_572_46

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_47 = 40
				local var_572_48 = utf8.len(var_572_46)
				local var_572_49 = var_572_47 <= 0 and var_572_43 or var_572_43 * (var_572_48 / var_572_47)

				if var_572_49 > 0 and var_572_43 < var_572_49 then
					arg_569_1.talkMaxDuration = var_572_49
					var_572_42 = var_572_42 + 0.3

					if var_572_49 + var_572_42 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_49 + var_572_42
					end
				end

				arg_569_1.text_.text = var_572_46
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_50 = var_572_42 + 0.3
			local var_572_51 = math.max(var_572_43, arg_569_1.talkMaxDuration)

			if var_572_50 <= arg_569_1.time_ and arg_569_1.time_ < var_572_50 + var_572_51 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_50) / var_572_51

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_50 + var_572_51 and arg_569_1.time_ < var_572_50 + var_572_51 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1109511141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1109511141
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1109511142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.775

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

				local var_578_3 = arg_575_1:GetWordFromCfg(1109511141)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 31
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
	Play1109511142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109511142
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109511143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 1.1

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_2 = arg_579_1:GetWordFromCfg(1109511142)
				local var_582_3 = arg_579_1:FormatText(var_582_2.content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 44
				local var_582_5 = utf8.len(var_582_3)
				local var_582_6 = var_582_4 <= 0 and var_582_1 or var_582_1 * (var_582_5 / var_582_4)

				if var_582_6 > 0 and var_582_1 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_7 and arg_579_1.time_ < var_582_0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109511143 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109511143
		arg_583_1.duration_ = 4.23

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109511144(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.425

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[1556].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_3 = arg_583_1:GetWordFromCfg(1109511143)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 17
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")

						arg_583_1:RecordAudio("1109511143", var_586_9)
						arg_583_1:RecordAudio("1109511143", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109511144 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109511144
		arg_587_1.duration_ = 6.4

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109511145(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["10058ui_story"]
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect10058ui_story == nil then
				arg_587_1.var_.characterEffect10058ui_story = var_590_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_2 = 0.200000002980232

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 and not isNil(var_590_0) then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2

				if arg_587_1.var_.characterEffect10058ui_story and not isNil(var_590_0) then
					arg_587_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect10058ui_story then
				arg_587_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_590_4 = arg_587_1.actors_["10058ui_story"].transform
			local var_590_5 = 0

			if var_590_5 < arg_587_1.time_ and arg_587_1.time_ <= var_590_5 + arg_590_0 then
				arg_587_1.var_.moveOldPos10058ui_story = var_590_4.localPosition
			end

			local var_590_6 = 0.001

			if var_590_5 <= arg_587_1.time_ and arg_587_1.time_ < var_590_5 + var_590_6 then
				local var_590_7 = (arg_587_1.time_ - var_590_5) / var_590_6
				local var_590_8 = Vector3.New(0, -0.98, -6.1)

				var_590_4.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10058ui_story, var_590_8, var_590_7)

				local var_590_9 = manager.ui.mainCamera.transform.position - var_590_4.position

				var_590_4.forward = Vector3.New(var_590_9.x, var_590_9.y, var_590_9.z)

				local var_590_10 = var_590_4.localEulerAngles

				var_590_10.z = 0
				var_590_10.x = 0
				var_590_4.localEulerAngles = var_590_10
			end

			if arg_587_1.time_ >= var_590_5 + var_590_6 and arg_587_1.time_ < var_590_5 + var_590_6 + arg_590_0 then
				var_590_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_590_11 = manager.ui.mainCamera.transform.position - var_590_4.position

				var_590_4.forward = Vector3.New(var_590_11.x, var_590_11.y, var_590_11.z)

				local var_590_12 = var_590_4.localEulerAngles

				var_590_12.z = 0
				var_590_12.x = 0
				var_590_4.localEulerAngles = var_590_12
			end

			local var_590_13 = 0

			if var_590_13 < arg_587_1.time_ and arg_587_1.time_ <= var_590_13 + arg_590_0 then
				arg_587_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_590_14 = 0

			if var_590_14 < arg_587_1.time_ and arg_587_1.time_ <= var_590_14 + arg_590_0 then
				arg_587_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_590_15 = 0
			local var_590_16 = 0.675

			if var_590_15 < arg_587_1.time_ and arg_587_1.time_ <= var_590_15 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_17 = arg_587_1:FormatText(StoryNameCfg[471].name)

				arg_587_1.leftNameTxt_.text = var_590_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_18 = arg_587_1:GetWordFromCfg(1109511144)
				local var_590_19 = arg_587_1:FormatText(var_590_18.content)

				arg_587_1.text_.text = var_590_19

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_20 = 27
				local var_590_21 = utf8.len(var_590_19)
				local var_590_22 = var_590_20 <= 0 and var_590_16 or var_590_16 * (var_590_21 / var_590_20)

				if var_590_22 > 0 and var_590_16 < var_590_22 then
					arg_587_1.talkMaxDuration = var_590_22

					if var_590_22 + var_590_15 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_22 + var_590_15
					end
				end

				arg_587_1.text_.text = var_590_19
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb") ~= 0 then
					local var_590_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb") / 1000

					if var_590_23 + var_590_15 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_23 + var_590_15
					end

					if var_590_18.prefab_name ~= "" and arg_587_1.actors_[var_590_18.prefab_name] ~= nil then
						local var_590_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_18.prefab_name].transform, "story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")

						arg_587_1:RecordAudio("1109511144", var_590_24)
						arg_587_1:RecordAudio("1109511144", var_590_24)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_25 = math.max(var_590_16, arg_587_1.talkMaxDuration)

			if var_590_15 <= arg_587_1.time_ and arg_587_1.time_ < var_590_15 + var_590_25 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_15) / var_590_25

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_15 + var_590_25 and arg_587_1.time_ < var_590_15 + var_590_25 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109511145 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109511145
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109511146(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["10058ui_story"]
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect10058ui_story == nil then
				arg_591_1.var_.characterEffect10058ui_story = var_594_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_2 = 0.200000002980232

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_2 and not isNil(var_594_0) then
				local var_594_3 = (arg_591_1.time_ - var_594_1) / var_594_2

				if arg_591_1.var_.characterEffect10058ui_story and not isNil(var_594_0) then
					local var_594_4 = Mathf.Lerp(0, 0.5, var_594_3)

					arg_591_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_591_1.var_.characterEffect10058ui_story.fillRatio = var_594_4
				end
			end

			if arg_591_1.time_ >= var_594_1 + var_594_2 and arg_591_1.time_ < var_594_1 + var_594_2 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect10058ui_story then
				local var_594_5 = 0.5

				arg_591_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_591_1.var_.characterEffect10058ui_story.fillRatio = var_594_5
			end

			local var_594_6 = 0
			local var_594_7 = 1.1

			if var_594_6 < arg_591_1.time_ and arg_591_1.time_ <= var_594_6 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_8 = arg_591_1:GetWordFromCfg(1109511145)
				local var_594_9 = arg_591_1:FormatText(var_594_8.content)

				arg_591_1.text_.text = var_594_9

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_10 = 44
				local var_594_11 = utf8.len(var_594_9)
				local var_594_12 = var_594_10 <= 0 and var_594_7 or var_594_7 * (var_594_11 / var_594_10)

				if var_594_12 > 0 and var_594_7 < var_594_12 then
					arg_591_1.talkMaxDuration = var_594_12

					if var_594_12 + var_594_6 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_12 + var_594_6
					end
				end

				arg_591_1.text_.text = var_594_9
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_13 = math.max(var_594_7, arg_591_1.talkMaxDuration)

			if var_594_6 <= arg_591_1.time_ and arg_591_1.time_ < var_594_6 + var_594_13 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_6) / var_594_13

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_6 + var_594_13 and arg_591_1.time_ < var_594_6 + var_594_13 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109511146 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109511146
		arg_595_1.duration_ = 7.03

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109511147(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.625

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[1556].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(1109511146)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb") / 1000

					if var_598_8 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_0
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")

						arg_595_1:RecordAudio("1109511146", var_598_9)
						arg_595_1:RecordAudio("1109511146", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_10 and arg_595_1.time_ < var_598_0 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109511147 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109511147
		arg_599_1.duration_ = 7.4

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109511148(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["10058ui_story"]
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect10058ui_story == nil then
				arg_599_1.var_.characterEffect10058ui_story = var_602_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 and not isNil(var_602_0) then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2

				if arg_599_1.var_.characterEffect10058ui_story and not isNil(var_602_0) then
					arg_599_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect10058ui_story then
				arg_599_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_602_4 = 0

			if var_602_4 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
				arg_599_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_602_5 = 0
			local var_602_6 = 0.725

			if var_602_5 < arg_599_1.time_ and arg_599_1.time_ <= var_602_5 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_7 = arg_599_1:FormatText(StoryNameCfg[471].name)

				arg_599_1.leftNameTxt_.text = var_602_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_8 = arg_599_1:GetWordFromCfg(1109511147)
				local var_602_9 = arg_599_1:FormatText(var_602_8.content)

				arg_599_1.text_.text = var_602_9

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_10 = 29
				local var_602_11 = utf8.len(var_602_9)
				local var_602_12 = var_602_10 <= 0 and var_602_6 or var_602_6 * (var_602_11 / var_602_10)

				if var_602_12 > 0 and var_602_6 < var_602_12 then
					arg_599_1.talkMaxDuration = var_602_12

					if var_602_12 + var_602_5 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_12 + var_602_5
					end
				end

				arg_599_1.text_.text = var_602_9
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb") ~= 0 then
					local var_602_13 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb") / 1000

					if var_602_13 + var_602_5 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_13 + var_602_5
					end

					if var_602_8.prefab_name ~= "" and arg_599_1.actors_[var_602_8.prefab_name] ~= nil then
						local var_602_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_8.prefab_name].transform, "story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")

						arg_599_1:RecordAudio("1109511147", var_602_14)
						arg_599_1:RecordAudio("1109511147", var_602_14)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_15 = math.max(var_602_6, arg_599_1.talkMaxDuration)

			if var_602_5 <= arg_599_1.time_ and arg_599_1.time_ < var_602_5 + var_602_15 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_5) / var_602_15

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_5 + var_602_15 and arg_599_1.time_ < var_602_5 + var_602_15 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109511148 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109511148
		arg_603_1.duration_ = 1.23

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109511149(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["10058ui_story"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect10058ui_story == nil then
				arg_603_1.var_.characterEffect10058ui_story = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect10058ui_story and not isNil(var_606_0) then
					local var_606_4 = Mathf.Lerp(0, 0.5, var_606_3)

					arg_603_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_603_1.var_.characterEffect10058ui_story.fillRatio = var_606_4
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect10058ui_story then
				local var_606_5 = 0.5

				arg_603_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_603_1.var_.characterEffect10058ui_story.fillRatio = var_606_5
			end

			local var_606_6 = 0
			local var_606_7 = 0.075

			if var_606_6 < arg_603_1.time_ and arg_603_1.time_ <= var_606_6 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_8 = arg_603_1:FormatText(StoryNameCfg[1556].name)

				arg_603_1.leftNameTxt_.text = var_606_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_9 = arg_603_1:GetWordFromCfg(1109511148)
				local var_606_10 = arg_603_1:FormatText(var_606_9.content)

				arg_603_1.text_.text = var_606_10

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_11 = 3
				local var_606_12 = utf8.len(var_606_10)
				local var_606_13 = var_606_11 <= 0 and var_606_7 or var_606_7 * (var_606_12 / var_606_11)

				if var_606_13 > 0 and var_606_7 < var_606_13 then
					arg_603_1.talkMaxDuration = var_606_13

					if var_606_13 + var_606_6 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_13 + var_606_6
					end
				end

				arg_603_1.text_.text = var_606_10
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb") ~= 0 then
					local var_606_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb") / 1000

					if var_606_14 + var_606_6 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_14 + var_606_6
					end

					if var_606_9.prefab_name ~= "" and arg_603_1.actors_[var_606_9.prefab_name] ~= nil then
						local var_606_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_9.prefab_name].transform, "story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")

						arg_603_1:RecordAudio("1109511148", var_606_15)
						arg_603_1:RecordAudio("1109511148", var_606_15)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_16 = math.max(var_606_7, arg_603_1.talkMaxDuration)

			if var_606_6 <= arg_603_1.time_ and arg_603_1.time_ < var_606_6 + var_606_16 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_6) / var_606_16

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_6 + var_606_16 and arg_603_1.time_ < var_606_6 + var_606_16 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109511149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109511149
		arg_607_1.duration_ = 4.8

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109511150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["10058ui_story"]
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect10058ui_story == nil then
				arg_607_1.var_.characterEffect10058ui_story = var_610_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 and not isNil(var_610_0) then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2

				if arg_607_1.var_.characterEffect10058ui_story and not isNil(var_610_0) then
					arg_607_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect10058ui_story then
				arg_607_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_610_4 = 0
			local var_610_5 = 0.35

			if var_610_4 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_6 = arg_607_1:FormatText(StoryNameCfg[471].name)

				arg_607_1.leftNameTxt_.text = var_610_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_7 = arg_607_1:GetWordFromCfg(1109511149)
				local var_610_8 = arg_607_1:FormatText(var_610_7.content)

				arg_607_1.text_.text = var_610_8

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_9 = 14
				local var_610_10 = utf8.len(var_610_8)
				local var_610_11 = var_610_9 <= 0 and var_610_5 or var_610_5 * (var_610_10 / var_610_9)

				if var_610_11 > 0 and var_610_5 < var_610_11 then
					arg_607_1.talkMaxDuration = var_610_11

					if var_610_11 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_11 + var_610_4
					end
				end

				arg_607_1.text_.text = var_610_8
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb") ~= 0 then
					local var_610_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb") / 1000

					if var_610_12 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_12 + var_610_4
					end

					if var_610_7.prefab_name ~= "" and arg_607_1.actors_[var_610_7.prefab_name] ~= nil then
						local var_610_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_7.prefab_name].transform, "story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")

						arg_607_1:RecordAudio("1109511149", var_610_13)
						arg_607_1:RecordAudio("1109511149", var_610_13)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_14 = math.max(var_610_5, arg_607_1.talkMaxDuration)

			if var_610_4 <= arg_607_1.time_ and arg_607_1.time_ < var_610_4 + var_610_14 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_4) / var_610_14

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_4 + var_610_14 and arg_607_1.time_ < var_610_4 + var_610_14 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109511150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109511150
		arg_611_1.duration_ = 6.83

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109511151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["10058ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect10058ui_story == nil then
				arg_611_1.var_.characterEffect10058ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect10058ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_611_1.var_.characterEffect10058ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect10058ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_611_1.var_.characterEffect10058ui_story.fillRatio = var_614_5
			end

			local var_614_6 = 0
			local var_614_7 = 0.625

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[1556].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_9 = arg_611_1:GetWordFromCfg(1109511150)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 25
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb") ~= 0 then
					local var_614_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb") / 1000

					if var_614_14 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_14 + var_614_6
					end

					if var_614_9.prefab_name ~= "" and arg_611_1.actors_[var_614_9.prefab_name] ~= nil then
						local var_614_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_9.prefab_name].transform, "story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")

						arg_611_1:RecordAudio("1109511150", var_614_15)
						arg_611_1:RecordAudio("1109511150", var_614_15)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_16 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_16 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_16

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_16 and arg_611_1.time_ < var_614_6 + var_614_16 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109511151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109511151
		arg_615_1.duration_ = 5.23

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109511152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.325

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_2 = arg_615_1:FormatText(StoryNameCfg[1556].name)

				arg_615_1.leftNameTxt_.text = var_618_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:GetWordFromCfg(1109511151)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 13
				local var_618_6 = utf8.len(var_618_4)
				local var_618_7 = var_618_5 <= 0 and var_618_1 or var_618_1 * (var_618_6 / var_618_5)

				if var_618_7 > 0 and var_618_1 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb") ~= 0 then
					local var_618_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb") / 1000

					if var_618_8 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_8 + var_618_0
					end

					if var_618_3.prefab_name ~= "" and arg_615_1.actors_[var_618_3.prefab_name] ~= nil then
						local var_618_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_3.prefab_name].transform, "story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")

						arg_615_1:RecordAudio("1109511151", var_618_9)
						arg_615_1:RecordAudio("1109511151", var_618_9)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_10 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_10 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_10

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_10 and arg_615_1.time_ < var_618_0 + var_618_10 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1109511152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109511152
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109511153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["10058ui_story"].transform
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.var_.moveOldPos10058ui_story = var_622_0.localPosition
			end

			local var_622_2 = 0.001

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2
				local var_622_4 = Vector3.New(0, 100, 0)

				var_622_0.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos10058ui_story, var_622_4, var_622_3)

				local var_622_5 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_5.x, var_622_5.y, var_622_5.z)

				local var_622_6 = var_622_0.localEulerAngles

				var_622_6.z = 0
				var_622_6.x = 0
				var_622_0.localEulerAngles = var_622_6
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 then
				var_622_0.localPosition = Vector3.New(0, 100, 0)

				local var_622_7 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_7.x, var_622_7.y, var_622_7.z)

				local var_622_8 = var_622_0.localEulerAngles

				var_622_8.z = 0
				var_622_8.x = 0
				var_622_0.localEulerAngles = var_622_8
			end

			local var_622_9 = 0
			local var_622_10 = 0.775

			if var_622_9 < arg_619_1.time_ and arg_619_1.time_ <= var_622_9 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_11 = arg_619_1:GetWordFromCfg(1109511152)
				local var_622_12 = arg_619_1:FormatText(var_622_11.content)

				arg_619_1.text_.text = var_622_12

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_13 = 31
				local var_622_14 = utf8.len(var_622_12)
				local var_622_15 = var_622_13 <= 0 and var_622_10 or var_622_10 * (var_622_14 / var_622_13)

				if var_622_15 > 0 and var_622_10 < var_622_15 then
					arg_619_1.talkMaxDuration = var_622_15

					if var_622_15 + var_622_9 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_15 + var_622_9
					end
				end

				arg_619_1.text_.text = var_622_12
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_16 = math.max(var_622_10, arg_619_1.talkMaxDuration)

			if var_622_9 <= arg_619_1.time_ and arg_619_1.time_ < var_622_9 + var_622_16 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_9) / var_622_16

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_9 + var_622_16 and arg_619_1.time_ < var_622_9 + var_622_16 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1109511153 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109511153
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109511154(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0
			local var_626_1 = 0.875

			if var_626_0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_2 = arg_623_1:FormatText(StoryNameCfg[7].name)

				arg_623_1.leftNameTxt_.text = var_626_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_3 = arg_623_1:GetWordFromCfg(1109511153)
				local var_626_4 = arg_623_1:FormatText(var_626_3.content)

				arg_623_1.text_.text = var_626_4

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 35
				local var_626_6 = utf8.len(var_626_4)
				local var_626_7 = var_626_5 <= 0 and var_626_1 or var_626_1 * (var_626_6 / var_626_5)

				if var_626_7 > 0 and var_626_1 < var_626_7 then
					arg_623_1.talkMaxDuration = var_626_7

					if var_626_7 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_0
					end
				end

				arg_623_1.text_.text = var_626_4
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_8 = math.max(var_626_1, arg_623_1.talkMaxDuration)

			if var_626_0 <= arg_623_1.time_ and arg_623_1.time_ < var_626_0 + var_626_8 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_0) / var_626_8

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_0 + var_626_8 and arg_623_1.time_ < var_626_0 + var_626_8 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109511154 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109511154
		arg_627_1.duration_ = 4.63

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109511155(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0
			local var_630_1 = 0.45

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_2 = arg_627_1:FormatText(StoryNameCfg[1556].name)

				arg_627_1.leftNameTxt_.text = var_630_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:GetWordFromCfg(1109511154)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 18
				local var_630_6 = utf8.len(var_630_4)
				local var_630_7 = var_630_5 <= 0 and var_630_1 or var_630_1 * (var_630_6 / var_630_5)

				if var_630_7 > 0 and var_630_1 < var_630_7 then
					arg_627_1.talkMaxDuration = var_630_7

					if var_630_7 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_0
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb") ~= 0 then
					local var_630_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb") / 1000

					if var_630_8 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_8 + var_630_0
					end

					if var_630_3.prefab_name ~= "" and arg_627_1.actors_[var_630_3.prefab_name] ~= nil then
						local var_630_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_3.prefab_name].transform, "story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")

						arg_627_1:RecordAudio("1109511154", var_630_9)
						arg_627_1:RecordAudio("1109511154", var_630_9)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_10 = math.max(var_630_1, arg_627_1.talkMaxDuration)

			if var_630_0 <= arg_627_1.time_ and arg_627_1.time_ < var_630_0 + var_630_10 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_0) / var_630_10

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_0 + var_630_10 and arg_627_1.time_ < var_630_0 + var_630_10 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109511155 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109511155
		arg_631_1.duration_ = 6.03

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109511156(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["10058ui_story"].transform
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 then
				arg_631_1.var_.moveOldPos10058ui_story = var_634_0.localPosition
			end

			local var_634_2 = 0.001

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2
				local var_634_4 = Vector3.New(0, -0.98, -6.1)

				var_634_0.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos10058ui_story, var_634_4, var_634_3)

				local var_634_5 = manager.ui.mainCamera.transform.position - var_634_0.position

				var_634_0.forward = Vector3.New(var_634_5.x, var_634_5.y, var_634_5.z)

				local var_634_6 = var_634_0.localEulerAngles

				var_634_6.z = 0
				var_634_6.x = 0
				var_634_0.localEulerAngles = var_634_6
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 then
				var_634_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_634_7 = manager.ui.mainCamera.transform.position - var_634_0.position

				var_634_0.forward = Vector3.New(var_634_7.x, var_634_7.y, var_634_7.z)

				local var_634_8 = var_634_0.localEulerAngles

				var_634_8.z = 0
				var_634_8.x = 0
				var_634_0.localEulerAngles = var_634_8
			end

			local var_634_9 = arg_631_1.actors_["10058ui_story"]
			local var_634_10 = 0

			if var_634_10 < arg_631_1.time_ and arg_631_1.time_ <= var_634_10 + arg_634_0 and not isNil(var_634_9) and arg_631_1.var_.characterEffect10058ui_story == nil then
				arg_631_1.var_.characterEffect10058ui_story = var_634_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_11 = 0.200000002980232

			if var_634_10 <= arg_631_1.time_ and arg_631_1.time_ < var_634_10 + var_634_11 and not isNil(var_634_9) then
				local var_634_12 = (arg_631_1.time_ - var_634_10) / var_634_11

				if arg_631_1.var_.characterEffect10058ui_story and not isNil(var_634_9) then
					arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_10 + var_634_11 and arg_631_1.time_ < var_634_10 + var_634_11 + arg_634_0 and not isNil(var_634_9) and arg_631_1.var_.characterEffect10058ui_story then
				arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_634_13 = 0
			local var_634_14 = 0.6

			if var_634_13 < arg_631_1.time_ and arg_631_1.time_ <= var_634_13 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_15 = arg_631_1:FormatText(StoryNameCfg[471].name)

				arg_631_1.leftNameTxt_.text = var_634_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_16 = arg_631_1:GetWordFromCfg(1109511155)
				local var_634_17 = arg_631_1:FormatText(var_634_16.content)

				arg_631_1.text_.text = var_634_17

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_18 = 24
				local var_634_19 = utf8.len(var_634_17)
				local var_634_20 = var_634_18 <= 0 and var_634_14 or var_634_14 * (var_634_19 / var_634_18)

				if var_634_20 > 0 and var_634_14 < var_634_20 then
					arg_631_1.talkMaxDuration = var_634_20

					if var_634_20 + var_634_13 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_20 + var_634_13
					end
				end

				arg_631_1.text_.text = var_634_17
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb") ~= 0 then
					local var_634_21 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb") / 1000

					if var_634_21 + var_634_13 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_21 + var_634_13
					end

					if var_634_16.prefab_name ~= "" and arg_631_1.actors_[var_634_16.prefab_name] ~= nil then
						local var_634_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_16.prefab_name].transform, "story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")

						arg_631_1:RecordAudio("1109511155", var_634_22)
						arg_631_1:RecordAudio("1109511155", var_634_22)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_23 = math.max(var_634_14, arg_631_1.talkMaxDuration)

			if var_634_13 <= arg_631_1.time_ and arg_631_1.time_ < var_634_13 + var_634_23 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_13) / var_634_23

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_13 + var_634_23 and arg_631_1.time_ < var_634_13 + var_634_23 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_631_1:InitPlayNodeList()
	end,
	Play1109511156 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109511156
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1109511157(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["10058ui_story"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect10058ui_story == nil then
				arg_635_1.var_.characterEffect10058ui_story = var_638_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 and not isNil(var_638_0) then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2

				if arg_635_1.var_.characterEffect10058ui_story and not isNil(var_638_0) then
					local var_638_4 = Mathf.Lerp(0, 0.5, var_638_3)

					arg_635_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_635_1.var_.characterEffect10058ui_story.fillRatio = var_638_4
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect10058ui_story then
				local var_638_5 = 0.5

				arg_635_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_635_1.var_.characterEffect10058ui_story.fillRatio = var_638_5
			end

			local var_638_6 = 0
			local var_638_7 = 0.825

			if var_638_6 < arg_635_1.time_ and arg_635_1.time_ <= var_638_6 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_8 = arg_635_1:GetWordFromCfg(1109511156)
				local var_638_9 = arg_635_1:FormatText(var_638_8.content)

				arg_635_1.text_.text = var_638_9

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_10 = 33
				local var_638_11 = utf8.len(var_638_9)
				local var_638_12 = var_638_10 <= 0 and var_638_7 or var_638_7 * (var_638_11 / var_638_10)

				if var_638_12 > 0 and var_638_7 < var_638_12 then
					arg_635_1.talkMaxDuration = var_638_12

					if var_638_12 + var_638_6 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_12 + var_638_6
					end
				end

				arg_635_1.text_.text = var_638_9
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_13 = math.max(var_638_7, arg_635_1.talkMaxDuration)

			if var_638_6 <= arg_635_1.time_ and arg_635_1.time_ < var_638_6 + var_638_13 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_6) / var_638_13

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_6 + var_638_13 and arg_635_1.time_ < var_638_6 + var_638_13 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1109511157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109511157
		arg_639_1.duration_ = 6.63

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109511158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["10058ui_story"]
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect10058ui_story == nil then
				arg_639_1.var_.characterEffect10058ui_story = var_642_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.200000002980232

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 and not isNil(var_642_0) then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2

				if arg_639_1.var_.characterEffect10058ui_story and not isNil(var_642_0) then
					arg_639_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect10058ui_story then
				arg_639_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_642_4 = 0

			if var_642_4 < arg_639_1.time_ and arg_639_1.time_ <= var_642_4 + arg_642_0 then
				arg_639_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_642_5 = 0

			if var_642_5 < arg_639_1.time_ and arg_639_1.time_ <= var_642_5 + arg_642_0 then
				arg_639_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_642_6 = 0
			local var_642_7 = 0.775

			if var_642_6 < arg_639_1.time_ and arg_639_1.time_ <= var_642_6 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_8 = arg_639_1:FormatText(StoryNameCfg[471].name)

				arg_639_1.leftNameTxt_.text = var_642_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_9 = arg_639_1:GetWordFromCfg(1109511157)
				local var_642_10 = arg_639_1:FormatText(var_642_9.content)

				arg_639_1.text_.text = var_642_10

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_11 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb") ~= 0 then
					local var_642_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb") / 1000

					if var_642_14 + var_642_6 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_14 + var_642_6
					end

					if var_642_9.prefab_name ~= "" and arg_639_1.actors_[var_642_9.prefab_name] ~= nil then
						local var_642_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_9.prefab_name].transform, "story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")

						arg_639_1:RecordAudio("1109511157", var_642_15)
						arg_639_1:RecordAudio("1109511157", var_642_15)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_16 = math.max(var_642_7, arg_639_1.talkMaxDuration)

			if var_642_6 <= arg_639_1.time_ and arg_639_1.time_ < var_642_6 + var_642_16 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_6) / var_642_16

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_6 + var_642_16 and arg_639_1.time_ < var_642_6 + var_642_16 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109511158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109511158
		arg_643_1.duration_ = 8.8

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109511159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0
			local var_646_1 = 1

			if var_646_0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_2 = arg_643_1:FormatText(StoryNameCfg[471].name)

				arg_643_1.leftNameTxt_.text = var_646_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_3 = arg_643_1:GetWordFromCfg(1109511158)
				local var_646_4 = arg_643_1:FormatText(var_646_3.content)

				arg_643_1.text_.text = var_646_4

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_5 = 40
				local var_646_6 = utf8.len(var_646_4)
				local var_646_7 = var_646_5 <= 0 and var_646_1 or var_646_1 * (var_646_6 / var_646_5)

				if var_646_7 > 0 and var_646_1 < var_646_7 then
					arg_643_1.talkMaxDuration = var_646_7

					if var_646_7 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_7 + var_646_0
					end
				end

				arg_643_1.text_.text = var_646_4
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb") ~= 0 then
					local var_646_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb") / 1000

					if var_646_8 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_8 + var_646_0
					end

					if var_646_3.prefab_name ~= "" and arg_643_1.actors_[var_646_3.prefab_name] ~= nil then
						local var_646_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_3.prefab_name].transform, "story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")

						arg_643_1:RecordAudio("1109511158", var_646_9)
						arg_643_1:RecordAudio("1109511158", var_646_9)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_10 = math.max(var_646_1, arg_643_1.talkMaxDuration)

			if var_646_0 <= arg_643_1.time_ and arg_643_1.time_ < var_646_0 + var_646_10 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_0) / var_646_10

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_0 + var_646_10 and arg_643_1.time_ < var_646_0 + var_646_10 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1109511159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109511159
		arg_647_1.duration_ = 6.43

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109511160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 0.6

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_2 = arg_647_1:FormatText(StoryNameCfg[471].name)

				arg_647_1.leftNameTxt_.text = var_650_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_3 = arg_647_1:GetWordFromCfg(1109511159)
				local var_650_4 = arg_647_1:FormatText(var_650_3.content)

				arg_647_1.text_.text = var_650_4

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_5 = 24
				local var_650_6 = utf8.len(var_650_4)
				local var_650_7 = var_650_5 <= 0 and var_650_1 or var_650_1 * (var_650_6 / var_650_5)

				if var_650_7 > 0 and var_650_1 < var_650_7 then
					arg_647_1.talkMaxDuration = var_650_7

					if var_650_7 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_7 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_4
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb") ~= 0 then
					local var_650_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb") / 1000

					if var_650_8 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_8 + var_650_0
					end

					if var_650_3.prefab_name ~= "" and arg_647_1.actors_[var_650_3.prefab_name] ~= nil then
						local var_650_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_3.prefab_name].transform, "story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")

						arg_647_1:RecordAudio("1109511159", var_650_9)
						arg_647_1:RecordAudio("1109511159", var_650_9)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_10 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_10 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_10

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_10 and arg_647_1.time_ < var_650_0 + var_650_10 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109511160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1109511160
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1109511161(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = arg_651_1.actors_["10058ui_story"]
			local var_654_1 = 0

			if var_654_1 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 and not isNil(var_654_0) and arg_651_1.var_.characterEffect10058ui_story == nil then
				arg_651_1.var_.characterEffect10058ui_story = var_654_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_2 = 0.200000002980232

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_2 and not isNil(var_654_0) then
				local var_654_3 = (arg_651_1.time_ - var_654_1) / var_654_2

				if arg_651_1.var_.characterEffect10058ui_story and not isNil(var_654_0) then
					local var_654_4 = Mathf.Lerp(0, 0.5, var_654_3)

					arg_651_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_651_1.var_.characterEffect10058ui_story.fillRatio = var_654_4
				end
			end

			if arg_651_1.time_ >= var_654_1 + var_654_2 and arg_651_1.time_ < var_654_1 + var_654_2 + arg_654_0 and not isNil(var_654_0) and arg_651_1.var_.characterEffect10058ui_story then
				local var_654_5 = 0.5

				arg_651_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_651_1.var_.characterEffect10058ui_story.fillRatio = var_654_5
			end

			local var_654_6 = 0
			local var_654_7 = 0.975

			if var_654_6 < arg_651_1.time_ and arg_651_1.time_ <= var_654_6 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_8 = arg_651_1:FormatText(StoryNameCfg[7].name)

				arg_651_1.leftNameTxt_.text = var_654_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_9 = arg_651_1:GetWordFromCfg(1109511160)
				local var_654_10 = arg_651_1:FormatText(var_654_9.content)

				arg_651_1.text_.text = var_654_10

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_11 = 39
				local var_654_12 = utf8.len(var_654_10)
				local var_654_13 = var_654_11 <= 0 and var_654_7 or var_654_7 * (var_654_12 / var_654_11)

				if var_654_13 > 0 and var_654_7 < var_654_13 then
					arg_651_1.talkMaxDuration = var_654_13

					if var_654_13 + var_654_6 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_13 + var_654_6
					end
				end

				arg_651_1.text_.text = var_654_10
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_14 = math.max(var_654_7, arg_651_1.talkMaxDuration)

			if var_654_6 <= arg_651_1.time_ and arg_651_1.time_ < var_654_6 + var_654_14 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_6) / var_654_14

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_6 + var_654_14 and arg_651_1.time_ < var_654_6 + var_654_14 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1109511161 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1109511161
		arg_655_1.duration_ = 8.13

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1109511162(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0
			local var_658_1 = 0.975

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_2 = arg_655_1:FormatText(StoryNameCfg[1556].name)

				arg_655_1.leftNameTxt_.text = var_658_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:GetWordFromCfg(1109511161)
				local var_658_4 = arg_655_1:FormatText(var_658_3.content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 39
				local var_658_6 = utf8.len(var_658_4)
				local var_658_7 = var_658_5 <= 0 and var_658_1 or var_658_1 * (var_658_6 / var_658_5)

				if var_658_7 > 0 and var_658_1 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_0
					end
				end

				arg_655_1.text_.text = var_658_4
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb") ~= 0 then
					local var_658_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb") / 1000

					if var_658_8 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_0
					end

					if var_658_3.prefab_name ~= "" and arg_655_1.actors_[var_658_3.prefab_name] ~= nil then
						local var_658_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_3.prefab_name].transform, "story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")

						arg_655_1:RecordAudio("1109511161", var_658_9)
						arg_655_1:RecordAudio("1109511161", var_658_9)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_10 = math.max(var_658_1, arg_655_1.talkMaxDuration)

			if var_658_0 <= arg_655_1.time_ and arg_655_1.time_ < var_658_0 + var_658_10 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_0) / var_658_10

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_0 + var_658_10 and arg_655_1.time_ < var_658_0 + var_658_10 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1109511162 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1109511162
		arg_659_1.duration_ = 9.23

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1109511163(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["10058ui_story"]
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.characterEffect10058ui_story == nil then
				arg_659_1.var_.characterEffect10058ui_story = var_662_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_2 = 0.200000002980232

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 and not isNil(var_662_0) then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2

				if arg_659_1.var_.characterEffect10058ui_story and not isNil(var_662_0) then
					arg_659_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.characterEffect10058ui_story then
				arg_659_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_662_4 = 0

			if var_662_4 < arg_659_1.time_ and arg_659_1.time_ <= var_662_4 + arg_662_0 then
				arg_659_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_662_5 = 0

			if var_662_5 < arg_659_1.time_ and arg_659_1.time_ <= var_662_5 + arg_662_0 then
				arg_659_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_662_6 = 0
			local var_662_7 = 1

			if var_662_6 < arg_659_1.time_ and arg_659_1.time_ <= var_662_6 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_8 = arg_659_1:FormatText(StoryNameCfg[471].name)

				arg_659_1.leftNameTxt_.text = var_662_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_9 = arg_659_1:GetWordFromCfg(1109511162)
				local var_662_10 = arg_659_1:FormatText(var_662_9.content)

				arg_659_1.text_.text = var_662_10

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_11 = 40
				local var_662_12 = utf8.len(var_662_10)
				local var_662_13 = var_662_11 <= 0 and var_662_7 or var_662_7 * (var_662_12 / var_662_11)

				if var_662_13 > 0 and var_662_7 < var_662_13 then
					arg_659_1.talkMaxDuration = var_662_13

					if var_662_13 + var_662_6 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_13 + var_662_6
					end
				end

				arg_659_1.text_.text = var_662_10
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb") ~= 0 then
					local var_662_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb") / 1000

					if var_662_14 + var_662_6 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_14 + var_662_6
					end

					if var_662_9.prefab_name ~= "" and arg_659_1.actors_[var_662_9.prefab_name] ~= nil then
						local var_662_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_9.prefab_name].transform, "story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")

						arg_659_1:RecordAudio("1109511162", var_662_15)
						arg_659_1:RecordAudio("1109511162", var_662_15)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_16 = math.max(var_662_7, arg_659_1.talkMaxDuration)

			if var_662_6 <= arg_659_1.time_ and arg_659_1.time_ < var_662_6 + var_662_16 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_6) / var_662_16

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_6 + var_662_16 and arg_659_1.time_ < var_662_6 + var_662_16 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1109511163 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1109511163
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1109511164(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["10058ui_story"].transform
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 then
				arg_663_1.var_.moveOldPos10058ui_story = var_666_0.localPosition
			end

			local var_666_2 = 0.001

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2
				local var_666_4 = Vector3.New(0, 100, 0)

				var_666_0.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos10058ui_story, var_666_4, var_666_3)

				local var_666_5 = manager.ui.mainCamera.transform.position - var_666_0.position

				var_666_0.forward = Vector3.New(var_666_5.x, var_666_5.y, var_666_5.z)

				local var_666_6 = var_666_0.localEulerAngles

				var_666_6.z = 0
				var_666_6.x = 0
				var_666_0.localEulerAngles = var_666_6
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 then
				var_666_0.localPosition = Vector3.New(0, 100, 0)

				local var_666_7 = manager.ui.mainCamera.transform.position - var_666_0.position

				var_666_0.forward = Vector3.New(var_666_7.x, var_666_7.y, var_666_7.z)

				local var_666_8 = var_666_0.localEulerAngles

				var_666_8.z = 0
				var_666_8.x = 0
				var_666_0.localEulerAngles = var_666_8
			end

			local var_666_9 = arg_663_1.actors_["10058ui_story"]
			local var_666_10 = 0

			if var_666_10 < arg_663_1.time_ and arg_663_1.time_ <= var_666_10 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect10058ui_story == nil then
				arg_663_1.var_.characterEffect10058ui_story = var_666_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_11 = 0.200000002980232

			if var_666_10 <= arg_663_1.time_ and arg_663_1.time_ < var_666_10 + var_666_11 and not isNil(var_666_9) then
				local var_666_12 = (arg_663_1.time_ - var_666_10) / var_666_11

				if arg_663_1.var_.characterEffect10058ui_story and not isNil(var_666_9) then
					local var_666_13 = Mathf.Lerp(0, 0.5, var_666_12)

					arg_663_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_663_1.var_.characterEffect10058ui_story.fillRatio = var_666_13
				end
			end

			if arg_663_1.time_ >= var_666_10 + var_666_11 and arg_663_1.time_ < var_666_10 + var_666_11 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect10058ui_story then
				local var_666_14 = 0.5

				arg_663_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_663_1.var_.characterEffect10058ui_story.fillRatio = var_666_14
			end

			local var_666_15 = 0
			local var_666_16 = 0.85

			if var_666_15 < arg_663_1.time_ and arg_663_1.time_ <= var_666_15 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_17 = arg_663_1:GetWordFromCfg(1109511163)
				local var_666_18 = arg_663_1:FormatText(var_666_17.content)

				arg_663_1.text_.text = var_666_18

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_19 = 34
				local var_666_20 = utf8.len(var_666_18)
				local var_666_21 = var_666_19 <= 0 and var_666_16 or var_666_16 * (var_666_20 / var_666_19)

				if var_666_21 > 0 and var_666_16 < var_666_21 then
					arg_663_1.talkMaxDuration = var_666_21

					if var_666_21 + var_666_15 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_21 + var_666_15
					end
				end

				arg_663_1.text_.text = var_666_18
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_22 = math.max(var_666_16, arg_663_1.talkMaxDuration)

			if var_666_15 <= arg_663_1.time_ and arg_663_1.time_ < var_666_15 + var_666_22 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_15) / var_666_22

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_15 + var_666_22 and arg_663_1.time_ < var_666_15 + var_666_22 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play1109511164 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1109511164
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1109511165(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.525

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, false)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_2 = arg_667_1:GetWordFromCfg(1109511164)
				local var_670_3 = arg_667_1:FormatText(var_670_2.content)

				arg_667_1.text_.text = var_670_3

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_4 = 21
				local var_670_5 = utf8.len(var_670_3)
				local var_670_6 = var_670_4 <= 0 and var_670_1 or var_670_1 * (var_670_5 / var_670_4)

				if var_670_6 > 0 and var_670_1 < var_670_6 then
					arg_667_1.talkMaxDuration = var_670_6

					if var_670_6 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_6 + var_670_0
					end
				end

				arg_667_1.text_.text = var_670_3
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_7 = math.max(var_670_1, arg_667_1.talkMaxDuration)

			if var_670_0 <= arg_667_1.time_ and arg_667_1.time_ < var_670_0 + var_670_7 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_0) / var_670_7

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_0 + var_670_7 and arg_667_1.time_ < var_670_0 + var_670_7 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1109511165 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1109511165
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1109511166(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0
			local var_674_1 = 0.9

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_2 = arg_671_1:GetWordFromCfg(1109511165)
				local var_674_3 = arg_671_1:FormatText(var_674_2.content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_4 = 36
				local var_674_5 = utf8.len(var_674_3)
				local var_674_6 = var_674_4 <= 0 and var_674_1 or var_674_1 * (var_674_5 / var_674_4)

				if var_674_6 > 0 and var_674_1 < var_674_6 then
					arg_671_1.talkMaxDuration = var_674_6

					if var_674_6 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_6 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_7 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_7 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_7

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_7 and arg_671_1.time_ < var_674_0 + var_674_7 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1109511166 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1109511166
		arg_675_1.duration_ = 6.47

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1109511167(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0
			local var_678_1 = 0.725

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_2 = arg_675_1:FormatText(StoryNameCfg[1556].name)

				arg_675_1.leftNameTxt_.text = var_678_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_3 = arg_675_1:GetWordFromCfg(1109511166)
				local var_678_4 = arg_675_1:FormatText(var_678_3.content)

				arg_675_1.text_.text = var_678_4

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 29
				local var_678_6 = utf8.len(var_678_4)
				local var_678_7 = var_678_5 <= 0 and var_678_1 or var_678_1 * (var_678_6 / var_678_5)

				if var_678_7 > 0 and var_678_1 < var_678_7 then
					arg_675_1.talkMaxDuration = var_678_7

					if var_678_7 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_7 + var_678_0
					end
				end

				arg_675_1.text_.text = var_678_4
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb") ~= 0 then
					local var_678_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb") / 1000

					if var_678_8 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_8 + var_678_0
					end

					if var_678_3.prefab_name ~= "" and arg_675_1.actors_[var_678_3.prefab_name] ~= nil then
						local var_678_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_3.prefab_name].transform, "story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")

						arg_675_1:RecordAudio("1109511166", var_678_9)
						arg_675_1:RecordAudio("1109511166", var_678_9)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_10 = math.max(var_678_1, arg_675_1.talkMaxDuration)

			if var_678_0 <= arg_675_1.time_ and arg_675_1.time_ < var_678_0 + var_678_10 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_0) / var_678_10

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_0 + var_678_10 and arg_675_1.time_ < var_678_0 + var_678_10 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play1109511167 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1109511167
		arg_679_1.duration_ = 2.47

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1109511168(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["10058ui_story"].transform
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.var_.moveOldPos10058ui_story = var_682_0.localPosition
			end

			local var_682_2 = 0.001

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2
				local var_682_4 = Vector3.New(0, -0.98, -6.1)

				var_682_0.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos10058ui_story, var_682_4, var_682_3)

				local var_682_5 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_5.x, var_682_5.y, var_682_5.z)

				local var_682_6 = var_682_0.localEulerAngles

				var_682_6.z = 0
				var_682_6.x = 0
				var_682_0.localEulerAngles = var_682_6
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 then
				var_682_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_682_7 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_7.x, var_682_7.y, var_682_7.z)

				local var_682_8 = var_682_0.localEulerAngles

				var_682_8.z = 0
				var_682_8.x = 0
				var_682_0.localEulerAngles = var_682_8
			end

			local var_682_9 = arg_679_1.actors_["10058ui_story"]
			local var_682_10 = 0

			if var_682_10 < arg_679_1.time_ and arg_679_1.time_ <= var_682_10 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect10058ui_story == nil then
				arg_679_1.var_.characterEffect10058ui_story = var_682_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_11 = 0.200000002980232

			if var_682_10 <= arg_679_1.time_ and arg_679_1.time_ < var_682_10 + var_682_11 and not isNil(var_682_9) then
				local var_682_12 = (arg_679_1.time_ - var_682_10) / var_682_11

				if arg_679_1.var_.characterEffect10058ui_story and not isNil(var_682_9) then
					arg_679_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= var_682_10 + var_682_11 and arg_679_1.time_ < var_682_10 + var_682_11 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect10058ui_story then
				arg_679_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_682_13 = 0

			if var_682_13 < arg_679_1.time_ and arg_679_1.time_ <= var_682_13 + arg_682_0 then
				arg_679_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_682_14 = 0
			local var_682_15 = 0.325

			if var_682_14 < arg_679_1.time_ and arg_679_1.time_ <= var_682_14 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_16 = arg_679_1:FormatText(StoryNameCfg[471].name)

				arg_679_1.leftNameTxt_.text = var_682_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_17 = arg_679_1:GetWordFromCfg(1109511167)
				local var_682_18 = arg_679_1:FormatText(var_682_17.content)

				arg_679_1.text_.text = var_682_18

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_19 = 13
				local var_682_20 = utf8.len(var_682_18)
				local var_682_21 = var_682_19 <= 0 and var_682_15 or var_682_15 * (var_682_20 / var_682_19)

				if var_682_21 > 0 and var_682_15 < var_682_21 then
					arg_679_1.talkMaxDuration = var_682_21

					if var_682_21 + var_682_14 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_21 + var_682_14
					end
				end

				arg_679_1.text_.text = var_682_18
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb") ~= 0 then
					local var_682_22 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb") / 1000

					if var_682_22 + var_682_14 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_22 + var_682_14
					end

					if var_682_17.prefab_name ~= "" and arg_679_1.actors_[var_682_17.prefab_name] ~= nil then
						local var_682_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_17.prefab_name].transform, "story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")

						arg_679_1:RecordAudio("1109511167", var_682_23)
						arg_679_1:RecordAudio("1109511167", var_682_23)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_24 = math.max(var_682_15, arg_679_1.talkMaxDuration)

			if var_682_14 <= arg_679_1.time_ and arg_679_1.time_ < var_682_14 + var_682_24 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_14) / var_682_24

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_14 + var_682_24 and arg_679_1.time_ < var_682_14 + var_682_24 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play1109511168 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1109511168
		arg_683_1.duration_ = 5.97

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1109511169(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["10058ui_story"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect10058ui_story == nil then
				arg_683_1.var_.characterEffect10058ui_story = var_686_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.characterEffect10058ui_story and not isNil(var_686_0) then
					local var_686_4 = Mathf.Lerp(0, 0.5, var_686_3)

					arg_683_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_683_1.var_.characterEffect10058ui_story.fillRatio = var_686_4
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect10058ui_story then
				local var_686_5 = 0.5

				arg_683_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_683_1.var_.characterEffect10058ui_story.fillRatio = var_686_5
			end

			local var_686_6 = 0
			local var_686_7 = 0.7

			if var_686_6 < arg_683_1.time_ and arg_683_1.time_ <= var_686_6 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_8 = arg_683_1:FormatText(StoryNameCfg[1556].name)

				arg_683_1.leftNameTxt_.text = var_686_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_9 = arg_683_1:GetWordFromCfg(1109511168)
				local var_686_10 = arg_683_1:FormatText(var_686_9.content)

				arg_683_1.text_.text = var_686_10

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_11 = 28
				local var_686_12 = utf8.len(var_686_10)
				local var_686_13 = var_686_11 <= 0 and var_686_7 or var_686_7 * (var_686_12 / var_686_11)

				if var_686_13 > 0 and var_686_7 < var_686_13 then
					arg_683_1.talkMaxDuration = var_686_13

					if var_686_13 + var_686_6 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_13 + var_686_6
					end
				end

				arg_683_1.text_.text = var_686_10
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb") ~= 0 then
					local var_686_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb") / 1000

					if var_686_14 + var_686_6 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_14 + var_686_6
					end

					if var_686_9.prefab_name ~= "" and arg_683_1.actors_[var_686_9.prefab_name] ~= nil then
						local var_686_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_9.prefab_name].transform, "story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")

						arg_683_1:RecordAudio("1109511168", var_686_15)
						arg_683_1:RecordAudio("1109511168", var_686_15)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_16 = math.max(var_686_7, arg_683_1.talkMaxDuration)

			if var_686_6 <= arg_683_1.time_ and arg_683_1.time_ < var_686_6 + var_686_16 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_6) / var_686_16

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_6 + var_686_16 and arg_683_1.time_ < var_686_6 + var_686_16 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1109511169 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1109511169
		arg_687_1.duration_ = 2

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1109511170(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["10058ui_story"]
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect10058ui_story == nil then
				arg_687_1.var_.characterEffect10058ui_story = var_690_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_2 = 0.200000002980232

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 and not isNil(var_690_0) then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2

				if arg_687_1.var_.characterEffect10058ui_story and not isNil(var_690_0) then
					arg_687_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect10058ui_story then
				arg_687_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_690_4 = 0

			if var_690_4 < arg_687_1.time_ and arg_687_1.time_ <= var_690_4 + arg_690_0 then
				arg_687_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action446")
			end

			local var_690_5 = 0

			if var_690_5 < arg_687_1.time_ and arg_687_1.time_ <= var_690_5 + arg_690_0 then
				arg_687_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_690_6 = 0
			local var_690_7 = 0.1

			if var_690_6 < arg_687_1.time_ and arg_687_1.time_ <= var_690_6 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_8 = arg_687_1:FormatText(StoryNameCfg[471].name)

				arg_687_1.leftNameTxt_.text = var_690_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_9 = arg_687_1:GetWordFromCfg(1109511169)
				local var_690_10 = arg_687_1:FormatText(var_690_9.content)

				arg_687_1.text_.text = var_690_10

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_11 = 4
				local var_690_12 = utf8.len(var_690_10)
				local var_690_13 = var_690_11 <= 0 and var_690_7 or var_690_7 * (var_690_12 / var_690_11)

				if var_690_13 > 0 and var_690_7 < var_690_13 then
					arg_687_1.talkMaxDuration = var_690_13

					if var_690_13 + var_690_6 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_13 + var_690_6
					end
				end

				arg_687_1.text_.text = var_690_10
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb") ~= 0 then
					local var_690_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb") / 1000

					if var_690_14 + var_690_6 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_14 + var_690_6
					end

					if var_690_9.prefab_name ~= "" and arg_687_1.actors_[var_690_9.prefab_name] ~= nil then
						local var_690_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_9.prefab_name].transform, "story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")

						arg_687_1:RecordAudio("1109511169", var_690_15)
						arg_687_1:RecordAudio("1109511169", var_690_15)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_16 = math.max(var_690_7, arg_687_1.talkMaxDuration)

			if var_690_6 <= arg_687_1.time_ and arg_687_1.time_ < var_690_6 + var_690_16 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_6) / var_690_16

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_6 + var_690_16 and arg_687_1.time_ < var_690_6 + var_690_16 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1109511170 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1109511170
		arg_691_1.duration_ = 2.9

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1109511171(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["10058ui_story"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect10058ui_story == nil then
				arg_691_1.var_.characterEffect10058ui_story = var_694_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 and not isNil(var_694_0) then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.characterEffect10058ui_story and not isNil(var_694_0) then
					local var_694_4 = Mathf.Lerp(0, 0.5, var_694_3)

					arg_691_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_691_1.var_.characterEffect10058ui_story.fillRatio = var_694_4
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect10058ui_story then
				local var_694_5 = 0.5

				arg_691_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_691_1.var_.characterEffect10058ui_story.fillRatio = var_694_5
			end

			local var_694_6 = 0
			local var_694_7 = 0.2

			if var_694_6 < arg_691_1.time_ and arg_691_1.time_ <= var_694_6 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_8 = arg_691_1:FormatText(StoryNameCfg[1556].name)

				arg_691_1.leftNameTxt_.text = var_694_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, true)
				arg_691_1.iconController_:SetSelectedState("hero")

				arg_691_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_691_1.callingController_:SetSelectedState("normal")

				arg_691_1.keyicon_.color = Color.New(1, 1, 1)
				arg_691_1.icon_.color = Color.New(1, 1, 1)

				local var_694_9 = arg_691_1:GetWordFromCfg(1109511170)
				local var_694_10 = arg_691_1:FormatText(var_694_9.content)

				arg_691_1.text_.text = var_694_10

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_11 = 8
				local var_694_12 = utf8.len(var_694_10)
				local var_694_13 = var_694_11 <= 0 and var_694_7 or var_694_7 * (var_694_12 / var_694_11)

				if var_694_13 > 0 and var_694_7 < var_694_13 then
					arg_691_1.talkMaxDuration = var_694_13

					if var_694_13 + var_694_6 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_6
					end
				end

				arg_691_1.text_.text = var_694_10
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb") ~= 0 then
					local var_694_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb") / 1000

					if var_694_14 + var_694_6 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_14 + var_694_6
					end

					if var_694_9.prefab_name ~= "" and arg_691_1.actors_[var_694_9.prefab_name] ~= nil then
						local var_694_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_9.prefab_name].transform, "story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")

						arg_691_1:RecordAudio("1109511170", var_694_15)
						arg_691_1:RecordAudio("1109511170", var_694_15)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_16 = math.max(var_694_7, arg_691_1.talkMaxDuration)

			if var_694_6 <= arg_691_1.time_ and arg_691_1.time_ < var_694_6 + var_694_16 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_6) / var_694_16

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_6 + var_694_16 and arg_691_1.time_ < var_694_6 + var_694_16 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1109511171 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1109511171
		arg_695_1.duration_ = 1

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"

			SetActive(arg_695_1.choicesGo_, true)

			for iter_696_0, iter_696_1 in ipairs(arg_695_1.choices_) do
				local var_696_0 = iter_696_0 <= 2

				SetActive(iter_696_1.go, var_696_0)
			end

			arg_695_1.choices_[1].txt.text = arg_695_1:FormatText(StoryChoiceCfg[1748].name)
			arg_695_1.choices_[2].txt.text = arg_695_1:FormatText(StoryChoiceCfg[1749].name)
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1109511172(arg_695_1)
			end

			if arg_697_0 == 2 then
				arg_695_0:Play1109511173(arg_695_1)
			end

			arg_695_1:RecordChoiceLog(1109511171, 1748, 1749)
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			return
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1109511172 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1109511172
		arg_699_1.duration_ = 2

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1109511174(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["10058ui_story"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos10058ui_story = var_702_0.localPosition
			end

			local var_702_2 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2
				local var_702_4 = Vector3.New(0, -0.98, -6.1)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10058ui_story, var_702_4, var_702_3)

				local var_702_5 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_5.x, var_702_5.y, var_702_5.z)

				local var_702_6 = var_702_0.localEulerAngles

				var_702_6.z = 0
				var_702_6.x = 0
				var_702_0.localEulerAngles = var_702_6
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_702_7 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_7.x, var_702_7.y, var_702_7.z)

				local var_702_8 = var_702_0.localEulerAngles

				var_702_8.z = 0
				var_702_8.x = 0
				var_702_0.localEulerAngles = var_702_8
			end

			local var_702_9 = arg_699_1.actors_["10058ui_story"]
			local var_702_10 = 0

			if var_702_10 < arg_699_1.time_ and arg_699_1.time_ <= var_702_10 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect10058ui_story == nil then
				arg_699_1.var_.characterEffect10058ui_story = var_702_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_11 = 0.200000002980232

			if var_702_10 <= arg_699_1.time_ and arg_699_1.time_ < var_702_10 + var_702_11 and not isNil(var_702_9) then
				local var_702_12 = (arg_699_1.time_ - var_702_10) / var_702_11

				if arg_699_1.var_.characterEffect10058ui_story and not isNil(var_702_9) then
					arg_699_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= var_702_10 + var_702_11 and arg_699_1.time_ < var_702_10 + var_702_11 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect10058ui_story then
				arg_699_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_702_13 = 0

			if var_702_13 < arg_699_1.time_ and arg_699_1.time_ <= var_702_13 + arg_702_0 then
				arg_699_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_702_14 = 0

			if var_702_14 < arg_699_1.time_ and arg_699_1.time_ <= var_702_14 + arg_702_0 then
				arg_699_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_702_15 = 0
			local var_702_16 = 0.05

			if var_702_15 < arg_699_1.time_ and arg_699_1.time_ <= var_702_15 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_17 = arg_699_1:FormatText(StoryNameCfg[471].name)

				arg_699_1.leftNameTxt_.text = var_702_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_18 = arg_699_1:GetWordFromCfg(1109511172)
				local var_702_19 = arg_699_1:FormatText(var_702_18.content)

				arg_699_1.text_.text = var_702_19

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_20 = 2
				local var_702_21 = utf8.len(var_702_19)
				local var_702_22 = var_702_20 <= 0 and var_702_16 or var_702_16 * (var_702_21 / var_702_20)

				if var_702_22 > 0 and var_702_16 < var_702_22 then
					arg_699_1.talkMaxDuration = var_702_22

					if var_702_22 + var_702_15 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_22 + var_702_15
					end
				end

				arg_699_1.text_.text = var_702_19
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb") ~= 0 then
					local var_702_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb") / 1000

					if var_702_23 + var_702_15 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_23 + var_702_15
					end

					if var_702_18.prefab_name ~= "" and arg_699_1.actors_[var_702_18.prefab_name] ~= nil then
						local var_702_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_18.prefab_name].transform, "story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")

						arg_699_1:RecordAudio("1109511172", var_702_24)
						arg_699_1:RecordAudio("1109511172", var_702_24)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_25 = math.max(var_702_16, arg_699_1.talkMaxDuration)

			if var_702_15 <= arg_699_1.time_ and arg_699_1.time_ < var_702_15 + var_702_25 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_15) / var_702_25

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_15 + var_702_25 and arg_699_1.time_ < var_702_15 + var_702_25 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play1109511174 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1109511174
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1109511175(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["10058ui_story"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos10058ui_story = var_706_0.localPosition
			end

			local var_706_2 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2
				local var_706_4 = Vector3.New(0, 100, 0)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos10058ui_story, var_706_4, var_706_3)

				local var_706_5 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_5.x, var_706_5.y, var_706_5.z)

				local var_706_6 = var_706_0.localEulerAngles

				var_706_6.z = 0
				var_706_6.x = 0
				var_706_0.localEulerAngles = var_706_6
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(0, 100, 0)

				local var_706_7 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_7.x, var_706_7.y, var_706_7.z)

				local var_706_8 = var_706_0.localEulerAngles

				var_706_8.z = 0
				var_706_8.x = 0
				var_706_0.localEulerAngles = var_706_8
			end

			local var_706_9 = arg_703_1.actors_["10058ui_story"]
			local var_706_10 = 0

			if var_706_10 < arg_703_1.time_ and arg_703_1.time_ <= var_706_10 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect10058ui_story == nil then
				arg_703_1.var_.characterEffect10058ui_story = var_706_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_11 = 0.200000002980232

			if var_706_10 <= arg_703_1.time_ and arg_703_1.time_ < var_706_10 + var_706_11 and not isNil(var_706_9) then
				local var_706_12 = (arg_703_1.time_ - var_706_10) / var_706_11

				if arg_703_1.var_.characterEffect10058ui_story and not isNil(var_706_9) then
					local var_706_13 = Mathf.Lerp(0, 0.5, var_706_12)

					arg_703_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_703_1.var_.characterEffect10058ui_story.fillRatio = var_706_13
				end
			end

			if arg_703_1.time_ >= var_706_10 + var_706_11 and arg_703_1.time_ < var_706_10 + var_706_11 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect10058ui_story then
				local var_706_14 = 0.5

				arg_703_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_703_1.var_.characterEffect10058ui_story.fillRatio = var_706_14
			end

			local var_706_15 = 0
			local var_706_16 = 0.725

			if var_706_15 < arg_703_1.time_ and arg_703_1.time_ <= var_706_15 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_17 = arg_703_1:GetWordFromCfg(1109511174)
				local var_706_18 = arg_703_1:FormatText(var_706_17.content)

				arg_703_1.text_.text = var_706_18

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_19 = 29
				local var_706_20 = utf8.len(var_706_18)
				local var_706_21 = var_706_19 <= 0 and var_706_16 or var_706_16 * (var_706_20 / var_706_19)

				if var_706_21 > 0 and var_706_16 < var_706_21 then
					arg_703_1.talkMaxDuration = var_706_21

					if var_706_21 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_21 + var_706_15
					end
				end

				arg_703_1.text_.text = var_706_18
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_22 = math.max(var_706_16, arg_703_1.talkMaxDuration)

			if var_706_15 <= arg_703_1.time_ and arg_703_1.time_ < var_706_15 + var_706_22 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_15) / var_706_22

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_15 + var_706_22 and arg_703_1.time_ < var_706_15 + var_706_22 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play1109511175 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1109511175
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1109511176(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0
			local var_710_1 = 1

			if var_710_0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_0 + arg_710_0 then
				local var_710_2 = "play"
				local var_710_3 = "effect"

				arg_707_1:AudioAction(var_710_2, var_710_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_710_4 = 0
			local var_710_5 = 1.15

			if var_710_4 < arg_707_1.time_ and arg_707_1.time_ <= var_710_4 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_6 = arg_707_1:GetWordFromCfg(1109511175)
				local var_710_7 = arg_707_1:FormatText(var_710_6.content)

				arg_707_1.text_.text = var_710_7

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_8 = 46
				local var_710_9 = utf8.len(var_710_7)
				local var_710_10 = var_710_8 <= 0 and var_710_5 or var_710_5 * (var_710_9 / var_710_8)

				if var_710_10 > 0 and var_710_5 < var_710_10 then
					arg_707_1.talkMaxDuration = var_710_10

					if var_710_10 + var_710_4 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_10 + var_710_4
					end
				end

				arg_707_1.text_.text = var_710_7
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_11 = math.max(var_710_5, arg_707_1.talkMaxDuration)

			if var_710_4 <= arg_707_1.time_ and arg_707_1.time_ < var_710_4 + var_710_11 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_4) / var_710_11

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_4 + var_710_11 and arg_707_1.time_ < var_710_4 + var_710_11 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1109511176 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1109511176
		arg_711_1.duration_ = 7.65

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1109511177(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = "ST77"

			if arg_711_1.bgs_[var_714_0] == nil then
				local var_714_1 = Object.Instantiate(arg_711_1.paintGo_)

				var_714_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_714_0)
				var_714_1.name = var_714_0
				var_714_1.transform.parent = arg_711_1.stage_.transform
				var_714_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_711_1.bgs_[var_714_0] = var_714_1
			end

			local var_714_2 = 1.35

			if var_714_2 < arg_711_1.time_ and arg_711_1.time_ <= var_714_2 + arg_714_0 then
				local var_714_3 = manager.ui.mainCamera.transform.localPosition
				local var_714_4 = Vector3.New(0, 0, 10) + Vector3.New(var_714_3.x, var_714_3.y, 0)
				local var_714_5 = arg_711_1.bgs_.ST77

				var_714_5.transform.localPosition = var_714_4
				var_714_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_714_6 = var_714_5:GetComponent("SpriteRenderer")

				if var_714_6 and var_714_6.sprite then
					local var_714_7 = (var_714_5.transform.localPosition - var_714_3).z
					local var_714_8 = manager.ui.mainCameraCom_
					local var_714_9 = 2 * var_714_7 * Mathf.Tan(var_714_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_714_10 = var_714_9 * var_714_8.aspect
					local var_714_11 = var_714_6.sprite.bounds.size.x
					local var_714_12 = var_714_6.sprite.bounds.size.y
					local var_714_13 = var_714_10 / var_714_11
					local var_714_14 = var_714_9 / var_714_12
					local var_714_15 = var_714_14 < var_714_13 and var_714_13 or var_714_14

					var_714_5.transform.localScale = Vector3.New(var_714_15, var_714_15, 0)
				end

				for iter_714_0, iter_714_1 in pairs(arg_711_1.bgs_) do
					if iter_714_0 ~= "ST77" then
						iter_714_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_714_16 = 0

			if var_714_16 < arg_711_1.time_ and arg_711_1.time_ <= var_714_16 + arg_714_0 then
				arg_711_1.allBtn_.enabled = false
			end

			local var_714_17 = 0.3

			if arg_711_1.time_ >= var_714_16 + var_714_17 and arg_711_1.time_ < var_714_16 + var_714_17 + arg_714_0 then
				arg_711_1.allBtn_.enabled = true
			end

			local var_714_18 = 0

			if var_714_18 < arg_711_1.time_ and arg_711_1.time_ <= var_714_18 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_19 = 1.35

			if var_714_18 <= arg_711_1.time_ and arg_711_1.time_ < var_714_18 + var_714_19 then
				local var_714_20 = (arg_711_1.time_ - var_714_18) / var_714_19
				local var_714_21 = Color.New(0, 0, 0)

				var_714_21.a = Mathf.Lerp(0, 1, var_714_20)
				arg_711_1.mask_.color = var_714_21
			end

			if arg_711_1.time_ >= var_714_18 + var_714_19 and arg_711_1.time_ < var_714_18 + var_714_19 + arg_714_0 then
				local var_714_22 = Color.New(0, 0, 0)

				var_714_22.a = 1
				arg_711_1.mask_.color = var_714_22
			end

			local var_714_23 = 1.35

			if var_714_23 < arg_711_1.time_ and arg_711_1.time_ <= var_714_23 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_24 = 1.35

			if var_714_23 <= arg_711_1.time_ and arg_711_1.time_ < var_714_23 + var_714_24 then
				local var_714_25 = (arg_711_1.time_ - var_714_23) / var_714_24
				local var_714_26 = Color.New(0, 0, 0)

				var_714_26.a = Mathf.Lerp(1, 0, var_714_25)
				arg_711_1.mask_.color = var_714_26
			end

			if arg_711_1.time_ >= var_714_23 + var_714_24 and arg_711_1.time_ < var_714_23 + var_714_24 + arg_714_0 then
				local var_714_27 = Color.New(0, 0, 0)
				local var_714_28 = 0

				arg_711_1.mask_.enabled = false
				var_714_27.a = var_714_28
				arg_711_1.mask_.color = var_714_27
			end

			local var_714_29 = 1
			local var_714_30 = 1

			if var_714_29 < arg_711_1.time_ and arg_711_1.time_ <= var_714_29 + arg_714_0 then
				local var_714_31 = "play"
				local var_714_32 = "effect"

				arg_711_1:AudioAction(var_714_31, var_714_32, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_714_33 = 0.2
			local var_714_34 = 1

			if var_714_33 < arg_711_1.time_ and arg_711_1.time_ <= var_714_33 + arg_714_0 then
				local var_714_35 = "stop"
				local var_714_36 = "effect"

				arg_711_1:AudioAction(var_714_35, var_714_36, "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			local var_714_37 = 1
			local var_714_38 = 1

			if var_714_37 < arg_711_1.time_ and arg_711_1.time_ <= var_714_37 + arg_714_0 then
				local var_714_39 = "play"
				local var_714_40 = "music"

				arg_711_1:AudioAction(var_714_39, var_714_40, "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day.awb")

				local var_714_41 = ""
				local var_714_42 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day")

				if var_714_42 ~= "" then
					if arg_711_1.bgmTxt_.text ~= var_714_42 and arg_711_1.bgmTxt_.text ~= "" then
						if arg_711_1.bgmTxt2_.text ~= "" then
							arg_711_1.bgmTxt_.text = arg_711_1.bgmTxt2_.text
						end

						arg_711_1.bgmTxt2_.text = var_714_42

						arg_711_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_711_1.bgmTxt_.text = var_714_42
						arg_711_1.bgmTxt2_.text = var_714_42
					end

					if arg_711_1.bgmTimer then
						arg_711_1.bgmTimer:Stop()

						arg_711_1.bgmTimer = nil
					end

					if arg_711_1.settingData.show_music_name == 1 then
						arg_711_1.musicController:SetSelectedState("show")
						arg_711_1.musicAnimator_:Play("open", 0, 0)

						if arg_711_1.settingData.music_time ~= 0 then
							arg_711_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_711_1.settingData.music_time), function()
								if arg_711_1 == nil or isNil(arg_711_1.bgmTxt_) then
									return
								end

								arg_711_1.musicController:SetSelectedState("hide")
								arg_711_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_711_1.frameCnt_ <= 1 then
				arg_711_1.dialog_:SetActive(false)
			end

			local var_714_43 = 2.65
			local var_714_44 = 0.7

			if var_714_43 < arg_711_1.time_ and arg_711_1.time_ <= var_714_43 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0

				arg_711_1.dialog_:SetActive(true)

				arg_711_1.dialogCg_.alpha = 0

				local var_714_45 = LeanTween.value(arg_711_1.dialog_, 0, 1, 0.3)

				var_714_45:setOnUpdate(LuaHelper.FloatAction(function(arg_716_0)
					arg_711_1.dialogCg_.alpha = arg_716_0
				end))
				var_714_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_711_1.dialog_)
					var_714_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_711_1.duration_ = arg_711_1.duration_ + 0.3

				SetActive(arg_711_1.leftNameGo_, false)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_46 = arg_711_1:GetWordFromCfg(1109511176)
				local var_714_47 = arg_711_1:FormatText(var_714_46.content)

				arg_711_1.text_.text = var_714_47

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_48 = 28
				local var_714_49 = utf8.len(var_714_47)
				local var_714_50 = var_714_48 <= 0 and var_714_44 or var_714_44 * (var_714_49 / var_714_48)

				if var_714_50 > 0 and var_714_44 < var_714_50 then
					arg_711_1.talkMaxDuration = var_714_50
					var_714_43 = var_714_43 + 0.3

					if var_714_50 + var_714_43 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_50 + var_714_43
					end
				end

				arg_711_1.text_.text = var_714_47
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_51 = var_714_43 + 0.3
			local var_714_52 = math.max(var_714_44, arg_711_1.talkMaxDuration)

			if var_714_51 <= arg_711_1.time_ and arg_711_1.time_ < var_714_51 + var_714_52 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_51) / var_714_52

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_51 + var_714_52 and arg_711_1.time_ < var_714_51 + var_714_52 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1109511177 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 1109511177
		arg_718_1.duration_ = 5

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play1109511178(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			local var_721_0 = 0
			local var_721_1 = 0.35

			if var_721_0 < arg_718_1.time_ and arg_718_1.time_ <= var_721_0 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				local var_721_2 = arg_718_1:FormatText(StoryNameCfg[7].name)

				arg_718_1.leftNameTxt_.text = var_721_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, true)
				arg_718_1.iconController_:SetSelectedState("hero")

				arg_718_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_718_1.callingController_:SetSelectedState("normal")

				arg_718_1.keyicon_.color = Color.New(1, 1, 1)
				arg_718_1.icon_.color = Color.New(1, 1, 1)

				local var_721_3 = arg_718_1:GetWordFromCfg(1109511177)
				local var_721_4 = arg_718_1:FormatText(var_721_3.content)

				arg_718_1.text_.text = var_721_4

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_5 = 14
				local var_721_6 = utf8.len(var_721_4)
				local var_721_7 = var_721_5 <= 0 and var_721_1 or var_721_1 * (var_721_6 / var_721_5)

				if var_721_7 > 0 and var_721_1 < var_721_7 then
					arg_718_1.talkMaxDuration = var_721_7

					if var_721_7 + var_721_0 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_7 + var_721_0
					end
				end

				arg_718_1.text_.text = var_721_4
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)
				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_8 = math.max(var_721_1, arg_718_1.talkMaxDuration)

			if var_721_0 <= arg_718_1.time_ and arg_718_1.time_ < var_721_0 + var_721_8 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - var_721_0) / var_721_8

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= var_721_0 + var_721_8 and arg_718_1.time_ < var_721_0 + var_721_8 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play1109511178 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1109511178
		arg_722_1.duration_ = 7.17

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1109511179(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			local var_725_0 = arg_722_1.actors_["10058ui_story"].transform
			local var_725_1 = 0

			if var_725_1 < arg_722_1.time_ and arg_722_1.time_ <= var_725_1 + arg_725_0 then
				arg_722_1.var_.moveOldPos10058ui_story = var_725_0.localPosition
			end

			local var_725_2 = 0.001

			if var_725_1 <= arg_722_1.time_ and arg_722_1.time_ < var_725_1 + var_725_2 then
				local var_725_3 = (arg_722_1.time_ - var_725_1) / var_725_2
				local var_725_4 = Vector3.New(0, -0.98, -6.1)

				var_725_0.localPosition = Vector3.Lerp(arg_722_1.var_.moveOldPos10058ui_story, var_725_4, var_725_3)

				local var_725_5 = manager.ui.mainCamera.transform.position - var_725_0.position

				var_725_0.forward = Vector3.New(var_725_5.x, var_725_5.y, var_725_5.z)

				local var_725_6 = var_725_0.localEulerAngles

				var_725_6.z = 0
				var_725_6.x = 0
				var_725_0.localEulerAngles = var_725_6
			end

			if arg_722_1.time_ >= var_725_1 + var_725_2 and arg_722_1.time_ < var_725_1 + var_725_2 + arg_725_0 then
				var_725_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_725_7 = manager.ui.mainCamera.transform.position - var_725_0.position

				var_725_0.forward = Vector3.New(var_725_7.x, var_725_7.y, var_725_7.z)

				local var_725_8 = var_725_0.localEulerAngles

				var_725_8.z = 0
				var_725_8.x = 0
				var_725_0.localEulerAngles = var_725_8
			end

			local var_725_9 = arg_722_1.actors_["10058ui_story"]
			local var_725_10 = 0

			if var_725_10 < arg_722_1.time_ and arg_722_1.time_ <= var_725_10 + arg_725_0 and not isNil(var_725_9) and arg_722_1.var_.characterEffect10058ui_story == nil then
				arg_722_1.var_.characterEffect10058ui_story = var_725_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_725_11 = 0.200000002980232

			if var_725_10 <= arg_722_1.time_ and arg_722_1.time_ < var_725_10 + var_725_11 and not isNil(var_725_9) then
				local var_725_12 = (arg_722_1.time_ - var_725_10) / var_725_11

				if arg_722_1.var_.characterEffect10058ui_story and not isNil(var_725_9) then
					arg_722_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_722_1.time_ >= var_725_10 + var_725_11 and arg_722_1.time_ < var_725_10 + var_725_11 + arg_725_0 and not isNil(var_725_9) and arg_722_1.var_.characterEffect10058ui_story then
				arg_722_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_725_13 = 0

			if var_725_13 < arg_722_1.time_ and arg_722_1.time_ <= var_725_13 + arg_725_0 then
				arg_722_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_725_14 = 0

			if var_725_14 < arg_722_1.time_ and arg_722_1.time_ <= var_725_14 + arg_725_0 then
				arg_722_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_725_15 = 0
			local var_725_16 = 0.8

			if var_725_15 < arg_722_1.time_ and arg_722_1.time_ <= var_725_15 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				local var_725_17 = arg_722_1:FormatText(StoryNameCfg[471].name)

				arg_722_1.leftNameTxt_.text = var_725_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, false)
				arg_722_1.callingController_:SetSelectedState("normal")

				local var_725_18 = arg_722_1:GetWordFromCfg(1109511178)
				local var_725_19 = arg_722_1:FormatText(var_725_18.content)

				arg_722_1.text_.text = var_725_19

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_20 = 32
				local var_725_21 = utf8.len(var_725_19)
				local var_725_22 = var_725_20 <= 0 and var_725_16 or var_725_16 * (var_725_21 / var_725_20)

				if var_725_22 > 0 and var_725_16 < var_725_22 then
					arg_722_1.talkMaxDuration = var_725_22

					if var_725_22 + var_725_15 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_22 + var_725_15
					end
				end

				arg_722_1.text_.text = var_725_19
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb") ~= 0 then
					local var_725_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb") / 1000

					if var_725_23 + var_725_15 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_23 + var_725_15
					end

					if var_725_18.prefab_name ~= "" and arg_722_1.actors_[var_725_18.prefab_name] ~= nil then
						local var_725_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_722_1.actors_[var_725_18.prefab_name].transform, "story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")

						arg_722_1:RecordAudio("1109511178", var_725_24)
						arg_722_1:RecordAudio("1109511178", var_725_24)
					else
						arg_722_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")
					end

					arg_722_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")
				end

				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_25 = math.max(var_725_16, arg_722_1.talkMaxDuration)

			if var_725_15 <= arg_722_1.time_ and arg_722_1.time_ < var_725_15 + var_725_25 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_15) / var_725_25

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_15 + var_725_25 and arg_722_1.time_ < var_725_15 + var_725_25 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_722_1:InitPlayNodeList()
	end,
	Play1109511179 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1109511179
		arg_726_1.duration_ = 9.5

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1109511180(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			local var_729_0 = 0
			local var_729_1 = 0.95

			if var_729_0 < arg_726_1.time_ and arg_726_1.time_ <= var_729_0 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				local var_729_2 = arg_726_1:FormatText(StoryNameCfg[471].name)

				arg_726_1.leftNameTxt_.text = var_729_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_3 = arg_726_1:GetWordFromCfg(1109511179)
				local var_729_4 = arg_726_1:FormatText(var_729_3.content)

				arg_726_1.text_.text = var_729_4

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_5 = 38
				local var_729_6 = utf8.len(var_729_4)
				local var_729_7 = var_729_5 <= 0 and var_729_1 or var_729_1 * (var_729_6 / var_729_5)

				if var_729_7 > 0 and var_729_1 < var_729_7 then
					arg_726_1.talkMaxDuration = var_729_7

					if var_729_7 + var_729_0 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_7 + var_729_0
					end
				end

				arg_726_1.text_.text = var_729_4
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb") ~= 0 then
					local var_729_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb") / 1000

					if var_729_8 + var_729_0 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_8 + var_729_0
					end

					if var_729_3.prefab_name ~= "" and arg_726_1.actors_[var_729_3.prefab_name] ~= nil then
						local var_729_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_3.prefab_name].transform, "story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")

						arg_726_1:RecordAudio("1109511179", var_729_9)
						arg_726_1:RecordAudio("1109511179", var_729_9)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_10 = math.max(var_729_1, arg_726_1.talkMaxDuration)

			if var_729_0 <= arg_726_1.time_ and arg_726_1.time_ < var_729_0 + var_729_10 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_0) / var_729_10

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_0 + var_729_10 and arg_726_1.time_ < var_729_0 + var_729_10 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play1109511180 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1109511180
		arg_730_1.duration_ = 5

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1109511181(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			local var_733_0 = arg_730_1.actors_["10058ui_story"]
			local var_733_1 = 0

			if var_733_1 < arg_730_1.time_ and arg_730_1.time_ <= var_733_1 + arg_733_0 and not isNil(var_733_0) and arg_730_1.var_.characterEffect10058ui_story == nil then
				arg_730_1.var_.characterEffect10058ui_story = var_733_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_733_2 = 0.200000002980232

			if var_733_1 <= arg_730_1.time_ and arg_730_1.time_ < var_733_1 + var_733_2 and not isNil(var_733_0) then
				local var_733_3 = (arg_730_1.time_ - var_733_1) / var_733_2

				if arg_730_1.var_.characterEffect10058ui_story and not isNil(var_733_0) then
					local var_733_4 = Mathf.Lerp(0, 0.5, var_733_3)

					arg_730_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_730_1.var_.characterEffect10058ui_story.fillRatio = var_733_4
				end
			end

			if arg_730_1.time_ >= var_733_1 + var_733_2 and arg_730_1.time_ < var_733_1 + var_733_2 + arg_733_0 and not isNil(var_733_0) and arg_730_1.var_.characterEffect10058ui_story then
				local var_733_5 = 0.5

				arg_730_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_730_1.var_.characterEffect10058ui_story.fillRatio = var_733_5
			end

			local var_733_6 = 0
			local var_733_7 = 0.65

			if var_733_6 < arg_730_1.time_ and arg_730_1.time_ <= var_733_6 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				local var_733_8 = arg_730_1:FormatText(StoryNameCfg[7].name)

				arg_730_1.leftNameTxt_.text = var_733_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, true)
				arg_730_1.iconController_:SetSelectedState("hero")

				arg_730_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_730_1.callingController_:SetSelectedState("normal")

				arg_730_1.keyicon_.color = Color.New(1, 1, 1)
				arg_730_1.icon_.color = Color.New(1, 1, 1)

				local var_733_9 = arg_730_1:GetWordFromCfg(1109511180)
				local var_733_10 = arg_730_1:FormatText(var_733_9.content)

				arg_730_1.text_.text = var_733_10

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_11 = 26
				local var_733_12 = utf8.len(var_733_10)
				local var_733_13 = var_733_11 <= 0 and var_733_7 or var_733_7 * (var_733_12 / var_733_11)

				if var_733_13 > 0 and var_733_7 < var_733_13 then
					arg_730_1.talkMaxDuration = var_733_13

					if var_733_13 + var_733_6 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_13 + var_733_6
					end
				end

				arg_730_1.text_.text = var_733_10
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)
				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_14 = math.max(var_733_7, arg_730_1.talkMaxDuration)

			if var_733_6 <= arg_730_1.time_ and arg_730_1.time_ < var_733_6 + var_733_14 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_6) / var_733_14

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_6 + var_733_14 and arg_730_1.time_ < var_733_6 + var_733_14 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1109511181 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1109511181
		arg_734_1.duration_ = 9.1

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1109511182(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			local var_737_0 = arg_734_1.actors_["10058ui_story"]
			local var_737_1 = 0

			if var_737_1 < arg_734_1.time_ and arg_734_1.time_ <= var_737_1 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect10058ui_story == nil then
				arg_734_1.var_.characterEffect10058ui_story = var_737_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_2 = 0.200000002980232

			if var_737_1 <= arg_734_1.time_ and arg_734_1.time_ < var_737_1 + var_737_2 and not isNil(var_737_0) then
				local var_737_3 = (arg_734_1.time_ - var_737_1) / var_737_2

				if arg_734_1.var_.characterEffect10058ui_story and not isNil(var_737_0) then
					arg_734_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_734_1.time_ >= var_737_1 + var_737_2 and arg_734_1.time_ < var_737_1 + var_737_2 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect10058ui_story then
				arg_734_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_737_4 = 0

			if var_737_4 < arg_734_1.time_ and arg_734_1.time_ <= var_737_4 + arg_737_0 then
				arg_734_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_737_5 = 0

			if var_737_5 < arg_734_1.time_ and arg_734_1.time_ <= var_737_5 + arg_737_0 then
				arg_734_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_737_6 = 0
			local var_737_7 = 0.95

			if var_737_6 < arg_734_1.time_ and arg_734_1.time_ <= var_737_6 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				local var_737_8 = arg_734_1:FormatText(StoryNameCfg[471].name)

				arg_734_1.leftNameTxt_.text = var_737_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, false)
				arg_734_1.callingController_:SetSelectedState("normal")

				local var_737_9 = arg_734_1:GetWordFromCfg(1109511181)
				local var_737_10 = arg_734_1:FormatText(var_737_9.content)

				arg_734_1.text_.text = var_737_10

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_11 = 38
				local var_737_12 = utf8.len(var_737_10)
				local var_737_13 = var_737_11 <= 0 and var_737_7 or var_737_7 * (var_737_12 / var_737_11)

				if var_737_13 > 0 and var_737_7 < var_737_13 then
					arg_734_1.talkMaxDuration = var_737_13

					if var_737_13 + var_737_6 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_13 + var_737_6
					end
				end

				arg_734_1.text_.text = var_737_10
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb") ~= 0 then
					local var_737_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb") / 1000

					if var_737_14 + var_737_6 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_14 + var_737_6
					end

					if var_737_9.prefab_name ~= "" and arg_734_1.actors_[var_737_9.prefab_name] ~= nil then
						local var_737_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_734_1.actors_[var_737_9.prefab_name].transform, "story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")

						arg_734_1:RecordAudio("1109511181", var_737_15)
						arg_734_1:RecordAudio("1109511181", var_737_15)
					else
						arg_734_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")
					end

					arg_734_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")
				end

				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_16 = math.max(var_737_7, arg_734_1.talkMaxDuration)

			if var_737_6 <= arg_734_1.time_ and arg_734_1.time_ < var_737_6 + var_737_16 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_6) / var_737_16

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_6 + var_737_16 and arg_734_1.time_ < var_737_6 + var_737_16 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1109511182 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1109511182
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1109511183(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = arg_738_1.actors_["10058ui_story"]
			local var_741_1 = 0

			if var_741_1 < arg_738_1.time_ and arg_738_1.time_ <= var_741_1 + arg_741_0 and not isNil(var_741_0) and arg_738_1.var_.characterEffect10058ui_story == nil then
				arg_738_1.var_.characterEffect10058ui_story = var_741_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_2 = 0.200000002980232

			if var_741_1 <= arg_738_1.time_ and arg_738_1.time_ < var_741_1 + var_741_2 and not isNil(var_741_0) then
				local var_741_3 = (arg_738_1.time_ - var_741_1) / var_741_2

				if arg_738_1.var_.characterEffect10058ui_story and not isNil(var_741_0) then
					local var_741_4 = Mathf.Lerp(0, 0.5, var_741_3)

					arg_738_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_738_1.var_.characterEffect10058ui_story.fillRatio = var_741_4
				end
			end

			if arg_738_1.time_ >= var_741_1 + var_741_2 and arg_738_1.time_ < var_741_1 + var_741_2 + arg_741_0 and not isNil(var_741_0) and arg_738_1.var_.characterEffect10058ui_story then
				local var_741_5 = 0.5

				arg_738_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_738_1.var_.characterEffect10058ui_story.fillRatio = var_741_5
			end

			local var_741_6 = 0
			local var_741_7 = 0.85

			if var_741_6 < arg_738_1.time_ and arg_738_1.time_ <= var_741_6 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				local var_741_8 = arg_738_1:FormatText(StoryNameCfg[7].name)

				arg_738_1.leftNameTxt_.text = var_741_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_9 = arg_738_1:GetWordFromCfg(1109511182)
				local var_741_10 = arg_738_1:FormatText(var_741_9.content)

				arg_738_1.text_.text = var_741_10

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_11 = 34
				local var_741_12 = utf8.len(var_741_10)
				local var_741_13 = var_741_11 <= 0 and var_741_7 or var_741_7 * (var_741_12 / var_741_11)

				if var_741_13 > 0 and var_741_7 < var_741_13 then
					arg_738_1.talkMaxDuration = var_741_13

					if var_741_13 + var_741_6 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_13 + var_741_6
					end
				end

				arg_738_1.text_.text = var_741_10
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_14 = math.max(var_741_7, arg_738_1.talkMaxDuration)

			if var_741_6 <= arg_738_1.time_ and arg_738_1.time_ < var_741_6 + var_741_14 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_6) / var_741_14

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_6 + var_741_14 and arg_738_1.time_ < var_741_6 + var_741_14 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1109511183 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1109511183
		arg_742_1.duration_ = 5

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1109511184(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			local var_745_0 = 0
			local var_745_1 = 0.575

			if var_745_0 < arg_742_1.time_ and arg_742_1.time_ <= var_745_0 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				local var_745_2 = arg_742_1:FormatText(StoryNameCfg[7].name)

				arg_742_1.leftNameTxt_.text = var_745_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, true)
				arg_742_1.iconController_:SetSelectedState("hero")

				arg_742_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_742_1.callingController_:SetSelectedState("normal")

				arg_742_1.keyicon_.color = Color.New(1, 1, 1)
				arg_742_1.icon_.color = Color.New(1, 1, 1)

				local var_745_3 = arg_742_1:GetWordFromCfg(1109511183)
				local var_745_4 = arg_742_1:FormatText(var_745_3.content)

				arg_742_1.text_.text = var_745_4

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_5 = 23
				local var_745_6 = utf8.len(var_745_4)
				local var_745_7 = var_745_5 <= 0 and var_745_1 or var_745_1 * (var_745_6 / var_745_5)

				if var_745_7 > 0 and var_745_1 < var_745_7 then
					arg_742_1.talkMaxDuration = var_745_7

					if var_745_7 + var_745_0 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_7 + var_745_0
					end
				end

				arg_742_1.text_.text = var_745_4
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)
				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_8 = math.max(var_745_1, arg_742_1.talkMaxDuration)

			if var_745_0 <= arg_742_1.time_ and arg_742_1.time_ < var_745_0 + var_745_8 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_0) / var_745_8

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_0 + var_745_8 and arg_742_1.time_ < var_745_0 + var_745_8 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1109511184 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1109511184
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1109511185(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			local var_749_0 = arg_746_1.actors_["10058ui_story"].transform
			local var_749_1 = 0

			if var_749_1 < arg_746_1.time_ and arg_746_1.time_ <= var_749_1 + arg_749_0 then
				arg_746_1.var_.moveOldPos10058ui_story = var_749_0.localPosition
			end

			local var_749_2 = 0.001

			if var_749_1 <= arg_746_1.time_ and arg_746_1.time_ < var_749_1 + var_749_2 then
				local var_749_3 = (arg_746_1.time_ - var_749_1) / var_749_2
				local var_749_4 = Vector3.New(0, 100, 0)

				var_749_0.localPosition = Vector3.Lerp(arg_746_1.var_.moveOldPos10058ui_story, var_749_4, var_749_3)

				local var_749_5 = manager.ui.mainCamera.transform.position - var_749_0.position

				var_749_0.forward = Vector3.New(var_749_5.x, var_749_5.y, var_749_5.z)

				local var_749_6 = var_749_0.localEulerAngles

				var_749_6.z = 0
				var_749_6.x = 0
				var_749_0.localEulerAngles = var_749_6
			end

			if arg_746_1.time_ >= var_749_1 + var_749_2 and arg_746_1.time_ < var_749_1 + var_749_2 + arg_749_0 then
				var_749_0.localPosition = Vector3.New(0, 100, 0)

				local var_749_7 = manager.ui.mainCamera.transform.position - var_749_0.position

				var_749_0.forward = Vector3.New(var_749_7.x, var_749_7.y, var_749_7.z)

				local var_749_8 = var_749_0.localEulerAngles

				var_749_8.z = 0
				var_749_8.x = 0
				var_749_0.localEulerAngles = var_749_8
			end

			local var_749_9 = 1
			local var_749_10 = 1

			if var_749_9 < arg_746_1.time_ and arg_746_1.time_ <= var_749_9 + arg_749_0 then
				local var_749_11 = "play"
				local var_749_12 = "effect"

				arg_746_1:AudioAction(var_749_11, var_749_12, "se_story_143", "se_story_143_foley_cloth02", "")
			end

			local var_749_13 = 0
			local var_749_14 = 0.75

			if var_749_13 < arg_746_1.time_ and arg_746_1.time_ <= var_749_13 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, false)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_746_1.iconTrs_.gameObject, false)
				arg_746_1.callingController_:SetSelectedState("normal")

				local var_749_15 = arg_746_1:GetWordFromCfg(1109511184)
				local var_749_16 = arg_746_1:FormatText(var_749_15.content)

				arg_746_1.text_.text = var_749_16

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_17 = 30
				local var_749_18 = utf8.len(var_749_16)
				local var_749_19 = var_749_17 <= 0 and var_749_14 or var_749_14 * (var_749_18 / var_749_17)

				if var_749_19 > 0 and var_749_14 < var_749_19 then
					arg_746_1.talkMaxDuration = var_749_19

					if var_749_19 + var_749_13 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_19 + var_749_13
					end
				end

				arg_746_1.text_.text = var_749_16
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_20 = math.max(var_749_14, arg_746_1.talkMaxDuration)

			if var_749_13 <= arg_746_1.time_ and arg_746_1.time_ < var_749_13 + var_749_20 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_13) / var_749_20

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_13 + var_749_20 and arg_746_1.time_ < var_749_13 + var_749_20 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_746_1:InitPlayNodeList()
	end,
	Play1109511185 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1109511185
		arg_750_1.duration_ = 6.13

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1109511186(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			local var_753_0 = arg_750_1.actors_["10058ui_story"]
			local var_753_1 = 0

			if var_753_1 < arg_750_1.time_ and arg_750_1.time_ <= var_753_1 + arg_753_0 and not isNil(var_753_0) and arg_750_1.var_.characterEffect10058ui_story == nil then
				arg_750_1.var_.characterEffect10058ui_story = var_753_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_753_2 = 0.200000002980232

			if var_753_1 <= arg_750_1.time_ and arg_750_1.time_ < var_753_1 + var_753_2 and not isNil(var_753_0) then
				local var_753_3 = (arg_750_1.time_ - var_753_1) / var_753_2

				if arg_750_1.var_.characterEffect10058ui_story and not isNil(var_753_0) then
					arg_750_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_750_1.time_ >= var_753_1 + var_753_2 and arg_750_1.time_ < var_753_1 + var_753_2 + arg_753_0 and not isNil(var_753_0) and arg_750_1.var_.characterEffect10058ui_story then
				arg_750_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_753_4 = 0

			if var_753_4 < arg_750_1.time_ and arg_750_1.time_ <= var_753_4 + arg_753_0 then
				arg_750_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_753_5 = arg_750_1.actors_["10058ui_story"].transform
			local var_753_6 = 0

			if var_753_6 < arg_750_1.time_ and arg_750_1.time_ <= var_753_6 + arg_753_0 then
				arg_750_1.var_.moveOldPos10058ui_story = var_753_5.localPosition
			end

			local var_753_7 = 0.001

			if var_753_6 <= arg_750_1.time_ and arg_750_1.time_ < var_753_6 + var_753_7 then
				local var_753_8 = (arg_750_1.time_ - var_753_6) / var_753_7
				local var_753_9 = Vector3.New(0, -0.98, -6.1)

				var_753_5.localPosition = Vector3.Lerp(arg_750_1.var_.moveOldPos10058ui_story, var_753_9, var_753_8)

				local var_753_10 = manager.ui.mainCamera.transform.position - var_753_5.position

				var_753_5.forward = Vector3.New(var_753_10.x, var_753_10.y, var_753_10.z)

				local var_753_11 = var_753_5.localEulerAngles

				var_753_11.z = 0
				var_753_11.x = 0
				var_753_5.localEulerAngles = var_753_11
			end

			if arg_750_1.time_ >= var_753_6 + var_753_7 and arg_750_1.time_ < var_753_6 + var_753_7 + arg_753_0 then
				var_753_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_753_12 = manager.ui.mainCamera.transform.position - var_753_5.position

				var_753_5.forward = Vector3.New(var_753_12.x, var_753_12.y, var_753_12.z)

				local var_753_13 = var_753_5.localEulerAngles

				var_753_13.z = 0
				var_753_13.x = 0
				var_753_5.localEulerAngles = var_753_13
			end

			local var_753_14 = 0

			if var_753_14 < arg_750_1.time_ and arg_750_1.time_ <= var_753_14 + arg_753_0 then
				arg_750_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_753_15 = 0
			local var_753_16 = 0.6

			if var_753_15 < arg_750_1.time_ and arg_750_1.time_ <= var_753_15 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				local var_753_17 = arg_750_1:FormatText(StoryNameCfg[471].name)

				arg_750_1.leftNameTxt_.text = var_753_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_18 = arg_750_1:GetWordFromCfg(1109511185)
				local var_753_19 = arg_750_1:FormatText(var_753_18.content)

				arg_750_1.text_.text = var_753_19

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_20 = 24
				local var_753_21 = utf8.len(var_753_19)
				local var_753_22 = var_753_20 <= 0 and var_753_16 or var_753_16 * (var_753_21 / var_753_20)

				if var_753_22 > 0 and var_753_16 < var_753_22 then
					arg_750_1.talkMaxDuration = var_753_22

					if var_753_22 + var_753_15 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_22 + var_753_15
					end
				end

				arg_750_1.text_.text = var_753_19
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb") ~= 0 then
					local var_753_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb") / 1000

					if var_753_23 + var_753_15 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_23 + var_753_15
					end

					if var_753_18.prefab_name ~= "" and arg_750_1.actors_[var_753_18.prefab_name] ~= nil then
						local var_753_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_18.prefab_name].transform, "story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")

						arg_750_1:RecordAudio("1109511185", var_753_24)
						arg_750_1:RecordAudio("1109511185", var_753_24)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_25 = math.max(var_753_16, arg_750_1.talkMaxDuration)

			if var_753_15 <= arg_750_1.time_ and arg_750_1.time_ < var_753_15 + var_753_25 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_15) / var_753_25

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_15 + var_753_25 and arg_750_1.time_ < var_753_15 + var_753_25 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_750_1:InitPlayNodeList()
	end,
	Play1109511186 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1109511186
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1109511187(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			local var_757_0 = arg_754_1.actors_["10058ui_story"]
			local var_757_1 = 0

			if var_757_1 < arg_754_1.time_ and arg_754_1.time_ <= var_757_1 + arg_757_0 and not isNil(var_757_0) and arg_754_1.var_.characterEffect10058ui_story == nil then
				arg_754_1.var_.characterEffect10058ui_story = var_757_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_757_2 = 0.200000002980232

			if var_757_1 <= arg_754_1.time_ and arg_754_1.time_ < var_757_1 + var_757_2 and not isNil(var_757_0) then
				local var_757_3 = (arg_754_1.time_ - var_757_1) / var_757_2

				if arg_754_1.var_.characterEffect10058ui_story and not isNil(var_757_0) then
					local var_757_4 = Mathf.Lerp(0, 0.5, var_757_3)

					arg_754_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_754_1.var_.characterEffect10058ui_story.fillRatio = var_757_4
				end
			end

			if arg_754_1.time_ >= var_757_1 + var_757_2 and arg_754_1.time_ < var_757_1 + var_757_2 + arg_757_0 and not isNil(var_757_0) and arg_754_1.var_.characterEffect10058ui_story then
				local var_757_5 = 0.5

				arg_754_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_754_1.var_.characterEffect10058ui_story.fillRatio = var_757_5
			end

			local var_757_6 = 0
			local var_757_7 = 0.975

			if var_757_6 < arg_754_1.time_ and arg_754_1.time_ <= var_757_6 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				local var_757_8 = arg_754_1:FormatText(StoryNameCfg[7].name)

				arg_754_1.leftNameTxt_.text = var_757_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_9 = arg_754_1:GetWordFromCfg(1109511186)
				local var_757_10 = arg_754_1:FormatText(var_757_9.content)

				arg_754_1.text_.text = var_757_10

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_11 = 39
				local var_757_12 = utf8.len(var_757_10)
				local var_757_13 = var_757_11 <= 0 and var_757_7 or var_757_7 * (var_757_12 / var_757_11)

				if var_757_13 > 0 and var_757_7 < var_757_13 then
					arg_754_1.talkMaxDuration = var_757_13

					if var_757_13 + var_757_6 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_13 + var_757_6
					end
				end

				arg_754_1.text_.text = var_757_10
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_14 = math.max(var_757_7, arg_754_1.talkMaxDuration)

			if var_757_6 <= arg_754_1.time_ and arg_754_1.time_ < var_757_6 + var_757_14 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - var_757_6) / var_757_14

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= var_757_6 + var_757_14 and arg_754_1.time_ < var_757_6 + var_757_14 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1109511187 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1109511187
		arg_758_1.duration_ = 2.33

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1109511188(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			local var_761_0 = arg_758_1.actors_["10058ui_story"]
			local var_761_1 = 0

			if var_761_1 < arg_758_1.time_ and arg_758_1.time_ <= var_761_1 + arg_761_0 and not isNil(var_761_0) and arg_758_1.var_.characterEffect10058ui_story == nil then
				arg_758_1.var_.characterEffect10058ui_story = var_761_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_761_2 = 0.200000002980232

			if var_761_1 <= arg_758_1.time_ and arg_758_1.time_ < var_761_1 + var_761_2 and not isNil(var_761_0) then
				local var_761_3 = (arg_758_1.time_ - var_761_1) / var_761_2

				if arg_758_1.var_.characterEffect10058ui_story and not isNil(var_761_0) then
					arg_758_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_758_1.time_ >= var_761_1 + var_761_2 and arg_758_1.time_ < var_761_1 + var_761_2 + arg_761_0 and not isNil(var_761_0) and arg_758_1.var_.characterEffect10058ui_story then
				arg_758_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_761_4 = 0
			local var_761_5 = 0.15

			if var_761_4 < arg_758_1.time_ and arg_758_1.time_ <= var_761_4 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, true)

				local var_761_6 = arg_758_1:FormatText(StoryNameCfg[471].name)

				arg_758_1.leftNameTxt_.text = var_761_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_758_1.leftNameTxt_.transform)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1.leftNameTxt_.text)
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_7 = arg_758_1:GetWordFromCfg(1109511187)
				local var_761_8 = arg_758_1:FormatText(var_761_7.content)

				arg_758_1.text_.text = var_761_8

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_9 = 6
				local var_761_10 = utf8.len(var_761_8)
				local var_761_11 = var_761_9 <= 0 and var_761_5 or var_761_5 * (var_761_10 / var_761_9)

				if var_761_11 > 0 and var_761_5 < var_761_11 then
					arg_758_1.talkMaxDuration = var_761_11

					if var_761_11 + var_761_4 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_11 + var_761_4
					end
				end

				arg_758_1.text_.text = var_761_8
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb") ~= 0 then
					local var_761_12 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb") / 1000

					if var_761_12 + var_761_4 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_12 + var_761_4
					end

					if var_761_7.prefab_name ~= "" and arg_758_1.actors_[var_761_7.prefab_name] ~= nil then
						local var_761_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_758_1.actors_[var_761_7.prefab_name].transform, "story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")

						arg_758_1:RecordAudio("1109511187", var_761_13)
						arg_758_1:RecordAudio("1109511187", var_761_13)
					else
						arg_758_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")
					end

					arg_758_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")
				end

				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_14 = math.max(var_761_5, arg_758_1.talkMaxDuration)

			if var_761_4 <= arg_758_1.time_ and arg_758_1.time_ < var_761_4 + var_761_14 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - var_761_4) / var_761_14

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= var_761_4 + var_761_14 and arg_758_1.time_ < var_761_4 + var_761_14 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play1109511188 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1109511188
		arg_762_1.duration_ = 5

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1109511189(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			local var_765_0 = arg_762_1.actors_["10058ui_story"]
			local var_765_1 = 0

			if var_765_1 < arg_762_1.time_ and arg_762_1.time_ <= var_765_1 + arg_765_0 and not isNil(var_765_0) and arg_762_1.var_.characterEffect10058ui_story == nil then
				arg_762_1.var_.characterEffect10058ui_story = var_765_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_2 = 0.200000002980232

			if var_765_1 <= arg_762_1.time_ and arg_762_1.time_ < var_765_1 + var_765_2 and not isNil(var_765_0) then
				local var_765_3 = (arg_762_1.time_ - var_765_1) / var_765_2

				if arg_762_1.var_.characterEffect10058ui_story and not isNil(var_765_0) then
					local var_765_4 = Mathf.Lerp(0, 0.5, var_765_3)

					arg_762_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_762_1.var_.characterEffect10058ui_story.fillRatio = var_765_4
				end
			end

			if arg_762_1.time_ >= var_765_1 + var_765_2 and arg_762_1.time_ < var_765_1 + var_765_2 + arg_765_0 and not isNil(var_765_0) and arg_762_1.var_.characterEffect10058ui_story then
				local var_765_5 = 0.5

				arg_762_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_762_1.var_.characterEffect10058ui_story.fillRatio = var_765_5
			end

			local var_765_6 = arg_762_1.actors_["10058ui_story"].transform
			local var_765_7 = 0

			if var_765_7 < arg_762_1.time_ and arg_762_1.time_ <= var_765_7 + arg_765_0 then
				arg_762_1.var_.moveOldPos10058ui_story = var_765_6.localPosition
			end

			local var_765_8 = 0.001

			if var_765_7 <= arg_762_1.time_ and arg_762_1.time_ < var_765_7 + var_765_8 then
				local var_765_9 = (arg_762_1.time_ - var_765_7) / var_765_8
				local var_765_10 = Vector3.New(0, 100, 0)

				var_765_6.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos10058ui_story, var_765_10, var_765_9)

				local var_765_11 = manager.ui.mainCamera.transform.position - var_765_6.position

				var_765_6.forward = Vector3.New(var_765_11.x, var_765_11.y, var_765_11.z)

				local var_765_12 = var_765_6.localEulerAngles

				var_765_12.z = 0
				var_765_12.x = 0
				var_765_6.localEulerAngles = var_765_12
			end

			if arg_762_1.time_ >= var_765_7 + var_765_8 and arg_762_1.time_ < var_765_7 + var_765_8 + arg_765_0 then
				var_765_6.localPosition = Vector3.New(0, 100, 0)

				local var_765_13 = manager.ui.mainCamera.transform.position - var_765_6.position

				var_765_6.forward = Vector3.New(var_765_13.x, var_765_13.y, var_765_13.z)

				local var_765_14 = var_765_6.localEulerAngles

				var_765_14.z = 0
				var_765_14.x = 0
				var_765_6.localEulerAngles = var_765_14
			end

			local var_765_15 = 0.5
			local var_765_16 = 1

			if var_765_15 < arg_762_1.time_ and arg_762_1.time_ <= var_765_15 + arg_765_0 then
				local var_765_17 = "play"
				local var_765_18 = "effect"

				arg_762_1:AudioAction(var_765_17, var_765_18, "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_765_19 = 0
			local var_765_20 = 1.025

			if var_765_19 < arg_762_1.time_ and arg_762_1.time_ <= var_765_19 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, false)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_762_1.iconTrs_.gameObject, false)
				arg_762_1.callingController_:SetSelectedState("normal")

				local var_765_21 = arg_762_1:GetWordFromCfg(1109511188)
				local var_765_22 = arg_762_1:FormatText(var_765_21.content)

				arg_762_1.text_.text = var_765_22

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_23 = 41
				local var_765_24 = utf8.len(var_765_22)
				local var_765_25 = var_765_23 <= 0 and var_765_20 or var_765_20 * (var_765_24 / var_765_23)

				if var_765_25 > 0 and var_765_20 < var_765_25 then
					arg_762_1.talkMaxDuration = var_765_25

					if var_765_25 + var_765_19 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_25 + var_765_19
					end
				end

				arg_762_1.text_.text = var_765_22
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)
				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_26 = math.max(var_765_20, arg_762_1.talkMaxDuration)

			if var_765_19 <= arg_762_1.time_ and arg_762_1.time_ < var_765_19 + var_765_26 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_19) / var_765_26

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_19 + var_765_26 and arg_762_1.time_ < var_765_19 + var_765_26 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_762_1:InitPlayNodeList()
	end,
	Play1109511189 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 1109511189
		arg_766_1.duration_ = 5

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play1109511190(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			local var_769_0 = 0
			local var_769_1 = 0.05

			if var_769_0 < arg_766_1.time_ and arg_766_1.time_ <= var_769_0 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				local var_769_2 = arg_766_1:FormatText(StoryNameCfg[7].name)

				arg_766_1.leftNameTxt_.text = var_769_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, true)
				arg_766_1.iconController_:SetSelectedState("hero")

				arg_766_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_766_1.callingController_:SetSelectedState("normal")

				arg_766_1.keyicon_.color = Color.New(1, 1, 1)
				arg_766_1.icon_.color = Color.New(1, 1, 1)

				local var_769_3 = arg_766_1:GetWordFromCfg(1109511189)
				local var_769_4 = arg_766_1:FormatText(var_769_3.content)

				arg_766_1.text_.text = var_769_4

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_5 = 2
				local var_769_6 = utf8.len(var_769_4)
				local var_769_7 = var_769_5 <= 0 and var_769_1 or var_769_1 * (var_769_6 / var_769_5)

				if var_769_7 > 0 and var_769_1 < var_769_7 then
					arg_766_1.talkMaxDuration = var_769_7

					if var_769_7 + var_769_0 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_7 + var_769_0
					end
				end

				arg_766_1.text_.text = var_769_4
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)
				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_8 = math.max(var_769_1, arg_766_1.talkMaxDuration)

			if var_769_0 <= arg_766_1.time_ and arg_766_1.time_ < var_769_0 + var_769_8 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - var_769_0) / var_769_8

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= var_769_0 + var_769_8 and arg_766_1.time_ < var_769_0 + var_769_8 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play1109511190 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 1109511190
		arg_770_1.duration_ = 8.32

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play1109511191(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			local var_773_0 = 1.58333333333333

			if var_773_0 < arg_770_1.time_ and arg_770_1.time_ <= var_773_0 + arg_773_0 then
				local var_773_1 = manager.ui.mainCamera.transform.localPosition
				local var_773_2 = Vector3.New(0, 0, 10) + Vector3.New(var_773_1.x, var_773_1.y, 0)
				local var_773_3 = arg_770_1.bgs_.ST0104

				var_773_3.transform.localPosition = var_773_2
				var_773_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_773_4 = var_773_3:GetComponent("SpriteRenderer")

				if var_773_4 and var_773_4.sprite then
					local var_773_5 = (var_773_3.transform.localPosition - var_773_1).z
					local var_773_6 = manager.ui.mainCameraCom_
					local var_773_7 = 2 * var_773_5 * Mathf.Tan(var_773_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_773_8 = var_773_7 * var_773_6.aspect
					local var_773_9 = var_773_4.sprite.bounds.size.x
					local var_773_10 = var_773_4.sprite.bounds.size.y
					local var_773_11 = var_773_8 / var_773_9
					local var_773_12 = var_773_7 / var_773_10
					local var_773_13 = var_773_12 < var_773_11 and var_773_11 or var_773_12

					var_773_3.transform.localScale = Vector3.New(var_773_13, var_773_13, 0)
				end

				for iter_773_0, iter_773_1 in pairs(arg_770_1.bgs_) do
					if iter_773_0 ~= "ST0104" then
						iter_773_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_773_14 = 1.58333333333333

			if var_773_14 < arg_770_1.time_ and arg_770_1.time_ <= var_773_14 + arg_773_0 then
				arg_770_1.allBtn_.enabled = false
			end

			local var_773_15 = 0.3

			if arg_770_1.time_ >= var_773_14 + var_773_15 and arg_770_1.time_ < var_773_14 + var_773_15 + arg_773_0 then
				arg_770_1.allBtn_.enabled = true
			end

			local var_773_16 = 0

			if var_773_16 < arg_770_1.time_ and arg_770_1.time_ <= var_773_16 + arg_773_0 then
				arg_770_1.mask_.enabled = true
				arg_770_1.mask_.raycastTarget = true

				arg_770_1:SetGaussion(false)
			end

			local var_773_17 = 1.583333333332

			if var_773_16 <= arg_770_1.time_ and arg_770_1.time_ < var_773_16 + var_773_17 then
				local var_773_18 = (arg_770_1.time_ - var_773_16) / var_773_17
				local var_773_19 = Color.New(0, 0, 0)

				var_773_19.a = Mathf.Lerp(0, 1, var_773_18)
				arg_770_1.mask_.color = var_773_19
			end

			if arg_770_1.time_ >= var_773_16 + var_773_17 and arg_770_1.time_ < var_773_16 + var_773_17 + arg_773_0 then
				local var_773_20 = Color.New(0, 0, 0)

				var_773_20.a = 1
				arg_770_1.mask_.color = var_773_20
			end

			local var_773_21 = 1.583333333332

			if var_773_21 < arg_770_1.time_ and arg_770_1.time_ <= var_773_21 + arg_773_0 then
				arg_770_1.mask_.enabled = true
				arg_770_1.mask_.raycastTarget = true

				arg_770_1:SetGaussion(false)
			end

			local var_773_22 = 2

			if var_773_21 <= arg_770_1.time_ and arg_770_1.time_ < var_773_21 + var_773_22 then
				local var_773_23 = (arg_770_1.time_ - var_773_21) / var_773_22
				local var_773_24 = Color.New(0, 0, 0)

				var_773_24.a = Mathf.Lerp(1, 0, var_773_23)
				arg_770_1.mask_.color = var_773_24
			end

			if arg_770_1.time_ >= var_773_21 + var_773_22 and arg_770_1.time_ < var_773_21 + var_773_22 + arg_773_0 then
				local var_773_25 = Color.New(0, 0, 0)
				local var_773_26 = 0

				arg_770_1.mask_.enabled = false
				var_773_25.a = var_773_26
				arg_770_1.mask_.color = var_773_25
			end

			local var_773_27 = arg_770_1.actors_["10058ui_story"].transform
			local var_773_28 = 1.58333333333333

			if var_773_28 < arg_770_1.time_ and arg_770_1.time_ <= var_773_28 + arg_773_0 then
				arg_770_1.var_.moveOldPos10058ui_story = var_773_27.localPosition
			end

			local var_773_29 = 0.001

			if var_773_28 <= arg_770_1.time_ and arg_770_1.time_ < var_773_28 + var_773_29 then
				local var_773_30 = (arg_770_1.time_ - var_773_28) / var_773_29
				local var_773_31 = Vector3.New(0, 100, 0)

				var_773_27.localPosition = Vector3.Lerp(arg_770_1.var_.moveOldPos10058ui_story, var_773_31, var_773_30)

				local var_773_32 = manager.ui.mainCamera.transform.position - var_773_27.position

				var_773_27.forward = Vector3.New(var_773_32.x, var_773_32.y, var_773_32.z)

				local var_773_33 = var_773_27.localEulerAngles

				var_773_33.z = 0
				var_773_33.x = 0
				var_773_27.localEulerAngles = var_773_33
			end

			if arg_770_1.time_ >= var_773_28 + var_773_29 and arg_770_1.time_ < var_773_28 + var_773_29 + arg_773_0 then
				var_773_27.localPosition = Vector3.New(0, 100, 0)

				local var_773_34 = manager.ui.mainCamera.transform.position - var_773_27.position

				var_773_27.forward = Vector3.New(var_773_34.x, var_773_34.y, var_773_34.z)

				local var_773_35 = var_773_27.localEulerAngles

				var_773_35.z = 0
				var_773_35.x = 0
				var_773_27.localEulerAngles = var_773_35
			end

			local var_773_36 = 1
			local var_773_37 = 1

			if var_773_36 < arg_770_1.time_ and arg_770_1.time_ <= var_773_36 + arg_773_0 then
				local var_773_38 = "play"
				local var_773_39 = "effect"

				arg_770_1:AudioAction(var_773_38, var_773_39, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_773_40 = 0.2
			local var_773_41 = 1

			if var_773_40 < arg_770_1.time_ and arg_770_1.time_ <= var_773_40 + arg_773_0 then
				local var_773_42 = "stop"
				local var_773_43 = "effect"

				arg_770_1:AudioAction(var_773_42, var_773_43, "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_770_1.frameCnt_ <= 1 then
				arg_770_1.dialog_:SetActive(false)
			end

			local var_773_44 = 3.31666666666667
			local var_773_45 = 0.125

			if var_773_44 < arg_770_1.time_ and arg_770_1.time_ <= var_773_44 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0

				arg_770_1.dialog_:SetActive(true)

				arg_770_1.dialogCg_.alpha = 0

				local var_773_46 = LeanTween.value(arg_770_1.dialog_, 0, 1, 0.3)

				var_773_46:setOnUpdate(LuaHelper.FloatAction(function(arg_774_0)
					arg_770_1.dialogCg_.alpha = arg_774_0
				end))
				var_773_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_770_1.dialog_)
					var_773_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_770_1.duration_ = arg_770_1.duration_ + 0.3

				SetActive(arg_770_1.leftNameGo_, true)

				local var_773_47 = arg_770_1:FormatText(StoryNameCfg[7].name)

				arg_770_1.leftNameTxt_.text = var_773_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, true)
				arg_770_1.iconController_:SetSelectedState("hero")

				arg_770_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_770_1.callingController_:SetSelectedState("normal")

				arg_770_1.keyicon_.color = Color.New(1, 1, 1)
				arg_770_1.icon_.color = Color.New(1, 1, 1)

				local var_773_48 = arg_770_1:GetWordFromCfg(1109511190)
				local var_773_49 = arg_770_1:FormatText(var_773_48.content)

				arg_770_1.text_.text = var_773_49

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_50 = 5
				local var_773_51 = utf8.len(var_773_49)
				local var_773_52 = var_773_50 <= 0 and var_773_45 or var_773_45 * (var_773_51 / var_773_50)

				if var_773_52 > 0 and var_773_45 < var_773_52 then
					arg_770_1.talkMaxDuration = var_773_52
					var_773_44 = var_773_44 + 0.3

					if var_773_52 + var_773_44 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_52 + var_773_44
					end
				end

				arg_770_1.text_.text = var_773_49
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)
				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_53 = var_773_44 + 0.3
			local var_773_54 = math.max(var_773_45, arg_770_1.talkMaxDuration)

			if var_773_53 <= arg_770_1.time_ and arg_770_1.time_ < var_773_53 + var_773_54 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - var_773_53) / var_773_54

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= var_773_53 + var_773_54 and arg_770_1.time_ < var_773_53 + var_773_54 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.58333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_770_1:InitPlayNodeList()
	end,
	Play1109511191 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1109511191
		arg_776_1.duration_ = 5

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1109511192(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			local var_779_0 = 0
			local var_779_1 = 0.55

			if var_779_0 < arg_776_1.time_ and arg_776_1.time_ <= var_779_0 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0
				arg_776_1.dialogCg_.alpha = 1

				arg_776_1.dialog_:SetActive(true)
				SetActive(arg_776_1.leftNameGo_, false)

				arg_776_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_776_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_776_1:RecordName(arg_776_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_776_1.iconTrs_.gameObject, false)
				arg_776_1.callingController_:SetSelectedState("normal")

				local var_779_2 = arg_776_1:GetWordFromCfg(1109511191)
				local var_779_3 = arg_776_1:FormatText(var_779_2.content)

				arg_776_1.text_.text = var_779_3

				LuaForUtil.ClearLinePrefixSymbol(arg_776_1.text_)

				local var_779_4 = 22
				local var_779_5 = utf8.len(var_779_3)
				local var_779_6 = var_779_4 <= 0 and var_779_1 or var_779_1 * (var_779_5 / var_779_4)

				if var_779_6 > 0 and var_779_1 < var_779_6 then
					arg_776_1.talkMaxDuration = var_779_6

					if var_779_6 + var_779_0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_6 + var_779_0
					end
				end

				arg_776_1.text_.text = var_779_3
				arg_776_1.typewritter.percent = 0

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(false)
				arg_776_1:RecordContent(arg_776_1.text_.text)
			end

			local var_779_7 = math.max(var_779_1, arg_776_1.talkMaxDuration)

			if var_779_0 <= arg_776_1.time_ and arg_776_1.time_ < var_779_0 + var_779_7 then
				arg_776_1.typewritter.percent = (arg_776_1.time_ - var_779_0) / var_779_7

				arg_776_1.typewritter:SetDirty()
			end

			if arg_776_1.time_ >= var_779_0 + var_779_7 and arg_776_1.time_ < var_779_0 + var_779_7 + arg_779_0 then
				arg_776_1.typewritter.percent = 1

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(true)
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1109511192 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1109511192
		arg_780_1.duration_ = 7.23

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1109511193(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			local var_783_0 = arg_780_1.actors_["10058ui_story"].transform
			local var_783_1 = 0

			if var_783_1 < arg_780_1.time_ and arg_780_1.time_ <= var_783_1 + arg_783_0 then
				arg_780_1.var_.moveOldPos10058ui_story = var_783_0.localPosition
			end

			local var_783_2 = 0.001

			if var_783_1 <= arg_780_1.time_ and arg_780_1.time_ < var_783_1 + var_783_2 then
				local var_783_3 = (arg_780_1.time_ - var_783_1) / var_783_2
				local var_783_4 = Vector3.New(0, -0.98, -6.1)

				var_783_0.localPosition = Vector3.Lerp(arg_780_1.var_.moveOldPos10058ui_story, var_783_4, var_783_3)

				local var_783_5 = manager.ui.mainCamera.transform.position - var_783_0.position

				var_783_0.forward = Vector3.New(var_783_5.x, var_783_5.y, var_783_5.z)

				local var_783_6 = var_783_0.localEulerAngles

				var_783_6.z = 0
				var_783_6.x = 0
				var_783_0.localEulerAngles = var_783_6
			end

			if arg_780_1.time_ >= var_783_1 + var_783_2 and arg_780_1.time_ < var_783_1 + var_783_2 + arg_783_0 then
				var_783_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_783_7 = manager.ui.mainCamera.transform.position - var_783_0.position

				var_783_0.forward = Vector3.New(var_783_7.x, var_783_7.y, var_783_7.z)

				local var_783_8 = var_783_0.localEulerAngles

				var_783_8.z = 0
				var_783_8.x = 0
				var_783_0.localEulerAngles = var_783_8
			end

			local var_783_9 = arg_780_1.actors_["10058ui_story"]
			local var_783_10 = 0

			if var_783_10 < arg_780_1.time_ and arg_780_1.time_ <= var_783_10 + arg_783_0 and not isNil(var_783_9) and arg_780_1.var_.characterEffect10058ui_story == nil then
				arg_780_1.var_.characterEffect10058ui_story = var_783_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_783_11 = 0.200000002980232

			if var_783_10 <= arg_780_1.time_ and arg_780_1.time_ < var_783_10 + var_783_11 and not isNil(var_783_9) then
				local var_783_12 = (arg_780_1.time_ - var_783_10) / var_783_11

				if arg_780_1.var_.characterEffect10058ui_story and not isNil(var_783_9) then
					arg_780_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_780_1.time_ >= var_783_10 + var_783_11 and arg_780_1.time_ < var_783_10 + var_783_11 + arg_783_0 and not isNil(var_783_9) and arg_780_1.var_.characterEffect10058ui_story then
				arg_780_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_783_13 = 0

			if var_783_13 < arg_780_1.time_ and arg_780_1.time_ <= var_783_13 + arg_783_0 then
				arg_780_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_783_14 = 0

			if var_783_14 < arg_780_1.time_ and arg_780_1.time_ <= var_783_14 + arg_783_0 then
				arg_780_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_783_15 = 0
			local var_783_16 = 0.65

			if var_783_15 < arg_780_1.time_ and arg_780_1.time_ <= var_783_15 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0
				arg_780_1.dialogCg_.alpha = 1

				arg_780_1.dialog_:SetActive(true)
				SetActive(arg_780_1.leftNameGo_, true)

				local var_783_17 = arg_780_1:FormatText(StoryNameCfg[471].name)

				arg_780_1.leftNameTxt_.text = var_783_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_780_1.leftNameTxt_.transform)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1.leftNameTxt_.text)
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_18 = arg_780_1:GetWordFromCfg(1109511192)
				local var_783_19 = arg_780_1:FormatText(var_783_18.content)

				arg_780_1.text_.text = var_783_19

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_20 = 26
				local var_783_21 = utf8.len(var_783_19)
				local var_783_22 = var_783_20 <= 0 and var_783_16 or var_783_16 * (var_783_21 / var_783_20)

				if var_783_22 > 0 and var_783_16 < var_783_22 then
					arg_780_1.talkMaxDuration = var_783_22

					if var_783_22 + var_783_15 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_22 + var_783_15
					end
				end

				arg_780_1.text_.text = var_783_19
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb") ~= 0 then
					local var_783_23 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb") / 1000

					if var_783_23 + var_783_15 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_23 + var_783_15
					end

					if var_783_18.prefab_name ~= "" and arg_780_1.actors_[var_783_18.prefab_name] ~= nil then
						local var_783_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_780_1.actors_[var_783_18.prefab_name].transform, "story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")

						arg_780_1:RecordAudio("1109511192", var_783_24)
						arg_780_1:RecordAudio("1109511192", var_783_24)
					else
						arg_780_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")
					end

					arg_780_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")
				end

				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_25 = math.max(var_783_16, arg_780_1.talkMaxDuration)

			if var_783_15 <= arg_780_1.time_ and arg_780_1.time_ < var_783_15 + var_783_25 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_15) / var_783_25

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_15 + var_783_25 and arg_780_1.time_ < var_783_15 + var_783_25 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_780_1:InitPlayNodeList()
	end,
	Play1109511193 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1109511193
		arg_784_1.duration_ = 5

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1109511194(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			local var_787_0 = arg_784_1.actors_["10058ui_story"]
			local var_787_1 = 0

			if var_787_1 < arg_784_1.time_ and arg_784_1.time_ <= var_787_1 + arg_787_0 and not isNil(var_787_0) and arg_784_1.var_.characterEffect10058ui_story == nil then
				arg_784_1.var_.characterEffect10058ui_story = var_787_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_787_2 = 0.200000002980232

			if var_787_1 <= arg_784_1.time_ and arg_784_1.time_ < var_787_1 + var_787_2 and not isNil(var_787_0) then
				local var_787_3 = (arg_784_1.time_ - var_787_1) / var_787_2

				if arg_784_1.var_.characterEffect10058ui_story and not isNil(var_787_0) then
					local var_787_4 = Mathf.Lerp(0, 0.5, var_787_3)

					arg_784_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_784_1.var_.characterEffect10058ui_story.fillRatio = var_787_4
				end
			end

			if arg_784_1.time_ >= var_787_1 + var_787_2 and arg_784_1.time_ < var_787_1 + var_787_2 + arg_787_0 and not isNil(var_787_0) and arg_784_1.var_.characterEffect10058ui_story then
				local var_787_5 = 0.5

				arg_784_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_784_1.var_.characterEffect10058ui_story.fillRatio = var_787_5
			end

			local var_787_6 = 0
			local var_787_7 = 1

			if var_787_6 < arg_784_1.time_ and arg_784_1.time_ <= var_787_6 + arg_787_0 then
				local var_787_8 = "play"
				local var_787_9 = "effect"

				arg_784_1:AudioAction(var_787_8, var_787_9, "se_story_152", "se_story_152_keyboard", "")
			end

			local var_787_10 = 0
			local var_787_11 = 0.45

			if var_787_10 < arg_784_1.time_ and arg_784_1.time_ <= var_787_10 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0
				arg_784_1.dialogCg_.alpha = 1

				arg_784_1.dialog_:SetActive(true)
				SetActive(arg_784_1.leftNameGo_, false)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_12 = arg_784_1:GetWordFromCfg(1109511193)
				local var_787_13 = arg_784_1:FormatText(var_787_12.content)

				arg_784_1.text_.text = var_787_13

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_14 = 18
				local var_787_15 = utf8.len(var_787_13)
				local var_787_16 = var_787_14 <= 0 and var_787_11 or var_787_11 * (var_787_15 / var_787_14)

				if var_787_16 > 0 and var_787_11 < var_787_16 then
					arg_784_1.talkMaxDuration = var_787_16

					if var_787_16 + var_787_10 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_16 + var_787_10
					end
				end

				arg_784_1.text_.text = var_787_13
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)
				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_17 = math.max(var_787_11, arg_784_1.talkMaxDuration)

			if var_787_10 <= arg_784_1.time_ and arg_784_1.time_ < var_787_10 + var_787_17 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_10) / var_787_17

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_10 + var_787_17 and arg_784_1.time_ < var_787_10 + var_787_17 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	Play1109511194 = function(arg_788_0, arg_788_1)
		arg_788_1.time_ = 0
		arg_788_1.frameCnt_ = 0
		arg_788_1.state_ = "playing"
		arg_788_1.curTalkId_ = 1109511194
		arg_788_1.duration_ = 5

		SetActive(arg_788_1.tipsGo_, false)

		function arg_788_1.onSingleLineFinish_()
			arg_788_1.onSingleLineUpdate_ = nil
			arg_788_1.onSingleLineFinish_ = nil
			arg_788_1.state_ = "waiting"
		end

		function arg_788_1.playNext_(arg_790_0)
			if arg_790_0 == 1 then
				arg_788_0:Play1109511195(arg_788_1)
			end
		end

		function arg_788_1.onSingleLineUpdate_(arg_791_0)
			local var_791_0 = 0
			local var_791_1 = 0.175

			if var_791_0 < arg_788_1.time_ and arg_788_1.time_ <= var_791_0 + arg_791_0 then
				arg_788_1.talkMaxDuration = 0
				arg_788_1.dialogCg_.alpha = 1

				arg_788_1.dialog_:SetActive(true)
				SetActive(arg_788_1.leftNameGo_, true)

				local var_791_2 = arg_788_1:FormatText(StoryNameCfg[7].name)

				arg_788_1.leftNameTxt_.text = var_791_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_788_1.leftNameTxt_.transform)

				arg_788_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_788_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_788_1:RecordName(arg_788_1.leftNameTxt_.text)
				SetActive(arg_788_1.iconTrs_.gameObject, true)
				arg_788_1.iconController_:SetSelectedState("hero")

				arg_788_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_788_1.callingController_:SetSelectedState("normal")

				arg_788_1.keyicon_.color = Color.New(1, 1, 1)
				arg_788_1.icon_.color = Color.New(1, 1, 1)

				local var_791_3 = arg_788_1:GetWordFromCfg(1109511194)
				local var_791_4 = arg_788_1:FormatText(var_791_3.content)

				arg_788_1.text_.text = var_791_4

				LuaForUtil.ClearLinePrefixSymbol(arg_788_1.text_)

				local var_791_5 = 7
				local var_791_6 = utf8.len(var_791_4)
				local var_791_7 = var_791_5 <= 0 and var_791_1 or var_791_1 * (var_791_6 / var_791_5)

				if var_791_7 > 0 and var_791_1 < var_791_7 then
					arg_788_1.talkMaxDuration = var_791_7

					if var_791_7 + var_791_0 > arg_788_1.duration_ then
						arg_788_1.duration_ = var_791_7 + var_791_0
					end
				end

				arg_788_1.text_.text = var_791_4
				arg_788_1.typewritter.percent = 0

				arg_788_1.typewritter:SetDirty()
				arg_788_1:ShowNextGo(false)
				arg_788_1:RecordContent(arg_788_1.text_.text)
			end

			local var_791_8 = math.max(var_791_1, arg_788_1.talkMaxDuration)

			if var_791_0 <= arg_788_1.time_ and arg_788_1.time_ < var_791_0 + var_791_8 then
				arg_788_1.typewritter.percent = (arg_788_1.time_ - var_791_0) / var_791_8

				arg_788_1.typewritter:SetDirty()
			end

			if arg_788_1.time_ >= var_791_0 + var_791_8 and arg_788_1.time_ < var_791_0 + var_791_8 + arg_791_0 then
				arg_788_1.typewritter.percent = 1

				arg_788_1.typewritter:SetDirty()
				arg_788_1:ShowNextGo(true)
			end
		end

		arg_788_1.nodeConfigList_ = {}

		arg_788_1:InitPlayNodeList()
	end,
	Play1109511195 = function(arg_792_0, arg_792_1)
		arg_792_1.time_ = 0
		arg_792_1.frameCnt_ = 0
		arg_792_1.state_ = "playing"
		arg_792_1.curTalkId_ = 1109511195
		arg_792_1.duration_ = 5.23

		SetActive(arg_792_1.tipsGo_, false)

		function arg_792_1.onSingleLineFinish_()
			arg_792_1.onSingleLineUpdate_ = nil
			arg_792_1.onSingleLineFinish_ = nil
			arg_792_1.state_ = "waiting"
		end

		function arg_792_1.playNext_(arg_794_0)
			if arg_794_0 == 1 then
				arg_792_0:Play1109511196(arg_792_1)
			end
		end

		function arg_792_1.onSingleLineUpdate_(arg_795_0)
			local var_795_0 = arg_792_1.actors_["10058ui_story"]
			local var_795_1 = 0

			if var_795_1 < arg_792_1.time_ and arg_792_1.time_ <= var_795_1 + arg_795_0 and not isNil(var_795_0) and arg_792_1.var_.characterEffect10058ui_story == nil then
				arg_792_1.var_.characterEffect10058ui_story = var_795_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_795_2 = 0.200000002980232

			if var_795_1 <= arg_792_1.time_ and arg_792_1.time_ < var_795_1 + var_795_2 and not isNil(var_795_0) then
				local var_795_3 = (arg_792_1.time_ - var_795_1) / var_795_2

				if arg_792_1.var_.characterEffect10058ui_story and not isNil(var_795_0) then
					arg_792_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_792_1.time_ >= var_795_1 + var_795_2 and arg_792_1.time_ < var_795_1 + var_795_2 + arg_795_0 and not isNil(var_795_0) and arg_792_1.var_.characterEffect10058ui_story then
				arg_792_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_795_4 = 0

			if var_795_4 < arg_792_1.time_ and arg_792_1.time_ <= var_795_4 + arg_795_0 then
				arg_792_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_795_5 = 0

			if var_795_5 < arg_792_1.time_ and arg_792_1.time_ <= var_795_5 + arg_795_0 then
				arg_792_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_795_6 = 0
			local var_795_7 = 0.525

			if var_795_6 < arg_792_1.time_ and arg_792_1.time_ <= var_795_6 + arg_795_0 then
				arg_792_1.talkMaxDuration = 0
				arg_792_1.dialogCg_.alpha = 1

				arg_792_1.dialog_:SetActive(true)
				SetActive(arg_792_1.leftNameGo_, true)

				local var_795_8 = arg_792_1:FormatText(StoryNameCfg[471].name)

				arg_792_1.leftNameTxt_.text = var_795_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_792_1.leftNameTxt_.transform)

				arg_792_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_792_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_792_1:RecordName(arg_792_1.leftNameTxt_.text)
				SetActive(arg_792_1.iconTrs_.gameObject, false)
				arg_792_1.callingController_:SetSelectedState("normal")

				local var_795_9 = arg_792_1:GetWordFromCfg(1109511195)
				local var_795_10 = arg_792_1:FormatText(var_795_9.content)

				arg_792_1.text_.text = var_795_10

				LuaForUtil.ClearLinePrefixSymbol(arg_792_1.text_)

				local var_795_11 = 21
				local var_795_12 = utf8.len(var_795_10)
				local var_795_13 = var_795_11 <= 0 and var_795_7 or var_795_7 * (var_795_12 / var_795_11)

				if var_795_13 > 0 and var_795_7 < var_795_13 then
					arg_792_1.talkMaxDuration = var_795_13

					if var_795_13 + var_795_6 > arg_792_1.duration_ then
						arg_792_1.duration_ = var_795_13 + var_795_6
					end
				end

				arg_792_1.text_.text = var_795_10
				arg_792_1.typewritter.percent = 0

				arg_792_1.typewritter:SetDirty()
				arg_792_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb") ~= 0 then
					local var_795_14 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb") / 1000

					if var_795_14 + var_795_6 > arg_792_1.duration_ then
						arg_792_1.duration_ = var_795_14 + var_795_6
					end

					if var_795_9.prefab_name ~= "" and arg_792_1.actors_[var_795_9.prefab_name] ~= nil then
						local var_795_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_792_1.actors_[var_795_9.prefab_name].transform, "story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")

						arg_792_1:RecordAudio("1109511195", var_795_15)
						arg_792_1:RecordAudio("1109511195", var_795_15)
					else
						arg_792_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")
					end

					arg_792_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")
				end

				arg_792_1:RecordContent(arg_792_1.text_.text)
			end

			local var_795_16 = math.max(var_795_7, arg_792_1.talkMaxDuration)

			if var_795_6 <= arg_792_1.time_ and arg_792_1.time_ < var_795_6 + var_795_16 then
				arg_792_1.typewritter.percent = (arg_792_1.time_ - var_795_6) / var_795_16

				arg_792_1.typewritter:SetDirty()
			end

			if arg_792_1.time_ >= var_795_6 + var_795_16 and arg_792_1.time_ < var_795_6 + var_795_16 + arg_795_0 then
				arg_792_1.typewritter.percent = 1

				arg_792_1.typewritter:SetDirty()
				arg_792_1:ShowNextGo(true)
			end
		end

		arg_792_1.nodeConfigList_ = {}

		arg_792_1:InitPlayNodeList()
	end,
	Play1109511196 = function(arg_796_0, arg_796_1)
		arg_796_1.time_ = 0
		arg_796_1.frameCnt_ = 0
		arg_796_1.state_ = "playing"
		arg_796_1.curTalkId_ = 1109511196
		arg_796_1.duration_ = 5.27

		SetActive(arg_796_1.tipsGo_, false)

		function arg_796_1.onSingleLineFinish_()
			arg_796_1.onSingleLineUpdate_ = nil
			arg_796_1.onSingleLineFinish_ = nil
			arg_796_1.state_ = "waiting"
		end

		function arg_796_1.playNext_(arg_798_0)
			if arg_798_0 == 1 then
				arg_796_0:Play1109511197(arg_796_1)
			end
		end

		function arg_796_1.onSingleLineUpdate_(arg_799_0)
			local var_799_0 = 0
			local var_799_1 = 0.6

			if var_799_0 < arg_796_1.time_ and arg_796_1.time_ <= var_799_0 + arg_799_0 then
				arg_796_1.talkMaxDuration = 0
				arg_796_1.dialogCg_.alpha = 1

				arg_796_1.dialog_:SetActive(true)
				SetActive(arg_796_1.leftNameGo_, true)

				local var_799_2 = arg_796_1:FormatText(StoryNameCfg[471].name)

				arg_796_1.leftNameTxt_.text = var_799_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_796_1.leftNameTxt_.transform)

				arg_796_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_796_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_796_1:RecordName(arg_796_1.leftNameTxt_.text)
				SetActive(arg_796_1.iconTrs_.gameObject, false)
				arg_796_1.callingController_:SetSelectedState("normal")

				local var_799_3 = arg_796_1:GetWordFromCfg(1109511196)
				local var_799_4 = arg_796_1:FormatText(var_799_3.content)

				arg_796_1.text_.text = var_799_4

				LuaForUtil.ClearLinePrefixSymbol(arg_796_1.text_)

				local var_799_5 = 24
				local var_799_6 = utf8.len(var_799_4)
				local var_799_7 = var_799_5 <= 0 and var_799_1 or var_799_1 * (var_799_6 / var_799_5)

				if var_799_7 > 0 and var_799_1 < var_799_7 then
					arg_796_1.talkMaxDuration = var_799_7

					if var_799_7 + var_799_0 > arg_796_1.duration_ then
						arg_796_1.duration_ = var_799_7 + var_799_0
					end
				end

				arg_796_1.text_.text = var_799_4
				arg_796_1.typewritter.percent = 0

				arg_796_1.typewritter:SetDirty()
				arg_796_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb") ~= 0 then
					local var_799_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb") / 1000

					if var_799_8 + var_799_0 > arg_796_1.duration_ then
						arg_796_1.duration_ = var_799_8 + var_799_0
					end

					if var_799_3.prefab_name ~= "" and arg_796_1.actors_[var_799_3.prefab_name] ~= nil then
						local var_799_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_796_1.actors_[var_799_3.prefab_name].transform, "story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")

						arg_796_1:RecordAudio("1109511196", var_799_9)
						arg_796_1:RecordAudio("1109511196", var_799_9)
					else
						arg_796_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")
					end

					arg_796_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")
				end

				arg_796_1:RecordContent(arg_796_1.text_.text)
			end

			local var_799_10 = math.max(var_799_1, arg_796_1.talkMaxDuration)

			if var_799_0 <= arg_796_1.time_ and arg_796_1.time_ < var_799_0 + var_799_10 then
				arg_796_1.typewritter.percent = (arg_796_1.time_ - var_799_0) / var_799_10

				arg_796_1.typewritter:SetDirty()
			end

			if arg_796_1.time_ >= var_799_0 + var_799_10 and arg_796_1.time_ < var_799_0 + var_799_10 + arg_799_0 then
				arg_796_1.typewritter.percent = 1

				arg_796_1.typewritter:SetDirty()
				arg_796_1:ShowNextGo(true)
			end
		end

		arg_796_1.nodeConfigList_ = {}

		arg_796_1:InitPlayNodeList()
	end,
	Play1109511197 = function(arg_800_0, arg_800_1)
		arg_800_1.time_ = 0
		arg_800_1.frameCnt_ = 0
		arg_800_1.state_ = "playing"
		arg_800_1.curTalkId_ = 1109511197
		arg_800_1.duration_ = 5

		SetActive(arg_800_1.tipsGo_, false)

		function arg_800_1.onSingleLineFinish_()
			arg_800_1.onSingleLineUpdate_ = nil
			arg_800_1.onSingleLineFinish_ = nil
			arg_800_1.state_ = "waiting"
		end

		function arg_800_1.playNext_(arg_802_0)
			if arg_802_0 == 1 then
				arg_800_0:Play1109511198(arg_800_1)
			end
		end

		function arg_800_1.onSingleLineUpdate_(arg_803_0)
			local var_803_0 = arg_800_1.actors_["10058ui_story"]
			local var_803_1 = 0

			if var_803_1 < arg_800_1.time_ and arg_800_1.time_ <= var_803_1 + arg_803_0 and not isNil(var_803_0) and arg_800_1.var_.characterEffect10058ui_story == nil then
				arg_800_1.var_.characterEffect10058ui_story = var_803_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_803_2 = 0.200000002980232

			if var_803_1 <= arg_800_1.time_ and arg_800_1.time_ < var_803_1 + var_803_2 and not isNil(var_803_0) then
				local var_803_3 = (arg_800_1.time_ - var_803_1) / var_803_2

				if arg_800_1.var_.characterEffect10058ui_story and not isNil(var_803_0) then
					local var_803_4 = Mathf.Lerp(0, 0.5, var_803_3)

					arg_800_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_800_1.var_.characterEffect10058ui_story.fillRatio = var_803_4
				end
			end

			if arg_800_1.time_ >= var_803_1 + var_803_2 and arg_800_1.time_ < var_803_1 + var_803_2 + arg_803_0 and not isNil(var_803_0) and arg_800_1.var_.characterEffect10058ui_story then
				local var_803_5 = 0.5

				arg_800_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_800_1.var_.characterEffect10058ui_story.fillRatio = var_803_5
			end

			local var_803_6 = 0
			local var_803_7 = 0.7

			if var_803_6 < arg_800_1.time_ and arg_800_1.time_ <= var_803_6 + arg_803_0 then
				arg_800_1.talkMaxDuration = 0
				arg_800_1.dialogCg_.alpha = 1

				arg_800_1.dialog_:SetActive(true)
				SetActive(arg_800_1.leftNameGo_, true)

				local var_803_8 = arg_800_1:FormatText(StoryNameCfg[7].name)

				arg_800_1.leftNameTxt_.text = var_803_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_800_1.leftNameTxt_.transform)

				arg_800_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_800_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_800_1:RecordName(arg_800_1.leftNameTxt_.text)
				SetActive(arg_800_1.iconTrs_.gameObject, true)
				arg_800_1.iconController_:SetSelectedState("hero")

				arg_800_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_800_1.callingController_:SetSelectedState("normal")

				arg_800_1.keyicon_.color = Color.New(1, 1, 1)
				arg_800_1.icon_.color = Color.New(1, 1, 1)

				local var_803_9 = arg_800_1:GetWordFromCfg(1109511197)
				local var_803_10 = arg_800_1:FormatText(var_803_9.content)

				arg_800_1.text_.text = var_803_10

				LuaForUtil.ClearLinePrefixSymbol(arg_800_1.text_)

				local var_803_11 = 28
				local var_803_12 = utf8.len(var_803_10)
				local var_803_13 = var_803_11 <= 0 and var_803_7 or var_803_7 * (var_803_12 / var_803_11)

				if var_803_13 > 0 and var_803_7 < var_803_13 then
					arg_800_1.talkMaxDuration = var_803_13

					if var_803_13 + var_803_6 > arg_800_1.duration_ then
						arg_800_1.duration_ = var_803_13 + var_803_6
					end
				end

				arg_800_1.text_.text = var_803_10
				arg_800_1.typewritter.percent = 0

				arg_800_1.typewritter:SetDirty()
				arg_800_1:ShowNextGo(false)
				arg_800_1:RecordContent(arg_800_1.text_.text)
			end

			local var_803_14 = math.max(var_803_7, arg_800_1.talkMaxDuration)

			if var_803_6 <= arg_800_1.time_ and arg_800_1.time_ < var_803_6 + var_803_14 then
				arg_800_1.typewritter.percent = (arg_800_1.time_ - var_803_6) / var_803_14

				arg_800_1.typewritter:SetDirty()
			end

			if arg_800_1.time_ >= var_803_6 + var_803_14 and arg_800_1.time_ < var_803_6 + var_803_14 + arg_803_0 then
				arg_800_1.typewritter.percent = 1

				arg_800_1.typewritter:SetDirty()
				arg_800_1:ShowNextGo(true)
			end
		end

		arg_800_1.nodeConfigList_ = {}

		arg_800_1:InitPlayNodeList()
	end,
	Play1109511198 = function(arg_804_0, arg_804_1)
		arg_804_1.time_ = 0
		arg_804_1.frameCnt_ = 0
		arg_804_1.state_ = "playing"
		arg_804_1.curTalkId_ = 1109511198
		arg_804_1.duration_ = 5

		SetActive(arg_804_1.tipsGo_, false)

		function arg_804_1.onSingleLineFinish_()
			arg_804_1.onSingleLineUpdate_ = nil
			arg_804_1.onSingleLineFinish_ = nil
			arg_804_1.state_ = "waiting"
		end

		function arg_804_1.playNext_(arg_806_0)
			if arg_806_0 == 1 then
				arg_804_0:Play1109511199(arg_804_1)
			end
		end

		function arg_804_1.onSingleLineUpdate_(arg_807_0)
			local var_807_0 = arg_804_1.actors_["10058ui_story"].transform
			local var_807_1 = 0

			if var_807_1 < arg_804_1.time_ and arg_804_1.time_ <= var_807_1 + arg_807_0 then
				arg_804_1.var_.moveOldPos10058ui_story = var_807_0.localPosition
			end

			local var_807_2 = 0.001

			if var_807_1 <= arg_804_1.time_ and arg_804_1.time_ < var_807_1 + var_807_2 then
				local var_807_3 = (arg_804_1.time_ - var_807_1) / var_807_2
				local var_807_4 = Vector3.New(0, 100, 0)

				var_807_0.localPosition = Vector3.Lerp(arg_804_1.var_.moveOldPos10058ui_story, var_807_4, var_807_3)

				local var_807_5 = manager.ui.mainCamera.transform.position - var_807_0.position

				var_807_0.forward = Vector3.New(var_807_5.x, var_807_5.y, var_807_5.z)

				local var_807_6 = var_807_0.localEulerAngles

				var_807_6.z = 0
				var_807_6.x = 0
				var_807_0.localEulerAngles = var_807_6
			end

			if arg_804_1.time_ >= var_807_1 + var_807_2 and arg_804_1.time_ < var_807_1 + var_807_2 + arg_807_0 then
				var_807_0.localPosition = Vector3.New(0, 100, 0)

				local var_807_7 = manager.ui.mainCamera.transform.position - var_807_0.position

				var_807_0.forward = Vector3.New(var_807_7.x, var_807_7.y, var_807_7.z)

				local var_807_8 = var_807_0.localEulerAngles

				var_807_8.z = 0
				var_807_8.x = 0
				var_807_0.localEulerAngles = var_807_8
			end

			local var_807_9 = 0
			local var_807_10 = 0.825

			if var_807_9 < arg_804_1.time_ and arg_804_1.time_ <= var_807_9 + arg_807_0 then
				arg_804_1.talkMaxDuration = 0
				arg_804_1.dialogCg_.alpha = 1

				arg_804_1.dialog_:SetActive(true)
				SetActive(arg_804_1.leftNameGo_, false)

				arg_804_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_804_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_804_1:RecordName(arg_804_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_804_1.iconTrs_.gameObject, false)
				arg_804_1.callingController_:SetSelectedState("normal")

				local var_807_11 = arg_804_1:GetWordFromCfg(1109511198)
				local var_807_12 = arg_804_1:FormatText(var_807_11.content)

				arg_804_1.text_.text = var_807_12

				LuaForUtil.ClearLinePrefixSymbol(arg_804_1.text_)

				local var_807_13 = 33
				local var_807_14 = utf8.len(var_807_12)
				local var_807_15 = var_807_13 <= 0 and var_807_10 or var_807_10 * (var_807_14 / var_807_13)

				if var_807_15 > 0 and var_807_10 < var_807_15 then
					arg_804_1.talkMaxDuration = var_807_15

					if var_807_15 + var_807_9 > arg_804_1.duration_ then
						arg_804_1.duration_ = var_807_15 + var_807_9
					end
				end

				arg_804_1.text_.text = var_807_12
				arg_804_1.typewritter.percent = 0

				arg_804_1.typewritter:SetDirty()
				arg_804_1:ShowNextGo(false)
				arg_804_1:RecordContent(arg_804_1.text_.text)
			end

			local var_807_16 = math.max(var_807_10, arg_804_1.talkMaxDuration)

			if var_807_9 <= arg_804_1.time_ and arg_804_1.time_ < var_807_9 + var_807_16 then
				arg_804_1.typewritter.percent = (arg_804_1.time_ - var_807_9) / var_807_16

				arg_804_1.typewritter:SetDirty()
			end

			if arg_804_1.time_ >= var_807_9 + var_807_16 and arg_804_1.time_ < var_807_9 + var_807_16 + arg_807_0 then
				arg_804_1.typewritter.percent = 1

				arg_804_1.typewritter:SetDirty()
				arg_804_1:ShowNextGo(true)
			end
		end

		arg_804_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_804_1:InitPlayNodeList()
	end,
	Play1109511199 = function(arg_808_0, arg_808_1)
		arg_808_1.time_ = 0
		arg_808_1.frameCnt_ = 0
		arg_808_1.state_ = "playing"
		arg_808_1.curTalkId_ = 1109511199
		arg_808_1.duration_ = 9.33

		SetActive(arg_808_1.tipsGo_, false)

		function arg_808_1.onSingleLineFinish_()
			arg_808_1.onSingleLineUpdate_ = nil
			arg_808_1.onSingleLineFinish_ = nil
			arg_808_1.state_ = "waiting"
		end

		function arg_808_1.playNext_(arg_810_0)
			if arg_810_0 == 1 then
				arg_808_0:Play1109511200(arg_808_1)
			end
		end

		function arg_808_1.onSingleLineUpdate_(arg_811_0)
			local var_811_0 = arg_808_1.actors_["10058ui_story"]
			local var_811_1 = 0

			if var_811_1 < arg_808_1.time_ and arg_808_1.time_ <= var_811_1 + arg_811_0 and not isNil(var_811_0) and arg_808_1.var_.characterEffect10058ui_story == nil then
				arg_808_1.var_.characterEffect10058ui_story = var_811_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_811_2 = 0.200000002980232

			if var_811_1 <= arg_808_1.time_ and arg_808_1.time_ < var_811_1 + var_811_2 and not isNil(var_811_0) then
				local var_811_3 = (arg_808_1.time_ - var_811_1) / var_811_2

				if arg_808_1.var_.characterEffect10058ui_story and not isNil(var_811_0) then
					arg_808_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_808_1.time_ >= var_811_1 + var_811_2 and arg_808_1.time_ < var_811_1 + var_811_2 + arg_811_0 and not isNil(var_811_0) and arg_808_1.var_.characterEffect10058ui_story then
				arg_808_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_811_4 = arg_808_1.actors_["10058ui_story"].transform
			local var_811_5 = 0

			if var_811_5 < arg_808_1.time_ and arg_808_1.time_ <= var_811_5 + arg_811_0 then
				arg_808_1.var_.moveOldPos10058ui_story = var_811_4.localPosition
			end

			local var_811_6 = 0.001

			if var_811_5 <= arg_808_1.time_ and arg_808_1.time_ < var_811_5 + var_811_6 then
				local var_811_7 = (arg_808_1.time_ - var_811_5) / var_811_6
				local var_811_8 = Vector3.New(0, -0.98, -6.1)

				var_811_4.localPosition = Vector3.Lerp(arg_808_1.var_.moveOldPos10058ui_story, var_811_8, var_811_7)

				local var_811_9 = manager.ui.mainCamera.transform.position - var_811_4.position

				var_811_4.forward = Vector3.New(var_811_9.x, var_811_9.y, var_811_9.z)

				local var_811_10 = var_811_4.localEulerAngles

				var_811_10.z = 0
				var_811_10.x = 0
				var_811_4.localEulerAngles = var_811_10
			end

			if arg_808_1.time_ >= var_811_5 + var_811_6 and arg_808_1.time_ < var_811_5 + var_811_6 + arg_811_0 then
				var_811_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_811_11 = manager.ui.mainCamera.transform.position - var_811_4.position

				var_811_4.forward = Vector3.New(var_811_11.x, var_811_11.y, var_811_11.z)

				local var_811_12 = var_811_4.localEulerAngles

				var_811_12.z = 0
				var_811_12.x = 0
				var_811_4.localEulerAngles = var_811_12
			end

			local var_811_13 = 0
			local var_811_14 = 0.725

			if var_811_13 < arg_808_1.time_ and arg_808_1.time_ <= var_811_13 + arg_811_0 then
				arg_808_1.talkMaxDuration = 0
				arg_808_1.dialogCg_.alpha = 1

				arg_808_1.dialog_:SetActive(true)
				SetActive(arg_808_1.leftNameGo_, true)

				local var_811_15 = arg_808_1:FormatText(StoryNameCfg[471].name)

				arg_808_1.leftNameTxt_.text = var_811_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_808_1.leftNameTxt_.transform)

				arg_808_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_808_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_808_1:RecordName(arg_808_1.leftNameTxt_.text)
				SetActive(arg_808_1.iconTrs_.gameObject, false)
				arg_808_1.callingController_:SetSelectedState("normal")

				local var_811_16 = arg_808_1:GetWordFromCfg(1109511199)
				local var_811_17 = arg_808_1:FormatText(var_811_16.content)

				arg_808_1.text_.text = var_811_17

				LuaForUtil.ClearLinePrefixSymbol(arg_808_1.text_)

				local var_811_18 = 29
				local var_811_19 = utf8.len(var_811_17)
				local var_811_20 = var_811_18 <= 0 and var_811_14 or var_811_14 * (var_811_19 / var_811_18)

				if var_811_20 > 0 and var_811_14 < var_811_20 then
					arg_808_1.talkMaxDuration = var_811_20

					if var_811_20 + var_811_13 > arg_808_1.duration_ then
						arg_808_1.duration_ = var_811_20 + var_811_13
					end
				end

				arg_808_1.text_.text = var_811_17
				arg_808_1.typewritter.percent = 0

				arg_808_1.typewritter:SetDirty()
				arg_808_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb") ~= 0 then
					local var_811_21 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb") / 1000

					if var_811_21 + var_811_13 > arg_808_1.duration_ then
						arg_808_1.duration_ = var_811_21 + var_811_13
					end

					if var_811_16.prefab_name ~= "" and arg_808_1.actors_[var_811_16.prefab_name] ~= nil then
						local var_811_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_808_1.actors_[var_811_16.prefab_name].transform, "story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")

						arg_808_1:RecordAudio("1109511199", var_811_22)
						arg_808_1:RecordAudio("1109511199", var_811_22)
					else
						arg_808_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")
					end

					arg_808_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")
				end

				arg_808_1:RecordContent(arg_808_1.text_.text)
			end

			local var_811_23 = math.max(var_811_14, arg_808_1.talkMaxDuration)

			if var_811_13 <= arg_808_1.time_ and arg_808_1.time_ < var_811_13 + var_811_23 then
				arg_808_1.typewritter.percent = (arg_808_1.time_ - var_811_13) / var_811_23

				arg_808_1.typewritter:SetDirty()
			end

			if arg_808_1.time_ >= var_811_13 + var_811_23 and arg_808_1.time_ < var_811_13 + var_811_23 + arg_811_0 then
				arg_808_1.typewritter.percent = 1

				arg_808_1.typewritter:SetDirty()
				arg_808_1:ShowNextGo(true)
			end
		end

		arg_808_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_808_1:InitPlayNodeList()
	end,
	Play1109511200 = function(arg_812_0, arg_812_1)
		arg_812_1.time_ = 0
		arg_812_1.frameCnt_ = 0
		arg_812_1.state_ = "playing"
		arg_812_1.curTalkId_ = 1109511200
		arg_812_1.duration_ = 5

		SetActive(arg_812_1.tipsGo_, false)

		function arg_812_1.onSingleLineFinish_()
			arg_812_1.onSingleLineUpdate_ = nil
			arg_812_1.onSingleLineFinish_ = nil
			arg_812_1.state_ = "waiting"
		end

		function arg_812_1.playNext_(arg_814_0)
			if arg_814_0 == 1 then
				arg_812_0:Play1109511201(arg_812_1)
			end
		end

		function arg_812_1.onSingleLineUpdate_(arg_815_0)
			local var_815_0 = arg_812_1.actors_["10058ui_story"]
			local var_815_1 = 0

			if var_815_1 < arg_812_1.time_ and arg_812_1.time_ <= var_815_1 + arg_815_0 and not isNil(var_815_0) and arg_812_1.var_.characterEffect10058ui_story == nil then
				arg_812_1.var_.characterEffect10058ui_story = var_815_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_815_2 = 0.200000002980232

			if var_815_1 <= arg_812_1.time_ and arg_812_1.time_ < var_815_1 + var_815_2 and not isNil(var_815_0) then
				local var_815_3 = (arg_812_1.time_ - var_815_1) / var_815_2

				if arg_812_1.var_.characterEffect10058ui_story and not isNil(var_815_0) then
					local var_815_4 = Mathf.Lerp(0, 0.5, var_815_3)

					arg_812_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_812_1.var_.characterEffect10058ui_story.fillRatio = var_815_4
				end
			end

			if arg_812_1.time_ >= var_815_1 + var_815_2 and arg_812_1.time_ < var_815_1 + var_815_2 + arg_815_0 and not isNil(var_815_0) and arg_812_1.var_.characterEffect10058ui_story then
				local var_815_5 = 0.5

				arg_812_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_812_1.var_.characterEffect10058ui_story.fillRatio = var_815_5
			end

			local var_815_6 = 0
			local var_815_7 = 0.725

			if var_815_6 < arg_812_1.time_ and arg_812_1.time_ <= var_815_6 + arg_815_0 then
				arg_812_1.talkMaxDuration = 0
				arg_812_1.dialogCg_.alpha = 1

				arg_812_1.dialog_:SetActive(true)
				SetActive(arg_812_1.leftNameGo_, true)

				local var_815_8 = arg_812_1:FormatText(StoryNameCfg[7].name)

				arg_812_1.leftNameTxt_.text = var_815_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_812_1.leftNameTxt_.transform)

				arg_812_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_812_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_812_1:RecordName(arg_812_1.leftNameTxt_.text)
				SetActive(arg_812_1.iconTrs_.gameObject, true)
				arg_812_1.iconController_:SetSelectedState("hero")

				arg_812_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_812_1.callingController_:SetSelectedState("normal")

				arg_812_1.keyicon_.color = Color.New(1, 1, 1)
				arg_812_1.icon_.color = Color.New(1, 1, 1)

				local var_815_9 = arg_812_1:GetWordFromCfg(1109511200)
				local var_815_10 = arg_812_1:FormatText(var_815_9.content)

				arg_812_1.text_.text = var_815_10

				LuaForUtil.ClearLinePrefixSymbol(arg_812_1.text_)

				local var_815_11 = 29
				local var_815_12 = utf8.len(var_815_10)
				local var_815_13 = var_815_11 <= 0 and var_815_7 or var_815_7 * (var_815_12 / var_815_11)

				if var_815_13 > 0 and var_815_7 < var_815_13 then
					arg_812_1.talkMaxDuration = var_815_13

					if var_815_13 + var_815_6 > arg_812_1.duration_ then
						arg_812_1.duration_ = var_815_13 + var_815_6
					end
				end

				arg_812_1.text_.text = var_815_10
				arg_812_1.typewritter.percent = 0

				arg_812_1.typewritter:SetDirty()
				arg_812_1:ShowNextGo(false)
				arg_812_1:RecordContent(arg_812_1.text_.text)
			end

			local var_815_14 = math.max(var_815_7, arg_812_1.talkMaxDuration)

			if var_815_6 <= arg_812_1.time_ and arg_812_1.time_ < var_815_6 + var_815_14 then
				arg_812_1.typewritter.percent = (arg_812_1.time_ - var_815_6) / var_815_14

				arg_812_1.typewritter:SetDirty()
			end

			if arg_812_1.time_ >= var_815_6 + var_815_14 and arg_812_1.time_ < var_815_6 + var_815_14 + arg_815_0 then
				arg_812_1.typewritter.percent = 1

				arg_812_1.typewritter:SetDirty()
				arg_812_1:ShowNextGo(true)
			end
		end

		arg_812_1.nodeConfigList_ = {}

		arg_812_1:InitPlayNodeList()
	end,
	Play1109511201 = function(arg_816_0, arg_816_1)
		arg_816_1.time_ = 0
		arg_816_1.frameCnt_ = 0
		arg_816_1.state_ = "playing"
		arg_816_1.curTalkId_ = 1109511201
		arg_816_1.duration_ = 5

		SetActive(arg_816_1.tipsGo_, false)

		function arg_816_1.onSingleLineFinish_()
			arg_816_1.onSingleLineUpdate_ = nil
			arg_816_1.onSingleLineFinish_ = nil
			arg_816_1.state_ = "waiting"
			arg_816_1.auto_ = false
		end

		function arg_816_1.playNext_(arg_818_0)
			arg_816_1.onStoryFinished_()
		end

		function arg_816_1.onSingleLineUpdate_(arg_819_0)
			local var_819_0 = 0
			local var_819_1 = 1.15

			if var_819_0 < arg_816_1.time_ and arg_816_1.time_ <= var_819_0 + arg_819_0 then
				arg_816_1.talkMaxDuration = 0
				arg_816_1.dialogCg_.alpha = 1

				arg_816_1.dialog_:SetActive(true)
				SetActive(arg_816_1.leftNameGo_, false)

				arg_816_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_816_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_816_1:RecordName(arg_816_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_816_1.iconTrs_.gameObject, false)
				arg_816_1.callingController_:SetSelectedState("normal")

				local var_819_2 = arg_816_1:GetWordFromCfg(1109511201)
				local var_819_3 = arg_816_1:FormatText(var_819_2.content)

				arg_816_1.text_.text = var_819_3

				LuaForUtil.ClearLinePrefixSymbol(arg_816_1.text_)

				local var_819_4 = 46
				local var_819_5 = utf8.len(var_819_3)
				local var_819_6 = var_819_4 <= 0 and var_819_1 or var_819_1 * (var_819_5 / var_819_4)

				if var_819_6 > 0 and var_819_1 < var_819_6 then
					arg_816_1.talkMaxDuration = var_819_6

					if var_819_6 + var_819_0 > arg_816_1.duration_ then
						arg_816_1.duration_ = var_819_6 + var_819_0
					end
				end

				arg_816_1.text_.text = var_819_3
				arg_816_1.typewritter.percent = 0

				arg_816_1.typewritter:SetDirty()
				arg_816_1:ShowNextGo(false)
				arg_816_1:RecordContent(arg_816_1.text_.text)
			end

			local var_819_7 = math.max(var_819_1, arg_816_1.talkMaxDuration)

			if var_819_0 <= arg_816_1.time_ and arg_816_1.time_ < var_819_0 + var_819_7 then
				arg_816_1.typewritter.percent = (arg_816_1.time_ - var_819_0) / var_819_7

				arg_816_1.typewritter:SetDirty()
			end

			if arg_816_1.time_ >= var_819_0 + var_819_7 and arg_816_1.time_ < var_819_0 + var_819_7 + arg_819_0 then
				arg_816_1.typewritter.percent = 1

				arg_816_1.typewritter:SetDirty()
				arg_816_1:ShowNextGo(true)
			end
		end

		arg_816_1.nodeConfigList_ = {}

		arg_816_1:InitPlayNodeList()
	end,
	Play1109511173 = function(arg_820_0, arg_820_1)
		arg_820_1.time_ = 0
		arg_820_1.frameCnt_ = 0
		arg_820_1.state_ = "playing"
		arg_820_1.curTalkId_ = 1109511173
		arg_820_1.duration_ = 2

		SetActive(arg_820_1.tipsGo_, false)

		function arg_820_1.onSingleLineFinish_()
			arg_820_1.onSingleLineUpdate_ = nil
			arg_820_1.onSingleLineFinish_ = nil
			arg_820_1.state_ = "waiting"
		end

		function arg_820_1.playNext_(arg_822_0)
			if arg_822_0 == 1 then
				arg_820_0:Play1109511174(arg_820_1)
			end
		end

		function arg_820_1.onSingleLineUpdate_(arg_823_0)
			local var_823_0 = "10058ui_story"

			if arg_820_1.actors_[var_823_0] == nil then
				local var_823_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_823_1) then
					local var_823_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_820_1.stage_.transform)

					var_823_2.name = var_823_0
					var_823_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_820_1.actors_[var_823_0] = var_823_2

					local var_823_3 = var_823_2:GetComponentInChildren(typeof(CharacterEffect))

					var_823_3.enabled = true

					local var_823_4 = GameObjectTools.GetOrAddComponent(var_823_2, typeof(DynamicBoneHelper))

					if var_823_4 then
						var_823_4:EnableDynamicBone(false)
					end

					arg_820_1:ShowWeapon(var_823_3.transform, false)

					arg_820_1.var_[var_823_0 .. "Animator"] = var_823_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_820_1.var_[var_823_0 .. "Animator"].applyRootMotion = true
					arg_820_1.var_[var_823_0 .. "LipSync"] = var_823_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_823_5 = 0

			if var_823_5 < arg_820_1.time_ and arg_820_1.time_ <= var_823_5 + arg_823_0 then
				arg_820_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_823_6 = arg_820_1.actors_["10058ui_story"].transform
			local var_823_7 = 0

			if var_823_7 < arg_820_1.time_ and arg_820_1.time_ <= var_823_7 + arg_823_0 then
				arg_820_1.var_.moveOldPos10058ui_story = var_823_6.localPosition
			end

			local var_823_8 = 0.001

			if var_823_7 <= arg_820_1.time_ and arg_820_1.time_ < var_823_7 + var_823_8 then
				local var_823_9 = (arg_820_1.time_ - var_823_7) / var_823_8
				local var_823_10 = Vector3.New(0, -0.98, -6.1)

				var_823_6.localPosition = Vector3.Lerp(arg_820_1.var_.moveOldPos10058ui_story, var_823_10, var_823_9)

				local var_823_11 = manager.ui.mainCamera.transform.position - var_823_6.position

				var_823_6.forward = Vector3.New(var_823_11.x, var_823_11.y, var_823_11.z)

				local var_823_12 = var_823_6.localEulerAngles

				var_823_12.z = 0
				var_823_12.x = 0
				var_823_6.localEulerAngles = var_823_12
			end

			if arg_820_1.time_ >= var_823_7 + var_823_8 and arg_820_1.time_ < var_823_7 + var_823_8 + arg_823_0 then
				var_823_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_823_13 = manager.ui.mainCamera.transform.position - var_823_6.position

				var_823_6.forward = Vector3.New(var_823_13.x, var_823_13.y, var_823_13.z)

				local var_823_14 = var_823_6.localEulerAngles

				var_823_14.z = 0
				var_823_14.x = 0
				var_823_6.localEulerAngles = var_823_14
			end

			local var_823_15 = "10058ui_story"

			if arg_820_1.actors_[var_823_15] == nil then
				local var_823_16 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_823_16) then
					local var_823_17 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_820_1.stage_.transform)

					var_823_17.name = var_823_15
					var_823_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_820_1.actors_[var_823_15] = var_823_17

					local var_823_18 = var_823_17:GetComponentInChildren(typeof(CharacterEffect))

					var_823_18.enabled = true

					local var_823_19 = GameObjectTools.GetOrAddComponent(var_823_17, typeof(DynamicBoneHelper))

					if var_823_19 then
						var_823_19:EnableDynamicBone(false)
					end

					arg_820_1:ShowWeapon(var_823_18.transform, false)

					arg_820_1.var_[var_823_15 .. "Animator"] = var_823_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_820_1.var_[var_823_15 .. "Animator"].applyRootMotion = true
					arg_820_1.var_[var_823_15 .. "LipSync"] = var_823_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_823_20 = 0

			if var_823_20 < arg_820_1.time_ and arg_820_1.time_ <= var_823_20 + arg_823_0 then
				arg_820_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_823_21 = arg_820_1.actors_["10058ui_story"]
			local var_823_22 = 0

			if var_823_22 < arg_820_1.time_ and arg_820_1.time_ <= var_823_22 + arg_823_0 and not isNil(var_823_21) and arg_820_1.var_.characterEffect10058ui_story == nil then
				arg_820_1.var_.characterEffect10058ui_story = var_823_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_823_23 = 0.200000002980232

			if var_823_22 <= arg_820_1.time_ and arg_820_1.time_ < var_823_22 + var_823_23 and not isNil(var_823_21) then
				local var_823_24 = (arg_820_1.time_ - var_823_22) / var_823_23

				if arg_820_1.var_.characterEffect10058ui_story and not isNil(var_823_21) then
					arg_820_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_820_1.time_ >= var_823_22 + var_823_23 and arg_820_1.time_ < var_823_22 + var_823_23 + arg_823_0 and not isNil(var_823_21) and arg_820_1.var_.characterEffect10058ui_story then
				arg_820_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_823_25 = 0
			local var_823_26 = 0.05

			if var_823_25 < arg_820_1.time_ and arg_820_1.time_ <= var_823_25 + arg_823_0 then
				arg_820_1.talkMaxDuration = 0
				arg_820_1.dialogCg_.alpha = 1

				arg_820_1.dialog_:SetActive(true)
				SetActive(arg_820_1.leftNameGo_, true)

				local var_823_27 = arg_820_1:FormatText(StoryNameCfg[471].name)

				arg_820_1.leftNameTxt_.text = var_823_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_820_1.leftNameTxt_.transform)

				arg_820_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_820_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_820_1:RecordName(arg_820_1.leftNameTxt_.text)
				SetActive(arg_820_1.iconTrs_.gameObject, false)
				arg_820_1.callingController_:SetSelectedState("normal")

				local var_823_28 = arg_820_1:GetWordFromCfg(1109511173)
				local var_823_29 = arg_820_1:FormatText(var_823_28.content)

				arg_820_1.text_.text = var_823_29

				LuaForUtil.ClearLinePrefixSymbol(arg_820_1.text_)

				local var_823_30 = 2
				local var_823_31 = utf8.len(var_823_29)
				local var_823_32 = var_823_30 <= 0 and var_823_26 or var_823_26 * (var_823_31 / var_823_30)

				if var_823_32 > 0 and var_823_26 < var_823_32 then
					arg_820_1.talkMaxDuration = var_823_32

					if var_823_32 + var_823_25 > arg_820_1.duration_ then
						arg_820_1.duration_ = var_823_32 + var_823_25
					end
				end

				arg_820_1.text_.text = var_823_29
				arg_820_1.typewritter.percent = 0

				arg_820_1.typewritter:SetDirty()
				arg_820_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb") ~= 0 then
					local var_823_33 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb") / 1000

					if var_823_33 + var_823_25 > arg_820_1.duration_ then
						arg_820_1.duration_ = var_823_33 + var_823_25
					end

					if var_823_28.prefab_name ~= "" and arg_820_1.actors_[var_823_28.prefab_name] ~= nil then
						local var_823_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_820_1.actors_[var_823_28.prefab_name].transform, "story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")

						arg_820_1:RecordAudio("1109511173", var_823_34)
						arg_820_1:RecordAudio("1109511173", var_823_34)
					else
						arg_820_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")
					end

					arg_820_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")
				end

				arg_820_1:RecordContent(arg_820_1.text_.text)
			end

			local var_823_35 = math.max(var_823_26, arg_820_1.talkMaxDuration)

			if var_823_25 <= arg_820_1.time_ and arg_820_1.time_ < var_823_25 + var_823_35 then
				arg_820_1.typewritter.percent = (arg_820_1.time_ - var_823_25) / var_823_35

				arg_820_1.typewritter:SetDirty()
			end

			if arg_820_1.time_ >= var_823_25 + var_823_35 and arg_820_1.time_ < var_823_25 + var_823_35 + arg_823_0 then
				arg_820_1.typewritter.percent = 1

				arg_820_1.typewritter:SetDirty()
				arg_820_1:ShowNextGo(true)
			end
		end

		arg_820_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_820_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0104",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/X203I",
		"TextureConfig/Background/X203K",
		"TextureConfig/Background/X203g",
		"TextureConfig/Background/ST70",
		"TextureConfig/Background/ST77"
	},
	voices = {
		"story_v_side_new_1109511.awb"
	}
}
