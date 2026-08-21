return {
	Play301021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 301021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play301021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST07"

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
				local var_4_5 = arg_1_1.bgs_.ST07

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
					if iter_4_0 ~= "ST07" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effectyewanbingfang
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_4_28)
					var_4_26.name = "yewanbingfang"
					arg_1_1.var_.effectyewanbingfang = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = 0.2
			local var_4_30 = 1

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "effect"

				arg_1_1:AudioAction(var_4_31, var_4_32, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_4_33 = 1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily.awb")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 0
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "effect"

				arg_1_1:AudioAction(var_4_41, var_4_42, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_43 = 2
			local var_4_44 = 1.3

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_45 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_45:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_46 = arg_1_1:GetWordFromCfg(301021001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 52
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_44 or var_4_44 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_44 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_43 = var_4_43 + 0.3

					if var_4_50 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_43
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_43 + 0.3
			local var_4_52 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play301021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 301021002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play301021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_152", "se_story_152_door", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1.825

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(301021002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 73
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play301021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 301021003
		arg_12_1.duration_ = 1.33

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play301021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.05

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(301021003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021003", "story_v_out_301021.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021003", "story_v_out_301021.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_301021", "301021003", "story_v_out_301021.awb")

						arg_12_1:RecordAudio("301021003", var_15_9)
						arg_12_1:RecordAudio("301021003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_301021", "301021003", "story_v_out_301021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_301021", "301021003", "story_v_out_301021.awb")
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
	Play301021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 301021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play301021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.4
			local var_19_1 = 1

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "play"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_19_4 = 0
			local var_19_5 = 1.125

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(301021004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 45
				local var_19_9 = utf8.len(var_19_7)
				local var_19_10 = var_19_8 <= 0 and var_19_5 or var_19_5 * (var_19_9 / var_19_8)

				if var_19_10 > 0 and var_19_5 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_11 and arg_16_1.time_ < var_19_4 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play301021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 301021005
		arg_20_1.duration_ = 8.02

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play301021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = manager.ui.mainCamera.transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				local var_23_2 = arg_20_1.var_.effectsaomiao1
				local var_23_3
				local var_23_4 = var_23_0

				if not var_23_2 then
					var_23_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_23_4)
					var_23_2.name = "saomiao1"
					arg_20_1.var_.effectsaomiao1 = var_23_2
				else
					var_23_2.transform:SetParent(var_23_4)
				end

				var_23_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_23_5 = 1.7777777777777777
				local var_23_6 = Screen.width / Screen.height
				local var_23_7 = var_23_6 / var_23_5
				local var_23_8 = Mathf.Max(var_23_5 / var_23_6, 1)
				local var_23_9 = Mathf.Max(var_23_7, var_23_8)

				var_23_2.transform.localScale = Vector3.New(var_23_2.transform.localScale.x * var_23_9, var_23_2.transform.localScale.y * var_23_9, var_23_2.transform.localScale.z * var_23_9)
			end

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_11 = 3.5

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_12 = 0.2
			local var_23_13 = 1

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				local var_23_14 = "play"
				local var_23_15 = "effect"

				arg_20_1:AudioAction(var_23_14, var_23_15, "se_story_151", "se_story_151_Baochunniao_Scan", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_16 = 3.01666666666667
			local var_23_17 = 2

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_18 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_18:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(301021005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 80
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_17 or var_23_17 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_17 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23
					var_23_16 = var_23_16 + 0.3

					if var_23_23 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = var_23_16 + 0.3
			local var_23_25 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_24 <= arg_20_1.time_ and arg_20_1.time_ < var_23_24 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_24) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_24 + var_23_25 and arg_20_1.time_ < var_23_24 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play301021006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 301021006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play301021007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1.325

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_2 = arg_26_1:GetWordFromCfg(301021006)
				local var_29_3 = arg_26_1:FormatText(var_29_2.content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 53
				local var_29_5 = utf8.len(var_29_3)
				local var_29_6 = var_29_4 <= 0 and var_29_1 or var_29_1 * (var_29_5 / var_29_4)

				if var_29_6 > 0 and var_29_1 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_7 and arg_26_1.time_ < var_29_0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play301021007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 301021007
		arg_30_1.duration_ = 2.27

		local var_30_0 = {
			zh = 2.266,
			ja = 1.333
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play301021008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.175

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[36].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(301021007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 7
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021007", "story_v_out_301021.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021007", "story_v_out_301021.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_301021", "301021007", "story_v_out_301021.awb")

						arg_30_1:RecordAudio("301021007", var_33_9)
						arg_30_1:RecordAudio("301021007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_301021", "301021007", "story_v_out_301021.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_301021", "301021007", "story_v_out_301021.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play301021008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 301021008
		arg_34_1.duration_ = 6.9

		local var_34_0 = {
			zh = 6.9,
			ja = 1.333
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play301021009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.575

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[36].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:GetWordFromCfg(301021008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 23
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021008", "story_v_out_301021.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021008", "story_v_out_301021.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_301021", "301021008", "story_v_out_301021.awb")

						arg_34_1:RecordAudio("301021008", var_37_9)
						arg_34_1:RecordAudio("301021008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_301021", "301021008", "story_v_out_301021.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_301021", "301021008", "story_v_out_301021.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play301021009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 301021009
		arg_38_1.duration_ = 9

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play301021010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 2

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				local var_41_1 = manager.ui.mainCamera.transform.localPosition
				local var_41_2 = Vector3.New(0, 0, 10) + Vector3.New(var_41_1.x, var_41_1.y, 0)
				local var_41_3 = arg_38_1.bgs_.ST07

				var_41_3.transform.localPosition = var_41_2
				var_41_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_4 = var_41_3:GetComponent("SpriteRenderer")

				if var_41_4 and var_41_4.sprite then
					local var_41_5 = (var_41_3.transform.localPosition - var_41_1).z
					local var_41_6 = manager.ui.mainCameraCom_
					local var_41_7 = 2 * var_41_5 * Mathf.Tan(var_41_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_8 = var_41_7 * var_41_6.aspect
					local var_41_9 = var_41_4.sprite.bounds.size.x
					local var_41_10 = var_41_4.sprite.bounds.size.y
					local var_41_11 = var_41_8 / var_41_9
					local var_41_12 = var_41_7 / var_41_10
					local var_41_13 = var_41_12 < var_41_11 and var_41_11 or var_41_12

					var_41_3.transform.localScale = Vector3.New(var_41_13, var_41_13, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "ST07" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_14 = 4

			if var_41_14 < arg_38_1.time_ and arg_38_1.time_ <= var_41_14 + arg_41_0 then
				arg_38_1.allBtn_.enabled = false
			end

			local var_41_15 = 0.3

			if arg_38_1.time_ >= var_41_14 + var_41_15 and arg_38_1.time_ < var_41_14 + var_41_15 + arg_41_0 then
				arg_38_1.allBtn_.enabled = true
			end

			local var_41_16 = 0

			if var_41_16 < arg_38_1.time_ and arg_38_1.time_ <= var_41_16 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_17 = 2

			if var_41_16 <= arg_38_1.time_ and arg_38_1.time_ < var_41_16 + var_41_17 then
				local var_41_18 = (arg_38_1.time_ - var_41_16) / var_41_17
				local var_41_19 = Color.New(0, 0, 0)

				var_41_19.a = Mathf.Lerp(0, 1, var_41_18)
				arg_38_1.mask_.color = var_41_19
			end

			if arg_38_1.time_ >= var_41_16 + var_41_17 and arg_38_1.time_ < var_41_16 + var_41_17 + arg_41_0 then
				local var_41_20 = Color.New(0, 0, 0)

				var_41_20.a = 1
				arg_38_1.mask_.color = var_41_20
			end

			local var_41_21 = 2

			if var_41_21 < arg_38_1.time_ and arg_38_1.time_ <= var_41_21 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_22 = 2

			if var_41_21 <= arg_38_1.time_ and arg_38_1.time_ < var_41_21 + var_41_22 then
				local var_41_23 = (arg_38_1.time_ - var_41_21) / var_41_22
				local var_41_24 = Color.New(0, 0, 0)

				var_41_24.a = Mathf.Lerp(1, 0, var_41_23)
				arg_38_1.mask_.color = var_41_24
			end

			if arg_38_1.time_ >= var_41_21 + var_41_22 and arg_38_1.time_ < var_41_21 + var_41_22 + arg_41_0 then
				local var_41_25 = Color.New(0, 0, 0)
				local var_41_26 = 0

				arg_38_1.mask_.enabled = false
				var_41_25.a = var_41_26
				arg_38_1.mask_.color = var_41_25
			end

			local var_41_27 = manager.ui.mainCamera.transform
			local var_41_28 = 2

			if var_41_28 < arg_38_1.time_ and arg_38_1.time_ <= var_41_28 + arg_41_0 then
				local var_41_29 = arg_38_1.var_.effectyewanbingfang

				if var_41_29 then
					Object.Destroy(var_41_29)

					arg_38_1.var_.effectyewanbingfang = nil
				end
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_30 = 4
			local var_41_31 = 0.2

			if var_41_30 < arg_38_1.time_ and arg_38_1.time_ <= var_41_30 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_32 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_32:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_33 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_34 = arg_38_1:GetWordFromCfg(301021009)
				local var_41_35 = arg_38_1:FormatText(var_41_34.content)

				arg_38_1.text_.text = var_41_35

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_36 = 8
				local var_41_37 = utf8.len(var_41_35)
				local var_41_38 = var_41_36 <= 0 and var_41_31 or var_41_31 * (var_41_37 / var_41_36)

				if var_41_38 > 0 and var_41_31 < var_41_38 then
					arg_38_1.talkMaxDuration = var_41_38
					var_41_30 = var_41_30 + 0.3

					if var_41_38 + var_41_30 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_38 + var_41_30
					end
				end

				arg_38_1.text_.text = var_41_35
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_39 = var_41_30 + 0.3
			local var_41_40 = math.max(var_41_31, arg_38_1.talkMaxDuration)

			if var_41_39 <= arg_38_1.time_ and arg_38_1.time_ < var_41_39 + var_41_40 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_39) / var_41_40

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_39 + var_41_40 and arg_38_1.time_ < var_41_39 + var_41_40 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play301021010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 301021010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play301021011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.775

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(301021010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 71
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play301021011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 301021011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play301021012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.3

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

				local var_51_2 = arg_48_1:GetWordFromCfg(301021011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 52
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
	Play301021012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 301021012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play301021013(arg_52_1)
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

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(301021012)
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play301021013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 301021013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play301021014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.1

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(301021013)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 44
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play301021014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 301021014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play301021015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.525

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(301021014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 21
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
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play301021015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 301021015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play301021016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_144", "se_story_144_door_open", "")
			end

			local var_67_4 = 0
			local var_67_5 = 1.525

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(301021015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 61
				local var_67_9 = utf8.len(var_67_7)
				local var_67_10 = var_67_8 <= 0 and var_67_5 or var_67_5 * (var_67_9 / var_67_8)

				if var_67_10 > 0 and var_67_5 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_11 and arg_64_1.time_ < var_67_4 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play301021016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 301021016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play301021017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.775

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(301021016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 31
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play301021017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 301021017
		arg_72_1.duration_ = 9

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play301021018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "I02f"

			if arg_72_1.bgs_[var_75_0] == nil then
				local var_75_1 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_75_0)
				var_75_1.name = var_75_0
				var_75_1.transform.parent = arg_72_1.stage_.transform
				var_75_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_[var_75_0] = var_75_1
			end

			local var_75_2 = 2

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				local var_75_3 = manager.ui.mainCamera.transform.localPosition
				local var_75_4 = Vector3.New(0, 0, 10) + Vector3.New(var_75_3.x, var_75_3.y, 0)
				local var_75_5 = arg_72_1.bgs_.I02f

				var_75_5.transform.localPosition = var_75_4
				var_75_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_6 = var_75_5:GetComponent("SpriteRenderer")

				if var_75_6 and var_75_6.sprite then
					local var_75_7 = (var_75_5.transform.localPosition - var_75_3).z
					local var_75_8 = manager.ui.mainCameraCom_
					local var_75_9 = 2 * var_75_7 * Mathf.Tan(var_75_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_10 = var_75_9 * var_75_8.aspect
					local var_75_11 = var_75_6.sprite.bounds.size.x
					local var_75_12 = var_75_6.sprite.bounds.size.y
					local var_75_13 = var_75_10 / var_75_11
					local var_75_14 = var_75_9 / var_75_12
					local var_75_15 = var_75_14 < var_75_13 and var_75_13 or var_75_14

					var_75_5.transform.localScale = Vector3.New(var_75_15, var_75_15, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "I02f" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_16 = 3.999999999999

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_17 = 0.3

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_18 = 0

			if var_75_18 < arg_72_1.time_ and arg_72_1.time_ <= var_75_18 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_19 = 2

			if var_75_18 <= arg_72_1.time_ and arg_72_1.time_ < var_75_18 + var_75_19 then
				local var_75_20 = (arg_72_1.time_ - var_75_18) / var_75_19
				local var_75_21 = Color.New(0, 0, 0)

				var_75_21.a = Mathf.Lerp(0, 1, var_75_20)
				arg_72_1.mask_.color = var_75_21
			end

			if arg_72_1.time_ >= var_75_18 + var_75_19 and arg_72_1.time_ < var_75_18 + var_75_19 + arg_75_0 then
				local var_75_22 = Color.New(0, 0, 0)

				var_75_22.a = 1
				arg_72_1.mask_.color = var_75_22
			end

			local var_75_23 = 2

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_24 = 2

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / var_75_24
				local var_75_26 = Color.New(0, 0, 0)

				var_75_26.a = Mathf.Lerp(1, 0, var_75_25)
				arg_72_1.mask_.color = var_75_26
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 then
				local var_75_27 = Color.New(0, 0, 0)
				local var_75_28 = 0

				arg_72_1.mask_.enabled = false
				var_75_27.a = var_75_28
				arg_72_1.mask_.color = var_75_27
			end

			local var_75_29 = 1.2
			local var_75_30 = 1

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				local var_75_31 = "play"
				local var_75_32 = "effect"

				arg_72_1:AudioAction(var_75_31, var_75_32, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_75_33 = 0.2
			local var_75_34 = 1

			if var_75_33 < arg_72_1.time_ and arg_72_1.time_ <= var_75_33 + arg_75_0 then
				local var_75_35 = "stop"
				local var_75_36 = "effect"

				arg_72_1:AudioAction(var_75_35, var_75_36, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_37 = 3.999999999999
			local var_75_38 = 1.325

			if var_75_37 < arg_72_1.time_ and arg_72_1.time_ <= var_75_37 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_39 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_39:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_40 = arg_72_1:GetWordFromCfg(301021017)
				local var_75_41 = arg_72_1:FormatText(var_75_40.content)

				arg_72_1.text_.text = var_75_41

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_42 = 53
				local var_75_43 = utf8.len(var_75_41)
				local var_75_44 = var_75_42 <= 0 and var_75_38 or var_75_38 * (var_75_43 / var_75_42)

				if var_75_44 > 0 and var_75_38 < var_75_44 then
					arg_72_1.talkMaxDuration = var_75_44
					var_75_37 = var_75_37 + 0.3

					if var_75_44 + var_75_37 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_44 + var_75_37
					end
				end

				arg_72_1.text_.text = var_75_41
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_45 = var_75_37 + 0.3
			local var_75_46 = math.max(var_75_38, arg_72_1.talkMaxDuration)

			if var_75_45 <= arg_72_1.time_ and arg_72_1.time_ < var_75_45 + var_75_46 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_45) / var_75_46

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_45 + var_75_46 and arg_72_1.time_ < var_75_45 + var_75_46 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play301021018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 301021018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play301021019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.55

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(301021018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 22
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play301021019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 301021019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play301021020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.225

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(301021019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 9
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play301021020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 301021020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play301021021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.825

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_2 = arg_86_1:GetWordFromCfg(301021020)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 73
				local var_89_5 = utf8.len(var_89_3)
				local var_89_6 = var_89_4 <= 0 and var_89_1 or var_89_1 * (var_89_5 / var_89_4)

				if var_89_6 > 0 and var_89_1 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_7 and arg_86_1.time_ < var_89_0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play301021021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 301021021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play301021022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.475

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(301021021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 19
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play301021022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 301021022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play301021023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.75

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(301021022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 30
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play301021023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 301021023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play301021024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.55

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(301021023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 62
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play301021024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 301021024
		arg_102_1.duration_ = 9.02

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play301021025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = "B13a"

			if arg_102_1.bgs_[var_105_0] == nil then
				local var_105_1 = Object.Instantiate(arg_102_1.paintGo_)

				var_105_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_105_0)
				var_105_1.name = var_105_0
				var_105_1.transform.parent = arg_102_1.stage_.transform
				var_105_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.bgs_[var_105_0] = var_105_1
			end

			local var_105_2 = 2

			if var_105_2 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				local var_105_3 = manager.ui.mainCamera.transform.localPosition
				local var_105_4 = Vector3.New(0, 0, 10) + Vector3.New(var_105_3.x, var_105_3.y, 0)
				local var_105_5 = arg_102_1.bgs_.B13a

				var_105_5.transform.localPosition = var_105_4
				var_105_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_6 = var_105_5:GetComponent("SpriteRenderer")

				if var_105_6 and var_105_6.sprite then
					local var_105_7 = (var_105_5.transform.localPosition - var_105_3).z
					local var_105_8 = manager.ui.mainCameraCom_
					local var_105_9 = 2 * var_105_7 * Mathf.Tan(var_105_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_105_10 = var_105_9 * var_105_8.aspect
					local var_105_11 = var_105_6.sprite.bounds.size.x
					local var_105_12 = var_105_6.sprite.bounds.size.y
					local var_105_13 = var_105_10 / var_105_11
					local var_105_14 = var_105_9 / var_105_12
					local var_105_15 = var_105_14 < var_105_13 and var_105_13 or var_105_14

					var_105_5.transform.localScale = Vector3.New(var_105_15, var_105_15, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "B13a" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_16 = 4

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			local var_105_17 = 0.3

			if arg_102_1.time_ >= var_105_16 + var_105_17 and arg_102_1.time_ < var_105_16 + var_105_17 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			local var_105_18 = 0

			if var_105_18 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_19 = 2

			if var_105_18 <= arg_102_1.time_ and arg_102_1.time_ < var_105_18 + var_105_19 then
				local var_105_20 = (arg_102_1.time_ - var_105_18) / var_105_19
				local var_105_21 = Color.New(0, 0, 0)

				var_105_21.a = Mathf.Lerp(0, 1, var_105_20)
				arg_102_1.mask_.color = var_105_21
			end

			if arg_102_1.time_ >= var_105_18 + var_105_19 and arg_102_1.time_ < var_105_18 + var_105_19 + arg_105_0 then
				local var_105_22 = Color.New(0, 0, 0)

				var_105_22.a = 1
				arg_102_1.mask_.color = var_105_22
			end

			local var_105_23 = 2

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_24 = 2

			if var_105_23 <= arg_102_1.time_ and arg_102_1.time_ < var_105_23 + var_105_24 then
				local var_105_25 = (arg_102_1.time_ - var_105_23) / var_105_24
				local var_105_26 = Color.New(0, 0, 0)

				var_105_26.a = Mathf.Lerp(1, 0, var_105_25)
				arg_102_1.mask_.color = var_105_26
			end

			if arg_102_1.time_ >= var_105_23 + var_105_24 and arg_102_1.time_ < var_105_23 + var_105_24 + arg_105_0 then
				local var_105_27 = Color.New(0, 0, 0)
				local var_105_28 = 0

				arg_102_1.mask_.enabled = false
				var_105_27.a = var_105_28
				arg_102_1.mask_.color = var_105_27
			end

			local var_105_29 = 1.2
			local var_105_30 = 1

			if var_105_29 < arg_102_1.time_ and arg_102_1.time_ <= var_105_29 + arg_105_0 then
				local var_105_31 = "play"
				local var_105_32 = "effect"

				arg_102_1:AudioAction(var_105_31, var_105_32, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_105_33 = 0.2
			local var_105_34 = 1

			if var_105_33 < arg_102_1.time_ and arg_102_1.time_ <= var_105_33 + arg_105_0 then
				local var_105_35 = "stop"
				local var_105_36 = "effect"

				arg_102_1:AudioAction(var_105_35, var_105_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_37 = 4.025
			local var_105_38 = 0.275

			if var_105_37 < arg_102_1.time_ and arg_102_1.time_ <= var_105_37 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_39 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_39:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_40 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_41 = arg_102_1:GetWordFromCfg(301021024)
				local var_105_42 = arg_102_1:FormatText(var_105_41.content)

				arg_102_1.text_.text = var_105_42

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_43 = 11
				local var_105_44 = utf8.len(var_105_42)
				local var_105_45 = var_105_43 <= 0 and var_105_38 or var_105_38 * (var_105_44 / var_105_43)

				if var_105_45 > 0 and var_105_38 < var_105_45 then
					arg_102_1.talkMaxDuration = var_105_45
					var_105_37 = var_105_37 + 0.3

					if var_105_45 + var_105_37 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_45 + var_105_37
					end
				end

				arg_102_1.text_.text = var_105_42
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_46 = var_105_37 + 0.3
			local var_105_47 = math.max(var_105_38, arg_102_1.talkMaxDuration)

			if var_105_46 <= arg_102_1.time_ and arg_102_1.time_ < var_105_46 + var_105_47 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_46) / var_105_47

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_46 + var_105_47 and arg_102_1.time_ < var_105_46 + var_105_47 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play301021025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 301021025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play301021026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.375

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(301021025)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 55
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play301021026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 301021026
		arg_112_1.duration_ = 4.3

		local var_112_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_112_0:Play301021027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.4

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[36].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(301021026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 16
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021026", "story_v_out_301021.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021026", "story_v_out_301021.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_301021", "301021026", "story_v_out_301021.awb")

						arg_112_1:RecordAudio("301021026", var_115_9)
						arg_112_1:RecordAudio("301021026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_301021", "301021026", "story_v_out_301021.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_301021", "301021026", "story_v_out_301021.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play301021027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 301021027
		arg_116_1.duration_ = 6.92

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play301021028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = manager.ui.mainCamera.transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				local var_119_2 = arg_116_1.var_.effectmengdizhuanshen1
				local var_119_3
				local var_119_4 = var_119_0

				if not var_119_2 then
					var_119_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_119_4)
					var_119_2.name = "mengdizhuanshen1"
					arg_116_1.var_.effectmengdizhuanshen1 = var_119_2
				else
					var_119_2.transform:SetParent(var_119_4)
				end

				var_119_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_119_5 = 1.7777777777777777
				local var_119_6 = Screen.width / Screen.height
				local var_119_7 = var_119_6 / var_119_5
				local var_119_8 = Mathf.Max(var_119_5 / var_119_6, 1)

				var_119_2.transform.localScale = Vector3.New(var_119_2.transform.localScale.x * var_119_7, var_119_2.transform.localScale.y * var_119_8, var_119_2.transform.localScale.z)
			end

			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_10 = 2.999999999999

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_11 = 1.92165549905039
			local var_119_12 = 0.65

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_13 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_13:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_14 = arg_116_1:GetWordFromCfg(301021027)
				local var_119_15 = arg_116_1:FormatText(var_119_14.content)

				arg_116_1.text_.text = var_119_15

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_16 = 26
				local var_119_17 = utf8.len(var_119_15)
				local var_119_18 = var_119_16 <= 0 and var_119_12 or var_119_12 * (var_119_17 / var_119_16)

				if var_119_18 > 0 and var_119_12 < var_119_18 then
					arg_116_1.talkMaxDuration = var_119_18
					var_119_11 = var_119_11 + 0.3

					if var_119_18 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_15
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_19 = var_119_11 + 0.3
			local var_119_20 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_19 <= arg_116_1.time_ and arg_116_1.time_ < var_119_19 + var_119_20 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_19) / var_119_20

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_19 + var_119_20 and arg_116_1.time_ < var_119_19 + var_119_20 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play301021028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 301021028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play301021029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.5
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "effect"

				arg_122_1:AudioAction(var_125_2, var_125_3, "se_story_152", "se_story_152_robot", "")
			end

			local var_125_4 = 0
			local var_125_5 = 1.6

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(301021028)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_8 = 64
				local var_125_9 = utf8.len(var_125_7)
				local var_125_10 = var_125_8 <= 0 and var_125_5 or var_125_5 * (var_125_9 / var_125_8)

				if var_125_10 > 0 and var_125_5 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_11 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_11

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_11 and arg_122_1.time_ < var_125_4 + var_125_11 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play301021029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 301021029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play301021030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.025

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(301021029)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 41
				local var_129_5 = utf8.len(var_129_3)
				local var_129_6 = var_129_4 <= 0 and var_129_1 or var_129_1 * (var_129_5 / var_129_4)

				if var_129_6 > 0 and var_129_1 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_7 and arg_126_1.time_ < var_129_0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play301021030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 301021030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play301021031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.275

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(301021030)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 11
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play301021031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 301021031
		arg_134_1.duration_ = 1

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"

			SetActive(arg_134_1.choicesGo_, true)

			for iter_135_0, iter_135_1 in ipairs(arg_134_1.choices_) do
				local var_135_0 = iter_135_0 <= 3

				SetActive(iter_135_1.go, var_135_0)
			end

			arg_134_1.choices_[1].txt.text = arg_134_1:FormatText(StoryChoiceCfg[1720].name)
			arg_134_1.choices_[2].txt.text = arg_134_1:FormatText(StoryChoiceCfg[1721].name)
			arg_134_1.choices_[3].txt.text = arg_134_1:FormatText(StoryChoiceCfg[1722].name)
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play301021032(arg_134_1)
			end

			if arg_136_0 == 2 then
				arg_134_0:Play301021032(arg_134_1)
			end

			if arg_136_0 == 3 then
				arg_134_0:Play301021032(arg_134_1)
			end

			arg_134_1:RecordChoiceLog(301021031, 1720, 1721, 1722)
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			local var_137_1 = 0.999999999999

			if arg_134_1.time_ >= var_137_0 + var_137_1 and arg_134_1.time_ < var_137_0 + var_137_1 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play301021032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 301021032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play301021033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.3

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(301021032)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 52
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play301021033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 301021033
		arg_142_1.duration_ = 7.67

		local var_142_0 = {
			zh = 4.3,
			ja = 7.666
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
				arg_142_0:Play301021034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.55

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[60].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2070")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(301021033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021033", "story_v_out_301021.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021033", "story_v_out_301021.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_301021", "301021033", "story_v_out_301021.awb")

						arg_142_1:RecordAudio("301021033", var_145_9)
						arg_142_1:RecordAudio("301021033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_301021", "301021033", "story_v_out_301021.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_301021", "301021033", "story_v_out_301021.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play301021034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 301021034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play301021035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.525

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

				local var_149_3 = arg_146_1:GetWordFromCfg(301021034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 21
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
	Play301021035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 301021035
		arg_150_1.duration_ = 11.67

		local var_150_0 = {
			zh = 6.466,
			ja = 11.666
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
				arg_150_0:Play301021036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.5
			local var_153_1 = 1

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				local var_153_2 = "play"
				local var_153_3 = "effect"

				arg_150_1:AudioAction(var_153_2, var_153_3, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_153_4 = 0
			local var_153_5 = 0.75

			if var_153_4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_6 = arg_150_1:FormatText(StoryNameCfg[60].name)

				arg_150_1.leftNameTxt_.text = var_153_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2070")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_7 = arg_150_1:GetWordFromCfg(301021035)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 30
				local var_153_10 = utf8.len(var_153_8)
				local var_153_11 = var_153_9 <= 0 and var_153_5 or var_153_5 * (var_153_10 / var_153_9)

				if var_153_11 > 0 and var_153_5 < var_153_11 then
					arg_150_1.talkMaxDuration = var_153_11

					if var_153_11 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021035", "story_v_out_301021.awb") ~= 0 then
					local var_153_12 = manager.audio:GetVoiceLength("story_v_out_301021", "301021035", "story_v_out_301021.awb") / 1000

					if var_153_12 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_12 + var_153_4
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_out_301021", "301021035", "story_v_out_301021.awb")

						arg_150_1:RecordAudio("301021035", var_153_13)
						arg_150_1:RecordAudio("301021035", var_153_13)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_301021", "301021035", "story_v_out_301021.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_301021", "301021035", "story_v_out_301021.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_14 and arg_150_1.time_ < var_153_4 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play301021036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 301021036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play301021037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.125

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(301021036)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 5
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_8 and arg_154_1.time_ < var_157_0 + var_157_8 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play301021037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 301021037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play301021038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 1.825

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(301021037)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 73
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play301021038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 301021038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play301021039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.325

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

				local var_165_3 = arg_162_1:GetWordFromCfg(301021038)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 13
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
	Play301021039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 301021039
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play301021040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 1.575

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(301021039)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 63
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_7 and arg_166_1.time_ < var_169_0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play301021040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 301021040
		arg_170_1.duration_ = 1

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"

			SetActive(arg_170_1.choicesGo_, true)

			for iter_171_0, iter_171_1 in ipairs(arg_170_1.choices_) do
				local var_171_0 = iter_171_0 <= 3

				SetActive(iter_171_1.go, var_171_0)
			end

			arg_170_1.choices_[1].txt.text = arg_170_1:FormatText(StoryChoiceCfg[1723].name)
			arg_170_1.choices_[2].txt.text = arg_170_1:FormatText(StoryChoiceCfg[1724].name)
			arg_170_1.choices_[3].txt.text = arg_170_1:FormatText(StoryChoiceCfg[1725].name)
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play301021041(arg_170_1)
			end

			if arg_172_0 == 2 then
				arg_170_0:Play301021041(arg_170_1)
			end

			if arg_172_0 == 3 then
				arg_170_0:Play301021041(arg_170_1)
			end

			arg_170_1:RecordChoiceLog(301021040, 1723, 1724, 1725)
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			local var_173_1 = 0.55

			if arg_170_1.time_ >= var_173_0 + var_173_1 and arg_170_1.time_ < var_173_0 + var_173_1 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play301021041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 301021041
		arg_174_1.duration_ = 5

		local var_174_0 = {
			zh = 2.833,
			ja = 5
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
				arg_174_0:Play301021042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 0.325

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[36].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(301021041)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 13
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021041", "story_v_out_301021.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021041", "story_v_out_301021.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_301021", "301021041", "story_v_out_301021.awb")

						arg_174_1:RecordAudio("301021041", var_177_9)
						arg_174_1:RecordAudio("301021041", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_301021", "301021041", "story_v_out_301021.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_301021", "301021041", "story_v_out_301021.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_10 and arg_174_1.time_ < var_177_0 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play301021042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 301021042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play301021043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1.625

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(301021042)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 65
				local var_181_5 = utf8.len(var_181_3)
				local var_181_6 = var_181_4 <= 0 and var_181_1 or var_181_1 * (var_181_5 / var_181_4)

				if var_181_6 > 0 and var_181_1 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_7 and arg_178_1.time_ < var_181_0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play301021043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 301021043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play301021044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.5

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(301021043)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 20
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play301021044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 301021044
		arg_186_1.duration_ = 4.1

		local var_186_0 = {
			zh = 3.333,
			ja = 4.1
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
				arg_186_0:Play301021045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = "1084ui_story"

			if arg_186_1.actors_[var_189_0] == nil then
				local var_189_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_189_1) then
					local var_189_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_186_1.stage_.transform)

					var_189_2.name = var_189_0
					var_189_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_186_1.actors_[var_189_0] = var_189_2

					local var_189_3 = var_189_2:GetComponentInChildren(typeof(CharacterEffect))

					var_189_3.enabled = true

					local var_189_4 = GameObjectTools.GetOrAddComponent(var_189_2, typeof(DynamicBoneHelper))

					if var_189_4 then
						var_189_4:EnableDynamicBone(false)
					end

					arg_186_1:ShowWeapon(var_189_3.transform, false)

					arg_186_1.var_[var_189_0 .. "Animator"] = var_189_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_186_1.var_[var_189_0 .. "Animator"].applyRootMotion = true
					arg_186_1.var_[var_189_0 .. "LipSync"] = var_189_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_189_5 = arg_186_1.actors_["1084ui_story"].transform
			local var_189_6 = 0

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = var_189_5.localPosition
			end

			local var_189_7 = 0.001

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_7 then
				local var_189_8 = (arg_186_1.time_ - var_189_6) / var_189_7
				local var_189_9 = Vector3.New(0, -0.97, -6)

				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, var_189_9, var_189_8)

				local var_189_10 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_10.x, var_189_10.y, var_189_10.z)

				local var_189_11 = var_189_5.localEulerAngles

				var_189_11.z = 0
				var_189_11.x = 0
				var_189_5.localEulerAngles = var_189_11
			end

			if arg_186_1.time_ >= var_189_6 + var_189_7 and arg_186_1.time_ < var_189_6 + var_189_7 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_189_12 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_12.x, var_189_12.y, var_189_12.z)

				local var_189_13 = var_189_5.localEulerAngles

				var_189_13.z = 0
				var_189_13.x = 0
				var_189_5.localEulerAngles = var_189_13
			end

			local var_189_14 = arg_186_1.actors_["1084ui_story"]
			local var_189_15 = 0

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1084ui_story == nil then
				arg_186_1.var_.characterEffect1084ui_story = var_189_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_16 = 0.200000002980232

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_16 and not isNil(var_189_14) then
				local var_189_17 = (arg_186_1.time_ - var_189_15) / var_189_16

				if arg_186_1.var_.characterEffect1084ui_story and not isNil(var_189_14) then
					arg_186_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_15 + var_189_16 and arg_186_1.time_ < var_189_15 + var_189_16 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1084ui_story then
				arg_186_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_189_18 = 0

			if var_189_18 < arg_186_1.time_ and arg_186_1.time_ <= var_189_18 + arg_189_0 then
				arg_186_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_189_19 = 0

			if var_189_19 < arg_186_1.time_ and arg_186_1.time_ <= var_189_19 + arg_189_0 then
				arg_186_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_20 = 0
			local var_189_21 = 0.375

			if var_189_20 < arg_186_1.time_ and arg_186_1.time_ <= var_189_20 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_22 = arg_186_1:FormatText(StoryNameCfg[6].name)

				arg_186_1.leftNameTxt_.text = var_189_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_23 = arg_186_1:GetWordFromCfg(301021044)
				local var_189_24 = arg_186_1:FormatText(var_189_23.content)

				arg_186_1.text_.text = var_189_24

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_25 = 15
				local var_189_26 = utf8.len(var_189_24)
				local var_189_27 = var_189_25 <= 0 and var_189_21 or var_189_21 * (var_189_26 / var_189_25)

				if var_189_27 > 0 and var_189_21 < var_189_27 then
					arg_186_1.talkMaxDuration = var_189_27

					if var_189_27 + var_189_20 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_27 + var_189_20
					end
				end

				arg_186_1.text_.text = var_189_24
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021044", "story_v_out_301021.awb") ~= 0 then
					local var_189_28 = manager.audio:GetVoiceLength("story_v_out_301021", "301021044", "story_v_out_301021.awb") / 1000

					if var_189_28 + var_189_20 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_28 + var_189_20
					end

					if var_189_23.prefab_name ~= "" and arg_186_1.actors_[var_189_23.prefab_name] ~= nil then
						local var_189_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_23.prefab_name].transform, "story_v_out_301021", "301021044", "story_v_out_301021.awb")

						arg_186_1:RecordAudio("301021044", var_189_29)
						arg_186_1:RecordAudio("301021044", var_189_29)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_301021", "301021044", "story_v_out_301021.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_301021", "301021044", "story_v_out_301021.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_30 = math.max(var_189_21, arg_186_1.talkMaxDuration)

			if var_189_20 <= arg_186_1.time_ and arg_186_1.time_ < var_189_20 + var_189_30 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_20) / var_189_30

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_20 + var_189_30 and arg_186_1.time_ < var_189_20 + var_189_30 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play301021045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 301021045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play301021046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1084ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1084ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1084ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1084ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.1

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

				local var_193_9 = arg_190_1:GetWordFromCfg(301021045)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 4
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
	Play301021046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 301021046
		arg_194_1.duration_ = 4.13

		local var_194_0 = {
			zh = 3.166,
			ja = 4.133
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
				arg_194_0:Play301021047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1084ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1084ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_197_4 = 0

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_197_5 = 0

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_197_6 = 0
			local var_197_7 = 0.45

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[6].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_9 = arg_194_1:GetWordFromCfg(301021046)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021046", "story_v_out_301021.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021046", "story_v_out_301021.awb") / 1000

					if var_197_14 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_6
					end

					if var_197_9.prefab_name ~= "" and arg_194_1.actors_[var_197_9.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_9.prefab_name].transform, "story_v_out_301021", "301021046", "story_v_out_301021.awb")

						arg_194_1:RecordAudio("301021046", var_197_15)
						arg_194_1:RecordAudio("301021046", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_301021", "301021046", "story_v_out_301021.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_301021", "301021046", "story_v_out_301021.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_16 and arg_194_1.time_ < var_197_6 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play301021047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 301021047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play301021048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1084ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1084ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1084ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1084ui_story.fillRatio = var_201_5
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

				local var_201_9 = arg_198_1:GetWordFromCfg(301021047)
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
	Play301021048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 301021048
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play301021049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1084ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1084ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1084ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = 0
			local var_205_10 = 1.475

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_11 = arg_202_1:GetWordFromCfg(301021048)
				local var_205_12 = arg_202_1:FormatText(var_205_11.content)

				arg_202_1.text_.text = var_205_12

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 59
				local var_205_14 = utf8.len(var_205_12)
				local var_205_15 = var_205_13 <= 0 and var_205_10 or var_205_10 * (var_205_14 / var_205_13)

				if var_205_15 > 0 and var_205_10 < var_205_15 then
					arg_202_1.talkMaxDuration = var_205_15

					if var_205_15 + var_205_9 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_15 + var_205_9
					end
				end

				arg_202_1.text_.text = var_205_12
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_10, arg_202_1.talkMaxDuration)

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_9) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_9 + var_205_16 and arg_202_1.time_ < var_205_9 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play301021049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 301021049
		arg_206_1.duration_ = 5.67

		local var_206_0 = {
			zh = 5.666,
			ja = 3.6
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
				arg_206_0:Play301021050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1084ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1084ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -0.97, -6)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1084ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1084ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1084ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1084ui_story then
				arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_209_15 = 0
			local var_209_16 = 0.425

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[6].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(301021049)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 17
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021049", "story_v_out_301021.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021049", "story_v_out_301021.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_301021", "301021049", "story_v_out_301021.awb")

						arg_206_1:RecordAudio("301021049", var_209_24)
						arg_206_1:RecordAudio("301021049", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_301021", "301021049", "story_v_out_301021.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_301021", "301021049", "story_v_out_301021.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play301021050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 301021050
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play301021051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1084ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1084ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1084ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 0.325

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

				local var_213_9 = arg_210_1:GetWordFromCfg(301021050)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 13
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
	Play301021051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 301021051
		arg_214_1.duration_ = 10.4

		local var_214_0 = {
			zh = 8,
			ja = 10.4
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
				arg_214_0:Play301021052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1084ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1084ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1084ui_story then
				arg_214_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_217_4 = 0

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_6 = 0
			local var_217_7 = 0.875

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[6].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:GetWordFromCfg(301021051)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 35
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021051", "story_v_out_301021.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021051", "story_v_out_301021.awb") / 1000

					if var_217_14 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_6
					end

					if var_217_9.prefab_name ~= "" and arg_214_1.actors_[var_217_9.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_9.prefab_name].transform, "story_v_out_301021", "301021051", "story_v_out_301021.awb")

						arg_214_1:RecordAudio("301021051", var_217_15)
						arg_214_1:RecordAudio("301021051", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_301021", "301021051", "story_v_out_301021.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_301021", "301021051", "story_v_out_301021.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_16 and arg_214_1.time_ < var_217_6 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play301021052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 301021052
		arg_218_1.duration_ = 11.1

		local var_218_0 = {
			zh = 9.9,
			ja = 11.1
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
				arg_218_0:Play301021053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_2 = 0
			local var_221_3 = 0.975

			if var_221_2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_4 = arg_218_1:FormatText(StoryNameCfg[6].name)

				arg_218_1.leftNameTxt_.text = var_221_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_5 = arg_218_1:GetWordFromCfg(301021052)
				local var_221_6 = arg_218_1:FormatText(var_221_5.content)

				arg_218_1.text_.text = var_221_6

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 39
				local var_221_8 = utf8.len(var_221_6)
				local var_221_9 = var_221_7 <= 0 and var_221_3 or var_221_3 * (var_221_8 / var_221_7)

				if var_221_9 > 0 and var_221_3 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_6
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021052", "story_v_out_301021.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_301021", "301021052", "story_v_out_301021.awb") / 1000

					if var_221_10 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_2
					end

					if var_221_5.prefab_name ~= "" and arg_218_1.actors_[var_221_5.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_5.prefab_name].transform, "story_v_out_301021", "301021052", "story_v_out_301021.awb")

						arg_218_1:RecordAudio("301021052", var_221_11)
						arg_218_1:RecordAudio("301021052", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_301021", "301021052", "story_v_out_301021.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_301021", "301021052", "story_v_out_301021.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_12 and arg_218_1.time_ < var_221_2 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play301021053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 301021053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play301021054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1084ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1084ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1084ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1084ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 1.775

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(301021053)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 71
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_7 or var_225_7 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_7 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_13 and arg_222_1.time_ < var_225_6 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play301021054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 301021054
		arg_226_1.duration_ = 4.33

		local var_226_0 = {
			zh = 4,
			ja = 4.333
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play301021055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_229_4 = 0

			if var_229_4 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_229_6 = 0
			local var_229_7 = 0.35

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[6].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:GetWordFromCfg(301021054)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021054", "story_v_out_301021.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021054", "story_v_out_301021.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_301021", "301021054", "story_v_out_301021.awb")

						arg_226_1:RecordAudio("301021054", var_229_15)
						arg_226_1:RecordAudio("301021054", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_301021", "301021054", "story_v_out_301021.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_301021", "301021054", "story_v_out_301021.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play301021055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 301021055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play301021056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1084ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_5
			end

			local var_233_6 = 0
			local var_233_7 = 1.15

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_8 = arg_230_1:GetWordFromCfg(301021055)
				local var_233_9 = arg_230_1:FormatText(var_233_8.content)

				arg_230_1.text_.text = var_233_9

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_10 = 46
				local var_233_11 = utf8.len(var_233_9)
				local var_233_12 = var_233_10 <= 0 and var_233_7 or var_233_7 * (var_233_11 / var_233_10)

				if var_233_12 > 0 and var_233_7 < var_233_12 then
					arg_230_1.talkMaxDuration = var_233_12

					if var_233_12 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_9
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_13 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_13

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_13 and arg_230_1.time_ < var_233_6 + var_233_13 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play301021056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 301021056
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 6.066,
			ja = 7
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
				arg_234_0:Play301021057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1084ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1084ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1084ui_story then
				arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_237_4 = 0

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_237_6 = 0
			local var_237_7 = 1

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				local var_237_8 = "play"
				local var_237_9 = "effect"

				arg_234_1:AudioAction(var_237_8, var_237_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_237_10 = 0
			local var_237_11 = 0.575

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_12 = arg_234_1:FormatText(StoryNameCfg[6].name)

				arg_234_1.leftNameTxt_.text = var_237_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_13 = arg_234_1:GetWordFromCfg(301021056)
				local var_237_14 = arg_234_1:FormatText(var_237_13.content)

				arg_234_1.text_.text = var_237_14

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_15 = 23
				local var_237_16 = utf8.len(var_237_14)
				local var_237_17 = var_237_15 <= 0 and var_237_11 or var_237_11 * (var_237_16 / var_237_15)

				if var_237_17 > 0 and var_237_11 < var_237_17 then
					arg_234_1.talkMaxDuration = var_237_17

					if var_237_17 + var_237_10 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_17 + var_237_10
					end
				end

				arg_234_1.text_.text = var_237_14
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021056", "story_v_out_301021.awb") ~= 0 then
					local var_237_18 = manager.audio:GetVoiceLength("story_v_out_301021", "301021056", "story_v_out_301021.awb") / 1000

					if var_237_18 + var_237_10 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_18 + var_237_10
					end

					if var_237_13.prefab_name ~= "" and arg_234_1.actors_[var_237_13.prefab_name] ~= nil then
						local var_237_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_13.prefab_name].transform, "story_v_out_301021", "301021056", "story_v_out_301021.awb")

						arg_234_1:RecordAudio("301021056", var_237_19)
						arg_234_1:RecordAudio("301021056", var_237_19)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_301021", "301021056", "story_v_out_301021.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_301021", "301021056", "story_v_out_301021.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_20 = math.max(var_237_11, arg_234_1.talkMaxDuration)

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_20 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_10) / var_237_20

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_10 + var_237_20 and arg_234_1.time_ < var_237_10 + var_237_20 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play301021057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 301021057
		arg_238_1.duration_ = 9

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play301021058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = "I27g"

			if arg_238_1.bgs_[var_241_0] == nil then
				local var_241_1 = Object.Instantiate(arg_238_1.paintGo_)

				var_241_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_241_0)
				var_241_1.name = var_241_0
				var_241_1.transform.parent = arg_238_1.stage_.transform
				var_241_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.bgs_[var_241_0] = var_241_1
			end

			local var_241_2 = 2

			if var_241_2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				local var_241_3 = manager.ui.mainCamera.transform.localPosition
				local var_241_4 = Vector3.New(0, 0, 10) + Vector3.New(var_241_3.x, var_241_3.y, 0)
				local var_241_5 = arg_238_1.bgs_.I27g

				var_241_5.transform.localPosition = var_241_4
				var_241_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_6 = var_241_5:GetComponent("SpriteRenderer")

				if var_241_6 and var_241_6.sprite then
					local var_241_7 = (var_241_5.transform.localPosition - var_241_3).z
					local var_241_8 = manager.ui.mainCameraCom_
					local var_241_9 = 2 * var_241_7 * Mathf.Tan(var_241_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_241_10 = var_241_9 * var_241_8.aspect
					local var_241_11 = var_241_6.sprite.bounds.size.x
					local var_241_12 = var_241_6.sprite.bounds.size.y
					local var_241_13 = var_241_10 / var_241_11
					local var_241_14 = var_241_9 / var_241_12
					local var_241_15 = var_241_14 < var_241_13 and var_241_13 or var_241_14

					var_241_5.transform.localScale = Vector3.New(var_241_15, var_241_15, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "I27g" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_16 = 3.999999999999

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			local var_241_17 = 0.3

			if arg_238_1.time_ >= var_241_16 + var_241_17 and arg_238_1.time_ < var_241_16 + var_241_17 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_18 = 0

			if var_241_18 < arg_238_1.time_ and arg_238_1.time_ <= var_241_18 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_19 = 2

			if var_241_18 <= arg_238_1.time_ and arg_238_1.time_ < var_241_18 + var_241_19 then
				local var_241_20 = (arg_238_1.time_ - var_241_18) / var_241_19
				local var_241_21 = Color.New(0, 0, 0)

				var_241_21.a = Mathf.Lerp(0, 1, var_241_20)
				arg_238_1.mask_.color = var_241_21
			end

			if arg_238_1.time_ >= var_241_18 + var_241_19 and arg_238_1.time_ < var_241_18 + var_241_19 + arg_241_0 then
				local var_241_22 = Color.New(0, 0, 0)

				var_241_22.a = 1
				arg_238_1.mask_.color = var_241_22
			end

			local var_241_23 = 2

			if var_241_23 < arg_238_1.time_ and arg_238_1.time_ <= var_241_23 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_24 = 2

			if var_241_23 <= arg_238_1.time_ and arg_238_1.time_ < var_241_23 + var_241_24 then
				local var_241_25 = (arg_238_1.time_ - var_241_23) / var_241_24
				local var_241_26 = Color.New(0, 0, 0)

				var_241_26.a = Mathf.Lerp(1, 0, var_241_25)
				arg_238_1.mask_.color = var_241_26
			end

			if arg_238_1.time_ >= var_241_23 + var_241_24 and arg_238_1.time_ < var_241_23 + var_241_24 + arg_241_0 then
				local var_241_27 = Color.New(0, 0, 0)
				local var_241_28 = 0

				arg_238_1.mask_.enabled = false
				var_241_27.a = var_241_28
				arg_238_1.mask_.color = var_241_27
			end

			local var_241_29 = arg_238_1.actors_["1084ui_story"].transform
			local var_241_30 = 1.96599999815226

			if var_241_30 < arg_238_1.time_ and arg_238_1.time_ <= var_241_30 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_29.localPosition
			end

			local var_241_31 = 0.001

			if var_241_30 <= arg_238_1.time_ and arg_238_1.time_ < var_241_30 + var_241_31 then
				local var_241_32 = (arg_238_1.time_ - var_241_30) / var_241_31
				local var_241_33 = Vector3.New(0, 100, 0)

				var_241_29.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, var_241_33, var_241_32)

				local var_241_34 = manager.ui.mainCamera.transform.position - var_241_29.position

				var_241_29.forward = Vector3.New(var_241_34.x, var_241_34.y, var_241_34.z)

				local var_241_35 = var_241_29.localEulerAngles

				var_241_35.z = 0
				var_241_35.x = 0
				var_241_29.localEulerAngles = var_241_35
			end

			if arg_238_1.time_ >= var_241_30 + var_241_31 and arg_238_1.time_ < var_241_30 + var_241_31 + arg_241_0 then
				var_241_29.localPosition = Vector3.New(0, 100, 0)

				local var_241_36 = manager.ui.mainCamera.transform.position - var_241_29.position

				var_241_29.forward = Vector3.New(var_241_36.x, var_241_36.y, var_241_36.z)

				local var_241_37 = var_241_29.localEulerAngles

				var_241_37.z = 0
				var_241_37.x = 0
				var_241_29.localEulerAngles = var_241_37
			end

			local var_241_38 = arg_238_1.actors_["1084ui_story"]
			local var_241_39 = 1.96599999815226

			if var_241_39 < arg_238_1.time_ and arg_238_1.time_ <= var_241_39 + arg_241_0 and not isNil(var_241_38) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_40 = 0.034000001847744

			if var_241_39 <= arg_238_1.time_ and arg_238_1.time_ < var_241_39 + var_241_40 and not isNil(var_241_38) then
				local var_241_41 = (arg_238_1.time_ - var_241_39) / var_241_40

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_38) then
					local var_241_42 = Mathf.Lerp(0, 0.5, var_241_41)

					arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1084ui_story.fillRatio = var_241_42
				end
			end

			if arg_238_1.time_ >= var_241_39 + var_241_40 and arg_238_1.time_ < var_241_39 + var_241_40 + arg_241_0 and not isNil(var_241_38) and arg_238_1.var_.characterEffect1084ui_story then
				local var_241_43 = 0.5

				arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1084ui_story.fillRatio = var_241_43
			end

			local var_241_44 = 1.2
			local var_241_45 = 1

			if var_241_44 < arg_238_1.time_ and arg_238_1.time_ <= var_241_44 + arg_241_0 then
				local var_241_46 = "play"
				local var_241_47 = "effect"

				arg_238_1:AudioAction(var_241_46, var_241_47, "se_story_121_04", "se_story_121_04_wind_loop", "")
			end

			local var_241_48 = 0.2
			local var_241_49 = 1

			if var_241_48 < arg_238_1.time_ and arg_238_1.time_ <= var_241_48 + arg_241_0 then
				local var_241_50 = "stop"
				local var_241_51 = "effect"

				arg_238_1:AudioAction(var_241_50, var_241_51, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_241_52 = 0
			local var_241_53 = 1

			if var_241_52 < arg_238_1.time_ and arg_238_1.time_ <= var_241_52 + arg_241_0 then
				local var_241_54 = "play"
				local var_241_55 = "music"

				arg_238_1:AudioAction(var_241_54, var_241_55, "bgm_activity_5_2_remake_ui_story", "bgm_activity_5_2_remake_ui_story", "bgm_activity_5_2_remake_ui_story.awb")

				local var_241_56 = ""
				local var_241_57 = MusicRecordCfg[465].musicName

				if var_241_57 ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_57 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_57

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_57
						arg_238_1.bgmTxt2_.text = var_241_57
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_58 = 4
			local var_241_59 = 1.35

			if var_241_58 < arg_238_1.time_ and arg_238_1.time_ <= var_241_58 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_60 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_60:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_238_1.dialogCg_.alpha = arg_243_0
				end))
				var_241_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_61 = arg_238_1:GetWordFromCfg(301021057)
				local var_241_62 = arg_238_1:FormatText(var_241_61.content)

				arg_238_1.text_.text = var_241_62

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_63 = 54
				local var_241_64 = utf8.len(var_241_62)
				local var_241_65 = var_241_63 <= 0 and var_241_59 or var_241_59 * (var_241_64 / var_241_63)

				if var_241_65 > 0 and var_241_59 < var_241_65 then
					arg_238_1.talkMaxDuration = var_241_65
					var_241_58 = var_241_58 + 0.3

					if var_241_65 + var_241_58 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_65 + var_241_58
					end
				end

				arg_238_1.text_.text = var_241_62
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_66 = var_241_58 + 0.3
			local var_241_67 = math.max(var_241_59, arg_238_1.talkMaxDuration)

			if var_241_66 <= arg_238_1.time_ and arg_238_1.time_ < var_241_66 + var_241_67 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_66) / var_241_67

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_66 + var_241_67 and arg_238_1.time_ < var_241_66 + var_241_67 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play301021058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 301021058
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play301021059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.525

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(301021058)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 61
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play301021059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 301021059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play301021060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = manager.ui.mainCamera.transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				local var_252_2 = arg_249_1.var_.effecthongse
				local var_252_3
				local var_252_4 = var_252_0

				if not var_252_2 then
					var_252_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error03_keep"), var_252_4)
					var_252_2.name = "hongse"
					arg_249_1.var_.effecthongse = var_252_2
				else
					var_252_2.transform:SetParent(var_252_4)
				end

				var_252_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_252_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_252_5 = 0
			local var_252_6 = 1.1

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(301021059)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 44
				local var_252_10 = utf8.len(var_252_8)
				local var_252_11 = var_252_9 <= 0 and var_252_6 or var_252_6 * (var_252_10 / var_252_9)

				if var_252_11 > 0 and var_252_6 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_12 and arg_249_1.time_ < var_252_5 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play301021060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 301021060
		arg_253_1.duration_ = 3.17

		local var_253_0 = {
			zh = 3.033,
			ja = 3.166
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
				arg_253_0:Play301021061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1084ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1084ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, -0.97, -6)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1084ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1084ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1084ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_15 = manager.ui.mainCamera.transform
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				local var_256_17 = arg_253_1.var_.effecthongse

				if var_256_17 then
					Object.Destroy(var_256_17)

					arg_253_1.var_.effecthongse = nil
				end
			end

			local var_256_18 = 0
			local var_256_19 = 0.65

			if var_256_18 < arg_253_1.time_ and arg_253_1.time_ <= var_256_18 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_20 = arg_253_1:FormatText(StoryNameCfg[6].name)

				arg_253_1.leftNameTxt_.text = var_256_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_21 = arg_253_1:GetWordFromCfg(301021060)
				local var_256_22 = arg_253_1:FormatText(var_256_21.content)

				arg_253_1.text_.text = var_256_22

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_23 = 26
				local var_256_24 = utf8.len(var_256_22)
				local var_256_25 = var_256_23 <= 0 and var_256_19 or var_256_19 * (var_256_24 / var_256_23)

				if var_256_25 > 0 and var_256_19 < var_256_25 then
					arg_253_1.talkMaxDuration = var_256_25

					if var_256_25 + var_256_18 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_25 + var_256_18
					end
				end

				arg_253_1.text_.text = var_256_22
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021060", "story_v_out_301021.awb") ~= 0 then
					local var_256_26 = manager.audio:GetVoiceLength("story_v_out_301021", "301021060", "story_v_out_301021.awb") / 1000

					if var_256_26 + var_256_18 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_26 + var_256_18
					end

					if var_256_21.prefab_name ~= "" and arg_253_1.actors_[var_256_21.prefab_name] ~= nil then
						local var_256_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_21.prefab_name].transform, "story_v_out_301021", "301021060", "story_v_out_301021.awb")

						arg_253_1:RecordAudio("301021060", var_256_27)
						arg_253_1:RecordAudio("301021060", var_256_27)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_301021", "301021060", "story_v_out_301021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_301021", "301021060", "story_v_out_301021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_28 = math.max(var_256_19, arg_253_1.talkMaxDuration)

			if var_256_18 <= arg_253_1.time_ and arg_253_1.time_ < var_256_18 + var_256_28 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_18) / var_256_28

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_18 + var_256_28 and arg_253_1.time_ < var_256_18 + var_256_28 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play301021061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 301021061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play301021062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1084ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1084ui_story and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1084ui_story.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1084ui_story.fillRatio = var_260_5
			end

			local var_260_6 = 0
			local var_260_7 = 0.35

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

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

				local var_260_9 = arg_257_1:GetWordFromCfg(301021061)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 14
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play301021062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 301021062
		arg_261_1.duration_ = 6.93

		local var_261_0 = {
			zh = 5.533,
			ja = 6.933
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
				arg_261_0:Play301021063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1084ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1084ui_story then
				arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 0.725

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_9 = arg_261_1:GetWordFromCfg(301021062)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 29
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021062", "story_v_out_301021.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021062", "story_v_out_301021.awb") / 1000

					if var_264_14 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_6
					end

					if var_264_9.prefab_name ~= "" and arg_261_1.actors_[var_264_9.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_9.prefab_name].transform, "story_v_out_301021", "301021062", "story_v_out_301021.awb")

						arg_261_1:RecordAudio("301021062", var_264_15)
						arg_261_1:RecordAudio("301021062", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_301021", "301021062", "story_v_out_301021.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_301021", "301021062", "story_v_out_301021.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_16 and arg_261_1.time_ < var_264_6 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play301021063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 301021063
		arg_265_1.duration_ = 4.9

		local var_265_0 = {
			zh = 3.4,
			ja = 4.9
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
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play301021064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.35

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(301021063)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021063", "story_v_out_301021.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021063", "story_v_out_301021.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_301021", "301021063", "story_v_out_301021.awb")

						arg_265_1:RecordAudio("301021063", var_268_9)
						arg_265_1:RecordAudio("301021063", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_301021", "301021063", "story_v_out_301021.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_301021", "301021063", "story_v_out_301021.awb")
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
	Play301021064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 301021064
		arg_269_1.duration_ = 1

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				local var_270_0 = iter_270_0 <= 2

				SetActive(iter_270_1.go, var_270_0)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1726].name)
			arg_269_1.choices_[2].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1727].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play301021065(arg_269_1)
			end

			if arg_271_0 == 2 then
				arg_269_0:Play301021065(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(301021064, 1726, 1727)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1084ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1084ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_5
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play301021065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 301021065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play301021066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 1.25

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_2 = arg_273_1:GetWordFromCfg(301021065)
				local var_276_3 = arg_273_1:FormatText(var_276_2.content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 50
				local var_276_5 = utf8.len(var_276_3)
				local var_276_6 = var_276_4 <= 0 and var_276_1 or var_276_1 * (var_276_5 / var_276_4)

				if var_276_6 > 0 and var_276_1 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_7 and arg_273_1.time_ < var_276_0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play301021066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 301021066
		arg_277_1.duration_ = 4.2

		local var_277_0 = {
			zh = 4.2,
			ja = 2.8
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play301021067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1084ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1084ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_280_4 = 0

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.2

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_8 = arg_277_1:FormatText(StoryNameCfg[6].name)

				arg_277_1.leftNameTxt_.text = var_280_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_9 = arg_277_1:GetWordFromCfg(301021066)
				local var_280_10 = arg_277_1:FormatText(var_280_9.content)

				arg_277_1.text_.text = var_280_10

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 8
				local var_280_12 = utf8.len(var_280_10)
				local var_280_13 = var_280_11 <= 0 and var_280_7 or var_280_7 * (var_280_12 / var_280_11)

				if var_280_13 > 0 and var_280_7 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_10
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021066", "story_v_out_301021.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021066", "story_v_out_301021.awb") / 1000

					if var_280_14 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_6
					end

					if var_280_9.prefab_name ~= "" and arg_277_1.actors_[var_280_9.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_9.prefab_name].transform, "story_v_out_301021", "301021066", "story_v_out_301021.awb")

						arg_277_1:RecordAudio("301021066", var_280_15)
						arg_277_1:RecordAudio("301021066", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_301021", "301021066", "story_v_out_301021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_301021", "301021066", "story_v_out_301021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_16 and arg_277_1.time_ < var_280_6 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play301021067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 301021067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play301021068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1084ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1084ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1084ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1084ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1084ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 0.05

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_8 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_9 = arg_281_1:GetWordFromCfg(301021067)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 2
				local var_284_12 = utf8.len(var_284_10)
				local var_284_13 = var_284_11 <= 0 and var_284_7 or var_284_7 * (var_284_12 / var_284_11)

				if var_284_13 > 0 and var_284_7 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_10
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play301021068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 301021068
		arg_285_1.duration_ = 6.1

		local var_285_0 = {
			zh = 5.2,
			ja = 6.1
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play301021069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1084ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_288_4 = 0

			if var_288_4 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_288_6 = 0
			local var_288_7 = 0.575

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[6].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_9 = arg_285_1:GetWordFromCfg(301021068)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 23
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021068", "story_v_out_301021.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021068", "story_v_out_301021.awb") / 1000

					if var_288_14 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_6
					end

					if var_288_9.prefab_name ~= "" and arg_285_1.actors_[var_288_9.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_9.prefab_name].transform, "story_v_out_301021", "301021068", "story_v_out_301021.awb")

						arg_285_1:RecordAudio("301021068", var_288_15)
						arg_285_1:RecordAudio("301021068", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_301021", "301021068", "story_v_out_301021.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_301021", "301021068", "story_v_out_301021.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_16 and arg_285_1.time_ < var_288_6 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play301021069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 301021069
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play301021070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1084ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1084ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1084ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1084ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1084ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.425

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(301021069)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 17
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play301021070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 301021070
		arg_293_1.duration_ = 3.93

		local var_293_0 = {
			zh = 2.966,
			ja = 3.933
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play301021071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1084ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1084ui_story then
				arg_293_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_296_4 = 0

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_296_6 = 0
			local var_296_7 = 0.275

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[6].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_9 = arg_293_1:GetWordFromCfg(301021070)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 11
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021070", "story_v_out_301021.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021070", "story_v_out_301021.awb") / 1000

					if var_296_14 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_6
					end

					if var_296_9.prefab_name ~= "" and arg_293_1.actors_[var_296_9.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_9.prefab_name].transform, "story_v_out_301021", "301021070", "story_v_out_301021.awb")

						arg_293_1:RecordAudio("301021070", var_296_15)
						arg_293_1:RecordAudio("301021070", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_301021", "301021070", "story_v_out_301021.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_301021", "301021070", "story_v_out_301021.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_16 and arg_293_1.time_ < var_296_6 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play301021071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 301021071
		arg_297_1.duration_ = 13.1

		local var_297_0 = {
			zh = 8.133,
			ja = 13.1
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play301021072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.125

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[6].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(301021071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 45
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021071", "story_v_out_301021.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021071", "story_v_out_301021.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_301021", "301021071", "story_v_out_301021.awb")

						arg_297_1:RecordAudio("301021071", var_300_9)
						arg_297_1:RecordAudio("301021071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_301021", "301021071", "story_v_out_301021.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_301021", "301021071", "story_v_out_301021.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play301021072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 301021072
		arg_301_1.duration_ = 8

		local var_301_0 = {
			zh = 6.533,
			ja = 8
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play301021073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_304_2 = 0
			local var_304_3 = 0.725

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_4 = arg_301_1:FormatText(StoryNameCfg[6].name)

				arg_301_1.leftNameTxt_.text = var_304_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:GetWordFromCfg(301021072)
				local var_304_6 = arg_301_1:FormatText(var_304_5.content)

				arg_301_1.text_.text = var_304_6

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 29
				local var_304_8 = utf8.len(var_304_6)
				local var_304_9 = var_304_7 <= 0 and var_304_3 or var_304_3 * (var_304_8 / var_304_7)

				if var_304_9 > 0 and var_304_3 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_6
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021072", "story_v_out_301021.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_301021", "301021072", "story_v_out_301021.awb") / 1000

					if var_304_10 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_2
					end

					if var_304_5.prefab_name ~= "" and arg_301_1.actors_[var_304_5.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_5.prefab_name].transform, "story_v_out_301021", "301021072", "story_v_out_301021.awb")

						arg_301_1:RecordAudio("301021072", var_304_11)
						arg_301_1:RecordAudio("301021072", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_301021", "301021072", "story_v_out_301021.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_301021", "301021072", "story_v_out_301021.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_12 and arg_301_1.time_ < var_304_2 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play301021073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 301021073
		arg_305_1.duration_ = 8

		local var_305_0 = {
			zh = 5.9,
			ja = 8
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play301021074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4123")
			end

			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_308_2 = 0
			local var_308_3 = 0.625

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_4 = arg_305_1:FormatText(StoryNameCfg[6].name)

				arg_305_1.leftNameTxt_.text = var_308_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:GetWordFromCfg(301021073)
				local var_308_6 = arg_305_1:FormatText(var_308_5.content)

				arg_305_1.text_.text = var_308_6

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 25
				local var_308_8 = utf8.len(var_308_6)
				local var_308_9 = var_308_7 <= 0 and var_308_3 or var_308_3 * (var_308_8 / var_308_7)

				if var_308_9 > 0 and var_308_3 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_6
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021073", "story_v_out_301021.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_301021", "301021073", "story_v_out_301021.awb") / 1000

					if var_308_10 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_2
					end

					if var_308_5.prefab_name ~= "" and arg_305_1.actors_[var_308_5.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_5.prefab_name].transform, "story_v_out_301021", "301021073", "story_v_out_301021.awb")

						arg_305_1:RecordAudio("301021073", var_308_11)
						arg_305_1:RecordAudio("301021073", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_301021", "301021073", "story_v_out_301021.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_301021", "301021073", "story_v_out_301021.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_12 and arg_305_1.time_ < var_308_2 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play301021074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 301021074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play301021075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1084ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1084ui_story == nil then
				arg_309_1.var_.characterEffect1084ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1084ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1084ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1084ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1084ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 0.05

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_9 = arg_309_1:GetWordFromCfg(301021074)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 2
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_14 and arg_309_1.time_ < var_312_6 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play301021075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 301021075
		arg_313_1.duration_ = 9.8

		local var_313_0 = {
			zh = 9.533,
			ja = 9.8
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
				arg_313_0:Play301021076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1084ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1084ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_316_6 = 0
			local var_316_7 = 1.05

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[6].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(301021075)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 42
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021075", "story_v_out_301021.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021075", "story_v_out_301021.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_out_301021", "301021075", "story_v_out_301021.awb")

						arg_313_1:RecordAudio("301021075", var_316_15)
						arg_313_1:RecordAudio("301021075", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_301021", "301021075", "story_v_out_301021.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_301021", "301021075", "story_v_out_301021.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play301021076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 301021076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play301021077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1084ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1084ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1084ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1084ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1084ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.175

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(301021076)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 7
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play301021077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 301021077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play301021078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1084ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1084ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, 100, 0)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1084ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, 100, 0)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = 0
			local var_324_10 = 1.325

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_11 = arg_321_1:GetWordFromCfg(301021077)
				local var_324_12 = arg_321_1:FormatText(var_324_11.content)

				arg_321_1.text_.text = var_324_12

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 53
				local var_324_14 = utf8.len(var_324_12)
				local var_324_15 = var_324_13 <= 0 and var_324_10 or var_324_10 * (var_324_14 / var_324_13)

				if var_324_15 > 0 and var_324_10 < var_324_15 then
					arg_321_1.talkMaxDuration = var_324_15

					if var_324_15 + var_324_9 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_15 + var_324_9
					end
				end

				arg_321_1.text_.text = var_324_12
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_10, arg_321_1.talkMaxDuration)

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_9) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_9 + var_324_16 and arg_321_1.time_ < var_324_9 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play301021078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 301021078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play301021079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.775

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(301021078)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 31
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
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play301021079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 301021079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play301021080(arg_329_1)
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

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(301021079)
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
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play301021080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 301021080
		arg_333_1.duration_ = 7.23

		local var_333_0 = {
			zh = 4.3,
			ja = 7.233
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
				arg_333_0:Play301021081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1084ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1084ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, -0.97, -6)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1084ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1084ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1084ui_story == nil then
				arg_333_1.var_.characterEffect1084ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1084ui_story and not isNil(var_336_9) then
					arg_333_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1084ui_story then
				arg_333_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_336_13 = 0

			if var_336_13 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_336_15 = 0
			local var_336_16 = 0.625

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_17 = arg_333_1:FormatText(StoryNameCfg[6].name)

				arg_333_1.leftNameTxt_.text = var_336_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:GetWordFromCfg(301021080)
				local var_336_19 = arg_333_1:FormatText(var_336_18.content)

				arg_333_1.text_.text = var_336_19

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 25
				local var_336_21 = utf8.len(var_336_19)
				local var_336_22 = var_336_20 <= 0 and var_336_16 or var_336_16 * (var_336_21 / var_336_20)

				if var_336_22 > 0 and var_336_16 < var_336_22 then
					arg_333_1.talkMaxDuration = var_336_22

					if var_336_22 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_22 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_19
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021080", "story_v_out_301021.awb") ~= 0 then
					local var_336_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021080", "story_v_out_301021.awb") / 1000

					if var_336_23 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_15
					end

					if var_336_18.prefab_name ~= "" and arg_333_1.actors_[var_336_18.prefab_name] ~= nil then
						local var_336_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_18.prefab_name].transform, "story_v_out_301021", "301021080", "story_v_out_301021.awb")

						arg_333_1:RecordAudio("301021080", var_336_24)
						arg_333_1:RecordAudio("301021080", var_336_24)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_301021", "301021080", "story_v_out_301021.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_301021", "301021080", "story_v_out_301021.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_25 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_25 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_25

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_25 and arg_333_1.time_ < var_336_15 + var_336_25 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play301021081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 301021081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play301021082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1084ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1084ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1084ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1084ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1084ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.625

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(301021081)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 25
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play301021082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 301021082
		arg_341_1.duration_ = 8.47

		local var_341_0 = {
			zh = 8.466,
			ja = 7.766
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
				arg_341_0:Play301021083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1084ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1084ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_344_4 = 0

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_344_6 = 0
			local var_344_7 = 0.925

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[6].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(301021082)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 37
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021082", "story_v_out_301021.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021082", "story_v_out_301021.awb") / 1000

					if var_344_14 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_6
					end

					if var_344_9.prefab_name ~= "" and arg_341_1.actors_[var_344_9.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_9.prefab_name].transform, "story_v_out_301021", "301021082", "story_v_out_301021.awb")

						arg_341_1:RecordAudio("301021082", var_344_15)
						arg_341_1:RecordAudio("301021082", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_301021", "301021082", "story_v_out_301021.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_301021", "301021082", "story_v_out_301021.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_16 and arg_341_1.time_ < var_344_6 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play301021083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 301021083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play301021084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1084ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1084ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1084ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1084ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1084ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.275

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(301021083)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 11
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play301021084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 301021084
		arg_349_1.duration_ = 8.8

		local var_349_0 = {
			zh = 6.5,
			ja = 8.8
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
				arg_349_0:Play301021085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1084ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1084ui_story then
				arg_349_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_352_4 = 0

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_352_6 = 0
			local var_352_7 = 0.75

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[6].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(301021084)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 30
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021084", "story_v_out_301021.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021084", "story_v_out_301021.awb") / 1000

					if var_352_14 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_6
					end

					if var_352_9.prefab_name ~= "" and arg_349_1.actors_[var_352_9.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_9.prefab_name].transform, "story_v_out_301021", "301021084", "story_v_out_301021.awb")

						arg_349_1:RecordAudio("301021084", var_352_15)
						arg_349_1:RecordAudio("301021084", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_301021", "301021084", "story_v_out_301021.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_301021", "301021084", "story_v_out_301021.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_16 and arg_349_1.time_ < var_352_6 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play301021085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 301021085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play301021086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1084ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1084ui_story == nil then
				arg_353_1.var_.characterEffect1084ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1084ui_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1084ui_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1084ui_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1084ui_story.fillRatio = var_356_5
			end

			local var_356_6 = 0
			local var_356_7 = 0.25

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_8 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_9 = arg_353_1:GetWordFromCfg(301021085)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 10
				local var_356_12 = utf8.len(var_356_10)
				local var_356_13 = var_356_11 <= 0 and var_356_7 or var_356_7 * (var_356_12 / var_356_11)

				if var_356_13 > 0 and var_356_7 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_14 and arg_353_1.time_ < var_356_6 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play301021086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 301021086
		arg_357_1.duration_ = 5.77

		local var_357_0 = {
			zh = 4.266,
			ja = 5.766
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play301021087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1084ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1084ui_story == nil then
				arg_357_1.var_.characterEffect1084ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1084ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1084ui_story then
				arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_360_4 = 0

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_6 = 0
			local var_360_7 = 0.55

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_8 = arg_357_1:FormatText(StoryNameCfg[6].name)

				arg_357_1.leftNameTxt_.text = var_360_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_9 = arg_357_1:GetWordFromCfg(301021086)
				local var_360_10 = arg_357_1:FormatText(var_360_9.content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 22
				local var_360_12 = utf8.len(var_360_10)
				local var_360_13 = var_360_11 <= 0 and var_360_7 or var_360_7 * (var_360_12 / var_360_11)

				if var_360_13 > 0 and var_360_7 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021086", "story_v_out_301021.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021086", "story_v_out_301021.awb") / 1000

					if var_360_14 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_6
					end

					if var_360_9.prefab_name ~= "" and arg_357_1.actors_[var_360_9.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_9.prefab_name].transform, "story_v_out_301021", "301021086", "story_v_out_301021.awb")

						arg_357_1:RecordAudio("301021086", var_360_15)
						arg_357_1:RecordAudio("301021086", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_301021", "301021086", "story_v_out_301021.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_301021", "301021086", "story_v_out_301021.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_16 and arg_357_1.time_ < var_360_6 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play301021087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 301021087
		arg_361_1.duration_ = 9

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play301021088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = "ST03a"

			if arg_361_1.bgs_[var_364_0] == nil then
				local var_364_1 = Object.Instantiate(arg_361_1.paintGo_)

				var_364_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_364_0)
				var_364_1.name = var_364_0
				var_364_1.transform.parent = arg_361_1.stage_.transform
				var_364_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.bgs_[var_364_0] = var_364_1
			end

			local var_364_2 = 2

			if var_364_2 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				local var_364_3 = manager.ui.mainCamera.transform.localPosition
				local var_364_4 = Vector3.New(0, 0, 10) + Vector3.New(var_364_3.x, var_364_3.y, 0)
				local var_364_5 = arg_361_1.bgs_.ST03a

				var_364_5.transform.localPosition = var_364_4
				var_364_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_364_6 = var_364_5:GetComponent("SpriteRenderer")

				if var_364_6 and var_364_6.sprite then
					local var_364_7 = (var_364_5.transform.localPosition - var_364_3).z
					local var_364_8 = manager.ui.mainCameraCom_
					local var_364_9 = 2 * var_364_7 * Mathf.Tan(var_364_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_364_10 = var_364_9 * var_364_8.aspect
					local var_364_11 = var_364_6.sprite.bounds.size.x
					local var_364_12 = var_364_6.sprite.bounds.size.y
					local var_364_13 = var_364_10 / var_364_11
					local var_364_14 = var_364_9 / var_364_12
					local var_364_15 = var_364_14 < var_364_13 and var_364_13 or var_364_14

					var_364_5.transform.localScale = Vector3.New(var_364_15, var_364_15, 0)
				end

				for iter_364_0, iter_364_1 in pairs(arg_361_1.bgs_) do
					if iter_364_0 ~= "ST03a" then
						iter_364_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_364_16 = 3.999999999999

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			local var_364_17 = 0.3

			if arg_361_1.time_ >= var_364_16 + var_364_17 and arg_361_1.time_ < var_364_16 + var_364_17 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_18 = 0

			if var_364_18 < arg_361_1.time_ and arg_361_1.time_ <= var_364_18 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_19 = 2

			if var_364_18 <= arg_361_1.time_ and arg_361_1.time_ < var_364_18 + var_364_19 then
				local var_364_20 = (arg_361_1.time_ - var_364_18) / var_364_19
				local var_364_21 = Color.New(0, 0, 0)

				var_364_21.a = Mathf.Lerp(0, 1, var_364_20)
				arg_361_1.mask_.color = var_364_21
			end

			if arg_361_1.time_ >= var_364_18 + var_364_19 and arg_361_1.time_ < var_364_18 + var_364_19 + arg_364_0 then
				local var_364_22 = Color.New(0, 0, 0)

				var_364_22.a = 1
				arg_361_1.mask_.color = var_364_22
			end

			local var_364_23 = 2

			if var_364_23 < arg_361_1.time_ and arg_361_1.time_ <= var_364_23 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_24 = 2

			if var_364_23 <= arg_361_1.time_ and arg_361_1.time_ < var_364_23 + var_364_24 then
				local var_364_25 = (arg_361_1.time_ - var_364_23) / var_364_24
				local var_364_26 = Color.New(0, 0, 0)

				var_364_26.a = Mathf.Lerp(1, 0, var_364_25)
				arg_361_1.mask_.color = var_364_26
			end

			if arg_361_1.time_ >= var_364_23 + var_364_24 and arg_361_1.time_ < var_364_23 + var_364_24 + arg_364_0 then
				local var_364_27 = Color.New(0, 0, 0)
				local var_364_28 = 0

				arg_361_1.mask_.enabled = false
				var_364_27.a = var_364_28
				arg_361_1.mask_.color = var_364_27
			end

			local var_364_29 = arg_361_1.actors_["1084ui_story"].transform
			local var_364_30 = 1.96599999815226

			if var_364_30 < arg_361_1.time_ and arg_361_1.time_ <= var_364_30 + arg_364_0 then
				arg_361_1.var_.moveOldPos1084ui_story = var_364_29.localPosition
			end

			local var_364_31 = 0.001

			if var_364_30 <= arg_361_1.time_ and arg_361_1.time_ < var_364_30 + var_364_31 then
				local var_364_32 = (arg_361_1.time_ - var_364_30) / var_364_31
				local var_364_33 = Vector3.New(0, 100, 0)

				var_364_29.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1084ui_story, var_364_33, var_364_32)

				local var_364_34 = manager.ui.mainCamera.transform.position - var_364_29.position

				var_364_29.forward = Vector3.New(var_364_34.x, var_364_34.y, var_364_34.z)

				local var_364_35 = var_364_29.localEulerAngles

				var_364_35.z = 0
				var_364_35.x = 0
				var_364_29.localEulerAngles = var_364_35
			end

			if arg_361_1.time_ >= var_364_30 + var_364_31 and arg_361_1.time_ < var_364_30 + var_364_31 + arg_364_0 then
				var_364_29.localPosition = Vector3.New(0, 100, 0)

				local var_364_36 = manager.ui.mainCamera.transform.position - var_364_29.position

				var_364_29.forward = Vector3.New(var_364_36.x, var_364_36.y, var_364_36.z)

				local var_364_37 = var_364_29.localEulerAngles

				var_364_37.z = 0
				var_364_37.x = 0
				var_364_29.localEulerAngles = var_364_37
			end

			local var_364_38 = arg_361_1.actors_["1084ui_story"]
			local var_364_39 = 1.96599999815226

			if var_364_39 < arg_361_1.time_ and arg_361_1.time_ <= var_364_39 + arg_364_0 and not isNil(var_364_38) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = var_364_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_40 = 0.0166666666666667

			if var_364_39 <= arg_361_1.time_ and arg_361_1.time_ < var_364_39 + var_364_40 and not isNil(var_364_38) then
				local var_364_41 = (arg_361_1.time_ - var_364_39) / var_364_40

				if arg_361_1.var_.characterEffect1084ui_story and not isNil(var_364_38) then
					local var_364_42 = Mathf.Lerp(0, 0.5, var_364_41)

					arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1084ui_story.fillRatio = var_364_42
				end
			end

			if arg_361_1.time_ >= var_364_39 + var_364_40 and arg_361_1.time_ < var_364_39 + var_364_40 + arg_364_0 and not isNil(var_364_38) and arg_361_1.var_.characterEffect1084ui_story then
				local var_364_43 = 0.5

				arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1084ui_story.fillRatio = var_364_43
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_44 = 3.999999999999
			local var_364_45 = 1.6

			if var_364_44 < arg_361_1.time_ and arg_361_1.time_ <= var_364_44 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_46 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_46:setOnUpdate(LuaHelper.FloatAction(function(arg_365_0)
					arg_361_1.dialogCg_.alpha = arg_365_0
				end))
				var_364_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_47 = arg_361_1:GetWordFromCfg(301021087)
				local var_364_48 = arg_361_1:FormatText(var_364_47.content)

				arg_361_1.text_.text = var_364_48

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_49 = 64
				local var_364_50 = utf8.len(var_364_48)
				local var_364_51 = var_364_49 <= 0 and var_364_45 or var_364_45 * (var_364_50 / var_364_49)

				if var_364_51 > 0 and var_364_45 < var_364_51 then
					arg_361_1.talkMaxDuration = var_364_51
					var_364_44 = var_364_44 + 0.3

					if var_364_51 + var_364_44 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_51 + var_364_44
					end
				end

				arg_361_1.text_.text = var_364_48
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_52 = var_364_44 + 0.3
			local var_364_53 = math.max(var_364_45, arg_361_1.talkMaxDuration)

			if var_364_52 <= arg_361_1.time_ and arg_361_1.time_ < var_364_52 + var_364_53 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_52) / var_364_53

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_52 + var_364_53 and arg_361_1.time_ < var_364_52 + var_364_53 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play301021088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 301021088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play301021089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.55

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(301021088)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 62
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play301021089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 301021089
		arg_371_1.duration_ = 2.27

		local var_371_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_371_0:Play301021090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1084ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1084ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -0.97, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1084ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1084ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1084ui_story == nil then
				arg_371_1.var_.characterEffect1084ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1084ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1084ui_story then
				arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_374_15 = 0
			local var_374_16 = 0.175

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[6].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(301021089)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 7
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021089", "story_v_out_301021.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021089", "story_v_out_301021.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_301021", "301021089", "story_v_out_301021.awb")

						arg_371_1:RecordAudio("301021089", var_374_24)
						arg_371_1:RecordAudio("301021089", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_301021", "301021089", "story_v_out_301021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_301021", "301021089", "story_v_out_301021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play301021090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 301021090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play301021091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1084ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1084ui_story == nil then
				arg_375_1.var_.characterEffect1084ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1084ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1084ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1084ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1084ui_story.fillRatio = var_378_5
			end

			local var_378_6 = 0
			local var_378_7 = 0.15

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_8 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_9 = arg_375_1:GetWordFromCfg(301021090)
				local var_378_10 = arg_375_1:FormatText(var_378_9.content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 6
				local var_378_12 = utf8.len(var_378_10)
				local var_378_13 = var_378_11 <= 0 and var_378_7 or var_378_7 * (var_378_12 / var_378_11)

				if var_378_13 > 0 and var_378_7 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_10
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_14 and arg_375_1.time_ < var_378_6 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play301021091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 301021091
		arg_379_1.duration_ = 3.1

		local var_379_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_379_0:Play301021092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1084ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1084ui_story == nil then
				arg_379_1.var_.characterEffect1084ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1084ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1084ui_story then
				arg_379_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_382_6 = 0
			local var_382_7 = 0.225

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[6].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_9 = arg_379_1:GetWordFromCfg(301021091)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 7
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021091", "story_v_out_301021.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_301021", "301021091", "story_v_out_301021.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_out_301021", "301021091", "story_v_out_301021.awb")

						arg_379_1:RecordAudio("301021091", var_382_15)
						arg_379_1:RecordAudio("301021091", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_301021", "301021091", "story_v_out_301021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_301021", "301021091", "story_v_out_301021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play301021092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 301021092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play301021093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1084ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1084ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, 100, 0)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1084ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, 100, 0)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["1084ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1084ui_story == nil then
				arg_383_1.var_.characterEffect1084ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect1084ui_story and not isNil(var_386_9) then
					local var_386_13 = Mathf.Lerp(0, 0.5, var_386_12)

					arg_383_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1084ui_story.fillRatio = var_386_13
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1084ui_story then
				local var_386_14 = 0.5

				arg_383_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1084ui_story.fillRatio = var_386_14
			end

			local var_386_15 = 0
			local var_386_16 = 1

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_17 = arg_383_1:GetWordFromCfg(301021092)
				local var_386_18 = arg_383_1:FormatText(var_386_17.content)

				arg_383_1.text_.text = var_386_18

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_19 = 40
				local var_386_20 = utf8.len(var_386_18)
				local var_386_21 = var_386_19 <= 0 and var_386_16 or var_386_16 * (var_386_20 / var_386_19)

				if var_386_21 > 0 and var_386_16 < var_386_21 then
					arg_383_1.talkMaxDuration = var_386_21

					if var_386_21 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_21 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_18
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_22 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_22 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_22

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_22 and arg_383_1.time_ < var_386_15 + var_386_22 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play301021093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 301021093
		arg_387_1.duration_ = 10.7

		local var_387_0 = {
			zh = 8.9,
			ja = 10.7
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
				arg_387_0:Play301021094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1084ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1084ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(0, -0.97, -6)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1084ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1084ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1084ui_story == nil then
				arg_387_1.var_.characterEffect1084ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1084ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1084ui_story then
				arg_387_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_390_14 = 0

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_390_15 = 0
			local var_390_16 = 0.95

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[6].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(301021093)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 38
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_16 or var_390_16 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_16 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22

					if var_390_22 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_15
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021093", "story_v_out_301021.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021093", "story_v_out_301021.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_301021", "301021093", "story_v_out_301021.awb")

						arg_387_1:RecordAudio("301021093", var_390_24)
						arg_387_1:RecordAudio("301021093", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_301021", "301021093", "story_v_out_301021.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_301021", "301021093", "story_v_out_301021.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = math.max(var_390_16, arg_387_1.talkMaxDuration)

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_25 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_15) / var_390_25

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_15 + var_390_25 and arg_387_1.time_ < var_390_15 + var_390_25 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play301021094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 301021094
		arg_391_1.duration_ = 11.85

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play301021095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1084ui_story"].transform
			local var_394_1 = 2

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1084ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, 100, 0)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1084ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, 100, 0)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = arg_391_1.actors_["1084ui_story"]
			local var_394_10 = 2

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1084ui_story == nil then
				arg_391_1.var_.characterEffect1084ui_story = var_394_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_11 = 0.034000001847744

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 and not isNil(var_394_9) then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11

				if arg_391_1.var_.characterEffect1084ui_story and not isNil(var_394_9) then
					local var_394_13 = Mathf.Lerp(0, 0.5, var_394_12)

					arg_391_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1084ui_story.fillRatio = var_394_13
				end
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1084ui_story then
				local var_394_14 = 0.5

				arg_391_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1084ui_story.fillRatio = var_394_14
			end

			local var_394_15 = 2
			local var_394_16 = 4.5
			local var_394_17 = "ST03a"

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.timestampController_:SetSelectedState("show")
				arg_391_1.timestampAni_:Play("in")

				arg_391_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_394_17)

				arg_391_1.timestampColorController_:SetSelectedState("cold")
				arg_391_1.timeColdImg_:SetAlpha(0.031)

				local var_394_18 = arg_391_1:GetWordFromCfg(501135)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_timeText_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_timeText_)

				local var_394_20 = arg_391_1:GetWordFromCfg(501136)
				local var_394_21 = arg_391_1:FormatText(var_394_20.content)

				arg_391_1.text_siteText_.text = var_394_21

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_siteText_)
			end

			if arg_391_1.time_ >= var_394_15 + var_394_16 and arg_391_1.time_ < var_394_15 + var_394_16 + arg_394_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_391_1.timestampAni_, "out", function()
					arg_391_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_394_22 = 0

			if var_394_22 < arg_391_1.time_ and arg_391_1.time_ <= var_394_22 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_23 = 2

			if var_394_22 <= arg_391_1.time_ and arg_391_1.time_ < var_394_22 + var_394_23 then
				local var_394_24 = (arg_391_1.time_ - var_394_22) / var_394_23
				local var_394_25 = Color.New(0, 0, 0)

				var_394_25.a = Mathf.Lerp(0, 1, var_394_24)
				arg_391_1.mask_.color = var_394_25
			end

			if arg_391_1.time_ >= var_394_22 + var_394_23 and arg_391_1.time_ < var_394_22 + var_394_23 + arg_394_0 then
				local var_394_26 = Color.New(0, 0, 0)

				var_394_26.a = 1
				arg_391_1.mask_.color = var_394_26
			end

			local var_394_27 = 2

			if var_394_27 < arg_391_1.time_ and arg_391_1.time_ <= var_394_27 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_28 = 2

			if var_394_27 <= arg_391_1.time_ and arg_391_1.time_ < var_394_27 + var_394_28 then
				local var_394_29 = (arg_391_1.time_ - var_394_27) / var_394_28
				local var_394_30 = Color.New(0, 0, 0)

				var_394_30.a = Mathf.Lerp(1, 0, var_394_29)
				arg_391_1.mask_.color = var_394_30
			end

			if arg_391_1.time_ >= var_394_27 + var_394_28 and arg_391_1.time_ < var_394_27 + var_394_28 + arg_394_0 then
				local var_394_31 = Color.New(0, 0, 0)
				local var_394_32 = 0

				arg_391_1.mask_.enabled = false
				var_394_31.a = var_394_32
				arg_391_1.mask_.color = var_394_31
			end

			local var_394_33 = 5.3

			if var_394_33 < arg_391_1.time_ and arg_391_1.time_ <= var_394_33 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_34 = 1.2

			if var_394_33 <= arg_391_1.time_ and arg_391_1.time_ < var_394_33 + var_394_34 then
				local var_394_35 = (arg_391_1.time_ - var_394_33) / var_394_34
				local var_394_36 = Color.New(0, 0, 0)

				var_394_36.a = Mathf.Lerp(0, 1, var_394_35)
				arg_391_1.mask_.color = var_394_36
			end

			if arg_391_1.time_ >= var_394_33 + var_394_34 and arg_391_1.time_ < var_394_33 + var_394_34 + arg_394_0 then
				local var_394_37 = Color.New(0, 0, 0)

				var_394_37.a = 1
				arg_391_1.mask_.color = var_394_37
			end

			local var_394_38 = 6.5

			if var_394_38 < arg_391_1.time_ and arg_391_1.time_ <= var_394_38 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_39 = 1.5

			if var_394_38 <= arg_391_1.time_ and arg_391_1.time_ < var_394_38 + var_394_39 then
				local var_394_40 = (arg_391_1.time_ - var_394_38) / var_394_39
				local var_394_41 = Color.New(0, 0, 0)

				var_394_41.a = Mathf.Lerp(1, 0, var_394_40)
				arg_391_1.mask_.color = var_394_41
			end

			if arg_391_1.time_ >= var_394_38 + var_394_39 and arg_391_1.time_ < var_394_38 + var_394_39 + arg_394_0 then
				local var_394_42 = Color.New(0, 0, 0)
				local var_394_43 = 0

				arg_391_1.mask_.enabled = false
				var_394_42.a = var_394_43
				arg_391_1.mask_.color = var_394_42
			end

			local var_394_44 = 0

			if var_394_44 < arg_391_1.time_ and arg_391_1.time_ <= var_394_44 + arg_394_0 then
				arg_391_1.allBtn_.enabled = false
			end

			local var_394_45 = 6.46666666666667

			if arg_391_1.time_ >= var_394_44 + var_394_45 and arg_391_1.time_ < var_394_44 + var_394_45 + arg_394_0 then
				arg_391_1.allBtn_.enabled = true
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_46 = 6.85
			local var_394_47 = 2.78333333333333

			if var_394_46 < arg_391_1.time_ and arg_391_1.time_ <= var_394_46 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_48 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_48:setOnUpdate(LuaHelper.FloatAction(function(arg_396_0)
					arg_391_1.dialogCg_.alpha = arg_396_0
				end))
				var_394_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_49 = arg_391_1:GetWordFromCfg(301021094)
				local var_394_50 = arg_391_1:FormatText(var_394_49.content)

				arg_391_1.text_.text = var_394_50

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_51 = 63
				local var_394_52 = utf8.len(var_394_50)
				local var_394_53 = var_394_51 <= 0 and var_394_47 or var_394_47 * (var_394_52 / var_394_51)

				if var_394_53 > 0 and var_394_47 < var_394_53 then
					arg_391_1.talkMaxDuration = var_394_53
					var_394_46 = var_394_46 + 0.3

					if var_394_53 + var_394_46 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_53 + var_394_46
					end
				end

				arg_391_1.text_.text = var_394_50
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_54 = var_394_46 + 0.3
			local var_394_55 = math.max(var_394_47, arg_391_1.talkMaxDuration)

			if var_394_54 <= arg_391_1.time_ and arg_391_1.time_ < var_394_54 + var_394_55 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_54) / var_394_55

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_54 + var_394_55 and arg_391_1.time_ < var_394_54 + var_394_55 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play301021095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 301021095
		arg_398_1.duration_ = 5.47

		local var_398_0 = {
			zh = 4.3,
			ja = 5.466
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play301021096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1084ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1084ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, -0.97, -6)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1084ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["1084ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1084ui_story == nil then
				arg_398_1.var_.characterEffect1084ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect1084ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1084ui_story then
				arg_398_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_401_13 = 0

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_15 = 0
			local var_401_16 = 0.45

			if var_401_15 < arg_398_1.time_ and arg_398_1.time_ <= var_401_15 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_17 = arg_398_1:FormatText(StoryNameCfg[6].name)

				arg_398_1.leftNameTxt_.text = var_401_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_18 = arg_398_1:GetWordFromCfg(301021095)
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

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021095", "story_v_out_301021.awb") ~= 0 then
					local var_401_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021095", "story_v_out_301021.awb") / 1000

					if var_401_23 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_15
					end

					if var_401_18.prefab_name ~= "" and arg_398_1.actors_[var_401_18.prefab_name] ~= nil then
						local var_401_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_18.prefab_name].transform, "story_v_out_301021", "301021095", "story_v_out_301021.awb")

						arg_398_1:RecordAudio("301021095", var_401_24)
						arg_398_1:RecordAudio("301021095", var_401_24)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_301021", "301021095", "story_v_out_301021.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_301021", "301021095", "story_v_out_301021.awb")
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
				actorName = "1084ui_story",
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
	Play301021096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 301021096
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play301021097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1084ui_story"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = var_405_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.characterEffect1084ui_story and not isNil(var_405_0) then
					local var_405_4 = Mathf.Lerp(0, 0.5, var_405_3)

					arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1084ui_story.fillRatio = var_405_4
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1084ui_story then
				local var_405_5 = 0.5

				arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1084ui_story.fillRatio = var_405_5
			end

			local var_405_6 = 0
			local var_405_7 = 0.65

			if var_405_6 < arg_402_1.time_ and arg_402_1.time_ <= var_405_6 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_8 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_9 = arg_402_1:GetWordFromCfg(301021096)
				local var_405_10 = arg_402_1:FormatText(var_405_9.content)

				arg_402_1.text_.text = var_405_10

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_11 = 26
				local var_405_12 = utf8.len(var_405_10)
				local var_405_13 = var_405_11 <= 0 and var_405_7 or var_405_7 * (var_405_12 / var_405_11)

				if var_405_13 > 0 and var_405_7 < var_405_13 then
					arg_402_1.talkMaxDuration = var_405_13

					if var_405_13 + var_405_6 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_13 + var_405_6
					end
				end

				arg_402_1.text_.text = var_405_10
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_14 = math.max(var_405_7, arg_402_1.talkMaxDuration)

			if var_405_6 <= arg_402_1.time_ and arg_402_1.time_ < var_405_6 + var_405_14 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_6) / var_405_14

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_6 + var_405_14 and arg_402_1.time_ < var_405_6 + var_405_14 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play301021097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 301021097
		arg_406_1.duration_ = 5.83

		local var_406_0 = {
			zh = 4.833,
			ja = 5.833
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
				arg_406_0:Play301021098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1084ui_story"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1084ui_story = var_409_0.localPosition
			end

			local var_409_2 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2
				local var_409_4 = Vector3.New(0, -0.97, -6)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1084ui_story, var_409_4, var_409_3)

				local var_409_5 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_5.x, var_409_5.y, var_409_5.z)

				local var_409_6 = var_409_0.localEulerAngles

				var_409_6.z = 0
				var_409_6.x = 0
				var_409_0.localEulerAngles = var_409_6
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_409_7 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_7.x, var_409_7.y, var_409_7.z)

				local var_409_8 = var_409_0.localEulerAngles

				var_409_8.z = 0
				var_409_8.x = 0
				var_409_0.localEulerAngles = var_409_8
			end

			local var_409_9 = arg_406_1.actors_["1084ui_story"]
			local var_409_10 = 0

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1084ui_story == nil then
				arg_406_1.var_.characterEffect1084ui_story = var_409_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_11 = 0.200000002980232

			if var_409_10 <= arg_406_1.time_ and arg_406_1.time_ < var_409_10 + var_409_11 and not isNil(var_409_9) then
				local var_409_12 = (arg_406_1.time_ - var_409_10) / var_409_11

				if arg_406_1.var_.characterEffect1084ui_story and not isNil(var_409_9) then
					arg_406_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_10 + var_409_11 and arg_406_1.time_ < var_409_10 + var_409_11 + arg_409_0 and not isNil(var_409_9) and arg_406_1.var_.characterEffect1084ui_story then
				arg_406_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_409_13 = 0

			if var_409_13 < arg_406_1.time_ and arg_406_1.time_ <= var_409_13 + arg_409_0 then
				arg_406_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_409_14 = 0

			if var_409_14 < arg_406_1.time_ and arg_406_1.time_ <= var_409_14 + arg_409_0 then
				arg_406_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_409_15 = 0
			local var_409_16 = 0.475

			if var_409_15 < arg_406_1.time_ and arg_406_1.time_ <= var_409_15 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_17 = arg_406_1:FormatText(StoryNameCfg[6].name)

				arg_406_1.leftNameTxt_.text = var_409_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_18 = arg_406_1:GetWordFromCfg(301021097)
				local var_409_19 = arg_406_1:FormatText(var_409_18.content)

				arg_406_1.text_.text = var_409_19

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_20 = 19
				local var_409_21 = utf8.len(var_409_19)
				local var_409_22 = var_409_20 <= 0 and var_409_16 or var_409_16 * (var_409_21 / var_409_20)

				if var_409_22 > 0 and var_409_16 < var_409_22 then
					arg_406_1.talkMaxDuration = var_409_22

					if var_409_22 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_22 + var_409_15
					end
				end

				arg_406_1.text_.text = var_409_19
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021097", "story_v_out_301021.awb") ~= 0 then
					local var_409_23 = manager.audio:GetVoiceLength("story_v_out_301021", "301021097", "story_v_out_301021.awb") / 1000

					if var_409_23 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_15
					end

					if var_409_18.prefab_name ~= "" and arg_406_1.actors_[var_409_18.prefab_name] ~= nil then
						local var_409_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_18.prefab_name].transform, "story_v_out_301021", "301021097", "story_v_out_301021.awb")

						arg_406_1:RecordAudio("301021097", var_409_24)
						arg_406_1:RecordAudio("301021097", var_409_24)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_301021", "301021097", "story_v_out_301021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_301021", "301021097", "story_v_out_301021.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_25 = math.max(var_409_16, arg_406_1.talkMaxDuration)

			if var_409_15 <= arg_406_1.time_ and arg_406_1.time_ < var_409_15 + var_409_25 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_15) / var_409_25

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_15 + var_409_25 and arg_406_1.time_ < var_409_15 + var_409_25 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play301021098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 301021098
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play301021099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1084ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1084ui_story == nil then
				arg_410_1.var_.characterEffect1084ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1084ui_story and not isNil(var_413_0) then
					local var_413_4 = Mathf.Lerp(0, 0.5, var_413_3)

					arg_410_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1084ui_story.fillRatio = var_413_4
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1084ui_story then
				local var_413_5 = 0.5

				arg_410_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1084ui_story.fillRatio = var_413_5
			end

			local var_413_6 = arg_410_1.actors_["1084ui_story"].transform
			local var_413_7 = 0

			if var_413_7 < arg_410_1.time_ and arg_410_1.time_ <= var_413_7 + arg_413_0 then
				arg_410_1.var_.moveOldPos1084ui_story = var_413_6.localPosition
			end

			local var_413_8 = 0.001

			if var_413_7 <= arg_410_1.time_ and arg_410_1.time_ < var_413_7 + var_413_8 then
				local var_413_9 = (arg_410_1.time_ - var_413_7) / var_413_8
				local var_413_10 = Vector3.New(0, 100, 0)

				var_413_6.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1084ui_story, var_413_10, var_413_9)

				local var_413_11 = manager.ui.mainCamera.transform.position - var_413_6.position

				var_413_6.forward = Vector3.New(var_413_11.x, var_413_11.y, var_413_11.z)

				local var_413_12 = var_413_6.localEulerAngles

				var_413_12.z = 0
				var_413_12.x = 0
				var_413_6.localEulerAngles = var_413_12
			end

			if arg_410_1.time_ >= var_413_7 + var_413_8 and arg_410_1.time_ < var_413_7 + var_413_8 + arg_413_0 then
				var_413_6.localPosition = Vector3.New(0, 100, 0)

				local var_413_13 = manager.ui.mainCamera.transform.position - var_413_6.position

				var_413_6.forward = Vector3.New(var_413_13.x, var_413_13.y, var_413_13.z)

				local var_413_14 = var_413_6.localEulerAngles

				var_413_14.z = 0
				var_413_14.x = 0
				var_413_6.localEulerAngles = var_413_14
			end

			local var_413_15 = 0
			local var_413_16 = 1.425

			if var_413_15 < arg_410_1.time_ and arg_410_1.time_ <= var_413_15 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_17 = arg_410_1:GetWordFromCfg(301021098)
				local var_413_18 = arg_410_1:FormatText(var_413_17.content)

				arg_410_1.text_.text = var_413_18

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_19 = 57
				local var_413_20 = utf8.len(var_413_18)
				local var_413_21 = var_413_19 <= 0 and var_413_16 or var_413_16 * (var_413_20 / var_413_19)

				if var_413_21 > 0 and var_413_16 < var_413_21 then
					arg_410_1.talkMaxDuration = var_413_21

					if var_413_21 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_21 + var_413_15
					end
				end

				arg_410_1.text_.text = var_413_18
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_22 = math.max(var_413_16, arg_410_1.talkMaxDuration)

			if var_413_15 <= arg_410_1.time_ and arg_410_1.time_ < var_413_15 + var_413_22 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_15) / var_413_22

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_15 + var_413_22 and arg_410_1.time_ < var_413_15 + var_413_22 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play301021099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 301021099
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play301021100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.2

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(301021099)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 8
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play301021100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 301021100
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play301021101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 1.2

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(301021100)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 48
				local var_421_5 = utf8.len(var_421_3)
				local var_421_6 = var_421_4 <= 0 and var_421_1 or var_421_1 * (var_421_5 / var_421_4)

				if var_421_6 > 0 and var_421_1 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_7 and arg_418_1.time_ < var_421_0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play301021101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 301021101
		arg_422_1.duration_ = 8.23

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play301021102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = "MS0101"

			if arg_422_1.bgs_[var_425_0] == nil then
				local var_425_1 = Object.Instantiate(arg_422_1.paintGo_)

				var_425_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_425_0)
				var_425_1.name = var_425_0
				var_425_1.transform.parent = arg_422_1.stage_.transform
				var_425_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.bgs_[var_425_0] = var_425_1
			end

			local var_425_2 = 1.23333333333333

			if var_425_2 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				local var_425_3 = manager.ui.mainCamera.transform.localPosition
				local var_425_4 = Vector3.New(0, 0, 10) + Vector3.New(var_425_3.x, var_425_3.y, 0)
				local var_425_5 = arg_422_1.bgs_.MS0101

				var_425_5.transform.localPosition = var_425_4
				var_425_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_425_6 = var_425_5:GetComponent("SpriteRenderer")

				if var_425_6 and var_425_6.sprite then
					local var_425_7 = (var_425_5.transform.localPosition - var_425_3).z
					local var_425_8 = manager.ui.mainCameraCom_
					local var_425_9 = 2 * var_425_7 * Mathf.Tan(var_425_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_425_10 = var_425_9 * var_425_8.aspect
					local var_425_11 = var_425_6.sprite.bounds.size.x
					local var_425_12 = var_425_6.sprite.bounds.size.y
					local var_425_13 = var_425_10 / var_425_11
					local var_425_14 = var_425_9 / var_425_12
					local var_425_15 = var_425_14 < var_425_13 and var_425_13 or var_425_14

					var_425_5.transform.localScale = Vector3.New(var_425_15, var_425_15, 0)
				end

				for iter_425_0, iter_425_1 in pairs(arg_422_1.bgs_) do
					if iter_425_0 ~= "MS0101" then
						iter_425_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_425_16 = manager.ui.mainCamera.transform
			local var_425_17 = 0

			if var_425_17 < arg_422_1.time_ and arg_422_1.time_ <= var_425_17 + arg_425_0 then
				local var_425_18 = arg_422_1.var_.effectxuanguangyese1
				local var_425_19
				local var_425_20 = var_425_16

				if not var_425_18 then
					var_425_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), var_425_20)
					var_425_18.name = "xuanguangyese1"
					arg_422_1.var_.effectxuanguangyese1 = var_425_18
				else
					var_425_18.transform:SetParent(var_425_20)
				end

				var_425_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_425_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_425_21 = manager.ui.mainCamera.transform
			local var_425_22 = 1.500000000001

			if var_425_22 < arg_422_1.time_ and arg_422_1.time_ <= var_425_22 + arg_425_0 then
				local var_425_23 = arg_422_1.var_.effectxuanguangyese1

				if var_425_23 then
					Object.Destroy(var_425_23)

					arg_422_1.var_.effectxuanguangyese1 = nil
				end
			end

			local var_425_24 = manager.ui.mainCamera.transform
			local var_425_25 = 1.15

			if var_425_25 < arg_422_1.time_ and arg_422_1.time_ <= var_425_25 + arg_425_0 then
				local var_425_26 = arg_422_1.var_.effectxuanguangyese2
				local var_425_27
				local var_425_28 = var_425_24

				if not var_425_26 then
					var_425_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), var_425_28)
					var_425_26.name = "xuanguangyese2"
					arg_422_1.var_.effectxuanguangyese2 = var_425_26
				else
					var_425_26.transform:SetParent(var_425_28)
				end

				var_425_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_425_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_425_29 = arg_422_1.bgs_.MS0101.transform
			local var_425_30 = 1.23333333333333

			if var_425_30 < arg_422_1.time_ and arg_422_1.time_ <= var_425_30 + arg_425_0 then
				arg_422_1.var_.moveOldPosMS0101 = var_425_29.localPosition
			end

			local var_425_31 = 2.43333333333333

			if var_425_30 <= arg_422_1.time_ and arg_422_1.time_ < var_425_30 + var_425_31 then
				local var_425_32 = (arg_422_1.time_ - var_425_30) / var_425_31
				local var_425_33 = Vector3.New(0.4, 0.5, 7)

				var_425_29.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPosMS0101, var_425_33, var_425_32)
			end

			if arg_422_1.time_ >= var_425_30 + var_425_31 and arg_422_1.time_ < var_425_30 + var_425_31 + arg_425_0 then
				var_425_29.localPosition = Vector3.New(0.4, 0.5, 7)
			end

			local var_425_34 = 1.2
			local var_425_35 = 1

			if var_425_34 < arg_422_1.time_ and arg_422_1.time_ <= var_425_34 + arg_425_0 then
				local var_425_36 = "play"
				local var_425_37 = "effect"

				arg_422_1:AudioAction(var_425_36, var_425_37, "se_story_147", "se_story_147_amb_rooftop", "")
			end

			local var_425_38 = 0.2
			local var_425_39 = 1

			if var_425_38 < arg_422_1.time_ and arg_422_1.time_ <= var_425_38 + arg_425_0 then
				local var_425_40 = "stop"
				local var_425_41 = "effect"

				arg_422_1:AudioAction(var_425_40, var_425_41, "se_story_121_04", "se_story_121_04_wind_loop", "")
			end

			local var_425_42 = 0
			local var_425_43 = 1

			if var_425_42 < arg_422_1.time_ and arg_422_1.time_ <= var_425_42 + arg_425_0 then
				local var_425_44 = "play"
				local var_425_45 = "music"

				arg_422_1:AudioAction(var_425_44, var_425_45, "bgm_activity_5_2_remake_ui_story", "violin", "bgm_activity_5_2_remake_ui_story.awb")

				local var_425_46 = ""
				local var_425_47 = MusicRecordCfg[464].musicName

				if var_425_47 ~= "" then
					if arg_422_1.bgmTxt_.text ~= var_425_47 and arg_422_1.bgmTxt_.text ~= "" then
						if arg_422_1.bgmTxt2_.text ~= "" then
							arg_422_1.bgmTxt_.text = arg_422_1.bgmTxt2_.text
						end

						arg_422_1.bgmTxt2_.text = var_425_47

						arg_422_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_422_1.bgmTxt_.text = var_425_47
						arg_422_1.bgmTxt2_.text = var_425_47
					end

					if arg_422_1.bgmTimer then
						arg_422_1.bgmTimer:Stop()

						arg_422_1.bgmTimer = nil
					end

					if arg_422_1.settingData.show_music_name == 1 then
						arg_422_1.musicController:SetSelectedState("show")
						arg_422_1.musicAnimator_:Play("open", 0, 0)

						if arg_422_1.settingData.music_time ~= 0 then
							arg_422_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_422_1.settingData.music_time), function()
								if arg_422_1 == nil or isNil(arg_422_1.bgmTxt_) then
									return
								end

								arg_422_1.musicController:SetSelectedState("hide")
								arg_422_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_425_48 = 0

			if var_425_48 < arg_422_1.time_ and arg_422_1.time_ <= var_425_48 + arg_425_0 then
				arg_422_1.allBtn_.enabled = false
			end

			local var_425_49 = 3.66666666666667

			if arg_422_1.time_ >= var_425_48 + var_425_49 and arg_422_1.time_ < var_425_48 + var_425_49 + arg_425_0 then
				arg_422_1.allBtn_.enabled = true
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_50 = 3.23333333333333
			local var_425_51 = 1.575

			if var_425_50 < arg_422_1.time_ and arg_422_1.time_ <= var_425_50 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_52 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_52:setOnUpdate(LuaHelper.FloatAction(function(arg_427_0)
					arg_422_1.dialogCg_.alpha = arg_427_0
				end))
				var_425_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_53 = arg_422_1:GetWordFromCfg(301021101)
				local var_425_54 = arg_422_1:FormatText(var_425_53.content)

				arg_422_1.text_.text = var_425_54

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_55 = 63
				local var_425_56 = utf8.len(var_425_54)
				local var_425_57 = var_425_55 <= 0 and var_425_51 or var_425_51 * (var_425_56 / var_425_55)

				if var_425_57 > 0 and var_425_51 < var_425_57 then
					arg_422_1.talkMaxDuration = var_425_57
					var_425_50 = var_425_50 + 0.3

					if var_425_57 + var_425_50 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_57 + var_425_50
					end
				end

				arg_422_1.text_.text = var_425_54
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_58 = var_425_50 + 0.3
			local var_425_59 = math.max(var_425_51, arg_422_1.talkMaxDuration)

			if var_425_58 <= arg_422_1.time_ and arg_422_1.time_ < var_425_58 + var_425_59 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_58) / var_425_59

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_58 + var_425_59 and arg_422_1.time_ < var_425_58 + var_425_59 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0101",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.43333333333333,
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.5, 7),
					endPos = Vector3.New(0.4, 0.5, 7),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play301021102 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 301021102
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play301021103(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 0.3

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_2 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:GetWordFromCfg(301021102)
				local var_432_4 = arg_429_1:FormatText(var_432_3.content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 12
				local var_432_6 = utf8.len(var_432_4)
				local var_432_7 = var_432_5 <= 0 and var_432_1 or var_432_1 * (var_432_6 / var_432_5)

				if var_432_7 > 0 and var_432_1 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_8 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_8 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_8

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_8 and arg_429_1.time_ < var_432_0 + var_432_8 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play301021103 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 301021103
		arg_433_1.duration_ = 10.4

		local var_433_0 = {
			zh = 7.8,
			ja = 10.4
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play301021104(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.925

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[6].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_3 = arg_433_1:GetWordFromCfg(301021103)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 37
				local var_436_6 = utf8.len(var_436_4)
				local var_436_7 = var_436_5 <= 0 and var_436_1 or var_436_1 * (var_436_6 / var_436_5)

				if var_436_7 > 0 and var_436_1 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021103", "story_v_out_301021.awb") ~= 0 then
					local var_436_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021103", "story_v_out_301021.awb") / 1000

					if var_436_8 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_8 + var_436_0
					end

					if var_436_3.prefab_name ~= "" and arg_433_1.actors_[var_436_3.prefab_name] ~= nil then
						local var_436_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_3.prefab_name].transform, "story_v_out_301021", "301021103", "story_v_out_301021.awb")

						arg_433_1:RecordAudio("301021103", var_436_9)
						arg_433_1:RecordAudio("301021103", var_436_9)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_301021", "301021103", "story_v_out_301021.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_301021", "301021103", "story_v_out_301021.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_10 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_10 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_10

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_10 and arg_433_1.time_ < var_436_0 + var_436_10 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play301021104 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 301021104
		arg_437_1.duration_ = 6.13

		local var_437_0 = {
			zh = 5.3,
			ja = 6.133
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
				arg_437_0:Play301021105(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.65

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[6].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:GetWordFromCfg(301021104)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 26
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021104", "story_v_out_301021.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021104", "story_v_out_301021.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_out_301021", "301021104", "story_v_out_301021.awb")

						arg_437_1:RecordAudio("301021104", var_440_9)
						arg_437_1:RecordAudio("301021104", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_301021", "301021104", "story_v_out_301021.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_301021", "301021104", "story_v_out_301021.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play301021105 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 301021105
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play301021106(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.5

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(301021105)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 20
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play301021106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 301021106
		arg_445_1.duration_ = 11.37

		local var_445_0 = {
			zh = 8.466,
			ja = 11.366
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play301021107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.95

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[6].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(301021106)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 38
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021106", "story_v_out_301021.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021106", "story_v_out_301021.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_out_301021", "301021106", "story_v_out_301021.awb")

						arg_445_1:RecordAudio("301021106", var_448_9)
						arg_445_1:RecordAudio("301021106", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_301021", "301021106", "story_v_out_301021.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_301021", "301021106", "story_v_out_301021.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_10 and arg_445_1.time_ < var_448_0 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play301021107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 301021107
		arg_449_1.duration_ = 6.73

		local var_449_0 = {
			zh = 4.5,
			ja = 6.733
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play301021108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.7

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[6].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_3 = arg_449_1:GetWordFromCfg(301021107)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 28
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021107", "story_v_out_301021.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021107", "story_v_out_301021.awb") / 1000

					if var_452_8 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_0
					end

					if var_452_3.prefab_name ~= "" and arg_449_1.actors_[var_452_3.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_3.prefab_name].transform, "story_v_out_301021", "301021107", "story_v_out_301021.awb")

						arg_449_1:RecordAudio("301021107", var_452_9)
						arg_449_1:RecordAudio("301021107", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_301021", "301021107", "story_v_out_301021.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_301021", "301021107", "story_v_out_301021.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_10 and arg_449_1.time_ < var_452_0 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play301021108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 301021108
		arg_453_1.duration_ = 8.37

		local var_453_0 = {
			zh = 6.966,
			ja = 8.366
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play301021109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.85

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[6].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:GetWordFromCfg(301021108)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 34
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021108", "story_v_out_301021.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021108", "story_v_out_301021.awb") / 1000

					if var_456_8 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_0
					end

					if var_456_3.prefab_name ~= "" and arg_453_1.actors_[var_456_3.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_3.prefab_name].transform, "story_v_out_301021", "301021108", "story_v_out_301021.awb")

						arg_453_1:RecordAudio("301021108", var_456_9)
						arg_453_1:RecordAudio("301021108", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_301021", "301021108", "story_v_out_301021.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_301021", "301021108", "story_v_out_301021.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_10 and arg_453_1.time_ < var_456_0 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play301021109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 301021109
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play301021110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.bgs_.MS0101.transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPosMS0101 = var_460_0.localPosition
			end

			local var_460_2 = 2.43333333333333

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0, 1, 10)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPosMS0101, var_460_4, var_460_3)
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_460_5 = 0

			if var_460_5 < arg_457_1.time_ and arg_457_1.time_ <= var_460_5 + arg_460_0 then
				arg_457_1.allBtn_.enabled = false
			end

			local var_460_6 = 1.66666666666667

			if arg_457_1.time_ >= var_460_5 + var_460_6 and arg_457_1.time_ < var_460_5 + var_460_6 + arg_460_0 then
				arg_457_1.allBtn_.enabled = true
			end

			local var_460_7 = 0
			local var_460_8 = 1.275

			if var_460_7 < arg_457_1.time_ and arg_457_1.time_ <= var_460_7 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_9 = arg_457_1:GetWordFromCfg(301021109)
				local var_460_10 = arg_457_1:FormatText(var_460_9.content)

				arg_457_1.text_.text = var_460_10

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 51
				local var_460_12 = utf8.len(var_460_10)
				local var_460_13 = var_460_11 <= 0 and var_460_8 or var_460_8 * (var_460_12 / var_460_11)

				if var_460_13 > 0 and var_460_8 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_7 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_7
					end
				end

				arg_457_1.text_.text = var_460_10
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_14 = math.max(var_460_8, arg_457_1.talkMaxDuration)

			if var_460_7 <= arg_457_1.time_ and arg_457_1.time_ < var_460_7 + var_460_14 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_7) / var_460_14

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_7 + var_460_14 and arg_457_1.time_ < var_460_7 + var_460_14 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0101",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.43333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.4, 0.5, 7),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play301021110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 301021110
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play301021111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 1.3

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(301021110)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 52
				local var_464_5 = utf8.len(var_464_3)
				local var_464_6 = var_464_4 <= 0 and var_464_1 or var_464_1 * (var_464_5 / var_464_4)

				if var_464_6 > 0 and var_464_1 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_7 and arg_461_1.time_ < var_464_0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play301021111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 301021111
		arg_465_1.duration_ = 1.33

		local var_465_0 = {
			zh = 1.333,
			ja = 1.3
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play301021112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.325

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[6].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(301021111)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 5
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021111", "story_v_out_301021.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021111", "story_v_out_301021.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_301021", "301021111", "story_v_out_301021.awb")

						arg_465_1:RecordAudio("301021111", var_468_9)
						arg_465_1:RecordAudio("301021111", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_301021", "301021111", "story_v_out_301021.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_301021", "301021111", "story_v_out_301021.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play301021112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 301021112
		arg_469_1.duration_ = 8

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play301021113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = "MS0101a"

			if arg_469_1.bgs_[var_472_0] == nil then
				local var_472_1 = Object.Instantiate(arg_469_1.paintGo_)

				var_472_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_472_0)
				var_472_1.name = var_472_0
				var_472_1.transform.parent = arg_469_1.stage_.transform
				var_472_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.bgs_[var_472_0] = var_472_1
			end

			local var_472_2 = 1.2

			if var_472_2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				local var_472_3 = manager.ui.mainCamera.transform.localPosition
				local var_472_4 = Vector3.New(0, 0, 10) + Vector3.New(var_472_3.x, var_472_3.y, 0)
				local var_472_5 = arg_469_1.bgs_.MS0101a

				var_472_5.transform.localPosition = var_472_4
				var_472_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_6 = var_472_5:GetComponent("SpriteRenderer")

				if var_472_6 and var_472_6.sprite then
					local var_472_7 = (var_472_5.transform.localPosition - var_472_3).z
					local var_472_8 = manager.ui.mainCameraCom_
					local var_472_9 = 2 * var_472_7 * Mathf.Tan(var_472_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_472_10 = var_472_9 * var_472_8.aspect
					local var_472_11 = var_472_6.sprite.bounds.size.x
					local var_472_12 = var_472_6.sprite.bounds.size.y
					local var_472_13 = var_472_10 / var_472_11
					local var_472_14 = var_472_9 / var_472_12
					local var_472_15 = var_472_14 < var_472_13 and var_472_13 or var_472_14

					var_472_5.transform.localScale = Vector3.New(var_472_15, var_472_15, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "MS0101a" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_16 = 3

			if var_472_16 < arg_469_1.time_ and arg_469_1.time_ <= var_472_16 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_17 = 0.3

			if arg_469_1.time_ >= var_472_16 + var_472_17 and arg_469_1.time_ < var_472_16 + var_472_17 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_18 = manager.ui.mainCamera.transform
			local var_472_19 = 0

			if var_472_19 < arg_469_1.time_ and arg_469_1.time_ <= var_472_19 + arg_472_0 then
				local var_472_20 = arg_469_1.var_.effectlajinjuli1
				local var_472_21
				local var_472_22 = var_472_18

				if not var_472_20 then
					var_472_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_472_22)
					var_472_20.name = "lajinjuli1"
					arg_469_1.var_.effectlajinjuli1 = var_472_20
				else
					var_472_20.transform:SetParent(var_472_22)
				end

				var_472_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_472_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_472_23 = 1.7777777777777777
				local var_472_24 = Screen.width / Screen.height
				local var_472_25 = var_472_24 / var_472_23
				local var_472_26 = Mathf.Max(var_472_23 / var_472_24, 1)

				var_472_20.transform.localScale = Vector3.New(var_472_20.transform.localScale.x * var_472_25, var_472_20.transform.localScale.y * var_472_26, var_472_20.transform.localScale.z)
			end

			local var_472_27 = 0

			if var_472_27 < arg_469_1.time_ and arg_469_1.time_ <= var_472_27 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_28 = 3

			if arg_469_1.time_ >= var_472_27 + var_472_28 and arg_469_1.time_ < var_472_27 + var_472_28 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_29 = arg_469_1.bgs_.MS0101a.transform
			local var_472_30 = 1.2

			if var_472_30 < arg_469_1.time_ and arg_469_1.time_ <= var_472_30 + arg_472_0 then
				arg_469_1.var_.moveOldPosMS0101a = var_472_29.localPosition
			end

			local var_472_31 = 2.43333333333333

			if var_472_30 <= arg_469_1.time_ and arg_469_1.time_ < var_472_30 + var_472_31 then
				local var_472_32 = (arg_469_1.time_ - var_472_30) / var_472_31
				local var_472_33 = Vector3.New(1, 0, 0)

				var_472_29.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPosMS0101a, var_472_33, var_472_32)
			end

			if arg_469_1.time_ >= var_472_30 + var_472_31 and arg_469_1.time_ < var_472_30 + var_472_31 + arg_472_0 then
				var_472_29.localPosition = Vector3.New(1, 0, 0)
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_34 = 3
			local var_472_35 = 0.675

			if var_472_34 < arg_469_1.time_ and arg_469_1.time_ <= var_472_34 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_36 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_36:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_37 = arg_469_1:GetWordFromCfg(301021112)
				local var_472_38 = arg_469_1:FormatText(var_472_37.content)

				arg_469_1.text_.text = var_472_38

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_39 = 27
				local var_472_40 = utf8.len(var_472_38)
				local var_472_41 = var_472_39 <= 0 and var_472_35 or var_472_35 * (var_472_40 / var_472_39)

				if var_472_41 > 0 and var_472_35 < var_472_41 then
					arg_469_1.talkMaxDuration = var_472_41
					var_472_34 = var_472_34 + 0.3

					if var_472_41 + var_472_34 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_41 + var_472_34
					end
				end

				arg_469_1.text_.text = var_472_38
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_42 = var_472_34 + 0.3
			local var_472_43 = math.max(var_472_35, arg_469_1.talkMaxDuration)

			if var_472_42 <= arg_469_1.time_ and arg_469_1.time_ < var_472_42 + var_472_43 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_42) / var_472_43

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_42 + var_472_43 and arg_469_1.time_ < var_472_42 + var_472_43 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0101a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.43333333333333,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 5),
					endPos = Vector3.New(1, 0, 0),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play301021113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 301021113
		arg_475_1.duration_ = 2.9

		local var_475_0 = {
			zh = 2.3,
			ja = 2.9
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
				arg_475_0:Play301021114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.225

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[6].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_3 = arg_475_1:GetWordFromCfg(301021113)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 9
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021113", "story_v_out_301021.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021113", "story_v_out_301021.awb") / 1000

					if var_478_8 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_0
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_301021", "301021113", "story_v_out_301021.awb")

						arg_475_1:RecordAudio("301021113", var_478_9)
						arg_475_1:RecordAudio("301021113", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_301021", "301021113", "story_v_out_301021.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_301021", "301021113", "story_v_out_301021.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_10 and arg_475_1.time_ < var_478_0 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play301021114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 301021114
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play301021115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.2

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[7].name)

				arg_479_1.leftNameTxt_.text = var_482_2

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

				local var_482_3 = arg_479_1:GetWordFromCfg(301021114)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 8
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_8 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_8 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_8

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_8 and arg_479_1.time_ < var_482_0 + var_482_8 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play301021115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 301021115
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play301021116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.1

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

				local var_486_3 = arg_483_1:GetWordFromCfg(301021115)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 44
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
	Play301021116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 301021116
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play301021117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.725

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[7].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(301021116)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 29
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_8 and arg_487_1.time_ < var_490_0 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play301021117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 301021117
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play301021118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 1.15

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_2 = arg_491_1:GetWordFromCfg(301021117)
				local var_494_3 = arg_491_1:FormatText(var_494_2.content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 60
				local var_494_5 = utf8.len(var_494_3)
				local var_494_6 = var_494_4 <= 0 and var_494_1 or var_494_1 * (var_494_5 / var_494_4)

				if var_494_6 > 0 and var_494_1 < var_494_6 then
					arg_491_1.talkMaxDuration = var_494_6

					if var_494_6 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_6 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_7 and arg_491_1.time_ < var_494_0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play301021118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 301021118
		arg_495_1.duration_ = 12.17

		local var_495_0 = {
			zh = 7.666,
			ja = 12.166
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play301021119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.9

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[6].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(301021118)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 36
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021118", "story_v_out_301021.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021118", "story_v_out_301021.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_301021", "301021118", "story_v_out_301021.awb")

						arg_495_1:RecordAudio("301021118", var_498_9)
						arg_495_1:RecordAudio("301021118", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_301021", "301021118", "story_v_out_301021.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_301021", "301021118", "story_v_out_301021.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play301021119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 301021119
		arg_499_1.duration_ = 6.9

		local var_499_0 = {
			zh = 5.1,
			ja = 6.9
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play301021120(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 0.625

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[6].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:GetWordFromCfg(301021119)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 25
				local var_502_6 = utf8.len(var_502_4)
				local var_502_7 = var_502_5 <= 0 and var_502_1 or var_502_1 * (var_502_6 / var_502_5)

				if var_502_7 > 0 and var_502_1 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021119", "story_v_out_301021.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021119", "story_v_out_301021.awb") / 1000

					if var_502_8 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_0
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_out_301021", "301021119", "story_v_out_301021.awb")

						arg_499_1:RecordAudio("301021119", var_502_9)
						arg_499_1:RecordAudio("301021119", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_301021", "301021119", "story_v_out_301021.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_301021", "301021119", "story_v_out_301021.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_10 and arg_499_1.time_ < var_502_0 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play301021120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 301021120
		arg_503_1.duration_ = 10.47

		local var_503_0 = {
			zh = 6.733,
			ja = 10.466
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play301021121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.85

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[6].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:GetWordFromCfg(301021120)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 34
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021120", "story_v_out_301021.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021120", "story_v_out_301021.awb") / 1000

					if var_506_8 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_0
					end

					if var_506_3.prefab_name ~= "" and arg_503_1.actors_[var_506_3.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_3.prefab_name].transform, "story_v_out_301021", "301021120", "story_v_out_301021.awb")

						arg_503_1:RecordAudio("301021120", var_506_9)
						arg_503_1:RecordAudio("301021120", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_301021", "301021120", "story_v_out_301021.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_301021", "301021120", "story_v_out_301021.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_10 and arg_503_1.time_ < var_506_0 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play301021121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 301021121
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play301021122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.25

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:GetWordFromCfg(301021121)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 10
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_8 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_8 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_8

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_8 and arg_507_1.time_ < var_510_0 + var_510_8 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play301021122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 301021122
		arg_511_1.duration_ = 6.9

		local var_511_0 = {
			zh = 3.766,
			ja = 6.9
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play301021123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.475

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[6].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:GetWordFromCfg(301021122)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 19
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021122", "story_v_out_301021.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021122", "story_v_out_301021.awb") / 1000

					if var_514_8 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_0
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_out_301021", "301021122", "story_v_out_301021.awb")

						arg_511_1:RecordAudio("301021122", var_514_9)
						arg_511_1:RecordAudio("301021122", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_301021", "301021122", "story_v_out_301021.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_301021", "301021122", "story_v_out_301021.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_10 and arg_511_1.time_ < var_514_0 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play301021123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 301021123
		arg_515_1.duration_ = 10.9

		local var_515_0 = {
			zh = 7.866,
			ja = 10.9
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play301021124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 1

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[6].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:GetWordFromCfg(301021123)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 40
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021123", "story_v_out_301021.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021123", "story_v_out_301021.awb") / 1000

					if var_518_8 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_0
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_301021", "301021123", "story_v_out_301021.awb")

						arg_515_1:RecordAudio("301021123", var_518_9)
						arg_515_1:RecordAudio("301021123", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_301021", "301021123", "story_v_out_301021.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_301021", "301021123", "story_v_out_301021.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_10 and arg_515_1.time_ < var_518_0 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play301021124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 301021124
		arg_519_1.duration_ = 8.93

		local var_519_0 = {
			zh = 5.233,
			ja = 8.933
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play301021125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.6

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[6].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_3 = arg_519_1:GetWordFromCfg(301021124)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 24
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301021", "301021124", "story_v_out_301021.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_301021", "301021124", "story_v_out_301021.awb") / 1000

					if var_522_8 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_0
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_out_301021", "301021124", "story_v_out_301021.awb")

						arg_519_1:RecordAudio("301021124", var_522_9)
						arg_519_1:RecordAudio("301021124", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_301021", "301021124", "story_v_out_301021.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_301021", "301021124", "story_v_out_301021.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_10 and arg_519_1.time_ < var_522_0 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play301021125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 301021125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play301021126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1.175

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_2 = arg_523_1:GetWordFromCfg(301021125)
				local var_526_3 = arg_523_1:FormatText(var_526_2.content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 47
				local var_526_5 = utf8.len(var_526_3)
				local var_526_6 = var_526_4 <= 0 and var_526_1 or var_526_1 * (var_526_5 / var_526_4)

				if var_526_6 > 0 and var_526_1 < var_526_6 then
					arg_523_1.talkMaxDuration = var_526_6

					if var_526_6 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_7 and arg_523_1.time_ < var_526_0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play301021126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 301021126
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.175

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[7].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:GetWordFromCfg(301021126)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 7
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_8 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_8 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_8

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_8 and arg_527_1.time_ < var_530_0 + var_530_8 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07",
		"TextureConfig/Background/I02f",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/I27g",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/MS0101",
		"TextureConfig/Background/MS0101a"
	},
	voices = {
		"story_v_out_301021.awb"
	}
}
