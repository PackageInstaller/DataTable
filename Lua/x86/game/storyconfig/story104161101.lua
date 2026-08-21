return {
	Play416111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416111001
		arg_1_1.duration_ = 14.3

		local var_1_0 = {
			zh = 11.1996666666667,
			ja = 14.2996666666667
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
				arg_1_0:Play416111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "SS1604"

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
				local var_4_5 = arg_1_1.bgs_.SS1604

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
					if iter_4_0 ~= "SS1604" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.66666666666667

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

			local var_4_24 = arg_1_1.bgs_.SS1604.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1604 = var_4_24.localPosition
			end

			local var_4_26 = 0.001

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Vector3.New(0, 1, 10)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1604, var_4_28, var_4_27)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_29 = arg_1_1.bgs_.SS1604.transform
			local var_4_30 = 0.0339999999999999

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1604 = var_4_29.localPosition
			end

			local var_4_31 = 2.29933333333333

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 1, 7)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1604, var_4_33, var_4_32)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 1, 7)
			end

			local var_4_34 = manager.ui.mainCamera.transform
			local var_4_35 = 0.167333333333333

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_36 = arg_1_1.var_.effect1101
				local var_4_37
				local var_4_38 = var_4_34

				if not var_4_36 then
					var_4_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), var_4_38)
					var_4_36.name = "1101"
					arg_1_1.var_.effect1101 = var_4_36
				else
					var_4_36.transform:SetParent(var_4_38)
				end

				var_4_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_39 = 0
			local var_4_40 = 0.2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_44 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_44 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_44

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_44
						arg_1_1.bgmTxt2_.text = var_4_44
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

			local var_4_45 = 0.466666666666667
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if var_4_50 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_50 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_50

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_50
						arg_1_1.bgmTxt2_.text = var_4_50
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

			local var_4_51 = 2.66666666666667
			local var_4_52 = 0.55

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_53 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_53:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_54 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_55 = arg_1_1:GetWordFromCfg(416111001)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.text_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_57 = 22
				local var_4_58 = utf8.len(var_4_56)
				local var_4_59 = var_4_57 <= 0 and var_4_52 or var_4_52 * (var_4_58 / var_4_57)

				if var_4_59 > 0 and var_4_52 < var_4_59 then
					arg_1_1.talkMaxDuration = var_4_59
					var_4_51 = var_4_51 + 0.3

					if var_4_59 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_59 + var_4_51
					end
				end

				arg_1_1.text_.text = var_4_56
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111001", "story_v_out_416111.awb") ~= 0 then
					local var_4_60 = manager.audio:GetVoiceLength("story_v_out_416111", "416111001", "story_v_out_416111.awb") / 1000

					if var_4_60 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_51
					end

					if var_4_55.prefab_name ~= "" and arg_1_1.actors_[var_4_55.prefab_name] ~= nil then
						local var_4_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_55.prefab_name].transform, "story_v_out_416111", "416111001", "story_v_out_416111.awb")

						arg_1_1:RecordAudio("416111001", var_4_61)
						arg_1_1:RecordAudio("416111001", var_4_61)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416111", "416111001", "story_v_out_416111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416111", "416111001", "story_v_out_416111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_51 + 0.3
			local var_4_63 = math.max(var_4_52, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.29933333333333,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416111002
		arg_9_1.duration_ = 4.9

		local var_9_0 = {
			zh = 4.9,
			ja = 3.433
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
				arg_9_0:Play416111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.5

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(416111002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111002", "story_v_out_416111.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111002", "story_v_out_416111.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_416111", "416111002", "story_v_out_416111.awb")

						arg_9_1:RecordAudio("416111002", var_12_9)
						arg_9_1:RecordAudio("416111002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416111", "416111002", "story_v_out_416111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416111", "416111002", "story_v_out_416111.awb")
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
	Play416111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416111003
		arg_13_1.duration_ = 5.5

		local var_13_0 = {
			zh = 5.5,
			ja = 3.333
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
				arg_13_0:Play416111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.525

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(416111003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111003", "story_v_out_416111.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111003", "story_v_out_416111.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_416111", "416111003", "story_v_out_416111.awb")

						arg_13_1:RecordAudio("416111003", var_16_9)
						arg_13_1:RecordAudio("416111003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416111", "416111003", "story_v_out_416111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416111", "416111003", "story_v_out_416111.awb")
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
	Play416111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416111004
		arg_17_1.duration_ = 6.57

		local var_17_0 = {
			zh = 5.933,
			ja = 6.566
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
				arg_17_0:Play416111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1148"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["1148"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.125

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor2.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor2.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor2.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 0.5, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_12 = "10109"

			if arg_17_1.actors_[var_20_12] == nil then
				local var_20_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_20_13) then
					local var_20_14 = Object.Instantiate(var_20_13, arg_17_1.canvasGo_.transform)

					var_20_14.transform:SetSiblingIndex(1)

					var_20_14.name = var_20_12
					var_20_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_12] = var_20_14

					local var_20_15 = var_20_14:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_6, iter_20_7 in ipairs(var_20_15) do
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_16 = arg_17_1.actors_["10109"]
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.actorSpriteComps10109 == nil then
				arg_17_1.var_.actorSpriteComps10109 = var_20_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_18 = 0.125

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_18 and not isNil(var_20_16) then
				local var_20_19 = (arg_17_1.time_ - var_20_17) / var_20_18

				if arg_17_1.var_.actorSpriteComps10109 then
					for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_20_9 then
							if arg_17_1.isInRecall_ then
								local var_20_20 = Mathf.Lerp(iter_20_9.color.r, arg_17_1.hightColor1.r, var_20_19)
								local var_20_21 = Mathf.Lerp(iter_20_9.color.g, arg_17_1.hightColor1.g, var_20_19)
								local var_20_22 = Mathf.Lerp(iter_20_9.color.b, arg_17_1.hightColor1.b, var_20_19)

								iter_20_9.color = Color.New(var_20_20, var_20_21, var_20_22)
							else
								local var_20_23 = Mathf.Lerp(iter_20_9.color.r, 1, var_20_19)

								iter_20_9.color = Color.New(var_20_23, var_20_23, var_20_23)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_17 + var_20_18 and arg_17_1.time_ < var_20_17 + var_20_18 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.actorSpriteComps10109 then
				for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_20_11 then
						if arg_17_1.isInRecall_ then
							iter_20_11.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10109 = nil
			end

			local var_20_24 = 0
			local var_20_25 = 0.675

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_26 = arg_17_1:FormatText(StoryNameCfg[36].name)

				arg_17_1.leftNameTxt_.text = var_20_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_27 = arg_17_1:GetWordFromCfg(416111004)
				local var_20_28 = arg_17_1:FormatText(var_20_27.content)

				arg_17_1.text_.text = var_20_28

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_29 = 27
				local var_20_30 = utf8.len(var_20_28)
				local var_20_31 = var_20_29 <= 0 and var_20_25 or var_20_25 * (var_20_30 / var_20_29)

				if var_20_31 > 0 and var_20_25 < var_20_31 then
					arg_17_1.talkMaxDuration = var_20_31

					if var_20_31 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_24
					end
				end

				arg_17_1.text_.text = var_20_28
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111004", "story_v_out_416111.awb") ~= 0 then
					local var_20_32 = manager.audio:GetVoiceLength("story_v_out_416111", "416111004", "story_v_out_416111.awb") / 1000

					if var_20_32 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_32 + var_20_24
					end

					if var_20_27.prefab_name ~= "" and arg_17_1.actors_[var_20_27.prefab_name] ~= nil then
						local var_20_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_27.prefab_name].transform, "story_v_out_416111", "416111004", "story_v_out_416111.awb")

						arg_17_1:RecordAudio("416111004", var_20_33)
						arg_17_1:RecordAudio("416111004", var_20_33)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416111", "416111004", "story_v_out_416111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416111", "416111004", "story_v_out_416111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_34 = math.max(var_20_25, arg_17_1.talkMaxDuration)

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_34 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_24) / var_20_34

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_24 + var_20_34 and arg_17_1.time_ < var_20_24 + var_20_34 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416111005
		arg_21_1.duration_ = 6.03

		local var_21_0 = {
			zh = 6.033,
			ja = 5
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1148"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.125

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_8 = arg_21_1.actors_["10109"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10109 == nil then
				arg_21_1.var_.actorSpriteComps10109 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.125

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10109 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10109 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10109 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.35

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_19 = arg_21_1:GetWordFromCfg(416111005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 14
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111005", "story_v_out_416111.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_416111", "416111005", "story_v_out_416111.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_416111", "416111005", "story_v_out_416111.awb")

						arg_21_1:RecordAudio("416111005", var_24_25)
						arg_21_1:RecordAudio("416111005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416111", "416111005", "story_v_out_416111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416111", "416111005", "story_v_out_416111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416111006
		arg_25_1.duration_ = 6

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play416111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1148"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 7)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -2000, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_7 = arg_25_1.actors_["10109"].transform
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.var_.moveOldPos10109 = var_28_7.localPosition
				var_28_7.localScale = Vector3.New(1, 1, 1)

				local var_28_9 = var_28_7.childCount

				for iter_28_1 = 0, var_28_9 - 1 do
					local var_28_10 = var_28_7:GetChild(iter_28_1)

					if var_28_10.name == "" or not string.find(var_28_10.name, "split") then
						var_28_10.gameObject:SetActive(true)
					else
						var_28_10.gameObject:SetActive(false)
					end
				end
			end

			local var_28_11 = 0.001

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_8) / var_28_11
				local var_28_13 = Vector3.New(0, 2000, 0)

				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10109, var_28_13, var_28_12)
			end

			if arg_25_1.time_ >= var_28_8 + var_28_11 and arg_25_1.time_ < var_28_8 + var_28_11 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_28_14 = arg_25_1.bgs_.SS1604.transform
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1604 = var_28_14.localPosition
			end

			local var_28_16 = 0.001

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16
				local var_28_18 = Vector3.New(0, 1, 7)

				var_28_14.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1604, var_28_18, var_28_17)
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 then
				var_28_14.localPosition = Vector3.New(0, 1, 7)
			end

			local var_28_19 = arg_25_1.bgs_.SS1604.transform
			local var_28_20 = 0.0339999999999999

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1604 = var_28_19.localPosition
			end

			local var_28_21 = 0.966

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_21 then
				local var_28_22 = (arg_25_1.time_ - var_28_20) / var_28_21
				local var_28_23 = Vector3.New(0, 1, 5)

				var_28_19.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1604, var_28_23, var_28_22)
			end

			if arg_25_1.time_ >= var_28_20 + var_28_21 and arg_25_1.time_ < var_28_20 + var_28_21 + arg_28_0 then
				var_28_19.localPosition = Vector3.New(0, 1, 5)
			end

			local var_28_24 = 0.9
			local var_28_25 = 1

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 then
				local var_28_26 = "play"
				local var_28_27 = "effect"

				arg_25_1:AudioAction(var_28_26, var_28_27, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_28 = 1
			local var_28_29 = 1.2

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_30 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_30:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_31 = arg_25_1:GetWordFromCfg(416111006)
				local var_28_32 = arg_25_1:FormatText(var_28_31.content)

				arg_25_1.text_.text = var_28_32

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_33 = 48
				local var_28_34 = utf8.len(var_28_32)
				local var_28_35 = var_28_33 <= 0 and var_28_29 or var_28_29 * (var_28_34 / var_28_33)

				if var_28_35 > 0 and var_28_29 < var_28_35 then
					arg_25_1.talkMaxDuration = var_28_35
					var_28_28 = var_28_28 + 0.3

					if var_28_35 + var_28_28 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_28
					end
				end

				arg_25_1.text_.text = var_28_32
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_36 = var_28_28 + 0.3
			local var_28_37 = math.max(var_28_29, arg_25_1.talkMaxDuration)

			if var_28_36 <= arg_25_1.time_ and arg_25_1.time_ < var_28_36 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_36) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_36 + var_28_37 and arg_25_1.time_ < var_28_36 + var_28_37 + arg_28_0 then
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
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play416111007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416111007
		arg_31_1.duration_ = 9.27

		local var_31_0 = {
			zh = 9.266,
			ja = 5.533
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
				arg_31_0:Play416111008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.6

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[36].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(416111007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111007", "story_v_out_416111.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111007", "story_v_out_416111.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_416111", "416111007", "story_v_out_416111.awb")

						arg_31_1:RecordAudio("416111007", var_34_9)
						arg_31_1:RecordAudio("416111007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416111", "416111007", "story_v_out_416111.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416111", "416111007", "story_v_out_416111.awb")
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
	Play416111008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416111008
		arg_35_1.duration_ = 5.83

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416111009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = manager.ui.mainCamera.transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_0.localPosition
			end

			local var_38_2 = 0.0666666666666667

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / 0.033
				local var_38_4, var_38_5 = math.modf(var_38_3)

				var_38_0.localPosition = Vector3.New(var_38_5 * 0.3, var_38_5 * 0.3, var_38_5 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_6 = manager.ui.mainCamera.transform
			local var_38_7 = 0

			if var_38_7 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 then
				local var_38_8 = arg_35_1.var_.effect1102
				local var_38_9
				local var_38_10 = var_38_6

				if not var_38_8 then
					var_38_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_38_10)
					var_38_8.name = "1102"
					arg_35_1.var_.effect1102 = var_38_8
				else
					var_38_8.transform:SetParent(var_38_10)
				end

				var_38_8.transform.localPosition = Vector3.New(0.06, 0, 1)
				var_38_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_38_11 = manager.ui.mainCamera.transform
			local var_38_12 = 1.33333333333333

			if var_38_12 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				local var_38_13 = arg_35_1.var_.effect1102

				if var_38_13 then
					Object.Destroy(var_38_13)

					arg_35_1.var_.effect1102 = nil
				end
			end

			local var_38_14 = manager.ui.mainCamera.transform
			local var_38_15 = 0.133333333333333

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_14.localPosition
			end

			local var_38_16 = 0.0666666666666667

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_16 then
				local var_38_17 = (arg_35_1.time_ - var_38_15) / 0.033
				local var_38_18, var_38_19 = math.modf(var_38_17)

				var_38_14.localPosition = Vector3.New(var_38_19 * 0.3, var_38_19 * 0.3, var_38_19 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_15 + var_38_16 and arg_35_1.time_ < var_38_15 + var_38_16 + arg_38_0 then
				var_38_14.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_20 = manager.ui.mainCamera.transform
			local var_38_21 = 0.133333333333333

			if var_38_21 < arg_35_1.time_ and arg_35_1.time_ <= var_38_21 + arg_38_0 then
				local var_38_22 = arg_35_1.var_.effect1103
				local var_38_23
				local var_38_24 = var_38_20

				if not var_38_22 then
					var_38_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_38_24)
					var_38_22.name = "1103"
					arg_35_1.var_.effect1103 = var_38_22
				else
					var_38_22.transform:SetParent(var_38_24)
				end

				var_38_22.transform.localPosition = Vector3.New(-0.82, -0.4, 1.1)
				var_38_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_38_25 = manager.ui.mainCamera.transform
			local var_38_26 = 1.33333333333333

			if var_38_26 < arg_35_1.time_ and arg_35_1.time_ <= var_38_26 + arg_38_0 then
				local var_38_27 = arg_35_1.var_.effect1103

				if var_38_27 then
					Object.Destroy(var_38_27)

					arg_35_1.var_.effect1103 = nil
				end
			end

			local var_38_28 = manager.ui.mainCamera.transform
			local var_38_29 = 0.266666666666667

			if var_38_29 < arg_35_1.time_ and arg_35_1.time_ <= var_38_29 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_28.localPosition
			end

			local var_38_30 = 0.0666666666666667

			if var_38_29 <= arg_35_1.time_ and arg_35_1.time_ < var_38_29 + var_38_30 then
				local var_38_31 = (arg_35_1.time_ - var_38_29) / 0.033
				local var_38_32, var_38_33 = math.modf(var_38_31)

				var_38_28.localPosition = Vector3.New(var_38_33 * 0.3, var_38_33 * 0.3, var_38_33 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_29 + var_38_30 and arg_35_1.time_ < var_38_29 + var_38_30 + arg_38_0 then
				var_38_28.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_34 = manager.ui.mainCamera.transform
			local var_38_35 = 0.266666666666667

			if var_38_35 < arg_35_1.time_ and arg_35_1.time_ <= var_38_35 + arg_38_0 then
				local var_38_36 = arg_35_1.var_.effect1104
				local var_38_37
				local var_38_38 = var_38_34

				if not var_38_36 then
					var_38_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_38_38)
					var_38_36.name = "1104"
					arg_35_1.var_.effect1104 = var_38_36
				else
					var_38_36.transform:SetParent(var_38_38)
				end

				var_38_36.transform.localPosition = Vector3.New(0.05, 0.21, 1)
				var_38_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_38_39 = manager.ui.mainCamera.transform
			local var_38_40 = 1.33333333333333

			if var_38_40 < arg_35_1.time_ and arg_35_1.time_ <= var_38_40 + arg_38_0 then
				local var_38_41 = arg_35_1.var_.effect1104

				if var_38_41 then
					Object.Destroy(var_38_41)

					arg_35_1.var_.effect1104 = nil
				end
			end

			local var_38_42 = manager.ui.mainCamera.transform
			local var_38_43 = 0.4

			if var_38_43 < arg_35_1.time_ and arg_35_1.time_ <= var_38_43 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_42.localPosition
			end

			local var_38_44 = 0.0666666666666667

			if var_38_43 <= arg_35_1.time_ and arg_35_1.time_ < var_38_43 + var_38_44 then
				local var_38_45 = (arg_35_1.time_ - var_38_43) / 0.033
				local var_38_46, var_38_47 = math.modf(var_38_45)

				var_38_42.localPosition = Vector3.New(var_38_47 * 0.3, var_38_47 * 0.3, var_38_47 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_43 + var_38_44 and arg_35_1.time_ < var_38_43 + var_38_44 + arg_38_0 then
				var_38_42.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_48 = manager.ui.mainCamera.transform
			local var_38_49 = 0.4

			if var_38_49 < arg_35_1.time_ and arg_35_1.time_ <= var_38_49 + arg_38_0 then
				local var_38_50 = arg_35_1.var_.effect1105
				local var_38_51
				local var_38_52 = var_38_48

				if not var_38_50 then
					var_38_50 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_38_52)
					var_38_50.name = "1105"
					arg_35_1.var_.effect1105 = var_38_50
				else
					var_38_50.transform:SetParent(var_38_52)
				end

				var_38_50.transform.localPosition = Vector3.New(0.36, -0.37, 1.5)
				var_38_50.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_38_53 = manager.ui.mainCamera.transform
			local var_38_54 = 1.33333333333333

			if var_38_54 < arg_35_1.time_ and arg_35_1.time_ <= var_38_54 + arg_38_0 then
				local var_38_55 = arg_35_1.var_.effect1105

				if var_38_55 then
					Object.Destroy(var_38_55)

					arg_35_1.var_.effect1105 = nil
				end
			end

			local var_38_56 = 0
			local var_38_57 = 1

			if var_38_56 < arg_35_1.time_ and arg_35_1.time_ <= var_38_56 + arg_38_0 then
				local var_38_58 = "play"
				local var_38_59 = "effect"

				arg_35_1:AudioAction(var_38_58, var_38_59, "se_story_15", "se_story_15_gun02", "")
			end

			local var_38_60 = 0.5
			local var_38_61 = 1

			if var_38_60 < arg_35_1.time_ and arg_35_1.time_ <= var_38_60 + arg_38_0 then
				local var_38_62 = "play"
				local var_38_63 = "effect"

				arg_35_1:AudioAction(var_38_62, var_38_63, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_64 = 0.833333333333333
			local var_38_65 = 1.3

			if var_38_64 < arg_35_1.time_ and arg_35_1.time_ <= var_38_64 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_66 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_66:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_67 = arg_35_1:GetWordFromCfg(416111008)
				local var_38_68 = arg_35_1:FormatText(var_38_67.content)

				arg_35_1.text_.text = var_38_68

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_69 = 52
				local var_38_70 = utf8.len(var_38_68)
				local var_38_71 = var_38_69 <= 0 and var_38_65 or var_38_65 * (var_38_70 / var_38_69)

				if var_38_71 > 0 and var_38_65 < var_38_71 then
					arg_35_1.talkMaxDuration = var_38_71
					var_38_64 = var_38_64 + 0.3

					if var_38_71 + var_38_64 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_71 + var_38_64
					end
				end

				arg_35_1.text_.text = var_38_68
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_72 = var_38_64 + 0.3
			local var_38_73 = math.max(var_38_65, arg_35_1.talkMaxDuration)

			if var_38_72 <= arg_35_1.time_ and arg_35_1.time_ < var_38_72 + var_38_73 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_72) / var_38_73

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_72 + var_38_73 and arg_35_1.time_ < var_38_72 + var_38_73 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play416111009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416111009
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play416111010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.65

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

				local var_44_2 = arg_41_1:GetWordFromCfg(416111009)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 66
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
	Play416111010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416111010
		arg_45_1.duration_ = 5.37

		local var_45_0 = {
			zh = 4.333,
			ja = 5.366
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
				arg_45_0:Play416111011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[36].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(416111010)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 14
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111010", "story_v_out_416111.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111010", "story_v_out_416111.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_416111", "416111010", "story_v_out_416111.awb")

						arg_45_1:RecordAudio("416111010", var_48_9)
						arg_45_1:RecordAudio("416111010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416111", "416111010", "story_v_out_416111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416111", "416111010", "story_v_out_416111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416111011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416111011
		arg_49_1.duration_ = 4.5

		local var_49_0 = {
			zh = 4.5,
			ja = 3.3
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
				arg_49_0:Play416111012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.6

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[8].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_4")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(416111011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111011", "story_v_out_416111.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111011", "story_v_out_416111.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_416111", "416111011", "story_v_out_416111.awb")

						arg_49_1:RecordAudio("416111011", var_52_9)
						arg_49_1:RecordAudio("416111011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416111", "416111011", "story_v_out_416111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416111", "416111011", "story_v_out_416111.awb")
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
	Play416111012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416111012
		arg_53_1.duration_ = 3.97

		local var_53_0 = {
			zh = 3.833,
			ja = 3.966
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
				arg_53_0:Play416111013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.475

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(416111012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111012", "story_v_out_416111.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111012", "story_v_out_416111.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_416111", "416111012", "story_v_out_416111.awb")

						arg_53_1:RecordAudio("416111012", var_56_9)
						arg_53_1:RecordAudio("416111012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416111", "416111012", "story_v_out_416111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416111", "416111012", "story_v_out_416111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416111013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416111013
		arg_57_1.duration_ = 6.13

		local var_57_0 = {
			zh = 3.733,
			ja = 6.133
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
				arg_57_0:Play416111014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.5

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[8].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(416111013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111013", "story_v_out_416111.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111013", "story_v_out_416111.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_416111", "416111013", "story_v_out_416111.awb")

						arg_57_1:RecordAudio("416111013", var_60_9)
						arg_57_1:RecordAudio("416111013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416111", "416111013", "story_v_out_416111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416111", "416111013", "story_v_out_416111.awb")
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
	Play416111014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416111014
		arg_61_1.duration_ = 5.77

		local var_61_0 = {
			zh = 3.5,
			ja = 5.766
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
				arg_61_0:Play416111015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.25

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[36].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(416111014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111014", "story_v_out_416111.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111014", "story_v_out_416111.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_416111", "416111014", "story_v_out_416111.awb")

						arg_61_1:RecordAudio("416111014", var_64_9)
						arg_61_1:RecordAudio("416111014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416111", "416111014", "story_v_out_416111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416111", "416111014", "story_v_out_416111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416111015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416111015
		arg_65_1.duration_ = 3.07

		local var_65_0 = {
			zh = 2.766,
			ja = 3.066
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
				arg_65_0:Play416111016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.225

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[8].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(416111015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111015", "story_v_out_416111.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111015", "story_v_out_416111.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_416111", "416111015", "story_v_out_416111.awb")

						arg_65_1:RecordAudio("416111015", var_68_9)
						arg_65_1:RecordAudio("416111015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416111", "416111015", "story_v_out_416111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416111", "416111015", "story_v_out_416111.awb")
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
	Play416111016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416111016
		arg_69_1.duration_ = 5.67

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play416111017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = manager.ui.mainCamera.transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				local var_72_2 = arg_69_1.var_.effect1106
				local var_72_3
				local var_72_4 = var_72_0

				if not var_72_2 then
					var_72_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_72_4)
					var_72_2.name = "1106"
					arg_69_1.var_.effect1106 = var_72_2
				else
					var_72_2.transform:SetParent(var_72_4)
				end

				var_72_2.transform.localPosition = Vector3.New(-0.09, -0.31, 0)
				var_72_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_5 = manager.ui.mainCamera.transform
			local var_72_6 = 2.03333333333333

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				local var_72_7 = arg_69_1.var_.effect1106

				if var_72_7 then
					Object.Destroy(var_72_7)

					arg_69_1.var_.effect1106 = nil
				end
			end

			local var_72_8 = manager.ui.mainCamera.transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_8.localPosition
			end

			local var_72_10 = 0.6

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / 0.066
				local var_72_12, var_72_13 = math.modf(var_72_11)

				var_72_8.localPosition = Vector3.New(var_72_13 * 0.13, var_72_13 * 0.13, var_72_13 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = arg_69_1.var_.shakeOldPos
			end

			local var_72_14 = 0
			local var_72_15 = 1

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				local var_72_16 = "play"
				local var_72_17 = "effect"

				arg_69_1:AudioAction(var_72_16, var_72_17, "se_story_131", "se_story_131__explosion", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_18 = 0.666666666666667
			local var_72_19 = 1.6

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_20 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_20:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_21 = arg_69_1:GetWordFromCfg(416111016)
				local var_72_22 = arg_69_1:FormatText(var_72_21.content)

				arg_69_1.text_.text = var_72_22

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_23 = 64
				local var_72_24 = utf8.len(var_72_22)
				local var_72_25 = var_72_23 <= 0 and var_72_19 or var_72_19 * (var_72_24 / var_72_23)

				if var_72_25 > 0 and var_72_19 < var_72_25 then
					arg_69_1.talkMaxDuration = var_72_25
					var_72_18 = var_72_18 + 0.3

					if var_72_25 + var_72_18 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_25 + var_72_18
					end
				end

				arg_69_1.text_.text = var_72_22
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_26 = var_72_18 + 0.3
			local var_72_27 = math.max(var_72_19, arg_69_1.talkMaxDuration)

			if var_72_26 <= arg_69_1.time_ and arg_69_1.time_ < var_72_26 + var_72_27 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_26) / var_72_27

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_26 + var_72_27 and arg_69_1.time_ < var_72_26 + var_72_27 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416111017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416111017
		arg_75_1.duration_ = 7.53

		local var_75_0 = {
			zh = 6.266,
			ja = 7.533
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play416111018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.425

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[36].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(416111017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 17
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111017", "story_v_out_416111.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111017", "story_v_out_416111.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_416111", "416111017", "story_v_out_416111.awb")

						arg_75_1:RecordAudio("416111017", var_78_9)
						arg_75_1:RecordAudio("416111017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416111", "416111017", "story_v_out_416111.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416111", "416111017", "story_v_out_416111.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416111018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416111018
		arg_79_1.duration_ = 9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416111019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 4

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_1 = 0.3

			if arg_79_1.time_ >= var_82_0 + var_82_1 and arg_79_1.time_ < var_82_0 + var_82_1 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_2 = "I13f"

			if arg_79_1.bgs_[var_82_2] == nil then
				local var_82_3 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_2)
				var_82_3.name = var_82_2
				var_82_3.transform.parent = arg_79_1.stage_.transform
				var_82_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_2] = var_82_3
			end

			local var_82_4 = 2

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				local var_82_5 = manager.ui.mainCamera.transform.localPosition
				local var_82_6 = Vector3.New(0, 0, 10) + Vector3.New(var_82_5.x, var_82_5.y, 0)
				local var_82_7 = arg_79_1.bgs_.I13f

				var_82_7.transform.localPosition = var_82_6
				var_82_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_8 = var_82_7:GetComponent("SpriteRenderer")

				if var_82_8 and var_82_8.sprite then
					local var_82_9 = (var_82_7.transform.localPosition - var_82_5).z
					local var_82_10 = manager.ui.mainCameraCom_
					local var_82_11 = 2 * var_82_9 * Mathf.Tan(var_82_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_12 = var_82_11 * var_82_10.aspect
					local var_82_13 = var_82_8.sprite.bounds.size.x
					local var_82_14 = var_82_8.sprite.bounds.size.y
					local var_82_15 = var_82_12 / var_82_13
					local var_82_16 = var_82_11 / var_82_14
					local var_82_17 = var_82_16 < var_82_15 and var_82_15 or var_82_16

					var_82_7.transform.localScale = Vector3.New(var_82_17, var_82_17, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I13f" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_18 = 0

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_19 = 2

			if var_82_18 <= arg_79_1.time_ and arg_79_1.time_ < var_82_18 + var_82_19 then
				local var_82_20 = (arg_79_1.time_ - var_82_18) / var_82_19
				local var_82_21 = Color.New(0, 0, 0)

				var_82_21.a = Mathf.Lerp(0, 1, var_82_20)
				arg_79_1.mask_.color = var_82_21
			end

			if arg_79_1.time_ >= var_82_18 + var_82_19 and arg_79_1.time_ < var_82_18 + var_82_19 + arg_82_0 then
				local var_82_22 = Color.New(0, 0, 0)

				var_82_22.a = 1
				arg_79_1.mask_.color = var_82_22
			end

			local var_82_23 = 2

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_24 = 2

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_24 then
				local var_82_25 = (arg_79_1.time_ - var_82_23) / var_82_24
				local var_82_26 = Color.New(0, 0, 0)

				var_82_26.a = Mathf.Lerp(1, 0, var_82_25)
				arg_79_1.mask_.color = var_82_26
			end

			if arg_79_1.time_ >= var_82_23 + var_82_24 and arg_79_1.time_ < var_82_23 + var_82_24 + arg_82_0 then
				local var_82_27 = Color.New(0, 0, 0)
				local var_82_28 = 0

				arg_79_1.mask_.enabled = false
				var_82_27.a = var_82_28
				arg_79_1.mask_.color = var_82_27
			end

			local var_82_29 = manager.ui.mainCamera.transform
			local var_82_30 = 1.83333333333333

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				local var_82_31 = arg_79_1.var_.effect1101

				if var_82_31 then
					Object.Destroy(var_82_31)

					arg_79_1.var_.effect1101 = nil
				end
			end

			local var_82_32 = 3.8
			local var_82_33 = 1

			if var_82_32 < arg_79_1.time_ and arg_79_1.time_ <= var_82_32 + arg_82_0 then
				local var_82_34 = "play"
				local var_82_35 = "effect"

				arg_79_1:AudioAction(var_82_34, var_82_35, "se_story_122_01", "se_story_122_01_shield", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_36 = 4
			local var_82_37 = 1.575

			if var_82_36 < arg_79_1.time_ and arg_79_1.time_ <= var_82_36 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_38 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_38:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_39 = arg_79_1:GetWordFromCfg(416111018)
				local var_82_40 = arg_79_1:FormatText(var_82_39.content)

				arg_79_1.text_.text = var_82_40

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_41 = 63
				local var_82_42 = utf8.len(var_82_40)
				local var_82_43 = var_82_41 <= 0 and var_82_37 or var_82_37 * (var_82_42 / var_82_41)

				if var_82_43 > 0 and var_82_37 < var_82_43 then
					arg_79_1.talkMaxDuration = var_82_43
					var_82_36 = var_82_36 + 0.3

					if var_82_43 + var_82_36 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_43 + var_82_36
					end
				end

				arg_79_1.text_.text = var_82_40
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_44 = var_82_36 + 0.3
			local var_82_45 = math.max(var_82_37, arg_79_1.talkMaxDuration)

			if var_82_44 <= arg_79_1.time_ and arg_79_1.time_ < var_82_44 + var_82_45 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_44) / var_82_45

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_44 + var_82_45 and arg_79_1.time_ < var_82_44 + var_82_45 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play416111019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416111019
		arg_85_1.duration_ = 8.3

		local var_85_0 = {
			zh = 5.266,
			ja = 8.3
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
				arg_85_0:Play416111020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10109"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10109 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10109", 3)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -346.2, -395)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10109, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_88_7 = arg_85_1.actors_["10109"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10109 == nil then
				arg_85_1.var_.actorSpriteComps10109 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.125

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps10109 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10109 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10109 = nil
			end

			local var_88_15 = 0
			local var_88_16 = 0.425

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[36].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(416111019)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 17
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111019", "story_v_out_416111.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111019", "story_v_out_416111.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_416111", "416111019", "story_v_out_416111.awb")

						arg_85_1:RecordAudio("416111019", var_88_24)
						arg_85_1:RecordAudio("416111019", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416111", "416111019", "story_v_out_416111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416111", "416111019", "story_v_out_416111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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
	Play416111020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416111020
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 4.4,
			ja = 3.7
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
				arg_89_0:Play416111021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10109"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10109 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10109", 2)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(-390, -346.2, -395)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10109, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_92_7 = arg_89_1.actors_["10109"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10109 == nil then
				arg_89_1.var_.actorSpriteComps10109 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.125

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps10109 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 0.5, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10109 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10109 = nil
			end

			local var_92_15 = arg_89_1.actors_["1148"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1148 == nil then
				arg_89_1.var_.actorSpriteComps1148 = var_92_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_17 = 0.125

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.actorSpriteComps1148 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								local var_92_19 = Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor1.r, var_92_18)
								local var_92_20 = Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor1.g, var_92_18)
								local var_92_21 = Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor1.b, var_92_18)

								iter_92_6.color = Color.New(var_92_19, var_92_20, var_92_21)
							else
								local var_92_22 = Mathf.Lerp(iter_92_6.color.r, 1, var_92_18)

								iter_92_6.color = Color.New(var_92_22, var_92_22, var_92_22)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1148 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_92_8 then
						if arg_89_1.isInRecall_ then
							iter_92_8.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1148 = nil
			end

			local var_92_23 = arg_89_1.actors_["1148"].transform
			local var_92_24 = 0

			if var_92_24 < arg_89_1.time_ and arg_89_1.time_ <= var_92_24 + arg_92_0 then
				arg_89_1.var_.moveOldPos1148 = var_92_23.localPosition
				var_92_23.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1148", 4)

				local var_92_25 = var_92_23.childCount

				for iter_92_9 = 0, var_92_25 - 1 do
					local var_92_26 = var_92_23:GetChild(iter_92_9)

					if var_92_26.name == "split_5" or not string.find(var_92_26.name, "split") then
						var_92_26.gameObject:SetActive(true)
					else
						var_92_26.gameObject:SetActive(false)
					end
				end
			end

			local var_92_27 = 0.001

			if var_92_24 <= arg_89_1.time_ and arg_89_1.time_ < var_92_24 + var_92_27 then
				local var_92_28 = (arg_89_1.time_ - var_92_24) / var_92_27
				local var_92_29 = Vector3.New(390, -429, -180)

				var_92_23.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1148, var_92_29, var_92_28)
			end

			if arg_89_1.time_ >= var_92_24 + var_92_27 and arg_89_1.time_ < var_92_24 + var_92_27 + arg_92_0 then
				var_92_23.localPosition = Vector3.New(390, -429, -180)
			end

			local var_92_30 = 0
			local var_92_31 = 0.35

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_32 = arg_89_1:FormatText(StoryNameCfg[8].name)

				arg_89_1.leftNameTxt_.text = var_92_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_33 = arg_89_1:GetWordFromCfg(416111020)
				local var_92_34 = arg_89_1:FormatText(var_92_33.content)

				arg_89_1.text_.text = var_92_34

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_35 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111020", "story_v_out_416111.awb") ~= 0 then
					local var_92_38 = manager.audio:GetVoiceLength("story_v_out_416111", "416111020", "story_v_out_416111.awb") / 1000

					if var_92_38 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_30
					end

					if var_92_33.prefab_name ~= "" and arg_89_1.actors_[var_92_33.prefab_name] ~= nil then
						local var_92_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_33.prefab_name].transform, "story_v_out_416111", "416111020", "story_v_out_416111.awb")

						arg_89_1:RecordAudio("416111020", var_92_39)
						arg_89_1:RecordAudio("416111020", var_92_39)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416111", "416111020", "story_v_out_416111.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416111", "416111020", "story_v_out_416111.awb")
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
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_89_1:InitPlayNodeList()
	end,
	Play416111021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416111021
		arg_93_1.duration_ = 4.17

		local var_93_0 = {
			zh = 4.166,
			ja = 3.666
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
				arg_93_0:Play416111022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.325

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(416111021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111021", "story_v_out_416111.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111021", "story_v_out_416111.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_416111", "416111021", "story_v_out_416111.awb")

						arg_93_1:RecordAudio("416111021", var_96_9)
						arg_93_1:RecordAudio("416111021", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416111", "416111021", "story_v_out_416111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416111", "416111021", "story_v_out_416111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416111022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416111022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416111023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1148"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1148 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1148", 7)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -2000, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1148, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_7 = arg_97_1.actors_["10109"].transform
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.var_.moveOldPos10109 = var_100_7.localPosition
				var_100_7.localScale = Vector3.New(1, 1, 1)

				local var_100_9 = var_100_7.childCount

				for iter_100_1 = 0, var_100_9 - 1 do
					local var_100_10 = var_100_7:GetChild(iter_100_1)

					if var_100_10.name == "" or not string.find(var_100_10.name, "split") then
						var_100_10.gameObject:SetActive(true)
					else
						var_100_10.gameObject:SetActive(false)
					end
				end
			end

			local var_100_11 = 0.001

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_8) / var_100_11
				local var_100_13 = Vector3.New(0, 2000, 0)

				var_100_7.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10109, var_100_13, var_100_12)
			end

			if arg_97_1.time_ >= var_100_8 + var_100_11 and arg_97_1.time_ < var_100_8 + var_100_11 + arg_100_0 then
				var_100_7.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_100_14 = 0
			local var_100_15 = 1.4

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_16 = arg_97_1:GetWordFromCfg(416111022)
				local var_100_17 = arg_97_1:FormatText(var_100_16.content)

				arg_97_1.text_.text = var_100_17

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_18 = 56
				local var_100_19 = utf8.len(var_100_17)
				local var_100_20 = var_100_18 <= 0 and var_100_15 or var_100_15 * (var_100_19 / var_100_18)

				if var_100_20 > 0 and var_100_15 < var_100_20 then
					arg_97_1.talkMaxDuration = var_100_20

					if var_100_20 + var_100_14 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_20 + var_100_14
					end
				end

				arg_97_1.text_.text = var_100_17
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_21 = math.max(var_100_15, arg_97_1.talkMaxDuration)

			if var_100_14 <= arg_97_1.time_ and arg_97_1.time_ < var_100_14 + var_100_21 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_14) / var_100_21

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_14 + var_100_21 and arg_97_1.time_ < var_100_14 + var_100_21 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play416111023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416111023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play416111024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.275

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(416111023)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 51
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416111024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416111024
		arg_105_1.duration_ = 5.67

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play416111025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = manager.ui.mainCamera.transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.shakeOldPos = var_108_0.localPosition
			end

			local var_108_2 = 0.266666666666667

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / 0.066
				local var_108_4, var_108_5 = math.modf(var_108_3)

				var_108_0.localPosition = Vector3.New(var_108_5 * 0.13, var_108_5 * 0.13, var_108_5 * 0.13) + arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = arg_105_1.var_.shakeOldPos
			end

			local var_108_6 = manager.ui.mainCamera.transform
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				local var_108_8 = arg_105_1.var_.effect1102
				local var_108_9
				local var_108_10 = var_108_6

				if not var_108_8 then
					var_108_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_108_10)
					var_108_8.name = "1102"
					arg_105_1.var_.effect1102 = var_108_8
				else
					var_108_8.transform:SetParent(var_108_10)
				end

				var_108_8.transform.localPosition = Vector3.New(0.06, -0.18, 1)
				var_108_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_108_11 = manager.ui.mainCamera.transform
			local var_108_12 = 1.3

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				local var_108_13 = arg_105_1.var_.effect1102

				if var_108_13 then
					Object.Destroy(var_108_13)

					arg_105_1.var_.effect1102 = nil
				end
			end

			local var_108_14 = 0.133333333333333
			local var_108_15 = 1

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				local var_108_16 = "play"
				local var_108_17 = "effect"

				arg_105_1:AudioAction(var_108_16, var_108_17, "se_story_15", "se_story_15_gun02", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_18 = 0.666666666666667
			local var_108_19 = 1.975

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_20 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_20:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_21 = arg_105_1:GetWordFromCfg(416111024)
				local var_108_22 = arg_105_1:FormatText(var_108_21.content)

				arg_105_1.text_.text = var_108_22

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_23 = 79
				local var_108_24 = utf8.len(var_108_22)
				local var_108_25 = var_108_23 <= 0 and var_108_19 or var_108_19 * (var_108_24 / var_108_23)

				if var_108_25 > 0 and var_108_19 < var_108_25 then
					arg_105_1.talkMaxDuration = var_108_25
					var_108_18 = var_108_18 + 0.3

					if var_108_25 + var_108_18 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_25 + var_108_18
					end
				end

				arg_105_1.text_.text = var_108_22
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = var_108_18 + 0.3
			local var_108_27 = math.max(var_108_19, arg_105_1.talkMaxDuration)

			if var_108_26 <= arg_105_1.time_ and arg_105_1.time_ < var_108_26 + var_108_27 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_26) / var_108_27

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_26 + var_108_27 and arg_105_1.time_ < var_108_26 + var_108_27 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play416111025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416111025
		arg_111_1.duration_ = 4.5

		local var_111_0 = {
			zh = 4.5,
			ja = 3.733
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
				arg_111_0:Play416111026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10109"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10109 == nil then
				arg_111_1.var_.actorSpriteComps10109 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.125

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10109 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 1, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10109 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10109 = nil
			end

			local var_114_8 = arg_111_1.actors_["10109"].transform
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.var_.moveOldPos10109 = var_114_8.localPosition
				var_114_8.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10109", 3)

				local var_114_10 = var_114_8.childCount

				for iter_114_4 = 0, var_114_10 - 1 do
					local var_114_11 = var_114_8:GetChild(iter_114_4)

					if var_114_11.name == "" or not string.find(var_114_11.name, "split") then
						var_114_11.gameObject:SetActive(true)
					else
						var_114_11.gameObject:SetActive(false)
					end
				end
			end

			local var_114_12 = 0.001

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_12 then
				local var_114_13 = (arg_111_1.time_ - var_114_9) / var_114_12
				local var_114_14 = Vector3.New(0, -346.2, -395)

				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10109, var_114_14, var_114_13)
			end

			if arg_111_1.time_ >= var_114_9 + var_114_12 and arg_111_1.time_ < var_114_9 + var_114_12 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_114_15 = arg_111_1.actors_["1148"]
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps1148 == nil then
				arg_111_1.var_.actorSpriteComps1148 = var_114_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_17 = 0.125

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 and not isNil(var_114_15) then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17

				if arg_111_1.var_.actorSpriteComps1148 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								local var_114_19 = Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, var_114_18)
								local var_114_20 = Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, var_114_18)
								local var_114_21 = Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, var_114_18)

								iter_114_6.color = Color.New(var_114_19, var_114_20, var_114_21)
							else
								local var_114_22 = Mathf.Lerp(iter_114_6.color.r, 0.5, var_114_18)

								iter_114_6.color = Color.New(var_114_22, var_114_22, var_114_22)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps1148 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_114_8 then
						if arg_111_1.isInRecall_ then
							iter_114_8.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1148 = nil
			end

			local var_114_23 = 0
			local var_114_24 = 0.325

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_25 = arg_111_1:FormatText(StoryNameCfg[36].name)

				arg_111_1.leftNameTxt_.text = var_114_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_26 = arg_111_1:GetWordFromCfg(416111025)
				local var_114_27 = arg_111_1:FormatText(var_114_26.content)

				arg_111_1.text_.text = var_114_27

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_28 = 13
				local var_114_29 = utf8.len(var_114_27)
				local var_114_30 = var_114_28 <= 0 and var_114_24 or var_114_24 * (var_114_29 / var_114_28)

				if var_114_30 > 0 and var_114_24 < var_114_30 then
					arg_111_1.talkMaxDuration = var_114_30

					if var_114_30 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_23
					end
				end

				arg_111_1.text_.text = var_114_27
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111025", "story_v_out_416111.awb") ~= 0 then
					local var_114_31 = manager.audio:GetVoiceLength("story_v_out_416111", "416111025", "story_v_out_416111.awb") / 1000

					if var_114_31 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_31 + var_114_23
					end

					if var_114_26.prefab_name ~= "" and arg_111_1.actors_[var_114_26.prefab_name] ~= nil then
						local var_114_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_26.prefab_name].transform, "story_v_out_416111", "416111025", "story_v_out_416111.awb")

						arg_111_1:RecordAudio("416111025", var_114_32)
						arg_111_1:RecordAudio("416111025", var_114_32)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416111", "416111025", "story_v_out_416111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416111", "416111025", "story_v_out_416111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_33 = math.max(var_114_24, arg_111_1.talkMaxDuration)

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_33 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_23) / var_114_33

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_23 + var_114_33 and arg_111_1.time_ < var_114_23 + var_114_33 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play416111026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416111026
		arg_115_1.duration_ = 5.2

		local var_115_0 = {
			zh = 4.133,
			ja = 5.2
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
				arg_115_0:Play416111027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10109"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10109 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10109", 2)

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
				local var_118_6 = Vector3.New(-390, -346.2, -395)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10109, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_118_7 = "10108"

			if arg_115_1.actors_[var_118_7] == nil then
				local var_118_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_118_8) then
					local var_118_9 = Object.Instantiate(var_118_8, arg_115_1.canvasGo_.transform)

					var_118_9.transform:SetSiblingIndex(1)

					var_118_9.name = var_118_7
					var_118_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_7] = var_118_9

					local var_118_10 = var_118_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_115_1.isInRecall_ then
						for iter_118_1, iter_118_2 in ipairs(var_118_10) do
							iter_118_2.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_11 = arg_115_1.actors_["10108"].transform
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPos10108 = var_118_11.localPosition
				var_118_11.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10108", 4)

				local var_118_13 = var_118_11.childCount

				for iter_118_3 = 0, var_118_13 - 1 do
					local var_118_14 = var_118_11:GetChild(iter_118_3)

					if var_118_14.name == "split_3" or not string.find(var_118_14.name, "split") then
						var_118_14.gameObject:SetActive(true)
					else
						var_118_14.gameObject:SetActive(false)
					end
				end
			end

			local var_118_15 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_15 then
				local var_118_16 = (arg_115_1.time_ - var_118_12) / var_118_15
				local var_118_17 = Vector3.New(390, -399.6, -130)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10108, var_118_17, var_118_16)
			end

			if arg_115_1.time_ >= var_118_12 + var_118_15 and arg_115_1.time_ < var_118_12 + var_118_15 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_118_18 = arg_115_1.actors_["10108"]
			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.actorSpriteComps10108 == nil then
				arg_115_1.var_.actorSpriteComps10108 = var_118_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_20 = 0.125

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_20 and not isNil(var_118_18) then
				local var_118_21 = (arg_115_1.time_ - var_118_19) / var_118_20

				if arg_115_1.var_.actorSpriteComps10108 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								local var_118_22 = Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor1.r, var_118_21)
								local var_118_23 = Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor1.g, var_118_21)
								local var_118_24 = Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor1.b, var_118_21)

								iter_118_5.color = Color.New(var_118_22, var_118_23, var_118_24)
							else
								local var_118_25 = Mathf.Lerp(iter_118_5.color.r, 1, var_118_21)

								iter_118_5.color = Color.New(var_118_25, var_118_25, var_118_25)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_19 + var_118_20 and arg_115_1.time_ < var_118_19 + var_118_20 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.actorSpriteComps10108 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_118_7 then
						if arg_115_1.isInRecall_ then
							iter_118_7.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10108 = nil
			end

			local var_118_26 = arg_115_1.actors_["10109"]
			local var_118_27 = 0

			if var_118_27 < arg_115_1.time_ and arg_115_1.time_ <= var_118_27 + arg_118_0 and not isNil(var_118_26) and arg_115_1.var_.actorSpriteComps10109 == nil then
				arg_115_1.var_.actorSpriteComps10109 = var_118_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_28 = 0.125

			if var_118_27 <= arg_115_1.time_ and arg_115_1.time_ < var_118_27 + var_118_28 and not isNil(var_118_26) then
				local var_118_29 = (arg_115_1.time_ - var_118_27) / var_118_28

				if arg_115_1.var_.actorSpriteComps10109 then
					for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_118_9 then
							if arg_115_1.isInRecall_ then
								local var_118_30 = Mathf.Lerp(iter_118_9.color.r, arg_115_1.hightColor2.r, var_118_29)
								local var_118_31 = Mathf.Lerp(iter_118_9.color.g, arg_115_1.hightColor2.g, var_118_29)
								local var_118_32 = Mathf.Lerp(iter_118_9.color.b, arg_115_1.hightColor2.b, var_118_29)

								iter_118_9.color = Color.New(var_118_30, var_118_31, var_118_32)
							else
								local var_118_33 = Mathf.Lerp(iter_118_9.color.r, 0.5, var_118_29)

								iter_118_9.color = Color.New(var_118_33, var_118_33, var_118_33)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_27 + var_118_28 and arg_115_1.time_ < var_118_27 + var_118_28 + arg_118_0 and not isNil(var_118_26) and arg_115_1.var_.actorSpriteComps10109 then
				for iter_118_10, iter_118_11 in pairs(arg_115_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_118_11 then
						if arg_115_1.isInRecall_ then
							iter_118_11.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10109 = nil
			end

			local var_118_34 = arg_115_1.actors_["1148"].transform
			local var_118_35 = 0

			if var_118_35 < arg_115_1.time_ and arg_115_1.time_ <= var_118_35 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_34.localPosition
				var_118_34.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 7)

				local var_118_36 = var_118_34.childCount

				for iter_118_12 = 0, var_118_36 - 1 do
					local var_118_37 = var_118_34:GetChild(iter_118_12)

					if var_118_37.name == "" or not string.find(var_118_37.name, "split") then
						var_118_37.gameObject:SetActive(true)
					else
						var_118_37.gameObject:SetActive(false)
					end
				end
			end

			local var_118_38 = 0.001

			if var_118_35 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_38 then
				local var_118_39 = (arg_115_1.time_ - var_118_35) / var_118_38
				local var_118_40 = Vector3.New(0, -2000, 0)

				var_118_34.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, var_118_40, var_118_39)
			end

			if arg_115_1.time_ >= var_118_35 + var_118_38 and arg_115_1.time_ < var_118_35 + var_118_38 + arg_118_0 then
				var_118_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_41 = 0
			local var_118_42 = 0.4

			if var_118_41 < arg_115_1.time_ and arg_115_1.time_ <= var_118_41 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_43 = arg_115_1:FormatText(StoryNameCfg[1083].name)

				arg_115_1.leftNameTxt_.text = var_118_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_44 = arg_115_1:GetWordFromCfg(416111026)
				local var_118_45 = arg_115_1:FormatText(var_118_44.content)

				arg_115_1.text_.text = var_118_45

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_46 = 16
				local var_118_47 = utf8.len(var_118_45)
				local var_118_48 = var_118_46 <= 0 and var_118_42 or var_118_42 * (var_118_47 / var_118_46)

				if var_118_48 > 0 and var_118_42 < var_118_48 then
					arg_115_1.talkMaxDuration = var_118_48

					if var_118_48 + var_118_41 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_48 + var_118_41
					end
				end

				arg_115_1.text_.text = var_118_45
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111026", "story_v_out_416111.awb") ~= 0 then
					local var_118_49 = manager.audio:GetVoiceLength("story_v_out_416111", "416111026", "story_v_out_416111.awb") / 1000

					if var_118_49 + var_118_41 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_49 + var_118_41
					end

					if var_118_44.prefab_name ~= "" and arg_115_1.actors_[var_118_44.prefab_name] ~= nil then
						local var_118_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_44.prefab_name].transform, "story_v_out_416111", "416111026", "story_v_out_416111.awb")

						arg_115_1:RecordAudio("416111026", var_118_50)
						arg_115_1:RecordAudio("416111026", var_118_50)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416111", "416111026", "story_v_out_416111.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416111", "416111026", "story_v_out_416111.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_51 = math.max(var_118_42, arg_115_1.talkMaxDuration)

			if var_118_41 <= arg_115_1.time_ and arg_115_1.time_ < var_118_41 + var_118_51 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_41) / var_118_51

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_41 + var_118_51 and arg_115_1.time_ < var_118_41 + var_118_51 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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
			},
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
	Play416111027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416111027
		arg_119_1.duration_ = 5.73

		local var_119_0 = {
			zh = 4.766,
			ja = 5.733
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
				arg_119_0:Play416111028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.45

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[1083].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(416111027)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 18
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111027", "story_v_out_416111.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111027", "story_v_out_416111.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_416111", "416111027", "story_v_out_416111.awb")

						arg_119_1:RecordAudio("416111027", var_122_9)
						arg_119_1:RecordAudio("416111027", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416111", "416111027", "story_v_out_416111.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416111", "416111027", "story_v_out_416111.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416111028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416111028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416111029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10108"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10108 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10108", 7)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(0, -2000, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10108, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_7 = arg_123_1.actors_["10109"].transform
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.var_.moveOldPos10109 = var_126_7.localPosition
				var_126_7.localScale = Vector3.New(1, 1, 1)

				local var_126_9 = var_126_7.childCount

				for iter_126_1 = 0, var_126_9 - 1 do
					local var_126_10 = var_126_7:GetChild(iter_126_1)

					if var_126_10.name == "" or not string.find(var_126_10.name, "split") then
						var_126_10.gameObject:SetActive(true)
					else
						var_126_10.gameObject:SetActive(false)
					end
				end
			end

			local var_126_11 = 0.001

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_11 then
				local var_126_12 = (arg_123_1.time_ - var_126_8) / var_126_11
				local var_126_13 = Vector3.New(0, 2000, 0)

				var_126_7.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10109, var_126_13, var_126_12)
			end

			if arg_123_1.time_ >= var_126_8 + var_126_11 and arg_123_1.time_ < var_126_8 + var_126_11 + arg_126_0 then
				var_126_7.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_126_14 = 0
			local var_126_15 = 1.925

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_16 = arg_123_1:GetWordFromCfg(416111028)
				local var_126_17 = arg_123_1:FormatText(var_126_16.content)

				arg_123_1.text_.text = var_126_17

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_18 = 77
				local var_126_19 = utf8.len(var_126_17)
				local var_126_20 = var_126_18 <= 0 and var_126_15 or var_126_15 * (var_126_19 / var_126_18)

				if var_126_20 > 0 and var_126_15 < var_126_20 then
					arg_123_1.talkMaxDuration = var_126_20

					if var_126_20 + var_126_14 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_14
					end
				end

				arg_123_1.text_.text = var_126_17
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_21 = math.max(var_126_15, arg_123_1.talkMaxDuration)

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_21 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_14) / var_126_21

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_14 + var_126_21 and arg_123_1.time_ < var_126_14 + var_126_21 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play416111029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416111029
		arg_127_1.duration_ = 10.97

		local var_127_0 = {
			zh = 7.933,
			ja = 10.966
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
				arg_127_0:Play416111030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10109"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10109 == nil then
				arg_127_1.var_.actorSpriteComps10109 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.125

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10109 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10109 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10109 = nil
			end

			local var_130_8 = arg_127_1.actors_["10109"].transform
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.var_.moveOldPos10109 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10109", 3)

				local var_130_10 = var_130_8.childCount

				for iter_130_4 = 0, var_130_10 - 1 do
					local var_130_11 = var_130_8:GetChild(iter_130_4)

					if var_130_11.name == "" or not string.find(var_130_11.name, "split") then
						var_130_11.gameObject:SetActive(true)
					else
						var_130_11.gameObject:SetActive(false)
					end
				end
			end

			local var_130_12 = 0.001

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_12 then
				local var_130_13 = (arg_127_1.time_ - var_130_9) / var_130_12
				local var_130_14 = Vector3.New(0, -346.2, -395)

				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10109, var_130_14, var_130_13)
			end

			if arg_127_1.time_ >= var_130_9 + var_130_12 and arg_127_1.time_ < var_130_9 + var_130_12 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_130_15 = 0
			local var_130_16 = 0.375

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[36].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(416111029)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 15
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111029", "story_v_out_416111.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111029", "story_v_out_416111.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_416111", "416111029", "story_v_out_416111.awb")

						arg_127_1:RecordAudio("416111029", var_130_24)
						arg_127_1:RecordAudio("416111029", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416111", "416111029", "story_v_out_416111.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416111", "416111029", "story_v_out_416111.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play416111030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416111030
		arg_131_1.duration_ = 6.03

		local var_131_0 = {
			zh = 6.033,
			ja = 3.933
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
				arg_131_0:Play416111031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.4

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[36].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(416111030)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111030", "story_v_out_416111.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111030", "story_v_out_416111.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_416111", "416111030", "story_v_out_416111.awb")

						arg_131_1:RecordAudio("416111030", var_134_9)
						arg_131_1:RecordAudio("416111030", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416111", "416111030", "story_v_out_416111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416111", "416111030", "story_v_out_416111.awb")
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
	Play416111031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416111031
		arg_135_1.duration_ = 2.5

		local var_135_0 = {
			zh = 2.133,
			ja = 2.5
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
				arg_135_0:Play416111032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10109"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10109 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10109", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -346.2, -395)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10109, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_138_7 = arg_135_1.actors_["1148"].transform
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.var_.moveOldPos1148 = var_138_7.localPosition
				var_138_7.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1148", 4)

				local var_138_9 = var_138_7.childCount

				for iter_138_1 = 0, var_138_9 - 1 do
					local var_138_10 = var_138_7:GetChild(iter_138_1)

					if var_138_10.name == "split_3" or not string.find(var_138_10.name, "split") then
						var_138_10.gameObject:SetActive(true)
					else
						var_138_10.gameObject:SetActive(false)
					end
				end
			end

			local var_138_11 = 0.001

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_8) / var_138_11
				local var_138_13 = Vector3.New(390, -429, -180)

				var_138_7.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1148, var_138_13, var_138_12)
			end

			if arg_135_1.time_ >= var_138_8 + var_138_11 and arg_135_1.time_ < var_138_8 + var_138_11 + arg_138_0 then
				var_138_7.localPosition = Vector3.New(390, -429, -180)
			end

			local var_138_14 = arg_135_1.actors_["1148"]
			local var_138_15 = 0

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.actorSpriteComps1148 == nil then
				arg_135_1.var_.actorSpriteComps1148 = var_138_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_16 = 0.125

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_16 and not isNil(var_138_14) then
				local var_138_17 = (arg_135_1.time_ - var_138_15) / var_138_16

				if arg_135_1.var_.actorSpriteComps1148 then
					for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_138_3 then
							if arg_135_1.isInRecall_ then
								local var_138_18 = Mathf.Lerp(iter_138_3.color.r, arg_135_1.hightColor1.r, var_138_17)
								local var_138_19 = Mathf.Lerp(iter_138_3.color.g, arg_135_1.hightColor1.g, var_138_17)
								local var_138_20 = Mathf.Lerp(iter_138_3.color.b, arg_135_1.hightColor1.b, var_138_17)

								iter_138_3.color = Color.New(var_138_18, var_138_19, var_138_20)
							else
								local var_138_21 = Mathf.Lerp(iter_138_3.color.r, 1, var_138_17)

								iter_138_3.color = Color.New(var_138_21, var_138_21, var_138_21)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_15 + var_138_16 and arg_135_1.time_ < var_138_15 + var_138_16 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.actorSpriteComps1148 then
				for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_138_5 then
						if arg_135_1.isInRecall_ then
							iter_138_5.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1148 = nil
			end

			local var_138_22 = arg_135_1.actors_["10109"]
			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10109 == nil then
				arg_135_1.var_.actorSpriteComps10109 = var_138_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_24 = 0.125

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 and not isNil(var_138_22) then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24

				if arg_135_1.var_.actorSpriteComps10109 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								local var_138_26 = Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, var_138_25)
								local var_138_27 = Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, var_138_25)
								local var_138_28 = Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, var_138_25)

								iter_138_7.color = Color.New(var_138_26, var_138_27, var_138_28)
							else
								local var_138_29 = Mathf.Lerp(iter_138_7.color.r, 0.5, var_138_25)

								iter_138_7.color = Color.New(var_138_29, var_138_29, var_138_29)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10109 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_138_9 then
						if arg_135_1.isInRecall_ then
							iter_138_9.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10109 = nil
			end

			local var_138_30 = 0
			local var_138_31 = 0.125

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_32 = arg_135_1:FormatText(StoryNameCfg[8].name)

				arg_135_1.leftNameTxt_.text = var_138_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_33 = arg_135_1:GetWordFromCfg(416111031)
				local var_138_34 = arg_135_1:FormatText(var_138_33.content)

				arg_135_1.text_.text = var_138_34

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_35 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111031", "story_v_out_416111.awb") ~= 0 then
					local var_138_38 = manager.audio:GetVoiceLength("story_v_out_416111", "416111031", "story_v_out_416111.awb") / 1000

					if var_138_38 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_38 + var_138_30
					end

					if var_138_33.prefab_name ~= "" and arg_135_1.actors_[var_138_33.prefab_name] ~= nil then
						local var_138_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_33.prefab_name].transform, "story_v_out_416111", "416111031", "story_v_out_416111.awb")

						arg_135_1:RecordAudio("416111031", var_138_39)
						arg_135_1:RecordAudio("416111031", var_138_39)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416111", "416111031", "story_v_out_416111.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416111", "416111031", "story_v_out_416111.awb")
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
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_135_1:InitPlayNodeList()
	end,
	Play416111032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416111032
		arg_139_1.duration_ = 5.4

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play416111033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1148"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps1148 == nil then
				arg_139_1.var_.actorSpriteComps1148 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.125

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps1148 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 0.5, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps1148 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1148 = nil
			end

			local var_142_8 = manager.ui.mainCamera.transform
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				local var_142_10 = arg_139_1.var_.effect11032
				local var_142_11
				local var_142_12 = var_142_8

				if not var_142_10 then
					var_142_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_142_12)
					var_142_10.name = "11032"
					arg_139_1.var_.effect11032 = var_142_10
				else
					var_142_10.transform:SetParent(var_142_12)
				end

				var_142_10.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_142_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_142_13 = manager.ui.mainCamera.transform
			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_13.localPosition
			end

			local var_142_15 = 0.4

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_15 then
				local var_142_16 = (arg_139_1.time_ - var_142_14) / 0.066
				local var_142_17, var_142_18 = math.modf(var_142_16)

				var_142_13.localPosition = Vector3.New(var_142_18 * 0.13, var_142_18 * 0.13, var_142_18 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_14 + var_142_15 and arg_139_1.time_ < var_142_14 + var_142_15 + arg_142_0 then
				var_142_13.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_19 = arg_139_1.actors_["10109"].transform
			local var_142_20 = 0

			if var_142_20 < arg_139_1.time_ and arg_139_1.time_ <= var_142_20 + arg_142_0 then
				arg_139_1.var_.moveOldPos10109 = var_142_19.localPosition
				var_142_19.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10109", 7)

				local var_142_21 = var_142_19.childCount

				for iter_142_4 = 0, var_142_21 - 1 do
					local var_142_22 = var_142_19:GetChild(iter_142_4)

					if var_142_22.name == "" or not string.find(var_142_22.name, "split") then
						var_142_22.gameObject:SetActive(true)
					else
						var_142_22.gameObject:SetActive(false)
					end
				end
			end

			local var_142_23 = 0.001

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_23 then
				local var_142_24 = (arg_139_1.time_ - var_142_20) / var_142_23
				local var_142_25 = Vector3.New(0, -2000, 0)

				var_142_19.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10109, var_142_25, var_142_24)
			end

			if arg_139_1.time_ >= var_142_20 + var_142_23 and arg_139_1.time_ < var_142_20 + var_142_23 + arg_142_0 then
				var_142_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_26 = arg_139_1.actors_["1148"].transform
			local var_142_27 = 0

			if var_142_27 < arg_139_1.time_ and arg_139_1.time_ <= var_142_27 + arg_142_0 then
				arg_139_1.var_.moveOldPos1148 = var_142_26.localPosition
				var_142_26.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1148", 7)

				local var_142_28 = var_142_26.childCount

				for iter_142_5 = 0, var_142_28 - 1 do
					local var_142_29 = var_142_26:GetChild(iter_142_5)

					if var_142_29.name == "split_3" or not string.find(var_142_29.name, "split") then
						var_142_29.gameObject:SetActive(true)
					else
						var_142_29.gameObject:SetActive(false)
					end
				end
			end

			local var_142_30 = 0.001

			if var_142_27 <= arg_139_1.time_ and arg_139_1.time_ < var_142_27 + var_142_30 then
				local var_142_31 = (arg_139_1.time_ - var_142_27) / var_142_30
				local var_142_32 = Vector3.New(0, -2000, 0)

				var_142_26.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1148, var_142_32, var_142_31)
			end

			if arg_139_1.time_ >= var_142_27 + var_142_30 and arg_139_1.time_ < var_142_27 + var_142_30 + arg_142_0 then
				var_142_26.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_33 = 2.43333333333333
			local var_142_34 = 1

			if var_142_33 < arg_139_1.time_ and arg_139_1.time_ <= var_142_33 + arg_142_0 then
				local var_142_35 = "play"
				local var_142_36 = "effect"

				arg_139_1:AudioAction(var_142_35, var_142_36, "se_story_1211", "se_story_1211_power", "")
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_37 = 0.4
			local var_142_38 = 1.775

			if var_142_37 < arg_139_1.time_ and arg_139_1.time_ <= var_142_37 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_39 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_39:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_40 = arg_139_1:GetWordFromCfg(416111032)
				local var_142_41 = arg_139_1:FormatText(var_142_40.content)

				arg_139_1.text_.text = var_142_41

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_42 = 71
				local var_142_43 = utf8.len(var_142_41)
				local var_142_44 = var_142_42 <= 0 and var_142_38 or var_142_38 * (var_142_43 / var_142_42)

				if var_142_44 > 0 and var_142_38 < var_142_44 then
					arg_139_1.talkMaxDuration = var_142_44
					var_142_37 = var_142_37 + 0.3

					if var_142_44 + var_142_37 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_44 + var_142_37
					end
				end

				arg_139_1.text_.text = var_142_41
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_45 = var_142_37 + 0.3
			local var_142_46 = math.max(var_142_38, arg_139_1.talkMaxDuration)

			if var_142_45 <= arg_139_1.time_ and arg_139_1.time_ < var_142_45 + var_142_46 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_45) / var_142_46

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_45 + var_142_46 and arg_139_1.time_ < var_142_45 + var_142_46 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_139_1:InitPlayNodeList()
	end,
	Play416111033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416111033
		arg_145_1.duration_ = 6.1

		local var_145_0 = {
			zh = 3.466,
			ja = 6.1
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
				arg_145_0:Play416111034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1148"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1148 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1148", 3)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_3" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -429, -180)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1148, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_148_7 = arg_145_1.actors_["1148"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1148 == nil then
				arg_145_1.var_.actorSpriteComps1148 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.125

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps1148 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1148 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1148 = nil
			end

			local var_148_15 = 0
			local var_148_16 = 0.3

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[8].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(416111033)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111033", "story_v_out_416111.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111033", "story_v_out_416111.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_416111", "416111033", "story_v_out_416111.awb")

						arg_145_1:RecordAudio("416111033", var_148_24)
						arg_145_1:RecordAudio("416111033", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416111", "416111033", "story_v_out_416111.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416111", "416111033", "story_v_out_416111.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play416111034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416111034
		arg_149_1.duration_ = 8.67

		local var_149_0 = {
			zh = 6.066,
			ja = 8.666
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
				arg_149_0:Play416111035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10109"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10109 == nil then
				arg_149_1.var_.actorSpriteComps10109 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.125

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10109 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 1, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10109 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10109 = nil
			end

			local var_152_8 = arg_149_1.actors_["1148"].transform
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.var_.moveOldPos1148 = var_152_8.localPosition
				var_152_8.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1148", 7)

				local var_152_10 = var_152_8.childCount

				for iter_152_4 = 0, var_152_10 - 1 do
					local var_152_11 = var_152_8:GetChild(iter_152_4)

					if var_152_11.name == "split_3" or not string.find(var_152_11.name, "split") then
						var_152_11.gameObject:SetActive(true)
					else
						var_152_11.gameObject:SetActive(false)
					end
				end
			end

			local var_152_12 = 0.001

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_12 then
				local var_152_13 = (arg_149_1.time_ - var_152_9) / var_152_12
				local var_152_14 = Vector3.New(0, -2000, 0)

				var_152_8.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1148, var_152_14, var_152_13)
			end

			if arg_149_1.time_ >= var_152_9 + var_152_12 and arg_149_1.time_ < var_152_9 + var_152_12 + arg_152_0 then
				var_152_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_15 = arg_149_1.actors_["10109"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos10109 = var_152_15.localPosition
				var_152_15.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10109", 3)

				local var_152_17 = var_152_15.childCount

				for iter_152_5 = 0, var_152_17 - 1 do
					local var_152_18 = var_152_15:GetChild(iter_152_5)

					if var_152_18.name == "" or not string.find(var_152_18.name, "split") then
						var_152_18.gameObject:SetActive(true)
					else
						var_152_18.gameObject:SetActive(false)
					end
				end
			end

			local var_152_19 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_19 then
				local var_152_20 = (arg_149_1.time_ - var_152_16) / var_152_19
				local var_152_21 = Vector3.New(0, -346.2, -395)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10109, var_152_21, var_152_20)
			end

			if arg_149_1.time_ >= var_152_16 + var_152_19 and arg_149_1.time_ < var_152_16 + var_152_19 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_152_22 = 0
			local var_152_23 = 0.55

			if var_152_22 < arg_149_1.time_ and arg_149_1.time_ <= var_152_22 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_24 = arg_149_1:FormatText(StoryNameCfg[36].name)

				arg_149_1.leftNameTxt_.text = var_152_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_25 = arg_149_1:GetWordFromCfg(416111034)
				local var_152_26 = arg_149_1:FormatText(var_152_25.content)

				arg_149_1.text_.text = var_152_26

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_27 = 22
				local var_152_28 = utf8.len(var_152_26)
				local var_152_29 = var_152_27 <= 0 and var_152_23 or var_152_23 * (var_152_28 / var_152_27)

				if var_152_29 > 0 and var_152_23 < var_152_29 then
					arg_149_1.talkMaxDuration = var_152_29

					if var_152_29 + var_152_22 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_29 + var_152_22
					end
				end

				arg_149_1.text_.text = var_152_26
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111034", "story_v_out_416111.awb") ~= 0 then
					local var_152_30 = manager.audio:GetVoiceLength("story_v_out_416111", "416111034", "story_v_out_416111.awb") / 1000

					if var_152_30 + var_152_22 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_30 + var_152_22
					end

					if var_152_25.prefab_name ~= "" and arg_149_1.actors_[var_152_25.prefab_name] ~= nil then
						local var_152_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_25.prefab_name].transform, "story_v_out_416111", "416111034", "story_v_out_416111.awb")

						arg_149_1:RecordAudio("416111034", var_152_31)
						arg_149_1:RecordAudio("416111034", var_152_31)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416111", "416111034", "story_v_out_416111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416111", "416111034", "story_v_out_416111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_32 = math.max(var_152_23, arg_149_1.talkMaxDuration)

			if var_152_22 <= arg_149_1.time_ and arg_149_1.time_ < var_152_22 + var_152_32 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_22) / var_152_32

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_22 + var_152_32 and arg_149_1.time_ < var_152_22 + var_152_32 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play416111035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416111035
		arg_153_1.duration_ = 5.53

		local var_153_0 = {
			zh = 5,
			ja = 5.533
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
				arg_153_0:Play416111036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1148"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1148 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1148", 3)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "split_3" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(0, -429, -180)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1148, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_156_7 = arg_153_1.actors_["1148"]
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1148 == nil then
				arg_153_1.var_.actorSpriteComps1148 = var_156_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.125

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 and not isNil(var_156_7) then
				local var_156_10 = (arg_153_1.time_ - var_156_8) / var_156_9

				if arg_153_1.var_.actorSpriteComps1148 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								local var_156_11 = Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, var_156_10)
								local var_156_12 = Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, var_156_10)
								local var_156_13 = Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, var_156_10)

								iter_156_2.color = Color.New(var_156_11, var_156_12, var_156_13)
							else
								local var_156_14 = Mathf.Lerp(iter_156_2.color.r, 1, var_156_10)

								iter_156_2.color = Color.New(var_156_14, var_156_14, var_156_14)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1148 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_156_4 then
						if arg_153_1.isInRecall_ then
							iter_156_4.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1148 = nil
			end

			local var_156_15 = arg_153_1.actors_["10109"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps10109 == nil then
				arg_153_1.var_.actorSpriteComps10109 = var_156_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_17 = 0.125

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.actorSpriteComps10109 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								local var_156_19 = Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, var_156_18)
								local var_156_20 = Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, var_156_18)
								local var_156_21 = Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, var_156_18)

								iter_156_6.color = Color.New(var_156_19, var_156_20, var_156_21)
							else
								local var_156_22 = Mathf.Lerp(iter_156_6.color.r, 0.5, var_156_18)

								iter_156_6.color = Color.New(var_156_22, var_156_22, var_156_22)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps10109 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_156_8 then
						if arg_153_1.isInRecall_ then
							iter_156_8.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10109 = nil
			end

			local var_156_23 = arg_153_1.actors_["10109"].transform
			local var_156_24 = 0

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.var_.moveOldPos10109 = var_156_23.localPosition
				var_156_23.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10109", 7)

				local var_156_25 = var_156_23.childCount

				for iter_156_9 = 0, var_156_25 - 1 do
					local var_156_26 = var_156_23:GetChild(iter_156_9)

					if var_156_26.name == "" or not string.find(var_156_26.name, "split") then
						var_156_26.gameObject:SetActive(true)
					else
						var_156_26.gameObject:SetActive(false)
					end
				end
			end

			local var_156_27 = 0.001

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_27 then
				local var_156_28 = (arg_153_1.time_ - var_156_24) / var_156_27
				local var_156_29 = Vector3.New(0, -2000, 0)

				var_156_23.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10109, var_156_29, var_156_28)
			end

			if arg_153_1.time_ >= var_156_24 + var_156_27 and arg_153_1.time_ < var_156_24 + var_156_27 + arg_156_0 then
				var_156_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_30 = 0
			local var_156_31 = 0.45

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_32 = arg_153_1:FormatText(StoryNameCfg[8].name)

				arg_153_1.leftNameTxt_.text = var_156_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_33 = arg_153_1:GetWordFromCfg(416111035)
				local var_156_34 = arg_153_1:FormatText(var_156_33.content)

				arg_153_1.text_.text = var_156_34

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_35 = 18
				local var_156_36 = utf8.len(var_156_34)
				local var_156_37 = var_156_35 <= 0 and var_156_31 or var_156_31 * (var_156_36 / var_156_35)

				if var_156_37 > 0 and var_156_31 < var_156_37 then
					arg_153_1.talkMaxDuration = var_156_37

					if var_156_37 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_37 + var_156_30
					end
				end

				arg_153_1.text_.text = var_156_34
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111035", "story_v_out_416111.awb") ~= 0 then
					local var_156_38 = manager.audio:GetVoiceLength("story_v_out_416111", "416111035", "story_v_out_416111.awb") / 1000

					if var_156_38 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_38 + var_156_30
					end

					if var_156_33.prefab_name ~= "" and arg_153_1.actors_[var_156_33.prefab_name] ~= nil then
						local var_156_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_33.prefab_name].transform, "story_v_out_416111", "416111035", "story_v_out_416111.awb")

						arg_153_1:RecordAudio("416111035", var_156_39)
						arg_153_1:RecordAudio("416111035", var_156_39)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416111", "416111035", "story_v_out_416111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416111", "416111035", "story_v_out_416111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_40 = math.max(var_156_31, arg_153_1.talkMaxDuration)

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_40 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_30) / var_156_40

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_30 + var_156_40 and arg_153_1.time_ < var_156_30 + var_156_40 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play416111036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416111036
		arg_157_1.duration_ = 6.7

		local var_157_0 = {
			zh = 4.466,
			ja = 6.7
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
				arg_157_0:Play416111037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.525

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

				local var_160_3 = arg_157_1:GetWordFromCfg(416111036)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111036", "story_v_out_416111.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111036", "story_v_out_416111.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_416111", "416111036", "story_v_out_416111.awb")

						arg_157_1:RecordAudio("416111036", var_160_9)
						arg_157_1:RecordAudio("416111036", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416111", "416111036", "story_v_out_416111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416111", "416111036", "story_v_out_416111.awb")
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
	Play416111037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416111037
		arg_161_1.duration_ = 5.2

		local var_161_0 = {
			zh = 4.766,
			ja = 5.2
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
				arg_161_0:Play416111038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.5

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[8].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(416111037)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 20
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111037", "story_v_out_416111.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111037", "story_v_out_416111.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_416111", "416111037", "story_v_out_416111.awb")

						arg_161_1:RecordAudio("416111037", var_164_9)
						arg_161_1:RecordAudio("416111037", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416111", "416111037", "story_v_out_416111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416111", "416111037", "story_v_out_416111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play416111038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416111038
		arg_165_1.duration_ = 7.77

		local var_165_0 = {
			zh = 4.2,
			ja = 7.766
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
				arg_165_0:Play416111039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10109"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10109 == nil then
				arg_165_1.var_.actorSpriteComps10109 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.125

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10109 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10109 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10109 = nil
			end

			local var_168_8 = arg_165_1.actors_["1148"]
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = var_168_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_10 = 0.125

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_10 and not isNil(var_168_8) then
				local var_168_11 = (arg_165_1.time_ - var_168_9) / var_168_10

				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_168_5 then
							if arg_165_1.isInRecall_ then
								local var_168_12 = Mathf.Lerp(iter_168_5.color.r, arg_165_1.hightColor2.r, var_168_11)
								local var_168_13 = Mathf.Lerp(iter_168_5.color.g, arg_165_1.hightColor2.g, var_168_11)
								local var_168_14 = Mathf.Lerp(iter_168_5.color.b, arg_165_1.hightColor2.b, var_168_11)

								iter_168_5.color = Color.New(var_168_12, var_168_13, var_168_14)
							else
								local var_168_15 = Mathf.Lerp(iter_168_5.color.r, 0.5, var_168_11)

								iter_168_5.color = Color.New(var_168_15, var_168_15, var_168_15)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_9 + var_168_10 and arg_165_1.time_ < var_168_9 + var_168_10 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_7 then
						if arg_165_1.isInRecall_ then
							iter_168_7.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_16 = 0
			local var_168_17 = 0.375

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_18 = arg_165_1:FormatText(StoryNameCfg[36].name)

				arg_165_1.leftNameTxt_.text = var_168_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_19 = arg_165_1:GetWordFromCfg(416111038)
				local var_168_20 = arg_165_1:FormatText(var_168_19.content)

				arg_165_1.text_.text = var_168_20

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_21 = 15
				local var_168_22 = utf8.len(var_168_20)
				local var_168_23 = var_168_21 <= 0 and var_168_17 or var_168_17 * (var_168_22 / var_168_21)

				if var_168_23 > 0 and var_168_17 < var_168_23 then
					arg_165_1.talkMaxDuration = var_168_23

					if var_168_23 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_16
					end
				end

				arg_165_1.text_.text = var_168_20
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111038", "story_v_out_416111.awb") ~= 0 then
					local var_168_24 = manager.audio:GetVoiceLength("story_v_out_416111", "416111038", "story_v_out_416111.awb") / 1000

					if var_168_24 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_24 + var_168_16
					end

					if var_168_19.prefab_name ~= "" and arg_165_1.actors_[var_168_19.prefab_name] ~= nil then
						local var_168_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_19.prefab_name].transform, "story_v_out_416111", "416111038", "story_v_out_416111.awb")

						arg_165_1:RecordAudio("416111038", var_168_25)
						arg_165_1:RecordAudio("416111038", var_168_25)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416111", "416111038", "story_v_out_416111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416111", "416111038", "story_v_out_416111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_26 = math.max(var_168_17, arg_165_1.talkMaxDuration)

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_26 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_16) / var_168_26

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_16 + var_168_26 and arg_165_1.time_ < var_168_16 + var_168_26 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416111039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416111039
		arg_169_1.duration_ = 3.87

		local var_169_0 = {
			zh = 3.866,
			ja = 2.933
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
				arg_169_0:Play416111040(arg_169_1)
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
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 1, var_172_3)

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
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.375

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[8].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(416111039)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111039", "story_v_out_416111.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_416111", "416111039", "story_v_out_416111.awb") / 1000

					if var_172_16 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_8
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_416111", "416111039", "story_v_out_416111.awb")

						arg_169_1:RecordAudio("416111039", var_172_17)
						arg_169_1:RecordAudio("416111039", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416111", "416111039", "story_v_out_416111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416111", "416111039", "story_v_out_416111.awb")
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
	Play416111040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416111040
		arg_173_1.duration_ = 5.67

		local var_173_0 = {
			zh = 4.333,
			ja = 5.666
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
				arg_173_0:Play416111041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.525

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[8].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(416111040)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 21
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111040", "story_v_out_416111.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111040", "story_v_out_416111.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_416111", "416111040", "story_v_out_416111.awb")

						arg_173_1:RecordAudio("416111040", var_176_9)
						arg_173_1:RecordAudio("416111040", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416111", "416111040", "story_v_out_416111.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416111", "416111040", "story_v_out_416111.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416111041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416111041
		arg_177_1.duration_ = 4.5

		local var_177_0 = {
			zh = 3.733,
			ja = 4.5
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416111042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.375

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[8].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(416111041)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 15
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111041", "story_v_out_416111.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111041", "story_v_out_416111.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_416111", "416111041", "story_v_out_416111.awb")

						arg_177_1:RecordAudio("416111041", var_180_9)
						arg_177_1:RecordAudio("416111041", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416111", "416111041", "story_v_out_416111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416111", "416111041", "story_v_out_416111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416111042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416111042
		arg_181_1.duration_ = 7.37

		local var_181_0 = {
			zh = 4.933,
			ja = 7.366
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
				arg_181_0:Play416111043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.425

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[8].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(416111042)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 17
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111042", "story_v_out_416111.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111042", "story_v_out_416111.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_416111", "416111042", "story_v_out_416111.awb")

						arg_181_1:RecordAudio("416111042", var_184_9)
						arg_181_1:RecordAudio("416111042", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416111", "416111042", "story_v_out_416111.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416111", "416111042", "story_v_out_416111.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play416111043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416111043
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416111044(arg_185_1)
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

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
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

			local var_188_7 = 0.233333333333333
			local var_188_8 = 0.933333333333333

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				local var_188_9 = "play"
				local var_188_10 = "effect"

				arg_185_1:AudioAction(var_188_9, var_188_10, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_188_11 = 0
			local var_188_12 = 1.95

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_13 = arg_185_1:GetWordFromCfg(416111043)
				local var_188_14 = arg_185_1:FormatText(var_188_13.content)

				arg_185_1.text_.text = var_188_14

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 78
				local var_188_16 = utf8.len(var_188_14)
				local var_188_17 = var_188_15 <= 0 and var_188_12 or var_188_12 * (var_188_16 / var_188_15)

				if var_188_17 > 0 and var_188_12 < var_188_17 then
					arg_185_1.talkMaxDuration = var_188_17

					if var_188_17 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_17 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_14
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_18 and arg_185_1.time_ < var_188_11 + var_188_18 + arg_188_0 then
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
	Play416111044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416111044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416111045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.8

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

				local var_192_2 = arg_189_1:GetWordFromCfg(416111044)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 72
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
	Play416111045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416111045
		arg_193_1.duration_ = 6.8

		local var_193_0 = {
			zh = 6.8,
			ja = 5.6
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
				arg_193_0:Play416111046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1148"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1148 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1148", 3)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_6" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -429, -180)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1148, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_196_7 = arg_193_1.actors_["1148"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1148 == nil then
				arg_193_1.var_.actorSpriteComps1148 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.125

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps1148 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1148 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1148 = nil
			end

			local var_196_15 = 0
			local var_196_16 = 0.375

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[8].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(416111045)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 15
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111045", "story_v_out_416111.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111045", "story_v_out_416111.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_416111", "416111045", "story_v_out_416111.awb")

						arg_193_1:RecordAudio("416111045", var_196_24)
						arg_193_1:RecordAudio("416111045", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416111", "416111045", "story_v_out_416111.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416111", "416111045", "story_v_out_416111.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play416111046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416111046
		arg_197_1.duration_ = 8.43

		local var_197_0 = {
			zh = 8.2,
			ja = 8.433
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
				arg_197_0:Play416111047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "STwhite"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 2

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.STwhite

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "STwhite" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 4

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_17 = 0.0666666666666669

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_18 = 0

			if var_200_18 < arg_197_1.time_ and arg_197_1.time_ <= var_200_18 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_19 = 2

			if var_200_18 <= arg_197_1.time_ and arg_197_1.time_ < var_200_18 + var_200_19 then
				local var_200_20 = (arg_197_1.time_ - var_200_18) / var_200_19
				local var_200_21 = Color.New(0, 0, 0)

				var_200_21.a = Mathf.Lerp(0, 1, var_200_20)
				arg_197_1.mask_.color = var_200_21
			end

			if arg_197_1.time_ >= var_200_18 + var_200_19 and arg_197_1.time_ < var_200_18 + var_200_19 + arg_200_0 then
				local var_200_22 = Color.New(0, 0, 0)

				var_200_22.a = 1
				arg_197_1.mask_.color = var_200_22
			end

			local var_200_23 = 2

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_24 = 2

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_24 then
				local var_200_25 = (arg_197_1.time_ - var_200_23) / var_200_24
				local var_200_26 = Color.New(0, 0, 0)

				var_200_26.a = Mathf.Lerp(1, 0, var_200_25)
				arg_197_1.mask_.color = var_200_26
			end

			if arg_197_1.time_ >= var_200_23 + var_200_24 and arg_197_1.time_ < var_200_23 + var_200_24 + arg_200_0 then
				local var_200_27 = Color.New(0, 0, 0)
				local var_200_28 = 0

				arg_197_1.mask_.enabled = false
				var_200_27.a = var_200_28
				arg_197_1.mask_.color = var_200_27
			end

			local var_200_29 = arg_197_1.actors_["1148"].transform
			local var_200_30 = 1.966

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.var_.moveOldPos1148 = var_200_29.localPosition
				var_200_29.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1148", 7)

				local var_200_31 = var_200_29.childCount

				for iter_200_2 = 0, var_200_31 - 1 do
					local var_200_32 = var_200_29:GetChild(iter_200_2)

					if var_200_32.name == "" or not string.find(var_200_32.name, "split") then
						var_200_32.gameObject:SetActive(true)
					else
						var_200_32.gameObject:SetActive(false)
					end
				end
			end

			local var_200_33 = 0.001

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_33 then
				local var_200_34 = (arg_197_1.time_ - var_200_30) / var_200_33
				local var_200_35 = Vector3.New(0, -2000, 0)

				var_200_29.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1148, var_200_35, var_200_34)
			end

			if arg_197_1.time_ >= var_200_30 + var_200_33 and arg_197_1.time_ < var_200_30 + var_200_33 + arg_200_0 then
				var_200_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_36 = 4
			local var_200_37 = 0.175

			if var_200_36 < arg_197_1.time_ and arg_197_1.time_ <= var_200_36 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_38 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_38:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_39 = arg_197_1:FormatText(StoryNameCfg[1092].name)

				arg_197_1.leftNameTxt_.text = var_200_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_40 = arg_197_1:GetWordFromCfg(416111046)
				local var_200_41 = arg_197_1:FormatText(var_200_40.content)

				arg_197_1.text_.text = var_200_41

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_42 = 7
				local var_200_43 = utf8.len(var_200_41)
				local var_200_44 = var_200_42 <= 0 and var_200_37 or var_200_37 * (var_200_43 / var_200_42)

				if var_200_44 > 0 and var_200_37 < var_200_44 then
					arg_197_1.talkMaxDuration = var_200_44
					var_200_36 = var_200_36 + 0.3

					if var_200_44 + var_200_36 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_44 + var_200_36
					end
				end

				arg_197_1.text_.text = var_200_41
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111046", "story_v_out_416111.awb") ~= 0 then
					local var_200_45 = manager.audio:GetVoiceLength("story_v_out_416111", "416111046", "story_v_out_416111.awb") / 1000

					if var_200_45 + var_200_36 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_45 + var_200_36
					end

					if var_200_40.prefab_name ~= "" and arg_197_1.actors_[var_200_40.prefab_name] ~= nil then
						local var_200_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_40.prefab_name].transform, "story_v_out_416111", "416111046", "story_v_out_416111.awb")

						arg_197_1:RecordAudio("416111046", var_200_46)
						arg_197_1:RecordAudio("416111046", var_200_46)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416111", "416111046", "story_v_out_416111.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416111", "416111046", "story_v_out_416111.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_47 = var_200_36 + 0.3
			local var_200_48 = math.max(var_200_37, arg_197_1.talkMaxDuration)

			if var_200_47 <= arg_197_1.time_ and arg_197_1.time_ < var_200_47 + var_200_48 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_47) / var_200_48

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_47 + var_200_48 and arg_197_1.time_ < var_200_47 + var_200_48 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play416111047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416111047
		arg_203_1.duration_ = 7.69

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416111048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "SS1605"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 0

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.SS1605

				var_206_5.transform.localPosition = var_206_4
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = (var_206_5.transform.localPosition - var_206_3).z
					local var_206_8 = manager.ui.mainCameraCom_
					local var_206_9 = 2 * var_206_7 * Mathf.Tan(var_206_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_10 = var_206_9 * var_206_8.aspect
					local var_206_11 = var_206_6.sprite.bounds.size.x
					local var_206_12 = var_206_6.sprite.bounds.size.y
					local var_206_13 = var_206_10 / var_206_11
					local var_206_14 = var_206_9 / var_206_12
					local var_206_15 = var_206_14 < var_206_13 and var_206_13 or var_206_14

					var_206_5.transform.localScale = Vector3.New(var_206_15, var_206_15, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "SS1605" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_17 = 1

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17
				local var_206_19 = Color.New(1, 1, 1)

				var_206_19.a = Mathf.Lerp(1, 0, var_206_18)
				arg_203_1.mask_.color = var_206_19
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				local var_206_20 = Color.New(1, 1, 1)
				local var_206_21 = 0

				arg_203_1.mask_.enabled = false
				var_206_20.a = var_206_21
				arg_203_1.mask_.color = var_206_20
			end

			local var_206_22 = 2.034

			if var_206_22 < arg_203_1.time_ and arg_203_1.time_ <= var_206_22 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_23 = 0.766666666666667

			if arg_203_1.time_ >= var_206_22 + var_206_23 and arg_203_1.time_ < var_206_22 + var_206_23 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_24 = arg_203_1.actors_["1148"].transform
			local var_206_25 = 0

			if var_206_25 < arg_203_1.time_ and arg_203_1.time_ <= var_206_25 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148 = var_206_24.localPosition
				var_206_24.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1148", 7)

				local var_206_26 = var_206_24.childCount

				for iter_206_2 = 0, var_206_26 - 1 do
					local var_206_27 = var_206_24:GetChild(iter_206_2)

					if var_206_27.name == "" or not string.find(var_206_27.name, "split") then
						var_206_27.gameObject:SetActive(true)
					else
						var_206_27.gameObject:SetActive(false)
					end
				end
			end

			local var_206_28 = 0.001

			if var_206_25 <= arg_203_1.time_ and arg_203_1.time_ < var_206_25 + var_206_28 then
				local var_206_29 = (arg_203_1.time_ - var_206_25) / var_206_28
				local var_206_30 = Vector3.New(0, -2000, 0)

				var_206_24.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148, var_206_30, var_206_29)
			end

			if arg_203_1.time_ >= var_206_25 + var_206_28 and arg_203_1.time_ < var_206_25 + var_206_28 + arg_206_0 then
				var_206_24.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_31 = arg_203_1.bgs_.SS1605.transform
			local var_206_32 = 0.0339999999999999

			if var_206_32 < arg_203_1.time_ and arg_203_1.time_ <= var_206_32 + arg_206_0 then
				arg_203_1.var_.moveOldPosSS1605 = var_206_31.localPosition
			end

			local var_206_33 = 0.001

			if var_206_32 <= arg_203_1.time_ and arg_203_1.time_ < var_206_32 + var_206_33 then
				local var_206_34 = (arg_203_1.time_ - var_206_32) / var_206_33
				local var_206_35 = Vector3.New(0, 1, 10)

				var_206_31.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosSS1605, var_206_35, var_206_34)
			end

			if arg_203_1.time_ >= var_206_32 + var_206_33 and arg_203_1.time_ < var_206_32 + var_206_33 + arg_206_0 then
				var_206_31.localPosition = Vector3.New(0, 1, 10)
			end

			local var_206_36 = arg_203_1.bgs_.SS1605.transform
			local var_206_37 = 0.0679999999999998

			if var_206_37 < arg_203_1.time_ and arg_203_1.time_ <= var_206_37 + arg_206_0 then
				arg_203_1.var_.moveOldPosSS1605 = var_206_36.localPosition
			end

			local var_206_38 = 1.966

			if var_206_37 <= arg_203_1.time_ and arg_203_1.time_ < var_206_37 + var_206_38 then
				local var_206_39 = (arg_203_1.time_ - var_206_37) / var_206_38
				local var_206_40 = Vector3.New(0, 1, 9)

				var_206_36.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosSS1605, var_206_40, var_206_39)
			end

			if arg_203_1.time_ >= var_206_37 + var_206_38 and arg_203_1.time_ < var_206_37 + var_206_38 + arg_206_0 then
				var_206_36.localPosition = Vector3.New(0, 1, 9)
			end

			local var_206_41 = manager.ui.mainCamera.transform
			local var_206_42 = 1.70066666666667

			if var_206_42 < arg_203_1.time_ and arg_203_1.time_ <= var_206_42 + arg_206_0 then
				local var_206_43 = arg_203_1.var_.effect1047
				local var_206_44
				local var_206_45 = var_206_41

				if not var_206_43 then
					var_206_43 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_206_45)
					var_206_43.name = "1047"
					arg_203_1.var_.effect1047 = var_206_43
				else
					var_206_43.transform:SetParent(var_206_45)
				end

				var_206_43.transform.localPosition = Vector3.New(0, 0, 0)
				var_206_43.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_206_46 = manager.ui.mainCameraCom_
				local var_206_47 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_206_46.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_206_48 = var_206_43.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_206_49 = 15
				local var_206_50 = 2 * var_206_49 * Mathf.Tan(var_206_46.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_206_46.aspect
				local var_206_51 = 1
				local var_206_52 = 1.7777777777777777

				if var_206_52 < var_206_46.aspect then
					var_206_51 = var_206_50 / (2 * var_206_49 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_206_52)
				end

				for iter_206_3, iter_206_4 in ipairs(var_206_48) do
					local var_206_53 = iter_206_4.transform.localScale

					iter_206_4.transform.localScale = Vector3.New(var_206_53.x / var_206_47 * var_206_51, var_206_53.y / var_206_47, var_206_53.z)
				end
			end

			local var_206_54 = manager.ui.mainCamera.transform
			local var_206_55 = 5.034

			if var_206_55 < arg_203_1.time_ and arg_203_1.time_ <= var_206_55 + arg_206_0 then
				local var_206_56 = arg_203_1.var_.effect1047

				if var_206_56 then
					Object.Destroy(var_206_56)

					arg_203_1.var_.effect1047 = nil
				end
			end

			local var_206_57 = manager.ui.mainCamera.transform
			local var_206_58 = 1.70066666666667

			if var_206_58 < arg_203_1.time_ and arg_203_1.time_ <= var_206_58 + arg_206_0 then
				arg_203_1.var_.shakeOldPos = var_206_57.localPosition
			end

			local var_206_59 = 0.9

			if var_206_58 <= arg_203_1.time_ and arg_203_1.time_ < var_206_58 + var_206_59 then
				local var_206_60 = (arg_203_1.time_ - var_206_58) / 0.066
				local var_206_61, var_206_62 = math.modf(var_206_60)

				var_206_57.localPosition = Vector3.New(var_206_62 * 0.13, var_206_62 * 0.13, var_206_62 * 0.13) + arg_203_1.var_.shakeOldPos
			end

			if arg_203_1.time_ >= var_206_58 + var_206_59 and arg_203_1.time_ < var_206_58 + var_206_59 + arg_206_0 then
				var_206_57.localPosition = arg_203_1.var_.shakeOldPos
			end

			local var_206_63 = 1.83333333333333
			local var_206_64 = 1

			if var_206_63 < arg_203_1.time_ and arg_203_1.time_ <= var_206_63 + arg_206_0 then
				local var_206_65 = "play"
				local var_206_66 = "effect"

				arg_203_1:AudioAction(var_206_65, var_206_66, "se_story_16", "se_story_16_archery", "")
			end

			local var_206_67 = 3.33333333333333
			local var_206_68 = 1

			if var_206_67 < arg_203_1.time_ and arg_203_1.time_ <= var_206_67 + arg_206_0 then
				local var_206_69 = "play"
				local var_206_70 = "effect"

				arg_203_1:AudioAction(var_206_69, var_206_70, "se_story_138", "se_story_138_thunderhit", "")
			end

			local var_206_71 = 1.83333333333333
			local var_206_72 = 1

			if var_206_71 < arg_203_1.time_ and arg_203_1.time_ <= var_206_71 + arg_206_0 then
				local var_206_73 = "play"
				local var_206_74 = "effect"

				arg_203_1:AudioAction(var_206_73, var_206_74, "se_story_121_04", "se_story_121_04_deformation", "")
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_75 = 2.69319013655124
			local var_206_76 = 1.425

			if var_206_75 < arg_203_1.time_ and arg_203_1.time_ <= var_206_75 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_77 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_77:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_78 = arg_203_1:GetWordFromCfg(416111047)
				local var_206_79 = arg_203_1:FormatText(var_206_78.content)

				arg_203_1.text_.text = var_206_79

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_80 = 57
				local var_206_81 = utf8.len(var_206_79)
				local var_206_82 = var_206_80 <= 0 and var_206_76 or var_206_76 * (var_206_81 / var_206_80)

				if var_206_82 > 0 and var_206_76 < var_206_82 then
					arg_203_1.talkMaxDuration = var_206_82
					var_206_75 = var_206_75 + 0.3

					if var_206_82 + var_206_75 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_82 + var_206_75
					end
				end

				arg_203_1.text_.text = var_206_79
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_83 = var_206_75 + 0.3
			local var_206_84 = math.max(var_206_76, arg_203_1.talkMaxDuration)

			if var_206_83 <= arg_203_1.time_ and arg_203_1.time_ < var_206_83 + var_206_84 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_83) / var_206_84

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_83 + var_206_84 and arg_203_1.time_ < var_206_83 + var_206_84 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0679999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play416111048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416111048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play416111049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.425

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(416111048)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 57
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play416111049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416111049
		arg_213_1.duration_ = 4.93

		local var_213_0 = {
			zh = 4.233,
			ja = 4.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play416111050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.933333333333333

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				local var_216_2 = "stop"
				local var_216_3 = "effect"

				arg_213_1:AudioAction(var_216_2, var_216_3, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_216_4 = 0
			local var_216_5 = 0.933333333333333

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				local var_216_6 = "play"
				local var_216_7 = "effect"

				arg_213_1:AudioAction(var_216_6, var_216_7, "se_story_5", "se_story_5_heartbeat_stop", "")
			end

			local var_216_8 = 0
			local var_216_9 = 0.45

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_10 = arg_213_1:FormatText(StoryNameCfg[8].name)

				arg_213_1.leftNameTxt_.text = var_216_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_11 = arg_213_1:GetWordFromCfg(416111049)
				local var_216_12 = arg_213_1:FormatText(var_216_11.content)

				arg_213_1.text_.text = var_216_12

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 18
				local var_216_14 = utf8.len(var_216_12)
				local var_216_15 = var_216_13 <= 0 and var_216_9 or var_216_9 * (var_216_14 / var_216_13)

				if var_216_15 > 0 and var_216_9 < var_216_15 then
					arg_213_1.talkMaxDuration = var_216_15

					if var_216_15 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_15 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_12
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111049", "story_v_out_416111.awb") ~= 0 then
					local var_216_16 = manager.audio:GetVoiceLength("story_v_out_416111", "416111049", "story_v_out_416111.awb") / 1000

					if var_216_16 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_16 + var_216_8
					end

					if var_216_11.prefab_name ~= "" and arg_213_1.actors_[var_216_11.prefab_name] ~= nil then
						local var_216_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_11.prefab_name].transform, "story_v_out_416111", "416111049", "story_v_out_416111.awb")

						arg_213_1:RecordAudio("416111049", var_216_17)
						arg_213_1:RecordAudio("416111049", var_216_17)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416111", "416111049", "story_v_out_416111.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416111", "416111049", "story_v_out_416111.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_18 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_18 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_18

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_18 and arg_213_1.time_ < var_216_8 + var_216_18 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play416111050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416111050
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play416111051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.075

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

				local var_220_2 = arg_217_1:GetWordFromCfg(416111050)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 43
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
	Play416111051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 416111051
		arg_221_1.duration_ = 6.3

		local var_221_0 = {
			zh = 4.933,
			ja = 6.3
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
				arg_221_0:Play416111052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.5

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[8].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(416111051)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 20
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111051", "story_v_out_416111.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111051", "story_v_out_416111.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_416111", "416111051", "story_v_out_416111.awb")

						arg_221_1:RecordAudio("416111051", var_224_9)
						arg_221_1:RecordAudio("416111051", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_416111", "416111051", "story_v_out_416111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_416111", "416111051", "story_v_out_416111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play416111052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 416111052
		arg_225_1.duration_ = 4.63

		local var_225_0 = {
			zh = 4.366,
			ja = 4.633
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
				arg_225_0:Play416111053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.bgs_.SS1605.transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPosSS1605 = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, 1, 9)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPosSS1605, var_228_4, var_228_3)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_228_5 = arg_225_1.bgs_.SS1605.transform
			local var_228_6 = 0.0339999999999998

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.var_.moveOldPosSS1605 = var_228_5.localPosition
			end

			local var_228_7 = 0.966

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_7 then
				local var_228_8 = (arg_225_1.time_ - var_228_6) / var_228_7
				local var_228_9 = Vector3.New(0, 0.9, 8.5)

				var_228_5.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPosSS1605, var_228_9, var_228_8)
			end

			if arg_225_1.time_ >= var_228_6 + var_228_7 and arg_225_1.time_ < var_228_6 + var_228_7 + arg_228_0 then
				var_228_5.localPosition = Vector3.New(0, 0.9, 8.5)
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_10 = 1
			local var_228_11 = 0.325

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_12 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_12:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_13 = arg_225_1:FormatText(StoryNameCfg[8].name)

				arg_225_1.leftNameTxt_.text = var_228_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_14 = arg_225_1:GetWordFromCfg(416111052)
				local var_228_15 = arg_225_1:FormatText(var_228_14.content)

				arg_225_1.text_.text = var_228_15

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_16 = 13
				local var_228_17 = utf8.len(var_228_15)
				local var_228_18 = var_228_16 <= 0 and var_228_11 or var_228_11 * (var_228_17 / var_228_16)

				if var_228_18 > 0 and var_228_11 < var_228_18 then
					arg_225_1.talkMaxDuration = var_228_18
					var_228_10 = var_228_10 + 0.3

					if var_228_18 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_10
					end
				end

				arg_225_1.text_.text = var_228_15
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111052", "story_v_out_416111.awb") ~= 0 then
					local var_228_19 = manager.audio:GetVoiceLength("story_v_out_416111", "416111052", "story_v_out_416111.awb") / 1000

					if var_228_19 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_19 + var_228_10
					end

					if var_228_14.prefab_name ~= "" and arg_225_1.actors_[var_228_14.prefab_name] ~= nil then
						local var_228_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_14.prefab_name].transform, "story_v_out_416111", "416111052", "story_v_out_416111.awb")

						arg_225_1:RecordAudio("416111052", var_228_20)
						arg_225_1:RecordAudio("416111052", var_228_20)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_416111", "416111052", "story_v_out_416111.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_416111", "416111052", "story_v_out_416111.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_21 = var_228_10 + 0.3
			local var_228_22 = math.max(var_228_11, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_22 and arg_225_1.time_ < var_228_21 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play416111053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416111053
		arg_231_1.duration_ = 8.9

		local var_231_0 = {
			zh = 5.966,
			ja = 8.9
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
				arg_231_0:Play416111054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.5

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[36].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(416111053)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111053", "story_v_out_416111.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111053", "story_v_out_416111.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_416111", "416111053", "story_v_out_416111.awb")

						arg_231_1:RecordAudio("416111053", var_234_9)
						arg_231_1:RecordAudio("416111053", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416111", "416111053", "story_v_out_416111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416111", "416111053", "story_v_out_416111.awb")
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
	Play416111054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416111054
		arg_235_1.duration_ = 7.07

		local var_235_0 = {
			zh = 4.2,
			ja = 7.066
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
				arg_235_0:Play416111055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.375

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[8].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:GetWordFromCfg(416111054)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 15
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111054", "story_v_out_416111.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111054", "story_v_out_416111.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_416111", "416111054", "story_v_out_416111.awb")

						arg_235_1:RecordAudio("416111054", var_238_9)
						arg_235_1:RecordAudio("416111054", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416111", "416111054", "story_v_out_416111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416111", "416111054", "story_v_out_416111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416111055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416111055
		arg_239_1.duration_ = 5.5

		local var_239_0 = {
			zh = 4.933,
			ja = 5.5
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
				arg_239_0:Play416111056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.575

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[8].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(416111055)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111055", "story_v_out_416111.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111055", "story_v_out_416111.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_416111", "416111055", "story_v_out_416111.awb")

						arg_239_1:RecordAudio("416111055", var_242_9)
						arg_239_1:RecordAudio("416111055", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416111", "416111055", "story_v_out_416111.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416111", "416111055", "story_v_out_416111.awb")
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
	Play416111056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416111056
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play416111057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1148"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1148 = var_246_0.localPosition
				var_246_0.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1148", 7)

				local var_246_2 = var_246_0.childCount

				for iter_246_0 = 0, var_246_2 - 1 do
					local var_246_3 = var_246_0:GetChild(iter_246_0)

					if var_246_3.name == "" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_4 then
				local var_246_5 = (arg_243_1.time_ - var_246_1) / var_246_4
				local var_246_6 = Vector3.New(0, -2000, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1148, var_246_6, var_246_5)
			end

			if arg_243_1.time_ >= var_246_1 + var_246_4 and arg_243_1.time_ < var_246_1 + var_246_4 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_246_7 = 0
			local var_246_8 = 1.525

			if var_246_7 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_9 = arg_243_1:GetWordFromCfg(416111056)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 61
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_8 or var_246_8 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_8 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_7 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_7
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_8, arg_243_1.talkMaxDuration)

			if var_246_7 <= arg_243_1.time_ and arg_243_1.time_ < var_246_7 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_7) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_7 + var_246_14 and arg_243_1.time_ < var_246_7 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play416111057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416111057
		arg_247_1.duration_ = 7.03

		local var_247_0 = {
			zh = 4.333,
			ja = 7.033
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
				arg_247_0:Play416111058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.475

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[8].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(416111057)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 19
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111057", "story_v_out_416111.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111057", "story_v_out_416111.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_416111", "416111057", "story_v_out_416111.awb")

						arg_247_1:RecordAudio("416111057", var_250_9)
						arg_247_1:RecordAudio("416111057", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416111", "416111057", "story_v_out_416111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416111", "416111057", "story_v_out_416111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play416111058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416111058
		arg_251_1.duration_ = 5.83

		local var_251_0 = {
			zh = 4.233,
			ja = 5.833
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
				arg_251_0:Play416111059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.45

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[8].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(416111058)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 18
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111058", "story_v_out_416111.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111058", "story_v_out_416111.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_416111", "416111058", "story_v_out_416111.awb")

						arg_251_1:RecordAudio("416111058", var_254_9)
						arg_251_1:RecordAudio("416111058", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416111", "416111058", "story_v_out_416111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416111", "416111058", "story_v_out_416111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416111059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416111059
		arg_255_1.duration_ = 4.13

		local var_255_0 = {
			zh = 3.2,
			ja = 4.133
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
			arg_255_1.auto_ = false
		end

		function arg_255_1.playNext_(arg_257_0)
			arg_255_1.onStoryFinished_()
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.bgs_.SS1605.transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPosSS1605 = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, 0.9, 8.5)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPosSS1605, var_258_4, var_258_3)
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, 0.9, 8.5)
			end

			local var_258_5 = arg_255_1.bgs_.SS1605.transform
			local var_258_6 = 0.0339999999999998

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.var_.moveOldPosSS1605 = var_258_5.localPosition
			end

			local var_258_7 = 0.466

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_7 then
				local var_258_8 = (arg_255_1.time_ - var_258_6) / var_258_7
				local var_258_9 = Vector3.New(0, 0.95, 9)

				var_258_5.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPosSS1605, var_258_9, var_258_8)
			end

			if arg_255_1.time_ >= var_258_6 + var_258_7 and arg_255_1.time_ < var_258_6 + var_258_7 + arg_258_0 then
				var_258_5.localPosition = Vector3.New(0, 0.95, 9)
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_10 = 0.5
			local var_258_11 = 0.25

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_12 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_12:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_13 = arg_255_1:FormatText(StoryNameCfg[8].name)

				arg_255_1.leftNameTxt_.text = var_258_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_14 = arg_255_1:GetWordFromCfg(416111059)
				local var_258_15 = arg_255_1:FormatText(var_258_14.content)

				arg_255_1.text_.text = var_258_15

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_16 = 10
				local var_258_17 = utf8.len(var_258_15)
				local var_258_18 = var_258_16 <= 0 and var_258_11 or var_258_11 * (var_258_17 / var_258_16)

				if var_258_18 > 0 and var_258_11 < var_258_18 then
					arg_255_1.talkMaxDuration = var_258_18
					var_258_10 = var_258_10 + 0.3

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_15
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111059", "story_v_out_416111.awb") ~= 0 then
					local var_258_19 = manager.audio:GetVoiceLength("story_v_out_416111", "416111059", "story_v_out_416111.awb") / 1000

					if var_258_19 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_19 + var_258_10
					end

					if var_258_14.prefab_name ~= "" and arg_255_1.actors_[var_258_14.prefab_name] ~= nil then
						local var_258_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_14.prefab_name].transform, "story_v_out_416111", "416111059", "story_v_out_416111.awb")

						arg_255_1:RecordAudio("416111059", var_258_20)
						arg_255_1:RecordAudio("416111059", var_258_20)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416111", "416111059", "story_v_out_416111.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416111", "416111059", "story_v_out_416111.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_21 = var_258_10 + 0.3
			local var_258_22 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_22 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_21) / var_258_22

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_21 + var_258_22 and arg_255_1.time_ < var_258_21 + var_258_22 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.466,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS1604",
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1605"
	},
	voices = {
		"story_v_out_416111.awb"
	}
}
