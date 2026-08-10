return {
	Play416042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416042001
		arg_1_1.duration_ = 5.77

		local var_1_0 = {
			zh = 5.2,
			ja = 5.766
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
				arg_1_0:Play416042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I14f"

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
				local var_4_5 = arg_1_1.bgs_.I14f

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
					if iter_4_0 ~= "I14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.05

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

			local var_4_30 = 0.466666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

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

			local var_4_36 = 0.8
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.35

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(416042001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 14
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042001", "story_v_out_416042.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_416042", "416042001", "story_v_out_416042.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_416042", "416042001", "story_v_out_416042.awb")

						arg_1_1:RecordAudio("416042001", var_4_50)
						arg_1_1:RecordAudio("416042001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416042", "416042001", "story_v_out_416042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416042", "416042001", "story_v_out_416042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

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
	Play416042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416042002
		arg_9_1.duration_ = 3.9

		local var_9_0 = {
			zh = 3.9,
			ja = 3.4
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
				arg_9_0:Play416042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.425

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[8].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(416042002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042002", "story_v_out_416042.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042002", "story_v_out_416042.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_416042", "416042002", "story_v_out_416042.awb")

						arg_9_1:RecordAudio("416042002", var_12_9)
						arg_9_1:RecordAudio("416042002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416042", "416042002", "story_v_out_416042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416042", "416042002", "story_v_out_416042.awb")
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
	Play416042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416042003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.633333333333333
			local var_16_1 = 1

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_2 = "play"
				local var_16_3 = "effect"

				arg_13_1:AudioAction(var_16_2, var_16_3, "se_story_15", "se_story_15_gun02", "")
			end

			local var_16_4 = 0
			local var_16_5 = 1.775

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(416042003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_8 = 71
				local var_16_9 = utf8.len(var_16_7)
				local var_16_10 = var_16_8 <= 0 and var_16_5 or var_16_5 * (var_16_9 / var_16_8)

				if var_16_10 > 0 and var_16_5 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_11 and arg_13_1.time_ < var_16_4 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416042004
		arg_17_1.duration_ = 4

		local var_17_0 = {
			zh = 4,
			ja = 3.6
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
				arg_17_0:Play416042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.225

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[8].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(416042004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 9
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042004", "story_v_out_416042.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042004", "story_v_out_416042.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_416042", "416042004", "story_v_out_416042.awb")

						arg_17_1:RecordAudio("416042004", var_20_9)
						arg_17_1:RecordAudio("416042004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416042", "416042004", "story_v_out_416042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416042", "416042004", "story_v_out_416042.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416042005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.75

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

				local var_24_2 = arg_21_1:GetWordFromCfg(416042005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 70
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
	Play416042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416042006
		arg_25_1.duration_ = 3.17

		local var_25_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_25_0:Play416042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1148"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["1148"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.125

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								local var_28_8 = Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, var_28_7)
								local var_28_9 = Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, var_28_7)
								local var_28_10 = Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, var_28_7)

								iter_28_3.color = Color.New(var_28_8, var_28_9, var_28_10)
							else
								local var_28_11 = Mathf.Lerp(iter_28_3.color.r, 1, var_28_7)

								iter_28_3.color = Color.New(var_28_11, var_28_11, var_28_11)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_5 then
						if arg_25_1.isInRecall_ then
							iter_28_5.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_12 = arg_25_1.actors_["1148"].transform
			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_12.localPosition
				var_28_12.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 3)

				local var_28_14 = var_28_12.childCount

				for iter_28_6 = 0, var_28_14 - 1 do
					local var_28_15 = var_28_12:GetChild(iter_28_6)

					if var_28_15.name == "split_6" or not string.find(var_28_15.name, "split") then
						var_28_15.gameObject:SetActive(true)
					else
						var_28_15.gameObject:SetActive(false)
					end
				end
			end

			local var_28_16 = 0.001

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_16 then
				local var_28_17 = (arg_25_1.time_ - var_28_13) / var_28_16
				local var_28_18 = Vector3.New(0, -429, -180)

				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, var_28_18, var_28_17)
			end

			if arg_25_1.time_ >= var_28_13 + var_28_16 and arg_25_1.time_ < var_28_13 + var_28_16 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, -429, -180)
			end

			local var_28_19 = 0
			local var_28_20 = 0.275

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_21 = arg_25_1:FormatText(StoryNameCfg[8].name)

				arg_25_1.leftNameTxt_.text = var_28_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_22 = arg_25_1:GetWordFromCfg(416042006)
				local var_28_23 = arg_25_1:FormatText(var_28_22.content)

				arg_25_1.text_.text = var_28_23

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_24 = 11
				local var_28_25 = utf8.len(var_28_23)
				local var_28_26 = var_28_24 <= 0 and var_28_20 or var_28_20 * (var_28_25 / var_28_24)

				if var_28_26 > 0 and var_28_20 < var_28_26 then
					arg_25_1.talkMaxDuration = var_28_26

					if var_28_26 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_26 + var_28_19
					end
				end

				arg_25_1.text_.text = var_28_23
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042006", "story_v_out_416042.awb") ~= 0 then
					local var_28_27 = manager.audio:GetVoiceLength("story_v_out_416042", "416042006", "story_v_out_416042.awb") / 1000

					if var_28_27 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_19
					end

					if var_28_22.prefab_name ~= "" and arg_25_1.actors_[var_28_22.prefab_name] ~= nil then
						local var_28_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_22.prefab_name].transform, "story_v_out_416042", "416042006", "story_v_out_416042.awb")

						arg_25_1:RecordAudio("416042006", var_28_28)
						arg_25_1:RecordAudio("416042006", var_28_28)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416042", "416042006", "story_v_out_416042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416042", "416042006", "story_v_out_416042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = math.max(var_28_20, arg_25_1.talkMaxDuration)

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_19) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_19 + var_28_29 and arg_25_1.time_ < var_28_19 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play416042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416042007
		arg_29_1.duration_ = 5.47

		local var_29_0 = {
			zh = 5.466,
			ja = 5.1
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
				arg_29_0:Play416042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1148"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.125

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.525

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[1084].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_11 = arg_29_1:GetWordFromCfg(416042007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 21
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_9 or var_32_9 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_9 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042007", "story_v_out_416042.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042007", "story_v_out_416042.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_416042", "416042007", "story_v_out_416042.awb")

						arg_29_1:RecordAudio("416042007", var_32_17)
						arg_29_1:RecordAudio("416042007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416042", "416042007", "story_v_out_416042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416042", "416042007", "story_v_out_416042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_18 and arg_29_1.time_ < var_32_8 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416042008
		arg_33_1.duration_ = 7.3

		local var_33_0 = {
			zh = 4.766,
			ja = 7.3
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
				arg_33_0:Play416042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1148"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.125

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.55

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_11 = arg_33_1:GetWordFromCfg(416042008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 22
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_9 or var_36_9 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_9 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042008", "story_v_out_416042.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042008", "story_v_out_416042.awb") / 1000

					if var_36_16 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_8
					end

					if var_36_11.prefab_name ~= "" and arg_33_1.actors_[var_36_11.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_11.prefab_name].transform, "story_v_out_416042", "416042008", "story_v_out_416042.awb")

						arg_33_1:RecordAudio("416042008", var_36_17)
						arg_33_1:RecordAudio("416042008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416042", "416042008", "story_v_out_416042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416042", "416042008", "story_v_out_416042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_18 and arg_33_1.time_ < var_36_8 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416042009
		arg_37_1.duration_ = 5.27

		local var_37_0 = {
			zh = 5.166,
			ja = 5.266
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
				arg_37_0:Play416042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.575

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[8].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(416042009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042009", "story_v_out_416042.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042009", "story_v_out_416042.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_416042", "416042009", "story_v_out_416042.awb")

						arg_37_1:RecordAudio("416042009", var_40_9)
						arg_37_1:RecordAudio("416042009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416042", "416042009", "story_v_out_416042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416042", "416042009", "story_v_out_416042.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play416042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416042010
		arg_41_1.duration_ = 4.27

		local var_41_0 = {
			zh = 4.233,
			ja = 4.266
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
				arg_41_0:Play416042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 == nil then
				arg_41_1.var_.actorSpriteComps1148 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.125

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1148 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.225

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[1084].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(416042010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 9
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042010", "story_v_out_416042.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042010", "story_v_out_416042.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_416042", "416042010", "story_v_out_416042.awb")

						arg_41_1:RecordAudio("416042010", var_44_17)
						arg_41_1:RecordAudio("416042010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416042", "416042010", "story_v_out_416042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416042", "416042010", "story_v_out_416042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416042011
		arg_45_1.duration_ = 5.7

		local var_45_0 = {
			zh = 4.2,
			ja = 5.7
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
				arg_45_0:Play416042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_1 = manager.ui.mainCamera.transform.localPosition
				local var_48_2 = Vector3.New(0, 0, 10) + Vector3.New(var_48_1.x, var_48_1.y, 0)
				local var_48_3 = arg_45_1.bgs_.I14f

				var_48_3.transform.localPosition = var_48_2
				var_48_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_4 = var_48_3:GetComponent("SpriteRenderer")

				if var_48_4 and var_48_4.sprite then
					local var_48_5 = (var_48_3.transform.localPosition - var_48_1).z
					local var_48_6 = manager.ui.mainCameraCom_
					local var_48_7 = 2 * var_48_5 * Mathf.Tan(var_48_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_8 = var_48_7 * var_48_6.aspect
					local var_48_9 = var_48_4.sprite.bounds.size.x
					local var_48_10 = var_48_4.sprite.bounds.size.y
					local var_48_11 = var_48_8 / var_48_9
					local var_48_12 = var_48_7 / var_48_10
					local var_48_13 = var_48_12 < var_48_11 and var_48_11 or var_48_12

					var_48_3.transform.localScale = Vector3.New(var_48_13, var_48_13, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I14f" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_15 = 1

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_15 then
				local var_48_16 = (arg_45_1.time_ - var_48_14) / var_48_15
				local var_48_17 = Color.New(0, 0, 0)

				var_48_17.a = Mathf.Lerp(0, 1, var_48_16)
				arg_45_1.mask_.color = var_48_17
			end

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 then
				local var_48_18 = Color.New(0, 0, 0)

				var_48_18.a = 1
				arg_45_1.mask_.color = var_48_18
			end

			local var_48_19 = 1

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_20 = 1

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_19) / var_48_20
				local var_48_22 = Color.New(0, 0, 0)

				var_48_22.a = Mathf.Lerp(1, 0, var_48_21)
				arg_45_1.mask_.color = var_48_22
			end

			if arg_45_1.time_ >= var_48_19 + var_48_20 and arg_45_1.time_ < var_48_19 + var_48_20 + arg_48_0 then
				local var_48_23 = Color.New(0, 0, 0)
				local var_48_24 = 0

				arg_45_1.mask_.enabled = false
				var_48_23.a = var_48_24
				arg_45_1.mask_.color = var_48_23
			end

			local var_48_25 = arg_45_1.actors_["1148"].transform
			local var_48_26 = 0.966666666666667

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = var_48_25.localPosition
				var_48_25.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 7)

				local var_48_27 = var_48_25.childCount

				for iter_48_2 = 0, var_48_27 - 1 do
					local var_48_28 = var_48_25:GetChild(iter_48_2)

					if var_48_28.name == "" or not string.find(var_48_28.name, "split") then
						var_48_28.gameObject:SetActive(true)
					else
						var_48_28.gameObject:SetActive(false)
					end
				end
			end

			local var_48_29 = 0.001

			if var_48_26 <= arg_45_1.time_ and arg_45_1.time_ < var_48_26 + var_48_29 then
				local var_48_30 = (arg_45_1.time_ - var_48_26) / var_48_29
				local var_48_31 = Vector3.New(0, -2000, 0)

				var_48_25.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, var_48_31, var_48_30)
			end

			if arg_45_1.time_ >= var_48_26 + var_48_29 and arg_45_1.time_ < var_48_26 + var_48_29 + arg_48_0 then
				var_48_25.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_32 = 2

			if var_48_32 < arg_45_1.time_ and arg_45_1.time_ <= var_48_32 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_33 = 0.1

			if arg_45_1.time_ >= var_48_32 + var_48_33 and arg_45_1.time_ < var_48_32 + var_48_33 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_34 = 2
			local var_48_35 = 0.175

			if var_48_34 < arg_45_1.time_ and arg_45_1.time_ <= var_48_34 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_36 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_36:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_37 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_38 = arg_45_1:GetWordFromCfg(416042011)
				local var_48_39 = arg_45_1:FormatText(var_48_38.content)

				arg_45_1.text_.text = var_48_39

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_40 = 7
				local var_48_41 = utf8.len(var_48_39)
				local var_48_42 = var_48_40 <= 0 and var_48_35 or var_48_35 * (var_48_41 / var_48_40)

				if var_48_42 > 0 and var_48_35 < var_48_42 then
					arg_45_1.talkMaxDuration = var_48_42
					var_48_34 = var_48_34 + 0.3

					if var_48_42 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_42 + var_48_34
					end
				end

				arg_45_1.text_.text = var_48_39
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042011", "story_v_out_416042.awb") ~= 0 then
					local var_48_43 = manager.audio:GetVoiceLength("story_v_out_416042", "416042011", "story_v_out_416042.awb") / 1000

					if var_48_43 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_43 + var_48_34
					end

					if var_48_38.prefab_name ~= "" and arg_45_1.actors_[var_48_38.prefab_name] ~= nil then
						local var_48_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_38.prefab_name].transform, "story_v_out_416042", "416042011", "story_v_out_416042.awb")

						arg_45_1:RecordAudio("416042011", var_48_44)
						arg_45_1:RecordAudio("416042011", var_48_44)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416042", "416042011", "story_v_out_416042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416042", "416042011", "story_v_out_416042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_45 = var_48_34 + 0.3
			local var_48_46 = math.max(var_48_35, arg_45_1.talkMaxDuration)

			if var_48_45 <= arg_45_1.time_ and arg_45_1.time_ < var_48_45 + var_48_46 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_45) / var_48_46

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_45 + var_48_46 and arg_45_1.time_ < var_48_45 + var_48_46 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play416042012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416042012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play416042013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1148"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1148 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1148", 7)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(0, -2000, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1148, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_7 = 0
			local var_54_8 = 1.875

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:GetWordFromCfg(416042012)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 75
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_8 or var_54_8 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_8 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_7
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_8, arg_51_1.talkMaxDuration)

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_7) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_7 + var_54_14 and arg_51_1.time_ < var_54_7 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play416042013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416042013
		arg_55_1.duration_ = 5.9

		local var_55_0 = {
			zh = 4.266,
			ja = 5.9
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
				arg_55_0:Play416042014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1148"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1148 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1148", 3)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "split_3" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(0, -429, -180)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1148, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_58_7 = arg_55_1.actors_["1148"]
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.actorSpriteComps1148 == nil then
				arg_55_1.var_.actorSpriteComps1148 = var_58_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 0.125

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 and not isNil(var_58_7) then
				local var_58_10 = (arg_55_1.time_ - var_58_8) / var_58_9

				if arg_55_1.var_.actorSpriteComps1148 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								local var_58_11 = Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, var_58_10)
								local var_58_12 = Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, var_58_10)
								local var_58_13 = Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, var_58_10)

								iter_58_2.color = Color.New(var_58_11, var_58_12, var_58_13)
							else
								local var_58_14 = Mathf.Lerp(iter_58_2.color.r, 1, var_58_10)

								iter_58_2.color = Color.New(var_58_14, var_58_14, var_58_14)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.actorSpriteComps1148 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_58_4 then
						if arg_55_1.isInRecall_ then
							iter_58_4.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1148 = nil
			end

			local var_58_15 = 0
			local var_58_16 = 0.525

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[8].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(416042013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 21
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042013", "story_v_out_416042.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042013", "story_v_out_416042.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_416042", "416042013", "story_v_out_416042.awb")

						arg_55_1:RecordAudio("416042013", var_58_24)
						arg_55_1:RecordAudio("416042013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_416042", "416042013", "story_v_out_416042.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_416042", "416042013", "story_v_out_416042.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play416042014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 416042014
		arg_59_1.duration_ = 4.03

		local var_59_0 = {
			zh = 3.1,
			ja = 4.033
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
				arg_59_0:Play416042015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1148"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1148 == nil then
				arg_59_1.var_.actorSpriteComps1148 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.125

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps1148 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 0.5, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1148 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1148 = nil
			end

			local var_62_8 = 0
			local var_62_9 = 0.325

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_10 = arg_59_1:FormatText(StoryNameCfg[1084].name)

				arg_59_1.leftNameTxt_.text = var_62_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_11 = arg_59_1:GetWordFromCfg(416042014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 13
				local var_62_14 = utf8.len(var_62_12)
				local var_62_15 = var_62_13 <= 0 and var_62_9 or var_62_9 * (var_62_14 / var_62_13)

				if var_62_15 > 0 and var_62_9 < var_62_15 then
					arg_59_1.talkMaxDuration = var_62_15

					if var_62_15 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042014", "story_v_out_416042.awb") ~= 0 then
					local var_62_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042014", "story_v_out_416042.awb") / 1000

					if var_62_16 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_16 + var_62_8
					end

					if var_62_11.prefab_name ~= "" and arg_59_1.actors_[var_62_11.prefab_name] ~= nil then
						local var_62_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_11.prefab_name].transform, "story_v_out_416042", "416042014", "story_v_out_416042.awb")

						arg_59_1:RecordAudio("416042014", var_62_17)
						arg_59_1:RecordAudio("416042014", var_62_17)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_416042", "416042014", "story_v_out_416042.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_416042", "416042014", "story_v_out_416042.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_18 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_18 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_18

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_18 and arg_59_1.time_ < var_62_8 + var_62_18 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play416042015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416042015
		arg_63_1.duration_ = 7.33

		local var_63_0 = {
			zh = 4.1,
			ja = 7.333
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
				arg_63_0:Play416042016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1148"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1148 == nil then
				arg_63_1.var_.actorSpriteComps1148 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.125

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps1148 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1148 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1148 = nil
			end

			local var_66_8 = arg_63_1.actors_["1148"].transform
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.var_.moveOldPos1148 = var_66_8.localPosition
				var_66_8.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1148", 3)

				local var_66_10 = var_66_8.childCount

				for iter_66_4 = 0, var_66_10 - 1 do
					local var_66_11 = var_66_8:GetChild(iter_66_4)

					if var_66_11.name == "split_6" or not string.find(var_66_11.name, "split") then
						var_66_11.gameObject:SetActive(true)
					else
						var_66_11.gameObject:SetActive(false)
					end
				end
			end

			local var_66_12 = 0.001

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_12 then
				local var_66_13 = (arg_63_1.time_ - var_66_9) / var_66_12
				local var_66_14 = Vector3.New(0, -429, -180)

				var_66_8.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1148, var_66_14, var_66_13)
			end

			if arg_63_1.time_ >= var_66_9 + var_66_12 and arg_63_1.time_ < var_66_9 + var_66_12 + arg_66_0 then
				var_66_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_66_15 = 0
			local var_66_16 = 0.525

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[8].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(416042015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 21
				local var_66_21 = utf8.len(var_66_19)
				local var_66_22 = var_66_20 <= 0 and var_66_16 or var_66_16 * (var_66_21 / var_66_20)

				if var_66_22 > 0 and var_66_16 < var_66_22 then
					arg_63_1.talkMaxDuration = var_66_22

					if var_66_22 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_22 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042015", "story_v_out_416042.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042015", "story_v_out_416042.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_out_416042", "416042015", "story_v_out_416042.awb")

						arg_63_1:RecordAudio("416042015", var_66_24)
						arg_63_1:RecordAudio("416042015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416042", "416042015", "story_v_out_416042.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416042", "416042015", "story_v_out_416042.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_25 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_25 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_25

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_25 and arg_63_1.time_ < var_66_15 + var_66_25 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play416042016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416042016
		arg_67_1.duration_ = 4

		local var_67_0 = {
			zh = 2.933,
			ja = 4
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
				arg_67_0:Play416042017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.325

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[8].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(416042016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 13
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042016", "story_v_out_416042.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042016", "story_v_out_416042.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_416042", "416042016", "story_v_out_416042.awb")

						arg_67_1:RecordAudio("416042016", var_70_9)
						arg_67_1:RecordAudio("416042016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416042", "416042016", "story_v_out_416042.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416042", "416042016", "story_v_out_416042.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416042017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416042017
		arg_71_1.duration_ = 6.77

		local var_71_0 = {
			zh = 3.7,
			ja = 6.766
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play416042018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.00066666666667

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				local var_74_1 = manager.ui.mainCamera.transform.localPosition
				local var_74_2 = Vector3.New(0, 0, 10) + Vector3.New(var_74_1.x, var_74_1.y, 0)
				local var_74_3 = arg_71_1.bgs_.I14f

				var_74_3.transform.localPosition = var_74_2
				var_74_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_4 = var_74_3:GetComponent("SpriteRenderer")

				if var_74_4 and var_74_4.sprite then
					local var_74_5 = (var_74_3.transform.localPosition - var_74_1).z
					local var_74_6 = manager.ui.mainCameraCom_
					local var_74_7 = 2 * var_74_5 * Mathf.Tan(var_74_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_8 = var_74_7 * var_74_6.aspect
					local var_74_9 = var_74_4.sprite.bounds.size.x
					local var_74_10 = var_74_4.sprite.bounds.size.y
					local var_74_11 = var_74_8 / var_74_9
					local var_74_12 = var_74_7 / var_74_10
					local var_74_13 = var_74_12 < var_74_11 and var_74_11 or var_74_12

					var_74_3.transform.localScale = Vector3.New(var_74_13, var_74_13, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "I14f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_15 = 1

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_15 then
				local var_74_16 = (arg_71_1.time_ - var_74_14) / var_74_15
				local var_74_17 = Color.New(0, 0, 0)

				var_74_17.a = Mathf.Lerp(0, 1, var_74_16)
				arg_71_1.mask_.color = var_74_17
			end

			if arg_71_1.time_ >= var_74_14 + var_74_15 and arg_71_1.time_ < var_74_14 + var_74_15 + arg_74_0 then
				local var_74_18 = Color.New(0, 0, 0)

				var_74_18.a = 1
				arg_71_1.mask_.color = var_74_18
			end

			local var_74_19 = 1.00066666666667

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_20 = 0.999333333333333

			if var_74_19 <= arg_71_1.time_ and arg_71_1.time_ < var_74_19 + var_74_20 then
				local var_74_21 = (arg_71_1.time_ - var_74_19) / var_74_20
				local var_74_22 = Color.New(0, 0, 0)

				var_74_22.a = Mathf.Lerp(1, 0, var_74_21)
				arg_71_1.mask_.color = var_74_22
			end

			if arg_71_1.time_ >= var_74_19 + var_74_20 and arg_71_1.time_ < var_74_19 + var_74_20 + arg_74_0 then
				local var_74_23 = Color.New(0, 0, 0)
				local var_74_24 = 0

				arg_71_1.mask_.enabled = false
				var_74_23.a = var_74_24
				arg_71_1.mask_.color = var_74_23
			end

			local var_74_25 = arg_71_1.actors_["1148"].transform
			local var_74_26 = 0.966666666666667

			if var_74_26 < arg_71_1.time_ and arg_71_1.time_ <= var_74_26 + arg_74_0 then
				arg_71_1.var_.moveOldPos1148 = var_74_25.localPosition
				var_74_25.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1148", 7)

				local var_74_27 = var_74_25.childCount

				for iter_74_2 = 0, var_74_27 - 1 do
					local var_74_28 = var_74_25:GetChild(iter_74_2)

					if var_74_28.name == "split_6" or not string.find(var_74_28.name, "split") then
						var_74_28.gameObject:SetActive(true)
					else
						var_74_28.gameObject:SetActive(false)
					end
				end
			end

			local var_74_29 = 0.001

			if var_74_26 <= arg_71_1.time_ and arg_71_1.time_ < var_74_26 + var_74_29 then
				local var_74_30 = (arg_71_1.time_ - var_74_26) / var_74_29
				local var_74_31 = Vector3.New(0, -2000, 0)

				var_74_25.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1148, var_74_31, var_74_30)
			end

			if arg_71_1.time_ >= var_74_26 + var_74_29 and arg_71_1.time_ < var_74_26 + var_74_29 + arg_74_0 then
				var_74_25.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_32 = 2

			if var_74_32 < arg_71_1.time_ and arg_71_1.time_ <= var_74_32 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_33 = 0.0333333333333332

			if arg_71_1.time_ >= var_74_32 + var_74_33 and arg_71_1.time_ < var_74_32 + var_74_33 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_34 = 2
			local var_74_35 = 0.075

			if var_74_34 < arg_71_1.time_ and arg_71_1.time_ <= var_74_34 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_36 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_36:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_37 = arg_71_1:FormatText(StoryNameCfg[8].name)

				arg_71_1.leftNameTxt_.text = var_74_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_38 = arg_71_1:GetWordFromCfg(416042017)
				local var_74_39 = arg_71_1:FormatText(var_74_38.content)

				arg_71_1.text_.text = var_74_39

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_40 = 3
				local var_74_41 = utf8.len(var_74_39)
				local var_74_42 = var_74_40 <= 0 and var_74_35 or var_74_35 * (var_74_41 / var_74_40)

				if var_74_42 > 0 and var_74_35 < var_74_42 then
					arg_71_1.talkMaxDuration = var_74_42
					var_74_34 = var_74_34 + 0.3

					if var_74_42 + var_74_34 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_42 + var_74_34
					end
				end

				arg_71_1.text_.text = var_74_39
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042017", "story_v_out_416042.awb") ~= 0 then
					local var_74_43 = manager.audio:GetVoiceLength("story_v_out_416042", "416042017", "story_v_out_416042.awb") / 1000

					if var_74_43 + var_74_34 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_43 + var_74_34
					end

					if var_74_38.prefab_name ~= "" and arg_71_1.actors_[var_74_38.prefab_name] ~= nil then
						local var_74_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_38.prefab_name].transform, "story_v_out_416042", "416042017", "story_v_out_416042.awb")

						arg_71_1:RecordAudio("416042017", var_74_44)
						arg_71_1:RecordAudio("416042017", var_74_44)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416042", "416042017", "story_v_out_416042.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416042", "416042017", "story_v_out_416042.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_45 = var_74_34 + 0.3
			local var_74_46 = math.max(var_74_35, arg_71_1.talkMaxDuration)

			if var_74_45 <= arg_71_1.time_ and arg_71_1.time_ < var_74_45 + var_74_46 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_45) / var_74_46

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_45 + var_74_46 and arg_71_1.time_ < var_74_45 + var_74_46 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416042018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416042018
		arg_77_1.duration_ = 3.63

		local var_77_0 = {
			zh = 3.1,
			ja = 3.633
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
				arg_77_0:Play416042019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.325

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1084].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(416042018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042018", "story_v_out_416042.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042018", "story_v_out_416042.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_416042", "416042018", "story_v_out_416042.awb")

						arg_77_1:RecordAudio("416042018", var_80_9)
						arg_77_1:RecordAudio("416042018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416042", "416042018", "story_v_out_416042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416042", "416042018", "story_v_out_416042.awb")
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
	Play416042019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416042019
		arg_81_1.duration_ = 4.27

		local var_81_0 = {
			zh = 3.566,
			ja = 4.266
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
				arg_81_0:Play416042020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1148"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1148", 3)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "split_5" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(0, -429, -180)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_84_7 = 0
			local var_84_8 = 0.325

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_9 = arg_81_1:FormatText(StoryNameCfg[8].name)

				arg_81_1.leftNameTxt_.text = var_84_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(416042019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_12 = 13
				local var_84_13 = utf8.len(var_84_11)
				local var_84_14 = var_84_12 <= 0 and var_84_8 or var_84_8 * (var_84_13 / var_84_12)

				if var_84_14 > 0 and var_84_8 < var_84_14 then
					arg_81_1.talkMaxDuration = var_84_14

					if var_84_14 + var_84_7 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_7
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042019", "story_v_out_416042.awb") ~= 0 then
					local var_84_15 = manager.audio:GetVoiceLength("story_v_out_416042", "416042019", "story_v_out_416042.awb") / 1000

					if var_84_15 + var_84_7 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_7
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_416042", "416042019", "story_v_out_416042.awb")

						arg_81_1:RecordAudio("416042019", var_84_16)
						arg_81_1:RecordAudio("416042019", var_84_16)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416042", "416042019", "story_v_out_416042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416042", "416042019", "story_v_out_416042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_17 = math.max(var_84_8, arg_81_1.talkMaxDuration)

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_17 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_7) / var_84_17

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_7 + var_84_17 and arg_81_1.time_ < var_84_7 + var_84_17 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play416042020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416042020
		arg_85_1.duration_ = 8.13

		local var_85_0 = {
			zh = 4.2,
			ja = 8.133
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
				arg_85_0:Play416042021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1148"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1148", 7)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_5" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -2000, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_7 = 0
			local var_88_8 = 0.425

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_9 = arg_85_1:FormatText(StoryNameCfg[8].name)

				arg_85_1.leftNameTxt_.text = var_88_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_10 = arg_85_1:GetWordFromCfg(416042020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_12 = 17
				local var_88_13 = utf8.len(var_88_11)
				local var_88_14 = var_88_12 <= 0 and var_88_8 or var_88_8 * (var_88_13 / var_88_12)

				if var_88_14 > 0 and var_88_8 < var_88_14 then
					arg_85_1.talkMaxDuration = var_88_14

					if var_88_14 + var_88_7 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_7
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042020", "story_v_out_416042.awb") ~= 0 then
					local var_88_15 = manager.audio:GetVoiceLength("story_v_out_416042", "416042020", "story_v_out_416042.awb") / 1000

					if var_88_15 + var_88_7 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_7
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_416042", "416042020", "story_v_out_416042.awb")

						arg_85_1:RecordAudio("416042020", var_88_16)
						arg_85_1:RecordAudio("416042020", var_88_16)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416042", "416042020", "story_v_out_416042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416042", "416042020", "story_v_out_416042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_17 = math.max(var_88_8, arg_85_1.talkMaxDuration)

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_17 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_7) / var_88_17

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_7 + var_88_17 and arg_85_1.time_ < var_88_7 + var_88_17 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play416042021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416042021
		arg_89_1.duration_ = 4.5

		local var_89_0 = {
			zh = 4.299999999997,
			ja = 4.5
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
				arg_89_0:Play416042022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				local var_92_1 = manager.ui.mainCamera.transform.localPosition
				local var_92_2 = Vector3.New(0, 0, 10) + Vector3.New(var_92_1.x, var_92_1.y, 0)
				local var_92_3 = arg_89_1.bgs_.I14f

				var_92_3.transform.localPosition = var_92_2
				var_92_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_4 = var_92_3:GetComponent("SpriteRenderer")

				if var_92_4 and var_92_4.sprite then
					local var_92_5 = (var_92_3.transform.localPosition - var_92_1).z
					local var_92_6 = manager.ui.mainCameraCom_
					local var_92_7 = 2 * var_92_5 * Mathf.Tan(var_92_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_8 = var_92_7 * var_92_6.aspect
					local var_92_9 = var_92_4.sprite.bounds.size.x
					local var_92_10 = var_92_4.sprite.bounds.size.y
					local var_92_11 = var_92_8 / var_92_9
					local var_92_12 = var_92_7 / var_92_10
					local var_92_13 = var_92_12 < var_92_11 and var_92_11 or var_92_12

					var_92_3.transform.localScale = Vector3.New(var_92_13, var_92_13, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "I14f" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_15 = 1

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_15 then
				local var_92_16 = (arg_89_1.time_ - var_92_14) / var_92_15
				local var_92_17 = Color.New(0, 0, 0)

				var_92_17.a = Mathf.Lerp(0, 1, var_92_16)
				arg_89_1.mask_.color = var_92_17
			end

			if arg_89_1.time_ >= var_92_14 + var_92_15 and arg_89_1.time_ < var_92_14 + var_92_15 + arg_92_0 then
				local var_92_18 = Color.New(0, 0, 0)

				var_92_18.a = 1
				arg_89_1.mask_.color = var_92_18
			end

			local var_92_19 = 1

			if var_92_19 < arg_89_1.time_ and arg_89_1.time_ <= var_92_19 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_20 = 1

			if var_92_19 <= arg_89_1.time_ and arg_89_1.time_ < var_92_19 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_19) / var_92_20
				local var_92_22 = Color.New(0, 0, 0)

				var_92_22.a = Mathf.Lerp(1, 0, var_92_21)
				arg_89_1.mask_.color = var_92_22
			end

			if arg_89_1.time_ >= var_92_19 + var_92_20 and arg_89_1.time_ < var_92_19 + var_92_20 + arg_92_0 then
				local var_92_23 = Color.New(0, 0, 0)
				local var_92_24 = 0

				arg_89_1.mask_.enabled = false
				var_92_23.a = var_92_24
				arg_89_1.mask_.color = var_92_23
			end

			local var_92_25 = 2

			if var_92_25 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_26 = 0.0333333333333332

			if arg_89_1.time_ >= var_92_25 + var_92_26 and arg_89_1.time_ < var_92_25 + var_92_26 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_27 = 2
			local var_92_28 = 0.0666666666666669

			if var_92_27 < arg_89_1.time_ and arg_89_1.time_ <= var_92_27 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_29 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_29:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_30 = arg_89_1:FormatText(StoryNameCfg[8].name)

				arg_89_1.leftNameTxt_.text = var_92_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_31 = arg_89_1:GetWordFromCfg(416042021)
				local var_92_32 = arg_89_1:FormatText(var_92_31.content)

				arg_89_1.text_.text = var_92_32

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_33 = 2
				local var_92_34 = utf8.len(var_92_32)
				local var_92_35 = var_92_33 <= 0 and var_92_28 or var_92_28 * (var_92_34 / var_92_33)

				if var_92_35 > 0 and var_92_28 < var_92_35 then
					arg_89_1.talkMaxDuration = var_92_35
					var_92_27 = var_92_27 + 0.3

					if var_92_35 + var_92_27 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_35 + var_92_27
					end
				end

				arg_89_1.text_.text = var_92_32
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042021", "story_v_out_416042.awb") ~= 0 then
					local var_92_36 = manager.audio:GetVoiceLength("story_v_out_416042", "416042021", "story_v_out_416042.awb") / 1000

					if var_92_36 + var_92_27 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_36 + var_92_27
					end

					if var_92_31.prefab_name ~= "" and arg_89_1.actors_[var_92_31.prefab_name] ~= nil then
						local var_92_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_31.prefab_name].transform, "story_v_out_416042", "416042021", "story_v_out_416042.awb")

						arg_89_1:RecordAudio("416042021", var_92_37)
						arg_89_1:RecordAudio("416042021", var_92_37)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416042", "416042021", "story_v_out_416042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416042", "416042021", "story_v_out_416042.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_38 = var_92_27 + 0.3
			local var_92_39 = math.max(var_92_28, arg_89_1.talkMaxDuration)

			if var_92_38 <= arg_89_1.time_ and arg_89_1.time_ < var_92_38 + var_92_39 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_38) / var_92_39

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_38 + var_92_39 and arg_89_1.time_ < var_92_38 + var_92_39 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416042022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416042022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play416042023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1148"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1148 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1148", 7)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(0, -2000, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1148, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_7 = 0
			local var_98_8 = 1.75

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(416042022)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 70
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_8 or var_98_8 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_8 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_7
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_8, arg_95_1.talkMaxDuration)

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_7) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_7 + var_98_14 and arg_95_1.time_ < var_98_7 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play416042023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416042023
		arg_99_1.duration_ = 6.33

		local var_99_0 = {
			zh = 4.5,
			ja = 6.333
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
				arg_99_0:Play416042024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.475

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1084].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(416042023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 19
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042023", "story_v_out_416042.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042023", "story_v_out_416042.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_416042", "416042023", "story_v_out_416042.awb")

						arg_99_1:RecordAudio("416042023", var_102_9)
						arg_99_1:RecordAudio("416042023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_416042", "416042023", "story_v_out_416042.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_416042", "416042023", "story_v_out_416042.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play416042024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416042024
		arg_103_1.duration_ = 5.5

		local var_103_0 = {
			zh = 4.633,
			ja = 5.5
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
				arg_103_0:Play416042025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1148"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1148 == nil then
				arg_103_1.var_.actorSpriteComps1148 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.125

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps1148 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 1, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1148 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1148 = nil
			end

			local var_106_8 = arg_103_1.actors_["1148"].transform
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.var_.moveOldPos1148 = var_106_8.localPosition
				var_106_8.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1148", 3)

				local var_106_10 = var_106_8.childCount

				for iter_106_4 = 0, var_106_10 - 1 do
					local var_106_11 = var_106_8:GetChild(iter_106_4)

					if var_106_11.name == "split_6" or not string.find(var_106_11.name, "split") then
						var_106_11.gameObject:SetActive(true)
					else
						var_106_11.gameObject:SetActive(false)
					end
				end
			end

			local var_106_12 = 0.001

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_9) / var_106_12
				local var_106_14 = Vector3.New(0, -429, -180)

				var_106_8.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1148, var_106_14, var_106_13)
			end

			if arg_103_1.time_ >= var_106_9 + var_106_12 and arg_103_1.time_ < var_106_9 + var_106_12 + arg_106_0 then
				var_106_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_106_15 = 0
			local var_106_16 = 0.475

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[8].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(416042024)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 19
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042024", "story_v_out_416042.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042024", "story_v_out_416042.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_416042", "416042024", "story_v_out_416042.awb")

						arg_103_1:RecordAudio("416042024", var_106_24)
						arg_103_1:RecordAudio("416042024", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416042", "416042024", "story_v_out_416042.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416042", "416042024", "story_v_out_416042.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play416042025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416042025
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			zh = 2.7,
			ja = 4.766
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
				arg_107_0:Play416042026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1148"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1148 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1148", 3)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_6" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(0, -429, -180)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1148, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_110_7 = 0
			local var_110_8 = 0.35

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_9 = arg_107_1:FormatText(StoryNameCfg[8].name)

				arg_107_1.leftNameTxt_.text = var_110_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(416042025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 14
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_8 or var_110_8 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_8 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042025", "story_v_out_416042.awb") ~= 0 then
					local var_110_15 = manager.audio:GetVoiceLength("story_v_out_416042", "416042025", "story_v_out_416042.awb") / 1000

					if var_110_15 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_15 + var_110_7
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_416042", "416042025", "story_v_out_416042.awb")

						arg_107_1:RecordAudio("416042025", var_110_16)
						arg_107_1:RecordAudio("416042025", var_110_16)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416042", "416042025", "story_v_out_416042.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416042", "416042025", "story_v_out_416042.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_17 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_17 and arg_107_1.time_ < var_110_7 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play416042026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416042026
		arg_111_1.duration_ = 2.4

		local var_111_0 = {
			zh = 2.4,
			ja = 2.266
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
				arg_111_0:Play416042027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_1 = 0.175

			if arg_111_1.time_ >= var_114_0 + var_114_1 and arg_111_1.time_ < var_114_0 + var_114_1 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_2 = 0
			local var_114_3 = 0.175

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_4 = arg_111_1:FormatText(StoryNameCfg[8].name)

				arg_111_1.leftNameTxt_.text = var_114_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(416042026)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 7
				local var_114_8 = utf8.len(var_114_6)
				local var_114_9 = var_114_7 <= 0 and var_114_3 or var_114_3 * (var_114_8 / var_114_7)

				if var_114_9 > 0 and var_114_3 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042026", "story_v_out_416042.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_416042", "416042026", "story_v_out_416042.awb") / 1000

					if var_114_10 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_2
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_416042", "416042026", "story_v_out_416042.awb")

						arg_111_1:RecordAudio("416042026", var_114_11)
						arg_111_1:RecordAudio("416042026", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416042", "416042026", "story_v_out_416042.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416042", "416042026", "story_v_out_416042.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_12 and arg_111_1.time_ < var_114_2 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416042027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416042027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416042028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1148"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 7)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(0, -2000, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			local var_118_8 = 0.5

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_9 = 0
			local var_118_10 = 1.9

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_11 = arg_115_1:GetWordFromCfg(416042027)
				local var_118_12 = arg_115_1:FormatText(var_118_11.content)

				arg_115_1.text_.text = var_118_12

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 76
				local var_118_14 = utf8.len(var_118_12)
				local var_118_15 = var_118_13 <= 0 and var_118_10 or var_118_10 * (var_118_14 / var_118_13)

				if var_118_15 > 0 and var_118_10 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_9
					end
				end

				arg_115_1.text_.text = var_118_12
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_10, arg_115_1.talkMaxDuration)

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_9) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_9 + var_118_16 and arg_115_1.time_ < var_118_9 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416042028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416042028
		arg_119_1.duration_ = 6.73

		local var_119_0 = {
			zh = 3.133,
			ja = 6.733
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
				arg_119_0:Play416042029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1148"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1148 == nil then
				arg_119_1.var_.actorSpriteComps1148 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.125

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps1148 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1148 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1148 = nil
			end

			local var_122_8 = arg_119_1.actors_["1148"].transform
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.var_.moveOldPos1148 = var_122_8.localPosition
				var_122_8.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1148", 3)

				local var_122_10 = var_122_8.childCount

				for iter_122_4 = 0, var_122_10 - 1 do
					local var_122_11 = var_122_8:GetChild(iter_122_4)

					if var_122_11.name == "split_6" or not string.find(var_122_11.name, "split") then
						var_122_11.gameObject:SetActive(true)
					else
						var_122_11.gameObject:SetActive(false)
					end
				end
			end

			local var_122_12 = 0.001

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_12 then
				local var_122_13 = (arg_119_1.time_ - var_122_9) / var_122_12
				local var_122_14 = Vector3.New(0, -429, -180)

				var_122_8.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1148, var_122_14, var_122_13)
			end

			if arg_119_1.time_ >= var_122_9 + var_122_12 and arg_119_1.time_ < var_122_9 + var_122_12 + arg_122_0 then
				var_122_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_122_15 = 0
			local var_122_16 = 0.3

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[8].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(416042028)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042028", "story_v_out_416042.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042028", "story_v_out_416042.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_416042", "416042028", "story_v_out_416042.awb")

						arg_119_1:RecordAudio("416042028", var_122_24)
						arg_119_1:RecordAudio("416042028", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416042", "416042028", "story_v_out_416042.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416042", "416042028", "story_v_out_416042.awb")
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

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416042029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416042029
		arg_123_1.duration_ = 6.43

		local var_123_0 = {
			zh = 6.266,
			ja = 6.433
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
				arg_123_0:Play416042030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1148"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1148 == nil then
				arg_123_1.var_.actorSpriteComps1148 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.125

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps1148 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1148 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1148 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.45

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_10 = arg_123_1:FormatText(StoryNameCfg[1084].name)

				arg_123_1.leftNameTxt_.text = var_126_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_11 = arg_123_1:GetWordFromCfg(416042029)
				local var_126_12 = arg_123_1:FormatText(var_126_11.content)

				arg_123_1.text_.text = var_126_12

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 18
				local var_126_14 = utf8.len(var_126_12)
				local var_126_15 = var_126_13 <= 0 and var_126_9 or var_126_9 * (var_126_14 / var_126_13)

				if var_126_15 > 0 and var_126_9 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_12
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042029", "story_v_out_416042.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042029", "story_v_out_416042.awb") / 1000

					if var_126_16 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_8
					end

					if var_126_11.prefab_name ~= "" and arg_123_1.actors_[var_126_11.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_11.prefab_name].transform, "story_v_out_416042", "416042029", "story_v_out_416042.awb")

						arg_123_1:RecordAudio("416042029", var_126_17)
						arg_123_1:RecordAudio("416042029", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416042", "416042029", "story_v_out_416042.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416042", "416042029", "story_v_out_416042.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_18 and arg_123_1.time_ < var_126_8 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play416042030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416042030
		arg_127_1.duration_ = 5.07

		local var_127_0 = {
			zh = 4.7,
			ja = 5.066
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
				arg_127_0:Play416042031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1148"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1148 == nil then
				arg_127_1.var_.actorSpriteComps1148 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.125

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps1148 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1148 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1148 = nil
			end

			local var_130_8 = 0
			local var_130_9 = 0.6

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_10 = arg_127_1:FormatText(StoryNameCfg[8].name)

				arg_127_1.leftNameTxt_.text = var_130_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_11 = arg_127_1:GetWordFromCfg(416042030)
				local var_130_12 = arg_127_1:FormatText(var_130_11.content)

				arg_127_1.text_.text = var_130_12

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 24
				local var_130_14 = utf8.len(var_130_12)
				local var_130_15 = var_130_13 <= 0 and var_130_9 or var_130_9 * (var_130_14 / var_130_13)

				if var_130_15 > 0 and var_130_9 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_12
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042030", "story_v_out_416042.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042030", "story_v_out_416042.awb") / 1000

					if var_130_16 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_8
					end

					if var_130_11.prefab_name ~= "" and arg_127_1.actors_[var_130_11.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_11.prefab_name].transform, "story_v_out_416042", "416042030", "story_v_out_416042.awb")

						arg_127_1:RecordAudio("416042030", var_130_17)
						arg_127_1:RecordAudio("416042030", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416042", "416042030", "story_v_out_416042.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416042", "416042030", "story_v_out_416042.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_18 and arg_127_1.time_ < var_130_8 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416042031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416042031
		arg_131_1.duration_ = 3.02

		local var_131_0 = {
			zh = 2.415999999999,
			ja = 3.015999999999
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
				arg_131_0:Play416042032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1148"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1148 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1148", 3)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "split_3" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(0, -429, -180)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1148, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_134_7 = manager.ui.mainCamera.transform
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.var_.shakeOldPos = var_134_7.localPosition
			end

			local var_134_9 = 0.433333333333333

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / 0.066
				local var_134_11, var_134_12 = math.modf(var_134_10)

				var_134_7.localPosition = Vector3.New(var_134_12 * 0.13, var_134_12 * 0.13, var_134_12 * 0.13) + arg_131_1.var_.shakeOldPos
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 then
				var_134_7.localPosition = arg_131_1.var_.shakeOldPos
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1.allBtn_.enabled = false
			end

			local var_134_14 = 0.849999999999

			if arg_131_1.time_ >= var_134_13 + var_134_14 and arg_131_1.time_ < var_134_13 + var_134_14 + arg_134_0 then
				arg_131_1.allBtn_.enabled = true
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_15 = 0.849999999999
			local var_134_16 = 0.15

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_17 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_17:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_18 = arg_131_1:FormatText(StoryNameCfg[8].name)

				arg_131_1.leftNameTxt_.text = var_134_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_19 = arg_131_1:GetWordFromCfg(416042031)
				local var_134_20 = arg_131_1:FormatText(var_134_19.content)

				arg_131_1.text_.text = var_134_20

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_21 = 6
				local var_134_22 = utf8.len(var_134_20)
				local var_134_23 = var_134_21 <= 0 and var_134_16 or var_134_16 * (var_134_22 / var_134_21)

				if var_134_23 > 0 and var_134_16 < var_134_23 then
					arg_131_1.talkMaxDuration = var_134_23
					var_134_15 = var_134_15 + 0.3

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_20
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042031", "story_v_out_416042.awb") ~= 0 then
					local var_134_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042031", "story_v_out_416042.awb") / 1000

					if var_134_24 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_15
					end

					if var_134_19.prefab_name ~= "" and arg_131_1.actors_[var_134_19.prefab_name] ~= nil then
						local var_134_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_19.prefab_name].transform, "story_v_out_416042", "416042031", "story_v_out_416042.awb")

						arg_131_1:RecordAudio("416042031", var_134_25)
						arg_131_1:RecordAudio("416042031", var_134_25)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416042", "416042031", "story_v_out_416042.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416042", "416042031", "story_v_out_416042.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_26 = var_134_15 + 0.3
			local var_134_27 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_26 <= arg_131_1.time_ and arg_131_1.time_ < var_134_26 + var_134_27 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_26) / var_134_27

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_26 + var_134_27 and arg_131_1.time_ < var_134_26 + var_134_27 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play416042032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416042032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416042033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1148"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 7)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_2" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -2000, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_7 = 0
			local var_140_8 = 1.2

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(416042032)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 48
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_8 or var_140_8 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_8 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_7 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_7
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_8, arg_137_1.talkMaxDuration)

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_7) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_7 + var_140_14 and arg_137_1.time_ < var_140_7 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play416042033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416042033
		arg_141_1.duration_ = 6.9

		local var_141_0 = {
			zh = 5.4,
			ja = 6.9
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416042034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1148"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1148", 3)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "split_6" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -429, -180)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_144_7 = arg_141_1.actors_["1148"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1148 == nil then
				arg_141_1.var_.actorSpriteComps1148 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.125

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps1148 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 1, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1148 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1148 = nil
			end

			local var_144_15 = 0
			local var_144_16 = 0.475

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[8].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(416042033)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 19
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042033", "story_v_out_416042.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042033", "story_v_out_416042.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_416042", "416042033", "story_v_out_416042.awb")

						arg_141_1:RecordAudio("416042033", var_144_24)
						arg_141_1:RecordAudio("416042033", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416042", "416042033", "story_v_out_416042.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416042", "416042033", "story_v_out_416042.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play416042034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416042034
		arg_145_1.duration_ = 5.03

		local var_145_0 = {
			zh = 5.033,
			ja = 4.666
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
				arg_145_0:Play416042035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.375

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[8].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(416042034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042034", "story_v_out_416042.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042034", "story_v_out_416042.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_416042", "416042034", "story_v_out_416042.awb")

						arg_145_1:RecordAudio("416042034", var_148_9)
						arg_145_1:RecordAudio("416042034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416042", "416042034", "story_v_out_416042.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416042", "416042034", "story_v_out_416042.awb")
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
	Play416042035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416042035
		arg_149_1.duration_ = 6.97

		local var_149_0 = {
			zh = 6.366,
			ja = 6.966
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
				arg_149_0:Play416042036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1148"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1148 == nil then
				arg_149_1.var_.actorSpriteComps1148 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.125

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1148 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1148 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1148 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.675

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[1084].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_11 = arg_149_1:GetWordFromCfg(416042035)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 27
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042035", "story_v_out_416042.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042035", "story_v_out_416042.awb") / 1000

					if var_152_16 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_8
					end

					if var_152_11.prefab_name ~= "" and arg_149_1.actors_[var_152_11.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_11.prefab_name].transform, "story_v_out_416042", "416042035", "story_v_out_416042.awb")

						arg_149_1:RecordAudio("416042035", var_152_17)
						arg_149_1:RecordAudio("416042035", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416042", "416042035", "story_v_out_416042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416042", "416042035", "story_v_out_416042.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_18 and arg_149_1.time_ < var_152_8 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416042036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416042036
		arg_153_1.duration_ = 6.7

		local var_153_0 = {
			zh = 6.033,
			ja = 6.7
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
				arg_153_0:Play416042037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1148"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1148 == nil then
				arg_153_1.var_.actorSpriteComps1148 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.125

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1148 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1148 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1148 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.5

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[8].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_11 = arg_153_1:GetWordFromCfg(416042036)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 20
				local var_156_14 = utf8.len(var_156_12)
				local var_156_15 = var_156_13 <= 0 and var_156_9 or var_156_9 * (var_156_14 / var_156_13)

				if var_156_15 > 0 and var_156_9 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042036", "story_v_out_416042.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042036", "story_v_out_416042.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_416042", "416042036", "story_v_out_416042.awb")

						arg_153_1:RecordAudio("416042036", var_156_17)
						arg_153_1:RecordAudio("416042036", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416042", "416042036", "story_v_out_416042.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416042", "416042036", "story_v_out_416042.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_18 and arg_153_1.time_ < var_156_8 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416042037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416042037
		arg_157_1.duration_ = 8.4

		local var_157_0 = {
			zh = 5.933,
			ja = 8.4
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
				arg_157_0:Play416042038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.6

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[8].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(416042037)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 24
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042037", "story_v_out_416042.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042037", "story_v_out_416042.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_416042", "416042037", "story_v_out_416042.awb")

						arg_157_1:RecordAudio("416042037", var_160_9)
						arg_157_1:RecordAudio("416042037", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416042", "416042037", "story_v_out_416042.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416042", "416042037", "story_v_out_416042.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416042038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416042038
		arg_161_1.duration_ = 5.1

		local var_161_0 = {
			zh = 4.9,
			ja = 5.1
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
				arg_161_0:Play416042039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1148"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1148 == nil then
				arg_161_1.var_.actorSpriteComps1148 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.125

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1148 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 0.5, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1148 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1148 = nil
			end

			local var_164_8 = 0
			local var_164_9 = 0.45

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_10 = arg_161_1:FormatText(StoryNameCfg[1084].name)

				arg_161_1.leftNameTxt_.text = var_164_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_11 = arg_161_1:GetWordFromCfg(416042038)
				local var_164_12 = arg_161_1:FormatText(var_164_11.content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 18
				local var_164_14 = utf8.len(var_164_12)
				local var_164_15 = var_164_13 <= 0 and var_164_9 or var_164_9 * (var_164_14 / var_164_13)

				if var_164_15 > 0 and var_164_9 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042038", "story_v_out_416042.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042038", "story_v_out_416042.awb") / 1000

					if var_164_16 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_8
					end

					if var_164_11.prefab_name ~= "" and arg_161_1.actors_[var_164_11.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_11.prefab_name].transform, "story_v_out_416042", "416042038", "story_v_out_416042.awb")

						arg_161_1:RecordAudio("416042038", var_164_17)
						arg_161_1:RecordAudio("416042038", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416042", "416042038", "story_v_out_416042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416042", "416042038", "story_v_out_416042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_18 and arg_161_1.time_ < var_164_8 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play416042039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416042039
		arg_165_1.duration_ = 5.57

		local var_165_0 = {
			zh = 3.466,
			ja = 5.566
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
				arg_165_0:Play416042040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1148"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.125

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.375

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_10 = arg_165_1:FormatText(StoryNameCfg[8].name)

				arg_165_1.leftNameTxt_.text = var_168_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:GetWordFromCfg(416042039)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 15
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_9 or var_168_9 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_9 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042039", "story_v_out_416042.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042039", "story_v_out_416042.awb") / 1000

					if var_168_16 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_8
					end

					if var_168_11.prefab_name ~= "" and arg_165_1.actors_[var_168_11.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_11.prefab_name].transform, "story_v_out_416042", "416042039", "story_v_out_416042.awb")

						arg_165_1:RecordAudio("416042039", var_168_17)
						arg_165_1:RecordAudio("416042039", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416042", "416042039", "story_v_out_416042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416042", "416042039", "story_v_out_416042.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_18 and arg_165_1.time_ < var_168_8 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416042040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416042040
		arg_169_1.duration_ = 5.23

		local var_169_0 = {
			zh = 5.233,
			ja = 4.733
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
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play416042041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1148"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1148 == nil then
				arg_169_1.var_.actorSpriteComps1148 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.125

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps1148 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 0.5, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1148 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.575

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[1084].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_11 = arg_169_1:GetWordFromCfg(416042040)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 23
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_9 or var_172_9 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_9 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042040", "story_v_out_416042.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042040", "story_v_out_416042.awb") / 1000

					if var_172_16 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_8
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_416042", "416042040", "story_v_out_416042.awb")

						arg_169_1:RecordAudio("416042040", var_172_17)
						arg_169_1:RecordAudio("416042040", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416042", "416042040", "story_v_out_416042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416042", "416042040", "story_v_out_416042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_18 and arg_169_1.time_ < var_172_8 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416042041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416042041
		arg_173_1.duration_ = 7.13

		local var_173_0 = {
			zh = 5.133,
			ja = 7.133
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416042042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1148"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1148 == nil then
				arg_173_1.var_.actorSpriteComps1148 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.125

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1148 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1148 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1148 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.45

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_10 = arg_173_1:FormatText(StoryNameCfg[8].name)

				arg_173_1.leftNameTxt_.text = var_176_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:GetWordFromCfg(416042041)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 18
				local var_176_14 = utf8.len(var_176_12)
				local var_176_15 = var_176_13 <= 0 and var_176_9 or var_176_9 * (var_176_14 / var_176_13)

				if var_176_15 > 0 and var_176_9 < var_176_15 then
					arg_173_1.talkMaxDuration = var_176_15

					if var_176_15 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042041", "story_v_out_416042.awb") ~= 0 then
					local var_176_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042041", "story_v_out_416042.awb") / 1000

					if var_176_16 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_16 + var_176_8
					end

					if var_176_11.prefab_name ~= "" and arg_173_1.actors_[var_176_11.prefab_name] ~= nil then
						local var_176_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_11.prefab_name].transform, "story_v_out_416042", "416042041", "story_v_out_416042.awb")

						arg_173_1:RecordAudio("416042041", var_176_17)
						arg_173_1:RecordAudio("416042041", var_176_17)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416042", "416042041", "story_v_out_416042.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416042", "416042041", "story_v_out_416042.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_18 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_18 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_18

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_18 and arg_173_1.time_ < var_176_8 + var_176_18 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416042042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416042042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416042043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1148"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1148 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1148", 7)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(0, -2000, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1148, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_7 = 0
			local var_180_8 = 1

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(416042042)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 40
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_8 or var_180_8 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_8 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_14 and arg_177_1.time_ < var_180_7 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play416042043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416042043
		arg_181_1.duration_ = 4.93

		local var_181_0 = {
			zh = 4.933,
			ja = 4.733
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play416042044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1148"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1148 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1148", 3)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "split_4" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(0, -429, -180)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1148, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_184_7 = arg_181_1.actors_["1148"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps1148 == nil then
				arg_181_1.var_.actorSpriteComps1148 = var_184_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.125

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.actorSpriteComps1148 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								local var_184_11 = Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, var_184_10)
								local var_184_12 = Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, var_184_10)
								local var_184_13 = Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, var_184_10)

								iter_184_2.color = Color.New(var_184_11, var_184_12, var_184_13)
							else
								local var_184_14 = Mathf.Lerp(iter_184_2.color.r, 1, var_184_10)

								iter_184_2.color = Color.New(var_184_14, var_184_14, var_184_14)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps1148 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_184_4 then
						if arg_181_1.isInRecall_ then
							iter_184_4.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1148 = nil
			end

			local var_184_15 = 2.6
			local var_184_16 = 0.4

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				local var_184_17 = "play"
				local var_184_18 = "effect"

				arg_181_1:AudioAction(var_184_17, var_184_18, "se_story_138", "se_story_138_sizzle", "")
			end

			local var_184_19 = 0
			local var_184_20 = 0.5

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_21 = arg_181_1:FormatText(StoryNameCfg[8].name)

				arg_181_1.leftNameTxt_.text = var_184_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_22 = arg_181_1:GetWordFromCfg(416042043)
				local var_184_23 = arg_181_1:FormatText(var_184_22.content)

				arg_181_1.text_.text = var_184_23

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_24 = 20
				local var_184_25 = utf8.len(var_184_23)
				local var_184_26 = var_184_24 <= 0 and var_184_20 or var_184_20 * (var_184_25 / var_184_24)

				if var_184_26 > 0 and var_184_20 < var_184_26 then
					arg_181_1.talkMaxDuration = var_184_26

					if var_184_26 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_26 + var_184_19
					end
				end

				arg_181_1.text_.text = var_184_23
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042043", "story_v_out_416042.awb") ~= 0 then
					local var_184_27 = manager.audio:GetVoiceLength("story_v_out_416042", "416042043", "story_v_out_416042.awb") / 1000

					if var_184_27 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_27 + var_184_19
					end

					if var_184_22.prefab_name ~= "" and arg_181_1.actors_[var_184_22.prefab_name] ~= nil then
						local var_184_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_22.prefab_name].transform, "story_v_out_416042", "416042043", "story_v_out_416042.awb")

						arg_181_1:RecordAudio("416042043", var_184_28)
						arg_181_1:RecordAudio("416042043", var_184_28)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416042", "416042043", "story_v_out_416042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416042", "416042043", "story_v_out_416042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_29 = math.max(var_184_20, arg_181_1.talkMaxDuration)

			if var_184_19 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_29 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_19) / var_184_29

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_19 + var_184_29 and arg_181_1.time_ < var_184_19 + var_184_29 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play416042044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416042044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416042045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1148"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1148 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1148", 7)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_6" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(0, -2000, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1148, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_188_7 = 0
			local var_188_8 = 1.925

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(416042044)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 77
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_8 or var_188_8 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_8 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_7
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_8, arg_185_1.talkMaxDuration)

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_7) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_7 + var_188_14 and arg_185_1.time_ < var_188_7 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play416042045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416042045
		arg_189_1.duration_ = 4.53

		local var_189_0 = {
			zh = 2.8,
			ja = 4.533
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416042046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1148"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1148 == nil then
				arg_189_1.var_.actorSpriteComps1148 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.125

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps1148 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 1, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1148 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1148 = nil
			end

			local var_192_8 = arg_189_1.actors_["1148"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148 = var_192_8.localPosition
				var_192_8.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1148", 3)

				local var_192_10 = var_192_8.childCount

				for iter_192_4 = 0, var_192_10 - 1 do
					local var_192_11 = var_192_8:GetChild(iter_192_4)

					if var_192_11.name == "split_6" or not string.find(var_192_11.name, "split") then
						var_192_11.gameObject:SetActive(true)
					else
						var_192_11.gameObject:SetActive(false)
					end
				end
			end

			local var_192_12 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_12 then
				local var_192_13 = (arg_189_1.time_ - var_192_9) / var_192_12
				local var_192_14 = Vector3.New(0, -429, -180)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148, var_192_14, var_192_13)
			end

			if arg_189_1.time_ >= var_192_9 + var_192_12 and arg_189_1.time_ < var_192_9 + var_192_12 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_192_15 = 0
			local var_192_16 = 0.2

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[8].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(416042045)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 8
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042045", "story_v_out_416042.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042045", "story_v_out_416042.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_416042", "416042045", "story_v_out_416042.awb")

						arg_189_1:RecordAudio("416042045", var_192_24)
						arg_189_1:RecordAudio("416042045", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416042", "416042045", "story_v_out_416042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416042", "416042045", "story_v_out_416042.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play416042046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416042046
		arg_193_1.duration_ = 8.57

		local var_193_0 = {
			zh = 7.033,
			ja = 8.566
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416042047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.625

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[8].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(416042046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 25
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042046", "story_v_out_416042.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042046", "story_v_out_416042.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_416042", "416042046", "story_v_out_416042.awb")

						arg_193_1:RecordAudio("416042046", var_196_9)
						arg_193_1:RecordAudio("416042046", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416042", "416042046", "story_v_out_416042.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416042", "416042046", "story_v_out_416042.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416042047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416042047
		arg_197_1.duration_ = 4.17

		local var_197_0 = {
			zh = 4.166,
			ja = 3.666
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
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play416042048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1148"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1148 == nil then
				arg_197_1.var_.actorSpriteComps1148 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.125

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps1148 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 0.5, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1148 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1148 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.225

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_10 = arg_197_1:FormatText(StoryNameCfg[1084].name)

				arg_197_1.leftNameTxt_.text = var_200_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_11 = arg_197_1:GetWordFromCfg(416042047)
				local var_200_12 = arg_197_1:FormatText(var_200_11.content)

				arg_197_1.text_.text = var_200_12

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 9
				local var_200_14 = utf8.len(var_200_12)
				local var_200_15 = var_200_13 <= 0 and var_200_9 or var_200_9 * (var_200_14 / var_200_13)

				if var_200_15 > 0 and var_200_9 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_12
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042047", "story_v_out_416042.awb") ~= 0 then
					local var_200_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042047", "story_v_out_416042.awb") / 1000

					if var_200_16 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_8
					end

					if var_200_11.prefab_name ~= "" and arg_197_1.actors_[var_200_11.prefab_name] ~= nil then
						local var_200_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_11.prefab_name].transform, "story_v_out_416042", "416042047", "story_v_out_416042.awb")

						arg_197_1:RecordAudio("416042047", var_200_17)
						arg_197_1:RecordAudio("416042047", var_200_17)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416042", "416042047", "story_v_out_416042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416042", "416042047", "story_v_out_416042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_18 and arg_197_1.time_ < var_200_8 + var_200_18 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play416042048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416042048
		arg_201_1.duration_ = 5.93

		local var_201_0 = {
			zh = 4.666,
			ja = 5.933
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play416042049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1148"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1148 == nil then
				arg_201_1.var_.actorSpriteComps1148 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.125

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1148 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 1, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1148 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1148 = nil
			end

			local var_204_8 = arg_201_1.actors_["1148"].transform
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.var_.moveOldPos1148 = var_204_8.localPosition
				var_204_8.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1148", 3)

				local var_204_10 = var_204_8.childCount

				for iter_204_4 = 0, var_204_10 - 1 do
					local var_204_11 = var_204_8:GetChild(iter_204_4)

					if var_204_11.name == "split_6" or not string.find(var_204_11.name, "split") then
						var_204_11.gameObject:SetActive(true)
					else
						var_204_11.gameObject:SetActive(false)
					end
				end
			end

			local var_204_12 = 0.001

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_12 then
				local var_204_13 = (arg_201_1.time_ - var_204_9) / var_204_12
				local var_204_14 = Vector3.New(0, -429, -180)

				var_204_8.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1148, var_204_14, var_204_13)
			end

			if arg_201_1.time_ >= var_204_9 + var_204_12 and arg_201_1.time_ < var_204_9 + var_204_12 + arg_204_0 then
				var_204_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_204_15 = 0
			local var_204_16 = 0.475

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_17 = arg_201_1:FormatText(StoryNameCfg[8].name)

				arg_201_1.leftNameTxt_.text = var_204_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_18 = arg_201_1:GetWordFromCfg(416042048)
				local var_204_19 = arg_201_1:FormatText(var_204_18.content)

				arg_201_1.text_.text = var_204_19

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 19
				local var_204_21 = utf8.len(var_204_19)
				local var_204_22 = var_204_20 <= 0 and var_204_16 or var_204_16 * (var_204_21 / var_204_20)

				if var_204_22 > 0 and var_204_16 < var_204_22 then
					arg_201_1.talkMaxDuration = var_204_22

					if var_204_22 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_22 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_19
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042048", "story_v_out_416042.awb") ~= 0 then
					local var_204_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042048", "story_v_out_416042.awb") / 1000

					if var_204_23 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_15
					end

					if var_204_18.prefab_name ~= "" and arg_201_1.actors_[var_204_18.prefab_name] ~= nil then
						local var_204_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_18.prefab_name].transform, "story_v_out_416042", "416042048", "story_v_out_416042.awb")

						arg_201_1:RecordAudio("416042048", var_204_24)
						arg_201_1:RecordAudio("416042048", var_204_24)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416042", "416042048", "story_v_out_416042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416042", "416042048", "story_v_out_416042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_25 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_25 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_25

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_25 and arg_201_1.time_ < var_204_15 + var_204_25 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play416042049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416042049
		arg_205_1.duration_ = 7.1

		local var_205_0 = {
			zh = 4.5,
			ja = 7.1
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
				arg_205_0:Play416042050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.55

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[8].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(416042049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 22
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042049", "story_v_out_416042.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042049", "story_v_out_416042.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_416042", "416042049", "story_v_out_416042.awb")

						arg_205_1:RecordAudio("416042049", var_208_9)
						arg_205_1:RecordAudio("416042049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416042", "416042049", "story_v_out_416042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416042", "416042049", "story_v_out_416042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play416042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416042050
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play416042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 4

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_1 = 0.3

			if arg_209_1.time_ >= var_212_0 + var_212_1 and arg_209_1.time_ < var_212_0 + var_212_1 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_2 = "SS1602"

			if arg_209_1.bgs_[var_212_2] == nil then
				local var_212_3 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_2)
				var_212_3.name = var_212_2
				var_212_3.transform.parent = arg_209_1.stage_.transform
				var_212_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_2] = var_212_3
			end

			local var_212_4 = 2

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				local var_212_5 = manager.ui.mainCamera.transform.localPosition
				local var_212_6 = Vector3.New(0, 0, 10) + Vector3.New(var_212_5.x, var_212_5.y, 0)
				local var_212_7 = arg_209_1.bgs_.SS1602

				var_212_7.transform.localPosition = var_212_6
				var_212_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_8 = var_212_7:GetComponent("SpriteRenderer")

				if var_212_8 and var_212_8.sprite then
					local var_212_9 = (var_212_7.transform.localPosition - var_212_5).z
					local var_212_10 = manager.ui.mainCameraCom_
					local var_212_11 = 2 * var_212_9 * Mathf.Tan(var_212_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_12 = var_212_11 * var_212_10.aspect
					local var_212_13 = var_212_8.sprite.bounds.size.x
					local var_212_14 = var_212_8.sprite.bounds.size.y
					local var_212_15 = var_212_12 / var_212_13
					local var_212_16 = var_212_11 / var_212_14
					local var_212_17 = var_212_16 < var_212_15 and var_212_15 or var_212_16

					var_212_7.transform.localScale = Vector3.New(var_212_17, var_212_17, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "SS1602" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_18 = 0

			if var_212_18 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_19 = 2

			if var_212_18 <= arg_209_1.time_ and arg_209_1.time_ < var_212_18 + var_212_19 then
				local var_212_20 = (arg_209_1.time_ - var_212_18) / var_212_19
				local var_212_21 = Color.New(0, 0, 0)

				var_212_21.a = Mathf.Lerp(0, 1, var_212_20)
				arg_209_1.mask_.color = var_212_21
			end

			if arg_209_1.time_ >= var_212_18 + var_212_19 and arg_209_1.time_ < var_212_18 + var_212_19 + arg_212_0 then
				local var_212_22 = Color.New(0, 0, 0)

				var_212_22.a = 1
				arg_209_1.mask_.color = var_212_22
			end

			local var_212_23 = 2

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_24 = 2

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24
				local var_212_26 = Color.New(0, 0, 0)

				var_212_26.a = Mathf.Lerp(1, 0, var_212_25)
				arg_209_1.mask_.color = var_212_26
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 then
				local var_212_27 = Color.New(0, 0, 0)
				local var_212_28 = 0

				arg_209_1.mask_.enabled = false
				var_212_27.a = var_212_28
				arg_209_1.mask_.color = var_212_27
			end

			local var_212_29 = arg_209_1.actors_["1148"].transform
			local var_212_30 = 1.966

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.var_.moveOldPos1148 = var_212_29.localPosition
				var_212_29.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1148", 7)

				local var_212_31 = var_212_29.childCount

				for iter_212_2 = 0, var_212_31 - 1 do
					local var_212_32 = var_212_29:GetChild(iter_212_2)

					if var_212_32.name == "" or not string.find(var_212_32.name, "split") then
						var_212_32.gameObject:SetActive(true)
					else
						var_212_32.gameObject:SetActive(false)
					end
				end
			end

			local var_212_33 = 0.001

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_33 then
				local var_212_34 = (arg_209_1.time_ - var_212_30) / var_212_33
				local var_212_35 = Vector3.New(0, -2000, 0)

				var_212_29.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1148, var_212_35, var_212_34)
			end

			if arg_209_1.time_ >= var_212_30 + var_212_33 and arg_209_1.time_ < var_212_30 + var_212_33 + arg_212_0 then
				var_212_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_36 = manager.ui.mainCamera.transform
			local var_212_37 = 2

			if var_212_37 < arg_209_1.time_ and arg_209_1.time_ <= var_212_37 + arg_212_0 then
				local var_212_38 = arg_209_1.var_.effect3330402
				local var_212_39
				local var_212_40 = var_212_36

				if not var_212_38 then
					var_212_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_212_40)
					var_212_38.name = "0402"
					arg_209_1.var_.effect3330402 = var_212_38
				else
					var_212_38.transform:SetParent(var_212_40)
				end

				var_212_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_212_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_212_41 = arg_209_1.bgs_.SS1602.transform
			local var_212_42 = 2.03333333333333

			if var_212_42 < arg_209_1.time_ and arg_209_1.time_ <= var_212_42 + arg_212_0 then
				arg_209_1.var_.moveOldPosSS1602 = var_212_41.localPosition
			end

			local var_212_43 = 0.001

			if var_212_42 <= arg_209_1.time_ and arg_209_1.time_ < var_212_42 + var_212_43 then
				local var_212_44 = (arg_209_1.time_ - var_212_42) / var_212_43
				local var_212_45 = Vector3.New(0, 1, 10)

				var_212_41.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSS1602, var_212_45, var_212_44)
			end

			if arg_209_1.time_ >= var_212_42 + var_212_43 and arg_209_1.time_ < var_212_42 + var_212_43 + arg_212_0 then
				var_212_41.localPosition = Vector3.New(0, 1, 10)
			end

			local var_212_46 = arg_209_1.bgs_.SS1602.transform
			local var_212_47 = 2.06733333333333

			if var_212_47 < arg_209_1.time_ and arg_209_1.time_ <= var_212_47 + arg_212_0 then
				arg_209_1.var_.moveOldPosSS1602 = var_212_46.localPosition
			end

			local var_212_48 = 1.93266666666667

			if var_212_47 <= arg_209_1.time_ and arg_209_1.time_ < var_212_47 + var_212_48 then
				local var_212_49 = (arg_209_1.time_ - var_212_47) / var_212_48
				local var_212_50 = Vector3.New(0, 1, 9)

				var_212_46.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSS1602, var_212_50, var_212_49)
			end

			if arg_209_1.time_ >= var_212_47 + var_212_48 and arg_209_1.time_ < var_212_47 + var_212_48 + arg_212_0 then
				var_212_46.localPosition = Vector3.New(0, 1, 9)
			end

			local var_212_51 = manager.ui.mainCamera.transform
			local var_212_52 = 4.3

			if var_212_52 < arg_209_1.time_ and arg_209_1.time_ <= var_212_52 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_51.localPosition
			end

			local var_212_53 = 0.9

			if var_212_52 <= arg_209_1.time_ and arg_209_1.time_ < var_212_52 + var_212_53 then
				local var_212_54 = (arg_209_1.time_ - var_212_52) / 0.066
				local var_212_55, var_212_56 = math.modf(var_212_54)

				var_212_51.localPosition = Vector3.New(var_212_56 * 0.13, var_212_56 * 0.13, var_212_56 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= var_212_52 + var_212_53 and arg_209_1.time_ < var_212_52 + var_212_53 + arg_212_0 then
				var_212_51.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_57 = 4.3
			local var_212_58 = 1

			if var_212_57 < arg_209_1.time_ and arg_209_1.time_ <= var_212_57 + arg_212_0 then
				local var_212_59 = "play"
				local var_212_60 = "effect"

				arg_209_1:AudioAction(var_212_59, var_212_60, "se_story_123_02", "se_story_123_02_fire", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_61 = 4
			local var_212_62 = 1.55

			if var_212_61 < arg_209_1.time_ and arg_209_1.time_ <= var_212_61 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_63 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_63:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_64 = arg_209_1:GetWordFromCfg(416042050)
				local var_212_65 = arg_209_1:FormatText(var_212_64.content)

				arg_209_1.text_.text = var_212_65

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_66 = 62
				local var_212_67 = utf8.len(var_212_65)
				local var_212_68 = var_212_66 <= 0 and var_212_62 or var_212_62 * (var_212_67 / var_212_66)

				if var_212_68 > 0 and var_212_62 < var_212_68 then
					arg_209_1.talkMaxDuration = var_212_68
					var_212_61 = var_212_61 + 0.3

					if var_212_68 + var_212_61 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_68 + var_212_61
					end
				end

				arg_209_1.text_.text = var_212_65
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_69 = var_212_61 + 0.3
			local var_212_70 = math.max(var_212_62, arg_209_1.talkMaxDuration)

			if var_212_69 <= arg_209_1.time_ and arg_209_1.time_ < var_212_69 + var_212_70 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_69) / var_212_70

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_69 + var_212_70 and arg_209_1.time_ < var_212_69 + var_212_70 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93266666666667,
				className = "StoryMoveNode",
				startTime = 2.06733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play416042051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416042051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416042052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.95

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(416042051)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 78
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play416042052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416042052
		arg_219_1.duration_ = 5.57

		local var_219_0 = {
			zh = 4.833,
			ja = 5.566
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416042053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.3

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[8].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(416042052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042052", "story_v_out_416042.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042052", "story_v_out_416042.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_416042", "416042052", "story_v_out_416042.awb")

						arg_219_1:RecordAudio("416042052", var_222_9)
						arg_219_1:RecordAudio("416042052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416042", "416042052", "story_v_out_416042.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416042", "416042052", "story_v_out_416042.awb")
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
	Play416042053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416042053
		arg_223_1.duration_ = 11.2

		local var_223_0 = {
			zh = 6.2,
			ja = 11.2
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
				arg_223_0:Play416042054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.6

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[8].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(416042053)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042053", "story_v_out_416042.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042053", "story_v_out_416042.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_416042", "416042053", "story_v_out_416042.awb")

						arg_223_1:RecordAudio("416042053", var_226_9)
						arg_223_1:RecordAudio("416042053", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416042", "416042053", "story_v_out_416042.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416042", "416042053", "story_v_out_416042.awb")
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
	Play416042054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416042054
		arg_227_1.duration_ = 7.5

		local var_227_0 = {
			zh = 5.4,
			ja = 7.5
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play416042055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.525

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[8].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(416042054)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 21
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042054", "story_v_out_416042.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042054", "story_v_out_416042.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_416042", "416042054", "story_v_out_416042.awb")

						arg_227_1:RecordAudio("416042054", var_230_9)
						arg_227_1:RecordAudio("416042054", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416042", "416042054", "story_v_out_416042.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416042", "416042054", "story_v_out_416042.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416042055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416042055
		arg_231_1.duration_ = 4.26

		local var_231_0 = {
			zh = 3.158,
			ja = 4.258
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
				arg_231_0:Play416042056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1148"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1148 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1148", 7)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(0, -2000, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1148, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_234_7 = manager.ui.mainCamera.transform
			local var_234_8 = 0

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				local var_234_9 = arg_231_1.var_.effect77
				local var_234_10
				local var_234_11 = var_234_7

				if not var_234_9 then
					var_234_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_234_11)
					var_234_9.name = "77"
					arg_231_1.var_.effect77 = var_234_9
				else
					var_234_9.transform:SetParent(var_234_11)
				end

				var_234_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_234_12 = manager.ui.mainCamera.transform
			local var_234_13 = 1

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				local var_234_14 = arg_231_1.var_.effect77

				if var_234_14 then
					Object.Destroy(var_234_14)

					arg_231_1.var_.effect77 = nil
				end
			end

			local var_234_15 = 0
			local var_234_16 = 1

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				local var_234_17 = "play"
				local var_234_18 = "effect"

				arg_231_1:AudioAction(var_234_17, var_234_18, "se_story_16", "se_story_16_channel", "")
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_19 = 0.625
			local var_234_20 = 0.375

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_21 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_21:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_22 = arg_231_1:FormatText(StoryNameCfg[36].name)

				arg_231_1.leftNameTxt_.text = var_234_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_23 = arg_231_1:GetWordFromCfg(416042055)
				local var_234_24 = arg_231_1:FormatText(var_234_23.content)

				arg_231_1.text_.text = var_234_24

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_25 = 15
				local var_234_26 = utf8.len(var_234_24)
				local var_234_27 = var_234_25 <= 0 and var_234_20 or var_234_20 * (var_234_26 / var_234_25)

				if var_234_27 > 0 and var_234_20 < var_234_27 then
					arg_231_1.talkMaxDuration = var_234_27
					var_234_19 = var_234_19 + 0.3

					if var_234_27 + var_234_19 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_27 + var_234_19
					end
				end

				arg_231_1.text_.text = var_234_24
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042055", "story_v_out_416042.awb") ~= 0 then
					local var_234_28 = manager.audio:GetVoiceLength("story_v_out_416042", "416042055", "story_v_out_416042.awb") / 1000

					if var_234_28 + var_234_19 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_19
					end

					if var_234_23.prefab_name ~= "" and arg_231_1.actors_[var_234_23.prefab_name] ~= nil then
						local var_234_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_23.prefab_name].transform, "story_v_out_416042", "416042055", "story_v_out_416042.awb")

						arg_231_1:RecordAudio("416042055", var_234_29)
						arg_231_1:RecordAudio("416042055", var_234_29)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416042", "416042055", "story_v_out_416042.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416042", "416042055", "story_v_out_416042.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_30 = var_234_19 + 0.3
			local var_234_31 = math.max(var_234_20, arg_231_1.talkMaxDuration)

			if var_234_30 <= arg_231_1.time_ and arg_231_1.time_ < var_234_30 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_30) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_30 + var_234_31 and arg_231_1.time_ < var_234_30 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play416042056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 416042056
		arg_237_1.duration_ = 5.93

		local var_237_0 = {
			zh = 5.633,
			ja = 5.933
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
				arg_237_0:Play416042057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.575

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[8].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(416042056)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042056", "story_v_out_416042.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042056", "story_v_out_416042.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_416042", "416042056", "story_v_out_416042.awb")

						arg_237_1:RecordAudio("416042056", var_240_9)
						arg_237_1:RecordAudio("416042056", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_416042", "416042056", "story_v_out_416042.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_416042", "416042056", "story_v_out_416042.awb")
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
	Play416042057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 416042057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play416042058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 2.05

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(416042057)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 82
				local var_244_5 = utf8.len(var_244_3)
				local var_244_6 = var_244_4 <= 0 and var_244_1 or var_244_1 * (var_244_5 / var_244_4)

				if var_244_6 > 0 and var_244_1 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_7 and arg_241_1.time_ < var_244_0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play416042058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 416042058
		arg_245_1.duration_ = 6.6

		local var_245_0 = {
			zh = 4.033,
			ja = 6.6
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play416042059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = manager.ui.mainCamera.transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				local var_248_2 = arg_245_1.var_.effect77
				local var_248_3
				local var_248_4 = var_248_0

				if not var_248_2 then
					var_248_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_248_4)
					var_248_2.name = "77"
					arg_245_1.var_.effect77 = var_248_2
				else
					var_248_2.transform:SetParent(var_248_4)
				end

				var_248_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_248_5 = manager.ui.mainCamera.transform
			local var_248_6 = 1

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				local var_248_7 = arg_245_1.var_.effect77

				if var_248_7 then
					Object.Destroy(var_248_7)

					arg_245_1.var_.effect77 = nil
				end
			end

			local var_248_8 = 0
			local var_248_9 = 1

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				local var_248_10 = "play"
				local var_248_11 = "effect"

				arg_245_1:AudioAction(var_248_10, var_248_11, "se_story_16", "se_story_16_channel", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_12 = 1
			local var_248_13 = 0.45

			if var_248_12 < arg_245_1.time_ and arg_245_1.time_ <= var_248_12 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_14 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_14:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_15 = arg_245_1:FormatText(StoryNameCfg[36].name)

				arg_245_1.leftNameTxt_.text = var_248_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_16 = arg_245_1:GetWordFromCfg(416042058)
				local var_248_17 = arg_245_1:FormatText(var_248_16.content)

				arg_245_1.text_.text = var_248_17

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_18 = 18
				local var_248_19 = utf8.len(var_248_17)
				local var_248_20 = var_248_18 <= 0 and var_248_13 or var_248_13 * (var_248_19 / var_248_18)

				if var_248_20 > 0 and var_248_13 < var_248_20 then
					arg_245_1.talkMaxDuration = var_248_20
					var_248_12 = var_248_12 + 0.3

					if var_248_20 + var_248_12 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_20 + var_248_12
					end
				end

				arg_245_1.text_.text = var_248_17
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042058", "story_v_out_416042.awb") ~= 0 then
					local var_248_21 = manager.audio:GetVoiceLength("story_v_out_416042", "416042058", "story_v_out_416042.awb") / 1000

					if var_248_21 + var_248_12 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_21 + var_248_12
					end

					if var_248_16.prefab_name ~= "" and arg_245_1.actors_[var_248_16.prefab_name] ~= nil then
						local var_248_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_16.prefab_name].transform, "story_v_out_416042", "416042058", "story_v_out_416042.awb")

						arg_245_1:RecordAudio("416042058", var_248_22)
						arg_245_1:RecordAudio("416042058", var_248_22)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_416042", "416042058", "story_v_out_416042.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_416042", "416042058", "story_v_out_416042.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_23 = var_248_12 + 0.3
			local var_248_24 = math.max(var_248_13, arg_245_1.talkMaxDuration)

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_24 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_23) / var_248_24

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_23 + var_248_24 and arg_245_1.time_ < var_248_23 + var_248_24 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play416042059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416042059
		arg_251_1.duration_ = 8.67

		local var_251_0 = {
			zh = 8.666,
			ja = 8.366
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
				arg_251_0:Play416042060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 2

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				local var_254_1 = manager.ui.mainCamera.transform.localPosition
				local var_254_2 = Vector3.New(0, 0, 10) + Vector3.New(var_254_1.x, var_254_1.y, 0)
				local var_254_3 = arg_251_1.bgs_.I14f

				var_254_3.transform.localPosition = var_254_2
				var_254_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_4 = var_254_3:GetComponent("SpriteRenderer")

				if var_254_4 and var_254_4.sprite then
					local var_254_5 = (var_254_3.transform.localPosition - var_254_1).z
					local var_254_6 = manager.ui.mainCameraCom_
					local var_254_7 = 2 * var_254_5 * Mathf.Tan(var_254_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_254_8 = var_254_7 * var_254_6.aspect
					local var_254_9 = var_254_4.sprite.bounds.size.x
					local var_254_10 = var_254_4.sprite.bounds.size.y
					local var_254_11 = var_254_8 / var_254_9
					local var_254_12 = var_254_7 / var_254_10
					local var_254_13 = var_254_12 < var_254_11 and var_254_11 or var_254_12

					var_254_3.transform.localScale = Vector3.New(var_254_13, var_254_13, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "I14f" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_15 = 2

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 then
				local var_254_16 = (arg_251_1.time_ - var_254_14) / var_254_15
				local var_254_17 = Color.New(0, 0, 0)

				var_254_17.a = Mathf.Lerp(0, 1, var_254_16)
				arg_251_1.mask_.color = var_254_17
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 then
				local var_254_18 = Color.New(0, 0, 0)

				var_254_18.a = 1
				arg_251_1.mask_.color = var_254_18
			end

			local var_254_19 = 2

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_20 = 2

			if var_254_19 <= arg_251_1.time_ and arg_251_1.time_ < var_254_19 + var_254_20 then
				local var_254_21 = (arg_251_1.time_ - var_254_19) / var_254_20
				local var_254_22 = Color.New(0, 0, 0)

				var_254_22.a = Mathf.Lerp(1, 0, var_254_21)
				arg_251_1.mask_.color = var_254_22
			end

			if arg_251_1.time_ >= var_254_19 + var_254_20 and arg_251_1.time_ < var_254_19 + var_254_20 + arg_254_0 then
				local var_254_23 = Color.New(0, 0, 0)
				local var_254_24 = 0

				arg_251_1.mask_.enabled = false
				var_254_23.a = var_254_24
				arg_251_1.mask_.color = var_254_23
			end

			local var_254_25 = "1028"

			if arg_251_1.actors_[var_254_25] == nil then
				local var_254_26 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_254_26) then
					local var_254_27 = Object.Instantiate(var_254_26, arg_251_1.canvasGo_.transform)

					var_254_27.transform:SetSiblingIndex(1)

					var_254_27.name = var_254_25
					var_254_27.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_251_1.actors_[var_254_25] = var_254_27

					local var_254_28 = var_254_27:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_251_1.isInRecall_ then
						for iter_254_2, iter_254_3 in ipairs(var_254_28) do
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_254_29 = arg_251_1.actors_["1028"]
			local var_254_30 = 3.46733333333333

			if var_254_30 < arg_251_1.time_ and arg_251_1.time_ <= var_254_30 + arg_254_0 and not isNil(var_254_29) and arg_251_1.var_.actorSpriteComps1028 == nil then
				arg_251_1.var_.actorSpriteComps1028 = var_254_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_31 = 0.125

			if var_254_30 <= arg_251_1.time_ and arg_251_1.time_ < var_254_30 + var_254_31 and not isNil(var_254_29) then
				local var_254_32 = (arg_251_1.time_ - var_254_30) / var_254_31

				if arg_251_1.var_.actorSpriteComps1028 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								local var_254_33 = Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor1.r, var_254_32)
								local var_254_34 = Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor1.g, var_254_32)
								local var_254_35 = Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor1.b, var_254_32)

								iter_254_5.color = Color.New(var_254_33, var_254_34, var_254_35)
							else
								local var_254_36 = Mathf.Lerp(iter_254_5.color.r, 1, var_254_32)

								iter_254_5.color = Color.New(var_254_36, var_254_36, var_254_36)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_30 + var_254_31 and arg_251_1.time_ < var_254_30 + var_254_31 + arg_254_0 and not isNil(var_254_29) and arg_251_1.var_.actorSpriteComps1028 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_254_7 then
						if arg_251_1.isInRecall_ then
							iter_254_7.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1028 = nil
			end

			local var_254_37 = arg_251_1.actors_["1028"].transform
			local var_254_38 = 3.46733333333333

			if var_254_38 < arg_251_1.time_ and arg_251_1.time_ <= var_254_38 + arg_254_0 then
				arg_251_1.var_.moveOldPos1028 = var_254_37.localPosition
				var_254_37.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1028", 3)

				local var_254_39 = var_254_37.childCount

				for iter_254_8 = 0, var_254_39 - 1 do
					local var_254_40 = var_254_37:GetChild(iter_254_8)

					if var_254_40.name == "split_2" or not string.find(var_254_40.name, "split") then
						var_254_40.gameObject:SetActive(true)
					else
						var_254_40.gameObject:SetActive(false)
					end
				end
			end

			local var_254_41 = 0.001

			if var_254_38 <= arg_251_1.time_ and arg_251_1.time_ < var_254_38 + var_254_41 then
				local var_254_42 = (arg_251_1.time_ - var_254_38) / var_254_41
				local var_254_43 = Vector3.New(0, -402.7, -156.1)

				var_254_37.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1028, var_254_43, var_254_42)
			end

			if arg_251_1.time_ >= var_254_38 + var_254_41 and arg_251_1.time_ < var_254_38 + var_254_41 + arg_254_0 then
				var_254_37.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_254_44 = arg_251_1.actors_["1028"]
			local var_254_45 = 3.46733333333333

			if var_254_45 < arg_251_1.time_ and arg_251_1.time_ <= var_254_45 + arg_254_0 then
				local var_254_46 = var_254_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_46 then
					arg_251_1.var_.alphaOldValue1028 = var_254_46.alpha
					arg_251_1.var_.characterEffect1028 = var_254_46
				end

				arg_251_1.var_.alphaOldValue1028 = 0
			end

			local var_254_47 = 0.857666666666667

			if var_254_45 <= arg_251_1.time_ and arg_251_1.time_ < var_254_45 + var_254_47 then
				local var_254_48 = (arg_251_1.time_ - var_254_45) / var_254_47
				local var_254_49 = Mathf.Lerp(arg_251_1.var_.alphaOldValue1028, 1, var_254_48)

				if arg_251_1.var_.characterEffect1028 then
					arg_251_1.var_.characterEffect1028.alpha = var_254_49
				end
			end

			if arg_251_1.time_ >= var_254_45 + var_254_47 and arg_251_1.time_ < var_254_45 + var_254_47 + arg_254_0 and arg_251_1.var_.characterEffect1028 then
				arg_251_1.var_.characterEffect1028.alpha = 1
			end

			local var_254_50 = manager.ui.mainCamera.transform
			local var_254_51 = 1.83333333333333

			if var_254_51 < arg_251_1.time_ and arg_251_1.time_ <= var_254_51 + arg_254_0 then
				local var_254_52 = arg_251_1.var_.effect3330402

				if var_254_52 then
					Object.Destroy(var_254_52)

					arg_251_1.var_.effect3330402 = nil
				end
			end

			local var_254_53 = 0
			local var_254_54 = 0.2

			if var_254_53 < arg_251_1.time_ and arg_251_1.time_ <= var_254_53 + arg_254_0 then
				local var_254_55 = "play"
				local var_254_56 = "music"

				arg_251_1:AudioAction(var_254_55, var_254_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_254_57 = ""
				local var_254_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_254_58 ~= "" then
					if arg_251_1.bgmTxt_.text ~= var_254_58 and arg_251_1.bgmTxt_.text ~= "" then
						if arg_251_1.bgmTxt2_.text ~= "" then
							arg_251_1.bgmTxt_.text = arg_251_1.bgmTxt2_.text
						end

						arg_251_1.bgmTxt2_.text = var_254_58

						arg_251_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_251_1.bgmTxt_.text = var_254_58
						arg_251_1.bgmTxt2_.text = var_254_58
					end

					if arg_251_1.bgmTimer then
						arg_251_1.bgmTimer:Stop()

						arg_251_1.bgmTimer = nil
					end

					if arg_251_1.settingData.show_music_name == 1 then
						arg_251_1.musicController:SetSelectedState("show")
						arg_251_1.musicAnimator_:Play("open", 0, 0)

						if arg_251_1.settingData.music_time ~= 0 then
							arg_251_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_251_1.settingData.music_time), function()
								if arg_251_1 == nil or isNil(arg_251_1.bgmTxt_) then
									return
								end

								arg_251_1.musicController:SetSelectedState("hide")
								arg_251_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_59 = 4
			local var_254_60 = 0.325

			if var_254_59 < arg_251_1.time_ and arg_251_1.time_ <= var_254_59 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_61 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_61:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_251_1.dialogCg_.alpha = arg_256_0
				end))
				var_254_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_62 = arg_251_1:FormatText(StoryNameCfg[327].name)

				arg_251_1.leftNameTxt_.text = var_254_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_63 = arg_251_1:GetWordFromCfg(416042059)
				local var_254_64 = arg_251_1:FormatText(var_254_63.content)

				arg_251_1.text_.text = var_254_64

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_65 = 13
				local var_254_66 = utf8.len(var_254_64)
				local var_254_67 = var_254_65 <= 0 and var_254_60 or var_254_60 * (var_254_66 / var_254_65)

				if var_254_67 > 0 and var_254_60 < var_254_67 then
					arg_251_1.talkMaxDuration = var_254_67
					var_254_59 = var_254_59 + 0.3

					if var_254_67 + var_254_59 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_67 + var_254_59
					end
				end

				arg_251_1.text_.text = var_254_64
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042059", "story_v_out_416042.awb") ~= 0 then
					local var_254_68 = manager.audio:GetVoiceLength("story_v_out_416042", "416042059", "story_v_out_416042.awb") / 1000

					if var_254_68 + var_254_59 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_68 + var_254_59
					end

					if var_254_63.prefab_name ~= "" and arg_251_1.actors_[var_254_63.prefab_name] ~= nil then
						local var_254_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_63.prefab_name].transform, "story_v_out_416042", "416042059", "story_v_out_416042.awb")

						arg_251_1:RecordAudio("416042059", var_254_69)
						arg_251_1:RecordAudio("416042059", var_254_69)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416042", "416042059", "story_v_out_416042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416042", "416042059", "story_v_out_416042.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_70 = var_254_59 + 0.3
			local var_254_71 = math.max(var_254_60, arg_251_1.talkMaxDuration)

			if var_254_70 <= arg_251_1.time_ and arg_251_1.time_ < var_254_70 + var_254_71 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_70) / var_254_71

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_70 + var_254_71 and arg_251_1.time_ < var_254_70 + var_254_71 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.46733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play416042060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 416042060
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play416042061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1028"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1028 = var_261_0.localPosition
				var_261_0.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1028", 7)

				local var_261_2 = var_261_0.childCount

				for iter_261_0 = 0, var_261_2 - 1 do
					local var_261_3 = var_261_0:GetChild(iter_261_0)

					if var_261_3.name == "" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_4 then
				local var_261_5 = (arg_258_1.time_ - var_261_1) / var_261_4
				local var_261_6 = Vector3.New(0, -2000, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1028, var_261_6, var_261_5)
			end

			if arg_258_1.time_ >= var_261_1 + var_261_4 and arg_258_1.time_ < var_261_1 + var_261_4 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_7 = 0
			local var_261_8 = 1.925

			if var_261_7 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_9 = arg_258_1:GetWordFromCfg(416042060)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 77
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_8 or var_261_8 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_8 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_7 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_7
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_8, arg_258_1.talkMaxDuration)

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_7) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_7 + var_261_14 and arg_258_1.time_ < var_261_7 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play416042061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 416042061
		arg_262_1.duration_ = 6.17

		local var_262_0 = {
			zh = 4.2,
			ja = 6.166
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
				arg_262_0:Play416042062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1028"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1028 = var_265_0.localPosition
				var_265_0.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1028", 3)

				local var_265_2 = var_265_0.childCount

				for iter_265_0 = 0, var_265_2 - 1 do
					local var_265_3 = var_265_0:GetChild(iter_265_0)

					if var_265_3.name == "split_2" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_4 then
				local var_265_5 = (arg_262_1.time_ - var_265_1) / var_265_4
				local var_265_6 = Vector3.New(0, -402.7, -156.1)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1028, var_265_6, var_265_5)
			end

			if arg_262_1.time_ >= var_265_1 + var_265_4 and arg_262_1.time_ < var_265_1 + var_265_4 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_265_7 = arg_262_1.actors_["1028"]
			local var_265_8 = 0

			if var_265_8 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.actorSpriteComps1028 == nil then
				arg_262_1.var_.actorSpriteComps1028 = var_265_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_9 = 0.125

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_9 and not isNil(var_265_7) then
				local var_265_10 = (arg_262_1.time_ - var_265_8) / var_265_9

				if arg_262_1.var_.actorSpriteComps1028 then
					for iter_265_1, iter_265_2 in pairs(arg_262_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_265_2 then
							if arg_262_1.isInRecall_ then
								local var_265_11 = Mathf.Lerp(iter_265_2.color.r, arg_262_1.hightColor1.r, var_265_10)
								local var_265_12 = Mathf.Lerp(iter_265_2.color.g, arg_262_1.hightColor1.g, var_265_10)
								local var_265_13 = Mathf.Lerp(iter_265_2.color.b, arg_262_1.hightColor1.b, var_265_10)

								iter_265_2.color = Color.New(var_265_11, var_265_12, var_265_13)
							else
								local var_265_14 = Mathf.Lerp(iter_265_2.color.r, 1, var_265_10)

								iter_265_2.color = Color.New(var_265_14, var_265_14, var_265_14)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_8 + var_265_9 and arg_262_1.time_ < var_265_8 + var_265_9 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.actorSpriteComps1028 then
				for iter_265_3, iter_265_4 in pairs(arg_262_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_265_4 then
						if arg_262_1.isInRecall_ then
							iter_265_4.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps1028 = nil
			end

			local var_265_15 = 0
			local var_265_16 = 0.2

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				local var_265_17 = "play"
				local var_265_18 = "music"

				arg_262_1:AudioAction(var_265_17, var_265_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_265_19 = ""
				local var_265_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_265_20 ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_20 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_20

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_20
						arg_262_1.bgmTxt2_.text = var_265_20
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_21 = 0.466666666666667
			local var_265_22 = 1

			if var_265_21 < arg_262_1.time_ and arg_262_1.time_ <= var_265_21 + arg_265_0 then
				local var_265_23 = "play"
				local var_265_24 = "music"

				arg_262_1:AudioAction(var_265_23, var_265_24, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_265_25 = ""
				local var_265_26 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if var_265_26 ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_26 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_26

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_26
						arg_262_1.bgmTxt2_.text = var_265_26
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_27 = 0
			local var_265_28 = 0.525

			if var_265_27 < arg_262_1.time_ and arg_262_1.time_ <= var_265_27 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_29 = arg_262_1:FormatText(StoryNameCfg[327].name)

				arg_262_1.leftNameTxt_.text = var_265_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_30 = arg_262_1:GetWordFromCfg(416042061)
				local var_265_31 = arg_262_1:FormatText(var_265_30.content)

				arg_262_1.text_.text = var_265_31

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_32 = 21
				local var_265_33 = utf8.len(var_265_31)
				local var_265_34 = var_265_32 <= 0 and var_265_28 or var_265_28 * (var_265_33 / var_265_32)

				if var_265_34 > 0 and var_265_28 < var_265_34 then
					arg_262_1.talkMaxDuration = var_265_34

					if var_265_34 + var_265_27 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_34 + var_265_27
					end
				end

				arg_262_1.text_.text = var_265_31
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042061", "story_v_out_416042.awb") ~= 0 then
					local var_265_35 = manager.audio:GetVoiceLength("story_v_out_416042", "416042061", "story_v_out_416042.awb") / 1000

					if var_265_35 + var_265_27 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_35 + var_265_27
					end

					if var_265_30.prefab_name ~= "" and arg_262_1.actors_[var_265_30.prefab_name] ~= nil then
						local var_265_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_30.prefab_name].transform, "story_v_out_416042", "416042061", "story_v_out_416042.awb")

						arg_262_1:RecordAudio("416042061", var_265_36)
						arg_262_1:RecordAudio("416042061", var_265_36)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_416042", "416042061", "story_v_out_416042.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_416042", "416042061", "story_v_out_416042.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_37 = math.max(var_265_28, arg_262_1.talkMaxDuration)

			if var_265_27 <= arg_262_1.time_ and arg_262_1.time_ < var_265_27 + var_265_37 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_27) / var_265_37

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_27 + var_265_37 and arg_262_1.time_ < var_265_27 + var_265_37 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play416042062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 416042062
		arg_268_1.duration_ = 4.7

		local var_268_0 = {
			zh = 4.066,
			ja = 4.7
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play416042063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1028"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1028 = var_271_0.localPosition
				var_271_0.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("1028", 2)

				local var_271_2 = var_271_0.childCount

				for iter_271_0 = 0, var_271_2 - 1 do
					local var_271_3 = var_271_0:GetChild(iter_271_0)

					if var_271_3.name == "" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_4 then
				local var_271_5 = (arg_268_1.time_ - var_271_1) / var_271_4
				local var_271_6 = Vector3.New(-390, -402.7, -156.1)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1028, var_271_6, var_271_5)
			end

			if arg_268_1.time_ >= var_271_1 + var_271_4 and arg_268_1.time_ < var_271_1 + var_271_4 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_271_7 = arg_268_1.actors_["1028"]
			local var_271_8 = 0

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 and not isNil(var_271_7) and arg_268_1.var_.actorSpriteComps1028 == nil then
				arg_268_1.var_.actorSpriteComps1028 = var_271_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_9 = 0.125

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_9 and not isNil(var_271_7) then
				local var_271_10 = (arg_268_1.time_ - var_271_8) / var_271_9

				if arg_268_1.var_.actorSpriteComps1028 then
					for iter_271_1, iter_271_2 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_271_2 then
							if arg_268_1.isInRecall_ then
								local var_271_11 = Mathf.Lerp(iter_271_2.color.r, arg_268_1.hightColor2.r, var_271_10)
								local var_271_12 = Mathf.Lerp(iter_271_2.color.g, arg_268_1.hightColor2.g, var_271_10)
								local var_271_13 = Mathf.Lerp(iter_271_2.color.b, arg_268_1.hightColor2.b, var_271_10)

								iter_271_2.color = Color.New(var_271_11, var_271_12, var_271_13)
							else
								local var_271_14 = Mathf.Lerp(iter_271_2.color.r, 0.5, var_271_10)

								iter_271_2.color = Color.New(var_271_14, var_271_14, var_271_14)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_8 + var_271_9 and arg_268_1.time_ < var_271_8 + var_271_9 + arg_271_0 and not isNil(var_271_7) and arg_268_1.var_.actorSpriteComps1028 then
				for iter_271_3, iter_271_4 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_271_4 then
						if arg_268_1.isInRecall_ then
							iter_271_4.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps1028 = nil
			end

			local var_271_15 = "10108"

			if arg_268_1.actors_[var_271_15] == nil then
				local var_271_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_271_16) then
					local var_271_17 = Object.Instantiate(var_271_16, arg_268_1.canvasGo_.transform)

					var_271_17.transform:SetSiblingIndex(1)

					var_271_17.name = var_271_15
					var_271_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_268_1.actors_[var_271_15] = var_271_17

					local var_271_18 = var_271_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_268_1.isInRecall_ then
						for iter_271_5, iter_271_6 in ipairs(var_271_18) do
							iter_271_6.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_271_19 = arg_268_1.actors_["10108"].transform
			local var_271_20 = 0

			if var_271_20 < arg_268_1.time_ and arg_268_1.time_ <= var_271_20 + arg_271_0 then
				arg_268_1.var_.moveOldPos10108 = var_271_19.localPosition
				var_271_19.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10108", 4)

				local var_271_21 = var_271_19.childCount

				for iter_271_7 = 0, var_271_21 - 1 do
					local var_271_22 = var_271_19:GetChild(iter_271_7)

					if var_271_22.name == "" or not string.find(var_271_22.name, "split") then
						var_271_22.gameObject:SetActive(true)
					else
						var_271_22.gameObject:SetActive(false)
					end
				end
			end

			local var_271_23 = 0.001

			if var_271_20 <= arg_268_1.time_ and arg_268_1.time_ < var_271_20 + var_271_23 then
				local var_271_24 = (arg_268_1.time_ - var_271_20) / var_271_23
				local var_271_25 = Vector3.New(390, -399.6, -130)

				var_271_19.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10108, var_271_25, var_271_24)
			end

			if arg_268_1.time_ >= var_271_20 + var_271_23 and arg_268_1.time_ < var_271_20 + var_271_23 + arg_271_0 then
				var_271_19.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_271_26 = arg_268_1.actors_["10108"]
			local var_271_27 = 0

			if var_271_27 < arg_268_1.time_ and arg_268_1.time_ <= var_271_27 + arg_271_0 and not isNil(var_271_26) and arg_268_1.var_.actorSpriteComps10108 == nil then
				arg_268_1.var_.actorSpriteComps10108 = var_271_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_28 = 0.125

			if var_271_27 <= arg_268_1.time_ and arg_268_1.time_ < var_271_27 + var_271_28 and not isNil(var_271_26) then
				local var_271_29 = (arg_268_1.time_ - var_271_27) / var_271_28

				if arg_268_1.var_.actorSpriteComps10108 then
					for iter_271_8, iter_271_9 in pairs(arg_268_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_271_9 then
							if arg_268_1.isInRecall_ then
								local var_271_30 = Mathf.Lerp(iter_271_9.color.r, arg_268_1.hightColor1.r, var_271_29)
								local var_271_31 = Mathf.Lerp(iter_271_9.color.g, arg_268_1.hightColor1.g, var_271_29)
								local var_271_32 = Mathf.Lerp(iter_271_9.color.b, arg_268_1.hightColor1.b, var_271_29)

								iter_271_9.color = Color.New(var_271_30, var_271_31, var_271_32)
							else
								local var_271_33 = Mathf.Lerp(iter_271_9.color.r, 1, var_271_29)

								iter_271_9.color = Color.New(var_271_33, var_271_33, var_271_33)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_27 + var_271_28 and arg_268_1.time_ < var_271_27 + var_271_28 + arg_271_0 and not isNil(var_271_26) and arg_268_1.var_.actorSpriteComps10108 then
				for iter_271_10, iter_271_11 in pairs(arg_268_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_271_11 then
						if arg_268_1.isInRecall_ then
							iter_271_11.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_271_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10108 = nil
			end

			local var_271_34 = 0
			local var_271_35 = 0.325

			if var_271_34 < arg_268_1.time_ and arg_268_1.time_ <= var_271_34 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_36 = arg_268_1:FormatText(StoryNameCfg[1083].name)

				arg_268_1.leftNameTxt_.text = var_271_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_37 = arg_268_1:GetWordFromCfg(416042062)
				local var_271_38 = arg_268_1:FormatText(var_271_37.content)

				arg_268_1.text_.text = var_271_38

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_39 = 13
				local var_271_40 = utf8.len(var_271_38)
				local var_271_41 = var_271_39 <= 0 and var_271_35 or var_271_35 * (var_271_40 / var_271_39)

				if var_271_41 > 0 and var_271_35 < var_271_41 then
					arg_268_1.talkMaxDuration = var_271_41

					if var_271_41 + var_271_34 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_41 + var_271_34
					end
				end

				arg_268_1.text_.text = var_271_38
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042062", "story_v_out_416042.awb") ~= 0 then
					local var_271_42 = manager.audio:GetVoiceLength("story_v_out_416042", "416042062", "story_v_out_416042.awb") / 1000

					if var_271_42 + var_271_34 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_42 + var_271_34
					end

					if var_271_37.prefab_name ~= "" and arg_268_1.actors_[var_271_37.prefab_name] ~= nil then
						local var_271_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_37.prefab_name].transform, "story_v_out_416042", "416042062", "story_v_out_416042.awb")

						arg_268_1:RecordAudio("416042062", var_271_43)
						arg_268_1:RecordAudio("416042062", var_271_43)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_416042", "416042062", "story_v_out_416042.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_416042", "416042062", "story_v_out_416042.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_44 = math.max(var_271_35, arg_268_1.talkMaxDuration)

			if var_271_34 <= arg_268_1.time_ and arg_268_1.time_ < var_271_34 + var_271_44 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_34) / var_271_44

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_34 + var_271_44 and arg_268_1.time_ < var_271_34 + var_271_44 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play416042063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 416042063
		arg_272_1.duration_ = 7.93

		local var_272_0 = {
			zh = 3.933,
			ja = 7.933
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play416042064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.425

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1083].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(416042063)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 17
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042063", "story_v_out_416042.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042063", "story_v_out_416042.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_416042", "416042063", "story_v_out_416042.awb")

						arg_272_1:RecordAudio("416042063", var_275_9)
						arg_272_1:RecordAudio("416042063", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_416042", "416042063", "story_v_out_416042.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_416042", "416042063", "story_v_out_416042.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play416042064 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 416042064
		arg_276_1.duration_ = 7.1

		local var_276_0 = {
			zh = 7.1,
			ja = 6.866
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play416042065(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10108"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10108 == nil then
				arg_276_1.var_.actorSpriteComps10108 = var_279_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_2 = 0.125

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.actorSpriteComps10108 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								local var_279_4 = Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor2.r, var_279_3)
								local var_279_5 = Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor2.g, var_279_3)
								local var_279_6 = Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor2.b, var_279_3)

								iter_279_1.color = Color.New(var_279_4, var_279_5, var_279_6)
							else
								local var_279_7 = Mathf.Lerp(iter_279_1.color.r, 0.5, var_279_3)

								iter_279_1.color = Color.New(var_279_7, var_279_7, var_279_7)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10108 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_279_3 then
						if arg_276_1.isInRecall_ then
							iter_279_3.color = arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_279_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10108 = nil
			end

			local var_279_8 = arg_276_1.actors_["1028"]
			local var_279_9 = 0

			if var_279_9 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.actorSpriteComps1028 == nil then
				arg_276_1.var_.actorSpriteComps1028 = var_279_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_10 = 0.125

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_10 and not isNil(var_279_8) then
				local var_279_11 = (arg_276_1.time_ - var_279_9) / var_279_10

				if arg_276_1.var_.actorSpriteComps1028 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								local var_279_12 = Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor1.r, var_279_11)
								local var_279_13 = Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor1.g, var_279_11)
								local var_279_14 = Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor1.b, var_279_11)

								iter_279_5.color = Color.New(var_279_12, var_279_13, var_279_14)
							else
								local var_279_15 = Mathf.Lerp(iter_279_5.color.r, 1, var_279_11)

								iter_279_5.color = Color.New(var_279_15, var_279_15, var_279_15)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_9 + var_279_10 and arg_276_1.time_ < var_279_9 + var_279_10 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.actorSpriteComps1028 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_279_7 then
						if arg_276_1.isInRecall_ then
							iter_279_7.color = arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_279_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps1028 = nil
			end

			local var_279_16 = 0
			local var_279_17 = 0.525

			if var_279_16 < arg_276_1.time_ and arg_276_1.time_ <= var_279_16 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_18 = arg_276_1:FormatText(StoryNameCfg[327].name)

				arg_276_1.leftNameTxt_.text = var_279_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_19 = arg_276_1:GetWordFromCfg(416042064)
				local var_279_20 = arg_276_1:FormatText(var_279_19.content)

				arg_276_1.text_.text = var_279_20

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_21 = 21
				local var_279_22 = utf8.len(var_279_20)
				local var_279_23 = var_279_21 <= 0 and var_279_17 or var_279_17 * (var_279_22 / var_279_21)

				if var_279_23 > 0 and var_279_17 < var_279_23 then
					arg_276_1.talkMaxDuration = var_279_23

					if var_279_23 + var_279_16 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_16
					end
				end

				arg_276_1.text_.text = var_279_20
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042064", "story_v_out_416042.awb") ~= 0 then
					local var_279_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042064", "story_v_out_416042.awb") / 1000

					if var_279_24 + var_279_16 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_24 + var_279_16
					end

					if var_279_19.prefab_name ~= "" and arg_276_1.actors_[var_279_19.prefab_name] ~= nil then
						local var_279_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_19.prefab_name].transform, "story_v_out_416042", "416042064", "story_v_out_416042.awb")

						arg_276_1:RecordAudio("416042064", var_279_25)
						arg_276_1:RecordAudio("416042064", var_279_25)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_416042", "416042064", "story_v_out_416042.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_416042", "416042064", "story_v_out_416042.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_26 = math.max(var_279_17, arg_276_1.talkMaxDuration)

			if var_279_16 <= arg_276_1.time_ and arg_276_1.time_ < var_279_16 + var_279_26 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_16) / var_279_26

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_16 + var_279_26 and arg_276_1.time_ < var_279_16 + var_279_26 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play416042065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 416042065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play416042066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1028"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos1028 = var_283_0.localPosition
				var_283_0.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("1028", 7)

				local var_283_2 = var_283_0.childCount

				for iter_283_0 = 0, var_283_2 - 1 do
					local var_283_3 = var_283_0:GetChild(iter_283_0)

					if var_283_3.name == "" or not string.find(var_283_3.name, "split") then
						var_283_3.gameObject:SetActive(true)
					else
						var_283_3.gameObject:SetActive(false)
					end
				end
			end

			local var_283_4 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_4 then
				local var_283_5 = (arg_280_1.time_ - var_283_1) / var_283_4
				local var_283_6 = Vector3.New(0, -2000, 0)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1028, var_283_6, var_283_5)
			end

			if arg_280_1.time_ >= var_283_1 + var_283_4 and arg_280_1.time_ < var_283_1 + var_283_4 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_283_7 = arg_280_1.actors_["10108"].transform
			local var_283_8 = 0

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.var_.moveOldPos10108 = var_283_7.localPosition
				var_283_7.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10108", 7)

				local var_283_9 = var_283_7.childCount

				for iter_283_1 = 0, var_283_9 - 1 do
					local var_283_10 = var_283_7:GetChild(iter_283_1)

					if var_283_10.name == "" or not string.find(var_283_10.name, "split") then
						var_283_10.gameObject:SetActive(true)
					else
						var_283_10.gameObject:SetActive(false)
					end
				end
			end

			local var_283_11 = 0.001

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_11 then
				local var_283_12 = (arg_280_1.time_ - var_283_8) / var_283_11
				local var_283_13 = Vector3.New(0, -2000, 0)

				var_283_7.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10108, var_283_13, var_283_12)
			end

			if arg_280_1.time_ >= var_283_8 + var_283_11 and arg_280_1.time_ < var_283_8 + var_283_11 + arg_283_0 then
				var_283_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_283_14 = 0
			local var_283_15 = 1.85

			if var_283_14 < arg_280_1.time_ and arg_280_1.time_ <= var_283_14 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_16 = arg_280_1:GetWordFromCfg(416042065)
				local var_283_17 = arg_280_1:FormatText(var_283_16.content)

				arg_280_1.text_.text = var_283_17

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_18 = 74
				local var_283_19 = utf8.len(var_283_17)
				local var_283_20 = var_283_18 <= 0 and var_283_15 or var_283_15 * (var_283_19 / var_283_18)

				if var_283_20 > 0 and var_283_15 < var_283_20 then
					arg_280_1.talkMaxDuration = var_283_20

					if var_283_20 + var_283_14 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_20 + var_283_14
					end
				end

				arg_280_1.text_.text = var_283_17
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_21 = math.max(var_283_15, arg_280_1.talkMaxDuration)

			if var_283_14 <= arg_280_1.time_ and arg_280_1.time_ < var_283_14 + var_283_21 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_14) / var_283_21

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_14 + var_283_21 and arg_280_1.time_ < var_283_14 + var_283_21 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play416042066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 416042066
		arg_284_1.duration_ = 11.63

		local var_284_0 = {
			zh = 6.1,
			ja = 11.633
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play416042067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = "1086"

			if arg_284_1.actors_[var_287_0] == nil then
				local var_287_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_287_1) then
					local var_287_2 = Object.Instantiate(var_287_1, arg_284_1.canvasGo_.transform)

					var_287_2.transform:SetSiblingIndex(1)

					var_287_2.name = var_287_0
					var_287_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_284_1.actors_[var_287_0] = var_287_2

					local var_287_3 = var_287_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_284_1.isInRecall_ then
						for iter_287_0, iter_287_1 in ipairs(var_287_3) do
							iter_287_1.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_287_4 = arg_284_1.actors_["1086"].transform
			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.var_.moveOldPos1086 = var_287_4.localPosition
				var_287_4.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1086", 3)

				local var_287_6 = var_287_4.childCount

				for iter_287_2 = 0, var_287_6 - 1 do
					local var_287_7 = var_287_4:GetChild(iter_287_2)

					if var_287_7.name == "split_1" or not string.find(var_287_7.name, "split") then
						var_287_7.gameObject:SetActive(true)
					else
						var_287_7.gameObject:SetActive(false)
					end
				end
			end

			local var_287_8 = 0.001

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_8 then
				local var_287_9 = (arg_284_1.time_ - var_287_5) / var_287_8
				local var_287_10 = Vector3.New(0, -404.2, -237.9)

				var_287_4.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1086, var_287_10, var_287_9)
			end

			if arg_284_1.time_ >= var_287_5 + var_287_8 and arg_284_1.time_ < var_287_5 + var_287_8 + arg_287_0 then
				var_287_4.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_287_11 = arg_284_1.actors_["1086"]
			local var_287_12 = 0

			if var_287_12 < arg_284_1.time_ and arg_284_1.time_ <= var_287_12 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.actorSpriteComps1086 == nil then
				arg_284_1.var_.actorSpriteComps1086 = var_287_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_13 = 0.125

			if var_287_12 <= arg_284_1.time_ and arg_284_1.time_ < var_287_12 + var_287_13 and not isNil(var_287_11) then
				local var_287_14 = (arg_284_1.time_ - var_287_12) / var_287_13

				if arg_284_1.var_.actorSpriteComps1086 then
					for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_287_4 then
							if arg_284_1.isInRecall_ then
								local var_287_15 = Mathf.Lerp(iter_287_4.color.r, arg_284_1.hightColor1.r, var_287_14)
								local var_287_16 = Mathf.Lerp(iter_287_4.color.g, arg_284_1.hightColor1.g, var_287_14)
								local var_287_17 = Mathf.Lerp(iter_287_4.color.b, arg_284_1.hightColor1.b, var_287_14)

								iter_287_4.color = Color.New(var_287_15, var_287_16, var_287_17)
							else
								local var_287_18 = Mathf.Lerp(iter_287_4.color.r, 1, var_287_14)

								iter_287_4.color = Color.New(var_287_18, var_287_18, var_287_18)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_12 + var_287_13 and arg_284_1.time_ < var_287_12 + var_287_13 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.actorSpriteComps1086 then
				for iter_287_5, iter_287_6 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_287_6 then
						if arg_284_1.isInRecall_ then
							iter_287_6.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps1086 = nil
			end

			local var_287_19 = 0
			local var_287_20 = 0.525

			if var_287_19 < arg_284_1.time_ and arg_284_1.time_ <= var_287_19 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_21 = arg_284_1:FormatText(StoryNameCfg[1080].name)

				arg_284_1.leftNameTxt_.text = var_287_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_22 = arg_284_1:GetWordFromCfg(416042066)
				local var_287_23 = arg_284_1:FormatText(var_287_22.content)

				arg_284_1.text_.text = var_287_23

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_24 = 21
				local var_287_25 = utf8.len(var_287_23)
				local var_287_26 = var_287_24 <= 0 and var_287_20 or var_287_20 * (var_287_25 / var_287_24)

				if var_287_26 > 0 and var_287_20 < var_287_26 then
					arg_284_1.talkMaxDuration = var_287_26

					if var_287_26 + var_287_19 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_26 + var_287_19
					end
				end

				arg_284_1.text_.text = var_287_23
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042066", "story_v_out_416042.awb") ~= 0 then
					local var_287_27 = manager.audio:GetVoiceLength("story_v_out_416042", "416042066", "story_v_out_416042.awb") / 1000

					if var_287_27 + var_287_19 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_27 + var_287_19
					end

					if var_287_22.prefab_name ~= "" and arg_284_1.actors_[var_287_22.prefab_name] ~= nil then
						local var_287_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_22.prefab_name].transform, "story_v_out_416042", "416042066", "story_v_out_416042.awb")

						arg_284_1:RecordAudio("416042066", var_287_28)
						arg_284_1:RecordAudio("416042066", var_287_28)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_416042", "416042066", "story_v_out_416042.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_416042", "416042066", "story_v_out_416042.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_29 = math.max(var_287_20, arg_284_1.talkMaxDuration)

			if var_287_19 <= arg_284_1.time_ and arg_284_1.time_ < var_287_19 + var_287_29 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_19) / var_287_29

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_19 + var_287_29 and arg_284_1.time_ < var_287_19 + var_287_29 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play416042067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 416042067
		arg_288_1.duration_ = 4.6

		local var_288_0 = {
			zh = 2.566,
			ja = 4.6
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play416042068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1086"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1086 == nil then
				arg_288_1.var_.actorSpriteComps1086 = var_291_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_2 = 0.125

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.actorSpriteComps1086 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								local var_291_4 = Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, var_291_3)
								local var_291_5 = Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, var_291_3)
								local var_291_6 = Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, var_291_3)

								iter_291_1.color = Color.New(var_291_4, var_291_5, var_291_6)
							else
								local var_291_7 = Mathf.Lerp(iter_291_1.color.r, 0.5, var_291_3)

								iter_291_1.color = Color.New(var_291_7, var_291_7, var_291_7)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1086 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_291_3 then
						if arg_288_1.isInRecall_ then
							iter_291_3.color = arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_291_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps1086 = nil
			end

			local var_291_8 = 0
			local var_291_9 = 0.325

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_10 = arg_288_1:FormatText(StoryNameCfg[1081].name)

				arg_288_1.leftNameTxt_.text = var_291_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10121")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_11 = arg_288_1:GetWordFromCfg(416042067)
				local var_291_12 = arg_288_1:FormatText(var_291_11.content)

				arg_288_1.text_.text = var_291_12

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 13
				local var_291_14 = utf8.len(var_291_12)
				local var_291_15 = var_291_13 <= 0 and var_291_9 or var_291_9 * (var_291_14 / var_291_13)

				if var_291_15 > 0 and var_291_9 < var_291_15 then
					arg_288_1.talkMaxDuration = var_291_15

					if var_291_15 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_15 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_12
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042067", "story_v_out_416042.awb") ~= 0 then
					local var_291_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042067", "story_v_out_416042.awb") / 1000

					if var_291_16 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_16 + var_291_8
					end

					if var_291_11.prefab_name ~= "" and arg_288_1.actors_[var_291_11.prefab_name] ~= nil then
						local var_291_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_11.prefab_name].transform, "story_v_out_416042", "416042067", "story_v_out_416042.awb")

						arg_288_1:RecordAudio("416042067", var_291_17)
						arg_288_1:RecordAudio("416042067", var_291_17)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_416042", "416042067", "story_v_out_416042.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_416042", "416042067", "story_v_out_416042.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_18 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_18 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_18

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_18 and arg_288_1.time_ < var_291_8 + var_291_18 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play416042068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 416042068
		arg_292_1.duration_ = 5.23

		local var_292_0 = {
			zh = 3.033,
			ja = 5.233
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play416042069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1086"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1086 == nil then
				arg_292_1.var_.actorSpriteComps1086 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.125

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps1086 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								local var_295_4 = Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, var_295_3)
								local var_295_5 = Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, var_295_3)
								local var_295_6 = Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, var_295_3)

								iter_295_1.color = Color.New(var_295_4, var_295_5, var_295_6)
							else
								local var_295_7 = Mathf.Lerp(iter_295_1.color.r, 1, var_295_3)

								iter_295_1.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1086 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps1086 = nil
			end

			local var_295_8 = 0
			local var_295_9 = 0.375

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_10 = arg_292_1:FormatText(StoryNameCfg[1080].name)

				arg_292_1.leftNameTxt_.text = var_295_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_11 = arg_292_1:GetWordFromCfg(416042068)
				local var_295_12 = arg_292_1:FormatText(var_295_11.content)

				arg_292_1.text_.text = var_295_12

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_13 = 15
				local var_295_14 = utf8.len(var_295_12)
				local var_295_15 = var_295_13 <= 0 and var_295_9 or var_295_9 * (var_295_14 / var_295_13)

				if var_295_15 > 0 and var_295_9 < var_295_15 then
					arg_292_1.talkMaxDuration = var_295_15

					if var_295_15 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_15 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_12
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042068", "story_v_out_416042.awb") ~= 0 then
					local var_295_16 = manager.audio:GetVoiceLength("story_v_out_416042", "416042068", "story_v_out_416042.awb") / 1000

					if var_295_16 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_16 + var_295_8
					end

					if var_295_11.prefab_name ~= "" and arg_292_1.actors_[var_295_11.prefab_name] ~= nil then
						local var_295_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_11.prefab_name].transform, "story_v_out_416042", "416042068", "story_v_out_416042.awb")

						arg_292_1:RecordAudio("416042068", var_295_17)
						arg_292_1:RecordAudio("416042068", var_295_17)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_416042", "416042068", "story_v_out_416042.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_416042", "416042068", "story_v_out_416042.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_18 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_18 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_8) / var_295_18

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_8 + var_295_18 and arg_292_1.time_ < var_295_8 + var_295_18 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play416042069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 416042069
		arg_296_1.duration_ = 7.27

		local var_296_0 = {
			zh = 5.533,
			ja = 7.266
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play416042070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.675

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[1080].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:GetWordFromCfg(416042069)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 27
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042069", "story_v_out_416042.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042069", "story_v_out_416042.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_out_416042", "416042069", "story_v_out_416042.awb")

						arg_296_1:RecordAudio("416042069", var_299_9)
						arg_296_1:RecordAudio("416042069", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_416042", "416042069", "story_v_out_416042.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_416042", "416042069", "story_v_out_416042.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play416042070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 416042070
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play416042071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1086"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1086 = var_303_0.localPosition
				var_303_0.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("1086", 7)

				local var_303_2 = var_303_0.childCount

				for iter_303_0 = 0, var_303_2 - 1 do
					local var_303_3 = var_303_0:GetChild(iter_303_0)

					if var_303_3.name == "" or not string.find(var_303_3.name, "split") then
						var_303_3.gameObject:SetActive(true)
					else
						var_303_3.gameObject:SetActive(false)
					end
				end
			end

			local var_303_4 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_4 then
				local var_303_5 = (arg_300_1.time_ - var_303_1) / var_303_4
				local var_303_6 = Vector3.New(0, -2000, 0)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1086, var_303_6, var_303_5)
			end

			if arg_300_1.time_ >= var_303_1 + var_303_4 and arg_300_1.time_ < var_303_1 + var_303_4 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_303_7 = 0
			local var_303_8 = 1.475

			if var_303_7 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_9 = arg_300_1:GetWordFromCfg(416042070)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 59
				local var_303_12 = utf8.len(var_303_10)
				local var_303_13 = var_303_11 <= 0 and var_303_8 or var_303_8 * (var_303_12 / var_303_11)

				if var_303_13 > 0 and var_303_8 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_7 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_7
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_8, arg_300_1.talkMaxDuration)

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_7) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_7 + var_303_14 and arg_300_1.time_ < var_303_7 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play416042071 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 416042071
		arg_304_1.duration_ = 5.53

		local var_304_0 = {
			zh = 3.466,
			ja = 5.533
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play416042072(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1086"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1086 = var_307_0.localPosition
				var_307_0.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1086", 3)

				local var_307_2 = var_307_0.childCount

				for iter_307_0 = 0, var_307_2 - 1 do
					local var_307_3 = var_307_0:GetChild(iter_307_0)

					if var_307_3.name == "split_2" or not string.find(var_307_3.name, "split") then
						var_307_3.gameObject:SetActive(true)
					else
						var_307_3.gameObject:SetActive(false)
					end
				end
			end

			local var_307_4 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_4 then
				local var_307_5 = (arg_304_1.time_ - var_307_1) / var_307_4
				local var_307_6 = Vector3.New(0, -404.2, -237.9)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1086, var_307_6, var_307_5)
			end

			if arg_304_1.time_ >= var_307_1 + var_307_4 and arg_304_1.time_ < var_307_1 + var_307_4 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_307_7 = arg_304_1.actors_["1086"]
			local var_307_8 = 0

			if var_307_8 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.actorSpriteComps1086 == nil then
				arg_304_1.var_.actorSpriteComps1086 = var_307_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_9 = 0.125

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_9 and not isNil(var_307_7) then
				local var_307_10 = (arg_304_1.time_ - var_307_8) / var_307_9

				if arg_304_1.var_.actorSpriteComps1086 then
					for iter_307_1, iter_307_2 in pairs(arg_304_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_307_2 then
							if arg_304_1.isInRecall_ then
								local var_307_11 = Mathf.Lerp(iter_307_2.color.r, arg_304_1.hightColor1.r, var_307_10)
								local var_307_12 = Mathf.Lerp(iter_307_2.color.g, arg_304_1.hightColor1.g, var_307_10)
								local var_307_13 = Mathf.Lerp(iter_307_2.color.b, arg_304_1.hightColor1.b, var_307_10)

								iter_307_2.color = Color.New(var_307_11, var_307_12, var_307_13)
							else
								local var_307_14 = Mathf.Lerp(iter_307_2.color.r, 1, var_307_10)

								iter_307_2.color = Color.New(var_307_14, var_307_14, var_307_14)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= var_307_8 + var_307_9 and arg_304_1.time_ < var_307_8 + var_307_9 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.actorSpriteComps1086 then
				for iter_307_3, iter_307_4 in pairs(arg_304_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_307_4 then
						if arg_304_1.isInRecall_ then
							iter_307_4.color = arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_307_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_304_1.var_.actorSpriteComps1086 = nil
			end

			local var_307_15 = 0
			local var_307_16 = 0.4

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_17 = arg_304_1:FormatText(StoryNameCfg[1080].name)

				arg_304_1.leftNameTxt_.text = var_307_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(416042071)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 16
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_16 or var_307_16 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_16 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042071", "story_v_out_416042.awb") ~= 0 then
					local var_307_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042071", "story_v_out_416042.awb") / 1000

					if var_307_23 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_23 + var_307_15
					end

					if var_307_18.prefab_name ~= "" and arg_304_1.actors_[var_307_18.prefab_name] ~= nil then
						local var_307_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_18.prefab_name].transform, "story_v_out_416042", "416042071", "story_v_out_416042.awb")

						arg_304_1:RecordAudio("416042071", var_307_24)
						arg_304_1:RecordAudio("416042071", var_307_24)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_416042", "416042071", "story_v_out_416042.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_416042", "416042071", "story_v_out_416042.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_25 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_25 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_15) / var_307_25

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_15 + var_307_25 and arg_304_1.time_ < var_307_15 + var_307_25 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play416042072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 416042072
		arg_308_1.duration_ = 6.93

		local var_308_0 = {
			zh = 5.466,
			ja = 6.933
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play416042073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1086"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1086 = var_311_0.localPosition
				var_311_0.localScale = Vector3.New(1, 1, 1)

				local var_311_2 = var_311_0.childCount

				for iter_311_0 = 0, var_311_2 - 1 do
					local var_311_3 = var_311_0:GetChild(iter_311_0)

					if var_311_3.name == "split_2" or not string.find(var_311_3.name, "split") then
						var_311_3.gameObject:SetActive(true)
					else
						var_311_3.gameObject:SetActive(false)
					end
				end
			end

			local var_311_4 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_4 then
				local var_311_5 = (arg_308_1.time_ - var_311_1) / var_311_4
				local var_311_6 = Vector3.New(-390, -398.8, -250.2)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1086, var_311_6, var_311_5)
			end

			if arg_308_1.time_ >= var_311_1 + var_311_4 and arg_308_1.time_ < var_311_1 + var_311_4 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(-390, -398.8, -250.2)
			end

			local var_311_7 = arg_308_1.actors_["1086"]
			local var_311_8 = 0

			if var_311_8 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 and not isNil(var_311_7) and arg_308_1.var_.actorSpriteComps1086 == nil then
				arg_308_1.var_.actorSpriteComps1086 = var_311_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_9 = 0.125

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_9 and not isNil(var_311_7) then
				local var_311_10 = (arg_308_1.time_ - var_311_8) / var_311_9

				if arg_308_1.var_.actorSpriteComps1086 then
					for iter_311_1, iter_311_2 in pairs(arg_308_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_311_2 then
							if arg_308_1.isInRecall_ then
								local var_311_11 = Mathf.Lerp(iter_311_2.color.r, arg_308_1.hightColor2.r, var_311_10)
								local var_311_12 = Mathf.Lerp(iter_311_2.color.g, arg_308_1.hightColor2.g, var_311_10)
								local var_311_13 = Mathf.Lerp(iter_311_2.color.b, arg_308_1.hightColor2.b, var_311_10)

								iter_311_2.color = Color.New(var_311_11, var_311_12, var_311_13)
							else
								local var_311_14 = Mathf.Lerp(iter_311_2.color.r, 0.5, var_311_10)

								iter_311_2.color = Color.New(var_311_14, var_311_14, var_311_14)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_8 + var_311_9 and arg_308_1.time_ < var_311_8 + var_311_9 + arg_311_0 and not isNil(var_311_7) and arg_308_1.var_.actorSpriteComps1086 then
				for iter_311_3, iter_311_4 in pairs(arg_308_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_311_4 then
						if arg_308_1.isInRecall_ then
							iter_311_4.color = arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_311_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps1086 = nil
			end

			local var_311_15 = arg_308_1.actors_["1028"]
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.actorSpriteComps1028 == nil then
				arg_308_1.var_.actorSpriteComps1028 = var_311_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_17 = 0.125

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 and not isNil(var_311_15) then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17

				if arg_308_1.var_.actorSpriteComps1028 then
					for iter_311_5, iter_311_6 in pairs(arg_308_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_311_6 then
							if arg_308_1.isInRecall_ then
								local var_311_19 = Mathf.Lerp(iter_311_6.color.r, arg_308_1.hightColor1.r, var_311_18)
								local var_311_20 = Mathf.Lerp(iter_311_6.color.g, arg_308_1.hightColor1.g, var_311_18)
								local var_311_21 = Mathf.Lerp(iter_311_6.color.b, arg_308_1.hightColor1.b, var_311_18)

								iter_311_6.color = Color.New(var_311_19, var_311_20, var_311_21)
							else
								local var_311_22 = Mathf.Lerp(iter_311_6.color.r, 1, var_311_18)

								iter_311_6.color = Color.New(var_311_22, var_311_22, var_311_22)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.actorSpriteComps1028 then
				for iter_311_7, iter_311_8 in pairs(arg_308_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_311_8 then
						if arg_308_1.isInRecall_ then
							iter_311_8.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps1028 = nil
			end

			local var_311_23 = arg_308_1.actors_["1028"].transform
			local var_311_24 = 0

			if var_311_24 < arg_308_1.time_ and arg_308_1.time_ <= var_311_24 + arg_311_0 then
				arg_308_1.var_.moveOldPos1028 = var_311_23.localPosition
				var_311_23.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1028", 4)

				local var_311_25 = var_311_23.childCount

				for iter_311_9 = 0, var_311_25 - 1 do
					local var_311_26 = var_311_23:GetChild(iter_311_9)

					if var_311_26.name == "" or not string.find(var_311_26.name, "split") then
						var_311_26.gameObject:SetActive(true)
					else
						var_311_26.gameObject:SetActive(false)
					end
				end
			end

			local var_311_27 = 0.001

			if var_311_24 <= arg_308_1.time_ and arg_308_1.time_ < var_311_24 + var_311_27 then
				local var_311_28 = (arg_308_1.time_ - var_311_24) / var_311_27
				local var_311_29 = Vector3.New(390, -402.7, -156.1)

				var_311_23.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1028, var_311_29, var_311_28)
			end

			if arg_308_1.time_ >= var_311_24 + var_311_27 and arg_308_1.time_ < var_311_24 + var_311_27 + arg_311_0 then
				var_311_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_311_30 = 0
			local var_311_31 = 0.6

			if var_311_30 < arg_308_1.time_ and arg_308_1.time_ <= var_311_30 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_32 = arg_308_1:FormatText(StoryNameCfg[327].name)

				arg_308_1.leftNameTxt_.text = var_311_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_33 = arg_308_1:GetWordFromCfg(416042072)
				local var_311_34 = arg_308_1:FormatText(var_311_33.content)

				arg_308_1.text_.text = var_311_34

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_35 = 24
				local var_311_36 = utf8.len(var_311_34)
				local var_311_37 = var_311_35 <= 0 and var_311_31 or var_311_31 * (var_311_36 / var_311_35)

				if var_311_37 > 0 and var_311_31 < var_311_37 then
					arg_308_1.talkMaxDuration = var_311_37

					if var_311_37 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_37 + var_311_30
					end
				end

				arg_308_1.text_.text = var_311_34
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042072", "story_v_out_416042.awb") ~= 0 then
					local var_311_38 = manager.audio:GetVoiceLength("story_v_out_416042", "416042072", "story_v_out_416042.awb") / 1000

					if var_311_38 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_38 + var_311_30
					end

					if var_311_33.prefab_name ~= "" and arg_308_1.actors_[var_311_33.prefab_name] ~= nil then
						local var_311_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_33.prefab_name].transform, "story_v_out_416042", "416042072", "story_v_out_416042.awb")

						arg_308_1:RecordAudio("416042072", var_311_39)
						arg_308_1:RecordAudio("416042072", var_311_39)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_416042", "416042072", "story_v_out_416042.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_416042", "416042072", "story_v_out_416042.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_40 = math.max(var_311_31, arg_308_1.talkMaxDuration)

			if var_311_30 <= arg_308_1.time_ and arg_308_1.time_ < var_311_30 + var_311_40 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_30) / var_311_40

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_30 + var_311_40 and arg_308_1.time_ < var_311_30 + var_311_40 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play416042073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 416042073
		arg_312_1.duration_ = 10.57

		local var_312_0 = {
			zh = 4.066,
			ja = 10.566
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play416042074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1028"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1028 == nil then
				arg_312_1.var_.actorSpriteComps1028 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.125

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1028 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 0.5, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1028 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1028 = nil
			end

			local var_315_8 = arg_312_1.actors_["1086"]
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps1086 == nil then
				arg_312_1.var_.actorSpriteComps1086 = var_315_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_10 = 0.125

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_10 and not isNil(var_315_8) then
				local var_315_11 = (arg_312_1.time_ - var_315_9) / var_315_10

				if arg_312_1.var_.actorSpriteComps1086 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								local var_315_12 = Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor1.r, var_315_11)
								local var_315_13 = Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor1.g, var_315_11)
								local var_315_14 = Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor1.b, var_315_11)

								iter_315_5.color = Color.New(var_315_12, var_315_13, var_315_14)
							else
								local var_315_15 = Mathf.Lerp(iter_315_5.color.r, 1, var_315_11)

								iter_315_5.color = Color.New(var_315_15, var_315_15, var_315_15)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_9 + var_315_10 and arg_312_1.time_ < var_315_9 + var_315_10 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps1086 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_315_7 then
						if arg_312_1.isInRecall_ then
							iter_315_7.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1086 = nil
			end

			local var_315_16 = 0
			local var_315_17 = 0.525

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_18 = arg_312_1:FormatText(StoryNameCfg[1080].name)

				arg_312_1.leftNameTxt_.text = var_315_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_19 = arg_312_1:GetWordFromCfg(416042073)
				local var_315_20 = arg_312_1:FormatText(var_315_19.content)

				arg_312_1.text_.text = var_315_20

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_21 = 21
				local var_315_22 = utf8.len(var_315_20)
				local var_315_23 = var_315_21 <= 0 and var_315_17 or var_315_17 * (var_315_22 / var_315_21)

				if var_315_23 > 0 and var_315_17 < var_315_23 then
					arg_312_1.talkMaxDuration = var_315_23

					if var_315_23 + var_315_16 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_16
					end
				end

				arg_312_1.text_.text = var_315_20
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042073", "story_v_out_416042.awb") ~= 0 then
					local var_315_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042073", "story_v_out_416042.awb") / 1000

					if var_315_24 + var_315_16 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_24 + var_315_16
					end

					if var_315_19.prefab_name ~= "" and arg_312_1.actors_[var_315_19.prefab_name] ~= nil then
						local var_315_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_19.prefab_name].transform, "story_v_out_416042", "416042073", "story_v_out_416042.awb")

						arg_312_1:RecordAudio("416042073", var_315_25)
						arg_312_1:RecordAudio("416042073", var_315_25)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_416042", "416042073", "story_v_out_416042.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_416042", "416042073", "story_v_out_416042.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_26 = math.max(var_315_17, arg_312_1.talkMaxDuration)

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_26 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_16) / var_315_26

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_16 + var_315_26 and arg_312_1.time_ < var_315_16 + var_315_26 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play416042074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 416042074
		arg_316_1.duration_ = 11.57

		local var_316_0 = {
			zh = 7.6,
			ja = 11.566
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play416042075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1028"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1028 == nil then
				arg_316_1.var_.actorSpriteComps1028 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.125

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps1028 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 1, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1028 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1028 = nil
			end

			local var_319_8 = arg_316_1.actors_["1086"]
			local var_319_9 = 0

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps1086 == nil then
				arg_316_1.var_.actorSpriteComps1086 = var_319_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_10 = 0.125

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_10 and not isNil(var_319_8) then
				local var_319_11 = (arg_316_1.time_ - var_319_9) / var_319_10

				if arg_316_1.var_.actorSpriteComps1086 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								local var_319_12 = Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor2.r, var_319_11)
								local var_319_13 = Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor2.g, var_319_11)
								local var_319_14 = Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor2.b, var_319_11)

								iter_319_5.color = Color.New(var_319_12, var_319_13, var_319_14)
							else
								local var_319_15 = Mathf.Lerp(iter_319_5.color.r, 0.5, var_319_11)

								iter_319_5.color = Color.New(var_319_15, var_319_15, var_319_15)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_9 + var_319_10 and arg_316_1.time_ < var_319_9 + var_319_10 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps1086 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_319_7 then
						if arg_316_1.isInRecall_ then
							iter_319_7.color = arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_319_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1086 = nil
			end

			local var_319_16 = 0
			local var_319_17 = 0.8

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_18 = arg_316_1:FormatText(StoryNameCfg[327].name)

				arg_316_1.leftNameTxt_.text = var_319_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_19 = arg_316_1:GetWordFromCfg(416042074)
				local var_319_20 = arg_316_1:FormatText(var_319_19.content)

				arg_316_1.text_.text = var_319_20

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_21 = 32
				local var_319_22 = utf8.len(var_319_20)
				local var_319_23 = var_319_21 <= 0 and var_319_17 or var_319_17 * (var_319_22 / var_319_21)

				if var_319_23 > 0 and var_319_17 < var_319_23 then
					arg_316_1.talkMaxDuration = var_319_23

					if var_319_23 + var_319_16 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_16
					end
				end

				arg_316_1.text_.text = var_319_20
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042074", "story_v_out_416042.awb") ~= 0 then
					local var_319_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042074", "story_v_out_416042.awb") / 1000

					if var_319_24 + var_319_16 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_24 + var_319_16
					end

					if var_319_19.prefab_name ~= "" and arg_316_1.actors_[var_319_19.prefab_name] ~= nil then
						local var_319_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_19.prefab_name].transform, "story_v_out_416042", "416042074", "story_v_out_416042.awb")

						arg_316_1:RecordAudio("416042074", var_319_25)
						arg_316_1:RecordAudio("416042074", var_319_25)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_416042", "416042074", "story_v_out_416042.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_416042", "416042074", "story_v_out_416042.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_26 = math.max(var_319_17, arg_316_1.talkMaxDuration)

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_26 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_16) / var_319_26

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_16 + var_319_26 and arg_316_1.time_ < var_319_16 + var_319_26 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play416042075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 416042075
		arg_320_1.duration_ = 10.8

		local var_320_0 = {
			zh = 6.4,
			ja = 10.8
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play416042076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10108"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos10108 = var_323_0.localPosition
				var_323_0.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10108", 3)

				local var_323_2 = var_323_0.childCount

				for iter_323_0 = 0, var_323_2 - 1 do
					local var_323_3 = var_323_0:GetChild(iter_323_0)

					if var_323_3.name == "split_2" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_4 then
				local var_323_5 = (arg_320_1.time_ - var_323_1) / var_323_4
				local var_323_6 = Vector3.New(0, -399.6, -130)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10108, var_323_6, var_323_5)
			end

			if arg_320_1.time_ >= var_323_1 + var_323_4 and arg_320_1.time_ < var_323_1 + var_323_4 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_323_7 = arg_320_1.actors_["1028"].transform
			local var_323_8 = 0

			if var_323_8 < arg_320_1.time_ and arg_320_1.time_ <= var_323_8 + arg_323_0 then
				arg_320_1.var_.moveOldPos1028 = var_323_7.localPosition
				var_323_7.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1028", 7)

				local var_323_9 = var_323_7.childCount

				for iter_323_1 = 0, var_323_9 - 1 do
					local var_323_10 = var_323_7:GetChild(iter_323_1)

					if var_323_10.name == "" or not string.find(var_323_10.name, "split") then
						var_323_10.gameObject:SetActive(true)
					else
						var_323_10.gameObject:SetActive(false)
					end
				end
			end

			local var_323_11 = 0.001

			if var_323_8 <= arg_320_1.time_ and arg_320_1.time_ < var_323_8 + var_323_11 then
				local var_323_12 = (arg_320_1.time_ - var_323_8) / var_323_11
				local var_323_13 = Vector3.New(0, -2000, 0)

				var_323_7.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1028, var_323_13, var_323_12)
			end

			if arg_320_1.time_ >= var_323_8 + var_323_11 and arg_320_1.time_ < var_323_8 + var_323_11 + arg_323_0 then
				var_323_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_14 = arg_320_1.actors_["1086"].transform
			local var_323_15 = 0

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.var_.moveOldPos1086 = var_323_14.localPosition
				var_323_14.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1086", 7)

				local var_323_16 = var_323_14.childCount

				for iter_323_2 = 0, var_323_16 - 1 do
					local var_323_17 = var_323_14:GetChild(iter_323_2)

					if var_323_17.name == "" or not string.find(var_323_17.name, "split") then
						var_323_17.gameObject:SetActive(true)
					else
						var_323_17.gameObject:SetActive(false)
					end
				end
			end

			local var_323_18 = 0.001

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_18 then
				local var_323_19 = (arg_320_1.time_ - var_323_15) / var_323_18
				local var_323_20 = Vector3.New(0, -2000, 0)

				var_323_14.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1086, var_323_20, var_323_19)
			end

			if arg_320_1.time_ >= var_323_15 + var_323_18 and arg_320_1.time_ < var_323_15 + var_323_18 + arg_323_0 then
				var_323_14.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_21 = arg_320_1.actors_["10108"]
			local var_323_22 = 0

			if var_323_22 < arg_320_1.time_ and arg_320_1.time_ <= var_323_22 + arg_323_0 and not isNil(var_323_21) and arg_320_1.var_.actorSpriteComps10108 == nil then
				arg_320_1.var_.actorSpriteComps10108 = var_323_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_23 = 0.125

			if var_323_22 <= arg_320_1.time_ and arg_320_1.time_ < var_323_22 + var_323_23 and not isNil(var_323_21) then
				local var_323_24 = (arg_320_1.time_ - var_323_22) / var_323_23

				if arg_320_1.var_.actorSpriteComps10108 then
					for iter_323_3, iter_323_4 in pairs(arg_320_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_323_4 then
							if arg_320_1.isInRecall_ then
								local var_323_25 = Mathf.Lerp(iter_323_4.color.r, arg_320_1.hightColor1.r, var_323_24)
								local var_323_26 = Mathf.Lerp(iter_323_4.color.g, arg_320_1.hightColor1.g, var_323_24)
								local var_323_27 = Mathf.Lerp(iter_323_4.color.b, arg_320_1.hightColor1.b, var_323_24)

								iter_323_4.color = Color.New(var_323_25, var_323_26, var_323_27)
							else
								local var_323_28 = Mathf.Lerp(iter_323_4.color.r, 1, var_323_24)

								iter_323_4.color = Color.New(var_323_28, var_323_28, var_323_28)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_22 + var_323_23 and arg_320_1.time_ < var_323_22 + var_323_23 + arg_323_0 and not isNil(var_323_21) and arg_320_1.var_.actorSpriteComps10108 then
				for iter_323_5, iter_323_6 in pairs(arg_320_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_323_6 then
						if arg_320_1.isInRecall_ then
							iter_323_6.color = arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_323_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps10108 = nil
			end

			local var_323_29 = 0
			local var_323_30 = 0.625

			if var_323_29 < arg_320_1.time_ and arg_320_1.time_ <= var_323_29 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_31 = arg_320_1:FormatText(StoryNameCfg[1083].name)

				arg_320_1.leftNameTxt_.text = var_323_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_32 = arg_320_1:GetWordFromCfg(416042075)
				local var_323_33 = arg_320_1:FormatText(var_323_32.content)

				arg_320_1.text_.text = var_323_33

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_34 = 25
				local var_323_35 = utf8.len(var_323_33)
				local var_323_36 = var_323_34 <= 0 and var_323_30 or var_323_30 * (var_323_35 / var_323_34)

				if var_323_36 > 0 and var_323_30 < var_323_36 then
					arg_320_1.talkMaxDuration = var_323_36

					if var_323_36 + var_323_29 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_36 + var_323_29
					end
				end

				arg_320_1.text_.text = var_323_33
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042075", "story_v_out_416042.awb") ~= 0 then
					local var_323_37 = manager.audio:GetVoiceLength("story_v_out_416042", "416042075", "story_v_out_416042.awb") / 1000

					if var_323_37 + var_323_29 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_37 + var_323_29
					end

					if var_323_32.prefab_name ~= "" and arg_320_1.actors_[var_323_32.prefab_name] ~= nil then
						local var_323_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_32.prefab_name].transform, "story_v_out_416042", "416042075", "story_v_out_416042.awb")

						arg_320_1:RecordAudio("416042075", var_323_38)
						arg_320_1:RecordAudio("416042075", var_323_38)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_416042", "416042075", "story_v_out_416042.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_416042", "416042075", "story_v_out_416042.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_39 = math.max(var_323_30, arg_320_1.talkMaxDuration)

			if var_323_29 <= arg_320_1.time_ and arg_320_1.time_ < var_323_29 + var_323_39 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_29) / var_323_39

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_29 + var_323_39 and arg_320_1.time_ < var_323_29 + var_323_39 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play416042076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 416042076
		arg_324_1.duration_ = 10.1

		local var_324_0 = {
			zh = 8.466,
			ja = 10.1
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play416042077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 4

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.allBtn_.enabled = false
			end

			local var_327_1 = 0.3

			if arg_324_1.time_ >= var_327_0 + var_327_1 and arg_324_1.time_ < var_327_0 + var_327_1 + arg_327_0 then
				arg_324_1.allBtn_.enabled = true
			end

			local var_327_2 = "ST0106"

			if arg_324_1.bgs_[var_327_2] == nil then
				local var_327_3 = Object.Instantiate(arg_324_1.paintGo_)

				var_327_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_327_2)
				var_327_3.name = var_327_2
				var_327_3.transform.parent = arg_324_1.stage_.transform
				var_327_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_324_1.bgs_[var_327_2] = var_327_3
			end

			local var_327_4 = 2

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				local var_327_5 = manager.ui.mainCamera.transform.localPosition
				local var_327_6 = Vector3.New(0, 0, 10) + Vector3.New(var_327_5.x, var_327_5.y, 0)
				local var_327_7 = arg_324_1.bgs_.ST0106

				var_327_7.transform.localPosition = var_327_6
				var_327_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_8 = var_327_7:GetComponent("SpriteRenderer")

				if var_327_8 and var_327_8.sprite then
					local var_327_9 = (var_327_7.transform.localPosition - var_327_5).z
					local var_327_10 = manager.ui.mainCameraCom_
					local var_327_11 = 2 * var_327_9 * Mathf.Tan(var_327_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_327_12 = var_327_11 * var_327_10.aspect
					local var_327_13 = var_327_8.sprite.bounds.size.x
					local var_327_14 = var_327_8.sprite.bounds.size.y
					local var_327_15 = var_327_12 / var_327_13
					local var_327_16 = var_327_11 / var_327_14
					local var_327_17 = var_327_16 < var_327_15 and var_327_15 or var_327_16

					var_327_7.transform.localScale = Vector3.New(var_327_17, var_327_17, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "ST0106" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_18 = 0

			if var_327_18 < arg_324_1.time_ and arg_324_1.time_ <= var_327_18 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_19 = 2

			if var_327_18 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_19 then
				local var_327_20 = (arg_324_1.time_ - var_327_18) / var_327_19
				local var_327_21 = Color.New(0, 0, 0)

				var_327_21.a = Mathf.Lerp(0, 1, var_327_20)
				arg_324_1.mask_.color = var_327_21
			end

			if arg_324_1.time_ >= var_327_18 + var_327_19 and arg_324_1.time_ < var_327_18 + var_327_19 + arg_327_0 then
				local var_327_22 = Color.New(0, 0, 0)

				var_327_22.a = 1
				arg_324_1.mask_.color = var_327_22
			end

			local var_327_23 = 2

			if var_327_23 < arg_324_1.time_ and arg_324_1.time_ <= var_327_23 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_24 = 2

			if var_327_23 <= arg_324_1.time_ and arg_324_1.time_ < var_327_23 + var_327_24 then
				local var_327_25 = (arg_324_1.time_ - var_327_23) / var_327_24
				local var_327_26 = Color.New(0, 0, 0)

				var_327_26.a = Mathf.Lerp(1, 0, var_327_25)
				arg_324_1.mask_.color = var_327_26
			end

			if arg_324_1.time_ >= var_327_23 + var_327_24 and arg_324_1.time_ < var_327_23 + var_327_24 + arg_327_0 then
				local var_327_27 = Color.New(0, 0, 0)
				local var_327_28 = 0

				arg_324_1.mask_.enabled = false
				var_327_27.a = var_327_28
				arg_324_1.mask_.color = var_327_27
			end

			local var_327_29 = arg_324_1.actors_["10108"].transform
			local var_327_30 = 1.966

			if var_327_30 < arg_324_1.time_ and arg_324_1.time_ <= var_327_30 + arg_327_0 then
				arg_324_1.var_.moveOldPos10108 = var_327_29.localPosition
				var_327_29.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("10108", 7)

				local var_327_31 = var_327_29.childCount

				for iter_327_2 = 0, var_327_31 - 1 do
					local var_327_32 = var_327_29:GetChild(iter_327_2)

					if var_327_32.name == "" or not string.find(var_327_32.name, "split") then
						var_327_32.gameObject:SetActive(true)
					else
						var_327_32.gameObject:SetActive(false)
					end
				end
			end

			local var_327_33 = 0.001

			if var_327_30 <= arg_324_1.time_ and arg_324_1.time_ < var_327_30 + var_327_33 then
				local var_327_34 = (arg_324_1.time_ - var_327_30) / var_327_33
				local var_327_35 = Vector3.New(0, -2000, 0)

				var_327_29.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10108, var_327_35, var_327_34)
			end

			if arg_324_1.time_ >= var_327_30 + var_327_33 and arg_324_1.time_ < var_327_30 + var_327_33 + arg_327_0 then
				var_327_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_36 = arg_324_1.actors_["1086"]
			local var_327_37 = 3.63333333333333

			if var_327_37 < arg_324_1.time_ and arg_324_1.time_ <= var_327_37 + arg_327_0 and not isNil(var_327_36) and arg_324_1.var_.actorSpriteComps1086 == nil then
				arg_324_1.var_.actorSpriteComps1086 = var_327_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_38 = 0.125

			if var_327_37 <= arg_324_1.time_ and arg_324_1.time_ < var_327_37 + var_327_38 and not isNil(var_327_36) then
				local var_327_39 = (arg_324_1.time_ - var_327_37) / var_327_38

				if arg_324_1.var_.actorSpriteComps1086 then
					for iter_327_3, iter_327_4 in pairs(arg_324_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_327_4 then
							if arg_324_1.isInRecall_ then
								local var_327_40 = Mathf.Lerp(iter_327_4.color.r, arg_324_1.hightColor1.r, var_327_39)
								local var_327_41 = Mathf.Lerp(iter_327_4.color.g, arg_324_1.hightColor1.g, var_327_39)
								local var_327_42 = Mathf.Lerp(iter_327_4.color.b, arg_324_1.hightColor1.b, var_327_39)

								iter_327_4.color = Color.New(var_327_40, var_327_41, var_327_42)
							else
								local var_327_43 = Mathf.Lerp(iter_327_4.color.r, 1, var_327_39)

								iter_327_4.color = Color.New(var_327_43, var_327_43, var_327_43)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_37 + var_327_38 and arg_324_1.time_ < var_327_37 + var_327_38 + arg_327_0 and not isNil(var_327_36) and arg_324_1.var_.actorSpriteComps1086 then
				for iter_327_5, iter_327_6 in pairs(arg_324_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_327_6 then
						if arg_324_1.isInRecall_ then
							iter_327_6.color = arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_327_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps1086 = nil
			end

			local var_327_44 = arg_324_1.actors_["1086"].transform
			local var_327_45 = 3.63333333333333

			if var_327_45 < arg_324_1.time_ and arg_324_1.time_ <= var_327_45 + arg_327_0 then
				arg_324_1.var_.moveOldPos1086 = var_327_44.localPosition
				var_327_44.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1086", 3)

				local var_327_46 = var_327_44.childCount

				for iter_327_7 = 0, var_327_46 - 1 do
					local var_327_47 = var_327_44:GetChild(iter_327_7)

					if var_327_47.name == "" or not string.find(var_327_47.name, "split") then
						var_327_47.gameObject:SetActive(true)
					else
						var_327_47.gameObject:SetActive(false)
					end
				end
			end

			local var_327_48 = 0.001

			if var_327_45 <= arg_324_1.time_ and arg_324_1.time_ < var_327_45 + var_327_48 then
				local var_327_49 = (arg_324_1.time_ - var_327_45) / var_327_48
				local var_327_50 = Vector3.New(0, -404.2, -237.9)

				var_327_44.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1086, var_327_50, var_327_49)
			end

			if arg_324_1.time_ >= var_327_45 + var_327_48 and arg_324_1.time_ < var_327_45 + var_327_48 + arg_327_0 then
				var_327_44.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_327_51 = arg_324_1.actors_["1086"]
			local var_327_52 = 3.63333333333333

			if var_327_52 < arg_324_1.time_ and arg_324_1.time_ <= var_327_52 + arg_327_0 then
				local var_327_53 = var_327_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_327_53 then
					arg_324_1.var_.alphaOldValue1086 = var_327_53.alpha
					arg_324_1.var_.characterEffect1086 = var_327_53
				end

				arg_324_1.var_.alphaOldValue1086 = 0
			end

			local var_327_54 = 0.466666666666666

			if var_327_52 <= arg_324_1.time_ and arg_324_1.time_ < var_327_52 + var_327_54 then
				local var_327_55 = (arg_324_1.time_ - var_327_52) / var_327_54
				local var_327_56 = Mathf.Lerp(arg_324_1.var_.alphaOldValue1086, 1, var_327_55)

				if arg_324_1.var_.characterEffect1086 then
					arg_324_1.var_.characterEffect1086.alpha = var_327_56
				end
			end

			if arg_324_1.time_ >= var_327_52 + var_327_54 and arg_324_1.time_ < var_327_52 + var_327_54 + arg_327_0 and arg_324_1.var_.characterEffect1086 then
				arg_324_1.var_.characterEffect1086.alpha = 1
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_57 = 4
			local var_327_58 = 0.625

			if var_327_57 < arg_324_1.time_ and arg_324_1.time_ <= var_327_57 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_59 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_59:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_60 = arg_324_1:FormatText(StoryNameCfg[1080].name)

				arg_324_1.leftNameTxt_.text = var_327_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_61 = arg_324_1:GetWordFromCfg(416042076)
				local var_327_62 = arg_324_1:FormatText(var_327_61.content)

				arg_324_1.text_.text = var_327_62

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_63 = 25
				local var_327_64 = utf8.len(var_327_62)
				local var_327_65 = var_327_63 <= 0 and var_327_58 or var_327_58 * (var_327_64 / var_327_63)

				if var_327_65 > 0 and var_327_58 < var_327_65 then
					arg_324_1.talkMaxDuration = var_327_65
					var_327_57 = var_327_57 + 0.3

					if var_327_65 + var_327_57 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_65 + var_327_57
					end
				end

				arg_324_1.text_.text = var_327_62
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042076", "story_v_out_416042.awb") ~= 0 then
					local var_327_66 = manager.audio:GetVoiceLength("story_v_out_416042", "416042076", "story_v_out_416042.awb") / 1000

					if var_327_66 + var_327_57 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_66 + var_327_57
					end

					if var_327_61.prefab_name ~= "" and arg_324_1.actors_[var_327_61.prefab_name] ~= nil then
						local var_327_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_61.prefab_name].transform, "story_v_out_416042", "416042076", "story_v_out_416042.awb")

						arg_324_1:RecordAudio("416042076", var_327_67)
						arg_324_1:RecordAudio("416042076", var_327_67)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_416042", "416042076", "story_v_out_416042.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_416042", "416042076", "story_v_out_416042.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_68 = var_327_57 + 0.3
			local var_327_69 = math.max(var_327_58, arg_324_1.talkMaxDuration)

			if var_327_68 <= arg_324_1.time_ and arg_324_1.time_ < var_327_68 + var_327_69 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_68) / var_327_69

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_68 + var_327_69 and arg_324_1.time_ < var_327_68 + var_327_69 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play416042077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 416042077
		arg_330_1.duration_ = 13.4

		local var_330_0 = {
			zh = 8.1,
			ja = 13.4
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play416042078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1.05

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[1080].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:GetWordFromCfg(416042077)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 42
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042077", "story_v_out_416042.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042077", "story_v_out_416042.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_416042", "416042077", "story_v_out_416042.awb")

						arg_330_1:RecordAudio("416042077", var_333_9)
						arg_330_1:RecordAudio("416042077", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_416042", "416042077", "story_v_out_416042.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_416042", "416042077", "story_v_out_416042.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play416042078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 416042078
		arg_334_1.duration_ = 13.53

		local var_334_0 = {
			zh = 3.9,
			ja = 13.533
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
				arg_334_0:Play416042079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1086"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos1086 = var_337_0.localPosition
				var_337_0.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("1086", 2)

				local var_337_2 = var_337_0.childCount

				for iter_337_0 = 0, var_337_2 - 1 do
					local var_337_3 = var_337_0:GetChild(iter_337_0)

					if var_337_3.name == "" or not string.find(var_337_3.name, "split") then
						var_337_3.gameObject:SetActive(true)
					else
						var_337_3.gameObject:SetActive(false)
					end
				end
			end

			local var_337_4 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_4 then
				local var_337_5 = (arg_334_1.time_ - var_337_1) / var_337_4
				local var_337_6 = Vector3.New(-390, -404.2, -237.9)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1086, var_337_6, var_337_5)
			end

			if arg_334_1.time_ >= var_337_1 + var_337_4 and arg_334_1.time_ < var_337_1 + var_337_4 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_337_7 = arg_334_1.actors_["10108"].transform
			local var_337_8 = 0

			if var_337_8 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.var_.moveOldPos10108 = var_337_7.localPosition
				var_337_7.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10108", 4)

				local var_337_9 = var_337_7.childCount

				for iter_337_1 = 0, var_337_9 - 1 do
					local var_337_10 = var_337_7:GetChild(iter_337_1)

					if var_337_10.name == "split_4" or not string.find(var_337_10.name, "split") then
						var_337_10.gameObject:SetActive(true)
					else
						var_337_10.gameObject:SetActive(false)
					end
				end
			end

			local var_337_11 = 0.001

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_11 then
				local var_337_12 = (arg_334_1.time_ - var_337_8) / var_337_11
				local var_337_13 = Vector3.New(390, -399.6, -130)

				var_337_7.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10108, var_337_13, var_337_12)
			end

			if arg_334_1.time_ >= var_337_8 + var_337_11 and arg_334_1.time_ < var_337_8 + var_337_11 + arg_337_0 then
				var_337_7.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_337_14 = arg_334_1.actors_["10108"]
			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.actorSpriteComps10108 == nil then
				arg_334_1.var_.actorSpriteComps10108 = var_337_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_16 = 0.125

			if var_337_15 <= arg_334_1.time_ and arg_334_1.time_ < var_337_15 + var_337_16 and not isNil(var_337_14) then
				local var_337_17 = (arg_334_1.time_ - var_337_15) / var_337_16

				if arg_334_1.var_.actorSpriteComps10108 then
					for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_337_3 then
							if arg_334_1.isInRecall_ then
								local var_337_18 = Mathf.Lerp(iter_337_3.color.r, arg_334_1.hightColor1.r, var_337_17)
								local var_337_19 = Mathf.Lerp(iter_337_3.color.g, arg_334_1.hightColor1.g, var_337_17)
								local var_337_20 = Mathf.Lerp(iter_337_3.color.b, arg_334_1.hightColor1.b, var_337_17)

								iter_337_3.color = Color.New(var_337_18, var_337_19, var_337_20)
							else
								local var_337_21 = Mathf.Lerp(iter_337_3.color.r, 1, var_337_17)

								iter_337_3.color = Color.New(var_337_21, var_337_21, var_337_21)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_15 + var_337_16 and arg_334_1.time_ < var_337_15 + var_337_16 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.actorSpriteComps10108 then
				for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_337_5 then
						if arg_334_1.isInRecall_ then
							iter_337_5.color = arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_337_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps10108 = nil
			end

			local var_337_22 = arg_334_1.actors_["1086"]
			local var_337_23 = 0

			if var_337_23 < arg_334_1.time_ and arg_334_1.time_ <= var_337_23 + arg_337_0 and not isNil(var_337_22) and arg_334_1.var_.actorSpriteComps1086 == nil then
				arg_334_1.var_.actorSpriteComps1086 = var_337_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_24 = 0.125

			if var_337_23 <= arg_334_1.time_ and arg_334_1.time_ < var_337_23 + var_337_24 and not isNil(var_337_22) then
				local var_337_25 = (arg_334_1.time_ - var_337_23) / var_337_24

				if arg_334_1.var_.actorSpriteComps1086 then
					for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_337_7 then
							if arg_334_1.isInRecall_ then
								local var_337_26 = Mathf.Lerp(iter_337_7.color.r, arg_334_1.hightColor2.r, var_337_25)
								local var_337_27 = Mathf.Lerp(iter_337_7.color.g, arg_334_1.hightColor2.g, var_337_25)
								local var_337_28 = Mathf.Lerp(iter_337_7.color.b, arg_334_1.hightColor2.b, var_337_25)

								iter_337_7.color = Color.New(var_337_26, var_337_27, var_337_28)
							else
								local var_337_29 = Mathf.Lerp(iter_337_7.color.r, 0.5, var_337_25)

								iter_337_7.color = Color.New(var_337_29, var_337_29, var_337_29)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_23 + var_337_24 and arg_334_1.time_ < var_337_23 + var_337_24 + arg_337_0 and not isNil(var_337_22) and arg_334_1.var_.actorSpriteComps1086 then
				for iter_337_8, iter_337_9 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_337_9 then
						if arg_334_1.isInRecall_ then
							iter_337_9.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps1086 = nil
			end

			local var_337_30 = 0
			local var_337_31 = 0.4

			if var_337_30 < arg_334_1.time_ and arg_334_1.time_ <= var_337_30 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_32 = arg_334_1:FormatText(StoryNameCfg[1083].name)

				arg_334_1.leftNameTxt_.text = var_337_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_33 = arg_334_1:GetWordFromCfg(416042078)
				local var_337_34 = arg_334_1:FormatText(var_337_33.content)

				arg_334_1.text_.text = var_337_34

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_35 = 16
				local var_337_36 = utf8.len(var_337_34)
				local var_337_37 = var_337_35 <= 0 and var_337_31 or var_337_31 * (var_337_36 / var_337_35)

				if var_337_37 > 0 and var_337_31 < var_337_37 then
					arg_334_1.talkMaxDuration = var_337_37

					if var_337_37 + var_337_30 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_37 + var_337_30
					end
				end

				arg_334_1.text_.text = var_337_34
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042078", "story_v_out_416042.awb") ~= 0 then
					local var_337_38 = manager.audio:GetVoiceLength("story_v_out_416042", "416042078", "story_v_out_416042.awb") / 1000

					if var_337_38 + var_337_30 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_38 + var_337_30
					end

					if var_337_33.prefab_name ~= "" and arg_334_1.actors_[var_337_33.prefab_name] ~= nil then
						local var_337_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_33.prefab_name].transform, "story_v_out_416042", "416042078", "story_v_out_416042.awb")

						arg_334_1:RecordAudio("416042078", var_337_39)
						arg_334_1:RecordAudio("416042078", var_337_39)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_416042", "416042078", "story_v_out_416042.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_416042", "416042078", "story_v_out_416042.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_40 = math.max(var_337_31, arg_334_1.talkMaxDuration)

			if var_337_30 <= arg_334_1.time_ and arg_334_1.time_ < var_337_30 + var_337_40 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_30) / var_337_40

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_30 + var_337_40 and arg_334_1.time_ < var_337_30 + var_337_40 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play416042079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 416042079
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play416042080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1086"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos1086 = var_341_0.localPosition
				var_341_0.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1086", 7)

				local var_341_2 = var_341_0.childCount

				for iter_341_0 = 0, var_341_2 - 1 do
					local var_341_3 = var_341_0:GetChild(iter_341_0)

					if var_341_3.name == "" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_4 then
				local var_341_5 = (arg_338_1.time_ - var_341_1) / var_341_4
				local var_341_6 = Vector3.New(0, -2000, 0)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1086, var_341_6, var_341_5)
			end

			if arg_338_1.time_ >= var_341_1 + var_341_4 and arg_338_1.time_ < var_341_1 + var_341_4 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_7 = arg_338_1.actors_["10108"].transform
			local var_341_8 = 0

			if var_341_8 < arg_338_1.time_ and arg_338_1.time_ <= var_341_8 + arg_341_0 then
				arg_338_1.var_.moveOldPos10108 = var_341_7.localPosition
				var_341_7.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10108", 7)

				local var_341_9 = var_341_7.childCount

				for iter_341_1 = 0, var_341_9 - 1 do
					local var_341_10 = var_341_7:GetChild(iter_341_1)

					if var_341_10.name == "" or not string.find(var_341_10.name, "split") then
						var_341_10.gameObject:SetActive(true)
					else
						var_341_10.gameObject:SetActive(false)
					end
				end
			end

			local var_341_11 = 0.001

			if var_341_8 <= arg_338_1.time_ and arg_338_1.time_ < var_341_8 + var_341_11 then
				local var_341_12 = (arg_338_1.time_ - var_341_8) / var_341_11
				local var_341_13 = Vector3.New(0, -2000, 0)

				var_341_7.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10108, var_341_13, var_341_12)
			end

			if arg_338_1.time_ >= var_341_8 + var_341_11 and arg_338_1.time_ < var_341_8 + var_341_11 + arg_341_0 then
				var_341_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_14 = 0
			local var_341_15 = 1.575

			if var_341_14 < arg_338_1.time_ and arg_338_1.time_ <= var_341_14 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_16 = arg_338_1:GetWordFromCfg(416042079)
				local var_341_17 = arg_338_1:FormatText(var_341_16.content)

				arg_338_1.text_.text = var_341_17

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_18 = 63
				local var_341_19 = utf8.len(var_341_17)
				local var_341_20 = var_341_18 <= 0 and var_341_15 or var_341_15 * (var_341_19 / var_341_18)

				if var_341_20 > 0 and var_341_15 < var_341_20 then
					arg_338_1.talkMaxDuration = var_341_20

					if var_341_20 + var_341_14 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_20 + var_341_14
					end
				end

				arg_338_1.text_.text = var_341_17
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_21 = math.max(var_341_15, arg_338_1.talkMaxDuration)

			if var_341_14 <= arg_338_1.time_ and arg_338_1.time_ < var_341_14 + var_341_21 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_14) / var_341_21

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_14 + var_341_21 and arg_338_1.time_ < var_341_14 + var_341_21 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play416042080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 416042080
		arg_342_1.duration_ = 7.07

		local var_342_0 = {
			zh = 6,
			ja = 7.066
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play416042081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1086"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1086 = var_345_0.localPosition
				var_345_0.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("1086", 3)

				local var_345_2 = var_345_0.childCount

				for iter_345_0 = 0, var_345_2 - 1 do
					local var_345_3 = var_345_0:GetChild(iter_345_0)

					if var_345_3.name == "split_4" or not string.find(var_345_3.name, "split") then
						var_345_3.gameObject:SetActive(true)
					else
						var_345_3.gameObject:SetActive(false)
					end
				end
			end

			local var_345_4 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_4 then
				local var_345_5 = (arg_342_1.time_ - var_345_1) / var_345_4
				local var_345_6 = Vector3.New(0, -404.2, -237.9)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1086, var_345_6, var_345_5)
			end

			if arg_342_1.time_ >= var_345_1 + var_345_4 and arg_342_1.time_ < var_345_1 + var_345_4 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_345_7 = arg_342_1.actors_["1086"]
			local var_345_8 = 0

			if var_345_8 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 and not isNil(var_345_7) and arg_342_1.var_.actorSpriteComps1086 == nil then
				arg_342_1.var_.actorSpriteComps1086 = var_345_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_9 = 0.125

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_9 and not isNil(var_345_7) then
				local var_345_10 = (arg_342_1.time_ - var_345_8) / var_345_9

				if arg_342_1.var_.actorSpriteComps1086 then
					for iter_345_1, iter_345_2 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_345_2 then
							if arg_342_1.isInRecall_ then
								local var_345_11 = Mathf.Lerp(iter_345_2.color.r, arg_342_1.hightColor1.r, var_345_10)
								local var_345_12 = Mathf.Lerp(iter_345_2.color.g, arg_342_1.hightColor1.g, var_345_10)
								local var_345_13 = Mathf.Lerp(iter_345_2.color.b, arg_342_1.hightColor1.b, var_345_10)

								iter_345_2.color = Color.New(var_345_11, var_345_12, var_345_13)
							else
								local var_345_14 = Mathf.Lerp(iter_345_2.color.r, 1, var_345_10)

								iter_345_2.color = Color.New(var_345_14, var_345_14, var_345_14)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_8 + var_345_9 and arg_342_1.time_ < var_345_8 + var_345_9 + arg_345_0 and not isNil(var_345_7) and arg_342_1.var_.actorSpriteComps1086 then
				for iter_345_3, iter_345_4 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_345_4 then
						if arg_342_1.isInRecall_ then
							iter_345_4.color = arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_345_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps1086 = nil
			end

			local var_345_15 = 0
			local var_345_16 = 0.725

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_17 = arg_342_1:FormatText(StoryNameCfg[1080].name)

				arg_342_1.leftNameTxt_.text = var_345_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_18 = arg_342_1:GetWordFromCfg(416042080)
				local var_345_19 = arg_342_1:FormatText(var_345_18.content)

				arg_342_1.text_.text = var_345_19

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_20 = 29
				local var_345_21 = utf8.len(var_345_19)
				local var_345_22 = var_345_20 <= 0 and var_345_16 or var_345_16 * (var_345_21 / var_345_20)

				if var_345_22 > 0 and var_345_16 < var_345_22 then
					arg_342_1.talkMaxDuration = var_345_22

					if var_345_22 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_22 + var_345_15
					end
				end

				arg_342_1.text_.text = var_345_19
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042080", "story_v_out_416042.awb") ~= 0 then
					local var_345_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042080", "story_v_out_416042.awb") / 1000

					if var_345_23 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_23 + var_345_15
					end

					if var_345_18.prefab_name ~= "" and arg_342_1.actors_[var_345_18.prefab_name] ~= nil then
						local var_345_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_18.prefab_name].transform, "story_v_out_416042", "416042080", "story_v_out_416042.awb")

						arg_342_1:RecordAudio("416042080", var_345_24)
						arg_342_1:RecordAudio("416042080", var_345_24)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_416042", "416042080", "story_v_out_416042.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_416042", "416042080", "story_v_out_416042.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_25 = math.max(var_345_16, arg_342_1.talkMaxDuration)

			if var_345_15 <= arg_342_1.time_ and arg_342_1.time_ < var_345_15 + var_345_25 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_15) / var_345_25

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_15 + var_345_25 and arg_342_1.time_ < var_345_15 + var_345_25 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play416042081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 416042081
		arg_346_1.duration_ = 8.3

		local var_346_0 = {
			zh = 4.266,
			ja = 8.3
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play416042082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1086"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos1086 = var_349_0.localPosition
				var_349_0.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1086", 2)

				local var_349_2 = var_349_0.childCount

				for iter_349_0 = 0, var_349_2 - 1 do
					local var_349_3 = var_349_0:GetChild(iter_349_0)

					if var_349_3.name == "split_4" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_4 then
				local var_349_5 = (arg_346_1.time_ - var_349_1) / var_349_4
				local var_349_6 = Vector3.New(-390, -404.2, -237.9)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1086, var_349_6, var_349_5)
			end

			if arg_346_1.time_ >= var_349_1 + var_349_4 and arg_346_1.time_ < var_349_1 + var_349_4 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_349_7 = arg_346_1.actors_["1086"]
			local var_349_8 = 0

			if var_349_8 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 and not isNil(var_349_7) and arg_346_1.var_.actorSpriteComps1086 == nil then
				arg_346_1.var_.actorSpriteComps1086 = var_349_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_9 = 0.125

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_9 and not isNil(var_349_7) then
				local var_349_10 = (arg_346_1.time_ - var_349_8) / var_349_9

				if arg_346_1.var_.actorSpriteComps1086 then
					for iter_349_1, iter_349_2 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_349_2 then
							if arg_346_1.isInRecall_ then
								local var_349_11 = Mathf.Lerp(iter_349_2.color.r, arg_346_1.hightColor2.r, var_349_10)
								local var_349_12 = Mathf.Lerp(iter_349_2.color.g, arg_346_1.hightColor2.g, var_349_10)
								local var_349_13 = Mathf.Lerp(iter_349_2.color.b, arg_346_1.hightColor2.b, var_349_10)

								iter_349_2.color = Color.New(var_349_11, var_349_12, var_349_13)
							else
								local var_349_14 = Mathf.Lerp(iter_349_2.color.r, 0.5, var_349_10)

								iter_349_2.color = Color.New(var_349_14, var_349_14, var_349_14)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_8 + var_349_9 and arg_346_1.time_ < var_349_8 + var_349_9 + arg_349_0 and not isNil(var_349_7) and arg_346_1.var_.actorSpriteComps1086 then
				for iter_349_3, iter_349_4 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_349_4 then
						if arg_346_1.isInRecall_ then
							iter_349_4.color = arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_349_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps1086 = nil
			end

			local var_349_15 = arg_346_1.actors_["1028"].transform
			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 then
				arg_346_1.var_.moveOldPos1028 = var_349_15.localPosition
				var_349_15.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1028", 4)

				local var_349_17 = var_349_15.childCount

				for iter_349_5 = 0, var_349_17 - 1 do
					local var_349_18 = var_349_15:GetChild(iter_349_5)

					if var_349_18.name == "" or not string.find(var_349_18.name, "split") then
						var_349_18.gameObject:SetActive(true)
					else
						var_349_18.gameObject:SetActive(false)
					end
				end
			end

			local var_349_19 = 0.001

			if var_349_16 <= arg_346_1.time_ and arg_346_1.time_ < var_349_16 + var_349_19 then
				local var_349_20 = (arg_346_1.time_ - var_349_16) / var_349_19
				local var_349_21 = Vector3.New(390, -402.7, -156.1)

				var_349_15.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1028, var_349_21, var_349_20)
			end

			if arg_346_1.time_ >= var_349_16 + var_349_19 and arg_346_1.time_ < var_349_16 + var_349_19 + arg_349_0 then
				var_349_15.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_349_22 = arg_346_1.actors_["1028"]
			local var_349_23 = 0

			if var_349_23 < arg_346_1.time_ and arg_346_1.time_ <= var_349_23 + arg_349_0 and not isNil(var_349_22) and arg_346_1.var_.actorSpriteComps1028 == nil then
				arg_346_1.var_.actorSpriteComps1028 = var_349_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_24 = 0.125

			if var_349_23 <= arg_346_1.time_ and arg_346_1.time_ < var_349_23 + var_349_24 and not isNil(var_349_22) then
				local var_349_25 = (arg_346_1.time_ - var_349_23) / var_349_24

				if arg_346_1.var_.actorSpriteComps1028 then
					for iter_349_6, iter_349_7 in pairs(arg_346_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_349_7 then
							if arg_346_1.isInRecall_ then
								local var_349_26 = Mathf.Lerp(iter_349_7.color.r, arg_346_1.hightColor1.r, var_349_25)
								local var_349_27 = Mathf.Lerp(iter_349_7.color.g, arg_346_1.hightColor1.g, var_349_25)
								local var_349_28 = Mathf.Lerp(iter_349_7.color.b, arg_346_1.hightColor1.b, var_349_25)

								iter_349_7.color = Color.New(var_349_26, var_349_27, var_349_28)
							else
								local var_349_29 = Mathf.Lerp(iter_349_7.color.r, 1, var_349_25)

								iter_349_7.color = Color.New(var_349_29, var_349_29, var_349_29)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_23 + var_349_24 and arg_346_1.time_ < var_349_23 + var_349_24 + arg_349_0 and not isNil(var_349_22) and arg_346_1.var_.actorSpriteComps1028 then
				for iter_349_8, iter_349_9 in pairs(arg_346_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_349_9 then
						if arg_346_1.isInRecall_ then
							iter_349_9.color = arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_349_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps1028 = nil
			end

			local var_349_30 = 0
			local var_349_31 = 0.4

			if var_349_30 < arg_346_1.time_ and arg_346_1.time_ <= var_349_30 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_32 = arg_346_1:FormatText(StoryNameCfg[327].name)

				arg_346_1.leftNameTxt_.text = var_349_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_33 = arg_346_1:GetWordFromCfg(416042081)
				local var_349_34 = arg_346_1:FormatText(var_349_33.content)

				arg_346_1.text_.text = var_349_34

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_35 = 16
				local var_349_36 = utf8.len(var_349_34)
				local var_349_37 = var_349_35 <= 0 and var_349_31 or var_349_31 * (var_349_36 / var_349_35)

				if var_349_37 > 0 and var_349_31 < var_349_37 then
					arg_346_1.talkMaxDuration = var_349_37

					if var_349_37 + var_349_30 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_37 + var_349_30
					end
				end

				arg_346_1.text_.text = var_349_34
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042081", "story_v_out_416042.awb") ~= 0 then
					local var_349_38 = manager.audio:GetVoiceLength("story_v_out_416042", "416042081", "story_v_out_416042.awb") / 1000

					if var_349_38 + var_349_30 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_38 + var_349_30
					end

					if var_349_33.prefab_name ~= "" and arg_346_1.actors_[var_349_33.prefab_name] ~= nil then
						local var_349_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_33.prefab_name].transform, "story_v_out_416042", "416042081", "story_v_out_416042.awb")

						arg_346_1:RecordAudio("416042081", var_349_39)
						arg_346_1:RecordAudio("416042081", var_349_39)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_416042", "416042081", "story_v_out_416042.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_416042", "416042081", "story_v_out_416042.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_40 = math.max(var_349_31, arg_346_1.talkMaxDuration)

			if var_349_30 <= arg_346_1.time_ and arg_346_1.time_ < var_349_30 + var_349_40 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_30) / var_349_40

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_30 + var_349_40 and arg_346_1.time_ < var_349_30 + var_349_40 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play416042082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416042082
		arg_350_1.duration_ = 16.13

		local var_350_0 = {
			zh = 8.1,
			ja = 16.133
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play416042083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1028"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1028 == nil then
				arg_350_1.var_.actorSpriteComps1028 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.125

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps1028 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 0.5, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1028 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_353_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps1028 = nil
			end

			local var_353_8 = arg_350_1.actors_["1086"]
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps1086 == nil then
				arg_350_1.var_.actorSpriteComps1086 = var_353_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_10 = 0.125

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_10 and not isNil(var_353_8) then
				local var_353_11 = (arg_350_1.time_ - var_353_9) / var_353_10

				if arg_350_1.var_.actorSpriteComps1086 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								local var_353_12 = Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor1.r, var_353_11)
								local var_353_13 = Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor1.g, var_353_11)
								local var_353_14 = Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor1.b, var_353_11)

								iter_353_5.color = Color.New(var_353_12, var_353_13, var_353_14)
							else
								local var_353_15 = Mathf.Lerp(iter_353_5.color.r, 1, var_353_11)

								iter_353_5.color = Color.New(var_353_15, var_353_15, var_353_15)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_9 + var_353_10 and arg_350_1.time_ < var_353_9 + var_353_10 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps1086 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_353_7 then
						if arg_350_1.isInRecall_ then
							iter_353_7.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps1086 = nil
			end

			local var_353_16 = arg_350_1.actors_["1086"].transform
			local var_353_17 = 0

			if var_353_17 < arg_350_1.time_ and arg_350_1.time_ <= var_353_17 + arg_353_0 then
				arg_350_1.var_.moveOldPos1086 = var_353_16.localPosition
				var_353_16.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1086", 2)

				local var_353_18 = var_353_16.childCount

				for iter_353_8 = 0, var_353_18 - 1 do
					local var_353_19 = var_353_16:GetChild(iter_353_8)

					if var_353_19.name == "split_1" or not string.find(var_353_19.name, "split") then
						var_353_19.gameObject:SetActive(true)
					else
						var_353_19.gameObject:SetActive(false)
					end
				end
			end

			local var_353_20 = 0.001

			if var_353_17 <= arg_350_1.time_ and arg_350_1.time_ < var_353_17 + var_353_20 then
				local var_353_21 = (arg_350_1.time_ - var_353_17) / var_353_20
				local var_353_22 = Vector3.New(-390, -404.2, -237.9)

				var_353_16.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1086, var_353_22, var_353_21)
			end

			if arg_350_1.time_ >= var_353_17 + var_353_20 and arg_350_1.time_ < var_353_17 + var_353_20 + arg_353_0 then
				var_353_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_353_23 = 0
			local var_353_24 = 0.75

			if var_353_23 < arg_350_1.time_ and arg_350_1.time_ <= var_353_23 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_25 = arg_350_1:FormatText(StoryNameCfg[1080].name)

				arg_350_1.leftNameTxt_.text = var_353_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_26 = arg_350_1:GetWordFromCfg(416042082)
				local var_353_27 = arg_350_1:FormatText(var_353_26.content)

				arg_350_1.text_.text = var_353_27

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_28 = 30
				local var_353_29 = utf8.len(var_353_27)
				local var_353_30 = var_353_28 <= 0 and var_353_24 or var_353_24 * (var_353_29 / var_353_28)

				if var_353_30 > 0 and var_353_24 < var_353_30 then
					arg_350_1.talkMaxDuration = var_353_30

					if var_353_30 + var_353_23 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_30 + var_353_23
					end
				end

				arg_350_1.text_.text = var_353_27
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042082", "story_v_out_416042.awb") ~= 0 then
					local var_353_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042082", "story_v_out_416042.awb") / 1000

					if var_353_31 + var_353_23 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_31 + var_353_23
					end

					if var_353_26.prefab_name ~= "" and arg_350_1.actors_[var_353_26.prefab_name] ~= nil then
						local var_353_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_26.prefab_name].transform, "story_v_out_416042", "416042082", "story_v_out_416042.awb")

						arg_350_1:RecordAudio("416042082", var_353_32)
						arg_350_1:RecordAudio("416042082", var_353_32)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_416042", "416042082", "story_v_out_416042.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_416042", "416042082", "story_v_out_416042.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_33 = math.max(var_353_24, arg_350_1.talkMaxDuration)

			if var_353_23 <= arg_350_1.time_ and arg_350_1.time_ < var_353_23 + var_353_33 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_23) / var_353_33

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_23 + var_353_33 and arg_350_1.time_ < var_353_23 + var_353_33 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play416042083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416042083
		arg_354_1.duration_ = 9.5

		local var_354_0 = {
			zh = 5.033,
			ja = 9.5
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
				arg_354_0:Play416042084(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.625

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[1080].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:GetWordFromCfg(416042083)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 25
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042083", "story_v_out_416042.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042083", "story_v_out_416042.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_out_416042", "416042083", "story_v_out_416042.awb")

						arg_354_1:RecordAudio("416042083", var_357_9)
						arg_354_1:RecordAudio("416042083", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416042", "416042083", "story_v_out_416042.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416042", "416042083", "story_v_out_416042.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_10 and arg_354_1.time_ < var_357_0 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play416042084 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 416042084
		arg_358_1.duration_ = 4.6

		local var_358_0 = {
			zh = 3.833,
			ja = 4.6
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
				arg_358_0:Play416042085(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1028"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1028 == nil then
				arg_358_1.var_.actorSpriteComps1028 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.125

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps1028 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 1, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1028 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1028 = nil
			end

			local var_361_8 = arg_358_1.actors_["1086"]
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps1086 == nil then
				arg_358_1.var_.actorSpriteComps1086 = var_361_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_10 = 0.125

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_10 and not isNil(var_361_8) then
				local var_361_11 = (arg_358_1.time_ - var_361_9) / var_361_10

				if arg_358_1.var_.actorSpriteComps1086 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								local var_361_12 = Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, var_361_11)
								local var_361_13 = Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, var_361_11)
								local var_361_14 = Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, var_361_11)

								iter_361_5.color = Color.New(var_361_12, var_361_13, var_361_14)
							else
								local var_361_15 = Mathf.Lerp(iter_361_5.color.r, 0.5, var_361_11)

								iter_361_5.color = Color.New(var_361_15, var_361_15, var_361_15)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_9 + var_361_10 and arg_358_1.time_ < var_361_9 + var_361_10 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps1086 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_361_7 then
						if arg_358_1.isInRecall_ then
							iter_361_7.color = arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_361_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1086 = nil
			end

			local var_361_16 = arg_358_1.actors_["1028"].transform
			local var_361_17 = 0

			if var_361_17 < arg_358_1.time_ and arg_358_1.time_ <= var_361_17 + arg_361_0 then
				arg_358_1.var_.moveOldPos1028 = var_361_16.localPosition
				var_361_16.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1028", 4)

				local var_361_18 = var_361_16.childCount

				for iter_361_8 = 0, var_361_18 - 1 do
					local var_361_19 = var_361_16:GetChild(iter_361_8)

					if var_361_19.name == "split_2" or not string.find(var_361_19.name, "split") then
						var_361_19.gameObject:SetActive(true)
					else
						var_361_19.gameObject:SetActive(false)
					end
				end
			end

			local var_361_20 = 0.001

			if var_361_17 <= arg_358_1.time_ and arg_358_1.time_ < var_361_17 + var_361_20 then
				local var_361_21 = (arg_358_1.time_ - var_361_17) / var_361_20
				local var_361_22 = Vector3.New(390, -402.7, -156.1)

				var_361_16.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1028, var_361_22, var_361_21)
			end

			if arg_358_1.time_ >= var_361_17 + var_361_20 and arg_358_1.time_ < var_361_17 + var_361_20 + arg_361_0 then
				var_361_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_361_23 = 0
			local var_361_24 = 0.325

			if var_361_23 < arg_358_1.time_ and arg_358_1.time_ <= var_361_23 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_25 = arg_358_1:FormatText(StoryNameCfg[327].name)

				arg_358_1.leftNameTxt_.text = var_361_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_26 = arg_358_1:GetWordFromCfg(416042084)
				local var_361_27 = arg_358_1:FormatText(var_361_26.content)

				arg_358_1.text_.text = var_361_27

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_28 = 13
				local var_361_29 = utf8.len(var_361_27)
				local var_361_30 = var_361_28 <= 0 and var_361_24 or var_361_24 * (var_361_29 / var_361_28)

				if var_361_30 > 0 and var_361_24 < var_361_30 then
					arg_358_1.talkMaxDuration = var_361_30

					if var_361_30 + var_361_23 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_30 + var_361_23
					end
				end

				arg_358_1.text_.text = var_361_27
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042084", "story_v_out_416042.awb") ~= 0 then
					local var_361_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042084", "story_v_out_416042.awb") / 1000

					if var_361_31 + var_361_23 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_31 + var_361_23
					end

					if var_361_26.prefab_name ~= "" and arg_358_1.actors_[var_361_26.prefab_name] ~= nil then
						local var_361_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_26.prefab_name].transform, "story_v_out_416042", "416042084", "story_v_out_416042.awb")

						arg_358_1:RecordAudio("416042084", var_361_32)
						arg_358_1:RecordAudio("416042084", var_361_32)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_416042", "416042084", "story_v_out_416042.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_416042", "416042084", "story_v_out_416042.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_33 = math.max(var_361_24, arg_358_1.talkMaxDuration)

			if var_361_23 <= arg_358_1.time_ and arg_358_1.time_ < var_361_23 + var_361_33 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_23) / var_361_33

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_23 + var_361_33 and arg_358_1.time_ < var_361_23 + var_361_33 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play416042085 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 416042085
		arg_362_1.duration_ = 10.03

		local var_362_0 = {
			zh = 6.6,
			ja = 10.033
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play416042086(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1028"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps1028 == nil then
				arg_362_1.var_.actorSpriteComps1028 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.125

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps1028 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								local var_365_4 = Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor2.r, var_365_3)
								local var_365_5 = Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor2.g, var_365_3)
								local var_365_6 = Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor2.b, var_365_3)

								iter_365_1.color = Color.New(var_365_4, var_365_5, var_365_6)
							else
								local var_365_7 = Mathf.Lerp(iter_365_1.color.r, 0.5, var_365_3)

								iter_365_1.color = Color.New(var_365_7, var_365_7, var_365_7)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps1028 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_365_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1028 = nil
			end

			local var_365_8 = arg_362_1.actors_["1086"]
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1086 == nil then
				arg_362_1.var_.actorSpriteComps1086 = var_365_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_10 = 0.125

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_10 and not isNil(var_365_8) then
				local var_365_11 = (arg_362_1.time_ - var_365_9) / var_365_10

				if arg_362_1.var_.actorSpriteComps1086 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								local var_365_12 = Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor1.r, var_365_11)
								local var_365_13 = Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor1.g, var_365_11)
								local var_365_14 = Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor1.b, var_365_11)

								iter_365_5.color = Color.New(var_365_12, var_365_13, var_365_14)
							else
								local var_365_15 = Mathf.Lerp(iter_365_5.color.r, 1, var_365_11)

								iter_365_5.color = Color.New(var_365_15, var_365_15, var_365_15)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_9 + var_365_10 and arg_362_1.time_ < var_365_9 + var_365_10 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1086 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_365_7 then
						if arg_362_1.isInRecall_ then
							iter_365_7.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1086 = nil
			end

			local var_365_16 = 0
			local var_365_17 = 0.725

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_18 = arg_362_1:FormatText(StoryNameCfg[1080].name)

				arg_362_1.leftNameTxt_.text = var_365_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_19 = arg_362_1:GetWordFromCfg(416042085)
				local var_365_20 = arg_362_1:FormatText(var_365_19.content)

				arg_362_1.text_.text = var_365_20

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_21 = 29
				local var_365_22 = utf8.len(var_365_20)
				local var_365_23 = var_365_21 <= 0 and var_365_17 or var_365_17 * (var_365_22 / var_365_21)

				if var_365_23 > 0 and var_365_17 < var_365_23 then
					arg_362_1.talkMaxDuration = var_365_23

					if var_365_23 + var_365_16 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_16
					end
				end

				arg_362_1.text_.text = var_365_20
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042085", "story_v_out_416042.awb") ~= 0 then
					local var_365_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042085", "story_v_out_416042.awb") / 1000

					if var_365_24 + var_365_16 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_24 + var_365_16
					end

					if var_365_19.prefab_name ~= "" and arg_362_1.actors_[var_365_19.prefab_name] ~= nil then
						local var_365_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_19.prefab_name].transform, "story_v_out_416042", "416042085", "story_v_out_416042.awb")

						arg_362_1:RecordAudio("416042085", var_365_25)
						arg_362_1:RecordAudio("416042085", var_365_25)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_416042", "416042085", "story_v_out_416042.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_416042", "416042085", "story_v_out_416042.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_26 = math.max(var_365_17, arg_362_1.talkMaxDuration)

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_26 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_16) / var_365_26

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_16 + var_365_26 and arg_362_1.time_ < var_365_16 + var_365_26 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play416042086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 416042086
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play416042087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1028"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1028 == nil then
				arg_366_1.var_.actorSpriteComps1028 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.125

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps1028 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								local var_369_4 = Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, var_369_3)
								local var_369_5 = Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, var_369_3)
								local var_369_6 = Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, var_369_3)

								iter_369_1.color = Color.New(var_369_4, var_369_5, var_369_6)
							else
								local var_369_7 = Mathf.Lerp(iter_369_1.color.r, 0.5, var_369_3)

								iter_369_1.color = Color.New(var_369_7, var_369_7, var_369_7)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1028 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps1028 = nil
			end

			local var_369_8 = arg_366_1.actors_["1086"]
			local var_369_9 = 0

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps1086 == nil then
				arg_366_1.var_.actorSpriteComps1086 = var_369_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_10 = 0.125

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_10 and not isNil(var_369_8) then
				local var_369_11 = (arg_366_1.time_ - var_369_9) / var_369_10

				if arg_366_1.var_.actorSpriteComps1086 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								local var_369_12 = Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, var_369_11)
								local var_369_13 = Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, var_369_11)
								local var_369_14 = Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, var_369_11)

								iter_369_5.color = Color.New(var_369_12, var_369_13, var_369_14)
							else
								local var_369_15 = Mathf.Lerp(iter_369_5.color.r, 0.5, var_369_11)

								iter_369_5.color = Color.New(var_369_15, var_369_15, var_369_15)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_9 + var_369_10 and arg_366_1.time_ < var_369_9 + var_369_10 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps1086 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_369_7 then
						if arg_366_1.isInRecall_ then
							iter_369_7.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps1086 = nil
			end

			local var_369_16 = 0
			local var_369_17 = 1.1

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_18 = arg_366_1:GetWordFromCfg(416042086)
				local var_369_19 = arg_366_1:FormatText(var_369_18.content)

				arg_366_1.text_.text = var_369_19

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_20 = 44
				local var_369_21 = utf8.len(var_369_19)
				local var_369_22 = var_369_20 <= 0 and var_369_17 or var_369_17 * (var_369_21 / var_369_20)

				if var_369_22 > 0 and var_369_17 < var_369_22 then
					arg_366_1.talkMaxDuration = var_369_22

					if var_369_22 + var_369_16 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_22 + var_369_16
					end
				end

				arg_366_1.text_.text = var_369_19
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_23 = math.max(var_369_17, arg_366_1.talkMaxDuration)

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_23 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_16) / var_369_23

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_16 + var_369_23 and arg_366_1.time_ < var_369_16 + var_369_23 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play416042087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 416042087
		arg_370_1.duration_ = 4.83

		local var_370_0 = {
			zh = 4.833,
			ja = 4.8
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play416042088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1028"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1028 == nil then
				arg_370_1.var_.actorSpriteComps1028 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.125

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps1028 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								local var_373_4 = Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, var_373_3)
								local var_373_5 = Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, var_373_3)
								local var_373_6 = Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, var_373_3)

								iter_373_1.color = Color.New(var_373_4, var_373_5, var_373_6)
							else
								local var_373_7 = Mathf.Lerp(iter_373_1.color.r, 1, var_373_3)

								iter_373_1.color = Color.New(var_373_7, var_373_7, var_373_7)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1028 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1028 = nil
			end

			local var_373_8 = arg_370_1.actors_["1086"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1086 == nil then
				arg_370_1.var_.actorSpriteComps1086 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.125

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps1086 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								local var_373_12 = Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, var_373_11)
								local var_373_13 = Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, var_373_11)
								local var_373_14 = Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, var_373_11)

								iter_373_5.color = Color.New(var_373_12, var_373_13, var_373_14)
							else
								local var_373_15 = Mathf.Lerp(iter_373_5.color.r, 0.5, var_373_11)

								iter_373_5.color = Color.New(var_373_15, var_373_15, var_373_15)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1086 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1086 = nil
			end

			local var_373_16 = 0
			local var_373_17 = 0.575

			if var_373_16 < arg_370_1.time_ and arg_370_1.time_ <= var_373_16 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_18 = arg_370_1:FormatText(StoryNameCfg[327].name)

				arg_370_1.leftNameTxt_.text = var_373_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_19 = arg_370_1:GetWordFromCfg(416042087)
				local var_373_20 = arg_370_1:FormatText(var_373_19.content)

				arg_370_1.text_.text = var_373_20

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_21 = 23
				local var_373_22 = utf8.len(var_373_20)
				local var_373_23 = var_373_21 <= 0 and var_373_17 or var_373_17 * (var_373_22 / var_373_21)

				if var_373_23 > 0 and var_373_17 < var_373_23 then
					arg_370_1.talkMaxDuration = var_373_23

					if var_373_23 + var_373_16 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_23 + var_373_16
					end
				end

				arg_370_1.text_.text = var_373_20
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042087", "story_v_out_416042.awb") ~= 0 then
					local var_373_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042087", "story_v_out_416042.awb") / 1000

					if var_373_24 + var_373_16 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_24 + var_373_16
					end

					if var_373_19.prefab_name ~= "" and arg_370_1.actors_[var_373_19.prefab_name] ~= nil then
						local var_373_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_19.prefab_name].transform, "story_v_out_416042", "416042087", "story_v_out_416042.awb")

						arg_370_1:RecordAudio("416042087", var_373_25)
						arg_370_1:RecordAudio("416042087", var_373_25)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_416042", "416042087", "story_v_out_416042.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_416042", "416042087", "story_v_out_416042.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_26 = math.max(var_373_17, arg_370_1.talkMaxDuration)

			if var_373_16 <= arg_370_1.time_ and arg_370_1.time_ < var_373_16 + var_373_26 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_16) / var_373_26

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_16 + var_373_26 and arg_370_1.time_ < var_373_16 + var_373_26 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play416042088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 416042088
		arg_374_1.duration_ = 8.87

		local var_374_0 = {
			zh = 8.866,
			ja = 6.433
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play416042089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1028"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps1028 == nil then
				arg_374_1.var_.actorSpriteComps1028 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.125

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps1028 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								local var_377_4 = Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, var_377_3)
								local var_377_5 = Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, var_377_3)
								local var_377_6 = Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, var_377_3)

								iter_377_1.color = Color.New(var_377_4, var_377_5, var_377_6)
							else
								local var_377_7 = Mathf.Lerp(iter_377_1.color.r, 0.5, var_377_3)

								iter_377_1.color = Color.New(var_377_7, var_377_7, var_377_7)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps1028 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps1028 = nil
			end

			local var_377_8 = arg_374_1.actors_["1086"]
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1086 == nil then
				arg_374_1.var_.actorSpriteComps1086 = var_377_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_10 = 0.125

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 and not isNil(var_377_8) then
				local var_377_11 = (arg_374_1.time_ - var_377_9) / var_377_10

				if arg_374_1.var_.actorSpriteComps1086 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								local var_377_12 = Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor1.r, var_377_11)
								local var_377_13 = Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor1.g, var_377_11)
								local var_377_14 = Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor1.b, var_377_11)

								iter_377_5.color = Color.New(var_377_12, var_377_13, var_377_14)
							else
								local var_377_15 = Mathf.Lerp(iter_377_5.color.r, 1, var_377_11)

								iter_377_5.color = Color.New(var_377_15, var_377_15, var_377_15)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1086 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_377_7 then
						if arg_374_1.isInRecall_ then
							iter_377_7.color = arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_377_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps1086 = nil
			end

			local var_377_16 = 0
			local var_377_17 = 0.75

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_18 = arg_374_1:FormatText(StoryNameCfg[1080].name)

				arg_374_1.leftNameTxt_.text = var_377_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_19 = arg_374_1:GetWordFromCfg(416042088)
				local var_377_20 = arg_374_1:FormatText(var_377_19.content)

				arg_374_1.text_.text = var_377_20

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_21 = 30
				local var_377_22 = utf8.len(var_377_20)
				local var_377_23 = var_377_21 <= 0 and var_377_17 or var_377_17 * (var_377_22 / var_377_21)

				if var_377_23 > 0 and var_377_17 < var_377_23 then
					arg_374_1.talkMaxDuration = var_377_23

					if var_377_23 + var_377_16 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_16
					end
				end

				arg_374_1.text_.text = var_377_20
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042088", "story_v_out_416042.awb") ~= 0 then
					local var_377_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042088", "story_v_out_416042.awb") / 1000

					if var_377_24 + var_377_16 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_24 + var_377_16
					end

					if var_377_19.prefab_name ~= "" and arg_374_1.actors_[var_377_19.prefab_name] ~= nil then
						local var_377_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_19.prefab_name].transform, "story_v_out_416042", "416042088", "story_v_out_416042.awb")

						arg_374_1:RecordAudio("416042088", var_377_25)
						arg_374_1:RecordAudio("416042088", var_377_25)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_416042", "416042088", "story_v_out_416042.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_416042", "416042088", "story_v_out_416042.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_26 = math.max(var_377_17, arg_374_1.talkMaxDuration)

			if var_377_16 <= arg_374_1.time_ and arg_374_1.time_ < var_377_16 + var_377_26 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_16) / var_377_26

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_16 + var_377_26 and arg_374_1.time_ < var_377_16 + var_377_26 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play416042089 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 416042089
		arg_378_1.duration_ = 10.73

		local var_378_0 = {
			zh = 8.8,
			ja = 10.733
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
				arg_378_0:Play416042090(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 1

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[1080].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(416042089)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 40
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042089", "story_v_out_416042.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042089", "story_v_out_416042.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_out_416042", "416042089", "story_v_out_416042.awb")

						arg_378_1:RecordAudio("416042089", var_381_9)
						arg_378_1:RecordAudio("416042089", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_416042", "416042089", "story_v_out_416042.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_416042", "416042089", "story_v_out_416042.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_10 and arg_378_1.time_ < var_381_0 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play416042090 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 416042090
		arg_382_1.duration_ = 3.2

		local var_382_0 = {
			zh = 2.966,
			ja = 3.2
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play416042091(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1028"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps1028 == nil then
				arg_382_1.var_.actorSpriteComps1028 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.125

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps1028 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 1, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps1028 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps1028 = nil
			end

			local var_385_8 = arg_382_1.actors_["1086"]
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps1086 == nil then
				arg_382_1.var_.actorSpriteComps1086 = var_385_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_10 = 0.125

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_10 and not isNil(var_385_8) then
				local var_385_11 = (arg_382_1.time_ - var_385_9) / var_385_10

				if arg_382_1.var_.actorSpriteComps1086 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								local var_385_12 = Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, var_385_11)
								local var_385_13 = Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, var_385_11)
								local var_385_14 = Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, var_385_11)

								iter_385_5.color = Color.New(var_385_12, var_385_13, var_385_14)
							else
								local var_385_15 = Mathf.Lerp(iter_385_5.color.r, 0.5, var_385_11)

								iter_385_5.color = Color.New(var_385_15, var_385_15, var_385_15)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_9 + var_385_10 and arg_382_1.time_ < var_385_9 + var_385_10 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps1086 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_385_7 then
						if arg_382_1.isInRecall_ then
							iter_385_7.color = arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_385_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps1086 = nil
			end

			local var_385_16 = arg_382_1.actors_["1028"].transform
			local var_385_17 = 0

			if var_385_17 < arg_382_1.time_ and arg_382_1.time_ <= var_385_17 + arg_385_0 then
				arg_382_1.var_.moveOldPos1028 = var_385_16.localPosition
				var_385_16.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1028", 4)

				local var_385_18 = var_385_16.childCount

				for iter_385_8 = 0, var_385_18 - 1 do
					local var_385_19 = var_385_16:GetChild(iter_385_8)

					if var_385_19.name == "split_2" or not string.find(var_385_19.name, "split") then
						var_385_19.gameObject:SetActive(true)
					else
						var_385_19.gameObject:SetActive(false)
					end
				end
			end

			local var_385_20 = 0.001

			if var_385_17 <= arg_382_1.time_ and arg_382_1.time_ < var_385_17 + var_385_20 then
				local var_385_21 = (arg_382_1.time_ - var_385_17) / var_385_20
				local var_385_22 = Vector3.New(390, -402.7, -156.1)

				var_385_16.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1028, var_385_22, var_385_21)
			end

			if arg_382_1.time_ >= var_385_17 + var_385_20 and arg_382_1.time_ < var_385_17 + var_385_20 + arg_385_0 then
				var_385_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_385_23 = 0
			local var_385_24 = 0.175

			if var_385_23 < arg_382_1.time_ and arg_382_1.time_ <= var_385_23 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_25 = arg_382_1:FormatText(StoryNameCfg[327].name)

				arg_382_1.leftNameTxt_.text = var_385_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_26 = arg_382_1:GetWordFromCfg(416042090)
				local var_385_27 = arg_382_1:FormatText(var_385_26.content)

				arg_382_1.text_.text = var_385_27

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_28 = 7
				local var_385_29 = utf8.len(var_385_27)
				local var_385_30 = var_385_28 <= 0 and var_385_24 or var_385_24 * (var_385_29 / var_385_28)

				if var_385_30 > 0 and var_385_24 < var_385_30 then
					arg_382_1.talkMaxDuration = var_385_30

					if var_385_30 + var_385_23 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_30 + var_385_23
					end
				end

				arg_382_1.text_.text = var_385_27
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042090", "story_v_out_416042.awb") ~= 0 then
					local var_385_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042090", "story_v_out_416042.awb") / 1000

					if var_385_31 + var_385_23 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_31 + var_385_23
					end

					if var_385_26.prefab_name ~= "" and arg_382_1.actors_[var_385_26.prefab_name] ~= nil then
						local var_385_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_26.prefab_name].transform, "story_v_out_416042", "416042090", "story_v_out_416042.awb")

						arg_382_1:RecordAudio("416042090", var_385_32)
						arg_382_1:RecordAudio("416042090", var_385_32)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_416042", "416042090", "story_v_out_416042.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_416042", "416042090", "story_v_out_416042.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_33 = math.max(var_385_24, arg_382_1.talkMaxDuration)

			if var_385_23 <= arg_382_1.time_ and arg_382_1.time_ < var_385_23 + var_385_33 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_23) / var_385_33

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_23 + var_385_33 and arg_382_1.time_ < var_385_23 + var_385_33 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play416042091 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 416042091
		arg_386_1.duration_ = 4.53

		local var_386_0 = {
			zh = 3.7,
			ja = 4.533
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
				arg_386_0:Play416042092(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1028"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps1028 == nil then
				arg_386_1.var_.actorSpriteComps1028 = var_389_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_2 = 0.125

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.actorSpriteComps1028 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								local var_389_4 = Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, var_389_3)
								local var_389_5 = Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, var_389_3)
								local var_389_6 = Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, var_389_3)

								iter_389_1.color = Color.New(var_389_4, var_389_5, var_389_6)
							else
								local var_389_7 = Mathf.Lerp(iter_389_1.color.r, 0.5, var_389_3)

								iter_389_1.color = Color.New(var_389_7, var_389_7, var_389_7)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps1028 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_389_3 then
						if arg_386_1.isInRecall_ then
							iter_389_3.color = arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_389_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps1028 = nil
			end

			local var_389_8 = arg_386_1.actors_["1086"]
			local var_389_9 = 0

			if var_389_9 < arg_386_1.time_ and arg_386_1.time_ <= var_389_9 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps1086 == nil then
				arg_386_1.var_.actorSpriteComps1086 = var_389_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_10 = 0.125

			if var_389_9 <= arg_386_1.time_ and arg_386_1.time_ < var_389_9 + var_389_10 and not isNil(var_389_8) then
				local var_389_11 = (arg_386_1.time_ - var_389_9) / var_389_10

				if arg_386_1.var_.actorSpriteComps1086 then
					for iter_389_4, iter_389_5 in pairs(arg_386_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_389_5 then
							if arg_386_1.isInRecall_ then
								local var_389_12 = Mathf.Lerp(iter_389_5.color.r, arg_386_1.hightColor1.r, var_389_11)
								local var_389_13 = Mathf.Lerp(iter_389_5.color.g, arg_386_1.hightColor1.g, var_389_11)
								local var_389_14 = Mathf.Lerp(iter_389_5.color.b, arg_386_1.hightColor1.b, var_389_11)

								iter_389_5.color = Color.New(var_389_12, var_389_13, var_389_14)
							else
								local var_389_15 = Mathf.Lerp(iter_389_5.color.r, 1, var_389_11)

								iter_389_5.color = Color.New(var_389_15, var_389_15, var_389_15)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_9 + var_389_10 and arg_386_1.time_ < var_389_9 + var_389_10 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps1086 then
				for iter_389_6, iter_389_7 in pairs(arg_386_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_389_7 then
						if arg_386_1.isInRecall_ then
							iter_389_7.color = arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_389_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps1086 = nil
			end

			local var_389_16 = arg_386_1.actors_["1086"].transform
			local var_389_17 = 0

			if var_389_17 < arg_386_1.time_ and arg_386_1.time_ <= var_389_17 + arg_389_0 then
				arg_386_1.var_.moveOldPos1086 = var_389_16.localPosition
				var_389_16.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("1086", 2)

				local var_389_18 = var_389_16.childCount

				for iter_389_8 = 0, var_389_18 - 1 do
					local var_389_19 = var_389_16:GetChild(iter_389_8)

					if var_389_19.name == "split_6" or not string.find(var_389_19.name, "split") then
						var_389_19.gameObject:SetActive(true)
					else
						var_389_19.gameObject:SetActive(false)
					end
				end
			end

			local var_389_20 = 0.001

			if var_389_17 <= arg_386_1.time_ and arg_386_1.time_ < var_389_17 + var_389_20 then
				local var_389_21 = (arg_386_1.time_ - var_389_17) / var_389_20
				local var_389_22 = Vector3.New(-390, -404.2, -237.9)

				var_389_16.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1086, var_389_22, var_389_21)
			end

			if arg_386_1.time_ >= var_389_17 + var_389_20 and arg_386_1.time_ < var_389_17 + var_389_20 + arg_389_0 then
				var_389_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_389_23 = 0
			local var_389_24 = 0.3

			if var_389_23 < arg_386_1.time_ and arg_386_1.time_ <= var_389_23 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_25 = arg_386_1:FormatText(StoryNameCfg[1080].name)

				arg_386_1.leftNameTxt_.text = var_389_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_26 = arg_386_1:GetWordFromCfg(416042091)
				local var_389_27 = arg_386_1:FormatText(var_389_26.content)

				arg_386_1.text_.text = var_389_27

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_28 = 12
				local var_389_29 = utf8.len(var_389_27)
				local var_389_30 = var_389_28 <= 0 and var_389_24 or var_389_24 * (var_389_29 / var_389_28)

				if var_389_30 > 0 and var_389_24 < var_389_30 then
					arg_386_1.talkMaxDuration = var_389_30

					if var_389_30 + var_389_23 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_30 + var_389_23
					end
				end

				arg_386_1.text_.text = var_389_27
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042091", "story_v_out_416042.awb") ~= 0 then
					local var_389_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042091", "story_v_out_416042.awb") / 1000

					if var_389_31 + var_389_23 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_31 + var_389_23
					end

					if var_389_26.prefab_name ~= "" and arg_386_1.actors_[var_389_26.prefab_name] ~= nil then
						local var_389_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_26.prefab_name].transform, "story_v_out_416042", "416042091", "story_v_out_416042.awb")

						arg_386_1:RecordAudio("416042091", var_389_32)
						arg_386_1:RecordAudio("416042091", var_389_32)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_416042", "416042091", "story_v_out_416042.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_416042", "416042091", "story_v_out_416042.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_33 = math.max(var_389_24, arg_386_1.talkMaxDuration)

			if var_389_23 <= arg_386_1.time_ and arg_386_1.time_ < var_389_23 + var_389_33 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_23) / var_389_33

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_23 + var_389_33 and arg_386_1.time_ < var_389_23 + var_389_33 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play416042092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416042092
		arg_390_1.duration_ = 8.5

		local var_390_0 = {
			zh = 5.033,
			ja = 8.5
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416042093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1028"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps1028 == nil then
				arg_390_1.var_.actorSpriteComps1028 = var_393_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_2 = 0.125

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.actorSpriteComps1028 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								local var_393_4 = Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, var_393_3)
								local var_393_5 = Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, var_393_3)
								local var_393_6 = Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, var_393_3)

								iter_393_1.color = Color.New(var_393_4, var_393_5, var_393_6)
							else
								local var_393_7 = Mathf.Lerp(iter_393_1.color.r, 1, var_393_3)

								iter_393_1.color = Color.New(var_393_7, var_393_7, var_393_7)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps1028 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_393_3 then
						if arg_390_1.isInRecall_ then
							iter_393_3.color = arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_393_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps1028 = nil
			end

			local var_393_8 = arg_390_1.actors_["1086"]
			local var_393_9 = 0

			if var_393_9 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 and not isNil(var_393_8) and arg_390_1.var_.actorSpriteComps1086 == nil then
				arg_390_1.var_.actorSpriteComps1086 = var_393_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_10 = 0.125

			if var_393_9 <= arg_390_1.time_ and arg_390_1.time_ < var_393_9 + var_393_10 and not isNil(var_393_8) then
				local var_393_11 = (arg_390_1.time_ - var_393_9) / var_393_10

				if arg_390_1.var_.actorSpriteComps1086 then
					for iter_393_4, iter_393_5 in pairs(arg_390_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_393_5 then
							if arg_390_1.isInRecall_ then
								local var_393_12 = Mathf.Lerp(iter_393_5.color.r, arg_390_1.hightColor2.r, var_393_11)
								local var_393_13 = Mathf.Lerp(iter_393_5.color.g, arg_390_1.hightColor2.g, var_393_11)
								local var_393_14 = Mathf.Lerp(iter_393_5.color.b, arg_390_1.hightColor2.b, var_393_11)

								iter_393_5.color = Color.New(var_393_12, var_393_13, var_393_14)
							else
								local var_393_15 = Mathf.Lerp(iter_393_5.color.r, 0.5, var_393_11)

								iter_393_5.color = Color.New(var_393_15, var_393_15, var_393_15)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_9 + var_393_10 and arg_390_1.time_ < var_393_9 + var_393_10 + arg_393_0 and not isNil(var_393_8) and arg_390_1.var_.actorSpriteComps1086 then
				for iter_393_6, iter_393_7 in pairs(arg_390_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_393_7 then
						if arg_390_1.isInRecall_ then
							iter_393_7.color = arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_393_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps1086 = nil
			end

			local var_393_16 = arg_390_1.actors_["1028"].transform
			local var_393_17 = 0

			if var_393_17 < arg_390_1.time_ and arg_390_1.time_ <= var_393_17 + arg_393_0 then
				arg_390_1.var_.moveOldPos1028 = var_393_16.localPosition
				var_393_16.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("1028", 4)

				local var_393_18 = var_393_16.childCount

				for iter_393_8 = 0, var_393_18 - 1 do
					local var_393_19 = var_393_16:GetChild(iter_393_8)

					if var_393_19.name == "split_2" or not string.find(var_393_19.name, "split") then
						var_393_19.gameObject:SetActive(true)
					else
						var_393_19.gameObject:SetActive(false)
					end
				end
			end

			local var_393_20 = 0.001

			if var_393_17 <= arg_390_1.time_ and arg_390_1.time_ < var_393_17 + var_393_20 then
				local var_393_21 = (arg_390_1.time_ - var_393_17) / var_393_20
				local var_393_22 = Vector3.New(390, -402.7, -156.1)

				var_393_16.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1028, var_393_22, var_393_21)
			end

			if arg_390_1.time_ >= var_393_17 + var_393_20 and arg_390_1.time_ < var_393_17 + var_393_20 + arg_393_0 then
				var_393_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_393_23 = 0
			local var_393_24 = 0.7

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_25 = arg_390_1:FormatText(StoryNameCfg[327].name)

				arg_390_1.leftNameTxt_.text = var_393_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_26 = arg_390_1:GetWordFromCfg(416042092)
				local var_393_27 = arg_390_1:FormatText(var_393_26.content)

				arg_390_1.text_.text = var_393_27

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_28 = 28
				local var_393_29 = utf8.len(var_393_27)
				local var_393_30 = var_393_28 <= 0 and var_393_24 or var_393_24 * (var_393_29 / var_393_28)

				if var_393_30 > 0 and var_393_24 < var_393_30 then
					arg_390_1.talkMaxDuration = var_393_30

					if var_393_30 + var_393_23 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_30 + var_393_23
					end
				end

				arg_390_1.text_.text = var_393_27
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042092", "story_v_out_416042.awb") ~= 0 then
					local var_393_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042092", "story_v_out_416042.awb") / 1000

					if var_393_31 + var_393_23 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_31 + var_393_23
					end

					if var_393_26.prefab_name ~= "" and arg_390_1.actors_[var_393_26.prefab_name] ~= nil then
						local var_393_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_26.prefab_name].transform, "story_v_out_416042", "416042092", "story_v_out_416042.awb")

						arg_390_1:RecordAudio("416042092", var_393_32)
						arg_390_1:RecordAudio("416042092", var_393_32)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416042", "416042092", "story_v_out_416042.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416042", "416042092", "story_v_out_416042.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_33 = math.max(var_393_24, arg_390_1.talkMaxDuration)

			if var_393_23 <= arg_390_1.time_ and arg_390_1.time_ < var_393_23 + var_393_33 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_23) / var_393_33

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_23 + var_393_33 and arg_390_1.time_ < var_393_23 + var_393_33 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play416042093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416042093
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416042094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1028"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1028 == nil then
				arg_394_1.var_.actorSpriteComps1028 = var_397_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_2 = 0.125

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.actorSpriteComps1028 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								local var_397_4 = Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor2.r, var_397_3)
								local var_397_5 = Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor2.g, var_397_3)
								local var_397_6 = Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor2.b, var_397_3)

								iter_397_1.color = Color.New(var_397_4, var_397_5, var_397_6)
							else
								local var_397_7 = Mathf.Lerp(iter_397_1.color.r, 0.5, var_397_3)

								iter_397_1.color = Color.New(var_397_7, var_397_7, var_397_7)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1028 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_397_3 then
						if arg_394_1.isInRecall_ then
							iter_397_3.color = arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_397_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps1028 = nil
			end

			local var_397_8 = arg_394_1.actors_["1086"]
			local var_397_9 = 0

			if var_397_9 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps1086 == nil then
				arg_394_1.var_.actorSpriteComps1086 = var_397_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_10 = 0.125

			if var_397_9 <= arg_394_1.time_ and arg_394_1.time_ < var_397_9 + var_397_10 and not isNil(var_397_8) then
				local var_397_11 = (arg_394_1.time_ - var_397_9) / var_397_10

				if arg_394_1.var_.actorSpriteComps1086 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								local var_397_12 = Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, var_397_11)
								local var_397_13 = Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, var_397_11)
								local var_397_14 = Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, var_397_11)

								iter_397_5.color = Color.New(var_397_12, var_397_13, var_397_14)
							else
								local var_397_15 = Mathf.Lerp(iter_397_5.color.r, 0.5, var_397_11)

								iter_397_5.color = Color.New(var_397_15, var_397_15, var_397_15)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_9 + var_397_10 and arg_394_1.time_ < var_397_9 + var_397_10 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps1086 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_397_7 then
						if arg_394_1.isInRecall_ then
							iter_397_7.color = arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_397_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps1086 = nil
			end

			local var_397_16 = 0
			local var_397_17 = 1.125

			if var_397_16 < arg_394_1.time_ and arg_394_1.time_ <= var_397_16 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_18 = arg_394_1:GetWordFromCfg(416042093)
				local var_397_19 = arg_394_1:FormatText(var_397_18.content)

				arg_394_1.text_.text = var_397_19

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_20 = 45
				local var_397_21 = utf8.len(var_397_19)
				local var_397_22 = var_397_20 <= 0 and var_397_17 or var_397_17 * (var_397_21 / var_397_20)

				if var_397_22 > 0 and var_397_17 < var_397_22 then
					arg_394_1.talkMaxDuration = var_397_22

					if var_397_22 + var_397_16 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_22 + var_397_16
					end
				end

				arg_394_1.text_.text = var_397_19
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_23 = math.max(var_397_17, arg_394_1.talkMaxDuration)

			if var_397_16 <= arg_394_1.time_ and arg_394_1.time_ < var_397_16 + var_397_23 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_16) / var_397_23

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_16 + var_397_23 and arg_394_1.time_ < var_397_16 + var_397_23 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play416042094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416042094
		arg_398_1.duration_ = 6.7

		local var_398_0 = {
			zh = 6.7,
			ja = 2.066
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
				arg_398_0:Play416042095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1028"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1028 == nil then
				arg_398_1.var_.actorSpriteComps1028 = var_401_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_2 = 0.125

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.actorSpriteComps1028 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								local var_401_4 = Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor1.r, var_401_3)
								local var_401_5 = Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor1.g, var_401_3)
								local var_401_6 = Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor1.b, var_401_3)

								iter_401_1.color = Color.New(var_401_4, var_401_5, var_401_6)
							else
								local var_401_7 = Mathf.Lerp(iter_401_1.color.r, 1, var_401_3)

								iter_401_1.color = Color.New(var_401_7, var_401_7, var_401_7)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1028 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_401_3 then
						if arg_398_1.isInRecall_ then
							iter_401_3.color = arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_401_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_398_1.var_.actorSpriteComps1028 = nil
			end

			local var_401_8 = arg_398_1.actors_["1086"]
			local var_401_9 = 0

			if var_401_9 < arg_398_1.time_ and arg_398_1.time_ <= var_401_9 + arg_401_0 and not isNil(var_401_8) and arg_398_1.var_.actorSpriteComps1086 == nil then
				arg_398_1.var_.actorSpriteComps1086 = var_401_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_10 = 0.125

			if var_401_9 <= arg_398_1.time_ and arg_398_1.time_ < var_401_9 + var_401_10 and not isNil(var_401_8) then
				local var_401_11 = (arg_398_1.time_ - var_401_9) / var_401_10

				if arg_398_1.var_.actorSpriteComps1086 then
					for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_401_5 then
							if arg_398_1.isInRecall_ then
								local var_401_12 = Mathf.Lerp(iter_401_5.color.r, arg_398_1.hightColor2.r, var_401_11)
								local var_401_13 = Mathf.Lerp(iter_401_5.color.g, arg_398_1.hightColor2.g, var_401_11)
								local var_401_14 = Mathf.Lerp(iter_401_5.color.b, arg_398_1.hightColor2.b, var_401_11)

								iter_401_5.color = Color.New(var_401_12, var_401_13, var_401_14)
							else
								local var_401_15 = Mathf.Lerp(iter_401_5.color.r, 0.5, var_401_11)

								iter_401_5.color = Color.New(var_401_15, var_401_15, var_401_15)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= var_401_9 + var_401_10 and arg_398_1.time_ < var_401_9 + var_401_10 + arg_401_0 and not isNil(var_401_8) and arg_398_1.var_.actorSpriteComps1086 then
				for iter_401_6, iter_401_7 in pairs(arg_398_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_401_7 then
						if arg_398_1.isInRecall_ then
							iter_401_7.color = arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_401_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_398_1.var_.actorSpriteComps1086 = nil
			end

			local var_401_16 = 0
			local var_401_17 = 0.375

			if var_401_16 < arg_398_1.time_ and arg_398_1.time_ <= var_401_16 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_18 = arg_398_1:FormatText(StoryNameCfg[327].name)

				arg_398_1.leftNameTxt_.text = var_401_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_19 = arg_398_1:GetWordFromCfg(416042094)
				local var_401_20 = arg_398_1:FormatText(var_401_19.content)

				arg_398_1.text_.text = var_401_20

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_21 = 15
				local var_401_22 = utf8.len(var_401_20)
				local var_401_23 = var_401_21 <= 0 and var_401_17 or var_401_17 * (var_401_22 / var_401_21)

				if var_401_23 > 0 and var_401_17 < var_401_23 then
					arg_398_1.talkMaxDuration = var_401_23

					if var_401_23 + var_401_16 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_16
					end
				end

				arg_398_1.text_.text = var_401_20
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042094", "story_v_out_416042.awb") ~= 0 then
					local var_401_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042094", "story_v_out_416042.awb") / 1000

					if var_401_24 + var_401_16 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_24 + var_401_16
					end

					if var_401_19.prefab_name ~= "" and arg_398_1.actors_[var_401_19.prefab_name] ~= nil then
						local var_401_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_19.prefab_name].transform, "story_v_out_416042", "416042094", "story_v_out_416042.awb")

						arg_398_1:RecordAudio("416042094", var_401_25)
						arg_398_1:RecordAudio("416042094", var_401_25)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416042", "416042094", "story_v_out_416042.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416042", "416042094", "story_v_out_416042.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_26 = math.max(var_401_17, arg_398_1.talkMaxDuration)

			if var_401_16 <= arg_398_1.time_ and arg_398_1.time_ < var_401_16 + var_401_26 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_16) / var_401_26

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_16 + var_401_26 and arg_398_1.time_ < var_401_16 + var_401_26 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416042095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416042095
		arg_402_1.duration_ = 12.4

		local var_402_0 = {
			zh = 3.833,
			ja = 12.4
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
				arg_402_0:Play416042096(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1028"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1028 == nil then
				arg_402_1.var_.actorSpriteComps1028 = var_405_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_2 = 0.125

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.actorSpriteComps1028 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								local var_405_4 = Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor2.r, var_405_3)
								local var_405_5 = Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor2.g, var_405_3)
								local var_405_6 = Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor2.b, var_405_3)

								iter_405_1.color = Color.New(var_405_4, var_405_5, var_405_6)
							else
								local var_405_7 = Mathf.Lerp(iter_405_1.color.r, 0.5, var_405_3)

								iter_405_1.color = Color.New(var_405_7, var_405_7, var_405_7)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1028 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_405_3 then
						if arg_402_1.isInRecall_ then
							iter_405_3.color = arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_405_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps1028 = nil
			end

			local var_405_8 = arg_402_1.actors_["1086"]
			local var_405_9 = 0

			if var_405_9 < arg_402_1.time_ and arg_402_1.time_ <= var_405_9 + arg_405_0 and not isNil(var_405_8) and arg_402_1.var_.actorSpriteComps1086 == nil then
				arg_402_1.var_.actorSpriteComps1086 = var_405_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_10 = 0.125

			if var_405_9 <= arg_402_1.time_ and arg_402_1.time_ < var_405_9 + var_405_10 and not isNil(var_405_8) then
				local var_405_11 = (arg_402_1.time_ - var_405_9) / var_405_10

				if arg_402_1.var_.actorSpriteComps1086 then
					for iter_405_4, iter_405_5 in pairs(arg_402_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_405_5 then
							if arg_402_1.isInRecall_ then
								local var_405_12 = Mathf.Lerp(iter_405_5.color.r, arg_402_1.hightColor1.r, var_405_11)
								local var_405_13 = Mathf.Lerp(iter_405_5.color.g, arg_402_1.hightColor1.g, var_405_11)
								local var_405_14 = Mathf.Lerp(iter_405_5.color.b, arg_402_1.hightColor1.b, var_405_11)

								iter_405_5.color = Color.New(var_405_12, var_405_13, var_405_14)
							else
								local var_405_15 = Mathf.Lerp(iter_405_5.color.r, 1, var_405_11)

								iter_405_5.color = Color.New(var_405_15, var_405_15, var_405_15)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_9 + var_405_10 and arg_402_1.time_ < var_405_9 + var_405_10 + arg_405_0 and not isNil(var_405_8) and arg_402_1.var_.actorSpriteComps1086 then
				for iter_405_6, iter_405_7 in pairs(arg_402_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_405_7 then
						if arg_402_1.isInRecall_ then
							iter_405_7.color = arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_405_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps1086 = nil
			end

			local var_405_16 = 0
			local var_405_17 = 0.425

			if var_405_16 < arg_402_1.time_ and arg_402_1.time_ <= var_405_16 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_18 = arg_402_1:FormatText(StoryNameCfg[1080].name)

				arg_402_1.leftNameTxt_.text = var_405_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_19 = arg_402_1:GetWordFromCfg(416042095)
				local var_405_20 = arg_402_1:FormatText(var_405_19.content)

				arg_402_1.text_.text = var_405_20

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_21 = 17
				local var_405_22 = utf8.len(var_405_20)
				local var_405_23 = var_405_21 <= 0 and var_405_17 or var_405_17 * (var_405_22 / var_405_21)

				if var_405_23 > 0 and var_405_17 < var_405_23 then
					arg_402_1.talkMaxDuration = var_405_23

					if var_405_23 + var_405_16 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_23 + var_405_16
					end
				end

				arg_402_1.text_.text = var_405_20
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042095", "story_v_out_416042.awb") ~= 0 then
					local var_405_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042095", "story_v_out_416042.awb") / 1000

					if var_405_24 + var_405_16 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_24 + var_405_16
					end

					if var_405_19.prefab_name ~= "" and arg_402_1.actors_[var_405_19.prefab_name] ~= nil then
						local var_405_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_19.prefab_name].transform, "story_v_out_416042", "416042095", "story_v_out_416042.awb")

						arg_402_1:RecordAudio("416042095", var_405_25)
						arg_402_1:RecordAudio("416042095", var_405_25)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416042", "416042095", "story_v_out_416042.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416042", "416042095", "story_v_out_416042.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_26 = math.max(var_405_17, arg_402_1.talkMaxDuration)

			if var_405_16 <= arg_402_1.time_ and arg_402_1.time_ < var_405_16 + var_405_26 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_16) / var_405_26

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_16 + var_405_26 and arg_402_1.time_ < var_405_16 + var_405_26 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play416042096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416042096
		arg_406_1.duration_ = 4.2

		local var_406_0 = {
			zh = 3.366,
			ja = 4.2
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
				arg_406_0:Play416042097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1028"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps1028 == nil then
				arg_406_1.var_.actorSpriteComps1028 = var_409_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_2 = 0.125

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.actorSpriteComps1028 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								local var_409_4 = Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor1.r, var_409_3)
								local var_409_5 = Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor1.g, var_409_3)
								local var_409_6 = Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor1.b, var_409_3)

								iter_409_1.color = Color.New(var_409_4, var_409_5, var_409_6)
							else
								local var_409_7 = Mathf.Lerp(iter_409_1.color.r, 1, var_409_3)

								iter_409_1.color = Color.New(var_409_7, var_409_7, var_409_7)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps1028 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_409_3 then
						if arg_406_1.isInRecall_ then
							iter_409_3.color = arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_409_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps1028 = nil
			end

			local var_409_8 = arg_406_1.actors_["1086"]
			local var_409_9 = 0

			if var_409_9 < arg_406_1.time_ and arg_406_1.time_ <= var_409_9 + arg_409_0 and not isNil(var_409_8) and arg_406_1.var_.actorSpriteComps1086 == nil then
				arg_406_1.var_.actorSpriteComps1086 = var_409_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_10 = 0.125

			if var_409_9 <= arg_406_1.time_ and arg_406_1.time_ < var_409_9 + var_409_10 and not isNil(var_409_8) then
				local var_409_11 = (arg_406_1.time_ - var_409_9) / var_409_10

				if arg_406_1.var_.actorSpriteComps1086 then
					for iter_409_4, iter_409_5 in pairs(arg_406_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_409_5 then
							if arg_406_1.isInRecall_ then
								local var_409_12 = Mathf.Lerp(iter_409_5.color.r, arg_406_1.hightColor2.r, var_409_11)
								local var_409_13 = Mathf.Lerp(iter_409_5.color.g, arg_406_1.hightColor2.g, var_409_11)
								local var_409_14 = Mathf.Lerp(iter_409_5.color.b, arg_406_1.hightColor2.b, var_409_11)

								iter_409_5.color = Color.New(var_409_12, var_409_13, var_409_14)
							else
								local var_409_15 = Mathf.Lerp(iter_409_5.color.r, 0.5, var_409_11)

								iter_409_5.color = Color.New(var_409_15, var_409_15, var_409_15)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_9 + var_409_10 and arg_406_1.time_ < var_409_9 + var_409_10 + arg_409_0 and not isNil(var_409_8) and arg_406_1.var_.actorSpriteComps1086 then
				for iter_409_6, iter_409_7 in pairs(arg_406_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_409_7 then
						if arg_406_1.isInRecall_ then
							iter_409_7.color = arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_409_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps1086 = nil
			end

			local var_409_16 = 0
			local var_409_17 = 0.375

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_18 = arg_406_1:FormatText(StoryNameCfg[327].name)

				arg_406_1.leftNameTxt_.text = var_409_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_19 = arg_406_1:GetWordFromCfg(416042096)
				local var_409_20 = arg_406_1:FormatText(var_409_19.content)

				arg_406_1.text_.text = var_409_20

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_21 = 15
				local var_409_22 = utf8.len(var_409_20)
				local var_409_23 = var_409_21 <= 0 and var_409_17 or var_409_17 * (var_409_22 / var_409_21)

				if var_409_23 > 0 and var_409_17 < var_409_23 then
					arg_406_1.talkMaxDuration = var_409_23

					if var_409_23 + var_409_16 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_16
					end
				end

				arg_406_1.text_.text = var_409_20
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042096", "story_v_out_416042.awb") ~= 0 then
					local var_409_24 = manager.audio:GetVoiceLength("story_v_out_416042", "416042096", "story_v_out_416042.awb") / 1000

					if var_409_24 + var_409_16 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_24 + var_409_16
					end

					if var_409_19.prefab_name ~= "" and arg_406_1.actors_[var_409_19.prefab_name] ~= nil then
						local var_409_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_19.prefab_name].transform, "story_v_out_416042", "416042096", "story_v_out_416042.awb")

						arg_406_1:RecordAudio("416042096", var_409_25)
						arg_406_1:RecordAudio("416042096", var_409_25)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_416042", "416042096", "story_v_out_416042.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_416042", "416042096", "story_v_out_416042.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_26 = math.max(var_409_17, arg_406_1.talkMaxDuration)

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_26 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_16) / var_409_26

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_16 + var_409_26 and arg_406_1.time_ < var_409_16 + var_409_26 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play416042097 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416042097
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
			arg_410_1.auto_ = false
		end

		function arg_410_1.playNext_(arg_412_0)
			arg_410_1.onStoryFinished_()
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1028"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1028 = var_413_0.localPosition
				var_413_0.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1028", 7)

				local var_413_2 = var_413_0.childCount

				for iter_413_0 = 0, var_413_2 - 1 do
					local var_413_3 = var_413_0:GetChild(iter_413_0)

					if var_413_3.name == "" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_4 then
				local var_413_5 = (arg_410_1.time_ - var_413_1) / var_413_4
				local var_413_6 = Vector3.New(0, -2000, 0)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1028, var_413_6, var_413_5)
			end

			if arg_410_1.time_ >= var_413_1 + var_413_4 and arg_410_1.time_ < var_413_1 + var_413_4 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_413_7 = arg_410_1.actors_["1086"].transform
			local var_413_8 = 0

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 then
				arg_410_1.var_.moveOldPos1086 = var_413_7.localPosition
				var_413_7.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1086", 7)

				local var_413_9 = var_413_7.childCount

				for iter_413_1 = 0, var_413_9 - 1 do
					local var_413_10 = var_413_7:GetChild(iter_413_1)

					if var_413_10.name == "" or not string.find(var_413_10.name, "split") then
						var_413_10.gameObject:SetActive(true)
					else
						var_413_10.gameObject:SetActive(false)
					end
				end
			end

			local var_413_11 = 0.001

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_11 then
				local var_413_12 = (arg_410_1.time_ - var_413_8) / var_413_11
				local var_413_13 = Vector3.New(0, -2000, 0)

				var_413_7.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1086, var_413_13, var_413_12)
			end

			if arg_410_1.time_ >= var_413_8 + var_413_11 and arg_410_1.time_ < var_413_8 + var_413_11 + arg_413_0 then
				var_413_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_413_14 = 0
			local var_413_15 = 1.175

			if var_413_14 < arg_410_1.time_ and arg_410_1.time_ <= var_413_14 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_16 = arg_410_1:GetWordFromCfg(416042097)
				local var_413_17 = arg_410_1:FormatText(var_413_16.content)

				arg_410_1.text_.text = var_413_17

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_18 = 47
				local var_413_19 = utf8.len(var_413_17)
				local var_413_20 = var_413_18 <= 0 and var_413_15 or var_413_15 * (var_413_19 / var_413_18)

				if var_413_20 > 0 and var_413_15 < var_413_20 then
					arg_410_1.talkMaxDuration = var_413_20

					if var_413_20 + var_413_14 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_20 + var_413_14
					end
				end

				arg_410_1.text_.text = var_413_17
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_21 = math.max(var_413_15, arg_410_1.talkMaxDuration)

			if var_413_14 <= arg_410_1.time_ and arg_410_1.time_ < var_413_14 + var_413_21 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_14) / var_413_21

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_14 + var_413_21 and arg_410_1.time_ < var_413_14 + var_413_21 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/SS1602",
		"TextureConfig/Background/ST0106"
	},
	voices = {
		"story_v_out_416042.awb"
	}
}
