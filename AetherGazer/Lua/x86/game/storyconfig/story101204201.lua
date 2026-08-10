return {
	Play120421001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120421001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			zh = 5.033999999999,
			ja = 6.566
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
				arg_1_0:Play120421002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "XH0204"

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
				local var_4_5 = arg_1_1.bgs_.XH0204

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
					if iter_4_0 ~= "XH0204" then
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
			local var_4_23 = 0.3

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

			local var_4_28 = arg_1_1.bgs_.XH0204.transform
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0204 = var_4_28.localPosition
			end

			local var_4_30 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30
				local var_4_32 = Vector3.New(0, 2, 1)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0204, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, 2, 1)
			end

			local var_4_33 = arg_1_1.bgs_.XH0204.transform
			local var_4_34 = 0.034

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0204 = var_4_33.localPosition
			end

			local var_4_35 = 5

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35
				local var_4_37 = Vector3.New(0, 2.5, 1)

				var_4_33.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0204, var_4_37, var_4_36)
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				var_4_33.localPosition = Vector3.New(0, 2.5, 1)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.1

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

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[399].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(120421001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421001", "story_v_out_120421.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_120421", "120421001", "story_v_out_120421.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_120421", "120421001", "story_v_out_120421.awb")

						arg_1_1:RecordAudio("120421001", var_4_48)
						arg_1_1:RecordAudio("120421001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120421", "120421001", "story_v_out_120421.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120421", "120421001", "story_v_out_120421.awb")
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120421002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 120421002
		arg_8_1.duration_ = 4.47

		local var_8_0 = {
			zh = 2.6,
			ja = 4.466
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
				arg_8_0:Play120421003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.25

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[399].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(120421002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421002", "story_v_out_120421.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421002", "story_v_out_120421.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_120421", "120421002", "story_v_out_120421.awb")

						arg_8_1:RecordAudio("120421002", var_11_9)
						arg_8_1:RecordAudio("120421002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_120421", "120421002", "story_v_out_120421.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_120421", "120421002", "story_v_out_120421.awb")
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
	Play120421003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 120421003
		arg_12_1.duration_ = 8.87

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play120421004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.bgs_.XH0204.transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPosXH0204 = var_15_0.localPosition
			end

			local var_15_2 = 8

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, 2.5, 2.5)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosXH0204, var_15_4, var_15_3)
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 2.5, 2.5)
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_6 = 8

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_7 = 0
			local var_15_8 = 0.3

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_9 = arg_12_1:FormatText(StoryNameCfg[399].name)

				arg_12_1.leftNameTxt_.text = var_15_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(120421003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_12 = 12
				local var_15_13 = utf8.len(var_15_11)
				local var_15_14 = var_15_12 <= 0 and var_15_8 or var_15_8 * (var_15_13 / var_15_12)

				if var_15_14 > 0 and var_15_8 < var_15_14 then
					arg_12_1.talkMaxDuration = var_15_14

					if var_15_14 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_7
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421003", "story_v_out_120421.awb") ~= 0 then
					local var_15_15 = manager.audio:GetVoiceLength("story_v_out_120421", "120421003", "story_v_out_120421.awb") / 1000

					if var_15_15 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_7
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_120421", "120421003", "story_v_out_120421.awb")

						arg_12_1:RecordAudio("120421003", var_15_16)
						arg_12_1:RecordAudio("120421003", var_15_16)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_120421", "120421003", "story_v_out_120421.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_120421", "120421003", "story_v_out_120421.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_17 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_7) / var_15_17

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_7 + var_15_17 and arg_12_1.time_ < var_15_7 + var_15_17 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play120421004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 120421004
		arg_16_1.duration_ = 7.8

		local var_16_0 = {
			zh = 4.6,
			ja = 7.8
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
				arg_16_0:Play120421005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.325

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[399].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(120421004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421004", "story_v_out_120421.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421004", "story_v_out_120421.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_120421", "120421004", "story_v_out_120421.awb")

						arg_16_1:RecordAudio("120421004", var_19_9)
						arg_16_1:RecordAudio("120421004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_120421", "120421004", "story_v_out_120421.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_120421", "120421004", "story_v_out_120421.awb")
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
	Play120421005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 120421005
		arg_20_1.duration_ = 2.63

		local var_20_0 = {
			zh = 2.633,
			ja = 2.1
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
				arg_20_0:Play120421006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.15

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[399].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(120421005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421005", "story_v_out_120421.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421005", "story_v_out_120421.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_120421", "120421005", "story_v_out_120421.awb")

						arg_20_1:RecordAudio("120421005", var_23_9)
						arg_20_1:RecordAudio("120421005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_120421", "120421005", "story_v_out_120421.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_120421", "120421005", "story_v_out_120421.awb")
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
	Play120421006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 120421006
		arg_24_1.duration_ = 4.77

		local var_24_0 = {
			zh = 3.4,
			ja = 4.766
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
				arg_24_0:Play120421007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.125

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[399].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(120421006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421006", "story_v_out_120421.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421006", "story_v_out_120421.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_120421", "120421006", "story_v_out_120421.awb")

						arg_24_1:RecordAudio("120421006", var_27_9)
						arg_24_1:RecordAudio("120421006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_120421", "120421006", "story_v_out_120421.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_120421", "120421006", "story_v_out_120421.awb")
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
	Play120421007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 120421007
		arg_28_1.duration_ = 3.83

		local var_28_0 = {
			zh = 2.966,
			ja = 3.833
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
				arg_28_0:Play120421008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.2

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[399].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(120421007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421007", "story_v_out_120421.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421007", "story_v_out_120421.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_120421", "120421007", "story_v_out_120421.awb")

						arg_28_1:RecordAudio("120421007", var_31_9)
						arg_28_1:RecordAudio("120421007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_120421", "120421007", "story_v_out_120421.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_120421", "120421007", "story_v_out_120421.awb")
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
	Play120421008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 120421008
		arg_32_1.duration_ = 9.37

		local var_32_0 = {
			zh = 7.866,
			ja = 9.366
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
				arg_32_0:Play120421009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.5

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[399].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(120421008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421008", "story_v_out_120421.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421008", "story_v_out_120421.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_120421", "120421008", "story_v_out_120421.awb")

						arg_32_1:RecordAudio("120421008", var_35_9)
						arg_32_1:RecordAudio("120421008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_120421", "120421008", "story_v_out_120421.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_120421", "120421008", "story_v_out_120421.awb")
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
	Play120421009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 120421009
		arg_36_1.duration_ = 9.77

		local var_36_0 = {
			zh = 9.766,
			ja = 7.5
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
				arg_36_0:Play120421010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.5

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[399].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(120421009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421009", "story_v_out_120421.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421009", "story_v_out_120421.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_120421", "120421009", "story_v_out_120421.awb")

						arg_36_1:RecordAudio("120421009", var_39_9)
						arg_36_1:RecordAudio("120421009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_120421", "120421009", "story_v_out_120421.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_120421", "120421009", "story_v_out_120421.awb")
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
	Play120421010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 120421010
		arg_40_1.duration_ = 7.43

		local var_40_0 = {
			zh = 4.2,
			ja = 7.433
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
				arg_40_0:Play120421011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.3

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[399].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(120421010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421010", "story_v_out_120421.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421010", "story_v_out_120421.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_120421", "120421010", "story_v_out_120421.awb")

						arg_40_1:RecordAudio("120421010", var_43_9)
						arg_40_1:RecordAudio("120421010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_120421", "120421010", "story_v_out_120421.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_120421", "120421010", "story_v_out_120421.awb")
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
	Play120421011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 120421011
		arg_44_1.duration_ = 2.67

		local var_44_0 = {
			zh = 1.5,
			ja = 2.666
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
				arg_44_0:Play120421012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.05

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[399].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(120421011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421011", "story_v_out_120421.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421011", "story_v_out_120421.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_120421", "120421011", "story_v_out_120421.awb")

						arg_44_1:RecordAudio("120421011", var_47_9)
						arg_44_1:RecordAudio("120421011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_120421", "120421011", "story_v_out_120421.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_120421", "120421011", "story_v_out_120421.awb")
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
	Play120421012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 120421012
		arg_48_1.duration_ = 4.37

		local var_48_0 = {
			zh = 4.366,
			ja = 4.233
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
				arg_48_0:Play120421013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.225

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[399].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(120421012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421012", "story_v_out_120421.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421012", "story_v_out_120421.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_120421", "120421012", "story_v_out_120421.awb")

						arg_48_1:RecordAudio("120421012", var_51_9)
						arg_48_1:RecordAudio("120421012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_120421", "120421012", "story_v_out_120421.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_120421", "120421012", "story_v_out_120421.awb")
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
	Play120421013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 120421013
		arg_52_1.duration_ = 2.8

		local var_52_0 = {
			zh = 1.366,
			ja = 2.8
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
				arg_52_0:Play120421014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.125

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[399].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(120421013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421013", "story_v_out_120421.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421013", "story_v_out_120421.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_120421", "120421013", "story_v_out_120421.awb")

						arg_52_1:RecordAudio("120421013", var_55_9)
						arg_52_1:RecordAudio("120421013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_120421", "120421013", "story_v_out_120421.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_120421", "120421013", "story_v_out_120421.awb")
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
	Play120421014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 120421014
		arg_56_1.duration_ = 9.43

		local var_56_0 = {
			zh = 6.866,
			ja = 9.433
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play120421015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.bgs_.XH0204.transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPosXH0204 = var_59_0.localPosition
			end

			local var_59_2 = 5

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 2.5, 3.5)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosXH0204, var_59_4, var_59_3)
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 2.5, 3.5)
			end

			local var_59_5 = 0
			local var_59_6 = 0.45

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_7 = arg_56_1:FormatText(StoryNameCfg[399].name)

				arg_56_1.leftNameTxt_.text = var_59_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(120421014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 18
				local var_59_11 = utf8.len(var_59_9)
				local var_59_12 = var_59_10 <= 0 and var_59_6 or var_59_6 * (var_59_11 / var_59_10)

				if var_59_12 > 0 and var_59_6 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12

					if var_59_12 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421014", "story_v_out_120421.awb") ~= 0 then
					local var_59_13 = manager.audio:GetVoiceLength("story_v_out_120421", "120421014", "story_v_out_120421.awb") / 1000

					if var_59_13 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_5
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_120421", "120421014", "story_v_out_120421.awb")

						arg_56_1:RecordAudio("120421014", var_59_14)
						arg_56_1:RecordAudio("120421014", var_59_14)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_120421", "120421014", "story_v_out_120421.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_120421", "120421014", "story_v_out_120421.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_15 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_15 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_15

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_15 and arg_56_1.time_ < var_59_5 + var_59_15 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play120421015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 120421015
		arg_60_1.duration_ = 4.53

		local var_60_0 = {
			zh = 4.533,
			ja = 3.033
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
				arg_60_0:Play120421016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.3

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[399].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(120421015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421015", "story_v_out_120421.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421015", "story_v_out_120421.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_120421", "120421015", "story_v_out_120421.awb")

						arg_60_1:RecordAudio("120421015", var_63_9)
						arg_60_1:RecordAudio("120421015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_120421", "120421015", "story_v_out_120421.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_120421", "120421015", "story_v_out_120421.awb")
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
	Play120421016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 120421016
		arg_64_1.duration_ = 8.03

		local var_64_0 = {
			zh = 8.033,
			ja = 7.7
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play120421017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 2

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_1 = manager.ui.mainCamera.transform.localPosition
				local var_67_2 = Vector3.New(0, 0, 10) + Vector3.New(var_67_1.x, var_67_1.y, 0)
				local var_67_3 = arg_64_1.bgs_.XH0204

				var_67_3.transform.localPosition = var_67_2
				var_67_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_4 = var_67_3:GetComponent("SpriteRenderer")

				if var_67_4 and var_67_4.sprite then
					local var_67_5 = (var_67_3.transform.localPosition - var_67_1).z
					local var_67_6 = manager.ui.mainCameraCom_
					local var_67_7 = 2 * var_67_5 * Mathf.Tan(var_67_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_8 = var_67_7 * var_67_6.aspect
					local var_67_9 = var_67_4.sprite.bounds.size.x
					local var_67_10 = var_67_4.sprite.bounds.size.y
					local var_67_11 = var_67_8 / var_67_9
					local var_67_12 = var_67_7 / var_67_10
					local var_67_13 = var_67_12 < var_67_11 and var_67_11 or var_67_12

					var_67_3.transform.localScale = Vector3.New(var_67_13, var_67_13, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "XH0204" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_15 = 2

			if var_67_14 <= arg_64_1.time_ and arg_64_1.time_ < var_67_14 + var_67_15 then
				local var_67_16 = (arg_64_1.time_ - var_67_14) / var_67_15
				local var_67_17 = Color.New(0, 0, 0)

				var_67_17.a = Mathf.Lerp(0, 1, var_67_16)
				arg_64_1.mask_.color = var_67_17
			end

			if arg_64_1.time_ >= var_67_14 + var_67_15 and arg_64_1.time_ < var_67_14 + var_67_15 + arg_67_0 then
				local var_67_18 = Color.New(0, 0, 0)

				var_67_18.a = 1
				arg_64_1.mask_.color = var_67_18
			end

			local var_67_19 = 2

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_20 = 2

			if var_67_19 <= arg_64_1.time_ and arg_64_1.time_ < var_67_19 + var_67_20 then
				local var_67_21 = (arg_64_1.time_ - var_67_19) / var_67_20
				local var_67_22 = Color.New(0, 0, 0)

				var_67_22.a = Mathf.Lerp(1, 0, var_67_21)
				arg_64_1.mask_.color = var_67_22
			end

			if arg_64_1.time_ >= var_67_19 + var_67_20 and arg_64_1.time_ < var_67_19 + var_67_20 + arg_67_0 then
				local var_67_23 = Color.New(0, 0, 0)
				local var_67_24 = 0

				arg_64_1.mask_.enabled = false
				var_67_23.a = var_67_24
				arg_64_1.mask_.color = var_67_23
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_25 = 4
			local var_67_26 = 0.25

			if var_67_25 < arg_64_1.time_ and arg_64_1.time_ <= var_67_25 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_27 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_27:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_28 = arg_64_1:FormatText(StoryNameCfg[399].name)

				arg_64_1.leftNameTxt_.text = var_67_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_29 = arg_64_1:GetWordFromCfg(120421016)
				local var_67_30 = arg_64_1:FormatText(var_67_29.content)

				arg_64_1.text_.text = var_67_30

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_31 = 10
				local var_67_32 = utf8.len(var_67_30)
				local var_67_33 = var_67_31 <= 0 and var_67_26 or var_67_26 * (var_67_32 / var_67_31)

				if var_67_33 > 0 and var_67_26 < var_67_33 then
					arg_64_1.talkMaxDuration = var_67_33
					var_67_25 = var_67_25 + 0.3

					if var_67_33 + var_67_25 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_33 + var_67_25
					end
				end

				arg_64_1.text_.text = var_67_30
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421016", "story_v_out_120421.awb") ~= 0 then
					local var_67_34 = manager.audio:GetVoiceLength("story_v_out_120421", "120421016", "story_v_out_120421.awb") / 1000

					if var_67_34 + var_67_25 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_34 + var_67_25
					end

					if var_67_29.prefab_name ~= "" and arg_64_1.actors_[var_67_29.prefab_name] ~= nil then
						local var_67_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_29.prefab_name].transform, "story_v_out_120421", "120421016", "story_v_out_120421.awb")

						arg_64_1:RecordAudio("120421016", var_67_35)
						arg_64_1:RecordAudio("120421016", var_67_35)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_120421", "120421016", "story_v_out_120421.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_120421", "120421016", "story_v_out_120421.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_36 = var_67_25 + 0.3
			local var_67_37 = math.max(var_67_26, arg_64_1.talkMaxDuration)

			if var_67_36 <= arg_64_1.time_ and arg_64_1.time_ < var_67_36 + var_67_37 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_36) / var_67_37

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_36 + var_67_37 and arg_64_1.time_ < var_67_36 + var_67_37 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play120421017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 120421017
		arg_70_1.duration_ = 6.57

		local var_70_0 = {
			zh = 6.566,
			ja = 5.133
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
				arg_70_0:Play120421018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "ST37"

			if arg_70_1.bgs_[var_73_0] == nil then
				local var_73_1 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_0)
				var_73_1.name = var_73_0
				var_73_1.transform.parent = arg_70_1.stage_.transform
				var_73_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_0] = var_73_1
			end

			local var_73_2 = 2

			if var_73_2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				local var_73_3 = manager.ui.mainCamera.transform.localPosition
				local var_73_4 = Vector3.New(0, 0, 10) + Vector3.New(var_73_3.x, var_73_3.y, 0)
				local var_73_5 = arg_70_1.bgs_.ST37

				var_73_5.transform.localPosition = var_73_4
				var_73_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_6 = var_73_5:GetComponent("SpriteRenderer")

				if var_73_6 and var_73_6.sprite then
					local var_73_7 = (var_73_5.transform.localPosition - var_73_3).z
					local var_73_8 = manager.ui.mainCameraCom_
					local var_73_9 = 2 * var_73_7 * Mathf.Tan(var_73_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_10 = var_73_9 * var_73_8.aspect
					local var_73_11 = var_73_6.sprite.bounds.size.x
					local var_73_12 = var_73_6.sprite.bounds.size.y
					local var_73_13 = var_73_10 / var_73_11
					local var_73_14 = var_73_9 / var_73_12
					local var_73_15 = var_73_14 < var_73_13 and var_73_13 or var_73_14

					var_73_5.transform.localScale = Vector3.New(var_73_15, var_73_15, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST37" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_17 = 2

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_17 then
				local var_73_18 = (arg_70_1.time_ - var_73_16) / var_73_17
				local var_73_19 = Color.New(0, 0, 0)

				var_73_19.a = Mathf.Lerp(0, 1, var_73_18)
				arg_70_1.mask_.color = var_73_19
			end

			if arg_70_1.time_ >= var_73_16 + var_73_17 and arg_70_1.time_ < var_73_16 + var_73_17 + arg_73_0 then
				local var_73_20 = Color.New(0, 0, 0)

				var_73_20.a = 1
				arg_70_1.mask_.color = var_73_20
			end

			local var_73_21 = 2

			if var_73_21 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_22 = 2

			if var_73_21 <= arg_70_1.time_ and arg_70_1.time_ < var_73_21 + var_73_22 then
				local var_73_23 = (arg_70_1.time_ - var_73_21) / var_73_22
				local var_73_24 = Color.New(0, 0, 0)

				var_73_24.a = Mathf.Lerp(1, 0, var_73_23)
				arg_70_1.mask_.color = var_73_24
			end

			if arg_70_1.time_ >= var_73_21 + var_73_22 and arg_70_1.time_ < var_73_21 + var_73_22 + arg_73_0 then
				local var_73_25 = Color.New(0, 0, 0)
				local var_73_26 = 0

				arg_70_1.mask_.enabled = false
				var_73_25.a = var_73_26
				arg_70_1.mask_.color = var_73_25
			end

			local var_73_27 = 0.133333333333333
			local var_73_28 = 1

			if var_73_27 < arg_70_1.time_ and arg_70_1.time_ <= var_73_27 + arg_73_0 then
				local var_73_29 = "play"
				local var_73_30 = "music"

				arg_70_1:AudioAction(var_73_29, var_73_30, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_73_31 = ""
				local var_73_32 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_73_32 ~= "" then
					if arg_70_1.bgmTxt_.text ~= var_73_32 and arg_70_1.bgmTxt_.text ~= "" then
						if arg_70_1.bgmTxt2_.text ~= "" then
							arg_70_1.bgmTxt_.text = arg_70_1.bgmTxt2_.text
						end

						arg_70_1.bgmTxt2_.text = var_73_32

						arg_70_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_70_1.bgmTxt_.text = var_73_32
						arg_70_1.bgmTxt2_.text = var_73_32
					end

					if arg_70_1.bgmTimer then
						arg_70_1.bgmTimer:Stop()

						arg_70_1.bgmTimer = nil
					end

					if arg_70_1.settingData.show_music_name == 1 then
						arg_70_1.musicController:SetSelectedState("show")
						arg_70_1.musicAnimator_:Play("open", 0, 0)

						if arg_70_1.settingData.music_time ~= 0 then
							arg_70_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_70_1.settingData.music_time), function()
								if arg_70_1 == nil or isNil(arg_70_1.bgmTxt_) then
									return
								end

								arg_70_1.musicController:SetSelectedState("hide")
								arg_70_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_33 = 4
			local var_73_34 = 0.075

			if var_73_33 < arg_70_1.time_ and arg_70_1.time_ <= var_73_33 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_35 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_35:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_70_1.dialogCg_.alpha = arg_75_0
				end))
				var_73_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_36 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_37 = arg_70_1:GetWordFromCfg(120421017)
				local var_73_38 = arg_70_1:FormatText(var_73_37.content)

				arg_70_1.text_.text = var_73_38

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_39 = 3
				local var_73_40 = utf8.len(var_73_38)
				local var_73_41 = var_73_39 <= 0 and var_73_34 or var_73_34 * (var_73_40 / var_73_39)

				if var_73_41 > 0 and var_73_34 < var_73_41 then
					arg_70_1.talkMaxDuration = var_73_41
					var_73_33 = var_73_33 + 0.3

					if var_73_41 + var_73_33 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_41 + var_73_33
					end
				end

				arg_70_1.text_.text = var_73_38
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421017", "story_v_out_120421.awb") ~= 0 then
					local var_73_42 = manager.audio:GetVoiceLength("story_v_out_120421", "120421017", "story_v_out_120421.awb") / 1000

					if var_73_42 + var_73_33 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_42 + var_73_33
					end

					if var_73_37.prefab_name ~= "" and arg_70_1.actors_[var_73_37.prefab_name] ~= nil then
						local var_73_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_37.prefab_name].transform, "story_v_out_120421", "120421017", "story_v_out_120421.awb")

						arg_70_1:RecordAudio("120421017", var_73_43)
						arg_70_1:RecordAudio("120421017", var_73_43)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_120421", "120421017", "story_v_out_120421.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_120421", "120421017", "story_v_out_120421.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_44 = var_73_33 + 0.3
			local var_73_45 = math.max(var_73_34, arg_70_1.talkMaxDuration)

			if var_73_44 <= arg_70_1.time_ and arg_70_1.time_ < var_73_44 + var_73_45 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_44) / var_73_45

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_44 + var_73_45 and arg_70_1.time_ < var_73_44 + var_73_45 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play120421018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120421018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120421019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.55

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(120421018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 62
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120421019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120421019
		arg_81_1.duration_ = 8.43

		local var_81_0 = {
			zh = 3.5,
			ja = 8.433
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
				arg_81_0:Play120421020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "1084ui_story"

			if arg_81_1.actors_[var_84_0] == nil then
				local var_84_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_84_1) then
					local var_84_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_81_1.stage_.transform)

					var_84_2.name = var_84_0
					var_84_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_81_1.actors_[var_84_0] = var_84_2

					local var_84_3 = var_84_2:GetComponentInChildren(typeof(CharacterEffect))

					var_84_3.enabled = true

					local var_84_4 = GameObjectTools.GetOrAddComponent(var_84_2, typeof(DynamicBoneHelper))

					if var_84_4 then
						var_84_4:EnableDynamicBone(false)
					end

					arg_81_1:ShowWeapon(var_84_3.transform, false)

					arg_81_1.var_[var_84_0 .. "Animator"] = var_84_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_81_1.var_[var_84_0 .. "Animator"].applyRootMotion = true
					arg_81_1.var_[var_84_0 .. "LipSync"] = var_84_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_84_5 = arg_81_1.actors_["1084ui_story"].transform
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_5.localPosition
			end

			local var_84_7 = 0.001

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7
				local var_84_9 = Vector3.New(0, -0.97, -6)

				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, var_84_9, var_84_8)

				local var_84_10 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_10.x, var_84_10.y, var_84_10.z)

				local var_84_11 = var_84_5.localEulerAngles

				var_84_11.z = 0
				var_84_11.x = 0
				var_84_5.localEulerAngles = var_84_11
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_84_12 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_12.x, var_84_12.y, var_84_12.z)

				local var_84_13 = var_84_5.localEulerAngles

				var_84_13.z = 0
				var_84_13.x = 0
				var_84_5.localEulerAngles = var_84_13
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_84_16 = arg_81_1.actors_["1084ui_story"]
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 and not isNil(var_84_16) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_18 = 0.2

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_18 and not isNil(var_84_16) then
				local var_84_19 = (arg_81_1.time_ - var_84_17) / var_84_18

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_16) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_17 + var_84_18 and arg_81_1.time_ < var_84_17 + var_84_18 + arg_84_0 and not isNil(var_84_16) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_20 = 0
			local var_84_21 = 0.225

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_22 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_23 = arg_81_1:GetWordFromCfg(120421019)
				local var_84_24 = arg_81_1:FormatText(var_84_23.content)

				arg_81_1.text_.text = var_84_24

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_25 = 9
				local var_84_26 = utf8.len(var_84_24)
				local var_84_27 = var_84_25 <= 0 and var_84_21 or var_84_21 * (var_84_26 / var_84_25)

				if var_84_27 > 0 and var_84_21 < var_84_27 then
					arg_81_1.talkMaxDuration = var_84_27

					if var_84_27 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_27 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_24
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421019", "story_v_out_120421.awb") ~= 0 then
					local var_84_28 = manager.audio:GetVoiceLength("story_v_out_120421", "120421019", "story_v_out_120421.awb") / 1000

					if var_84_28 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_20
					end

					if var_84_23.prefab_name ~= "" and arg_81_1.actors_[var_84_23.prefab_name] ~= nil then
						local var_84_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_23.prefab_name].transform, "story_v_out_120421", "120421019", "story_v_out_120421.awb")

						arg_81_1:RecordAudio("120421019", var_84_29)
						arg_81_1:RecordAudio("120421019", var_84_29)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120421", "120421019", "story_v_out_120421.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120421", "120421019", "story_v_out_120421.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_30 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_30 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_30

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_30 and arg_81_1.time_ < var_84_20 + var_84_30 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play120421020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120421020
		arg_85_1.duration_ = 5.3

		local var_85_0 = {
			zh = 5.3,
			ja = 3.9
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
				arg_85_0:Play120421021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.2

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
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(120421020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421020", "story_v_out_120421.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421020", "story_v_out_120421.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_120421", "120421020", "story_v_out_120421.awb")

						arg_85_1:RecordAudio("120421020", var_88_9)
						arg_85_1:RecordAudio("120421020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120421", "120421020", "story_v_out_120421.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120421", "120421020", "story_v_out_120421.awb")
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
	Play120421021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120421021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120421022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1084ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1084ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1084ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0
			local var_92_10 = 1

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				local var_92_11 = "play"
				local var_92_12 = "effect"

				arg_89_1:AudioAction(var_92_11, var_92_12, "se_story_16", "se_story_16_door06", "")
			end

			local var_92_13 = 0
			local var_92_14 = 1.075

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(120421021)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 43
				local var_92_18 = utf8.len(var_92_16)
				local var_92_19 = var_92_17 <= 0 and var_92_14 or var_92_14 * (var_92_18 / var_92_17)

				if var_92_19 > 0 and var_92_14 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_13 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_13
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_20 = math.max(var_92_14, arg_89_1.talkMaxDuration)

			if var_92_13 <= arg_89_1.time_ and arg_89_1.time_ < var_92_13 + var_92_20 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_13) / var_92_20

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_13 + var_92_20 and arg_89_1.time_ < var_92_13 + var_92_20 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play120421022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120421022
		arg_93_1.duration_ = 5.73

		local var_93_0 = {
			zh = 3.766,
			ja = 5.733
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
				arg_93_0:Play120421023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1084ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -0.97, -6)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_10 = arg_93_1.actors_["1084ui_story"]
			local var_96_11 = 0

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_12 = 0.2

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_12 and not isNil(var_96_10) then
				local var_96_13 = (arg_93_1.time_ - var_96_11) / var_96_12

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_10) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_11 + var_96_12 and arg_93_1.time_ < var_96_11 + var_96_12 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_96_15 = 0
			local var_96_16 = 0.35

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(120421022)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 14
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421022", "story_v_out_120421.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_120421", "120421022", "story_v_out_120421.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_120421", "120421022", "story_v_out_120421.awb")

						arg_93_1:RecordAudio("120421022", var_96_24)
						arg_93_1:RecordAudio("120421022", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120421", "120421022", "story_v_out_120421.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120421", "120421022", "story_v_out_120421.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play120421023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120421023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play120421024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1084ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = 0
			local var_100_10 = 1.525

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:GetWordFromCfg(120421023)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 61
				local var_100_14 = utf8.len(var_100_12)
				local var_100_15 = var_100_13 <= 0 and var_100_10 or var_100_10 * (var_100_14 / var_100_13)

				if var_100_15 > 0 and var_100_10 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_16 and arg_97_1.time_ < var_100_9 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play120421024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120421024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120421025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.325

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

				local var_104_2 = arg_101_1:GetWordFromCfg(120421024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 13
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
	Play120421025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120421025
		arg_105_1.duration_ = 2

		local var_105_0 = {
			zh = 1.3,
			ja = 2
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
				arg_105_0:Play120421026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.125

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[381].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(120421025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421025", "story_v_out_120421.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421025", "story_v_out_120421.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_120421", "120421025", "story_v_out_120421.awb")

						arg_105_1:RecordAudio("120421025", var_108_9)
						arg_105_1:RecordAudio("120421025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120421", "120421025", "story_v_out_120421.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120421", "120421025", "story_v_out_120421.awb")
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
	Play120421026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120421026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play120421027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(120421026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 40
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play120421027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120421027
		arg_113_1.duration_ = 3.03

		local var_113_0 = {
			zh = 2.866,
			ja = 3.033
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
				arg_113_0:Play120421028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1084ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1084ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(-0.7, -0.97, -6)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1084ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = "1075ui_story"

			if arg_113_1.actors_[var_116_9] == nil then
				local var_116_10 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_116_10) then
					local var_116_11 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_113_1.stage_.transform)

					var_116_11.name = var_116_9
					var_116_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_9] = var_116_11

					local var_116_12 = var_116_11:GetComponentInChildren(typeof(CharacterEffect))

					var_116_12.enabled = true

					local var_116_13 = GameObjectTools.GetOrAddComponent(var_116_11, typeof(DynamicBoneHelper))

					if var_116_13 then
						var_116_13:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_12.transform, false)

					arg_113_1.var_[var_116_9 .. "Animator"] = var_116_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_9 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_9 .. "LipSync"] = var_116_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_14 = arg_113_1.actors_["1075ui_story"].transform
			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.var_.moveOldPos1075ui_story = var_116_14.localPosition
			end

			local var_116_16 = 0.001

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_16 then
				local var_116_17 = (arg_113_1.time_ - var_116_15) / var_116_16
				local var_116_18 = Vector3.New(0.7, -1.055, -6.16)

				var_116_14.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1075ui_story, var_116_18, var_116_17)

				local var_116_19 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_19.x, var_116_19.y, var_116_19.z)

				local var_116_20 = var_116_14.localEulerAngles

				var_116_20.z = 0
				var_116_20.x = 0
				var_116_14.localEulerAngles = var_116_20
			end

			if arg_113_1.time_ >= var_116_15 + var_116_16 and arg_113_1.time_ < var_116_15 + var_116_16 + arg_116_0 then
				var_116_14.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_116_21 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_21.x, var_116_21.y, var_116_21.z)

				local var_116_22 = var_116_14.localEulerAngles

				var_116_22.z = 0
				var_116_22.x = 0
				var_116_14.localEulerAngles = var_116_22
			end

			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_116_24 = 0

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_116_25 = arg_113_1.actors_["1075ui_story"]
			local var_116_26 = 0

			if var_116_26 < arg_113_1.time_ and arg_113_1.time_ <= var_116_26 + arg_116_0 and not isNil(var_116_25) and arg_113_1.var_.characterEffect1075ui_story == nil then
				arg_113_1.var_.characterEffect1075ui_story = var_116_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_27 = 0.2

			if var_116_26 <= arg_113_1.time_ and arg_113_1.time_ < var_116_26 + var_116_27 and not isNil(var_116_25) then
				local var_116_28 = (arg_113_1.time_ - var_116_26) / var_116_27

				if arg_113_1.var_.characterEffect1075ui_story and not isNil(var_116_25) then
					arg_113_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_26 + var_116_27 and arg_113_1.time_ < var_116_26 + var_116_27 + arg_116_0 and not isNil(var_116_25) and arg_113_1.var_.characterEffect1075ui_story then
				arg_113_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_116_29 = arg_113_1.actors_["1084ui_story"]
			local var_116_30 = 0

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 and not isNil(var_116_29) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_31 = 0.2

			if var_116_30 <= arg_113_1.time_ and arg_113_1.time_ < var_116_30 + var_116_31 and not isNil(var_116_29) then
				local var_116_32 = (arg_113_1.time_ - var_116_30) / var_116_31

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_29) then
					local var_116_33 = Mathf.Lerp(0, 0.5, var_116_32)

					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_33
				end
			end

			if arg_113_1.time_ >= var_116_30 + var_116_31 and arg_113_1.time_ < var_116_30 + var_116_31 + arg_116_0 and not isNil(var_116_29) and arg_113_1.var_.characterEffect1084ui_story then
				local var_116_34 = 0.5

				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_34
			end

			local var_116_35 = 0
			local var_116_36 = 0.4

			if var_116_35 < arg_113_1.time_ and arg_113_1.time_ <= var_116_35 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_37 = arg_113_1:FormatText(StoryNameCfg[381].name)

				arg_113_1.leftNameTxt_.text = var_116_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_38 = arg_113_1:GetWordFromCfg(120421027)
				local var_116_39 = arg_113_1:FormatText(var_116_38.content)

				arg_113_1.text_.text = var_116_39

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_40 = 16
				local var_116_41 = utf8.len(var_116_39)
				local var_116_42 = var_116_40 <= 0 and var_116_36 or var_116_36 * (var_116_41 / var_116_40)

				if var_116_42 > 0 and var_116_36 < var_116_42 then
					arg_113_1.talkMaxDuration = var_116_42

					if var_116_42 + var_116_35 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_42 + var_116_35
					end
				end

				arg_113_1.text_.text = var_116_39
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421027", "story_v_out_120421.awb") ~= 0 then
					local var_116_43 = manager.audio:GetVoiceLength("story_v_out_120421", "120421027", "story_v_out_120421.awb") / 1000

					if var_116_43 + var_116_35 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_43 + var_116_35
					end

					if var_116_38.prefab_name ~= "" and arg_113_1.actors_[var_116_38.prefab_name] ~= nil then
						local var_116_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_38.prefab_name].transform, "story_v_out_120421", "120421027", "story_v_out_120421.awb")

						arg_113_1:RecordAudio("120421027", var_116_44)
						arg_113_1:RecordAudio("120421027", var_116_44)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120421", "120421027", "story_v_out_120421.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120421", "120421027", "story_v_out_120421.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_45 = math.max(var_116_36, arg_113_1.talkMaxDuration)

			if var_116_35 <= arg_113_1.time_ and arg_113_1.time_ < var_116_35 + var_116_45 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_35) / var_116_45

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_35 + var_116_45 and arg_113_1.time_ < var_116_35 + var_116_45 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play120421028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120421028
		arg_117_1.duration_ = 11.93

		local var_117_0 = {
			zh = 7.4,
			ja = 11.933
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
				arg_117_0:Play120421029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_120_1 = arg_117_1.actors_["1075ui_story"]
			local var_120_2 = 0

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1075ui_story == nil then
				arg_117_1.var_.characterEffect1075ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.2

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_3 and not isNil(var_120_1) then
				local var_120_4 = (arg_117_1.time_ - var_120_2) / var_120_3

				if arg_117_1.var_.characterEffect1075ui_story and not isNil(var_120_1) then
					local var_120_5 = Mathf.Lerp(0, 0.5, var_120_4)

					arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1075ui_story.fillRatio = var_120_5
				end
			end

			if arg_117_1.time_ >= var_120_2 + var_120_3 and arg_117_1.time_ < var_120_2 + var_120_3 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1075ui_story then
				local var_120_6 = 0.5

				arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1075ui_story.fillRatio = var_120_6
			end

			local var_120_7 = arg_117_1.actors_["1084ui_story"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_9 = 0.2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_7) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_120_11 = 0
			local var_120_12 = 0.9

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_13 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(120421028)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421028", "story_v_out_120421.awb") ~= 0 then
					local var_120_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421028", "story_v_out_120421.awb") / 1000

					if var_120_19 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_11
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_120421", "120421028", "story_v_out_120421.awb")

						arg_117_1:RecordAudio("120421028", var_120_20)
						arg_117_1:RecordAudio("120421028", var_120_20)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120421", "120421028", "story_v_out_120421.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120421", "120421028", "story_v_out_120421.awb")
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
	Play120421029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120421029
		arg_121_1.duration_ = 9.27

		local var_121_0 = {
			zh = 4.3,
			ja = 9.266
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
				arg_121_0:Play120421030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1075ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1075ui_story == nil then
				arg_121_1.var_.characterEffect1075ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1075ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1075ui_story then
				arg_121_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1084ui_story"]
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.2

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 and not isNil(var_124_4) then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6

				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_4) then
					local var_124_8 = Mathf.Lerp(0, 0.5, var_124_7)

					arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1084ui_story.fillRatio = var_124_8
				end
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1084ui_story then
				local var_124_9 = 0.5

				arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1084ui_story.fillRatio = var_124_9
			end

			local var_124_10 = 0
			local var_124_11 = 0.45

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_12 = arg_121_1:FormatText(StoryNameCfg[381].name)

				arg_121_1.leftNameTxt_.text = var_124_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(120421029)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 18
				local var_124_16 = utf8.len(var_124_14)
				local var_124_17 = var_124_15 <= 0 and var_124_11 or var_124_11 * (var_124_16 / var_124_15)

				if var_124_17 > 0 and var_124_11 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_10
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421029", "story_v_out_120421.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421029", "story_v_out_120421.awb") / 1000

					if var_124_18 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_10
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_120421", "120421029", "story_v_out_120421.awb")

						arg_121_1:RecordAudio("120421029", var_124_19)
						arg_121_1:RecordAudio("120421029", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120421", "120421029", "story_v_out_120421.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120421", "120421029", "story_v_out_120421.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_11, arg_121_1.talkMaxDuration)

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_10) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_10 + var_124_20 and arg_121_1.time_ < var_124_10 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120421030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120421030
		arg_125_1.duration_ = 7.27

		local var_125_0 = {
			zh = 4.2,
			ja = 7.266
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
				arg_125_0:Play120421031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1075ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1075ui_story == nil then
				arg_125_1.var_.characterEffect1075ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1075ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1075ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1075ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1075ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["1084ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.2

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_128_12 = 0
			local var_128_13 = 0.45

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(120421030)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 18
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421030", "story_v_out_120421.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421030", "story_v_out_120421.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_120421", "120421030", "story_v_out_120421.awb")

						arg_125_1:RecordAudio("120421030", var_128_21)
						arg_125_1:RecordAudio("120421030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120421", "120421030", "story_v_out_120421.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120421", "120421030", "story_v_out_120421.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120421031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120421031
		arg_129_1.duration_ = 6.8

		local var_129_0 = {
			zh = 5.933,
			ja = 6.8
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
				arg_129_0:Play120421032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_132_2 = 0
			local var_132_3 = 0.6

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_4 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_5 = arg_129_1:GetWordFromCfg(120421031)
				local var_132_6 = arg_129_1:FormatText(var_132_5.content)

				arg_129_1.text_.text = var_132_6

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 24
				local var_132_8 = utf8.len(var_132_6)
				local var_132_9 = var_132_7 <= 0 and var_132_3 or var_132_3 * (var_132_8 / var_132_7)

				if var_132_9 > 0 and var_132_3 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_6
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421031", "story_v_out_120421.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421031", "story_v_out_120421.awb") / 1000

					if var_132_10 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_2
					end

					if var_132_5.prefab_name ~= "" and arg_129_1.actors_[var_132_5.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_5.prefab_name].transform, "story_v_out_120421", "120421031", "story_v_out_120421.awb")

						arg_129_1:RecordAudio("120421031", var_132_11)
						arg_129_1:RecordAudio("120421031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120421", "120421031", "story_v_out_120421.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120421", "120421031", "story_v_out_120421.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_12 and arg_129_1.time_ < var_132_2 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120421032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120421032
		arg_133_1.duration_ = 8.77

		local var_133_0 = {
			zh = 5.333,
			ja = 8.766
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
				arg_133_0:Play120421033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_136_1 = 0
			local var_136_2 = 0.7

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_3 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(120421032)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 28
				local var_136_7 = utf8.len(var_136_5)
				local var_136_8 = var_136_6 <= 0 and var_136_2 or var_136_2 * (var_136_7 / var_136_6)

				if var_136_8 > 0 and var_136_2 < var_136_8 then
					arg_133_1.talkMaxDuration = var_136_8

					if var_136_8 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421032", "story_v_out_120421.awb") ~= 0 then
					local var_136_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421032", "story_v_out_120421.awb") / 1000

					if var_136_9 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_1
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_120421", "120421032", "story_v_out_120421.awb")

						arg_133_1:RecordAudio("120421032", var_136_10)
						arg_133_1:RecordAudio("120421032", var_136_10)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120421", "120421032", "story_v_out_120421.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120421", "120421032", "story_v_out_120421.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_11 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_11 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_11

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_11 and arg_133_1.time_ < var_136_1 + var_136_11 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play120421033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120421033
		arg_137_1.duration_ = 9.7

		local var_137_0 = {
			zh = 6.633,
			ja = 9.7
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
				arg_137_0:Play120421034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1084ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1084ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1084ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_140_7 = arg_137_1.actors_["1075ui_story"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1075ui_story == nil then
				arg_137_1.var_.characterEffect1075ui_story = var_140_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_9 = 0.2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.characterEffect1075ui_story and not isNil(var_140_7) then
					arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1075ui_story then
				arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_140_11 = 0

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_140_12 = 0
			local var_140_13 = 0.7

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[381].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(120421033)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 28
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421033", "story_v_out_120421.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421033", "story_v_out_120421.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_120421", "120421033", "story_v_out_120421.awb")

						arg_137_1:RecordAudio("120421033", var_140_21)
						arg_137_1:RecordAudio("120421033", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120421", "120421033", "story_v_out_120421.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120421", "120421033", "story_v_out_120421.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play120421034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120421034
		arg_141_1.duration_ = 8.13

		local var_141_0 = {
			zh = 8.133,
			ja = 7.5
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
				arg_141_0:Play120421035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_144_1 = arg_141_1.actors_["1075ui_story"]
			local var_144_2 = 0

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1075ui_story == nil then
				arg_141_1.var_.characterEffect1075ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.2

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_3 and not isNil(var_144_1) then
				local var_144_4 = (arg_141_1.time_ - var_144_2) / var_144_3

				if arg_141_1.var_.characterEffect1075ui_story and not isNil(var_144_1) then
					local var_144_5 = Mathf.Lerp(0, 0.5, var_144_4)

					arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_5
				end
			end

			if arg_141_1.time_ >= var_144_2 + var_144_3 and arg_141_1.time_ < var_144_2 + var_144_3 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1075ui_story then
				local var_144_6 = 0.5

				arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_6
			end

			local var_144_7 = arg_141_1.actors_["1084ui_story"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_9 = 0.2

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_7) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_11 = 0
			local var_144_12 = 0.8

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_13 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_14 = arg_141_1:GetWordFromCfg(120421034)
				local var_144_15 = arg_141_1:FormatText(var_144_14.content)

				arg_141_1.text_.text = var_144_15

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 32
				local var_144_17 = utf8.len(var_144_15)
				local var_144_18 = var_144_16 <= 0 and var_144_12 or var_144_12 * (var_144_17 / var_144_16)

				if var_144_18 > 0 and var_144_12 < var_144_18 then
					arg_141_1.talkMaxDuration = var_144_18

					if var_144_18 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_15
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421034", "story_v_out_120421.awb") ~= 0 then
					local var_144_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421034", "story_v_out_120421.awb") / 1000

					if var_144_19 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_11
					end

					if var_144_14.prefab_name ~= "" and arg_141_1.actors_[var_144_14.prefab_name] ~= nil then
						local var_144_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_14.prefab_name].transform, "story_v_out_120421", "120421034", "story_v_out_120421.awb")

						arg_141_1:RecordAudio("120421034", var_144_20)
						arg_141_1:RecordAudio("120421034", var_144_20)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120421", "120421034", "story_v_out_120421.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120421", "120421034", "story_v_out_120421.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_21 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_21 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_21

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_21 and arg_141_1.time_ < var_144_11 + var_144_21 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120421035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120421035
		arg_145_1.duration_ = 15.8

		local var_145_0 = {
			zh = 9.5,
			ja = 15.8
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
				arg_145_0:Play120421036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.95

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(120421035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421035", "story_v_out_120421.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421035", "story_v_out_120421.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_120421", "120421035", "story_v_out_120421.awb")

						arg_145_1:RecordAudio("120421035", var_148_9)
						arg_145_1:RecordAudio("120421035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120421", "120421035", "story_v_out_120421.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120421", "120421035", "story_v_out_120421.awb")
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
	Play120421036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120421036
		arg_149_1.duration_ = 10.3

		local var_149_0 = {
			zh = 6.133,
			ja = 10.3
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
				arg_149_0:Play120421037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_152_1 = arg_149_1.actors_["1075ui_story"]
			local var_152_2 = 0

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1075ui_story == nil then
				arg_149_1.var_.characterEffect1075ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_3 and not isNil(var_152_1) then
				local var_152_4 = (arg_149_1.time_ - var_152_2) / var_152_3

				if arg_149_1.var_.characterEffect1075ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_2 + var_152_3 and arg_149_1.time_ < var_152_2 + var_152_3 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1075ui_story then
				arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_152_5 = arg_149_1.actors_["1084ui_story"]
			local var_152_6 = 0

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_7 = 0.2

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_7 and not isNil(var_152_5) then
				local var_152_8 = (arg_149_1.time_ - var_152_6) / var_152_7

				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_5) then
					local var_152_9 = Mathf.Lerp(0, 0.5, var_152_8)

					arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1084ui_story.fillRatio = var_152_9
				end
			end

			if arg_149_1.time_ >= var_152_6 + var_152_7 and arg_149_1.time_ < var_152_6 + var_152_7 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1084ui_story then
				local var_152_10 = 0.5

				arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1084ui_story.fillRatio = var_152_10
			end

			local var_152_11 = 0
			local var_152_12 = 0.825

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_13 = arg_149_1:FormatText(StoryNameCfg[381].name)

				arg_149_1.leftNameTxt_.text = var_152_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:GetWordFromCfg(120421036)
				local var_152_15 = arg_149_1:FormatText(var_152_14.content)

				arg_149_1.text_.text = var_152_15

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 33
				local var_152_17 = utf8.len(var_152_15)
				local var_152_18 = var_152_16 <= 0 and var_152_12 or var_152_12 * (var_152_17 / var_152_16)

				if var_152_18 > 0 and var_152_12 < var_152_18 then
					arg_149_1.talkMaxDuration = var_152_18

					if var_152_18 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_15
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421036", "story_v_out_120421.awb") ~= 0 then
					local var_152_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421036", "story_v_out_120421.awb") / 1000

					if var_152_19 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_11
					end

					if var_152_14.prefab_name ~= "" and arg_149_1.actors_[var_152_14.prefab_name] ~= nil then
						local var_152_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_14.prefab_name].transform, "story_v_out_120421", "120421036", "story_v_out_120421.awb")

						arg_149_1:RecordAudio("120421036", var_152_20)
						arg_149_1:RecordAudio("120421036", var_152_20)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120421", "120421036", "story_v_out_120421.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120421", "120421036", "story_v_out_120421.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_21 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_21 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_21

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_21 and arg_149_1.time_ < var_152_11 + var_152_21 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120421037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120421037
		arg_153_1.duration_ = 4.77

		local var_153_0 = {
			zh = 3.233,
			ja = 4.766
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
				arg_153_0:Play120421038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.325

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[381].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(120421037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421037", "story_v_out_120421.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421037", "story_v_out_120421.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_120421", "120421037", "story_v_out_120421.awb")

						arg_153_1:RecordAudio("120421037", var_156_9)
						arg_153_1:RecordAudio("120421037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120421", "120421037", "story_v_out_120421.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120421", "120421037", "story_v_out_120421.awb")
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
	Play120421038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120421038
		arg_157_1.duration_ = 12.7

		local var_157_0 = {
			zh = 7.066,
			ja = 12.7
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
				arg_157_0:Play120421039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1075ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1075ui_story == nil then
				arg_157_1.var_.characterEffect1075ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1075ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1075ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1075ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1075ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["1084ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1084ui_story == nil then
				arg_157_1.var_.characterEffect1084ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1084ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1084ui_story then
				arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_160_10 = 0
			local var_160_11 = 0.875

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_12 = arg_157_1:FormatText(StoryNameCfg[6].name)

				arg_157_1.leftNameTxt_.text = var_160_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_13 = arg_157_1:GetWordFromCfg(120421038)
				local var_160_14 = arg_157_1:FormatText(var_160_13.content)

				arg_157_1.text_.text = var_160_14

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_15 = 35
				local var_160_16 = utf8.len(var_160_14)
				local var_160_17 = var_160_15 <= 0 and var_160_11 or var_160_11 * (var_160_16 / var_160_15)

				if var_160_17 > 0 and var_160_11 < var_160_17 then
					arg_157_1.talkMaxDuration = var_160_17

					if var_160_17 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_14
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421038", "story_v_out_120421.awb") ~= 0 then
					local var_160_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421038", "story_v_out_120421.awb") / 1000

					if var_160_18 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_10
					end

					if var_160_13.prefab_name ~= "" and arg_157_1.actors_[var_160_13.prefab_name] ~= nil then
						local var_160_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_13.prefab_name].transform, "story_v_out_120421", "120421038", "story_v_out_120421.awb")

						arg_157_1:RecordAudio("120421038", var_160_19)
						arg_157_1:RecordAudio("120421038", var_160_19)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120421", "120421038", "story_v_out_120421.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120421", "120421038", "story_v_out_120421.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_20 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_20 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_20

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_20 and arg_157_1.time_ < var_160_10 + var_160_20 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120421039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120421039
		arg_161_1.duration_ = 5.47

		local var_161_0 = {
			zh = 5.466,
			ja = 3.433
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
				arg_161_0:Play120421040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_164_1 = arg_161_1.actors_["1075ui_story"]
			local var_164_2 = 0

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1075ui_story == nil then
				arg_161_1.var_.characterEffect1075ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_3 and not isNil(var_164_1) then
				local var_164_4 = (arg_161_1.time_ - var_164_2) / var_164_3

				if arg_161_1.var_.characterEffect1075ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_2 + var_164_3 and arg_161_1.time_ < var_164_2 + var_164_3 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1075ui_story then
				arg_161_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_164_5 = arg_161_1.actors_["1084ui_story"]
			local var_164_6 = 0

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.2

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_7 and not isNil(var_164_5) then
				local var_164_8 = (arg_161_1.time_ - var_164_6) / var_164_7

				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_5) then
					local var_164_9 = Mathf.Lerp(0, 0.5, var_164_8)

					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_9
				end
			end

			if arg_161_1.time_ >= var_164_6 + var_164_7 and arg_161_1.time_ < var_164_6 + var_164_7 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1084ui_story then
				local var_164_10 = 0.5

				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_10
			end

			local var_164_11 = 0

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_164_12 = 0
			local var_164_13 = 0.75

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_14 = arg_161_1:FormatText(StoryNameCfg[381].name)

				arg_161_1.leftNameTxt_.text = var_164_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_15 = arg_161_1:GetWordFromCfg(120421039)
				local var_164_16 = arg_161_1:FormatText(var_164_15.content)

				arg_161_1.text_.text = var_164_16

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_17 = 30
				local var_164_18 = utf8.len(var_164_16)
				local var_164_19 = var_164_17 <= 0 and var_164_13 or var_164_13 * (var_164_18 / var_164_17)

				if var_164_19 > 0 and var_164_13 < var_164_19 then
					arg_161_1.talkMaxDuration = var_164_19

					if var_164_19 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_12
					end
				end

				arg_161_1.text_.text = var_164_16
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421039", "story_v_out_120421.awb") ~= 0 then
					local var_164_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421039", "story_v_out_120421.awb") / 1000

					if var_164_20 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_20 + var_164_12
					end

					if var_164_15.prefab_name ~= "" and arg_161_1.actors_[var_164_15.prefab_name] ~= nil then
						local var_164_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_15.prefab_name].transform, "story_v_out_120421", "120421039", "story_v_out_120421.awb")

						arg_161_1:RecordAudio("120421039", var_164_21)
						arg_161_1:RecordAudio("120421039", var_164_21)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120421", "120421039", "story_v_out_120421.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120421", "120421039", "story_v_out_120421.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_22 = math.max(var_164_13, arg_161_1.talkMaxDuration)

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_22 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_12) / var_164_22

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_12 + var_164_22 and arg_161_1.time_ < var_164_12 + var_164_22 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120421040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120421040
		arg_165_1.duration_ = 7

		local var_165_0 = {
			zh = 4.2,
			ja = 7
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
				arg_165_0:Play120421041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1075ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1075ui_story == nil then
				arg_165_1.var_.characterEffect1075ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1075ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1075ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1075ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1075ui_story.fillRatio = var_168_5
			end

			local var_168_6 = arg_165_1.actors_["1084ui_story"]
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.2

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 and not isNil(var_168_6) then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8

				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_168_12 = 0
			local var_168_13 = 0.55

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_14 = arg_165_1:FormatText(StoryNameCfg[6].name)

				arg_165_1.leftNameTxt_.text = var_168_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_15 = arg_165_1:GetWordFromCfg(120421040)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.text_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 22
				local var_168_18 = utf8.len(var_168_16)
				local var_168_19 = var_168_17 <= 0 and var_168_13 or var_168_13 * (var_168_18 / var_168_17)

				if var_168_19 > 0 and var_168_13 < var_168_19 then
					arg_165_1.talkMaxDuration = var_168_19

					if var_168_19 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_16
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421040", "story_v_out_120421.awb") ~= 0 then
					local var_168_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421040", "story_v_out_120421.awb") / 1000

					if var_168_20 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_12
					end

					if var_168_15.prefab_name ~= "" and arg_165_1.actors_[var_168_15.prefab_name] ~= nil then
						local var_168_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_15.prefab_name].transform, "story_v_out_120421", "120421040", "story_v_out_120421.awb")

						arg_165_1:RecordAudio("120421040", var_168_21)
						arg_165_1:RecordAudio("120421040", var_168_21)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_120421", "120421040", "story_v_out_120421.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_120421", "120421040", "story_v_out_120421.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_22 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_22

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_22 and arg_165_1.time_ < var_168_12 + var_168_22 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120421041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120421041
		arg_169_1.duration_ = 7.4

		local var_169_0 = {
			zh = 7,
			ja = 7.4
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
				arg_169_0:Play120421042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_172_2 = 0
			local var_172_3 = 0.95

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_4 = arg_169_1:FormatText(StoryNameCfg[6].name)

				arg_169_1.leftNameTxt_.text = var_172_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(120421041)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 38
				local var_172_8 = utf8.len(var_172_6)
				local var_172_9 = var_172_7 <= 0 and var_172_3 or var_172_3 * (var_172_8 / var_172_7)

				if var_172_9 > 0 and var_172_3 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421041", "story_v_out_120421.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421041", "story_v_out_120421.awb") / 1000

					if var_172_10 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_2
					end

					if var_172_5.prefab_name ~= "" and arg_169_1.actors_[var_172_5.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_5.prefab_name].transform, "story_v_out_120421", "120421041", "story_v_out_120421.awb")

						arg_169_1:RecordAudio("120421041", var_172_11)
						arg_169_1:RecordAudio("120421041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120421", "120421041", "story_v_out_120421.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120421", "120421041", "story_v_out_120421.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_12 and arg_169_1.time_ < var_172_2 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play120421042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120421042
		arg_173_1.duration_ = 15.2

		local var_173_0 = {
			zh = 6.5,
			ja = 15.2
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
				arg_173_0:Play120421043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1075ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1075ui_story == nil then
				arg_173_1.var_.characterEffect1075ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1075ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1075ui_story then
				arg_173_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["1084ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1084ui_story == nil then
				arg_173_1.var_.characterEffect1084ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.2

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect1084ui_story and not isNil(var_176_4) then
					local var_176_8 = Mathf.Lerp(0, 0.5, var_176_7)

					arg_173_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1084ui_story.fillRatio = var_176_8
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1084ui_story then
				local var_176_9 = 0.5

				arg_173_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1084ui_story.fillRatio = var_176_9
			end

			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_176_11 = 0

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_176_12 = 0
			local var_176_13 = 0.75

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[381].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(120421042)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 30
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421042", "story_v_out_120421.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421042", "story_v_out_120421.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_120421", "120421042", "story_v_out_120421.awb")

						arg_173_1:RecordAudio("120421042", var_176_21)
						arg_173_1:RecordAudio("120421042", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120421", "120421042", "story_v_out_120421.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120421", "120421042", "story_v_out_120421.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play120421043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120421043
		arg_177_1.duration_ = 8.87

		local var_177_0 = {
			zh = 8.766,
			ja = 8.866
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
				arg_177_0:Play120421044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.8

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[381].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(120421043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421043", "story_v_out_120421.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421043", "story_v_out_120421.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_120421", "120421043", "story_v_out_120421.awb")

						arg_177_1:RecordAudio("120421043", var_180_9)
						arg_177_1:RecordAudio("120421043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120421", "120421043", "story_v_out_120421.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120421", "120421043", "story_v_out_120421.awb")
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
	Play120421044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120421044
		arg_181_1.duration_ = 12.6

		local var_181_0 = {
			zh = 11.466,
			ja = 12.6
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
				arg_181_0:Play120421045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1075ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1075ui_story == nil then
				arg_181_1.var_.characterEffect1075ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1075ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1075ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1075ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1075ui_story.fillRatio = var_184_5
			end

			local var_184_6 = arg_181_1.actors_["1084ui_story"]
			local var_184_7 = 0

			if var_184_7 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_8 = 0.2

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_8 and not isNil(var_184_6) then
				local var_184_9 = (arg_181_1.time_ - var_184_7) / var_184_8

				if arg_181_1.var_.characterEffect1084ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_7 + var_184_8 and arg_181_1.time_ < var_184_7 + var_184_8 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			local var_184_11 = 0

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_184_12 = 0
			local var_184_13 = 0.75

			if var_184_12 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_14 = arg_181_1:FormatText(StoryNameCfg[6].name)

				arg_181_1.leftNameTxt_.text = var_184_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_15 = arg_181_1:GetWordFromCfg(120421044)
				local var_184_16 = arg_181_1:FormatText(var_184_15.content)

				arg_181_1.text_.text = var_184_16

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_17 = 30
				local var_184_18 = utf8.len(var_184_16)
				local var_184_19 = var_184_17 <= 0 and var_184_13 or var_184_13 * (var_184_18 / var_184_17)

				if var_184_19 > 0 and var_184_13 < var_184_19 then
					arg_181_1.talkMaxDuration = var_184_19

					if var_184_19 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_12
					end
				end

				arg_181_1.text_.text = var_184_16
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421044", "story_v_out_120421.awb") ~= 0 then
					local var_184_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421044", "story_v_out_120421.awb") / 1000

					if var_184_20 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_20 + var_184_12
					end

					if var_184_15.prefab_name ~= "" and arg_181_1.actors_[var_184_15.prefab_name] ~= nil then
						local var_184_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_15.prefab_name].transform, "story_v_out_120421", "120421044", "story_v_out_120421.awb")

						arg_181_1:RecordAudio("120421044", var_184_21)
						arg_181_1:RecordAudio("120421044", var_184_21)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120421", "120421044", "story_v_out_120421.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120421", "120421044", "story_v_out_120421.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = math.max(var_184_13, arg_181_1.talkMaxDuration)

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_22 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_12) / var_184_22

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_12 + var_184_22 and arg_181_1.time_ < var_184_12 + var_184_22 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play120421045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120421045
		arg_185_1.duration_ = 6.93

		local var_185_0 = {
			zh = 6.633,
			ja = 6.933
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play120421046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1075ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1075ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1075ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_5
			end

			local var_188_6 = arg_185_1.actors_["1084ui_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.2

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_188_12 = 0
			local var_188_13 = 0.725

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(120421045)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 29
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421045", "story_v_out_120421.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421045", "story_v_out_120421.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_out_120421", "120421045", "story_v_out_120421.awb")

						arg_185_1:RecordAudio("120421045", var_188_21)
						arg_185_1:RecordAudio("120421045", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120421", "120421045", "story_v_out_120421.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120421", "120421045", "story_v_out_120421.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120421046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120421046
		arg_189_1.duration_ = 3.13

		local var_189_0 = {
			zh = 2,
			ja = 3.133
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
				arg_189_0:Play120421047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1075ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1075ui_story == nil then
				arg_189_1.var_.characterEffect1075ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1075ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1075ui_story then
				arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1084ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1084ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0
			local var_192_11 = 0.25

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[381].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(120421046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 10
				local var_192_16 = utf8.len(var_192_14)
				local var_192_17 = var_192_15 <= 0 and var_192_11 or var_192_11 * (var_192_16 / var_192_15)

				if var_192_17 > 0 and var_192_11 < var_192_17 then
					arg_189_1.talkMaxDuration = var_192_17

					if var_192_17 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421046", "story_v_out_120421.awb") ~= 0 then
					local var_192_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421046", "story_v_out_120421.awb") / 1000

					if var_192_18 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_10
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_120421", "120421046", "story_v_out_120421.awb")

						arg_189_1:RecordAudio("120421046", var_192_19)
						arg_189_1:RecordAudio("120421046", var_192_19)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120421", "120421046", "story_v_out_120421.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120421", "120421046", "story_v_out_120421.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_20 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_20 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_20

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_20 and arg_189_1.time_ < var_192_10 + var_192_20 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120421047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120421047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play120421048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1075ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1075ui_story == nil then
				arg_193_1.var_.characterEffect1075ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1075ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1075ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_5
			end

			local var_196_6 = arg_193_1.actors_["1084ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.2

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_196_11 = 0

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_196_12 = 0
			local var_196_13 = 0.825

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_14 = arg_193_1:GetWordFromCfg(120421047)
				local var_196_15 = arg_193_1:FormatText(var_196_14.content)

				arg_193_1.text_.text = var_196_15

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 33
				local var_196_17 = utf8.len(var_196_15)
				local var_196_18 = var_196_16 <= 0 and var_196_13 or var_196_13 * (var_196_17 / var_196_16)

				if var_196_18 > 0 and var_196_13 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18

					if var_196_18 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_15
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_19 and arg_193_1.time_ < var_196_12 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play120421048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120421048
		arg_197_1.duration_ = 6.93

		local var_197_0 = {
			zh = 5.966,
			ja = 6.933
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
				arg_197_0:Play120421049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_200_1 = 0
			local var_200_2 = 0.45

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_3 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(120421048)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 18
				local var_200_7 = utf8.len(var_200_5)
				local var_200_8 = var_200_6 <= 0 and var_200_2 or var_200_2 * (var_200_7 / var_200_6)

				if var_200_8 > 0 and var_200_2 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421048", "story_v_out_120421.awb") ~= 0 then
					local var_200_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421048", "story_v_out_120421.awb") / 1000

					if var_200_9 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_1
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_120421", "120421048", "story_v_out_120421.awb")

						arg_197_1:RecordAudio("120421048", var_200_10)
						arg_197_1:RecordAudio("120421048", var_200_10)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120421", "120421048", "story_v_out_120421.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120421", "120421048", "story_v_out_120421.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_11 and arg_197_1.time_ < var_200_1 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120421049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120421049
		arg_201_1.duration_ = 14.57

		local var_201_0 = {
			zh = 12.3,
			ja = 14.566
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
				arg_201_0:Play120421050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.35

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(120421049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 54
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421049", "story_v_out_120421.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421049", "story_v_out_120421.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_120421", "120421049", "story_v_out_120421.awb")

						arg_201_1:RecordAudio("120421049", var_204_9)
						arg_201_1:RecordAudio("120421049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120421", "120421049", "story_v_out_120421.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120421", "120421049", "story_v_out_120421.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play120421050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120421050
		arg_205_1.duration_ = 7.8

		local var_205_0 = {
			zh = 6.566,
			ja = 7.8
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
				arg_205_0:Play120421051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.6

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[6].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(120421050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421050", "story_v_out_120421.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421050", "story_v_out_120421.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_120421", "120421050", "story_v_out_120421.awb")

						arg_205_1:RecordAudio("120421050", var_208_9)
						arg_205_1:RecordAudio("120421050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_120421", "120421050", "story_v_out_120421.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_120421", "120421050", "story_v_out_120421.awb")
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
	Play120421051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120421051
		arg_209_1.duration_ = 4.8

		local var_209_0 = {
			zh = 3.7,
			ja = 4.8
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play120421052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1075ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1075ui_story == nil then
				arg_209_1.var_.characterEffect1075ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1075ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1075ui_story then
				arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1084ui_story"]
			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1084ui_story == nil then
				arg_209_1.var_.characterEffect1084ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.2

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 and not isNil(var_212_4) then
				local var_212_7 = (arg_209_1.time_ - var_212_5) / var_212_6

				if arg_209_1.var_.characterEffect1084ui_story and not isNil(var_212_4) then
					local var_212_8 = Mathf.Lerp(0, 0.5, var_212_7)

					arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1084ui_story.fillRatio = var_212_8
				end
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1084ui_story then
				local var_212_9 = 0.5

				arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1084ui_story.fillRatio = var_212_9
			end

			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_212_11 = 0

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_212_12 = 0
			local var_212_13 = 0.45

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_14 = arg_209_1:FormatText(StoryNameCfg[381].name)

				arg_209_1.leftNameTxt_.text = var_212_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_15 = arg_209_1:GetWordFromCfg(120421051)
				local var_212_16 = arg_209_1:FormatText(var_212_15.content)

				arg_209_1.text_.text = var_212_16

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_17 = 18
				local var_212_18 = utf8.len(var_212_16)
				local var_212_19 = var_212_17 <= 0 and var_212_13 or var_212_13 * (var_212_18 / var_212_17)

				if var_212_19 > 0 and var_212_13 < var_212_19 then
					arg_209_1.talkMaxDuration = var_212_19

					if var_212_19 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_12
					end
				end

				arg_209_1.text_.text = var_212_16
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421051", "story_v_out_120421.awb") ~= 0 then
					local var_212_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421051", "story_v_out_120421.awb") / 1000

					if var_212_20 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_12
					end

					if var_212_15.prefab_name ~= "" and arg_209_1.actors_[var_212_15.prefab_name] ~= nil then
						local var_212_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_15.prefab_name].transform, "story_v_out_120421", "120421051", "story_v_out_120421.awb")

						arg_209_1:RecordAudio("120421051", var_212_21)
						arg_209_1:RecordAudio("120421051", var_212_21)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120421", "120421051", "story_v_out_120421.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120421", "120421051", "story_v_out_120421.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_22 = math.max(var_212_13, arg_209_1.talkMaxDuration)

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_12) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_12 + var_212_22 and arg_209_1.time_ < var_212_12 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120421052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120421052
		arg_213_1.duration_ = 5.37

		local var_213_0 = {
			zh = 5.366,
			ja = 4.866
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
				arg_213_0:Play120421053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1075ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1075ui_story == nil then
				arg_213_1.var_.characterEffect1075ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1075ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1075ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1075ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1075ui_story.fillRatio = var_216_5
			end

			local var_216_6 = arg_213_1.actors_["1084ui_story"]
			local var_216_7 = 0

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1084ui_story == nil then
				arg_213_1.var_.characterEffect1084ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_8 = 0.2

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_8 and not isNil(var_216_6) then
				local var_216_9 = (arg_213_1.time_ - var_216_7) / var_216_8

				if arg_213_1.var_.characterEffect1084ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_7 + var_216_8 and arg_213_1.time_ < var_216_7 + var_216_8 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1084ui_story then
				arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_216_11 = 0
			local var_216_12 = 0.7

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_13 = arg_213_1:FormatText(StoryNameCfg[6].name)

				arg_213_1.leftNameTxt_.text = var_216_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_14 = arg_213_1:GetWordFromCfg(120421052)
				local var_216_15 = arg_213_1:FormatText(var_216_14.content)

				arg_213_1.text_.text = var_216_15

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_16 = 28
				local var_216_17 = utf8.len(var_216_15)
				local var_216_18 = var_216_16 <= 0 and var_216_12 or var_216_12 * (var_216_17 / var_216_16)

				if var_216_18 > 0 and var_216_12 < var_216_18 then
					arg_213_1.talkMaxDuration = var_216_18

					if var_216_18 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_11
					end
				end

				arg_213_1.text_.text = var_216_15
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421052", "story_v_out_120421.awb") ~= 0 then
					local var_216_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421052", "story_v_out_120421.awb") / 1000

					if var_216_19 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_11
					end

					if var_216_14.prefab_name ~= "" and arg_213_1.actors_[var_216_14.prefab_name] ~= nil then
						local var_216_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_14.prefab_name].transform, "story_v_out_120421", "120421052", "story_v_out_120421.awb")

						arg_213_1:RecordAudio("120421052", var_216_20)
						arg_213_1:RecordAudio("120421052", var_216_20)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_120421", "120421052", "story_v_out_120421.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_120421", "120421052", "story_v_out_120421.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_21 = math.max(var_216_12, arg_213_1.talkMaxDuration)

			if var_216_11 <= arg_213_1.time_ and arg_213_1.time_ < var_216_11 + var_216_21 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_11) / var_216_21

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_11 + var_216_21 and arg_213_1.time_ < var_216_11 + var_216_21 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120421053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120421053
		arg_217_1.duration_ = 13.03

		local var_217_0 = {
			zh = 10.1,
			ja = 13.033
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play120421054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_220_1 = 0
			local var_220_2 = 1.175

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_3 = arg_217_1:FormatText(StoryNameCfg[6].name)

				arg_217_1.leftNameTxt_.text = var_220_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(120421053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 47
				local var_220_7 = utf8.len(var_220_5)
				local var_220_8 = var_220_6 <= 0 and var_220_2 or var_220_2 * (var_220_7 / var_220_6)

				if var_220_8 > 0 and var_220_2 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421053", "story_v_out_120421.awb") ~= 0 then
					local var_220_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421053", "story_v_out_120421.awb") / 1000

					if var_220_9 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_1
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_120421", "120421053", "story_v_out_120421.awb")

						arg_217_1:RecordAudio("120421053", var_220_10)
						arg_217_1:RecordAudio("120421053", var_220_10)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_120421", "120421053", "story_v_out_120421.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_120421", "120421053", "story_v_out_120421.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_11 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_11 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_11

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_11 and arg_217_1.time_ < var_220_1 + var_220_11 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play120421054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120421054
		arg_221_1.duration_ = 12.83

		local var_221_0 = {
			zh = 7.8,
			ja = 12.833
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
				arg_221_0:Play120421055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.025

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[6].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(120421054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421054", "story_v_out_120421.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421054", "story_v_out_120421.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_120421", "120421054", "story_v_out_120421.awb")

						arg_221_1:RecordAudio("120421054", var_224_9)
						arg_221_1:RecordAudio("120421054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_120421", "120421054", "story_v_out_120421.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_120421", "120421054", "story_v_out_120421.awb")
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
	Play120421055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120421055
		arg_225_1.duration_ = 4.9

		local var_225_0 = {
			zh = 2.6,
			ja = 4.9
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
				arg_225_0:Play120421056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1075ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1075ui_story == nil then
				arg_225_1.var_.characterEffect1075ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1075ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1075ui_story then
				arg_225_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_228_4 = arg_225_1.actors_["1084ui_story"]
			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.2

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_6 and not isNil(var_228_4) then
				local var_228_7 = (arg_225_1.time_ - var_228_5) / var_228_6

				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_4) then
					local var_228_8 = Mathf.Lerp(0, 0.5, var_228_7)

					arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_8
				end
			end

			if arg_225_1.time_ >= var_228_5 + var_228_6 and arg_225_1.time_ < var_228_5 + var_228_6 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1084ui_story then
				local var_228_9 = 0.5

				arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_9
			end

			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_228_11 = 0
			local var_228_12 = 0.325

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_13 = arg_225_1:FormatText(StoryNameCfg[381].name)

				arg_225_1.leftNameTxt_.text = var_228_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_14 = arg_225_1:GetWordFromCfg(120421055)
				local var_228_15 = arg_225_1:FormatText(var_228_14.content)

				arg_225_1.text_.text = var_228_15

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_16 = 13
				local var_228_17 = utf8.len(var_228_15)
				local var_228_18 = var_228_16 <= 0 and var_228_12 or var_228_12 * (var_228_17 / var_228_16)

				if var_228_18 > 0 and var_228_12 < var_228_18 then
					arg_225_1.talkMaxDuration = var_228_18

					if var_228_18 + var_228_11 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_11
					end
				end

				arg_225_1.text_.text = var_228_15
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421055", "story_v_out_120421.awb") ~= 0 then
					local var_228_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421055", "story_v_out_120421.awb") / 1000

					if var_228_19 + var_228_11 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_19 + var_228_11
					end

					if var_228_14.prefab_name ~= "" and arg_225_1.actors_[var_228_14.prefab_name] ~= nil then
						local var_228_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_14.prefab_name].transform, "story_v_out_120421", "120421055", "story_v_out_120421.awb")

						arg_225_1:RecordAudio("120421055", var_228_20)
						arg_225_1:RecordAudio("120421055", var_228_20)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_120421", "120421055", "story_v_out_120421.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_120421", "120421055", "story_v_out_120421.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_21 = math.max(var_228_12, arg_225_1.talkMaxDuration)

			if var_228_11 <= arg_225_1.time_ and arg_225_1.time_ < var_228_11 + var_228_21 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_11) / var_228_21

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_11 + var_228_21 and arg_225_1.time_ < var_228_11 + var_228_21 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play120421056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120421056
		arg_229_1.duration_ = 8.7

		local var_229_0 = {
			zh = 5.7,
			ja = 8.7
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play120421057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1075ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1075ui_story == nil then
				arg_229_1.var_.characterEffect1075ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1075ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1075ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1075ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1075ui_story.fillRatio = var_232_5
			end

			local var_232_6 = arg_229_1.actors_["1084ui_story"]
			local var_232_7 = 0

			if var_232_7 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1084ui_story == nil then
				arg_229_1.var_.characterEffect1084ui_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_8 = 0.2

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_8 and not isNil(var_232_6) then
				local var_232_9 = (arg_229_1.time_ - var_232_7) / var_232_8

				if arg_229_1.var_.characterEffect1084ui_story and not isNil(var_232_6) then
					arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_7 + var_232_8 and arg_229_1.time_ < var_232_7 + var_232_8 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1084ui_story then
				arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_232_11 = 0

			if var_232_11 < arg_229_1.time_ and arg_229_1.time_ <= var_232_11 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_232_12 = 0
			local var_232_13 = 0.75

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_14 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(120421056)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 30
				local var_232_18 = utf8.len(var_232_16)
				local var_232_19 = var_232_17 <= 0 and var_232_13 or var_232_13 * (var_232_18 / var_232_17)

				if var_232_19 > 0 and var_232_13 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421056", "story_v_out_120421.awb") ~= 0 then
					local var_232_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421056", "story_v_out_120421.awb") / 1000

					if var_232_20 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_20 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_out_120421", "120421056", "story_v_out_120421.awb")

						arg_229_1:RecordAudio("120421056", var_232_21)
						arg_229_1:RecordAudio("120421056", var_232_21)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120421", "120421056", "story_v_out_120421.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120421", "120421056", "story_v_out_120421.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_22 and arg_229_1.time_ < var_232_12 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play120421057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120421057
		arg_233_1.duration_ = 9

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play120421058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "ST29"

			if arg_233_1.bgs_[var_236_0] == nil then
				local var_236_1 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_0)
				var_236_1.name = var_236_0
				var_236_1.transform.parent = arg_233_1.stage_.transform
				var_236_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_0] = var_236_1
			end

			local var_236_2 = 2

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				local var_236_3 = manager.ui.mainCamera.transform.localPosition
				local var_236_4 = Vector3.New(0, 0, 10) + Vector3.New(var_236_3.x, var_236_3.y, 0)
				local var_236_5 = arg_233_1.bgs_.ST29

				var_236_5.transform.localPosition = var_236_4
				var_236_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_6 = var_236_5:GetComponent("SpriteRenderer")

				if var_236_6 and var_236_6.sprite then
					local var_236_7 = (var_236_5.transform.localPosition - var_236_3).z
					local var_236_8 = manager.ui.mainCameraCom_
					local var_236_9 = 2 * var_236_7 * Mathf.Tan(var_236_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_10 = var_236_9 * var_236_8.aspect
					local var_236_11 = var_236_6.sprite.bounds.size.x
					local var_236_12 = var_236_6.sprite.bounds.size.y
					local var_236_13 = var_236_10 / var_236_11
					local var_236_14 = var_236_9 / var_236_12
					local var_236_15 = var_236_14 < var_236_13 and var_236_13 or var_236_14

					var_236_5.transform.localScale = Vector3.New(var_236_15, var_236_15, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST29" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_17 = 2

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17
				local var_236_19 = Color.New(0, 0, 0)

				var_236_19.a = Mathf.Lerp(0, 1, var_236_18)
				arg_233_1.mask_.color = var_236_19
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				local var_236_20 = Color.New(0, 0, 0)

				var_236_20.a = 1
				arg_233_1.mask_.color = var_236_20
			end

			local var_236_21 = 2

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_22 = 2

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_22 then
				local var_236_23 = (arg_233_1.time_ - var_236_21) / var_236_22
				local var_236_24 = Color.New(0, 0, 0)

				var_236_24.a = Mathf.Lerp(1, 0, var_236_23)
				arg_233_1.mask_.color = var_236_24
			end

			if arg_233_1.time_ >= var_236_21 + var_236_22 and arg_233_1.time_ < var_236_21 + var_236_22 + arg_236_0 then
				local var_236_25 = Color.New(0, 0, 0)
				local var_236_26 = 0

				arg_233_1.mask_.enabled = false
				var_236_25.a = var_236_26
				arg_233_1.mask_.color = var_236_25
			end

			local var_236_27 = arg_233_1.actors_["1084ui_story"].transform
			local var_236_28 = 1.966

			if var_236_28 < arg_233_1.time_ and arg_233_1.time_ <= var_236_28 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_27.localPosition
			end

			local var_236_29 = 0.001

			if var_236_28 <= arg_233_1.time_ and arg_233_1.time_ < var_236_28 + var_236_29 then
				local var_236_30 = (arg_233_1.time_ - var_236_28) / var_236_29
				local var_236_31 = Vector3.New(0, 100, 0)

				var_236_27.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, var_236_31, var_236_30)

				local var_236_32 = manager.ui.mainCamera.transform.position - var_236_27.position

				var_236_27.forward = Vector3.New(var_236_32.x, var_236_32.y, var_236_32.z)

				local var_236_33 = var_236_27.localEulerAngles

				var_236_33.z = 0
				var_236_33.x = 0
				var_236_27.localEulerAngles = var_236_33
			end

			if arg_233_1.time_ >= var_236_28 + var_236_29 and arg_233_1.time_ < var_236_28 + var_236_29 + arg_236_0 then
				var_236_27.localPosition = Vector3.New(0, 100, 0)

				local var_236_34 = manager.ui.mainCamera.transform.position - var_236_27.position

				var_236_27.forward = Vector3.New(var_236_34.x, var_236_34.y, var_236_34.z)

				local var_236_35 = var_236_27.localEulerAngles

				var_236_35.z = 0
				var_236_35.x = 0
				var_236_27.localEulerAngles = var_236_35
			end

			local var_236_36 = arg_233_1.actors_["1075ui_story"].transform
			local var_236_37 = 1.966

			if var_236_37 < arg_233_1.time_ and arg_233_1.time_ <= var_236_37 + arg_236_0 then
				arg_233_1.var_.moveOldPos1075ui_story = var_236_36.localPosition
			end

			local var_236_38 = 0.001

			if var_236_37 <= arg_233_1.time_ and arg_233_1.time_ < var_236_37 + var_236_38 then
				local var_236_39 = (arg_233_1.time_ - var_236_37) / var_236_38
				local var_236_40 = Vector3.New(0, 100, 0)

				var_236_36.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1075ui_story, var_236_40, var_236_39)

				local var_236_41 = manager.ui.mainCamera.transform.position - var_236_36.position

				var_236_36.forward = Vector3.New(var_236_41.x, var_236_41.y, var_236_41.z)

				local var_236_42 = var_236_36.localEulerAngles

				var_236_42.z = 0
				var_236_42.x = 0
				var_236_36.localEulerAngles = var_236_42
			end

			if arg_233_1.time_ >= var_236_37 + var_236_38 and arg_233_1.time_ < var_236_37 + var_236_38 + arg_236_0 then
				var_236_36.localPosition = Vector3.New(0, 100, 0)

				local var_236_43 = manager.ui.mainCamera.transform.position - var_236_36.position

				var_236_36.forward = Vector3.New(var_236_43.x, var_236_43.y, var_236_43.z)

				local var_236_44 = var_236_36.localEulerAngles

				var_236_44.z = 0
				var_236_44.x = 0
				var_236_36.localEulerAngles = var_236_44
			end

			local var_236_45 = 0.8
			local var_236_46 = 1

			if var_236_45 < arg_233_1.time_ and arg_233_1.time_ <= var_236_45 + arg_236_0 then
				local var_236_47 = "play"
				local var_236_48 = "music"

				arg_233_1:AudioAction(var_236_47, var_236_48, "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_236_49 = ""
				local var_236_50 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

				if var_236_50 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_50 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_50

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_50
						arg_233_1.bgmTxt2_.text = var_236_50
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_236_51 = 0
			local var_236_52 = 0.2

			if var_236_51 < arg_233_1.time_ and arg_233_1.time_ <= var_236_51 + arg_236_0 then
				local var_236_53 = "play"
				local var_236_54 = "music"

				arg_233_1:AudioAction(var_236_53, var_236_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_236_55 = ""
				local var_236_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_236_56 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_56 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_56

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_56
						arg_233_1.bgmTxt2_.text = var_236_56
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_57 = 4
			local var_236_58 = 0.675

			if var_236_57 < arg_233_1.time_ and arg_233_1.time_ <= var_236_57 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_59 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_59:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_233_1.dialogCg_.alpha = arg_239_0
				end))
				var_236_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_60 = arg_233_1:GetWordFromCfg(120421057)
				local var_236_61 = arg_233_1:FormatText(var_236_60.content)

				arg_233_1.text_.text = var_236_61

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_62 = 27
				local var_236_63 = utf8.len(var_236_61)
				local var_236_64 = var_236_62 <= 0 and var_236_58 or var_236_58 * (var_236_63 / var_236_62)

				if var_236_64 > 0 and var_236_58 < var_236_64 then
					arg_233_1.talkMaxDuration = var_236_64
					var_236_57 = var_236_57 + 0.3

					if var_236_64 + var_236_57 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_64 + var_236_57
					end
				end

				arg_233_1.text_.text = var_236_61
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_65 = var_236_57 + 0.3
			local var_236_66 = math.max(var_236_58, arg_233_1.talkMaxDuration)

			if var_236_65 <= arg_233_1.time_ and arg_233_1.time_ < var_236_65 + var_236_66 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_65) / var_236_66

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_65 + var_236_66 and arg_233_1.time_ < var_236_65 + var_236_66 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play120421058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120421058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play120421059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.575

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(120421058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 23
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play120421059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120421059
		arg_245_1.duration_ = 7.27

		local var_245_0 = {
			zh = 4.766,
			ja = 7.266
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
				arg_245_0:Play120421060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1075ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1075ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1075ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1084ui_story"].transform
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.var_.moveOldPos1084ui_story = var_248_9.localPosition
			end

			local var_248_11 = 0.001

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11
				local var_248_13 = Vector3.New(0.7, -0.97, -6)

				var_248_9.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1084ui_story, var_248_13, var_248_12)

				local var_248_14 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_14.x, var_248_14.y, var_248_14.z)

				local var_248_15 = var_248_9.localEulerAngles

				var_248_15.z = 0
				var_248_15.x = 0
				var_248_9.localEulerAngles = var_248_15
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 then
				var_248_9.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_248_16 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_16.x, var_248_16.y, var_248_16.z)

				local var_248_17 = var_248_9.localEulerAngles

				var_248_17.z = 0
				var_248_17.x = 0
				var_248_9.localEulerAngles = var_248_17
			end

			local var_248_18 = 0

			if var_248_18 < arg_245_1.time_ and arg_245_1.time_ <= var_248_18 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_248_19 = 0

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_248_20 = arg_245_1.actors_["1084ui_story"]
			local var_248_21 = 0

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 and not isNil(var_248_20) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_22 = 0.2

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_22 and not isNil(var_248_20) then
				local var_248_23 = (arg_245_1.time_ - var_248_21) / var_248_22

				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_20) then
					local var_248_24 = Mathf.Lerp(0, 0.5, var_248_23)

					arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_24
				end
			end

			if arg_245_1.time_ >= var_248_21 + var_248_22 and arg_245_1.time_ < var_248_21 + var_248_22 + arg_248_0 and not isNil(var_248_20) and arg_245_1.var_.characterEffect1084ui_story then
				local var_248_25 = 0.5

				arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_25
			end

			local var_248_26 = arg_245_1.actors_["1075ui_story"]
			local var_248_27 = 0

			if var_248_27 < arg_245_1.time_ and arg_245_1.time_ <= var_248_27 + arg_248_0 and not isNil(var_248_26) and arg_245_1.var_.characterEffect1075ui_story == nil then
				arg_245_1.var_.characterEffect1075ui_story = var_248_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_28 = 0.2

			if var_248_27 <= arg_245_1.time_ and arg_245_1.time_ < var_248_27 + var_248_28 and not isNil(var_248_26) then
				local var_248_29 = (arg_245_1.time_ - var_248_27) / var_248_28

				if arg_245_1.var_.characterEffect1075ui_story and not isNil(var_248_26) then
					arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_27 + var_248_28 and arg_245_1.time_ < var_248_27 + var_248_28 + arg_248_0 and not isNil(var_248_26) and arg_245_1.var_.characterEffect1075ui_story then
				arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_248_30 = 0
			local var_248_31 = 0.65

			if var_248_30 < arg_245_1.time_ and arg_245_1.time_ <= var_248_30 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_32 = arg_245_1:FormatText(StoryNameCfg[381].name)

				arg_245_1.leftNameTxt_.text = var_248_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_33 = arg_245_1:GetWordFromCfg(120421059)
				local var_248_34 = arg_245_1:FormatText(var_248_33.content)

				arg_245_1.text_.text = var_248_34

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_35 = 26
				local var_248_36 = utf8.len(var_248_34)
				local var_248_37 = var_248_35 <= 0 and var_248_31 or var_248_31 * (var_248_36 / var_248_35)

				if var_248_37 > 0 and var_248_31 < var_248_37 then
					arg_245_1.talkMaxDuration = var_248_37

					if var_248_37 + var_248_30 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_37 + var_248_30
					end
				end

				arg_245_1.text_.text = var_248_34
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421059", "story_v_out_120421.awb") ~= 0 then
					local var_248_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421059", "story_v_out_120421.awb") / 1000

					if var_248_38 + var_248_30 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_38 + var_248_30
					end

					if var_248_33.prefab_name ~= "" and arg_245_1.actors_[var_248_33.prefab_name] ~= nil then
						local var_248_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_33.prefab_name].transform, "story_v_out_120421", "120421059", "story_v_out_120421.awb")

						arg_245_1:RecordAudio("120421059", var_248_39)
						arg_245_1:RecordAudio("120421059", var_248_39)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120421", "120421059", "story_v_out_120421.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120421", "120421059", "story_v_out_120421.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_40 = math.max(var_248_31, arg_245_1.talkMaxDuration)

			if var_248_30 <= arg_245_1.time_ and arg_245_1.time_ < var_248_30 + var_248_40 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_30) / var_248_40

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_30 + var_248_40 and arg_245_1.time_ < var_248_30 + var_248_40 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play120421060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120421060
		arg_249_1.duration_ = 9.97

		local var_249_0 = {
			zh = 5.7,
			ja = 9.966
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play120421061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_252_1 = arg_249_1.actors_["1084ui_story"]
			local var_252_2 = 0

			if var_252_2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.2

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_3 and not isNil(var_252_1) then
				local var_252_4 = (arg_249_1.time_ - var_252_2) / var_252_3

				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_2 + var_252_3 and arg_249_1.time_ < var_252_2 + var_252_3 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_5 = arg_249_1.actors_["1075ui_story"]
			local var_252_6 = 0

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1075ui_story == nil then
				arg_249_1.var_.characterEffect1075ui_story = var_252_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.2

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_7 and not isNil(var_252_5) then
				local var_252_8 = (arg_249_1.time_ - var_252_6) / var_252_7

				if arg_249_1.var_.characterEffect1075ui_story and not isNil(var_252_5) then
					local var_252_9 = Mathf.Lerp(0, 0.5, var_252_8)

					arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1075ui_story.fillRatio = var_252_9
				end
			end

			if arg_249_1.time_ >= var_252_6 + var_252_7 and arg_249_1.time_ < var_252_6 + var_252_7 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1075ui_story then
				local var_252_10 = 0.5

				arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1075ui_story.fillRatio = var_252_10
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_252_12 = 0
			local var_252_13 = 0.8

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[6].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(120421060)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 32
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421060", "story_v_out_120421.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421060", "story_v_out_120421.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_out_120421", "120421060", "story_v_out_120421.awb")

						arg_249_1:RecordAudio("120421060", var_252_21)
						arg_249_1:RecordAudio("120421060", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120421", "120421060", "story_v_out_120421.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120421", "120421060", "story_v_out_120421.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120421061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120421061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play120421062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1084ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1084ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.5

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

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(120421061)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 20
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
	Play120421062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120421062
		arg_257_1.duration_ = 15.9

		local var_257_0 = {
			zh = 12.066,
			ja = 15.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play120421063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1075ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1075ui_story == nil then
				arg_257_1.var_.characterEffect1075ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1075ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1075ui_story then
				arg_257_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_260_4 = 0
			local var_260_5 = 1.175

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_6 = arg_257_1:FormatText(StoryNameCfg[381].name)

				arg_257_1.leftNameTxt_.text = var_260_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(120421062)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 47
				local var_260_10 = utf8.len(var_260_8)
				local var_260_11 = var_260_9 <= 0 and var_260_5 or var_260_5 * (var_260_10 / var_260_9)

				if var_260_11 > 0 and var_260_5 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421062", "story_v_out_120421.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421062", "story_v_out_120421.awb") / 1000

					if var_260_12 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_4
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_120421", "120421062", "story_v_out_120421.awb")

						arg_257_1:RecordAudio("120421062", var_260_13)
						arg_257_1:RecordAudio("120421062", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120421", "120421062", "story_v_out_120421.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120421", "120421062", "story_v_out_120421.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_14 and arg_257_1.time_ < var_260_4 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120421063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120421063
		arg_261_1.duration_ = 10.97

		local var_261_0 = {
			zh = 7.1,
			ja = 10.966
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
				arg_261_0:Play120421064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.85

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[381].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(120421063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 34
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421063", "story_v_out_120421.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421063", "story_v_out_120421.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_120421", "120421063", "story_v_out_120421.awb")

						arg_261_1:RecordAudio("120421063", var_264_9)
						arg_261_1:RecordAudio("120421063", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120421", "120421063", "story_v_out_120421.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120421", "120421063", "story_v_out_120421.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120421064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120421064
		arg_265_1.duration_ = 8.83

		local var_265_0 = {
			zh = 5.6,
			ja = 8.833
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
				arg_265_0:Play120421065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1084ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["1075ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1075ui_story == nil then
				arg_265_1.var_.characterEffect1075ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.2

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect1075ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1075ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1075ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1075ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_268_11 = 0

			if var_268_11 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_268_12 = 0
			local var_268_13 = 0.625

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_14 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_15 = arg_265_1:GetWordFromCfg(120421064)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 25
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421064", "story_v_out_120421.awb") ~= 0 then
					local var_268_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421064", "story_v_out_120421.awb") / 1000

					if var_268_20 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_12
					end

					if var_268_15.prefab_name ~= "" and arg_265_1.actors_[var_268_15.prefab_name] ~= nil then
						local var_268_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_15.prefab_name].transform, "story_v_out_120421", "120421064", "story_v_out_120421.awb")

						arg_265_1:RecordAudio("120421064", var_268_21)
						arg_265_1:RecordAudio("120421064", var_268_21)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120421", "120421064", "story_v_out_120421.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120421", "120421064", "story_v_out_120421.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_22 and arg_265_1.time_ < var_268_12 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120421065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120421065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120421066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1084ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

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

			local var_272_6 = arg_269_1.actors_["1075ui_story"]
			local var_272_7 = 0

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1075ui_story == nil then
				arg_269_1.var_.characterEffect1075ui_story = var_272_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_8 = 0.2

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_8 and not isNil(var_272_6) then
				local var_272_9 = (arg_269_1.time_ - var_272_7) / var_272_8

				if arg_269_1.var_.characterEffect1075ui_story and not isNil(var_272_6) then
					local var_272_10 = Mathf.Lerp(0, 0.5, var_272_9)

					arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1075ui_story.fillRatio = var_272_10
				end
			end

			if arg_269_1.time_ >= var_272_7 + var_272_8 and arg_269_1.time_ < var_272_7 + var_272_8 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1075ui_story then
				local var_272_11 = 0.5

				arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1075ui_story.fillRatio = var_272_11
			end

			local var_272_12 = 0
			local var_272_13 = 0.225

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_14 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_15 = arg_269_1:GetWordFromCfg(120421065)
				local var_272_16 = arg_269_1:FormatText(var_272_15.content)

				arg_269_1.text_.text = var_272_16

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_17 = 9
				local var_272_18 = utf8.len(var_272_16)
				local var_272_19 = var_272_17 <= 0 and var_272_13 or var_272_13 * (var_272_18 / var_272_17)

				if var_272_19 > 0 and var_272_13 < var_272_19 then
					arg_269_1.talkMaxDuration = var_272_19

					if var_272_19 + var_272_12 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_19 + var_272_12
					end
				end

				arg_269_1.text_.text = var_272_16
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_20 = math.max(var_272_13, arg_269_1.talkMaxDuration)

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_20 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_12) / var_272_20

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_12 + var_272_20 and arg_269_1.time_ < var_272_12 + var_272_20 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play120421066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120421066
		arg_273_1.duration_ = 7.43

		local var_273_0 = {
			zh = 6.966,
			ja = 7.433
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play120421067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1084ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1084ui_story == nil then
				arg_273_1.var_.characterEffect1084ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1084ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1084ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1084ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1084ui_story.fillRatio = var_276_5
			end

			local var_276_6 = arg_273_1.actors_["1075ui_story"]
			local var_276_7 = 0

			if var_276_7 < arg_273_1.time_ and arg_273_1.time_ <= var_276_7 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect1075ui_story == nil then
				arg_273_1.var_.characterEffect1075ui_story = var_276_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_8 = 0.2

			if var_276_7 <= arg_273_1.time_ and arg_273_1.time_ < var_276_7 + var_276_8 and not isNil(var_276_6) then
				local var_276_9 = (arg_273_1.time_ - var_276_7) / var_276_8

				if arg_273_1.var_.characterEffect1075ui_story and not isNil(var_276_6) then
					arg_273_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_7 + var_276_8 and arg_273_1.time_ < var_276_7 + var_276_8 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect1075ui_story then
				arg_273_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_276_11 = 0

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_276_12 = 0
			local var_276_13 = 0.75

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_14 = arg_273_1:FormatText(StoryNameCfg[381].name)

				arg_273_1.leftNameTxt_.text = var_276_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_15 = arg_273_1:GetWordFromCfg(120421066)
				local var_276_16 = arg_273_1:FormatText(var_276_15.content)

				arg_273_1.text_.text = var_276_16

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_17 = 30
				local var_276_18 = utf8.len(var_276_16)
				local var_276_19 = var_276_17 <= 0 and var_276_13 or var_276_13 * (var_276_18 / var_276_17)

				if var_276_19 > 0 and var_276_13 < var_276_19 then
					arg_273_1.talkMaxDuration = var_276_19

					if var_276_19 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_12
					end
				end

				arg_273_1.text_.text = var_276_16
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421066", "story_v_out_120421.awb") ~= 0 then
					local var_276_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421066", "story_v_out_120421.awb") / 1000

					if var_276_20 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_20 + var_276_12
					end

					if var_276_15.prefab_name ~= "" and arg_273_1.actors_[var_276_15.prefab_name] ~= nil then
						local var_276_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_15.prefab_name].transform, "story_v_out_120421", "120421066", "story_v_out_120421.awb")

						arg_273_1:RecordAudio("120421066", var_276_21)
						arg_273_1:RecordAudio("120421066", var_276_21)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120421", "120421066", "story_v_out_120421.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120421", "120421066", "story_v_out_120421.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_22 = math.max(var_276_13, arg_273_1.talkMaxDuration)

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_12) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_12 + var_276_22 and arg_273_1.time_ < var_276_12 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play120421067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120421067
		arg_277_1.duration_ = 11.8

		local var_277_0 = {
			zh = 9.9,
			ja = 11.8
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
				arg_277_0:Play120421068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 1.225

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[381].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(120421067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 49
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421067", "story_v_out_120421.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421067", "story_v_out_120421.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_120421", "120421067", "story_v_out_120421.awb")

						arg_277_1:RecordAudio("120421067", var_280_9)
						arg_277_1:RecordAudio("120421067", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_120421", "120421067", "story_v_out_120421.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_120421", "120421067", "story_v_out_120421.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play120421068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120421068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play120421069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1075ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1075ui_story == nil then
				arg_281_1.var_.characterEffect1075ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1075ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1075ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1075ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1075ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 0.475

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

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_9 = arg_281_1:GetWordFromCfg(120421068)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 19
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
	Play120421069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120421069
		arg_285_1.duration_ = 4.3

		local var_285_0 = {
			zh = 2.466,
			ja = 4.3
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
				arg_285_0:Play120421070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1075ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1075ui_story == nil then
				arg_285_1.var_.characterEffect1075ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1075ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1075ui_story then
				arg_285_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_288_4 = 0
			local var_288_5 = 0.25

			if var_288_4 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_6 = arg_285_1:FormatText(StoryNameCfg[381].name)

				arg_285_1.leftNameTxt_.text = var_288_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(120421069)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 10
				local var_288_10 = utf8.len(var_288_8)
				local var_288_11 = var_288_9 <= 0 and var_288_5 or var_288_5 * (var_288_10 / var_288_9)

				if var_288_11 > 0 and var_288_5 < var_288_11 then
					arg_285_1.talkMaxDuration = var_288_11

					if var_288_11 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421069", "story_v_out_120421.awb") ~= 0 then
					local var_288_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421069", "story_v_out_120421.awb") / 1000

					if var_288_12 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_4
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_120421", "120421069", "story_v_out_120421.awb")

						arg_285_1:RecordAudio("120421069", var_288_13)
						arg_285_1:RecordAudio("120421069", var_288_13)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_120421", "120421069", "story_v_out_120421.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_120421", "120421069", "story_v_out_120421.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_14 and arg_285_1.time_ < var_288_4 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play120421070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120421070
		arg_289_1.duration_ = 9

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play120421071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = "ST31"

			if arg_289_1.bgs_[var_292_0] == nil then
				local var_292_1 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_0)
				var_292_1.name = var_292_0
				var_292_1.transform.parent = arg_289_1.stage_.transform
				var_292_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_0] = var_292_1
			end

			local var_292_2 = 2

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				local var_292_3 = manager.ui.mainCamera.transform.localPosition
				local var_292_4 = Vector3.New(0, 0, 10) + Vector3.New(var_292_3.x, var_292_3.y, 0)
				local var_292_5 = arg_289_1.bgs_.ST31

				var_292_5.transform.localPosition = var_292_4
				var_292_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_6 = var_292_5:GetComponent("SpriteRenderer")

				if var_292_6 and var_292_6.sprite then
					local var_292_7 = (var_292_5.transform.localPosition - var_292_3).z
					local var_292_8 = manager.ui.mainCameraCom_
					local var_292_9 = 2 * var_292_7 * Mathf.Tan(var_292_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_10 = var_292_9 * var_292_8.aspect
					local var_292_11 = var_292_6.sprite.bounds.size.x
					local var_292_12 = var_292_6.sprite.bounds.size.y
					local var_292_13 = var_292_10 / var_292_11
					local var_292_14 = var_292_9 / var_292_12
					local var_292_15 = var_292_14 < var_292_13 and var_292_13 or var_292_14

					var_292_5.transform.localScale = Vector3.New(var_292_15, var_292_15, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "ST31" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_17 = 2

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17
				local var_292_19 = Color.New(0, 0, 0)

				var_292_19.a = Mathf.Lerp(0, 1, var_292_18)
				arg_289_1.mask_.color = var_292_19
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 then
				local var_292_20 = Color.New(0, 0, 0)

				var_292_20.a = 1
				arg_289_1.mask_.color = var_292_20
			end

			local var_292_21 = 2

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_22 = 2

			if var_292_21 <= arg_289_1.time_ and arg_289_1.time_ < var_292_21 + var_292_22 then
				local var_292_23 = (arg_289_1.time_ - var_292_21) / var_292_22
				local var_292_24 = Color.New(0, 0, 0)

				var_292_24.a = Mathf.Lerp(1, 0, var_292_23)
				arg_289_1.mask_.color = var_292_24
			end

			if arg_289_1.time_ >= var_292_21 + var_292_22 and arg_289_1.time_ < var_292_21 + var_292_22 + arg_292_0 then
				local var_292_25 = Color.New(0, 0, 0)
				local var_292_26 = 0

				arg_289_1.mask_.enabled = false
				var_292_25.a = var_292_26
				arg_289_1.mask_.color = var_292_25
			end

			local var_292_27 = 2
			local var_292_28 = 1

			if var_292_27 < arg_289_1.time_ and arg_289_1.time_ <= var_292_27 + arg_292_0 then
				local var_292_29 = "play"
				local var_292_30 = "effect"

				arg_289_1:AudioAction(var_292_29, var_292_30, "se_story_1", "se_story_1_count", "")
			end

			local var_292_31 = arg_289_1.actors_["1075ui_story"].transform
			local var_292_32 = 1.966

			if var_292_32 < arg_289_1.time_ and arg_289_1.time_ <= var_292_32 + arg_292_0 then
				arg_289_1.var_.moveOldPos1075ui_story = var_292_31.localPosition
			end

			local var_292_33 = 0.001

			if var_292_32 <= arg_289_1.time_ and arg_289_1.time_ < var_292_32 + var_292_33 then
				local var_292_34 = (arg_289_1.time_ - var_292_32) / var_292_33
				local var_292_35 = Vector3.New(0, 100, 0)

				var_292_31.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1075ui_story, var_292_35, var_292_34)

				local var_292_36 = manager.ui.mainCamera.transform.position - var_292_31.position

				var_292_31.forward = Vector3.New(var_292_36.x, var_292_36.y, var_292_36.z)

				local var_292_37 = var_292_31.localEulerAngles

				var_292_37.z = 0
				var_292_37.x = 0
				var_292_31.localEulerAngles = var_292_37
			end

			if arg_289_1.time_ >= var_292_32 + var_292_33 and arg_289_1.time_ < var_292_32 + var_292_33 + arg_292_0 then
				var_292_31.localPosition = Vector3.New(0, 100, 0)

				local var_292_38 = manager.ui.mainCamera.transform.position - var_292_31.position

				var_292_31.forward = Vector3.New(var_292_38.x, var_292_38.y, var_292_38.z)

				local var_292_39 = var_292_31.localEulerAngles

				var_292_39.z = 0
				var_292_39.x = 0
				var_292_31.localEulerAngles = var_292_39
			end

			local var_292_40 = arg_289_1.actors_["1084ui_story"].transform
			local var_292_41 = 1.966

			if var_292_41 < arg_289_1.time_ and arg_289_1.time_ <= var_292_41 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = var_292_40.localPosition
			end

			local var_292_42 = 0.001

			if var_292_41 <= arg_289_1.time_ and arg_289_1.time_ < var_292_41 + var_292_42 then
				local var_292_43 = (arg_289_1.time_ - var_292_41) / var_292_42
				local var_292_44 = Vector3.New(0, 100, 0)

				var_292_40.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, var_292_44, var_292_43)

				local var_292_45 = manager.ui.mainCamera.transform.position - var_292_40.position

				var_292_40.forward = Vector3.New(var_292_45.x, var_292_45.y, var_292_45.z)

				local var_292_46 = var_292_40.localEulerAngles

				var_292_46.z = 0
				var_292_46.x = 0
				var_292_40.localEulerAngles = var_292_46
			end

			if arg_289_1.time_ >= var_292_41 + var_292_42 and arg_289_1.time_ < var_292_41 + var_292_42 + arg_292_0 then
				var_292_40.localPosition = Vector3.New(0, 100, 0)

				local var_292_47 = manager.ui.mainCamera.transform.position - var_292_40.position

				var_292_40.forward = Vector3.New(var_292_47.x, var_292_47.y, var_292_47.z)

				local var_292_48 = var_292_40.localEulerAngles

				var_292_48.z = 0
				var_292_48.x = 0
				var_292_40.localEulerAngles = var_292_48
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_49 = 4
			local var_292_50 = 0.05

			if var_292_49 < arg_289_1.time_ and arg_289_1.time_ <= var_292_49 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_51 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_51:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_52 = arg_289_1:FormatText(StoryNameCfg[36].name)

				arg_289_1.leftNameTxt_.text = var_292_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_53 = arg_289_1:GetWordFromCfg(120421070)
				local var_292_54 = arg_289_1:FormatText(var_292_53.content)

				arg_289_1.text_.text = var_292_54

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_55 = 2
				local var_292_56 = utf8.len(var_292_54)
				local var_292_57 = var_292_55 <= 0 and var_292_50 or var_292_50 * (var_292_56 / var_292_55)

				if var_292_57 > 0 and var_292_50 < var_292_57 then
					arg_289_1.talkMaxDuration = var_292_57
					var_292_49 = var_292_49 + 0.3

					if var_292_57 + var_292_49 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_57 + var_292_49
					end
				end

				arg_289_1.text_.text = var_292_54
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_58 = var_292_49 + 0.3
			local var_292_59 = math.max(var_292_50, arg_289_1.talkMaxDuration)

			if var_292_58 <= arg_289_1.time_ and arg_289_1.time_ < var_292_58 + var_292_59 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_58) / var_292_59

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_58 + var_292_59 and arg_289_1.time_ < var_292_58 + var_292_59 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play120421071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 120421071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play120421072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.125

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(120421071)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 5
				local var_298_5 = utf8.len(var_298_3)
				local var_298_6 = var_298_4 <= 0 and var_298_1 or var_298_1 * (var_298_5 / var_298_4)

				if var_298_6 > 0 and var_298_1 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_7 and arg_295_1.time_ < var_298_0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play120421072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 120421072
		arg_299_1.duration_ = 8.07

		local var_299_0 = {
			zh = 8.066,
			ja = 7.166
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play120421073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = "1074ui_story"

			if arg_299_1.actors_[var_302_0] == nil then
				local var_302_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_302_1) then
					local var_302_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_299_1.stage_.transform)

					var_302_2.name = var_302_0
					var_302_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_299_1.actors_[var_302_0] = var_302_2

					local var_302_3 = var_302_2:GetComponentInChildren(typeof(CharacterEffect))

					var_302_3.enabled = true

					local var_302_4 = GameObjectTools.GetOrAddComponent(var_302_2, typeof(DynamicBoneHelper))

					if var_302_4 then
						var_302_4:EnableDynamicBone(false)
					end

					arg_299_1:ShowWeapon(var_302_3.transform, false)

					arg_299_1.var_[var_302_0 .. "Animator"] = var_302_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_299_1.var_[var_302_0 .. "Animator"].applyRootMotion = true
					arg_299_1.var_[var_302_0 .. "LipSync"] = var_302_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_302_5 = arg_299_1.actors_["1074ui_story"].transform
			local var_302_6 = 0

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.var_.moveOldPos1074ui_story = var_302_5.localPosition
			end

			local var_302_7 = 0.001

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_7 then
				local var_302_8 = (arg_299_1.time_ - var_302_6) / var_302_7
				local var_302_9 = Vector3.New(0, -1.055, -6.12)

				var_302_5.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1074ui_story, var_302_9, var_302_8)

				local var_302_10 = manager.ui.mainCamera.transform.position - var_302_5.position

				var_302_5.forward = Vector3.New(var_302_10.x, var_302_10.y, var_302_10.z)

				local var_302_11 = var_302_5.localEulerAngles

				var_302_11.z = 0
				var_302_11.x = 0
				var_302_5.localEulerAngles = var_302_11
			end

			if arg_299_1.time_ >= var_302_6 + var_302_7 and arg_299_1.time_ < var_302_6 + var_302_7 + arg_302_0 then
				var_302_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_302_12 = manager.ui.mainCamera.transform.position - var_302_5.position

				var_302_5.forward = Vector3.New(var_302_12.x, var_302_12.y, var_302_12.z)

				local var_302_13 = var_302_5.localEulerAngles

				var_302_13.z = 0
				var_302_13.x = 0
				var_302_5.localEulerAngles = var_302_13
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_302_15 = 0

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_302_16 = arg_299_1.actors_["1074ui_story"]
			local var_302_17 = 0

			if var_302_17 < arg_299_1.time_ and arg_299_1.time_ <= var_302_17 + arg_302_0 and not isNil(var_302_16) and arg_299_1.var_.characterEffect1074ui_story == nil then
				arg_299_1.var_.characterEffect1074ui_story = var_302_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_18 = 0.2

			if var_302_17 <= arg_299_1.time_ and arg_299_1.time_ < var_302_17 + var_302_18 and not isNil(var_302_16) then
				local var_302_19 = (arg_299_1.time_ - var_302_17) / var_302_18

				if arg_299_1.var_.characterEffect1074ui_story and not isNil(var_302_16) then
					arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_17 + var_302_18 and arg_299_1.time_ < var_302_17 + var_302_18 + arg_302_0 and not isNil(var_302_16) and arg_299_1.var_.characterEffect1074ui_story then
				arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_302_20 = 0
			local var_302_21 = 0.6

			if var_302_20 < arg_299_1.time_ and arg_299_1.time_ <= var_302_20 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_22 = arg_299_1:FormatText(StoryNameCfg[36].name)

				arg_299_1.leftNameTxt_.text = var_302_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_23 = arg_299_1:GetWordFromCfg(120421072)
				local var_302_24 = arg_299_1:FormatText(var_302_23.content)

				arg_299_1.text_.text = var_302_24

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_25 = 24
				local var_302_26 = utf8.len(var_302_24)
				local var_302_27 = var_302_25 <= 0 and var_302_21 or var_302_21 * (var_302_26 / var_302_25)

				if var_302_27 > 0 and var_302_21 < var_302_27 then
					arg_299_1.talkMaxDuration = var_302_27

					if var_302_27 + var_302_20 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_27 + var_302_20
					end
				end

				arg_299_1.text_.text = var_302_24
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421072", "story_v_out_120421.awb") ~= 0 then
					local var_302_28 = manager.audio:GetVoiceLength("story_v_out_120421", "120421072", "story_v_out_120421.awb") / 1000

					if var_302_28 + var_302_20 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_28 + var_302_20
					end

					if var_302_23.prefab_name ~= "" and arg_299_1.actors_[var_302_23.prefab_name] ~= nil then
						local var_302_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_23.prefab_name].transform, "story_v_out_120421", "120421072", "story_v_out_120421.awb")

						arg_299_1:RecordAudio("120421072", var_302_29)
						arg_299_1:RecordAudio("120421072", var_302_29)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_120421", "120421072", "story_v_out_120421.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_120421", "120421072", "story_v_out_120421.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_30 = math.max(var_302_21, arg_299_1.talkMaxDuration)

			if var_302_20 <= arg_299_1.time_ and arg_299_1.time_ < var_302_20 + var_302_30 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_20) / var_302_30

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_20 + var_302_30 and arg_299_1.time_ < var_302_20 + var_302_30 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play120421073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 120421073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play120421074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1074ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1074ui_story == nil then
				arg_303_1.var_.characterEffect1074ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1074ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1074ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1074ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1074ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_306_7 = 0
			local var_306_8 = 1.025

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_9 = arg_303_1:GetWordFromCfg(120421073)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 38
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_8 or var_306_8 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_8 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_7 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_7
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_8, arg_303_1.talkMaxDuration)

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_7) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_7 + var_306_14 and arg_303_1.time_ < var_306_7 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play120421074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 120421074
		arg_307_1.duration_ = 8

		local var_307_0 = {
			zh = 4.5,
			ja = 8
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play120421075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = "1072ui_story"

			if arg_307_1.actors_[var_310_0] == nil then
				local var_310_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_310_1) then
					local var_310_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_307_1.stage_.transform)

					var_310_2.name = var_310_0
					var_310_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_307_1.actors_[var_310_0] = var_310_2

					local var_310_3 = var_310_2:GetComponentInChildren(typeof(CharacterEffect))

					var_310_3.enabled = true

					local var_310_4 = GameObjectTools.GetOrAddComponent(var_310_2, typeof(DynamicBoneHelper))

					if var_310_4 then
						var_310_4:EnableDynamicBone(false)
					end

					arg_307_1:ShowWeapon(var_310_3.transform, false)

					arg_307_1.var_[var_310_0 .. "Animator"] = var_310_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_307_1.var_[var_310_0 .. "Animator"].applyRootMotion = true
					arg_307_1.var_[var_310_0 .. "LipSync"] = var_310_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_310_5 = arg_307_1.actors_["1072ui_story"].transform
			local var_310_6 = 0

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.var_.moveOldPos1072ui_story = var_310_5.localPosition
			end

			local var_310_7 = 0.001

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_7 then
				local var_310_8 = (arg_307_1.time_ - var_310_6) / var_310_7
				local var_310_9 = Vector3.New(0, -0.71, -6)

				var_310_5.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1072ui_story, var_310_9, var_310_8)

				local var_310_10 = manager.ui.mainCamera.transform.position - var_310_5.position

				var_310_5.forward = Vector3.New(var_310_10.x, var_310_10.y, var_310_10.z)

				local var_310_11 = var_310_5.localEulerAngles

				var_310_11.z = 0
				var_310_11.x = 0
				var_310_5.localEulerAngles = var_310_11
			end

			if arg_307_1.time_ >= var_310_6 + var_310_7 and arg_307_1.time_ < var_310_6 + var_310_7 + arg_310_0 then
				var_310_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_310_12 = manager.ui.mainCamera.transform.position - var_310_5.position

				var_310_5.forward = Vector3.New(var_310_12.x, var_310_12.y, var_310_12.z)

				local var_310_13 = var_310_5.localEulerAngles

				var_310_13.z = 0
				var_310_13.x = 0
				var_310_5.localEulerAngles = var_310_13
			end

			local var_310_14 = 0

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				arg_307_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_310_15 = 0

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_16 = arg_307_1.actors_["1072ui_story"]
			local var_310_17 = 0

			if var_310_17 < arg_307_1.time_ and arg_307_1.time_ <= var_310_17 + arg_310_0 and not isNil(var_310_16) and arg_307_1.var_.characterEffect1072ui_story == nil then
				arg_307_1.var_.characterEffect1072ui_story = var_310_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_18 = 0.2

			if var_310_17 <= arg_307_1.time_ and arg_307_1.time_ < var_310_17 + var_310_18 and not isNil(var_310_16) then
				local var_310_19 = (arg_307_1.time_ - var_310_17) / var_310_18

				if arg_307_1.var_.characterEffect1072ui_story and not isNil(var_310_16) then
					arg_307_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_17 + var_310_18 and arg_307_1.time_ < var_310_17 + var_310_18 + arg_310_0 and not isNil(var_310_16) and arg_307_1.var_.characterEffect1072ui_story then
				arg_307_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_310_20 = arg_307_1.actors_["1074ui_story"].transform
			local var_310_21 = 0

			if var_310_21 < arg_307_1.time_ and arg_307_1.time_ <= var_310_21 + arg_310_0 then
				arg_307_1.var_.moveOldPos1074ui_story = var_310_20.localPosition
			end

			local var_310_22 = 0.001

			if var_310_21 <= arg_307_1.time_ and arg_307_1.time_ < var_310_21 + var_310_22 then
				local var_310_23 = (arg_307_1.time_ - var_310_21) / var_310_22
				local var_310_24 = Vector3.New(0, 100, 0)

				var_310_20.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1074ui_story, var_310_24, var_310_23)

				local var_310_25 = manager.ui.mainCamera.transform.position - var_310_20.position

				var_310_20.forward = Vector3.New(var_310_25.x, var_310_25.y, var_310_25.z)

				local var_310_26 = var_310_20.localEulerAngles

				var_310_26.z = 0
				var_310_26.x = 0
				var_310_20.localEulerAngles = var_310_26
			end

			if arg_307_1.time_ >= var_310_21 + var_310_22 and arg_307_1.time_ < var_310_21 + var_310_22 + arg_310_0 then
				var_310_20.localPosition = Vector3.New(0, 100, 0)

				local var_310_27 = manager.ui.mainCamera.transform.position - var_310_20.position

				var_310_20.forward = Vector3.New(var_310_27.x, var_310_27.y, var_310_27.z)

				local var_310_28 = var_310_20.localEulerAngles

				var_310_28.z = 0
				var_310_28.x = 0
				var_310_20.localEulerAngles = var_310_28
			end

			local var_310_29 = arg_307_1.actors_["1072ui_story"]
			local var_310_30 = 0

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 then
				if arg_307_1.var_.characterEffect1072ui_story == nil then
					arg_307_1.var_.characterEffect1072ui_story = var_310_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_310_31 = arg_307_1.var_.characterEffect1072ui_story

				var_310_31.imageEffect:turnOff()

				var_310_31.interferenceEffect.enabled = true
				var_310_31.interferenceEffect.noise = 0.001
				var_310_31.interferenceEffect.simTimeScale = 1
				var_310_31.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_310_32 = 0
			local var_310_33 = 0.575

			if var_310_32 < arg_307_1.time_ and arg_307_1.time_ <= var_310_32 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_34 = arg_307_1:FormatText(StoryNameCfg[379].name)

				arg_307_1.leftNameTxt_.text = var_310_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_35 = arg_307_1:GetWordFromCfg(120421074)
				local var_310_36 = arg_307_1:FormatText(var_310_35.content)

				arg_307_1.text_.text = var_310_36

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_37 = 23
				local var_310_38 = utf8.len(var_310_36)
				local var_310_39 = var_310_37 <= 0 and var_310_33 or var_310_33 * (var_310_38 / var_310_37)

				if var_310_39 > 0 and var_310_33 < var_310_39 then
					arg_307_1.talkMaxDuration = var_310_39

					if var_310_39 + var_310_32 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_39 + var_310_32
					end
				end

				arg_307_1.text_.text = var_310_36
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421074", "story_v_out_120421.awb") ~= 0 then
					local var_310_40 = manager.audio:GetVoiceLength("story_v_out_120421", "120421074", "story_v_out_120421.awb") / 1000

					if var_310_40 + var_310_32 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_40 + var_310_32
					end

					if var_310_35.prefab_name ~= "" and arg_307_1.actors_[var_310_35.prefab_name] ~= nil then
						local var_310_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_35.prefab_name].transform, "story_v_out_120421", "120421074", "story_v_out_120421.awb")

						arg_307_1:RecordAudio("120421074", var_310_41)
						arg_307_1:RecordAudio("120421074", var_310_41)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_120421", "120421074", "story_v_out_120421.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_120421", "120421074", "story_v_out_120421.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_42 = math.max(var_310_33, arg_307_1.talkMaxDuration)

			if var_310_32 <= arg_307_1.time_ and arg_307_1.time_ < var_310_32 + var_310_42 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_32) / var_310_42

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_32 + var_310_42 and arg_307_1.time_ < var_310_32 + var_310_42 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play120421075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 120421075
		arg_311_1.duration_ = 10.83

		local var_311_0 = {
			zh = 5.633,
			ja = 10.833
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play120421076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1072ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1072ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, -0.71, -6)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1072ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_10 = arg_311_1.actors_["1072ui_story"]
			local var_314_11 = 0

			if var_314_11 < arg_311_1.time_ and arg_311_1.time_ <= var_314_11 + arg_314_0 and not isNil(var_314_10) and arg_311_1.var_.characterEffect1072ui_story == nil then
				arg_311_1.var_.characterEffect1072ui_story = var_314_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_12 = 0.2

			if var_314_11 <= arg_311_1.time_ and arg_311_1.time_ < var_314_11 + var_314_12 and not isNil(var_314_10) then
				local var_314_13 = (arg_311_1.time_ - var_314_11) / var_314_12

				if arg_311_1.var_.characterEffect1072ui_story and not isNil(var_314_10) then
					local var_314_14 = Mathf.Lerp(0, 0.5, var_314_13)

					arg_311_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1072ui_story.fillRatio = var_314_14
				end
			end

			if arg_311_1.time_ >= var_314_11 + var_314_12 and arg_311_1.time_ < var_314_11 + var_314_12 + arg_314_0 and not isNil(var_314_10) and arg_311_1.var_.characterEffect1072ui_story then
				local var_314_15 = 0.5

				arg_311_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1072ui_story.fillRatio = var_314_15
			end

			local var_314_16 = 0
			local var_314_17 = 0.725

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_18 = arg_311_1:FormatText(StoryNameCfg[379].name)

				arg_311_1.leftNameTxt_.text = var_314_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(120421075)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_21 = 29
				local var_314_22 = utf8.len(var_314_20)
				local var_314_23 = var_314_21 <= 0 and var_314_17 or var_314_17 * (var_314_22 / var_314_21)

				if var_314_23 > 0 and var_314_17 < var_314_23 then
					arg_311_1.talkMaxDuration = var_314_23

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421075", "story_v_out_120421.awb") ~= 0 then
					local var_314_24 = manager.audio:GetVoiceLength("story_v_out_120421", "120421075", "story_v_out_120421.awb") / 1000

					if var_314_24 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_24 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_120421", "120421075", "story_v_out_120421.awb")

						arg_311_1:RecordAudio("120421075", var_314_25)
						arg_311_1:RecordAudio("120421075", var_314_25)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_120421", "120421075", "story_v_out_120421.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_120421", "120421075", "story_v_out_120421.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_16) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_16 + var_314_26 and arg_311_1.time_ < var_314_16 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play120421076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 120421076
		arg_315_1.duration_ = 6.7

		local var_315_0 = {
			zh = 2.8,
			ja = 6.7
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play120421077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1074ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1074ui_story == nil then
				arg_315_1.var_.characterEffect1074ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1074ui_story and not isNil(var_318_0) then
					arg_315_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1074ui_story then
				arg_315_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_318_4 = arg_315_1.actors_["1072ui_story"].transform
			local var_318_5 = 0

			if var_318_5 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.var_.moveOldPos1072ui_story = var_318_4.localPosition
			end

			local var_318_6 = 0.001

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_6 then
				local var_318_7 = (arg_315_1.time_ - var_318_5) / var_318_6
				local var_318_8 = Vector3.New(0, 100, 0)

				var_318_4.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1072ui_story, var_318_8, var_318_7)

				local var_318_9 = manager.ui.mainCamera.transform.position - var_318_4.position

				var_318_4.forward = Vector3.New(var_318_9.x, var_318_9.y, var_318_9.z)

				local var_318_10 = var_318_4.localEulerAngles

				var_318_10.z = 0
				var_318_10.x = 0
				var_318_4.localEulerAngles = var_318_10
			end

			if arg_315_1.time_ >= var_318_5 + var_318_6 and arg_315_1.time_ < var_318_5 + var_318_6 + arg_318_0 then
				var_318_4.localPosition = Vector3.New(0, 100, 0)

				local var_318_11 = manager.ui.mainCamera.transform.position - var_318_4.position

				var_318_4.forward = Vector3.New(var_318_11.x, var_318_11.y, var_318_11.z)

				local var_318_12 = var_318_4.localEulerAngles

				var_318_12.z = 0
				var_318_12.x = 0
				var_318_4.localEulerAngles = var_318_12
			end

			local var_318_13 = arg_315_1.actors_["1074ui_story"].transform
			local var_318_14 = 0

			if var_318_14 < arg_315_1.time_ and arg_315_1.time_ <= var_318_14 + arg_318_0 then
				arg_315_1.var_.moveOldPos1074ui_story = var_318_13.localPosition
			end

			local var_318_15 = 0.001

			if var_318_14 <= arg_315_1.time_ and arg_315_1.time_ < var_318_14 + var_318_15 then
				local var_318_16 = (arg_315_1.time_ - var_318_14) / var_318_15
				local var_318_17 = Vector3.New(0, -1.055, -6.12)

				var_318_13.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1074ui_story, var_318_17, var_318_16)

				local var_318_18 = manager.ui.mainCamera.transform.position - var_318_13.position

				var_318_13.forward = Vector3.New(var_318_18.x, var_318_18.y, var_318_18.z)

				local var_318_19 = var_318_13.localEulerAngles

				var_318_19.z = 0
				var_318_19.x = 0
				var_318_13.localEulerAngles = var_318_19
			end

			if arg_315_1.time_ >= var_318_14 + var_318_15 and arg_315_1.time_ < var_318_14 + var_318_15 + arg_318_0 then
				var_318_13.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_318_20 = manager.ui.mainCamera.transform.position - var_318_13.position

				var_318_13.forward = Vector3.New(var_318_20.x, var_318_20.y, var_318_20.z)

				local var_318_21 = var_318_13.localEulerAngles

				var_318_21.z = 0
				var_318_21.x = 0
				var_318_13.localEulerAngles = var_318_21
			end

			local var_318_22 = 0
			local var_318_23 = 0.275

			if var_318_22 < arg_315_1.time_ and arg_315_1.time_ <= var_318_22 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_24 = arg_315_1:FormatText(StoryNameCfg[410].name)

				arg_315_1.leftNameTxt_.text = var_318_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_25 = arg_315_1:GetWordFromCfg(120421076)
				local var_318_26 = arg_315_1:FormatText(var_318_25.content)

				arg_315_1.text_.text = var_318_26

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_27 = 11
				local var_318_28 = utf8.len(var_318_26)
				local var_318_29 = var_318_27 <= 0 and var_318_23 or var_318_23 * (var_318_28 / var_318_27)

				if var_318_29 > 0 and var_318_23 < var_318_29 then
					arg_315_1.talkMaxDuration = var_318_29

					if var_318_29 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_29 + var_318_22
					end
				end

				arg_315_1.text_.text = var_318_26
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421076", "story_v_out_120421.awb") ~= 0 then
					local var_318_30 = manager.audio:GetVoiceLength("story_v_out_120421", "120421076", "story_v_out_120421.awb") / 1000

					if var_318_30 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_30 + var_318_22
					end

					if var_318_25.prefab_name ~= "" and arg_315_1.actors_[var_318_25.prefab_name] ~= nil then
						local var_318_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_25.prefab_name].transform, "story_v_out_120421", "120421076", "story_v_out_120421.awb")

						arg_315_1:RecordAudio("120421076", var_318_31)
						arg_315_1:RecordAudio("120421076", var_318_31)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_120421", "120421076", "story_v_out_120421.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_120421", "120421076", "story_v_out_120421.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_32 = math.max(var_318_23, arg_315_1.talkMaxDuration)

			if var_318_22 <= arg_315_1.time_ and arg_315_1.time_ < var_318_22 + var_318_32 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_22) / var_318_32

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_22 + var_318_32 and arg_315_1.time_ < var_318_22 + var_318_32 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play120421077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 120421077
		arg_319_1.duration_ = 10.73

		local var_319_0 = {
			zh = 4.433,
			ja = 10.733
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play120421078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1074ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1074ui_story == nil then
				arg_319_1.var_.characterEffect1074ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1074ui_story and not isNil(var_322_0) then
					local var_322_4 = Mathf.Lerp(0, 0.5, var_322_3)

					arg_319_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1074ui_story.fillRatio = var_322_4
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1074ui_story then
				local var_322_5 = 0.5

				arg_319_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1074ui_story.fillRatio = var_322_5
			end

			local var_322_6 = arg_319_1.actors_["1072ui_story"].transform
			local var_322_7 = 0

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.var_.moveOldPos1072ui_story = var_322_6.localPosition
			end

			local var_322_8 = 0.001

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_8 then
				local var_322_9 = (arg_319_1.time_ - var_322_7) / var_322_8
				local var_322_10 = Vector3.New(0, -0.71, -6)

				var_322_6.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1072ui_story, var_322_10, var_322_9)

				local var_322_11 = manager.ui.mainCamera.transform.position - var_322_6.position

				var_322_6.forward = Vector3.New(var_322_11.x, var_322_11.y, var_322_11.z)

				local var_322_12 = var_322_6.localEulerAngles

				var_322_12.z = 0
				var_322_12.x = 0
				var_322_6.localEulerAngles = var_322_12
			end

			if arg_319_1.time_ >= var_322_7 + var_322_8 and arg_319_1.time_ < var_322_7 + var_322_8 + arg_322_0 then
				var_322_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_322_13 = manager.ui.mainCamera.transform.position - var_322_6.position

				var_322_6.forward = Vector3.New(var_322_13.x, var_322_13.y, var_322_13.z)

				local var_322_14 = var_322_6.localEulerAngles

				var_322_14.z = 0
				var_322_14.x = 0
				var_322_6.localEulerAngles = var_322_14
			end

			local var_322_15 = 0

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_17 = arg_319_1.actors_["1072ui_story"]
			local var_322_18 = 0

			if var_322_18 < arg_319_1.time_ and arg_319_1.time_ <= var_322_18 + arg_322_0 and not isNil(var_322_17) and arg_319_1.var_.characterEffect1072ui_story == nil then
				arg_319_1.var_.characterEffect1072ui_story = var_322_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_19 = 0.2

			if var_322_18 <= arg_319_1.time_ and arg_319_1.time_ < var_322_18 + var_322_19 and not isNil(var_322_17) then
				local var_322_20 = (arg_319_1.time_ - var_322_18) / var_322_19

				if arg_319_1.var_.characterEffect1072ui_story and not isNil(var_322_17) then
					arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_18 + var_322_19 and arg_319_1.time_ < var_322_18 + var_322_19 + arg_322_0 and not isNil(var_322_17) and arg_319_1.var_.characterEffect1072ui_story then
				arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_322_21 = arg_319_1.actors_["1074ui_story"].transform
			local var_322_22 = 0

			if var_322_22 < arg_319_1.time_ and arg_319_1.time_ <= var_322_22 + arg_322_0 then
				arg_319_1.var_.moveOldPos1074ui_story = var_322_21.localPosition
			end

			local var_322_23 = 0.001

			if var_322_22 <= arg_319_1.time_ and arg_319_1.time_ < var_322_22 + var_322_23 then
				local var_322_24 = (arg_319_1.time_ - var_322_22) / var_322_23
				local var_322_25 = Vector3.New(0, 100, 0)

				var_322_21.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1074ui_story, var_322_25, var_322_24)

				local var_322_26 = manager.ui.mainCamera.transform.position - var_322_21.position

				var_322_21.forward = Vector3.New(var_322_26.x, var_322_26.y, var_322_26.z)

				local var_322_27 = var_322_21.localEulerAngles

				var_322_27.z = 0
				var_322_27.x = 0
				var_322_21.localEulerAngles = var_322_27
			end

			if arg_319_1.time_ >= var_322_22 + var_322_23 and arg_319_1.time_ < var_322_22 + var_322_23 + arg_322_0 then
				var_322_21.localPosition = Vector3.New(0, 100, 0)

				local var_322_28 = manager.ui.mainCamera.transform.position - var_322_21.position

				var_322_21.forward = Vector3.New(var_322_28.x, var_322_28.y, var_322_28.z)

				local var_322_29 = var_322_21.localEulerAngles

				var_322_29.z = 0
				var_322_29.x = 0
				var_322_21.localEulerAngles = var_322_29
			end

			local var_322_30 = 0
			local var_322_31 = 0.5

			if var_322_30 < arg_319_1.time_ and arg_319_1.time_ <= var_322_30 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_32 = arg_319_1:FormatText(StoryNameCfg[379].name)

				arg_319_1.leftNameTxt_.text = var_322_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_33 = arg_319_1:GetWordFromCfg(120421077)
				local var_322_34 = arg_319_1:FormatText(var_322_33.content)

				arg_319_1.text_.text = var_322_34

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_35 = 20
				local var_322_36 = utf8.len(var_322_34)
				local var_322_37 = var_322_35 <= 0 and var_322_31 or var_322_31 * (var_322_36 / var_322_35)

				if var_322_37 > 0 and var_322_31 < var_322_37 then
					arg_319_1.talkMaxDuration = var_322_37

					if var_322_37 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_37 + var_322_30
					end
				end

				arg_319_1.text_.text = var_322_34
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421077", "story_v_out_120421.awb") ~= 0 then
					local var_322_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421077", "story_v_out_120421.awb") / 1000

					if var_322_38 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_38 + var_322_30
					end

					if var_322_33.prefab_name ~= "" and arg_319_1.actors_[var_322_33.prefab_name] ~= nil then
						local var_322_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_33.prefab_name].transform, "story_v_out_120421", "120421077", "story_v_out_120421.awb")

						arg_319_1:RecordAudio("120421077", var_322_39)
						arg_319_1:RecordAudio("120421077", var_322_39)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_120421", "120421077", "story_v_out_120421.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_120421", "120421077", "story_v_out_120421.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_40 = math.max(var_322_31, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_40 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_40

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_40 and arg_319_1.time_ < var_322_30 + var_322_40 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play120421078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 120421078
		arg_323_1.duration_ = 10.67

		local var_323_0 = {
			zh = 10.666,
			ja = 10.4
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play120421079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1074ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1074ui_story == nil then
				arg_323_1.var_.characterEffect1074ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1074ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1074ui_story then
				arg_323_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_326_4 = arg_323_1.actors_["1074ui_story"].transform
			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.var_.moveOldPos1074ui_story = var_326_4.localPosition
			end

			local var_326_6 = 0.001

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_6 then
				local var_326_7 = (arg_323_1.time_ - var_326_5) / var_326_6
				local var_326_8 = Vector3.New(0, -1.055, -6.12)

				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1074ui_story, var_326_8, var_326_7)

				local var_326_9 = manager.ui.mainCamera.transform.position - var_326_4.position

				var_326_4.forward = Vector3.New(var_326_9.x, var_326_9.y, var_326_9.z)

				local var_326_10 = var_326_4.localEulerAngles

				var_326_10.z = 0
				var_326_10.x = 0
				var_326_4.localEulerAngles = var_326_10
			end

			if arg_323_1.time_ >= var_326_5 + var_326_6 and arg_323_1.time_ < var_326_5 + var_326_6 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_326_11 = manager.ui.mainCamera.transform.position - var_326_4.position

				var_326_4.forward = Vector3.New(var_326_11.x, var_326_11.y, var_326_11.z)

				local var_326_12 = var_326_4.localEulerAngles

				var_326_12.z = 0
				var_326_12.x = 0
				var_326_4.localEulerAngles = var_326_12
			end

			local var_326_13 = arg_323_1.actors_["1072ui_story"].transform
			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1.var_.moveOldPos1072ui_story = var_326_13.localPosition
			end

			local var_326_15 = 0.001

			if var_326_14 <= arg_323_1.time_ and arg_323_1.time_ < var_326_14 + var_326_15 then
				local var_326_16 = (arg_323_1.time_ - var_326_14) / var_326_15
				local var_326_17 = Vector3.New(0, 100, 0)

				var_326_13.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1072ui_story, var_326_17, var_326_16)

				local var_326_18 = manager.ui.mainCamera.transform.position - var_326_13.position

				var_326_13.forward = Vector3.New(var_326_18.x, var_326_18.y, var_326_18.z)

				local var_326_19 = var_326_13.localEulerAngles

				var_326_19.z = 0
				var_326_19.x = 0
				var_326_13.localEulerAngles = var_326_19
			end

			if arg_323_1.time_ >= var_326_14 + var_326_15 and arg_323_1.time_ < var_326_14 + var_326_15 + arg_326_0 then
				var_326_13.localPosition = Vector3.New(0, 100, 0)

				local var_326_20 = manager.ui.mainCamera.transform.position - var_326_13.position

				var_326_13.forward = Vector3.New(var_326_20.x, var_326_20.y, var_326_20.z)

				local var_326_21 = var_326_13.localEulerAngles

				var_326_21.z = 0
				var_326_21.x = 0
				var_326_13.localEulerAngles = var_326_21
			end

			local var_326_22 = 0
			local var_326_23 = 0.875

			if var_326_22 < arg_323_1.time_ and arg_323_1.time_ <= var_326_22 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_24 = arg_323_1:FormatText(StoryNameCfg[410].name)

				arg_323_1.leftNameTxt_.text = var_326_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_25 = arg_323_1:GetWordFromCfg(120421078)
				local var_326_26 = arg_323_1:FormatText(var_326_25.content)

				arg_323_1.text_.text = var_326_26

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_27 = 35
				local var_326_28 = utf8.len(var_326_26)
				local var_326_29 = var_326_27 <= 0 and var_326_23 or var_326_23 * (var_326_28 / var_326_27)

				if var_326_29 > 0 and var_326_23 < var_326_29 then
					arg_323_1.talkMaxDuration = var_326_29

					if var_326_29 + var_326_22 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_29 + var_326_22
					end
				end

				arg_323_1.text_.text = var_326_26
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421078", "story_v_out_120421.awb") ~= 0 then
					local var_326_30 = manager.audio:GetVoiceLength("story_v_out_120421", "120421078", "story_v_out_120421.awb") / 1000

					if var_326_30 + var_326_22 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_22
					end

					if var_326_25.prefab_name ~= "" and arg_323_1.actors_[var_326_25.prefab_name] ~= nil then
						local var_326_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_25.prefab_name].transform, "story_v_out_120421", "120421078", "story_v_out_120421.awb")

						arg_323_1:RecordAudio("120421078", var_326_31)
						arg_323_1:RecordAudio("120421078", var_326_31)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_120421", "120421078", "story_v_out_120421.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_120421", "120421078", "story_v_out_120421.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_32 = math.max(var_326_23, arg_323_1.talkMaxDuration)

			if var_326_22 <= arg_323_1.time_ and arg_323_1.time_ < var_326_22 + var_326_32 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_22) / var_326_32

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_22 + var_326_32 and arg_323_1.time_ < var_326_22 + var_326_32 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play120421079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 120421079
		arg_327_1.duration_ = 11.97

		local var_327_0 = {
			zh = 8.4,
			ja = 11.966
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play120421080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1074ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1074ui_story == nil then
				arg_327_1.var_.characterEffect1074ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1074ui_story and not isNil(var_330_0) then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1074ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1074ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1074ui_story.fillRatio = var_330_5
			end

			local var_330_6 = arg_327_1.actors_["1072ui_story"].transform
			local var_330_7 = 0

			if var_330_7 < arg_327_1.time_ and arg_327_1.time_ <= var_330_7 + arg_330_0 then
				arg_327_1.var_.moveOldPos1072ui_story = var_330_6.localPosition
			end

			local var_330_8 = 0.001

			if var_330_7 <= arg_327_1.time_ and arg_327_1.time_ < var_330_7 + var_330_8 then
				local var_330_9 = (arg_327_1.time_ - var_330_7) / var_330_8
				local var_330_10 = Vector3.New(0, -0.71, -6)

				var_330_6.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1072ui_story, var_330_10, var_330_9)

				local var_330_11 = manager.ui.mainCamera.transform.position - var_330_6.position

				var_330_6.forward = Vector3.New(var_330_11.x, var_330_11.y, var_330_11.z)

				local var_330_12 = var_330_6.localEulerAngles

				var_330_12.z = 0
				var_330_12.x = 0
				var_330_6.localEulerAngles = var_330_12
			end

			if arg_327_1.time_ >= var_330_7 + var_330_8 and arg_327_1.time_ < var_330_7 + var_330_8 + arg_330_0 then
				var_330_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_330_13 = manager.ui.mainCamera.transform.position - var_330_6.position

				var_330_6.forward = Vector3.New(var_330_13.x, var_330_13.y, var_330_13.z)

				local var_330_14 = var_330_6.localEulerAngles

				var_330_14.z = 0
				var_330_14.x = 0
				var_330_6.localEulerAngles = var_330_14
			end

			local var_330_15 = 0

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				arg_327_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_17 = arg_327_1.actors_["1072ui_story"]
			local var_330_18 = 0

			if var_330_18 < arg_327_1.time_ and arg_327_1.time_ <= var_330_18 + arg_330_0 and not isNil(var_330_17) and arg_327_1.var_.characterEffect1072ui_story == nil then
				arg_327_1.var_.characterEffect1072ui_story = var_330_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_19 = 0.2

			if var_330_18 <= arg_327_1.time_ and arg_327_1.time_ < var_330_18 + var_330_19 and not isNil(var_330_17) then
				local var_330_20 = (arg_327_1.time_ - var_330_18) / var_330_19

				if arg_327_1.var_.characterEffect1072ui_story and not isNil(var_330_17) then
					arg_327_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_18 + var_330_19 and arg_327_1.time_ < var_330_18 + var_330_19 + arg_330_0 and not isNil(var_330_17) and arg_327_1.var_.characterEffect1072ui_story then
				arg_327_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_330_21 = arg_327_1.actors_["1074ui_story"].transform
			local var_330_22 = 0

			if var_330_22 < arg_327_1.time_ and arg_327_1.time_ <= var_330_22 + arg_330_0 then
				arg_327_1.var_.moveOldPos1074ui_story = var_330_21.localPosition
			end

			local var_330_23 = 0.001

			if var_330_22 <= arg_327_1.time_ and arg_327_1.time_ < var_330_22 + var_330_23 then
				local var_330_24 = (arg_327_1.time_ - var_330_22) / var_330_23
				local var_330_25 = Vector3.New(0, 100, 0)

				var_330_21.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1074ui_story, var_330_25, var_330_24)

				local var_330_26 = manager.ui.mainCamera.transform.position - var_330_21.position

				var_330_21.forward = Vector3.New(var_330_26.x, var_330_26.y, var_330_26.z)

				local var_330_27 = var_330_21.localEulerAngles

				var_330_27.z = 0
				var_330_27.x = 0
				var_330_21.localEulerAngles = var_330_27
			end

			if arg_327_1.time_ >= var_330_22 + var_330_23 and arg_327_1.time_ < var_330_22 + var_330_23 + arg_330_0 then
				var_330_21.localPosition = Vector3.New(0, 100, 0)

				local var_330_28 = manager.ui.mainCamera.transform.position - var_330_21.position

				var_330_21.forward = Vector3.New(var_330_28.x, var_330_28.y, var_330_28.z)

				local var_330_29 = var_330_21.localEulerAngles

				var_330_29.z = 0
				var_330_29.x = 0
				var_330_21.localEulerAngles = var_330_29
			end

			local var_330_30 = 0
			local var_330_31 = 0.975

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_32 = arg_327_1:FormatText(StoryNameCfg[379].name)

				arg_327_1.leftNameTxt_.text = var_330_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_33 = arg_327_1:GetWordFromCfg(120421079)
				local var_330_34 = arg_327_1:FormatText(var_330_33.content)

				arg_327_1.text_.text = var_330_34

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_35 = 39
				local var_330_36 = utf8.len(var_330_34)
				local var_330_37 = var_330_35 <= 0 and var_330_31 or var_330_31 * (var_330_36 / var_330_35)

				if var_330_37 > 0 and var_330_31 < var_330_37 then
					arg_327_1.talkMaxDuration = var_330_37

					if var_330_37 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_37 + var_330_30
					end
				end

				arg_327_1.text_.text = var_330_34
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421079", "story_v_out_120421.awb") ~= 0 then
					local var_330_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421079", "story_v_out_120421.awb") / 1000

					if var_330_38 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_30
					end

					if var_330_33.prefab_name ~= "" and arg_327_1.actors_[var_330_33.prefab_name] ~= nil then
						local var_330_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_33.prefab_name].transform, "story_v_out_120421", "120421079", "story_v_out_120421.awb")

						arg_327_1:RecordAudio("120421079", var_330_39)
						arg_327_1:RecordAudio("120421079", var_330_39)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_120421", "120421079", "story_v_out_120421.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_120421", "120421079", "story_v_out_120421.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_40 = math.max(var_330_31, arg_327_1.talkMaxDuration)

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_40 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_30) / var_330_40

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_30 + var_330_40 and arg_327_1.time_ < var_330_30 + var_330_40 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play120421080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 120421080
		arg_331_1.duration_ = 5.13

		local var_331_0 = {
			zh = 3.066,
			ja = 5.133
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play120421081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1074ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1074ui_story == nil then
				arg_331_1.var_.characterEffect1074ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1074ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1074ui_story then
				arg_331_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["1074ui_story"].transform
			local var_334_5 = 0

			if var_334_5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.var_.moveOldPos1074ui_story = var_334_4.localPosition
			end

			local var_334_6 = 0.001

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_6 then
				local var_334_7 = (arg_331_1.time_ - var_334_5) / var_334_6
				local var_334_8 = Vector3.New(0, -1.055, -6.12)

				var_334_4.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1074ui_story, var_334_8, var_334_7)

				local var_334_9 = manager.ui.mainCamera.transform.position - var_334_4.position

				var_334_4.forward = Vector3.New(var_334_9.x, var_334_9.y, var_334_9.z)

				local var_334_10 = var_334_4.localEulerAngles

				var_334_10.z = 0
				var_334_10.x = 0
				var_334_4.localEulerAngles = var_334_10
			end

			if arg_331_1.time_ >= var_334_5 + var_334_6 and arg_331_1.time_ < var_334_5 + var_334_6 + arg_334_0 then
				var_334_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_334_11 = manager.ui.mainCamera.transform.position - var_334_4.position

				var_334_4.forward = Vector3.New(var_334_11.x, var_334_11.y, var_334_11.z)

				local var_334_12 = var_334_4.localEulerAngles

				var_334_12.z = 0
				var_334_12.x = 0
				var_334_4.localEulerAngles = var_334_12
			end

			local var_334_13 = arg_331_1.actors_["1072ui_story"].transform
			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.var_.moveOldPos1072ui_story = var_334_13.localPosition
			end

			local var_334_15 = 0.001

			if var_334_14 <= arg_331_1.time_ and arg_331_1.time_ < var_334_14 + var_334_15 then
				local var_334_16 = (arg_331_1.time_ - var_334_14) / var_334_15
				local var_334_17 = Vector3.New(0, 100, 0)

				var_334_13.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1072ui_story, var_334_17, var_334_16)

				local var_334_18 = manager.ui.mainCamera.transform.position - var_334_13.position

				var_334_13.forward = Vector3.New(var_334_18.x, var_334_18.y, var_334_18.z)

				local var_334_19 = var_334_13.localEulerAngles

				var_334_19.z = 0
				var_334_19.x = 0
				var_334_13.localEulerAngles = var_334_19
			end

			if arg_331_1.time_ >= var_334_14 + var_334_15 and arg_331_1.time_ < var_334_14 + var_334_15 + arg_334_0 then
				var_334_13.localPosition = Vector3.New(0, 100, 0)

				local var_334_20 = manager.ui.mainCamera.transform.position - var_334_13.position

				var_334_13.forward = Vector3.New(var_334_20.x, var_334_20.y, var_334_20.z)

				local var_334_21 = var_334_13.localEulerAngles

				var_334_21.z = 0
				var_334_21.x = 0
				var_334_13.localEulerAngles = var_334_21
			end

			local var_334_22 = 0
			local var_334_23 = 0.25

			if var_334_22 < arg_331_1.time_ and arg_331_1.time_ <= var_334_22 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_24 = arg_331_1:FormatText(StoryNameCfg[410].name)

				arg_331_1.leftNameTxt_.text = var_334_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_25 = arg_331_1:GetWordFromCfg(120421080)
				local var_334_26 = arg_331_1:FormatText(var_334_25.content)

				arg_331_1.text_.text = var_334_26

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_27 = 10
				local var_334_28 = utf8.len(var_334_26)
				local var_334_29 = var_334_27 <= 0 and var_334_23 or var_334_23 * (var_334_28 / var_334_27)

				if var_334_29 > 0 and var_334_23 < var_334_29 then
					arg_331_1.talkMaxDuration = var_334_29

					if var_334_29 + var_334_22 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_29 + var_334_22
					end
				end

				arg_331_1.text_.text = var_334_26
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421080", "story_v_out_120421.awb") ~= 0 then
					local var_334_30 = manager.audio:GetVoiceLength("story_v_out_120421", "120421080", "story_v_out_120421.awb") / 1000

					if var_334_30 + var_334_22 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_30 + var_334_22
					end

					if var_334_25.prefab_name ~= "" and arg_331_1.actors_[var_334_25.prefab_name] ~= nil then
						local var_334_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_25.prefab_name].transform, "story_v_out_120421", "120421080", "story_v_out_120421.awb")

						arg_331_1:RecordAudio("120421080", var_334_31)
						arg_331_1:RecordAudio("120421080", var_334_31)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_120421", "120421080", "story_v_out_120421.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_120421", "120421080", "story_v_out_120421.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_32 = math.max(var_334_23, arg_331_1.talkMaxDuration)

			if var_334_22 <= arg_331_1.time_ and arg_331_1.time_ < var_334_22 + var_334_32 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_22) / var_334_32

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_22 + var_334_32 and arg_331_1.time_ < var_334_22 + var_334_32 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play120421081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 120421081
		arg_335_1.duration_ = 8.37

		local var_335_0 = {
			zh = 6.666,
			ja = 8.366
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play120421082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1074ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1074ui_story == nil then
				arg_335_1.var_.characterEffect1074ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1074ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1074ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1074ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1074ui_story.fillRatio = var_338_5
			end

			local var_338_6 = arg_335_1.actors_["1072ui_story"].transform
			local var_338_7 = 0

			if var_338_7 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 then
				arg_335_1.var_.moveOldPos1072ui_story = var_338_6.localPosition
			end

			local var_338_8 = 0.001

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_8 then
				local var_338_9 = (arg_335_1.time_ - var_338_7) / var_338_8
				local var_338_10 = Vector3.New(0, -0.71, -6)

				var_338_6.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1072ui_story, var_338_10, var_338_9)

				local var_338_11 = manager.ui.mainCamera.transform.position - var_338_6.position

				var_338_6.forward = Vector3.New(var_338_11.x, var_338_11.y, var_338_11.z)

				local var_338_12 = var_338_6.localEulerAngles

				var_338_12.z = 0
				var_338_12.x = 0
				var_338_6.localEulerAngles = var_338_12
			end

			if arg_335_1.time_ >= var_338_7 + var_338_8 and arg_335_1.time_ < var_338_7 + var_338_8 + arg_338_0 then
				var_338_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_338_13 = manager.ui.mainCamera.transform.position - var_338_6.position

				var_338_6.forward = Vector3.New(var_338_13.x, var_338_13.y, var_338_13.z)

				local var_338_14 = var_338_6.localEulerAngles

				var_338_14.z = 0
				var_338_14.x = 0
				var_338_6.localEulerAngles = var_338_14
			end

			local var_338_15 = 0

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_338_17 = arg_335_1.actors_["1072ui_story"]
			local var_338_18 = 0

			if var_338_18 < arg_335_1.time_ and arg_335_1.time_ <= var_338_18 + arg_338_0 and not isNil(var_338_17) and arg_335_1.var_.characterEffect1072ui_story == nil then
				arg_335_1.var_.characterEffect1072ui_story = var_338_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_19 = 0.2

			if var_338_18 <= arg_335_1.time_ and arg_335_1.time_ < var_338_18 + var_338_19 and not isNil(var_338_17) then
				local var_338_20 = (arg_335_1.time_ - var_338_18) / var_338_19

				if arg_335_1.var_.characterEffect1072ui_story and not isNil(var_338_17) then
					arg_335_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_18 + var_338_19 and arg_335_1.time_ < var_338_18 + var_338_19 + arg_338_0 and not isNil(var_338_17) and arg_335_1.var_.characterEffect1072ui_story then
				arg_335_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_338_21 = arg_335_1.actors_["1074ui_story"].transform
			local var_338_22 = 0

			if var_338_22 < arg_335_1.time_ and arg_335_1.time_ <= var_338_22 + arg_338_0 then
				arg_335_1.var_.moveOldPos1074ui_story = var_338_21.localPosition
			end

			local var_338_23 = 0.001

			if var_338_22 <= arg_335_1.time_ and arg_335_1.time_ < var_338_22 + var_338_23 then
				local var_338_24 = (arg_335_1.time_ - var_338_22) / var_338_23
				local var_338_25 = Vector3.New(0, 100, 0)

				var_338_21.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1074ui_story, var_338_25, var_338_24)

				local var_338_26 = manager.ui.mainCamera.transform.position - var_338_21.position

				var_338_21.forward = Vector3.New(var_338_26.x, var_338_26.y, var_338_26.z)

				local var_338_27 = var_338_21.localEulerAngles

				var_338_27.z = 0
				var_338_27.x = 0
				var_338_21.localEulerAngles = var_338_27
			end

			if arg_335_1.time_ >= var_338_22 + var_338_23 and arg_335_1.time_ < var_338_22 + var_338_23 + arg_338_0 then
				var_338_21.localPosition = Vector3.New(0, 100, 0)

				local var_338_28 = manager.ui.mainCamera.transform.position - var_338_21.position

				var_338_21.forward = Vector3.New(var_338_28.x, var_338_28.y, var_338_28.z)

				local var_338_29 = var_338_21.localEulerAngles

				var_338_29.z = 0
				var_338_29.x = 0
				var_338_21.localEulerAngles = var_338_29
			end

			local var_338_30 = 0
			local var_338_31 = 0.725

			if var_338_30 < arg_335_1.time_ and arg_335_1.time_ <= var_338_30 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_32 = arg_335_1:FormatText(StoryNameCfg[379].name)

				arg_335_1.leftNameTxt_.text = var_338_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_33 = arg_335_1:GetWordFromCfg(120421081)
				local var_338_34 = arg_335_1:FormatText(var_338_33.content)

				arg_335_1.text_.text = var_338_34

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_35 = 29
				local var_338_36 = utf8.len(var_338_34)
				local var_338_37 = var_338_35 <= 0 and var_338_31 or var_338_31 * (var_338_36 / var_338_35)

				if var_338_37 > 0 and var_338_31 < var_338_37 then
					arg_335_1.talkMaxDuration = var_338_37

					if var_338_37 + var_338_30 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_37 + var_338_30
					end
				end

				arg_335_1.text_.text = var_338_34
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421081", "story_v_out_120421.awb") ~= 0 then
					local var_338_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421081", "story_v_out_120421.awb") / 1000

					if var_338_38 + var_338_30 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_38 + var_338_30
					end

					if var_338_33.prefab_name ~= "" and arg_335_1.actors_[var_338_33.prefab_name] ~= nil then
						local var_338_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_33.prefab_name].transform, "story_v_out_120421", "120421081", "story_v_out_120421.awb")

						arg_335_1:RecordAudio("120421081", var_338_39)
						arg_335_1:RecordAudio("120421081", var_338_39)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_120421", "120421081", "story_v_out_120421.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_120421", "120421081", "story_v_out_120421.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_40 = math.max(var_338_31, arg_335_1.talkMaxDuration)

			if var_338_30 <= arg_335_1.time_ and arg_335_1.time_ < var_338_30 + var_338_40 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_30) / var_338_40

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_30 + var_338_40 and arg_335_1.time_ < var_338_30 + var_338_40 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play120421082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 120421082
		arg_339_1.duration_ = 1.03

		local var_339_0 = {
			zh = 0.999999999999,
			ja = 1.033
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play120421083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1074ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1074ui_story == nil then
				arg_339_1.var_.characterEffect1074ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1074ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1074ui_story then
				arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_342_4 = arg_339_1.actors_["1074ui_story"].transform
			local var_342_5 = 0

			if var_342_5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.var_.moveOldPos1074ui_story = var_342_4.localPosition
			end

			local var_342_6 = 0.001

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_6 then
				local var_342_7 = (arg_339_1.time_ - var_342_5) / var_342_6
				local var_342_8 = Vector3.New(0, -1.055, -6.12)

				var_342_4.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1074ui_story, var_342_8, var_342_7)

				local var_342_9 = manager.ui.mainCamera.transform.position - var_342_4.position

				var_342_4.forward = Vector3.New(var_342_9.x, var_342_9.y, var_342_9.z)

				local var_342_10 = var_342_4.localEulerAngles

				var_342_10.z = 0
				var_342_10.x = 0
				var_342_4.localEulerAngles = var_342_10
			end

			if arg_339_1.time_ >= var_342_5 + var_342_6 and arg_339_1.time_ < var_342_5 + var_342_6 + arg_342_0 then
				var_342_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_342_11 = manager.ui.mainCamera.transform.position - var_342_4.position

				var_342_4.forward = Vector3.New(var_342_11.x, var_342_11.y, var_342_11.z)

				local var_342_12 = var_342_4.localEulerAngles

				var_342_12.z = 0
				var_342_12.x = 0
				var_342_4.localEulerAngles = var_342_12
			end

			local var_342_13 = arg_339_1.actors_["1072ui_story"].transform
			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 then
				arg_339_1.var_.moveOldPos1072ui_story = var_342_13.localPosition
			end

			local var_342_15 = 0.001

			if var_342_14 <= arg_339_1.time_ and arg_339_1.time_ < var_342_14 + var_342_15 then
				local var_342_16 = (arg_339_1.time_ - var_342_14) / var_342_15
				local var_342_17 = Vector3.New(0, 100, 0)

				var_342_13.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1072ui_story, var_342_17, var_342_16)

				local var_342_18 = manager.ui.mainCamera.transform.position - var_342_13.position

				var_342_13.forward = Vector3.New(var_342_18.x, var_342_18.y, var_342_18.z)

				local var_342_19 = var_342_13.localEulerAngles

				var_342_19.z = 0
				var_342_19.x = 0
				var_342_13.localEulerAngles = var_342_19
			end

			if arg_339_1.time_ >= var_342_14 + var_342_15 and arg_339_1.time_ < var_342_14 + var_342_15 + arg_342_0 then
				var_342_13.localPosition = Vector3.New(0, 100, 0)

				local var_342_20 = manager.ui.mainCamera.transform.position - var_342_13.position

				var_342_13.forward = Vector3.New(var_342_20.x, var_342_20.y, var_342_20.z)

				local var_342_21 = var_342_13.localEulerAngles

				var_342_21.z = 0
				var_342_21.x = 0
				var_342_13.localEulerAngles = var_342_21
			end

			local var_342_22 = 0
			local var_342_23 = 0.05

			if var_342_22 < arg_339_1.time_ and arg_339_1.time_ <= var_342_22 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_24 = arg_339_1:FormatText(StoryNameCfg[410].name)

				arg_339_1.leftNameTxt_.text = var_342_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_25 = arg_339_1:GetWordFromCfg(120421082)
				local var_342_26 = arg_339_1:FormatText(var_342_25.content)

				arg_339_1.text_.text = var_342_26

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_27 = 2
				local var_342_28 = utf8.len(var_342_26)
				local var_342_29 = var_342_27 <= 0 and var_342_23 or var_342_23 * (var_342_28 / var_342_27)

				if var_342_29 > 0 and var_342_23 < var_342_29 then
					arg_339_1.talkMaxDuration = var_342_29

					if var_342_29 + var_342_22 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_22
					end
				end

				arg_339_1.text_.text = var_342_26
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421082", "story_v_out_120421.awb") ~= 0 then
					local var_342_30 = manager.audio:GetVoiceLength("story_v_out_120421", "120421082", "story_v_out_120421.awb") / 1000

					if var_342_30 + var_342_22 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_30 + var_342_22
					end

					if var_342_25.prefab_name ~= "" and arg_339_1.actors_[var_342_25.prefab_name] ~= nil then
						local var_342_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_25.prefab_name].transform, "story_v_out_120421", "120421082", "story_v_out_120421.awb")

						arg_339_1:RecordAudio("120421082", var_342_31)
						arg_339_1:RecordAudio("120421082", var_342_31)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_120421", "120421082", "story_v_out_120421.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_120421", "120421082", "story_v_out_120421.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_32 = math.max(var_342_23, arg_339_1.talkMaxDuration)

			if var_342_22 <= arg_339_1.time_ and arg_339_1.time_ < var_342_22 + var_342_32 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_22) / var_342_32

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_22 + var_342_32 and arg_339_1.time_ < var_342_22 + var_342_32 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play120421083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 120421083
		arg_343_1.duration_ = 5.83

		local var_343_0 = {
			zh = 3.266,
			ja = 5.833
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play120421084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.35

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[410].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(120421083)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 14
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421083", "story_v_out_120421.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421083", "story_v_out_120421.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_120421", "120421083", "story_v_out_120421.awb")

						arg_343_1:RecordAudio("120421083", var_346_9)
						arg_343_1:RecordAudio("120421083", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_120421", "120421083", "story_v_out_120421.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_120421", "120421083", "story_v_out_120421.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play120421084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 120421084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play120421085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1074ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1074ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(0, 100, 0)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1074ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, 100, 0)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = 0
			local var_350_10 = 1.25

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_11 = arg_347_1:GetWordFromCfg(120421084)
				local var_350_12 = arg_347_1:FormatText(var_350_11.content)

				arg_347_1.text_.text = var_350_12

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 50
				local var_350_14 = utf8.len(var_350_12)
				local var_350_15 = var_350_13 <= 0 and var_350_10 or var_350_10 * (var_350_14 / var_350_13)

				if var_350_15 > 0 and var_350_10 < var_350_15 then
					arg_347_1.talkMaxDuration = var_350_15

					if var_350_15 + var_350_9 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_9
					end
				end

				arg_347_1.text_.text = var_350_12
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_16 = math.max(var_350_10, arg_347_1.talkMaxDuration)

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_16 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_9) / var_350_16

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_9 + var_350_16 and arg_347_1.time_ < var_350_9 + var_350_16 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play120421085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 120421085
		arg_351_1.duration_ = 4.4

		local var_351_0 = {
			zh = 4.4,
			ja = 4.033
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play120421086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1074ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1074ui_story == nil then
				arg_351_1.var_.characterEffect1074ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1074ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1074ui_story then
				arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_354_5 = arg_351_1.actors_["1074ui_story"].transform
			local var_354_6 = 0

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.var_.moveOldPos1074ui_story = var_354_5.localPosition
			end

			local var_354_7 = 0.001

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_7 then
				local var_354_8 = (arg_351_1.time_ - var_354_6) / var_354_7
				local var_354_9 = Vector3.New(0, -1.055, -6.12)

				var_354_5.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1074ui_story, var_354_9, var_354_8)

				local var_354_10 = manager.ui.mainCamera.transform.position - var_354_5.position

				var_354_5.forward = Vector3.New(var_354_10.x, var_354_10.y, var_354_10.z)

				local var_354_11 = var_354_5.localEulerAngles

				var_354_11.z = 0
				var_354_11.x = 0
				var_354_5.localEulerAngles = var_354_11
			end

			if arg_351_1.time_ >= var_354_6 + var_354_7 and arg_351_1.time_ < var_354_6 + var_354_7 + arg_354_0 then
				var_354_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_354_12 = manager.ui.mainCamera.transform.position - var_354_5.position

				var_354_5.forward = Vector3.New(var_354_12.x, var_354_12.y, var_354_12.z)

				local var_354_13 = var_354_5.localEulerAngles

				var_354_13.z = 0
				var_354_13.x = 0
				var_354_5.localEulerAngles = var_354_13
			end

			local var_354_14 = 0
			local var_354_15 = 0.475

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_16 = arg_351_1:FormatText(StoryNameCfg[410].name)

				arg_351_1.leftNameTxt_.text = var_354_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_17 = arg_351_1:GetWordFromCfg(120421085)
				local var_354_18 = arg_351_1:FormatText(var_354_17.content)

				arg_351_1.text_.text = var_354_18

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_19 = 19
				local var_354_20 = utf8.len(var_354_18)
				local var_354_21 = var_354_19 <= 0 and var_354_15 or var_354_15 * (var_354_20 / var_354_19)

				if var_354_21 > 0 and var_354_15 < var_354_21 then
					arg_351_1.talkMaxDuration = var_354_21

					if var_354_21 + var_354_14 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_21 + var_354_14
					end
				end

				arg_351_1.text_.text = var_354_18
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421085", "story_v_out_120421.awb") ~= 0 then
					local var_354_22 = manager.audio:GetVoiceLength("story_v_out_120421", "120421085", "story_v_out_120421.awb") / 1000

					if var_354_22 + var_354_14 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_14
					end

					if var_354_17.prefab_name ~= "" and arg_351_1.actors_[var_354_17.prefab_name] ~= nil then
						local var_354_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_17.prefab_name].transform, "story_v_out_120421", "120421085", "story_v_out_120421.awb")

						arg_351_1:RecordAudio("120421085", var_354_23)
						arg_351_1:RecordAudio("120421085", var_354_23)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_120421", "120421085", "story_v_out_120421.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_120421", "120421085", "story_v_out_120421.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_24 = math.max(var_354_15, arg_351_1.talkMaxDuration)

			if var_354_14 <= arg_351_1.time_ and arg_351_1.time_ < var_354_14 + var_354_24 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_14) / var_354_24

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_14 + var_354_24 and arg_351_1.time_ < var_354_14 + var_354_24 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play120421086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 120421086
		arg_355_1.duration_ = 13.83

		local var_355_0 = {
			zh = 7,
			ja = 13.833
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play120421087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1074ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1074ui_story == nil then
				arg_355_1.var_.characterEffect1074ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1074ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1074ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1074ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1074ui_story.fillRatio = var_358_5
			end

			local var_358_6 = arg_355_1.actors_["1072ui_story"].transform
			local var_358_7 = 0

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.var_.moveOldPos1072ui_story = var_358_6.localPosition
			end

			local var_358_8 = 0.001

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_8 then
				local var_358_9 = (arg_355_1.time_ - var_358_7) / var_358_8
				local var_358_10 = Vector3.New(0, -0.71, -6)

				var_358_6.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1072ui_story, var_358_10, var_358_9)

				local var_358_11 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_11.x, var_358_11.y, var_358_11.z)

				local var_358_12 = var_358_6.localEulerAngles

				var_358_12.z = 0
				var_358_12.x = 0
				var_358_6.localEulerAngles = var_358_12
			end

			if arg_355_1.time_ >= var_358_7 + var_358_8 and arg_355_1.time_ < var_358_7 + var_358_8 + arg_358_0 then
				var_358_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_358_13 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_13.x, var_358_13.y, var_358_13.z)

				local var_358_14 = var_358_6.localEulerAngles

				var_358_14.z = 0
				var_358_14.x = 0
				var_358_6.localEulerAngles = var_358_14
			end

			local var_358_15 = 0

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_17 = arg_355_1.actors_["1072ui_story"]
			local var_358_18 = 0

			if var_358_18 < arg_355_1.time_ and arg_355_1.time_ <= var_358_18 + arg_358_0 and not isNil(var_358_17) and arg_355_1.var_.characterEffect1072ui_story == nil then
				arg_355_1.var_.characterEffect1072ui_story = var_358_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_19 = 0.2

			if var_358_18 <= arg_355_1.time_ and arg_355_1.time_ < var_358_18 + var_358_19 and not isNil(var_358_17) then
				local var_358_20 = (arg_355_1.time_ - var_358_18) / var_358_19

				if arg_355_1.var_.characterEffect1072ui_story and not isNil(var_358_17) then
					arg_355_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_18 + var_358_19 and arg_355_1.time_ < var_358_18 + var_358_19 + arg_358_0 and not isNil(var_358_17) and arg_355_1.var_.characterEffect1072ui_story then
				arg_355_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_358_21 = arg_355_1.actors_["1074ui_story"].transform
			local var_358_22 = 0

			if var_358_22 < arg_355_1.time_ and arg_355_1.time_ <= var_358_22 + arg_358_0 then
				arg_355_1.var_.moveOldPos1074ui_story = var_358_21.localPosition
			end

			local var_358_23 = 0.001

			if var_358_22 <= arg_355_1.time_ and arg_355_1.time_ < var_358_22 + var_358_23 then
				local var_358_24 = (arg_355_1.time_ - var_358_22) / var_358_23
				local var_358_25 = Vector3.New(0, 100, 0)

				var_358_21.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1074ui_story, var_358_25, var_358_24)

				local var_358_26 = manager.ui.mainCamera.transform.position - var_358_21.position

				var_358_21.forward = Vector3.New(var_358_26.x, var_358_26.y, var_358_26.z)

				local var_358_27 = var_358_21.localEulerAngles

				var_358_27.z = 0
				var_358_27.x = 0
				var_358_21.localEulerAngles = var_358_27
			end

			if arg_355_1.time_ >= var_358_22 + var_358_23 and arg_355_1.time_ < var_358_22 + var_358_23 + arg_358_0 then
				var_358_21.localPosition = Vector3.New(0, 100, 0)

				local var_358_28 = manager.ui.mainCamera.transform.position - var_358_21.position

				var_358_21.forward = Vector3.New(var_358_28.x, var_358_28.y, var_358_28.z)

				local var_358_29 = var_358_21.localEulerAngles

				var_358_29.z = 0
				var_358_29.x = 0
				var_358_21.localEulerAngles = var_358_29
			end

			local var_358_30 = 0
			local var_358_31 = 0.825

			if var_358_30 < arg_355_1.time_ and arg_355_1.time_ <= var_358_30 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_32 = arg_355_1:FormatText(StoryNameCfg[379].name)

				arg_355_1.leftNameTxt_.text = var_358_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_33 = arg_355_1:GetWordFromCfg(120421086)
				local var_358_34 = arg_355_1:FormatText(var_358_33.content)

				arg_355_1.text_.text = var_358_34

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_35 = 33
				local var_358_36 = utf8.len(var_358_34)
				local var_358_37 = var_358_35 <= 0 and var_358_31 or var_358_31 * (var_358_36 / var_358_35)

				if var_358_37 > 0 and var_358_31 < var_358_37 then
					arg_355_1.talkMaxDuration = var_358_37

					if var_358_37 + var_358_30 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_37 + var_358_30
					end
				end

				arg_355_1.text_.text = var_358_34
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421086", "story_v_out_120421.awb") ~= 0 then
					local var_358_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421086", "story_v_out_120421.awb") / 1000

					if var_358_38 + var_358_30 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_38 + var_358_30
					end

					if var_358_33.prefab_name ~= "" and arg_355_1.actors_[var_358_33.prefab_name] ~= nil then
						local var_358_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_33.prefab_name].transform, "story_v_out_120421", "120421086", "story_v_out_120421.awb")

						arg_355_1:RecordAudio("120421086", var_358_39)
						arg_355_1:RecordAudio("120421086", var_358_39)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_120421", "120421086", "story_v_out_120421.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_120421", "120421086", "story_v_out_120421.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_40 = math.max(var_358_31, arg_355_1.talkMaxDuration)

			if var_358_30 <= arg_355_1.time_ and arg_355_1.time_ < var_358_30 + var_358_40 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_30) / var_358_40

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_30 + var_358_40 and arg_355_1.time_ < var_358_30 + var_358_40 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play120421087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 120421087
		arg_359_1.duration_ = 13

		local var_359_0 = {
			zh = 9.866,
			ja = 13
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
				arg_359_0:Play120421088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1072ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1072ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, -0.71, -6)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1072ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_362_10 = 0
			local var_362_11 = 1.175

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_12 = arg_359_1:FormatText(StoryNameCfg[379].name)

				arg_359_1.leftNameTxt_.text = var_362_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_13 = arg_359_1:GetWordFromCfg(120421087)
				local var_362_14 = arg_359_1:FormatText(var_362_13.content)

				arg_359_1.text_.text = var_362_14

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_15 = 47
				local var_362_16 = utf8.len(var_362_14)
				local var_362_17 = var_362_15 <= 0 and var_362_11 or var_362_11 * (var_362_16 / var_362_15)

				if var_362_17 > 0 and var_362_11 < var_362_17 then
					arg_359_1.talkMaxDuration = var_362_17

					if var_362_17 + var_362_10 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_17 + var_362_10
					end
				end

				arg_359_1.text_.text = var_362_14
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421087", "story_v_out_120421.awb") ~= 0 then
					local var_362_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421087", "story_v_out_120421.awb") / 1000

					if var_362_18 + var_362_10 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_18 + var_362_10
					end

					if var_362_13.prefab_name ~= "" and arg_359_1.actors_[var_362_13.prefab_name] ~= nil then
						local var_362_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_13.prefab_name].transform, "story_v_out_120421", "120421087", "story_v_out_120421.awb")

						arg_359_1:RecordAudio("120421087", var_362_19)
						arg_359_1:RecordAudio("120421087", var_362_19)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_120421", "120421087", "story_v_out_120421.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_120421", "120421087", "story_v_out_120421.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_20 = math.max(var_362_11, arg_359_1.talkMaxDuration)

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_20 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_10) / var_362_20

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_10 + var_362_20 and arg_359_1.time_ < var_362_10 + var_362_20 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play120421088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 120421088
		arg_363_1.duration_ = 2

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play120421089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1074ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1074ui_story == nil then
				arg_363_1.var_.characterEffect1074ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1074ui_story and not isNil(var_366_0) then
					arg_363_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1074ui_story then
				arg_363_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_366_4 = 0

			if var_366_4 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_366_5 = arg_363_1.actors_["1074ui_story"].transform
			local var_366_6 = 0

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.var_.moveOldPos1074ui_story = var_366_5.localPosition
			end

			local var_366_7 = 0.001

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_7 then
				local var_366_8 = (arg_363_1.time_ - var_366_6) / var_366_7
				local var_366_9 = Vector3.New(0, -1.055, -6.12)

				var_366_5.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1074ui_story, var_366_9, var_366_8)

				local var_366_10 = manager.ui.mainCamera.transform.position - var_366_5.position

				var_366_5.forward = Vector3.New(var_366_10.x, var_366_10.y, var_366_10.z)

				local var_366_11 = var_366_5.localEulerAngles

				var_366_11.z = 0
				var_366_11.x = 0
				var_366_5.localEulerAngles = var_366_11
			end

			if arg_363_1.time_ >= var_366_6 + var_366_7 and arg_363_1.time_ < var_366_6 + var_366_7 + arg_366_0 then
				var_366_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_366_12 = manager.ui.mainCamera.transform.position - var_366_5.position

				var_366_5.forward = Vector3.New(var_366_12.x, var_366_12.y, var_366_12.z)

				local var_366_13 = var_366_5.localEulerAngles

				var_366_13.z = 0
				var_366_13.x = 0
				var_366_5.localEulerAngles = var_366_13
			end

			local var_366_14 = arg_363_1.actors_["1072ui_story"].transform
			local var_366_15 = 0

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.var_.moveOldPos1072ui_story = var_366_14.localPosition
			end

			local var_366_16 = 0.001

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_16 then
				local var_366_17 = (arg_363_1.time_ - var_366_15) / var_366_16
				local var_366_18 = Vector3.New(0, 100, 0)

				var_366_14.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1072ui_story, var_366_18, var_366_17)

				local var_366_19 = manager.ui.mainCamera.transform.position - var_366_14.position

				var_366_14.forward = Vector3.New(var_366_19.x, var_366_19.y, var_366_19.z)

				local var_366_20 = var_366_14.localEulerAngles

				var_366_20.z = 0
				var_366_20.x = 0
				var_366_14.localEulerAngles = var_366_20
			end

			if arg_363_1.time_ >= var_366_15 + var_366_16 and arg_363_1.time_ < var_366_15 + var_366_16 + arg_366_0 then
				var_366_14.localPosition = Vector3.New(0, 100, 0)

				local var_366_21 = manager.ui.mainCamera.transform.position - var_366_14.position

				var_366_14.forward = Vector3.New(var_366_21.x, var_366_21.y, var_366_21.z)

				local var_366_22 = var_366_14.localEulerAngles

				var_366_22.z = 0
				var_366_22.x = 0
				var_366_14.localEulerAngles = var_366_22
			end

			local var_366_23 = arg_363_1.actors_["1072ui_story"]
			local var_366_24 = 0

			if var_366_24 < arg_363_1.time_ and arg_363_1.time_ <= var_366_24 + arg_366_0 then
				if arg_363_1.var_.characterEffect1072ui_story == nil then
					arg_363_1.var_.characterEffect1072ui_story = var_366_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_366_25 = arg_363_1.var_.characterEffect1072ui_story

				var_366_25.imageEffect:turnOff()

				var_366_25.interferenceEffect.enabled = false
				var_366_25.interferenceEffect.noise = 0.001
				var_366_25.interferenceEffect.simTimeScale = 1
				var_366_25.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_366_26 = 0
			local var_366_27 = 0.15

			if var_366_26 < arg_363_1.time_ and arg_363_1.time_ <= var_366_26 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_28 = arg_363_1:FormatText(StoryNameCfg[410].name)

				arg_363_1.leftNameTxt_.text = var_366_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_29 = arg_363_1:GetWordFromCfg(120421088)
				local var_366_30 = arg_363_1:FormatText(var_366_29.content)

				arg_363_1.text_.text = var_366_30

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_31 = 6
				local var_366_32 = utf8.len(var_366_30)
				local var_366_33 = var_366_31 <= 0 and var_366_27 or var_366_27 * (var_366_32 / var_366_31)

				if var_366_33 > 0 and var_366_27 < var_366_33 then
					arg_363_1.talkMaxDuration = var_366_33

					if var_366_33 + var_366_26 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_33 + var_366_26
					end
				end

				arg_363_1.text_.text = var_366_30
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421088", "story_v_out_120421.awb") ~= 0 then
					local var_366_34 = manager.audio:GetVoiceLength("story_v_out_120421", "120421088", "story_v_out_120421.awb") / 1000

					if var_366_34 + var_366_26 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_34 + var_366_26
					end

					if var_366_29.prefab_name ~= "" and arg_363_1.actors_[var_366_29.prefab_name] ~= nil then
						local var_366_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_29.prefab_name].transform, "story_v_out_120421", "120421088", "story_v_out_120421.awb")

						arg_363_1:RecordAudio("120421088", var_366_35)
						arg_363_1:RecordAudio("120421088", var_366_35)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_120421", "120421088", "story_v_out_120421.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_120421", "120421088", "story_v_out_120421.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_36 = math.max(var_366_27, arg_363_1.talkMaxDuration)

			if var_366_26 <= arg_363_1.time_ and arg_363_1.time_ < var_366_26 + var_366_36 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_26) / var_366_36

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_26 + var_366_36 and arg_363_1.time_ < var_366_26 + var_366_36 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play120421089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 120421089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play120421090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1074ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos1074ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0, 100, 0)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1074ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, 100, 0)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = 0
			local var_370_10 = 0.75

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_11 = arg_367_1:GetWordFromCfg(120421089)
				local var_370_12 = arg_367_1:FormatText(var_370_11.content)

				arg_367_1.text_.text = var_370_12

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 30
				local var_370_14 = utf8.len(var_370_12)
				local var_370_15 = var_370_13 <= 0 and var_370_10 or var_370_10 * (var_370_14 / var_370_13)

				if var_370_15 > 0 and var_370_10 < var_370_15 then
					arg_367_1.talkMaxDuration = var_370_15

					if var_370_15 + var_370_9 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_15 + var_370_9
					end
				end

				arg_367_1.text_.text = var_370_12
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_10, arg_367_1.talkMaxDuration)

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_9) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_9 + var_370_16 and arg_367_1.time_ < var_370_9 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play120421090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 120421090
		arg_371_1.duration_ = 9

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play120421091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 2

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				local var_374_1 = manager.ui.mainCamera.transform.localPosition
				local var_374_2 = Vector3.New(0, 0, 10) + Vector3.New(var_374_1.x, var_374_1.y, 0)
				local var_374_3 = arg_371_1.bgs_.ST29

				var_374_3.transform.localPosition = var_374_2
				var_374_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_4 = var_374_3:GetComponent("SpriteRenderer")

				if var_374_4 and var_374_4.sprite then
					local var_374_5 = (var_374_3.transform.localPosition - var_374_1).z
					local var_374_6 = manager.ui.mainCameraCom_
					local var_374_7 = 2 * var_374_5 * Mathf.Tan(var_374_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_374_8 = var_374_7 * var_374_6.aspect
					local var_374_9 = var_374_4.sprite.bounds.size.x
					local var_374_10 = var_374_4.sprite.bounds.size.y
					local var_374_11 = var_374_8 / var_374_9
					local var_374_12 = var_374_7 / var_374_10
					local var_374_13 = var_374_12 < var_374_11 and var_374_11 or var_374_12

					var_374_3.transform.localScale = Vector3.New(var_374_13, var_374_13, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "ST29" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_15 = 2

			if var_374_14 <= arg_371_1.time_ and arg_371_1.time_ < var_374_14 + var_374_15 then
				local var_374_16 = (arg_371_1.time_ - var_374_14) / var_374_15
				local var_374_17 = Color.New(0, 0, 0)

				var_374_17.a = Mathf.Lerp(0, 1, var_374_16)
				arg_371_1.mask_.color = var_374_17
			end

			if arg_371_1.time_ >= var_374_14 + var_374_15 and arg_371_1.time_ < var_374_14 + var_374_15 + arg_374_0 then
				local var_374_18 = Color.New(0, 0, 0)

				var_374_18.a = 1
				arg_371_1.mask_.color = var_374_18
			end

			local var_374_19 = 2

			if var_374_19 < arg_371_1.time_ and arg_371_1.time_ <= var_374_19 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_20 = 2

			if var_374_19 <= arg_371_1.time_ and arg_371_1.time_ < var_374_19 + var_374_20 then
				local var_374_21 = (arg_371_1.time_ - var_374_19) / var_374_20
				local var_374_22 = Color.New(0, 0, 0)

				var_374_22.a = Mathf.Lerp(1, 0, var_374_21)
				arg_371_1.mask_.color = var_374_22
			end

			if arg_371_1.time_ >= var_374_19 + var_374_20 and arg_371_1.time_ < var_374_19 + var_374_20 + arg_374_0 then
				local var_374_23 = Color.New(0, 0, 0)
				local var_374_24 = 0

				arg_371_1.mask_.enabled = false
				var_374_23.a = var_374_24
				arg_371_1.mask_.color = var_374_23
			end

			local var_374_25 = 0
			local var_374_26 = 0.533333333333333

			if var_374_25 < arg_371_1.time_ and arg_371_1.time_ <= var_374_25 + arg_374_0 then
				local var_374_27 = "play"
				local var_374_28 = "music"

				arg_371_1:AudioAction(var_374_27, var_374_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_374_29 = ""
				local var_374_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_374_30 ~= "" then
					if arg_371_1.bgmTxt_.text ~= var_374_30 and arg_371_1.bgmTxt_.text ~= "" then
						if arg_371_1.bgmTxt2_.text ~= "" then
							arg_371_1.bgmTxt_.text = arg_371_1.bgmTxt2_.text
						end

						arg_371_1.bgmTxt2_.text = var_374_30

						arg_371_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_371_1.bgmTxt_.text = var_374_30
						arg_371_1.bgmTxt2_.text = var_374_30
					end

					if arg_371_1.bgmTimer then
						arg_371_1.bgmTimer:Stop()

						arg_371_1.bgmTimer = nil
					end

					if arg_371_1.settingData.show_music_name == 1 then
						arg_371_1.musicController:SetSelectedState("show")
						arg_371_1.musicAnimator_:Play("open", 0, 0)

						if arg_371_1.settingData.music_time ~= 0 then
							arg_371_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_371_1.settingData.music_time), function()
								if arg_371_1 == nil or isNil(arg_371_1.bgmTxt_) then
									return
								end

								arg_371_1.musicController:SetSelectedState("hide")
								arg_371_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_31 = 4
			local var_374_32 = 1.15

			if var_374_31 < arg_371_1.time_ and arg_371_1.time_ <= var_374_31 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_33 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_33:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_371_1.dialogCg_.alpha = arg_376_0
				end))
				var_374_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_34 = arg_371_1:GetWordFromCfg(120421090)
				local var_374_35 = arg_371_1:FormatText(var_374_34.content)

				arg_371_1.text_.text = var_374_35

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_36 = 46
				local var_374_37 = utf8.len(var_374_35)
				local var_374_38 = var_374_36 <= 0 and var_374_32 or var_374_32 * (var_374_37 / var_374_36)

				if var_374_38 > 0 and var_374_32 < var_374_38 then
					arg_371_1.talkMaxDuration = var_374_38
					var_374_31 = var_374_31 + 0.3

					if var_374_38 + var_374_31 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_38 + var_374_31
					end
				end

				arg_371_1.text_.text = var_374_35
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_39 = var_374_31 + 0.3
			local var_374_40 = math.max(var_374_32, arg_371_1.talkMaxDuration)

			if var_374_39 <= arg_371_1.time_ and arg_371_1.time_ < var_374_39 + var_374_40 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_39) / var_374_40

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_39 + var_374_40 and arg_371_1.time_ < var_374_39 + var_374_40 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play120421091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 120421091
		arg_378_1.duration_ = 3.63

		local var_378_0 = {
			zh = 2.366,
			ja = 3.633
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
				arg_378_0:Play120421092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1074ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1074ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(0, -1.055, -6.12)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1074ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = arg_378_1.actors_["1074ui_story"]
			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1074ui_story == nil then
				arg_378_1.var_.characterEffect1074ui_story = var_381_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_11 = 0.2

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_11 and not isNil(var_381_9) then
				local var_381_12 = (arg_378_1.time_ - var_381_10) / var_381_11

				if arg_378_1.var_.characterEffect1074ui_story and not isNil(var_381_9) then
					arg_378_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_10 + var_381_11 and arg_378_1.time_ < var_381_10 + var_381_11 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1074ui_story then
				arg_378_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_381_13 = 0

			if var_381_13 < arg_378_1.time_ and arg_378_1.time_ <= var_381_13 + arg_381_0 then
				arg_378_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_381_14 = 0

			if var_381_14 < arg_378_1.time_ and arg_378_1.time_ <= var_381_14 + arg_381_0 then
				arg_378_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_381_15 = 0
			local var_381_16 = 0.175

			if var_381_15 < arg_378_1.time_ and arg_378_1.time_ <= var_381_15 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_17 = arg_378_1:FormatText(StoryNameCfg[410].name)

				arg_378_1.leftNameTxt_.text = var_381_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_18 = arg_378_1:GetWordFromCfg(120421091)
				local var_381_19 = arg_378_1:FormatText(var_381_18.content)

				arg_378_1.text_.text = var_381_19

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_20 = 7
				local var_381_21 = utf8.len(var_381_19)
				local var_381_22 = var_381_20 <= 0 and var_381_16 or var_381_16 * (var_381_21 / var_381_20)

				if var_381_22 > 0 and var_381_16 < var_381_22 then
					arg_378_1.talkMaxDuration = var_381_22

					if var_381_22 + var_381_15 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_22 + var_381_15
					end
				end

				arg_378_1.text_.text = var_381_19
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421091", "story_v_out_120421.awb") ~= 0 then
					local var_381_23 = manager.audio:GetVoiceLength("story_v_out_120421", "120421091", "story_v_out_120421.awb") / 1000

					if var_381_23 + var_381_15 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_23 + var_381_15
					end

					if var_381_18.prefab_name ~= "" and arg_378_1.actors_[var_381_18.prefab_name] ~= nil then
						local var_381_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_18.prefab_name].transform, "story_v_out_120421", "120421091", "story_v_out_120421.awb")

						arg_378_1:RecordAudio("120421091", var_381_24)
						arg_378_1:RecordAudio("120421091", var_381_24)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_120421", "120421091", "story_v_out_120421.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_120421", "120421091", "story_v_out_120421.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_25 = math.max(var_381_16, arg_378_1.talkMaxDuration)

			if var_381_15 <= arg_378_1.time_ and arg_378_1.time_ < var_381_15 + var_381_25 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_15) / var_381_25

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_15 + var_381_25 and arg_378_1.time_ < var_381_15 + var_381_25 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play120421092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 120421092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play120421093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1074ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos1074ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(0, 100, 0)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1074ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(0, 100, 0)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = 0
			local var_385_10 = 1.2

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_11 = arg_382_1:GetWordFromCfg(120421092)
				local var_385_12 = arg_382_1:FormatText(var_385_11.content)

				arg_382_1.text_.text = var_385_12

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_13 = 48
				local var_385_14 = utf8.len(var_385_12)
				local var_385_15 = var_385_13 <= 0 and var_385_10 or var_385_10 * (var_385_14 / var_385_13)

				if var_385_15 > 0 and var_385_10 < var_385_15 then
					arg_382_1.talkMaxDuration = var_385_15

					if var_385_15 + var_385_9 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_15 + var_385_9
					end
				end

				arg_382_1.text_.text = var_385_12
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_10, arg_382_1.talkMaxDuration)

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_9) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_9 + var_385_16 and arg_382_1.time_ < var_385_9 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play120421093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 120421093
		arg_386_1.duration_ = 2

		local var_386_0 = {
			zh = 2,
			ja = 0.999999999999
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
				arg_386_0:Play120421094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.075

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[410].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:GetWordFromCfg(120421093)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 3
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421093", "story_v_out_120421.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421093", "story_v_out_120421.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_out_120421", "120421093", "story_v_out_120421.awb")

						arg_386_1:RecordAudio("120421093", var_389_9)
						arg_386_1:RecordAudio("120421093", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_120421", "120421093", "story_v_out_120421.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_120421", "120421093", "story_v_out_120421.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_10 and arg_386_1.time_ < var_389_0 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play120421094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 120421094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play120421095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 1.2

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(120421094)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 48
				local var_393_5 = utf8.len(var_393_3)
				local var_393_6 = var_393_4 <= 0 and var_393_1 or var_393_1 * (var_393_5 / var_393_4)

				if var_393_6 > 0 and var_393_1 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_7 and arg_390_1.time_ < var_393_0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play120421095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 120421095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play120421096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.525

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

				local var_397_2 = arg_394_1:GetWordFromCfg(120421095)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 21
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
	Play120421096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 120421096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play120421097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				local var_401_1 = manager.ui.mainCamera.transform.localPosition
				local var_401_2 = Vector3.New(0, 0, 10) + Vector3.New(var_401_1.x, var_401_1.y, 0)
				local var_401_3 = arg_398_1.bgs_.ST37

				var_401_3.transform.localPosition = var_401_2
				var_401_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_401_4 = var_401_3:GetComponent("SpriteRenderer")

				if var_401_4 and var_401_4.sprite then
					local var_401_5 = (var_401_3.transform.localPosition - var_401_1).z
					local var_401_6 = manager.ui.mainCameraCom_
					local var_401_7 = 2 * var_401_5 * Mathf.Tan(var_401_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_401_8 = var_401_7 * var_401_6.aspect
					local var_401_9 = var_401_4.sprite.bounds.size.x
					local var_401_10 = var_401_4.sprite.bounds.size.y
					local var_401_11 = var_401_8 / var_401_9
					local var_401_12 = var_401_7 / var_401_10
					local var_401_13 = var_401_12 < var_401_11 and var_401_11 or var_401_12

					var_401_3.transform.localScale = Vector3.New(var_401_13, var_401_13, 0)
				end

				for iter_401_0, iter_401_1 in pairs(arg_398_1.bgs_) do
					if iter_401_0 ~= "ST37" then
						iter_401_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1.mask_.enabled = true
				arg_398_1.mask_.raycastTarget = true

				arg_398_1:SetGaussion(false)
			end

			local var_401_15 = 2

			if var_401_14 <= arg_398_1.time_ and arg_398_1.time_ < var_401_14 + var_401_15 then
				local var_401_16 = (arg_398_1.time_ - var_401_14) / var_401_15
				local var_401_17 = Color.New(1, 1, 1)

				var_401_17.a = Mathf.Lerp(1, 0, var_401_16)
				arg_398_1.mask_.color = var_401_17
			end

			if arg_398_1.time_ >= var_401_14 + var_401_15 and arg_398_1.time_ < var_401_14 + var_401_15 + arg_401_0 then
				local var_401_18 = Color.New(1, 1, 1)
				local var_401_19 = 0

				arg_398_1.mask_.enabled = false
				var_401_18.a = var_401_19
				arg_398_1.mask_.color = var_401_18
			end

			local var_401_20 = 0
			local var_401_21 = 1

			if var_401_20 < arg_398_1.time_ and arg_398_1.time_ <= var_401_20 + arg_401_0 then
				local var_401_22 = "play"
				local var_401_23 = "effect"

				arg_398_1:AudioAction(var_401_22, var_401_23, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_401_24 = 0
			local var_401_25 = 0.05

			if var_401_24 < arg_398_1.time_ and arg_398_1.time_ <= var_401_24 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_26 = arg_398_1:GetWordFromCfg(120421096)
				local var_401_27 = arg_398_1:FormatText(var_401_26.content)

				arg_398_1.text_.text = var_401_27

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_28 = 2
				local var_401_29 = utf8.len(var_401_27)
				local var_401_30 = var_401_28 <= 0 and var_401_25 or var_401_25 * (var_401_29 / var_401_28)

				if var_401_30 > 0 and var_401_25 < var_401_30 then
					arg_398_1.talkMaxDuration = var_401_30

					if var_401_30 + var_401_24 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_30 + var_401_24
					end
				end

				arg_398_1.text_.text = var_401_27
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_31 = math.max(var_401_25, arg_398_1.talkMaxDuration)

			if var_401_24 <= arg_398_1.time_ and arg_398_1.time_ < var_401_24 + var_401_31 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_24) / var_401_31

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_24 + var_401_31 and arg_398_1.time_ < var_401_24 + var_401_31 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play120421097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 120421097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play120421098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 1.075

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_2 = arg_402_1:GetWordFromCfg(120421097)
				local var_405_3 = arg_402_1:FormatText(var_405_2.content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 43
				local var_405_5 = utf8.len(var_405_3)
				local var_405_6 = var_405_4 <= 0 and var_405_1 or var_405_1 * (var_405_5 / var_405_4)

				if var_405_6 > 0 and var_405_1 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_7 and arg_402_1.time_ < var_405_0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play120421098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 120421098
		arg_406_1.duration_ = 4.47

		local var_406_0 = {
			zh = 4.466,
			ja = 3.566
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
				arg_406_0:Play120421099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1074ui_story"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1074ui_story = var_409_0.localPosition
			end

			local var_409_2 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2
				local var_409_4 = Vector3.New(0, -1.055, -6.12)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1074ui_story, var_409_4, var_409_3)

				local var_409_5 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_5.x, var_409_5.y, var_409_5.z)

				local var_409_6 = var_409_0.localEulerAngles

				var_409_6.z = 0
				var_409_6.x = 0
				var_409_0.localEulerAngles = var_409_6
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_409_7 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_7.x, var_409_7.y, var_409_7.z)

				local var_409_8 = var_409_0.localEulerAngles

				var_409_8.z = 0
				var_409_8.x = 0
				var_409_0.localEulerAngles = var_409_8
			end

			local var_409_9 = 0

			if var_409_9 < arg_406_1.time_ and arg_406_1.time_ <= var_409_9 + arg_409_0 then
				arg_406_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_409_10 = 0

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 then
				arg_406_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_409_11 = arg_406_1.actors_["1074ui_story"]
			local var_409_12 = 0

			if var_409_12 < arg_406_1.time_ and arg_406_1.time_ <= var_409_12 + arg_409_0 and not isNil(var_409_11) and arg_406_1.var_.characterEffect1074ui_story == nil then
				arg_406_1.var_.characterEffect1074ui_story = var_409_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_13 = 0.2

			if var_409_12 <= arg_406_1.time_ and arg_406_1.time_ < var_409_12 + var_409_13 and not isNil(var_409_11) then
				local var_409_14 = (arg_406_1.time_ - var_409_12) / var_409_13

				if arg_406_1.var_.characterEffect1074ui_story and not isNil(var_409_11) then
					arg_406_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_12 + var_409_13 and arg_406_1.time_ < var_409_12 + var_409_13 + arg_409_0 and not isNil(var_409_11) and arg_406_1.var_.characterEffect1074ui_story then
				arg_406_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_409_15 = 0
			local var_409_16 = 0.1

			if var_409_15 < arg_406_1.time_ and arg_406_1.time_ <= var_409_15 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_17 = arg_406_1:FormatText(StoryNameCfg[400].name)

				arg_406_1.leftNameTxt_.text = var_409_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_18 = arg_406_1:GetWordFromCfg(120421098)
				local var_409_19 = arg_406_1:FormatText(var_409_18.content)

				arg_406_1.text_.text = var_409_19

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421098", "story_v_out_120421.awb") ~= 0 then
					local var_409_23 = manager.audio:GetVoiceLength("story_v_out_120421", "120421098", "story_v_out_120421.awb") / 1000

					if var_409_23 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_15
					end

					if var_409_18.prefab_name ~= "" and arg_406_1.actors_[var_409_18.prefab_name] ~= nil then
						local var_409_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_18.prefab_name].transform, "story_v_out_120421", "120421098", "story_v_out_120421.awb")

						arg_406_1:RecordAudio("120421098", var_409_24)
						arg_406_1:RecordAudio("120421098", var_409_24)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_120421", "120421098", "story_v_out_120421.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_120421", "120421098", "story_v_out_120421.awb")
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
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play120421099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 120421099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play120421100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1074ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1074ui_story == nil then
				arg_410_1.var_.characterEffect1074ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.2

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1074ui_story and not isNil(var_413_0) then
					local var_413_4 = Mathf.Lerp(0, 0.5, var_413_3)

					arg_410_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1074ui_story.fillRatio = var_413_4
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1074ui_story then
				local var_413_5 = 0.5

				arg_410_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1074ui_story.fillRatio = var_413_5
			end

			local var_413_6 = 0
			local var_413_7 = 0.725

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_8 = arg_410_1:GetWordFromCfg(120421099)
				local var_413_9 = arg_410_1:FormatText(var_413_8.content)

				arg_410_1.text_.text = var_413_9

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_10 = 29
				local var_413_11 = utf8.len(var_413_9)
				local var_413_12 = var_413_10 <= 0 and var_413_7 or var_413_7 * (var_413_11 / var_413_10)

				if var_413_12 > 0 and var_413_7 < var_413_12 then
					arg_410_1.talkMaxDuration = var_413_12

					if var_413_12 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_12 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_9
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_13 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_13 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_13

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_13 and arg_410_1.time_ < var_413_6 + var_413_13 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play120421100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 120421100
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play120421101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 1

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				local var_417_2 = "play"
				local var_417_3 = "music"

				arg_414_1:AudioAction(var_417_2, var_417_3, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_417_4 = ""
				local var_417_5 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_417_5 ~= "" then
					if arg_414_1.bgmTxt_.text ~= var_417_5 and arg_414_1.bgmTxt_.text ~= "" then
						if arg_414_1.bgmTxt2_.text ~= "" then
							arg_414_1.bgmTxt_.text = arg_414_1.bgmTxt2_.text
						end

						arg_414_1.bgmTxt2_.text = var_417_5

						arg_414_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_414_1.bgmTxt_.text = var_417_5
						arg_414_1.bgmTxt2_.text = var_417_5
					end

					if arg_414_1.bgmTimer then
						arg_414_1.bgmTimer:Stop()

						arg_414_1.bgmTimer = nil
					end

					if arg_414_1.settingData.show_music_name == 1 then
						arg_414_1.musicController:SetSelectedState("show")
						arg_414_1.musicAnimator_:Play("open", 0, 0)

						if arg_414_1.settingData.music_time ~= 0 then
							arg_414_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_414_1.settingData.music_time), function()
								if arg_414_1 == nil or isNil(arg_414_1.bgmTxt_) then
									return
								end

								arg_414_1.musicController:SetSelectedState("hide")
								arg_414_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_417_6 = 0
			local var_417_7 = 1.55

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_8 = arg_414_1:GetWordFromCfg(120421100)
				local var_417_9 = arg_414_1:FormatText(var_417_8.content)

				arg_414_1.text_.text = var_417_9

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_10 = 62
				local var_417_11 = utf8.len(var_417_9)
				local var_417_12 = var_417_10 <= 0 and var_417_7 or var_417_7 * (var_417_11 / var_417_10)

				if var_417_12 > 0 and var_417_7 < var_417_12 then
					arg_414_1.talkMaxDuration = var_417_12

					if var_417_12 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_12 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_9
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_13 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_13 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_13

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_13 and arg_414_1.time_ < var_417_6 + var_417_13 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play120421101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 120421101
		arg_419_1.duration_ = 2.53

		local var_419_0 = {
			zh = 2.399999999999,
			ja = 2.533
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play120421102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1074ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1074ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1074ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = "10044ui_story"

			if arg_419_1.actors_[var_422_9] == nil then
				local var_422_10 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_422_10) then
					local var_422_11 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_419_1.stage_.transform)

					var_422_11.name = var_422_9
					var_422_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_419_1.actors_[var_422_9] = var_422_11

					local var_422_12 = var_422_11:GetComponentInChildren(typeof(CharacterEffect))

					var_422_12.enabled = true

					local var_422_13 = GameObjectTools.GetOrAddComponent(var_422_11, typeof(DynamicBoneHelper))

					if var_422_13 then
						var_422_13:EnableDynamicBone(false)
					end

					arg_419_1:ShowWeapon(var_422_12.transform, false)

					arg_419_1.var_[var_422_9 .. "Animator"] = var_422_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_419_1.var_[var_422_9 .. "Animator"].applyRootMotion = true
					arg_419_1.var_[var_422_9 .. "LipSync"] = var_422_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_422_14 = arg_419_1.actors_["10044ui_story"].transform
			local var_422_15 = 0

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				arg_419_1.var_.moveOldPos10044ui_story = var_422_14.localPosition
			end

			local var_422_16 = 0.001

			if var_422_15 <= arg_419_1.time_ and arg_419_1.time_ < var_422_15 + var_422_16 then
				local var_422_17 = (arg_419_1.time_ - var_422_15) / var_422_16
				local var_422_18 = Vector3.New(0.7, -0.72, -6.3)

				var_422_14.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10044ui_story, var_422_18, var_422_17)

				local var_422_19 = manager.ui.mainCamera.transform.position - var_422_14.position

				var_422_14.forward = Vector3.New(var_422_19.x, var_422_19.y, var_422_19.z)

				local var_422_20 = var_422_14.localEulerAngles

				var_422_20.z = 0
				var_422_20.x = 0
				var_422_14.localEulerAngles = var_422_20
			end

			if arg_419_1.time_ >= var_422_15 + var_422_16 and arg_419_1.time_ < var_422_15 + var_422_16 + arg_422_0 then
				var_422_14.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_422_21 = manager.ui.mainCamera.transform.position - var_422_14.position

				var_422_14.forward = Vector3.New(var_422_21.x, var_422_21.y, var_422_21.z)

				local var_422_22 = var_422_14.localEulerAngles

				var_422_22.z = 0
				var_422_22.x = 0
				var_422_14.localEulerAngles = var_422_22
			end

			local var_422_23 = 0

			if var_422_23 < arg_419_1.time_ and arg_419_1.time_ <= var_422_23 + arg_422_0 then
				arg_419_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_422_24 = 0

			if var_422_24 < arg_419_1.time_ and arg_419_1.time_ <= var_422_24 + arg_422_0 then
				arg_419_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_422_25 = arg_419_1.actors_["10044ui_story"]
			local var_422_26 = 0

			if var_422_26 < arg_419_1.time_ and arg_419_1.time_ <= var_422_26 + arg_422_0 and not isNil(var_422_25) and arg_419_1.var_.characterEffect10044ui_story == nil then
				arg_419_1.var_.characterEffect10044ui_story = var_422_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_27 = 0.2

			if var_422_26 <= arg_419_1.time_ and arg_419_1.time_ < var_422_26 + var_422_27 and not isNil(var_422_25) then
				local var_422_28 = (arg_419_1.time_ - var_422_26) / var_422_27

				if arg_419_1.var_.characterEffect10044ui_story and not isNil(var_422_25) then
					arg_419_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_26 + var_422_27 and arg_419_1.time_ < var_422_26 + var_422_27 + arg_422_0 and not isNil(var_422_25) and arg_419_1.var_.characterEffect10044ui_story then
				arg_419_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_422_29 = 0
			local var_422_30 = 0.05

			if var_422_29 < arg_419_1.time_ and arg_419_1.time_ <= var_422_29 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_31 = arg_419_1:FormatText(StoryNameCfg[380].name)

				arg_419_1.leftNameTxt_.text = var_422_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_32 = arg_419_1:GetWordFromCfg(120421101)
				local var_422_33 = arg_419_1:FormatText(var_422_32.content)

				arg_419_1.text_.text = var_422_33

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_34 = 2
				local var_422_35 = utf8.len(var_422_33)
				local var_422_36 = var_422_34 <= 0 and var_422_30 or var_422_30 * (var_422_35 / var_422_34)

				if var_422_36 > 0 and var_422_30 < var_422_36 then
					arg_419_1.talkMaxDuration = var_422_36

					if var_422_36 + var_422_29 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_36 + var_422_29
					end
				end

				arg_419_1.text_.text = var_422_33
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421101", "story_v_out_120421.awb") ~= 0 then
					local var_422_37 = manager.audio:GetVoiceLength("story_v_out_120421", "120421101", "story_v_out_120421.awb") / 1000

					if var_422_37 + var_422_29 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_37 + var_422_29
					end

					if var_422_32.prefab_name ~= "" and arg_419_1.actors_[var_422_32.prefab_name] ~= nil then
						local var_422_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_32.prefab_name].transform, "story_v_out_120421", "120421101", "story_v_out_120421.awb")

						arg_419_1:RecordAudio("120421101", var_422_38)
						arg_419_1:RecordAudio("120421101", var_422_38)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_120421", "120421101", "story_v_out_120421.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_120421", "120421101", "story_v_out_120421.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_39 = math.max(var_422_30, arg_419_1.talkMaxDuration)

			if var_422_29 <= arg_419_1.time_ and arg_419_1.time_ < var_422_29 + var_422_39 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_29) / var_422_39

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_29 + var_422_39 and arg_419_1.time_ < var_422_29 + var_422_39 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play120421102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 120421102
		arg_423_1.duration_ = 12.3

		local var_423_0 = {
			zh = 5.4,
			ja = 12.3
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
				arg_423_0:Play120421103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["10044ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10044ui_story == nil then
				arg_423_1.var_.characterEffect10044ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect10044ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_423_1.var_.characterEffect10044ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10044ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_423_1.var_.characterEffect10044ui_story.fillRatio = var_426_5
			end

			local var_426_6 = arg_423_1.actors_["1074ui_story"]
			local var_426_7 = 0

			if var_426_7 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect1074ui_story == nil then
				arg_423_1.var_.characterEffect1074ui_story = var_426_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_8 = 0.2

			if var_426_7 <= arg_423_1.time_ and arg_423_1.time_ < var_426_7 + var_426_8 and not isNil(var_426_6) then
				local var_426_9 = (arg_423_1.time_ - var_426_7) / var_426_8

				if arg_423_1.var_.characterEffect1074ui_story and not isNil(var_426_6) then
					arg_423_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_7 + var_426_8 and arg_423_1.time_ < var_426_7 + var_426_8 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect1074ui_story then
				arg_423_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 then
				arg_423_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_426_11 = 0
			local var_426_12 = 0.4

			if var_426_11 < arg_423_1.time_ and arg_423_1.time_ <= var_426_11 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_13 = arg_423_1:FormatText(StoryNameCfg[410].name)

				arg_423_1.leftNameTxt_.text = var_426_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_14 = arg_423_1:GetWordFromCfg(120421102)
				local var_426_15 = arg_423_1:FormatText(var_426_14.content)

				arg_423_1.text_.text = var_426_15

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_16 = 16
				local var_426_17 = utf8.len(var_426_15)
				local var_426_18 = var_426_16 <= 0 and var_426_12 or var_426_12 * (var_426_17 / var_426_16)

				if var_426_18 > 0 and var_426_12 < var_426_18 then
					arg_423_1.talkMaxDuration = var_426_18

					if var_426_18 + var_426_11 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_18 + var_426_11
					end
				end

				arg_423_1.text_.text = var_426_15
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421102", "story_v_out_120421.awb") ~= 0 then
					local var_426_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421102", "story_v_out_120421.awb") / 1000

					if var_426_19 + var_426_11 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_19 + var_426_11
					end

					if var_426_14.prefab_name ~= "" and arg_423_1.actors_[var_426_14.prefab_name] ~= nil then
						local var_426_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_14.prefab_name].transform, "story_v_out_120421", "120421102", "story_v_out_120421.awb")

						arg_423_1:RecordAudio("120421102", var_426_20)
						arg_423_1:RecordAudio("120421102", var_426_20)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_120421", "120421102", "story_v_out_120421.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_120421", "120421102", "story_v_out_120421.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_21 = math.max(var_426_12, arg_423_1.talkMaxDuration)

			if var_426_11 <= arg_423_1.time_ and arg_423_1.time_ < var_426_11 + var_426_21 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_11) / var_426_21

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_11 + var_426_21 and arg_423_1.time_ < var_426_11 + var_426_21 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play120421103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 120421103
		arg_427_1.duration_ = 7.93

		local var_427_0 = {
			zh = 4.233,
			ja = 7.933
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play120421104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10044ui_story"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos10044ui_story = var_430_0.localPosition
			end

			local var_430_2 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2
				local var_430_4 = Vector3.New(0, 100, 0)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10044ui_story, var_430_4, var_430_3)

				local var_430_5 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_5.x, var_430_5.y, var_430_5.z)

				local var_430_6 = var_430_0.localEulerAngles

				var_430_6.z = 0
				var_430_6.x = 0
				var_430_0.localEulerAngles = var_430_6
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(0, 100, 0)

				local var_430_7 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_7.x, var_430_7.y, var_430_7.z)

				local var_430_8 = var_430_0.localEulerAngles

				var_430_8.z = 0
				var_430_8.x = 0
				var_430_0.localEulerAngles = var_430_8
			end

			local var_430_9 = arg_427_1.actors_["1074ui_story"]
			local var_430_10 = 0

			if var_430_10 < arg_427_1.time_ and arg_427_1.time_ <= var_430_10 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1074ui_story == nil then
				arg_427_1.var_.characterEffect1074ui_story = var_430_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.2

			if var_430_10 <= arg_427_1.time_ and arg_427_1.time_ < var_430_10 + var_430_11 and not isNil(var_430_9) then
				local var_430_12 = (arg_427_1.time_ - var_430_10) / var_430_11

				if arg_427_1.var_.characterEffect1074ui_story and not isNil(var_430_9) then
					local var_430_13 = Mathf.Lerp(0, 0.5, var_430_12)

					arg_427_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1074ui_story.fillRatio = var_430_13
				end
			end

			if arg_427_1.time_ >= var_430_10 + var_430_11 and arg_427_1.time_ < var_430_10 + var_430_11 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1074ui_story then
				local var_430_14 = 0.5

				arg_427_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1074ui_story.fillRatio = var_430_14
			end

			local var_430_15 = 0

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 then
				arg_427_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_430_16 = arg_427_1.actors_["1075ui_story"].transform
			local var_430_17 = 0

			if var_430_17 < arg_427_1.time_ and arg_427_1.time_ <= var_430_17 + arg_430_0 then
				arg_427_1.var_.moveOldPos1075ui_story = var_430_16.localPosition
			end

			local var_430_18 = 0.001

			if var_430_17 <= arg_427_1.time_ and arg_427_1.time_ < var_430_17 + var_430_18 then
				local var_430_19 = (arg_427_1.time_ - var_430_17) / var_430_18
				local var_430_20 = Vector3.New(0.7, -1.055, -6.16)

				var_430_16.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1075ui_story, var_430_20, var_430_19)

				local var_430_21 = manager.ui.mainCamera.transform.position - var_430_16.position

				var_430_16.forward = Vector3.New(var_430_21.x, var_430_21.y, var_430_21.z)

				local var_430_22 = var_430_16.localEulerAngles

				var_430_22.z = 0
				var_430_22.x = 0
				var_430_16.localEulerAngles = var_430_22
			end

			if arg_427_1.time_ >= var_430_17 + var_430_18 and arg_427_1.time_ < var_430_17 + var_430_18 + arg_430_0 then
				var_430_16.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_430_23 = manager.ui.mainCamera.transform.position - var_430_16.position

				var_430_16.forward = Vector3.New(var_430_23.x, var_430_23.y, var_430_23.z)

				local var_430_24 = var_430_16.localEulerAngles

				var_430_24.z = 0
				var_430_24.x = 0
				var_430_16.localEulerAngles = var_430_24
			end

			local var_430_25 = arg_427_1.actors_["1075ui_story"]
			local var_430_26 = 0

			if var_430_26 < arg_427_1.time_ and arg_427_1.time_ <= var_430_26 + arg_430_0 and not isNil(var_430_25) and arg_427_1.var_.characterEffect1075ui_story == nil then
				arg_427_1.var_.characterEffect1075ui_story = var_430_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_27 = 0.2

			if var_430_26 <= arg_427_1.time_ and arg_427_1.time_ < var_430_26 + var_430_27 and not isNil(var_430_25) then
				local var_430_28 = (arg_427_1.time_ - var_430_26) / var_430_27

				if arg_427_1.var_.characterEffect1075ui_story and not isNil(var_430_25) then
					arg_427_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_26 + var_430_27 and arg_427_1.time_ < var_430_26 + var_430_27 + arg_430_0 and not isNil(var_430_25) and arg_427_1.var_.characterEffect1075ui_story then
				arg_427_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_430_29 = 0
			local var_430_30 = 0.525

			if var_430_29 < arg_427_1.time_ and arg_427_1.time_ <= var_430_29 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_31 = arg_427_1:FormatText(StoryNameCfg[381].name)

				arg_427_1.leftNameTxt_.text = var_430_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_32 = arg_427_1:GetWordFromCfg(120421103)
				local var_430_33 = arg_427_1:FormatText(var_430_32.content)

				arg_427_1.text_.text = var_430_33

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_34 = 21
				local var_430_35 = utf8.len(var_430_33)
				local var_430_36 = var_430_34 <= 0 and var_430_30 or var_430_30 * (var_430_35 / var_430_34)

				if var_430_36 > 0 and var_430_30 < var_430_36 then
					arg_427_1.talkMaxDuration = var_430_36

					if var_430_36 + var_430_29 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_36 + var_430_29
					end
				end

				arg_427_1.text_.text = var_430_33
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421103", "story_v_out_120421.awb") ~= 0 then
					local var_430_37 = manager.audio:GetVoiceLength("story_v_out_120421", "120421103", "story_v_out_120421.awb") / 1000

					if var_430_37 + var_430_29 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_37 + var_430_29
					end

					if var_430_32.prefab_name ~= "" and arg_427_1.actors_[var_430_32.prefab_name] ~= nil then
						local var_430_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_32.prefab_name].transform, "story_v_out_120421", "120421103", "story_v_out_120421.awb")

						arg_427_1:RecordAudio("120421103", var_430_38)
						arg_427_1:RecordAudio("120421103", var_430_38)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_120421", "120421103", "story_v_out_120421.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_120421", "120421103", "story_v_out_120421.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_39 = math.max(var_430_30, arg_427_1.talkMaxDuration)

			if var_430_29 <= arg_427_1.time_ and arg_427_1.time_ < var_430_29 + var_430_39 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_29) / var_430_39

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_29 + var_430_39 and arg_427_1.time_ < var_430_29 + var_430_39 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play120421104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 120421104
		arg_431_1.duration_ = 8.3

		local var_431_0 = {
			zh = 3.6,
			ja = 8.3
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play120421105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1074ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1074ui_story == nil then
				arg_431_1.var_.characterEffect1074ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1074ui_story and not isNil(var_434_0) then
					arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1074ui_story then
				arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_434_4 = arg_431_1.actors_["1075ui_story"]
			local var_434_5 = 0

			if var_434_5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 and not isNil(var_434_4) and arg_431_1.var_.characterEffect1075ui_story == nil then
				arg_431_1.var_.characterEffect1075ui_story = var_434_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_6 = 0.2

			if var_434_5 <= arg_431_1.time_ and arg_431_1.time_ < var_434_5 + var_434_6 and not isNil(var_434_4) then
				local var_434_7 = (arg_431_1.time_ - var_434_5) / var_434_6

				if arg_431_1.var_.characterEffect1075ui_story and not isNil(var_434_4) then
					local var_434_8 = Mathf.Lerp(0, 0.5, var_434_7)

					arg_431_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1075ui_story.fillRatio = var_434_8
				end
			end

			if arg_431_1.time_ >= var_434_5 + var_434_6 and arg_431_1.time_ < var_434_5 + var_434_6 + arg_434_0 and not isNil(var_434_4) and arg_431_1.var_.characterEffect1075ui_story then
				local var_434_9 = 0.5

				arg_431_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1075ui_story.fillRatio = var_434_9
			end

			local var_434_10 = 0
			local var_434_11 = 0.4

			if var_434_10 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_12 = arg_431_1:FormatText(StoryNameCfg[410].name)

				arg_431_1.leftNameTxt_.text = var_434_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_13 = arg_431_1:GetWordFromCfg(120421104)
				local var_434_14 = arg_431_1:FormatText(var_434_13.content)

				arg_431_1.text_.text = var_434_14

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_15 = 16
				local var_434_16 = utf8.len(var_434_14)
				local var_434_17 = var_434_15 <= 0 and var_434_11 or var_434_11 * (var_434_16 / var_434_15)

				if var_434_17 > 0 and var_434_11 < var_434_17 then
					arg_431_1.talkMaxDuration = var_434_17

					if var_434_17 + var_434_10 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_17 + var_434_10
					end
				end

				arg_431_1.text_.text = var_434_14
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421104", "story_v_out_120421.awb") ~= 0 then
					local var_434_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421104", "story_v_out_120421.awb") / 1000

					if var_434_18 + var_434_10 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_18 + var_434_10
					end

					if var_434_13.prefab_name ~= "" and arg_431_1.actors_[var_434_13.prefab_name] ~= nil then
						local var_434_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_13.prefab_name].transform, "story_v_out_120421", "120421104", "story_v_out_120421.awb")

						arg_431_1:RecordAudio("120421104", var_434_19)
						arg_431_1:RecordAudio("120421104", var_434_19)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_120421", "120421104", "story_v_out_120421.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_120421", "120421104", "story_v_out_120421.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_20 = math.max(var_434_11, arg_431_1.talkMaxDuration)

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_20 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_10) / var_434_20

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_10 + var_434_20 and arg_431_1.time_ < var_434_10 + var_434_20 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play120421105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 120421105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play120421106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1074ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1074ui_story == nil then
				arg_435_1.var_.characterEffect1074ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1074ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1074ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1074ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1074ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 1.175

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_8 = arg_435_1:GetWordFromCfg(120421105)
				local var_438_9 = arg_435_1:FormatText(var_438_8.content)

				arg_435_1.text_.text = var_438_9

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_10 = 47
				local var_438_11 = utf8.len(var_438_9)
				local var_438_12 = var_438_10 <= 0 and var_438_7 or var_438_7 * (var_438_11 / var_438_10)

				if var_438_12 > 0 and var_438_7 < var_438_12 then
					arg_435_1.talkMaxDuration = var_438_12

					if var_438_12 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_12 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_9
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_13 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_13 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_13

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_13 and arg_435_1.time_ < var_438_6 + var_438_13 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play120421106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 120421106
		arg_439_1.duration_ = 8.57

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play120421107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_1 = 2

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_1 then
				local var_442_2 = (arg_439_1.time_ - var_442_0) / var_442_1
				local var_442_3 = Color.New(0, 0, 0)

				var_442_3.a = Mathf.Lerp(0, 1, var_442_2)
				arg_439_1.mask_.color = var_442_3
			end

			if arg_439_1.time_ >= var_442_0 + var_442_1 and arg_439_1.time_ < var_442_0 + var_442_1 + arg_442_0 then
				local var_442_4 = Color.New(0, 0, 0)

				var_442_4.a = 1
				arg_439_1.mask_.color = var_442_4
			end

			local var_442_5 = 2

			if var_442_5 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_6 = 2

			if var_442_5 <= arg_439_1.time_ and arg_439_1.time_ < var_442_5 + var_442_6 then
				local var_442_7 = (arg_439_1.time_ - var_442_5) / var_442_6
				local var_442_8 = Color.New(0, 0, 0)

				var_442_8.a = Mathf.Lerp(1, 0, var_442_7)
				arg_439_1.mask_.color = var_442_8
			end

			if arg_439_1.time_ >= var_442_5 + var_442_6 and arg_439_1.time_ < var_442_5 + var_442_6 + arg_442_0 then
				local var_442_9 = Color.New(0, 0, 0)
				local var_442_10 = 0

				arg_439_1.mask_.enabled = false
				var_442_9.a = var_442_10
				arg_439_1.mask_.color = var_442_9
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_11 = 3.56666666666667
			local var_442_12 = 1.55

			if var_442_11 < arg_439_1.time_ and arg_439_1.time_ <= var_442_11 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_13 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_13:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_14 = arg_439_1:GetWordFromCfg(120421106)
				local var_442_15 = arg_439_1:FormatText(var_442_14.content)

				arg_439_1.text_.text = var_442_15

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_16 = 62
				local var_442_17 = utf8.len(var_442_15)
				local var_442_18 = var_442_16 <= 0 and var_442_12 or var_442_12 * (var_442_17 / var_442_16)

				if var_442_18 > 0 and var_442_12 < var_442_18 then
					arg_439_1.talkMaxDuration = var_442_18
					var_442_11 = var_442_11 + 0.3

					if var_442_18 + var_442_11 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_18 + var_442_11
					end
				end

				arg_439_1.text_.text = var_442_15
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_19 = var_442_11 + 0.3
			local var_442_20 = math.max(var_442_12, arg_439_1.talkMaxDuration)

			if var_442_19 <= arg_439_1.time_ and arg_439_1.time_ < var_442_19 + var_442_20 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_19) / var_442_20

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_19 + var_442_20 and arg_439_1.time_ < var_442_19 + var_442_20 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play120421107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 120421107
		arg_445_1.duration_ = 11.33

		local var_445_0 = {
			zh = 8.033,
			ja = 11.333
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
				arg_445_0:Play120421108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1074ui_story"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1074ui_story == nil then
				arg_445_1.var_.characterEffect1074ui_story = var_448_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.2

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.characterEffect1074ui_story and not isNil(var_448_0) then
					arg_445_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1074ui_story then
				arg_445_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_448_4 = 0
			local var_448_5 = 0.8

			if var_448_4 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_6 = arg_445_1:FormatText(StoryNameCfg[410].name)

				arg_445_1.leftNameTxt_.text = var_448_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:GetWordFromCfg(120421107)
				local var_448_8 = arg_445_1:FormatText(var_448_7.content)

				arg_445_1.text_.text = var_448_8

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 32
				local var_448_10 = utf8.len(var_448_8)
				local var_448_11 = var_448_9 <= 0 and var_448_5 or var_448_5 * (var_448_10 / var_448_9)

				if var_448_11 > 0 and var_448_5 < var_448_11 then
					arg_445_1.talkMaxDuration = var_448_11

					if var_448_11 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_11 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_8
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421107", "story_v_out_120421.awb") ~= 0 then
					local var_448_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421107", "story_v_out_120421.awb") / 1000

					if var_448_12 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_12 + var_448_4
					end

					if var_448_7.prefab_name ~= "" and arg_445_1.actors_[var_448_7.prefab_name] ~= nil then
						local var_448_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_7.prefab_name].transform, "story_v_out_120421", "120421107", "story_v_out_120421.awb")

						arg_445_1:RecordAudio("120421107", var_448_13)
						arg_445_1:RecordAudio("120421107", var_448_13)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_120421", "120421107", "story_v_out_120421.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_120421", "120421107", "story_v_out_120421.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_14 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_14 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_14

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_14 and arg_445_1.time_ < var_448_4 + var_448_14 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play120421108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 120421108
		arg_449_1.duration_ = 4.6

		local var_449_0 = {
			zh = 3.1,
			ja = 4.6
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
				arg_449_0:Play120421109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1075ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos1075ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, 100, 0)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1075ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, 100, 0)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["10044ui_story"].transform
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 then
				arg_449_1.var_.moveOldPos10044ui_story = var_452_9.localPosition
			end

			local var_452_11 = 0.001

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11
				local var_452_13 = Vector3.New(0.7, -0.72, -6.3)

				var_452_9.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10044ui_story, var_452_13, var_452_12)

				local var_452_14 = manager.ui.mainCamera.transform.position - var_452_9.position

				var_452_9.forward = Vector3.New(var_452_14.x, var_452_14.y, var_452_14.z)

				local var_452_15 = var_452_9.localEulerAngles

				var_452_15.z = 0
				var_452_15.x = 0
				var_452_9.localEulerAngles = var_452_15
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 then
				var_452_9.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_452_16 = manager.ui.mainCamera.transform.position - var_452_9.position

				var_452_9.forward = Vector3.New(var_452_16.x, var_452_16.y, var_452_16.z)

				local var_452_17 = var_452_9.localEulerAngles

				var_452_17.z = 0
				var_452_17.x = 0
				var_452_9.localEulerAngles = var_452_17
			end

			local var_452_18 = 0

			if var_452_18 < arg_449_1.time_ and arg_449_1.time_ <= var_452_18 + arg_452_0 then
				arg_449_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_452_19 = 0

			if var_452_19 < arg_449_1.time_ and arg_449_1.time_ <= var_452_19 + arg_452_0 then
				arg_449_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_452_20 = arg_449_1.actors_["10044ui_story"]
			local var_452_21 = 0

			if var_452_21 < arg_449_1.time_ and arg_449_1.time_ <= var_452_21 + arg_452_0 and not isNil(var_452_20) and arg_449_1.var_.characterEffect10044ui_story == nil then
				arg_449_1.var_.characterEffect10044ui_story = var_452_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_22 = 0.2

			if var_452_21 <= arg_449_1.time_ and arg_449_1.time_ < var_452_21 + var_452_22 and not isNil(var_452_20) then
				local var_452_23 = (arg_449_1.time_ - var_452_21) / var_452_22

				if arg_449_1.var_.characterEffect10044ui_story and not isNil(var_452_20) then
					arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_21 + var_452_22 and arg_449_1.time_ < var_452_21 + var_452_22 + arg_452_0 and not isNil(var_452_20) and arg_449_1.var_.characterEffect10044ui_story then
				arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_452_24 = arg_449_1.actors_["1074ui_story"]
			local var_452_25 = 0

			if var_452_25 < arg_449_1.time_ and arg_449_1.time_ <= var_452_25 + arg_452_0 and not isNil(var_452_24) and arg_449_1.var_.characterEffect1074ui_story == nil then
				arg_449_1.var_.characterEffect1074ui_story = var_452_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_26 = 0.2

			if var_452_25 <= arg_449_1.time_ and arg_449_1.time_ < var_452_25 + var_452_26 and not isNil(var_452_24) then
				local var_452_27 = (arg_449_1.time_ - var_452_25) / var_452_26

				if arg_449_1.var_.characterEffect1074ui_story and not isNil(var_452_24) then
					local var_452_28 = Mathf.Lerp(0, 0.5, var_452_27)

					arg_449_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1074ui_story.fillRatio = var_452_28
				end
			end

			if arg_449_1.time_ >= var_452_25 + var_452_26 and arg_449_1.time_ < var_452_25 + var_452_26 + arg_452_0 and not isNil(var_452_24) and arg_449_1.var_.characterEffect1074ui_story then
				local var_452_29 = 0.5

				arg_449_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1074ui_story.fillRatio = var_452_29
			end

			local var_452_30 = 0
			local var_452_31 = 0.35

			if var_452_30 < arg_449_1.time_ and arg_449_1.time_ <= var_452_30 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_32 = arg_449_1:FormatText(StoryNameCfg[380].name)

				arg_449_1.leftNameTxt_.text = var_452_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_33 = arg_449_1:GetWordFromCfg(120421108)
				local var_452_34 = arg_449_1:FormatText(var_452_33.content)

				arg_449_1.text_.text = var_452_34

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_35 = 14
				local var_452_36 = utf8.len(var_452_34)
				local var_452_37 = var_452_35 <= 0 and var_452_31 or var_452_31 * (var_452_36 / var_452_35)

				if var_452_37 > 0 and var_452_31 < var_452_37 then
					arg_449_1.talkMaxDuration = var_452_37

					if var_452_37 + var_452_30 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_37 + var_452_30
					end
				end

				arg_449_1.text_.text = var_452_34
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421108", "story_v_out_120421.awb") ~= 0 then
					local var_452_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421108", "story_v_out_120421.awb") / 1000

					if var_452_38 + var_452_30 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_38 + var_452_30
					end

					if var_452_33.prefab_name ~= "" and arg_449_1.actors_[var_452_33.prefab_name] ~= nil then
						local var_452_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_33.prefab_name].transform, "story_v_out_120421", "120421108", "story_v_out_120421.awb")

						arg_449_1:RecordAudio("120421108", var_452_39)
						arg_449_1:RecordAudio("120421108", var_452_39)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_120421", "120421108", "story_v_out_120421.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_120421", "120421108", "story_v_out_120421.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_40 = math.max(var_452_31, arg_449_1.talkMaxDuration)

			if var_452_30 <= arg_449_1.time_ and arg_449_1.time_ < var_452_30 + var_452_40 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_30) / var_452_40

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_30 + var_452_40 and arg_449_1.time_ < var_452_30 + var_452_40 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play120421109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 120421109
		arg_453_1.duration_ = 3.1

		local var_453_0 = {
			zh = 2.3,
			ja = 3.1
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
				arg_453_0:Play120421110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["10044ui_story"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.characterEffect10044ui_story == nil then
				arg_453_1.var_.characterEffect10044ui_story = var_456_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.2

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.characterEffect10044ui_story and not isNil(var_456_0) then
					local var_456_4 = Mathf.Lerp(0, 0.5, var_456_3)

					arg_453_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10044ui_story.fillRatio = var_456_4
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.characterEffect10044ui_story then
				local var_456_5 = 0.5

				arg_453_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10044ui_story.fillRatio = var_456_5
			end

			local var_456_6 = arg_453_1.actors_["1074ui_story"]
			local var_456_7 = 0

			if var_456_7 < arg_453_1.time_ and arg_453_1.time_ <= var_456_7 + arg_456_0 and not isNil(var_456_6) and arg_453_1.var_.characterEffect1074ui_story == nil then
				arg_453_1.var_.characterEffect1074ui_story = var_456_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_8 = 0.2

			if var_456_7 <= arg_453_1.time_ and arg_453_1.time_ < var_456_7 + var_456_8 and not isNil(var_456_6) then
				local var_456_9 = (arg_453_1.time_ - var_456_7) / var_456_8

				if arg_453_1.var_.characterEffect1074ui_story and not isNil(var_456_6) then
					arg_453_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_7 + var_456_8 and arg_453_1.time_ < var_456_7 + var_456_8 + arg_456_0 and not isNil(var_456_6) and arg_453_1.var_.characterEffect1074ui_story then
				arg_453_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_456_10 = 0
			local var_456_11 = 0.175

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_12 = arg_453_1:FormatText(StoryNameCfg[410].name)

				arg_453_1.leftNameTxt_.text = var_456_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_13 = arg_453_1:GetWordFromCfg(120421109)
				local var_456_14 = arg_453_1:FormatText(var_456_13.content)

				arg_453_1.text_.text = var_456_14

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_15 = 7
				local var_456_16 = utf8.len(var_456_14)
				local var_456_17 = var_456_15 <= 0 and var_456_11 or var_456_11 * (var_456_16 / var_456_15)

				if var_456_17 > 0 and var_456_11 < var_456_17 then
					arg_453_1.talkMaxDuration = var_456_17

					if var_456_17 + var_456_10 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_17 + var_456_10
					end
				end

				arg_453_1.text_.text = var_456_14
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421109", "story_v_out_120421.awb") ~= 0 then
					local var_456_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421109", "story_v_out_120421.awb") / 1000

					if var_456_18 + var_456_10 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_18 + var_456_10
					end

					if var_456_13.prefab_name ~= "" and arg_453_1.actors_[var_456_13.prefab_name] ~= nil then
						local var_456_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_13.prefab_name].transform, "story_v_out_120421", "120421109", "story_v_out_120421.awb")

						arg_453_1:RecordAudio("120421109", var_456_19)
						arg_453_1:RecordAudio("120421109", var_456_19)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_120421", "120421109", "story_v_out_120421.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_120421", "120421109", "story_v_out_120421.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_20 = math.max(var_456_11, arg_453_1.talkMaxDuration)

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_20 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_10) / var_456_20

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_10 + var_456_20 and arg_453_1.time_ < var_456_10 + var_456_20 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play120421110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 120421110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play120421111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["10044ui_story"].transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPos10044ui_story = var_460_0.localPosition
			end

			local var_460_2 = 0.001

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0, 100, 0)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10044ui_story, var_460_4, var_460_3)

				local var_460_5 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_5.x, var_460_5.y, var_460_5.z)

				local var_460_6 = var_460_0.localEulerAngles

				var_460_6.z = 0
				var_460_6.x = 0
				var_460_0.localEulerAngles = var_460_6
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0, 100, 0)

				local var_460_7 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_7.x, var_460_7.y, var_460_7.z)

				local var_460_8 = var_460_0.localEulerAngles

				var_460_8.z = 0
				var_460_8.x = 0
				var_460_0.localEulerAngles = var_460_8
			end

			local var_460_9 = arg_457_1.actors_["1074ui_story"].transform
			local var_460_10 = 0

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 then
				arg_457_1.var_.moveOldPos1074ui_story = var_460_9.localPosition
			end

			local var_460_11 = 0.001

			if var_460_10 <= arg_457_1.time_ and arg_457_1.time_ < var_460_10 + var_460_11 then
				local var_460_12 = (arg_457_1.time_ - var_460_10) / var_460_11
				local var_460_13 = Vector3.New(0, 100, 0)

				var_460_9.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1074ui_story, var_460_13, var_460_12)

				local var_460_14 = manager.ui.mainCamera.transform.position - var_460_9.position

				var_460_9.forward = Vector3.New(var_460_14.x, var_460_14.y, var_460_14.z)

				local var_460_15 = var_460_9.localEulerAngles

				var_460_15.z = 0
				var_460_15.x = 0
				var_460_9.localEulerAngles = var_460_15
			end

			if arg_457_1.time_ >= var_460_10 + var_460_11 and arg_457_1.time_ < var_460_10 + var_460_11 + arg_460_0 then
				var_460_9.localPosition = Vector3.New(0, 100, 0)

				local var_460_16 = manager.ui.mainCamera.transform.position - var_460_9.position

				var_460_9.forward = Vector3.New(var_460_16.x, var_460_16.y, var_460_16.z)

				local var_460_17 = var_460_9.localEulerAngles

				var_460_17.z = 0
				var_460_17.x = 0
				var_460_9.localEulerAngles = var_460_17
			end

			local var_460_18 = 0
			local var_460_19 = 1.05

			if var_460_18 < arg_457_1.time_ and arg_457_1.time_ <= var_460_18 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_20 = arg_457_1:GetWordFromCfg(120421110)
				local var_460_21 = arg_457_1:FormatText(var_460_20.content)

				arg_457_1.text_.text = var_460_21

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_22 = 42
				local var_460_23 = utf8.len(var_460_21)
				local var_460_24 = var_460_22 <= 0 and var_460_19 or var_460_19 * (var_460_23 / var_460_22)

				if var_460_24 > 0 and var_460_19 < var_460_24 then
					arg_457_1.talkMaxDuration = var_460_24

					if var_460_24 + var_460_18 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_24 + var_460_18
					end
				end

				arg_457_1.text_.text = var_460_21
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_25 = math.max(var_460_19, arg_457_1.talkMaxDuration)

			if var_460_18 <= arg_457_1.time_ and arg_457_1.time_ < var_460_18 + var_460_25 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_18) / var_460_25

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_18 + var_460_25 and arg_457_1.time_ < var_460_18 + var_460_25 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play120421111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 120421111
		arg_461_1.duration_ = 13.27

		local var_461_0 = {
			zh = 9.966,
			ja = 13.266
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play120421112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1074ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1074ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1074ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["10044ui_story"].transform
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 then
				arg_461_1.var_.moveOldPos10044ui_story = var_464_9.localPosition
			end

			local var_464_11 = 0.001

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11
				local var_464_13 = Vector3.New(0.7, -0.72, -6.3)

				var_464_9.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10044ui_story, var_464_13, var_464_12)

				local var_464_14 = manager.ui.mainCamera.transform.position - var_464_9.position

				var_464_9.forward = Vector3.New(var_464_14.x, var_464_14.y, var_464_14.z)

				local var_464_15 = var_464_9.localEulerAngles

				var_464_15.z = 0
				var_464_15.x = 0
				var_464_9.localEulerAngles = var_464_15
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 then
				var_464_9.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_464_16 = manager.ui.mainCamera.transform.position - var_464_9.position

				var_464_9.forward = Vector3.New(var_464_16.x, var_464_16.y, var_464_16.z)

				local var_464_17 = var_464_9.localEulerAngles

				var_464_17.z = 0
				var_464_17.x = 0
				var_464_9.localEulerAngles = var_464_17
			end

			local var_464_18 = 0

			if var_464_18 < arg_461_1.time_ and arg_461_1.time_ <= var_464_18 + arg_464_0 then
				arg_461_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_464_19 = 0

			if var_464_19 < arg_461_1.time_ and arg_461_1.time_ <= var_464_19 + arg_464_0 then
				arg_461_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_464_20 = 0

			if var_464_20 < arg_461_1.time_ and arg_461_1.time_ <= var_464_20 + arg_464_0 then
				arg_461_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_464_21 = 0

			if var_464_21 < arg_461_1.time_ and arg_461_1.time_ <= var_464_21 + arg_464_0 then
				arg_461_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_464_22 = arg_461_1.actors_["10044ui_story"]
			local var_464_23 = 0

			if var_464_23 < arg_461_1.time_ and arg_461_1.time_ <= var_464_23 + arg_464_0 and not isNil(var_464_22) and arg_461_1.var_.characterEffect10044ui_story == nil then
				arg_461_1.var_.characterEffect10044ui_story = var_464_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_24 = 0.2

			if var_464_23 <= arg_461_1.time_ and arg_461_1.time_ < var_464_23 + var_464_24 and not isNil(var_464_22) then
				local var_464_25 = (arg_461_1.time_ - var_464_23) / var_464_24

				if arg_461_1.var_.characterEffect10044ui_story and not isNil(var_464_22) then
					local var_464_26 = Mathf.Lerp(0, 0.5, var_464_25)

					arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10044ui_story.fillRatio = var_464_26
				end
			end

			if arg_461_1.time_ >= var_464_23 + var_464_24 and arg_461_1.time_ < var_464_23 + var_464_24 + arg_464_0 and not isNil(var_464_22) and arg_461_1.var_.characterEffect10044ui_story then
				local var_464_27 = 0.5

				arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10044ui_story.fillRatio = var_464_27
			end

			local var_464_28 = arg_461_1.actors_["1074ui_story"]
			local var_464_29 = 0

			if var_464_29 < arg_461_1.time_ and arg_461_1.time_ <= var_464_29 + arg_464_0 and not isNil(var_464_28) and arg_461_1.var_.characterEffect1074ui_story == nil then
				arg_461_1.var_.characterEffect1074ui_story = var_464_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_30 = 0.2

			if var_464_29 <= arg_461_1.time_ and arg_461_1.time_ < var_464_29 + var_464_30 and not isNil(var_464_28) then
				local var_464_31 = (arg_461_1.time_ - var_464_29) / var_464_30

				if arg_461_1.var_.characterEffect1074ui_story and not isNil(var_464_28) then
					arg_461_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_29 + var_464_30 and arg_461_1.time_ < var_464_29 + var_464_30 + arg_464_0 and not isNil(var_464_28) and arg_461_1.var_.characterEffect1074ui_story then
				arg_461_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_464_32 = 0
			local var_464_33 = 1.1

			if var_464_32 < arg_461_1.time_ and arg_461_1.time_ <= var_464_32 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_34 = arg_461_1:FormatText(StoryNameCfg[410].name)

				arg_461_1.leftNameTxt_.text = var_464_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_35 = arg_461_1:GetWordFromCfg(120421111)
				local var_464_36 = arg_461_1:FormatText(var_464_35.content)

				arg_461_1.text_.text = var_464_36

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_37 = 44
				local var_464_38 = utf8.len(var_464_36)
				local var_464_39 = var_464_37 <= 0 and var_464_33 or var_464_33 * (var_464_38 / var_464_37)

				if var_464_39 > 0 and var_464_33 < var_464_39 then
					arg_461_1.talkMaxDuration = var_464_39

					if var_464_39 + var_464_32 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_39 + var_464_32
					end
				end

				arg_461_1.text_.text = var_464_36
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421111", "story_v_out_120421.awb") ~= 0 then
					local var_464_40 = manager.audio:GetVoiceLength("story_v_out_120421", "120421111", "story_v_out_120421.awb") / 1000

					if var_464_40 + var_464_32 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_40 + var_464_32
					end

					if var_464_35.prefab_name ~= "" and arg_461_1.actors_[var_464_35.prefab_name] ~= nil then
						local var_464_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_35.prefab_name].transform, "story_v_out_120421", "120421111", "story_v_out_120421.awb")

						arg_461_1:RecordAudio("120421111", var_464_41)
						arg_461_1:RecordAudio("120421111", var_464_41)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_120421", "120421111", "story_v_out_120421.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_120421", "120421111", "story_v_out_120421.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_42 = math.max(var_464_33, arg_461_1.talkMaxDuration)

			if var_464_32 <= arg_461_1.time_ and arg_461_1.time_ < var_464_32 + var_464_42 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_32) / var_464_42

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_32 + var_464_42 and arg_461_1.time_ < var_464_32 + var_464_42 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play120421112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 120421112
		arg_465_1.duration_ = 14.53

		local var_465_0 = {
			zh = 12.133,
			ja = 14.533
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
				arg_465_0:Play120421113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.25

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[410].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(120421112)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421112", "story_v_out_120421.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421112", "story_v_out_120421.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_120421", "120421112", "story_v_out_120421.awb")

						arg_465_1:RecordAudio("120421112", var_468_9)
						arg_465_1:RecordAudio("120421112", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_120421", "120421112", "story_v_out_120421.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_120421", "120421112", "story_v_out_120421.awb")
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
	Play120421113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 120421113
		arg_469_1.duration_ = 5.73

		local var_469_0 = {
			zh = 1.933,
			ja = 5.733
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
				arg_469_0:Play120421114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.2

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[410].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_3 = arg_469_1:GetWordFromCfg(120421113)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421113", "story_v_out_120421.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421113", "story_v_out_120421.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_out_120421", "120421113", "story_v_out_120421.awb")

						arg_469_1:RecordAudio("120421113", var_472_9)
						arg_469_1:RecordAudio("120421113", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_120421", "120421113", "story_v_out_120421.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_120421", "120421113", "story_v_out_120421.awb")
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
	Play120421114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 120421114
		arg_473_1.duration_ = 4.97

		local var_473_0 = {
			zh = 2.5,
			ja = 4.966
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play120421115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10044ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect10044ui_story == nil then
				arg_473_1.var_.characterEffect10044ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.2

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect10044ui_story and not isNil(var_476_0) then
					arg_473_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect10044ui_story then
				arg_473_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_476_4 = arg_473_1.actors_["1074ui_story"]
			local var_476_5 = 0

			if var_476_5 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect1074ui_story == nil then
				arg_473_1.var_.characterEffect1074ui_story = var_476_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_6 = 0.2

			if var_476_5 <= arg_473_1.time_ and arg_473_1.time_ < var_476_5 + var_476_6 and not isNil(var_476_4) then
				local var_476_7 = (arg_473_1.time_ - var_476_5) / var_476_6

				if arg_473_1.var_.characterEffect1074ui_story and not isNil(var_476_4) then
					local var_476_8 = Mathf.Lerp(0, 0.5, var_476_7)

					arg_473_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1074ui_story.fillRatio = var_476_8
				end
			end

			if arg_473_1.time_ >= var_476_5 + var_476_6 and arg_473_1.time_ < var_476_5 + var_476_6 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect1074ui_story then
				local var_476_9 = 0.5

				arg_473_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1074ui_story.fillRatio = var_476_9
			end

			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 then
				arg_473_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_476_11 = 0
			local var_476_12 = 0.3

			if var_476_11 < arg_473_1.time_ and arg_473_1.time_ <= var_476_11 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_13 = arg_473_1:FormatText(StoryNameCfg[380].name)

				arg_473_1.leftNameTxt_.text = var_476_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_14 = arg_473_1:GetWordFromCfg(120421114)
				local var_476_15 = arg_473_1:FormatText(var_476_14.content)

				arg_473_1.text_.text = var_476_15

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_16 = 12
				local var_476_17 = utf8.len(var_476_15)
				local var_476_18 = var_476_16 <= 0 and var_476_12 or var_476_12 * (var_476_17 / var_476_16)

				if var_476_18 > 0 and var_476_12 < var_476_18 then
					arg_473_1.talkMaxDuration = var_476_18

					if var_476_18 + var_476_11 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_18 + var_476_11
					end
				end

				arg_473_1.text_.text = var_476_15
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421114", "story_v_out_120421.awb") ~= 0 then
					local var_476_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421114", "story_v_out_120421.awb") / 1000

					if var_476_19 + var_476_11 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_19 + var_476_11
					end

					if var_476_14.prefab_name ~= "" and arg_473_1.actors_[var_476_14.prefab_name] ~= nil then
						local var_476_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_14.prefab_name].transform, "story_v_out_120421", "120421114", "story_v_out_120421.awb")

						arg_473_1:RecordAudio("120421114", var_476_20)
						arg_473_1:RecordAudio("120421114", var_476_20)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_120421", "120421114", "story_v_out_120421.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_120421", "120421114", "story_v_out_120421.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_21 = math.max(var_476_12, arg_473_1.talkMaxDuration)

			if var_476_11 <= arg_473_1.time_ and arg_473_1.time_ < var_476_11 + var_476_21 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_11) / var_476_21

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_11 + var_476_21 and arg_473_1.time_ < var_476_11 + var_476_21 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play120421115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 120421115
		arg_477_1.duration_ = 2

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play120421116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10044ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10044ui_story == nil then
				arg_477_1.var_.characterEffect10044ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect10044ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10044ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10044ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10044ui_story.fillRatio = var_480_5
			end

			local var_480_6 = arg_477_1.actors_["1074ui_story"]
			local var_480_7 = 0

			if var_480_7 < arg_477_1.time_ and arg_477_1.time_ <= var_480_7 + arg_480_0 and not isNil(var_480_6) and arg_477_1.var_.characterEffect1074ui_story == nil then
				arg_477_1.var_.characterEffect1074ui_story = var_480_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_8 = 0.2

			if var_480_7 <= arg_477_1.time_ and arg_477_1.time_ < var_480_7 + var_480_8 and not isNil(var_480_6) then
				local var_480_9 = (arg_477_1.time_ - var_480_7) / var_480_8

				if arg_477_1.var_.characterEffect1074ui_story and not isNil(var_480_6) then
					arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_7 + var_480_8 and arg_477_1.time_ < var_480_7 + var_480_8 + arg_480_0 and not isNil(var_480_6) and arg_477_1.var_.characterEffect1074ui_story then
				arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_480_11 = 0
			local var_480_12 = 0.225

			if var_480_11 < arg_477_1.time_ and arg_477_1.time_ <= var_480_11 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_13 = arg_477_1:FormatText(StoryNameCfg[410].name)

				arg_477_1.leftNameTxt_.text = var_480_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_14 = arg_477_1:GetWordFromCfg(120421115)
				local var_480_15 = arg_477_1:FormatText(var_480_14.content)

				arg_477_1.text_.text = var_480_15

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_16 = 9
				local var_480_17 = utf8.len(var_480_15)
				local var_480_18 = var_480_16 <= 0 and var_480_12 or var_480_12 * (var_480_17 / var_480_16)

				if var_480_18 > 0 and var_480_12 < var_480_18 then
					arg_477_1.talkMaxDuration = var_480_18

					if var_480_18 + var_480_11 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_18 + var_480_11
					end
				end

				arg_477_1.text_.text = var_480_15
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421115", "story_v_out_120421.awb") ~= 0 then
					local var_480_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421115", "story_v_out_120421.awb") / 1000

					if var_480_19 + var_480_11 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_19 + var_480_11
					end

					if var_480_14.prefab_name ~= "" and arg_477_1.actors_[var_480_14.prefab_name] ~= nil then
						local var_480_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_14.prefab_name].transform, "story_v_out_120421", "120421115", "story_v_out_120421.awb")

						arg_477_1:RecordAudio("120421115", var_480_20)
						arg_477_1:RecordAudio("120421115", var_480_20)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_120421", "120421115", "story_v_out_120421.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_120421", "120421115", "story_v_out_120421.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_21 = math.max(var_480_12, arg_477_1.talkMaxDuration)

			if var_480_11 <= arg_477_1.time_ and arg_477_1.time_ < var_480_11 + var_480_21 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_11) / var_480_21

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_11 + var_480_21 and arg_477_1.time_ < var_480_11 + var_480_21 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play120421116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 120421116
		arg_481_1.duration_ = 9.17

		local var_481_0 = {
			zh = 7.333,
			ja = 9.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play120421117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.775

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[410].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:GetWordFromCfg(120421116)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 31
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421116", "story_v_out_120421.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421116", "story_v_out_120421.awb") / 1000

					if var_484_8 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_0
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_out_120421", "120421116", "story_v_out_120421.awb")

						arg_481_1:RecordAudio("120421116", var_484_9)
						arg_481_1:RecordAudio("120421116", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_120421", "120421116", "story_v_out_120421.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_120421", "120421116", "story_v_out_120421.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_10 and arg_481_1.time_ < var_484_0 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play120421117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 120421117
		arg_485_1.duration_ = 2

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play120421118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["10044ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10044ui_story == nil then
				arg_485_1.var_.characterEffect10044ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.2

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect10044ui_story and not isNil(var_488_0) then
					arg_485_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10044ui_story then
				arg_485_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_488_4 = arg_485_1.actors_["1074ui_story"]
			local var_488_5 = 0

			if var_488_5 < arg_485_1.time_ and arg_485_1.time_ <= var_488_5 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1074ui_story == nil then
				arg_485_1.var_.characterEffect1074ui_story = var_488_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_6 = 0.2

			if var_488_5 <= arg_485_1.time_ and arg_485_1.time_ < var_488_5 + var_488_6 and not isNil(var_488_4) then
				local var_488_7 = (arg_485_1.time_ - var_488_5) / var_488_6

				if arg_485_1.var_.characterEffect1074ui_story and not isNil(var_488_4) then
					local var_488_8 = Mathf.Lerp(0, 0.5, var_488_7)

					arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1074ui_story.fillRatio = var_488_8
				end
			end

			if arg_485_1.time_ >= var_488_5 + var_488_6 and arg_485_1.time_ < var_488_5 + var_488_6 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1074ui_story then
				local var_488_9 = 0.5

				arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1074ui_story.fillRatio = var_488_9
			end

			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 then
				arg_485_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action443")
			end

			local var_488_11 = 0
			local var_488_12 = 0.1

			if var_488_11 < arg_485_1.time_ and arg_485_1.time_ <= var_488_11 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_13 = arg_485_1:FormatText(StoryNameCfg[380].name)

				arg_485_1.leftNameTxt_.text = var_488_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_14 = arg_485_1:GetWordFromCfg(120421117)
				local var_488_15 = arg_485_1:FormatText(var_488_14.content)

				arg_485_1.text_.text = var_488_15

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_16 = 4
				local var_488_17 = utf8.len(var_488_15)
				local var_488_18 = var_488_16 <= 0 and var_488_12 or var_488_12 * (var_488_17 / var_488_16)

				if var_488_18 > 0 and var_488_12 < var_488_18 then
					arg_485_1.talkMaxDuration = var_488_18

					if var_488_18 + var_488_11 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_18 + var_488_11
					end
				end

				arg_485_1.text_.text = var_488_15
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421117", "story_v_out_120421.awb") ~= 0 then
					local var_488_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421117", "story_v_out_120421.awb") / 1000

					if var_488_19 + var_488_11 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_19 + var_488_11
					end

					if var_488_14.prefab_name ~= "" and arg_485_1.actors_[var_488_14.prefab_name] ~= nil then
						local var_488_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_14.prefab_name].transform, "story_v_out_120421", "120421117", "story_v_out_120421.awb")

						arg_485_1:RecordAudio("120421117", var_488_20)
						arg_485_1:RecordAudio("120421117", var_488_20)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_120421", "120421117", "story_v_out_120421.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_120421", "120421117", "story_v_out_120421.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_21 = math.max(var_488_12, arg_485_1.talkMaxDuration)

			if var_488_11 <= arg_485_1.time_ and arg_485_1.time_ < var_488_11 + var_488_21 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_11) / var_488_21

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_11 + var_488_21 and arg_485_1.time_ < var_488_11 + var_488_21 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play120421118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 120421118
		arg_489_1.duration_ = 8.2

		local var_489_0 = {
			zh = 8.2,
			ja = 8.166
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play120421119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["10044ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect10044ui_story == nil then
				arg_489_1.var_.characterEffect10044ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.2

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect10044ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_489_1.var_.characterEffect10044ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect10044ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_489_1.var_.characterEffect10044ui_story.fillRatio = var_492_5
			end

			local var_492_6 = arg_489_1.actors_["1074ui_story"]
			local var_492_7 = 0

			if var_492_7 < arg_489_1.time_ and arg_489_1.time_ <= var_492_7 + arg_492_0 and not isNil(var_492_6) and arg_489_1.var_.characterEffect1074ui_story == nil then
				arg_489_1.var_.characterEffect1074ui_story = var_492_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_8 = 0.2

			if var_492_7 <= arg_489_1.time_ and arg_489_1.time_ < var_492_7 + var_492_8 and not isNil(var_492_6) then
				local var_492_9 = (arg_489_1.time_ - var_492_7) / var_492_8

				if arg_489_1.var_.characterEffect1074ui_story and not isNil(var_492_6) then
					arg_489_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= var_492_7 + var_492_8 and arg_489_1.time_ < var_492_7 + var_492_8 + arg_492_0 and not isNil(var_492_6) and arg_489_1.var_.characterEffect1074ui_story then
				arg_489_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_492_10 = 0
			local var_492_11 = 0.9

			if var_492_10 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_12 = arg_489_1:FormatText(StoryNameCfg[410].name)

				arg_489_1.leftNameTxt_.text = var_492_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_13 = arg_489_1:GetWordFromCfg(120421118)
				local var_492_14 = arg_489_1:FormatText(var_492_13.content)

				arg_489_1.text_.text = var_492_14

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_15 = 36
				local var_492_16 = utf8.len(var_492_14)
				local var_492_17 = var_492_15 <= 0 and var_492_11 or var_492_11 * (var_492_16 / var_492_15)

				if var_492_17 > 0 and var_492_11 < var_492_17 then
					arg_489_1.talkMaxDuration = var_492_17

					if var_492_17 + var_492_10 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_17 + var_492_10
					end
				end

				arg_489_1.text_.text = var_492_14
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421118", "story_v_out_120421.awb") ~= 0 then
					local var_492_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421118", "story_v_out_120421.awb") / 1000

					if var_492_18 + var_492_10 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_18 + var_492_10
					end

					if var_492_13.prefab_name ~= "" and arg_489_1.actors_[var_492_13.prefab_name] ~= nil then
						local var_492_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_13.prefab_name].transform, "story_v_out_120421", "120421118", "story_v_out_120421.awb")

						arg_489_1:RecordAudio("120421118", var_492_19)
						arg_489_1:RecordAudio("120421118", var_492_19)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_120421", "120421118", "story_v_out_120421.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_120421", "120421118", "story_v_out_120421.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_20 = math.max(var_492_11, arg_489_1.talkMaxDuration)

			if var_492_10 <= arg_489_1.time_ and arg_489_1.time_ < var_492_10 + var_492_20 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_10) / var_492_20

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_10 + var_492_20 and arg_489_1.time_ < var_492_10 + var_492_20 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play120421119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 120421119
		arg_493_1.duration_ = 4.8

		local var_493_0 = {
			zh = 0.999999999999,
			ja = 4.8
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play120421120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["10044ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect10044ui_story == nil then
				arg_493_1.var_.characterEffect10044ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect10044ui_story and not isNil(var_496_0) then
					arg_493_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect10044ui_story then
				arg_493_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_496_4 = arg_493_1.actors_["1074ui_story"]
			local var_496_5 = 0

			if var_496_5 < arg_493_1.time_ and arg_493_1.time_ <= var_496_5 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1074ui_story == nil then
				arg_493_1.var_.characterEffect1074ui_story = var_496_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_6 = 0.2

			if var_496_5 <= arg_493_1.time_ and arg_493_1.time_ < var_496_5 + var_496_6 and not isNil(var_496_4) then
				local var_496_7 = (arg_493_1.time_ - var_496_5) / var_496_6

				if arg_493_1.var_.characterEffect1074ui_story and not isNil(var_496_4) then
					local var_496_8 = Mathf.Lerp(0, 0.5, var_496_7)

					arg_493_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1074ui_story.fillRatio = var_496_8
				end
			end

			if arg_493_1.time_ >= var_496_5 + var_496_6 and arg_493_1.time_ < var_496_5 + var_496_6 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1074ui_story then
				local var_496_9 = 0.5

				arg_493_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1074ui_story.fillRatio = var_496_9
			end

			local var_496_10 = 0
			local var_496_11 = 0.125

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_12 = arg_493_1:FormatText(StoryNameCfg[380].name)

				arg_493_1.leftNameTxt_.text = var_496_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_13 = arg_493_1:GetWordFromCfg(120421119)
				local var_496_14 = arg_493_1:FormatText(var_496_13.content)

				arg_493_1.text_.text = var_496_14

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_15 = 5
				local var_496_16 = utf8.len(var_496_14)
				local var_496_17 = var_496_15 <= 0 and var_496_11 or var_496_11 * (var_496_16 / var_496_15)

				if var_496_17 > 0 and var_496_11 < var_496_17 then
					arg_493_1.talkMaxDuration = var_496_17

					if var_496_17 + var_496_10 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_17 + var_496_10
					end
				end

				arg_493_1.text_.text = var_496_14
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421119", "story_v_out_120421.awb") ~= 0 then
					local var_496_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421119", "story_v_out_120421.awb") / 1000

					if var_496_18 + var_496_10 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_18 + var_496_10
					end

					if var_496_13.prefab_name ~= "" and arg_493_1.actors_[var_496_13.prefab_name] ~= nil then
						local var_496_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_13.prefab_name].transform, "story_v_out_120421", "120421119", "story_v_out_120421.awb")

						arg_493_1:RecordAudio("120421119", var_496_19)
						arg_493_1:RecordAudio("120421119", var_496_19)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_120421", "120421119", "story_v_out_120421.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_120421", "120421119", "story_v_out_120421.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_20 = math.max(var_496_11, arg_493_1.talkMaxDuration)

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_20 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_10) / var_496_20

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_10 + var_496_20 and arg_493_1.time_ < var_496_10 + var_496_20 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play120421120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 120421120
		arg_497_1.duration_ = 8.1

		local var_497_0 = {
			zh = 4.3,
			ja = 8.1
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
				arg_497_0:Play120421121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1075ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1075ui_story == nil then
				arg_497_1.var_.characterEffect1075ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.2

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1075ui_story and not isNil(var_500_0) then
					arg_497_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1075ui_story then
				arg_497_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_500_4 = arg_497_1.actors_["1074ui_story"]
			local var_500_5 = 0

			if var_500_5 < arg_497_1.time_ and arg_497_1.time_ <= var_500_5 + arg_500_0 and not isNil(var_500_4) and arg_497_1.var_.characterEffect1074ui_story == nil then
				arg_497_1.var_.characterEffect1074ui_story = var_500_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_6 = 0.2

			if var_500_5 <= arg_497_1.time_ and arg_497_1.time_ < var_500_5 + var_500_6 and not isNil(var_500_4) then
				local var_500_7 = (arg_497_1.time_ - var_500_5) / var_500_6

				if arg_497_1.var_.characterEffect1074ui_story and not isNil(var_500_4) then
					local var_500_8 = Mathf.Lerp(0, 0.5, var_500_7)

					arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1074ui_story.fillRatio = var_500_8
				end
			end

			if arg_497_1.time_ >= var_500_5 + var_500_6 and arg_497_1.time_ < var_500_5 + var_500_6 + arg_500_0 and not isNil(var_500_4) and arg_497_1.var_.characterEffect1074ui_story then
				local var_500_9 = 0.5

				arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1074ui_story.fillRatio = var_500_9
			end

			local var_500_10 = 0

			if var_500_10 < arg_497_1.time_ and arg_497_1.time_ <= var_500_10 + arg_500_0 then
				arg_497_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_500_11 = arg_497_1.actors_["1075ui_story"].transform
			local var_500_12 = 0

			if var_500_12 < arg_497_1.time_ and arg_497_1.time_ <= var_500_12 + arg_500_0 then
				arg_497_1.var_.moveOldPos1075ui_story = var_500_11.localPosition
			end

			local var_500_13 = 0.001

			if var_500_12 <= arg_497_1.time_ and arg_497_1.time_ < var_500_12 + var_500_13 then
				local var_500_14 = (arg_497_1.time_ - var_500_12) / var_500_13
				local var_500_15 = Vector3.New(0.7, -1.055, -6.16)

				var_500_11.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1075ui_story, var_500_15, var_500_14)

				local var_500_16 = manager.ui.mainCamera.transform.position - var_500_11.position

				var_500_11.forward = Vector3.New(var_500_16.x, var_500_16.y, var_500_16.z)

				local var_500_17 = var_500_11.localEulerAngles

				var_500_17.z = 0
				var_500_17.x = 0
				var_500_11.localEulerAngles = var_500_17
			end

			if arg_497_1.time_ >= var_500_12 + var_500_13 and arg_497_1.time_ < var_500_12 + var_500_13 + arg_500_0 then
				var_500_11.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_500_18 = manager.ui.mainCamera.transform.position - var_500_11.position

				var_500_11.forward = Vector3.New(var_500_18.x, var_500_18.y, var_500_18.z)

				local var_500_19 = var_500_11.localEulerAngles

				var_500_19.z = 0
				var_500_19.x = 0
				var_500_11.localEulerAngles = var_500_19
			end

			local var_500_20 = arg_497_1.actors_["10044ui_story"].transform
			local var_500_21 = 0

			if var_500_21 < arg_497_1.time_ and arg_497_1.time_ <= var_500_21 + arg_500_0 then
				arg_497_1.var_.moveOldPos10044ui_story = var_500_20.localPosition
			end

			local var_500_22 = 0.001

			if var_500_21 <= arg_497_1.time_ and arg_497_1.time_ < var_500_21 + var_500_22 then
				local var_500_23 = (arg_497_1.time_ - var_500_21) / var_500_22
				local var_500_24 = Vector3.New(0, 100, 0)

				var_500_20.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10044ui_story, var_500_24, var_500_23)

				local var_500_25 = manager.ui.mainCamera.transform.position - var_500_20.position

				var_500_20.forward = Vector3.New(var_500_25.x, var_500_25.y, var_500_25.z)

				local var_500_26 = var_500_20.localEulerAngles

				var_500_26.z = 0
				var_500_26.x = 0
				var_500_20.localEulerAngles = var_500_26
			end

			if arg_497_1.time_ >= var_500_21 + var_500_22 and arg_497_1.time_ < var_500_21 + var_500_22 + arg_500_0 then
				var_500_20.localPosition = Vector3.New(0, 100, 0)

				local var_500_27 = manager.ui.mainCamera.transform.position - var_500_20.position

				var_500_20.forward = Vector3.New(var_500_27.x, var_500_27.y, var_500_27.z)

				local var_500_28 = var_500_20.localEulerAngles

				var_500_28.z = 0
				var_500_28.x = 0
				var_500_20.localEulerAngles = var_500_28
			end

			local var_500_29 = 0
			local var_500_30 = 0.5

			if var_500_29 < arg_497_1.time_ and arg_497_1.time_ <= var_500_29 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_31 = arg_497_1:FormatText(StoryNameCfg[381].name)

				arg_497_1.leftNameTxt_.text = var_500_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_32 = arg_497_1:GetWordFromCfg(120421120)
				local var_500_33 = arg_497_1:FormatText(var_500_32.content)

				arg_497_1.text_.text = var_500_33

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_34 = 20
				local var_500_35 = utf8.len(var_500_33)
				local var_500_36 = var_500_34 <= 0 and var_500_30 or var_500_30 * (var_500_35 / var_500_34)

				if var_500_36 > 0 and var_500_30 < var_500_36 then
					arg_497_1.talkMaxDuration = var_500_36

					if var_500_36 + var_500_29 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_36 + var_500_29
					end
				end

				arg_497_1.text_.text = var_500_33
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421120", "story_v_out_120421.awb") ~= 0 then
					local var_500_37 = manager.audio:GetVoiceLength("story_v_out_120421", "120421120", "story_v_out_120421.awb") / 1000

					if var_500_37 + var_500_29 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_37 + var_500_29
					end

					if var_500_32.prefab_name ~= "" and arg_497_1.actors_[var_500_32.prefab_name] ~= nil then
						local var_500_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_32.prefab_name].transform, "story_v_out_120421", "120421120", "story_v_out_120421.awb")

						arg_497_1:RecordAudio("120421120", var_500_38)
						arg_497_1:RecordAudio("120421120", var_500_38)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_120421", "120421120", "story_v_out_120421.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_120421", "120421120", "story_v_out_120421.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_39 = math.max(var_500_30, arg_497_1.talkMaxDuration)

			if var_500_29 <= arg_497_1.time_ and arg_497_1.time_ < var_500_29 + var_500_39 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_29) / var_500_39

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_29 + var_500_39 and arg_497_1.time_ < var_500_29 + var_500_39 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play120421121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 120421121
		arg_501_1.duration_ = 8.97

		local var_501_0 = {
			zh = 5.2,
			ja = 8.966
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play120421122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.625

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[381].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_3 = arg_501_1:GetWordFromCfg(120421121)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 25
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421121", "story_v_out_120421.awb") ~= 0 then
					local var_504_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421121", "story_v_out_120421.awb") / 1000

					if var_504_8 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_0
					end

					if var_504_3.prefab_name ~= "" and arg_501_1.actors_[var_504_3.prefab_name] ~= nil then
						local var_504_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_3.prefab_name].transform, "story_v_out_120421", "120421121", "story_v_out_120421.awb")

						arg_501_1:RecordAudio("120421121", var_504_9)
						arg_501_1:RecordAudio("120421121", var_504_9)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_120421", "120421121", "story_v_out_120421.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_120421", "120421121", "story_v_out_120421.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_10 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_10 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_10

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_10 and arg_501_1.time_ < var_504_0 + var_504_10 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play120421122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 120421122
		arg_505_1.duration_ = 3.87

		local var_505_0 = {
			zh = 2.366666666666,
			ja = 3.866
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play120421123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1075ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1075ui_story == nil then
				arg_505_1.var_.characterEffect1075ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1075ui_story and not isNil(var_508_0) then
					local var_508_4 = Mathf.Lerp(0, 0.5, var_508_3)

					arg_505_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1075ui_story.fillRatio = var_508_4
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1075ui_story then
				local var_508_5 = 0.5

				arg_505_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1075ui_story.fillRatio = var_508_5
			end

			local var_508_6 = arg_505_1.actors_["1074ui_story"]
			local var_508_7 = 0

			if var_508_7 < arg_505_1.time_ and arg_505_1.time_ <= var_508_7 + arg_508_0 and not isNil(var_508_6) and arg_505_1.var_.characterEffect1074ui_story == nil then
				arg_505_1.var_.characterEffect1074ui_story = var_508_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_8 = 0.2

			if var_508_7 <= arg_505_1.time_ and arg_505_1.time_ < var_508_7 + var_508_8 and not isNil(var_508_6) then
				local var_508_9 = (arg_505_1.time_ - var_508_7) / var_508_8

				if arg_505_1.var_.characterEffect1074ui_story and not isNil(var_508_6) then
					arg_505_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_7 + var_508_8 and arg_505_1.time_ < var_508_7 + var_508_8 + arg_508_0 and not isNil(var_508_6) and arg_505_1.var_.characterEffect1074ui_story then
				arg_505_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_508_10 = 0

			if var_508_10 < arg_505_1.time_ and arg_505_1.time_ <= var_508_10 + arg_508_0 then
				arg_505_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_508_11 = 0

			if var_508_11 < arg_505_1.time_ and arg_505_1.time_ <= var_508_11 + arg_508_0 then
				arg_505_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_508_12 = 0
			local var_508_13 = 0.175

			if var_508_12 < arg_505_1.time_ and arg_505_1.time_ <= var_508_12 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_14 = arg_505_1:FormatText(StoryNameCfg[410].name)

				arg_505_1.leftNameTxt_.text = var_508_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_15 = arg_505_1:GetWordFromCfg(120421122)
				local var_508_16 = arg_505_1:FormatText(var_508_15.content)

				arg_505_1.text_.text = var_508_16

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_17 = 7
				local var_508_18 = utf8.len(var_508_16)
				local var_508_19 = var_508_17 <= 0 and var_508_13 or var_508_13 * (var_508_18 / var_508_17)

				if var_508_19 > 0 and var_508_13 < var_508_19 then
					arg_505_1.talkMaxDuration = var_508_19

					if var_508_19 + var_508_12 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_19 + var_508_12
					end
				end

				arg_505_1.text_.text = var_508_16
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421122", "story_v_out_120421.awb") ~= 0 then
					local var_508_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421122", "story_v_out_120421.awb") / 1000

					if var_508_20 + var_508_12 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_20 + var_508_12
					end

					if var_508_15.prefab_name ~= "" and arg_505_1.actors_[var_508_15.prefab_name] ~= nil then
						local var_508_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_15.prefab_name].transform, "story_v_out_120421", "120421122", "story_v_out_120421.awb")

						arg_505_1:RecordAudio("120421122", var_508_21)
						arg_505_1:RecordAudio("120421122", var_508_21)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_120421", "120421122", "story_v_out_120421.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_120421", "120421122", "story_v_out_120421.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_22 = math.max(var_508_13, arg_505_1.talkMaxDuration)

			if var_508_12 <= arg_505_1.time_ and arg_505_1.time_ < var_508_12 + var_508_22 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_12) / var_508_22

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_12 + var_508_22 and arg_505_1.time_ < var_508_12 + var_508_22 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play120421123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 120421123
		arg_509_1.duration_ = 7.77

		local var_509_0 = {
			zh = 4.033,
			ja = 7.766
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play120421124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1075ui_story"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1075ui_story == nil then
				arg_509_1.var_.characterEffect1075ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.2

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.characterEffect1075ui_story and not isNil(var_512_0) then
					arg_509_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1075ui_story then
				arg_509_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_512_4 = arg_509_1.actors_["1074ui_story"]
			local var_512_5 = 0

			if var_512_5 < arg_509_1.time_ and arg_509_1.time_ <= var_512_5 + arg_512_0 and not isNil(var_512_4) and arg_509_1.var_.characterEffect1074ui_story == nil then
				arg_509_1.var_.characterEffect1074ui_story = var_512_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_6 = 0.2

			if var_512_5 <= arg_509_1.time_ and arg_509_1.time_ < var_512_5 + var_512_6 and not isNil(var_512_4) then
				local var_512_7 = (arg_509_1.time_ - var_512_5) / var_512_6

				if arg_509_1.var_.characterEffect1074ui_story and not isNil(var_512_4) then
					local var_512_8 = Mathf.Lerp(0, 0.5, var_512_7)

					arg_509_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1074ui_story.fillRatio = var_512_8
				end
			end

			if arg_509_1.time_ >= var_512_5 + var_512_6 and arg_509_1.time_ < var_512_5 + var_512_6 + arg_512_0 and not isNil(var_512_4) and arg_509_1.var_.characterEffect1074ui_story then
				local var_512_9 = 0.5

				arg_509_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1074ui_story.fillRatio = var_512_9
			end

			local var_512_10 = 0

			if var_512_10 < arg_509_1.time_ and arg_509_1.time_ <= var_512_10 + arg_512_0 then
				arg_509_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_512_11 = 0

			if var_512_11 < arg_509_1.time_ and arg_509_1.time_ <= var_512_11 + arg_512_0 then
				arg_509_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_512_12 = 0
			local var_512_13 = 0.525

			if var_512_12 < arg_509_1.time_ and arg_509_1.time_ <= var_512_12 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_14 = arg_509_1:FormatText(StoryNameCfg[381].name)

				arg_509_1.leftNameTxt_.text = var_512_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_15 = arg_509_1:GetWordFromCfg(120421123)
				local var_512_16 = arg_509_1:FormatText(var_512_15.content)

				arg_509_1.text_.text = var_512_16

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_17 = 21
				local var_512_18 = utf8.len(var_512_16)
				local var_512_19 = var_512_17 <= 0 and var_512_13 or var_512_13 * (var_512_18 / var_512_17)

				if var_512_19 > 0 and var_512_13 < var_512_19 then
					arg_509_1.talkMaxDuration = var_512_19

					if var_512_19 + var_512_12 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_19 + var_512_12
					end
				end

				arg_509_1.text_.text = var_512_16
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421123", "story_v_out_120421.awb") ~= 0 then
					local var_512_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421123", "story_v_out_120421.awb") / 1000

					if var_512_20 + var_512_12 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_20 + var_512_12
					end

					if var_512_15.prefab_name ~= "" and arg_509_1.actors_[var_512_15.prefab_name] ~= nil then
						local var_512_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_15.prefab_name].transform, "story_v_out_120421", "120421123", "story_v_out_120421.awb")

						arg_509_1:RecordAudio("120421123", var_512_21)
						arg_509_1:RecordAudio("120421123", var_512_21)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_120421", "120421123", "story_v_out_120421.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_120421", "120421123", "story_v_out_120421.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_22 = math.max(var_512_13, arg_509_1.talkMaxDuration)

			if var_512_12 <= arg_509_1.time_ and arg_509_1.time_ < var_512_12 + var_512_22 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_12) / var_512_22

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_12 + var_512_22 and arg_509_1.time_ < var_512_12 + var_512_22 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play120421124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 120421124
		arg_513_1.duration_ = 8.5

		local var_513_0 = {
			zh = 4.8,
			ja = 8.5
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play120421125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.6

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[381].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:GetWordFromCfg(120421124)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 24
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421124", "story_v_out_120421.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421124", "story_v_out_120421.awb") / 1000

					if var_516_8 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_0
					end

					if var_516_3.prefab_name ~= "" and arg_513_1.actors_[var_516_3.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_3.prefab_name].transform, "story_v_out_120421", "120421124", "story_v_out_120421.awb")

						arg_513_1:RecordAudio("120421124", var_516_9)
						arg_513_1:RecordAudio("120421124", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_120421", "120421124", "story_v_out_120421.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_120421", "120421124", "story_v_out_120421.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_10 and arg_513_1.time_ < var_516_0 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play120421125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 120421125
		arg_517_1.duration_ = 11.47

		local var_517_0 = {
			zh = 8.566,
			ja = 11.466
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play120421126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 1.1

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[381].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:GetWordFromCfg(120421125)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 44
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421125", "story_v_out_120421.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421125", "story_v_out_120421.awb") / 1000

					if var_520_8 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_0
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_out_120421", "120421125", "story_v_out_120421.awb")

						arg_517_1:RecordAudio("120421125", var_520_9)
						arg_517_1:RecordAudio("120421125", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_120421", "120421125", "story_v_out_120421.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_120421", "120421125", "story_v_out_120421.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_10 and arg_517_1.time_ < var_520_0 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play120421126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 120421126
		arg_521_1.duration_ = 3.5

		local var_521_0 = {
			zh = 3.5,
			ja = 1.999999999999
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play120421127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1075ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1075ui_story == nil then
				arg_521_1.var_.characterEffect1075ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect1075ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1075ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1075ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1075ui_story.fillRatio = var_524_5
			end

			local var_524_6 = arg_521_1.actors_["1074ui_story"]
			local var_524_7 = 0

			if var_524_7 < arg_521_1.time_ and arg_521_1.time_ <= var_524_7 + arg_524_0 and not isNil(var_524_6) and arg_521_1.var_.characterEffect1074ui_story == nil then
				arg_521_1.var_.characterEffect1074ui_story = var_524_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_8 = 0.2

			if var_524_7 <= arg_521_1.time_ and arg_521_1.time_ < var_524_7 + var_524_8 and not isNil(var_524_6) then
				local var_524_9 = (arg_521_1.time_ - var_524_7) / var_524_8

				if arg_521_1.var_.characterEffect1074ui_story and not isNil(var_524_6) then
					arg_521_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= var_524_7 + var_524_8 and arg_521_1.time_ < var_524_7 + var_524_8 + arg_524_0 and not isNil(var_524_6) and arg_521_1.var_.characterEffect1074ui_story then
				arg_521_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_524_10 = 0

			if var_524_10 < arg_521_1.time_ and arg_521_1.time_ <= var_524_10 + arg_524_0 then
				arg_521_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_524_11 = 0

			if var_524_11 < arg_521_1.time_ and arg_521_1.time_ <= var_524_11 + arg_524_0 then
				arg_521_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_524_12 = 0
			local var_524_13 = 0.125

			if var_524_12 < arg_521_1.time_ and arg_521_1.time_ <= var_524_12 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_14 = arg_521_1:FormatText(StoryNameCfg[410].name)

				arg_521_1.leftNameTxt_.text = var_524_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_15 = arg_521_1:GetWordFromCfg(120421126)
				local var_524_16 = arg_521_1:FormatText(var_524_15.content)

				arg_521_1.text_.text = var_524_16

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_17 = 5
				local var_524_18 = utf8.len(var_524_16)
				local var_524_19 = var_524_17 <= 0 and var_524_13 or var_524_13 * (var_524_18 / var_524_17)

				if var_524_19 > 0 and var_524_13 < var_524_19 then
					arg_521_1.talkMaxDuration = var_524_19

					if var_524_19 + var_524_12 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_19 + var_524_12
					end
				end

				arg_521_1.text_.text = var_524_16
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421126", "story_v_out_120421.awb") ~= 0 then
					local var_524_20 = manager.audio:GetVoiceLength("story_v_out_120421", "120421126", "story_v_out_120421.awb") / 1000

					if var_524_20 + var_524_12 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_20 + var_524_12
					end

					if var_524_15.prefab_name ~= "" and arg_521_1.actors_[var_524_15.prefab_name] ~= nil then
						local var_524_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_15.prefab_name].transform, "story_v_out_120421", "120421126", "story_v_out_120421.awb")

						arg_521_1:RecordAudio("120421126", var_524_21)
						arg_521_1:RecordAudio("120421126", var_524_21)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_120421", "120421126", "story_v_out_120421.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_120421", "120421126", "story_v_out_120421.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_22 = math.max(var_524_13, arg_521_1.talkMaxDuration)

			if var_524_12 <= arg_521_1.time_ and arg_521_1.time_ < var_524_12 + var_524_22 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_12) / var_524_22

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_12 + var_524_22 and arg_521_1.time_ < var_524_12 + var_524_22 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play120421127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 120421127
		arg_525_1.duration_ = 9.4

		local var_525_0 = {
			zh = 5.633,
			ja = 9.4
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play120421128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["10044ui_story"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect10044ui_story == nil then
				arg_525_1.var_.characterEffect10044ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.2

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect10044ui_story and not isNil(var_528_0) then
					arg_525_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect10044ui_story then
				arg_525_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_528_4 = arg_525_1.actors_["1074ui_story"]
			local var_528_5 = 0

			if var_528_5 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 and not isNil(var_528_4) and arg_525_1.var_.characterEffect1074ui_story == nil then
				arg_525_1.var_.characterEffect1074ui_story = var_528_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_6 = 0.2

			if var_528_5 <= arg_525_1.time_ and arg_525_1.time_ < var_528_5 + var_528_6 and not isNil(var_528_4) then
				local var_528_7 = (arg_525_1.time_ - var_528_5) / var_528_6

				if arg_525_1.var_.characterEffect1074ui_story and not isNil(var_528_4) then
					local var_528_8 = Mathf.Lerp(0, 0.5, var_528_7)

					arg_525_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1074ui_story.fillRatio = var_528_8
				end
			end

			if arg_525_1.time_ >= var_528_5 + var_528_6 and arg_525_1.time_ < var_528_5 + var_528_6 + arg_528_0 and not isNil(var_528_4) and arg_525_1.var_.characterEffect1074ui_story then
				local var_528_9 = 0.5

				arg_525_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1074ui_story.fillRatio = var_528_9
			end

			local var_528_10 = 0

			if var_528_10 < arg_525_1.time_ and arg_525_1.time_ <= var_528_10 + arg_528_0 then
				arg_525_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_528_11 = 0

			if var_528_11 < arg_525_1.time_ and arg_525_1.time_ <= var_528_11 + arg_528_0 then
				arg_525_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_528_12 = arg_525_1.actors_["1075ui_story"].transform
			local var_528_13 = 0

			if var_528_13 < arg_525_1.time_ and arg_525_1.time_ <= var_528_13 + arg_528_0 then
				arg_525_1.var_.moveOldPos1075ui_story = var_528_12.localPosition
			end

			local var_528_14 = 0.001

			if var_528_13 <= arg_525_1.time_ and arg_525_1.time_ < var_528_13 + var_528_14 then
				local var_528_15 = (arg_525_1.time_ - var_528_13) / var_528_14
				local var_528_16 = Vector3.New(0, 100, 0)

				var_528_12.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1075ui_story, var_528_16, var_528_15)

				local var_528_17 = manager.ui.mainCamera.transform.position - var_528_12.position

				var_528_12.forward = Vector3.New(var_528_17.x, var_528_17.y, var_528_17.z)

				local var_528_18 = var_528_12.localEulerAngles

				var_528_18.z = 0
				var_528_18.x = 0
				var_528_12.localEulerAngles = var_528_18
			end

			if arg_525_1.time_ >= var_528_13 + var_528_14 and arg_525_1.time_ < var_528_13 + var_528_14 + arg_528_0 then
				var_528_12.localPosition = Vector3.New(0, 100, 0)

				local var_528_19 = manager.ui.mainCamera.transform.position - var_528_12.position

				var_528_12.forward = Vector3.New(var_528_19.x, var_528_19.y, var_528_19.z)

				local var_528_20 = var_528_12.localEulerAngles

				var_528_20.z = 0
				var_528_20.x = 0
				var_528_12.localEulerAngles = var_528_20
			end

			local var_528_21 = arg_525_1.actors_["10044ui_story"].transform
			local var_528_22 = 0

			if var_528_22 < arg_525_1.time_ and arg_525_1.time_ <= var_528_22 + arg_528_0 then
				arg_525_1.var_.moveOldPos10044ui_story = var_528_21.localPosition
			end

			local var_528_23 = 0.001

			if var_528_22 <= arg_525_1.time_ and arg_525_1.time_ < var_528_22 + var_528_23 then
				local var_528_24 = (arg_525_1.time_ - var_528_22) / var_528_23
				local var_528_25 = Vector3.New(0.7, -0.72, -6.3)

				var_528_21.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10044ui_story, var_528_25, var_528_24)

				local var_528_26 = manager.ui.mainCamera.transform.position - var_528_21.position

				var_528_21.forward = Vector3.New(var_528_26.x, var_528_26.y, var_528_26.z)

				local var_528_27 = var_528_21.localEulerAngles

				var_528_27.z = 0
				var_528_27.x = 0
				var_528_21.localEulerAngles = var_528_27
			end

			if arg_525_1.time_ >= var_528_22 + var_528_23 and arg_525_1.time_ < var_528_22 + var_528_23 + arg_528_0 then
				var_528_21.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_528_28 = manager.ui.mainCamera.transform.position - var_528_21.position

				var_528_21.forward = Vector3.New(var_528_28.x, var_528_28.y, var_528_28.z)

				local var_528_29 = var_528_21.localEulerAngles

				var_528_29.z = 0
				var_528_29.x = 0
				var_528_21.localEulerAngles = var_528_29
			end

			local var_528_30 = 0
			local var_528_31 = 0.575

			if var_528_30 < arg_525_1.time_ and arg_525_1.time_ <= var_528_30 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_32 = arg_525_1:FormatText(StoryNameCfg[380].name)

				arg_525_1.leftNameTxt_.text = var_528_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_33 = arg_525_1:GetWordFromCfg(120421127)
				local var_528_34 = arg_525_1:FormatText(var_528_33.content)

				arg_525_1.text_.text = var_528_34

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_35 = 23
				local var_528_36 = utf8.len(var_528_34)
				local var_528_37 = var_528_35 <= 0 and var_528_31 or var_528_31 * (var_528_36 / var_528_35)

				if var_528_37 > 0 and var_528_31 < var_528_37 then
					arg_525_1.talkMaxDuration = var_528_37

					if var_528_37 + var_528_30 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_37 + var_528_30
					end
				end

				arg_525_1.text_.text = var_528_34
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421127", "story_v_out_120421.awb") ~= 0 then
					local var_528_38 = manager.audio:GetVoiceLength("story_v_out_120421", "120421127", "story_v_out_120421.awb") / 1000

					if var_528_38 + var_528_30 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_38 + var_528_30
					end

					if var_528_33.prefab_name ~= "" and arg_525_1.actors_[var_528_33.prefab_name] ~= nil then
						local var_528_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_33.prefab_name].transform, "story_v_out_120421", "120421127", "story_v_out_120421.awb")

						arg_525_1:RecordAudio("120421127", var_528_39)
						arg_525_1:RecordAudio("120421127", var_528_39)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_120421", "120421127", "story_v_out_120421.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_120421", "120421127", "story_v_out_120421.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_40 = math.max(var_528_31, arg_525_1.talkMaxDuration)

			if var_528_30 <= arg_525_1.time_ and arg_525_1.time_ < var_528_30 + var_528_40 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_30) / var_528_40

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_30 + var_528_40 and arg_525_1.time_ < var_528_30 + var_528_40 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play120421128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 120421128
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play120421129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["10044ui_story"].transform
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.var_.moveOldPos10044ui_story = var_532_0.localPosition
			end

			local var_532_2 = 0.001

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2
				local var_532_4 = Vector3.New(0, 100, 0)

				var_532_0.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10044ui_story, var_532_4, var_532_3)

				local var_532_5 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_5.x, var_532_5.y, var_532_5.z)

				local var_532_6 = var_532_0.localEulerAngles

				var_532_6.z = 0
				var_532_6.x = 0
				var_532_0.localEulerAngles = var_532_6
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 then
				var_532_0.localPosition = Vector3.New(0, 100, 0)

				local var_532_7 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_7.x, var_532_7.y, var_532_7.z)

				local var_532_8 = var_532_0.localEulerAngles

				var_532_8.z = 0
				var_532_8.x = 0
				var_532_0.localEulerAngles = var_532_8
			end

			local var_532_9 = arg_529_1.actors_["1074ui_story"].transform
			local var_532_10 = 0

			if var_532_10 < arg_529_1.time_ and arg_529_1.time_ <= var_532_10 + arg_532_0 then
				arg_529_1.var_.moveOldPos1074ui_story = var_532_9.localPosition
			end

			local var_532_11 = 0.001

			if var_532_10 <= arg_529_1.time_ and arg_529_1.time_ < var_532_10 + var_532_11 then
				local var_532_12 = (arg_529_1.time_ - var_532_10) / var_532_11
				local var_532_13 = Vector3.New(0, 100, 0)

				var_532_9.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1074ui_story, var_532_13, var_532_12)

				local var_532_14 = manager.ui.mainCamera.transform.position - var_532_9.position

				var_532_9.forward = Vector3.New(var_532_14.x, var_532_14.y, var_532_14.z)

				local var_532_15 = var_532_9.localEulerAngles

				var_532_15.z = 0
				var_532_15.x = 0
				var_532_9.localEulerAngles = var_532_15
			end

			if arg_529_1.time_ >= var_532_10 + var_532_11 and arg_529_1.time_ < var_532_10 + var_532_11 + arg_532_0 then
				var_532_9.localPosition = Vector3.New(0, 100, 0)

				local var_532_16 = manager.ui.mainCamera.transform.position - var_532_9.position

				var_532_9.forward = Vector3.New(var_532_16.x, var_532_16.y, var_532_16.z)

				local var_532_17 = var_532_9.localEulerAngles

				var_532_17.z = 0
				var_532_17.x = 0
				var_532_9.localEulerAngles = var_532_17
			end

			local var_532_18 = 0
			local var_532_19 = 1.075

			if var_532_18 < arg_529_1.time_ and arg_529_1.time_ <= var_532_18 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_20 = arg_529_1:GetWordFromCfg(120421128)
				local var_532_21 = arg_529_1:FormatText(var_532_20.content)

				arg_529_1.text_.text = var_532_21

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_22 = 43
				local var_532_23 = utf8.len(var_532_21)
				local var_532_24 = var_532_22 <= 0 and var_532_19 or var_532_19 * (var_532_23 / var_532_22)

				if var_532_24 > 0 and var_532_19 < var_532_24 then
					arg_529_1.talkMaxDuration = var_532_24

					if var_532_24 + var_532_18 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_24 + var_532_18
					end
				end

				arg_529_1.text_.text = var_532_21
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_25 = math.max(var_532_19, arg_529_1.talkMaxDuration)

			if var_532_18 <= arg_529_1.time_ and arg_529_1.time_ < var_532_18 + var_532_25 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_18) / var_532_25

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_18 + var_532_25 and arg_529_1.time_ < var_532_18 + var_532_25 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play120421129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 120421129
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play120421130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 1.1

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_2 = arg_533_1:GetWordFromCfg(120421129)
				local var_536_3 = arg_533_1:FormatText(var_536_2.content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 44
				local var_536_5 = utf8.len(var_536_3)
				local var_536_6 = var_536_4 <= 0 and var_536_1 or var_536_1 * (var_536_5 / var_536_4)

				if var_536_6 > 0 and var_536_1 < var_536_6 then
					arg_533_1.talkMaxDuration = var_536_6

					if var_536_6 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_6 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_7 and arg_533_1.time_ < var_536_0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play120421130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 120421130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play120421131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.825

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_2 = arg_537_1:GetWordFromCfg(120421130)
				local var_540_3 = arg_537_1:FormatText(var_540_2.content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 33
				local var_540_5 = utf8.len(var_540_3)
				local var_540_6 = var_540_4 <= 0 and var_540_1 or var_540_1 * (var_540_5 / var_540_4)

				if var_540_6 > 0 and var_540_1 < var_540_6 then
					arg_537_1.talkMaxDuration = var_540_6

					if var_540_6 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_7 and arg_537_1.time_ < var_540_0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play120421131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 120421131
		arg_541_1.duration_ = 4.53

		local var_541_0 = {
			zh = 4.533,
			ja = 3.5
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play120421132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["10044ui_story"].transform
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.var_.moveOldPos10044ui_story = var_544_0.localPosition
			end

			local var_544_2 = 0.001

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2
				local var_544_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_544_0.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10044ui_story, var_544_4, var_544_3)

				local var_544_5 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_5.x, var_544_5.y, var_544_5.z)

				local var_544_6 = var_544_0.localEulerAngles

				var_544_6.z = 0
				var_544_6.x = 0
				var_544_0.localEulerAngles = var_544_6
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 then
				var_544_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_544_7 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_7.x, var_544_7.y, var_544_7.z)

				local var_544_8 = var_544_0.localEulerAngles

				var_544_8.z = 0
				var_544_8.x = 0
				var_544_0.localEulerAngles = var_544_8
			end

			local var_544_9 = 0

			if var_544_9 < arg_541_1.time_ and arg_541_1.time_ <= var_544_9 + arg_544_0 then
				arg_541_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_544_10 = 0

			if var_544_10 < arg_541_1.time_ and arg_541_1.time_ <= var_544_10 + arg_544_0 then
				arg_541_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_544_11 = arg_541_1.actors_["10044ui_story"]
			local var_544_12 = 0

			if var_544_12 < arg_541_1.time_ and arg_541_1.time_ <= var_544_12 + arg_544_0 and not isNil(var_544_11) and arg_541_1.var_.characterEffect10044ui_story == nil then
				arg_541_1.var_.characterEffect10044ui_story = var_544_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_13 = 0.2

			if var_544_12 <= arg_541_1.time_ and arg_541_1.time_ < var_544_12 + var_544_13 and not isNil(var_544_11) then
				local var_544_14 = (arg_541_1.time_ - var_544_12) / var_544_13

				if arg_541_1.var_.characterEffect10044ui_story and not isNil(var_544_11) then
					arg_541_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= var_544_12 + var_544_13 and arg_541_1.time_ < var_544_12 + var_544_13 + arg_544_0 and not isNil(var_544_11) and arg_541_1.var_.characterEffect10044ui_story then
				arg_541_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_544_15 = arg_541_1.actors_["1074ui_story"].transform
			local var_544_16 = 0

			if var_544_16 < arg_541_1.time_ and arg_541_1.time_ <= var_544_16 + arg_544_0 then
				arg_541_1.var_.moveOldPos1074ui_story = var_544_15.localPosition
			end

			local var_544_17 = 0.001

			if var_544_16 <= arg_541_1.time_ and arg_541_1.time_ < var_544_16 + var_544_17 then
				local var_544_18 = (arg_541_1.time_ - var_544_16) / var_544_17
				local var_544_19 = Vector3.New(0.7, -1.055, -6.12)

				var_544_15.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1074ui_story, var_544_19, var_544_18)

				local var_544_20 = manager.ui.mainCamera.transform.position - var_544_15.position

				var_544_15.forward = Vector3.New(var_544_20.x, var_544_20.y, var_544_20.z)

				local var_544_21 = var_544_15.localEulerAngles

				var_544_21.z = 0
				var_544_21.x = 0
				var_544_15.localEulerAngles = var_544_21
			end

			if arg_541_1.time_ >= var_544_16 + var_544_17 and arg_541_1.time_ < var_544_16 + var_544_17 + arg_544_0 then
				var_544_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_544_22 = manager.ui.mainCamera.transform.position - var_544_15.position

				var_544_15.forward = Vector3.New(var_544_22.x, var_544_22.y, var_544_22.z)

				local var_544_23 = var_544_15.localEulerAngles

				var_544_23.z = 0
				var_544_23.x = 0
				var_544_15.localEulerAngles = var_544_23
			end

			local var_544_24 = 0

			if var_544_24 < arg_541_1.time_ and arg_541_1.time_ <= var_544_24 + arg_544_0 then
				arg_541_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_544_25 = 0
			local var_544_26 = 0.525

			if var_544_25 < arg_541_1.time_ and arg_541_1.time_ <= var_544_25 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_27 = arg_541_1:FormatText(StoryNameCfg[380].name)

				arg_541_1.leftNameTxt_.text = var_544_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_28 = arg_541_1:GetWordFromCfg(120421131)
				local var_544_29 = arg_541_1:FormatText(var_544_28.content)

				arg_541_1.text_.text = var_544_29

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_30 = 21
				local var_544_31 = utf8.len(var_544_29)
				local var_544_32 = var_544_30 <= 0 and var_544_26 or var_544_26 * (var_544_31 / var_544_30)

				if var_544_32 > 0 and var_544_26 < var_544_32 then
					arg_541_1.talkMaxDuration = var_544_32

					if var_544_32 + var_544_25 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_32 + var_544_25
					end
				end

				arg_541_1.text_.text = var_544_29
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421131", "story_v_out_120421.awb") ~= 0 then
					local var_544_33 = manager.audio:GetVoiceLength("story_v_out_120421", "120421131", "story_v_out_120421.awb") / 1000

					if var_544_33 + var_544_25 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_33 + var_544_25
					end

					if var_544_28.prefab_name ~= "" and arg_541_1.actors_[var_544_28.prefab_name] ~= nil then
						local var_544_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_28.prefab_name].transform, "story_v_out_120421", "120421131", "story_v_out_120421.awb")

						arg_541_1:RecordAudio("120421131", var_544_34)
						arg_541_1:RecordAudio("120421131", var_544_34)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_120421", "120421131", "story_v_out_120421.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_120421", "120421131", "story_v_out_120421.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_35 = math.max(var_544_26, arg_541_1.talkMaxDuration)

			if var_544_25 <= arg_541_1.time_ and arg_541_1.time_ < var_544_25 + var_544_35 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_25) / var_544_35

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_25 + var_544_35 and arg_541_1.time_ < var_544_25 + var_544_35 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play120421132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 120421132
		arg_545_1.duration_ = 2

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play120421133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["10044ui_story"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10044ui_story == nil then
				arg_545_1.var_.characterEffect10044ui_story = var_548_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.2

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.characterEffect10044ui_story and not isNil(var_548_0) then
					local var_548_4 = Mathf.Lerp(0, 0.5, var_548_3)

					arg_545_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_545_1.var_.characterEffect10044ui_story.fillRatio = var_548_4
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10044ui_story then
				local var_548_5 = 0.5

				arg_545_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_545_1.var_.characterEffect10044ui_story.fillRatio = var_548_5
			end

			local var_548_6 = 0

			if var_548_6 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_548_7 = arg_545_1.actors_["1074ui_story"]
			local var_548_8 = 0

			if var_548_8 < arg_545_1.time_ and arg_545_1.time_ <= var_548_8 + arg_548_0 and not isNil(var_548_7) and arg_545_1.var_.characterEffect1074ui_story == nil then
				arg_545_1.var_.characterEffect1074ui_story = var_548_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_9 = 0.2

			if var_548_8 <= arg_545_1.time_ and arg_545_1.time_ < var_548_8 + var_548_9 and not isNil(var_548_7) then
				local var_548_10 = (arg_545_1.time_ - var_548_8) / var_548_9

				if arg_545_1.var_.characterEffect1074ui_story and not isNil(var_548_7) then
					arg_545_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= var_548_8 + var_548_9 and arg_545_1.time_ < var_548_8 + var_548_9 + arg_548_0 and not isNil(var_548_7) and arg_545_1.var_.characterEffect1074ui_story then
				arg_545_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_548_11 = 0
			local var_548_12 = 0.125

			if var_548_11 < arg_545_1.time_ and arg_545_1.time_ <= var_548_11 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_13 = arg_545_1:FormatText(StoryNameCfg[410].name)

				arg_545_1.leftNameTxt_.text = var_548_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_14 = arg_545_1:GetWordFromCfg(120421132)
				local var_548_15 = arg_545_1:FormatText(var_548_14.content)

				arg_545_1.text_.text = var_548_15

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_16 = 5
				local var_548_17 = utf8.len(var_548_15)
				local var_548_18 = var_548_16 <= 0 and var_548_12 or var_548_12 * (var_548_17 / var_548_16)

				if var_548_18 > 0 and var_548_12 < var_548_18 then
					arg_545_1.talkMaxDuration = var_548_18

					if var_548_18 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_18 + var_548_11
					end
				end

				arg_545_1.text_.text = var_548_15
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421132", "story_v_out_120421.awb") ~= 0 then
					local var_548_19 = manager.audio:GetVoiceLength("story_v_out_120421", "120421132", "story_v_out_120421.awb") / 1000

					if var_548_19 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_19 + var_548_11
					end

					if var_548_14.prefab_name ~= "" and arg_545_1.actors_[var_548_14.prefab_name] ~= nil then
						local var_548_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_14.prefab_name].transform, "story_v_out_120421", "120421132", "story_v_out_120421.awb")

						arg_545_1:RecordAudio("120421132", var_548_20)
						arg_545_1:RecordAudio("120421132", var_548_20)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_120421", "120421132", "story_v_out_120421.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_120421", "120421132", "story_v_out_120421.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_21 = math.max(var_548_12, arg_545_1.talkMaxDuration)

			if var_548_11 <= arg_545_1.time_ and arg_545_1.time_ < var_548_11 + var_548_21 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_11) / var_548_21

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_11 + var_548_21 and arg_545_1.time_ < var_548_11 + var_548_21 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play120421133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 120421133
		arg_549_1.duration_ = 7.3

		local var_549_0 = {
			zh = 3.3,
			ja = 7.3
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play120421134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_552_1 = arg_549_1.actors_["1074ui_story"]
			local var_552_2 = 0

			if var_552_2 < arg_549_1.time_ and arg_549_1.time_ <= var_552_2 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1074ui_story == nil then
				arg_549_1.var_.characterEffect1074ui_story = var_552_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_3 = 0.2

			if var_552_2 <= arg_549_1.time_ and arg_549_1.time_ < var_552_2 + var_552_3 and not isNil(var_552_1) then
				local var_552_4 = (arg_549_1.time_ - var_552_2) / var_552_3

				if arg_549_1.var_.characterEffect1074ui_story and not isNil(var_552_1) then
					arg_549_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_2 + var_552_3 and arg_549_1.time_ < var_552_2 + var_552_3 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1074ui_story then
				arg_549_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_552_5 = 0
			local var_552_6 = 0.25

			if var_552_5 < arg_549_1.time_ and arg_549_1.time_ <= var_552_5 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_7 = arg_549_1:FormatText(StoryNameCfg[410].name)

				arg_549_1.leftNameTxt_.text = var_552_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_8 = arg_549_1:GetWordFromCfg(120421133)
				local var_552_9 = arg_549_1:FormatText(var_552_8.content)

				arg_549_1.text_.text = var_552_9

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_10 = 10
				local var_552_11 = utf8.len(var_552_9)
				local var_552_12 = var_552_10 <= 0 and var_552_6 or var_552_6 * (var_552_11 / var_552_10)

				if var_552_12 > 0 and var_552_6 < var_552_12 then
					arg_549_1.talkMaxDuration = var_552_12

					if var_552_12 + var_552_5 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_12 + var_552_5
					end
				end

				arg_549_1.text_.text = var_552_9
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421133", "story_v_out_120421.awb") ~= 0 then
					local var_552_13 = manager.audio:GetVoiceLength("story_v_out_120421", "120421133", "story_v_out_120421.awb") / 1000

					if var_552_13 + var_552_5 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_13 + var_552_5
					end

					if var_552_8.prefab_name ~= "" and arg_549_1.actors_[var_552_8.prefab_name] ~= nil then
						local var_552_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_8.prefab_name].transform, "story_v_out_120421", "120421133", "story_v_out_120421.awb")

						arg_549_1:RecordAudio("120421133", var_552_14)
						arg_549_1:RecordAudio("120421133", var_552_14)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_120421", "120421133", "story_v_out_120421.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_120421", "120421133", "story_v_out_120421.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_15 = math.max(var_552_6, arg_549_1.talkMaxDuration)

			if var_552_5 <= arg_549_1.time_ and arg_549_1.time_ < var_552_5 + var_552_15 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_5) / var_552_15

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_5 + var_552_15 and arg_549_1.time_ < var_552_5 + var_552_15 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play120421134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 120421134
		arg_553_1.duration_ = 5.3

		local var_553_0 = {
			zh = 4.066,
			ja = 5.3
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play120421135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1074ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1074ui_story == nil then
				arg_553_1.var_.characterEffect1074ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1074ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1074ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1074ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1074ui_story.fillRatio = var_556_5
			end

			local var_556_6 = arg_553_1.actors_["10044ui_story"]
			local var_556_7 = 0

			if var_556_7 < arg_553_1.time_ and arg_553_1.time_ <= var_556_7 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect10044ui_story == nil then
				arg_553_1.var_.characterEffect10044ui_story = var_556_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_8 = 0.2

			if var_556_7 <= arg_553_1.time_ and arg_553_1.time_ < var_556_7 + var_556_8 and not isNil(var_556_6) then
				local var_556_9 = (arg_553_1.time_ - var_556_7) / var_556_8

				if arg_553_1.var_.characterEffect10044ui_story and not isNil(var_556_6) then
					arg_553_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= var_556_7 + var_556_8 and arg_553_1.time_ < var_556_7 + var_556_8 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect10044ui_story then
				arg_553_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_556_10 = 0
			local var_556_11 = 0.4

			if var_556_10 < arg_553_1.time_ and arg_553_1.time_ <= var_556_10 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_12 = arg_553_1:FormatText(StoryNameCfg[380].name)

				arg_553_1.leftNameTxt_.text = var_556_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_13 = arg_553_1:GetWordFromCfg(120421134)
				local var_556_14 = arg_553_1:FormatText(var_556_13.content)

				arg_553_1.text_.text = var_556_14

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_15 = 16
				local var_556_16 = utf8.len(var_556_14)
				local var_556_17 = var_556_15 <= 0 and var_556_11 or var_556_11 * (var_556_16 / var_556_15)

				if var_556_17 > 0 and var_556_11 < var_556_17 then
					arg_553_1.talkMaxDuration = var_556_17

					if var_556_17 + var_556_10 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_17 + var_556_10
					end
				end

				arg_553_1.text_.text = var_556_14
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421134", "story_v_out_120421.awb") ~= 0 then
					local var_556_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421134", "story_v_out_120421.awb") / 1000

					if var_556_18 + var_556_10 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_18 + var_556_10
					end

					if var_556_13.prefab_name ~= "" and arg_553_1.actors_[var_556_13.prefab_name] ~= nil then
						local var_556_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_13.prefab_name].transform, "story_v_out_120421", "120421134", "story_v_out_120421.awb")

						arg_553_1:RecordAudio("120421134", var_556_19)
						arg_553_1:RecordAudio("120421134", var_556_19)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_120421", "120421134", "story_v_out_120421.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_120421", "120421134", "story_v_out_120421.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_20 = math.max(var_556_11, arg_553_1.talkMaxDuration)

			if var_556_10 <= arg_553_1.time_ and arg_553_1.time_ < var_556_10 + var_556_20 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_10) / var_556_20

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_10 + var_556_20 and arg_553_1.time_ < var_556_10 + var_556_20 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play120421135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 120421135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play120421136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10044ui_story"].transform
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.var_.moveOldPos10044ui_story = var_560_0.localPosition
			end

			local var_560_2 = 0.001

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2
				local var_560_4 = Vector3.New(0, 100, 0)

				var_560_0.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10044ui_story, var_560_4, var_560_3)

				local var_560_5 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_5.x, var_560_5.y, var_560_5.z)

				local var_560_6 = var_560_0.localEulerAngles

				var_560_6.z = 0
				var_560_6.x = 0
				var_560_0.localEulerAngles = var_560_6
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 then
				var_560_0.localPosition = Vector3.New(0, 100, 0)

				local var_560_7 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_7.x, var_560_7.y, var_560_7.z)

				local var_560_8 = var_560_0.localEulerAngles

				var_560_8.z = 0
				var_560_8.x = 0
				var_560_0.localEulerAngles = var_560_8
			end

			local var_560_9 = arg_557_1.actors_["1074ui_story"].transform
			local var_560_10 = 0

			if var_560_10 < arg_557_1.time_ and arg_557_1.time_ <= var_560_10 + arg_560_0 then
				arg_557_1.var_.moveOldPos1074ui_story = var_560_9.localPosition
			end

			local var_560_11 = 0.001

			if var_560_10 <= arg_557_1.time_ and arg_557_1.time_ < var_560_10 + var_560_11 then
				local var_560_12 = (arg_557_1.time_ - var_560_10) / var_560_11
				local var_560_13 = Vector3.New(0, 100, 0)

				var_560_9.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1074ui_story, var_560_13, var_560_12)

				local var_560_14 = manager.ui.mainCamera.transform.position - var_560_9.position

				var_560_9.forward = Vector3.New(var_560_14.x, var_560_14.y, var_560_14.z)

				local var_560_15 = var_560_9.localEulerAngles

				var_560_15.z = 0
				var_560_15.x = 0
				var_560_9.localEulerAngles = var_560_15
			end

			if arg_557_1.time_ >= var_560_10 + var_560_11 and arg_557_1.time_ < var_560_10 + var_560_11 + arg_560_0 then
				var_560_9.localPosition = Vector3.New(0, 100, 0)

				local var_560_16 = manager.ui.mainCamera.transform.position - var_560_9.position

				var_560_9.forward = Vector3.New(var_560_16.x, var_560_16.y, var_560_16.z)

				local var_560_17 = var_560_9.localEulerAngles

				var_560_17.z = 0
				var_560_17.x = 0
				var_560_9.localEulerAngles = var_560_17
			end

			local var_560_18 = 0
			local var_560_19 = 0.9

			if var_560_18 < arg_557_1.time_ and arg_557_1.time_ <= var_560_18 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_20 = arg_557_1:GetWordFromCfg(120421135)
				local var_560_21 = arg_557_1:FormatText(var_560_20.content)

				arg_557_1.text_.text = var_560_21

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_22 = 36
				local var_560_23 = utf8.len(var_560_21)
				local var_560_24 = var_560_22 <= 0 and var_560_19 or var_560_19 * (var_560_23 / var_560_22)

				if var_560_24 > 0 and var_560_19 < var_560_24 then
					arg_557_1.talkMaxDuration = var_560_24

					if var_560_24 + var_560_18 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_24 + var_560_18
					end
				end

				arg_557_1.text_.text = var_560_21
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_25 = math.max(var_560_19, arg_557_1.talkMaxDuration)

			if var_560_18 <= arg_557_1.time_ and arg_557_1.time_ < var_560_18 + var_560_25 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_18) / var_560_25

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_18 + var_560_25 and arg_557_1.time_ < var_560_18 + var_560_25 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play120421136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 120421136
		arg_561_1.duration_ = 12.1

		local var_561_0 = {
			zh = 7.9,
			ja = 12.1
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play120421137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1074ui_story"].transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPos1074ui_story = var_564_0.localPosition
			end

			local var_564_2 = 0.001

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2
				local var_564_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1074ui_story, var_564_4, var_564_3)

				local var_564_5 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_5.x, var_564_5.y, var_564_5.z)

				local var_564_6 = var_564_0.localEulerAngles

				var_564_6.z = 0
				var_564_6.x = 0
				var_564_0.localEulerAngles = var_564_6
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_564_7 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_7.x, var_564_7.y, var_564_7.z)

				local var_564_8 = var_564_0.localEulerAngles

				var_564_8.z = 0
				var_564_8.x = 0
				var_564_0.localEulerAngles = var_564_8
			end

			local var_564_9 = 0

			if var_564_9 < arg_561_1.time_ and arg_561_1.time_ <= var_564_9 + arg_564_0 then
				arg_561_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_564_10 = arg_561_1.actors_["1074ui_story"]
			local var_564_11 = 0

			if var_564_11 < arg_561_1.time_ and arg_561_1.time_ <= var_564_11 + arg_564_0 and not isNil(var_564_10) and arg_561_1.var_.characterEffect1074ui_story == nil then
				arg_561_1.var_.characterEffect1074ui_story = var_564_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_12 = 0.2

			if var_564_11 <= arg_561_1.time_ and arg_561_1.time_ < var_564_11 + var_564_12 and not isNil(var_564_10) then
				local var_564_13 = (arg_561_1.time_ - var_564_11) / var_564_12

				if arg_561_1.var_.characterEffect1074ui_story and not isNil(var_564_10) then
					arg_561_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= var_564_11 + var_564_12 and arg_561_1.time_ < var_564_11 + var_564_12 + arg_564_0 and not isNil(var_564_10) and arg_561_1.var_.characterEffect1074ui_story then
				arg_561_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_564_14 = 0
			local var_564_15 = 0.825

			if var_564_14 < arg_561_1.time_ and arg_561_1.time_ <= var_564_14 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_16 = arg_561_1:FormatText(StoryNameCfg[410].name)

				arg_561_1.leftNameTxt_.text = var_564_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_17 = arg_561_1:GetWordFromCfg(120421136)
				local var_564_18 = arg_561_1:FormatText(var_564_17.content)

				arg_561_1.text_.text = var_564_18

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_19 = 33
				local var_564_20 = utf8.len(var_564_18)
				local var_564_21 = var_564_19 <= 0 and var_564_15 or var_564_15 * (var_564_20 / var_564_19)

				if var_564_21 > 0 and var_564_15 < var_564_21 then
					arg_561_1.talkMaxDuration = var_564_21

					if var_564_21 + var_564_14 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_21 + var_564_14
					end
				end

				arg_561_1.text_.text = var_564_18
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421136", "story_v_out_120421.awb") ~= 0 then
					local var_564_22 = manager.audio:GetVoiceLength("story_v_out_120421", "120421136", "story_v_out_120421.awb") / 1000

					if var_564_22 + var_564_14 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_22 + var_564_14
					end

					if var_564_17.prefab_name ~= "" and arg_561_1.actors_[var_564_17.prefab_name] ~= nil then
						local var_564_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_17.prefab_name].transform, "story_v_out_120421", "120421136", "story_v_out_120421.awb")

						arg_561_1:RecordAudio("120421136", var_564_23)
						arg_561_1:RecordAudio("120421136", var_564_23)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_120421", "120421136", "story_v_out_120421.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_120421", "120421136", "story_v_out_120421.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_24 = math.max(var_564_15, arg_561_1.talkMaxDuration)

			if var_564_14 <= arg_561_1.time_ and arg_561_1.time_ < var_564_14 + var_564_24 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_14) / var_564_24

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_14 + var_564_24 and arg_561_1.time_ < var_564_14 + var_564_24 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play120421137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 120421137
		arg_565_1.duration_ = 2.3

		local var_565_0 = {
			zh = 2.166,
			ja = 2.3
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play120421138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1084ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1084ui_story == nil then
				arg_565_1.var_.characterEffect1084ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.2

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect1084ui_story and not isNil(var_568_0) then
					arg_565_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1084ui_story then
				arg_565_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_568_4 = arg_565_1.actors_["1084ui_story"].transform
			local var_568_5 = 0

			if var_568_5 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1.var_.moveOldPos1084ui_story = var_568_4.localPosition
			end

			local var_568_6 = 0.001

			if var_568_5 <= arg_565_1.time_ and arg_565_1.time_ < var_568_5 + var_568_6 then
				local var_568_7 = (arg_565_1.time_ - var_568_5) / var_568_6
				local var_568_8 = Vector3.New(0.7, -0.97, -6)

				var_568_4.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1084ui_story, var_568_8, var_568_7)

				local var_568_9 = manager.ui.mainCamera.transform.position - var_568_4.position

				var_568_4.forward = Vector3.New(var_568_9.x, var_568_9.y, var_568_9.z)

				local var_568_10 = var_568_4.localEulerAngles

				var_568_10.z = 0
				var_568_10.x = 0
				var_568_4.localEulerAngles = var_568_10
			end

			if arg_565_1.time_ >= var_568_5 + var_568_6 and arg_565_1.time_ < var_568_5 + var_568_6 + arg_568_0 then
				var_568_4.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_568_11 = manager.ui.mainCamera.transform.position - var_568_4.position

				var_568_4.forward = Vector3.New(var_568_11.x, var_568_11.y, var_568_11.z)

				local var_568_12 = var_568_4.localEulerAngles

				var_568_12.z = 0
				var_568_12.x = 0
				var_568_4.localEulerAngles = var_568_12
			end

			local var_568_13 = 0

			if var_568_13 < arg_565_1.time_ and arg_565_1.time_ <= var_568_13 + arg_568_0 then
				arg_565_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_568_14 = 0

			if var_568_14 < arg_565_1.time_ and arg_565_1.time_ <= var_568_14 + arg_568_0 then
				arg_565_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_568_15 = arg_565_1.actors_["1074ui_story"]
			local var_568_16 = 0

			if var_568_16 < arg_565_1.time_ and arg_565_1.time_ <= var_568_16 + arg_568_0 and not isNil(var_568_15) and arg_565_1.var_.characterEffect1074ui_story == nil then
				arg_565_1.var_.characterEffect1074ui_story = var_568_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_17 = 0.2

			if var_568_16 <= arg_565_1.time_ and arg_565_1.time_ < var_568_16 + var_568_17 and not isNil(var_568_15) then
				local var_568_18 = (arg_565_1.time_ - var_568_16) / var_568_17

				if arg_565_1.var_.characterEffect1074ui_story and not isNil(var_568_15) then
					local var_568_19 = Mathf.Lerp(0, 0.5, var_568_18)

					arg_565_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1074ui_story.fillRatio = var_568_19
				end
			end

			if arg_565_1.time_ >= var_568_16 + var_568_17 and arg_565_1.time_ < var_568_16 + var_568_17 + arg_568_0 and not isNil(var_568_15) and arg_565_1.var_.characterEffect1074ui_story then
				local var_568_20 = 0.5

				arg_565_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1074ui_story.fillRatio = var_568_20
			end

			local var_568_21 = 0
			local var_568_22 = 0.2

			if var_568_21 < arg_565_1.time_ and arg_565_1.time_ <= var_568_21 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_23 = arg_565_1:FormatText(StoryNameCfg[6].name)

				arg_565_1.leftNameTxt_.text = var_568_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_24 = arg_565_1:GetWordFromCfg(120421137)
				local var_568_25 = arg_565_1:FormatText(var_568_24.content)

				arg_565_1.text_.text = var_568_25

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_26 = 8
				local var_568_27 = utf8.len(var_568_25)
				local var_568_28 = var_568_26 <= 0 and var_568_22 or var_568_22 * (var_568_27 / var_568_26)

				if var_568_28 > 0 and var_568_22 < var_568_28 then
					arg_565_1.talkMaxDuration = var_568_28

					if var_568_28 + var_568_21 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_28 + var_568_21
					end
				end

				arg_565_1.text_.text = var_568_25
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421137", "story_v_out_120421.awb") ~= 0 then
					local var_568_29 = manager.audio:GetVoiceLength("story_v_out_120421", "120421137", "story_v_out_120421.awb") / 1000

					if var_568_29 + var_568_21 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_29 + var_568_21
					end

					if var_568_24.prefab_name ~= "" and arg_565_1.actors_[var_568_24.prefab_name] ~= nil then
						local var_568_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_24.prefab_name].transform, "story_v_out_120421", "120421137", "story_v_out_120421.awb")

						arg_565_1:RecordAudio("120421137", var_568_30)
						arg_565_1:RecordAudio("120421137", var_568_30)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_120421", "120421137", "story_v_out_120421.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_120421", "120421137", "story_v_out_120421.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_31 = math.max(var_568_22, arg_565_1.talkMaxDuration)

			if var_568_21 <= arg_565_1.time_ and arg_565_1.time_ < var_568_21 + var_568_31 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_21) / var_568_31

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_21 + var_568_31 and arg_565_1.time_ < var_568_21 + var_568_31 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play120421138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 120421138
		arg_569_1.duration_ = 7.27

		local var_569_0 = {
			zh = 7.266,
			ja = 6.733
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play120421139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1084ui_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1084ui_story == nil then
				arg_569_1.var_.characterEffect1084ui_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.2

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect1084ui_story and not isNil(var_572_0) then
					local var_572_4 = Mathf.Lerp(0, 0.5, var_572_3)

					arg_569_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1084ui_story.fillRatio = var_572_4
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1084ui_story then
				local var_572_5 = 0.5

				arg_569_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1084ui_story.fillRatio = var_572_5
			end

			local var_572_6 = arg_569_1.actors_["1074ui_story"]
			local var_572_7 = 0

			if var_572_7 < arg_569_1.time_ and arg_569_1.time_ <= var_572_7 + arg_572_0 and not isNil(var_572_6) and arg_569_1.var_.characterEffect1074ui_story == nil then
				arg_569_1.var_.characterEffect1074ui_story = var_572_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_8 = 0.2

			if var_572_7 <= arg_569_1.time_ and arg_569_1.time_ < var_572_7 + var_572_8 and not isNil(var_572_6) then
				local var_572_9 = (arg_569_1.time_ - var_572_7) / var_572_8

				if arg_569_1.var_.characterEffect1074ui_story and not isNil(var_572_6) then
					arg_569_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= var_572_7 + var_572_8 and arg_569_1.time_ < var_572_7 + var_572_8 + arg_572_0 and not isNil(var_572_6) and arg_569_1.var_.characterEffect1074ui_story then
				arg_569_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_572_10 = 0
			local var_572_11 = 0.925

			if var_572_10 < arg_569_1.time_ and arg_569_1.time_ <= var_572_10 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_12 = arg_569_1:FormatText(StoryNameCfg[410].name)

				arg_569_1.leftNameTxt_.text = var_572_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_13 = arg_569_1:GetWordFromCfg(120421138)
				local var_572_14 = arg_569_1:FormatText(var_572_13.content)

				arg_569_1.text_.text = var_572_14

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_15 = 37
				local var_572_16 = utf8.len(var_572_14)
				local var_572_17 = var_572_15 <= 0 and var_572_11 or var_572_11 * (var_572_16 / var_572_15)

				if var_572_17 > 0 and var_572_11 < var_572_17 then
					arg_569_1.talkMaxDuration = var_572_17

					if var_572_17 + var_572_10 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_17 + var_572_10
					end
				end

				arg_569_1.text_.text = var_572_14
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421138", "story_v_out_120421.awb") ~= 0 then
					local var_572_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421138", "story_v_out_120421.awb") / 1000

					if var_572_18 + var_572_10 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_18 + var_572_10
					end

					if var_572_13.prefab_name ~= "" and arg_569_1.actors_[var_572_13.prefab_name] ~= nil then
						local var_572_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_13.prefab_name].transform, "story_v_out_120421", "120421138", "story_v_out_120421.awb")

						arg_569_1:RecordAudio("120421138", var_572_19)
						arg_569_1:RecordAudio("120421138", var_572_19)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_120421", "120421138", "story_v_out_120421.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_120421", "120421138", "story_v_out_120421.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_20 = math.max(var_572_11, arg_569_1.talkMaxDuration)

			if var_572_10 <= arg_569_1.time_ and arg_569_1.time_ < var_572_10 + var_572_20 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_10) / var_572_20

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_10 + var_572_20 and arg_569_1.time_ < var_572_10 + var_572_20 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play120421139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 120421139
		arg_573_1.duration_ = 9.3

		local var_573_0 = {
			zh = 3.5,
			ja = 9.3
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play120421140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.35

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[410].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_3 = arg_573_1:GetWordFromCfg(120421139)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 14
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421139", "story_v_out_120421.awb") ~= 0 then
					local var_576_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421139", "story_v_out_120421.awb") / 1000

					if var_576_8 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_8 + var_576_0
					end

					if var_576_3.prefab_name ~= "" and arg_573_1.actors_[var_576_3.prefab_name] ~= nil then
						local var_576_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_3.prefab_name].transform, "story_v_out_120421", "120421139", "story_v_out_120421.awb")

						arg_573_1:RecordAudio("120421139", var_576_9)
						arg_573_1:RecordAudio("120421139", var_576_9)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_120421", "120421139", "story_v_out_120421.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_120421", "120421139", "story_v_out_120421.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_10 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_10 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_10

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_10 and arg_573_1.time_ < var_576_0 + var_576_10 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play120421140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 120421140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play120421141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1084ui_story"].transform
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.var_.moveOldPos1084ui_story = var_580_0.localPosition
			end

			local var_580_2 = 0.001

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2
				local var_580_4 = Vector3.New(0, 100, 0)

				var_580_0.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1084ui_story, var_580_4, var_580_3)

				local var_580_5 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_5.x, var_580_5.y, var_580_5.z)

				local var_580_6 = var_580_0.localEulerAngles

				var_580_6.z = 0
				var_580_6.x = 0
				var_580_0.localEulerAngles = var_580_6
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 then
				var_580_0.localPosition = Vector3.New(0, 100, 0)

				local var_580_7 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_7.x, var_580_7.y, var_580_7.z)

				local var_580_8 = var_580_0.localEulerAngles

				var_580_8.z = 0
				var_580_8.x = 0
				var_580_0.localEulerAngles = var_580_8
			end

			local var_580_9 = arg_577_1.actors_["1074ui_story"].transform
			local var_580_10 = 0

			if var_580_10 < arg_577_1.time_ and arg_577_1.time_ <= var_580_10 + arg_580_0 then
				arg_577_1.var_.moveOldPos1074ui_story = var_580_9.localPosition
			end

			local var_580_11 = 0.001

			if var_580_10 <= arg_577_1.time_ and arg_577_1.time_ < var_580_10 + var_580_11 then
				local var_580_12 = (arg_577_1.time_ - var_580_10) / var_580_11
				local var_580_13 = Vector3.New(0, 100, 0)

				var_580_9.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1074ui_story, var_580_13, var_580_12)

				local var_580_14 = manager.ui.mainCamera.transform.position - var_580_9.position

				var_580_9.forward = Vector3.New(var_580_14.x, var_580_14.y, var_580_14.z)

				local var_580_15 = var_580_9.localEulerAngles

				var_580_15.z = 0
				var_580_15.x = 0
				var_580_9.localEulerAngles = var_580_15
			end

			if arg_577_1.time_ >= var_580_10 + var_580_11 and arg_577_1.time_ < var_580_10 + var_580_11 + arg_580_0 then
				var_580_9.localPosition = Vector3.New(0, 100, 0)

				local var_580_16 = manager.ui.mainCamera.transform.position - var_580_9.position

				var_580_9.forward = Vector3.New(var_580_16.x, var_580_16.y, var_580_16.z)

				local var_580_17 = var_580_9.localEulerAngles

				var_580_17.z = 0
				var_580_17.x = 0
				var_580_9.localEulerAngles = var_580_17
			end

			local var_580_18 = 0
			local var_580_19 = 0.975

			if var_580_18 < arg_577_1.time_ and arg_577_1.time_ <= var_580_18 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_20 = arg_577_1:GetWordFromCfg(120421140)
				local var_580_21 = arg_577_1:FormatText(var_580_20.content)

				arg_577_1.text_.text = var_580_21

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_22 = 39
				local var_580_23 = utf8.len(var_580_21)
				local var_580_24 = var_580_22 <= 0 and var_580_19 or var_580_19 * (var_580_23 / var_580_22)

				if var_580_24 > 0 and var_580_19 < var_580_24 then
					arg_577_1.talkMaxDuration = var_580_24

					if var_580_24 + var_580_18 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_24 + var_580_18
					end
				end

				arg_577_1.text_.text = var_580_21
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_25 = math.max(var_580_19, arg_577_1.talkMaxDuration)

			if var_580_18 <= arg_577_1.time_ and arg_577_1.time_ < var_580_18 + var_580_25 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_18) / var_580_25

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_18 + var_580_25 and arg_577_1.time_ < var_580_18 + var_580_25 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play120421141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 120421141
		arg_581_1.duration_ = 9.67

		local var_581_0 = {
			zh = 6.066,
			ja = 9.666
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play120421142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1084ui_story"].transform
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.var_.moveOldPos1084ui_story = var_584_0.localPosition
			end

			local var_584_2 = 0.001

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2
				local var_584_4 = Vector3.New(-0.7, -0.97, -6)

				var_584_0.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1084ui_story, var_584_4, var_584_3)

				local var_584_5 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_5.x, var_584_5.y, var_584_5.z)

				local var_584_6 = var_584_0.localEulerAngles

				var_584_6.z = 0
				var_584_6.x = 0
				var_584_0.localEulerAngles = var_584_6
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 then
				var_584_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_584_7 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_7.x, var_584_7.y, var_584_7.z)

				local var_584_8 = var_584_0.localEulerAngles

				var_584_8.z = 0
				var_584_8.x = 0
				var_584_0.localEulerAngles = var_584_8
			end

			local var_584_9 = 0

			if var_584_9 < arg_581_1.time_ and arg_581_1.time_ <= var_584_9 + arg_584_0 then
				arg_581_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_584_10 = 0

			if var_584_10 < arg_581_1.time_ and arg_581_1.time_ <= var_584_10 + arg_584_0 then
				arg_581_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_584_11 = arg_581_1.actors_["1084ui_story"]
			local var_584_12 = 0

			if var_584_12 < arg_581_1.time_ and arg_581_1.time_ <= var_584_12 + arg_584_0 and not isNil(var_584_11) and arg_581_1.var_.characterEffect1084ui_story == nil then
				arg_581_1.var_.characterEffect1084ui_story = var_584_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_13 = 0.2

			if var_584_12 <= arg_581_1.time_ and arg_581_1.time_ < var_584_12 + var_584_13 and not isNil(var_584_11) then
				local var_584_14 = (arg_581_1.time_ - var_584_12) / var_584_13

				if arg_581_1.var_.characterEffect1084ui_story and not isNil(var_584_11) then
					arg_581_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= var_584_12 + var_584_13 and arg_581_1.time_ < var_584_12 + var_584_13 + arg_584_0 and not isNil(var_584_11) and arg_581_1.var_.characterEffect1084ui_story then
				arg_581_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_584_15 = 0
			local var_584_16 = 0.525

			if var_584_15 < arg_581_1.time_ and arg_581_1.time_ <= var_584_15 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_17 = arg_581_1:FormatText(StoryNameCfg[6].name)

				arg_581_1.leftNameTxt_.text = var_584_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_18 = arg_581_1:GetWordFromCfg(120421141)
				local var_584_19 = arg_581_1:FormatText(var_584_18.content)

				arg_581_1.text_.text = var_584_19

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_20 = 21
				local var_584_21 = utf8.len(var_584_19)
				local var_584_22 = var_584_20 <= 0 and var_584_16 or var_584_16 * (var_584_21 / var_584_20)

				if var_584_22 > 0 and var_584_16 < var_584_22 then
					arg_581_1.talkMaxDuration = var_584_22

					if var_584_22 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_22 + var_584_15
					end
				end

				arg_581_1.text_.text = var_584_19
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421141", "story_v_out_120421.awb") ~= 0 then
					local var_584_23 = manager.audio:GetVoiceLength("story_v_out_120421", "120421141", "story_v_out_120421.awb") / 1000

					if var_584_23 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_23 + var_584_15
					end

					if var_584_18.prefab_name ~= "" and arg_581_1.actors_[var_584_18.prefab_name] ~= nil then
						local var_584_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_18.prefab_name].transform, "story_v_out_120421", "120421141", "story_v_out_120421.awb")

						arg_581_1:RecordAudio("120421141", var_584_24)
						arg_581_1:RecordAudio("120421141", var_584_24)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_120421", "120421141", "story_v_out_120421.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_120421", "120421141", "story_v_out_120421.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_25 = math.max(var_584_16, arg_581_1.talkMaxDuration)

			if var_584_15 <= arg_581_1.time_ and arg_581_1.time_ < var_584_15 + var_584_25 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_15) / var_584_25

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_15 + var_584_25 and arg_581_1.time_ < var_584_15 + var_584_25 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play120421142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 120421142
		arg_585_1.duration_ = 7.33

		local var_585_0 = {
			zh = 3.233,
			ja = 7.333
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play120421143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_588_1 = arg_585_1.actors_["1075ui_story"]
			local var_588_2 = 0

			if var_588_2 < arg_585_1.time_ and arg_585_1.time_ <= var_588_2 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1075ui_story == nil then
				arg_585_1.var_.characterEffect1075ui_story = var_588_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_3 = 0.2

			if var_588_2 <= arg_585_1.time_ and arg_585_1.time_ < var_588_2 + var_588_3 and not isNil(var_588_1) then
				local var_588_4 = (arg_585_1.time_ - var_588_2) / var_588_3

				if arg_585_1.var_.characterEffect1075ui_story and not isNil(var_588_1) then
					arg_585_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_2 + var_588_3 and arg_585_1.time_ < var_588_2 + var_588_3 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1075ui_story then
				arg_585_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_588_5 = arg_585_1.actors_["1075ui_story"].transform
			local var_588_6 = 0

			if var_588_6 < arg_585_1.time_ and arg_585_1.time_ <= var_588_6 + arg_588_0 then
				arg_585_1.var_.moveOldPos1075ui_story = var_588_5.localPosition
			end

			local var_588_7 = 0.001

			if var_588_6 <= arg_585_1.time_ and arg_585_1.time_ < var_588_6 + var_588_7 then
				local var_588_8 = (arg_585_1.time_ - var_588_6) / var_588_7
				local var_588_9 = Vector3.New(0.7, -1.055, -6.16)

				var_588_5.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1075ui_story, var_588_9, var_588_8)

				local var_588_10 = manager.ui.mainCamera.transform.position - var_588_5.position

				var_588_5.forward = Vector3.New(var_588_10.x, var_588_10.y, var_588_10.z)

				local var_588_11 = var_588_5.localEulerAngles

				var_588_11.z = 0
				var_588_11.x = 0
				var_588_5.localEulerAngles = var_588_11
			end

			if arg_585_1.time_ >= var_588_6 + var_588_7 and arg_585_1.time_ < var_588_6 + var_588_7 + arg_588_0 then
				var_588_5.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_588_12 = manager.ui.mainCamera.transform.position - var_588_5.position

				var_588_5.forward = Vector3.New(var_588_12.x, var_588_12.y, var_588_12.z)

				local var_588_13 = var_588_5.localEulerAngles

				var_588_13.z = 0
				var_588_13.x = 0
				var_588_5.localEulerAngles = var_588_13
			end

			local var_588_14 = arg_585_1.actors_["1084ui_story"]
			local var_588_15 = 0

			if var_588_15 < arg_585_1.time_ and arg_585_1.time_ <= var_588_15 + arg_588_0 and not isNil(var_588_14) and arg_585_1.var_.characterEffect1084ui_story == nil then
				arg_585_1.var_.characterEffect1084ui_story = var_588_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_16 = 0.2

			if var_588_15 <= arg_585_1.time_ and arg_585_1.time_ < var_588_15 + var_588_16 and not isNil(var_588_14) then
				local var_588_17 = (arg_585_1.time_ - var_588_15) / var_588_16

				if arg_585_1.var_.characterEffect1084ui_story and not isNil(var_588_14) then
					local var_588_18 = Mathf.Lerp(0, 0.5, var_588_17)

					arg_585_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1084ui_story.fillRatio = var_588_18
				end
			end

			if arg_585_1.time_ >= var_588_15 + var_588_16 and arg_585_1.time_ < var_588_15 + var_588_16 + arg_588_0 and not isNil(var_588_14) and arg_585_1.var_.characterEffect1084ui_story then
				local var_588_19 = 0.5

				arg_585_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1084ui_story.fillRatio = var_588_19
			end

			local var_588_20 = 0
			local var_588_21 = 0.275

			if var_588_20 < arg_585_1.time_ and arg_585_1.time_ <= var_588_20 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_22 = arg_585_1:FormatText(StoryNameCfg[381].name)

				arg_585_1.leftNameTxt_.text = var_588_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_23 = arg_585_1:GetWordFromCfg(120421142)
				local var_588_24 = arg_585_1:FormatText(var_588_23.content)

				arg_585_1.text_.text = var_588_24

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_25 = 11
				local var_588_26 = utf8.len(var_588_24)
				local var_588_27 = var_588_25 <= 0 and var_588_21 or var_588_21 * (var_588_26 / var_588_25)

				if var_588_27 > 0 and var_588_21 < var_588_27 then
					arg_585_1.talkMaxDuration = var_588_27

					if var_588_27 + var_588_20 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_27 + var_588_20
					end
				end

				arg_585_1.text_.text = var_588_24
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421142", "story_v_out_120421.awb") ~= 0 then
					local var_588_28 = manager.audio:GetVoiceLength("story_v_out_120421", "120421142", "story_v_out_120421.awb") / 1000

					if var_588_28 + var_588_20 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_28 + var_588_20
					end

					if var_588_23.prefab_name ~= "" and arg_585_1.actors_[var_588_23.prefab_name] ~= nil then
						local var_588_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_23.prefab_name].transform, "story_v_out_120421", "120421142", "story_v_out_120421.awb")

						arg_585_1:RecordAudio("120421142", var_588_29)
						arg_585_1:RecordAudio("120421142", var_588_29)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_120421", "120421142", "story_v_out_120421.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_120421", "120421142", "story_v_out_120421.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_30 = math.max(var_588_21, arg_585_1.talkMaxDuration)

			if var_588_20 <= arg_585_1.time_ and arg_585_1.time_ < var_588_20 + var_588_30 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_20) / var_588_30

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_20 + var_588_30 and arg_585_1.time_ < var_588_20 + var_588_30 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play120421143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 120421143
		arg_589_1.duration_ = 11.77

		local var_589_0 = {
			zh = 8.9,
			ja = 11.766
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play120421144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["1084ui_story"].transform
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.var_.moveOldPos1084ui_story = var_592_0.localPosition
			end

			local var_592_2 = 0.001

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2
				local var_592_4 = Vector3.New(0, 100, 0)

				var_592_0.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1084ui_story, var_592_4, var_592_3)

				local var_592_5 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_5.x, var_592_5.y, var_592_5.z)

				local var_592_6 = var_592_0.localEulerAngles

				var_592_6.z = 0
				var_592_6.x = 0
				var_592_0.localEulerAngles = var_592_6
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 then
				var_592_0.localPosition = Vector3.New(0, 100, 0)

				local var_592_7 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_7.x, var_592_7.y, var_592_7.z)

				local var_592_8 = var_592_0.localEulerAngles

				var_592_8.z = 0
				var_592_8.x = 0
				var_592_0.localEulerAngles = var_592_8
			end

			local var_592_9 = arg_589_1.actors_["1075ui_story"].transform
			local var_592_10 = 0

			if var_592_10 < arg_589_1.time_ and arg_589_1.time_ <= var_592_10 + arg_592_0 then
				arg_589_1.var_.moveOldPos1075ui_story = var_592_9.localPosition
			end

			local var_592_11 = 0.001

			if var_592_10 <= arg_589_1.time_ and arg_589_1.time_ < var_592_10 + var_592_11 then
				local var_592_12 = (arg_589_1.time_ - var_592_10) / var_592_11
				local var_592_13 = Vector3.New(0, 100, 0)

				var_592_9.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1075ui_story, var_592_13, var_592_12)

				local var_592_14 = manager.ui.mainCamera.transform.position - var_592_9.position

				var_592_9.forward = Vector3.New(var_592_14.x, var_592_14.y, var_592_14.z)

				local var_592_15 = var_592_9.localEulerAngles

				var_592_15.z = 0
				var_592_15.x = 0
				var_592_9.localEulerAngles = var_592_15
			end

			if arg_589_1.time_ >= var_592_10 + var_592_11 and arg_589_1.time_ < var_592_10 + var_592_11 + arg_592_0 then
				var_592_9.localPosition = Vector3.New(0, 100, 0)

				local var_592_16 = manager.ui.mainCamera.transform.position - var_592_9.position

				var_592_9.forward = Vector3.New(var_592_16.x, var_592_16.y, var_592_16.z)

				local var_592_17 = var_592_9.localEulerAngles

				var_592_17.z = 0
				var_592_17.x = 0
				var_592_9.localEulerAngles = var_592_17
			end

			local var_592_18 = arg_589_1.actors_["10044ui_story"].transform
			local var_592_19 = 0

			if var_592_19 < arg_589_1.time_ and arg_589_1.time_ <= var_592_19 + arg_592_0 then
				arg_589_1.var_.moveOldPos10044ui_story = var_592_18.localPosition
			end

			local var_592_20 = 0.001

			if var_592_19 <= arg_589_1.time_ and arg_589_1.time_ < var_592_19 + var_592_20 then
				local var_592_21 = (arg_589_1.time_ - var_592_19) / var_592_20
				local var_592_22 = Vector3.New(0, -0.72, -6.3)

				var_592_18.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10044ui_story, var_592_22, var_592_21)

				local var_592_23 = manager.ui.mainCamera.transform.position - var_592_18.position

				var_592_18.forward = Vector3.New(var_592_23.x, var_592_23.y, var_592_23.z)

				local var_592_24 = var_592_18.localEulerAngles

				var_592_24.z = 0
				var_592_24.x = 0
				var_592_18.localEulerAngles = var_592_24
			end

			if arg_589_1.time_ >= var_592_19 + var_592_20 and arg_589_1.time_ < var_592_19 + var_592_20 + arg_592_0 then
				var_592_18.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_592_25 = manager.ui.mainCamera.transform.position - var_592_18.position

				var_592_18.forward = Vector3.New(var_592_25.x, var_592_25.y, var_592_25.z)

				local var_592_26 = var_592_18.localEulerAngles

				var_592_26.z = 0
				var_592_26.x = 0
				var_592_18.localEulerAngles = var_592_26
			end

			local var_592_27 = 0

			if var_592_27 < arg_589_1.time_ and arg_589_1.time_ <= var_592_27 + arg_592_0 then
				arg_589_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_592_28 = 0

			if var_592_28 < arg_589_1.time_ and arg_589_1.time_ <= var_592_28 + arg_592_0 then
				arg_589_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_592_29 = arg_589_1.actors_["10044ui_story"]
			local var_592_30 = 0

			if var_592_30 < arg_589_1.time_ and arg_589_1.time_ <= var_592_30 + arg_592_0 and not isNil(var_592_29) and arg_589_1.var_.characterEffect10044ui_story == nil then
				arg_589_1.var_.characterEffect10044ui_story = var_592_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_31 = 0.2

			if var_592_30 <= arg_589_1.time_ and arg_589_1.time_ < var_592_30 + var_592_31 and not isNil(var_592_29) then
				local var_592_32 = (arg_589_1.time_ - var_592_30) / var_592_31

				if arg_589_1.var_.characterEffect10044ui_story and not isNil(var_592_29) then
					arg_589_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= var_592_30 + var_592_31 and arg_589_1.time_ < var_592_30 + var_592_31 + arg_592_0 and not isNil(var_592_29) and arg_589_1.var_.characterEffect10044ui_story then
				arg_589_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_592_33 = 0
			local var_592_34 = 0.85

			if var_592_33 < arg_589_1.time_ and arg_589_1.time_ <= var_592_33 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_35 = arg_589_1:FormatText(StoryNameCfg[380].name)

				arg_589_1.leftNameTxt_.text = var_592_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_36 = arg_589_1:GetWordFromCfg(120421143)
				local var_592_37 = arg_589_1:FormatText(var_592_36.content)

				arg_589_1.text_.text = var_592_37

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_38 = 34
				local var_592_39 = utf8.len(var_592_37)
				local var_592_40 = var_592_38 <= 0 and var_592_34 or var_592_34 * (var_592_39 / var_592_38)

				if var_592_40 > 0 and var_592_34 < var_592_40 then
					arg_589_1.talkMaxDuration = var_592_40

					if var_592_40 + var_592_33 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_40 + var_592_33
					end
				end

				arg_589_1.text_.text = var_592_37
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421143", "story_v_out_120421.awb") ~= 0 then
					local var_592_41 = manager.audio:GetVoiceLength("story_v_out_120421", "120421143", "story_v_out_120421.awb") / 1000

					if var_592_41 + var_592_33 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_41 + var_592_33
					end

					if var_592_36.prefab_name ~= "" and arg_589_1.actors_[var_592_36.prefab_name] ~= nil then
						local var_592_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_36.prefab_name].transform, "story_v_out_120421", "120421143", "story_v_out_120421.awb")

						arg_589_1:RecordAudio("120421143", var_592_42)
						arg_589_1:RecordAudio("120421143", var_592_42)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_120421", "120421143", "story_v_out_120421.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_120421", "120421143", "story_v_out_120421.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_43 = math.max(var_592_34, arg_589_1.talkMaxDuration)

			if var_592_33 <= arg_589_1.time_ and arg_589_1.time_ < var_592_33 + var_592_43 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_33) / var_592_43

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_33 + var_592_43 and arg_589_1.time_ < var_592_33 + var_592_43 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play120421144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 120421144
		arg_593_1.duration_ = 15.4

		local var_593_0 = {
			zh = 15.4,
			ja = 13.366
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play120421145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 1.475

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[380].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_3 = arg_593_1:GetWordFromCfg(120421144)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 59
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421144", "story_v_out_120421.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421144", "story_v_out_120421.awb") / 1000

					if var_596_8 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_0
					end

					if var_596_3.prefab_name ~= "" and arg_593_1.actors_[var_596_3.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_3.prefab_name].transform, "story_v_out_120421", "120421144", "story_v_out_120421.awb")

						arg_593_1:RecordAudio("120421144", var_596_9)
						arg_593_1:RecordAudio("120421144", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_120421", "120421144", "story_v_out_120421.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_120421", "120421144", "story_v_out_120421.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_10 and arg_593_1.time_ < var_596_0 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play120421145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 120421145
		arg_597_1.duration_ = 7.8

		local var_597_0 = {
			zh = 7.066,
			ja = 7.8
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play120421146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0
			local var_600_1 = 0.65

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_2 = arg_597_1:FormatText(StoryNameCfg[380].name)

				arg_597_1.leftNameTxt_.text = var_600_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_3 = arg_597_1:GetWordFromCfg(120421145)
				local var_600_4 = arg_597_1:FormatText(var_600_3.content)

				arg_597_1.text_.text = var_600_4

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 26
				local var_600_6 = utf8.len(var_600_4)
				local var_600_7 = var_600_5 <= 0 and var_600_1 or var_600_1 * (var_600_6 / var_600_5)

				if var_600_7 > 0 and var_600_1 < var_600_7 then
					arg_597_1.talkMaxDuration = var_600_7

					if var_600_7 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_4
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421145", "story_v_out_120421.awb") ~= 0 then
					local var_600_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421145", "story_v_out_120421.awb") / 1000

					if var_600_8 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_8 + var_600_0
					end

					if var_600_3.prefab_name ~= "" and arg_597_1.actors_[var_600_3.prefab_name] ~= nil then
						local var_600_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_3.prefab_name].transform, "story_v_out_120421", "120421145", "story_v_out_120421.awb")

						arg_597_1:RecordAudio("120421145", var_600_9)
						arg_597_1:RecordAudio("120421145", var_600_9)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_120421", "120421145", "story_v_out_120421.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_120421", "120421145", "story_v_out_120421.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_10 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_10 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_10

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_10 and arg_597_1.time_ < var_600_0 + var_600_10 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play120421146 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 120421146
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play120421147(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["10044ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10044ui_story == nil then
				arg_601_1.var_.characterEffect10044ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.2

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect10044ui_story and not isNil(var_604_0) then
					local var_604_4 = Mathf.Lerp(0, 0.5, var_604_3)

					arg_601_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_601_1.var_.characterEffect10044ui_story.fillRatio = var_604_4
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10044ui_story then
				local var_604_5 = 0.5

				arg_601_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_601_1.var_.characterEffect10044ui_story.fillRatio = var_604_5
			end

			local var_604_6 = 0

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_604_7 = 0
			local var_604_8 = 0.8

			if var_604_7 < arg_601_1.time_ and arg_601_1.time_ <= var_604_7 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_9 = arg_601_1:GetWordFromCfg(120421146)
				local var_604_10 = arg_601_1:FormatText(var_604_9.content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_11 = 32
				local var_604_12 = utf8.len(var_604_10)
				local var_604_13 = var_604_11 <= 0 and var_604_8 or var_604_8 * (var_604_12 / var_604_11)

				if var_604_13 > 0 and var_604_8 < var_604_13 then
					arg_601_1.talkMaxDuration = var_604_13

					if var_604_13 + var_604_7 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_13 + var_604_7
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_14 = math.max(var_604_8, arg_601_1.talkMaxDuration)

			if var_604_7 <= arg_601_1.time_ and arg_601_1.time_ < var_604_7 + var_604_14 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_7) / var_604_14

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_7 + var_604_14 and arg_601_1.time_ < var_604_7 + var_604_14 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play120421147 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 120421147
		arg_605_1.duration_ = 6.07

		local var_605_0 = {
			zh = 4.966,
			ja = 6.066
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play120421148(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 then
				arg_605_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_608_2 = arg_605_1.actors_["10044ui_story"]
			local var_608_3 = 0

			if var_608_3 < arg_605_1.time_ and arg_605_1.time_ <= var_608_3 + arg_608_0 and not isNil(var_608_2) and arg_605_1.var_.characterEffect10044ui_story == nil then
				arg_605_1.var_.characterEffect10044ui_story = var_608_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_4 = 0.2

			if var_608_3 <= arg_605_1.time_ and arg_605_1.time_ < var_608_3 + var_608_4 and not isNil(var_608_2) then
				local var_608_5 = (arg_605_1.time_ - var_608_3) / var_608_4

				if arg_605_1.var_.characterEffect10044ui_story and not isNil(var_608_2) then
					arg_605_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= var_608_3 + var_608_4 and arg_605_1.time_ < var_608_3 + var_608_4 + arg_608_0 and not isNil(var_608_2) and arg_605_1.var_.characterEffect10044ui_story then
				arg_605_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_608_6 = 0
			local var_608_7 = 0.375

			if var_608_6 < arg_605_1.time_ and arg_605_1.time_ <= var_608_6 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_8 = arg_605_1:FormatText(StoryNameCfg[380].name)

				arg_605_1.leftNameTxt_.text = var_608_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_9 = arg_605_1:GetWordFromCfg(120421147)
				local var_608_10 = arg_605_1:FormatText(var_608_9.content)

				arg_605_1.text_.text = var_608_10

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_11 = 15
				local var_608_12 = utf8.len(var_608_10)
				local var_608_13 = var_608_11 <= 0 and var_608_7 or var_608_7 * (var_608_12 / var_608_11)

				if var_608_13 > 0 and var_608_7 < var_608_13 then
					arg_605_1.talkMaxDuration = var_608_13

					if var_608_13 + var_608_6 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_13 + var_608_6
					end
				end

				arg_605_1.text_.text = var_608_10
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421147", "story_v_out_120421.awb") ~= 0 then
					local var_608_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421147", "story_v_out_120421.awb") / 1000

					if var_608_14 + var_608_6 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_14 + var_608_6
					end

					if var_608_9.prefab_name ~= "" and arg_605_1.actors_[var_608_9.prefab_name] ~= nil then
						local var_608_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_9.prefab_name].transform, "story_v_out_120421", "120421147", "story_v_out_120421.awb")

						arg_605_1:RecordAudio("120421147", var_608_15)
						arg_605_1:RecordAudio("120421147", var_608_15)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_120421", "120421147", "story_v_out_120421.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_120421", "120421147", "story_v_out_120421.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_16 = math.max(var_608_7, arg_605_1.talkMaxDuration)

			if var_608_6 <= arg_605_1.time_ and arg_605_1.time_ < var_608_6 + var_608_16 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_6) / var_608_16

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_6 + var_608_16 and arg_605_1.time_ < var_608_6 + var_608_16 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play120421148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 120421148
		arg_609_1.duration_ = 9

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play120421149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 2

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				local var_612_1 = manager.ui.mainCamera.transform.localPosition
				local var_612_2 = Vector3.New(0, 0, 10) + Vector3.New(var_612_1.x, var_612_1.y, 0)
				local var_612_3 = arg_609_1.bgs_.ST29

				var_612_3.transform.localPosition = var_612_2
				var_612_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_612_4 = var_612_3:GetComponent("SpriteRenderer")

				if var_612_4 and var_612_4.sprite then
					local var_612_5 = (var_612_3.transform.localPosition - var_612_1).z
					local var_612_6 = manager.ui.mainCameraCom_
					local var_612_7 = 2 * var_612_5 * Mathf.Tan(var_612_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_612_8 = var_612_7 * var_612_6.aspect
					local var_612_9 = var_612_4.sprite.bounds.size.x
					local var_612_10 = var_612_4.sprite.bounds.size.y
					local var_612_11 = var_612_8 / var_612_9
					local var_612_12 = var_612_7 / var_612_10
					local var_612_13 = var_612_12 < var_612_11 and var_612_11 or var_612_12

					var_612_3.transform.localScale = Vector3.New(var_612_13, var_612_13, 0)
				end

				for iter_612_0, iter_612_1 in pairs(arg_609_1.bgs_) do
					if iter_612_0 ~= "ST29" then
						iter_612_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_612_14 = 0

			if var_612_14 < arg_609_1.time_ and arg_609_1.time_ <= var_612_14 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_15 = 2

			if var_612_14 <= arg_609_1.time_ and arg_609_1.time_ < var_612_14 + var_612_15 then
				local var_612_16 = (arg_609_1.time_ - var_612_14) / var_612_15
				local var_612_17 = Color.New(0, 0, 0)

				var_612_17.a = Mathf.Lerp(0, 1, var_612_16)
				arg_609_1.mask_.color = var_612_17
			end

			if arg_609_1.time_ >= var_612_14 + var_612_15 and arg_609_1.time_ < var_612_14 + var_612_15 + arg_612_0 then
				local var_612_18 = Color.New(0, 0, 0)

				var_612_18.a = 1
				arg_609_1.mask_.color = var_612_18
			end

			local var_612_19 = 2

			if var_612_19 < arg_609_1.time_ and arg_609_1.time_ <= var_612_19 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_20 = 2

			if var_612_19 <= arg_609_1.time_ and arg_609_1.time_ < var_612_19 + var_612_20 then
				local var_612_21 = (arg_609_1.time_ - var_612_19) / var_612_20
				local var_612_22 = Color.New(0, 0, 0)

				var_612_22.a = Mathf.Lerp(1, 0, var_612_21)
				arg_609_1.mask_.color = var_612_22
			end

			if arg_609_1.time_ >= var_612_19 + var_612_20 and arg_609_1.time_ < var_612_19 + var_612_20 + arg_612_0 then
				local var_612_23 = Color.New(0, 0, 0)
				local var_612_24 = 0

				arg_609_1.mask_.enabled = false
				var_612_23.a = var_612_24
				arg_609_1.mask_.color = var_612_23
			end

			local var_612_25 = arg_609_1.actors_["10044ui_story"].transform
			local var_612_26 = 1.966

			if var_612_26 < arg_609_1.time_ and arg_609_1.time_ <= var_612_26 + arg_612_0 then
				arg_609_1.var_.moveOldPos10044ui_story = var_612_25.localPosition
			end

			local var_612_27 = 0.001

			if var_612_26 <= arg_609_1.time_ and arg_609_1.time_ < var_612_26 + var_612_27 then
				local var_612_28 = (arg_609_1.time_ - var_612_26) / var_612_27
				local var_612_29 = Vector3.New(0, 100, 0)

				var_612_25.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos10044ui_story, var_612_29, var_612_28)

				local var_612_30 = manager.ui.mainCamera.transform.position - var_612_25.position

				var_612_25.forward = Vector3.New(var_612_30.x, var_612_30.y, var_612_30.z)

				local var_612_31 = var_612_25.localEulerAngles

				var_612_31.z = 0
				var_612_31.x = 0
				var_612_25.localEulerAngles = var_612_31
			end

			if arg_609_1.time_ >= var_612_26 + var_612_27 and arg_609_1.time_ < var_612_26 + var_612_27 + arg_612_0 then
				var_612_25.localPosition = Vector3.New(0, 100, 0)

				local var_612_32 = manager.ui.mainCamera.transform.position - var_612_25.position

				var_612_25.forward = Vector3.New(var_612_32.x, var_612_32.y, var_612_32.z)

				local var_612_33 = var_612_25.localEulerAngles

				var_612_33.z = 0
				var_612_33.x = 0
				var_612_25.localEulerAngles = var_612_33
			end

			if arg_609_1.frameCnt_ <= 1 then
				arg_609_1.dialog_:SetActive(false)
			end

			local var_612_34 = 4
			local var_612_35 = 0.675

			if var_612_34 < arg_609_1.time_ and arg_609_1.time_ <= var_612_34 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0

				arg_609_1.dialog_:SetActive(true)

				arg_609_1.dialogCg_.alpha = 0

				local var_612_36 = LeanTween.value(arg_609_1.dialog_, 0, 1, 0.3)

				var_612_36:setOnUpdate(LuaHelper.FloatAction(function(arg_613_0)
					arg_609_1.dialogCg_.alpha = arg_613_0
				end))
				var_612_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_609_1.dialog_)
					var_612_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_609_1.duration_ = arg_609_1.duration_ + 0.3

				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_37 = arg_609_1:GetWordFromCfg(120421148)
				local var_612_38 = arg_609_1:FormatText(var_612_37.content)

				arg_609_1.text_.text = var_612_38

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_39 = 27
				local var_612_40 = utf8.len(var_612_38)
				local var_612_41 = var_612_39 <= 0 and var_612_35 or var_612_35 * (var_612_40 / var_612_39)

				if var_612_41 > 0 and var_612_35 < var_612_41 then
					arg_609_1.talkMaxDuration = var_612_41
					var_612_34 = var_612_34 + 0.3

					if var_612_41 + var_612_34 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_41 + var_612_34
					end
				end

				arg_609_1.text_.text = var_612_38
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_42 = var_612_34 + 0.3
			local var_612_43 = math.max(var_612_35, arg_609_1.talkMaxDuration)

			if var_612_42 <= arg_609_1.time_ and arg_609_1.time_ < var_612_42 + var_612_43 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_42) / var_612_43

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_42 + var_612_43 and arg_609_1.time_ < var_612_42 + var_612_43 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play120421149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 120421149
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play120421150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.925

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_2 = arg_615_1:GetWordFromCfg(120421149)
				local var_618_3 = arg_615_1:FormatText(var_618_2.content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_4 = 37
				local var_618_5 = utf8.len(var_618_3)
				local var_618_6 = var_618_4 <= 0 and var_618_1 or var_618_1 * (var_618_5 / var_618_4)

				if var_618_6 > 0 and var_618_1 < var_618_6 then
					arg_615_1.talkMaxDuration = var_618_6

					if var_618_6 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_6 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_7 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_7 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_7

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_7 and arg_615_1.time_ < var_618_0 + var_618_7 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play120421150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 120421150
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play120421151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0
			local var_622_1 = 0.6

			if var_622_0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_2 = arg_619_1:GetWordFromCfg(120421150)
				local var_622_3 = arg_619_1:FormatText(var_622_2.content)

				arg_619_1.text_.text = var_622_3

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_4 = 24
				local var_622_5 = utf8.len(var_622_3)
				local var_622_6 = var_622_4 <= 0 and var_622_1 or var_622_1 * (var_622_5 / var_622_4)

				if var_622_6 > 0 and var_622_1 < var_622_6 then
					arg_619_1.talkMaxDuration = var_622_6

					if var_622_6 + var_622_0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_6 + var_622_0
					end
				end

				arg_619_1.text_.text = var_622_3
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_7 = math.max(var_622_1, arg_619_1.talkMaxDuration)

			if var_622_0 <= arg_619_1.time_ and arg_619_1.time_ < var_622_0 + var_622_7 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_0) / var_622_7

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_0 + var_622_7 and arg_619_1.time_ < var_622_0 + var_622_7 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play120421151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 120421151
		arg_623_1.duration_ = 3.9

		local var_623_0 = {
			zh = 3.9,
			ja = 3.5
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play120421152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1074ui_story"].transform
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.var_.moveOldPos1074ui_story = var_626_0.localPosition
			end

			local var_626_2 = 0.001

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2
				local var_626_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_626_0.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1074ui_story, var_626_4, var_626_3)

				local var_626_5 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_5.x, var_626_5.y, var_626_5.z)

				local var_626_6 = var_626_0.localEulerAngles

				var_626_6.z = 0
				var_626_6.x = 0
				var_626_0.localEulerAngles = var_626_6
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 then
				var_626_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_626_7 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_7.x, var_626_7.y, var_626_7.z)

				local var_626_8 = var_626_0.localEulerAngles

				var_626_8.z = 0
				var_626_8.x = 0
				var_626_0.localEulerAngles = var_626_8
			end

			local var_626_9 = 0

			if var_626_9 < arg_623_1.time_ and arg_623_1.time_ <= var_626_9 + arg_626_0 then
				arg_623_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_626_10 = arg_623_1.actors_["1074ui_story"]
			local var_626_11 = 0

			if var_626_11 < arg_623_1.time_ and arg_623_1.time_ <= var_626_11 + arg_626_0 and not isNil(var_626_10) and arg_623_1.var_.characterEffect1074ui_story == nil then
				arg_623_1.var_.characterEffect1074ui_story = var_626_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_12 = 0.2

			if var_626_11 <= arg_623_1.time_ and arg_623_1.time_ < var_626_11 + var_626_12 and not isNil(var_626_10) then
				local var_626_13 = (arg_623_1.time_ - var_626_11) / var_626_12

				if arg_623_1.var_.characterEffect1074ui_story and not isNil(var_626_10) then
					arg_623_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= var_626_11 + var_626_12 and arg_623_1.time_ < var_626_11 + var_626_12 + arg_626_0 and not isNil(var_626_10) and arg_623_1.var_.characterEffect1074ui_story then
				arg_623_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_626_14 = "1076ui_story"

			if arg_623_1.actors_[var_626_14] == nil then
				local var_626_15 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_626_15) then
					local var_626_16 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_623_1.stage_.transform)

					var_626_16.name = var_626_14
					var_626_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_623_1.actors_[var_626_14] = var_626_16

					local var_626_17 = var_626_16:GetComponentInChildren(typeof(CharacterEffect))

					var_626_17.enabled = true

					local var_626_18 = GameObjectTools.GetOrAddComponent(var_626_16, typeof(DynamicBoneHelper))

					if var_626_18 then
						var_626_18:EnableDynamicBone(false)
					end

					arg_623_1:ShowWeapon(var_626_17.transform, false)

					arg_623_1.var_[var_626_14 .. "Animator"] = var_626_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_623_1.var_[var_626_14 .. "Animator"].applyRootMotion = true
					arg_623_1.var_[var_626_14 .. "LipSync"] = var_626_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_626_19 = arg_623_1.actors_["1076ui_story"]
			local var_626_20 = 0

			if var_626_20 < arg_623_1.time_ and arg_623_1.time_ <= var_626_20 + arg_626_0 and not isNil(var_626_19) and arg_623_1.var_.characterEffect1076ui_story == nil then
				arg_623_1.var_.characterEffect1076ui_story = var_626_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_21 = 0.2

			if var_626_20 <= arg_623_1.time_ and arg_623_1.time_ < var_626_20 + var_626_21 and not isNil(var_626_19) then
				local var_626_22 = (arg_623_1.time_ - var_626_20) / var_626_21

				if arg_623_1.var_.characterEffect1076ui_story and not isNil(var_626_19) then
					local var_626_23 = Mathf.Lerp(0, 0.5, var_626_22)

					arg_623_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1076ui_story.fillRatio = var_626_23
				end
			end

			if arg_623_1.time_ >= var_626_20 + var_626_21 and arg_623_1.time_ < var_626_20 + var_626_21 + arg_626_0 and not isNil(var_626_19) and arg_623_1.var_.characterEffect1076ui_story then
				local var_626_24 = 0.5

				arg_623_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1076ui_story.fillRatio = var_626_24
			end

			local var_626_25 = 0

			if var_626_25 < arg_623_1.time_ and arg_623_1.time_ <= var_626_25 + arg_626_0 then
				arg_623_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_626_26 = arg_623_1.actors_["1076ui_story"].transform
			local var_626_27 = 0

			if var_626_27 < arg_623_1.time_ and arg_623_1.time_ <= var_626_27 + arg_626_0 then
				arg_623_1.var_.moveOldPos1076ui_story = var_626_26.localPosition
			end

			local var_626_28 = 0.001

			if var_626_27 <= arg_623_1.time_ and arg_623_1.time_ < var_626_27 + var_626_28 then
				local var_626_29 = (arg_623_1.time_ - var_626_27) / var_626_28
				local var_626_30 = Vector3.New(0.7, -1.06, -6.2)

				var_626_26.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1076ui_story, var_626_30, var_626_29)

				local var_626_31 = manager.ui.mainCamera.transform.position - var_626_26.position

				var_626_26.forward = Vector3.New(var_626_31.x, var_626_31.y, var_626_31.z)

				local var_626_32 = var_626_26.localEulerAngles

				var_626_32.z = 0
				var_626_32.x = 0
				var_626_26.localEulerAngles = var_626_32
			end

			if arg_623_1.time_ >= var_626_27 + var_626_28 and arg_623_1.time_ < var_626_27 + var_626_28 + arg_626_0 then
				var_626_26.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_626_33 = manager.ui.mainCamera.transform.position - var_626_26.position

				var_626_26.forward = Vector3.New(var_626_33.x, var_626_33.y, var_626_33.z)

				local var_626_34 = var_626_26.localEulerAngles

				var_626_34.z = 0
				var_626_34.x = 0
				var_626_26.localEulerAngles = var_626_34
			end

			local var_626_35 = 0
			local var_626_36 = 0.225

			if var_626_35 < arg_623_1.time_ and arg_623_1.time_ <= var_626_35 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_37 = arg_623_1:FormatText(StoryNameCfg[410].name)

				arg_623_1.leftNameTxt_.text = var_626_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_38 = arg_623_1:GetWordFromCfg(120421151)
				local var_626_39 = arg_623_1:FormatText(var_626_38.content)

				arg_623_1.text_.text = var_626_39

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_40 = 9
				local var_626_41 = utf8.len(var_626_39)
				local var_626_42 = var_626_40 <= 0 and var_626_36 or var_626_36 * (var_626_41 / var_626_40)

				if var_626_42 > 0 and var_626_36 < var_626_42 then
					arg_623_1.talkMaxDuration = var_626_42

					if var_626_42 + var_626_35 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_42 + var_626_35
					end
				end

				arg_623_1.text_.text = var_626_39
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421151", "story_v_out_120421.awb") ~= 0 then
					local var_626_43 = manager.audio:GetVoiceLength("story_v_out_120421", "120421151", "story_v_out_120421.awb") / 1000

					if var_626_43 + var_626_35 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_43 + var_626_35
					end

					if var_626_38.prefab_name ~= "" and arg_623_1.actors_[var_626_38.prefab_name] ~= nil then
						local var_626_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_38.prefab_name].transform, "story_v_out_120421", "120421151", "story_v_out_120421.awb")

						arg_623_1:RecordAudio("120421151", var_626_44)
						arg_623_1:RecordAudio("120421151", var_626_44)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_120421", "120421151", "story_v_out_120421.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_120421", "120421151", "story_v_out_120421.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_45 = math.max(var_626_36, arg_623_1.talkMaxDuration)

			if var_626_35 <= arg_623_1.time_ and arg_623_1.time_ < var_626_35 + var_626_45 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_35) / var_626_45

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_35 + var_626_45 and arg_623_1.time_ < var_626_35 + var_626_45 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play120421152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 120421152
		arg_627_1.duration_ = 5.6

		local var_627_0 = {
			zh = 3.566,
			ja = 5.6
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play120421153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1074ui_story"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1074ui_story == nil then
				arg_627_1.var_.characterEffect1074ui_story = var_630_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.2

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.characterEffect1074ui_story and not isNil(var_630_0) then
					local var_630_4 = Mathf.Lerp(0, 0.5, var_630_3)

					arg_627_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1074ui_story.fillRatio = var_630_4
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1074ui_story then
				local var_630_5 = 0.5

				arg_627_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1074ui_story.fillRatio = var_630_5
			end

			local var_630_6 = arg_627_1.actors_["1076ui_story"]
			local var_630_7 = 0

			if var_630_7 < arg_627_1.time_ and arg_627_1.time_ <= var_630_7 + arg_630_0 and not isNil(var_630_6) and arg_627_1.var_.characterEffect1076ui_story == nil then
				arg_627_1.var_.characterEffect1076ui_story = var_630_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_8 = 0.2

			if var_630_7 <= arg_627_1.time_ and arg_627_1.time_ < var_630_7 + var_630_8 and not isNil(var_630_6) then
				local var_630_9 = (arg_627_1.time_ - var_630_7) / var_630_8

				if arg_627_1.var_.characterEffect1076ui_story and not isNil(var_630_6) then
					arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= var_630_7 + var_630_8 and arg_627_1.time_ < var_630_7 + var_630_8 + arg_630_0 and not isNil(var_630_6) and arg_627_1.var_.characterEffect1076ui_story then
				arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_630_10 = 0
			local var_630_11 = 0.35

			if var_630_10 < arg_627_1.time_ and arg_627_1.time_ <= var_630_10 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_12 = arg_627_1:FormatText(StoryNameCfg[389].name)

				arg_627_1.leftNameTxt_.text = var_630_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_13 = arg_627_1:GetWordFromCfg(120421152)
				local var_630_14 = arg_627_1:FormatText(var_630_13.content)

				arg_627_1.text_.text = var_630_14

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_15 = 14
				local var_630_16 = utf8.len(var_630_14)
				local var_630_17 = var_630_15 <= 0 and var_630_11 or var_630_11 * (var_630_16 / var_630_15)

				if var_630_17 > 0 and var_630_11 < var_630_17 then
					arg_627_1.talkMaxDuration = var_630_17

					if var_630_17 + var_630_10 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_17 + var_630_10
					end
				end

				arg_627_1.text_.text = var_630_14
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421152", "story_v_out_120421.awb") ~= 0 then
					local var_630_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421152", "story_v_out_120421.awb") / 1000

					if var_630_18 + var_630_10 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_18 + var_630_10
					end

					if var_630_13.prefab_name ~= "" and arg_627_1.actors_[var_630_13.prefab_name] ~= nil then
						local var_630_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_13.prefab_name].transform, "story_v_out_120421", "120421152", "story_v_out_120421.awb")

						arg_627_1:RecordAudio("120421152", var_630_19)
						arg_627_1:RecordAudio("120421152", var_630_19)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_120421", "120421152", "story_v_out_120421.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_120421", "120421152", "story_v_out_120421.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_20 = math.max(var_630_11, arg_627_1.talkMaxDuration)

			if var_630_10 <= arg_627_1.time_ and arg_627_1.time_ < var_630_10 + var_630_20 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_10) / var_630_20

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_10 + var_630_20 and arg_627_1.time_ < var_630_10 + var_630_20 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play120421153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 120421153
		arg_631_1.duration_ = 7.3

		local var_631_0 = {
			zh = 6.033,
			ja = 7.3
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play120421154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1074ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1074ui_story == nil then
				arg_631_1.var_.characterEffect1074ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.2

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1074ui_story and not isNil(var_634_0) then
					arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1074ui_story then
				arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_634_4 = arg_631_1.actors_["1076ui_story"]
			local var_634_5 = 0

			if var_634_5 < arg_631_1.time_ and arg_631_1.time_ <= var_634_5 + arg_634_0 and not isNil(var_634_4) and arg_631_1.var_.characterEffect1076ui_story == nil then
				arg_631_1.var_.characterEffect1076ui_story = var_634_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_6 = 0.2

			if var_634_5 <= arg_631_1.time_ and arg_631_1.time_ < var_634_5 + var_634_6 and not isNil(var_634_4) then
				local var_634_7 = (arg_631_1.time_ - var_634_5) / var_634_6

				if arg_631_1.var_.characterEffect1076ui_story and not isNil(var_634_4) then
					local var_634_8 = Mathf.Lerp(0, 0.5, var_634_7)

					arg_631_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1076ui_story.fillRatio = var_634_8
				end
			end

			if arg_631_1.time_ >= var_634_5 + var_634_6 and arg_631_1.time_ < var_634_5 + var_634_6 + arg_634_0 and not isNil(var_634_4) and arg_631_1.var_.characterEffect1076ui_story then
				local var_634_9 = 0.5

				arg_631_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1076ui_story.fillRatio = var_634_9
			end

			local var_634_10 = 0
			local var_634_11 = 0.65

			if var_634_10 < arg_631_1.time_ and arg_631_1.time_ <= var_634_10 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_12 = arg_631_1:FormatText(StoryNameCfg[410].name)

				arg_631_1.leftNameTxt_.text = var_634_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_13 = arg_631_1:GetWordFromCfg(120421153)
				local var_634_14 = arg_631_1:FormatText(var_634_13.content)

				arg_631_1.text_.text = var_634_14

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_15 = 26
				local var_634_16 = utf8.len(var_634_14)
				local var_634_17 = var_634_15 <= 0 and var_634_11 or var_634_11 * (var_634_16 / var_634_15)

				if var_634_17 > 0 and var_634_11 < var_634_17 then
					arg_631_1.talkMaxDuration = var_634_17

					if var_634_17 + var_634_10 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_17 + var_634_10
					end
				end

				arg_631_1.text_.text = var_634_14
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421153", "story_v_out_120421.awb") ~= 0 then
					local var_634_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421153", "story_v_out_120421.awb") / 1000

					if var_634_18 + var_634_10 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_18 + var_634_10
					end

					if var_634_13.prefab_name ~= "" and arg_631_1.actors_[var_634_13.prefab_name] ~= nil then
						local var_634_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_13.prefab_name].transform, "story_v_out_120421", "120421153", "story_v_out_120421.awb")

						arg_631_1:RecordAudio("120421153", var_634_19)
						arg_631_1:RecordAudio("120421153", var_634_19)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_120421", "120421153", "story_v_out_120421.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_120421", "120421153", "story_v_out_120421.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_20 = math.max(var_634_11, arg_631_1.talkMaxDuration)

			if var_634_10 <= arg_631_1.time_ and arg_631_1.time_ < var_634_10 + var_634_20 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_10) / var_634_20

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_10 + var_634_20 and arg_631_1.time_ < var_634_10 + var_634_20 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play120421154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 120421154
		arg_635_1.duration_ = 6.9

		local var_635_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play120421155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 0.575

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_2 = arg_635_1:FormatText(StoryNameCfg[410].name)

				arg_635_1.leftNameTxt_.text = var_638_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_3 = arg_635_1:GetWordFromCfg(120421154)
				local var_638_4 = arg_635_1:FormatText(var_638_3.content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 23
				local var_638_6 = utf8.len(var_638_4)
				local var_638_7 = var_638_5 <= 0 and var_638_1 or var_638_1 * (var_638_6 / var_638_5)

				if var_638_7 > 0 and var_638_1 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421154", "story_v_out_120421.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421154", "story_v_out_120421.awb") / 1000

					if var_638_8 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_0
					end

					if var_638_3.prefab_name ~= "" and arg_635_1.actors_[var_638_3.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_3.prefab_name].transform, "story_v_out_120421", "120421154", "story_v_out_120421.awb")

						arg_635_1:RecordAudio("120421154", var_638_9)
						arg_635_1:RecordAudio("120421154", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_120421", "120421154", "story_v_out_120421.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_120421", "120421154", "story_v_out_120421.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_10 and arg_635_1.time_ < var_638_0 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play120421155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 120421155
		arg_639_1.duration_ = 3.93

		local var_639_0 = {
			zh = 2.933,
			ja = 3.933
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play120421156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["1074ui_story"]
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect1074ui_story == nil then
				arg_639_1.var_.characterEffect1074ui_story = var_642_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.2

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 and not isNil(var_642_0) then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2

				if arg_639_1.var_.characterEffect1074ui_story and not isNil(var_642_0) then
					local var_642_4 = Mathf.Lerp(0, 0.5, var_642_3)

					arg_639_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1074ui_story.fillRatio = var_642_4
				end
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 and not isNil(var_642_0) and arg_639_1.var_.characterEffect1074ui_story then
				local var_642_5 = 0.5

				arg_639_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1074ui_story.fillRatio = var_642_5
			end

			local var_642_6 = 0
			local var_642_7 = 0.3

			if var_642_6 < arg_639_1.time_ and arg_639_1.time_ <= var_642_6 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_8 = arg_639_1:FormatText(StoryNameCfg[379].name)

				arg_639_1.leftNameTxt_.text = var_642_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_9 = arg_639_1:GetWordFromCfg(120421155)
				local var_642_10 = arg_639_1:FormatText(var_642_9.content)

				arg_639_1.text_.text = var_642_10

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421155", "story_v_out_120421.awb") ~= 0 then
					local var_642_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421155", "story_v_out_120421.awb") / 1000

					if var_642_14 + var_642_6 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_14 + var_642_6
					end

					if var_642_9.prefab_name ~= "" and arg_639_1.actors_[var_642_9.prefab_name] ~= nil then
						local var_642_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_9.prefab_name].transform, "story_v_out_120421", "120421155", "story_v_out_120421.awb")

						arg_639_1:RecordAudio("120421155", var_642_15)
						arg_639_1:RecordAudio("120421155", var_642_15)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_120421", "120421155", "story_v_out_120421.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_120421", "120421155", "story_v_out_120421.awb")
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
	Play120421156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 120421156
		arg_643_1.duration_ = 8.1

		local var_643_0 = {
			zh = 4.433,
			ja = 8.1
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play120421157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1076ui_story"]
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect1076ui_story == nil then
				arg_643_1.var_.characterEffect1076ui_story = var_646_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.2

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 and not isNil(var_646_0) then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2

				if arg_643_1.var_.characterEffect1076ui_story and not isNil(var_646_0) then
					arg_643_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect1076ui_story then
				arg_643_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_646_4 = 0
			local var_646_5 = 0.35

			if var_646_4 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_6 = arg_643_1:FormatText(StoryNameCfg[389].name)

				arg_643_1.leftNameTxt_.text = var_646_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_7 = arg_643_1:GetWordFromCfg(120421156)
				local var_646_8 = arg_643_1:FormatText(var_646_7.content)

				arg_643_1.text_.text = var_646_8

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 14
				local var_646_10 = utf8.len(var_646_8)
				local var_646_11 = var_646_9 <= 0 and var_646_5 or var_646_5 * (var_646_10 / var_646_9)

				if var_646_11 > 0 and var_646_5 < var_646_11 then
					arg_643_1.talkMaxDuration = var_646_11

					if var_646_11 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_11 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_8
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421156", "story_v_out_120421.awb") ~= 0 then
					local var_646_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421156", "story_v_out_120421.awb") / 1000

					if var_646_12 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_12 + var_646_4
					end

					if var_646_7.prefab_name ~= "" and arg_643_1.actors_[var_646_7.prefab_name] ~= nil then
						local var_646_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_7.prefab_name].transform, "story_v_out_120421", "120421156", "story_v_out_120421.awb")

						arg_643_1:RecordAudio("120421156", var_646_13)
						arg_643_1:RecordAudio("120421156", var_646_13)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_120421", "120421156", "story_v_out_120421.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_120421", "120421156", "story_v_out_120421.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_14 = math.max(var_646_5, arg_643_1.talkMaxDuration)

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_14 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_4) / var_646_14

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_4 + var_646_14 and arg_643_1.time_ < var_646_4 + var_646_14 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play120421157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 120421157
		arg_647_1.duration_ = 10.73

		local var_647_0 = {
			zh = 6.233,
			ja = 10.733
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
			arg_647_1.auto_ = false
		end

		function arg_647_1.playNext_(arg_649_0)
			arg_647_1.onStoryFinished_()
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 0.7

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_2 = arg_647_1:FormatText(StoryNameCfg[389].name)

				arg_647_1.leftNameTxt_.text = var_650_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_3 = arg_647_1:GetWordFromCfg(120421157)
				local var_650_4 = arg_647_1:FormatText(var_650_3.content)

				arg_647_1.text_.text = var_650_4

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421157", "story_v_out_120421.awb") ~= 0 then
					local var_650_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421157", "story_v_out_120421.awb") / 1000

					if var_650_8 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_8 + var_650_0
					end

					if var_650_3.prefab_name ~= "" and arg_647_1.actors_[var_650_3.prefab_name] ~= nil then
						local var_650_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_3.prefab_name].transform, "story_v_out_120421", "120421157", "story_v_out_120421.awb")

						arg_647_1:RecordAudio("120421157", var_650_9)
						arg_647_1:RecordAudio("120421157", var_650_9)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_120421", "120421157", "story_v_out_120421.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_120421", "120421157", "story_v_out_120421.awb")
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
	assets = {
		"TextureConfig/Background/XH0204",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST31"
	},
	voices = {
		"story_v_out_120421.awb"
	}
}
