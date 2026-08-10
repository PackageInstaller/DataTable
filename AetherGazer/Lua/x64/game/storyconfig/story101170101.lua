return {
	Play117011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I08b"

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
				local var_4_5 = arg_1_1.bgs_.I08b

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
					if iter_4_0 ~= "I08b" then
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
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_17", "se_story_17_fire_loop", "")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 2
			local var_4_33 = 0.4

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(117011001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 16
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_32 + 0.3
			local var_4_41 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play117011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 117011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play117011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = manager.ui.mainCamera.transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.shakeOldPos = var_11_0.localPosition
			end

			local var_11_2 = 2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / 0.066
				local var_11_4, var_11_5 = math.modf(var_11_3)

				var_11_0.localPosition = Vector3.New(var_11_5 * 0.13, var_11_5 * 0.13, var_11_5 * 0.13) + arg_8_1.var_.shakeOldPos
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				var_11_0.localPosition = arg_8_1.var_.shakeOldPos
			end

			local var_11_6 = 0
			local var_11_7 = 1

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				local var_11_8 = "play"
				local var_11_9 = "effect"

				arg_8_1:AudioAction(var_11_8, var_11_9, "se_story_17", "se_story_17_boss_hawk1", "")
			end

			local var_11_10 = 0
			local var_11_11 = 1.65

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(117011002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 66
				local var_11_15 = utf8.len(var_11_13)
				local var_11_16 = var_11_14 <= 0 and var_11_11 or var_11_11 * (var_11_15 / var_11_14)

				if var_11_16 > 0 and var_11_11 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_17 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_17 and arg_8_1.time_ < var_11_10 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play117011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 117011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play117011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.825

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

				local var_15_2 = arg_12_1:GetWordFromCfg(117011003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 33
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
	Play117011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 117011004
		arg_16_1.duration_ = 2.97

		local var_16_0 = {
			zh = 1.3,
			ja = 2.966
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play117011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = manager.ui.mainCamera.transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = var_19_0.localPosition
			end

			local var_19_2 = 0.6

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / 0.066
				local var_19_4, var_19_5 = math.modf(var_19_3)

				var_19_0.localPosition = Vector3.New(var_19_5 * 0.13, var_19_5 * 0.13, var_19_5 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = arg_16_1.var_.shakeOldPos
			end

			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_7 = 0.6

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_8 = 0
			local var_19_9 = 0.075

			if var_19_8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_10 = arg_16_1:FormatText(StoryNameCfg[367].name)

				arg_16_1.leftNameTxt_.text = var_19_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_11 = arg_16_1:GetWordFromCfg(117011004)
				local var_19_12 = arg_16_1:FormatText(var_19_11.content)

				arg_16_1.text_.text = var_19_12

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 3
				local var_19_14 = utf8.len(var_19_12)
				local var_19_15 = var_19_13 <= 0 and var_19_9 or var_19_9 * (var_19_14 / var_19_13)

				if var_19_15 > 0 and var_19_9 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_12
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011004", "story_v_out_117011.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_117011", "117011004", "story_v_out_117011.awb") / 1000

					if var_19_16 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_8
					end

					if var_19_11.prefab_name ~= "" and arg_16_1.actors_[var_19_11.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_11.prefab_name].transform, "story_v_out_117011", "117011004", "story_v_out_117011.awb")

						arg_16_1:RecordAudio("117011004", var_19_17)
						arg_16_1:RecordAudio("117011004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_117011", "117011004", "story_v_out_117011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_117011", "117011004", "story_v_out_117011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_18 and arg_16_1.time_ < var_19_8 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play117011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 117011005
		arg_20_1.duration_ = 5.6

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play117011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = manager.ui.mainCamera.transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = var_23_0.localPosition
			end

			local var_23_2 = 1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / 0.066
				local var_23_4, var_23_5 = math.modf(var_23_3)

				var_23_0.localPosition = Vector3.New(var_23_5 * 0.13, var_23_5 * 0.13, var_23_5 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = arg_20_1.var_.shakeOldPos
			end

			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_7 = 1

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_8 = 0
			local var_23_9 = 1

			if var_23_8 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				local var_23_10 = "play"
				local var_23_11 = "effect"

				arg_20_1:AudioAction(var_23_10, var_23_11, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			local var_23_12 = 0.6
			local var_23_13 = 1

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				local var_23_14 = "play"
				local var_23_15 = "effect"

				arg_20_1:AudioAction(var_23_14, var_23_15, "se_story_17", "se_story_17_boss_hawk3", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_16 = 0.6
			local var_23_17 = 1.075

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

				local var_23_19 = arg_20_1:GetWordFromCfg(117011005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 43
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
	Play117011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 117011006
		arg_26_1.duration_ = 11.6

		local var_26_0 = {
			zh = 11.6,
			ja = 9.266
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play117011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "TI0101"

			if arg_26_1.bgs_[var_29_0] == nil then
				local var_29_1 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_0)
				var_29_1.name = var_29_0
				var_29_1.transform.parent = arg_26_1.stage_.transform
				var_29_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_0] = var_29_1
			end

			local var_29_2 = 2

			if var_29_2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				local var_29_3 = manager.ui.mainCamera.transform.localPosition
				local var_29_4 = Vector3.New(0, 0, 10) + Vector3.New(var_29_3.x, var_29_3.y, 0)
				local var_29_5 = arg_26_1.bgs_.TI0101

				var_29_5.transform.localPosition = var_29_4
				var_29_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_6 = var_29_5:GetComponent("SpriteRenderer")

				if var_29_6 and var_29_6.sprite then
					local var_29_7 = (var_29_5.transform.localPosition - var_29_3).z
					local var_29_8 = manager.ui.mainCameraCom_
					local var_29_9 = 2 * var_29_7 * Mathf.Tan(var_29_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_29_10 = var_29_9 * var_29_8.aspect
					local var_29_11 = var_29_6.sprite.bounds.size.x
					local var_29_12 = var_29_6.sprite.bounds.size.y
					local var_29_13 = var_29_10 / var_29_11
					local var_29_14 = var_29_9 / var_29_12
					local var_29_15 = var_29_14 < var_29_13 and var_29_13 or var_29_14

					var_29_5.transform.localScale = Vector3.New(var_29_15, var_29_15, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "TI0101" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_16 = 0

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_17 = 2

			if var_29_16 <= arg_26_1.time_ and arg_26_1.time_ < var_29_16 + var_29_17 then
				local var_29_18 = (arg_26_1.time_ - var_29_16) / var_29_17
				local var_29_19 = Color.New(0, 0, 0)

				var_29_19.a = Mathf.Lerp(0, 1, var_29_18)
				arg_26_1.mask_.color = var_29_19
			end

			if arg_26_1.time_ >= var_29_16 + var_29_17 and arg_26_1.time_ < var_29_16 + var_29_17 + arg_29_0 then
				local var_29_20 = Color.New(0, 0, 0)

				var_29_20.a = 1
				arg_26_1.mask_.color = var_29_20
			end

			local var_29_21 = 2

			if var_29_21 < arg_26_1.time_ and arg_26_1.time_ <= var_29_21 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_22 = 2

			if var_29_21 <= arg_26_1.time_ and arg_26_1.time_ < var_29_21 + var_29_22 then
				local var_29_23 = (arg_26_1.time_ - var_29_21) / var_29_22
				local var_29_24 = Color.New(0, 0, 0)

				var_29_24.a = Mathf.Lerp(1, 0, var_29_23)
				arg_26_1.mask_.color = var_29_24
			end

			if arg_26_1.time_ >= var_29_21 + var_29_22 and arg_26_1.time_ < var_29_21 + var_29_22 + arg_29_0 then
				local var_29_25 = Color.New(0, 0, 0)
				local var_29_26 = 0

				arg_26_1.mask_.enabled = false
				var_29_25.a = var_29_26
				arg_26_1.mask_.color = var_29_25
			end

			local var_29_27 = arg_26_1.bgs_.TI0101.transform
			local var_29_28 = 2

			if var_29_28 < arg_26_1.time_ and arg_26_1.time_ <= var_29_28 + arg_29_0 then
				arg_26_1.var_.moveOldPosTI0101 = var_29_27.localPosition
			end

			local var_29_29 = 0.001

			if var_29_28 <= arg_26_1.time_ and arg_26_1.time_ < var_29_28 + var_29_29 then
				local var_29_30 = (arg_26_1.time_ - var_29_28) / var_29_29
				local var_29_31 = Vector3.New(0, 1, 9)

				var_29_27.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosTI0101, var_29_31, var_29_30)
			end

			if arg_26_1.time_ >= var_29_28 + var_29_29 and arg_26_1.time_ < var_29_28 + var_29_29 + arg_29_0 then
				var_29_27.localPosition = Vector3.New(0, 1, 9)
			end

			local var_29_32 = arg_26_1.bgs_.TI0101.transform
			local var_29_33 = 2.034

			if var_29_33 < arg_26_1.time_ and arg_26_1.time_ <= var_29_33 + arg_29_0 then
				arg_26_1.var_.moveOldPosTI0101 = var_29_32.localPosition
			end

			local var_29_34 = 5.5

			if var_29_33 <= arg_26_1.time_ and arg_26_1.time_ < var_29_33 + var_29_34 then
				local var_29_35 = (arg_26_1.time_ - var_29_33) / var_29_34
				local var_29_36 = Vector3.New(0, 1, 10)

				var_29_32.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosTI0101, var_29_36, var_29_35)
			end

			if arg_26_1.time_ >= var_29_33 + var_29_34 and arg_26_1.time_ < var_29_33 + var_29_34 + arg_29_0 then
				var_29_32.localPosition = Vector3.New(0, 1, 10)
			end

			local var_29_37 = 4

			if var_29_37 < arg_26_1.time_ and arg_26_1.time_ <= var_29_37 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_38 = 3.534

			if arg_26_1.time_ >= var_29_37 + var_29_38 and arg_26_1.time_ < var_29_37 + var_29_38 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_39 = 0
			local var_29_40 = 1

			if var_29_39 < arg_26_1.time_ and arg_26_1.time_ <= var_29_39 + arg_29_0 then
				local var_29_41 = "stop"
				local var_29_42 = "effect"

				arg_26_1:AudioAction(var_29_41, var_29_42, "se_story_17", "se_story_17_fire_loop", "")
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_43 = 4
			local var_29_44 = 0.975

			if var_29_43 < arg_26_1.time_ and arg_26_1.time_ <= var_29_43 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_45 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_45:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_46 = arg_26_1:FormatText(StoryNameCfg[368].name)

				arg_26_1.leftNameTxt_.text = var_29_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_47 = arg_26_1:GetWordFromCfg(117011006)
				local var_29_48 = arg_26_1:FormatText(var_29_47.content)

				arg_26_1.text_.text = var_29_48

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_49 = 39
				local var_29_50 = utf8.len(var_29_48)
				local var_29_51 = var_29_49 <= 0 and var_29_44 or var_29_44 * (var_29_50 / var_29_49)

				if var_29_51 > 0 and var_29_44 < var_29_51 then
					arg_26_1.talkMaxDuration = var_29_51
					var_29_43 = var_29_43 + 0.3

					if var_29_51 + var_29_43 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_51 + var_29_43
					end
				end

				arg_26_1.text_.text = var_29_48
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011006", "story_v_out_117011.awb") ~= 0 then
					local var_29_52 = manager.audio:GetVoiceLength("story_v_out_117011", "117011006", "story_v_out_117011.awb") / 1000

					if var_29_52 + var_29_43 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_52 + var_29_43
					end

					if var_29_47.prefab_name ~= "" and arg_26_1.actors_[var_29_47.prefab_name] ~= nil then
						local var_29_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_47.prefab_name].transform, "story_v_out_117011", "117011006", "story_v_out_117011.awb")

						arg_26_1:RecordAudio("117011006", var_29_53)
						arg_26_1:RecordAudio("117011006", var_29_53)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_117011", "117011006", "story_v_out_117011.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_117011", "117011006", "story_v_out_117011.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_54 = var_29_43 + 0.3
			local var_29_55 = math.max(var_29_44, arg_26_1.talkMaxDuration)

			if var_29_54 <= arg_26_1.time_ and arg_26_1.time_ < var_29_54 + var_29_55 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_54) / var_29_55

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_54 + var_29_55 and arg_26_1.time_ < var_29_54 + var_29_55 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play117011007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 117011007
		arg_32_1.duration_ = 8.03

		local var_32_0 = {
			zh = 8.033,
			ja = 6.2
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
				arg_32_0:Play117011008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.025

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[368].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(117011007)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011007", "story_v_out_117011.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011007", "story_v_out_117011.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_117011", "117011007", "story_v_out_117011.awb")

						arg_32_1:RecordAudio("117011007", var_35_9)
						arg_32_1:RecordAudio("117011007", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_117011", "117011007", "story_v_out_117011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_117011", "117011007", "story_v_out_117011.awb")
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
	Play117011008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 117011008
		arg_36_1.duration_ = 12.63

		local var_36_0 = {
			zh = 6.8,
			ja = 12.633
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
				arg_36_0:Play117011009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.85

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[368].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(117011008)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 34
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011008", "story_v_out_117011.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011008", "story_v_out_117011.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_117011", "117011008", "story_v_out_117011.awb")

						arg_36_1:RecordAudio("117011008", var_39_9)
						arg_36_1:RecordAudio("117011008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_117011", "117011008", "story_v_out_117011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_117011", "117011008", "story_v_out_117011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play117011009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 117011009
		arg_40_1.duration_ = 7.23

		local var_40_0 = {
			zh = 7.233,
			ja = 4.366
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
				arg_40_0:Play117011010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.9

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[368].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(117011009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011009", "story_v_out_117011.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011009", "story_v_out_117011.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_117011", "117011009", "story_v_out_117011.awb")

						arg_40_1:RecordAudio("117011009", var_43_9)
						arg_40_1:RecordAudio("117011009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_117011", "117011009", "story_v_out_117011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_117011", "117011009", "story_v_out_117011.awb")
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
	Play117011010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 117011010
		arg_44_1.duration_ = 9.93

		local var_44_0 = {
			zh = 9.933,
			ja = 6.666
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
				arg_44_0:Play117011011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.15

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[368].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(117011010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011010", "story_v_out_117011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011010", "story_v_out_117011.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_117011", "117011010", "story_v_out_117011.awb")

						arg_44_1:RecordAudio("117011010", var_47_9)
						arg_44_1:RecordAudio("117011010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_117011", "117011010", "story_v_out_117011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_117011", "117011010", "story_v_out_117011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play117011011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 117011011
		arg_48_1.duration_ = 6.53

		local var_48_0 = {
			zh = 3.8,
			ja = 6.533
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
				arg_48_0:Play117011012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.55

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[368].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(117011011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 22
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011011", "story_v_out_117011.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011011", "story_v_out_117011.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_117011", "117011011", "story_v_out_117011.awb")

						arg_48_1:RecordAudio("117011011", var_51_9)
						arg_48_1:RecordAudio("117011011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_117011", "117011011", "story_v_out_117011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_117011", "117011011", "story_v_out_117011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play117011012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 117011012
		arg_52_1.duration_ = 9

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play117011013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_1 = 2

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_1 then
				local var_55_2 = (arg_52_1.time_ - var_55_0) / var_55_1
				local var_55_3 = Color.New(0, 0, 0)

				var_55_3.a = Mathf.Lerp(0, 1, var_55_2)
				arg_52_1.mask_.color = var_55_3
			end

			if arg_52_1.time_ >= var_55_0 + var_55_1 and arg_52_1.time_ < var_55_0 + var_55_1 + arg_55_0 then
				local var_55_4 = Color.New(0, 0, 0)

				var_55_4.a = 1
				arg_52_1.mask_.color = var_55_4
			end

			local var_55_5 = 2

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_6 = 2

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6
				local var_55_8 = Color.New(0, 0, 0)

				var_55_8.a = Mathf.Lerp(1, 0, var_55_7)
				arg_52_1.mask_.color = var_55_8
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				local var_55_9 = Color.New(0, 0, 0)
				local var_55_10 = 0

				arg_52_1.mask_.enabled = false
				var_55_9.a = var_55_10
				arg_52_1.mask_.color = var_55_9
			end

			local var_55_11 = "ST12"

			if arg_52_1.bgs_[var_55_11] == nil then
				local var_55_12 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_11)
				var_55_12.name = var_55_11
				var_55_12.transform.parent = arg_52_1.stage_.transform
				var_55_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_11] = var_55_12
			end

			local var_55_13 = 2

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				local var_55_14 = manager.ui.mainCamera.transform.localPosition
				local var_55_15 = Vector3.New(0, 0, 10) + Vector3.New(var_55_14.x, var_55_14.y, 0)
				local var_55_16 = arg_52_1.bgs_.ST12

				var_55_16.transform.localPosition = var_55_15
				var_55_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_17 = var_55_16:GetComponent("SpriteRenderer")

				if var_55_17 and var_55_17.sprite then
					local var_55_18 = (var_55_16.transform.localPosition - var_55_14).z
					local var_55_19 = manager.ui.mainCameraCom_
					local var_55_20 = 2 * var_55_18 * Mathf.Tan(var_55_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_21 = var_55_20 * var_55_19.aspect
					local var_55_22 = var_55_17.sprite.bounds.size.x
					local var_55_23 = var_55_17.sprite.bounds.size.y
					local var_55_24 = var_55_21 / var_55_22
					local var_55_25 = var_55_20 / var_55_23
					local var_55_26 = var_55_25 < var_55_24 and var_55_24 or var_55_25

					var_55_16.transform.localScale = Vector3.New(var_55_26, var_55_26, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "ST12" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_27 = 4
			local var_55_28 = 1.2

			if var_55_27 < arg_52_1.time_ and arg_52_1.time_ <= var_55_27 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_29 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_29:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_30 = arg_52_1:GetWordFromCfg(117011012)
				local var_55_31 = arg_52_1:FormatText(var_55_30.content)

				arg_52_1.text_.text = var_55_31

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_32 = 48
				local var_55_33 = utf8.len(var_55_31)
				local var_55_34 = var_55_32 <= 0 and var_55_28 or var_55_28 * (var_55_33 / var_55_32)

				if var_55_34 > 0 and var_55_28 < var_55_34 then
					arg_52_1.talkMaxDuration = var_55_34
					var_55_27 = var_55_27 + 0.3

					if var_55_34 + var_55_27 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_27
					end
				end

				arg_52_1.text_.text = var_55_31
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_35 = var_55_27 + 0.3
			local var_55_36 = math.max(var_55_28, arg_52_1.talkMaxDuration)

			if var_55_35 <= arg_52_1.time_ and arg_52_1.time_ < var_55_35 + var_55_36 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_35) / var_55_36

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_35 + var_55_36 and arg_52_1.time_ < var_55_35 + var_55_36 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play117011013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 117011013
		arg_58_1.duration_ = 5.1

		local var_58_0 = {
			zh = 4.466,
			ja = 5.1
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
				arg_58_0:Play117011014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "1029"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(var_61_1, arg_58_1.canvasGo_.transform)

					var_61_2.transform:SetSiblingIndex(1)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_58_1.isInRecall_ then
						for iter_61_0, iter_61_1 in ipairs(var_61_3) do
							iter_61_1.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_61_4 = arg_58_1.actors_["1029"].transform
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.var_.moveOldPos1029 = var_61_4.localPosition
				var_61_4.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1029", 2)

				local var_61_6 = var_61_4.childCount

				for iter_61_2 = 0, var_61_6 - 1 do
					local var_61_7 = var_61_4:GetChild(iter_61_2)

					if var_61_7.name == "split_1" or not string.find(var_61_7.name, "split") then
						var_61_7.gameObject:SetActive(true)
					else
						var_61_7.gameObject:SetActive(false)
					end
				end
			end

			local var_61_8 = 0.001

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_5) / var_61_8
				local var_61_10 = Vector3.New(-390, -355, -140)

				var_61_4.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1029, var_61_10, var_61_9)
			end

			if arg_58_1.time_ >= var_61_5 + var_61_8 and arg_58_1.time_ < var_61_5 + var_61_8 + arg_61_0 then
				var_61_4.localPosition = Vector3.New(-390, -355, -140)
			end

			local var_61_11 = arg_58_1.actors_["1029"]
			local var_61_12 = 0

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				local var_61_13 = var_61_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_61_13 then
					arg_58_1.var_.alphaOldValue1029 = var_61_13.alpha
					arg_58_1.var_.characterEffect1029 = var_61_13
				end

				arg_58_1.var_.alphaOldValue1029 = 0
			end

			local var_61_14 = 0.333333333333333

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_14 then
				local var_61_15 = (arg_58_1.time_ - var_61_12) / var_61_14
				local var_61_16 = Mathf.Lerp(arg_58_1.var_.alphaOldValue1029, 1, var_61_15)

				if arg_58_1.var_.characterEffect1029 then
					arg_58_1.var_.characterEffect1029.alpha = var_61_16
				end
			end

			if arg_58_1.time_ >= var_61_12 + var_61_14 and arg_58_1.time_ < var_61_12 + var_61_14 + arg_61_0 and arg_58_1.var_.characterEffect1029 then
				arg_58_1.var_.characterEffect1029.alpha = 1
			end

			local var_61_17 = 0
			local var_61_18 = 0.1

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 then
				local var_61_19 = "play"
				local var_61_20 = "music"

				arg_58_1:AudioAction(var_61_19, var_61_20, "ui_battle", "ui_battle_stopbgm", "")

				local var_61_21 = ""
				local var_61_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_61_22 ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_22 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_22

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_22
						arg_58_1.bgmTxt2_.text = var_61_22
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_61_23 = 0.2
			local var_61_24 = 0.733333333333333

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				local var_61_25 = "play"
				local var_61_26 = "music"

				arg_58_1:AudioAction(var_61_25, var_61_26, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_61_27 = ""
				local var_61_28 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_61_28 ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_28 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_28

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_28
						arg_58_1.bgmTxt2_.text = var_61_28
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_61_29 = 0
			local var_61_30 = 0.5

			if var_61_29 < arg_58_1.time_ and arg_58_1.time_ <= var_61_29 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_31 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_31:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_58_1.dialogCg_.alpha = arg_64_0
				end))
				var_61_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_32 = arg_58_1:FormatText(StoryNameCfg[319].name)

				arg_58_1.leftNameTxt_.text = var_61_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_33 = arg_58_1:GetWordFromCfg(117011013)
				local var_61_34 = arg_58_1:FormatText(var_61_33.content)

				arg_58_1.text_.text = var_61_34

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_35 = 20
				local var_61_36 = utf8.len(var_61_34)
				local var_61_37 = var_61_35 <= 0 and var_61_30 or var_61_30 * (var_61_36 / var_61_35)

				if var_61_37 > 0 and var_61_30 < var_61_37 then
					arg_58_1.talkMaxDuration = var_61_37
					var_61_29 = var_61_29 + 0.3

					if var_61_37 + var_61_29 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_37 + var_61_29
					end
				end

				arg_58_1.text_.text = var_61_34
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011013", "story_v_out_117011.awb") ~= 0 then
					local var_61_38 = manager.audio:GetVoiceLength("story_v_out_117011", "117011013", "story_v_out_117011.awb") / 1000

					if var_61_38 + var_61_29 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_38 + var_61_29
					end

					if var_61_33.prefab_name ~= "" and arg_58_1.actors_[var_61_33.prefab_name] ~= nil then
						local var_61_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_33.prefab_name].transform, "story_v_out_117011", "117011013", "story_v_out_117011.awb")

						arg_58_1:RecordAudio("117011013", var_61_39)
						arg_58_1:RecordAudio("117011013", var_61_39)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_117011", "117011013", "story_v_out_117011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_117011", "117011013", "story_v_out_117011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_40 = var_61_29 + 0.3
			local var_61_41 = math.max(var_61_30, arg_58_1.talkMaxDuration)

			if var_61_40 <= arg_58_1.time_ and arg_58_1.time_ < var_61_40 + var_61_41 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_40) / var_61_41

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_40 + var_61_41 and arg_58_1.time_ < var_61_40 + var_61_41 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play117011014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 117011014
		arg_66_1.duration_ = 5.6

		local var_66_0 = {
			zh = 5.6,
			ja = 4.966
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
				arg_66_0:Play117011015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "1033"

			if arg_66_1.actors_[var_69_0] == nil then
				local var_69_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_69_1) then
					local var_69_2 = Object.Instantiate(var_69_1, arg_66_1.canvasGo_.transform)

					var_69_2.transform:SetSiblingIndex(1)

					var_69_2.name = var_69_0
					var_69_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_66_1.actors_[var_69_0] = var_69_2

					local var_69_3 = var_69_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_66_1.isInRecall_ then
						for iter_69_0, iter_69_1 in ipairs(var_69_3) do
							iter_69_1.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_69_4 = arg_66_1.actors_["1033"].transform
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.var_.moveOldPos1033 = var_69_4.localPosition
				var_69_4.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1033", 4)

				local var_69_6 = var_69_4.childCount

				for iter_69_2 = 0, var_69_6 - 1 do
					local var_69_7 = var_69_4:GetChild(iter_69_2)

					if var_69_7.name == "split_6" or not string.find(var_69_7.name, "split") then
						var_69_7.gameObject:SetActive(true)
					else
						var_69_7.gameObject:SetActive(false)
					end
				end
			end

			local var_69_8 = 0.001

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_8 then
				local var_69_9 = (arg_66_1.time_ - var_69_5) / var_69_8
				local var_69_10 = Vector3.New(390, -420, 0)

				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1033, var_69_10, var_69_9)
			end

			if arg_66_1.time_ >= var_69_5 + var_69_8 and arg_66_1.time_ < var_69_5 + var_69_8 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(390, -420, 0)
			end

			local var_69_11 = arg_66_1.actors_["1033"]
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				local var_69_13 = var_69_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_69_13 then
					arg_66_1.var_.alphaOldValue1033 = var_69_13.alpha
					arg_66_1.var_.characterEffect1033 = var_69_13
				end

				arg_66_1.var_.alphaOldValue1033 = 0
			end

			local var_69_14 = 0.333333333333333

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_14 then
				local var_69_15 = (arg_66_1.time_ - var_69_12) / var_69_14
				local var_69_16 = Mathf.Lerp(arg_66_1.var_.alphaOldValue1033, 1, var_69_15)

				if arg_66_1.var_.characterEffect1033 then
					arg_66_1.var_.characterEffect1033.alpha = var_69_16
				end
			end

			if arg_66_1.time_ >= var_69_12 + var_69_14 and arg_66_1.time_ < var_69_12 + var_69_14 + arg_69_0 and arg_66_1.var_.characterEffect1033 then
				arg_66_1.var_.characterEffect1033.alpha = 1
			end

			local var_69_17 = arg_66_1.actors_["1029"]
			local var_69_18 = 0

			if var_69_18 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 and not isNil(var_69_17) and arg_66_1.var_.actorSpriteComps1029 == nil then
				arg_66_1.var_.actorSpriteComps1029 = var_69_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_19 = 0.2

			if var_69_18 <= arg_66_1.time_ and arg_66_1.time_ < var_69_18 + var_69_19 and not isNil(var_69_17) then
				local var_69_20 = (arg_66_1.time_ - var_69_18) / var_69_19

				if arg_66_1.var_.actorSpriteComps1029 then
					for iter_69_3, iter_69_4 in pairs(arg_66_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_69_4 then
							if arg_66_1.isInRecall_ then
								local var_69_21 = Mathf.Lerp(iter_69_4.color.r, arg_66_1.hightColor2.r, var_69_20)
								local var_69_22 = Mathf.Lerp(iter_69_4.color.g, arg_66_1.hightColor2.g, var_69_20)
								local var_69_23 = Mathf.Lerp(iter_69_4.color.b, arg_66_1.hightColor2.b, var_69_20)

								iter_69_4.color = Color.New(var_69_21, var_69_22, var_69_23)
							else
								local var_69_24 = Mathf.Lerp(iter_69_4.color.r, 0.5, var_69_20)

								iter_69_4.color = Color.New(var_69_24, var_69_24, var_69_24)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_18 + var_69_19 and arg_66_1.time_ < var_69_18 + var_69_19 + arg_69_0 and not isNil(var_69_17) and arg_66_1.var_.actorSpriteComps1029 then
				for iter_69_5, iter_69_6 in pairs(arg_66_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_69_6 then
						if arg_66_1.isInRecall_ then
							iter_69_6.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1029 = nil
			end

			local var_69_25 = 0
			local var_69_26 = 0.3

			if var_69_25 < arg_66_1.time_ and arg_66_1.time_ <= var_69_25 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_27 = arg_66_1:FormatText(StoryNameCfg[236].name)

				arg_66_1.leftNameTxt_.text = var_69_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_28 = arg_66_1:GetWordFromCfg(117011014)
				local var_69_29 = arg_66_1:FormatText(var_69_28.content)

				arg_66_1.text_.text = var_69_29

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_30 = 12
				local var_69_31 = utf8.len(var_69_29)
				local var_69_32 = var_69_30 <= 0 and var_69_26 or var_69_26 * (var_69_31 / var_69_30)

				if var_69_32 > 0 and var_69_26 < var_69_32 then
					arg_66_1.talkMaxDuration = var_69_32

					if var_69_32 + var_69_25 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_32 + var_69_25
					end
				end

				arg_66_1.text_.text = var_69_29
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011014", "story_v_out_117011.awb") ~= 0 then
					local var_69_33 = manager.audio:GetVoiceLength("story_v_out_117011", "117011014", "story_v_out_117011.awb") / 1000

					if var_69_33 + var_69_25 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_33 + var_69_25
					end

					if var_69_28.prefab_name ~= "" and arg_66_1.actors_[var_69_28.prefab_name] ~= nil then
						local var_69_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_28.prefab_name].transform, "story_v_out_117011", "117011014", "story_v_out_117011.awb")

						arg_66_1:RecordAudio("117011014", var_69_34)
						arg_66_1:RecordAudio("117011014", var_69_34)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_117011", "117011014", "story_v_out_117011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_117011", "117011014", "story_v_out_117011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_35 = math.max(var_69_26, arg_66_1.talkMaxDuration)

			if var_69_25 <= arg_66_1.time_ and arg_66_1.time_ < var_69_25 + var_69_35 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_25) / var_69_35

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_25 + var_69_35 and arg_66_1.time_ < var_69_25 + var_69_35 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play117011015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 117011015
		arg_70_1.duration_ = 8.63

		local var_70_0 = {
			zh = 8.633,
			ja = 6
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play117011016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.125

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[236].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(117011015)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 45
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011015", "story_v_out_117011.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011015", "story_v_out_117011.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_117011", "117011015", "story_v_out_117011.awb")

						arg_70_1:RecordAudio("117011015", var_73_9)
						arg_70_1:RecordAudio("117011015", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_117011", "117011015", "story_v_out_117011.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_117011", "117011015", "story_v_out_117011.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play117011016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 117011016
		arg_74_1.duration_ = 8.53

		local var_74_0 = {
			zh = 8.533,
			ja = 4.133
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
				arg_74_0:Play117011017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.95

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[236].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(117011016)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011016", "story_v_out_117011.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011016", "story_v_out_117011.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_117011", "117011016", "story_v_out_117011.awb")

						arg_74_1:RecordAudio("117011016", var_77_9)
						arg_74_1:RecordAudio("117011016", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_117011", "117011016", "story_v_out_117011.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_117011", "117011016", "story_v_out_117011.awb")
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
	Play117011017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 117011017
		arg_78_1.duration_ = 12.83

		local var_78_0 = {
			zh = 3.6,
			ja = 12.833
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
				arg_78_0:Play117011018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.35

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[236].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(117011017)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011017", "story_v_out_117011.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011017", "story_v_out_117011.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_117011", "117011017", "story_v_out_117011.awb")

						arg_78_1:RecordAudio("117011017", var_81_9)
						arg_78_1:RecordAudio("117011017", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_117011", "117011017", "story_v_out_117011.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_117011", "117011017", "story_v_out_117011.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play117011018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 117011018
		arg_82_1.duration_ = 4.33

		local var_82_0 = {
			zh = 3.7,
			ja = 4.333
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
				arg_82_0:Play117011019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1033"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1033 == nil then
				arg_82_1.var_.actorSpriteComps1033 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1033 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 0.5, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1033 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1033 = nil
			end

			local var_85_8 = arg_82_1.actors_["1029"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps1029 == nil then
				arg_82_1.var_.actorSpriteComps1029 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.2

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps1029 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor1.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor1.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor1.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 1, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps1029 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1029 = nil
			end

			local var_85_16 = 0
			local var_85_17 = 0.325

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_18 = arg_82_1:FormatText(StoryNameCfg[319].name)

				arg_82_1.leftNameTxt_.text = var_85_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(117011018)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 13
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_17 or var_85_17 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_17 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23

					if var_85_23 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_16
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011018", "story_v_out_117011.awb") ~= 0 then
					local var_85_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011018", "story_v_out_117011.awb") / 1000

					if var_85_24 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_16
					end

					if var_85_19.prefab_name ~= "" and arg_82_1.actors_[var_85_19.prefab_name] ~= nil then
						local var_85_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_19.prefab_name].transform, "story_v_out_117011", "117011018", "story_v_out_117011.awb")

						arg_82_1:RecordAudio("117011018", var_85_25)
						arg_82_1:RecordAudio("117011018", var_85_25)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_117011", "117011018", "story_v_out_117011.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_117011", "117011018", "story_v_out_117011.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_26 = math.max(var_85_17, arg_82_1.talkMaxDuration)

			if var_85_16 <= arg_82_1.time_ and arg_82_1.time_ < var_85_16 + var_85_26 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_16) / var_85_26

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_16 + var_85_26 and arg_82_1.time_ < var_85_16 + var_85_26 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play117011019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 117011019
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play117011020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1029"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1029 == nil then
				arg_86_1.var_.actorSpriteComps1029 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps1029 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 0.5, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1029 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1029 = nil
			end

			local var_89_8 = 0
			local var_89_9 = 0.6

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(117011019)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_12 = 24
				local var_89_13 = utf8.len(var_89_11)
				local var_89_14 = var_89_12 <= 0 and var_89_9 or var_89_9 * (var_89_13 / var_89_12)

				if var_89_14 > 0 and var_89_9 < var_89_14 then
					arg_86_1.talkMaxDuration = var_89_14

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_15 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_15 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_15

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_15 and arg_86_1.time_ < var_89_8 + var_89_15 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play117011020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 117011020
		arg_90_1.duration_ = 5.7

		local var_90_0 = {
			zh = 2.3,
			ja = 5.7
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
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play117011021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1033"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1033 == nil then
				arg_90_1.var_.actorSpriteComps1033 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1033 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1033 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1033 = nil
			end

			local var_93_8 = 0
			local var_93_9 = 0.325

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[236].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_11 = arg_90_1:GetWordFromCfg(117011020)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 13
				local var_93_14 = utf8.len(var_93_12)
				local var_93_15 = var_93_13 <= 0 and var_93_9 or var_93_9 * (var_93_14 / var_93_13)

				if var_93_15 > 0 and var_93_9 < var_93_15 then
					arg_90_1.talkMaxDuration = var_93_15

					if var_93_15 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_12
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011020", "story_v_out_117011.awb") ~= 0 then
					local var_93_16 = manager.audio:GetVoiceLength("story_v_out_117011", "117011020", "story_v_out_117011.awb") / 1000

					if var_93_16 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_16 + var_93_8
					end

					if var_93_11.prefab_name ~= "" and arg_90_1.actors_[var_93_11.prefab_name] ~= nil then
						local var_93_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_11.prefab_name].transform, "story_v_out_117011", "117011020", "story_v_out_117011.awb")

						arg_90_1:RecordAudio("117011020", var_93_17)
						arg_90_1:RecordAudio("117011020", var_93_17)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_117011", "117011020", "story_v_out_117011.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_117011", "117011020", "story_v_out_117011.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_18 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_18 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_18

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_18 and arg_90_1.time_ < var_93_8 + var_93_18 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play117011021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 117011021
		arg_94_1.duration_ = 4.17

		local var_94_0 = {
			zh = 2.533,
			ja = 4.166
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play117011022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1033"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1033 == nil then
				arg_94_1.var_.actorSpriteComps1033 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps1033 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 0.5, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1033 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1033 = nil
			end

			local var_97_8 = arg_94_1.actors_["1029"]
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps1029 == nil then
				arg_94_1.var_.actorSpriteComps1029 = var_97_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_10 = 0.2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 and not isNil(var_97_8) then
				local var_97_11 = (arg_94_1.time_ - var_97_9) / var_97_10

				if arg_94_1.var_.actorSpriteComps1029 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								local var_97_12 = Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor1.r, var_97_11)
								local var_97_13 = Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor1.g, var_97_11)
								local var_97_14 = Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor1.b, var_97_11)

								iter_97_5.color = Color.New(var_97_12, var_97_13, var_97_14)
							else
								local var_97_15 = Mathf.Lerp(iter_97_5.color.r, 1, var_97_11)

								iter_97_5.color = Color.New(var_97_15, var_97_15, var_97_15)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps1029 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_97_7 then
						if arg_94_1.isInRecall_ then
							iter_97_7.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1029 = nil
			end

			local var_97_16 = 0
			local var_97_17 = 0.325

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_18 = arg_94_1:FormatText(StoryNameCfg[319].name)

				arg_94_1.leftNameTxt_.text = var_97_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_19 = arg_94_1:GetWordFromCfg(117011021)
				local var_97_20 = arg_94_1:FormatText(var_97_19.content)

				arg_94_1.text_.text = var_97_20

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_21 = 13
				local var_97_22 = utf8.len(var_97_20)
				local var_97_23 = var_97_21 <= 0 and var_97_17 or var_97_17 * (var_97_22 / var_97_21)

				if var_97_23 > 0 and var_97_17 < var_97_23 then
					arg_94_1.talkMaxDuration = var_97_23

					if var_97_23 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_20
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011021", "story_v_out_117011.awb") ~= 0 then
					local var_97_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011021", "story_v_out_117011.awb") / 1000

					if var_97_24 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_16
					end

					if var_97_19.prefab_name ~= "" and arg_94_1.actors_[var_97_19.prefab_name] ~= nil then
						local var_97_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_19.prefab_name].transform, "story_v_out_117011", "117011021", "story_v_out_117011.awb")

						arg_94_1:RecordAudio("117011021", var_97_25)
						arg_94_1:RecordAudio("117011021", var_97_25)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_117011", "117011021", "story_v_out_117011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_117011", "117011021", "story_v_out_117011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_26 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_26 and arg_94_1.time_ < var_97_16 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play117011022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 117011022
		arg_98_1.duration_ = 9.9

		local var_98_0 = {
			zh = 8.933,
			ja = 9.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play117011023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.975

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[319].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(117011022)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 39
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011022", "story_v_out_117011.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011022", "story_v_out_117011.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_117011", "117011022", "story_v_out_117011.awb")

						arg_98_1:RecordAudio("117011022", var_101_9)
						arg_98_1:RecordAudio("117011022", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_117011", "117011022", "story_v_out_117011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_117011", "117011022", "story_v_out_117011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play117011023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 117011023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play117011024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1029"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1029 == nil then
				arg_102_1.var_.actorSpriteComps1029 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps1029 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 0.5, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1029 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1029 = nil
			end

			local var_105_8 = 0
			local var_105_9 = 0.575

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(117011023)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_12 = 23
				local var_105_13 = utf8.len(var_105_11)
				local var_105_14 = var_105_12 <= 0 and var_105_9 or var_105_9 * (var_105_13 / var_105_12)

				if var_105_14 > 0 and var_105_9 < var_105_14 then
					arg_102_1.talkMaxDuration = var_105_14

					if var_105_14 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_15 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_15 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_15

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_15 and arg_102_1.time_ < var_105_8 + var_105_15 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play117011024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 117011024
		arg_106_1.duration_ = 7.7

		local var_106_0 = {
			zh = 6.8,
			ja = 7.7
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play117011025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1033"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1033 == nil then
				arg_106_1.var_.actorSpriteComps1033 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps1033 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1033 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1033 = nil
			end

			local var_109_8 = 0
			local var_109_9 = 0.825

			if var_109_8 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_10 = arg_106_1:FormatText(StoryNameCfg[236].name)

				arg_106_1.leftNameTxt_.text = var_109_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_11 = arg_106_1:GetWordFromCfg(117011024)
				local var_109_12 = arg_106_1:FormatText(var_109_11.content)

				arg_106_1.text_.text = var_109_12

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 33
				local var_109_14 = utf8.len(var_109_12)
				local var_109_15 = var_109_13 <= 0 and var_109_9 or var_109_9 * (var_109_14 / var_109_13)

				if var_109_15 > 0 and var_109_9 < var_109_15 then
					arg_106_1.talkMaxDuration = var_109_15

					if var_109_15 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_12
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011024", "story_v_out_117011.awb") ~= 0 then
					local var_109_16 = manager.audio:GetVoiceLength("story_v_out_117011", "117011024", "story_v_out_117011.awb") / 1000

					if var_109_16 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_8
					end

					if var_109_11.prefab_name ~= "" and arg_106_1.actors_[var_109_11.prefab_name] ~= nil then
						local var_109_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_11.prefab_name].transform, "story_v_out_117011", "117011024", "story_v_out_117011.awb")

						arg_106_1:RecordAudio("117011024", var_109_17)
						arg_106_1:RecordAudio("117011024", var_109_17)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_117011", "117011024", "story_v_out_117011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_117011", "117011024", "story_v_out_117011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_18 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_18

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_18 and arg_106_1.time_ < var_109_8 + var_109_18 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play117011025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 117011025
		arg_110_1.duration_ = 8.27

		local var_110_0 = {
			zh = 6.8,
			ja = 8.266
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play117011026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.9

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[236].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(117011025)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011025", "story_v_out_117011.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011025", "story_v_out_117011.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_117011", "117011025", "story_v_out_117011.awb")

						arg_110_1:RecordAudio("117011025", var_113_9)
						arg_110_1:RecordAudio("117011025", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_117011", "117011025", "story_v_out_117011.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_117011", "117011025", "story_v_out_117011.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play117011026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 117011026
		arg_114_1.duration_ = 5.77

		local var_114_0 = {
			zh = 3.6,
			ja = 5.766
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play117011027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1033"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1033 == nil then
				arg_114_1.var_.actorSpriteComps1033 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps1033 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 0.5, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1033 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps1033 = nil
			end

			local var_117_8 = arg_114_1.actors_["1029"]
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 and not isNil(var_117_8) and arg_114_1.var_.actorSpriteComps1029 == nil then
				arg_114_1.var_.actorSpriteComps1029 = var_117_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_10 = 0.2

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_10 and not isNil(var_117_8) then
				local var_117_11 = (arg_114_1.time_ - var_117_9) / var_117_10

				if arg_114_1.var_.actorSpriteComps1029 then
					for iter_117_4, iter_117_5 in pairs(arg_114_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_117_5 then
							if arg_114_1.isInRecall_ then
								local var_117_12 = Mathf.Lerp(iter_117_5.color.r, arg_114_1.hightColor1.r, var_117_11)
								local var_117_13 = Mathf.Lerp(iter_117_5.color.g, arg_114_1.hightColor1.g, var_117_11)
								local var_117_14 = Mathf.Lerp(iter_117_5.color.b, arg_114_1.hightColor1.b, var_117_11)

								iter_117_5.color = Color.New(var_117_12, var_117_13, var_117_14)
							else
								local var_117_15 = Mathf.Lerp(iter_117_5.color.r, 1, var_117_11)

								iter_117_5.color = Color.New(var_117_15, var_117_15, var_117_15)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_9 + var_117_10 and arg_114_1.time_ < var_117_9 + var_117_10 + arg_117_0 and not isNil(var_117_8) and arg_114_1.var_.actorSpriteComps1029 then
				for iter_117_6, iter_117_7 in pairs(arg_114_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_117_7 then
						if arg_114_1.isInRecall_ then
							iter_117_7.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_117_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps1029 = nil
			end

			local var_117_16 = 0
			local var_117_17 = 0.425

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_18 = arg_114_1:FormatText(StoryNameCfg[319].name)

				arg_114_1.leftNameTxt_.text = var_117_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_19 = arg_114_1:GetWordFromCfg(117011026)
				local var_117_20 = arg_114_1:FormatText(var_117_19.content)

				arg_114_1.text_.text = var_117_20

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_21 = 17
				local var_117_22 = utf8.len(var_117_20)
				local var_117_23 = var_117_21 <= 0 and var_117_17 or var_117_17 * (var_117_22 / var_117_21)

				if var_117_23 > 0 and var_117_17 < var_117_23 then
					arg_114_1.talkMaxDuration = var_117_23

					if var_117_23 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_16
					end
				end

				arg_114_1.text_.text = var_117_20
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011026", "story_v_out_117011.awb") ~= 0 then
					local var_117_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011026", "story_v_out_117011.awb") / 1000

					if var_117_24 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_24 + var_117_16
					end

					if var_117_19.prefab_name ~= "" and arg_114_1.actors_[var_117_19.prefab_name] ~= nil then
						local var_117_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_19.prefab_name].transform, "story_v_out_117011", "117011026", "story_v_out_117011.awb")

						arg_114_1:RecordAudio("117011026", var_117_25)
						arg_114_1:RecordAudio("117011026", var_117_25)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_117011", "117011026", "story_v_out_117011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_117011", "117011026", "story_v_out_117011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_26 = math.max(var_117_17, arg_114_1.talkMaxDuration)

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_26 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_16) / var_117_26

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_16 + var_117_26 and arg_114_1.time_ < var_117_16 + var_117_26 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play117011027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 117011027
		arg_118_1.duration_ = 1.53

		local var_118_0 = {
			zh = 1.533,
			ja = 0.999999999999
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play117011028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1033"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1033 == nil then
				arg_118_1.var_.actorSpriteComps1033 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps1033 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1033 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps1033 = nil
			end

			local var_121_8 = arg_118_1.actors_["1029"]
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps1029 == nil then
				arg_118_1.var_.actorSpriteComps1029 = var_121_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_10 = 0.2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 and not isNil(var_121_8) then
				local var_121_11 = (arg_118_1.time_ - var_121_9) / var_121_10

				if arg_118_1.var_.actorSpriteComps1029 then
					for iter_121_4, iter_121_5 in pairs(arg_118_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_121_5 then
							if arg_118_1.isInRecall_ then
								local var_121_12 = Mathf.Lerp(iter_121_5.color.r, arg_118_1.hightColor2.r, var_121_11)
								local var_121_13 = Mathf.Lerp(iter_121_5.color.g, arg_118_1.hightColor2.g, var_121_11)
								local var_121_14 = Mathf.Lerp(iter_121_5.color.b, arg_118_1.hightColor2.b, var_121_11)

								iter_121_5.color = Color.New(var_121_12, var_121_13, var_121_14)
							else
								local var_121_15 = Mathf.Lerp(iter_121_5.color.r, 0.5, var_121_11)

								iter_121_5.color = Color.New(var_121_15, var_121_15, var_121_15)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps1029 then
				for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_121_7 then
						if arg_118_1.isInRecall_ then
							iter_121_7.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps1029 = nil
			end

			local var_121_16 = 0
			local var_121_17 = 0.2

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_18 = arg_118_1:FormatText(StoryNameCfg[236].name)

				arg_118_1.leftNameTxt_.text = var_121_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_19 = arg_118_1:GetWordFromCfg(117011027)
				local var_121_20 = arg_118_1:FormatText(var_121_19.content)

				arg_118_1.text_.text = var_121_20

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_21 = 8
				local var_121_22 = utf8.len(var_121_20)
				local var_121_23 = var_121_21 <= 0 and var_121_17 or var_121_17 * (var_121_22 / var_121_21)

				if var_121_23 > 0 and var_121_17 < var_121_23 then
					arg_118_1.talkMaxDuration = var_121_23

					if var_121_23 + var_121_16 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_16
					end
				end

				arg_118_1.text_.text = var_121_20
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011027", "story_v_out_117011.awb") ~= 0 then
					local var_121_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011027", "story_v_out_117011.awb") / 1000

					if var_121_24 + var_121_16 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_24 + var_121_16
					end

					if var_121_19.prefab_name ~= "" and arg_118_1.actors_[var_121_19.prefab_name] ~= nil then
						local var_121_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_19.prefab_name].transform, "story_v_out_117011", "117011027", "story_v_out_117011.awb")

						arg_118_1:RecordAudio("117011027", var_121_25)
						arg_118_1:RecordAudio("117011027", var_121_25)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_117011", "117011027", "story_v_out_117011.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_117011", "117011027", "story_v_out_117011.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_26 = math.max(var_121_17, arg_118_1.talkMaxDuration)

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_26 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_16) / var_121_26

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_16 + var_121_26 and arg_118_1.time_ < var_121_16 + var_121_26 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play117011028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 117011028
		arg_122_1.duration_ = 6.57

		local var_122_0 = {
			zh = 6.566,
			ja = 5
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
				arg_122_0:Play117011029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1033"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1033 == nil then
				arg_122_1.var_.actorSpriteComps1033 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps1033 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 0.5, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1033 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1033 = nil
			end

			local var_125_8 = arg_122_1.actors_["1029"]
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps1029 == nil then
				arg_122_1.var_.actorSpriteComps1029 = var_125_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_10 = 0.2

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 and not isNil(var_125_8) then
				local var_125_11 = (arg_122_1.time_ - var_125_9) / var_125_10

				if arg_122_1.var_.actorSpriteComps1029 then
					for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_125_5 then
							if arg_122_1.isInRecall_ then
								local var_125_12 = Mathf.Lerp(iter_125_5.color.r, arg_122_1.hightColor1.r, var_125_11)
								local var_125_13 = Mathf.Lerp(iter_125_5.color.g, arg_122_1.hightColor1.g, var_125_11)
								local var_125_14 = Mathf.Lerp(iter_125_5.color.b, arg_122_1.hightColor1.b, var_125_11)

								iter_125_5.color = Color.New(var_125_12, var_125_13, var_125_14)
							else
								local var_125_15 = Mathf.Lerp(iter_125_5.color.r, 1, var_125_11)

								iter_125_5.color = Color.New(var_125_15, var_125_15, var_125_15)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps1029 then
				for iter_125_6, iter_125_7 in pairs(arg_122_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_125_7 then
						if arg_122_1.isInRecall_ then
							iter_125_7.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1029 = nil
			end

			local var_125_16 = 0
			local var_125_17 = 0.825

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_18 = arg_122_1:FormatText(StoryNameCfg[319].name)

				arg_122_1.leftNameTxt_.text = var_125_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_19 = arg_122_1:GetWordFromCfg(117011028)
				local var_125_20 = arg_122_1:FormatText(var_125_19.content)

				arg_122_1.text_.text = var_125_20

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_21 = 33
				local var_125_22 = utf8.len(var_125_20)
				local var_125_23 = var_125_21 <= 0 and var_125_17 or var_125_17 * (var_125_22 / var_125_21)

				if var_125_23 > 0 and var_125_17 < var_125_23 then
					arg_122_1.talkMaxDuration = var_125_23

					if var_125_23 + var_125_16 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_16
					end
				end

				arg_122_1.text_.text = var_125_20
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011028", "story_v_out_117011.awb") ~= 0 then
					local var_125_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011028", "story_v_out_117011.awb") / 1000

					if var_125_24 + var_125_16 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_24 + var_125_16
					end

					if var_125_19.prefab_name ~= "" and arg_122_1.actors_[var_125_19.prefab_name] ~= nil then
						local var_125_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_19.prefab_name].transform, "story_v_out_117011", "117011028", "story_v_out_117011.awb")

						arg_122_1:RecordAudio("117011028", var_125_25)
						arg_122_1:RecordAudio("117011028", var_125_25)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_117011", "117011028", "story_v_out_117011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_117011", "117011028", "story_v_out_117011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_26 = math.max(var_125_17, arg_122_1.talkMaxDuration)

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_26 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_16) / var_125_26

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_16 + var_125_26 and arg_122_1.time_ < var_125_16 + var_125_26 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play117011029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 117011029
		arg_126_1.duration_ = 1.73

		local var_126_0 = {
			zh = 0.999999999999,
			ja = 1.733
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play117011030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1033"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1033 = var_129_0.localPosition
				var_129_0.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("1033", 4)

				local var_129_2 = var_129_0.childCount

				for iter_129_0 = 0, var_129_2 - 1 do
					local var_129_3 = var_129_0:GetChild(iter_129_0)

					if var_129_3.name == "split_4" or not string.find(var_129_3.name, "split") then
						var_129_3.gameObject:SetActive(true)
					else
						var_129_3.gameObject:SetActive(false)
					end
				end
			end

			local var_129_4 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_4 then
				local var_129_5 = (arg_126_1.time_ - var_129_1) / var_129_4
				local var_129_6 = Vector3.New(390, -420, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1033, var_129_6, var_129_5)
			end

			if arg_126_1.time_ >= var_129_1 + var_129_4 and arg_126_1.time_ < var_129_1 + var_129_4 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_129_7 = arg_126_1.actors_["1033"]
			local var_129_8 = 0

			if var_129_8 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 and not isNil(var_129_7) and arg_126_1.var_.actorSpriteComps1033 == nil then
				arg_126_1.var_.actorSpriteComps1033 = var_129_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_9 = 0.2

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_9 and not isNil(var_129_7) then
				local var_129_10 = (arg_126_1.time_ - var_129_8) / var_129_9

				if arg_126_1.var_.actorSpriteComps1033 then
					for iter_129_1, iter_129_2 in pairs(arg_126_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_129_2 then
							if arg_126_1.isInRecall_ then
								local var_129_11 = Mathf.Lerp(iter_129_2.color.r, arg_126_1.hightColor1.r, var_129_10)
								local var_129_12 = Mathf.Lerp(iter_129_2.color.g, arg_126_1.hightColor1.g, var_129_10)
								local var_129_13 = Mathf.Lerp(iter_129_2.color.b, arg_126_1.hightColor1.b, var_129_10)

								iter_129_2.color = Color.New(var_129_11, var_129_12, var_129_13)
							else
								local var_129_14 = Mathf.Lerp(iter_129_2.color.r, 1, var_129_10)

								iter_129_2.color = Color.New(var_129_14, var_129_14, var_129_14)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_8 + var_129_9 and arg_126_1.time_ < var_129_8 + var_129_9 + arg_129_0 and not isNil(var_129_7) and arg_126_1.var_.actorSpriteComps1033 then
				for iter_129_3, iter_129_4 in pairs(arg_126_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_129_4 then
						if arg_126_1.isInRecall_ then
							iter_129_4.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1033 = nil
			end

			local var_129_15 = arg_126_1.actors_["1029"]
			local var_129_16 = 0

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 and not isNil(var_129_15) and arg_126_1.var_.actorSpriteComps1029 == nil then
				arg_126_1.var_.actorSpriteComps1029 = var_129_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_17 = 0.2

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_17 and not isNil(var_129_15) then
				local var_129_18 = (arg_126_1.time_ - var_129_16) / var_129_17

				if arg_126_1.var_.actorSpriteComps1029 then
					for iter_129_5, iter_129_6 in pairs(arg_126_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_129_6 then
							if arg_126_1.isInRecall_ then
								local var_129_19 = Mathf.Lerp(iter_129_6.color.r, arg_126_1.hightColor2.r, var_129_18)
								local var_129_20 = Mathf.Lerp(iter_129_6.color.g, arg_126_1.hightColor2.g, var_129_18)
								local var_129_21 = Mathf.Lerp(iter_129_6.color.b, arg_126_1.hightColor2.b, var_129_18)

								iter_129_6.color = Color.New(var_129_19, var_129_20, var_129_21)
							else
								local var_129_22 = Mathf.Lerp(iter_129_6.color.r, 0.5, var_129_18)

								iter_129_6.color = Color.New(var_129_22, var_129_22, var_129_22)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 and not isNil(var_129_15) and arg_126_1.var_.actorSpriteComps1029 then
				for iter_129_7, iter_129_8 in pairs(arg_126_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_129_8 then
						if arg_126_1.isInRecall_ then
							iter_129_8.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1029 = nil
			end

			local var_129_23 = 0
			local var_129_24 = 0.05

			if var_129_23 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_25 = arg_126_1:FormatText(StoryNameCfg[236].name)

				arg_126_1.leftNameTxt_.text = var_129_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_26 = arg_126_1:GetWordFromCfg(117011029)
				local var_129_27 = arg_126_1:FormatText(var_129_26.content)

				arg_126_1.text_.text = var_129_27

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_28 = 2
				local var_129_29 = utf8.len(var_129_27)
				local var_129_30 = var_129_28 <= 0 and var_129_24 or var_129_24 * (var_129_29 / var_129_28)

				if var_129_30 > 0 and var_129_24 < var_129_30 then
					arg_126_1.talkMaxDuration = var_129_30

					if var_129_30 + var_129_23 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_30 + var_129_23
					end
				end

				arg_126_1.text_.text = var_129_27
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011029", "story_v_out_117011.awb") ~= 0 then
					local var_129_31 = manager.audio:GetVoiceLength("story_v_out_117011", "117011029", "story_v_out_117011.awb") / 1000

					if var_129_31 + var_129_23 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_31 + var_129_23
					end

					if var_129_26.prefab_name ~= "" and arg_126_1.actors_[var_129_26.prefab_name] ~= nil then
						local var_129_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_26.prefab_name].transform, "story_v_out_117011", "117011029", "story_v_out_117011.awb")

						arg_126_1:RecordAudio("117011029", var_129_32)
						arg_126_1:RecordAudio("117011029", var_129_32)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_117011", "117011029", "story_v_out_117011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_117011", "117011029", "story_v_out_117011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_33 = math.max(var_129_24, arg_126_1.talkMaxDuration)

			if var_129_23 <= arg_126_1.time_ and arg_126_1.time_ < var_129_23 + var_129_33 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_23) / var_129_33

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_23 + var_129_33 and arg_126_1.time_ < var_129_23 + var_129_33 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play117011030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 117011030
		arg_130_1.duration_ = 8.03

		local var_130_0 = {
			zh = 5.7,
			ja = 8.033
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
				arg_130_0:Play117011031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1033"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1033 == nil then
				arg_130_1.var_.actorSpriteComps1033 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps1033 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 0.5, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1033 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1033 = nil
			end

			local var_133_8 = arg_130_1.actors_["1029"]
			local var_133_9 = 0

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.actorSpriteComps1029 == nil then
				arg_130_1.var_.actorSpriteComps1029 = var_133_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_10 = 0.2

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_10 and not isNil(var_133_8) then
				local var_133_11 = (arg_130_1.time_ - var_133_9) / var_133_10

				if arg_130_1.var_.actorSpriteComps1029 then
					for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_133_5 then
							if arg_130_1.isInRecall_ then
								local var_133_12 = Mathf.Lerp(iter_133_5.color.r, arg_130_1.hightColor1.r, var_133_11)
								local var_133_13 = Mathf.Lerp(iter_133_5.color.g, arg_130_1.hightColor1.g, var_133_11)
								local var_133_14 = Mathf.Lerp(iter_133_5.color.b, arg_130_1.hightColor1.b, var_133_11)

								iter_133_5.color = Color.New(var_133_12, var_133_13, var_133_14)
							else
								local var_133_15 = Mathf.Lerp(iter_133_5.color.r, 1, var_133_11)

								iter_133_5.color = Color.New(var_133_15, var_133_15, var_133_15)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_9 + var_133_10 and arg_130_1.time_ < var_133_9 + var_133_10 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.actorSpriteComps1029 then
				for iter_133_6, iter_133_7 in pairs(arg_130_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_133_7 then
						if arg_130_1.isInRecall_ then
							iter_133_7.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_133_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1029 = nil
			end

			local var_133_16 = 0
			local var_133_17 = 0.5

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_18 = arg_130_1:FormatText(StoryNameCfg[319].name)

				arg_130_1.leftNameTxt_.text = var_133_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_19 = arg_130_1:GetWordFromCfg(117011030)
				local var_133_20 = arg_130_1:FormatText(var_133_19.content)

				arg_130_1.text_.text = var_133_20

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_21 = 20
				local var_133_22 = utf8.len(var_133_20)
				local var_133_23 = var_133_21 <= 0 and var_133_17 or var_133_17 * (var_133_22 / var_133_21)

				if var_133_23 > 0 and var_133_17 < var_133_23 then
					arg_130_1.talkMaxDuration = var_133_23

					if var_133_23 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_16
					end
				end

				arg_130_1.text_.text = var_133_20
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011030", "story_v_out_117011.awb") ~= 0 then
					local var_133_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011030", "story_v_out_117011.awb") / 1000

					if var_133_24 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_16
					end

					if var_133_19.prefab_name ~= "" and arg_130_1.actors_[var_133_19.prefab_name] ~= nil then
						local var_133_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_19.prefab_name].transform, "story_v_out_117011", "117011030", "story_v_out_117011.awb")

						arg_130_1:RecordAudio("117011030", var_133_25)
						arg_130_1:RecordAudio("117011030", var_133_25)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_117011", "117011030", "story_v_out_117011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_117011", "117011030", "story_v_out_117011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_17, arg_130_1.talkMaxDuration)

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_16) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_16 + var_133_26 and arg_130_1.time_ < var_133_16 + var_133_26 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play117011031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 117011031
		arg_134_1.duration_ = 7.47

		local var_134_0 = {
			zh = 7.466,
			ja = 6.266
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
				arg_134_0:Play117011032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1033"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1033 = var_137_0.localPosition
				var_137_0.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1033", 4)

				local var_137_2 = var_137_0.childCount

				for iter_137_0 = 0, var_137_2 - 1 do
					local var_137_3 = var_137_0:GetChild(iter_137_0)

					if var_137_3.name == "split_6" or not string.find(var_137_3.name, "split") then
						var_137_3.gameObject:SetActive(true)
					else
						var_137_3.gameObject:SetActive(false)
					end
				end
			end

			local var_137_4 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_4 then
				local var_137_5 = (arg_134_1.time_ - var_137_1) / var_137_4
				local var_137_6 = Vector3.New(390, -420, 0)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1033, var_137_6, var_137_5)
			end

			if arg_134_1.time_ >= var_137_1 + var_137_4 and arg_134_1.time_ < var_137_1 + var_137_4 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_137_7 = arg_134_1.actors_["1033"]
			local var_137_8 = 0

			if var_137_8 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.actorSpriteComps1033 == nil then
				arg_134_1.var_.actorSpriteComps1033 = var_137_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_9 = 0.2

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_9 and not isNil(var_137_7) then
				local var_137_10 = (arg_134_1.time_ - var_137_8) / var_137_9

				if arg_134_1.var_.actorSpriteComps1033 then
					for iter_137_1, iter_137_2 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_137_2 then
							if arg_134_1.isInRecall_ then
								local var_137_11 = Mathf.Lerp(iter_137_2.color.r, arg_134_1.hightColor1.r, var_137_10)
								local var_137_12 = Mathf.Lerp(iter_137_2.color.g, arg_134_1.hightColor1.g, var_137_10)
								local var_137_13 = Mathf.Lerp(iter_137_2.color.b, arg_134_1.hightColor1.b, var_137_10)

								iter_137_2.color = Color.New(var_137_11, var_137_12, var_137_13)
							else
								local var_137_14 = Mathf.Lerp(iter_137_2.color.r, 1, var_137_10)

								iter_137_2.color = Color.New(var_137_14, var_137_14, var_137_14)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_8 + var_137_9 and arg_134_1.time_ < var_137_8 + var_137_9 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.actorSpriteComps1033 then
				for iter_137_3, iter_137_4 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_137_4 then
						if arg_134_1.isInRecall_ then
							iter_137_4.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1033 = nil
			end

			local var_137_15 = arg_134_1.actors_["1029"]
			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 and not isNil(var_137_15) and arg_134_1.var_.actorSpriteComps1029 == nil then
				arg_134_1.var_.actorSpriteComps1029 = var_137_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_17 = 0.2

			if var_137_16 <= arg_134_1.time_ and arg_134_1.time_ < var_137_16 + var_137_17 and not isNil(var_137_15) then
				local var_137_18 = (arg_134_1.time_ - var_137_16) / var_137_17

				if arg_134_1.var_.actorSpriteComps1029 then
					for iter_137_5, iter_137_6 in pairs(arg_134_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_137_6 then
							if arg_134_1.isInRecall_ then
								local var_137_19 = Mathf.Lerp(iter_137_6.color.r, arg_134_1.hightColor2.r, var_137_18)
								local var_137_20 = Mathf.Lerp(iter_137_6.color.g, arg_134_1.hightColor2.g, var_137_18)
								local var_137_21 = Mathf.Lerp(iter_137_6.color.b, arg_134_1.hightColor2.b, var_137_18)

								iter_137_6.color = Color.New(var_137_19, var_137_20, var_137_21)
							else
								local var_137_22 = Mathf.Lerp(iter_137_6.color.r, 0.5, var_137_18)

								iter_137_6.color = Color.New(var_137_22, var_137_22, var_137_22)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_16 + var_137_17 and arg_134_1.time_ < var_137_16 + var_137_17 + arg_137_0 and not isNil(var_137_15) and arg_134_1.var_.actorSpriteComps1029 then
				for iter_137_7, iter_137_8 in pairs(arg_134_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_137_8 then
						if arg_134_1.isInRecall_ then
							iter_137_8.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1029 = nil
			end

			local var_137_23 = 0
			local var_137_24 = 0.925

			if var_137_23 < arg_134_1.time_ and arg_134_1.time_ <= var_137_23 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_25 = arg_134_1:FormatText(StoryNameCfg[236].name)

				arg_134_1.leftNameTxt_.text = var_137_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_26 = arg_134_1:GetWordFromCfg(117011031)
				local var_137_27 = arg_134_1:FormatText(var_137_26.content)

				arg_134_1.text_.text = var_137_27

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_28 = 37
				local var_137_29 = utf8.len(var_137_27)
				local var_137_30 = var_137_28 <= 0 and var_137_24 or var_137_24 * (var_137_29 / var_137_28)

				if var_137_30 > 0 and var_137_24 < var_137_30 then
					arg_134_1.talkMaxDuration = var_137_30

					if var_137_30 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_30 + var_137_23
					end
				end

				arg_134_1.text_.text = var_137_27
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011031", "story_v_out_117011.awb") ~= 0 then
					local var_137_31 = manager.audio:GetVoiceLength("story_v_out_117011", "117011031", "story_v_out_117011.awb") / 1000

					if var_137_31 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_31 + var_137_23
					end

					if var_137_26.prefab_name ~= "" and arg_134_1.actors_[var_137_26.prefab_name] ~= nil then
						local var_137_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_26.prefab_name].transform, "story_v_out_117011", "117011031", "story_v_out_117011.awb")

						arg_134_1:RecordAudio("117011031", var_137_32)
						arg_134_1:RecordAudio("117011031", var_137_32)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_117011", "117011031", "story_v_out_117011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_117011", "117011031", "story_v_out_117011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_33 = math.max(var_137_24, arg_134_1.talkMaxDuration)

			if var_137_23 <= arg_134_1.time_ and arg_134_1.time_ < var_137_23 + var_137_33 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_23) / var_137_33

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_23 + var_137_33 and arg_134_1.time_ < var_137_23 + var_137_33 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play117011032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 117011032
		arg_138_1.duration_ = 9.9

		local var_138_0 = {
			zh = 9.9,
			ja = 7.766
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play117011033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1033"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1033 == nil then
				arg_138_1.var_.actorSpriteComps1033 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps1033 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 0.5, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1033 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1033 = nil
			end

			local var_141_8 = arg_138_1.actors_["1029"]
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1029 == nil then
				arg_138_1.var_.actorSpriteComps1029 = var_141_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_10 = 0.2

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_10 and not isNil(var_141_8) then
				local var_141_11 = (arg_138_1.time_ - var_141_9) / var_141_10

				if arg_138_1.var_.actorSpriteComps1029 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								local var_141_12 = Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor1.r, var_141_11)
								local var_141_13 = Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor1.g, var_141_11)
								local var_141_14 = Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor1.b, var_141_11)

								iter_141_5.color = Color.New(var_141_12, var_141_13, var_141_14)
							else
								local var_141_15 = Mathf.Lerp(iter_141_5.color.r, 1, var_141_11)

								iter_141_5.color = Color.New(var_141_15, var_141_15, var_141_15)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_9 + var_141_10 and arg_138_1.time_ < var_141_9 + var_141_10 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1029 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_141_7 then
						if arg_138_1.isInRecall_ then
							iter_141_7.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1029 = nil
			end

			local var_141_16 = 0
			local var_141_17 = 1.325

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_18 = arg_138_1:FormatText(StoryNameCfg[319].name)

				arg_138_1.leftNameTxt_.text = var_141_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_19 = arg_138_1:GetWordFromCfg(117011032)
				local var_141_20 = arg_138_1:FormatText(var_141_19.content)

				arg_138_1.text_.text = var_141_20

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_21 = 53
				local var_141_22 = utf8.len(var_141_20)
				local var_141_23 = var_141_21 <= 0 and var_141_17 or var_141_17 * (var_141_22 / var_141_21)

				if var_141_23 > 0 and var_141_17 < var_141_23 then
					arg_138_1.talkMaxDuration = var_141_23

					if var_141_23 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_16
					end
				end

				arg_138_1.text_.text = var_141_20
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011032", "story_v_out_117011.awb") ~= 0 then
					local var_141_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011032", "story_v_out_117011.awb") / 1000

					if var_141_24 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_24 + var_141_16
					end

					if var_141_19.prefab_name ~= "" and arg_138_1.actors_[var_141_19.prefab_name] ~= nil then
						local var_141_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_19.prefab_name].transform, "story_v_out_117011", "117011032", "story_v_out_117011.awb")

						arg_138_1:RecordAudio("117011032", var_141_25)
						arg_138_1:RecordAudio("117011032", var_141_25)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_117011", "117011032", "story_v_out_117011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_117011", "117011032", "story_v_out_117011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_26 = math.max(var_141_17, arg_138_1.talkMaxDuration)

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_26 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_16) / var_141_26

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_16 + var_141_26 and arg_138_1.time_ < var_141_16 + var_141_26 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play117011033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 117011033
		arg_142_1.duration_ = 12.57

		local var_142_0 = {
			zh = 12.566,
			ja = 9.6
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
				arg_142_0:Play117011034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.45

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[319].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(117011033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011033", "story_v_out_117011.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011033", "story_v_out_117011.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_117011", "117011033", "story_v_out_117011.awb")

						arg_142_1:RecordAudio("117011033", var_145_9)
						arg_142_1:RecordAudio("117011033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_117011", "117011033", "story_v_out_117011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_117011", "117011033", "story_v_out_117011.awb")
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
	Play117011034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 117011034
		arg_146_1.duration_ = 7.33

		local var_146_0 = {
			zh = 3.933,
			ja = 7.333
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
				arg_146_0:Play117011035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.425

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[319].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:GetWordFromCfg(117011034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011034", "story_v_out_117011.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011034", "story_v_out_117011.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_117011", "117011034", "story_v_out_117011.awb")

						arg_146_1:RecordAudio("117011034", var_149_9)
						arg_146_1:RecordAudio("117011034", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_117011", "117011034", "story_v_out_117011.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_117011", "117011034", "story_v_out_117011.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play117011035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 117011035
		arg_150_1.duration_ = 5.13

		local var_150_0 = {
			zh = 2.366,
			ja = 5.133
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
				arg_150_0:Play117011036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1033"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps1033 == nil then
				arg_150_1.var_.actorSpriteComps1033 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps1033 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 1, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps1033 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps1033 = nil
			end

			local var_153_8 = arg_150_1.actors_["1029"]
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps1029 == nil then
				arg_150_1.var_.actorSpriteComps1029 = var_153_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_10 = 0.2

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 and not isNil(var_153_8) then
				local var_153_11 = (arg_150_1.time_ - var_153_9) / var_153_10

				if arg_150_1.var_.actorSpriteComps1029 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								local var_153_12 = Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, var_153_11)
								local var_153_13 = Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, var_153_11)
								local var_153_14 = Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, var_153_11)

								iter_153_5.color = Color.New(var_153_12, var_153_13, var_153_14)
							else
								local var_153_15 = Mathf.Lerp(iter_153_5.color.r, 0.5, var_153_11)

								iter_153_5.color = Color.New(var_153_15, var_153_15, var_153_15)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps1029 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_153_7 then
						if arg_150_1.isInRecall_ then
							iter_153_7.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps1029 = nil
			end

			local var_153_16 = 0
			local var_153_17 = 0.175

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_18 = arg_150_1:FormatText(StoryNameCfg[236].name)

				arg_150_1.leftNameTxt_.text = var_153_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_19 = arg_150_1:GetWordFromCfg(117011035)
				local var_153_20 = arg_150_1:FormatText(var_153_19.content)

				arg_150_1.text_.text = var_153_20

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_21 = 7
				local var_153_22 = utf8.len(var_153_20)
				local var_153_23 = var_153_21 <= 0 and var_153_17 or var_153_17 * (var_153_22 / var_153_21)

				if var_153_23 > 0 and var_153_17 < var_153_23 then
					arg_150_1.talkMaxDuration = var_153_23

					if var_153_23 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_16
					end
				end

				arg_150_1.text_.text = var_153_20
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011035", "story_v_out_117011.awb") ~= 0 then
					local var_153_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011035", "story_v_out_117011.awb") / 1000

					if var_153_24 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_16
					end

					if var_153_19.prefab_name ~= "" and arg_150_1.actors_[var_153_19.prefab_name] ~= nil then
						local var_153_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_19.prefab_name].transform, "story_v_out_117011", "117011035", "story_v_out_117011.awb")

						arg_150_1:RecordAudio("117011035", var_153_25)
						arg_150_1:RecordAudio("117011035", var_153_25)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_117011", "117011035", "story_v_out_117011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_117011", "117011035", "story_v_out_117011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_26 = math.max(var_153_17, arg_150_1.talkMaxDuration)

			if var_153_16 <= arg_150_1.time_ and arg_150_1.time_ < var_153_16 + var_153_26 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_16) / var_153_26

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_16 + var_153_26 and arg_150_1.time_ < var_153_16 + var_153_26 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play117011036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 117011036
		arg_154_1.duration_ = 3.97

		local var_154_0 = {
			zh = 2.233,
			ja = 3.966
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
				arg_154_0:Play117011037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1033"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1033 == nil then
				arg_154_1.var_.actorSpriteComps1033 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps1033 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 0.5, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1033 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_157_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1033 = nil
			end

			local var_157_8 = arg_154_1.actors_["1029"]
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps1029 == nil then
				arg_154_1.var_.actorSpriteComps1029 = var_157_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_10 = 0.2

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_10 and not isNil(var_157_8) then
				local var_157_11 = (arg_154_1.time_ - var_157_9) / var_157_10

				if arg_154_1.var_.actorSpriteComps1029 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								local var_157_12 = Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, var_157_11)
								local var_157_13 = Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, var_157_11)
								local var_157_14 = Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, var_157_11)

								iter_157_5.color = Color.New(var_157_12, var_157_13, var_157_14)
							else
								local var_157_15 = Mathf.Lerp(iter_157_5.color.r, 1, var_157_11)

								iter_157_5.color = Color.New(var_157_15, var_157_15, var_157_15)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_9 + var_157_10 and arg_154_1.time_ < var_157_9 + var_157_10 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps1029 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_157_7 then
						if arg_154_1.isInRecall_ then
							iter_157_7.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1029 = nil
			end

			local var_157_16 = 0
			local var_157_17 = 0.225

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_18 = arg_154_1:FormatText(StoryNameCfg[319].name)

				arg_154_1.leftNameTxt_.text = var_157_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_19 = arg_154_1:GetWordFromCfg(117011036)
				local var_157_20 = arg_154_1:FormatText(var_157_19.content)

				arg_154_1.text_.text = var_157_20

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_21 = 9
				local var_157_22 = utf8.len(var_157_20)
				local var_157_23 = var_157_21 <= 0 and var_157_17 or var_157_17 * (var_157_22 / var_157_21)

				if var_157_23 > 0 and var_157_17 < var_157_23 then
					arg_154_1.talkMaxDuration = var_157_23

					if var_157_23 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_16
					end
				end

				arg_154_1.text_.text = var_157_20
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011036", "story_v_out_117011.awb") ~= 0 then
					local var_157_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011036", "story_v_out_117011.awb") / 1000

					if var_157_24 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_16
					end

					if var_157_19.prefab_name ~= "" and arg_154_1.actors_[var_157_19.prefab_name] ~= nil then
						local var_157_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_19.prefab_name].transform, "story_v_out_117011", "117011036", "story_v_out_117011.awb")

						arg_154_1:RecordAudio("117011036", var_157_25)
						arg_154_1:RecordAudio("117011036", var_157_25)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_117011", "117011036", "story_v_out_117011.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_117011", "117011036", "story_v_out_117011.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_26 = math.max(var_157_17, arg_154_1.talkMaxDuration)

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_26 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_16) / var_157_26

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_16 + var_157_26 and arg_154_1.time_ < var_157_16 + var_157_26 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play117011037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 117011037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play117011038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1029"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1029 == nil then
				arg_158_1.var_.actorSpriteComps1029 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps1029 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 0.5, var_161_3)

								iter_161_1.color = Color.New(var_161_7, var_161_7, var_161_7)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1029 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps1029 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.425

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:GetWordFromCfg(117011037)
				local var_161_11 = arg_158_1:FormatText(var_161_10.content)

				arg_158_1.text_.text = var_161_11

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_12 = 17
				local var_161_13 = utf8.len(var_161_11)
				local var_161_14 = var_161_12 <= 0 and var_161_9 or var_161_9 * (var_161_13 / var_161_12)

				if var_161_14 > 0 and var_161_9 < var_161_14 then
					arg_158_1.talkMaxDuration = var_161_14

					if var_161_14 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_11
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_15 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_15 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_15

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_15 and arg_158_1.time_ < var_161_8 + var_161_15 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play117011038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 117011038
		arg_162_1.duration_ = 2.97

		local var_162_0 = {
			zh = 2.966,
			ja = 2.7
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
				arg_162_0:Play117011039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1029"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1029 == nil then
				arg_162_1.var_.actorSpriteComps1029 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps1029 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 1, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1029 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_165_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps1029 = nil
			end

			local var_165_8 = 0
			local var_165_9 = 0.4

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_10 = arg_162_1:FormatText(StoryNameCfg[319].name)

				arg_162_1.leftNameTxt_.text = var_165_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_11 = arg_162_1:GetWordFromCfg(117011038)
				local var_165_12 = arg_162_1:FormatText(var_165_11.content)

				arg_162_1.text_.text = var_165_12

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_13 = 16
				local var_165_14 = utf8.len(var_165_12)
				local var_165_15 = var_165_13 <= 0 and var_165_9 or var_165_9 * (var_165_14 / var_165_13)

				if var_165_15 > 0 and var_165_9 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15

					if var_165_15 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_12
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011038", "story_v_out_117011.awb") ~= 0 then
					local var_165_16 = manager.audio:GetVoiceLength("story_v_out_117011", "117011038", "story_v_out_117011.awb") / 1000

					if var_165_16 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_16 + var_165_8
					end

					if var_165_11.prefab_name ~= "" and arg_162_1.actors_[var_165_11.prefab_name] ~= nil then
						local var_165_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_11.prefab_name].transform, "story_v_out_117011", "117011038", "story_v_out_117011.awb")

						arg_162_1:RecordAudio("117011038", var_165_17)
						arg_162_1:RecordAudio("117011038", var_165_17)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_117011", "117011038", "story_v_out_117011.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_117011", "117011038", "story_v_out_117011.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_18 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_18 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_18

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_18 and arg_162_1.time_ < var_165_8 + var_165_18 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play117011039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 117011039
		arg_166_1.duration_ = 3.47

		local var_166_0 = {
			zh = 2.4,
			ja = 3.466
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
				arg_166_0:Play117011040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1029"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1029 == nil then
				arg_166_1.var_.actorSpriteComps1029 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps1029 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 0.5, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1029 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1029 = nil
			end

			local var_169_8 = arg_166_1.actors_["1033"]
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1033 == nil then
				arg_166_1.var_.actorSpriteComps1033 = var_169_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_10 = 0.2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 and not isNil(var_169_8) then
				local var_169_11 = (arg_166_1.time_ - var_169_9) / var_169_10

				if arg_166_1.var_.actorSpriteComps1033 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								local var_169_12 = Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor1.r, var_169_11)
								local var_169_13 = Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor1.g, var_169_11)
								local var_169_14 = Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor1.b, var_169_11)

								iter_169_5.color = Color.New(var_169_12, var_169_13, var_169_14)
							else
								local var_169_15 = Mathf.Lerp(iter_169_5.color.r, 1, var_169_11)

								iter_169_5.color = Color.New(var_169_15, var_169_15, var_169_15)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1033 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_169_7 then
						if arg_166_1.isInRecall_ then
							iter_169_7.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1033 = nil
			end

			local var_169_16 = 0
			local var_169_17 = 0.3

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_18 = arg_166_1:FormatText(StoryNameCfg[236].name)

				arg_166_1.leftNameTxt_.text = var_169_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_19 = arg_166_1:GetWordFromCfg(117011039)
				local var_169_20 = arg_166_1:FormatText(var_169_19.content)

				arg_166_1.text_.text = var_169_20

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_21 = 10
				local var_169_22 = utf8.len(var_169_20)
				local var_169_23 = var_169_21 <= 0 and var_169_17 or var_169_17 * (var_169_22 / var_169_21)

				if var_169_23 > 0 and var_169_17 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23

					if var_169_23 + var_169_16 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_16
					end
				end

				arg_166_1.text_.text = var_169_20
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011039", "story_v_out_117011.awb") ~= 0 then
					local var_169_24 = manager.audio:GetVoiceLength("story_v_out_117011", "117011039", "story_v_out_117011.awb") / 1000

					if var_169_24 + var_169_16 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_24 + var_169_16
					end

					if var_169_19.prefab_name ~= "" and arg_166_1.actors_[var_169_19.prefab_name] ~= nil then
						local var_169_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_19.prefab_name].transform, "story_v_out_117011", "117011039", "story_v_out_117011.awb")

						arg_166_1:RecordAudio("117011039", var_169_25)
						arg_166_1:RecordAudio("117011039", var_169_25)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_117011", "117011039", "story_v_out_117011.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_117011", "117011039", "story_v_out_117011.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_26 = math.max(var_169_17, arg_166_1.talkMaxDuration)

			if var_169_16 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_26 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_16) / var_169_26

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_16 + var_169_26 and arg_166_1.time_ < var_169_16 + var_169_26 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play117011040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 117011040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play117011041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1033"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				local var_173_2 = var_173_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_173_2 then
					arg_170_1.var_.alphaOldValue1033 = var_173_2.alpha
					arg_170_1.var_.characterEffect1033 = var_173_2
				end

				arg_170_1.var_.alphaOldValue1033 = 1
			end

			local var_173_3 = 0.333333333333333

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_3 then
				local var_173_4 = (arg_170_1.time_ - var_173_1) / var_173_3
				local var_173_5 = Mathf.Lerp(arg_170_1.var_.alphaOldValue1033, 0, var_173_4)

				if arg_170_1.var_.characterEffect1033 then
					arg_170_1.var_.characterEffect1033.alpha = var_173_5
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_3 and arg_170_1.time_ < var_173_1 + var_173_3 + arg_173_0 and arg_170_1.var_.characterEffect1033 then
				arg_170_1.var_.characterEffect1033.alpha = 0
			end

			local var_173_6 = arg_170_1.actors_["1029"]
			local var_173_7 = 0

			if var_173_7 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 then
				local var_173_8 = var_173_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_173_8 then
					arg_170_1.var_.alphaOldValue1029 = var_173_8.alpha
					arg_170_1.var_.characterEffect1029 = var_173_8
				end

				arg_170_1.var_.alphaOldValue1029 = 1
			end

			local var_173_9 = 0.333333333333333

			if var_173_7 <= arg_170_1.time_ and arg_170_1.time_ < var_173_7 + var_173_9 then
				local var_173_10 = (arg_170_1.time_ - var_173_7) / var_173_9
				local var_173_11 = Mathf.Lerp(arg_170_1.var_.alphaOldValue1029, 0, var_173_10)

				if arg_170_1.var_.characterEffect1029 then
					arg_170_1.var_.characterEffect1029.alpha = var_173_11
				end
			end

			if arg_170_1.time_ >= var_173_7 + var_173_9 and arg_170_1.time_ < var_173_7 + var_173_9 + arg_173_0 and arg_170_1.var_.characterEffect1029 then
				arg_170_1.var_.characterEffect1029.alpha = 0
			end

			local var_173_12 = 0
			local var_173_13 = 0.975

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_14 = arg_170_1:GetWordFromCfg(117011040)
				local var_173_15 = arg_170_1:FormatText(var_173_14.content)

				arg_170_1.text_.text = var_173_15

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_16 = 39
				local var_173_17 = utf8.len(var_173_15)
				local var_173_18 = var_173_16 <= 0 and var_173_13 or var_173_13 * (var_173_17 / var_173_16)

				if var_173_18 > 0 and var_173_13 < var_173_18 then
					arg_170_1.talkMaxDuration = var_173_18

					if var_173_18 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_18 + var_173_12
					end
				end

				arg_170_1.text_.text = var_173_15
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_19 = math.max(var_173_13, arg_170_1.talkMaxDuration)

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_19 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_12) / var_173_19

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_12 + var_173_19 and arg_170_1.time_ < var_173_12 + var_173_19 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play117011041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 117011041
		arg_174_1.duration_ = 4.8

		local var_174_0 = {
			zh = 3.333,
			ja = 4.8
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
				arg_174_0:Play117011042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1029"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				local var_177_2 = var_177_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_177_2 then
					arg_174_1.var_.alphaOldValue1029 = var_177_2.alpha
					arg_174_1.var_.characterEffect1029 = var_177_2
				end

				arg_174_1.var_.alphaOldValue1029 = 0
			end

			local var_177_3 = 0.333333333333333

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_3 then
				local var_177_4 = (arg_174_1.time_ - var_177_1) / var_177_3
				local var_177_5 = Mathf.Lerp(arg_174_1.var_.alphaOldValue1029, 1, var_177_4)

				if arg_174_1.var_.characterEffect1029 then
					arg_174_1.var_.characterEffect1029.alpha = var_177_5
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_3 and arg_174_1.time_ < var_177_1 + var_177_3 + arg_177_0 and arg_174_1.var_.characterEffect1029 then
				arg_174_1.var_.characterEffect1029.alpha = 1
			end

			local var_177_6 = arg_174_1.actors_["1029"].transform
			local var_177_7 = 0

			if var_177_7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.var_.moveOldPos1029 = var_177_6.localPosition
				var_177_6.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1029", 3)

				local var_177_8 = var_177_6.childCount

				for iter_177_0 = 0, var_177_8 - 1 do
					local var_177_9 = var_177_6:GetChild(iter_177_0)

					if var_177_9.name == "split_1" or not string.find(var_177_9.name, "split") then
						var_177_9.gameObject:SetActive(true)
					else
						var_177_9.gameObject:SetActive(false)
					end
				end
			end

			local var_177_10 = 0.001

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_10 then
				local var_177_11 = (arg_174_1.time_ - var_177_7) / var_177_10
				local var_177_12 = Vector3.New(0, -355, -140)

				var_177_6.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1029, var_177_12, var_177_11)
			end

			if arg_174_1.time_ >= var_177_7 + var_177_10 and arg_174_1.time_ < var_177_7 + var_177_10 + arg_177_0 then
				var_177_6.localPosition = Vector3.New(0, -355, -140)
			end

			local var_177_13 = arg_174_1.actors_["1029"]
			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 and not isNil(var_177_13) and arg_174_1.var_.actorSpriteComps1029 == nil then
				arg_174_1.var_.actorSpriteComps1029 = var_177_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_15 = 0.2

			if var_177_14 <= arg_174_1.time_ and arg_174_1.time_ < var_177_14 + var_177_15 and not isNil(var_177_13) then
				local var_177_16 = (arg_174_1.time_ - var_177_14) / var_177_15

				if arg_174_1.var_.actorSpriteComps1029 then
					for iter_177_1, iter_177_2 in pairs(arg_174_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_177_2 then
							if arg_174_1.isInRecall_ then
								local var_177_17 = Mathf.Lerp(iter_177_2.color.r, arg_174_1.hightColor1.r, var_177_16)
								local var_177_18 = Mathf.Lerp(iter_177_2.color.g, arg_174_1.hightColor1.g, var_177_16)
								local var_177_19 = Mathf.Lerp(iter_177_2.color.b, arg_174_1.hightColor1.b, var_177_16)

								iter_177_2.color = Color.New(var_177_17, var_177_18, var_177_19)
							else
								local var_177_20 = Mathf.Lerp(iter_177_2.color.r, 1, var_177_16)

								iter_177_2.color = Color.New(var_177_20, var_177_20, var_177_20)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_14 + var_177_15 and arg_174_1.time_ < var_177_14 + var_177_15 + arg_177_0 and not isNil(var_177_13) and arg_174_1.var_.actorSpriteComps1029 then
				for iter_177_3, iter_177_4 in pairs(arg_174_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_177_4 then
						if arg_174_1.isInRecall_ then
							iter_177_4.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1029 = nil
			end

			local var_177_21 = 0
			local var_177_22 = 0.375

			if var_177_21 < arg_174_1.time_ and arg_174_1.time_ <= var_177_21 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_23 = arg_174_1:FormatText(StoryNameCfg[319].name)

				arg_174_1.leftNameTxt_.text = var_177_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_24 = arg_174_1:GetWordFromCfg(117011041)
				local var_177_25 = arg_174_1:FormatText(var_177_24.content)

				arg_174_1.text_.text = var_177_25

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_26 = 15
				local var_177_27 = utf8.len(var_177_25)
				local var_177_28 = var_177_26 <= 0 and var_177_22 or var_177_22 * (var_177_27 / var_177_26)

				if var_177_28 > 0 and var_177_22 < var_177_28 then
					arg_174_1.talkMaxDuration = var_177_28

					if var_177_28 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_28 + var_177_21
					end
				end

				arg_174_1.text_.text = var_177_25
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011041", "story_v_out_117011.awb") ~= 0 then
					local var_177_29 = manager.audio:GetVoiceLength("story_v_out_117011", "117011041", "story_v_out_117011.awb") / 1000

					if var_177_29 + var_177_21 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_29 + var_177_21
					end

					if var_177_24.prefab_name ~= "" and arg_174_1.actors_[var_177_24.prefab_name] ~= nil then
						local var_177_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_24.prefab_name].transform, "story_v_out_117011", "117011041", "story_v_out_117011.awb")

						arg_174_1:RecordAudio("117011041", var_177_30)
						arg_174_1:RecordAudio("117011041", var_177_30)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_117011", "117011041", "story_v_out_117011.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_117011", "117011041", "story_v_out_117011.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_31 = math.max(var_177_22, arg_174_1.talkMaxDuration)

			if var_177_21 <= arg_174_1.time_ and arg_174_1.time_ < var_177_21 + var_177_31 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_21) / var_177_31

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_21 + var_177_31 and arg_174_1.time_ < var_177_21 + var_177_31 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play117011042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 117011042
		arg_178_1.duration_ = 11.37

		local var_178_0 = {
			zh = 9.633,
			ja = 11.366
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
				arg_178_0:Play117011043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = "ST03"

			if arg_178_1.bgs_[var_181_0] == nil then
				local var_181_1 = Object.Instantiate(arg_178_1.paintGo_)

				var_181_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_181_0)
				var_181_1.name = var_181_0
				var_181_1.transform.parent = arg_178_1.stage_.transform
				var_181_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.bgs_[var_181_0] = var_181_1
			end

			local var_181_2 = 2

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				local var_181_3 = manager.ui.mainCamera.transform.localPosition
				local var_181_4 = Vector3.New(0, 0, 10) + Vector3.New(var_181_3.x, var_181_3.y, 0)
				local var_181_5 = arg_178_1.bgs_.ST03

				var_181_5.transform.localPosition = var_181_4
				var_181_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_6 = var_181_5:GetComponent("SpriteRenderer")

				if var_181_6 and var_181_6.sprite then
					local var_181_7 = (var_181_5.transform.localPosition - var_181_3).z
					local var_181_8 = manager.ui.mainCameraCom_
					local var_181_9 = 2 * var_181_7 * Mathf.Tan(var_181_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_181_10 = var_181_9 * var_181_8.aspect
					local var_181_11 = var_181_6.sprite.bounds.size.x
					local var_181_12 = var_181_6.sprite.bounds.size.y
					local var_181_13 = var_181_10 / var_181_11
					local var_181_14 = var_181_9 / var_181_12
					local var_181_15 = var_181_14 < var_181_13 and var_181_13 or var_181_14

					var_181_5.transform.localScale = Vector3.New(var_181_15, var_181_15, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST03" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_17 = 2

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_17 then
				local var_181_18 = (arg_178_1.time_ - var_181_16) / var_181_17
				local var_181_19 = Color.New(0, 0, 0)

				var_181_19.a = Mathf.Lerp(0, 1, var_181_18)
				arg_178_1.mask_.color = var_181_19
			end

			if arg_178_1.time_ >= var_181_16 + var_181_17 and arg_178_1.time_ < var_181_16 + var_181_17 + arg_181_0 then
				local var_181_20 = Color.New(0, 0, 0)

				var_181_20.a = 1
				arg_178_1.mask_.color = var_181_20
			end

			local var_181_21 = 2

			if var_181_21 < arg_178_1.time_ and arg_178_1.time_ <= var_181_21 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_22 = 2

			if var_181_21 <= arg_178_1.time_ and arg_178_1.time_ < var_181_21 + var_181_22 then
				local var_181_23 = (arg_178_1.time_ - var_181_21) / var_181_22
				local var_181_24 = Color.New(0, 0, 0)

				var_181_24.a = Mathf.Lerp(1, 0, var_181_23)
				arg_178_1.mask_.color = var_181_24
			end

			if arg_178_1.time_ >= var_181_21 + var_181_22 and arg_178_1.time_ < var_181_21 + var_181_22 + arg_181_0 then
				local var_181_25 = Color.New(0, 0, 0)
				local var_181_26 = 0

				arg_178_1.mask_.enabled = false
				var_181_25.a = var_181_26
				arg_178_1.mask_.color = var_181_25
			end

			local var_181_27 = arg_178_1.actors_["1029"].transform
			local var_181_28 = 1.966

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1.var_.moveOldPos1029 = var_181_27.localPosition
				var_181_27.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1029", 7)

				local var_181_29 = var_181_27.childCount

				for iter_181_2 = 0, var_181_29 - 1 do
					local var_181_30 = var_181_27:GetChild(iter_181_2)

					if var_181_30.name == "split_1" or not string.find(var_181_30.name, "split") then
						var_181_30.gameObject:SetActive(true)
					else
						var_181_30.gameObject:SetActive(false)
					end
				end
			end

			local var_181_31 = 0.001

			if var_181_28 <= arg_178_1.time_ and arg_178_1.time_ < var_181_28 + var_181_31 then
				local var_181_32 = (arg_178_1.time_ - var_181_28) / var_181_31
				local var_181_33 = Vector3.New(0, -2000, -140)

				var_181_27.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1029, var_181_33, var_181_32)
			end

			if arg_178_1.time_ >= var_181_28 + var_181_31 and arg_178_1.time_ < var_181_28 + var_181_31 + arg_181_0 then
				var_181_27.localPosition = Vector3.New(0, -2000, -140)
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_34 = 4
			local var_181_35 = 0.825

			if var_181_34 < arg_178_1.time_ and arg_178_1.time_ <= var_181_34 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_36 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_36:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_37 = arg_178_1:FormatText(StoryNameCfg[144].name)

				arg_178_1.leftNameTxt_.text = var_181_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_38 = arg_178_1:GetWordFromCfg(117011042)
				local var_181_39 = arg_178_1:FormatText(var_181_38.content)

				arg_178_1.text_.text = var_181_39

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_40 = 33
				local var_181_41 = utf8.len(var_181_39)
				local var_181_42 = var_181_40 <= 0 and var_181_35 or var_181_35 * (var_181_41 / var_181_40)

				if var_181_42 > 0 and var_181_35 < var_181_42 then
					arg_178_1.talkMaxDuration = var_181_42
					var_181_34 = var_181_34 + 0.3

					if var_181_42 + var_181_34 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_42 + var_181_34
					end
				end

				arg_178_1.text_.text = var_181_39
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011042", "story_v_out_117011.awb") ~= 0 then
					local var_181_43 = manager.audio:GetVoiceLength("story_v_out_117011", "117011042", "story_v_out_117011.awb") / 1000

					if var_181_43 + var_181_34 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_43 + var_181_34
					end

					if var_181_38.prefab_name ~= "" and arg_178_1.actors_[var_181_38.prefab_name] ~= nil then
						local var_181_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_38.prefab_name].transform, "story_v_out_117011", "117011042", "story_v_out_117011.awb")

						arg_178_1:RecordAudio("117011042", var_181_44)
						arg_178_1:RecordAudio("117011042", var_181_44)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_117011", "117011042", "story_v_out_117011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_117011", "117011042", "story_v_out_117011.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_45 = var_181_34 + 0.3
			local var_181_46 = math.max(var_181_35, arg_178_1.talkMaxDuration)

			if var_181_45 <= arg_178_1.time_ and arg_178_1.time_ < var_181_45 + var_181_46 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_45) / var_181_46

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_45 + var_181_46 and arg_178_1.time_ < var_181_45 + var_181_46 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play117011043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 117011043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play117011044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 1

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				local var_187_2 = "play"
				local var_187_3 = "effect"

				arg_184_1:AudioAction(var_187_2, var_187_3, "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd.awb")
			end

			local var_187_4 = 0
			local var_187_5 = 1.225

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(117011043)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 49
				local var_187_9 = utf8.len(var_187_7)
				local var_187_10 = var_187_8 <= 0 and var_187_5 or var_187_5 * (var_187_9 / var_187_8)

				if var_187_10 > 0 and var_187_5 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_11 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_11 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_11

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_11 and arg_184_1.time_ < var_187_4 + var_187_11 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play117011044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 117011044
		arg_188_1.duration_ = 1.9

		local var_188_0 = {
			zh = 1.9,
			ja = 1.333
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play117011045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.25

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[144].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:GetWordFromCfg(117011044)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 10
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011044", "story_v_out_117011.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011044", "story_v_out_117011.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_117011", "117011044", "story_v_out_117011.awb")

						arg_188_1:RecordAudio("117011044", var_191_9)
						arg_188_1:RecordAudio("117011044", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_117011", "117011044", "story_v_out_117011.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_117011", "117011044", "story_v_out_117011.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play117011045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 117011045
		arg_192_1.duration_ = 10.77

		local var_192_0 = {
			zh = 5.9,
			ja = 10.766
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play117011046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = "1132"

			if arg_192_1.actors_[var_195_0] == nil then
				local var_195_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_195_1) then
					local var_195_2 = Object.Instantiate(var_195_1, arg_192_1.canvasGo_.transform)

					var_195_2.transform:SetSiblingIndex(1)

					var_195_2.name = var_195_0
					var_195_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_192_1.actors_[var_195_0] = var_195_2

					local var_195_3 = var_195_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_192_1.isInRecall_ then
						for iter_195_0, iter_195_1 in ipairs(var_195_3) do
							iter_195_1.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_195_4 = arg_192_1.actors_["1132"].transform
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.var_.moveOldPos1132 = var_195_4.localPosition
				var_195_4.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1132", 3)

				local var_195_6 = var_195_4.childCount

				for iter_195_2 = 0, var_195_6 - 1 do
					local var_195_7 = var_195_4:GetChild(iter_195_2)

					if var_195_7.name == "split_6" or not string.find(var_195_7.name, "split") then
						var_195_7.gameObject:SetActive(true)
					else
						var_195_7.gameObject:SetActive(false)
					end
				end
			end

			local var_195_8 = 0.001

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_8 then
				local var_195_9 = (arg_192_1.time_ - var_195_5) / var_195_8
				local var_195_10 = Vector3.New(0, -413, -185)

				var_195_4.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1132, var_195_10, var_195_9)
			end

			if arg_192_1.time_ >= var_195_5 + var_195_8 and arg_192_1.time_ < var_195_5 + var_195_8 + arg_195_0 then
				var_195_4.localPosition = Vector3.New(0, -413, -185)
			end

			local var_195_11 = arg_192_1.actors_["1132"]
			local var_195_12 = 0

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				local var_195_13 = var_195_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_195_13 then
					arg_192_1.var_.alphaOldValue1132 = var_195_13.alpha
					arg_192_1.var_.characterEffect1132 = var_195_13
				end

				arg_192_1.var_.alphaOldValue1132 = 0
			end

			local var_195_14 = 0.333333333333333

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_14 then
				local var_195_15 = (arg_192_1.time_ - var_195_12) / var_195_14
				local var_195_16 = Mathf.Lerp(arg_192_1.var_.alphaOldValue1132, 1, var_195_15)

				if arg_192_1.var_.characterEffect1132 then
					arg_192_1.var_.characterEffect1132.alpha = var_195_16
				end
			end

			if arg_192_1.time_ >= var_195_12 + var_195_14 and arg_192_1.time_ < var_195_12 + var_195_14 + arg_195_0 and arg_192_1.var_.characterEffect1132 then
				arg_192_1.var_.characterEffect1132.alpha = 1
			end

			local var_195_17 = 0
			local var_195_18 = 0.875

			if var_195_17 < arg_192_1.time_ and arg_192_1.time_ <= var_195_17 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_19 = arg_192_1:FormatText(StoryNameCfg[61].name)

				arg_192_1.leftNameTxt_.text = var_195_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_20 = arg_192_1:GetWordFromCfg(117011045)
				local var_195_21 = arg_192_1:FormatText(var_195_20.content)

				arg_192_1.text_.text = var_195_21

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_22 = 35
				local var_195_23 = utf8.len(var_195_21)
				local var_195_24 = var_195_22 <= 0 and var_195_18 or var_195_18 * (var_195_23 / var_195_22)

				if var_195_24 > 0 and var_195_18 < var_195_24 then
					arg_192_1.talkMaxDuration = var_195_24

					if var_195_24 + var_195_17 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_24 + var_195_17
					end
				end

				arg_192_1.text_.text = var_195_21
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011045", "story_v_out_117011.awb") ~= 0 then
					local var_195_25 = manager.audio:GetVoiceLength("story_v_out_117011", "117011045", "story_v_out_117011.awb") / 1000

					if var_195_25 + var_195_17 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_25 + var_195_17
					end

					if var_195_20.prefab_name ~= "" and arg_192_1.actors_[var_195_20.prefab_name] ~= nil then
						local var_195_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_20.prefab_name].transform, "story_v_out_117011", "117011045", "story_v_out_117011.awb")

						arg_192_1:RecordAudio("117011045", var_195_26)
						arg_192_1:RecordAudio("117011045", var_195_26)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_117011", "117011045", "story_v_out_117011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_117011", "117011045", "story_v_out_117011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_27 = math.max(var_195_18, arg_192_1.talkMaxDuration)

			if var_195_17 <= arg_192_1.time_ and arg_192_1.time_ < var_195_17 + var_195_27 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_17) / var_195_27

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_17 + var_195_27 and arg_192_1.time_ < var_195_17 + var_195_27 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play117011046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 117011046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play117011047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1132"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				local var_199_2 = var_199_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_199_2 then
					arg_196_1.var_.alphaOldValue1132 = var_199_2.alpha
					arg_196_1.var_.characterEffect1132 = var_199_2
				end

				arg_196_1.var_.alphaOldValue1132 = 1
			end

			local var_199_3 = 0.333333333333333

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Mathf.Lerp(arg_196_1.var_.alphaOldValue1132, 0, var_199_4)

				if arg_196_1.var_.characterEffect1132 then
					arg_196_1.var_.characterEffect1132.alpha = var_199_5
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 and arg_196_1.var_.characterEffect1132 then
				arg_196_1.var_.characterEffect1132.alpha = 0
			end

			local var_199_6 = 0
			local var_199_7 = 0.525

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_8 = arg_196_1:GetWordFromCfg(117011046)
				local var_199_9 = arg_196_1:FormatText(var_199_8.content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 21
				local var_199_11 = utf8.len(var_199_9)
				local var_199_12 = var_199_10 <= 0 and var_199_7 or var_199_7 * (var_199_11 / var_199_10)

				if var_199_12 > 0 and var_199_7 < var_199_12 then
					arg_196_1.talkMaxDuration = var_199_12

					if var_199_12 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_13 and arg_196_1.time_ < var_199_6 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play117011047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 117011047
		arg_200_1.duration_ = 7.8

		local var_200_0 = {
			zh = 6.9,
			ja = 7.8
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play117011048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.925

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[144].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(117011047)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 37
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011047", "story_v_out_117011.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011047", "story_v_out_117011.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_117011", "117011047", "story_v_out_117011.awb")

						arg_200_1:RecordAudio("117011047", var_203_9)
						arg_200_1:RecordAudio("117011047", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_117011", "117011047", "story_v_out_117011.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_117011", "117011047", "story_v_out_117011.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play117011048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 117011048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
			arg_204_1.auto_ = false
		end

		function arg_204_1.playNext_(arg_206_0)
			arg_204_1.onStoryFinished_()
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.925

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(117011048)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 37
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08b",
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST03"
	},
	voices = {
		"story_v_out_117011.awb"
	}
}
